<#list articles as article>
		<div  id="post">
			<h2 class="post_title_h2">
				<a href="${article.articlePermalink}">${article.articleTitle}</a>
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
				<div class="post_info_author">&nbsp;&nbsp;by&nbsp;&nbsp;
					<a href="/authors/${article.authorId}" title="Posts&nbsp;&nbsp;by&nbsp;&nbsp;${article.authorName}" rel="author" style="opacity: 1; ">${article.authorName}</a>
				</div>
			</div>
			<div class="post_content">
				${article.articleAbstract}
			</div>
		</div>
		<div class="post_info_bootom">
			<div class="post_meta">
				<ul>
					<#list article.articleTags?split(",") as articleTag>
						<li><a href="${staticServePath}/tags/${articleTag?url('UTF-8')}" rel="tag">${articleTag}</a><#if articleTag_has_next></#if></li>
					</#list>
				</ul>
			</div>  
			<div class="post_readmore">
				<a href="${article.articlePermalink}#comments" title="Comment&nbsp;&nbsp;on&nbsp;&nbsp;">${article.articleCommentCount}&nbsp;&nbsp;${commentLabel}
        		</a>
			</div>	
		</div>
</#list>
<#if 0 != paginationPageCount>
	<div class="page_navi">
	<ul class="page-numbers">
            <#if 1 != paginationPageNums?first>
            <li><a href="${staticServePath}" title="${nextPagePabel}">${firstPageLabel}</a>
            <a href="${staticServePath}${path}/${paginationPreviousPageNum}" title="${previousPageLabel}"><<</a></li>
            </#if>
            <#list paginationPageNums as paginationPageNum>
            <#if paginationPageNum == paginationCurrentPageNum>
            <li><span class="current">${paginationPageNum}</span></li>
            <#else>
            <li><a title="${paginationPageNum}" href="${staticServePath}${path}/${paginationPageNum}">${paginationPageNum}</a></li>
            </#if>
            </#list>
            <#if paginationPageNums?last != paginationPageCount>
            <li><a href="${staticServePath}${path}/${paginationNextPageNum}" title="${nextPagePabel}">>></a>
            <a href="${staticServePath}${path}/${paginationPageCount}" title="${lastPageLabel}">${lastPageLabel}</a></li>
            </#if>
            &nbsp;&nbsp;${sumLabel} ${paginationPageCount} ${pageLabel}
	</ul>
	</div>
</#if>