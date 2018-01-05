<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${allTagsLabel} - ${blogTitle}">
        <meta name="keywords" content="${metaKeywords},${allTagsLabel}"/>
        <meta name="description" content="<#list tags as tag>${tag.tagTitle}<#if tag_has_next>,</#if></#list>"/>
        </@head>
        <link rel="stylesheet" type="text/css" href="${staticServePath}/skins/${skinDirName}/css/style${miniPostfix}.css?${staticResourceVersion}" media="all" />
    </head>
    <body id="blog">
		${topBarReplacement}
        <div id="wrap">
            <#include "header-articel.ftl">
            <div id="content" class="clear">
                <div id="main" class="left">
                    <ul id="tags" class="tags">
                        <#list tags as tag>
                        <li>
                            <a data-count="${tag.tagPublishedRefCount}"
                               href="${staticServePath}/tags/${tag.tagTitle?url('UTF-8')}" title="${tag.tagTitle}">
                                <span>${tag.tagTitle}</span>
                                (<b>${tag.tagPublishedRefCount}</b>)
                            </a>
                        </li>
                        </#list>
                    </ul>
                </div>
                <#include "side.ftl">
                <#include "footer.ftl">
            </div>
        </div>
        <script type="text/javascript">
            Util.buildTags()
        </script>
    </body>
</html>
