<?php
define('_VALID', true);
require 'include/config.php';
require 'include/function_global.php';
require 'include/function_smarty.php';

$sql_add	= NULL;
$sql_delim	= ' WHERE';
if ( $config['show_private_videos'] == '0' ) {
    $sql_add   .= $sql_delim. " type = 'public'";
    $sql_delim	= ' AND';
}

$sql_add       .= $sql_delim. " active = '1'";

// START BLOCK MOD
$ip			= 	ip2long($_SERVER['REMOTE_ADDR']);
$sql		= "SELECT VID FROM dislikes_ip WHERE IP = " .$ip;
$result		=  mysql_query($sql);
$var 		=  array();
while ($rw = mysql_fetch_array($result)) {
  $var[] = $rw['VID'];
}
foreach($var as $vars) {
   $string[] .= $vars;
}
$block_list = implode(",", $string);
if (empty($string)) {$block_list = 0;}
// END BLOCK MOD

$sql            = "SELECT VID, title, duration, addtime, thumb, thumbs, viewnumber, rate, type, like_yes, like_no, hd
                   FROM video WHERE active = '1' AND channel NOT IN (25,43) AND VID NOT IN ( ".$block_list.") ORDER BY viewtime DESC LIMIT " .$config['watched_per_page'];
$rs             = $conn->execute($sql);
$viewed_videos  = $rs->getrows();

$sql            = "SELECT VID, title, duration, addtime, thumb, thumbs, viewnumber, rate, type, like_yes, like_no, hd
                   FROM video WHERE active = '1' AND channel NOT IN (25,43) AND VID NOT IN (".$block_list.") ORDER BY addtime DESC LIMIT " .$config['recent_per_page'];
$rs             = $conn->execute($sql);
$recent_videos  = $rs->getrows();
$short=$recent_videos[0];


// RECENT SEARCHES MOD
$ip		= ip2long($_SERVER['REMOTE_ADDR']);
$uid 	= $_SESSION['uid'];
$searches	= array('d', 'a');
$search		= ( isset($_GET['so']) && in_array($_GET['so'], $searches) ) ? $_GET['so'] : 'd';
switch ( $search ) {
    case 'd':
        $s_order	= "addtime DESC";
        break;
    case 'a':
        $s_order	= "keywords ASC";
        break;
}

if ( isset($_SESSION['uid']) ) {
	$sql            = "SELECT keywords,addtime FROM terms WHERE UID = '".$uid."' ORDER BY ".$s_order." LIMIT 30";
} else {
	$sql            = "SELECT keywords,addtime FROM terms WHERE IP = '".$ip."' ORDER BY ".$s_order." LIMIT 30";
}

$rs				= $conn->execute($sql);
$terms			= $rs->getrows();
$smarty->assign('terms', $terms);

// added by sad-face: hide private videos from non-friends
$video              = $rs->getrows();
$video              = $video['0'];
$guest_limit	    = false;
if ( !isset($_SESSION['uid']) && $config['guest_limit'] == '1' ) {
    $remote_ip = ip2long($remote_ip);
    require $config['BASE_DIR']. '/classes/bandwidth.class.php';
    $guest_limit = VBandwidth::check($remote_ip, intval($video['space']));
}
$video['keyword']   = explode(' ', $video['keyword']);
$uid                = ( isset($_SESSION['uid']) ) ? intval($_SESSION['uid']) : NULL;
$is_friend          = true;
if ( $video['type'] == 'private' && $uid != $video['UID'] ) {
    $sql = "SELECT FID FROM friends
            WHERE ((UID = " .intval($video['UID']). " AND FID = " .$uid. ")
            OR (UID = " .$uid. " AND FID = " .intval($video['UID']). "))
            AND status = 'Confirmed'
            LIMIT 1";
    $conn->execute($sql);
    if ( $conn->Affected_Rows() == 0 ) {
        $is_friend = false;
    }
}


// END RECENT SEARCHES MOD

$smarty->assign('errors',$errors);
$smarty->assign('messages',$messages);
$smarty->assign('menu', 'home');
$smarty->assign('index', true);
$smarty->assign('viewed_total', $viewed_total);
$smarty->assign('viewed_videos', $viewed_videos);
$smarty->assign('recent_videos', $recent_videos);
$smarty->assign('self_title', $seo['index_title']);
$smarty->assign('self_description', $seo['index_desc']);
$smarty->assign('self_keywords', $seo['index_keywords']);
$smarty->assign('is_friend', $is_friend);
$smarty->display('header2.tpl');
$smarty->display('errors.tpl');
$smarty->display('messages.tpl');
$smarty->display('index2.tpl');
//if (!isset($_COOKIE['splash'])) {
if (!$terms) { $smarty->display('splash.tpl'); }
//	}
//$smarty->display('footer2.tpl');
$smarty->gzip_encode();
?>