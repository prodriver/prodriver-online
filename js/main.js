_this = {
		
		clearForm: function(fn){
			$(':input',fn)
			 .not(':button, :submit, :reset, :hidden')
			 .val('')
			 .removeAttr('checked')
			 .removeAttr('selected');
		},
		
		getURLParams: function(){
			var params = {};
			window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str,key,value) {
				params[key] = value;
			});
		 
			return params;
		},
		
		init: function(page) {
			
			$(document).ready( function(){  
				
				_this.setLoginBtnState();
				_this.setFormSubmitBtnHandler();
				
				switch (page) {
					case "admin-detail" : _this.initAdminDetailPage(); break;
					case "calendar" : _this.initDriverCalendar(); break;
					case "edit-driver-profile" : _this.initDriverEditPage(); break;
					case "edit-company-profile" : _this.initCompanyEditPage(); break;
					case "message" : _this.initMessagePage(); break;
					case "co-profile" : _this.initCompanyProfile(); break;
					case "profile" : _this.initDriverProfile(); break;
					case "search" : _this.initDriverSearchPage(); break;
					case "driver-signup1" : _this.initDriverSignup1(); break;
					case "driver-signup2" : _this.initDriverSignup2(); break;
					case "driver-signup3" : _this.initDriverSignup3(); break;
					case "company-signup1" : _this.initCompanySignup1(); break;
					case "company-signup2" : _this.initCompanySignup2(); break;
					case "index1" : _this.initIndex1(); break;
					case "index2" : _this.initIndex2(); break;
				}
				
			});
			
		},
		
		initAdminDetailPage: function(){
			
			$("#approveAccount_btn").live("click",function(){  
				var o = confirm('Are you sure you would like to approve this account? Click "OK" to proceed.');
				if(o) { window.location.href="worker.cfc?method=approveAccount&accountID=" + this.title; };
				return false;
			});
			
			$("#activateAccount_btn").live("click",function(){  
				var o = confirm('Are you sure you would like to activate this account? Activating this account will give them full access to the website. Click "OK" to proceed.');
				if(o) { window.location.href="worker.cfc?method=activateAccount&accountID=" + this.title; };
				return false;
			});
			
			$("#deleteAll_btn").live("click", function(){  
				var o = confirm('Are you sure you would like to delete all of the documents? Click "OK" to proceed.');
				if(o) { window.location.href="worker.cfc?method=deleteAllDocuments&accountID=" + this.title; };
				return false;
			});
			
			$("#reinstateAccount_btn").live("click", function(){  
				var o = confirm('Are you sure you would like to reinstate this account? Click "OK" to proceed.');
				if(o) { window.location.href="worker.cfc?method=reinstateAccount&accountID=" + this.title; };
				return false;
			});
			
			$("#suspendAccount_btn").live("click", function(){  
				var o = confirm('Are you sure you would like to suspend this account? Click "OK" to proceed.');
				if(o) { window.location.href="worker.cfc?method=suspendAccount&accountID=" + this.title; };
				return false;
			});
			
		},
		
		initCompanyEditPage: function(){
			$("#companyEditForm").validationEngine();
			$("#companyEditForm").attr("action","worker.cfc?method=editCompanyProfile");
			$("#saveProfileBtn").click( function(){ $("#companyEditForm").submit(); } );
		},
		
		initCompanyProfile: function(){
			$("#emailDriverBtn").colorbox({ inline:true, href:"#emailForm", width:"550px", height:"400px" });
			$("#emailSubmitBtn").click(function(){
				$.ajaxq("allQueue",{ 
					 type:"POST",
					 url: "worker.cfc?method=sendMessage", 
					 data: $("#emailForm").serialize(),
					 dataType:"json",
					 timeout:8000,
					 success: function(data){ 
							if(!data.success){ alert("There was an error trying to save your message. Please try again."); }
								
							else { 
								window.location.href="profile.cfm?pid=" + $("#messageToID").val();
							}
					 },
					 error: function(a,b,c){ alert("There was a problem communicating with the server. Please try again in a few minutes."); }
				});
			});
		},
		
		initCompanySignup1: function(){
			//$("#company_video_link").colorbox({ iframe:true, href:"company_video.html", innerWidth:"640px", innerHeight:"480px" });
			$("#signupCompany1").validationEngine();
			$("#signupCompany1").attr("action","worker.cfc?method=signupCompanyStep1");
			$("#nextBtn").click( function(){ $("#signupCompany1").submit(); } );
		},
		
		initCompanySignup2: function(){
			//$("#company_video_link").colorbox({ iframe:true, href:"company_video.html", innerWidth:"640px", innerHeight:"480px" });
			$("#signupCompany2").validationEngine();
			$("#signupCompany2").attr("action","worker.cfc?method=signupCompanyStep2");
			$("#nextBtn").click( function(){ $("#signupCompany2").submit(); } );
		},
		
		initDriverCalendar: function(){
			var params = _this.getURLParams();
			$('#backend').DOPBookingCalendar( {'Type':'BackEnd', 'DataURL':'worker.cfc?method=loadCalendarData', 'SaveURL':'worker.cfc?method=saveCalendarChanges' } );
			if(params.pid){
				$('#frontend').DOPBookingCalendar({'Type':'FrontEnd', 'DataURL':'worker.cfc?method=loadCalendarData&pid=' + params.pid });
			} else {
				$('#frontend').DOPBookingCalendar({'Type':'FrontEnd', 'DataURL':'worker.cfc?method=loadCalendarData' });
			}
		},
		
		initDriverEditPage: function(){
			//$("#accountState").suggest( { type:'/location/citytown', flyout:'false'} );
			//$("#accountCurrentCity").suggest( { type:'/location/citytown', flyout:'false'} );
			//$("#editProfileForm").validationEngine();
			//$("#editProfileForm").attr("action","worker.cfc?method=saveEditProfile");
			$("#saveProfileBtn").click( function(){ $("#editProfileForm").submit(); } );
		},
		
		initDriverProfile: function(){
			_this.initDriverCalendar();
			
			$("#emailDriverBtn").colorbox({ inline:true, href:"#emailForm", width:"550px", height:"400px" });
			$("#emailSubmitBtn").click(function(){
				$.ajaxq("allQueue",{ 
					 type:"POST",
					 url: "worker.cfc?method=sendMessage", 
					 data: $("#emailForm").serialize(),
					 dataType:"json",
					 timeout:8000,
					 success: function(data){ 
							if(!data.success){ alert("There was an error trying to save your message. Please try again."); }
								
							else { 
								window.location.href="profile.cfm?pid=" + $("#comment_for").val();
							}
					 },
					 error: function(a,b,c){ alert("There was a problem communicating with the server. Please try again in a few minutes."); }
				});
			});
			
			$("#commentBtn").colorbox({ inline:true, href:"#commentForm", width:"550px", height:"350px" });
			$("#submitCommentBtn").click(function(){
				$.ajaxq("allQueue",{ 
					 type:"POST",
					 url: "worker.cfc?method=saveComment", 
					 data: $("#commentRatingForm").serialize(),
					 dataType:"json",
					 timeout:8000,
					 success: function(data){ 
							if(!data.success){ alert("There was an error trying to save your message. Please try again."); }
								
							else { 
								//window.location.href="profile.cfm?pid=" + $("#comment_for").val();
								window.location.reload();
							}
					 },
					 error: function(a,b,c){ alert("There was a problem communicating with the server. Please try again in a few minutes."); }
				});
			});
			
			$("#reqDriverCredBtn").click( function(){  
				var o = confirm('Are you sure you would like to send us a request for this driver\'s credentials?');
				if(o) { window.location.href="worker.cfc?method=requestDriverCredentials&accountID=" + this.title; };
				return false;
			});
		},
		
		initDriverSearchPage: function(){
			$("#searchForm").validationEngine();
			//$("#accountState").suggest( { type:'/location/us_state', flyout:'false'} );
		},
		
		initDriverSignup1: function(){
			$("#driver_video_link").colorbox({ iframe:true, href:"driver_video.html", innerWidth:"640px", innerHeight:"480px" });
			$("#signupDriver1").validationEngine();
			$("#signupDriver1").attr("action","worker.cfc?method=signupDriverStep1");
			$("#nextBtn").click( function(){ $("#signupDriver1").submit(); } );
		},
		
		initDriverSignup2: function(){
			$("#driver_video_link").colorbox({ iframe:true, href:"driver_video.html", innerWidth:"640px", innerHeight:"480px" });
			$("#signupDriver2").validationEngine();
			$("#signupDriver2").attr("action","worker.cfc?method=signupDriverStep2");
			$("#nextBtn").click( function(){ $("#signupDriver2").submit(); } );
		},
		
		initDriverSignup3: function(){
			$("#driver_video_link").colorbox({ iframe:true, href:"driver_video.html", innerWidth:"640px", innerHeight:"480px" });
			$("#signupDriver3").validationEngine();

			var errs = false;
			var areFileFieldsEmpty = false;
			
			$("input[type=file]").each(function(k,v){
				if(v.value){ areFileFieldsEmpty = true; };
			});
			
			$("#accountFaxDocuments").click(function(){
					if(this.checked){
						$('#signupDriver3').validationEngine('hideAll');
						$("input[type=file]").attr("disabled","disabled");
					} else {
						$("input[type=file]").removeAttr("disabled");
					}
			});
			
			$("#signupDriver3").attr("action","worker.cfc?method=signupDriverStep3");
			$("#nextBtn").click( function(){ if(!errs){ $("#signupDriver3").submit(); } } );
		},
		
		initIndex1: function(){
			$("#driver_video_link").colorbox({ iframe:true, href:"driver_video.html", innerWidth:"640px", innerHeight:"480px" });
		},
		
		initIndex2: function(){
			$("#company_video_link").colorbox({ iframe:true, href:"company_video.html", innerWidth:"640px", innerHeight:"480px" });
		},
		
		initMessagePage: function(){
			 $("#message_form").attr("action","worker.cfc?method=replyMessage");
			 $("#replyBtn").click( function(){ $("#message_form").submit(); } );
		},
		
		redirectAlert: function(){
			alert("You previously did not complete the signup process. You are being redirected to complete.");
		},
		
		setFormSubmitBtnHandler: function(formName,method){
			$("#form1").submit( function(){  });
			$("#next_btn").click( function(){ $("#form1").submit(); } );
		},
		
		setLoginBtnState: function(){
			
			$("#login-link").live("click", function(){  
				$("#login-panel").slideToggle(200);
			});
			
			$("#logoutBtn").live("click", function(){
				window.location.href="index.cfm?reset";
			});
			
			$("#submitBtn").live("click", function(){  
				$.ajaxq("allQueue",{ 
					 type:"POST",
					 url: "worker.cfc?method=checkAuthorization", 
					 data: $("#loginForm").serialize(),
					 dataType:"json",
					 timeout:8000,
					 success: function(data){ 
							//console.log(data);
							if(!data.success){ alert("Username and password is incorrect. Please try again."); }
							else { 
								
								// COMPANY TYPE
								if (data.type == 1) {
									
									switch (data.status) {
										case 1: window.location.href = "signup-company-confirmation.cfm"; break;
										case 2: window.location.href = "profile-declined.cfm"; break;
										case 3: window.location.href = "payment.cfm"; break;
										case 4: window.location.href = "search.cfm"; break;
										case 5: window.location.href = "account-suspended.cfm"; break;
										case 6: window.location.href = "payment-declined.cfm"; break;
										case 7: window.location.href = "signup-company-2.cfm"; break;
										case 8: window.location.href = "signup-company-3.cfm"; break;
									}
									
								}
								
								// DRIVER TYPE
								if (data.type == 2) {
									
									switch (data.status) {
										case 1: window.location.href = "signup-company-confirmation.cfm"; break;
										case 2: window.location.href = "profile-declined.cfm"; break;
										case 3: window.location.href = "payment.cfm"; break;
										case 4: window.location.href = "messages.cfm"; break;
										case 5: window.location.href = "account-suspended.cfm"; break;
										case 6: window.location.href = "payment-declined.cfm"; break;
										case 7: window.location.href = "signup-driver-2.cfm"; break;
										case 8: window.location.href = "signup-driver-3.cfm"; break;
									}
									
								}
								
								// ADMIN TYPE
								if (data.type == 3) { window.location.href = "admin.cfm"; }
								
								/*
								switch (data.status) {
									
									case 1: window.location.href = "signup-company-confirmation.cfm"; break;
									case 2: window.location.href = "profile-declined.cfm"; break;
									case 3: window.location.href = "payment.cfm"; break;
									case 5: window.location.href = "account-suspended.cfm"; break;
									case 6: window.location.href = "payment-declined.cfm"; break;
									
									case 7: 
										switch (data.type) {
											case 1: _this.redirectAlert(); window.location.href = "signup-company-2.cfm"; break;
											case 2: _this.redirectAlert(); window.location.href = "signup-driver-2.cfm"; break;
										}; break;
										
									case 8: 
										switch (data.type) {
											case 1: _this.redirectAlert(); window.location.href = "signup-company-3.cfm"; break;
											case 2: _this.redirectAlert(); window.location.href = "signup-driver-3.cfm"; break;
										}; break;
									
									default:
										switch (data.type) {
											case 1: window.location.href = "search.cfm"; break;
											case 2: window.location.href = "messages.cfm"; break;
											case 3: window.location.href = "admin.cfm"; break;
										}; break;
											
								};
								*/
							}
					 },
					 error: function(a,b,c){ alert("There was a problem communicating with the server. Please try again in a few minutes."); }
				});return false;
				
			});
			
			$("#searchBtn").live("click", function(){  
				$("#searchForm").attr("action","search.cfm");
				$("#searchForm").submit();
			});
			
		}
		
}