<#macro comments commentList article>
<!-- comments -->
<div id="comments" class="comments article-comments">
    <#list commentList as comment>
    <div class="media bs-docs-example-child" id="${comment.oId}">
        <#if "http://" == comment.commentURL>
        <a class="pull-left" title="${comment.commentName}"><img class="media-object img-polaroid" data-src="holder.js/64x64" style="width: 64px; height: 64px;" src="${comment.commentThumbnailURL}"></a>
        <#else>
        <a class="pull-left" href="${comment.commentURL}" target="_blank"><img class="media-object img-polaroid" data-src="holder.js/64x64" style="width: 64px; height: 64px;" src="${comment.commentThumbnailURL}"></a>
        </#if>
        <div class="media-body">
            <h4 class="media-heading">
                <#if "http://" == comment.commentURL>
                <a>${comment.commentName}</a>
                <#else>
                <a href="${comment.commentURL}" target="_blank">${comment.commentName}</a>
                </#if>
                <#if comment.isReply>
                <i class="icon-share-alt"></i>
                <a href="${servePath}${article.permalink}#${comment.commentOriginalCommentId}"
                   onmouseover="page.showComment(this, '${comment.commentOriginalCommentId}', 10);"
                   onmouseout="page.hideComment('${comment.commentOriginalCommentId}')">${comment.commentOriginalCommentName}</a>
                </#if>
                <span class="pull-right" style="font-size: 12px;font-weight: normal;color: #676767;">
                    <i class="icon-time"></i> 
                    ${comment.commentDate?string("yyyy-MM-dd HH:mm:ss")}
                    <i class="icon-comment"></i>
                    <a rel="nofollow" href="javascript:replyTo('${comment.oId}');">${replyLabel}</a>
                </span>
            </h4>
            ${comment.commentContent}
            <!-- Nested media object -->
            <div class="media" ref="#media_${comment.commentOriginalCommentId}">
            </div>
        </div>
    </div>
    </#list>
</div>

<!-- Leave a comment -->
<#if article.commentable>
<form class="well form-horizontal" id="commentForm">
    <div class="control-group">
        <div class="input-prepend">
            <span class="add-on"><i class="icon-user"></i></span>
            <input type="text" id="commentName" placeholder="${commentNameLabel}">
        </div>
    </div>
    <div class="control-group">
        <div class="input-prepend">
            <span class="add-on"><i class="icon-envelope"></i></span>
            <input type="text" id="commentEmail" placeholder="${commentEmailLabel}">
        </div>
    </div>
    <div class="control-group">
        <div class="input-prepend">
            <span class="add-on"><i class="icon-globe"></i></span>
            <input type="text" id="commentURL" placeholder="${commentURLLabel}">
        </div>
    </div>
    <div class="control-group">
        <span id="emotions">
            <span class="em00" title="${em00Label}"></span>
            <span class="em01" title="${em01Label}"></span>
            <span class="em02" title="${em02Label}"></span>
            <span class="em03" title="${em03Label}"></span>
            <span class="em04" title="${em04Label}"></span>
            <span class="em05" title="${em05Label}"></span>
            <span class="em06" title="${em06Label}"></span>
            <span class="em07" title="${em07Label}"></span>
            <span class="em08" title="${em08Label}"></span>
            <span class="em09" title="${em09Label}"></span>
            <span class="em10" title="${em10Label}"></span>
            <span class="em11" title="${em11Label}"></span>
            <span class="em12" title="${em12Label}"></span>
            <span class="em13" title="${em13Label}"></span>
            <span class="em14" title="${em14Label}"></span>
        </span>
        <div>
            <textarea rows="7" cols="96" id="comment" class="input-block-level"></textarea>
        </div>
    </div>
    <div class="control-group">
        <div class="input-prepend">
            <span class="add-on"><i class="icon-check"></i></span>
            <input type="text" id="commentValidate"/>
            <img id="captcha" alt="validate" src="${servePath}/captcha.do" class="img-polaroid" style="margin-left: 5px;" />
        </div>
    </div>
    <div class="form-actions form-actions-m pagination-right">
        <span class="pull-left text-error" id="commentErrorTip"></span>
        <button id="submitCommentButton" type="button" onclick="page.submitComment();" class="btn btn-primary">${submmitCommentLabel}</button>
    </div>
</form>
<#if externalRelevantArticlesDisplayCount?? && 0 != externalRelevantArticlesDisplayCount>
<div id="externalRelevantArticles" class="article-relative"></div>
</#if>
</#if>
</#macro>

<#macro comment_script oId>
<script type="text/javascript" src="${staticServePath}/js/page${miniPostfix}.js?${staticResourceVersion}" charset="utf-8"></script>
<script type="text/javascript">
    var page = new Page({
        "nameTooLongLabel": "${nameTooLongLabel}",
        "mailCannotEmptyLabel": "${mailCannotEmptyLabel}",
        "mailInvalidLabel": "${mailInvalidLabel}",
        "commentContentCannotEmptyLabel": "${commentContentCannotEmptyLabel}",
        "captchaCannotEmptyLabel": "${captchaCannotEmptyLabel}",
        "captchaErrorLabel": "${captchaErrorLabel}",
        "loadingLabel": "${loadingLabel}",
        "oId": "${oId}",
        "skinDirName": "${skinDirName}",
        "blogHost": "${blogHost}",
        "randomArticles1Label": "${randomArticlesLabel}",
        "externalRelevantArticles1Label": "${externalRelevantArticlesLabel}"
    });

    var addComment = function (result, state) {
        var html = new Array();
        html.push('<div class="media bs-docs-example-child" id="'+result.oId+'">');
        html.push('<a class="pull-left" href="#" target="_blank">');
        html.push('<img class="media-object img-polaroid" data-src="holder.js/64x64" style="width: 64px; height: 64px;" src="'+result.commentThumbnailURL+'">');
        html.push('</a>');
        html.push('<div class="media-body" id="'+result.oId+'">');
        html.push('<h4 class="media-heading">');
        html.push(result.replyNameHTML);
        if (state !== "") {
            var commentOriginalCommentName = $("#" + page.currentCommentId + " .media-heading a").first().text();
            html.push('&nbsp;<i class="icon-share-alt"></i>');
            html.push('&nbsp;<a href="${servePath}' + result.commentSharpURL.split("#")[0] + '#' + page.currentCommentId + '"'
                + 'onmouseover="page.showComment(this, \'' + page.currentCommentId + '\', 20);"'
                + 'onmouseout="page.hideComment(\'' + page.currentCommentId + '\')">'+commentOriginalCommentName+'</a>');
        }
        html.push('<span class="pull-right" style="font-size: 12px;font-weight: normal;color: #676767;">');
        html.push('<i class="icon-time"></i> '+ result.commentDate.substring(0, 19));
        html.push('&nbsp;<i class="icon-comment"></i>&nbsp;');
        html.push('<a rel="nofollow" href="javascript:replyTo(\''+result.oId+'\');">${replyLabel}</a>');
        html.push('</span>');
        html.push('</h4>');
        html.push(Util.replaceEmString($("#comment" + state).val().replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g,"<br/>")));
        return html.join('');
    }

    var replyTo = function (id) {
        var commentFormHTML = "<form class='well form-horizontal' id='replyForm'>";
        page.addReplyForm(id, commentFormHTML,'</form>');
    };

    (function () {
        page.load();
        // emotions
        page.replaceCommentsEm("#comments .article-body");
            <#nested>
        })();
</script>
</#macro>