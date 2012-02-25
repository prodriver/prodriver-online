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
<script type="text/javascript">_this.init("company-signup1");</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <div id="body"><img src="images/new/signup_company_step1.png" width="970" height="239"></div>
  <div id="content-container">
  	<div id="pricing"><img src="images/new/pricing_company.gif" width="172" height="185"></div>
    <div id="form-body">
      <form id="signupCompany1" method="post">
        <div class="form-heading">Create Username and Password</div>
        <div class="form-content">
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="50%" class="form-label">Email Address</td>
              <td width="50%" class="form-label">Password</td>
            </tr>
            <tr>
              <td><input type="text" name="accountEmail" id="accountEmail" class="validate[required,custom[email],ajax[emailDupCheck]]"></td>
              <td><input type="password" name="accountPassword" id="accountPassword" class="validate[required]" value=""></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td class="form-label">Confirm Password</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>
                <input type="password" name="accountPassword2" id="accountPassword2" class="validate[required,equals[accountPassword]]">
              </td>
            </tr>
          </table>
        </div>
        <div class="form-heading">Address Information</div>
        <div class="form-content">
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="50%" class="form-label">First Name</td>
              <td width="50%" class="form-label">Last Name</td>
            </tr>
            <tr>
              <td><input type="text" name="accountFirstName" id="accountFirstName" class="validate[required]"></td>
              <td><input type="text" name="accountLastName" id="accountLastName" class="validate[required]"></td>
            </tr>
            <tr>
              <td class="form-label">Address 1</td>
              <td class="form-label">Address 2</td>
            </tr>
            <tr>
              <td><input type="text" name="accountAddress1" id="accountAddress1" class="validate[required]"></td>
              <td><input type="text" name="accountAddress2" id="accountAddress2"></td>
            </tr>
            <tr>
              <td class="form-label">City</td>
              <td class="form-label">&nbsp;</td>
            </tr>
            <tr>
              <td><input type="text" name="accountCity" id="accountCity" class="validate[required]"></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td class="form-label">State</td>
              <td class="form-label">&nbsp;</td>
            </tr>
            <tr>
              <td>
<select id="accountState" name="accountState" class="validate[required]">
	<option value="">-- Select a state --</option>
  <option value="Alabama">Alabama</option> 
	<option value="Alaska">Alaska</option> 
  <option value="Arizona">Arizona</option> 
  <option value="Arkansas">Arkansas</option> 
  <option value="California">California</option> 
  <option value="Colorado">Colorado</option> 
  <option value="Connecticut">Connecticut</option> 
  <option value="Delaware">Delaware</option> 
  <option value="Florida">Florida</option> 
  <option value="Georgia">Georgia</option> 
  <option value="Hawaii">Hawaii</option> 
  <option value="Idaho">Idaho</option> 
  <option value="Illinois">Illinois</option> 
  <option value="Indiana">Indiana</option> 
  <option value="Iowa">Iowa</option> 
  <option value="Kansas">Kansas</option> 
  <option value="Kentucky">Kentucky</option> 
  <option value="Louisiana">Louisiana</option> 
  <option value="Maine">Maine</option> 
  <option value="Maryland">Maryland</option> 
  <option value="Massachusetts">Massachusetts</option> 
  <option value="Michigan">Michigan</option> 
  <option value="Minnesota">Minnesota</option> 
  <option value="Mississippi">Mississippi</option> 
  <option value="Missouri">Missouri</option> 
  <option value="Montana">Montana</option> 
  <option value="Nebraska">Nebraska</option> 
  <option value="Nevada">Nevada</option> 
  <option value="New Hampshire">New Hampshire</option> 
  <option value="New Jersey">New Jersey</option> 
  <option value="New Mexico">New Mexico</option> 
  <option value="New York">New York</option> 
  <option value="North Carolina">North Carolina</option> 
  <option value="North Dakota">North Dakota</option> 
  <option value="Ohio">Ohio</option> 
  <option value="Oklahoma">Oklahoma</option>
  <option value="Oregon">Oregon</option> 
  <option value="Pennsylvania">Pennsylvania</option> 
  <option value="Rhode Island">Rhode Island</option> 
  <option value="South Carolina">South Carolina</option> 
  <option value="South Dakota">South Dakota</option> 
  <option value="Tennessee">Tennessee</option> 
  <option value="Texas">Texas</option> 
  <option value="Utah">Utah</option> 
  <option value="Vermont">Vermont</option> 
  <option value="Virginia">Virginia</option> 
  <option value="Washington">Washington</option> 
  <option value="West Virginia">West Virginia</option> 
  <option value="Wisconsin">Wisconsin</option> 
  <option value="Wyoming">Wyoming</option> 
</select>  
              </td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td class="form-label">Zip Code</td>
              <td class="form-label">&nbsp;</td>
            </tr>
            <tr>
              <td><input name="accountZip" type="text" id="accountZip" size="15" class="validate[required]"></td>
              <td>&nbsp;</td>
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