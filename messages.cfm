<cfset perpage = 10>

<cfparam name="url.start" default="1">

<cfquery name="data" datasource="#application.datasource#">
	SELECT sender.accountFirstName AS senderFirstName,
  			 sender.accountLastName AS senderLastName,
         sender.accountCompanyName AS senderCompanyName,
         sender.accountTypeID AS senderAccountType,
  			 receiver.accountFirstName AS receiverFirstName,
         receiver.accountLastName AS receiverLastName, 
         receiver.accountTypeID AS receiverAccountType,
         receiver.accountCompanyName AS receiverCompanyName,
         messages.*
  FROM messages as messages
  LEFT JOIN accounts AS sender ON sender.accountID = messages.messageFromID
	LEFT JOIN accounts AS receiver ON receiver.accountID = messages.messageToID
  WHERE messages.messageParentID = 0
  AND (messages.messageToID = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT.ID#">
  OR messages.messageFromID = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT.ID#">)
  ORDER BY messages.messageDate DESC
</cfquery>

<cfif not isNumeric(url.start) or url.start lt 1 or url.start gt data.recordcount or round(url.start) neq url.start>
	<cfset url.start = 1>
</cfif>

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
<script type="text/javascript">_this.init();</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <cfinclude template="inc-menu.cfm">
  <div id="content-container">
    <form>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:10px solid #FFFFFF; margin:20px 0 0 0;">
        <tr>
          <td colspan="2" style="background:#4f4f4f;"><div class="page-title">MY EMAIL</div></td>
        </tr>
        <!---
        <tr>
          <td colspan="2" style="background-color:#e6ae02; border-top:3px solid #FFFFFF;border-bottom:3px solid #FFFFFF;"><div id="email-menu"><a href="my-email-inbox.cfm">INCOMING</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="my-email-outbox.cfm">OUTGOING</a></div></td>
        </tr>
        --->
        <tr>
          <td colspan="2" style="background-color:#fff;">
          	<table width="100%" border="0" cellpadding="0" cellspacing="0" id="email-table">
            	<thead>
              	<tr>
                  <th width="20" align="left">&nbsp;</th>
                  <th align="left">SUBJECT</th>
                   <th align="left">TO</th>
                  <th align="left">FROM</th>
                  <th align="left">DATE</th>
                </tr>
              </thead>
              <tbody>
              	<cfoutput query="data" startrow="#url.start#" maxrows="#perpage#">
                <tr>
                  <td width="20"><!---<input name="messageCB" type="checkbox" value="#data.messageID#">--->&nbsp;</td>
                  <td><a href="message.cfm?messageID=#data.messageID#">#data.messageSubject#</a></td>
                  <cfif data.receiverAccountType eq 1>
                  <td><a href="co_profile.cfm?pid=#data.messageToID#">#data.receiverCompanyName#</a></td>
                  <cfelse>
                  <td><a href="profile.cfm?pid=#data.messageToID#">#data.receiverFirstName# #data.receiverLastName#</a></td>
                  </cfif>
                  <cfif data.senderAccountType eq 1>
                  <td><a href="co_profile.cfm?pid=#data.messageFromID#">#data.senderCompanyName#</a></td>
                  <cfelse>
                  <td><a href="profile.cfm?pid=#data.messageFromID#">#data.senderFirstName# #data.senderLastName#</a></td>
                  </cfif>
                  <td>#dateformat(data.messageDate,"mm-dd-yyyy")# #timeformat(data.messageDate,"h:mm tt")#</td>
                </tr>
                </cfoutput>
                <tr>
                	<td colspan="5">
                    <p>
                    
                      [
                      
                      <cfif url.start gt 1>
                        <cfset link = cgi.script_name & "?start=" & (url.start - perpage)>
                        <cfoutput><a href="#link#">Previous Page</a></cfoutput>
                      <cfelse>
                        Previous Page
                      </cfif>
                      
                      /
                      
                      <!--- Start Page Number --->
                      
                      <cfset pageCount = 1>
                      <cfset pageLink = 1>
                      <cfset totalPages = Ceiling(data.recordcount / perpage)>
                      <cfloop index="c" from="1" to="#totalPages#">
                        <cfoutput><a href="?start=#pageLink#">#pageCount#</a></cfoutput>
                        <cfset pageCount = pageCount + 1>
                        <cfset pageLink = pageLink + perpage>
                      </cfloop>
                      
                      <!--- End Page Number --->
                      
                      /
                      
                      <cfif (url.start + perpage - 1) lt data.recordcount>
                        <cfset link = cgi.script_name & "?start=" & (url.start + perpage)>
                        <cfoutput><a href="#link#">Next Page</a></cfoutput>
                      <cfelse>
                        Next Page
                      </cfif>
                      
                      ]
                    
                    </p>
                  </td>
                </tr>
              </tbody>
            </table>
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