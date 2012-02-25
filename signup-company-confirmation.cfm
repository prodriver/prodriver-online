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
  	<div id="pricing"><img src="images/new/pricing_company.gif" width="172" height="185"></div>
    <div id="form-body" style="width:770px;">
    	<form id="form1" action="worker.cfc?method=signupDriverStep3" method="post" enctype="multipart/form-data">
        <div class="form-heading">Account Confirmation</div>
        <div class="form-content">
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="100%" class="form-label">
              <p>Your account has been submitted and is currently being reviewed. If approved, you will receive an email confirmation of approval. Before you can be approved, you must provide us with all necessary documents. If you have not, you will be contacted to provide us with the remaining documents before approval.<br><br>We also strongly suggest you check your spam box frequently in the event that our confirmation email is treated as spam on your system.</p>
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
    <div style="clear:both;"></div>
  </div>
  <div id="footer">
    <cfinclude template="inc-footer.cfm">
  </div>
</div>
</body>
</html>