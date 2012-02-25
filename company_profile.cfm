<!--- if an id is not established, redirect to the first page of the signup process --->
<cfif not isdefined("COOKIE.accountID") or COOKIE.accountID eq "">
	<cflocation url="index.cfm">
</cfif>

<cfquery name="account_rs" datasource="#application.datasource#">
	SELECT * 
  FROM accounts 
  WHERE accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#COOKIE.accountID#">
</cfquery>

<cfquery name="professions_rs" datasource="#application.datasource#">
	SELECT *
  FROM professions
  WHERE professionID
  IN (#account_rs.accountProfessions#)
</cfquery>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ProDriver</title>
<link rel="stylesheet" type="text/css" href="css/global.css" />
<link rel="stylesheet" type="text/css" href="css/profile.css" />
<style type="text/css">
body { background-image:url(images/new/tpl-bg-3.png); background-repeat:repeat-x; background-color:#2D2D2D; }
</style>
<script type="text/javascript" src="js/all.js"></script>
<script type="text/javascript">_this.init();</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <div id="body">
    <cfif COOKIE.ACCOUNT_TYPE eq 1><div id="search-button"><a href="#"></a></div></cfif>
    <div id="email-button"><a href="#"></a></div>
    <cfif COOKIE.ACCOUNT_TYPE eq 2><div id="mycal-button"><a href="driver_cal.cfm"></a></div></cfif>
    <div id="edit-button"><a href="#"></a></div>
  </div>
  <div id="content-container">
    <form>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:10px solid #FFFFFF; margin:20px 0 0 0;">
        <tr>
          <td colspan="2" style="background:#4f4f4f;">
          <div class="page-title">COMPANY PROFILE</div>
          </td>
        </tr>
        <tr>
          <td width="210" rowspan="4" valign="top" style="border-top:3px solid #FFFFFF; border-right:3px solid #FFFFFF; background:#4f4f4f;">
          <div class="prof_image"><img src=""></div>
          <div style="clear:both;"></div>
          <div class="prof_sidebar">
            <div style="border:1px solid #666; width:186px; margin-top:10px;"></div>
            <div style="margin-top:10px;"> <img src="images/email_co_btn.png"> </div>
            <div style="border:1px solid #666; width:186px; margin-top:10px;"></div>
          </div>
          </td>
          <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;">
          <div class="section-title">Company Name</div>
          <div class="section-body">
            <div class="top">
              <div class="one">Website<br> <span style="color:#fff; font-size:12px;">http://www.longesturlinhistoryevar.com</span> </div>
              <div class="two">Telephone<br> <span style="color:#fff; font-size:12px;">781-111-0987</span> </div>
              
              <div class="one" style="font-size:14px; color:#e6ae02; font-weight:bold; margin-top:15px;">Address<br> <span style="color:#000; font-size:12px;"><cfoutput>#account_rs.account_current_employer#</cfoutput></span> </div>
              <div class="two"  style="font-size:14px; color:#e6ae02; font-weight:bold; margin-top:15px; ">Contacts<br> <span style="color:#000; font-size:12px;"><cfoutput>#account_rs.accountCanadaRequirements#</cfoutput></span> </div>
          </div>
          </td>
        </tr>
        <tr>
          <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;">
          <div class="section-title">About Us</div>
          <div class="section-body" style="min-height:135px; max-height:600px; padding-top:10px; padding-left:10px; padding-bottom:10px; font-size:12px; font-family:Verdana, Geneva, sans-serif;">
          Welcome to Westwood Leasing, a full service coach company. We provide custom coach transportation for the entertainment 
industry, corporate lease and private charter. We service many of the top named artist in the music industry, Fortune 500 
company travel as well as serving the North Alabama region with corporate car service. If you need professional 
transportation that excels in comfort and luxury, you should give us a call.<br><br>

Services<br><br>

    * Entertainer<br>
    * Corporate and Limo<br>
    * Private<br><br>

What can Westwood do for you?


          </div>
          </td>
        </tr>
      </table>
    </form>
    <div style="clear:both;"></div>
  </div>
  <div id="footer">
    <cfinclude template="inc-footer.cfm">
  </div>
</div>
</body>
</html>