<cfparam name="URL.pid" default="#SESSION.account.id#">

<cfquery name="account_rs" datasource="#application.datasource#">
	SELECT * 
  FROM accounts 
  WHERE accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.pid#">
</cfquery>

<cfquery name="professions_rs" datasource="#application.datasource#">
	SELECT professions.*, professiontypes.professionTitle
  FROM professions
  INNER JOIN professiontypes
  ON professions.professionID = professiontypes.professionID
  WHERE professions.accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.pid#">
</cfquery>

<cfquery name="comments_rs" datasource="#application.datasource#">
	SELECT comments.*, accounts.accountCompanyName
  FROM comments
  INNER JOIN accounts
  ON comments.commentLeftBy = accounts.accountID
  WHERE comments.commentFor = #url.pid#
  ORDER BY comments.commentPostedDate ASC
</cfquery>

<cfquery name="avg_rs" datasource="#application.datasource#">
	SELECT AVG(commentRating) AS rating 
  FROM comments
  WHERE commentFor = #URL.pid#
</cfquery>

<cfif avg_rs.rating eq "">
	<cfset rating = 0>
<cfelse>
	<cfset rating = avg_rs.rating>
</cfif>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ProDriver</title>
<link rel="stylesheet" type="text/css" href="css/global.css" />
<link rel="stylesheet" type="text/css" href="css/profile.css" />
<link rel="stylesheet" type="text/css" href="css/colorbox.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.dop.BookingCalendar.css" />
<style type="text/css">
	body { background-image:url(images/new/tpl-bg-3.png); background-repeat:repeat-x; background-color:#2D2D2D; }
</style>
<script type="text/javascript" src="js/all.js"></script>
<script type="text/javascript" src="js/jquery.dop.BookingCalendar.js"></script>
<script type="text/javascript">_this.init("profile");</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <cfinclude template="inc-menu.cfm">
  <div id="content-container">
    <form>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:10px solid #FFFFFF; margin:20px 0 0 0;">
        <tr>
          <td colspan="2" style="background:#4f4f4f;">
          <div class="page-title">MY PROFILE</div>
          </td>
        </tr>
        <tr>
          <td width="210" rowspan="4" valign="top" style="border-top:3px solid #FFFFFF; border-right:3px solid #FFFFFF; background:#4f4f4f;">
          <div class="prof_image"><img src="images/profile_pics/<cfoutput>#account_rs.accountProfileImage#</cfoutput>" width="175" height="175"></div>
          <div style="clear:both;"></div>
          <div class="prof_sidebar">Driver Rating<br>
            <div style="margin-top:10px;">
            	<span id="driverRatingNo1" class="driverRating"></span>
							<script>
                $("#driverRatingNo1").raty({ path:"images/raty/", 
                                          readOnly:true, 
                                          number:5,
																					start:<cfoutput>#rating#</cfoutput>,
                                          width:"260px", 
                                          size:24,
                                          starOff:'star-off-big.png',
                                          starOn:'star-on-big.png',
                                          });
              </script>
            </div>
            <div style="border:1px solid #666; width:186px; margin-top:10px;"></div>
						<cfif URL.pid neq SESSION.account.id>
            <div style="margin-top:10px;"> <a id="emailDriverBtn" href=""><img src="images/emailDriver_btn.png" border="0"></a></div>
            <div style="border:1px solid #666; width:186px; margin-top:10px;"></div>
            </cfif>
            <div style="margin-top:10px;"> <a id="reqDriverCredBtn" href="" title="<cfoutput>#URL.pid#</cfoutput>"><img src="images/reqCred_btn.png" width="169" height="48" border="0"></a> </div>
          </div>
          </td>
          <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;">
          <div class="section-title"><cfoutput>#account_rs.accountFirstName# #account_rs.accountLastName#</cfoutput></div>
          <div class="section-body">
            <div class="top">
              <div class="one">Preferred Airport<br> <span style="color:#fff; font-size:12px;"><cfoutput>#account_rs.accountPreferredAirport#</cfoutput></span> </div>
              <div class="two">Home Base<br> <span style="color:#fff; font-size:12px;"><cfoutput>#account_rs.accountCity#, #account_rs.accountState#</cfoutput></span> </div>
              <div class="three">Current City<br> <span style="color:#fff; font-size:12px;"><cfoutput>#account_rs.accountCurrentCity#</cfoutput></span> </div>
              <div class="one" style="font-size:14px; color:#e6ae02; font-weight:bold; margin-top:15px;">Current Employer<br> <span style="color:#000; font-size:12px;"><cfoutput>#account_rs.accountCurrentEmployer#</cfoutput></span> </div>
              <div class="two"  style="font-size:14px; color:#e6ae02; font-weight:bold; margin-top:15px; ">Canadian Driver Approved<br> <span style="color:#000; font-size:12px;"><cfoutput>#account_rs.accountCanadaRequirements#</cfoutput></span> </div>
              <div class="three" style="font-size:14px; color:#e6ae02; font-weight:bold; margin-top:15px; ">Telephone<br> <span style="color:#000; font-size:12px;"><cfoutput>#account_rs.accountPhone#</cfoutput></span> </div>
              <div class="one" style="font-size:14px; color:#e6ae02; font-weight:bold; margin-top:15px;">Passport<br> <span style="color:#000; font-size:12px;"><cfoutput>#account_rs.accountPassport#</cfoutput></span> </div>
              <div class="two"  style="font-size:14px; color:#e6ae02; font-weight:bold; margin-top:15px;">Date of Birth<br> <span style="color:#000; font-size:12px;"><cfoutput>#dateformat(account_rs.accountDOB,"mm-dd-yyyy")#</cfoutput></span> </div>
            </div>
            <div class="four" style="font-size:14px; color:#e6ae02; font-weight:bold; text-indent:27px; padding-top:5px;">Driving Professions:<br> <span style="float:left; color:#000; font-size:12px; text-indent:27px;"><cfoutput query="professions_rs">#professions_rs.professionTitle#&nbsp;&nbsp;-&nbsp;&nbsp;</cfoutput></span> </div>
          </div>
          </td>
        </tr>
        <tr>
          <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;">
          <div class="section-title">Driver Calendar</div>
          <div class="section-body">
            <!---<div class="booking">Booking Availability</div>--->
            <div id="front-container">
                <div id="frontend"></div>
            </div>
          </div>
          </td>
        </tr>
        <tr>
          <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;">
            <div class="section-title" style="background-color:#ff7002;">About Driver</div>
            <div class="section-body" style="font-size:14px; padding-left:10px; padding-top:10px; padding-right:5px;"> <cfoutput>#paragraphformat(account_rs.accountBio)#</cfoutput></div>
          </td>
        </tr>
        <tr>
          <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;">
          <div class="section-title1" style=" color:#fff; background-color:#4f4f4f; text-align:left; height:28px;">
            <div style="float:left; margin:5px 0 0 0;">Driver Comments</div>
            <div style="margin:5px 20px 0 85px; float:left;">Rate:
           		<span id="driverRatingNo2" class="driverRating"></span>
							<script>
                $("#driverRatingNo2").raty({ path:"images/raty/", 
                                          readOnly:true, 
                                          number:5,
																					start:<cfoutput>#rating#</cfoutput>,
                                          width:"260px", 
                                          size:24,
                                          starOff:'star-off-big.png',
                                          starOn:'star-on-big.png',
                                          });
              </script>
            </div>
            <cfif URL.pid neq SESSION.account.id>
            <div style="float:right;"><a id="commentBtn" href="javascript:;"><img src="images/subCom_btn.png" width="157" height="30" border="0" align="absmiddle"></a></div>
            </cfif>
          </div>
          <div class="section-body" style="font-size:12px; padding-left:10px; padding-top:10px; padding-right:5px;">
          	<cfoutput query="comments_rs">
            <strong><a href="co_profile.cfm?pid=#comments_rs.commentLeftBy#">#comments_rs.accountCompanyName#</a></strong><br> 
            #comments_rs.commentBody#<br><br>
            </cfoutput>
          </div>
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
<div style="display:none;">
  <div id="commentForm">
  	<form id="commentRatingForm">
    <div class="section-title" style="background-color:#4f4f4f; color:#ffffff;">Submit Comment</div>
    <div class="section-body" style="font-size:14px; padding:10px 5px 0 10px;">
    	<table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
        	<td valign="top">
          	<div style="margin:0; height:28px; width:300px;">Rate: <span id="driverRating" class="driverRating"></span></div>
            <script>
							$("#driverRating").raty({ path:"images/raty/", 
																				readOnly:false, 
																				number:5, 
																				width:"260px", 
																				height:"28px",
																				targetKeep: true,
																				targetType: "number",
																				cancel:true, 
																				cancelPlace:"right", 
																				size:24,
																				starOff:'star-off-big.png',
																				starOn:'star-on-big.png',
																				cancelOff:'cancel-off-big.png', 
																				cancelOn:'cancel-on-big.png' });
            </script>
          </td>
        </tr>
        <tr>
        	<td>
            <textarea name="commentBody" style="width:99%; height:130px; margin:5px 0 0 0;"></textarea>
            <input id="commentLeftBy" name="commentLeftBy" type="hidden" value="<cfoutput>#SESSION.account.id#</cfoutput>">
            <input id="commentFor" name="commentFor" type="hidden" value="<cfoutput>#URL.pid#</cfoutput>">
          	<a id="submitCommentBtn" href="javascript:;"><img src="images/subCom_btn.png" width="157" height="30" border="0" style="margin:10px 0 0 0;"></a>
          </td>
        </tr>
      </table>
    </div>
    </form>
  </div>
</div>

<div style="display:none;">
  <div id="emailFormContainer">
  	<form id="emailForm">
    <div class="section-title" style="background-color:#4f4f4f; color:#ffffff;">Send Email</div>
    <div class="section-body" style="font-size:14px; padding:10px 5px 0 10px;">
    	<table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
        	<td><div style="margin:0 0 5px 0;">Subject:</div><input name="messageSubject" type="text" style="width:99%;"></td>
        </tr>
        <tr>
        	<td>
            <div style="margin:5px 0 5px 0;">Message:</div>
            <textarea name="messageBody" style="width:99%; height:130px; margin:0 0 0 0;"></textarea>
            <input id="messageFromID" name="messageFromID" type="hidden" value="<cfoutput>#SESSION.account.id#</cfoutput>">
            <input id="messageToID" name="messageToID" type="hidden" value="<cfoutput>#URL.pid#</cfoutput>">
          	<a id="emailSubmitBtn" href=""><img src="images/emailDriver_btn.png" width="168" height="35" border="0" style="margin:10px 0 0 0;"></a>
          </td>
        </tr>
      </table>
    </div>
    </form>
  </div>
</div>

</body>
</html>