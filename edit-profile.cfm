<cfquery name="account_rs" datasource="#application.datasource#">
	SELECT * 
  FROM accounts 
  WHERE accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT.ID#">
</cfquery>

<cfquery name="professions_rs" datasource="#application.datasource#">
	SELECT professions.*, professionTypes.professionTitle
  FROM professions
  INNER JOIN professionTypes
  ON professions.professionID = professionTypes.professionID
  WHERE professions.accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT.ID#">
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
<script type="text/javascript">_this.init("edit-driver-profile");</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <cfinclude template="inc-menu.cfm">
  <form id="editProfileForm" name="editProfileForm" enctype="multipart/form-data" method="post" action="worker.cfc?method=saveEditProfile">
  <div id="content-container">
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
              	<div class="containerHeader">General Information</div>
                <table id="editProfileTable" border="0" cellpadding="0" cellspacing="0" style="width:100%; margin:5px 0 0 0;">
                  <tr>
                    <td width="33%" class="cellBorder"><div class="formLabel">CURRENT EMPLOYER</div></td>
                    <td width="33%" class="cellBorder"><div class="formLabel">TELEPHONE</div></td>
                    <td width="33%"><div class="formLabel">PASSPORT</div></td>
                  </tr>
                  <tr>
                    <td class="cellBorder"><input type="text" name="accountCurrentEmployer" id="accountCurrentEmployer" value="<cfoutput>#account_rs.accountCurrentEmployer#</cfoutput>" class="validate[required]"></td>
                    <td class="cellBorder"><input type="text" name="accountPhone" id="accountPhone" value="<cfoutput>#account_rs.accountPhone#</cfoutput>" class="validate[required],custom[phone]"></td>
                    <td>
                      <select name="accountPassport">
                        <option value="yes" <cfif account_rs.accountPassport eq "yes">selected="selected"</cfif>>YES</option>
                        <option value="no" <cfif account_rs.accountPassport eq "no">selected="selected"</cfif>>NO</option>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td width="33%" class="cellBorder"><div class="formLabel">ADDRESS</div></td>
                    <td width="33%" class="cellBorder"><div class="formLabel">MARITAL STATUS</div></td>
                    <td width="33%"><div class="formLabel">CANADA DRIVER CERTIFIED</div></td>
                  </tr>
                  <tr>
                    <td class="cellBorder"><input type="text" name="accountAddress1" id="accountAddress1" value="<cfoutput>#account_rs.accountAddress1#</cfoutput>" class="validate[required]"></td>
                    <td class="cellBorder">
                      <select name="accountMaritalStatus">
                        <option value="Single" <cfif account_rs.accountMaritalStatus eq "Single">selected="selected"</cfif>>Single</option>
                        <option value="Married" <cfif account_rs.accountMaritalStatus eq "Married">selected="selected"</cfif>>Married</option>
                        <option value="Divorced" <cfif account_rs.accountMaritalStatus eq "Divorced">selected="selected"</cfif>>Divorced</option>
                      </select>
                    </td>
                    <td>
                      <select name="accountCanadaRequirements">
                        <option value="yes" <cfif account_rs.accountCanadaRequirements eq "yes">selected="selected"</cfif>>YES</option>
                        <option value="no" <cfif account_rs.accountCanadaRequirements eq "no">selected="selected"</cfif>>NO</option>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td class="cellBorder"><input type="text" name="accountAddress2" id="accountAddress2" value="<cfoutput>#account_rs.accountAddress2#</cfoutput>"></td>
                    <td width="33%" class="cellBorder"><div class="formLabel">DATE OF BIRTH</div></td>
                    <td width="33%">
                    <div class="formLabel">CURRENT CITY &amp; STATE</div></td>
                  </tr>
                  <tr>
                    <td class="cellBorder"><input type="text" name="accountCity" id="accountCity" value="<cfoutput>#account_rs.accountCity#</cfoutput>" class="validate[required]"></td>
                    <td class="cellBorder"><input type="text" name="accountDOB" id="accountDOB" value="<cfoutput>#dateformat(account_rs.accountDOB,"mm-dd-yyyy")#</cfoutput>" class="validate[required],custom[date]"></td>
                    <td><input type="text" name="accountCurrentCity" id="accountCurrentCity" value="<cfoutput>#account_rs.accountCurrentCity#</cfoutput>"></td>
                  </tr>
                  <tr>
                    <td class="cellBorder">
                    
<select id="accountState" name="accountState" class="validate[required]">
	<option value="">-- Select a state --</option>
  <option value="Alabama" <cfif account_rs.accountState eq "Alabama">selected</cfif>>Alabama</option> 
	<option value="Alaska" <cfif account_rs.accountState eq "Alaska">selected</cfif>>Alaska</option> 
  <option value="Arizona" <cfif account_rs.accountState eq "Arizona">selected</cfif>>Arizona</option> 
  <option value="Arkansas" <cfif account_rs.accountState eq "Arkansas">selected</cfif>>Arkansas</option> 
  <option value="California" <cfif account_rs.accountState eq "California">selected</cfif>>California</option> 
  <option value="Colorado" <cfif account_rs.accountState eq "Colorado">selected</cfif>>Colorado</option> 
  <option value="Connecticut" <cfif account_rs.accountState eq "Connecticut">selected</cfif>>Connecticut</option> 
  <option value="Delaware" <cfif account_rs.accountState eq "Delaware">selected</cfif>>Delaware</option> 
  <option value="Florida" <cfif account_rs.accountState eq "Florida">selected</cfif>>Florida</option> 
  <option value="Georgia" <cfif account_rs.accountState eq "Georgia">selected</cfif>>Georgia</option> 
  <option value="Hawaii" <cfif account_rs.accountState eq "Hawaii">selected</cfif>>Hawaii</option> 
  <option value="Idaho" <cfif account_rs.accountState eq "Idaho">selected</cfif>>Idaho</option> 
  <option value="Illinois" <cfif account_rs.accountState eq "Illinois">selected</cfif>>Illinois</option> 
  <option value="Indiana" <cfif account_rs.accountState eq "Indiana">selected</cfif>>Indiana</option> 
  <option value="Iowa" <cfif account_rs.accountState eq "Iowa">selected</cfif>>Iowa</option> 
  <option value="Kansas" <cfif account_rs.accountState eq "Kansas">selected</cfif>>Kansas</option> 
  <option value="Kentucky" <cfif account_rs.accountState eq "Kentucky">selected</cfif>>Kentucky</option> 
  <option value="Louisiana" <cfif account_rs.accountState eq "Louisiana">selected</cfif>>Louisiana</option> 
  <option value="Maine" <cfif account_rs.accountState eq "Maine">selected</cfif>>Maine</option> 
  <option value="Maryland" <cfif account_rs.accountState eq "Maryland">selected</cfif>>Maryland</option> 
  <option value="Massachusetts" <cfif account_rs.accountState eq "Massachusetts">selected</cfif>>Massachusetts</option> 
  <option value="Michigan" <cfif account_rs.accountState eq "Michigan">selected</cfif>>Michigan</option> 
  <option value="Minnesota" <cfif account_rs.accountState eq "Minnesota">selected</cfif>>Minnesota</option> 
  <option value="Mississippi" <cfif account_rs.accountState eq "Mississippi">selected</cfif>>Mississippi</option> 
  <option value="Missouri" <cfif account_rs.accountState eq "Missouri">selected</cfif>>Missouri</option> 
  <option value="Montana" <cfif account_rs.accountState eq "Montana">selected</cfif>>Montana</option> 
  <option value="Nebraska" <cfif account_rs.accountState eq "Nebraska">selected</cfif>>Nebraska</option> 
  <option value="Nevada" <cfif account_rs.accountState eq "Nevada">selected</cfif>>Nevada</option> 
  <option value="New Hampshire" <cfif account_rs.accountState eq "New Hampshir">selected</cfif>>New Hampshire</option> 
  <option value="New Jersey" <cfif account_rs.accountState eq "New Jersey">selected</cfif>>New Jersey</option> 
  <option value="New Mexico" <cfif account_rs.accountState eq "New York">selected</cfif>>New Mexico</option> 
  <option value="New York" <cfif account_rs.accountState eq "New York">selected</cfif>>New York</option> 
  <option value="North Carolina" <cfif account_rs.accountState eq "North Carolina">selected</cfif>>North Carolina</option> 
  <option value="North Dakota" <cfif account_rs.accountState eq "North Dakota">selected</cfif>>North Dakota</option> 
  <option value="Ohio" <cfif account_rs.accountState eq "Ohio">selected</cfif>>Ohio</option> 
  <option value="Oklahoma" <cfif account_rs.accountState eq "Oklahoma">selected</cfif>>Oklahoma</option>
  <option value="Oregon" <cfif account_rs.accountState eq "Oregon">selected</cfif>>Oregon</option> 
  <option value="Pennsylvania" <cfif account_rs.accountState eq "Pennsylvania">selected</cfif>>Pennsylvania</option> 
  <option value="Rhode Island" <cfif account_rs.accountState eq "Rhode Island">selected</cfif>>Rhode Island</option> 
  <option value="South Carolina" <cfif account_rs.accountState eq "South Carolina">selected</cfif>>South Carolina</option> 
  <option value="South Dakota" <cfif account_rs.accountState eq "South Dakota">selected</cfif>>South Dakota</option> 
  <option value="Tennessee" <cfif account_rs.accountState eq "Tennessee">selected</cfif>>Tennessee</option> 
  <option value="Texas" <cfif account_rs.accountState eq "Texas">selected</cfif>>Texas</option> 
  <option value="Utah" <cfif account_rs.accountState eq "Utah">selected</cfif>>Utah</option> 
  <option value="Vermont" <cfif account_rs.accountState eq "Vermont">selected</cfif>>Vermont</option> 
  <option value="Virginia" <cfif account_rs.accountState eq "Virginia">selected</cfif>>Virginia</option> 
  <option value="Washington" <cfif account_rs.accountState eq "Washington">selected</cfif>>Washington</option> 
  <option value="West Virginia" <cfif account_rs.accountState eq "West Virginia">selected</cfif>>West Virginia</option> 
  <option value="Wisconsin" <cfif account_rs.accountState eq "Wisconsin">selected</cfif>>Wisconsin</option> 
  <option value="Wyoming" <cfif account_rs.accountState eq "Wyoming">selected</cfif>>Wyoming</option> 
</select>                     
                    
                    </td>
                    <td width="33%" class="cellBorder"><div class="formLabel">SMOKER</div></td>
                    <td width="33%"><div class="formLabel">PREFERRED AIRPORT</div></td>
                  </tr>
                  <tr>
                    <td class="cellBorder"><input type="text" name="accountZip" id="accountZip" value="<cfoutput>#account_rs.accountZip#</cfoutput>" class="validate[required]"></td>
                    <td class="cellBorder">
                      <select name="accountSmoker">
                        <option value="yes" <cfif account_rs.accountSmoker eq "Yes">selected="selected"</cfif>>YES</option>
                        <option value="no" <cfif account_rs.accountSmoker eq "No">selected="selected"</cfif>>NO</option>
                      </select>
                    </td>
                    <td><input type="text" name="accountPreferredAirport" id="accountPreferredAirport" value="<cfoutput>#account_rs.accountPreferredAirport#</cfoutput>"></td>
                  </tr>
                </table>
              </div>
              <div style="clear:both"></div>
              <div id="editProfessionsContainer" style="background:#fff; width:300px; height:100px; margin:0 5px 5px 0; padding:5px; float:left;">
              	<div class="containerHeader">Edit Professions</div>
                <table id="editProfessionsTable" border="0" cellpadding="0" cellspacing="0" style="width:100%; margin:15px 0 0 0;">
                	<tr>
                  	<td>
                    	<div class="checkbox-div"><input id="checkbox1" name="accountProfessions" class="validate[minCheckbox[1]]" type="checkbox" value="3" <cfif listcontains(professionsList,3)>checked="checked"</cfif>><span class="form-label">&nbsp;&nbsp;<strong>PRIVATE</strong></span></div>
                      <div class="checkbox-div"><input id="checkbox2" name="accountProfessions" class="validate[minCheckbox[1]]" type="checkbox" value="1" <cfif listcontains(professionsList,1)>checked="checked"</cfif>><span class="form-label">&nbsp;&nbsp;<strong>ENTERTAINMENT</strong></span></div>
                      <div class="checkbox-div"><input id="checkbox3" name="accountProfessions" class="validate[minCheckbox[1]]" type="checkbox" value="5" <cfif listcontains(professionsList,5)>checked="checked"</cfif>><span class="form-label">&nbsp;&nbsp;<strong>LIMO</strong></span></div>
                    </td>
                  </tr>
                  <tr>
                  	<td style="padding-top:15px;">
                    	<div class="checkbox-div" style="margin-right:13px;"><input id="checkbox4" name="accountProfessions" class="validate[minCheckbox[2]]" type="checkbox" value="4" <cfif listcontains(professionsList,4)>checked="checked"</cfif>><span class="form-label">&nbsp;&nbsp;<strong>CHARTER</strong></span></div>
                      <div class="checkbox-div"><input id="checkbox5" name="accountProfessions" class="validate[minCheckbox[1]]" type="checkbox" value="2" <cfif listcontains(professionsList,2)>checked="checked"</cfif>><span class="form-label">&nbsp;&nbsp;<strong>CORPORATE</strong></span></div>
                    </td>
                  </tr>
                </table>
              </div>
              <div id="editProfilePicContainer" style="background:#fff; width:305px; height:100px; margin:0 0 5px 0; padding:5px; float:left;">
              	<div class="containerHeader">Edit Profile Picture</div>
                <table id="editProfilePictureTable" border="0" cellpadding="0" cellspacing="0" style="width:100%; margin:5px 0 0 0;">
                	<tr>
                  	<td width="20%" rowspan="2" valign="top"><img src="images/profile_pics/<cfoutput>#account_rs.accountProfileImage#</cfoutput>" width="60" height="60" style="margin:0 5px 0 0; border:1px solid #ccc;"></td>
                  	<td width="80%">
                 	  <div class="formLabel" style="padding-left:5px;">UPLOAD IMAGE</div></td>
                  </tr>
                  <tr>
                  	<td><input id="accountProfileImage" name="accountProfileImage" type="file"></td>
                  </tr>
                </table>
              </div>
              <div style="clear:both"></div>
              <div id="editBioContainer" style="height:234px; padding:5px; background:#fff;">
              	<div class="containerHeader">Edit Biography</div>
                <table id="editBioTable" border="0" cellpadding="0" cellspacing="0" style="width:100%; margin:5px 0 0 0;">
                	<tr>
                  	<td height="30"><div class="checkbox-div"><input name="accountBioFlag" type="checkbox" value="1" <cfif account_rs.accountBioFlag eq 1>checked="checked"</cfif>><span class="form-label">&nbsp;&nbsp;<strong>Do you want to show your biography on your profile?</strong></span></div></td>
                  </tr>
                  <tr>
                  	<td><textarea name="accountBio" id="accountBio" cols="45" rows="5" style="width:612px; height:150px;"><cfoutput>#account_rs.accountBio#</cfoutput></textarea></td>
                  </tr>
                </table>
              </div>
            </div>
            <div id="rContainer" style="float:left; width:305px; margin:0 0 0 5px;">
              <div id="updateCredentialsContainer" style="background:#fff; padding:5px; height:600px;">
              	<div class="containerHeader">Update Credentials</div>
                <table id="editProfessionsTable" border="0" cellpadding="0" cellspacing="0" style="width:100%; margin:5px 0 0 0;">
                	<tr>
                  	<td><span style="font-weight:bold;">UPLOAD ONLY .PDF FORMAT FILES</span></td>
                  </tr>
                  <tr>
                  	<td width="50%"><div class="formLabel" style="padding-left:5px;">DRIVER APPLICATION</div></td>
                  </tr>
                  <tr>
                  	<td width="50%"><input id="accountDriverApplication" name="accountDriverApplication" type="file"></td>
                  </tr>
                  <tr>
                  	<td width="50%"><div class="formLabel" style="padding-left:5px;">COPY OF LICENSE</div></td>
                  </tr>
                  <tr>
                  	<td width="50%"><input id="accountCopyOfLicense" name="accountCopyOfLicense" type="file"></td>
                  </tr>
                  <tr>
                  	<td width="50%"><div class="formLabel" style="padding-left:5px;">FAIR CREDIT REPORTING ACT DISCLOSURE</div></td>
                  </tr>
                  <tr>
                  	<td width="50%"><input id="accountFairCreditDisclosure" name="accountFairCreditDisclosure" type="file"></td>
                  </tr>
                  <tr>
                  	<td width="50%">
                  	<div class="formLabel" style="padding-left:5px;">CURRENT MVR</div></td>
                  </tr>
                  <tr>
                  	<td width="50%"><input id="accountMVR" name="accountMVR" type="file"></td>
                  </tr>
                  <tr>
                  	<td width="50%">
                  	<div class="formLabel" style="padding-left:5px;">SOCIAL SECURITY CARD</div></td>
                  </tr>
                  <tr>
                  	<td width="50%"><input id="accountSSN" name="accountSSN" type="file"></td>
                  </tr>
                  <tr>
                  	<td width="50%">
                  	<div class="formLabel" style="padding-left:5px;">CRIMINAL BACKGROUND CHECK</div></td>
                  </tr>
                  <tr>
                  	<td width="50%"><input id="accountBackgroundCheck" name="accountBackgroundCheck" type="file"></td>
                  </tr>
                  <tr>
                  	<td width="50%">
                  	<div class="formLabel" style="padding-left:5px;">DOT MEDICAL CARD</div></td>
                  </tr>
                  <tr>
                  	<td width="50%"><input id="accountDOTMedical" name="accountDOTMedical" type="file"></td>
                  </tr>
                  <tr>
                  	<td width="50%">
                  	<div class="formLabel" style="padding-left:5px;">MEDICAL LONG FORM</div></td>
                  </tr>
                  <tr>
                  	<td width="50%"><input id="accountMedicalLongForm" name="accountMedicalLongForm" type="file"></td>
                  </tr>
                  <tr>
                  	<td width="50%">
                  	<div class="formLabel" style="padding-left:5px;">CURRENT W-9</div></td>
                  </tr>
                  <tr>
                  	<td width="50%"><input id="accountW2" name="accountW2" type="file"></td>
                  </tr>
                  <tr>
                  	<td width="50%">
                  	<div class="formLabel" style="padding-left:5px;">CURRENT I-9</div></td>
                  </tr>
                  <tr>
                  	<td width="50%"><input id="accountI9" name="accountI9" type="file"></td>
                  </tr>
                </table>
              </div>
            </div>
            <div style="clear:both;"></div>
            <div id="formBtnContainer" style="margin:5px 0 0 0; padding:5px; background:#fff; text-align:center;"><img id="saveProfileBtn" src="images/sv_changes.png" width="168" height="35"></div>
          </td>
        </tr>
      </table>
    <div style="clear:both;"></div>
  </div>
  </form>
  <div id="footer">
    <cfinclude template="inc-footer.cfm">
  </div>
</div>
</body>
</html>