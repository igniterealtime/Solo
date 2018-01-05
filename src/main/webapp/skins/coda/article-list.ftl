<#list articles as article>
<article class="clear">
    <section class="postinfo left extracolum">
        <div class="post_time icon">
            ${article.authorName} Published<br />
            <#if article.hasUpdated>
            ${article.articleUpdateDate?string("yyyy-MM-dd HH:mm:ss")}
            <#else>
            ${article.articleCreateDate?string("yyyy-MM-dd HH:mm:ss")}
            </#if>
        </div>
        <ul class="postmeta opaque_5">
            <li><a class="comment_post comment_on icon" rel ="nofollow" href="#comments"  title="Skip to Commentlist">${SendYouComments}(${article.articleCommentCount})</a></li>
            <li><a href="#" class="permalink icon">${ArticlePermalink}</a></li>
        </ul>
    </section>
    <section class="postcontent maincolum left ver_side">
        <h2>
            <a class="article-title" href="${article.articlePermalink}">
                ${article.articleTitle}
            </a>
            <#if article.articlePutTop>
            <sup class="tip">
                ${topArticleLabel}
            </sup>
            </#if>
        </h2>
        <div class="post_content">
            ${article.articleAbstract}
        </div>
        <div class="opaque_5 post_tags">
            <span class="tags icon">
                <#list article.articleTags?split(",") as articleTag>
                <a href="${staticServePath}/tags/${articleTag?url('UTF-8')}" rel="tag">${articleTag}</a>
                </#list>
            </span>
        </div>
        <div class="hor_side"></div>
    </section>
</article>
</#list>
<#if 0 != paginationPageCount>
<div class="pagination">
<span class="pages">${paginationCurrentPageNum}/${paginationPageCount}</span>
<#if 1 != paginationPageNums?first>
<a href="${staticServePath}${path}/1">1st</a>
<a href="${staticServePath}${path}/${paginationPreviousPageNum}">${TitelNO1}</a>
</#if>
<#list paginationPageNums as paginationPageNum>
<#if paginationPageNum == paginationCurrentPageNum>
<span class="current">${paginationPageNum}</span>
<#else>
<a title="${paginationPageNum}" href="${staticServePath}${path}/${paginationPageNum}">${paginationPageNum}</a>
</#if>
</#list>
<#if paginationPageNums?last != paginationPageCount>
<a href="${staticServePath}${path}/${paginationNextPageNum}">${TitelNO}</a>
<a title="Last ${TitelNO}" href="${staticServePath}${path}/${paginationPageCount}">Last ${TitelNO}</a>
</#if>
</div>
</#if>