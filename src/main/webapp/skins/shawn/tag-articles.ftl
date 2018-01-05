<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${tag.tagTitle} - ${blogTitle}">
        <meta name="keywords" content="${metaKeywords},${tag.tagTitle}"/>
        <meta name="description" content="<#list articles as article>${article.articleTitle}<#if article_has_next>,</#if></#list>"/>
        </@head>
    </head>
    <body>
        ${topBarReplacement}
        <div id="loading" style="display: none; "></div>
        <div id="page">
            <#include "header.ftl">
            <div id="content">
                <h2 class="pagetitle">
                    <a href="${staticServePath}/tag-articles-feed.do?oId=${tag.oId}" class="feed-ico">
                        ${tag1Label}
                        ${tag.tagTitle}
                        (${tag.tagPublishedRefCount})
                    </a>
                </h2>
                <#include "article-list.ftl">
            </div>
            <#include "side.ftl">
            <#include "footer.ftl">
        </div>
    </body>
</html>
