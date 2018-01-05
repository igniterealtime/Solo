			<!--<div id="footer-no"></div>-->
			<div id="footer-link">
			<p>&copy; ${year} <a href="${servePath}">${blogTitle}</a></p>
			<p>
				Powered by
				<a href="http://b3log.org" target="_blank">
					<span style="color: orange;">B</span>
					<span style="font-size: 9px; color: blue;"><sup>3</sup></span>
					<span style="color: green;">L</span>
					<span style="color: red;">O</span>
					<span style="color: blue;">G</span>&nbsp;
					<span style="color: orangered; font-weight: bold;">Solo</span></a>,
				ver ${version}&nbsp;&nbsp;
				Theme[5style for 0.5.0] by <a href="http://www.noday.net" target="_blank">Noday</a>
				& <a href="http://marslau.com" target="_blank" title="Mars Lau's blog">Mars Lau</a>
			</p>
			</div>
			<div id="footer-right"><a href="javascript:void(0);" onclick="Util.goTop();" id="to-top" title="Top"></a></div>
<script type="text/javascript" src="${staticServePath}/js/lib/jquery/jquery.min.js" charset="utf-8"></script>
<script type="text/javascript" src="${staticServePath}/js/common${miniPostfix}.js?${staticResourceVersion}" charset="utf-8"></script>
<script type="text/javascript">
    var latkeConfig = {
        "servePath": "${servePath}",
        "staticServePath": "${staticServePath}"
    };
    
    var Label = {
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

    $(document).ready(function () {
        Util.init();
        Util.replaceSideEm($("#sidebarul .arrow a"));
        // set selected navi
        $("#header-navi li").each(function (i) {
            if (i < $("#header-navi li").length - 1) {
                var $it = $(this),
                locationURL = window.location.pathname + window.location.search;
                if (i === 0 && (locationURL === "/")) {
                    $it.addClass("selected");
                    return;
                }
                if (locationURL.indexOf($it.find("a").attr("href")) > -1 && i !== 0) {
                    $it.addClass("selected");
                }
            }
        });
    });
</script>
${plugins}
<!--百度统计-->
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F82227c32d41de30d4b92e66760d6e7b9' type='text/javascript'%3E%3C/script%3E"));
</script>