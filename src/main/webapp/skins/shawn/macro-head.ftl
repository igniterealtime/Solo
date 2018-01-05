<#macro head title>
<meta charset="utf-8" />
<title>${title}</title>
<#nested>
<meta name="author" content="B3log Team" />
<meta name="generator" content="B3log" />
<meta name="copyright" content="B3log" />
<meta name="revised" content="B3log, ${year}" />
<meta http-equiv="Window-target" content="_top" />
<link href="blog-articles-feed.do" title="ATOM" type="application/atom+xml" rel="alternate" />
<link rel="icon" type="image/png" href="${staticServePath}/favicon.png" />
<meta name="author" content="Shawn" />
<link rel="canonical" href="${blogHost}" />
<link rel="stylesheet" type="text/css" href="${staticServePath}/skins/${skinDirName}/css/style${miniPostfix}.css?${staticResourceVersion}" media="all" />
<script type="text/javascript" src="${staticServePath}/js/lib/jquery/jquery.min.js" charset="utf-8"></script>
<script type="text/javascript">
    jQuery(document).ready(function($){
        $('#wgNotice').css('width',$(window).width() - $('#wgSNS').outerWidth() -40);
        $("#wgNotice li:gt(0)").css("display","none");var B=$("#wgNotice li:last");var C=$("#wgNotice li:first");setInterval(function(){if(B.is(":visible")){C.fadeIn(500).addClass("in");B.hide()}else{$("#wgNotice li:visible").addClass("in");$("#wgNotice li.in").next().fadeIn(500);$("#wgNotice li.in").hide().removeClass("in")}},5000);
    });
    function addFavorite(){if(document.all){try{window.external.addFavorite(window.location.href,document.title)}catch(e){alert("${Collection}")}}else if(window.sidebar){window.sidebar.addPanel(document.title,window.location.href,"")}else{alert("${Collection}")}}
</script>
${htmlHead}
</#macro>