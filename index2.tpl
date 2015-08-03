{literal}
<script>
function setCookie(cname,cvalue,exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires=" + d.toGMTString();
    document.cookie = cname+"="+cvalue+"; "+expires+"; path=/";
} 
$( document ).ready(function() {
    document.cookie = "splash=; expires=Thu, 01 Jan 1970 00:00:00 UTC";
    setCookie("splash", "yes", 10 * 365 * 24 * 60 * 60);
});
</script>
{/literal}

<div id="content">
    <!-- video title -->
    <div style="position:absolute;top:50px;left:378px">
        <script type="text/javascript" src="{$relative_tpl}/js/jquery.jtruncate.js"></script>
	<script type="text/javascript" src="{$relative_tpl}/js/jquery.video-0.2.js"></script>
            
        <!-- added by sad-face from video.tpl -->
                
        <div id="player">
        {if $deviceType != 'computer'}
            {include file='video_mobile.tpl'}
        {else}
            {if $is_friend && !$guest_limit}
            {include file='video_vplayer.tpl'}
            {/if}
        {/if}
        </div>
        <div id="video_info">
	        <h2 id="video_title">{$video.title|escape:'html'}</h2>
	        <div class="video_actions">
		    <div id="like"></div>
	            <div id="dislike"></div>
	            <i id="skip" class="fa fa-fast-forward"></i>
	        </div>
	        <div id="video_tags">
	                {t c='global.tags'}:
	                {assign var='keywords' value=$video.keyword}
	                {section name=i loop=$keywords}
	                <span class="video_tag" onclick="location.href='{$relative}/search?search_type=videos&search_query={$keywords[i]}'">{$keywords[i]}</span>,
	                {/section}
	        </div>
	 </div>
	 <!-- end addition -->
    </div>
    
    
        {include file="recent_search2.tpl"}
        <br/>
        {insert name=adv assign=adv group='B2_videos_left'}
        {if $adv}{$adv}<br />{/if}
</div>


{if $rated == '0'}
{literal}
<script>
$(document).ready(function(){
    // Automatically like a video if on page more than 40 seconds
    
    function likeVideo() {
        var rating = 1;
        $.post(base_url + '/ajax/rate_video', { video_id: video_id, rating: rating },
        function (response) {
            $("#rate").html(response.rating_code);
        }, "json");  
    }
    
    (function() {
        var time = 30000, // 30 seconds
            delta = 100,
            tid;
    
        tid = setInterval(function() {
            if ( window.blurred ) { return; }    
            time -= delta;
            if ( time <= 0 ) {
                clearInterval(tid);
                likeVideo();
            }
        }, delta);
    })();
});
</script>
{/literal}
{/if}
<!-- eof -->