<div id="maptitle">
    <h1><a href="${staticServePath}">${blogTitle}</a></h1>
    <h3>${blogSubtitle}</h3>
</div>
<div id="mapmenu" class="clear">
    <ul>
        <li>
            <a href="${staticServePath}" title="${indexLabel}">${indexLabel}</a>
        </li>
        <li>
            <a href="${staticServePath}/tags.html">${allTagsLabel}</a>  
        </li>
        <#list pageNavigations as page>
        <li>
            <a href="${page.pagePermalink}" target="${page.pageOpenTarget}">${page.pageTitle}</a>
        </li>
        </#list>
    </ul>
</div>
