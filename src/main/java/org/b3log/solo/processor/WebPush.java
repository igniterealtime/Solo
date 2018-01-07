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
import java.util.concurrent.*;
import java.io.*;
import java.security.*;

import org.jivesoftware.util.*;
import org.jivesoftware.openfire.*;
import org.jivesoftware.openfire.group.*;

import com.google.common.io.BaseEncoding;
import com.google.gson.Gson;
import org.apache.http.HttpResponse;
import nl.martijndwars.webpush.*;

import org.bouncycastle.jce.ECNamedCurveTable;
import org.bouncycastle.jce.interfaces.ECPrivateKey;
import org.bouncycastle.jce.interfaces.ECPublicKey;
import org.bouncycastle.jce.spec.ECNamedCurveParameterSpec;

import org.xmpp.packet.*;

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

            group.getProperties().put("webpush.subscribe." + requestJSONObject.getJSONObject("keys").getString("auth"), requestJSONObject.toString());
            ret.put("response", "ok");

        } catch (final Exception e) {
            LOGGER.log(Level.WARN, e.getMessage(), e);
            ret.put("error", e.getMessage());
        }
    }

    @RequestProcessing(value = "/webpush/publickey", method = HTTPRequestMethod.GET)
    public void publicKey(final HTTPRequestContext context)
    {
        final JSONRenderer renderer = new JSONRenderer();
        context.setRenderer(renderer);
        final JSONObject ret = new JSONObject();
        renderer.setJSONObject(ret);

        try {
            String ofPublicKey = JiveGlobals.getProperty("vapid.public.key", null);
            String ofPrivateKey = JiveGlobals.getProperty("vapid.private.key", null);

            if (ofPublicKey == null || ofPrivateKey == null)
            {
                KeyPair keyPair = generateKeyPair();

                byte[] publicKey = Utils.savePublicKey((ECPublicKey) keyPair.getPublic());
                byte[] privateKey = Utils.savePrivateKey((ECPrivateKey) keyPair.getPrivate());

                ofPublicKey = BaseEncoding.base64Url().encode(publicKey);
                ofPrivateKey = BaseEncoding.base64Url().encode(privateKey);

                JiveGlobals.setProperty("vapid.public.key", ofPublicKey);
                JiveGlobals.setProperty("vapid.private.key", ofPrivateKey);
            }

            ret.put("publicKey", ofPublicKey);

        } catch (final Exception e) {
            LOGGER.log(Level.WARN, e.getMessage(), e);
            ret.put("error", e.getMessage());
        }
    }

    public static boolean push(String payload)
    {
        LOGGER.info("push \n" + payload);

        boolean ok = false;

        // first push to online reciepients

        String domain = XMPPServer.getInstance().getServerInfo().getXMPPDomain();

        Message message = new Message();
        message.setFrom(domain);
        message.addChildElement("solo", "http://igniterealtime.org/solo").setText(payload);

        XMPPServer.getInstance().getSessionManager().broadcast(message);

        // next push to offline reciepients

        String publicKey = JiveGlobals.getProperty("vapid.public.key", null);
        String privateKey = JiveGlobals.getProperty("vapid.private.key", null);

        String groupName = JiveGlobals.getProperty("solo.blog.name", "solo");

        try {
            Group group = GroupManager.getInstance().getGroup(groupName);

            if (group != null && publicKey != null && privateKey != null)
            {
                PushService pushService = new PushService()
                    .setPublicKey(publicKey)
                    .setPrivateKey(privateKey)
                    .setSubject("mailto:admin@" + domain);

                Log.debug("postWebPush keys \n"  + publicKey + "\n" + privateKey);

                for (String key : group.getProperties().keySet())
                {
                    if (key.startsWith("webpush.subscribe."))
                    {
                        try {
                            Subscription subscription = new Gson().fromJson(group.getProperties().get(key), Subscription.class);
                            Notification notification = new Notification(subscription, payload);
                            HttpResponse response = pushService.send(notification);
                            int statusCode = response.getStatusLine().getStatusCode();

                            ok =  ok && (200 == statusCode) || (201 == statusCode);

                            LOGGER.info("postWebPush delivered "  + statusCode + "\n" + response);

                        } catch (Exception e) {
                            LOGGER.log(Level.WARN, "postWebPush failed "  + "\n" + payload, e);
                        }
                    }
                }

            }
        } catch (Exception e1) {
            LOGGER.log(Level.WARN, "postWebPush failed "  + "\n" + payload, e1);
        }

        return ok;
    }


    private KeyPair generateKeyPair() throws InvalidAlgorithmParameterException, NoSuchProviderException, NoSuchAlgorithmException {
        ECNamedCurveParameterSpec parameterSpec = ECNamedCurveTable.getParameterSpec("prime256v1");

        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("ECDH", "BC");
        keyPairGenerator.initialize(parameterSpec);

        return keyPairGenerator.generateKeyPair();
    }
}
