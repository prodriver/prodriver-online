<!--- security to redirect if user is not an admin --->
<cfif SESSION.account.type neq 3>
  <cflocation url="profile.cfm">
</cfif>

<cfquery name="rs_accounts" datasource="#application.datasource#">
  SELECT accounts.*, status.statusTitle, account_types.accountTypeName
  FROM accounts 
  LEFT JOIN status ON accounts.accountStatus = status.statusID 
  LEFT JOIN account_types ON accounts.accountTypeID = account_types.accountTypeID 
  WHERE NOT accounts.accountTypeID = 3
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
  <div id="body"> </div>
  <div id="content-container">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:10px solid #FFFFFF; margin:20px 0 0 0;">
      <tr>
        <td colspan="2" style="background:#4f4f4f;">
        <div class="page-title">ADMIN PANEL</div>
        </td>
      </tr>
      <tr>
        <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;">
        <div class="section-body">
          <table cellpadding="10" cellspacing="0" border="0" class="admin" style="width:100%">
            <thead>
              <tr class="thead">
                <td><strong>User Name</strong></td>
                <td><strong>Type</strong></td>
                <td><strong>Status</strong></td>
                <td><strong>Date Created</strong></td>
                <td><strong>Driver Profile</strong></td>
                <td width="90"></td>
              </tr>
            </thead>
            <tbody>
              <cfoutput query="rs_accounts">
              <tr class="tbody">
                <td><strong><cfif accountTypeName eq "driver">#accountFirstName# #accountLastName#<cfelse>#accountCompanyName#</cfif></strong></td>
                <td>#accountTypeName#</td>
                <td><div class="verified">#statusTitle#</div></td>
                <td>#dateformat(accountCreationDate,"mm/dd/yyyy")#</td>
                <td><cfif accountTypeName eq "company"><a href="co_profile.cfm?pid=#accountID#">View</a><cfelse><a href="profile.cfm?pid=#accountID#">View</a></cfif></td>
                <td width="90"><div id="manage"><a href="admin_detail.cfm?id=#accountID#"><img src="images/manage.png" width="76" height="22" border="0"></a></div></td>
              </tr>
              </cfoutput>
            </tbody>
          </table>
        </div>
        </td>
      </tr>
    </table>
    <div style="clear:both;"></div>
  </div>
  <div id="footer">
    <cfinclude template="inc-footer.cfm">
  </div>
</div>
</body>
</html>