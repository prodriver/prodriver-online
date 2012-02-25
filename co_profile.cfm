<cfparam name="URL.pid" default="#SESSION.account.id#">

<cfquery name="account_rs" datasource="#application.datasource#">
	SELECT * 
  FROM accounts 
  WHERE accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.pid#">
</cfquery>

<cfquery name="professions_rs" datasource="#application.datasource#">
	SELECT professions.*, professionTypes.professionTitle
  FROM professions
  INNER JOIN professionTypes
  ON professions.professionID = professionTypes.professionID
  WHERE professions.accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.pid#">
</cfquery>

<cfquery name="contacts_rs" datasource="#application.datasource#">
	SELECT *
  FROM contacts
  WHERE accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT.ID#">
</cfquery>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ProDriver</title>
<link rel="stylesheet" type="text/css" href="css/global.css" />
<link rel="stylesheet" type="text/css" href="css/profile.css" />
<link rel="stylesheet" type="text/css" href="css/colorbox.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.dop.BookingCalendar.css" />
<style type="text/css">
body { background-image:url(images/new/tpl-bg-3.png); background-repeat:repeat-x; background-color:#2D2D2D; }
</style>
<script type="text/javascript" src="js/all.js"></script>
<script type="text/javascript" src="js/jquery.dop.BookingCalendar.js"></script>
<script type="text/javascript">_this.init("co-profile");</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <cfinclude template="inc-menu.cfm">
  <div id="content-container">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:10px solid #FFFFFF; margin:20px 0 0 0;">
        <tr>
          <td colspan="2" style="background:#4f4f4f;">
          <div class="page-title">COMPANY PROFILE</div>
          </td>
        </tr>
        <tr>
          <td width="210" rowspan="4" valign="top" style="border-top:3px solid #FFFFFF; border-right:3px solid #FFFFFF; background:#4f4f4f;">
          <div class="prof_image" style="width:175px; height:175px;"><img src="images/profile_pics/<cfoutput>#account_rs.accountCompanyLogo#</cfoutput>" alt="No Image" width="175" height="175"></div>
          <div style="clear:both;"></div>
          <div class="prof_sidebar">
            <div style="border:1px solid #666; width:186px; margin-top:10px;"></div>
            <cfif URL.pid neq SESSION.account.id>
            <div style="margin-top:10px;"> <a id="emailDriverBtn" href="javascipt:;"><img src="images/email_company_btn.png" border="0"></a> </div>
            <div style="border:1px solid #666; width:186px; margin-top:10px;"></div>
            </cfif>
          </div>
          </td>
          <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;">
          <div class="section-title"><cfoutput>#account_rs.accountCompanyName#</cfoutput></div>
          <div class="section-body">
            <div class="top">
              <div class="one">Website<br> <span style="color:#fff; font-size:12px;"><cfoutput>#account_rs.accountWWW#&nbsp;</cfoutput></span></div>
              <div class="two">Telephone<br> <span style="color:#fff; font-size:12px;"><cfoutput>#account_rs.accountPhone#&nbsp;</cfoutput></span></div>
              <div class="one" style="font-size:14px; color:#e6ae02; font-weight:bold; margin-top:15px;">Address<br> 
              <span style="color:#000; font-size:12px;">
							<cfoutput>#account_rs.accountAddress1#<br><cfif account_rs.accountAddress2 neq "">#account_rs.accountAddress2#<br></cfif>#account_rs.accountCity#, #account_rs.accountState# #account_rs.accountZip#<br></cfoutput></span></div>
              <div class="two"  style="font-size:14px; color:#e6ae02; font-weight:bold; margin-top:15px; ">Contacts<br> <span style="color:#000; font-size:12px;"><cfoutput query="contacts_rs"><div style="margin:3px 0 0 0"><a href="mailto:#contacts_rs.contactEmail#">#contacts_rs.contactName#</a></div></cfoutput></span> </div>
            </div>
          </div>
          </td>
        </tr>
        <tr>
          <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;">
          <div class="section-title">About Us</div>
          <div class="section-body" style="font-size:14px; padding-left:10px; padding-top:10px; padding-right:5px;"> <cfoutput>#paragraphformat(account_rs.accountBio)#</cfoutput></div>
          </td>
        </tr>
      </table>
    <div style="clear:both;"></div>
  </div>
  <div id="footer">
    <cfinclude template="inc-footer.cfm">
  </div>
</div>
<div style="display:none;">
  <div id="emailFormContainer">
  	<form id="emailForm" method="post">
    <div class="section-title" style="background-color:#4f4f4f; color:#ffffff;">Send Email</div>
    <div class="section-body" style="font-size:14px; padding:10px 5px 0 10px;">
    	<table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
        	<td><div style="margin:0 0 5px 0;">Subject:</div><input name="messageSubject" type="text" style="width:99%;"></td>
        </tr>
        <tr>
        	<td>
            <div style="margin:5px 0 5px 0;">Message:</div>
            <textarea name="messageBody" style="width:99%; height:130px; margin:0 0 0 0;"></textarea>
            <input id="messageFromID" name="messageFromID" type="hidden" value="<cfoutput>#SESSION.account.id#</cfoutput>">
            <input id="messageToID" name="messageToID" type="hidden" value="<cfoutput>#URL.pid#</cfoutput>">
          	<a id="emailSubmitBtn" href=""><img src="images/email_company_btn.png" border="0" style="margin:10px 0 0 0;"></a>
          </td>
        </tr>
      </table>
    </div>
    </form>
  </div>
</div>
</body>
</html>