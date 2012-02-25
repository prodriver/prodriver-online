<cfcomponent output="false" hint="I define the application and root-level event handlers.">
 
	<cfset THIS.Name = "ProdriverOnline" />
	<cfset THIS.ApplicationTimeout = CreateTimeSpan( 0, 0, 5, 0 ) />
	<cfset THIS.SessionManagement = true />
	<cfset THIS.SessionTimeout = CreateTimeSpan( 0, 5, 0, 0 ) />
	<cfset THIS.SetClientCookies = true />

	<cfsetting showdebugoutput="false" requesttimeout="10" />
 
	<cffunction name="OnApplicationStart" access="public" returntype="boolean" output="false" hint="I run when the application boots up. If I return false, the application initialization will hault.">
		<cfset APPLICATION.EncryptionKey = "Q2w3E4r5T6y7U8i9O0" />
    <cfset APPLICATION.datasource = "prodriveronlinecom2" />
    <cfset APPLICATION.datamanager = createobject("component","com.datamgr.DataMgr_MYSQL").init("prodriveronlinecom2")>
		<cfset APPLICATION.startingDirectory = "E:\www\prodriver-online.com\">
    <cfset APPLICATION.filestore = "E:\www\prodriver-online.com\documents\">
 		<cfreturn true />
	</cffunction>
 
	<cffunction name="OnSessionStart" access="public" returntype="void" output="false" hint="I run when a session boots up.">
		<cfset var LOCAL = {} />
		<cfset LOCAL.CFID = SESSION.CFID />
		<cfset LOCAL.CFTOKEN = SESSION.CFTOKEN />
		<cfset StructClear( SESSION ) />
		<cfset SESSION.CFID = LOCAL.CFID />
		<cfset SESSION.CFTOKEN = LOCAL.CFTOKEN />
		<cfset SESSION.ACCOUNT = { ID = 0, type = 0, DateCreated = Now() } />
		<cftry>
			<cfset LOCAL.RememberMe = Decrypt(COOKIE.RememberMe, APPLICATION.EncryptionKey,"cfmx_compat","hex") />
			<cfset LOCAL.RememberMe = ListGetAt(LOCAL.RememberMe,2,":") />
			<cfif IsNumeric( LOCAL.RememberMe )>
				<cfset SESSION.ACCOUNT.ID = LOCAL.RememberMe />
			</cfif>
			<cfcatch></cfcatch>
		</cftry>
		<cfreturn />
	</cffunction>
 
	<cffunction name="OnRequestStart" access="public" returntype="boolean" output="false" hint="I perform pre page processing. If I return false, I hault the rest of the page from processing.">
		<cfif StructKeyExists( URL, "reset" )>
			<cfset THIS.OnApplicationStart() />
			<cfset THIS.OnSessionStart() />
		</cfif>
		<cfreturn true />
	</cffunction>
  
  <cffunction name="OnRequest" access="public" returntype="void" output="true" hint="I execute the primary template.">
  	<cfargument name="page" type="string" required="yes" hint="This page was requested by the user.">
    <cfset excludeURLs = "/index.cfm,
													/index2.cfm,
													/index3.cfm,
													/signup-driver-1.cfm,
													/signup-company-1.cfm,
													/about.cfm,
													/services.cfm,
													/contact.cfm,
													/terms.cfm,
													/privacy.cfm">
    <cfif listcontains(excludeURLs, arguments.page)>
    	<cfinclude template="#arguments.page#">
    <cfelse>
			<cfif SESSION.ACCOUNT.ID and SESSION.ACCOUNT.STATUS neq 5>
        <cfinclude template="#ARGUMENTS.page#" />
      <cfelse>
        <cfinclude template="index.cfm" />
      </cfif>
    </cfif>
    <cfif StructKeyExists( URL, "debug" )>
			<cfdump var="#SESSION#">
		</cfif>
		<cfreturn />
  </cffunction>
 
	<!---<cffunction name="OnRequest" access="public" returntype="void" output="true" hint="I execute the primary template.">
    <cfargument name="page" type="string" required="true" hint="The page template requested by the user." />
		<cfif SESSION.ACCOUNT.ID>
			<cfinclude template="#ARGUMENTS.page#" />
		<cfelse>
      <cfinclude template="index.cfm" />
		</cfif>
    <cfif StructKeyExists( URL, "debug" )>
			<cfdump var="#SESSION#">
		</cfif>
		<cfreturn />
	</cffunction>--->
 
</cfcomponent>