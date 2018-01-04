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
package org.b3log.solo.processor;

import org.b3log.latke.logging.Level;
import org.b3log.latke.logging.Logger;
import org.b3log.latke.service.ServiceException;
import org.b3log.latke.servlet.HTTPRequestContext;
import org.b3log.latke.servlet.HTTPRequestMethod;
import org.b3log.latke.servlet.annotation.RequestProcessing;
import org.b3log.latke.servlet.annotation.RequestProcessor;
import org.b3log.latke.servlet.renderer.JSONRenderer;
import org.b3log.latke.util.Requests;

import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.*;
import org.jivesoftware.util.*;
import org.jivesoftware.openfire.*;
import org.jivesoftware.openfire.group.*;

/**
 * WebPush processor.
 *
 */
@RequestProcessor
public class WebPush {

    private static final Logger LOGGER = Logger.getLogger(WebPush.class);

    @RequestProcessing(value = "/webpush/subscribe", method = HTTPRequestMethod.POST)
    public void subscribe(final HTTPRequestContext context, final HttpServletRequest request, final HttpServletResponse response)  throws Exception
    {
        final JSONRenderer renderer = new JSONRenderer();
        context.setRenderer(renderer);
        final JSONObject ret = new JSONObject();
        renderer.setJSONObject(ret);

        try {
            final JSONObject requestJSONObject = Requests.parseRequestJSONObject(request, response);
            LOGGER.info("/webpush/subscribe\n" + requestJSONObject);

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
                    LOGGER.log(Level.WARN, e1.getMessage(), e1);
                    ret.put("error", e1.getMessage());
                    return;
                }
            }

            group.getProperties().put(requestJSONObject.getString("auth"), requestJSONObject.toString());
            ret.put("response", "ok");

        } catch (final Exception e) {
            LOGGER.log(Level.WARN, e.getMessage(), e);
            ret.put("error", e.getMessage());
        }
    }

    @RequestProcessing(value = "/webpush/publickey", method = HTTPRequestMethod.GET)
    public void search(final HTTPRequestContext context)
    {
        final JSONRenderer renderer = new JSONRenderer();
        context.setRenderer(renderer);
        final JSONObject ret = new JSONObject();
        renderer.setJSONObject(ret);

        try {
            ret.put("publicKey", JiveGlobals.getProperty("vapid.public.key", null));

        } catch (final Exception e) {
            LOGGER.log(Level.WARN, e.getMessage(), e);
            ret.put("error", e.getMessage());
        }
    }
}
