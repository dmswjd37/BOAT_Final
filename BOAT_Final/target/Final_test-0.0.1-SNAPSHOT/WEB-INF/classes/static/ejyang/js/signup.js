$(document).ready(function(){
	//이메일 입력 유효성
	$('#email').keyup(function() {
		var pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var email = $.trim($(this).val());
		if(pattern.test(email)){
			$('.btn-primary').attr("disabled", false);
			$('input[type=email]').removeClass('is-invalid');
			$('#user_mail').hide().removeClass('invalid-feedback');
		}else {	
			$('.btn-primary').attr("disabled", true);
			$('input[type=email]').addClass('is-invalid');
			$('#user_mail').show().addClass('invalid-feedback');
		}
		
		if(email=='' || email.equls('')) {
			$('input[type=email]').removeClass('is-invalid');
			$('#user_mail').hide().removeClass('invalid-feedback');
		}
	});
	
	
	
});



