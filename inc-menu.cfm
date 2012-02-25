<div id="body">
	<cfif SESSION.ACCOUNT.TYPE eq 1><div id="search-button"><a href="search.cfm"></a></div></cfif>
  <div id="email-button"><a href="messages.cfm"></a></div>
  <cfif SESSION.ACCOUNT.TYPE eq 2><div id="mycal-button"><a href="calendar.cfm"></a></div></cfif>
  <cfif SESSION.ACCOUNT.TYPE eq 2>
  	<div id="edit-button"><a href="edit-profile.cfm"></a></div>
    <div id="view-button"><a href="profile.cfm"></a></div>
  <cfelse>
  	<div id="edit-button"><a href="co-edit-profile-loo.cfm"></a></div>
    <div id="view-button"><a href="co_profile.cfm"></a></div>
  </cfif>
</div>