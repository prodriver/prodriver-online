<!--- 1.0 Beta 1 (Build 11) --->
<!--- Last Updated: 2010-12-18 --->
<!--- Information: sebtools.com --->
<cfcomponent>

<cffunction name="init" access="public" returntype="any" output="no">
	<cfargument name="Manager" type="any" required="yes">
	<cfargument name="NoticeMgr" type="any" required="no">
	<cfargument name="Scheduler" type="any" required="no">
	<cfargument name="ErrorEmail" type="string" required="no">
	
	<cfset initInternal(argumentCollection=arguments)>
	
	<cfreturn this>
</cffunction>

<cffunction name="initInternal" access="public" returntype="any" output="no" hint="I initialize and return this object.">
	<cfargument name="Manager" type="any" required="yes">
	<cfargument name="NoticeMgr" type="any" required="no">
	<cfargument name="Scheduler" type="any" required="no">
	<cfargument name="ErrorEmail" type="string" required="no">
	
	<!--- Copy initialization arguments to variables so that they will be persistent with component but not available outside component --->
	<cfscript>
	var key = "";
	var xmlcustom = getMethodOutputValue(variables,"customxml");
	
	variables.sMe = getMetaData(This);
	variables.CurrentFolder = getDirectoryFromPath(variables.sMe.Path);
	
	loadComponentData();
	
	for (key in arguments) {
		variables[key] = arguments[key];
		if ( StructKeyExists(arguments,key) AND isObject(arguments[key]) ) {
			This[key] = arguments[key];
		}
	}
	
	variables.DataMgr = variables.Manager.DataMgr;
	variables.FileMgr = variables.Manager.FileMgr;
	variables.datasource = variables.DataMgr.getDatasource();
	
	variables.xDefs = loadXML(getMethodOutputValue(variables,"xml"));
	This.xDefs = variables.xDefs;
	loadCustomFields();
	if ( Len(Trim(xmlcustom)) ) {
		variables.xDefsCustom = loadXML(xmlcustom);
	}
	
	if ( StructKeyExists(arguments,"NoticeMgr") ) {
		This.NoticeMgr = variables.NoticeMgr;
		loadNotices();
	}
	if ( StructKeyExists(arguments,"Scheduler") ) {
		This.Scheduler = variables.Scheduler;
		loadScheduledTask();
	}
	
	loadComponents();
	</cfscript>
	
	<cfreturn This>
</cffunction>

<cffunction name="getCustomExtension" access="public" returntype="string" output="false" hint="">
	
	<cfset var result = "">
	
	<cfif StructKeyExists(variables,"CustomSuffix") AND isSimpelValue(variables.CustomSuffix) AND Len(Trim(variables.CustomSuffix))>
		<cfset result = variables.CustomSuffix>
	<cfelseif ListLen(variables.me.fullname,"_") EQ 2>
		<cfset result = ListLast(variables.me.fullname,"_")>
	</cfif>
	
	<cfreturn result>
</cffunction>

<cffunction name="loadComponentData" access="public" returntype="void" output="false" hint="">
	
	<cfset var sThis = getMetaData(This)>
	<cfset var filename = ListLast(sThis.name,".")>
	<cfset var result = "">
	
	<cfset variables.me = StructNew()>
	<cfset variables.me["fullname"] = filename>
	<cfset variables.me["name"] = ListFirst(variables.me["fullname"],"_")>
	<cfset variables.me["path"] = reverse(ListRest(reverse(sThis.name),"."))>
	<cfif StructKeyExists(sThis,"DisplayName")>
		<cfset variables.me["label"] = sThis.DisplayName>
	<cfelse>
		<cfset variables.me["label"] = variables.me["name"]>
	</cfif>
	<cfset variables.me["dir"] = getDirectoryFromPath(sThis.path)>
	
</cffunction>

<cffunction name="getServiceComponent" access="public" returntype="any" output="no">
	<cfargument name="name" type="string" required="true">
	
	<cfset var result = arguments.name>
	
	<cfif StructKeyExists(This,arguments.name)>
		<cfset result = This[arguments.name]>
	</cfif>
	
	<cfreturn result>
</cffunction>

<cffunction name="getComponentsList" access="public" returntype="string" output="false" hint="">
	
	<cfset var qComponentFiles = 0>
	<cfset var comp = "">
	<cfset var result = "">
	
	<cfdirectory directory="#variables.me.dir#" name="qComponentFiles" filter="*.cfc">
	
	<cfloop query="qComponentFiles">
		<cfset comp = ListFirst(name,".")>
		<cfif
				ListLen(comp,"_") EQ 1
			AND	comp NEQ variables.me.name
			AND	comp NEQ variables.me.fullname
			AND NOT ListFindNoCase(result,comp)
		>
			<cfset result = ListAppend(result,comp)>
		</cfif>
	</cfloop>
	
	<cfreturn result>
</cffunction>

<cffunction name="getComponentTableName" access="public" returntype="string" output="false" hint="">
	<cfargument name="Comp" type="any" required="true">
	
	<cfset var sCompData = getMetaData(arguments.Comp)>
	<cfset var qInfo = 0>
	<cfset var result = "">
	
	<cfquery name="qInfo" dbtype="query">
	SELECT	name
	FROM	variables.qTables
	WHERE	methodPlural = '#ListLast(sCompData.name,".")#'
	</cfquery>
	
	<cfif qInfo.RecordCount EQ 1>
		<cfset result = qInfo.name>
	<cfelse>
		<cfquery name="qInfo" dbtype="query">
		SELECT	name
		FROM	variables.qTables
		WHERE	entities = '#ListLast(sCompData.name,".")#'
		</cfquery>
		<cfif qInfo.RecordCount EQ 1>
			<cfset result = qInfo.name>
		<cfelse>
			<cfthrow message="Unable to determine table for #ListLast(sCompData.name,".")#." type="ProgramManager">
		</cfif>
	</cfif>
	
	<cfreturn result>
</cffunction>

<cffunction name="getTableName" access="public" returntype="string" output="false" hint="">
	
	<cfset var result = "">
	
	<cfif StructKeyExists(variables,"xDefs")>
	
	</cfif>
	
	<cfreturn result>
</cffunction>

<cffunction name="getVariable" access="package" returntype="any" output="false" hint="">
	<cfargument name="name" type="string" required="true">
	
	<cfset var result = "">
	
	<cfif StructKeyExists(variables,arguments.name)>
		<cfset result = variables[arguments.name]>
	</cfif>
	
	<cfreturn result>
</cffunction>

<cffunction name="customxml" access="private" returntype="string" output="false" hint="">
	<cfreturn "">
</cffunction>

<cffunction name="loadCustomFields" access="private" returntype="any" output="false" hint="">

</cffunction>

<cffunction name="loadComponents" access="private" returntype="void" output="false" hint="">
	
	<cfset var comps = getComponentsList()>
	<cfset var comp = "">
	
	<cfif StructKeyExists(variables,"qTables")>
		<cfloop query="variables.qTables">
			<cfif Len(Trim(methodPlural))>
				<cfset comp = variables.Manager.makeCompName(methodPlural)>
				<cfif NOT ListFindNoCase(comps,comp)>
					<cfif FileExists("#variables.me.dir##comp#.cfc")>
						<cfset loadComponent(comp)>
					<cfelse>
						<cfset loadComponent(name=comp,table=name,path="com.sebtools.Records")>
					</cfif>
				</cfif>
			</cfif>
		</cfloop>
	</cfif>
	
	<cfloop list="#comps#" index="comp">
		<cfif StructKeyExists(This,"component_#comp#")>
			<cfinvoke component="#This#" method="component_#comp#">
		<cfelse>
			<cfset loadComponent(comp)>
		</cfif>
	</cfloop>
	
</cffunction>

<cffunction name="loadNotices" access="private" returntype="any" output="false" hint="">
	
	<cfset var sNotice = StructNew()>
	
</cffunction>

<cffunction name="loadScheduledTask" access="private" returntype="any" output="false" hint="">
	<cfif StructKeyExists(variables,"Scheduler") AND StructKeyExists(This,"runScheduledTask")>
		<cfinvoke component="#variables.Scheduler#" method="setTask">
			<cfinvokeargument name="Name" value="#ListLast(sMe.name,'.')#">
			<cfinvokeargument name="ComponentPath" value="#sMe.name#">
			<cfinvokeargument name="Component" value="#This#">
			<cfinvokeargument name="MethodName" value="runScheduledTask">
			<cfinvokeargument name="interval" value="hourly">
		</cfinvoke>
	</cfif>
</cffunction>

<cffunction name="loadXml" access="private" returntype="any" output="false" hint="">
	<cfargument name="xml" type="string" required="true">
	
	<cfscript>
	var xData = variables.Manager.loadXML(arguments.xml);
	var aTables = XmlSearch(xData,"//table");
	var ii = 0;
	var att = 0;
	var cols = "name,entity,entities,labelField,labelPlural,labelSingular,methodSingular,methodPlural,deletable,sortfield";
	var row = 0;
	
	if ( NOT StructKeyExists(variables,"qTables") ) {
		variables.qTables = QueryNew(cols);
	}
	
	for ( ii=1; ii LTE ArrayLen(aTables); ii=ii+1 ) {
		if ( NOT ListFindNoCase(ValueList(variables.qTables.name),aTables[ii].XmlAttributes.name) ) {
			QueryAddRow(variables.qTables);
			row = row + 1;
			for ( att in aTables[ii].XmlAttributes ) {
				if ( ListFindNoCase(cols,att) ) {
					QuerySetCell(variables.qTables,att,aTables[ii].XmlAttributes[att],row);
				}
			}
			if ( StructKeyExists(aTables[ii].XmlAttributes,"entity") ) {
				QuerySetCell(variables.qTables,"entities",variables.Manager.pluralize(aTables[ii].XmlAttributes["entity"]),row);
			}
			if ( NOT Len(variables.qTables["methodSingular"][row]) ) {
				if ( StructKeyExists(aTables[ii].XmlAttributes,"labelSingular") ) {
					QuerySetCell(variables.qTables,"methodSingular",aTables[ii].XmlAttributes["labelSingular"],row);
				}
			}
			if ( NOT Len(variables.qTables["methodPlural"][row]) ) {
				if ( StructKeyExists(aTables[ii].XmlAttributes,"labelPlural") ) {
					QuerySetCell(variables.qTables,"methodPlural",aTables[ii].XmlAttributes["labelPlural"],row);
				}
			}
			QuerySetCell(variables.qTables,"methodSingular",makeCompName(variables.qTables["methodSingular"][row]),row);
			QuerySetCell(variables.qTables,"methodPlural",makeCompName(variables.qTables["methodPlural"][row]),row);
		}
	}
	</cfscript>
	
	<cfreturn xData>
</cffunction>

<cffunction name="runScheduledTask" access="public" returntype="any" output="false" hint="">
	
</cffunction>

<cffunction name="sendNotice" access="public" returntype="void" output="false" hint="">
	<cfargument name="Action" type="string" required="yes">
	
	<cfif StructKeyExists(variables,"NoticeMgr")>
	
	</cfif>
	
</cffunction>

<cffunction name="component" access="private" returntype="any" output="no" hint="DEPRECATED">
	<cfargument name="name" type="string" required="yes">
	
	<cfset loadComponent(argumentCollection=arguments)>
	
</cffunction>

<cffunction name="getMethodOutputValue" access="private" returntype="string" output="no" hint="DEPRECATED">
	<cfargument name="component" type="any" required="yes">
	<cfargument name="method" type="string" required="yes">
	<cfargument name="args" type="struct" required="no">
	
	<cfset var result = "">
	<cfset var fMethod = component[method]>
	
	<cfif StructKeyExists(arguments,"args")>
		<cfsavecontent variable="result"><cfoutput>#fMethod(argumentCollection=args)#</cfoutput></cfsavecontent>
	<cfelse>
		<cfsavecontent variable="result"><cfoutput>#fMethod()#</cfoutput></cfsavecontent>
	</cfif>
	
	<cfset result = Trim(result)>
	
	<cfreturn result>
</cffunction>

<cffunction name="loadComponent" access="private" returntype="any" output="no" hint="I load a component into memory in this component.">
	<cfargument name="name" type="string" required="yes">
	
	<cfset var ext = getCustomExtension()>
	<cfset var extpath = "">
	
	<cfif NOT StructKeyExists(arguments,"path")>
		<cfset arguments.path = "#variables.me.path#.#arguments.name#">
	</cfif>
	
	<cfset extpath = "#getDirectoryFromPath(getCurrentTemplatePath())##arguments.name#_#ext#.cfc">
	
	<cfif Len(ext) AND FileExists(extpath)>
		<cfset arguments.path = "#arguments.path#_#ext#">
	</cfif>
	
	<cfset arguments["Manager"] = variables.Manager>
	<cfset arguments["Parent"] = This>
	<cfset arguments[variables.me.name] = This>
	
	<cfinvoke component="#arguments.path#" method="init" returnvariable="this.#name#" argumentCollection="#arguments#"></cfinvoke>
	
	<cfset variables[arguments.name] = This[arguments.name]>
	
</cffunction>

<cffunction name="sendEmailAlert" access="package" returntype="void" output="false" hint="">
	<cfargument name="Subject" type="string" required="yes">
	<cfargument name="html" type="string" required="yes">
	
	<cfset var oMailer = 0>
	
	<cfif StructKeyExists(variables,"NoticeMgr")>
		<cfset oMailer = variables.NoticeMgr.getMailer()>
	</cfif>
	
	<cfif StructKeyExists(variables,"NoticeMgr") AND StructKeyExists(variables,"ErrorEmail") AND Len(Trim(variables.ErrorEmail))>
		<cfinvoke component="#oMailer#" method="send">
			<cfinvokeargument name="To" value="#variables.ErrorEmail#">
			<cfinvokeargument name="Subject" value="#arguments.Subject#">
			<cfinvokeargument name="html" value="#arguments.html#">
		</cfinvoke>
	<cfelse>
		<cfmail to="steve@bryantwebconsulting.com" from="robot@bryantwebconsulting.com" server="mail.bryantwebconsulting.com" type="html" subject="#variables.me.label# Error">#arguments.html#</cfmail>
	</cfif>
	
</cffunction>

<cffunction name="throwError" access="public" returntype="void" output="false" hint="">
	<cfargument name="message" type="string" required="yes">
	<cfargument name="errorcode" type="string" default="">
	<cfargument name="detail" type="string" default="">
	<cfargument name="extendedinfo" type="string" default="">
	
	<cfset var html = "">
	
	<cfsavecontent variable="html"><cfoutput><cfdump var="#arguments#"></cfoutput></cfsavecontent>
	<cfset sendEmailAlert("#variables.me.label# Error",html)>
	
	<cfthrow
		type="#variables.me.name#"
		message="#arguments.message#"
		errorcode="#arguments.errorcode#"
		detail="#arguments.detail#"
		extendedinfo="#arguments.extendedinfo#"
	>
	
</cffunction>
<cfscript>
function makeLinkVar(str) {
	return LCase(makeCompName(str));
}
function makeCompName(str) {
	return variables.Manager.makeCompName(str);
}
function makeFileName(str) {
	/* Change special character to underscores */
	var result = ReReplaceNoCase(LCase(str),"[^a-z0-9]","_","ALL");
	var find = FindNoCase("__",result);
	
	/* Remove duplicate underscores */
	while ( find GT 0 ) {
		result = ReplaceNoCase(result,"__","_","ALL");
		find = FindNoCase("__",result);
	}
	
	return result;
}
</cfscript>
</cfcomponent>