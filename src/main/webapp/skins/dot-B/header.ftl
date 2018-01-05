	<div id="header">
		<div id="logo">
			<a href="${staticServePath}" title="${blogTitle}" rel="home">${blogTitle}</a>
			<div id="description">${blogSubtitle}</div>
		</div>
		<div id="header_right">
			<div id="header_meta">
				<div id="header_search_area">
					<form action="http://www.google.com/cse" id="searchform">
           					<input type="hidden" name="cx" value="003546163348813487923:cn_wvlqmqvs" />
            				<input type="hidden" name="ie" value="UTF-8" />
           					<input type="text" id="s" name="q" size="25"  value="type, hit enter" size="35" maxlength="50" x-webkit-speech="" />
   					</form>
				</div>
				<a id="rss" rel="external nofollow" href="${staticServePath}/blog-articles-feed.do" title="RSS FEED" ></a>
			</div>
			<div class="clear"></div>
			<div id="social">
				<div class="menu-default-container">
					<ul class="menu" id="menu-default">
						<li class="facebook"><a target="_blank" href="https://www.facebook.com/ansenorg">Facebook</a></li>
						<li class="twitter"><a target="_blank" href="https://twitter.com/ansenorg">Twitter</a></li>
						<li class="tencent"><a target="_blank" href="http://t.qq.com/shenan">${Tencentmicroblog}</a></li>
						<li class="gplus"><a target="_blank" href="https://plus.google.com/u/0/104839560635327200193">Google+</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="header_menu">
			<div class="menu-menu-container">
				<ul>
					<li>
						<a href="${staticServePath}">${indexLabel}</a>
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
			</div>
		</div>
	</div>