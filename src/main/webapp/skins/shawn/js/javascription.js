(function($) {
    $.fn.ajaxSubmit = function(o) {
        if (typeof o == "function") {
            o = {
                success: o
            }
        }
        o = $.extend({
            url: this.attr("action") || window.location.toString(),
            type: this.attr("method") || "GET"
        },
        o || {});
        var p = {};
        $.event.trigger("form.pre.serialize", [this, o, p]);
        if (p.veto) {
            return this
        }
        var a = this.formToArray(o.semantic);
        if (o.data) {
            for (var n in o.data) {
                a.push({
                    name: n,
                    value: o.data[n]
                })
            }
        }
        if (o.beforeSubmit && o.beforeSubmit(a, this, o) === false) {
            return this
        }
        $.event.trigger("form.submit.validate", [a, this, o, p]);
        if (p.veto) {
            return this
        }
        var q = $.param(a);
        if (o.type.toUpperCase() == "GET") {
            o.url += (o.url.indexOf("?") >= 0 ? "&": "?") + q;
            o.data = null
        } else {
            o.data = q
        }
        var r = this,
        callbacks = [];
        if (o.resetForm) {
            callbacks.push(function() {
                r.resetForm()
            })
        }
        if (o.clearForm) {
            callbacks.push(function() {
                r.clearForm()
            })
        }
        if (!o.dataType && o.target) {
            var u = o.success || 
            function() {};
            callbacks.push(function(a) {
                if (this.evalScripts) {
                    $(o.target).attr("innerHTML", a).evalScripts().each(u, arguments)
                } else {
                    $(o.target).html(a).each(u, arguments)
                }
            })
        } else {
            if (o.success) {
                callbacks.push(o.success)
            }
        }
        o.success = function(a, b) {
            for (var i = 0, max = callbacks.length; i < max; i++) {
                callbacks[i](a, b, r)
            }
        };
        var v = $("input:file", this).fieldValue();
        var w = false;
        for (var j = 0; j < v.length; j++) {
            if (v[j]) {
                w = true
            }
        }
        if (o.iframe || w) {
            if ($.browser.safari && o.closeKeepAlive) {
                $.get(o.closeKeepAlive, fileUpload)
            } else {
                fileUpload()
            }
        } else {
            $.ajax(o)
        }
        $.event.trigger("form.submit.notify", [this, o]);
        return this;
        function fileUpload() {
            var d = r[0];
            var f = $.extend({},
                $.ajaxSettings, o);
            var h = "jqFormIO" + $.fn.ajaxSubmit.counter++;
            var i = $('<iframe id="' + h + '" name="' + h + '" />');
            var j = i[0];
            var k = $.browser.opera && window.opera.version() < 9;
            if ($.browser.msie || k) {
                j.src = 'javascript:false;document.write("");'
            }
            i.css({
                position: "absolute",
                top: "-1000px",
                left: "-1000px"
            });
            var l = {
                responseText: null,
                responseXML: null,
                status: 0,
                statusText: "n/a",
                getAllResponseHeaders: function() {},
                getResponseHeader: function() {},
                setRequestHeader: function() {}
            };
            var g = f.global;
            if (g && !$.active++) {
                $.event.trigger("ajaxStart")
            }
            if (g) {
                $.event.trigger("ajaxSend", [l, f])
            }
            var m = 0;
            var n = 0;
            setTimeout(function() {
                var a = d.encoding ? "encoding": "enctype";
                var t = r.attr("target");
                r.attr({
                    target: h,
                    method: "POST",
                    action: f.url
                });
                d[a] = "multipart/form-data";
                if (f.timeout) {
                    setTimeout(function() {
                        n = true;
                        cb()
                    },
                    f.timeout)
                }
                i.appendTo("body");
                j.attachEvent ? j.attachEvent("onload", cb) : j.addEventListener("load", cb, false);
                d.submit();
                r.attr("target", t)
            },
            10);
            function cb() {
                if (m++) {
                    return
                }
                j.detachEvent ? j.detachEvent("onload", cb) : j.removeEventListener("load", cb, false);
                var a = true;
                try {
                    if (n) {
                        throw "timeout"
                    }
                    var b,
                    doc;
                    doc = j.contentWindow ? j.contentWindow.document: j.contentDocument ? j.contentDocument: j.document;
                    l.responseText = doc.body ? doc.body.innerHTML: null;
                    l.responseXML = doc.XMLDocument ? doc.XMLDocument: doc;
                    if (f.dataType == "json" || f.dataType == "script") {
                        var c = doc.getElementsByTagName("textarea")[0];
                        b = c ? c.value: l.responseText;
                        if (f.dataType == "json") {
                            eval("data = " + b)
                        } else {
                            $.globalEval(b)
                        }
                    } else {
                        if (f.dataType == "xml") {
                            b = l.responseXML;
                            if (!b && l.responseText != null) {
                                b = toXml(l.responseText)
                            }
                        } else {
                            b = l.responseText
                        }
                    }
                } catch(e) {
                    a = false;
                    $.handleError(f, l, "error", e)
                }
                if (a) {
                    f.success(b, "success");
                    if (g) {
                        $.event.trigger("ajaxSuccess", [l, f])
                    }
                }
                if (g) {
                    $.event.trigger("ajaxComplete", [l, f])
                }
                if (g && !--$.active) {
                    $.event.trigger("ajaxStop")
                }
                if (f.complete) {
                    f.complete(l, a ? "success": "error")
                }
                setTimeout(function() {
                    i.remove();
                    l.responseXML = null
                },
                100)
            }
            function toXml(s, a) {
                if (window.ActiveXObject) {
                    a = new ActiveXObject("Microsoft.XMLDOM");
                    a.async = "false";
                    a.loadXML(s)
                } else {
                    a = (new DOMParser()).parseFromString(s, "text/xml")
                }
                return (a && a.documentElement && a.documentElement.tagName != "parsererror") ? a: null
            }
        }
    };
    $.fn.ajaxSubmit.counter = 0;
    $.fn.ajaxForm = function(a) {
        return this.ajaxFormUnbind().submit(submitHandler).each(function() {
            this.formPluginId = $.fn.ajaxForm.counter++;
            $.fn.ajaxForm.optionHash[this.formPluginId] = a;
            $(":submit,input:image", this).click(clickHandler)
        })
    };
    $.fn.ajaxForm.counter = 1;
    $.fn.ajaxForm.optionHash = {};
    function clickHandler(e) {
        var a = this.form;
        a.clk = this;
        if (this.type == "image") {
            if (e.offsetX != undefined) {
                a.clk_x = e.offsetX;
                a.clk_y = e.offsetY
            } else {
                if (typeof $.fn.offset == "function") {
                    var b = $(this).offset();
                    a.clk_x = e.pageX - b.left;
                    a.clk_y = e.pageY - b.top
                } else {
                    a.clk_x = e.pageX - this.offsetLeft;
                    a.clk_y = e.pageY - this.offsetTop
                }
            }
        }
        setTimeout(function() {
            a.clk = a.clk_x = a.clk_y = null
        },
        10)
    }
    function submitHandler() {
        var a = this.formPluginId;
        var b = $.fn.ajaxForm.optionHash[a];
        $(this).ajaxSubmit(b);
        return false
    }
    $.fn.ajaxFormUnbind = function() {
        this.unbind("submit", submitHandler);
        return this.each(function() {
            $(":submit,input:image", this).unbind("click", clickHandler)
        })
    };
    $.fn.formToArray = function(b) {
        var a = [];
        if (this.length == 0) {
            return a
        }
        var c = this[0];
        var d = b ? c.getElementsByTagName("*") : c.elements;
        if (!d) {
            return a
        }
        for (var i = 0, max = d.length; i < max; i++) {
            var e = d[i];
            var n = e.name;
            if (!n) {
                continue
            }
            if (b && c.clk && e.type == "image") {
                if (!e.disabled && c.clk == e) {
                    a.push({
                        name: n + ".x",
                        value: c.clk_x
                    },
                    {
                        name: n + ".y",
                        value: c.clk_y
                    })
                }
                continue
            }
            var v = $.fieldValue(e, true);
            if (v && v.constructor == Array) {
                for (var j = 0, jmax = v.length; j < jmax; j++) {
                    a.push({
                        name: n,
                        value: v[j]
                    })
                }
            } else {
                if (v !== null && typeof v != "undefined") {
                    a.push({
                        name: n,
                        value: v
                    })
                }
            }
        }
        if (!b && c.clk) {
            var f = c.getElementsByTagName("input");
            for (var i = 0, max = f.length; i < max; i++) {
                var g = f[i];
                var n = g.name;
                if (n && !g.disabled && g.type == "image" && c.clk == g) {
                    a.push({
                        name: n + ".x",
                        value: c.clk_x
                    },
                    {
                        name: n + ".y",
                        value: c.clk_y
                    })
                }
            }
        }
        return a
    };
    $.fn.formSerialize = function(a) {
        return $.param(this.formToArray(a))
    };
    $.fn.fieldSerialize = function(b) {
        var a = [];
        this.each(function() {
            var n = this.name;
            if (!n) {
                return
            }
            var v = $.fieldValue(this, b);
            if (v && v.constructor == Array) {
                for (var i = 0, max = v.length; i < max; i++) {
                    a.push({
                        name: n,
                        value: v[i]
                    })
                }
            } else {
                if (v !== null && typeof v != "undefined") {
                    a.push({
                        name: this.name,
                        value: v
                    })
                }
            }
        });
        return $.param(a)
    };
    $.fn.fieldValue = function(a) {
        for (var b = [], i = 0, max = this.length; i < max; i++) {
            var c = this[i];
            var v = $.fieldValue(c, a);
            if (v === null || typeof v == "undefined" || (v.constructor == Array && !v.length)) {
                continue
            }
            v.constructor == Array ? $.merge(b, v) : b.push(v)
        }
        return b
    };
    $.fieldValue = function(b, c) {
        var n = b.name,
        t = b.type,
        tag = b.tagName.toLowerCase();
        if (typeof c == "undefined") {
            c = true
        }
        if (c && (!n || b.disabled || t == "reset" || t == "button" || (t == "checkbox" || t == "radio") && !b.checked || (t == "submit" || t == "image") && b.form && b.form.clk != b || tag == "select" && b.selectedIndex == -1)) {
            return null
        }
        if (tag == "select") {
            var d = b.selectedIndex;
            if (d < 0) {
                return null
            }
            var a = [],
            ops = b.options;
            var e = (t == "select-one");
            var f = (e ? d + 1: ops.length);
            for (var i = (e ? d: 0); i < f; i++) {
                var g = ops[i];
                if (g.selected) {
                    var v = $.browser.msie && !(g.attributes.value.specified) ? g.text: g.value;
                    if (e) {
                        return v
                    }
                    a.push(v)
                }
            }
            return a
        }
        return b.value
    };
    $.fn.clearForm = function() {
        return this.each(function() {
            $("input,select,textarea", this).clearFields()
        })
    };
    $.fn.clearFields = $.fn.clearInputs = function() {
        return this.each(function() {
            var t = this.type,
            tag = this.tagName.toLowerCase();
            if (t == "text" || t == "password" || tag == "textarea") {
                this.value = ""
            } else {
                if (t == "checkbox" || t == "radio") {
                    this.checked = false
                } else {
                    if (tag == "select") {
                        this.selectedIndex = -1
                    }
                }
            }
        })
    };
    $.fn.resetForm = function() {
        return this.each(function() {
            if (typeof this.reset == "function" || (typeof this.reset == "object" && !this.reset.nodeType)) {
                this.reset()
            }
        })
    };
    $.fn.enable = function(b) {
        if (b == undefined) {
            b = true
        }
        return this.each(function() {
            this.disabled = !b
        })
    };
    $.fn.select = function(b) {
        if (b == undefined) {
            b = true
        }
        return this.each(function() {
            var t = this.type;
            if (t == "checkbox" || t == "radio") {
                this.checked = b
            } else {
                if (this.tagName.toLowerCase() == "option") {
                    var a = $(this).parent("select");
                    if (b && a[0] && a[0].type == "select-one") {
                        a.find("option").select(false)
                    }
                    this.selected = b
                }
            }
        })
    }
})(jQuery);
$.fn.countdown = function(a) {
    if (!a) {
        a = "()"
    }
    if ($(this).length == 0) {
        return false
    }
    var b = this;
    if (a.seconds < 0 || a.seconds == "undefined") {
        if (a.callback) {
            eval(a.callback)
        }
        return null
    }
    window.setTimeout(function() {
        $(b).html(String(a.seconds));
        --a.seconds;
        $(b).countdown(a)
    },
    1000);
    return this
};
$.fn.countdown.stop = function() {
    window.clearTimeout(setTimeout("0") - 1)
};
(function(B) {
    var C = B.scrollTo = function(D, F, E) {
        B(window).scrollTo(D, F, E)
    };
    C.defaults = {
        axis: "y",
        duration: 1
    };
    C.window = function(D) {
        return B(window).scrollable()
    };
    B.fn.scrollable = function() {
        return this.map(function() {
            var G = this.parentWindow || this.defaultView,
            E = this.nodeName == "#document" ? G.frameElement || G: this,
            F = E.contentDocument || (E.contentWindow || E).document,
            D = E.setInterval;
            return E.nodeName == "IFRAME" || D && B.browser.safari ? F.body: D ? F.documentElement: this
        })
    };
    B.fn.scrollTo = function(D, F, E) {
        if (typeof F == "object") {
            E = F;
            F = 0
        }
        if (typeof E == "function") {
            E = {
                onAfter: E
            }
        }
        E = B.extend({},
            C.defaults, E);
        F = F || E.speed || E.duration;
        E.queue = E.queue && E.axis.length > 1;
        if (E.queue) {
            F /= 2
        }
        E.offset = A(E.offset);
        E.over = A(E.over);
        return this.scrollable().each(function() {
            var M = this,
            K = B(M),
            L = D,
            J,
            H = {},
            N = K.is("html,body");
            switch (typeof L) {
                case "number":
                case "string":
                    if (/^([+-]=)?\d+(px)?$/.test(L)) {
                        L = A(L);
                        break
                    }
                    L = B(L, this);
                case "object":
                    if (L.is || L.style) {
                        J = (L = B(L)).offset()
                    }
            }
            B.each(E.axis.split(""), 
                function(R, S) {
                    var T = S == "x" ? "Left": "Top",
                    W = T.toLowerCase(),
                    Q = "scroll" + T,
                    O = M[Q],
                    P = S == "x" ? "Width": "Height",
                    U = P.toLowerCase();
                    if (J) {
                        H[Q] = J[W] + (N ? 0: O - K.offset()[W]);
                        if (E.margin) {
                            H[Q] -= parseInt(L.css("margin" + T)) || 0;
                            H[Q] -= parseInt(L.css("border" + T + "Width")) || 0
                        }
                        H[Q] += E.offset[W] || 0;
                        if (E.over[W]) {
                            H[Q] += L[U]() * E.over[W]
                        }
                    } else {
                        H[Q] = L[W]
                    }
                    if (/^\d+$/.test(H[Q])) {
                        H[Q] = H[Q] <= 0 ? 0: Math.min(H[Q], G(P))
                    }
                    if (!R && E.queue) {
                        if (O != H[Q]) {
                            I(E.onAfterFirst)
                        }
                        delete H[Q]
                    }
                });
            I(E.onAfter);
            function I(O) {
                K.animate(H, F, E.easing, O && 
                    function() {
                        O.call(this, D, E)
                    })
            }
            function G(P) {
                var O = "scroll" + P,
                Q = M.ownerDocument;
                return N ? Math.max(Q.documentElement[O], Q.body[O]) : M[O]
            }
        }).end()
    };
    function A(D) {
        return typeof D == "object" ? D: {
            top: D,
            left: D
        }
    }
})(jQuery);
(function(A) {
    A.extend({
        aflow: {
            version: 1,
            defaults: {
                toggleSpeed: 75,
                toggleEffect: "both",
                hoverEffect: null,
                moveSpeed: 250,
                easing: "swing",
                className: "aflow"
            },
            effects: {
                width: {
                    width: 0
                },
                height: {
                    height: 0
                },
                both: {
                    width: 0,
                    height: 0
                }
            }
        }
    });
    A.fn.extend({
        aflow: function(C) {
            var C = A.extend({},
                A.aflow.defaults, C);
            var B = ((typeof C.toggleEffect == "string") ? A.aflow.effects[C.toggleEffect] : C.toggleEffect);
            return this.hover(function(H) {
                var I = A(this);
                var D = I.parent();
                var G = {
                    width: I.outerWidth(),
                    height: I.outerHeight()
                };
                var L = I.offset();
                var M = D.offset();
                var J = A("div." + C.className, D).stop();
                var F = (J.length == 0);
                if (F) {
                    J = A("<div>&nbsp;</div>").addClass(C.className).appendTo(D).css(G)
                }
                var E = {
                    left: L.left - M.left - (J.outerWidth() - J.width()) / 2,
                    top: L.top - M.top - (J.outerHeight() - J.height()) / 2
                };
                if (F) {
                    J.css(E).css(B).animate(G, {
                        queue: false,
                        duration: C.toggleSpeed,
                        easing: C.easing
                    })
                } else {
                    var K = A.extend({},
                        G, E);
                    J.animate(K, {
                        queue: false,
                        duration: C.moveSpeed,
                        easing: C.easing
                    })
                }
                if (A.isFunction(C.hoverEffect)) {
                    J.queue(C.hoverEffect)
                }
            },
            function(E) {
                A("div." + C.className).animate(B, {
                    queue: false,
                    duration: C.toggleSpeed,
                    easing: C.easing,
                    complete: function() {
                        A(this).remove()
                    }
                })
            })
        }
    })
})(jQuery);
/*var ajax_comments = {
    locked: [],
    onsubmit: function() {
        var A = this;
        if (ajax_comments.locked[A]) {
            return false
        } else {
            ajax_comments.locked[A] = true
        }
        $.ajax({
            type: "POST",
            url: "http://shawnster.org/wp-content/plugins/ajax-comments/Ajax-comments-post.php",
            data: $(this).formSerialize(),
            dataType: "json",
            cache: false,
            timeout: 60000,
            beforeSend: function(B) {
                $(".ajax_comments_error", A).remove();
                $("input[@type=submit]", A).attr("disabled", "disabled").hide().after('<div class="ajax_comments_spinner" title="Sending Your Comment..." style="background:url(/loading.gif);width:99px;height:9px;text-indent:-9999px;font-size:0;line-height:0">\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd...</div>')
            },
            success: function(H, G) {
                if (typeof(H.comment_type) == "undefined" || typeof(H.comment_ID) == "undefined" || typeof(H.comments_template) == "undefined" || !H.comments_template) {
                    this.error({
                        responseText: ""
                    },
                    "", "");
                    return
                }
                var C = $(A).parents("div#ajax_comments_wrapper"),
                B = $(".commentlist", C),
                E = $(H.comments_template),
                F = $("#comment-" + H.comment_ID + ", .commentlist *:last", E).eq(0).hide();
                if (!$.browser.msie) {
                    F.css({
                        "margin-left": "55px",
                        "margin-right": "70px",
                        opacity: "0.1"
                    })
                }
                if (H.comment_type == "conventional" && B.length > 0) {
                    B.append(F);
                    $("#comments", C).after($("#comments", E)).remove()
                } else {
                    var D = $("//textarea[@name=comment]", E).parents("form");
                    if (D.length) {
                        D.after(A).remove()
                    } else {
                        E.append(A)
                    }
                    C.after(E).remove()
                }
                if ($.browser.msie) {
                    F.show(1000)
                }
                if (!$.browser.msie) {
                    F.css("display", "block").animate({
                        marginLeft: "85px",
                        marginRight: "40px",
                        opacity: "1"
                    },
                    800)
                }
                if (typeof(AjaxEditComments) != "undefined") {
                    AjaxEditComments.init()
                }
                this.cleanup()
            },
            error: function(C, E, D) {
                var B = "";
                if (typeof(C.responseText) == "string" && C.responseText != "") {
                    B = C.responseText
                } else {
                    if (E == "timeout") {
                        B = "Could not connect the server, please refresh the page"
                    } else {
                        B = "Unknow error, would you like to re-send?"
                    }
                }
                $(A).prepend('<div class="ajax_comments_error" style="background:#999;font-size:12px;margin:15px 126px;padding:.8em;color:#fff;line-height:1.3em;width:200px;text-align:center">' + B + "</div>");
                $(".ajax_comments_spinner", A).remove();
                $("input[@type=submit]", A).removeAttr("disabled").show();
                ajax_comments.locked[A] = false
            },
            cleanup: function() {
                $("#comment", A).clearFields();
                $(".ajax_comments_spinner", A).remove();
                $("input[@type=submit]", A).removeAttr("disabled").show();
                ajax_comments.locked[A] = false
            }
        });
        return false
    }
};
$(function() {
    $("#commentform").bind("submit", ajax_comments.onsubmit)
});*/
$(".post #postail,.reply #submit").css({
    "-moz-border-radius": "7px",
    "-webkit-border-radius": "7px",
    "border-radius": "7px"
});
//$("#sidebar ul:last li:first").css("display", "none");
$(".nav li").css({
    "-moz-border-radius-topright": "8px",
    "-moz-border-radius-topleft": "8px"
});
$(".entry p.code").css("word-break", "break-all");
/*$(".index h3").each(function() 
{
    var A = $(this).find("a").attr("href");
    var B = '<a href="' + A + '" style="font:small-caps bold 11px Verdana;border:none">More&raquo;</a>';
    var C = $(this).next().next().find(".conumber");
    $(this).next().find("p").append(B);
    C.replaceWith("<a href='" + A + "#comments'>" + C.text() + "</a>");
});*/
$(document).ready(function() {
    var K = $("div.timeta,.rssfeed img,.twitter");
    K.hover(function() {
        $(this).fadeTo("fast", "1")
    },
    function() {
        $(this).fadeTo("fast", "0.7")
    }).fadeTo("normal", "0.7");
    var E = $("#sidebar ul li ul li");
    if (!$.browser.msie) {
        E.hover(function() {
            $(this).fadeTo("fast", "1")
        },
        function() {
            $(this).fadeTo("fast", "0.7")
        }).fadeTo("normal", "0.7")
    }
    var G = $("#footer .g2b,#footer .b2t");
    G.hover(function() {
        $(this).fadeTo("fast", "1")
    },
    function() {
        $(this).fadeTo("fast", "0.2")
    }).fadeTo("normal", "0.2");
    $("a[rel!='nofollow']a[rel!='external'][target!='_blank']a[class!='nopopup']").click(function() {
        $("#loading").slideDown();
        setTimeout(function() {
            $("#loading").fadeOut()
        },
        4000)
    });
    $("a[href*='#'],a[rel='external nofollow'],a[href='javascript:void(0)'],a[href='javascript:reset_captcha('')']").click(function() {
        $("#loading").fadeOut("slow")
    });
    $(".post .entry p a:has(img)").css({
        background: "transparent",
        border: "none"
    });
    $(".post .entry p:has(img[src*='yupoo'])").css({
        "text-indent": "0px",
        "text-align": "center"
    });
    $(".post .entry p:has(object)").css({
        "text-indent": "0px",
        "text-align": "center",
        height: "344px",
        background: "url(/skins/Shawn/images/videobg.png) no-repeat center center",
        padding: "15px 0 19px"
    });
    $("#sidebar ul:nth-child(even)").css("background", "url(/skins/Shawn/images/sidelines.gif) no-repeat");
    $("#sidebar ul li ul").css("background", "none");
    $(".contact a").click(function() {
        $(this).countdown({
            seconds: 9
        }).css({
            border: "none",
            "font-size": "16px",
            color: "red"
        }).unbind("click");
        var B = "shawnrx";
        var C = "gmail.com";
        var A = $(this).parent();
        setTimeout(function() {
            A.append("<span>" + B + "@" + C + "</span>");
            $(".contact a").hide()
        },
        10000)
    });
    var D = /^@/;
    var G = /^#comment-/;
    var F = $.browser.msie && $.browser.version == "6.0";
    $(".commentlist li .list p a").each(function() {
        if ($(this).text().match(D) && $(this).attr("href").match(G)) {
            $(this).addClass("replybox").removeAttr("rel", "nofollow")
        }
    });
    $(".replybox").hover(function() {
        $($(this).attr("href")).clone().hide().attr("id", "").insertAfter($(this).parents("li")).addClass("backward").css({
            display: "block",
            opacity: "0"
        }).animate({
            marginTop: "-50px",
            opacity: "1"
        },
        500)
    },
    function() {
        $(".backward").animate({
            marginTop: "40px",
            opacity: "0"
        },
        500).hide(100, 
            function() {
                $(this).remove()
            })
    }).mousemove(function(A) {
        var E = $(".commentlist").offset();
        if (F) {
            $(".backward").css({
                left: (A.pageX - E.left - 150),
                top: (A.pageY - E.top + 60)
            })
        } else {
            $(".backward").css({
                left: (A.pageX - E.left - 60),
                top: (A.pageY - E.top + 60),
                "-moz-border-radius": "10px",
                "-webkit-border-radius": "10px"
            })
        }
    });
    $(".reply input,.reply textarea").focus(function() {
        $(this).next("span").fadeIn("fast")
    }),
    $(".reply input,.reply textarea").blur(function() {
        $(this).next("span").fadeOut("fast")
    });
    $("a[rel='nofollow'],a[rel='external'],a[rel='external nofollow']").click(function() {
        window.open(this.href);
        return false
    });
    $(".commentlist li").hover(function() {
        $(this).find(".atreply").css("display", "block")
    },
    function() {
        $(this).find(".atreply").css("display", "none")
    });
    $.getScript("http://www.google.com/coop/cse/brand?form=cse-search-box&amp;lang=en-us");
    $("#share").hover(function() {
        $("#share ul").css("display", "block").animate({
            top: "-205px",
            opacity: "0.8"
        },
        500)
    },
    function() {
        $("#share ul").animate({
            top: "-225px",
            opacity: "0.1"
        },
        300);
        setTimeout(function() {
            $("#share ul").css("display", "none")
        },
        310)
    });
    $("#loading").fadeOut(1000)
});
$(function(C) {
    C.easing.elasout = function(F, E, D, I, H) {
        var G = 1.70158;
        var Q = 0;
        var B = I;
        if (E == 0) {
            return D
        }
        if ((E /= H) == 1) {
            return D + I
        }
        if (!Q) {
            Q = H * 0.3
        }
        if (B < Math.abs(I)) {
            B = I;
            var G = Q / 4
        } else {
            var G = Q / (2 * Math.PI) * Math.asin(I / B)
        }
        return B * Math.pow(2, -10 * E) * Math.sin((E * H - G) * (2 * Math.PI) / Q) + I + D
    };
    /*C("span.cmntcnt a,a.say").click(function() {
        C.scrollTo(this.hash, 1000, {
            easing: "elasout"
        });
        return false
    });*/
    C("#footer .b2t").click(function() {
        C.scrollTo("#header", 800, {
            offset: -45
        });
        return false
    });
    C("#footer .g2b").click(function() {
        C.scrollTo("#footer", 1200);
        return false
    });
    C(".say").click(function() {
        C.scrollTo("#comments", 500);
        return false
    });
    C("img.atreply").click(function() {
        C.scrollTo("#" +  C(this).attr("data-id"), 1000, {
            easing: "elasout"
        });
        return false;
    });
    var A = window.location.hash.split("#")[1];
    if (A) {
        C.scrollTo("#" + A, 1000)
    }
});
$(function(B) {
    B("#sidebar ul li ul li").aflow({
        toggleEffect: "height",
        moveSpeed: 75,
        toggleSpeed: 250
    })
});
document.writeln("<style type='text/css'>.aflow{-moz-border-radius:7px;-webkit-border-radius:7px;border-radius:7px}.post .index p a:hover{text-decoration:underline}</style>");
function emoticon(F) {
    var H;
    F = " " + F + " ";
    if (document.getElementById("comment") && document.getElementById("comment").type == "textarea") {
        H = document.getElementById("comment")
    } else {
        return false
    }
    if (document.selection) {
        H.focus();
        sel = document.selection.createRange();
        sel.text = F;
        H.focus()
    } else {
        if (H.selectionStart || H.selectionStart == "0") {
            var I = H.selectionStart;
            var J = H.selectionEnd;
            var G = J;
            H.value = H.value.substring(0, I) + F + H.value.substring(J, H.value.length);
            G += F.length;
            H.focus();
            H.selectionStart = G;
            H.selectionEnd = G
        } else {
            H.value += F;
            H.focus()
        }
    }
}

function ctrlEnter(D) {
    var C = D ? D: window.event;
    if (C.ctrlKey && C.keyCode == 13) {
        if (document.getElementById("submitCommentButtonReply")) {
            document.getElementById("submitCommentButtonReply").click();
        } else {
            document.getElementById("submitCommentButton").click();
        }
    }
}
$.cookie = function(O, T, Q) {
    if (typeof T != "undefined") {
        Q = Q || {};
        if (T === null) {
            T = "";
            Q.expires = -1
        }
        var Y = "";
        if (Q.expires && (typeof Q.expires == "number" || Q.expires.toUTCString)) {
            var X;
            if (typeof Q.expires == "number") {
                X = new Date();
                X.setTime(X.getTime() + (Q.expires * 24 * 60 * 60 * 1000))
            } else {
                X = Q.expires
            }
            Y = "; expires=" + X.toUTCString()
        }
        var R = ";path=/";
        var W = Q.domain ? "; domain=" + (Q.domain) : "";
        var P = Q.secure ? "; secure": "";
        document.cookie = [O, "=", encodeURIComponent(T), Y, R, W, P].join("")
    } else {
        var M = null;
        if (document.cookie && document.cookie != "") {
            var S = document.cookie.split(";");
            for (var U = 0; U < S.length; U++) {
                var N = $.trim(S[U]);
                if (N.substring(0, O.length + 1) == (O + "=")) {
                    M = decodeURIComponent(N.substring(O.length + 1));
                    break
                }
            }
        }
        return M
    }
};
$(".advise a").click(function() {
    $(".advise").fadeOut();
    $.cookie("subscrib", "1", {
        expires: 90
    })
});
var V = 0;
if ($.cookie("shawn_blog")) {
    V = parseInt($.cookie("shawn_blog"))
}
$.cookie("shawn_blog", (V + 1).toString(), {
    expires: 90
});
var ie6 = $.browser.msie && $.browser.version == "6.0";
if ($("input#author:has[value]").length <= 0 && V > 5 && $.cookie("subscrib") != "1" && !ie6) {
    $(".advise").fadeIn(1500)
}
var FC = "<span style='background:#fff;position:absolute;margin-left:-220px;padding:5px;width:220px;height:20px'></span>";
$(".linklove").append(FC);
(function(D) {
    if (D.browser.msie && document.namespaces.v == null) {
        document.namespaces.add("v", "urn:schemas-microsoft-com:vml");
        var C = document.createStyleSheet().owningElement;
        C.styleSheet.cssText = "v\\:*{behavior:url(#default#VML);}"
    }
    D.fn.cornerz = function(L) {
        function B(E, j, m, a, e, g) {
            var G,
            d,
            i,
            H,
            b,
            I,
            c,
            l = 1.57,
            f = "position:absolute;";
            if (E) {
                G = -l;
                b = m;
                c = 0;
                f += "top:-" + a + "px;"
            } else {
                G = l;
                b = 0;
                c = m;
                f += "bottom:-" + a + "px;"
            }
            if (j) {
                d = l * 2;
                H = m;
                I = 0;
                f += "left:-" + a + "px;"
            } else {
                d = 0;
                H = 0;
                I = m;
                f += "right:-" + a + "px;"
            }
            var k = D("<canvas width=" + m + "px height=" + m + "px style='" + f + "' ></canvas>");
            var F = k[0].getContext("2d");
            F.beginPath();
            F.lineWidth = a * 2;
            F.arc(H, b, m, G, d, !(E ^ j));
            F.strokeStyle = e;
            F.stroke();
            F.lineWidth = 0;
            F.lineTo(I, c);
            F.fillStyle = g;
            F.fill();
            return k
        }
        function A(G, P, H, I, E) {
            var F = D("<div style='display: inherit' />");
            D.each(G.split(" "), 
                function() {
                    F.append(B(this[0] == "t", this[1] == "l", P, H, I, E))
                });
            return F
        }
        function J(W, G, H, T, I, U, F) {
            var S = T - I - F;
            var E = T - U;
            return "<v:arc filled='False' strokeweight='" + G + "px' strokecolor='" + H + "' startangle='0' endangle='361' style=' top:" + E + "px;left: " + S + ";width:" + W + "px; height:" + W + "px' />"
        }
        function M(F, Q, H, I, E, G) {
            var R = "<div style='text-align:left; '>";
            D.each(D.trim(F).split(" "), 
                function() {
                    var U,
                    O = 1,
                    W = 1,
                    P = 0;
                    if (this.charAt(0) == "t") {
                        U = "top:-" + H + "px;"
                    } else {
                        U = "bottom:-" + H + "px;";
                        W = Q + 1
                    }
                    if (this.charAt(1) == "l") {
                        U += "left:-" + H + "px;"
                    } else {
                        U += "right:-" + (H) + "px; ";
                        O = Q;
                        P = 1
                    }
                    R += "<div style='" + U + "; position: absolute; overflow:hidden; width:" + Q + "px; height: " + Q + "px;'>";
                    R += "<v:group  style='width:1000px;height:1000px;position:absolute;' coordsize='1000,1000' >";
                    R += J(Q * 3, Q + H, E, -Q / 2, O, W, P);
                    if (H > 0) {
                        R += J(Q * 2 - H, H, I, Math.floor(H / 2 + 0.5), O, W, P)
                    }
                    R += "</v:group>";
                    R += "</div>"
                });
            R += "</div>";
            return R
        }
        var K = {
            corners: "tl tr bl br",
            radius: 10,
            background: "white",
            borderWidth: 0,
            fixIE: true
        };
        D.extend(K, L || {});
        var N = function(F, H, G) {
            var E = parseInt(F.css(H)) || 0;
            F.css(H, G + E)
        };
        return this.each(function() {
            var G = D(this);
            var S = K.radius * 1;
            var H = (K.borderWidth || parseInt(G.css("borderTopWidth")) || 0) * 1;
            var E = K.background;
            var I = K.borderColor;
            I = I || (H > 0 ? G.css("borderTopColor") : E);
            var T = K.corners;
            if (D.browser.msie) {
                h = M(T, S, H, I, E, D(this).width());
                this.innerHTML += h
            } else {
                G.append(A(T, S, H, I, E))
            }
            if (this.style.position != "absolute") {
                this.style.position = "relative"
            }
            this.style.zoom = 1;
            if (D.browser.msie && K.fixIE) {
                var F = G.outerWidth();
                var R = G.outerHeight();
                if (F % 2 == 1) {
                    N(G, "padding-right", 1);
                    N(G, "margin-right", 1)
                }
                if (R % 2 == 1) {
                    N(G, "padding-bottom", 1);
                    N(G, "margin-bottom", 1)
                }
            }
        })
    }
})(jQuery);
if (!$.browser.mozilla) {
    $(function() {
        $(".post #postail").cornerz({
            radius: 7
        });
        $(".nav li").cornerz({
            radius: 8,
            background: "#EAEAEA",
            corners: "tl tr"
        })
    })
}