$(document).ready(function(){
	var valid_name = false;
	var valid_empno = false;
	var valid_email = false;
	var valid_email_ck = false;
	
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
	//이메일 인증
	$("#email_auth_btn").on('click',function () {
		console.log($('#email').val())
		var email = $('#email').val();
		$("#email_auth_key").prop('disabled', false);
		
			$.ajax({
				type : "POST",
				url : "emailcerti",
				data : {email : email},
				beforeSend : function(xhr)
		        {   
		        	xhr.setRequestHeader(header, token);			
		        },
				success: function(data){
					email_auth_cd = data;
					$('#validationServerUsernameFeedback4').show();
					
					$("#email_auth_key").keyup(function() {
						if($("#email_auth_key").val() == email_auth_cd) {
							$('#validationServerUsernameFeedback4').hide();
							valid_email_ck = true;
							console.log('valid_email_ck='+valid_email_ck)
							activateSubmitButton();
						}
						
						activateButton();
					});
				},
				error: function(data){
					$('#validationServerUsernameFeedback5').show();
					valid_email_ck = false;
				}
			}); //ajax end
	});
	
	//이름 체크
	$('#name').keyup(function() {
		if($(this).val() == '' || $(this).val().length <= 2){
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback').show();
			 valid_name = false;
		}else {	
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback').hide();
			 valid_name = true;
		}
		
		activateButton();
    });
    $('#name').focusout(function() {
    	if($(this).val() == '' || $(this).val().length <= 2){
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback').show();
			 valid_name = false;
		}else {	
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback').hide();
			 valid_name = true;
		}
		
		activateButton();
    });
	
	//사번 체크
	$('#empno').keyup(function() {
		var pattern = /^\d{7}$/;
		var empno = $.trim($(this).val());
		if(pattern.test(empno)){
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback2').hide();
			valid_empno = true;
		}else {	
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback2').show();
			valid_empno = false;
		}
		
		activateButton();
	});
	$('#empno').focusout(function() {
		var pattern = /^\d{7}$/;
		var empno = $.trim($(this).val());
    	if($(this).val() == '' || !(pattern.test(empno))){
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback2').show();
			 valid_empno = false;
		}else {	
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback2').hide();
			 valid_empno = true;
			
		}
		
		activateButton();
    });
    
    //메일 체크
	$('#email').keyup(function() {
		var pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var email = $.trim($(this).val());
		if(pattern.test(email)){
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback3').hide();
			 valid_email = true;
		}else {	
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback3').show();
			 valid_email = false;
		}
		
		activateButton();
	});
	$('#email').focusout(function() {
		var pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var email = $.trim($(this).val());
    	if($(this).val() == '' || !(pattern.test(email))){
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback3').show();
			 valid_email = false;
		}else {	
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback3').hide();
			 valid_email = true;
			
		}
		
		activateButton();
    });
    
    //인증 버튼 활성화
	function activateButton() {
		console.log("===================")
		console.log("valid_name"+valid_name)
		console.log("valid_empno"+valid_empno)
		console.log("valid_email"+valid_email)
	    if (valid_email && valid_name && valid_empno) {
	      $('.row-container button[type=button]').prop('disabled', false);
	    } else {
	      $('.row-container button[type=button]').prop('disabled', true);
	    }
	  }
	
	//아이디 찾기 버튼 활성화
	function activateSubmitButton() {
		$('#form-controls button[type=submit]').prop('disabled', false);
	}
});