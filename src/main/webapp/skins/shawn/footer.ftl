<div id="footer">
    <div id="footertext">
        <span style="color: gray;">&copy; ${year}</span> - <a href="http://${blogHost}">${blogTitle}</a><br/>
        Powered by
        <a href="http://b3log-solo.googlecode.com" target="_blank" class="logo">
            ${b3logLabel}&nbsp;
            <span style="color: orangered; font-weight: bold;">Solo</span></a>,
        ver ${version}&nbsp;&nbsp;
        Theme by <a href="http://www.ansen.org" target="_blank">Ansen</a>
        & <a href="http://vanessa.b3log.org" target="_blank">Vanessa</a>
        & <a href="http://www.q86.net" target="_blank">Angel</a>.
    </div>
    <div class="b2t" style="opacity: 0.2; "></div>
    <div class="g2b" style="opacity: 0.2; "></div>
    <form action="http://www.google.com/cse" id="cse-search-box">
        <div>
            <input type="hidden" name="cx" value="partner-pub-6776264782593260:2266952709" />
            <input type="hidden" name="ie" value="UTF-8" />
            <input type="text" name="q" size="25" />
        </div>
    </form>
</div>
<div class="advise">${Repeatedlyrefresh1} 
    <a href="${staticServePath}/blog-articles-feed.do" rel="external">RSS</a> ${Repeatedlyrefresh2}
    <a href="javascript:void(0)">${Repeatedlyrefresh3}</a>
</div>
<script type="text/javascript" src="${staticServePath}/js/common${miniPostfix}.js?${staticResourceVersion}" charset="utf-8"></script>
<script type="text/javascript" src="${staticServePath}/skins/${skinDirName}/js/core${miniPostfix}.js?${staticResourceVersion}"></script>
<script type="text/javascript" src="${staticServePath}/skins/${skinDirName}/js/javascription${miniPostfix}.js?${staticResourceVersion}"></script>
${plugins}