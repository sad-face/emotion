<div id="login">
    <h2 style="text-align:center">{t c='login.title' s=$site_name}</h2>
    <form name="login_form" id="login_form" method="post" action="{$relative}/login">
            <input name="username" type="text" value="" id="login_username" placeholder="Username" />
            <br /><br />
            <input name="password" type="password" value="" id="login_password" placeholder="Password" />
            <br />
            <input name="login_remember" type="checkbox" id="login_remember" class="checkbox" />&nbsp;{t c='global.remember'}
            <br />
            <a href="{$relative}/lost" rel="nofollow" id="lost_password">{t c='global.forgot'}</a>
            <br />
            <a href="{$relative}/confirm" rel="nofollow" id="confirmation_email">{t c='global.confirm'}</a>
            <br />
            <input name="submit_login" type="submit" value="{t c='global.login'}" id="login_submit" style="display:none" />
            <div onclick="document.getElementById('login_submit').click()" id="submit_button">Login</div>
    </form>
</div>
<br />
<div id="what_is">      
    <h2>{t c='global.what_is' s=$site_name}</h2>
    {include file='static/whatis.tpl'}
</div>

<!-- eof -->