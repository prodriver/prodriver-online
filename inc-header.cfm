<cfquery name="accountNameRS" datasource="#APPLICATION.datasource#">
	SELECT accountFirstName, accountLastName
  FROM accounts
  WHERE accountID = #SESSION.ACCOUNT.ID#
</cfquery>
<div id="header">
  <div id="logo"><a href="index.cfm"><img src="images/new/home-logo.png" width="245" height="52" border="0"></a></div>
  <div id="home-menu"> <a href="about.cfm">ABOUT PRODRIVER</a> <a href="services.cfm">SERVICES</a> <a href="contact.cfm">CONTACT US</a> <cfif SESSION.account.type eq 3><a href="admin.cfm">ADMIN PANEL</a></cfif> <cfif SESSION.ACCOUNT.ID gt 0><span style="color:#ffff00; margin:0 0 0 20px;"><cfoutput><span id="profileTextLink" style="cursor:pointer;" onClick="window.location.href='<cfif SESSION.account.type eq 2>profile.cfm<cfelse>co_profile.cfm</cfif>'">Welcome, #accountNameRS.accountFirstName# #accountNameRS.accountLastName#</span></cfoutput></span><a id="logout-link" href="#"><img id="logoutBtn" src="images/logout.gif" border="0"></a><cfelse><a id="login-link" href="#"><img id="loginBtn" src="images/login.gif" border="0"></a></cfif>
    <div id="login-panel">
      <form id="loginForm" method="post" action="">
        <label>EMAIL ADDRESS:<br><input id="loginAccountEmail" name="loginAccountEmail" value="" type="text"></label><br>
        <label>PASSWORD:<br><input id="loginAccountPassword" name="loginAccountPassword" value="" type="password"></label><br>
        <input id="submitBtn" name="submitBtn" value="Sign In" type="submit">
      </form>
    </div>
  </div>
</div>