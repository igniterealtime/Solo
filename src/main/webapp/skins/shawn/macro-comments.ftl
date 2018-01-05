<#macro comments commentList article>
<div id="ajax_comments_wrapper">
    <div class="comstyle">
        ${commentList?size}&nbsp;Comments<span>&nbsp;Contributed by Visitors</span>
    </div>
    <div id="comments">
        <div>
            <ol class="commentlist">
                <#list commentList as comment>
                <li id="${comment.oId}">
                    <cite>
                        <img data-id="${comment.oId}" onclick="replyTo('${comment.oId}')" 
                             class="atreply" 
                             title="${ClickToReply} ${comment.commentName}" 
                             src="${staticServePath}/skins/${skinDirName}/images/reply.png" 
                             alt="rebutton"
                             width="20"
                             height="16"
                             style="display: none;" />
                        <#if "http://" == comment.commentURL>
                        ${comment.commentName}
                        <#else>
                        <a class="url" rel="external nofollow" href="${comment.commentURL}">${comment.commentName}</a>
                        </#if> / 
                        <small>${comment.commentDate?string("HH:mm:ss")}&nbsp;@&nbsp;${comment.commentDate?string("yyyy-MM-dd")}</small>
                    </cite>
                    <span class="cmntcnt ${comment.commentName}">
                        <a href="#${comment.oId}">${commentList?size - comment_index}#</a>
                    </span>
                    <div class="lovatar">
                        <img src="${comment.commentThumbnailURL}" alt="leehow" class="gravatar" width="48" height="48" />
                    </div>
                    <div class="list">
                        <p>
                            <#if comment.isReply>
                            <a class="replybox" href="#${comment.commentOriginalCommentId}">
                                @${comment.commentOriginalCommentName}</a>
                            <br>
                            </#if>
                            ${comment.commentContent}
                        </p>
                    </div>
                </li>
                </#list>
            </ol>
        </div>
    </div>
	<#if article.commentable>
    <div id="respond" class="comstyle">Leave <span>Comments</span> Here...</div>
    <div id="commentForm" class="reply">
        <div class="friendly">
            <p>
                <label>
                    ${commentNameLabel}
                </label>
                <input type="text" id="commentName" class="text" size="22" tabindex="1" />
                <span class="tips">${Required}</span>
            </p>
            <p>
                <label>
                    ${commentEmailLabel}
                </label>
                <input type="text" id="commentEmail" class="text" size="22" tabindex="1" />
                <span class="tips">${Required}&amp;${Secrecy}</span>
            </p>
            <p>
                <label>
                    ${commentURLLabel}
                </label>
                <input type="text" id="commentURL" class="text" size="22" tabindex="1" />
                <span class="tips">${WithYou}</span>
            </p>
            <p id="checkarea">
                    <label>
                        Code  
                    </label>
                    <input type="text" id="commentValidate" class="text" />
                    <span class="tips" style="background: none;border: none;">
                    <img id="captcha" alt="validate" src="${staticServePath}/captcha.do" />
                    </span>
            </p>
        </div>
        <p>
            <textarea rows="10" id="comment"  name="comment" cols="100%" tabindex="4" onkeyup="javascript:return ctrlEnter(event);"></textarea>
            <span class="tips" style="white-space: nowrap; top: 93px; left: 506px;">${QuickSubmission}</span>
        </p>
        <p>
            <button id="submitCommentButton" onclick="page.submitComment();" 
                    style="border-radius: 7px; margin-top: 12px;">
                ${submmitCommentLabel}
            </button>
            <span id="commentErrorTip"></span>
        </p>
    </div>
	<#else>
	    <div id="respond" class="comstyle">The <span>Comments</span> Closed...</div>
	</#if>
    <ul class="endnotes">
        <li>${Endnotes1}</li>
        <li>${Endnotes2}</li>
		<li>${Endnotes3}</li>
        <li>${Endnotes4}<code style="padding:2px 5px">&lt; = &amp;lt;</code>,<code style="padding:2px 5px">&gt; = &amp;gt;</code> .</li>
        <li>${Endnotes5}</li>
        <li>${Endnotes6} <img src="${staticServePath}/skins/${skinDirName}/images/reply.png" width="20" height="16" alt="Reply" style="vertical-align:middle"> ${Endnotes7} <code style="padding:2px 5px">${Endnotes8}</code>.</li>
        <li>${Endnotes9}</li>
    </ul>
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
        "captchaErrorLabel": "${captchaErrorLabel}",
        "loadingLabel": "${loadingLabel}",
        "oId": "${oId}",
        "skinDirName": "${skinDirName}",
        "blogHost": "${blogHost}",
        "randomArticles1Label": "${randomArticles1Label}",
        "externalRelevantArticles1Label": "${externalRelevantArticles1Label}"
    });

    var addComment = function (result, state) {
        var name = result.replyNameHTML;
        if ($("#commentURL" + state).val().replace(/\s/g, "") === "") {
            name = $("#commentName" + state).val();
        }
        var commentHTML =  '<ol class="commentlist">'
            + '<li class="alt altline">'
            + '<cite>' + name +
            '&nbsp;/&nbsp;<small>' + result.commentDate.substr(11, 8) + '&nbsp;@&nbsp;' + result.commentDate.substring(0, 10) + '</small></cite>'
            + '<div class="lovatar">'
            + '<img src="' + result.commentThumbnailURL
            + '" alt="leehow" class="gravatar" width="48" height="48">'
            + '</div>'
            + '<div class="list">'
            + '<p>'
            + Util.replaceEmString($("#comment" + state).val().replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g,"<br/>"))
            + '</p>'
            + '</div></li></ol>';
        return commentHTML;
    }

    var replyTo = function (id) {
        var commentFormHTML = "<div class='reply' id='replyForm'>";
        page.addReplyForm(id, commentFormHTML, "</div>");
        
        $("#replyForm span").fadeOut("fast");
        $("#commentErrorTipReply").fadeIn("fast");
        $("#replyForm input,#replyForm textarea").focus(function() {
            $(this).next("span").fadeIn("fast")
        }),
        $("#replyForm input,#replyForm textarea").blur(function() {
            $(this).next("span").fadeOut("fast")
        });
    };
    
    (function () {
        page.load();
            <#nested>
        })();
</script>
</#macro>