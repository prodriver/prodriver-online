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
      	<div class="page-title">EDIT MY PROFILE</div>
        </td>
        </tr>
        <tr>
        <td>
        <table width="628" cellpadding="0" cellspacing="0" border="0" style=" padding:5px; float:left;" >
        	<tr>
            <td>
            <div class="section-title">General Information</div>
            <div class="section-body">
            	<div style="float:left; width:30%; border-right:1px solid #666; padding:5px; font-size:14px; font-weight:bold; color:#000;">
                Current Employer<Br>
                <input type="text" name="current_employer" id="current_employer"><br>
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
                Marital Status<br>
                <input type="text" name="marital" id="marital"><br>
                Date of Birth<br>
                <input type="text" name="dob" id="dob"><br>
                Smoker<br>
                <select name="smoker" id="smoker">
                	<option>Yes</option>
                    <option>No</option>
                </select><br>
                </div>
                <div style="float:left; width:30%; padding:5px; font-size:14px; font-weight:bold; color:#000; line-height:22px;">
                Passport<br>
                <select name="passport" id="passport">
                	<option>Yes</option>
                    <option>No</option>
                </select><br>
                Canada Driver Certified<br>
                <select name="canada" id="canada">
                	<option>Yes</option>
                    <option>No</option>
                </select><br>
                Current City<br>
                <input type="text" name="cur_city" id="cur_city"><br>
                Preferred Airport<br>
                <input type="text" name="airport" id="airport">
                </div>
                <div style="clear:both;"></div>
            </div>
            </td>
            </tr>
            </table>
            <table width="628" cellpadding="0" cellspacing="0" border="0" style=" padding:5px; float:left;" >
            <tr>
            <td>
            	<div class="section-title">Edit Biography</div>
                <div class="section-body" style="padding:5px;"><button value="hide">Hide</button>You can hide or show your biography on your profile.<br>
        <textarea style="margin-top:5px; margin-left:2%; width:96%; height:155px;"></textarea></div>
        <div style="clear:both;"></div>
            </td>
            </tr>
        </table>
        <table width="368" cellspacing="0" cellpadding="0" border="0" style="padding:5px;">
        <tr>
        <td>
        	<div class="section-title">Edit Profile Picture</div>
            <div class="section-body" style="min-height:75px;">
            	<div style="float:left; width:100px; padding:3px;">
            		<img src="images/profile_pics/12.jpg"></div>
            	<div style="float:left; width:200px; padding:3px; padding-top:15px;">Upload Image<br><input type="file"></div>
            	<div style="clear:both;"></div>
            </div>
        </td>
        </tr>
        </table>
        <table width="368" cellspacing="0" cellpadding="0" border="0" style="padding:5px;">
        <tr>
        <td>
        	<div class="section-title">Edit Professions</div>
            <div class="section-body" style="min-height:65px;">
            	<input style="margin-left:5px; margin-top:5px; margin-right:5px;" type="checkbox">Entertainment<input style="margin-left:45px; margin-top:5px; margin-right:5px;" type="checkbox">Private<input style="margin-left:45px; margin-top:5px; margin-right:5px;" type="checkbox">Limo<br><input style="margin-left:5px; margin-top:5px; margin-right:5px;" type="checkbox">Charter<input style="margin-left:91px; margin-top:5px; margin-right:5px;" type="checkbox">Corporate
            </div>
        </td>
        </tr>
        </table>
        <table width="368" cellspacing="0" cellpadding="0" border="0" style="padding:5px;">
        <tr>
        <td>
        	<div class="section-title" style="background-color:#4f4f4f; color:#fff;">Update Credentials</div>
            <div class="section-body" style="min-height:170px;">
            	<div style="float:left; width:48%; margin-left:2%; font-size:12px; font-weight:bold; margin-top:5px;">
            Driver Application 
            <input type="file" size="10" name="driver_app" id="driver_app"><br>
            Current MVR
            <input type="file" size="10" name="mvr" id="mvr">
            Social Security Card
            <input type="file" size="10" name="ssn" id="ssn">
            Criminal Background Check
            <input type="file" size="10" name="criminal" id="criminal">
            </div>
            <div style="float:left; width:48%; font-size:12px; font-weight:bold; margin-top:5px;">
            DOT Medical Card
            <input type="file" size="10" name="DOT" id="DOT">
            Medical Exam
            <input type="file" size="10" name="medical" id="medical">
            Current W-2
            <input type="file" size="10" name="w2" id="w2">
            Current I-9
            <input type="file" size="10" name="i9" id="i9">
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
        	<div style="float:right; line-height:35px;">
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