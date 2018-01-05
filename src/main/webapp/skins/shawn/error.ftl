<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${notFoundLabel} - ${blogTitle}">
        <meta name="keywords" content="${notFoundLabel},${metaKeywords}"/>
        <meta name="description" content="${sorryLabel},${notFoundLabel},${metaDescription}"/>
        <meta name="robots" content="noindex, follow"/>
        </@head>
    </head>
    <body>
        ${topBarReplacement}
        <div id="loading" style="display: none; "></div>
        <div id="page">
            <#include "header.ftl">
            <div id="content">
                <h2 >${sorryLabel} ${notFoundLabel}</h2>
                <a href="http://${blogHost}">${returnTo1Label}${blogTitle}</a>
            </div>
            <#include "side.ftl">
            <#include "footer.ftl">
        </div>
    </body>
</html>