<#include "macro-head.ftl">
<#include "macro-comments.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${tag.tagTitle} - ${blogTitle}">
        <meta name="keywords" content="${metaKeywords},${tag.tagTitle}"/>
        <meta name="description" content="<#list articles as article>${article.articleTitle}<#if article_has_next>,</#if></#list>"/>
        </@head>
        <link rel="stylesheet" type="text/css" href="${staticServePath}/skins/${skinDirName}/css/style${miniPostfix}.css?${staticResourceVersion}" media="all" />
    </head>
    <body id="blog">
		<div id="wrap">
			<#include "header-articel.ftl">
			<div id="content" class="clear">
				<div id="main" class="left">
				<div class="opaque_10 result"><strong class="icon tags">${ArticleTags} : </strong>"${tag.tagTitle}"<br></div>	
				 <#include "article-list.ftl">	
				</div>
				<#include "side.ftl">
			</div>
			<#include "footer.ftl">
		</div>
    </body>
</html>