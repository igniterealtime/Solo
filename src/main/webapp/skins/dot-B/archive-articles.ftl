<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${archiveDate.archiveDateMonth} ${archiveDate.archiveDateYear} (${archiveDate.archiveDatePublishedArticleCount}) - ${blogTitle}">
        <meta name="keywords" content="${metaKeywords},${archiveDate.archiveDateYear}${archiveDate.archiveDateMonth}"/>
        <meta name="description" content="<#list articles as article>${article.articleTitle}<#if article_has_next>,</#if></#list>"/>
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
                                ${archive1Label}
                                <#if "en" == localeString?substring(0, 2)>
                                ${archiveDate.archiveDateMonth} ${archiveDate.archiveDateYear} (${archiveDate.archiveDatePublishedArticleCount})
                                <#else>
                                ${archiveDate.archiveDateYear} ${yearLabel} ${archiveDate.archiveDateMonth} ${monthLabel} (${archiveDate.archiveDatePublishedArticleCount})
                                </#if>
							</h2>
							<div class="clear"></div>
							<div class="post_content">
                                <#include "article-list.ftl">
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
            </div>
            <div class="clear"></div>
            <div id="bottom-bar"></div>
    </body>
</html>