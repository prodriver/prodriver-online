<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ProDriver</title>
<link rel="stylesheet" type="text/css" href="css/global.css" />
<link rel="stylesheet" type="text/css" href="css/signup.css" />
<style type="text/css">
	body { background-image:url(images/new/tpl-bg-2.png); background-repeat:repeat-x; background-color:#2D2D2D;  }
</style>
<script type="text/javascript" src="js/all.js"></script>
<script type="text/javascript">_this.init();</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <div id="body"><img src="images/new/signup_driver_step3.png" width="970" height="239"></div>
  <div id="content-container">
  	<div id="pricing"><img src="images/new/pricing_driver.gif" width="172" height="185"></div>
    <div id="form-body">
    	<form id="form1" action="worker.cfc?method=signupDriverStep3" method="post" enctype="multipart/form-data">
        <div class="form-heading">Account Notification</div>
        <div class="form-content">
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="100%" class="form-label">
              <p>Your account has been suspended. Please contact <a href="mailto:support@prodriver-online.com">support@prodriver-online.com</a> for more information.</p>
              <p>&nbsp;</p>
              <p>&nbsp;</p>
              <p>&nbsp;</p>
              <p>&nbsp;</p>
              <p>&nbsp;</p>
              <p>&nbsp;</p>
              <p><br></p>
              </td>
            </tr>
          </table>
        </div>
        <div id="form-buttons"></div>
      </form>
    </div>
    <div id="application-process">
      <div class="application-header">DOWNLOAD <br>DRIVER APPLICATION</div>
      <div style="clear:both;"></div>
      <div class="application-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fu sce a eros acsuscipit pulvinar vitae ac dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce a eros acsuscipit pulvinar vitae ac dui. <br><br><img src="images/down_app.png" width="227" height="36"><br><br> <a><strong>See Terms of Use</strong></a> &gt;<br>
      <div class="subtitle">REQUIRED DOCUMENTS FOR APPROVAL</div><br>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce a eros acsuscipit pulvinar vitae ac dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce a eros acsuscipit pulvinar vitae ac dui.</div>
    </div>
    <div style="clear:both;"></div>
  </div>
  <div id="footer">
    <cfinclude template="inc-footer.cfm">
  </div>
</div>
</body>
</html>