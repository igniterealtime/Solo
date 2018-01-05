<#list articles as article>
<div class="page-header page-header-m">
    <h3><a href="${article.articlePermalink}">${article.articleTitle}</a></h3>
</div>
<div class="page-header-bottom">
    <span>
        <li class="icon-time"></li>
        <#if article.hasUpdated>
        ${article.articleUpdateDate?string("yyyy-MM-dd HH:mm")}
        <#else>
        ${article.articleCreateDate?string("yyyy-MM-dd HH:mm")}
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
${article.articleAbstract}
<div class="article-tags">
    <li class="icon-tags"></li>${tag1Label}
    <#list article.articleTags?split(",") as articleTag>
        <span>
            <a href="${servePath}/tags/${articleTag?url('UTF-8')}">
            ${articleTag}
            </a>
            <#if articleTag_has_next>,</#if>
        </span>
    </#list>
</div>
</#list>
<#if paginationCurrentPageNum != paginationPageCount && 0 != paginationPageCount>
<div class="btn btn-block pagination-btn" onclick="getNextPage()" data-page="${paginationCurrentPageNum}">${moreLabel}</div>
</#if>