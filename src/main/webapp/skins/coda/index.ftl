<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${blogTitle}">
        <meta name="keywords" content="${metaKeywords}"/>
        <meta name="description" content="<#list articles as article>${article.articleTitle}<#if article_has_next>,</#if></#list>"/>
        </@head>
        <link rel="stylesheet" type="text/css" href="${staticServePath}/skins/${skinDirName}/css/style-home${miniPostfix}.css?${staticResourceVersion}" media="all" />
        <style type="text/css">
            #sitemap {background: url(${staticServePath}/skins/${skinDirName}/images/moon.jpg) no-repeat;}
        </style>
    </head>
    <body id="home">
        ${topBarReplacement}
        <div id="sitemap">
            <#include "header.ftl">
            <div id ="mapcontent">
                <div id="mappost">
                    <span class="newposts">${recentArticlesLabel}</span>
                    <ul id="highlight">
                        <#list articles as article>
                        <li>
                            <span class="title"><a href="${article.articlePermalink}" title="${article.articleTitle}">${article.articleTitle}</a></span>
                            <span class="section"><a href="${article.articlePermalink}#comments">${article.articleCommentCount}&nbsp;&nbsp;comments</a></span>
                            <span class="date"><#if article.hasUpdated>
                                ${article.articleUpdateDate?string("yyyy/MM/dd")}
                                <#else>
                                ${article.articleCreateDate?string("yyyy/MM/dd")}
                                </#if>
                            </span>
                        </li>
                        </#list>
                    </ul>
                </div>
            </div>
			<#if 0 != paginationPageCount>
			<div id="pagination">
			<span class="pages">${paginationCurrentPageNum}/${paginationPageCount}</span>
            <#if 1 != paginationPageNums?first>
            <a href="${staticServePath}${path}/1">1st</a>
            <a href="${staticServePath}${path}/${paginationPreviousPageNum}">${TitelNO1}</a>
            </#if>
            <#list paginationPageNums as paginationPageNum>
            <#if paginationPageNum == paginationCurrentPageNum>
            <span class="current">${paginationPageNum}</span>
            <#else>
            <a title="${paginationPageNum}" href="${staticServePath}${path}/${paginationPageNum}">${paginationPageNum}</a>
            </#if>
            </#list>
            <#if paginationPageNums?last != paginationPageCount>
            <a href="${staticServePath}${path}/${paginationNextPageNum}">${TitelNO}</a>
            <a title="Last ${TitelNO}" href="${staticServePath}${path}/${paginationPageCount}">Last ${TitelNO}</a>
            </#if>
			</div>
			</#if>
            <div id="mapfooter">
                <span class="author"> Powered by <a href="http://b3log-solo.googlecode.com" target="_blank" class="logo">
                        ${b3logLabel}&nbsp;
                        <span style="color: orangered; font-weight: bold;">Solo</span></a>,
                    ver ${version}&nbsp;&nbsp; | Copyright <span style="color: gray;">&copy; ${year}</span><a href="http://${blogHost}">${blogTitle}</a>  | Theme by <a href="http://www.ansen.org" target="_blank">Ansen</a>.</span> 
            </div>
        </div>	
    </body>
</html>