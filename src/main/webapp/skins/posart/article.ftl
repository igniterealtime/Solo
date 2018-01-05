<#include "macro-head.ftl">
<#include "macro-comments.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${article.articleTitle} - ${blogTitle}">
        <meta name="keywords" content="${article.articleTags}" />
        <meta name="description" content="${article.articleAbstract?html}" />
        </@head>
		<script src="${staticServePath}/skins/${skinDirName}/js/syntaxhighlighter/scripts/shCore.js"></script>
		<script src="${staticServePath}/skins/${skinDirName}/js/syntaxhighlighter/scripts/shBrushJScript.js"></script>
		<script src="${staticServePath}/skins/${skinDirName}/js/syntaxhighlighter/scripts/shBrushJava.js"></script>
		<script src="${staticServePath}/skins/${skinDirName}/js/syntaxhighlighter/scripts/shBrushJScript.js"></script>
		<script src="${staticServePath}/skins/${skinDirName}/js/syntaxhighlighter/scripts/shBrushXml.js"></script>
		<link type="text/css" rel="stylesheet" href="${staticServePath}/skins/${skinDirName}/js/syntaxhighlighter/styles/shCoreDefault.css" charset="utf-8" />
	<script type="text/javascript">SyntaxHighlighter.all();</script>
    </head>
    <body>
        ${topBarReplacement}
        <#include "header.ftl">
		<div id="wrapper">
		<a href="${servePath}" class="header mhidden"><img src="${staticServePath}/skins/${skinDirName}/images/ghead.png"></a>
			<div id="container" class="cl">		
				<div class="body">				
					<ul class="breadcrumb">
						<li><a href="${servePath}">首页</a> <span class="divider">/</span></li>
						<li style="color:#333333">
						${article.articleTitle}</li>
						<li class='y'>
							 ${tag1Label}
							<#list article.articleTags?split(",") as articleTag>
							<a rel="tag" href="${servePath}/tags/${articleTag?url('UTF-8')}">${articleTag}</a><#if articleTag_has_next>,</#if>
							</#list>
						</li>
						
					</ul>
					<div class="content">
					 <div  class="post-7 post type-post status-publish format-standard hentry category-uncategorized" style="position: relative; z-index: 1;">
						<header class="entry-header">
							<h2 class="entry-title">${article.articleTitle}</h2>
							 <!--<#if article.hasUpdated>
                            <sup>
                                ${updatedLabel}
                            </sup>
                            </#if>
                            <#if article.articlePutTop>
                            <sup>
                                ${topArticleLabel}
                            </sup>
                            </#if>-->
							
						</header>
							<div class="entry-content">	
								<div class="article-body">							
								 ${article.articleContent}
								<#if "" != article.articleSign.signHTML?trim>
								<p>
									${article.articleSign.signHTML}
								</p>
								</#if>		
									</div>							
							</div>
											</div>
								<footer style="width:100%">
								<p class="entry-meta" >
									<#if article.hasUpdated>
											${article.articleUpdateDate?string("yy-MM-dd HH:mm")}
										<#else>
											${article.articleCreateDate?string("yy-MM-dd HH:mm")}
										</#if>&nbsp;&nbsp;&nbsp;
										<a rel="nofollow" href="${servePath}/authors/${article.authorId}">${article.authorName}</a>
										&nbsp;&nbsp;&nbsp;
									<a  href="${servePath}${article.articlePermalink}#comments">
									${article.articleCommentCount}&nbsp;&nbsp;${commentLabel}
									</a> &nbsp;&nbsp;&nbsp;
									<a href="${servePath}${article.articlePermalink}">
									${article.articleViewCount}&nbsp;&nbsp;${viewLabel}
									</a>							
								</p>					 
						</footer>						
				</div>				  
				<ul class="breadcrumb">
					<li class='active' > 
						<#if nextArticlePermalink??>
						<a href="${servePath}${nextArticlePermalink}"><span class="ft-gray">&lt;</span>${nextArticleTitle}</a>                
						</#if>
					</li>   					
                   <li class='y active'> 
				   <#if previousArticlePermalink??>                  
                        <a href="${servePath}${previousArticlePermalink}">${previousArticleTitle} <span class="ft-gray">&gt;</span></a>                                         
                    </#if>
					 </li> 
				</ul>							         
				 <@comments commentList=articleComments article=article></@comments> 				
       
			</div>
			</div>			
	 <#include "footer.ftl">
	</div>       
        <@comment_script oId=article.oId>
        page.tips.externalRelevantArticlesDisplayCount = "${externalRelevantArticlesDisplayCount}";
        <#if 0 != randomArticlesDisplayCount>
        page.loadRandomArticles('<h4 class="ft-gray">${randomArticlesLabel}</h4>');
        </#if>
        <#if 0 != relevantArticlesDisplayCount>
        page.loadRelevantArticles('${article.oId}', '<h4 class="ft-gray">${relevantArticlesLabel}</h4>');
        </#if>
        <#if 0 != externalRelevantArticlesDisplayCount>
        page.loadExternalRelevantArticles("<#list article.articleTags?split(",") as articleTag>${articleTag}<#if articleTag_has_next>,</#if></#list>");
        </#if>
        </@comment_script>  
    </body>
</html>
