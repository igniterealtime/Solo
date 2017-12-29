/*
 * Copyright (c) 2010-2017, b3log.org & hacpai.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.b3log.solo.repository.impl;

import java.util.*;

import org.b3log.latke.Keys;
import org.b3log.latke.ioc.inject.Inject;
import org.b3log.latke.model.Role;
import org.b3log.latke.model.User;
import org.b3log.latke.model.Pagination;
import org.b3log.latke.repository.*;
import org.b3log.latke.repository.jdbc.*;
import org.b3log.latke.repository.jdbc.util.JdbcRepositories;
import org.b3log.latke.repository.annotation.Repository;
import org.b3log.solo.cache.UserCache;
import org.b3log.solo.repository.UserRepository;
import org.b3log.solo.model.UserExt;
import org.json.JSONArray;
import org.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.jivesoftware.util.JiveGlobals;
import org.jivesoftware.openfire.XMPPServer;
import org.jivesoftware.openfire.group.Group;
import org.jivesoftware.openfire.group.GroupManager;
import org.jivesoftware.openfire.group.GroupNotFoundException;
import org.jivesoftware.openfire.user.UserManager;
import org.jivesoftware.openfire.user.UserNotFoundException;
import org.jivesoftware.openfire.vcard.VCardManager;

import org.xmpp.packet.JID;
import org.dom4j.Element;

/**
 * User repository for openfire.
 *
 */
@Repository
public class UserRepositoryImpl extends AbstractRepository implements UserRepository
{
    private static final Logger Log = LoggerFactory.getLogger( UserRepositoryImpl.class );

    public UserRepositoryImpl()
    {
        super(User.USER);
    }

    @Override
    public String add(final JSONObject jsonObject)
    {
        Log.debug("add\n" + jsonObject);
        org.jivesoftware.openfire.user.User user = getAndCheckUser(jsonObject);
        return user != null ? user.getUsername() : null;
    }

    @Override
    public void remove(final String id)
    {
        Log.debug("remove " + id);

        try {
            super.remove(id);
            org.jivesoftware.openfire.user.User user = XMPPServer.getInstance().getUserManager().getUser(id);
            if (user != null) XMPPServer.getInstance().getUserManager().deleteUser(user);
        } catch (Exception e) {
            Log.error("remove", e);
        }
    }

    @Override
    public JSONObject get(final String id)
    {
        try {
            org.jivesoftware.openfire.user.User user = XMPPServer.getInstance().getUserManager().getUser(id);
            return getUser(user);
        } catch (Exception e) {
            Log.error("remove", e);
            return new JSONObject();
        }
    }

    @Override
    public Map<String, JSONObject> get(final Iterable<String> ids)
    {
        final Map<String, JSONObject> map = new HashMap<>();
        JSONObject jsonObject;

        for (final String id : ids) {
            jsonObject = get(id);
            map.put(jsonObject.optString(JdbcRepositories.getDefaultKeyName()), jsonObject);
        }

        return map;
    }

    @Override
    public JSONObject get(final Query query)
    {
        final JSONObject ret = new JSONObject();

        try {
            final Group group = getAndCheckGroup();
            final int recordCount = group.getAll().size();

            // page
            final JSONObject pagination = new JSONObject();
            pagination.put(Pagination.PAGINATION_PAGE_COUNT, 1);
            pagination.put(Pagination.PAGINATION_RECORD_COUNT, recordCount);
            ret.put(Pagination.PAGINATION, pagination);

            // result
            if (0 == recordCount) {
                ret.put(Keys.RESULTS, new JSONArray());
                return ret;
            }

            final JSONArray jsonResults = new JSONArray();
            int i = 0;

            for (JID jid : group.getAll())
            {
                jsonResults.put(i, get(jid.getNode()));
                i++;
            }
            ret.put(Keys.RESULTS, jsonResults);

            Log.debug("get query results \n" + ret);

        } catch (final Exception e) {
            Log.error("query: " + e.getMessage(), e);
        }

        return ret;
    }

    @Override
    public void update(final String id, final JSONObject jsonObject)
    {
        try {
            org.jivesoftware.openfire.user.User user = XMPPServer.getInstance().getUserManager().getUser(id);

            if (user != null)
            {
                updateUser(user, jsonObject);
            }
        } catch (Exception e) {
            Log.error("update", e);
        }
    }

    @Override
    public boolean has(final String id)
    {
        try {
            return XMPPServer.getInstance().getUserManager().getUser(id) != null;
        } catch (Exception e) {
            Log.error("has", e);
            return false;
        }
    }


    @Override
    public List<JSONObject> getRandomly(final int fetchSize)
    {
        Log.debug("getRandomly " + fetchSize);
        return new ArrayList<JSONObject>();
    }

    @Override
    public long count()
    {
        Group group = getAndCheckGroup();
        return group.getAll().size();
    }

    @Override
    public long count(final Query query)
    {
        return count();
    }

    @Override
    public List<JSONObject> select(final String statement, final Object... params)
    {
        Log.debug("select " + statement);

        try {
            return Collections.emptyList();
        } catch (final Exception e) {
            Log.error("select error", e);
            return Collections.emptyList();
        }
    }


    @Override
    public JSONObject getByEmail(final String email)
    {
        try {
            Collection<org.jivesoftware.openfire.user.User> users = XMPPServer.getInstance().getUserManager().findUsers(new HashSet<String>(Arrays.asList("Email")), email);

            if (users.size() == 0)
            {
                return null;
            }

            org.jivesoftware.openfire.user.User user = users.iterator().next();
            JSONObject json = getUser(user);

            Group group = getAndCheckGroup();
            boolean member = false;

            for (JID jid : group.getAll())
            {
                if (jid.getNode().equals(json.getString(User.USER_NAME)))
                {
                   return json;
                }
            }
            return null;

        } catch (Exception e) {
            Log.error("remove", e);
            return new JSONObject();
        }
    }

    @Override
    public JSONObject getAdmin()
    {
        Group group = getAndCheckGroup();
        Collection<JID> admins = group.getAdmins();

        if (admins.size() == 0)
        {
            return null;
        }

        JID jid = admins.iterator().next();
        return get(jid.getNode());
    }

    @Override
    public boolean isAdminEmail(final String email)
    {
        final JSONObject user = getByEmail(email);
        if (null == user) {
            return false;
        }

        return Role.ADMIN_ROLE.equals(user.optString(User.USER_ROLE));
    }

    private Group getAndCheckGroup()
    {
        String groupName = JiveGlobals.getProperty("solo.blog.name", "solo");
        Group group = null;

        try {
            group = GroupManager.getInstance().getGroup(groupName);
        } catch (GroupNotFoundException e) {

            try {
                group = GroupManager.getInstance().createGroup(groupName);
                group.setDescription("Access Control group for Solo Blogger");

                group.getProperties().put("sharedRoster.showInRoster", "onlyGroup");
                group.getProperties().put("sharedRoster.displayName", "Solo Blogger");
                group.getProperties().put("sharedRoster.groupList", "");

            } catch (Exception e1) {
                Log.error("getAndCheckGroup", e1);
            }
        }
        return group;
    }

    private org.jivesoftware.openfire.user.User getAndCheckUser(JSONObject jsonObject)
    {
        org.jivesoftware.openfire.user.User user = null;

        try {
            user = XMPPServer.getInstance().getUserManager().getUser(jsonObject.getString(User.USER_NAME));

        } catch (UserNotFoundException e) {

            try {
                user = XMPPServer.getInstance().getUserManager().createUser(jsonObject.getString(User.USER_NAME), jsonObject.getString(User.USER_PASSWORD), jsonObject.getString(User.USER_NAME), jsonObject.getString(User.USER_EMAIL));
            } catch (Exception e1) {
                Log.error("getAndCheckUser", e1);
            }
        } catch (Exception e2) {
            Log.error("getAndCheckUser", e2);
        }

        updateUser(user, jsonObject);

        return user;
    }

    private JSONObject getUser(org.jivesoftware.openfire.user.User user)
    {
        final JSONObject requestJSONObject = new JSONObject();

        if (user != null)
        {
            Group group = getAndCheckGroup();

            String url = user.getProperties().get(User.USER_URL);
            String articleCount = user.getProperties().get(UserExt.USER_ARTICLE_COUNT);
            String pubArticleCount = user.getProperties().get(UserExt.USER_PUBLISHED_ARTICLE_COUNT);
            String avatar = user.getProperties().get(UserExt.USER_AVATAR);

            String role = user.getProperties().get(User.USER_ROLE);

            if (role == null)
            {
                Collection<JID> admins = group.getAdmins();
                role = Role.DEFAULT_ROLE;

                for (JID jid : admins)
                {
                    if (jid.getNode().equals(user.getUsername())) role = Role.ADMIN_ROLE;
                }
            }

            if (avatar == null)
            {
                avatar = "";

                Element vcard = VCardManager.getInstance().getVCard(user.getUsername());

                if (vcard != null)
                {
                    Element photo = vcard.element("PHOTO");

                    if (photo != null)
                    {
                        String type = photo.element("TYPE").getText();
                        String binval = photo.element("BINVAL").getText();

                        avatar = "data:" + type + ";base64," + binval.replace("\n", "").replace("\r", "");
                    }
                }
            }

            requestJSONObject.put(User.USER_EMAIL, user.getEmail());
            requestJSONObject.put("oId", user.getUsername());
            requestJSONObject.put(User.USER_NAME, user.getUsername());
            requestJSONObject.put(User.USER_PASSWORD, user.getUsername());

            requestJSONObject.put(User.USER_ROLE, role);
            requestJSONObject.put(UserExt.USER_AVATAR, avatar);

            requestJSONObject.put(User.USER_URL, url != null ? url : getDefaultUrl());
            requestJSONObject.put(UserExt.USER_ARTICLE_COUNT, articleCount != null ? articleCount : "0");
            requestJSONObject.put(UserExt.USER_PUBLISHED_ARTICLE_COUNT, pubArticleCount != null ? pubArticleCount : "0");
        }

        return requestJSONObject;
    }

    private void updateUser(org.jivesoftware.openfire.user.User user, JSONObject jsonObject)
    {
        try {
            try {
                user.setEmail(jsonObject.getString(User.USER_EMAIL));

                if (jsonObject.has(User.USER_PASSWORD))
                {
                    String pwd = jsonObject.getString(User.USER_PASSWORD);
                    if (pwd != "" && !pwd.equals(user.getUsername())) user.setPassword(pwd);
                }
            } catch (Exception e) {
                Log.warn("cannot update user");
            }

            user.getProperties().put(User.USER_URL, jsonObject.getString(User.USER_URL));
            user.getProperties().put(User.USER_ROLE, jsonObject.getString(User.USER_ROLE));
            user.getProperties().put(UserExt.USER_ARTICLE_COUNT, jsonObject.getString(UserExt.USER_ARTICLE_COUNT));
            user.getProperties().put(UserExt.USER_PUBLISHED_ARTICLE_COUNT, jsonObject.getString(UserExt.USER_PUBLISHED_ARTICLE_COUNT));
            user.getProperties().put(UserExt.USER_AVATAR, jsonObject.getString(UserExt.USER_AVATAR));

            final String userRole = jsonObject.getString(User.USER_ROLE);
            boolean isAdmin = false;

            if (Role.ADMIN_ROLE.equals(userRole))
            {
                isAdmin = true;
            }

            Group group = getAndCheckGroup();
            Collection<JID> users = (isAdmin ? group.getAdmins() : group.getMembers());

            try {
                users.add(XMPPServer.getInstance().createJID(user.getUsername(), null));
            } catch (Exception e) {}

        } catch (Exception e1) {
            Log.error("updateUser", e1);
        }
    }

    private String getDefaultUrl()
    {
        String serverScheme = "http";
        String serverHost = JiveGlobals.getProperty("xmpp.fqdn", XMPPServer.getInstance().getServerInfo().getHostname());
        String serverPort = JiveGlobals.getProperty("solo.port.plain", JiveGlobals.getProperty("httpbind.port.plain", "7070"));
        String soloName = JiveGlobals.getProperty("solo.blog.name", "solo");

        boolean secureBlog = JiveGlobals.getBooleanProperty("solo.blog.secure", true);

        if (secureBlog)
        {
            serverScheme = "https";
            serverPort = JiveGlobals.getProperty("solo.port.secure", JiveGlobals.getProperty("httpbind.port.secure", "7443"));
        }
        return serverScheme + "://" + serverHost + ":" + serverPort + "/" + soloName;
    }
}
