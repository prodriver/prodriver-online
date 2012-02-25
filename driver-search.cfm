<!---

First search by date range to get all of the records to be excluded from the accounts records. Then use subquery to exclude those records using the account IDs. 

--->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Untitled Document</title>
</head>

<body>
<form name="form1" action="worker.cfc?method=searchDriverAccounts" method="post">
  <table cellpadding="2" cellspacing="0" border="0">
    <tr>
      <td align="right">
        <label for="startDate">Date Range</label>
      </td>
      <td>
        <input type="text" name="startDate" value="">
        &nbsp;
        <label for="accountLastName">To:</label>
        &nbsp;
      <input type="text" name="endDate" value="">
        &nbsp;(mm/dd/yyyy)</td>
    </tr>
    <tr>
      <td align="right">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td align="right">
        <label for="accountName">First Name:</label>
      </td>
      <td>
        <input type="text" name="accountFirstName" value="" id="accountFirstName">
         &nbsp;
         <label for="accountFirstName">Last Name:</label>
        &nbsp;
        <input type="text" name="accountLastName" value="" id="accountLastName">
      </td>
    </tr>
    <tr>
      <td align="right">
        <label for="accountState">State</label>
      </td>
      <td>
        <input type="text" name="accountState" value="">
      </td>
    </tr>
    <tr>
      <td align="right" valign="top">
        <label for="professions">Professions</label>
      </td>
      <td>
        <select name="professions" size="6" multiple>
          <option value="">None</option>
          <option value="1">Entertainment</option>
          <option value="2">Corporate</option>
          <option value="3">Private</option>
          <option value="4">Charter</option>
          <option value="5">Limo</option>
        </select>
      </td>
    </tr>
    <tr>
      <td align="right">
        <label for="passport">Passport</label>
      </td>
      <td>
        <select name="passport">
        	<option value="">None</option>
          <option value="yes">yes</option>
          <option value="no">no</option>
        </select>
      </td>
    </tr>
    <tr>
      <td align="right">
        <label for="canadian">Canadian</label>
      </td>
      <td>
        <select name="canadian">
        	<option value="">None</option>
          <option value="yes">yes</option>
          <option value="no">no</option>
        </select>
      </td>
    </tr>
    <tr>
      <td align="center" colspan="2">
        <input type="submit" name="WADbSearch1" value="Submit">
      </td>
    </tr>
  </table>
</form>
</body>
</html>
