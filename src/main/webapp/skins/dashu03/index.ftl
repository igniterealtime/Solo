<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
	<head>
		<@head title="${blogTitle}">
		<meta name="keywords" content="${metaKeywords}"/>
		<meta name="description" content="<#list articles as article>${article.articleTitle}<#if article_has_next>,</#if></#list>"/>
		</@head>
	</head>
	<body>
		
		<#include "header.ftl">

		<div id="myCarousel" class="carousel slide">
			<div class="carousel-inner">

<#list articles as article>
	<#if article_index == 0>
	
		            <div class="item active">
						<img src="${staticServePath}/skins/${skinDirName}/images/slide-01.jpg" alt="">
						<div class="container">
							<div class="carousel-caption">
								<h1>${article.articleTitle}</h1>
								<p class="lead">
									${article.articleAbstract}
								</p>
								<a class="btn btn-large btn-primary" href="${servePath}${article.articlePermalink}">Read more</a>
							</div>
						</div>
					</div>
					
	<#elseif article_index == 1>
	
		       		<div class="item">
						<img src="${staticServePath}/skins/${skinDirName}/images/slide-02.jpg" alt="">
						<div class="container">
							<div class="carousel-caption">
								<h1>${article.articleTitle}</h1>
								<p class="lead">
									${article.articleAbstract}
								</p>
								<a class="btn btn-large btn-primary" href="${servePath}${article.articlePermalink}">Read more</a>
							</div>
						</div>
					</div>
					
	<#elseif article_index == 2>
	
		       		<div class="item">
						<img src="${staticServePath}/skins/${skinDirName}/images/slide-03.jpg" alt="">
						<div class="container">
							<div class="carousel-caption">
								<h1>${article.articleTitle}</h1>
								<p class="lead">
									${article.articleAbstract}
								</p>
								<a class="btn btn-large btn-primary" href="${servePath}${article.articlePermalink}">Read more</a>
							</div>
						</div>
					</div>
			</div>
		</div>
		<a class="left carousel-control" href="${staticServePath}#myCarousel" data-slide="prev">‹</a>
		<a class="right carousel-control" href="${staticServePath}#myCarousel" data-slide="next">›</a>
		</div><!-- /.carousel -->
		
		<div class="container">
			<div class="row">
				
				<div class="span4">
					<h4>${recentArticlesLabel}&nbsp;<i class="icon-time"></i></h4>
					<ul  class="unstyled">
	<#else>
						<li>
							<p><a href="${servePath}${article.articlePermalink}" class="tooltipLink" data-original-title='${article.articleAbstract}'>${article.articleTitle}</a></p>
							<span style="display: none;">${article.articleAbstract}</span>
						</li>
	</#if>
</#list>
					</ul>
				</div>
				
				<div class="span4">
					<h4>${mostViewCountArticlesLabel}&nbsp;<i class="icon-folder-close"></i></h4>
					<ul  class="unstyled">
						<#list mostViewCountArticles as article>
			            <li>
			                <p><a href="${servePath}${article.articlePermalink}" class="tooltipLink" data-original-title='${article.articleAbstract}'>${article.articleTitle}</a></p>
			                <span style="display: none;">${article.articleAbstract}</span>
			            </li>
			            </#list>
					</ul>
				</div>
				
				<div class="span4">
					<h4>${mostCommentArticlesLabel}&nbsp;<i class="icon-comment"></i></h4>
					<ul  class="unstyled">
						<#list mostCommentArticles as article>
			            <li>
			                <p><a href="${servePath}${article.articlePermalink}" class="tooltipLink" data-original-title='${article.articleAbstract}'>${article.articleTitle}</a></p>
			                <span style="display: none;">${article.articleAbstract}</span>
			            </li>
			            </#list>
					</ul>
				</div>
				
			</div>
		</div>
		
		<#include "footer.ftl">
</body>
</html>
