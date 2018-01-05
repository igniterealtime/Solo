<#include "macro-head.ftl">
<#include "macro-comments.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${page.pageTitle} - ${blogTitle}">
        <meta name="keywords" content="${metaKeywords},${page.pageTitle}" />
        <meta name="description" content="${metaDescription}" />
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
                        <div class="post_content">
                            ${page.pageContent}
                        </div>
                    </div>
                    <div class="clear"></div>	
                    <@comments commentList=pageComments article=page></@comments>
                    <div class="clear"></div>
                </div>
                <div id="sidebar" class="widget-area">
                    <#include "side.ftl">
                </div>
                <div class="clear"></div>
            </div>
            <#include "footer.ftl">
        </div>
        <div id="bottom-bar"></div>
        <@comment_script oId=page.oId></@comment_script>
    </body>
</html>