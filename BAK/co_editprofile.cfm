<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ProDriver</title>
<link rel="stylesheet" type="text/css" href="css/global.css" />
<link rel="stylesheet" type="text/css" href="css/profile.css" />
<style type="text/css">
	body { background-image:url(images/new/tpl-bg-3.png); background-repeat:repeat-x; background-color:#2D2D2D;  }
</style>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    $("#login-link").click(function(){
        $("#login-panel").slideToggle(200);
    })
})
$(document).keydown(function(e) {
    if (e.keyCode == 27) {
        $("#login-panel").hide(0);
    }
});
</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <div id="body">
  	<div id="search-button"><a href="#"></a></div>
    <div id="email-button"><a href="#"></a></div>
    <div id="edit-button"><a href="#"></a></div>
    <div id="view-button"><a href="#"></a></div>
  </div>
  <div id="content-container">
  <form>
  	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:10px solid #FFFFFF; margin:20px 0 0 0;">
    	<tr>
      	<td colspan="2" style="background:#4f4f4f;"><div class="page-title">EDIT PROFILE</div></td>
      </tr>
    	<tr>
    	  <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;">
       	<div class="section-title" style="width:596px;">Company Contact Information</div>
        <div class="section-body" style="width:618px;">&nbsp;</div>
        </td>
        <td width="366" rowspan="4" valign="top" style="border-top:3px solid #FFFFFF; border-right:3px solid #FFFFFF; background:#2d2d2d; padding:5px;">
        <div class="section-title" style="width:356px;">Company Logo</div>
        <div class="section-body" style="width:378px; height:66px;">&nbsp;</div>
        <div style="width:100%; height:10px;"></div>
        <div class="section-title" style="width:356px;">Company Contacts</div>
        <div class="section-body" style="width:368px; padding:5px;">
        <input class="co_contacts" type="text"><input class="co_contacts" type="text">
        <input class="co_contacts" type="text"><input class="co_contacts" type="text">
        <input class="co_contacts" type="text"><input class="co_contacts" type="text"></div>
        </td>
  	  </tr>
    	<tr>
    	  <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;">
       	<div class="section-title" style="width:596px;">About </div>
        <div class="section-body" style="width:618px;"><textarea class="co_about"></textarea></div>
        </td>
  	  </tr>
      <tr>
      	<td colspan="2" style="height:40px; width:100%; background-color:#fff;">
        	<button type="submit" class="save_changes">
        </td>
      </tr>
    </table>
    </form>
    <div style="clear:both;"></div>
  </div>
  <div id="footer">
    <div id="footer-line">ProDriver.com&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;All Rights Reserved&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;About Us&nbsp;&nbsp;-&nbsp;&nbsp;Contact Us&nbsp;&nbsp;-&nbsp;&nbsp;Terms and Conditions</div>
  </div>
</div>
</body>
</html>