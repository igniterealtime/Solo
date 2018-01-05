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
	<#include "header.ftl">
	<div id="wrapper">
		<a href="${servePath}" class="header mhidden"><img src="${staticServePath}/skins/${skinDirName}/images/ghead.png"></a>
			<div id="container" class="cl">		
				<div class="body">
					<div id="loading-posts" style="display:none;"></div>			 
						<div class="posts-list">
						 <#include "article-list.ftl">				 
						</div>
				</div>
			</div>
	<#include "footer.ftl">
	</div>
    
        
    </body>
</html>
