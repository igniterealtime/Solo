<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${article.articleTitle} - ${blogTitle}">
        <meta name="keywords" content="${article.articleTags}" />
        <meta name="description" content="${article.articleAbstract?html}" />
        </@head>
        <link rel="stylesheet" type="text/css" href="${staticServePath}/skins/${skinDirName}/css/style${miniPostfix}.css?${staticResourceVersion}" media="all" />
    </head>
    <body id="blog">
        <div id="loading" style="display: none; "></div>
		<div id="wrap">
			<#include "header-articel.ftl">
			<div id="content" class="clear">
                <h2>${author1Label}${authorName}</h2>
                <#include "article-list.ftl">
            </div>
            <#include "side.ftl">
            <#include "footer.ftl">
        </div>
    </body>
</html>
