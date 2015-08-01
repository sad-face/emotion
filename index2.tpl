{literal}
<script>
	document.cookie="template=blue";
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
    <div style="position:absolute;top:50px;width:82%;left:258px">
        <script type="text/javascript" src="{$relative_tpl}/js/jquery.jtruncate.js"></script>
	<script type="text/javascript" src="{$relative_tpl}/js/jquery.video-0.2.js"></script>
            
        <!-- added by sad-face from video.tpl -->
        
                
        <div id="player">
        {if $deviceType != 'computer'}
            {include file='video_mobile.tpl'}
        {else}
            {if $is_friend && !$guest_limit}
            {include file='video_vplayer2.tpl'}
            {/if}
        {/if}
        </div>
        <h2 style="margin-left:20px;float:left;color:rgb(255, 192, 203);font-size:24px">{$video.title|escape:'html'}</h2>
        <div style="margin-right:20px;float:right;right:20px" class="video_actions">
	    <div style="background-color:pink !important" id="like"></div>
            <div style="background-color:pink !important" id="dislike"></div>
            <i style="color: white; font-size: 18px; border: 13px solid rgb(255, 192, 203);background-color:pink" class="fa fa-fast-forward"></i>
        </div>
        <br><br> <br><br><br>
        <div class="video_tags" id="video_tags">
                {t c='global.tags'}:
                {assign var='keywords' value=$video.keyword}
                {section name=i loop=$keywords}
                <a href="{$relative}/search?search_type=videos&search_query={$keywords[i]}">{$keywords[i]}</a>,
                {/section}
        </div>
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