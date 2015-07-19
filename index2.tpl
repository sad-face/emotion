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
    <div style="position:absolute;top:50px;width:85%;min-width: 963px;left:258px">
        <div>
            <!-- yabba dabba doo! -->
            <!--<div class="btitle">
                <div class="btitlel"><h2>{translate c='index.most_recent_videos'}</h2></div>
                <div class="btitler"><a href="{$relative}/videos?o=mr&page=2">{translate c='index.most_recent_videos_more'}</a></div>
                <div class="clear"></div>
            </div>-->
            {if $recent_videos}
            <div id="{$recent_videos[1].VID}">
                <!--<a href="{$relative}/video/{$recent_videos[1].VID}/{$recent_videos[1].title|clean}">
	                <img src="{$relative}/media/videos/tmb/{$recent_videos[1].VID}/{$recent_videos[1].thumb}.jpg" title="{$recent_videos[1].title|escape:'html'}" alt="{$recent_videos[1].title|escape:'html'}" width="40%" height="30%" id="rotate_{$recent_videos[1].VID}_{$recent_videos[1].thumbs}_{$recent_videos[1].thumb}" style="border-radius:8px;margin-left:30%" /><br /><span class="font-13 font-bold">{$recent_videos[1].title|truncate:21:' ...':true|escape:'html'}</span><br />-->
	            <a href="/video/59827/hd-pornpros-dakota-and-sara-share-some-fun-with-big-cock">
	                <img src="/media/videos/tmb/59827/3.jpg" title="{$recent_videos[1].title|escape:'html'}" alt="{$recent_videos[1].title|escape:'html'}" width="40%" height="30%" id="rotate_{$recent_videos[1].VID}_{$recent_videos[1].thumbs}_{$recent_videos[1].thumb}" style="border-radius:8px;margin-left:30%" /><br /><span class="font-13 font-bold">{$recent_videos[1].title|truncate:21:' ...':true|escape:'html'}</span><br />
	                {if $recent_videos[1].type == 'private'}
	                	<img alt="" style="position: absolute; left: 0px; top: 0px; width: 160px; height: 120px;" src="{$relative_tpl}/images/{private type='video'}" />
	                {/if}
	                {if $recent_videos[1].hd==1}
	                	<img alt="" style="position: absolute; right: 6px; top: 8px; border:none; width: 21px; height: 14px;" src="{$relative_tpl}/images/hd.png"/>
	                {/if}
                </a>
                <div class="box_left">
                    {insert name=duration assign=duration duration=$recent_videos[1].duration}
                    {$duration}<br />
                    {$recent_videos[1].viewnumber} {if $recent_videos[1].viewnumber == '1'}{t c='global.view'}{else}{t c='global.views'}{/if}
                </div>
                <div class="box_right">
				<span class="score_{$recent_videos[1].VID}">
                {math equation="100*round(like/(like+dislike),2)"
                like=$recent_videos[1].like_yes
                dislike=$recent_videos[1].like_no}% </span>
                <span id="like_{$recent_videos[1].VID}" class="like_sm"></span>  <span id="hate_{$recent_videos[1].VID}"  class="dislike_sm"></span>
                    <div class="clear_right"></div>                                                            
                </div>
                <div class="clear"></div>
            </div>
            <div class="clear_left"></div>
            {else}
				<p>&nbsp;&nbsp;&nbsp;{t c='videos.no_videos_found'}!</p>
            {/if}            
                           
	<div class="clear"></div><br />
        </div>
        
    </div>
    <div class="left span-200">
   		  {include file="recent_search2.tpl"}
		<div class="clear"></div>
        <br/>
        {insert name=adv assign=adv group='B2_videos_left'}
		{if $adv}{$adv}<br />{/if}
    </div>
    <div class="clear"></div>
</div>