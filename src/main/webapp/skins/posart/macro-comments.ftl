<#macro comments commentList article>
<div id="comments">
    <#list commentList as comment>
    <div  class="article cl" id="${comment.oId}">	     
        <div style="float:left;margin:5px;">
            <img class="comment-header" title="${comment.commentName}"
                 alt="${comment.commentName}" src="${comment.commentThumbnailURL}"/>
        </div>
        <div class='entry-content'>	
            ${comment.commentContent}
            <#if comment.isReply>@
            <a href="${servePath}${article.permalink}#${comment.commentOriginalCommentId}"
               onmouseover="page.showComment(this, '${comment.commentOriginalCommentId}', 25);"
               onmouseout="page.hideComment('${comment.commentOriginalCommentId}')">${comment.commentOriginalCommentName}</a>
            </#if>

        </div>
        <p class="entry-meta" style="margin:0 80px;">
            <a>${comment.commentName}</a>&nbsp;&nbsp;&nbsp;  	
            ${comment.commentDate?string("yy-MM-dd HH:mm")}  
            <#if article.commentable>
            <a class="y" href="javascript:replyTo('${comment.oId}');">${replyLabel}</a>
            </#if>
        </p>	
    </div>	
    </#list>
</div>
<#if article.commentable>
<div class="comments" >
    <div class="comments-area">
        <table id="commentForm">
            <tbody>
                <#if !isLoggedIn>
                <tr>
                    <td colspan="2">
                        <input type="text" class="normalInput" id="commentName"/>
                        <label for="commentName">${commentNameLabel}</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="text" class="normalInput" id="commentEmail"/>
                        <label for="commentEmail">${commentEmailLabel}</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="text" id="commentURL"/>
                        <label for="commentURL">${commentURLLabel}</label>
                    </td>
                </tr>
                </#if>
                <tr>
                    <td id="emotions" colspan="2">
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
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <p class="comment-form-comment">
                            <textarea rows="4" cols="96" id="comment"></textarea>
                        </p>
                    </td>
                </tr>
                <#if !isLoggedIn>
                <tr>
                    <td colspan="2">
                        <input type="text" class="normalInput" id="commentValidate"/>
                        <img id="captcha" alt="validate" src="${servePath}/captcha.do" />
                    </td>
                </tr>
                </#if>
                <tr>               
                    <td >
                        <p class="form-submit">
                            <input name="submit" type="submit" id="submitCommentButton" onclick="page.submitComment();" value="${submmitCommentLabel}" />                   
                        </p>
                    </td>
                    <td>
                        <span class="ft-gray" id="commentErrorTip"></span>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>	
</div>
<#if externalRelevantArticlesDisplayCount?? && 0 != externalRelevantArticlesDisplayCount>
<div id="externalRelevantArticles" class="article-relative"></div>
</#if>
<span class="clear"></span>
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

                                var addComment = function(result, state) {

                                    var commentHTML = '<div  class="article cl" id="' + result.oId + '">'
                                            + '<div style="float:left;margin:5px;">'
                                            + '<img class="comment-header" title="' + result.userName + '"'
                                            + 'alt="' + result.userName + '" src="' + result.commentThumbnailURL + '"/>'
                                            + '</div>'
                                            + ' <div class="entry-content">'
                                            + Util.replaceEmString($("#comment" + state).val().replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br/>"));
                                    if (state !== "") {
                                        var commentOriginalCommentName = $("#" + page.currentCommentId
                                                + " .entry-meta a").first().text();
                                        commentHTML += '&nbsp;@&nbsp;<a href="${servePath}'
                                                + result.commentSharpURL.split("#")[0] + '#' + page.currentCommentId + '"'
                                                + 'onmouseover="page.showComment(this, \'' + page.currentCommentId + '\', 25);"'
                                                + 'onmouseout="page.hideComment(\'' + page.currentCommentId + '\')">'
                                                + commentOriginalCommentName + '</a>';
                                    }
                                    commentHTML += '</div> <p class="entry-meta" style="margin:0 80px;"><a>'
                                            + result.userName + '</a>&nbsp;&nbsp;&nbsp;'
                                            + result.commentDate.substring(2, 16)
                                            + '<a class="y" href="javascript:replyTo(\'' + result.oId + '\');">${replyLabel}</a>'
                                            + '</p></div>';

                                    return commentHTML;
                                };

                                var replyTo = function(id) {
                                    var commentFormHTML = "<table class='form' id='replyForm'>";
                                    page.addReplyForm(id, commentFormHTML);
                                    $("#replyForm label").each(function() {
                                        $this = $(this);
                                        $this.attr("for", $this.attr("for") + "Reply");
                                    });
                                };

                                $(document).ready(function() {
                                    page.load();
                                    // emotions
                                    page.replaceCommentsEm("#comments .entry-content");
                                    <#nested>
                                });
</script>
</#macro>