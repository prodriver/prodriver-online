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
<script type="text/javascript">_this.init("calendar");</script>
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
          <div class="page-title">INTERACTIVE CALENDAR</div>
          </td>
        </tr>
        <tr>
          <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;"> 
						<!--- insert calendar here ---> 
            <div id="backend-container">
                <h2>Back End Version (Save Disabled)<span>(Double click on a day or select 2 different days to edit them and view the changes in the Front End Version by clicking refresh; <strong>easy integration into your Content Management System; auto resizable and completely customizable from CSS</strong>)</span></h2>
                <input type="button" name="refresh1" id="refresh1" class="reload-btn" value="Refresh Calendar" />
                <div id="backend"></div>
            </div>
          </td>
        </tr>
        <tr>
          <td colspan="2" style="height:40px; width:100%; background-color:#fff;">
          <div style="float:right; margin-right:5px;">
            <button type="submit" class="save_changes"></button>
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
</body>
</html>