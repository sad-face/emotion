<script type="text/javascript" src="{$relative_tpl}/js/jquery.jtruncate.js"></script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.video-0.2.js"></script>

<div id="content">
    <div class="left span-630">
        <h1>{$video.title|escape:'html'}</h1>
        <div id="player">
        {if $deviceType != 'computer'}
            {include file='video_mobile.tpl'}
        {else}
            {if $is_friend && !$guest_limit}
            {include file='video_vplayer.tpl'}
            {/if}
        {/if}
        </div>
    </div>
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