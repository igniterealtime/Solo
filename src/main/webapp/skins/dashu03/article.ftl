<#include "macro-head.ftl">
<#include "macro-comments.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${article.articleTitle} - ${blogTitle}">
        <meta name="keywords" content="${article.articleTags}" />
        <meta name="description" content="${article.articleAbstract?html}" />
        </@head>
    </head>
    <body>
    	
        <#include "header.ftl">
        
        <div class="container " style="margin-top: 100px;padding-left: 30px;">
            <div class="row">
                <div class="span9">
                    <div class="article-title">
                        <h2>
                            <a class="ft-gray" href="${servePath}${article.articlePermalink}">
                                ${article.articleTitle}
                            </a>
                            <#if article.hasUpdated>
                            <sup>
                                ${updatedLabel}
                            </sup>
                            </#if>
                            <#if article.articlePutTop>
                            <sup>
                                ${topArticleLabel}
                            </sup>
                            </#if>
                        </h2>
						<!-- JiaThis Button BEGIN -->
						<div class="jiathis_style" style="height: 16px;margin: 13px 0;">
						<a class="jiathis_button_qzone"></a>
						<a class="jiathis_button_tsina"></a>
						<a class="jiathis_button_tqq"></a>
						<a class="jiathis_button_renren"></a>
						<a class="jiathis_button_kaixin001"></a>
						<a class="jiathis_button_diandian"></a>
						<a class="jiathis_button_twitter"></a>
						<a class="jiathis_button_ydnote"></a>
						<a class="jiathis_button_meilishuo"></a>
						<a class="jiathis_button_qingbiji"></a>
						<a class="jiathis_button_taobao"></a>
						<a class="jiathis_button_fb"></a>
						<a class="jiathis_button_miliao"></a>
						<a class="jiathis_button_mop"></a>
						<a class="jiathis_button_mogujie"></a>
						<a class="jiathis_button_sdonote"></a>
						<a class="jiathis_button_copy"></a>
						<a class="jiathis_button_fav"></a>
						<a class="jiathis_button_print"></a>
						<a href="http://www.jiathis.com/share?uid=1665959" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"></a>
						<a class="jiathis_counter_style"></a>
						</div>
						<!-- JiaThis Button END -->
						<div class="clearfix"></div>
                        <div class="clearfix" style="margin: 6px 0px;">
                        	<span class="pull-right">
                            <a rel="nofollow" class="ft-gray" href="${servePath}${article.articlePermalink}#comments">
                                ${article.articleCommentCount}&nbsp;&nbsp;${commentLabel}
                            </a>&nbsp;&nbsp;
                            <a rel="nofollow" class="ft-gray" href="${servePath}${article.articlePermalink}">
                                ${article.articleViewCount}&nbsp;&nbsp;${viewLabel}
                            </a>
                            </span>
                            <span class="pull-left">
	                        <a rel="nofollow" href="${servePath}/authors/${article.authorId}">${article.authorName}</a>
	                        <#if article.hasUpdated>
	                        ${article.articleUpdateDate?string("yyyy-MM-dd HH:mm")}
	                        <#else>
	                        ${article.articleCreateDate?string("yyyy-MM-dd HH:mm")}
	                        </#if>
	                        </span>
                        </div>
                    </div>
                    <hr />
                    <div class="clearfix" style="margin-top: 5px;">
                        ${article.articleContent}
                        <#if "" != article.articleSign.signHTML?trim>
                        <p>
                            ${article.articleSign.signHTML}
                        </p>
                        </#if>
                    </div>
                    
                    <!-- JiaThis Button BEGIN -->
					<div class="jiathis_style_32x32" style="height: 10px; margin: 10px 0;">
					<a class="jiathis_button_qzone"></a>
					<a class="jiathis_button_tsina"></a>
					<a class="jiathis_button_tqq"></a>
					<a class="jiathis_button_renren"></a>
					<a class="jiathis_button_fb"></a>
					<a class="jiathis_button_ydnote"></a>
					<a class="jiathis_button_diandian"></a>
					<a class="jiathis_button_douban"></a>
					<a class="jiathis_button_googleplus"></a>
					<a class="jiathis_button_fav"></a>
					<a class="jiathis_button_print"></a>
					<a href="http://www.jiathis.com/share?uid=1665959" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"></a>
					<a class="jiathis_counter_style"></a>
					</div>
					<!-- JiaThis Button END -->
				    <div class="clearfix" style="margin-bottom: 10px;"></div>
                    
                    <div class="">
                        <#if 0 != relevantArticlesDisplayCount>
                        <div id="relevantArticles" class="span4"></div>
                        </#if>
                        <#if 0 != randomArticlesDisplayCount>
                        <div id="randomArticles" class="span4"></div>
                        </#if>
                        <div class="clear"></div>
                    </div>
                    
                    <div class="" style="margin: 5px 0 5px 0">
                        ${tag1Label}
                        <#list article.articleTags?split(",") as articleTag>
                        <a rel="tag" href="${servePath}/tags/${articleTag?url('UTF-8')}">${articleTag}</a><#if articleTag_has_next>,</#if>
                        </#list>
                    </div>
                    
                    <div class="clearfix" style="margin: 5px 0 20px 0">
	                    <#if nextArticlePermalink??>
	                    <div class="pull-left">
	                        <span class="ft-gray">&lt;</span>
	                        <a href="${servePath}${nextArticlePermalink}">${nextArticleTitle}</a>
	                    </div>
	                    </#if>                            
	                    <#if previousArticlePermalink??>
	                    <div class="pull-right">
	                        <a href="${servePath}${previousArticlePermalink}">${previousArticleTitle}</a> 
	                        <span class="ft-gray">&gt;</span>
	                    </div>
	                    </#if>
                    </div>
                    <hr />
                    
					<@comments commentList=articleComments article=article></@comments>
					
                </div>
                
                <#include "usedside.ftl">
                
            </div>
        </div>
        <#include "footer.ftl">
        <@comment_script oId=article.oId>
        page.tips.externalRelevantArticlesDisplayCount = "${externalRelevantArticlesDisplayCount}";
        <#if 0 != randomArticlesDisplayCount>
        page.loadRandomArticles('<h4 class="ft-gray">${randomArticlesLabel}</h4>');
        </#if>
        <#if 0 != relevantArticlesDisplayCount>
        page.loadRelevantArticles('${article.oId}', '<h4 class="ft-gray">${relevantArticlesLabel}</h4>');
        </#if>
        </@comment_script>
		<script type="text/javascript" >
		var jiathis_config={
			data_track_clickback:true,
			summary:"",
			hideMore:false
		}
		</script>
		<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=1665959" charset="utf-8"></script>
		</script>
    </body>
</html>
