<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ProDriver</title>
<link rel="stylesheet" type="text/css" href="css/global.css" />
<link rel="stylesheet" type="text/css" href="css/colorbox.css" />
<link rel="stylesheet" type="text/css" href="css/signup.css" />
<style type="text/css">
	body { background-image:url(images/new/tpl-bg-2.png); background-repeat:repeat-x; background-color:#2D2D2D;  }
</style>
<script type="text/javascript" src="js/all.js"></script>
<script type="text/javascript">_this.init("driver-signup2");</script>
</head>
<body>
<div id="container">
  <cfinclude template="inc-header.cfm">
  <div id="body"><img src="images/new/signup_driver_step2.png" width="970" height="239"></div>
  <div id="content-container">
  	<div id="pricing"><img src="images/new/pricing_driver.gif" width="172" height="185"><img src="images/video_preview.png" width="173" height="186" border="0" usemap="#Map">
      <map name="Map">
        <area id="driver_video_link" shape="rect" coords="7,140,165,179" href="#">
      </map>
  	</div>
    <div id="form-body">
    	<form id="signupDriver2" method="post" enctype="multipart/form-data">
        <div class="form-heading">Driver Information</div>
        <div class="form-content">
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="50%" class="form-label">Current Employer</td>
              <td width="50%" class="form-label">Marital Status</td>
            </tr>
            <tr>
              <td><input type="text" name="accountCurrentEmployer" id="accountCurrentEmployer" class="validate[required]"></td>
              <td>
                <select name="accountMaritalStatus" id="accountMaritalStatus" class="validate[required]">
                  <option value="">Choose</option>
                  <option value="Single">Single</option>
                  <option value="Married">Married</option>
                  <option value="Divorced">Divorced</option>
                </select>
              </td>
            </tr>
            <tr>
              <td width="50%" class="form-label">Telephone</td>
              <td width="50%" class="form-label">Passport</td>
            </tr>
            <tr>
              <td><input type="text" name="accountPhone" id="accountPhone" class="validate[required],custom[phone]"></td>
              <td>
                <select name="accountPassport" id="accountPassport" class="validate[required]">
                  <option value="">Choose</option>
                  <option value="Yes">Yes</option>
                  <option value="No">No</option>
                </select>
              </td>
            </tr>
            <tr>
              <td width="50%" class="form-label">
              Date of Birth
              </td>
              <td width="50%" class="form-label">Smoker</td>
            </tr>
            <tr>
              <td><input type="text" name="accountDOB" id="accountDOB" class="validate[required],custom[date]"></td>
              <td>
                <select name="accountSmoker" id="accountSmoker" class="validate[required]">
                  <option value="">Choose</option>
                  <option value="Yes">Yes</option>
                  <option value="No">No</option>
                </select>
              </td>
            </tr>
            <tr>
              <td width="50%" class="form-label">&nbsp;</td>
              <td width="50%" class="form-label">Meet Canada Driver Requirements?</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>
                <select name="accountCanadaRequirements" id="accountCanadaRequirements" class="validate[required]">
                  <option value="">Choose</option>
                  <option value="Yes">Yes</option>
                  <option value="No">No</option>
                </select>
              </td>
            </tr>
          </table>
        </div>
        <div class="form-heading">Driver Professions</div>
        <div class="form-content">
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td colspan="2">
              	<div class="checkbox-div"><input id="check1" name="accountProfessions" type="checkbox" value="1" class="validate[minCheckbox[1]]"><span class="form-label">Entertainment</span></div>
                <div class="checkbox-div"><input id="check2" name="accountProfessions" type="checkbox" value="2" class="validate[minCheckbox[1]]"><span class="form-label">Corporate</span></div>
                <div class="checkbox-div"><input id="check3" name="accountProfessions" type="checkbox" value="3" class="validate[minCheckbox[1]]"><span class="form-label">Private</span></div>
                <div class="checkbox-div"><input id="check4" name="accountProfessions" type="checkbox" value="4" class="validate[minCheckbox[1]]"><span class="form-label">Charter</span></div>
                <div class="checkbox-div"><input id="check5" name="accountProfessions" type="checkbox" value="5" class="validate[minCheckbox[1]]"><span class="form-label">Limo</span></div>
              </td>
            </tr>
          </table>
        </div>
        <div class="form-heading">Driver Biography</div>
        <div class="form-content">
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td class="form-label">Tell us a little about yourself. Providing companies a little background on your work experience could be beneficial (optional).</td>
            </tr>
            <tr>
              <td>
                <textarea name="accountBio" id="accountBio" cols="45" rows="5"></textarea>
              </td>
            </tr>
          </table>
        </div>
        <div class="form-heading">Profile Image (Optional)</div>
        <div class="form-content">
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td class="form-label">Upload a profile picture. (Optional)<br>
              </td>
            </tr>
            <tr>
              <td class="form-label">Upload Image</td>
            </tr>
            <tr>
              <td>
                <input type="file" name="accountProfileImage" id="accountProfileImage">
              </td>
            </tr>
          </table>
        </div>
        <div id="form-buttons"><a id="nextBtn" href="javascript:;"><img src="images/new/next-btn.png" width="74" height="35"></a></div>
      </form>
    </div>
    <div id="verification-process">
      <div class="verification-header">Verification Process</div>
      <div style="clear:both;"></div>
      <div class="verification-text">The following documents are available for download. Documents are in a fillable PDF format however they can not be saved and <br>
will need to be saved and will need to be printed out for your signature. Please upload or fax in your completed forms to ensure the completion of your ProDriver-Online membership.<br>
<br>
<div class="subtitle">REQUIRED DOCUMENTS FOR APPROVAL</div>
<a href="pdfs/application.pdf" target="_blank" style="color:#fff;"><br>
Driver Application</a><br>
<br>
<a href="pdfs/fair-credit.pdf" target="_blank" style="color:#fff;">Fair Credit</a><br>
<br>
<a href="pdfs/I-9.pdf" target="_blank" style="color:#fff;">I-9</a><br>
<br>
<a href="pdfs/W-9.pdf" target="_blank" style="color:#fff;">W-9</a></div>
    </div>
    <div style="clear:both;"></div>
  </div>
  <div id="footer">
    <cfinclude template="inc-footer.cfm">
  </div>
</div>
</body>
</html>