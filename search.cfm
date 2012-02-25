<cfset perpage = 5>
<cfparam name="URL.start" default="1">
<cfparam name="URL.startDate" default="">
<cfparam name="URL.endDate" default="">
<cfparam name="URL.accountFirstName" default="">
<cfparam name="URL.accountLastName" default="">
<cfparam name="URL.accountState" default="">
<cfparam name="URL.professions" default="">
<cfparam name="URL.passport" default="">
<cfparam name="URL.canadian" default="">
<cfset qstring = "&startDate=#URL.startDate#">
<cfset qstring = qstring & "&endDate=#URL.endDate#">
<cfset qstring = qstring & "&accountFirstName=#URL.accountFirstName#">
<cfset qstring = qstring & "&accountLastName=#URL.accountLastName#">
<cfset qstring = qstring & "&accountState=#URL.accountState#">
<cfset qstring = qstring & "&professions=#URL.professions#">
<cfset qstring = qstring & "&passport=#URL.passport#">
<cfset qstring = qstring & "&canadian=#URL.canadian#">
<cfquery name="search_rs" datasource="#application.datasource#">
  SELECT *
  FROM accounts
  WHERE accountID
  NOT IN ( SELECT DISTINCT accountID 
           FROM calendar 
           WHERE calendarDate >= '#dateformat(URL.startDate,"yyyy-mm-dd")#' 
           AND calendarDate <='#dateformat(URL.endDate,"yyyy-mm-dd")#' )
  <cfif isdefined("URL.professions") and URL.professions neq "">
  AND accountID 
  IN ( SELECT DISTINCT accountID
       FROM professions
       WHERE professionID IN (#URL.professions#) )
  </cfif>
  AND accounts.accountTypeID = <cfqueryparam cfsqltype="cf_sql_numeric" value="2">
  AND accounts.accountStatus = <cfqueryparam cfsqltype="cf_sql_numeric" value="4">
  <cfif isdefined("URL.accountState") and URL.accountState neq "">AND accounts.accountState = '#trim(URL.accountState)#'</cfif>
  <cfif isdefined("URL.accountFirstName") and URL.accountFirstName neq "">AND accounts.accountFirstName = '#trim(URL.accountFirstName)#'</cfif>
  <cfif isdefined("URL.accountLastName") and URL.accountLastName neq "">AND accounts.accountLastName = '#trim(URL.accountLastName)#'</cfif>
  <cfif isdefined("URL.passport") and URL.passport neq "">AND accounts.accountPassport = '#trim(URL.passport)#'</cfif>
  <cfif isdefined("URL.canadian") and URL.canadian neq "">AND accounts.accountCanadaRequirements = '#trim(URL.canadian)#'</cfif>
  <cfif not isdefined("URL.init") or URL.init neq 1>AND accountStatus = 10000</cfif>
</cfquery>
<cfif not isNumeric(url.start) or url.start lt 1 or url.start gt search_rs.recordcount or round(url.start) neq url.start>
  <cfset url.start = 1>
</cfif>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ProDriver</title>
<link rel="stylesheet" type="text/css" href="http://freebaselibs.com/static/suggest/1.3/suggest.min.css">
<link rel="stylesheet" type="text/css" href="css/global.css">
<link rel="stylesheet" type="text/css" href="css/profile.css">
<link rel="stylesheet" type="text/css" href="css/datepicker.css">
<style type="text/css">
body {
	background-image:url(images/new/tpl-bg-3.png);
	background-repeat:repeat-x;
	background-color:#2D2D2D;
}
</style>
<script type="text/javascript" src="js/all.js"></script>
<script type="text/javascript" src="js/datepicker.js"></script>
<script type="text/javascript" src="js/eye.js"></script>
<!---<script type="text/javascript" src="http://freebaselibs.com/static/suggest/1.3/suggest.min.js"></script>--->
<script type="text/javascript">_this.init('search');</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <cfinclude template="inc-menu.cfm">
  <div id="content-container">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:10px solid #FFFFFF; margin:20px 0 0 0;">
      <tr>
        <td colspan="2" style="background:#4f4f4f;"><div class="page-title">SEARCH DRIVERS</div></td>
      </tr>
      <tr>
        <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;"><div id="searchFormDiv" style="float:left; border:3px solid #FFF; background:#e6ae02; width:350px; padding:7px;">
            <form id="searchForm" name="searchForm" action="" enctype="application/x-www-form-urlencoded" method="get">
              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td>By Date Range (mm-dd-yyyy)</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td colspan="2">
                  	<div id="cal"></div>
                  </td>
                </tr>
                <tr>
                  <td>
                  	<input type="text" name="startDate" id="startDate" class="validate[],custom[date]" value="<cfoutput>#URL.startDate#</cfoutput>">
                    <script>
											$('#startDate').DatePicker({
												format:'m-d-Y',
												//date: $('#startDate').val(),
												date: '<cfoutput>#dateformat(now(),"mm-dd-yyyy")#</cfoutput>',
												starts: 1,
												position: 'bottom',
												onBeforeShow: function(){
													if( $('#startDate').val() != '' ){
														$('#startDate').DatePickerSetDate($('#startDate').val(), true);
													}
												},
												onChange: function(formated, dates){
													$('#startDate').val(formated);
													$('#startDate').DatePickerHide();
												}
											});
                    </script>
                  </td>
                  <td>
                  	<input type="text" name="endDate" id="endDate" class="validate[],custom[date]" value="<cfoutput>#URL.endDate#</cfoutput>">
                    <script>
											$('#endDate').DatePicker({
												format:'m-d-Y',
												date: '<cfoutput>#dateformat(now(),"mm-dd-yyyy")#</cfoutput>',
												//current: $('#endDate').val(),
												starts: 1,
												position: 'bottom',
												onBeforeShow: function(){
													//$('#endDate').DatePickerSetDate($('#endDate').val(), true);
													if( $('#startDate').val() != '' ){
														$('#endDate').DatePickerSetDate($('#startDate').val(), true);
													}
												},
												onChange: function(formated, dates){
													$('#endDate').val(formated);
													$('#endDate').DatePickerHide();
												}
											});
                    </script>
                  </td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>By First Name</td>
                  <td>By Last Name</td>
                </tr>
                <tr>
                  <td><input type="text" name="accountFirstName" id="accountFirstName" value="<cfoutput>#URL.accountFirstName#</cfoutput>"></td>
                  <td><input type="text" name="accountLastName" id="accountLastName" value="<cfoutput>#URL.accountLastName#</cfoutput>"></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>By State</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td colspan="2">
                  	
<select id="accountState" name="accountState">
	<option value="">-- Select a state --</option>
  <option value="Alabama">Alabama</option> 
	<option value="Alaska">Alaska</option> 
  <option value="Arizona">Arizona</option> 
  <option value="Arkansas">Arkansas</option> 
  <option value="California">California</option> 
  <option value="Colorado">Colorado</option> 
  <option value="Connecticut">Connecticut</option> 
  <option value="Delaware">Delaware</option> 
  <option value="Florida">Florida</option> 
  <option value="Georgia">Georgia</option> 
  <option value="Hawaii">Hawaii</option> 
  <option value="Idaho">Idaho</option> 
  <option value="Illinois">Illinois</option> 
  <option value="Indiana">Indiana</option> 
  <option value="Iowa">Iowa</option> 
  <option value="Kansas">Kansas</option> 
  <option value="Kentucky">Kentucky</option> 
  <option value="Louisiana">Louisiana</option> 
  <option value="Maine">Maine</option> 
  <option value="Maryland">Maryland</option> 
  <option value="Massachusetts">Massachusetts</option> 
  <option value="Michigan">Michigan</option> 
  <option value="Minnesota">Minnesota</option> 
  <option value="Mississippi">Mississippi</option> 
  <option value="Missouri">Missouri</option> 
  <option value="Montana">Montana</option> 
  <option value="Nebraska">Nebraska</option> 
  <option value="Nevada">Nevada</option> 
  <option value="New Hampshire">New Hampshire</option> 
  <option value="New Jersey">New Jersey</option> 
  <option value="New Mexico">New Mexico</option> 
  <option value="New York">New York</option> 
  <option value="North Carolina">North Carolina</option> 
  <option value="North Dakota">North Dakota</option> 
  <option value="Ohio">Ohio</option> 
  <option value="Oklahoma">Oklahoma</option>
  <option value="Oregon">Oregon</option> 
  <option value="Pennsylvania">Pennsylvania</option> 
  <option value="Rhode Island">Rhode Island</option> 
  <option value="South Carolina">South Carolina</option> 
  <option value="South Dakota">South Dakota</option> 
  <option value="Tennessee">Tennessee</option> 
  <option value="Texas">Texas</option> 
  <option value="Utah">Utah</option> 
  <option value="Vermont">Vermont</option> 
  <option value="Virginia">Virginia</option> 
  <option value="Washington">Washington</option> 
  <option value="West Virginia">West Virginia</option> 
  <option value="Wisconsin">Wisconsin</option> 
  <option value="Wyoming">Wyoming</option> 
</select>                    
                    
                  </td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>By Profession</td>
                  <td>Passport</td>
                </tr>
                <tr>
                  <td rowspan="5"><select name="professions" size="6" multiple>
                      <option value="">None</option>
                      <option value="1" <cfif listcontains(URL.professions, 1)>selected="selected"</cfif>>Entertainment</option>
                      <option value="2" <cfif listcontains(URL.professions, 2)>selected="selected"</cfif>>Corporate</option>
                      <option value="3" <cfif listcontains(URL.professions, 3)>selected="selected"</cfif>>Private</option>
                      <option value="4" <cfif listcontains(URL.professions, 4)>selected="selected"</cfif>>Charter</option>
                      <option value="5" <cfif listcontains(URL.professions, 5)>selected="selected"</cfif>>Limo</option>
                    </select></td>
                  <td><select name="passport">
                      <option value="">None</option>
                      <option value="yes" <cfif URL.passport eq "yes">selected="selected"</cfif>>yes</option>
                      <option value="no" <cfif URL.passport eq "no">selected="selected"</cfif>>no</option>
                    </select></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>Canadian Driver Certified</td>
                </tr>
                <tr>
                  <td><select name="canadian">
                      <option value="">None</option>
                      <option value="yes" <cfif URL.canadian eq "yes">selected="selected"</cfif>>yes</option>
                      <option value="no" <cfif URL.canadian eq "no">selected="selected"</cfif>>no</option>
                    </select></td>
                </tr>
                <tr>
                  <td><input type="hidden" name="init" value="1"></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img id="searchBtn" src="images/submit_btn.png" alt="" width="160" height="43"></td>
                </tr>
              </table>
            </form>
          </div>
          <div id="searchResults" style="float:left; margin:0 0 0 5px; padding:5px; width:555px; height:500px; background:#FFF;">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" id="searchResultsTable">
              <thead>
                <tr>
                  <th align="left">Name</th>
                  <th align="left">State</th>
                  <th align="left">Pass Port</th>
                  <th width="50" align="left">Canadian Cert.</th>
                  <th>&nbsp;</th>
                </tr>
              </thead>
              <tbody>
                <cfoutput query="search_rs" startrow="#url.start#" maxrows="#perpage#">
                  <cfquery name="professions_rs" datasource="#application.datasource#">
                    SELECT professions.*, professionTypes.professionTitle
                    FROM professions
                    INNER JOIN professionTypes
                    ON professions.professionID = professionTypes.professionID
                    WHERE professions.accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#search_rs.accountID#">
                  </cfquery>
                  <cfquery name="avg_rs" datasource="#application.datasource#">
                    SELECT AVG(commentRating) AS rating 
                    FROM comments
                    WHERE commentFor = #search_rs.accountID#
                  </cfquery>
                  <cfif avg_rs.rating eq "">
                    <cfset rating = 0>
                    <cfelse>
                    <cfset rating = avg_rs.rating>
                  </cfif>
                  <tr>
                    <td>#accountFirstName# #accountLastName#</td>
                    <td>#accountState#</td>
                    <td>#ucase(accountPassport)#</td>
                    <td>#ucase(accountCanadaRequirements)#</td>
                    <td align="right"><a href="profile.cfm?pid=#accountID#"><img src="images/viewDriver.png" width="122" height="26" border="0"></a></td>
                  </tr>
                  <tr>
                    <td colspan="4" valign="top" style="border-bottom:1px dotted ##666;"><div class="professionsList">
                        <cfloop query="professions_rs">
                          #professions_rs.professionTitle#,&nbsp;&nbsp;
                        </cfloop>
                      </div></td>
                    <td align="right" valign="top" style="border-bottom:1px dotted ##666;"><div id="driverRating_#accountID#" class="driverRating"></div>
                      <script>$("##driverRating_#accountID#").raty({ path:"images/raty/", readOnly:true, number:5, start:#rating# });</script></td>
                  </tr>
                </cfoutput>
                <tr>
                  <td colspan="5" style="height:30px;"><p> [
                      <cfif url.start gt 1>
                        <cfset link = cgi.script_name & "?start=" & (url.start - perpage) & qstring>
                        <cfoutput><a href="#link#">Previous Page</a></cfoutput>
                        <cfelse>
                        Previous Page
                      </cfif>
                      / 
                      
                      <!--- Start Page Number --->
                      
                      <cfset pageCount = 1>
                      <cfset pageLink = 1>
                      <cfset totalPages = Ceiling(search_rs.recordcount / perpage)>
                      <cfloop index="c" from="1" to="#totalPages#">
                        <cfoutput><a href="?start=#pageLink##qstring#">#pageCount#</a></cfoutput>
                        <cfset pageCount = pageCount + 1>
                        <cfset pageLink = pageLink + perpage>
                      </cfloop>
                      
                      <!--- End Page Number ---> 
                      
                      /
                      <cfif (url.start + perpage - 1) lt search_rs.recordcount>
                        <cfset link = cgi.script_name & "?start=" & (url.start + perpage) & qstring>
                        <cfoutput><a href="#link#">Next Page</a></cfoutput>
                        <cfelse>
                        Next Page
                      </cfif>
                      ] </p></td>
                </tr>
              </tbody>
            </table>
          </div></td>
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