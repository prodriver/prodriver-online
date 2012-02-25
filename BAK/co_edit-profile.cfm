<cfparam name="URL.pid" default="#SESSION.account.id#">

<cfquery name="account_rs" datasource="#application.datasource#">
	SELECT * 
  FROM accounts 
  WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.pid#">
</cfquery>

<cfquery name="professions_rs" datasource="#application.datasource#">
	SELECT professions.*, profession_types.profession_title
  FROM professions
  INNER JOIN profession_types
  ON professions.profession_id = profession_types.profession_id
  WHERE professions.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.pid#">
</cfquery>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ProDriver</title>
<link rel="stylesheet" type="text/css" href="css/global.css" />
<link rel="stylesheet" type="text/css" href="css/profile.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.dop.BookingCalendar.css" />
<style type="text/css">
body { background-image:url(images/new/tpl-bg-3.png); background-repeat:repeat-x; background-color:#2D2D2D; }
</style>
<script type="text/javascript" src="js/all.js"></script>
<script type="text/javascript" src="js/jquery.dop.BookingCalendar.js"></script>
<script type="text/javascript">_this.init("profile");</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <cfinclude template="inc-menu.cfm">
  <div id="content-container">
    <form>
      <table cellspacing="0" cellpadding="0" border="0" width="1008" style="border:5px solid #fff;">
      	<tr>
        <td style="border-bottom:5px solid #fff;">
      	<div class="page-title">EDIT PROFILE</div>
        </td>
        </tr>
        <tr>
        <td>
        <table width="628" cellpadding="0" cellspacing="0" border="0" style=" padding:5px; float:left;" >
        	<tr>
            <td>
            <div class="section-title">Company contact Information</div>
            <div class="section-body">
            	<div style="float:left; width:30%; border-right:1px solid #666; padding:5px; font-size:14px; font-weight:bold; color:#000;">
                Company Name<Br>
                <input type="text" name="co_name" id="co_name"><br>
                Address<br>
                <input type="text" name="street" id="street"><br>
                <input type="text" name="street2" id="street2"><br>
                <input type="text" name="city" id="city"><br>
                <input type="text" name="state" id="state"><br>
                <input type="text" name="zip" id="zip" maxlength="10"><br>
                </div>
                <div style="float:left; width:30%; border-right:1px solid #666; padding:5px; font-size:14px; font-weight:bold; color:#000; line-height:22px;">
                Telephone<br>
                <input type="text" name="telephone" id="telephone"><br>
                Website<br>
                <input type="text" name="website" id="website"><br><br><br><br><br>
                </div>
                <div style="clear:both;"></div>
            </div>
            </td>
            </tr>
            </table>
            <table width="628" cellpadding="0" cellspacing="0" border="0" style=" padding:5px; float:left;" >
            <tr>
            <td>
            	<div class="section-title">About</div>
                <div class="section-body" style="padding:5px;">
        <textarea style="margin-top:5px; margin-left:2%; width:96%; height:155px;"></textarea></div>
        <div style="clear:both;"></div>
            </td>
            </tr>
        </table>
        <table width="368" cellspacing="0" cellpadding="0" border="0" style="padding:5px;">
        <tr>
        <td>
        	<div class="section-title">Company Logo</div>
            <div class="section-body" style="min-height:75px;">
            	<div style="float:left; width:100px; padding:3px;">
            		<img src="images/profile_pics/12.jpg"></div>
            	<div style="float:left; width:200px; padding:3px; padding-top:15px;">Upload Photo<br><input type="file"></div>
            	<div style="clear:both;"></div>
            </div>
        </td>
        </tr>
        </table>
        <table width="368" cellspacing="0" cellpadding="0" border="0" style="padding:5px;">
        <tr>
        <td>
        	<div class="section-title" style="background-color:#4f4f4f; color:#fff;">Company Contacts</div>
            <div class="section-body" style="min-height:286px; padding:10px;">
            <div style="float:left; width:50%;">
            Patrick Hereford<br><br>
            <input type="text" size="15" name="contact2" id="contact2"><br><br>
            
            <input type="text" size="15" name="contact3" id="contact3">
           
            </div>
            <div style="float:left;">
            phereford@gmail.com<br><br>
            <input type="text" size="15" name="contact_email2" id="contact_email2"><br><br>
            <input type="text" size="15" name="contact_email3" id="contact_email3">
            </div>
           
            <div style="clear:both;"></div>
            </div>
        </td>
        </tr>
        </table>
        </td>
        </tr>
        <tr>
        <td>
        <div class="section-title" style="background-color:#fff; height:35px;">
        	<div style="float:left; line-height:35px;">
        		<img src="images/sv_changes.png">
        	</div>
            <div style="clear:both;"></div>
            </div>
        </td>
        </tr>
      </table>
      <div style="clear:both;"></div>
    </form>
    <div style="clear:both;"></div>
  </div>
  <div id="footer">
    <div id="footer-line">ProDriver.com&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;All Rights Reserved&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;About Us&nbsp;&nbsp;-&nbsp;&nbsp;Contact Us&nbsp;&nbsp;-&nbsp;&nbsp;Terms and Conditions</div>
  </div>
</div>
</body>
</html>