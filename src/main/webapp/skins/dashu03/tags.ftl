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
        <#include "header.ftl">
        <div class="main">
            <div class="container" style="margin-top: 100px;">
            	<div class="row">
            		<div class="span9">
            			<ul id="tags" class="unstyled">
		                    <#list tags as tag>
		                    <li class="pull-left">
		                        <a rel="tag" data-count="${tag.tagPublishedRefCount}"
		                           href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}" title="${tag.tagTitle}">
		                            <span>${tag.tagTitle}</span>
		                            (<b>${tag.tagPublishedRefCount}</b>)
		                        </a>&nbsp;&nbsp;
							</li>
		                    </#list>
		                </ul>
            		</div>
            		
            		<#include "usedside.ftl">
            		
            	</div>
                
            </div>
        </div>
        <#include "footer.ftl">
        <script type="text/javascript">
            Util.buildTags();
        </script>
    </body>
</html>
