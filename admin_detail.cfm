<cfparam name="url.id" default="0">
<cfquery name="rs_account" datasource="#application.datasource#">SELECT * FROM accounts LEFT JOIN status ON accounts.accountStatus = status.statusID WHERE accounts.accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#"></cfquery>

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
<script type="text/javascript">_this.init("admin-detail");</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <div id="body"> </div>
  <div id="content-container">
    <form>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:10px solid #FFFFFF; margin:20px 0 0 0;">
        <tr>
          <td colspan="2" style="background:#4f4f4f;">
          <div class="page-title">ADMIN PANEL</div>
          </td>
        </tr>
        <tr>
          <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;">
          <div class="section-body">
            <table cellpadding="0" cellspacing="0" border="0" class="admin" width="100%">
              <thead>
                <tr class="thead">
                  <td width="210">&nbsp;</td>
                  <td width="137">&nbsp;</td>
                  <td width="248">&nbsp;</td>
                  <td width="">&nbsp;</td>
                </tr>
              </thead>
              <tbody>
                <cfoutput query="rs_account">
                <tr class="tbody1">
                  <td width="210">
                  <div style="font-size:16px; padding-left:10px; width:210px;"><strong>#accountFirstName# #accountLastName#</strong></div>
                  <div style="line-height:18px; padding:7px 0 0 10px; width:210px;"><strong>Company Name</strong><br>#accountCompanyName#</div>
                  <div style="line-height:18px; padding:7px 0 0 10px; width:210px;"><strong>Address 1</strong><br>#accountAddress1#</div>
                  <div style="line-height:18px; padding:7px 0 0 10px; width:210px;"><strong>Address 2</strong><br>#accountAddress2#</div>
                  <div style="line-height:18px; padding:7px 0 0 10px; width:210px;"><strong>City</strong><br>#accountCity#</div>
                  <div style="line-height:18px; padding:7px 0 0 10px; width:210px;"><strong>State</strong><br>#accountState#</div>
                  <div style="line-height:18px; padding:7px 0 0 10px; width:210px;"><strong>Zip</strong><br>#accountZip#</div>
                  </td>
                  <td width="137" valign="top">
                  <div style="padding:7px 0 0 10px; width:210px;"><strong>Telephone Number</strong><br>#accountPhone#&nbsp;</div>
                  <div style="padding:7px 0 0 10px; width:210px;"><strong>Email Address</strong><br>#accountEmail#</div>
                  <div style="padding:15px 0 0 10px; width:210px;"><strong>Status</strong><br> #statusTitle#</div>
                  <div style="padding:15px 0 0 10px; width:210px;"><strong>Business ID</strong><br> #accountBusinessID#</div>
                  </td>
                  <td width="248" valign="top">
                  <div style="line-height:18px; padding-left:10px; width:210px;"><strong>Documents</strong><br>
                  	<cfif fileexists("#application.filestore#\#url.id#\#url.id#_driver_application.pdf")><a href="documents/#url.id#/#url.id#_driver_application.pdf" target="_blank">Driver Application</a><br></cfif>
                    <cfif fileexists("#application.filestore#\#url.id#\#url.id#_medical_long_form.pdf")><a href="documents/#url.id#/#url.id#_medical_long_form.pdf" target="_blank">Medical Long Form</a><br></cfif>
										<cfif fileexists("#application.filestore#\#url.id#\#url.id#_copy_of_license.pdf")><a href="documents/#url.id#/#url.id#_copy_of_license.pdf" target="_blank">Copy of License</a><br></cfif>
                    <cfif fileexists("#application.filestore#\#url.id#\#url.id#_i9.pdf")><a href="documents/#url.id#/#url.id#_i9.pdf" target="_blank">I-9</a><br></cfif>
                    <cfif fileexists("#application.filestore#\#url.id#\#url.id#_fair_credit_disclosure.pdf")><a href="documents/#url.id#/#url.id#_fair_credit_disclosure.pdf" target="_blank">Fair Credit Reporting Act Disclosure</a><br></cfif>
                    
                    
                    <cfif fileexists("#application.filestore#\#url.id#\#url.id#_mvr.pdf")><a href="documents/#url.id#/#url.id#_mvr.pdf" target="_blank">MVR</a><br></cfif>
                    <cfif fileexists("#application.filestore#\#url.id#\#url.id#_ssn.pdf")><a href="documents/#url.id#/#url.id#_ssn.pdf" target="_blank">SSN</a><br></cfif>
										<cfif fileexists("#application.filestore#\#url.id#\#url.id#_background_check.pdf")><a href="documents/#url.id#/#url.id#_background_check.pdf" target="_blank">Background Check</a><br></cfif>
                    <cfif fileexists("#application.filestore#\#url.id#\#url.id#_dot_medical.pdf")><a href="documents/#url.id#/#url.id#_dot_medical.pdf" target="_blank">DOT Medical Card</a><br></cfif>
                    <cfif fileexists("#application.filestore#\#url.id#\#url.id#_w2.pdf")><a href="documents/#url.id#/#url.id#_w2.pdf" target="_blank">W2</a><br></cfif>
                    
                    
                    
                  	<!---<a href="##"><img src="images/download.png"></a><br> --->
                    <!---<a id="deleteAll_btn" href="##" title="#url.id#"><img style="margin-top:5px;" src="images/delete_all.png"></a>--->
                  </div>
                  </td>
                  <td width="" valign="top">
                  <div style="padding-left:10px;"><strong>Actions</strong><br>
                  	<cfif rs_account.accountStatus eq 1>
                    	<a id="approveAccount_btn" href="javascript:;" title="#url.id#">Approve Account</a><br>
                    </cfif>
                    <a id="activateAccount_btn" href="javascript:;" title="#url.id#">Activate Account</a><br>
                    <a id="suspendAccount_btn" href="javascript:;" title="#url.id#">Suspend Account</a><br>
                    <a id="reinstateAccount_btn" href="javascript:;" title="#url.id#">Reinstate Account</a><br>
                    <a id="deleteAll_btn" href="javascript:;" title="#url.id#">Delete Documents</a><br>
                  </div>
                  </td>
                </tr>
                <tr class="tbody1">
                  <td>&nbsp;</td>
                  <td valign="top">&nbsp;</td>
                  <td valign="top">&nbsp;</td>
                  <td valign="top">&nbsp;</td>
                </tr>
                </cfoutput>
              </tbody>
            </table>
          </div>
          </td>
        </tr>
          </tbody>
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