<div class="module-panel">
    <div class="module-header">
        <h2>${aboutLabel}</h2>
    </div>
    <div class="module-body padding12">
        <div class="about-logo">
            <a href="http://b3log.org" target="_blank">
                <img width="128" src="${staticServePath}/images/logo.png" alt="Solo" title="Solo" />
            </a>
        </div>
        <div class="left content-reset" style="width: 73%">
            <div id="aboutLatest" class="about-margin">${checkingVersionLabel}</div>
            ${aboutContentLabel}

            <ul class="about-list">
            </ul>
            <button class="right" onclick="window.open('http://b3log.org/donate.html')">${sponsorLabel}</button>
        </div>
        <span class="clear" /> <br/>
    </div>
</div>
${plugins}
