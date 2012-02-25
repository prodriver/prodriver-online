<cfquery name="account_rs" datasource="#application.datasource#">
	SELECT * 
  FROM accounts 
  WHERE accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT.ID#">
</cfquery>

<cfquery name="professions_rs" datasource="#application.datasource#">
	SELECT professions.*, professiontypes.professionTitle
  FROM professions
  INNER JOIN professiontypes
  ON professions.professionID = professiontypes.professionID
  WHERE professions.accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT.ID#">
</cfquery>

<cfquery name="contacts_rs" datasource="#application.datasource#">
	SELECT *
  FROM contacts
  WHERE accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT.ID#">
</cfquery>

<cfset professionsList = valuelist(professions_rs.professionID)>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ProDriver</title>
<link rel="stylesheet" type="text/css" href="css/global.css" />
<link rel="stylesheet" type="text/css" href="css/profile.css" />
<link type="text/css" rel="stylesheet" href="http://freebaselibs.com/static/suggest/1.3/suggest.min.css" />
<style type="text/css">
	body { background-image:url(images/new/tpl-bg-3.png); background-repeat:repeat-x; background-color:#2D2D2D; }
</style>
<script type="text/javascript" src="js/all.js"></script>
<script type="text/javascript" src="http://freebaselibs.com/static/suggest/1.3/suggest.min.js"></script>
<script type="text/javascript">_this.init("edit-company-profile");</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <cfinclude template="inc-menu.cfm">
  <div id="content-container">
      <form id="companyEditForm" method="post" enctype="multipart/form-data">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:10px solid #FFFFFF; margin:20px 0 0 0;">
        <tr>
          <td colspan="2" style="background:#4f4f4f;">
          <div class="page-title">EDIT MY PROFILE</div>
          </td>
        </tr>
        <tr>
          <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;"> 
						<div id="lContainer" style="float:left; width:630px;">
            	<div id="generalInfoContainer" style="margin:0 0 5px 0; padding:5px; background:#fff;">
              	<div class="containerHeader">Company Contact Information</div>
                <table id="editProfileTable" border="0" cellpadding="0" cellspacing="0" style="width:100%; margin:5px 0 0 0;">
                  <tr>
                    <td width="33%" class="cellBorder"><div class="formLabel">COMPANY NAME</div></td>
                    <td width="33%" class="cellBorder"><div class="formLabel">TELEPHONE</div></td>
                    <td width="33%"><div class="formLabel"></div></td>
                  </tr>
                  <tr>
                    <td class="cellBorder"><input type="text" name="accountCompanyName" id="accountCompanyName" value="<cfoutput>#account_rs.accountCompanyName#</cfoutput>"></td>
                    <td class="cellBorder"><input type="text" name="accountPhone" id="accountPhone" value="<cfoutput>#account_rs.accountPhone#</cfoutput>"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="33%" class="cellBorder"><div class="formLabel">ADDRESS</div></td>
                    <td width="33%" class="cellBorder"><div class="formLabel">WEBSITE</div></td>
                    <td width="33%"><div class="formLabel"></div></td>
                  </tr>
                  <tr>
                    <td class="cellBorder"><input type="text" name="accountAddress1" id="accountAddress1" value="<cfoutput>#account_rs.accountAddress1#</cfoutput>"></td>
                    <td class="cellBorder"><input type="text" name="accountWWW" id="accountWWW" value="<cfoutput>#account_rs.accountWWW#</cfoutput>"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="cellBorder"><input type="text" name="accountAddress2" id="accountAddress2" value="<cfoutput>#account_rs.accountAddress2#</cfoutput>"></td>
                    <td width="33%" class="cellBorder">&nbsp;</td>
                    <td width="33%">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="cellBorder"><input type="text" name="accountCity" id="accountCity" value="<cfoutput>#account_rs.accountCity#</cfoutput>"></td>
                    <td class="cellBorder"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="cellBorder"><input type="text" name="accountState" id="accountState" value="<cfoutput>#account_rs.accountState#</cfoutput>"></td>
                    <td width="33%" class="cellBorder"></td>
                    <td width="33%"></td>
                  </tr>
                  <tr>
                    <td class="cellBorder"><input type="text" name="accountZip" id="accountZip" value="<cfoutput>#account_rs.accountZip#</cfoutput>"></td>
                    <td class="cellBorder">&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                </table>
              </div>
              <div style="clear:both"></div>
              <div id="editBioContainer" style="height:264px; padding:5px; background:#fff;">
              	<div class="containerHeader">About</div>
                <table id="editBioTable" border="0" cellpadding="0" cellspacing="0" style="width:100%; margin:5px 0 0 0;">
            
                  <tr>
                  	<td><textarea name="accountBio" id="accountBio" style="width:612px; height:200px;"><cfoutput query="account_rs">#account_rs.accountBio#</cfoutput></textarea></td>
                  </tr>
                </table>
              </div>
            </div>
            <div id="rContainer" style="float:left; width:305px; margin:0 0 0 5px;">
             <div id="editProfilePicContainer" style="background:#fff; height:100px; width:295px; margin:0 0 5px 0; padding:5px; float:left;">
              	<div class="containerHeader">Edit Profile Picture</div>
                <table id="editProfilePictureTable" border="0" cellpadding="0" cellspacing="0" style="width:100%; margin:5px 0 0 0;">
                	<tr>
                  	<td width="20%" rowspan="2" valign="top"><img src="images/profile_pics/<cfoutput>#account_rs.accountCompanyLogo#</cfoutput>" width="60" height="60" style="margin:0 5px 0 0; border:1px solid #ccc;"></td>
                  	<td width="80%">
                 	  <div class="formLabel" style="padding-left:5px;">UPLOAD IMAGE</div></td>
                  </tr>
                  <tr>
                  	<td><input id="accountCompanyLogo" name="accountCompanyLogo" type="file"></td>
                  </tr>
                </table>
              </div>
              <div id="updateCredentialsContainer" style="background:#fff; padding:5px; float:left; margin:0 0 5px 0; height:398px; width:295px;">
              	<div class="containerHeader" style="background-color:#4f4f4f; color:#fff;">Company Contacts</div>
                <table id="editProfessionsTable" border="0" cellpadding="0" cellspacing="0" style="width:100%; margin:5px 0 0 0;">
                	<cfoutput query="contacts_rs">
                  <tr>
                  	<td width="50%" height="35"><div class="formLabel" style="padding-left:5px; font-size:12px;">#contacts_rs.contactName#</div></td>
                    <td width="50%" height="35"><div class="formLabel" style="padding-left:5px; font-size:12px;">#contacts_rs.contactEmail#</div></td>
                  </tr>
                  </cfoutput>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="35" colspan="2">
                      <div class="formLabel" style="padding-left:5px; font-size:12px;border-bottom:1px solid #CCC;">ADD NEW CONTACT</div>
                    </td>
                  </tr>
                  <tr>
                    <td height="25" align="center">Name</td>
                    <td height="25" align="center">Email Address</td>
                  </tr>
                  <tr>
                  	<td width="50%" height="35" align="center"><input id="contactName" name="contactName" type="text" style="width:120px;"></td>
                  	<td width="50%" height="35" align="center"><input id="contactEmail" name="contactEmail" type="text" style="width:120px;"></td>
                  </tr>
                </table>
              </div>
            </div>
            <div style="clear:both;"></div>
            <div id="formBtnContainer" style="margin:5px 0 0 0; padding:5px; background:#fff; text-align:center;"><a id="saveProfileBtn" href="javascript:;"><img src="images/sv_changes.png" width="168" height="35" border="0"></a></div>
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