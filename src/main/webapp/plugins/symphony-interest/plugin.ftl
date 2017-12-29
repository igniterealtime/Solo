<link type="text/css" rel="stylesheet" href="${staticServePath}/plugins/symphony-interest/style.css"/>
<div id="symphonyInterestPanel">
    <div class="module-panel">
        <div class="module-header">
            <h2>Ignite Realtime News Feed</h2>
        </div>
        <div class="module-body padding12">
            <div id="symphonyInterest">
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    plugins.symphonyInterest = {
        init: function () {
            $("#loadMsg").text("${loadingLabel}");

            $("#symphonyInterest").css("background",
                    "url(${staticServePath}/images/loader.gif) no-repeat scroll center center transparent");

            var listHTML = "<ul>";
            var articleLiHtml = "<li>No News Feed</li>"
            listHTML += articleLiHtml
            listHTML += "</ul>";

            $("#symphonyInterest").html(listHTML).css("background", "none");
            $("#loadMsg").text("");
        }
    };

    admin.plugin.add({
        "id": "symphonyInterest",
        "path": "/main/panel1",
        "content": $("#symphonyInterestPanel").html()
    });

    $("#symphonyInterestPanel").remove();
</script>
