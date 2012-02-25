<cfset perpage = 10>
<cfparam name="url.start" default="1">

<cfquery name="data" datasource="#application.datasource#">
  SELECT messages.*, accounts.account_first_name, accounts.account_last_name
  FROM messages
  INNER JOIN accounts
  ON messages.message_to_id = accounts.account_id
  WHERE message_from_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#COOKIE.ACCOUNT_ID#">
  AND message_parent_id = 0
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
  <div id="body">
    <cfif COOKIE.ACCOUNT_TYPE eq 1>
      <div id="search-button"><a href="#"></a></div>
    </cfif>
    <div id="email-button"><a href="#"></a></div>
    <cfif COOKIE.ACCOUNT_TYPE eq 2>
      <div id="mycal-button"><a href="driver_cal.cfm"></a></div>
    </cfif>
    <div id="edit-button"><a href="my-email.cfm"></a></div>
  </div>
  <div id="content-container">
    <div class="welcome"> <span class="yellow">Welcome:</span> James Bassett </div>
    <div class="table">
      <div class="tbl_head">
        <div class="text">My Email</div>
        <div class="second">Incoming | Outgoing</div>
      </div>
      <form>
        <table cellpadding="0" cellspacing="0" border="0" class="table_email">
          <thead class="open_subject">
          	<tr>
            	<th width="596" align="left">Subject: We got a job for you</th>
            </tr>
          </thead>
          <tbody>
            <tr class="thread">
              <td valign="middle" class="sender"> <strong>jbasset</strong><br />5/19/2010 - 12:00:00 </td>
              <td valign="middle" class="thread_reply"> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse erat lorem, iaculis nec tincidunt vitae, congue non risus. Nulla nec 
              diam at lacus lacinia feugiat eu non justo. Ut pharetra neque sit amet mauris sagittis imperdiet. Quisque quam massa, aliquet at venenatis 
              quis, porttitor quis elit. Aenean rhoncus urna a ligula malesuada ac cursus urna varius. 
              
              In id justo nibh. Phasellus facilisis porttitor tellus placerat elementum. Sed erat nunc, feugiat in hendrerit ut, pretium non leo. In in dui 
              placerat risus cursus iaculis non et leo. </td>
            </tr>
            <tr class="thread">
              <td valign="middle" class="sender"> <strong>jbasset</strong><br />5/19/2010 - 12:00:00 </td>
              <td valign="middle" class="thread_reply"> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse erat lorem, iaculis nec tincidunt vitae, congue non risus. Nulla nec 
              diam at lacus lacinia feugiat eu non justo. Ut pharetra neque sit amet mauris sagittis imperdiet. Quisque quam massa, aliquet at venenatis 
              quis, porttitor quis elit. Aenean rhoncus urna a ligula malesuada ac cursus urna varius. 
              
              In id justo nibh. Phasellus facilisis porttitor tellus placerat elementum. Sed erat nunc, feugiat in hendrerit ut, pretium non leo. In in dui 
              placerat risus cursus iaculis non et leo. </td>
            </tr>
            <tr class="thread">
              <td class="sender">&nbsp;</td>
              <td class="thread_reply">
              <div style="margin-left:75px; height:100px;">
                <textarea cols="75" rows="5"></textarea>
              </div>
              <div style="float:left; margin-left:300px; margin-top:20px;"> <a><img src="images/reply.png" /></a> </div>
              </td>
            </tr>
            <tr class="thread">
              <td class="thread_reply1">
              <div class="grey_bar"></div>
              </td>
              <td class="sender1">
              <div style="float:right;"><a><img src="images/delete_btn.png" /></a></div>
              </td>
            </tr>
          </tbody>
        </table>
      </form>
    </div>
  </div>
  <div style="clear:both;"></div>
</div>
<div id="footer">
  <div id="footer-line">ProDriver.com&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;All Rights Reserved&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;About Us&nbsp;&nbsp;-&nbsp;&nbsp;Contact Us&nbsp;&nbsp;-&nbsp;&nbsp;Terms and Conditions</div>
</div>
</div>
</body>
</html>