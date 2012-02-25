<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ProDriver</title>
<link rel="stylesheet" type="text/css" href="css/global.css" />
<link rel="stylesheet" type="text/css" href="css/profile.css" />
<style type="text/css">
	body { background-image:url(images/new/tpl-bg-3.png); background-repeat:repeat-x; background-color:#2D2D2D;  }
</style>
<script type="text/javascript" src="js/all.js"></script>
<script type="text/javascript">_this.init("message");</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <cfinclude template="inc-menu.cfm">
  <div id="content-container">
  	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:10px solid #FFFFFF; margin:20px 0 0 0;">
    	<tr>
      	<td colspan="2" style="background:#4f4f4f;"><div class="page-title">PAYMENTS</div></td>
      </tr>
    	<tr>
    	  <td width="210" rowspan="4" valign="top" style="border-top:3px solid #FFFFFF; border-right:3px solid #FFFFFF; background:#4f4f4f;">&nbsp;</td>
    	  <td style="border-top:3px solid #FFFFFF; background:#2d2d2d; padding:5px;">
       	<div class="section-title">Luis Aragon</div>
        <div class="section-body">
        	<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post">
            <input type="hidden" name="cmd" value="_s-xclick">
            <input type="hidden" name="hosted_button_id" value="EXJDAUV5QLEVU">
            <table>
            <tr><td><input type="hidden" name="on0" value="Payment Options">Payment Options</td></tr><tr><td><select name="os0">
              <option value="Monthly">Monthly : $24.99 USD - monthly</option>
              <option value="Yearly">Yearly : $249.99 USD - yearly</option>
            </select> </td></tr>
            </table>
            <input type="hidden" name="currency_code" value="USD">
            <input type="image" src="https://www.sandbox.paypal.com/en_US/i/btn/btn_subscribeCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
            <img alt="" border="0" src="https://www.sandbox.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
          </form>
        </div>
        </td>
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