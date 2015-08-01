<?php

define('_VALID', true);
require 'include/config.php';
require 'include/function_global.php';
require 'include/function_smarty.php';
require 'classes/pagination.class.php';

if ( $config['video_view'] == 'registered' ) {
    require 'classes/auth.class.php';
    Auth::check();
}

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


// RECENT SEARCHES MOD
// sad-face: if no recent searches, no $terms, so splash page
$ip		= ip2long($_SERVER['REMOTE_ADDR']);
$uid 	= $_SESSION['uid'];
$searches	= array('d', 'a');



function printArr($x){
    for($i=0;$i<count($x);$i++){
        echo $x[$i];
        echo "<br>";
    }
}
function deepArr($x){
    for($i=0;$i<count($x);$i++){
    	if(is_array($x[$i])){
    	    deepArr($x[$i]);
    	}else{
            echo $x[$i];
            echo "<br>";
        }
    }
}
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
// deepArr($terms);
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

$vid=$recent_videos[2][0];
if ( !$vid ) {
    VRedirect::go($config['BASE_URL']. '/error/video_missing');
}

$active     = ( $config['approve'] == '1' ) ? " AND v.active = '1'" : NULL;
$sql        = "SELECT v.VID, v.UID, v.title, v.channel, v.keyword, v.viewnumber, v.type, v.like_yes, v.like_no,
                      v.addtime, v.rate, v.ratedby, v.flvdoname, v.space, v.embed_code, v.width_sd, v.height_sd,v.hd,
					  u.username, u.fname
               FROM video AS v, signup AS u WHERE v.VID = " .$vid. " AND v.UID = u.UID" .$active. " LIMIT 1";// query string
$rs         = $conn->execute($sql);// object

if ( $conn->Affected_Rows() != 1 ) {
    VRedirect::go($config['BASE_URL']. '/error/video_missing');
}
$hd = $rs->fields['hd'];
$video_width		= $rs->fields['width_sd'];
$video_height		= $rs->fields['height_sd'];
$player_width = 1830;
$autoheight	= round($player_width * ($video_height/$video_width) + 22);


$video              = $rs->getrows();
$video              = $video['0'];
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

$pagination     = new Pagination(10, 'p_related_videos_' .$video['VID']. '_');
$limit          = $pagination->getLimit($total_related);

/* SLOW QUERY 
$sql            = "SELECT VID, title, duration, addtime, rate, viewnumber, type, thumb, thumbs, like_yes,like_no FROM video
                   WHERE VID NOT IN (".$block_list.") AND active = '1' AND channel = '" .$video['channel']. "' AND VID != " .$vid. "
                   AND ( title LIKE '%" .mysql_real_escape_string($video['title']). "%' " .$sql_add. ")
                   ORDER BY addtime DESC LIMIT " .$limit;
*/

// Remove keyword search
$sql            = "SELECT VID, title, duration, addtime, rate, viewnumber, viewtime, type, thumb, thumbs, like_yes,like_no FROM video
                   WHERE VID NOT IN (".$block_list.") AND active = '1' AND channel = '" .$video['channel']. "' AND VID != " .$vid. "
                   ORDER BY viewtime DESC LIMIT " .$limit;
		   
				   
$rs             = $conn->execute($sql);
$videos         = $rs->getrows();
$page_link      = $pagination->getPagination('video');

$sql            = "SELECT COUNT(CID) AS total_comments FROM video_comments WHERE VID = " .$vid. " AND status = '1'";
$rsc            = $conn->execute($sql);
$total_comments = $rsc->fields['total_comments'];
$pagination     = new Pagination(10);
$limit          = $pagination->getLimit($total_comments);
$sql            = "SELECT c.CID, c.UID, c.comment, c.addtime, s.username, s.photo, s.gender
                   FROM video_comments AS c, signup AS s 
                   WHERE c.VID = " .$vid. " AND c.status = '1' AND c.UID = s.UID 
                   ORDER BY c.addtime DESC LIMIT " .$limit;
$rs             = $conn->execute($sql);
$comments       = $rs->getrows();
$page_link_c    = $pagination->getPagination('video', 'p_video_comments_' .$video['VID']. '_');
$page_link_cb   = $pagination->getPagination('video', 'pp_video_comments_' .$video['VID']. '_');
$start_num      = $pagination->getStartItem();
$end_num        = $pagination->getEndItem();

$self_title         = $video['title'] . $seo['video_title'];
$self_description   = $video['title'] . $seo['video_desc'];
$self_keywords      = implode(', ', $video['keyword']) . $seo['video_keywords'];

// START RATING MOD
$sql    = "SELECT like_yes, like_no, ratedby FROM video WHERE VID = " .$vid. " LIMIT 1";
$rsc	= $conn->execute($sql);
$like	= $rsc->fields['like_yes'];
$dislike	= $rsc->fields['like_no'];
$ratedby	= $rsc->fields['ratedby'];
$rating = (100*round($like/($dislike+$like),2));
$smarty->assign('rating',$rating);
$smarty->assign('ratedby',$ratedby);
$smarty->assign('like',$like);
$smarty->assign('dislike',$dislike);
// END RATING MOD

$ip    			= ip2long($_SERVER['REMOTE_ADDR']);
/*
$sql    = "SELECT VID FROM video_vote_ip WHERE VID = " .$vid. " AND ip = " .$ip. " LIMIT 1";
$conn->execute($sql);
	
		if ( $conn->Affected_Rows() == 1 ) {
			$rated = 1;
		} else {
			$rated = 0;
		}
*/
$rated = '0';
$sql    = "SELECT VID FROM video_vote_ip WHERE VID = " .$vid. " AND ip = " .$ip. " LIMIT 1";
$conn->execute($sql);
if ( $conn->Affected_Rows() == 1 ) {
	$sql    = "SELECT VID FROM likes WHERE VID = " .$vid. " AND IP = " .$ip. " LIMIT 1";
	$conn->execute($sql);
	if ( $conn->Affected_Rows() == 1 ) {
			$rated = '2';
	}
	$sql    = "SELECT VID FROM dislikes_ip WHERE VID = " .$vid. " AND IP = " .$ip. " LIMIT 1";
	$conn->execute($sql);
	if ( $conn->Affected_Rows() == 1 ) {
				$rated = '1';
	} 
}





// END RECENT SEARCHES MOD
// video.php
$smarty->assign('deviceType',$deviceType);
$smarty->assign('rated',$rated);
$smarty->assign('menu', 'videos');
$smarty->assign('submenu', '');
$smarty->assign('view', true);
$smarty->assign('autoheight',$autoheight);
$smarty->assign('player_width',$player_width);
$smarty->assign('hd',$hd);
$smarty->assign('video', $video);
$smarty->assign('self_title', $self_title);
$smarty->assign('self_description', $self_description);
$smarty->assign('self_keywords', $self_keywords);
$smarty->assign('videos_total', $total_related);
$smarty->assign('videos', $videos);
$smarty->assign('page_link', $page_link);
$smarty->assign('comments_total', $total_comments);
$smarty->assign('comments', $comments);
$smarty->assign('page_link_comments', $page_link_c);
$smarty->assign('page_link_comments_bottom', $page_link_cb);
$smarty->assign('start_num', $start_num);
$smarty->assign('end_num', $end_num);
$smarty->assign('is_friend', $is_friend);
$smarty->assign('guest_limit', $guest_limit);
// original
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
if (!$terms) { $smarty->display('splash2.tpl'); }
//	}
//$smarty->display('footer2.tpl');
$smarty->gzip_encode();
?>