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
    <body>
    ${topBarReplacement}
	<div id="wrap">
		<#include "header.ftl">
		<div id="main">
			<div id="maincontent">
				<div class="forFlow">
					<div class="navigation-top shortline">
						<span>${breadcrumbNaviLabel}</span>
						<a href="${servePath}/">${homeLabel}</a> > <a title="${article.articleTitle}">${article.articleTitle}</a>
					</div>
					<div class="post">
						<h2 class="post-tltle breakline">
							${article.articleTitle}
						</h2>
						<div class="postmetadata-top">
							<span class="post-date">
							        <#if article.hasUpdated>
								${article.articleUpdateDate?string("yyyy-MM-dd HH:mm:ss")}
								<#else>
								${article.articleCreateDate?string("yyyy-MM-dd HH:mm:ss")}
								</#if>
							</span>
							<a href="/authors/${article.authorId}" title="${authorLabel}">
								<span class="post-author">
									${article.authorName}
								</span>
							</a>
							<a href="${article.articlePermalink}" title="${viewLabel}">
								<span class="post-views">
										${article.articleViewCount}
								</span>
							</a>
							<a href="${article.articlePermalink}#comments" title="${commentLabel}">
								<span class="post-comments">
									${article.articleCommentCount}
								</span>
							</a>
							<span id="bdshare" class="bdshare_b" style="line-height: 12px;float: right;"><img src="http://share.baidu.com/static/images/type-button-1.jpg" />
								<a class="shareCount"></a>
							</span>
						</div>
						<div class="article-body breakline">
							${article.articleContent}
							<#if "" != article.articleSign.signHTML?trim>
							<div class="marginTop12">
								${article.articleSign.signHTML}
							</div>
							</#if>
						</div>
						<div class="postmetadata">
							<span class="post-tag" title="${tagLabel}">
								<#list article.articleTags?split(",") as articleTag>
								<span>
									<a href="${servePath}/tags/${articleTag?url('UTF-8')}">
										${articleTag}</a><#if articleTag_has_next>,</#if>
								</span>
								</#list>
							</span>
						</div>
						<div class="shortline">
							<#if nextArticlePermalink??>
							${nextArticle1Label}
							<a href="${servePath}${nextArticlePermalink}" title="${nextArticleTitle}">${nextArticleTitle}</a>
							<br/>
							</#if>
							<#if previousArticlePermalink??>
							${previousArticle1Label}
							<a href="${servePath}${previousArticlePermalink}" title="${previousArticleTitle}">${previousArticleTitle}</a>
							<br/>
							</#if>
						</div>
						<div id="relevantArticles" class="article-relative"></div>
						<div id="randomArticles" class="article-relative"></div>
						<div id="externalRelevantArticles" class="article-relative"></div>
					</div>
					<@comments commentList=articleComments article=article></@comments>
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
        <@comment_script oId=article.oId>
        page.tips.externalRelevantArticlesDisplayCount = "${externalRelevantArticlesDisplayCount}";
        <#if 0 != randomArticlesDisplayCount>
        page.loadRandomArticles();
        </#if>
        <#if 0 != relevantArticlesDisplayCount>
        page.loadRelevantArticles('${article.oId}', '${relevantArticles1Label}');
        </#if>
        <#if 0 != externalRelevantArticlesDisplayCount>
        page.loadExternalRelevantArticles("<#list article.articleTags?split(",") as articleTag>${articleTag}<#if articleTag_has_next>,</#if></#list>");
        </#if>
        </@comment_script>
	<script type="text/javascript" id="bdshare_js" data="type=button&amp;mini=1&amp;uid=19727" ></script>
	<script type="text/javascript" id="bdshell_js"></script>
	<script type="text/javascript">
		document.getElementById("bdshell_js").src = "http://share.baidu.com/static/js/shell_v2.js?t=" + new Date().getHours();
	</script>
    </body>
</html>
