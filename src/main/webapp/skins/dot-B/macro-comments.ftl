<#macro comments commentList article>
<div>
    <!-- You can start editing here -->
    <h2 id="comments-title"><span>{ <a href="#respond"  rel="nofollow" title="Leave a Reply ?">Leave a Reply ?</a> }</span></h2>
    <ol class="commentlist" id="comments">
        <#list commentList as comment>
        <li id="${comment.oId}">
            <div class="by-vistor">
                <div class="comment-author vcard">
                    <img alt="${comment.commentName}" src="${comment.commentThumbnailURL}" class="avatar avatar-40 photo" height="40" width="40">
                    <cite class="fn">
                        <#if "http://" == comment.commentURL>
                        ${comment.commentName}
                        <#else>
                        <a href="${comment.commentURL}" rel="external nofollow" class="url">${comment.commentName}</a>
                        </#if> 
                    </cite>			
                    <span class="comment-meta commentmetadata">
                        ${comment.commentDate?string("yyyy-MM-dd HH:mm:ss")}
                        <a href="#${comment.oId}"> # </a>
                    </span><!-- .comment-meta .commentmetadata -->
                </div>
                <div class="comment-content">
                    <p>
                     <#if comment.isReply>
                            @  <a href="${article.permalink}#${comment.commentOriginalCommentId}"
                                  onmouseover="page.showComment(this, '${comment.commentOriginalCommentId}', 35, 'li');"
                                  onmouseout="page.hideComment('${comment.commentOriginalCommentId}')">${comment.commentOriginalCommentName}</a><br>
                    </#if>
                        ${comment.commentContent}
                    </p>
                </div>
                <#if article.commentable>
                <div class="reply">
                    <a class="comment-reply-link"
                       href="javascript:replyTo('${comment.oId}');">${replyLabel}</a>
                </div>
                </#if>
            </div>
        </li>
        </#list>
    </ol>
    <#if article.commentable>
    <div id="respond">
        <h3 id="reply-title">Leave a Reply</h3>
        <p class="comment-notes">Your email address will not be published.</p>
        <div id="commentForm">
            <p class="comment-form-author">
                <label>Name</label> <input id="commentName" name="author" type="text" value="" size="30"></p>
            <p class="comment-form-email">
                <label>Email</label> <input id="commentEmail" name="email" type="text" value="" size="30"></p>
            <p class="comment-form-url">
                <label>Website</label><input id="commentURL" name="url" type="text" value="" size="30"></p>
            <p class="comment-form-code">
                <label><img id="captcha" alt="validate" src="/captcha.do" /></label>
                <input id="commentValidate" name="code" type="text" value="" size="30">
            </p>
            <p class="comment-form-comment">
                <label>Comment</label><textarea id="comment" name="comment" cols="45" rows="8" aria-required="true"></textarea></p>
            <p class="form-submit">
                <button type="submit" id="submitCommentButton" onclick="page.submitComment();">Post Comment</button>
                <span class="error-msg" id="commentErrorTip"></span>
            </p>
            <p id="emotions">
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
            </p>
        </div>
    </div>
    <#else>
    <div class="comstyle">The Comments <span>Closed!</span></div>
    </#if>
</div>
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
        "loadingLabel": "${loadingLabel}",
        "oId": "${oId}",
        "skinDirName": "${skinDirName}",
        "blogHost": "${blogHost}",
        "randomArticles1Label": "${randomArticlesLabel}",
        "externalRelevantArticles1Label": "${externalRelevantArticlesLabel}"
    });

    var addComment = function (result, state) {
        var commentHTML = '<li id="' + result.oId + 
            '"><div class="by-vistor"><div class="comment-author vcard">' +
            '<img alt="' + $("#commentName" + state).val() + 
            '" src="' + result.commentThumbnailURL + '" class="avatar avatar-40 photo" height="40" width="40">' + 
            '<cite class="fn">' + result.replyNameHTML + '</cite>' +			
            '<span class="comment-meta commentmetadata">' +  result.commentDate + 
            '<a href="#' + result.oId + '"> # </a>';

        if (state !== "") {
            var commentOriginalCommentName = $("#" + page.currentCommentId).find(".fn").text();
            commentHTML += '&nbsp;@&nbsp;<a href="' + result.commentSharpURL.split("#")[0] + '#' + page.currentCommentId + '"'
                + 'onmouseover="page.showComment(this, \'' + page.currentCommentId + '\', 35, \'li\');"'
                + 'onmouseout="page.hideComment(\'' + page.currentCommentId + '\')">' + commentOriginalCommentName + '</a>';
        }
        
        commentHTML += '</span></div><div class="comment-content"><p>' +
            Util.replaceEmString($("#comment" + state).val().replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g,"<br/>")) +
            '</p></div>';
            commentHTML += '</div></li>';
        return commentHTML;
    }

    var replyTo = function (id) {
        var commentFormHTML = "<div id='replyForm'>";
        page.addReplyForm(id, commentFormHTML, "</div>");
    };

    (function () {
        page.load();
        // emotions
        page.replaceCommentsEm("#comments .comment-content");
            <#nested>
        })();
</script>
</#macro>