<!--- if an id is not established, redirect to the first page of the signup process --->
<cfif not isdefined("SESSION.ACCOUNT.ID") or SESSION.ACCOUNT.ID eq "">
	<cflocation url="signup-company-1.cfm" addtoken="no">
</cfif>

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
<script type="text/javascript">_this.init("company-signup2");</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <div id="body"><img src="images/new/signup_company_step2.png" width="970" height="239"></div>
  <div id="content-container">
  	<div id="pricing"><img src="images/new/pricing_company.gif" width="172" height="185"></div>
    <div id="form-body">
    	<form id="signupCompany2" method="post" enctype="multipart/form-data">
        <div class="form-heading">Company Information</div>
        <div class="form-content">
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="50%" class="form-label">Company Name</td>
              <td width="50%" class="form-label">&nbsp;</td>
            </tr>
            <tr>
              <td><input type="text" name="accountCompanyName" id="accountCompanyName" class="validate[required]"></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td width="50%" class="form-label">Address 1</td>
              <td width="50%" class="form-label">Address 2</td>
            </tr>
            <tr>
              <td><input type="text" name="accountAddress1" id="accountAddress1" class="validate[required]"></td>
              <td><input type="text" name="accountAddress2" id="accountAddress2"></td>
            </tr>
            <tr>
              <td width="50%" class="form-label">City</td>
              <td width="50%" class="form-label">&nbsp;</td>
            </tr>
            <tr>
              <td><input type="text" name="accountCity" id="accountCity" class="validate[required]"></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td width="50%" class="form-label">State</td>
              <td width="50%" class="form-label">&nbsp;</td>
            </tr>
            <tr>
              <td><input type="text" name="accountState" id="accountState" class="validate[required]"></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td width="50%" class="form-label">Zip Code</td>
              <td width="50%" class="form-label">&nbsp;</td>
            </tr>
            <tr>
              <td><input type="text" name="accountZip" id="accountZip" class="validate[required]"></td>
              <td>&nbsp;</td>
            </tr>
          </table>
        </div>
        <div class="form-heading">About Your Company</div>
        <div class="form-content">
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td class="form-label">Please tell us a little bit about your company:</td>
            </tr>
            <tr>
              <td>
                <textarea name="accountBio" id="accountBio" cols="45" rows="5" class="validate[required]"></textarea>
              </td>
            </tr>
          </table>
        </div>
        <div class="form-heading">Business ID</div>
        <div class="form-content">
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td class="form-label">Please enter your Federal DOT# or Federal Employer ID# below:</td>
            </tr>
            <tr>
              <td><input type="text" name="accountBusinessID" id="accountBusinessID" class="validate[required]"></td>
            </tr>
          </table>
        </div>
        <div class="form-heading">Company Logo (Optional)</div>
        <div class="form-content">
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td class="form-label">Uploaded image will need to be in jpeg format<br><br>
              </td>
            </tr>
            <tr>
              <td class="form-label">Upload Image</td>
            </tr>
            <tr>
              <td>
                <input type="file" name="accountCompanyLogo" id="accountCompanyLogo">
              </td>
            </tr>
          </table>
        </div>
        <div id="form-buttons"><a id="nextBtn" href="javascript:;"><img src="images/new/next-btn.png" width="74" height="35" border="0"></a></div>
      </form>
    </div>
    <div id="verification-process">
      <div class="verification-header">Verification<br>Process</div>
      <div style="clear:both;"></div>
      <div class="verification-text">ProDriver-Online takes the necessary precautions to ensure all personal information provided by all parties.  As part of this process, we verify all applicants who will be receiving this information. By providing us with either the DOT # or the Federal Identification #, ProDriver-Online can verify the validity of its members.
 
        <br>
        <br>
      ProDriver-Online appreciates the understanding and cooperation in providing us with the necessary information to ensure that its website maintains its integrity for all members and participants. By providing this information the user agrees to all terms of service. <br><br> <a href="terms.cfm" style="color:#FFF;">See Terms of Use</a></div>
    </div>
    <div style="clear:both;"></div>
  </div>
  <div id="footer">
    <cfinclude template="inc-footer.cfm">
  </div>
</div>
</body>
</html>