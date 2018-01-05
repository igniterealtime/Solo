/*
 * Copyright (c) 2009, 2010, 2011, 2012, 2013, B3log Team
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
if($.browser.msie&&($.browser.version < "9.0")){
	$('html').addClass('ie');
}
$(document).ready(function(){
	$('.sidebar').masonry({ singleMode: true });
	arrivedAtBottom = $(window).scrollTop() >= $(document).height() - $(window).height() - 30;
	$(window).scroll(function(event){
		event.stopPropagation();
		arrivedAtBottom = $(window).scrollTop() >= $(document).height() - $(window).height() - 30;
		if (arrivedAtBottom) {
			$('.totop').removeClass("go_bottom");
			$('.totop').addClass("go_top");
		} 
		else {
			$('.totop').removeClass("go_top");
			$('.totop').addClass("go_bottom");
		}
	});
	$('.totop').click(function(){
		if (arrivedAtBottom) {
			$('html,body').animate({scrollTop: 0}, 500);
		} else {
			$('html,body').animate({scrollTop: $(document).height() - $(window).height()}, 500);	
		}
	});
	$('.tocomments').click(function(){
		$('html,body').animate({scrollTop: $(".comments").offset().top - 40}, 500);
	});
	/* ajax */
    $body = (window.opera) ? (document.compatMode == "CSS1Compat" ? $('html') : $('body')) : $('html,body');
    $(document).on('click', '#comments-nav a', function(e) {
        e.preventDefault();
        $.ajax({
            type: "GET",
            url: $(this).attr('href'),
            beforeSend: function() {
                $('#comments-nav').remove();
                $('#loading-comments').slideDown();
            },
            dataType: "html",
            success: function(out) {
				$('.comment-list').remove();
                result = $(out).find('.comment-list');
                nextlink = $(out).find('#comments-nav');
                $('#loading-comments').slideUp(550);
                $('#loading-comments').after(result.fadeIn(800));
                $('.comment-list').after(nextlink);
            }
        });
    });   
	$(document).on('click', '#posts-nav a', function(e) {
        e.preventDefault();
        $.ajax({
            type: "GET",
            url: $(this).attr('href'),
            beforeSend: function() {
				$('#posts-nav').remove();
				$('#loading-posts').slideDown();
            },
            dataType: "html",
            success: function(out) {
				$('.posts-list').remove();
                result = $(out).find('.posts-list');
				nextlink = $(out).find('#posts-nav');
				$('#loading-posts').slideUp(550);
                $('#loading-posts').after(result.fadeIn(800));
				$('.posts-list').after(nextlink);
            }
        });
    });
});