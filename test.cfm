<!---

	If "FROM DATE" and/or "TO DATE" then
		include the calendar table and inner join the account id to accounts table
	Else
		do search from only the accounts table and inner join the professions table



--->

<cfquery name="rs" datasource="#application.datasource#">
	SELECT *
  FROM professionz
</cfquery>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Untitled Document</title>
</head>
<body>
<cfdump var="#rs#">
</body>
</html>