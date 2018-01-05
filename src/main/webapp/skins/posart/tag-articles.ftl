<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${tag.tagTitle} - ${blogTitle}">
        <meta name="keywords" content="${metaKeywords},${tag.tagTitle}"/>
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
				<ul class="breadcrumb">
						<li><a href="${servePath}">首页</a> <span class="divider">/</span></li>
						<li class='active'>
						<a id="tag" rel="alternate" href="${servePath}/tag-articles-feed.do?oId=${tag.oId}" style="color:#333333">
								${tag1Label}
								${tag.tagTitle}
								(${tag.tagPublishedRefCount})
							</a></li>	
					</ul>
					<div class="posts-list">
						
						 <#include "article-list.ftl">				 
					</div>
				</div>
			</div>
	<#include "footer.ftl">
	</div>

    </body>
</html>
