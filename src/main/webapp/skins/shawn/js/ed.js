jQuery(document).ready(function()
{
	$(".commentlist li:even").addClass("alt");
	$(".commentlist li:odd").addClass("altline");
	loadjs = false;
	/*commentuser = $.cookie("comment_user");
	if (commentuser)
	{
		//[user, email, url] = commentuser.split("#@#");
		data = commentuser.split("#@#");
		$("#author").val(data[0]);
		$("#email").val(data[1]);
		$("#url").val(data[2]);
	};

	$("#commentform").ajaxForm(
	{
		type : "post", 
		dataType : "json", 
		beforeSubmit : function(formData, jqForm, options)
		{
			var form = jqForm[0];			
			if (form.author)
			{
				if (!form.author.value)
				{
					showinfo("Please input your name!");
					$("#authors")[0].innerHTML = "Name<font color='#FF0000' size='1px'>\u03C7</font>";
					form.author.focus();
					return false;
				}
				else
				{
					$("#authors")[0].innerHTML = "Name<font color='#00CC00' size='1px'><strong>\u221a</strong></font>"
				}
				if (!form.email.value)
				{
					showinfo("Please input your email address!");
					$("#emails")[0].innerHTML = "Mail<font color='#FF0000' size='1px'>\u03C7</font>";
					form.email.focus();
					return false;
				}
				if (form.email.value.search(/^\w+((-\w+)|(\.\w+))*\@{1}\w+\.{1}\w{2,4}(\.{0,1}\w{2}){0,1}/ig) == -1)
				{
					showinfo("Please input a correct email address!");
					form.email.value = "";
					form.email.focus();
					return false;
				}
				else
				{
					$("#emails")[0].innerHTML = "Mail<font color='#00CC00' size='1px'><strong>\u221a</strong></font>"
				}
			}
			if ($("#checkarea").css("display") == "block")
			{
				if (!form.checkret.value)
				{
					showinfo("Please input validate code, 3Q!");
					$("#checkcodes")[0].innerHTML = "Code:<font color='#FF0000' size='1px'><strong>\u03C7</strong></font>"
					form.checkret.focus();
					return false;
				}
				if (isNaN(form.checkret.value))
				{
					showinfo("This validate code must be filled with all-numbers, 3Q!");
					$("#checkcodes")[0].innerHTML = "Code:<font color='#FF0000' size='1px'><strong>\u03C7</strong></font>"
					form.checkret.value = "";
					form.checkret.focus();
					return false;
				}
				else
				{
					$("#checkcodes")[0].innerHTML = "Code:"
				}
			}
			if (!form.comment.value)
			{
				showinfo("Please enter a message!");
				form.comment.focus();
				return false;
			}
			
			$("#submit").attr("disabled", true);
			return true;
		}, success : function(data)
		{
			$("#submit").attr("disabled", false);
			if (data[0])
			{
				//document.cookie = data[2];
				showinfo("Submitted successfully!");
				add_comment(data[1]);
				$("#s_msg").text("Submitted successfully!");
				$("#comment").val("");
				reloadCheckImage();
				if ($("#checkarea").css("display") == "block")
				{
					if ($("#check_type").val() > 0)
					{
						get_check_area($("#check_type").val());
						reloadCheckImage();
					}
				}
				$("#checkret").val("");
				location = "#comments";
				//refresh
				if (data)
				{
					$("#commentlist").animate({opacity: 0.4}, 500, function()
					{
						$(this).html(data);//;
					}).animate({opacity : 1}, "slow");
				}
				//#refresh
			}
			else
			{
				if (data[1] == -102)
				{
					showinfo("Validate code error, please retry it, 3Q!");
					reloadCheckImage();
					$("#checkret").focus();
				}
			}
		}
	});*/
});
/*
function keyDown()
{
	if (event.ctrlKey && event.keyCode == 13)
	{
		document.getElementById("submitCommentButton").click();
		return false;
	}
}
*/
function get_check_area(type)
{
	if (type == 1)
	{
		$("#check").load("/checkcode/");
		$("#checkarea").show();
	}
	else if (type == 2)
	{
		$("#check").html("<img id='checkimg' src='/checkimg/' style='border:0px;padding:0;float:left;margin-right:8px' title='Click here to change Code' onclick='reloadCheckImage();' />");
		$("#checkarea").show();
    }
}

function reloadCheckImage()
{
	var img = document.getElementById("checkimg");
	img.src += "?";
}

//alert
function showinfo(msg)
{
	window.alert(msg);
}

//fixed ajax comments.
function add_comment(msg)
{
	comment = $(msg);

	if (!loadjs) {
		$("#comments").prepend(comment).show();

		$.getScript("http://dev.jquery.com/view/trunk/plugins/color/jquery.color.js", function()
		{
			comment.animate({backgroundColor: "#fbc7c7"}, "slow").animate({backgroundColor: "white"}, "slow");
			loadjs = true;
		});
	}
	else
	{
		$("#comments").prepend(comment);

		comment.animate({backgroundColor: "#fbc7c7"}, "slow").animate({backgroundColor: "white"}, "slow");
	}
}