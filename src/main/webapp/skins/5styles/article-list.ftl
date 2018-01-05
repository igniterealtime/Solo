					<#if 0 != recentComments?size>
					<#list articles as article>
					<div class="post">
						<h2 class="post-tltle shortline">
							<a href="${servePath}${article.articlePermalink}" title="${article.articleTitle}">
								${article.articleTitle}
							</a>
						</h2>
						<div class="postmetadata-top">
							<span class="post-date">
							        <#if article.hasUpdated>
								${article.articleUpdateDate?string("yyyy-MM-dd HH:mm:ss")}
								<#else>
								${article.articleCreateDate?string("yyyy-MM-dd HH:mm:ss")}
								</#if>
							</span>
							<a href="${servePath}/authors/${article.authorId}" title="${authorLabel}">
								<span class="post-author">
									${article.authorName}
								</span>
							</a>
							<a href="${servePath}${article.articlePermalink}" title="${viewLabel}">
								<span class="post-views">
										${article.articleViewCount}
								</span>
							</a>
							<a href="${servePath}${article.articlePermalink}#comments" title="${commentLabel}">
								<span class="post-comments">
									${article.articleCommentCount}
								</span>
							</a>
						</div>
						<div class="entry breakline">
							${article.articleAbstract}
						</div>
						<div class="postmetadata">
							<!--
							<span class="post-cat">#</span>-->
							<span class="post-tag" title="${tagLabel}">
								<#list article.articleTags?split(",") as articleTag>
								<span>
									<a href="${servePath}/tags/${articleTag?url('UTF-8')}">
										${articleTag}</a><#if articleTag_has_next>,</#if>
								</span>
								</#list>
							</span>
						</div>
					</div>
					</#list>
					<#if 0 != paginationPageCount>
					<div class="navigation">
						<div id="pagenavi">
							<#if 1 != paginationPageNums?first>
							<a href="${servePath}${path}/1">${firstPageLabel}</a>
							<a id="previousPage" href="${servePath}${path}/${paginationPreviousPageNum}">${previousPageLabel}</a>
							</#if>
							<#list paginationPageNums as paginationPageNum>
							<#if paginationPageNum == paginationCurrentPageNum>
							<span>${paginationPageNum}</span>
							<#else>
							<a href="${servePath}${path}/${paginationPageNum}">${paginationPageNum}</a>
							</#if>
							</#list>
							<#if paginationPageNums?last != paginationPageCount>
							<a id="nextPage" href="${servePath}${path}/${paginationNextPageNum}">${nextPagePabel}</a>
							<a href="${servePath}${path}/${paginationPageCount}">${lastPageLabel}</a>
							</#if>
							&nbsp;&nbsp;${sumLabel} ${paginationPageCount} ${pageLabel}
						</div>
					</div>
					</#if>
					<#else>
					<h2 class="center">${noArticleTitleLabel}</h2>
					<p class="center">${noArticleContentLabel}</p>
					</#if>