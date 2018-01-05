<#if "" != noticeBoard>
<section class="widget-1 widget">
    <div class="widget-inner">
        <h4>${noticeBoardLabel}</h4>
        <p>${noticeBoard}</p>
    </div>
</section>
</#if>

<#if 0 != recentComments?size>
<section id="widget_recent_comments" class="widget-2 widget comments">
    <div class="widget-inner"><h4>${recentCommentsLabel}</h4>
        <ul>
            <#list recentComments as comment>
            <li class="recentcomments">
                <a target="_blank" rel="external nofollow" href="${comment.commentURL}" class="url">${comment.commentName}:</a>
                <a rel="external nofollow" class=" breakline url" href="${comment.commentSharpURL}">
                    ${comment.commentContent}
                </a>
            </li>
            </#list>
        </ul>
    </div>
</section>
</#if>

<#if 0 != mostCommentArticles?size>
<section class="widget-3 widget">
    <div class="widget-inner">
        <h4>${mostCommentArticlesLabel}</h4>
        <ul>
            <#list mostCommentArticles as article>
            <li>
                <a href="${article.articlePermalink}">
                    [${article.articleCommentCount}] ${article.articleTitle}
                </a>
            </li>
            </#list>
        </ul>
    </div>
</section>
</#if>

<#if 0 != mostViewCountArticles?size>
<section class="widget-4 widget">
    <div class="widget-inner">
        <h4>${mostViewCountArticlesLabel}</h4>
        <ul>
            <#list mostViewCountArticles as article>
            <li>
                <a href="${article.articlePermalink}">
                    [${article.articleViewCount}] ${article.articleTitle}
                </a>
            </li>
            </#list>
        </ul>
    </div>
</section>
</#if>

<#if 0 != mostUsedTags?size>
<section class="widget-5 widget">
    <div class="widget-inner">
        <h4>${popTagsLabel}</h4>
        <ul>
            <#list mostUsedTags as tag>
                <span class="tag">
                    <#if (tag.tagPublishedRefCount/3 > 5 ) >
					<a href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}" title="${tag.tagPublishedRefCount}">
                        <span class="badge badge-inverse">${tag.tagTitle}</span>
                    </a>
                    <#elseif (tag.tagPublishedRefCount/3 > 4 ) >
                        <a href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}" title="${tag.tagPublishedRefCount}">
                            <span class="badge badge-info">${tag.tagTitle}</span>
                        </a>
                    <#elseif (tag.tagPublishedRefCount/3 > 3 ) >
                        <a href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}" title="${tag.tagPublishedRefCount}">
                            <span class="badge badge-success">${tag.tagTitle}</span>
                        </a>
                    <#elseif (tag.tagPublishedRefCount/3 > 2 ) >
                        <a href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}" title="${tag.tagPublishedRefCount}">
                            <span class="badge badge-important">${tag.tagTitle}</span>
                        </a>
                    <#elseif (tag.tagPublishedRefCount/3 > 1 ) >
                        <a href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}" title="${tag.tagPublishedRefCount}">
                            <span class="badge badge-warning">${tag.tagTitle}</span>
                        </a>
                    <#elseif (tag.tagPublishedRefCount/3 > 0 ) >
                        <a href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}" title="${tag.tagPublishedRefCount}">
                            <span class="badge">${tag.tagTitle}</span>
                        </a>
                    </#if>
				</span>
            </#list>
        </ul>
    </div>
</section>
</#if>

<#if 0 != archiveDates?size>
<section class="widget-6 widget">
    <div class="widget-inner">
        <h4>${archiveLabel}</h4>
        <ul>
            <#list archiveDates as archiveDate>
            <#if "en" == localeString?substring(0, 2)>
                <li><a href="${servePath}/archives/${archiveDate.archiveDateYear}/${archiveDate.archiveDateMonth}"
                       title="${archiveDate.monthName} ${archiveDate.archiveDateYear}(${archiveDate.archiveDatePublishedArticleCount})">
                ${archiveDate.monthName} ${archiveDate.archiveDateYear}</a>(${archiveDate.archiveDatePublishedArticleCount})</li>
            <#else>
                <li><a href="${servePath}/archives/${archiveDate.archiveDateYear}/${archiveDate.archiveDateMonth}"
                       title="${archiveDate.archiveDateYear} ${yearLabel} ${archiveDate.archiveDateMonth} ${monthLabel}(${archiveDate.archiveDatePublishedArticleCount})">
                ${archiveDate.archiveDateYear} ${yearLabel} ${archiveDate.archiveDateMonth} ${monthLabel}</a>(${archiveDate.archiveDatePublishedArticleCount})</li>
            </#if>
            </#list>
        </ul>
    </div>
</section>
</#if>

<#if 0 != links?size>
<section class="widget-7 widget">
    <div class="widget-inner">
        <h4>${linkLabel}</h4>
        <ul>
            <#list links as link>
                <li>
                    <a href="${link.linkAddress}" title="${link.linkTitle}" target="_blank">
                        ${link.linkTitle}
                    </a>
                </li>
            </#list>
        </ul>
    </div>
</section>
</#if>
