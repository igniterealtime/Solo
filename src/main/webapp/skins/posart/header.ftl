<div id="header">
		<ul class="z">
			<li><a class="main" href="${servePath}" title="${blogTitle}"> ${blogTitle}</a></li>
			   <#list pageNavigations as page>
                <li>
                    <a href="${page.pagePermalink}" target="${page.pageOpenTarget}">${page.pageTitle}</a>
                </li>
                </#list> 
				<li>
                    <a href="${servePath}/tags.html">${allTagsLabel}</a>  
                </li>
				<li>
                    <a href="#">我的作品</a>
                </li>
				<li>
                    <a href="#">关于我们</a>
                </li>				
				<!--<li>
                    <a href="${servePath}/dynamic.html">${dynamicLabel}</a>
                </li>
               
                <li>
                    <a href="${servePath}/archives.html">${archiveLabel}</a>
                </li>
                <li>
                    <a href="${servePath}/links.html">${linkLabel}</a>
                </li> -->
                <li>
                    <a rel="alternate" href="${servePath}/blog-articles-feed.do">Atom<img src="${staticServePath}/images/feed.png" alt="Atom"/></a>
                </li>				
		</ul>		
</div>	
