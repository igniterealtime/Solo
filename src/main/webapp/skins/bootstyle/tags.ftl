<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${allTagsLabel} - ${blogTitle}">
        <meta name="keywords" content="${metaKeywords},${allTagsLabel}"/>
        <meta name="description" content="<#list tags as tag>${tag.tagTitle}<#if tag_has_next>,</#if></#list>"/>
        </@head>
    </head>
    <body class="home page top-navbar">
        <#include "header.ftl">
        <div id="wrap" class="container" role="document">
            <div id="content" class="row">
                <div id="main" class="span8" role="main">
                    <ul id="tags" class="other-main">
                    <#list tags as tag>
                        <li>
                            <a rel="tag" data-count="${tag.tagPublishedRefCount}"
                               href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}" title="${tag.tagTitle}">
                                <span>${tag.tagTitle}</span>
                                (<b>${tag.tagPublishedRefCount}</b>)
                            </a>
                        </li>
                    </#list>
                    </ul>
                    <div class="clear"></div>
                </div>
                <aside id="sidebar" class="span4">
                <#include "side.ftl">
                </aside>
            </div>
        </div>
        <#include "footer.ftl">
        <script type="text/javascript">
            Util.buildTags();
        </script>
    </body>
</html>
