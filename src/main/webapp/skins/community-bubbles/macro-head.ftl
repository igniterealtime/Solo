<#macro head title>
<meta charset="utf-8" />
<title>${title}</title>
<#nested>
<meta name="author" content="Armstrong@sweelia.com" />
<meta name="generator" content="B3log" />
<meta name="copyright" content="B3log" />
<meta name="revised" content="Sweelia.com, ${year}" />
<meta http-equiv="Window-target" content="_top" />
<link type="text/css" rel="stylesheet" href="${staticServePath}/css/default-base${miniPostfix}.css?${staticResourceVersion}" charset="utf-8" />
<link type="text/css" rel="stylesheet" href="${staticServePath}/skins/${skinDirName}/css/community-bubbles.css?${staticResourceVersion}" charset="utf-8" />
<link type="text/css" rel="stylesheet" href="${staticServePath}/skins/${skinDirName}/css/bubbles.css?${staticResourceVersion}" charset="utf-8" />
<link href="${servePath}/blog-articles-feed.do" title="ATOM" type="application/atom+xml" rel="alternate" charset="utf-8"/>
<link rel="icon" type="image/png" href="${staticServePath}/favicon.png" />
<script type="text/javascript" src="${staticServePath}/skins/${skinDirName}/js/md5.js?${staticResourceVersion}"></script>
<script type="text/javascript" src="${staticServePath}/skins/${skinDirName}/js/gravatar.js?${staticResourceVersion}"></script>
${htmlHead}
</#macro>