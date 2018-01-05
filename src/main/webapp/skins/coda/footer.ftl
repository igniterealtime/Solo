<footer class="opaque_10">
    Powered by 
    <a href="http://b3log-solo.googlecode.com" target="_blank" class="logo">
        ${b3logLabel}&nbsp;
        <span style="color: orangered; font-weight: bold;">Solo</span></a>,
    ver ${version}&nbsp;&nbsp; | Copyright
    <span style="color: gray;">&copy; ${year}</span>
    <a href="http://${blogHost}">${blogTitle}</a>
    | Theme by
    <a href="http://www.ansen.org" target="_blank">Ansen</a>&<a href="http://vanessa.b3log.org/" target="_blank">Vanessa</a>.
</footer>
<script type="text/javascript" src="${staticServePath}/js/lib/jquery/jquery.min.js?${staticResourceVersion}" charset="utf-8"></script>
<script type="text/javascript" src="${staticServePath}/js/common${miniPostfix}.js?${staticResourceVersion}" charset="utf-8"></script>
<script type="text/javascript">
    var latkeConfig = {
        "servePath": "${servePath}",
        "staticServePath": "${staticServePath}"
    };
    var Label = ({
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
    });
    $(document).ready(function () {
	    Util.init();
		Util.replaceSideEm($("#recentComments .row"));
	});
</script>${plugins}    