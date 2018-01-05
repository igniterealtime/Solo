<div class="span3">
	<div>
		<h4>${mostViewCountArticlesLabel}&nbsp;<i class="icon-folder-close"></i></h4>
		<ul  class="unstyled">
			<#list mostViewCountArticles as article>
            <li>
                <p><a href="${servePath}${article.articlePermalink}" class="tooltipLink" data-original-title='${article.articleAbstract}'>${article.articleTitle}</a></p>
            </li>
            </#list>
		</ul>
	</div>
	<div>
		<h4>${mostCommentArticlesLabel}&nbsp;<i class="icon-comment"></i></h4>
		<ul  class="unstyled">
			<#list mostCommentArticles as article>
            <li>
                <p><a href="${servePath}${article.articlePermalink}" class="tooltipLink" data-original-title='${article.articleAbstract}'>${article.articleTitle}</a></p>
            </li>
            </#list>
		</ul>
	</div>
	<div>
		<#if 0 != archiveDates?size>
    <div class="item">
        <h4>${archiveLabel}&nbsp;<i class="icon-calendar"></i></h4>
        <ul   class="unstyled">
            <#list archiveDates as archiveDate>
            <li>
                <#if "en" == localeString?substring(0, 2)>
                <a href="${servePath}/archives/${archiveDate.archiveDateYear}/${archiveDate.archiveDateMonth}"
                   title="${archiveDate.monthName} ${archiveDate.archiveDateYear}(${archiveDate.archiveDatePublishedArticleCount})">
                    ${archiveDate.monthName} ${archiveDate.archiveDateYear}</a>(${archiveDate.archiveDatePublishedArticleCount})
                <#else>
                <a href="${servePath}/archives/${archiveDate.archiveDateYear}/${archiveDate.archiveDateMonth}"
                   title="${archiveDate.archiveDateYear} ${yearLabel} ${archiveDate.archiveDateMonth} ${monthLabel}(${archiveDate.archiveDatePublishedArticleCount})">
                    ${archiveDate.archiveDateYear} ${yearLabel} ${archiveDate.archiveDateMonth} ${monthLabel}</a>(${archiveDate.archiveDatePublishedArticleCount})
                </#if>
            </li>
            </#list>
        </ul>
    </div>
    </#if>
	</div>
</div>