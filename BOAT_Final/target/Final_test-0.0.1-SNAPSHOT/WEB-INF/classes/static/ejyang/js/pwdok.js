$(document).ready(function(){
    $('.fa-eye-slash').on('click',function(){
        $('input').toggleClass('active');
        if($('input').hasClass('active')){
            $(this).attr('class',"fa fa-eye").parent()
            .prev('input').attr('type',"text");
        }else{
            $(this).attr('class',"fa fa-eye-slash").parent()
            .prev('input').attr('type','password');
        }
    });
    
    var valid_password = false;
	var valid_password_ck = false;
	
	//유효성 비밀번호
	$('#_label-pwd').keyup(function() {
		var pattern = /^[0-9a-zA-Z~?!@#$%^&*_-]{6,16}$/i;
		var pwd = $.trim($(this).val());
		
		if(pattern.test(pwd)){
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback').hide();
			$('#_label-pwd-ck').removeClass('border-danger ');
			$('#validationServerUsernameFeedback2').hide();
			valid_password = true;
		}else {	
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback').show();
			valid_password = false;
		}
		
		activateButton();
    });
    $('#_label-pwd').focusout(function() {
    	if($(this).val() == '' || $(this).length() < 6){
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback').show();
			valid_password = false;
		}else {	
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback').hide();
			valid_password = true;
		}
		
		activateButton();
    });
	
	//유효성 비밀번호 확인
	$('#_label-pwd-ck').keyup(function() {
		var pwdck = $.trim($(this).val());
		
		if(pwdck == $('#_label-pwd').val()){
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback2').hide();
			 valid_password_ck = true;
		}else {	
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback2').show();
			 valid_password_ck = false;
		}
		
		activateButton();
    });
    $('#_label-pwd-ck').focusout(function() {
    	if($(this).val() == '' || $(this).val().length() < 6){
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback2').show();
			 valid_password_ck = false;
		}else {	
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback2').hide();
			 valid_password_ck = true;
		}
		
		activateButton();
    });
    
    //가입하기 버튼 활성화
	function activateButton() {
		console.log("===================")
		console.log("valid_password"+valid_password)
		console.log("valid_password_ck"+valid_password_ck)
	    if (valid_password && valid_password_ck) {
	      $('#form-controls .btn-primary').prop('disabled', false);
	    } else {
	      $('#form-controls .btn-primary').prop('disabled', true);
	    }
	}
});
