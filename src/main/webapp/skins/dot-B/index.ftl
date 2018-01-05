<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${blogTitle}">
        <meta name="keywords" content="${metaKeywords}"/>
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
                    <#include "article-list.ftl">
                </div>
                <div id="sidebar" class="widget-area">
                    <#include "side.ftl">
                </div>
                <div class="clear"></div>
            </div>
            <#include "footer.ftl">
        </div>
        <div id="bottom-bar"></div>
    </body>
</html>