<cfcomponent>

	<cfsetting enablecfoutputonly="Yes" showdebugoutput="No" requesttimeout="80000">
  
  <cffunction name="approveAccount" access="remote">
  	<cfargument name="accountID" type="numeric" required="yes">
    <cfquery name="account_rs" datasource="#APPLICATION.datasource#">SELECT * FROM accounts WHERE accountID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.accountID#"></cfquery>
		<cfset FORM.accountID = ARGUMENTS.accountID>
    <cfset FORM.accountStatus = 3>
    <cfset APPLICATION.datamanager.updaterecord("accounts", FORM)>
    <!--- send email to account holder to proceed with payment --->
    <cfmail from="support@prodriver-online.com" 
    				to="#account_rs.accountEmail#"
            subject="Prodriver: Your Account Has Been Approved"
            type="html">
    Your account has been approved! The next time you log in, you will be prompted to proceed with the payment steps. <a href="http://"www.prodriver-online.com>www.prodriver-online.com</a>        
    </cfmail>
    <cflocation url="admin.cfm" addtoken="no">
  </cffunction>
  
  
  
  <cffunction name="activateAccount" access="remote">
  	<cfargument name="accountID" type="numeric" required="yes">
    <cfquery name="account_rs" datasource="#APPLICATION.datasource#">SELECT * FROM accounts WHERE accountID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.accountID#"></cfquery>
		<cfset FORM.accountID = ARGUMENTS.accountID>
    <cfset FORM.accountStatus = 4>
    <cfset APPLICATION.datamanager.updaterecord("accounts", FORM)>
    <!--- send email to account holder to proceed with payment --->
    <cfmail from="support@prodriver-online.com" 
    				to="#account_rs.accountEmail#"
            subject="Prodriver: Your Account Has Been Activated"
            type="html">
    Your payment has been made and your account has been activated! The next time you log in, you will have full access to the website. <a href="http://"www.prodriver-online.com>www.prodriver-online.com</a>        
    </cfmail>
    <cflocation url="admin.cfm" addtoken="no">
  </cffunction>



	<cffunction name="checkAuthorization" access="remote">
  	<cfargument name="loginAccountEmail" type="string" required="yes">
    <cfargument name="loginAccountPassword" type="string" required="yes">
    <cfargument name="loginAccountRememberMe" type="boolean" required="no">
    <cfquery name="rs" datasource="#APPLICATION.datasource#">
    	SELECT *
      FROM accounts
      WHERE accountEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.loginAccountEmail#">
      AND accountPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(ARGUMENTS.loginAccountPassword, "SHA-512")#">
    </cfquery>
    <cfif rs.recordcount gt 0>
			<cfset SESSION.ACCOUNT.ID = rs.accountID>
      <cfset SESSION.ACCOUNT.TYPE = rs.accountTypeID>
      <cfset SESSION.ACCOUNT.STATUS = rs.accountStatus>
      <cfoutput>{ "success":true, "status":#rs.accountStatus#, "type":#rs.accountTypeID#  }</cfoutput>
    <cfelse>
    	<cfoutput>{ "success":false }</cfoutput>
		</cfif>
  </cffunction>
  
  
  
  <cffunction name="checkEmailDuplicate" access="remote">
  	<cfargument name="fieldId" required="yes">
    <cfargument name="fieldValue" required="yes">
    <cfquery name="rs" datasource="#APPLICATION.datasource#">
    	SELECT *
      FROM accounts
      WHERE accountEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fieldValue#">
    </cfquery>
    <cfif rs.recordcount gt 0>
    	<cfoutput>["#arguments.fieldId#",false]</cfoutput>
    <cfelse>
    	<cfoutput>["#arguments.fieldId#",true]</cfoutput>
    </cfif>
  </cffunction>
  
  
  
  <cffunction name="editCompanyProfile" access="remote">
  	
    <cfif isdefined("FORM.accountCompanyLogo") and FORM.accountCompanyLogo neq "">
      <cffile action="upload" filefield="accountCompanyLogo" destination="E:\www\prodriver-online.com\temp\#SESSION.account.id#.jpg" nameconflict="overwrite" />
      <cfimage action="read" name="img" source="E:\www\prodriver-online.com\temp\#SESSION.account.id#.jpg" format="jpg">
      <cfset sq_size = 100>
      <cfset imagesetantialiasing(img, "on")>
      <cfset imagescaletofit(img, sq_size, sq_size)>
      <cfif img.width gte img.height>
				<cfset x = 0>
        <cfset y = ceiling((img.width - img.height)/2)>
      <cfelse>
				<cfset x = ceiling((img.height - img.width)/2)>
        <cfset y = 0>
      </cfif>
      <cfset newimg = imagenew("",sq_size, sq_size, "rgb", "FFFFFF")>
      <cfset imagepaste(newimg, img, x, y)>
      <cfimage action="write" source="#newimg#" destination="#APPLICATION.startingDirectory#images\profile_pics\#SESSION.account.id#.jpg" format="jpg" overwrite="yes">
    </cfif>
    
    
    <cfset FORM.accountID = SESSION.account.id>
    <cfset FORM.accountCompanyLogo = "#SESSION.account.id#.jpg">
		<cfset action = APPLICATION.datamanager.updaterecord("accounts", FORM)>
    <cfset action2 = APPLICATION.datamanager.insertrecord("contacts", FORM)>
    <cflocation url="co_profile.cfm" addtoken="no">
  </cffunction>
  
  
  
  <cffunction name="deleteAllDocuments" access="remote">
  	<cfargument name="accountID" type="numeric" required="yes">
    <cfdirectory action="delete" directory="#APPLICATION.filestore#\#ARGUMENTS.accountID#\" recurse="yes">
    <cflocation url="admin.cfm" addtoken="no">
  </cffunction>
  
  
  
  <cffunction name="requestDriverCredentials" access="remote">
  	<cfargument name="accountID" type="numeric" required="yes">
    <cfquery name="rs" datasource="#APPLICATION.datasource#">
    	SELECT *
      FROM accounts
      WHERE accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.accountID#">
    </cfquery>
    <cfquery name="rs2" datasource="#APPLICATION.datasource#">
    	SELECT *
      FROM accounts
      WHERE accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.account.id#">
    </cfquery>
    <cfmail from="support@prodriver-online.com" 
    				to="support@prodriver-online.com"
            cc="luis@the360interactive.com"
            subject="Prodriver: Driver Credentials Request"
            type="html">
    A request has been made for the credentials for #rs.accountFirstName# #rs.accountLastName# (#rs.accountID#) by #rs2.accountFirstName# #rs2.accountLastName# (#rs2.accountID#). <a href="http://"www.prodriver-online.com>www.prodriver-online.com</a>        
    </cfmail>
    <cflocation url="profile.cfm?pid=#ARGUMENTS.accountID#" addtoken="no">
  </cffunction>
  
  
  
  <cffunction name="saveComment" access="remote">
  	<cfset FORM.commentPostedDate = now()>
    <cfset FORM.commentRating = FORM.score>
		<cfset action = APPLICATION.datamanager.insertrecord("comments", FORM)>
    <cfoutput>{ "success":"true" }</cfoutput>
  </cffunction>
  
  
  
  <cffunction name="saveEditProfile" access="remote">
  	
    <cfsetting requesttimeout="99999">
    
    <cfdump var="#form#">

		<!--- save professions to db --->
    <cfif isdefined("form.accountProfessions") and form.accountProfessions neq "">
			<cfset APPLICATION.datamanager.saverelationlist("professions","accountID",#SESSION.account.id#,"professionID","#FORM.accountProfessions#")>
    </cfif>
    
    <cfif isdefined("FORM.accountProfileImage") and FORM.accountProfileImage neq "">
      <cffile action="upload" filefield="accountProfileImage" destination="E:\www\prodriver-online.com\temp\#SESSION.account.id#.jpg" nameconflict="overwrite" />
      <cfimage action="read" name="img" source="E:\www\prodriver-online.com\temp\#SESSION.account.id#.jpg" format="jpg">
      <cfset sq_size = 100>
      <cfset imagesetantialiasing(img, "on")>
      <cfset imagescaletofit(img, sq_size, sq_size)>
      <cfif img.width gte img.height>
				<cfset x = 0>
        <cfset y = ceiling((img.width - img.height)/2)>
      <cfelse>
				<cfset x = ceiling((img.height - img.width)/2)>
        <cfset y = 0>
      </cfif>
      <cfset newimg = imagenew("",sq_size, sq_size, "rgb", "FFFFFF")>
      <cfset imagepaste(newimg, img, x, y)>
      <cfimage action="write" source="#newimg#" destination="#APPLICATION.startingDirectory#images\profile_pics\#SESSION.account.id#.jpg" format="jpg" overwrite="yes">
    </cfif>
		
		<!--- all the uploaded documents --->
		<cfif not directoryexists("#APPLICATION.filestore#\#SESSION.account.id#\")>
			<cfdirectory action="create" directory="#APPLICATION.filestore#\#SESSION.account.id#\">
		</cfif>
		
    <!--- driver application --->
		<cfif isdefined("FORM.accountDriverApplication") and FORM.accountDriverApplication neq "">
      <cffile action="upload" filefield="accountDriverApplication" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_driver_application.pdf" nameconflict="overwrite"  />
      <cfoutput>driver app uploaded</cfoutput>
      <cfset FORM.accountDriverApplication = "#SESSION.account.id#_driver_application.pdf">
    </cfif>
    
    <!--- medical long form --->
    <cfif isdefined("FORM.accountMedicalLongForm") and FORM.accountMedicalLongForm neq "">
      <cffile action="upload" filefield="accountMedicalLongForm" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_medical_long_form.pdf" nameconflict="overwrite" />
      <cfoutput>medical long form uploaded</cfoutput>
      <cfset FORM.accountMedicalLongForm = "#SESSION.account.id#_medical_long_form.pdf">
    </cfif>
    
    <!--- copy of license --->
    <cfif isdefined("FORM.accountCopyOfLicense") and FORM.accountCopyOfLicense neq "">
      <cffile action="upload" filefield="accountCopyOfLicense" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_copy_of_license.pdf" nameconflict="overwrite" />
      <cfoutput>copy of license uploaded</cfoutput>
      <cfset FORM.accountCopyOfLicense = "#SESSION.account.id#_copy_of_license.pdf">
    </cfif>
    
    <!--- i-9 --->
    <cfif isdefined("FORM.accountI9") and FORM.accountI9 neq "">
      <cffile action="upload" filefield="accountI9" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_i9.pdf" nameconflict="overwrite" />
      <cfoutput>i9 uploaded</cfoutput>
      <cfset FORM.accountI9 = "#SESSION.account.id#_i9.pdf">
    </cfif>
    
    <!--- fair credit disclosure --->
    <cfif isdefined("FORM.accountFairCreditDisclosure") and FORM.accountFairCreditDisclosure neq "">
      <cffile action="upload" filefield="accountFairCreditDisclosure" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_fair_credit_disclosure.pdf" nameconflict="overwrite" />
      <cfoutput>fair credit uploaded</cfoutput>
      <cfset FORM.accountFairCreditDisclosure = "#SESSION.account.id#_fair_credit_disclosure.pdf">
    </cfif>
    
    <!--- mvr --->
    <cfif isdefined("FORM.accountMVR") and FORM.accountMVR neq "">
      <cffile action="upload" filefield="accountMVR" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_mvr.pdf" nameconflict="overwrite" />
      <cfoutput>MVR uploaded</cfoutput>
      <cfset FORM.accountMVR = "#SESSION.account.id#_mvr.pdf">
    </cfif>
    
    <!--- social security card --->
    <cfif isdefined("FORM.accountSSN") and FORM.accountSSN neq "">
      <cffile action="upload" filefield="accountSSN" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_ssn.pdf" nameconflict="overwrite" />
      <cfoutput>ssn uploaded</cfoutput>
      <cfset FORM.accountSSN = "#SESSION.account.id#_ssn.pdf">
    </cfif>
    
    <!--- background check --->
    <cfif isdefined("FORM.accountBackgroundCheck") and FORM.accountBackgroundCheck neq "">
      <cffile action="upload" filefield="accountBackgroundCheck" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_background_check.pdf" nameconflict="overwrite" />
      <cfoutput>background check uploaded</cfoutput>
      <cfset FORM.accountBackgroundCheck = "#SESSION.account.id#_background_check.pdf">
    </cfif>
    
    <!--- dot medical --->
    <cfif isdefined("FORM.accountDOTMedical") and FORM.accountDOTMedical neq "">
      <cffile action="upload" filefield="accountDOTMedical" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_dot_medical.pdf" nameconflict="overwrite" />
      <cfoutput>dot medical uploaded</cfoutput>
      <cfset FORM.accountDOTMedical = "#SESSION.account.id#_dot_medical.pdf">
    </cfif>
    
    <!--- W2 --->
    <cfif isdefined("FORM.accountW2") and FORM.accountW2 neq "">
      <cffile action="upload" filefield="accountW2" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_w2.pdf" nameconflict="overwrite" />
      <cfoutput>w2 uploaded</cfoutput>
      <cfset FORM.accountW2 = "#SESSION.account.id#_w2.pdf">
    </cfif>
    
    <!--- save bio flag field --->
    <cfif NOT isdefined("FORM.accountBioFlag") or FORM.accountBioFlag eq "">
			<cfset FORM.accountBioFlag = 0>
		</cfif>
    
		<cfset FORM.accountID = SESSION.account.id>
    <cfset FORM.accountProfileImage = "#SESSION.account.id#.jpg">
		<cfset action = APPLICATION.datamanager.updaterecord("accounts", FORM)>
    <cflocation url="profile.cfm" addtoken="no">
    
  </cffunction>
  
  
  
  <cffunction name="searchDriverAccounts" access="remote">
  
  	<cfquery name="search_rs" datasource="#APPLICATION.datasource#">
    	SELECT *
      FROM accounts
      WHERE accountID
      NOT IN ( SELECT DISTINCT accountID 
      				 FROM calendar 
               WHERE calendarDate >= '#dateformat(startDate,"yyyy-mm-dd")#' 
               AND calendarDate <='#dateformat(endDate,"yyyy-mm-dd")#' )
			<cfif isdefined("FORM.professions") and FORM.professions neq "">
			AND accountID 
      IN ( SELECT DISTINCT accountID
      		 FROM professions
           WHERE professionID IN (#FORM.professions#) )
			</cfif>               
      <cfif isdefined("FORM.accountState") and FORM.accountState neq "">AND accounts.accountState = '#trim(FORM.accountState)#'</cfif>
      <cfif isdefined("FORM.accountFirstName") and FORM.accountFirstName neq "">AND accounts.accountFirstName = '#trim(FORM.accountFirstName)#'</cfif>
      <cfif isdefined("FORM.accountLastName") and FORM.accountLastName neq "">AND accounts.accountLastName = '#trim(FORM.accountLastName)#'</cfif>
      <cfif isdefined("FORM.passport") and FORM.passport neq "">AND accounts.accountPassport = '#trim(FORM.passport)#'</cfif>
      <cfif isdefined("FORM.canadian") and FORM.canadian neq "">AND accounts.accountCanadaRequirements = '#trim(FORM.canadian)#'</cfif>
    </cfquery>
    
    <cfdump var="#search_rs#">
  </cffunction>
  
  
  
  <cffunction name="loadCalendarData" access="remote">
    <cfargument name="pid" default="#SESSION.ACCOUNT.ID#" required="no">
    <cfsetting enablecfoutputonly="true"></cfsetting>
    <cfquery name="rs" datasource="#APPLICATION.datasource#">SELECT * FROM calendar WHERE accountID = 0 OR accountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pid#"></cfquery>
		<cfoutput query="rs">#dateformat(rs.calendarDate,"yyyy-mm-dd")#;;#rs.calendarStatus#;;#calendarAmount#<cfif rs.currentrow neq rs.recordcount>,</cfif></cfoutput>
  </cffunction>
  
  
  
  <cffunction name="replyMessage" access="remote">
  	<cfargument name="messageParentID" type="numeric" required="yes">
    <cfargument name="messageToID" type="numeric" required="yes">
    <cfargument name="messageFromID" type="numeric" required="yes">
    <cfset FORM.messageDate = now()>
    <cfset action = APPLICATION.datamanager.insertrecord("messages", FORM)>
    <cflocation url="messages.cfm" addtoken="no">
  </cffunction>
  
  
  
  <cffunction name="saveCalendarChanges" access="remote">
    <cfargument name="dop_booking_calendar" type="string" required="no">
    <cfloop list="#ARGUMENTS.dop_booking_calendar#" index="i" delimiters=",">
      
			<cfset tmp = listtoarray(i,";;")>
			
			<cfset data = structnew()>
      <cfset data.accountID = SESSION.ACCOUNT.ID>
      <cfset data.calendarDate = tmp[1]>
      
      <cfif tmp[2] eq 2>
				<!--- add record to calendar table with account id --->
				<cfset data.calendarStatus = tmp[2]>
        <cfset data.calendarAmount = 0>
        <cfset action = APPLICATION.datamanager.saverecord("calendar", data)>
			</cfif>
      <cfif tmp[2] eq 1>
				<!--- check to see if a record exists using the date as ID and delete if it does --->
				<cfset action = APPLICATION.datamanager.deleterecord("calendar", data)>
			</cfif>
    </cfloop>
  </cffunction>
  
  
  
  <cffunction name="sendMessage" access="remote">
  	<cfset form.messageDate = now()>
		<cfset action = APPLICATION.datamanager.insertrecord("messages", form)>
    <cfoutput>{ "success":"true" }</cfoutput>
  </cffunction>
  
  
  
  <cffunction name="signupCompanyStep1" access="remote">
  	<cfset FORM.accountPassword = hash(FORM.accountPassword, "SHA-512")>
		<cfset FORM.accountTypeID = 1>
    <cfset FORM.accountCreationDate = now()>
    <cfset FORM.accountStatus = 7>
		<cfset id = APPLICATION.datamanager.insertrecord("accounts", FORM)>
    <cfset SESSION.ACCOUNT.ID = id>
    <cfset SESSION.ACCOUNT.TYPE = 2>
    <cfset SESSION.ACCOUNT.STATUS = 7>
    <cflocation url="signup-company-2.cfm" addtoken="no">
  </cffunction>
  
  
  
  <cffunction name="signupCompanyStep2" access="remote">
		<cfif isdefined("FORM.accountCompanyLogo") and FORM.accountCompanyLogo neq "">
      <cffile action="upload" filefield="accountCompanyLogo" destination="E:\www\prodriver-online.com\temp\#SESSION.account.id#.jpg" nameconflict="overwrite" />
      <cfimage action="read" name="img" source="E:\www\prodriver-online.com\temp\#SESSION.account.id#.jpg" format="jpg">
      <cfset sq_size = 100>
      <cfset imagesetantialiasing(img, "on")>
      <cfset imagescaletofit(img, sq_size, sq_size)>
      <cfif img.width gte img.height>
				<cfset x = 0>
        <cfset y = ceiling((img.width - img.height)/2)>
      <cfelse>
				<cfset x = ceiling((img.height - img.width)/2)>
        <cfset y = 0>
      </cfif>
      <cfset newimg = imagenew("",sq_size, sq_size, "rgb", "FFFFFF")>
      <cfset imagepaste(newimg, img, x, y)>
      <cfimage action="write" source="#newimg#" destination="#APPLICATION.startingDirectory#images\profile_pics\#SESSION.account.id#.jpg" format="jpg" overwrite="yes">
    </cfif>
    <cfset FORM.accountID = #SESSION.account.id#>
    <cfset FORM.accountCompanyLogo = "#SESSION.account.id#.jpg">
    <cfset FORM.accountCreationDate = now()>
    <cfset FORM.accountStatus = 1>
    <cfset action = APPLICATION.datamanager.updaterecord("accounts", FORM)>
    
    <!--- send email to account holder to proceed with payment --->
    <cfmail from="no.reply@prodriver-online.com" 
    				to="support@prodriver-online.com"
            subject="Prodriver: COMPANY ACCOUNT SUBMISSION"
            type="html">
    A company profile has been created. Please login to the admin account to approve and download documents.
    </cfmail>
    
    <cflocation url="signup-company-confirmation.cfm" addtoken="no">
  </cffunction>
  
  
  
  <cffunction name="signupDriverStep1" access="remote">
		<cfset FORM.accountPassword = hash(FORM.accountPassword, "SHA-512")>
    <cfset FORM.accountTypeID = 2>
    <cfset FORM.accountCreationDate = now()>
    <cfset FORM.accountStatus = 7>
    <cfset id = APPLICATION.datamanager.insertrecord("accounts", FORM)>
    <cfset SESSION.ACCOUNT.ID = id>
    <cfset SESSION.ACCOUNT.TYPE = 2>
    <cfset SESSION.ACCOUNT.STATUS = 7>
    <cflocation url="signup-driver-2.cfm" addtoken="no">
  </cffunction>
  
  
  
  <cffunction name="signupDriverStep2" access="remote">
		<cfif isdefined("FORM.accountProfileImage") and FORM.accountProfileImage neq "">
      <cffile action="upload" filefield="accountProfileImage" destination="E:\www\prodriver-online.com\temp\#SESSION.account.id#.jpg" nameconflict="overwrite" />
      <cfimage action="read" name="img" source="E:\www\prodriver-online.com\temp\#SESSION.account.id#.jpg" format="jpg">
      <cfset sq_size = 100>
      <cfset imagesetantialiasing(img, "on")>
      <cfset imagescaletofit(img, sq_size, sq_size)>
      <cfif img.width gte img.height>
				<cfset x = 0>
        <cfset y = ceiling((img.width - img.height)/2)>
      <cfelse>
				<cfset x = ceiling((img.height - img.width)/2)>
        <cfset y = 0>
      </cfif>
      <cfset newimg = imagenew("",sq_size, sq_size, "rgb", "FFFFFF")>
      <cfset imagepaste(newimg, img, x, y)>
      <cfimage action="write" source="#newimg#" destination="#APPLICATION.startingDirectory#images\profile_pics\#SESSION.account.id#.jpg" format="jpg" overwrite="yes">
    </cfif>
    <cfset FORM.accountID = #SESSION.account.id#>
    <cfset FORM.accountProfileImage = "#SESSION.account.id#.jpg">
    <cfset FORM.accountStatus = 8>
    <cfset action = APPLICATION.datamanager.updaterecord("accounts", FORM)>
    <cflocation url="signup-driver-3.cfm" addtoken="no">
  </cffunction>
  
  
  
  <cffunction name="signupDriverStep3" access="remote">
		
		<cfif not directoryexists("#APPLICATION.filestore#\#SESSION.account.id#\")>
			<cfdirectory action="create" directory="#APPLICATION.filestore#\#SESSION.account.id#\">
		</cfif>
    
    <!--- driver application --->
		<cfif isdefined("FORM.accountDriverApplication") and FORM.accountDriverApplication neq "">
      <cffile action="upload" filefield="accountDriverApplication" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_driver_application.pdf" nameconflict="overwrite"  />
      <cfset FORM.accountDriverApplication = "#SESSION.account.id#_driver_application.pdf">
    </cfif>
    
    <!--- medical long form --->
    <cfif isdefined("FORM.accountMedicalLongForm") and FORM.accountMedicalLongForm neq "">
      <cffile action="upload" filefield="accountMedicalLongForm" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_medical_long_form.pdf" nameconflict="overwrite" />
      <cfset FORM.accountMedicalLongForm = "#SESSION.account.id#_medical_long_form.pdf">
    </cfif>
    
    <!--- copy of license --->
    <cfif isdefined("FORM.accountCopyOfLicense") and FORM.accountCopyOfLicense neq "">
      <cffile action="upload" filefield="accountCopyOfLicense" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_copy_of_license.pdf" nameconflict="overwrite" />
      <cfset FORM.accountCopyOfLicense = "#SESSION.account.id#_copy_of_license.pdf">
    </cfif>
    
    <!--- i-9 --->
    <cfif isdefined("FORM.accountI9") and FORM.accountI9 neq "">
      <cffile action="upload" filefield="accountI9" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_i9.pdf" nameconflict="overwrite" />
      <cfset FORM.accountI9 = "#SESSION.account.id#_i9.pdf">
    </cfif>
    
    <!--- fair credit disclosure --->
    <cfif isdefined("FORM.accountFairCreditDisclosure") and FORM.accountFairCreditDisclosure neq "">
      <cffile action="upload" filefield="accountFairCreditDisclosure" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_fair_credit_disclosure.pdf" nameconflict="overwrite" />
      <cfset FORM.accountFairCreditDisclosure = "#SESSION.account.id#_fair_credit_disclosure.pdf">
    </cfif>
    
    <!--- mvr --->
    <cfif isdefined("FORM.accountMVR") and FORM.accountMVR neq "">
      <cffile action="upload" filefield="accountMVR" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_mvr.pdf" nameconflict="overwrite" />
      <cfset FORM.accountMVR = "#SESSION.account.id#_mvr.pdf">
    </cfif>
    
    <!--- social security card --->
    <cfif isdefined("FORM.accountSSN") and FORM.accountSSN neq "">
      <cffile action="upload" filefield="accountSSN" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_ssn.pdf" nameconflict="overwrite" />
      <cfset FORM.accountSSN = "#SESSION.account.id#_ssn.pdf">
    </cfif>
    
    <!--- background check --->
    <cfif isdefined("FORM.accountBackgroundCheck") and FORM.accountBackgroundCheck neq "">
      <cffile action="upload" filefield="accountBackgroundCheck" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_background_check.pdf" nameconflict="overwrite" />
      <cfset FORM.accountBackgroundCheck = "#SESSION.account.id#_background_check.pdf">
    </cfif>
    
    <!--- dot medical --->
    <cfif isdefined("FORM.accountDOTMedical") and FORM.accountDOTMedical neq "">
      <cffile action="upload" filefield="accountDOTMedical" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_dot_medical.pdf" nameconflict="overwrite" />
      <cfset FORM.accountDOTMedical = "#SESSION.account.id#_dot_medical.pdf">
    </cfif>
    
    <!--- W2 --->
    <cfif isdefined("FORM.accountW2") and FORM.accountW2 neq "">
      <cffile action="upload" filefield="accountW2" destination="#APPLICATION.filestore#\#SESSION.account.id#\#SESSION.account.id#_w2.pdf" nameconflict="overwrite" />
      <cfset FORM.accountW2 = "#SESSION.account.id#_w2.pdf">
    </cfif>
    
    <cfset FORM.accountID = SESSION.account.id>
		<cfset FORM.accountStatus = 1>
    <cfset action = APPLICATION.datamanager.updaterecord("accounts", FORM)>
    
    <!--- send email to account holder to proceed with payment --->
    <cfmail from="no.reply@prodriver-online.com" 
    				to="support@prodriver-online.com"
            subject="Prodriver: DRIVER ACCOUNT SUBMISSION"
            type="html">
    A driver profile has been created. Please login to the admin account to approve and download documents.
    </cfmail>
    
    <cflocation url="signup-driver-confirmation.cfm" addtoken="no">
    
  </cffunction>
  
  
  
  <cffunction name="reinstateAccount" access="remote">
  	<cfargument name="accountID" type="numeric" required="yes">
    <cfquery name="account_rs" datasource="#APPLICATION.datasource#">SELECT * FROM accounts WHERE accountID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.accountID#"></cfquery>
		<cfset FORM.accountID = ARGUMENTS.accountID>
    <cfset FORM.accountStatus = 4>
    <cfset APPLICATION.datamanager.updaterecord("accounts", FORM)>
    <!--- send email to account holder to proceed with payment --->
    <cfmail from="support@prodriver-online.com" 
    				to="#account_rs.accountEmail#"
            subject="Prodriver: Your Account Has Been Reinstated"
            type="html">
    Your account has been reinstated. You may now login successfully at <a href="http://www.prodriver-online.com">prodriver-online.com</a>.        
    </cfmail>
    <cflocation url="admin.cfm" addtoken="no">
  </cffunction>
  
  
  
  <cffunction name="suspendAccount" access="remote">
  	<cfargument name="accountID" type="numeric" required="yes">
    <cfquery name="account_rs" datasource="#APPLICATION.datasource#">SELECT * FROM accounts WHERE accountID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.accountID#"></cfquery>
		<cfset FORM.accountID = ARGUMENTS.accountID>
    <cfset FORM.accountStatus = 5>
    <cfset APPLICATION.datamanager.updaterecord("accounts", FORM)>
    <!--- send email to account holder to proceed with payment --->
    <cfmail from="support@prodriver-online.com" 
    				to="#account_rs.accountEmail#"
            subject="Prodriver: Your Account Has Been Suspended"
            type="html">
    Your account has been suspended. Contact <a href="mailto:support@prodriver-online.com">support@prodriver-online.com</a> for more information. <a href="http://"www.prodriver-online.com>www.prodriver-online.com</a>        
    </cfmail>
    <cflocation url="admin.cfm" addtoken="no">
  </cffunction>
  
  
  
</cfcomponent>