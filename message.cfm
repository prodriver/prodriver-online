<cfparam name="url.messageID" default="0">

<cfquery name="message_rs" datasource="#application.datasource#">
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
  WHERE (messages.messageID = #url.messageID#
  OR messages.messageParentID = #url.messageID#)
  ORDER BY messages.messageDate ASC
</cfquery>

<!--- IF THE USER IS NOT THE SENDER OR RECIPIENT OF THIS MESSAGE, DON'T LET HIM/HER SEE IT --->
<cfif message_rs.messageFromID neq SESSION.account.id AND message_rs.messageToID neq SESSION.account.id>
	<cflocation url="messages.cfm" addtoken="no">
</cfif>

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
<script type="text/javascript">_this.init("message");</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <cfinclude template="inc-menu.cfm">
  <div id="content-container">
    <form id="message_form" enctype="multipart/form-data" method="post">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:10px solid #FFFFFF; margin:20px 0 0 0;">
        <tr>
          <td colspan="2" style="background:#4f4f4f;"><div class="page-title">MY EMAIL</div></td>
        </tr>
        <tr>
          <td colspan="2" style="background-color:#fff;">
          	<table width="100%" border="0" cellpadding="0" cellspacing="0" id="email-table">
            	<thead>
              	<tr>
                  <th align="left"><div id="messageSubject"><cfoutput>SUBJECT: #message_rs.messageSubject#</cfoutput></div></th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td style="padding:4px 0 0 0;">
                  <cfoutput query="message_rs">
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" id="email-message-detail">
                    <tr>
                      <td width="25%" align="center" style="border-right:1px solid ##000000;">
                      	<div id="message_detail">
                        	<cfif message_rs.senderAccountType eq 1>
                        	<div class="message_sender_name">#message_rs.senderCompanyName#</div>
                          <cfelse>
                          <div class="message_sender_name">#message_rs.senderFirstName# #message_rs.senderLastName#</div>
                          </cfif>
                          <div class="message_sender_date">#dateformat(message_rs.messageDate,"mm/dd/yyyy")# #timeformat(message_rs.messageDate,"h:mm tt")#</div>
                          #iif(message_rs.messageRead eq 1, de("Message Read"), de("Message Unread"))#
                        </div>
                      </td>
                      <td width="75%" align="center"><div id="message_body_div">#htmleditformat(message_rs.messageBody)#</div></td>
                    </tr>
                  </table>
                  </cfoutput>
                  </td>
                </tr>
                <tr>
                	<td align="center"><textarea id="messageBody" name="messageBody" cols="100" rows="7" style="width:950px;"></textarea></td>
                </tr>
                <tr>
                	<td align="center">
                    <input name="messageParentID" type="hidden" value="<cfoutput>#message_rs.messageID#</cfoutput>">
                    <input name="messageToID" type="hidden" value="<cfoutput>#message_rs.messageFromID#</cfoutput>">
                    <input name="messageFromID" type="hidden" value="<cfoutput>#message_rs.messageToID#</cfoutput>">
                    <a id="replyBtn" href="javascript:;"><img src="images/reply.png" name="replyBtn" width="113" height="35" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/delete_btn.png" width="113" height="35"></td>
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