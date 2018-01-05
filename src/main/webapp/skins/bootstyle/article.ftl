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
<body class="home page top-navbar">
<#include "header.ftl">
<div id="wrap" class="container" role="document">
    <div id="content" class="row">
        <div id="main" class="span8" role="main">
            <div class="page-header page-header-m">
                <h3>
                    ${article.articleTitle}
                </h3>
            </div>
            <div class="page-header-bottom">
                <span>
                    <li class="icon-time"></li>
                    <#if article.hasUpdated>
                    ${article.articleUpdateDate?string("yyyy-MM-dd HH:mm:ss")}
                    <#else>
                    ${article.articleCreateDate?string("yyyy-MM-dd HH:mm:ss")}
                    </#if>
                </span>
                <span>
                    <li class="icon-user"></li>
                    <a href="/authors/${article.authorId}" title="${authorLabel}: ${article.authorName}">
                        ${article.authorName}
                    </a>
                </span>
                <div class="pull-right">
                    <span>
                        <li class="icon-eye-open"></li>
                        <a href="${article.articlePermalink}">${article.articleViewCount} ${viewLabel}</a>
                    </span>
                    <span>
                        <li class="icon-comment"></li>
                        <a href="${article.articlePermalink}#comments">${article.articleCommentCount} ${commentLabel}</a>
                    </span>
                </div>
            </div>
            ${article.articleContent}
            <div class="article-tags">
                <li class="icon-tags"></li>
                ${tag1Label}
                <#list article.articleTags?split(",") as articleTag>
                    <span>
                        <a href="${servePath}/tags/${articleTag?url('UTF-8')}">
                            ${articleTag}
                        </a>
                        <#if articleTag_has_next>,</#if>
                    </span>
                </#list>
            </div>
            <div class="alert alert-info">
            <#if nextArticlePermalink??>
                <a href="${servePath}${nextArticlePermalink}" title="${nextArticleTitle}">
                    <li class="icon-step-backward"></li>${nextArticleTitle}
                </a>
            </#if>
                &nbsp;
            <#if previousArticlePermalink??>
                <div class="pull-right">
                    <a href="${servePath}${previousArticlePermalink}" title="${previousArticleTitle}">
                        ${previousArticleTitle}<li class="icon-step-forward"></li>
                    </a>
                </div>
            </#if>
            </div>
            <@comments commentList=articleComments article=article></@comments>
        </div>
        <aside id="sidebar" class="span4" role="complementary">
        <#include "side.ftl">
        </aside>
    </div>
</div>
<#include "footer.ftl">
<@comment_script oId=article.oId>
page.tips.externalRelevantArticlesDisplayCount = "${externalRelevantArticlesDisplayCount}";
    <#if 0 != randomArticlesDisplayCount>
    page.loadRandomArticles('<h4 class="ft-gray">${randomArticlesLabel}</h4>');
    </#if>
    <#if 0 != relevantArticlesDisplayCount>
    page.loadRelevantArticles('${article.oId}', '<h4 class="ft-gray">${relevantArticlesLabel}</h4>');
    </#if>
    <#if 0 != externalRelevantArticlesDisplayCount>
    page.loadExternalRelevantArticles("<#list article.articleTags?split(",") as articleTag>${articleTag}<#if articleTag_has_next>,</#if></#list>");
    </#if>
</@comment_script>
</body>
</html>
