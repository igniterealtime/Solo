<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${allTagsLabel} - ${blogTitle}">
        <meta name="keywords" content="${metaKeywords},${allTagsLabel}"/>
        <meta name="description" content="<#list tags as tag>${tag.tagTitle}<#if tag_has_next>,</#if></#list>"/>
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
						<a href="${servePath}">${homeLabel}</a> > <a title="${allTagsLabel}">${allTagsLabel}</a>
					</div>
					<div class="post">
						<h2 class="post-tltle breakline">
							${allTagsLabel}
						</h2>
						<div class="entry">
							<#list tags as tag>
							<a data-count="${tag.tagPublishedRefCount}"
							   href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}" title="${tag.tagTitle}">
								<span>${tag.tagTitle}</span>
								(<b>${tag.tagPublishedRefCount}</b>)
							</a>
							</#list>
						</div>
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
        <script type="text/javascript">
            Util.buildTags();
        </script>
    </body>
</html>
