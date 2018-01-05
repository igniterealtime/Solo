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
		<div id="wrapper" align="center">
			<#include "header.ftl">
			<div id="outerwrapper">
				<div id="innerwrapper">
				<div id="rightcol">
					<#include "side.ftl">
				</div>
				<div id="maincol">
					<div class="postwrap">
						<div class="postmeta2">
							<div class="meta2inner">
								<div class="pyear"></div>
								<div class="pday"></div>
							</div>
						</div>
						<h2 class="posttitle">
							${page.pageTitle}
						</h2>
						<div class="postmeta">
							<a href="">${blogTitle}</a>
						</div>
						<div class="clr16"></div>
						<div class="postcontent breakline article-body">
						${page.pageContent}
						</div>
						<div class="clr"></div>
					</div>
					<div class="clr"></div>
					 <@comments commentList=pageComments article=page></@comments>
				</div>
				<div class="clr"></div>
				<div class="copyr">
				&copy; ${year}&nbsp;<a href="http://${blogHost}">${blogTitle}</a>
				</div>
				<div class="clr16"></div>
			</div>
			</div>
			<#include "footer.ftl">
		</div>
		<@comment_script oId=page.oId></@comment_script>
    </body>
</html>
