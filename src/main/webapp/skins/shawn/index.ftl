<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${blogTitle}">
        <meta name="keywords" content="${metaKeywords}"/>
        <meta name="description" content="<#list articles as article>${article.articleTitle}<#if article_has_next>,</#if></#list>"/>
        </@head>
    </head>
    <body>
        ${topBarReplacement}
        <div id="loading" style="display: none; "></div>
        <div id="page">
        <#include "header.ftl">
        <div id="content">
            <#include "article-list.ftl">
        </div>
        <#include "side.ftl">
        <#include "footer.ftl">
        </div>
    </body>
</html>
