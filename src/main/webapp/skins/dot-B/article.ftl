<#include "macro-head.ftl">
<#include "macro-comments.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${article.articleTitle} - ${blogTitle}">
        <meta name="keywords" content="${article.articleTags}" />
        <meta name="description" content="${article.articleAbstract?html}" />
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
                            <a href="${article.articlePermalink}" style="opacity: 1;">${article.articleTitle}</a>
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
                        </h2>
                        <div class="post_info_top">
                            <div class="post_info_date">
                                <a href="${article.articlePermalink}" title="${dateLabel}" rel="bookmark">Posted&nbsp;&nbsp;on&nbsp;&nbsp; 
                                    <#if article.hasUpdated>
                                    ${article.articleUpdateDate?string("yyyy-MM-dd HH:mm:ss")}
                                    <#else>
                                    ${article.articleCreateDate?string("yyyy-MM-dd HH:mm:ss")}
                                    </#if>
                                </a>
                            </div>
                            <div class="post_info_author">
                                <a href="${staticServePath}/authors/${article.authorId}" title="Posts&nbsp;&nbsp;by&nbsp;&nbsp;${article.authorName}" rel="author" style="opacity: 1; ">${article.authorName}</a>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="post_content">
                            ${article.articleContent}
                            <#if "" != article.articleSign.signHTML?trim>
                            <div class="sign-htmml">
                                ${article.articleSign.signHTML}
                            </div>
                            </#if>
                            <#if 0 != relevantArticlesDisplayCount>
                            <div id="relevantArticles" class="article-relative left" style="width: 50%;"></div>
                            </#if>
                            <div id="randomArticles" class="left article-relative"></div>
                            <div class="clear"></div>
                            <div id="externalRelevantArticles" class="article-relative"></div>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div class="post_info_bootom">
                        <div class="post_meta">
                            <ul>
                                <#list article.articleTags?split(",") as articleTag>
                                <li><a href="${staticServePath}/tags/${articleTag?url('UTF-8')}" rel="tag">${articleTag}</a><#if articleTag_has_next>,</#if></li>
                                </#list>
                            </ul>
                        </div>  
                        <div class="post_readmore">
                            <a href="${article.articlePermalink}#comments" title="Comment&nbsp;&nbsp;on&nbsp;&nbsp;">${article.articleCommentCount}&nbsp;&nbsp;${commentLabel}
                            </a>
                        </div>	
                    </div>		
                    <div class="post-nav">
                        <#if nextArticlePermalink??>
                        <div class="previous_post"><a href="${nextArticlePermalink}">${nextArticle1Label}${nextArticleTitle}</a></div>
                        <#else>
                        <div class="previous_post">Already the latest post!</div>
                        </#if>
                        <#if previousArticlePermalink??>
                        <div class="next_post"><a href="${previousArticlePermalink}">${previousArticle1Label}${previousArticleTitle}</a></div>
                        <#else>
                        <div class="next_post">Already the latest post!</div>
                        </#if>
                    </div>
                    <@comments commentList=articleComments article=article></@comments>
                    <div class="clear"></div>
                </div>
                <div id="sidebar" class="widget-area">
                    <#include "side.ftl">
                </div>
                <div class="clear"></div>
            </div>
            <#include "footer.ftl">
        </div>
        <div id="bottom-bar"></div>
        <@comment_script oId=article.oId>
        page.tips.externalRelevantArticlesDisplayCount = "${externalRelevantArticlesDisplayCount}";
        <#if 0 != randomArticlesDisplayCount>
        page.loadRandomArticles();
        </#if>
        <#if 0 != relevantArticlesDisplayCount>
        page.loadRelevantArticles('${article.oId}', '<h4>${relevantArticlesLabel}</h4>');
        </#if>
        <#if 0 != externalRelevantArticlesDisplayCount>
        page.loadExternalRelevantArticles("<#list article.articleTags?split(",") as articleTag>${articleTag}<#if articleTag_has_next>,</#if></#list>");
        </#if>
        </@comment_script>    
    </body>
</html>