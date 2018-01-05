var bootstyle = {
    getCurrentPage: function () {
        var $next = $(".pagination-btn");
        if ($next.length > 0) {
            window.currentPage = $next.data("page");
        }
    },
    setNavCurrent: function () {
        $(".nav li a").each(function () {
            var $this = $(this);
            var path1 = latkeConfig.servePath + location.pathname,
                path2 = latkeConfig.servePath + location.pathname.substr(0, location.pathname.length - 1);
            if ($this.attr("href") === path1 || $this.attr("href") === path2) {
                $this.parent().addClass("active");
            } else if (/\/[0-9]+$/.test(location.pathname)) {
                $(".nav li")[0].className = "current";
            }
        });
    },
    setCommentEmotions: function () {
        // comments emotions
        $(".comments").each(function () {
            $(this).html(Util.replaceEmString($(this).html()));
        });
    },
    init: function () {
        this.getCurrentPage();
        this.setNavCurrent();
        this.setCommentEmotions();
    }
};
$(function () {
    bootstyle.init();
})

var getNextPage = function () {
    var $more = $(".pagination-btn");
    currentPage += 1;
    var path = "/articles/";
    if (location.pathname.indexOf("tags") > -1) {
        var tagsPathnaem = location.pathname.split("/tags/");
        var tags = tagsPathnaem[1].split("/");
        path = "/articles/tags/" + tags[0] + "/";
    } else if (location.pathname.indexOf("archives") > -1) {
        var archivesPathname = location.pathname.split("/archives/");
        var archives = archivesPathname[1].split("/");
        path = "/articles/archives/" + archives[0] + "/" + archives[1] + "/";
    }

    var nextLabel = '',btn_background = '';
    $.ajax({
        url: latkeConfig.servePath + path + currentPage,
        type: "GET",
        beforeSend: function () {
            nextLabel = $more.text();
            btn_background = $more.css('background');
            $more.text('　').css("background",
                "url(" + latkeConfig.staticServePath + "/skins/ease/images/ajax-loader.gif) no-repeat scroll center center #fefefe");
        },
        success: function (result, textStatus) {
            var pagination = result.rslts.pagination;

            for (var i = 0; i < result.rslts.articles.length; i++) {
                var article = result.rslts.articles[i];
                var articleHTML = new Array();
                articleHTML.push('<div class="page-header page-header-m">');
                articleHTML.push('<h3><a href="'+article.articlePermalink+'">'+article.articleTitle+'</a></h3>');
                articleHTML.push('</div>');
                articleHTML.push('<div class="page-header-bottom"><span>');
                articleHTML.push('<li class="icon-time"></li>');
                if (article.hasUpdated) {
                    articleHTML.push(Util.toDate(article.articleUpdateDate, ' yyyy-MM-dd HH:mm '));
                }else{
                    articleHTML.push(Util.toDate(article.articleCreateDate, ' yyyy-MM-dd HH:mm '));
                }
                articleHTML.push('</span><span><li class="icon-user"></li>');
                articleHTML.push('<a href="/authors/'+article.authorId+'" title="'+Label.authorLabel+': '+article.authorName+'"> ');
                articleHTML.push(article.authorName);
                articleHTML.push(' </a>');
                articleHTML.push('</span><div class="pull-right"><span>');
                articleHTML.push('<li class="icon-eye-open"></li>');
                articleHTML.push('<a href="'+article.articlePermalink+'"> ');
                articleHTML.push(article.articleViewCount+' '+Label.viewLabel);
                articleHTML.push(' </a>');
                articleHTML.push('</span><span><li class="icon-comment"></li>');
                articleHTML.push('<a href="'+article.articlePermalink+'#comments"> '+article.articleCommentCount+' '+Label.commentLabel+' </a>');
                articleHTML.push('</span></div></div>');
                articleHTML.push(article.articleAbstract);
                articleHTML.push('<div class="article-tags">');
                articleHTML.push('<li class="icon-tags"></li>'+Label.tag1Label);
                var articleTags = article.articleTags.split(',');
                for(var j = 0;j < articleTags.length;j++){
                    var articleTag = articleTags[j];
                    articleHTML.push('<span>');
                    articleHTML.push('<a href="'+latkeConfig.servePath+'/tags/'+articleTag+'">');
                    articleHTML.push(articleTag);
                    articleHTML.push('</a></span>');
                }
                articleHTML.push('</div>');
                $more.before(articleHTML.join(''));
            }

            if (pagination.paginationPageCount === currentPage) {
                $more.remove();
            } else {
                $more.text(nextLabel).css("background", '');
            }
        }
    });
};