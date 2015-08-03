<!-- SPLASH OVERLAY -->

{literal}
<script type="text/javascript" src="{$relative_tpl}/js/jquery.blog-0.1.js"></script>
<!--<script>
$(document).ready(function(){
    $(".logo").click(function(){
    	$('#tagwoo').css({'width': '200px'},{'height':'150ox'});
        $("#tagwoo").attr("src","http://www.porndora.sexy/templates/frontend/blue/images/bigblackdick.png");
        
    });
});
</script>-->

<style type="text/css">
	.overlay {width:100%;height:100%;background-image:url("http://www.porndora.sexy/templates/frontend/blue/images/splash_image.jpg");color:#fff;z-index:99999;position:fixed;top:0;left:0;opacity:1.00;display:block;}
	#container1 { width: 650px; margin:auto;text-align:center;}
	.logo {	margin: 100px auto 30px auto}
	#warning { font: normal 28px "Lucida Sans Unicode", Arial; color: #eee; letter-spacing: -1px; }
	#warning2 {	margin: 20px 0 0 0;	font: normal 16px "Lucida Sans Unicode", Arial;	color: #FFFFFF; }
	.search {width:340px;margin:auto;overflow:auto;}
	.search_box {width:200px;padding:8px !important;float:left;margin:0 !important;}
	.splashbutton {width:100px;margin:0;float:right;border:0;background:#C00;color:#fff;height:32px;}
	.splashbutton:hover {cursor:pointer;background:#F00}
</style>
{/literal}

<div class="overlay">
    <div id="container1">
	<div class="logo">
	    <br><br><br><br><br><br>
	</div>
	<div class="clear"></div>
	<div id="warning" style="color:blue" class="align-center">What Is MagnaCarta?</div>
	<div id="warning2" style="color:blue" class="align-center">
	    MagnaCarta provides a better viewing experience by playing only videos that you will love.
	</div>
	<br /><br />
        <div class="search">
            <form name="search"  method="get" action="{$relative}/search">
               	<div id="search_form">
	            <input name="search_query" type="text" id="search_query" style="padding-left: 10% !important" class="search_box" value="" placeholder="Enter a term to create a personalized station" />
	        </div>
               	<select class="searchselect" name="search_type" id="search_type" style="display:none">
		    <option value="videos" selected="yes">{translate c="global.videos"}</option>
                </select>
                <!-- <input type="button" value="Categories" class="splashbutton left" onclick="window.location.href='{$baseurl}/categories'" /> -->
                <input type="submit" value="{t c="ajax.search"}" style="display:none" class="splashbutton" maxlength="50" />
            </form>
        </div>
    </div>
</div>