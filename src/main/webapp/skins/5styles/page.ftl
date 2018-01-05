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
    <body>
    ${topBarReplacement}
	<div id="wrap">
		<#include "header.ftl">
		<div id="main">
			<div id="maincontent">
				<div class="forFlow">
					<div class="navigation-top shortline">
						<span>${breadcrumbNaviLabel}</span>
						<a href="/">${homeLabel}</a> > <a title="${page.pageTitle}">${page.pageTitle}</a>
					</div>
					<div class="post">
						<h2 class="post-tltle breakline">
							${page.pageTitle}
						</h2>
						<div class="article-body breakline">
							${page.pageContent}
						</div>
					</div>
					<@comments commentList=pageComments article=page></@comments>
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
        <@comment_script oId=page.oId></@comment_script>
    </body>
</html>
