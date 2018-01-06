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
package org.b3log.solo.event.openfire;

import org.b3log.latke.Keys;
import org.b3log.latke.Latkes;
import org.b3log.latke.event.AbstractEventListener;
import org.b3log.latke.event.Event;
import org.b3log.latke.event.EventException;
import org.b3log.latke.ioc.LatkeBeanManager;
import org.b3log.latke.ioc.Lifecycle;
import org.b3log.latke.logging.Level;
import org.b3log.latke.logging.Logger;
import org.b3log.latke.util.Strings;
import org.b3log.solo.SoloServletListener;
import org.b3log.solo.event.EventTypes;
import org.b3log.solo.model.Article;
import org.b3log.solo.model.Common;
import org.b3log.solo.model.Option;
import org.b3log.solo.service.PreferenceQueryService;
import org.json.JSONObject;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;

import org.b3log.solo.processor.WebPush;

/**
 * This listener is responsible for sending web push notifications on new blogs.
 *
 */
public final class BlogPosted extends AbstractEventListener<JSONObject> {

    private static final Logger LOGGER = Logger.getLogger(BlogPosted.class);

    @Override
    public void action(final Event<JSONObject> event) throws EventException {
        final JSONObject data = event.getData();

        LOGGER.log(Level.DEBUG, "Processing an event[type={0}, data={1}] in listener[className={2}]",
                event.getType(), data, BlogPosted.class.getName());
        try {
            final JSONObject originalArticle = data.getJSONObject(Article.ARTICLE);

            if (!originalArticle.getBoolean(Article.ARTICLE_IS_PUBLISHED)) {
                LOGGER.log(Level.DEBUG, "Ignores post article[title={0}] to web push", originalArticle.getString(Article.ARTICLE_TITLE));

                return;
            }

            final LatkeBeanManager beanManager = Lifecycle.getBeanManager();
            final PreferenceQueryService preferenceQueryService = beanManager.getReference(PreferenceQueryService.class);

            final JSONObject preference = preferenceQueryService.getPreference();
            if (null == preference) {
                throw new EventException("Not found preference");
            }

            if (!Strings.isEmptyOrNull(originalArticle.optString(Article.ARTICLE_VIEW_PWD))) {
                return;
            }

            if (Latkes.getServePath().contains("localhost")) {
                LOGGER.log(Level.TRACE, "Solo runs on local server, so should not push this article[id={0}, title={1}] to browser",
                        originalArticle.getString(Keys.OBJECT_ID), originalArticle.getString(Article.ARTICLE_TITLE));
                return;
            }

            final JSONObject requestJSONObject = new JSONObject();
            final JSONObject article = new JSONObject();

            article.put(Keys.OBJECT_ID, originalArticle.getString(Keys.OBJECT_ID));
            article.put(Article.ARTICLE_TITLE, originalArticle.getString(Article.ARTICLE_TITLE));
            article.put(Article.ARTICLE_PERMALINK, originalArticle.getString(Article.ARTICLE_PERMALINK));
            article.put(Article.ARTICLE_TAGS_REF, originalArticle.getString(Article.ARTICLE_TAGS_REF));
            article.put(Article.ARTICLE_AUTHOR_EMAIL, originalArticle.getString(Article.ARTICLE_AUTHOR_EMAIL));
            article.put(Article.ARTICLE_CONTENT, originalArticle.getString(Article.ARTICLE_CONTENT));
            article.put(Article.ARTICLE_CREATE_DATE, ((Date) originalArticle.get(Article.ARTICLE_CREATE_DATE)).getTime());
            article.put(Common.POST_TO_COMMUNITY, originalArticle.getBoolean(Common.POST_TO_COMMUNITY));

            // Removes this property avoid to persist
            originalArticle.remove(Common.POST_TO_COMMUNITY);

            requestJSONObject.put(Article.ARTICLE, article);
            requestJSONObject.put(Common.BLOG_VERSION, SoloServletListener.VERSION);
            requestJSONObject.put(Common.BLOG, "Solo");
            requestJSONObject.put(Option.ID_C_BLOG_TITLE, preference.getString(Option.ID_C_BLOG_TITLE));
            requestJSONObject.put("blogHost", Latkes.getServePath());
            requestJSONObject.put("userB3Key", preference.optString(Option.ID_C_KEY_OF_SOLO));
            requestJSONObject.put("clientAdminEmail", preference.optString(Option.ID_C_ADMIN_EMAIL));
            requestJSONObject.put("clientRuntimeEnv", "LOCAL");

            // do web push
            final JSONObject pushJson = new JSONObject();
            pushJson.put("title", originalArticle.getString(Article.ARTICLE_AUTHOR_EMAIL));
            pushJson.put("message", originalArticle.getString(Article.ARTICLE_TITLE));
            pushJson.put("url", Latkes.getServePath() + originalArticle.getString(Article.ARTICLE_PERMALINK));
            WebPush.push(pushJson.toString());

        } catch (final Exception e) {
            LOGGER.log(Level.ERROR, "Sends an article to web browser error: {0}", e.getMessage());
        }

        LOGGER.log(Level.DEBUG, "Sent an article to browser");
    }

    @Override
    public String getEventType() {
        return EventTypes.ADD_ARTICLE;
    }
}
