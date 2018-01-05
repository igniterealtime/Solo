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
	<div id="wrap">
		<#include "header.ftl">
		<div id="main">
			<div id="maincontent">
				<div class="forFlow">
					<div class="navigation-top shortline">
						<span>${breadcrumbNaviLabel}</span>
						<a href="${servePath}">${homeLabel}</a> > <a title="${tag1Label}">
						${tag1Label}${tag.tagTitle}(${tag.tagPublishedRefCount})
						<a href="${servePath}/tag-articles-feed.do?oId=${tag.oId}">
							<img alt="${tag.tagTitle}" src="${servePath}/images/feed.png" width="16px" height="16px"/>
						</a>
						</a>
					</div>
					<#include "article-list.ftl">
				</div>
			</div>
			<div id="sidebar">
				<#include "side.ftl">
			</div>
		</div>
		<div id="footer">
			<#include "footer.ftl">
		</div>
	</div>
    </body>
</html>
