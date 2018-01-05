<div class="span3">
	<div>
		<h4>${mostViewCountArticlesLabel}&nbsp;<i class="icon-folder-close"></i></h4>
		<ul  class="unstyled">
			<#list mostViewCountArticles as article>
            <li>
                <p><a href="${servePath}${article.articlePermalink}" class="tooltipLink" data-original-title='${article.articleAbstract}'>${article.articleTitle}</a></p>
                <span style="display: none;">${article.articleAbstract}</span>
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
                <span style="display: none;">${article.articleAbstract}</span>
            </li>
            </#list>
		</ul>
	</div>
	<div>
		<#if 0 != mostUsedTags?size>
		<#list mostUsedTags as tag>
		<li>
			<a rel="tag" title="${tag.tagTitle}" href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}">
				${tag.tagTitle}</a>
		</li>
		</#list>
		</#if>
	</div>
	<div>
		<#list links as link>
		<li>
			<span class="left">
			<a rel="friend" href="${link.linkAddress}" title="${link.linkTitle}" target="_blank" >
				<img alt="${link.linkTitle}"
					 src="http://www.google.com/s2/u/0/favicons?domain=<#list link.linkAddress?split('/') as x><#if x_index=2>${x}<#break></#if></#list>" />&nbsp;${link.linkTitle}
			</a>
			</span>&nbsp;&nbsp;
		</li>
		</#list>
	</div>
	<div>
		<#if 0 != archiveDates?size>
    <div class="item">
        <h4>${archiveLabel}</h4>
        <ul>
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