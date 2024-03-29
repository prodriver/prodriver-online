<!--- 1.4 (Build 11) --->
<!--- Last Updated: 2010-12-18 --->
<!--- Information: sebtools.com --->
<cfcomponent displayname="File Manager">
<!--- %%Handle folders w/o write permission --->
<cffunction name="init" access="public" returntype="FileMgr" output="no" hint="I instantiate and return this object.">
	<cfargument name="UploadPath" type="string" required="yes" hint="The file path for uploads.">
	<cfargument name="UploadURL" type="string" default="" hint="The URL path for uploads.">
	
	<cfset variables.UploadPath = arguments.UploadPath>
	<cfset variables.UploadURL = arguments.UploadURL>
	<cfset variables.dirdelim = CreateObject("java", "java.io.File").separator>
	
	<cfset makedir(variables.UploadPath)>
	
	<cfset This["DirectoryList"] = getDirectoryList>
	<cfset variables["DirectoryList"] = getDirectoryList>
	
	<cfif ListFirst(Server.ColdFusion.ProductVersion,".") GTE 7>
		<cfinclude template="FileMgr_7.cfm">
	</cfif>
	
	<cfreturn this>
</cffunction>

<cffunction name="LimitFileNameLength" acess="public" returntype="string" output="no">
	<cfargument name="Length" type="numeric" required="true">
	<cfargument name="Root" type="string" required="true">
	<cfargument name="Suffix" type="string" default="">
	
	<cfset var FileName = "">
	<cfset var Dir = "">
	<cfset var result = "">
	<cfset var LeftLength = 0>
	
	<cfif arguments.Length GT 0>
		<cfif Len(arguments.Suffix) EQ 0 AND ListLen(arguments.Root,".") GT 1>
			<cfset arguments.Suffix = "." & ListLast(arguments.Root,".")>
			<cfset arguments.Root = ListDeleteAt(arguments.Root,ListLen(arguments.Root,"."),".")>
		</cfif>
		
		<cfset result = "#arguments.Root##arguments.Suffix#">
		<cfset FileName = getFileFromPath(result)>
		<cfif ( result NEQ FileName )>
			<cfset arguments.Root = getFileFromPath(arguments.Root)>
			<cfset Dir = getDirectoryFromPath(result)>
		</cfif>
		
		<cfif Len(arguments.Suffix) GTE arguments.Length>
			<cfthrow message="Suffix (#arguments.Suffix#) is too long for file length limit (#arguments.Length#)">
		</cfif>
		
		<cfif Len(FileName) GT arguments.Length>
			<cfset LeftLength = arguments.Length - Len(arguments.Suffix) - 1>
			<cfif LeftLength GT 0>
				<cfset FileName = Left(arguments.Root,LeftLength) & "~" & arguments.Suffix>
			<cfelse>
				<cfset FileName = "~" & arguments.Suffix>
			</cfif>
		</cfif>
		
		<cfset result = Dir & FileName>
	<cfelse>
		<cfset result = arguments.Root & arguments.Suffix>
	</cfif>
	
	<cfreturn result>
</cffunction>

<cffunction name="makeFileCopy" access="public" returntype="string" output="no" hint="I make a copy of a file and return the new file name.">
	<cfargument name="FileName" type="string" required="yes">
	<cfargument name="Folder" type="string" required="no">
	
	<cfset var path_old = getFilePath(argumentCollection=arguments)>
	<cfset var path_new = createUniqueFileName(path_old)>
	
	<cffile action="copy" source="#path_old#" destination="#path_new#">
	
	<cfreturn ListLast(path_new,variables.dirdelim)>
</cffunction>

<cffunction name="copyFiles" access="public" returntype="void" output="no" hint="I copy files from one folder to another.">
	<cfargument name="from" type="string" required="yes">
	<cfargument name="to" type="string" required="yes">
	<cfargument name="overwrite" type="boolean" default="false">
	
	<cfset var dir_from = getDirectory(arguments.from)>
	<cfset var dir_to = getDirectory(arguments.to)>
	<cfset var qFiles = getDirectoryList(directory=dir_from)>
	
	<cfloop query="qFiles">
		<cfif arguments.overwrite OR NOT FileExists("#dir_to##name#")>
			<cffile action="copy" source="#dir_from##name#" destination="#dir_to#">
		</cfif>
	</cfloop>
	
</cffunction>

<cffunction name="deleteFile" access="public" returntype="any" output="no" hint="I delete the given file.">
	<cfargument name="FileName" type="string" required="yes">
	<cfargument name="Folder" type="string" required="no">

	<cfset var destination = getFilePath(argumentCollection=arguments)>
	
	<cfif FileExists(destination)>
		<cffile action="DELETE" file="#destination#">
	</cfif>
	
</cffunction>
<!---
 Mimics the cfdirectory, action=&quot;list&quot; command.
 Updated with final CFMX var code.
 Fixed a bug where the filter wouldn't show dirs.
 
 @param directory 	 The directory to list. (Required)
 @param filter 	 Optional filter to apply. (Optional)
 @param sort 	 Sort to apply. (Optional)
 @param recurse 	 Recursive directory list. Defaults to false. (Optional)
 @return Returns a query. 
 @author Raymond Camden (ray@camdenfamily.com) 
 @version 2, April 8, 2004 
--->
<cffunction name="getDirectoryList" output="false" returnType="query" hint="Mimics the cfdirectory list.">
	<cfargument name="directory" type="string" required="true">
	<cfargument name="filter" type="string" required="false" default="">
	<cfargument name="sort" type="string" required="false" default="">
	<cfargument name="recurse" type="boolean" required="false" default="false">
	<!--- temp vars --->
	<cfargument name="dirInfo" type="query" required="false">
	<cfargument name="thisDir" type="query" required="false">
	
	<cfset var path = "">
    <cfset var temp = "">
	<cfset var qDirs = 0>
	
	<cfif not recurse>
		<cfdirectory name="temp" directory="#directory#" filter="#filter#" sort="#sort#">
		<cfreturn temp>
	<cfelse>
		<!--- We loop through until done recursing drive --->
		<cfif not isDefined("dirInfo")>
			<cfset dirInfo = queryNew("attributes,datelastmodified,mode,name,size,type,directory")>
		</cfif>
		<cfset thisDir = getDirectoryList(directory,filter,sort,false)>
		<cfif server.os.name contains "Windows">
			<cfset path = "\">
		<cfelse>
			<cfset path = "/">
		</cfif>
		<cfif Right(arguments.directory,1) NEQ path>
			<cfset arguments.directory = "#arguments.directory##path#">
		</cfif>
		<cfif Len(filter)>
			<cfdirectory name="qDirs" directory="#directory#" sort="#sort#">
			<cfloop query="qDirs">
				<cfif type is "dir">
					<cfset getDirectoryList(directory & name,filter,sort,true,dirInfo)>
				</cfif>
			</cfloop>
		</cfif>
		<cfloop query="thisDir">
			<cfset queryAddRow(dirInfo)>
			<cfset querySetCell(dirInfo,"attributes",attributes)>
			<cfset querySetCell(dirInfo,"datelastmodified",datelastmodified)>
			<cfset querySetCell(dirInfo,"mode",mode)>
			<cfset querySetCell(dirInfo,"name",name)>
			<cfset querySetCell(dirInfo,"size",size)>
			<cfset querySetCell(dirInfo,"type",type)>
			<cfset querySetCell(dirInfo,"directory",directory)>
			<cfif type is "dir">
				<!--- go deep! --->
				<cfset getDirectoryList(directory & name,filter,sort,true,dirInfo)>
			</cfif>
		</cfloop>
		<cfreturn dirInfo>
	</cfif>
</cffunction>

<cffunction name="FileNameFromString" access="public" returntype="string" output="no">
	<cfargument name="string" type="string" required="yes">
	<cfargument name="extensions" type="string" default="cfm,htm,html">
	
	<cfset var exts = arguments.extensions>
	<cfset var result = "">
	<cfset var ext = ListLast(string,".")>
	
	<cfif Len(ext) AND ListFindNoCase(exts,ext) AND (Len(string)-Len(ext)-1) GT 0>
		<cfset string = Left(string,Len(string)-Len(ext)-1)>
	</cfif>
	
	<cfset result = PathNameFromString(arguments.string)>

	<cfif Len(result)>
		<cfif Len(ext) AND ListFindNoCase(exts,ext)>
			<cfset result = "#result#.#ext#">
		<cfelse>
			<cfset result = "#result#.#ListFirst(exts)#">
		</cfif>
	</cfif>
	
	<cfreturn LCase(result)>
</cffunction>

<cffunction name="getDelimiter" access="public" returntype="string" output="no">
	<cfreturn variables.dirdelim>
</cffunction>

<cffunction name="getDirectory" access="public" returntype="string" output="no">
	<cfargument name="Folder" type="string" required="no">
	
	<cfset var result = variables.UploadPath>
	
	<cfif StructKeyExists(arguments,"Folder")>
		<cfset arguments.Folder = convertFolder(arguments.Folder,variables.dirdelim)>
		
		<cfif Right(result,1) EQ variables.dirdelim>
			<cfset result = Left(result,Len(result)-1)>
		</cfif>
		
		<cfset result = ListAppend(result,arguments.Folder,variables.dirdelim)>
	</cfif>
	
	<cfif Right(result,1) NEQ variables.dirdelim>
		<cfset result = "#result##variables.dirdelim#">
	</cfif>
	
	<cfreturn result>
</cffunction>

<cffunction name="getFileLen" access="public" returntype="numeric" output="no">
	<cfargument name="FileName" type="string" required="yes">
	<cfargument name="Folder" type="string" required="no">
	
	<cfset var result = 0>
	<cfset var path = getFilePath(argumentCollection=arguments)>
	<cfset var qFiles = 0>
	
	<cfdirectory action="LIST" directory="#path#" name="qFiles" filter="#arguments.FileName#">
	
	<cfloop query="qFiles">
		<cfif Name EQ arguments.FileName>
			<cfset result = size>
		</cfif>
	</cfloop>
	
	<cfreturn result>
</cffunction>

<cffunction name="getFilePath" access="public" returntype="string" output="no">
	<cfargument name="FileName" type="string" required="yes">
	<cfargument name="Folder" type="string" default="">
	
	<cfreturn getDirectory(arguments.Folder) & arguments.FileName>
</cffunction>

<cffunction name="getFileURL" access="public" returntype="string" output="no">
	<cfargument name="FileName" type="string" required="yes">
	<cfargument name="Folder" type="string" required="no">
	
	<cfset var result = variables.UploadURL>
	
	<cfif StructKeyExists(arguments,"Folder")>
		<cfset result = ListAppend(result,convertFolder(arguments.Folder,"/"),"/")>
	</cfif>
	<cfset result = ListAppend(result,arguments.FileName,"/")>
	
	<cfset result = ReplaceNoCase(result,"//","/","ALL")>
	
	<cfreturn result>
</cffunction>

<cffunction name="getUploadPath" access="public" returntype="string" output="no">
	<cfreturn variables.UploadPath>
</cffunction>

<cffunction name="getUploadURL" access="public" returntype="string" output="no">
	<cfreturn variables.UploadURL>
</cffunction>

<cffunction name="makedir" access="public" returntype="any" output="no" hint="I make a directory (if it doesn't exist already).">
	<cfargument name="Directory" type="string" required="yes">
	
	<cfset var thisDir = "">
	<cfset var parent = "">
	
	<cfif NOT DirectoryExists(arguments.Directory) AND ListLen(arguments.Directory,variables.dirdelim)>
		<cfset parent = ListDeleteAt(arguments.Directory,ListLen(arguments.Directory,variables.dirdelim),variables.dirdelim)>
		<cfif NOT DirectoryExists(parent)>
			<cfset makedir(parent)>
		</cfif>
		<cfdirectory action="CREATE" directory="#arguments.Directory#">
	</cfif>
	
</cffunction>

<cffunction name="makeFolder" access="public" returntype="void" output="no">
	<cfargument name="Folder" type="string" required="yes">
	
	<cfset makedir(getDirectory(arguments.Folder))>
	
</cffunction>

<cffunction name="PathNameFromString" access="public" returntype="string" output="false" hint="">
	<cfargument name="string" type="string" required="yes">
	
	<cfset var reChars = "([0-9]|[a-z]|[A-Z])">
	<cfset var ii = 0>
	<cfset var result = "">
	
	<cfloop index="ii" from="1" to="#Len(string)#" step="1">
		<cfif REFindNoCase(reChars, Mid(string,ii,1))>
			<cfset result = result & Mid(string,ii,1)>
		<cfelse>
			<cfset result = result & "-">
		</cfif>
	</cfloop>
	
	<cfset result = REReplaceNoCase(result, "_{2,}", "_", "ALL")>
	<cfset result = REReplaceNoCase(result, "-{2,}", "-", "ALL")>
	
	<cfset result = ReplaceNoCase(result,"-"," ","ALL")>
	<cfset result = ReplaceNoCase(Trim(result)," ","-","ALL")>
	
	<cfreturn LCase(result)>
</cffunction>

<cffunction name="readFile" access="public" returntype="string" output="no" hint="I return the contents of a file.">
	<cfargument name="FileName" type="string" required="yes">
	<cfargument name="Folder" type="string" required="no">
	
	<cfset var destination = getFilePath(argumentCollection=arguments)>
	
	<cffile action="READ" file="#destination#" variable="result">
	
	<cfreturn result>
</cffunction>

<cffunction name="writeFile" access="public" returntype="void" output="no" hint="I save a file.">
	<cfargument name="FileName" type="string" required="yes">
	<cfargument name="Contents" type="string" required="yes">
	<cfargument name="Folder" type="string" required="no">
	
	<cfset var destination = getFilePath(argumentCollection=arguments)>
	
	<cfif StructKeyExists(arguments,"Folder")>
		<cfset makeFolder(arguments.Folder)>
	</cfif>
	
	<cffile action="WRITE" file="#destination#" output="#arguments.Contents#" addnewline="no">
	
</cffunction>

<cffunction name="uploadFile" access="public" returntype="any" output="no">
	<cfargument name="FieldName" type="string" required="yes">
	<cfargument name="Folder" type="string" required="no">
	<cfargument name="NameConflict" type="string" default="Error">
	
	<cfset var destination = getDirectory(argumentCollection=arguments)>
	<cfset var CFFILE = StructNew()>
	<cfset var result = "">
	
	<!--- Make sure the folder exists --->
	<cfif StructKeyExists(arguments,"Folder")>
		<cfset makeFolder(arguments.Folder)>
	</cfif>
	
	<cffile action="UPLOAD" filefield="#arguments.FieldName#" destination="#destination#" nameconflict="#arguments.NameConflict#" accept="#arguments.accept#">
	
	<cfif
			StructKeyExists(arguments,"extensions")
		AND	Len(arguments.extensions)
		AND	NOT ListFindNoCase(arguments.extensions,ListLast(CFFILE.ServerFile,"."))
	>
		<cffile action="DELETE" file="#CFFILE.serverDirectory##CFFILE.ServerFile#">
		<cfset CFFILE = StructNew()>
	</cfif>
	
	<cfif StructKeyExists(arguments,"return") AND isSimpleValue(arguments.return)>
		<cfif arguments.return EQ "name">
			<cfset arguments.return = "ServerFile">
		</cfif>
		<cfif StructKeyExists(CFFILE,arguments.return)>
			<cfset result = CFFILE[arguments.return]>
		</cfif>
	<cfelse>
		<cfset result = CFFILE>
	</cfif>
	
	<cfreturn result>
</cffunction>

<cffunction name="convertFolder" access="public" returntype="string" output="no">
	<cfargument name="Folder" type="string" required="yes">
	<cfargument name="delimiter" type="string" default="/">
	
	<cfset var result = arguments.Folder>
	
	<cfset result = ListChangeDelims(result,"/",",")>
	<cfset result = ListChangeDelims(result,variables.dirdelim,"/")>

	<cfset result = ListChangeDelims(result,arguments.delimiter,variables.dirdelim)>
	
	<cfreturn result>
</cffunction>

<!---
Copies a directory.

@param source      Source directory. (Required)
@param destination      Destination directory. (Required)
@param nameConflict      What to do when a conflict occurs (skip, overwrite, makeunique). Defaults to overwrite. (Optional)
@return Returns nothing. 
@author Joe Rinehart (joe.rinehart@gmail.com) 
@version 1, July 27, 2005 
--->
<cffunction name="copyDirectories" output="true">
    <cfargument name="source" required="true" type="string">
    <cfargument name="destination" required="true" type="string">
    <cfargument name="nameconflict" required="true" default="overwrite">

    <cfset var contents = "" />
    <cfset var dirDelim = getDelimiter()>
    
    <cfif not(directoryExists(arguments.destination))>
        <cfdirectory action="create" directory="#arguments.destination#">
    </cfif>
    
    <cfdirectory action="list" directory="#arguments.source#" name="contents">
    
    <cfloop query="contents">
        <cfif contents.type eq "file">
            <cffile action="copy" source="#arguments.source##dirDelim##name#" destination="#arguments.destination##dirDelim##name#" nameconflict="#arguments.nameConflict#">
        <cfelseif contents.type eq "dir">
            <cfset copyDirectories(arguments.source & dirDelim & name, arguments.destination & dirDelim & name) />
        </cfif>
    </cfloop>
</cffunction>

<!---
 * v2, bug found with dots in path, bug found by joseph
 * 
 * @author Marc Esher (marc.esher@cablespeed.com) 
 * @version 2, January 22, 2008 
--->
<cffunction name="createUniqueFileName" acess="public" returntype="string" output="no" hint="Creates a unique file name; used to prevent overwriting when moving or copying files from one location to another.">
	<cfargument name="fullPath" type="string" required="true" hint="Full path to file.">
	<cfargument name="maxfilelength" type="numeric" default="0">
	<cfscript>
	var extension = "";
	var thePath = "";
	var result = arguments.fullPath;
	var counter = 0;
	
	if( ListLen(fullPath,".") gte 2 ) {
		extension = "." & ListLast(fullPath,".");
	}
	thePath = ListDeleteAt(fullPath,ListLen(fullPath,"."),".");
	dir = getDirectoryFromPath(arguments.fullPath);
	filebase = getFileFromPath(arguments.fullPath);
	filebase = ListDeleteAt(filebase,ListLen(filebase,"."),".");
	
	if ( arguments.maxfilelength AND Len(filebase & extension) GT arguments.maxfilelength ) {
		filebase = Left(filebase,arguments.maxfilelength-extension);
	}

	while( FileExists(result) ) {
		counter = counter + 1;
		result = LimitFileNameLength(arguments.maxfilelength,thePath,"_" & counter & extension);			
	}
	
	return result;	
	</cfscript>
</cffunction>

<cfscript>
/**
 * Makes a row of a query into a structure.
 * 
 * @param query 	 The query to work with. 
 * @param row 	 Row number to check. Defaults to row 1. 
 * @return Returns a structure. 
 * @author Nathan Dintenfass (nathan@changemedia.com) 
 * @version 1, December 11, 2001 
 */
</cfscript>
</cfcomponent>