<cfset data = querynew("subject,from,date","varchar,varchar,varchar")>
<cfloop index="x" from="1" to="200">
<cfset queryaddrow(data)>
<cfset querysetcell(data,"subject","SUBJECT #x#")>
<cfset querysetcell(data,"from","USER #x#")>
<cfset querysetcell(data,"date","11-30-2011")>
</cfloop>
<cfset perpage = 10>
<cfparam name="url.start" default="1">
<cfif not isNumeric(url.start) or url.start lt 1 or url.start gt data.recordCount or round(url.start) neq url.start>
  <cfset url.start = 1>
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/global.css">
<link rel="stylesheet" type="text/css" href="css/profile.css">
<style type="text/css">
body { background-image:url(images/new/tpl-bg-3.png); background-repeat:repeat-x; background-color:#2D2D2D; }
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Untitled Document</title>
</head>

<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <div id="body">
    <div id="search-button"><a href="#"></a></div>
    <div id="email-button"><a href="#"></a></div>
    <div id="edit-button"><a href="#"></a></div>
    <div id="view-button"><a href="#"></a></div>
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
          <thead class="t_head">
            <tr>
              <td width="618">Subject</td>
              <td width="396">Sender</td>
              <td width="148">Date</td>
            </tr>
          </thead>
          <tbody>
            <cfoutput query="data" startrow="#url.start#" maxrows="#perpage#">
            <tr class="odd">
              <td width="618"><input type="checkbox">#subject#</td>
              <td width="396">#from#</td>
              <td width="148">#date#</td>
            </tr>
            </cfoutput>
            <tr class="email_footer">
              <td width="618">
              <p align="center"> [
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
                <cfset totalPages = Ceiling(data.recordCount / perpage)>
                <cfloop index="c" from="1" to="#totalPages#">
                <cfoutput><a href="?start=#pageLink#">#pageCount#</a></cfoutput>
                <cfset pageCount = pageCount + 1>
                <cfset pageLink = pageLink + perpage>
                </cfloop>
                
                <!--- End Page Number ---> 
                
                /
                <cfif (url.start + perpage - 1) lt data.recordCount>
                  <cfset link = cgi.script_name & "?start=" & (url.start + perpage)>
                  <cfoutput><a href="#link#">Next Page</a></cfoutput>
                  <cfelse>
                  Next Page
                </cfif>
                ] </p>
              </td>
              <td width="396" style="background-color:#fff;"><a href="#" class="delete_btn"><img src="images/delete_btn.png"></a><a href="#" class="selectall_btn"><img src="images/selectall_btn.png"></a></td>
            </tr>
          </tbody>
        </table>
      </form>
    </div>
  </div>
</div>
</body>
</html>
