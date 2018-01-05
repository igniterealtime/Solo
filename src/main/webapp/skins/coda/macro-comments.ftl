<#macro comments commentList article>
<section class="left ver_side maincolum">
    <h3 id="commentcount" class="hor_side">${Comments}
        <div class="comstyle">
            <span>${commentList?size}</span>&nbsp;Comments&nbsp;Contributed by Visitors
        </div>
    </h3>

    <ol id="comments" class="clear">
        <#list commentList as comment>
        <li class="comment hor_side" id="${comment.oId}">
            <div class="clear">
                <div class="comment-meta post_time icon">
                    ${comment.commentDate?string("yyyy-MM-dd")}<br>${comment.commentDate?string("HH:mm:ss")}
                </div>
                <div class="comment-author vcard">
                    <cite class="fn">
                        <#if "http://" == comment.commentURL>
                        ${comment.commentName}
                        <#else>
                        <a class="url" rel="external nofollow" href="${comment.commentURL}">${comment.commentName}</a>
                        </#if>
                    </cite>
                    <span class="says">&nbsp;${Said}</span></div>
                <div class="avatar right">
                    <img title="" alt="" src="${comment.commentThumbnailURL}" 
                         class="avatar avatar-30 photo" height="30" width="30" />
                </div>
                <div class="reply right">
                    <span class="cmntcnt ${comment.commentName}">
                        <a href="#${comment.oId}">${commentList?size - comment_index}#</a>
                    </span>&nbsp;|&nbsp;
                    <a class="replyto" rel="nofollow" href="javascript:replyTo('${comment.oId}');" title="${replyLabel}">${replyLabel}</a>
                </div>
                <div class="comment-content">
                    <p>
                        <#if comment.isReply>
                        <a class="atreply" rel="nofollow" href="#${comment.commentOriginalCommentId}"
                           onmouseover="page.showComment(this, '${comment.commentOriginalCommentId}', 23);"
                           onmouseout="page.hideComment('${comment.commentOriginalCommentId}')">
                            @${comment.commentOriginalCommentName}</a>
                        <br>
                        </#if>
                        ${comment.commentContent}
                    </p>
                </div>
            </div>
        </li>
        </#list>
    </ol>
	<#if article.commentable>
    <div id="commentForm">
        <fieldset> 
            <label for="commentName">${commentNameLabel}&nbsp;*</label> 
            <input id="commentName"
                   size="22"
                   type="text"
                   placeholder="Your Name Here"> 
            <label for="commentEmail">${commentEmailLabel}&nbsp;*</label> 
            <input id="commentEmail" 
                   size="22"
                   placeholder="Your Email Here (Keep Secret)"> 
            <label for="commentURL">${commentURLLabel}</label> 
            <input id="commentURL" 
                   size="22"
                   placeholder="Your Website Here (Not required)"> 
            <label for="commentValidate">Code&nbsp;*</label>
            <input type="text" 
                   id="commentValidate" 
                   class="text"
                   placeholder="Please enter the verification code"/>
            <img id="captcha" class="code" alt="validate" src="${staticServePath}/captcha.do" />
        </fieldset>
		<fieldset>
        <div id="emotions">
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
        </div>
		</fieldset>
        <fieldset>
            <label for="comment">${commentContent1Label}*</label> 
            <textarea id="comment" rows="10" cols="30" placeholder="What Do You Want To Say?" 
                      style="resize: none; overflow-y: hidden; "></textarea>
        </fieldset>
        <fieldset> 
            <p>
                <input name="submit" class="button"
                       type="submit"
                       id="submitCommentButton" 
                       tabindex="5" 
                       value="Submit Comment"
                       onclick="page.submitComment();">
            </p>
            <span class="error-msg" id="commentErrorTip"></span>
        </fieldset>
    </div>
	</#if>
</section>
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
        "randomArticles1Label": "${randomArticles1Label}",
        "externalRelevantArticles1Label": "${externalRelevantArticles1Label}"
    });

    var addComment = function (result, state) {              
        var date = result.commentDate.split(" ");
            
        var commentHTML =  '<li class="comment hor_side" id="' + result.oId + '">'
            + '<div class="clear"><div class="comment-meta post_time icon">'
            + date[0] + "</br>" + date[1]
            + '</div><div class="comment-author vcard"><cite class="fn">' + result.replyNameHTML;
        
        commentHTML += '</cite><span class="says">&nbsp;说道：</span></div><div class="avatar right">'
            + '<img src="' + result.commentThumbnailURL + '" class="avatar avatar-30 photo" height="30" width="30" />'
            + '</div><div class="reply right"><span class="cmntcnt">'
            + '<a href="' + result.commentSharpURL.split("#")[0] + '#' + page.currentCommentId + '">' 
            + ($("#comments li").length + 1) + '#</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;'
            + '<a class="replyto" rel="nofollow" href="javascript:replyTo(\'' + result.oId + '\');" title="${replyLabel}">${replyLabel}</a>'
            + '</div><div class="comment-content"><p>'
            
        if (state !== "") {
            var commentOriginalCommentName = $("#" + page.currentCommentId + " cite.fn").text();
            commentHTML += '<a class="atreply" rel="nofollow" href="' + result.commentSharpURL.split("#")[0] + '#' + page.currentCommentId + '"'
                + 'onmouseover="page.showComment(this, \'' + page.currentCommentId + '\', 23);"'
                + 'onmouseout="page.hideComment(\'' + page.currentCommentId + '\')">@' + commentOriginalCommentName + '</a><br/>';
        }
        
        commentHTML += Util.replaceEmString($("#comment" + state).val().replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g,"<br/>"))
            + '</p></div></div></li>';
        
        
        $("#commentcount span").text($("#comments li").length + 1);
        
        return commentHTML;
    }

    var replyTo = function (id) {
        var commentFormHTML = "<div class='reply' id='replyForm'>";
        page.addReplyForm(id, commentFormHTML, "</div>");
    };
    
    (function () {
        page.load();
        page.replaceCommentsEm("#comments .comment-content");
            <#nested>
        })();
</script>
</#macro>