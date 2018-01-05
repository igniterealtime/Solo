<footer id="footer">
    <div class="navbar-inner">
        <div class="container">
            <div class="pull-left">
                <span>&copy; ${year}</span> - <a href="${servePath}">${blogTitle}</a>
                Powered by
                <a href="http://b3log.org" target="_blank" class="logo">
                ${b3logLabel}&nbsp;
                    <span style="color: orangered; font-weight: bold;">Solo</span></a>,
                ver ${version}&nbsp;&nbsp;
                Theme by <a rel="friend" rel="friend" href="http://www.oncereply.me" target="_blank">oncereply</a>.
                <a href="${servePath}/admin-index.do#main">${adminLabel}</a>
            </div>
            <div class="pull-right">
                <div class="pull-left">
                ${viewCount1Label}
                    <span>
                    ${statistic.statisticBlogViewCount}
                    </span>
                    &nbsp;&nbsp;
                ${articleCount1Label}
                    <span>
                    ${statistic.statisticPublishedBlogArticleCount}
                    </span>
                    &nbsp;&nbsp;
                ${commentCount1Label}
                    <span>
                    ${statistic.statisticPublishedBlogCommentCount}
                    </span>
                </div>
                <span class="translate-ico" onclick="goTranslate()"></span>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</footer>

<div id="goTop" onclick="Util.goTop()" class="hide">TOP</div>
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
<script type="text/javascript" src="${staticServePath}/js/lib/jquery/jquery.min.js" charset="utf-8"></script>
<script type="text/javascript" src="${staticServePath}/js/common${miniPostfix}.js?${staticResourceVersion}" charset="utf-8"></script>
<script type="text/javascript" src="${staticServePath}/skins/${skinDirName}/bootstrap/js/bootstrap${miniPostfix}.js?${staticResourceVersion}" charset="utf-8"></script>
<script type="text/javascript" src="${staticServePath}/skins/${skinDirName}/js/${skinDirName}${miniPostfix}.js?${staticResourceVersion}" charset="utf-8"></script>
${plugins}
