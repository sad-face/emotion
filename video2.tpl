<script type="text/javascript" src="{$relative_tpl}/js/jquery.jtruncate.js"></script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.video-0.2.js"></script>
<div id="content">
{if $hd == '1'}
	<div>
		<h1>{$video.title|escape:'html'}</h1>

        {if $deviceType != 'computer'}
            {include file='video_mobile.tpl'}
        {else}
            {if $is_friend && !$guest_limit}
            {include file='video_vplayer.tpl'}
            {/if}
        {/if}
	<br />
	</div>

	<div class="left span-630">
        {if $video_embed == '1' && $video.embed_code == '' && $is_friend}
        <div id="embed_video_box" style="display: none;">
            <div class="box">
                <div class="btitle"><h2>{t c='video.EMBED'}</h2></div>
                <div class="blink"><a href="#close_embed" id="close_embed">{t c='global.close'}</a></div>
                <div class="clear_right"></div>
				{include file='video_embed_vplayer.tpl'}
            </div>
        </div>
        {/if}
    </div>


{/if}
{if $hd == '0'}
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

{/if}

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