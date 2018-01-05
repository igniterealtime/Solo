<header>
    <h2 id="logo"><a href="${blogHost}">${blogTitle}</a></h2>
    <nav>
        <ul class="menu clear">
            <li>
                <a href="${staticServePath}" title="${indexLabel}">${indexLabel}</a>
            </li>
            <li>
                <a href="${staticServePath}/tags.html">${allTagsLabel}</a>  
            </li>
            <#list pageNavigations as page>
            <li>
                <a href="${page.pagePermalink}">${page.pageTitle}</a>
            </li>
            </#list>
        </ul>
    </nav>
    <div id="dash" class="clear">
        <div class="right">${blogSubtitle}</div>
        <div>
            <p class="icon post_subr">
                <a href="http://fusion.google.com/add?feedurl=${blogHost}${staticServePath}/blog-articles-feed.do">Google${RSS}</a>${Or}
                <a href="http://xianguo.com/subscribe?url=http%3A%2F%2F${blogHost}%2Fblog-articles-feed.do">${XianGuo}${RSS}</a>
            </p>
            <p class="icon me_tsina">
                <a target="_blank" href="http://t.qq.com/shenan" rel="external">${Mine}${TencentWeiBo}</a>
            </p>
        </div>
    </div>
</header>
