<div id="footer" class="">
	<div class="container">
		<div class="span3">
			<h3>NOTIC</h3>
			<div>
				<i class="icon-leaf"></i>&nbsp;${noticeBoard}
			</div>
		</div>
		<div class="span3">
			<h3>${allTagsLabel }</h3>
			<div>
				<ul class="unstyled">
					<#list mostUsedTags as tag>
					<li style="float: left;">
						<a rel="tag" title="${tag.tagTitle}(${tag.tagPublishedRefCount})" href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}">
							${tag.tagTitle}(${tag.tagPublishedRefCount})&nbsp;</a>
					</li>
					</#list>
				</ul>
			</div>
		</div>
		<div class="span3">
			<h3>${linkLabel}</h3>
			<div>
				<ul class="unstyled">
					<#list links as link>
					<li style="float: left;">
						<span class="left">
						<a rel="friend" href="${link.linkAddress}" title="${link.linkTitle}" target="_blank" >
							<img alt="${link.linkTitle}"
								 src="http://www.google.com/s2/u/0/favicons?domain=<#list link.linkAddress?split('/') as x><#if x_index=2>${x}<#break></#if></#list>" />&nbsp;${link.linkTitle}
						</a>
						</span>&nbsp;&nbsp;
					</li>
					</#list>
				</ul>
			</div>
		</div>
		<div class="span3" style="width: 240px;">
			<div style="margin-top: 13px;">
			&copy; 2012 <a href="http://${blogHost}">${blogTitle}</a><br>
			Powered By <a href="http://www.b3log.org/">B3log</a><br>
			Theme by <a href="http://www.idashu.me">idashu</a><br>
		</div>
		</div>
	</div>
</div>
<script type="text/javascript">
var latkeConfig = {
	"servePath": "${servePath}",
	"staticServePath": "${staticServePath}"
};
var Label = {
    "tag1Label": "${tag1Label}",
    "viewLabel": "${viewLabel}",
    "commentLabel": "${commentLabel}",
    "topArticleLabel": "${topArticleLabel}",
    "updatedLabel": "${updatedLabel}",
    "contentLabel": "${contentLabel}",
    "abstractLabel": "${abstractLabel}",
    "clearAllCacheLabel": "${clearAllCacheLabel}",
    "clearCacheLabel": "${clearCacheLabel}",
    "adminLabel": "${adminLabel}",
    "logoutLabel": "${logoutLabel}",
    "skinDirName": "${skinDirName}",
    "loginLabel": "${loginLabel}",
    "em00Label": "${em00Label}",
    "em01Label": "${em01Label}",
    "em02Label": "${em02Label}",
    "em03Label": "${em03Label}",
    "em04Label": "${em04Label}",
    "em05Label": "${em05Label}",
    "em06Label": "${em06Label}",
    "em07Label": "${em07Label}",
    "em08Label": "${em08Label}",
    "em09Label": "${em09Label}",
    "em10Label": "${em10Label}",
    "em11Label": "${em11Label}",
    "em12Label": "${em12Label}",
    "em13Label": "${em13Label}",
    "em14Label": "${em14Label}"
};
</script>
<script type="text/javascript" src="${staticServePath}/skins/${skinDirName}/js/jquery.js" charset="utf-8"></script>
<script type="text/javascript" src="${staticServePath}/skins/${skinDirName}/js/bootstrap.js" charset="utf-8"></script>
<script type="text/javascript" src="${staticServePath}/skins/${skinDirName}/js/bootstrap-tooltip.js" charset="utf-8"></script>
<script type="text/javascript" src="${staticServePath}/js/common${miniPostfix}.js?${staticResourceVersion}" charset="utf-8"></script>
<script type="text/javascript">
	$(".tooltipLink").tooltip({
		html : true
	});
</script>
${plugins}