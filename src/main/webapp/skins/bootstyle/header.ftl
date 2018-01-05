<header id="banner" class="navbar navbar-fixed-top" role="banner" style="z-index: 9;">
    <div class="navbar-inner">
        <div class="container">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <a class="brand" href="${servePath}" title="${blogSubtitle}">${blogTitle}</a>
            <nav id="nav-main" class="nav-collapse" role="navigation">
                <ul id="menu-primary-navigation" class="nav">
                    <li class="menu-home"><a href="${servePath}">${indexLabel}</a></li>
                    <#list pageNavigations as page>
                    <li><a href="${page.pagePermalink}" target="${page.pageOpenTarget}">${page.pageTitle}</a></li>
                    </#list>
                    <li>
                        <a href="${servePath}/tags.html">${allTagsLabel}</a>
                    </li>
                    <li>
                        <a rel="alternate" href="${servePath}/blog-articles-feed.do">Atom<img src="${staticServePath}/images/feed.png" alt="Atom"/></a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</header>

