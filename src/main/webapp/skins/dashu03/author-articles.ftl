<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${authorName} - ${blogTitle}">
        <meta name="keywords" content="${metaKeywords},${authorName}"/>
        <meta name="description" content="<#list articles as article>${article.articleTitle}<#if article_has_next>,</#if></#list>"/>
        </@head>
    </head>
    <body>
        <#include "header.ftl">
        <div class="main">
            <div class="container"  style="margin-top: 100px;">
            	<div class="row">
        			<div class="span9">
		                <h2>${author1Label}${authorName}</h2>
		                <#include "article-list.ftl">
            		</div>
            		
            		<#include "usedside.ftl">
            		
				</div>
			</div>
        </div>
        <#include "footer.ftl">
    </body>
</html>
