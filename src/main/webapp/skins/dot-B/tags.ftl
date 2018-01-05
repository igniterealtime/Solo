<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${allTagsLabel} - ${blogTitle}">
        <meta name="keywords" content="${metaKeywords},${allTagsLabel}"/>
        <meta name="description" content="<#list tags as tag>${tag.tagTitle}<#if tag_has_next>,</#if></#list>"/>
        </@head>
    </head>
    <body id="body">
        ${topBarReplacement}
        <div id="top_bar"></div>
            <div id="wrapper">
            	<#include "header.ftl">
                <div id="main">
                	<div id="content">
                		<div class="post">
							<h2 class="post_title_h2">
								<a href="${blogHost}/tags.html" style="opacity: 1;">${allTagsLabel}</a>
							</h2>
							<div class="clear"></div>
							<div class="post_content">
                                <ul id="tags" class="tags">
                                    <#list tags as tag>
                                    <li>
                                        <a data-count="${tag.tagPublishedRefCount}"
                                           href="${staticServePath}/tags/${tag.tagTitle?url('UTF-8')}" title="${tag.tagTitle}">
                                            <span>${tag.tagTitle}</span>
                                            (<b>${tag.tagPublishedRefCount}</b>)
                                        </a>
                                    </li>
                                    </#list>
                                </ul>
							</div>
							<div class="menu-mark"></div>
						</div>
					</div>
	                <div id="sidebar" class="widget-area">
	                	<#include "side.ftl">
	                </div>
	                <div class="clear"></div>
                </div>
                <div class="clear"></div>
                <#include "footer.ftl">
				 <script type="text/javascript">
					Util.buildTags();
				</script>
            </div>
            <div class="clear"></div>
            <div id="bottom-bar"></div>
    </body>
</html>