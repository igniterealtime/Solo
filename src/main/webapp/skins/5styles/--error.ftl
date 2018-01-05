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
        <#include "top-nav.ftl">
	<div id="wrap">
		<#include "header.ftl">
		<div id="main">
			<div id="maincontent">
				<div class="forFlow">
					<div class="navigation-top shortline">
						<span>${breadcrumbNaviLabel}</span>
						<a href="/">${homeLabel}</a> > <a title="${notFoundLabel}">${notFoundLabel}</a>
					</div>
					<div class="post">
						<h2 class="post-tltle">${notFoundLabel}</h2>
						<p>${noArticleContentLabel}</p>
						<p><a href="http://${blogHost}">${returnTo1Label}${blogTitle}</a></p>
					</div>
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
