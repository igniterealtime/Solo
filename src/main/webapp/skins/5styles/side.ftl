				<#--
				<div id="rss">
					<a href="#"><div id="rss-pic"></div></a>
				</div>
				<form method="get" id="searchform" action="#">
						<input type="text" value="#" name="s" id="s" />
						<input type="submit" type="image" id="searchsubmit" value="" />
				</form>
				-->
				<div class="postmetadata">
				        <span>
						${viewCount1Label}
						<span class='error-msg'>
							${statistic.statisticBlogViewCount}
						</span>
						&nbsp;&nbsp;
					</span>
					<span>
						${articleCount1Label}
						<span class='error-msg'>
							${statistic.statisticPublishedBlogArticleCount}
						</span>
						&nbsp;&nbsp;
					</span><br>
					<span>
						${commentCount1Label}
						<span class='error-msg'>
							${statistic.statisticPublishedBlogCommentCount}
						</span>
					</span><br />
					<form target="_blank" method="get" id="searchform" action="/search">
						<input type="text" value="" name="q" id="s">
						<input type="submit" id="searchsubmit" value="${searchLable}">
					</form>
				</div>
				<ul id="sidebarul">
					<#if "" != noticeBoard>
					<li>
						<h3>${noticeBoardLabel}</h3>
						<ul>
							${noticeBoard}
						</ul>
					</li>
					</#if>
					<#if 0 != recentComments?size>
					<li>
						<h3>${recentCommentsLabel}</h3>
						<ul class="comms breakline">
							<#list recentComments as comment>
							<li>
								<span class="arrow">
									<a  rel="nofollow" title="${comment.commentContent}" href="${servePath}${comment.commentSharpURL}">
										${comment.commentContent}
									</a>
								</span>
							</li>
							</#list>
						</ul>
					</li>
					</#if>
					<#if 0 != mostCommentArticles?size>
					<li>
						<h3>${mostCommentArticlesLabel}</h3>
						<ul class="shortline slist">
							<#list mostCommentArticles as article>
							<li>
								<a title="${article.articleTitle}" href="${servePath}${article.articlePermalink}">
									[${article.articleCommentCount}] ${article.articleTitle}
								</a>
							</li>
							</#list>
						</ul>
					</li>
					</#if>
					<#if 0 != mostViewCountArticles?size>
					<li>
						<h3>${mostViewCountArticlesLabel}</h3>
						<ul class="shortline slist">
							<#list mostViewCountArticles as article>
							<li>
								<a title="${article.articleTitle}" href="${servePath}${article.articlePermalink}">
									[${article.articleViewCount}] ${article.articleTitle}
								</a>
							</li>
							</#list>
						</ul>
					</li>
					</#if>
					<#if 0 != mostUsedTags?size>
					<li>
						<h3>${popTagsLabel}</h3>
						<ul class="side-cat" >
							<#list mostUsedTags as tag>
							<a href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}">
							<span>
								${tag.tagTitle}(${tag.tagPublishedRefCount})
							</span></a>
							</#list>
						</ul>
						<div class="clear"></div>
					</li>
					</#if>
					<#if 0 != links?size>
					<li>
						<h3>${linkLabel}</h3>
						<ul class="shortline slist">
							<#list links as link>
							<li>
								<a href="${link.linkAddress}" title="${link.linkTitle}" target="_blank">
									${link.linkTitle}
								</a>
							</li>
							</#list>
						</ul>
					</li>
					</#if>
					<#if 0 != archiveDates?size>
					<li>
						<h3>${archiveLabel}</h3>
						<ul class="shortline slist">
							<#list archiveDates as archiveDate>
							<li>
								<#if "en" == localeString?substring(0, 2)>
								<a href="${servePath}/archives/${archiveDate.archiveDateYear}/${archiveDate.archiveDateMonth}">
									${archiveDate.monthName} ${archiveDate.archiveDateYear} (${archiveDate.archiveDatePublishedArticleCount})
								</a>
								<#else>
								<a href="${servePath}/archives/${archiveDate.archiveDateYear}/${archiveDate.archiveDateMonth}">
									${archiveDate.archiveDateYear} ${yearLabel} ${archiveDate.archiveDateMonth} ${monthLabel}(${archiveDate.archiveDatePublishedArticleCount})
								</a>
								</#if>
							</li>
							</#list>
						</ul>
					</li>
					</#if>
				</ul>