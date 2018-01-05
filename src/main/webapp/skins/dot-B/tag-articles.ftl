<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${tag.tagTitle} - ${blogTitle}">
        <meta name="keywords" content="${metaKeywords},${tag.tagTitle}"/>
        <meta name="description" content="<#list articles as article>${article.articleTitle}<#if article_has_next>,</#if></#list>"/>
        </@head>
    </head>
    <body id="body">
        ${topBarReplacement}
        <div id="top_bar"></div>
            <div id="wrapper">
                <#include "header.ftl">
                <div id="main">
                    <div id="content">
                        <div class="post">
                            <h2 class="post_title_h2">
                                <a href="${staticServePath}/tag-articles-feed.do?oId=${tag.oId}" class="feed-ico">
                                    ${tag1Label}
                                    ${tag.tagTitle}
                                    (${tag.tagPublishedRefCount})
                                </a>
                            </h2>
                            <div class="clear"></div>
                            <div class="post_content">
                                <#include "article-list.ftl">
                            </div>
                            <div class="menu-mark"></div>
                        </div>
                    </div>
                    <div id="sidebar" class="widget-area">
                        <#include "side.ftl">
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
                <#include "footer.ftl">
            </div>
            <div class="clear"></div>
            <div id="bottom-bar"></div>
    </body>
</html>