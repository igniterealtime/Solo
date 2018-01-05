<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${blogTitle}">
        <meta name="keywords" content="${metaKeywords}"/>
        <meta name="description" content="<#list articles as article>${article.articleTitle}<#if article_has_next>,</#if></#list>"/>
        </@head>
    </head>
    <body class="home page top-navbar">
        <#include "header.ftl">
        <div id="wrap" class="container" role="document">
            <div id="content" class="row">
                <div id="main" class="span8" role="main">
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
