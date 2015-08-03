<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>{if isset($self_title) && $self_title != ''}{$self_title|escape:'html'}{else}{$site_name}{/if}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="robots" content="index, follow" />
    <meta name="revisit-after" content="1 days" />
    <meta name="keywords" content="{if isset($self_keywords) && $self_keywords != ''}{$self_keywords|escape:'html'}{else}{$meta_keywords}{/if}" />
    <meta name="description" content="{if isset($self_description) && $self_description != ''}{$self_description|escape:'html'}{else}{$meta_description}{/if}" />
    <link rel = "stylesheet" id="switch_style" href="/templates/frontend/{php}if (isset($_COOKIE['template'])) {echo $_COOKIE['template'];} else {echo 'blue';}{/php}/css/style2.css" type = "text/css" />
    <link rel = "stylesheet" id="switch_style1" href="/templates/frontend/{php}if (isset($_COOKIE['template'])) {echo $_COOKIE['template'];} else {echo 'blue';}{/php}/css/style_menu.css" type = "text/css" />
	<link rel="Shortcut Icon" type="image/ico" href="/favicon.ico" />
    <!--[if IE 7]><link rel="stylesheet" type="text/css" href="{$relative_tpl}/css/style_ie7.css" /><![endif]-->
    <!--[if IE 6]><link rel="stylesheet" type="text/css" href="{$relative_tpl}/css/style_ie6.css" /><![endif]-->
    <script type="text/javascript">
    var base_url = "{$baseurl}";
    var tpl_url = "{$relative_tpl}";
    {if isset($video.VID)}var video_id = "{$video.VID}";{/if}
</script>
    <script type="text/javascript" src="{$relative_tpl}/js/jquery-1.2.6.pack.js"></script>
    <script type="text/javascript" src="{$relative_tpl}/js/jquery.livequery.pack.js"></script>
    <script type="text/javascript" src="{$relative_tpl}/js/jquery.rotator-0.2.js"></script>
    <script src="{$relative_tpl}/js/py.js"></script>
    {if $submenu_tag_scroller == '1'}<script type="text/javascript" src="{$relative_tpl}/js/jscroller2-1.5.js"></script>{/if}
    <script type="text/javascript" src="{$relative_tpl}/js/jquery.avs-0.2.js"></script>
    {if $submenu_tag_scroller == '1'}<script type="text/javascript" src="{$relative_tpl}/js/jscroller2-1.5.js"></script>{/if}
    {literal}
    <script>
    function setCookie(cname,cvalue,exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays*24*60*60*1000));
        var expires = "expires=" + d.toGMTString();
        document.cookie = cname+"="+cvalue+"; "+expires+"; path=/";
    }
    (function ($j) {
        switch_style = {
        onReady: function () {      
            this.switch_style_click();
        },
        switch_style_click: function(){
    	$( ".templates" ).change(function() {
		//var color=getCookie("template");
		//setCookie("template", color, 30);
		var id = "/templates/frontend/"+$(this).val()+"/css/style.css";
		var id1 = "/templates/frontend/"+$(this).val()+"/css/style_menu.css";
		var id2 = "/templates/frontend/"+$(this).val()+"/images/logo.png";
    		$("#switch_style").attr("href", id );    		
    		$("#switch_style1").attr("href", id1 );    		
    		$("#switch_style2").attr("src", id2 );
		color = $(this).val();
		document.cookie = "template=; expires=Thu, 01 Jan 1970 00:00:00 UTC";
		setCookie("template", color, 20*365);    		
    	});
    },
  };

  $j().ready(function () {
	  switch_style.onReady();
  });

})(jQuery);	

</script> 
<!-- ALERT MOD -->
<script>
$( document ).ready(function() {
	$(".alert_message .close" ).click(function() {
  		$(".alert_message").fadeOut();
		var alert_id = 'alert_'+{/literal}{$alert_id}{literal};
		document.cookie = "alert=; expires=Thu, 01 Jan 1970 00:00:00 UTC";
		setCookie(alert_id, "dismissed", 20*365);
	});
	refactorSwitch(location.pathname);
});
</script>
     
  <style>
  .alert_message {width:100%;padding:8px 0;margin:-10px auto 20px 0;background:#3399ff;color:#fff;font-size:14px;position:relative;text-align:left;text-align:center;}
  .alert_message .close {padding:8px 10px;position:absolute;top:0;right:0;color:#fff;opacity:.8;text-indent:0;}
  .alert_message .close:hover {opacity:1;cursor:pointer}
  </style>
<!-- END ALERT MOD -->
<link href='http://fonts.googleapis.com/css?family=Telex' rel='stylesheet' type='text/css'>

    {/literal}
</head>
<body>
<div id="container">
    <div id="header">
        <!-- PORNDORA BETA HEADER -->
        <span id="porndora">PORNDORA</span>
        <span id="beta">BETA</span>
        <div class="nav_tab" onclick="location.href='/login2.php'">SIGN UP</div>
        <div class="nav_tab" style="right:15%" onclick="location.href='/login2.php'">LOGIN</div>
    </div>
<!-- eof -->