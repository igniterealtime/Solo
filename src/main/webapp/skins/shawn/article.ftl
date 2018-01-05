<#include "macro-head.ftl">
<#include "macro-comments.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${article.articleTitle} - ${blogTitle}">
        <meta name="keywords" content="${article.articleTags}" />
        <meta name="description" content="${article.articleAbstract?html}" />
        </@head>
        <script type="text/javascript" src="${staticServePath}/skins/${skinDirName}${staticServePath}/js/ed.js?${staticResourceVersion}"></script>
    </head>
    <body>
        <div id="loading" style="display: none; "></div>
        <div id="page">
            <#include "header.ftl">
            <div id="content">   
                <div class="post" id="post">
                    <h1>
                        <a class="article-title" href="${article.articlePermalink}">
                            ${article.articleTitle}
                        </a>
                        <#if article.hasUpdated>
                        <sup class="tip">
                            ${updatedLabel}
                        </sup>
                        </#if>
                        <#if article.articlePutTop>
                        <sup class="tip">
                            ${topArticleLabel}
                        </sup>
                        </#if>
                    </h1>
                    <div class="timeta" style="opacity: 0.7; ">${article.authorName} Published@
                        <#if article.hasUpdated>
                        ${article.articleUpdateDate?string("yyyy-MM-dd HH:mm:ss")}
                        <#else>
                        ${article.articleCreateDate?string("yyyy-MM-dd HH:mm:ss")}
                        </#if>                            
                        /<a class="say" href="#comments" title="Skip to Commentlist">Skip</a> 
                    </div>
                    <div class="clear"></div>
                    <div class="entry">
                        <div class="article-body">
                            ${article.articleContent}
                        </div>
                        <#if "" != article.articleSign.signHTML?trim>
                        <div>
                            ${article.articleSign.signHTML}
                        </div>
                        </#if>
                        <div class="clear"></div>
                        <div>
                        <#if nextArticlePermalink??>
                            <div class="left commentsli" style="float:left;width:250px;">
                                <a href="${nextArticlePermalink}" title="${nextArticleTitle}">${nextArticle1Label}${nextArticleTitle}</a>
                            </div>
                            </#if>                            
                            <#if previousArticlePermalink??>
                             <div class="right commentsli" style="width:250px;">
                                 <a href="${previousArticlePermalink}" title="${previousArticleTitle}">${previousArticle1Label}${previousArticleTitle}</a>
                             </div>
                            </#if></div>
                            <div class="clear"></div>
                        <div id="postail" style="border-top-left-radius: 7px 7px; border-top-right-radius: 7px 7px; border-bottom-right-radius: 7px 7px; border-bottom-left-radius: 7px 7px; position: relative; zoom: 1; ">
                            Tag(s): 
                            <#list article.articleTags?split(",") as articleTag>
                            <a href="${staticServePath}/tags/${articleTag?url('UTF-8')}">${articleTag}</a>
                            </#list>
                            <div style="display: inherit">
                                <canvas width="7px" height="7px" style="position:absolute;top:-2px;left:-2px;"></canvas>
                                <canvas width="7px" height="7px" style="position:absolute;top:-2px;right:-2px;"></canvas>
                                <canvas width="7px" height="7px" style="position:absolute;bottom:-2px;left:-2px;"></canvas>
                                <canvas width="7px" height="7px" style="position:absolute;bottom:-2px;right:-2px;"></canvas>
                            </div>
                        </div>
                        <div id="share">
                            <ul style="display: none; top: -225px; opacity: 0; ">
                                <li onclick="window.open('http://shuqian.qq.com/post?title=${article.articleTitle}%26url=${blogHost}${article.articlePermalink}');return false">${QQBookmarks}</li>
                                <li onclick="window.open('http://del.icio.us/post?url%3D${blogHost}${article.articlePermalink}%26title=${article.articleTitle}');return false">Del.icio.us</li>
                                <li onclick="window.open('http://cang.baidu.com/do/add?it%3D${article.articleTitle}%26iu=${blogHost}${article.articlePermalink}%26dc%3D%26fr%3Dien#nw%3D1');return false">${BaiduFavorites}</li>
                                <li onclick="window.open('http://www.google.com/bookmarks/mark?op%3Dedit%26bkmk%3D${blogHost}${article.articlePermalink}%26title%3D${article.articleTitle}');return false">Google</li>
                                <li onclick="window.open('http://fanfou.com/sharer?u%3D${blogHost}${article.articlePermalink}%26t%3D${article.articleTitle}');return false">${FanFou}</li>
                                <li onclick="window.open('http://friendfeed.com/share?url=${blogHost}${article.articlePermalink}%26title%3D${article.articleTitle}');return false">FriendFeed</li>
                            </ul>
                        </div>
                    </div>
                    <div class="related">
                        <div id="relatedclick">
                            <span style="color:red;font-weight:bold;padding-left:95px">&hearts;&hearts;&hearts;</span>
                            <a href="javascript:showRelatedul('${article.oId}', '${relevantArticles1Label}', '${article.articleTags}')">
                                <span style="font-weight:bold">${AmbiguousArticle}
                            </a>
                            <span style="color:red;font-weight:bold">&hearts;&hearts;&hearts;</span>
                        </div>
                        <div id="relatedul" style="display: none;" class="hidden">
							<#if 0 != randomArticlesDisplayCount>
								page.loadRandomArticles();
							</#if>
							<#if 0 != relevantArticlesDisplayCount>
								page.loadRelevantArticles('${article.oId}', '<h4>${relevantArticles1Label}</h4>');
							</#if>
							<#if 0 != externalRelevantArticlesDisplayCount>
								page.loadExternalRelevantArticles("<#list article.articleTags?split(",") as articleTag>${articleTag}<#if articleTag_has_next>,</#if></#list>");
							</#if>
                        </div>
                    </div>
                </div>
                <@comments commentList=articleComments article=article></@comments>
            </div>
            <#include "side.ftl">
            <#include "footer.ftl">
        </div>
        <@comment_script oId=article.oId>
        page.tips.externalRelevantArticlesDisplayCount = "${externalRelevantArticlesDisplayCount}";
        </@comment_script>    
    </body>
</html>
