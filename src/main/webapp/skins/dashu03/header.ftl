<div class="container navbar-wrapper">
	<div class="navbar navbar-inverse">
		<div class="navbar-inner">
			<a class="btn btn-navbar " data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a>
			<a class="brand" href="${servePath}/">${blogTitle}</a>
			<div class="nav-collapse collapse">
				<ul class="nav">
					<li class="">
						<a href="${servePath}/"><i class="icon-home"></i>&nbsp;${indexLabel}</a>
					</li>
					<#list pageNavigations as page>
					<li>
						<a href="${page.pagePermalink}" target="${page.pageOpenTarget}">${page.pageTitle}</a>
					</li>
					</#list>
					<li class="dropdown">
						<a href="${servePath}/#" class="dropdown-toggle" data-toggle="dropdown">${allTagsLabel}<b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li>
								<a href="${servePath}/tags.html">${allTagsLabel}&nbsp;<i class="icon-tags"></i></a>
							</li>
							<li class="divider"></li>
							<li class="nav-header">
								${popTagsLabel }&nbsp;<i class="icon-arrow-down"></i>
							</li>
							<#if 0 != mostUsedTags?size>
							<#list mostUsedTags as tag>
							<li>
								<a rel="tag" title="${tag.tagTitle}" href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}">
									${tag.tagTitle}</a>
							</li>
							</#list>
							</#if>
						</ul>
					</li>
				</ul>
				</li>
				</ul>
			</div><!--/.nav-collapse -->
		</div><!-- /.navbar-inner -->
	</div><!-- /.navbar -->
</div><!-- /.container -->