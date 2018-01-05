<#include "macro-head.ftl">
<#include "macro-comments.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${article.articleTitle} - ${blogTitle}">
        <meta name="keywords" content="${article.articleTags}" />
        <meta name="description" content="${article.articleAbstract?html}" />
        </@head>
        <link rel="stylesheet" type="text/css" href="${staticServePath}/skins/${skinDirName}/css/style${miniPostfix}.css?${staticResourceVersion}" media="all" />
    </head>
    <body id="blog">
        ${topBarReplacement}
        <div id="wrap">
            <#include "header-articel.ftl">
            <div id="content" class="clear">
                <div id="main" class="left">
                    <div class="clear"></div>
                        <article id="post" class="clear">
                            <section class="postinfo left extracolum">
                                <div class="post_time icon">
                                    ${article.authorName} Published<br />
                                    <#if article.hasUpdated>
                                    ${article.articleUpdateDate?string("yyyy-MM-dd HH:mm")}
                                    <#else>
                                    ${article.articleCreateDate?string("yyyy-MM-dd HH:mm")}
                                    </#if>                            
                                </div>
                                <ul class="postmeta opaque_5">
                                    <li><a class="comment_post comment_on icon" rel ="nofollow" href="#comments"  title="Skip to Commentlist">${SendYouComments}(${article.articleCommentCount})</a></li>
                                    <li><a href="#" class="share icon">${ShareTo}</a>
                                        <ul class="opaque_10 share_to">
                                            <li><a href="#" class="icon ishare me_tsina">${SinaWeiBo}</a></li>
                                            <li><a href="#" class="icon ishare me_tqq">${TencentWeiBo}</a></li>
                                            <li><a href="#" class="icon ishare me_renren">${RenRenWang}</a></li>
                                            <li><a href="#" class="icon ishare me_qzone">${QZone}</a></li>
                                            <li><a href="#" class="icon ishare me_douban">${DouBan}</a></li>
                                            <li><a href="#" class="icon ishare me_kaixin">${KaiXinWang}</a></li>
                                            <li><a href="#" class="icon ishare me_twitter">Twitter</a></li>
                                            <li><a href="#" class="icon ishare me_facebook">Facebook</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#" class="subscribe icon"> ${RSS}</a>
                                        <ul class="opaque_10 subscribe_to">
                                            <li><a target="_blank" rel="nofollow" title="${RSSToGoogle}" href="http://fusion.google.com/add?feedurl=http://${blogHost}${staticServePath}/blog-articles-feed.do" class="icon me_greader">GReader</a></li>
                                            <li><a target="_blank" rel="nofollow" title="${RSSToXianGuo}" href="http://www.xianguo.com/subscribe.php?url=http://${blogHost}${staticServePath}/blog-articles-feed.do" class="icon me_xianguo">鲜果</a></li>
                                            <li><a target="_blank" rel="nofollow" title="${RSSToZhuaXia}" href="http://www.zhuaxia.com/add_channel.php?url=http://${blogHost}${staticServePath}/blog-articles-feed.do" class="icon me_zhuaxia">抓虾</a></li>
                                            <li><a target="_blank" rel="nofollow" title="{RSSToYaHoo}" href="http://add.my.yahoo.com/rss?url=http://${blogHost}${staticServePath}/blog-articles-feed.do" class="icon me_yahoo">Yahoo!</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#" class="trackback icon">${YYTGDZ}</a></li>
                                    <li><a href="#" class="permalink icon">${ArticlePermalink}</a></li>
                                </ul>
                            </section>
                            <section class="postcontent maincolum left ver_side">
                                <h2>
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
                                </h2>
                                <div class="post_content article-body">
                                    ${article.articleContent}
                                    <div class="copyright_info opaque_10">
                                        »»»
                                        <b>
                                            ${ArticlePermalink2}：
                                            <a rel="bookmark" title="${article.articleTitle}" href="${article.articlePermalink}">
                                                http://${blogHost}${article.articlePermalink}
                                            </a>
                                        </b>
                                        <br />
                                        <b>
                                            ${HuanYinDinYue}
                                            <a href="${staticServePath}/blog-articles-feed.do" target="_blank">${RSSReader}</a>
                                            ${RSS}
                                        </b>
                                        <br /> 
                                        <strong>${Statement}</strong>
                                        <b>${Statement2}
                                            <a title="${Statement3}" 
                                               href="http://creativecommons.org/licenses/by-nc-sa/3.0/deed.zh"
                                               target="_blank" rel="external nofollow"> BY-NC-SA-3.0</a>.
                                            ${Statement4}
                                            <a title="${blogSubtitle} | ${blogSubtitle}" 
                                               href="http://${blogHost}" 
                                               rel="bookmark">
                                                ${blogTitle}
                                            </a>
                                        </b>
                                    </div>
                                </div>
                                <div class="opaque_5 post_tags">Tag(s):
								    <#list article.articleTags?split(",") as articleTag>
										<a href="/tags/${articleTag?url('UTF-8')}">${articleTag}</a>
									</#list>
								</div>
                                <div class="maincolum clear hor_side" id="postnavi">
                                    <#if nextArticlePermalink??>
                                    <span class="left prev_post icon">
                                        <a rel="prev" href="${nextArticlePermalink}">
                                            ${nextArticleTitle}
                                        </a>
                                    </span>
                                    </#if>
                                    <#if previousArticlePermalink??>
                                    <span class="right next_post icon">
                                        <a rel="next" href="${previousArticlePermalink}">
                                            ${previousArticleTitle}
                                        </a>
                                    </span>
                                    </#if>
                                </div>
                                <div id="relatedpost" class="hor_side">
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
                            </section>
                    <div class="clear"></div>
                    <div class="left extracolum opaque_5">
                        <ul class="postmeta opaque_5">
                            <li><a class="comment_post comment_on icon" rel ="nofollow" href="#comments"  title="Skip to Commentlist">${SendYouComments}</a></li>
                        </ul>
                    </div>
                    <@comments commentList=articleComments article=article></@comments>
                    </article>
                </div>
                <#include "side.ftl">
            </div>
            <#include "footer.ftl">
        </div>
        <@comment_script oId=article.oId>
        page.tips.externalRelevantArticlesDisplayCount = "${externalRelevantArticlesDisplayCount}";
        <#if 0 != randomArticlesDisplayCount>
        page.loadRandomArticles('<h3>${randomArticlesLabel}</h3>');
        </#if>
        <#if 0 != relevantArticlesDisplayCount>
        page.loadRelevantArticles('${article.oId}', '<h3>${relevantArticlesLabel}</h3>');
        </#if>
        <#if 0 != externalRelevantArticlesDisplayCount>
        page.loadExternalRelevantArticles('<#list article.articleTags?split(",") as articleTag>${articleTag}<#if articleTag_has_next>,</#if></#list>', '<h3>${externalRelevantArticlesLabel}</h3>');
        </#if>
        
         <#if 0 != externalRelevantArticlesDisplayCount && 0 != relevantArticlesDisplayCount && 0 != randomArticlesDisplayCount>
         $("#relatedpost").hide();
         </#if>
        </@comment_script>   
    </body>
</html>