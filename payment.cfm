<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ProDriver</title>
<link type="text/css" rel="stylesheet" href="http://freebaselibs.com/static/suggest/1.3/suggest.min.css" />
<link rel="stylesheet" type="text/css" href="css/global.css" />
<link rel="stylesheet" type="text/css" href="css/profile.css" />
<style type="text/css">
body { background-image:url(images/new/tpl-bg-3.png); background-repeat:repeat-x; background-color:#2D2D2D; }
</style>
<script type="text/javascript" src="js/all.js"></script>
<script type="text/javascript">_this.init();</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <div id="content-container-sub" style="margin-top:150px;">
    <div style="float:left;width:970px;border:1px solid #fff;">
    	<div style="margin:20px;">
      	<div class="page-title" style="margin:0;color:#f7c815;">YOUR ACCOUNT HAS BEEN VERIFIED</div>
        <div style="font-size:1.8em; color:#fff; margin:10px 0 20px 0;">To complete your subscription, please select from one of the following payment plans.
        	<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
            <input type="hidden" name="cmd" value="_s-xclick">
            <input type="hidden" name="hosted_button_id" value="GBZKABFQRLETA">
            <table>
              <tr>
                <td><input type="hidden" name="on0" value="Subscription Options">
                </td></tr><tr><td>
                  <select name="os0" style="margin:10px 0 0 0;">
                    <cfif SESSION.account.type eq 2>
                    <option value="Monthly Driver Subscription">Monthly Driver Subscription : $19.95USD - monthly</option>
                    <option value="Yearly Driver Subscription">Yearly Driver Subscription : $199.95USD - yearly</option>
                    </cfif>
                    <cfif SESSION.account.type eq 1>
                    <option value="Monthly Company Subscription">Monthly Company Subscription : $12.95USD - monthly</option>
                    <option value="Yearly Company Subscription">Yearly Company Subscription : $124.95USD - yearly</option>
                    </cfif>
                  </select>
                </td>
              </tr>
            </table>
            <input type="hidden" name="currency_code" value="USD">
            <input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_subscribeCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!" style="margin:10px 0 0 0;">
            <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
          </form>
        </div>
    	</div>
    </div>
    <div style="clear:both;"></div>
  </div>
  <div id="footer">
    <cfinclude template="inc-footer.cfm">
  </div>
</div>
</body>
</html>