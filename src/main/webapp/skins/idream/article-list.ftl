					<div id="maincol">
					<#list articles as article>
						<div class="postwrap">
							<div class="postmeta2">
								<div class="meta2inner">
									<div class="pyear">
									<#if article.hasUpdated>
									${article.articleUpdateDate?string("yyyy")}
									<#else>
									${article.articleCreateDate?string("yyyy")}
									</#if>
									</div>
									<div class="pday">
									<#if article.hasUpdated>
									${article.articleUpdateDate?string("MM/dd")}
									<#else>
									${article.articleCreateDate?string("MM/dd")}
									</#if>
									</div>
								</div>
							</div>
							<h2 class="posttitle shortline">
								<a href="${servePath}${article.articlePermalink}">${article.articleTitle}</a>
							</h2>
							<div class="postmeta">
								<#if article.articlePutTop>
									${topArticleLabel}
								</#if>
								<#if article.hasUpdated>
									${updatedLabel}
								</#if>
								<a href="${servePath}/authors/${article.authorId}">${article.authorName}</a>
								<a href="${servePath}${article.articlePermalink}">${article.articleViewCount} ${viewLabel}</a>
							</div>
							<div class="clr16"></div>
							<div class="postcontent breakline">${article.articleAbstract}</div>
							<div class="clr"></div>
							<div class="roubcornrcontent">
								<span class="posttags" title="${tagLabel}">
									<#list article.articleTags?split(",") as articleTag>
									<a href="${servePath}/tags/${articleTag?url('UTF-8')}">
											${articleTag}</a><#if articleTag_has_next>,</#if>
									</#list>
								</span>
								<a href="${servePath}${article.articlePermalink}#comments">
									<span class="postcomments" title="${commentLabel}">
									${article.articleCommentCount}
									</span>
								</a>
								<div class="clr"></div>
							</div>
							<div class="clr"></div>
						</div>
					</#list>
					<#if 0 != paginationPageCount>
						<div id="nextprevious">
							<div class="nav">
								<div class="wp-pagenavi">
									<#if 1 != paginationPageNums?first>
									<a href="${servePath}${path}/1">${firstPageLabel}</a>
									<a id="previousPage" href="${servePath}${path}/${paginationPreviousPageNum}">${previousPageLabel}</a>
									</#if>
									<#list paginationPageNums as paginationPageNum>
									<#if paginationPageNum == paginationCurrentPageNum>
									<span style="color: #889;">${paginationPageNum}</span>
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
							<div class="clr"></div>
						</div>
						<div class="clr"></div>
					</#if>
					</div>
					<div class="clr"></div>
					<div class="copyr">
					&copy; ${year}&nbsp;<a href="http://${blogHost}">${blogTitle}</a>
					</div>
					<div class="clr16"></div>