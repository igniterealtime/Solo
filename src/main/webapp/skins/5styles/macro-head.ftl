<#macro head title>
<meta charset="utf-8" />
<title>${title}</title>
<#nested>
<meta name="author" content="B3log Team" />
<meta name="generator" content="B3log" />
<meta name="copyright" content="B3log" />
<meta name="revised" content="B3log, ${year}" />
<meta http-equiv="Window-target" content="_top" />
<link title="css0" href="${staticServePath}/skins/${skinDirName}/css/layout1.css?${staticResourceVersion}" rel="stylesheet" disabled="false" type="text/css" charset="utf-8" />
<link title="css1" href="${staticServePath}/skins/${skinDirName}/css/layout2.css?${staticResourceVersion}" rel="stylesheet" disabled="false" type="text/css" charset="utf-8" />
<link title="css2" href="${staticServePath}/skins/${skinDirName}/css/layout3.css?${staticResourceVersion}" rel="stylesheet" disabled="false" type="text/css" charset="utf-8" />
<link title="css3" href="${staticServePath}/skins/${skinDirName}/css/layout4.css?${staticResourceVersion}" rel="stylesheet" disabled="false" type="text/css" charset="utf-8" />
<link title="css4" href="${staticServePath}/skins/${skinDirName}/css/layout5.css?${staticResourceVersion}" rel="stylesheet" disabled="false" type="text/css" charset="utf-8" />
<link href="${staticServePath}/skins/${skinDirName}/css/${skinDirName}.css?${staticResourceVersion}" type="text/css" rel="stylesheet" charset="utf-8" />
<script type="text/javascript" src="${staticServePath}/skins/${skinDirName}/js/${skinDirName}.js?${staticResourceVersion}" charset="utf-8"></script>
<script type="text/javascript">setStyleSheet(readCookie("stylesheet"));</script>
<link href="${servePath}/blog-articles-feed.do" title="ATOM" type="application/atom+xml" rel="alternate" />
<link rel="icon" type="image/png" href="${staticServePath}/favicon.png" />
${htmlHead}
</#macro>