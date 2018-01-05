<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${tag.tagTitle} - ${blogTitle}">
        <meta name="keywords" content="${metaKeywords},${tag.tagTitle}"/>
        <meta name="description" content="<#list articles as article>${article.articleTitle}<#if article_has_next>,</#if></#list>"/>
        </@head>
    </head>
    <body class="home page top-navbar">
        <#include "header.ftl">
        <div id="wrap" class="container" role="document">
            <div id="content" class="row">
                <div id="main" class="span8" role="main">
                    <h4>
                        <a rel="alternate" href="${servePath}/tag-articles-feed.do?oId=${tag.oId}">
                        ${tag1Label}
                        ${tag.tagTitle}
                            (${tag.tagPublishedRefCount})
                        </a>
                    </h4>
                    <#include "article-list.ftl">
                </div>
                <aside id="sidebar" class="span4">
                <#include "side.ftl">
                </aside>
            </div>
        </div>
        <#include "footer.ftl">
    </body>
</html>
