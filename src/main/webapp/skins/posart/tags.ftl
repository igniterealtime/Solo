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
        <#include "header.ftl">
		<div id="wrapper">
			<a href="${servePath}" class="header mhidden"><img src="${staticServePath}/skins/${skinDirName}/images/ghead.png"></a>
				<div id="container" class="cl">		
				<div class="body">				
					<ul class="breadcrumb">
						<li><a href="${servePath}">首页</a> <span class="divider">/</span></li>
						<li style="color:#333333">
						标签墙</li>					
					</ul>
					<div class="tag-content"  >
						<#list tags as tag>
							
								<a rel="tag" data-count="${tag.tagPublishedRefCount}" class="tab-label"
								   href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}" title="${tag.tagTitle}">
									<span>${tag.tagTitle}</span>
									(<b>${tag.tagPublishedRefCount}</b>)
								</a>
							
						</#list>
					</div>
				</div>
			</div>
			 <#include "footer.ftl">
		</div>     
       
        <script type="text/javascript">
            Util.buildTags();
        </script>
    </body>
</html>
