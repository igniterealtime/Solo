<#include "macro-head.ftl">
<#include "macro-comments.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${page.pageTitle} - ${blogTitle}">
        <meta name="keywords" content="${metaKeywords},${page.pageTitle}" />
        <meta name="description" content="${metaDescription}" />
        </@head>
        <link rel="stylesheet" type="text/css" href="${staticServePath}/skins/${skinDirName}/css/style${miniPostfix}.css?${staticResourceVersion}" media="all" />
    </head>
    <body id="blog">
		${topBarReplacement}
		<div id="wrap">
			<#include "header-articel.ftl">
			<div id="content" class="clear">
				<div id="main" class="left">
					<div class="clear">
						<article id="post" class="clear">
							<section class="postinfo left extracolum">
								<div class="post_time icon">
									Published                          
								</div>
								<ul class="postmeta opaque_5">
									<li><a class="comment_post comment_on icon" rel ="nofollow" href="#comments"  title="Skip to Commentlist">${SendYouComments}(${page.pageCommentCount})</a></li>
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
											<li><a target="_blank" rel="nofollow" title="${RSSToXianGuo}" href="http://www.xianguo.com/subscribe.php?url=http://${blogHost}${staticServePath}/blog-articles-feed.do" class="icon me_xianguo">${XianGuo}</a></li>
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
									<a class="article-title" href="${page.pagePermalink}">
										${page.pageTitle}
									</a>
								</h2>
								<div class="post_content">
										${page.pageContent}
								</div>
								<div class="opaque_5 post_tags"></div>
							</section>
						</div>
                    <div class="left extracolum opaque_5">
                        <ul class="postmeta opaque_5">
                            <li><a class="comment_post comment_on icon" rel ="nofollow" href="#comments"  title="Skip to Commentlist">${SendYouComments}</a></li>
                        </ul>
                    </div>
							<@comments commentList=pageComments article=page></@comments>
					</article>
				</div>
				<#include "side.ftl">
			</div>
			<#include "footer.ftl">
		</div>
    </body>
</html>