$(document).ready(function(){

	// 초기값은 모든 필드의 검사를 통과하지 않은 상태로 설정합니다
	var agree_chk = false;
	var agree_chk2 = false;
	var valid_select = false;
	var valid_empno = false;
	var valid_password = false;
	var valid_password_ck = false;
	var valid_email = true;
	var valid_name = ($('#_label-name').val() != null && $('#_label-name').val() != '');
	var valid_file = false;
	var valid_email_ck = false;
	
	activateButton();




	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
	var email_auth_cd = '';

	$("#email_auth_btn").on('click',function () {
		console.log($('#email').val())
		var email = $('#email').val();
		$("#email_auth_key").prop('disabled', false);
		
			$.ajax({
				type : "POST",
				url : "emailAuth",
				data : {email : email},
				beforeSend : function(xhr)
		        {   
		        	xhr.setRequestHeader(header, token);			
		        },
				success: function(data){
					email_auth_cd = data;
					$('#validationServerUsernameFeedback8').show();
					
					$("#email_auth_key").keyup(function() {
						if($("#email_auth_key").val() == email_auth_cd) {
							$('#validationServerUsernameFeedback8').hide();
							valid_email_ck = true;
							console.log('valid_email_ck='+valid_email_ck)
						}else{
							$('#validationServerUsernameFeedback8').show();
							valid_email_ck = false;
						}
						
						activateButton();
					});
				},
				error: function(data){
					$('#validationServerUsernameFeedback9').show();
					valid_email_ck = false;
				}
			}); //ajax end
	});


	
	
	//비밀번호 눈
    $('.fa-eye-slash').on('click',function(){
        $('input').toggleClass('active');
        if($('input').hasClass('active')){
            $(this).attr('class',"fa fa-eye")
            .prev('input').attr('type',"text");
        }else{
            $(this).attr('class',"fa fa-eye-slash")
            .prev('input').attr('type','password');
        }
    });
    
    //약관 모두 동의
    $('#agree_all').on('click',function(){
    	if($(this).is(":checked") == true) {
	    	$('#agree_chk').prop("checked", true);
	    	$('#agree_chk2').prop("checked", true);
	    	agree_chk = true;
	    	agree_chk2 = true;
    	}else {
	    	$('#agree_chk').prop("checked", false);
	    	$('#agree_chk2').prop("checked", false);
	    	agree_chk = false;
	    	agree_chk2 = false;
    	}
    		
		activateButton();
    });
    $('#agree_chk').on('click',function(){
	    if($('#agree_chk').is(":checked") == true && $('#agree_chk2').is(":checked") == true) {
	    	$('#agree_all').prop("checked", true);
	    }else{
	    	$('#agree_all').prop("checked", false);
	    }
	    
	    if($('#agree_chk').is(":checked") == true) {
	    	 agree_chk = true;
	    }else{
	    	 agree_chk = false;
	    }
		
		activateButton();
    });
    $('#agree_chk2').on('click',function(){
	    if($('#agree_chk').is(":checked") == true && $('#agree_chk2').is(":checked") == true) {
	    	$('#agree_all').prop("checked", true);
	    }else{
	    	$('#agree_all').prop("checked", false);
	    }
	    
	    if($('#agree_chk2').is(":checked") == true) {
	    	 agree_chk2 = true;
	    }else{
	    	 agree_chk2 = false;
	    }
		
		activateButton();
    });
    
    //유효성 부서명
    $('.form-select').on('change',function(){
    	if($(this).val() == '부서명을 선택해 주세요'){
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback').show();
			$('.input-empno').val('');
			 valid_select = false;
			 valid_empno = false;
		}else {	
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback').hide();
			$('.input-empno').removeClass('border-danger ');
			$('#validationServerUsernameFeedback2').hide();
			 valid_select = true;
			 valid_empno = true;
		}
		
		
		$.ajax({
 			url : "idcheck",
 			data : {"select":$(this).val()},
 			success : function(resp){
 				let select = $(".form-select").val();
 				
 				let selectempno = 10;
				if(select=="개발팀")
					selectempno = 20;
				if(select=="인사팀")
					selectempno = 30;
				if(select=="기획팀")
					selectempno = 40;
				if(select=="영업팀")
					selectempno = 50;
					
 				if(resp == 0){//db에 해당 id가 없는 경우
 					var today = new Date();
 					var year = today.getFullYear().toString().slice(-2);
 					console.log(year)
 					console.log("$(this).val()"+$(".form-select").val())
 					
 					var empno = year + selectempno + "001";
 					$('.input-empno').val(empno);
 					
 				}else{//db에 해당 id가 있는 경우
 					console.log("resp"+resp)
 					var empno = Number(resp) + 1;
 					console.log("empno"+empno)
 					$('.input-empno').val(empno);
 				}
 			}
 		});//ajax end
		
		activateButton();
		
    });
    $('.form-select').focusout(function() {
	    if($(this).val() == '부서명을 선택해 주세요'){
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback').show();
			 valid_select = false;
			 valid_empno = false;
			 
		}else {
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback').hide();
			 valid_select = true;
			 valid_empno = true;
		}
		
		activateButton();
	});
	
	//유효성 사원번호
	$('.input-empno').focusout(function() {
    	if($(this).val() == ''){
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback2').show();
		}else {	
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback2').hide();
		}
		
    });
	
	//유효성 비밀번호
	$('#_label-pwd').keyup(function() {
		var pattern = /^[0-9a-zA-Z~?!@#$%^&*_-]{6,16}$/i;
		var pwd = $.trim($(this).val());
		
		if(pattern.test(pwd)){
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback3').hide();
			$('#_label-pwd-ck').removeClass('border-danger ');
			$('#validationServerUsernameFeedback4').hide();
			valid_password = true;
		}else {	
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback3').show();
			valid_password = false;
		}
		
		activateButton();
    });
    $('#_label-pwd').focusout(function() {
    	if($(this).val() == '' || $(this).length() < 6){
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback3').show();
			valid_password = false;
		}else {	
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback3').hide();
			valid_password = true;
		}
		
		activateButton();
    });
	
	//유효성 비밀번호 확인
	$('#_label-pwd-ck').keyup(function() {
		var pwdck = $.trim($(this).val());
		
		if(pwdck == $('#_label-pwd').val()){
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback4').hide();
			 valid_password_ck = true;
		}else {	
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback4').show();
			 valid_password_ck = false;
		}
		
		activateButton();
    });
    $('#_label-pwd-ck').focusout(function() {
    	if($(this).val() == '' || $(this).val().length() < 6){
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback4').show();
			 valid_password_ck = false;
		}else {	
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback4').hide();
			 valid_password_ck = true;
		}
		
		activateButton();
    });
	
	//유효성 메일
	$('#email').keyup(function() {
		var pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var email = $.trim($(this).val());
		if(pattern.test(email)){
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback6').hide();
			 valid_email = true;
		}else {	
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback6').show();
			 valid_email = false;
		}
		
		activateButton();
	});
	$('#email').focusout(function() {
		var pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var email = $.trim($(this).val());
    	if($(this).val() == '' || !(pattern.test(email))){
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback6').show();
			 valid_email = false;
		}else {	
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback6').hide();
			 valid_email = true;
		}
		
		activateButton();
    });
	
	//유효성 이름
	$('#_label-name').keyup(function() {
		if($(this).val() == '' || $(this).val().length <= 2){
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback5').show();
			 valid_name = false;
		}else {	
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback5').hide();
			 valid_name = true;
		}
		
		activateButton();
    });
    $('#_label-name').focusout(function() {
    	if($(this).val() == '' || $(this).val().length <= 2){
			$(this).addClass('border-danger ');
			$('#validationServerUsernameFeedback5').show();
			 valid_name = false;
		}else {	
			$(this).removeClass('border-danger ');
			$('#validationServerUsernameFeedback5').hide();
			 valid_name = true;
		}
		
		activateButton();
    });
    
    $('#validationServerUsernameFeedback7').show();
    
    //사진 첨부
    $("#upfile").on('change',function(){
		const reader = new FileReader();
		reader.readAsDataURL(event.target.files[0]);
					
		reader.onload = function() { //읽기에 성공했을 때 실행되는 이벤트 핸들러
			$('.profile img').attr('src', this.result); 
			$('.profile img').show();
			$(".profile label").removeAttr("style");
			$(".profile svg").hide();
			$('#validationServerUsernameFeedback7').hide();
		};
		
		valid_file = true;
		activateButton();
		
	});
    
    //사진 첨부
    
	//가입하기 버튼 활성화
	function activateButton() {
		console.log("===================")
		console.log("agree_chk"+agree_chk)
		console.log("agree_chk2"+agree_chk2)
		console.log("valid_select"+valid_select)
		console.log("valid_empno"+valid_empno)
		console.log("valid_password"+valid_password)
		console.log("valid_password_ck"+valid_password_ck)
		console.log("valid_email"+valid_email)
		console.log("valid_name"+valid_name)
		console.log("valid_file"+valid_file)
		console.log("valid_email_ck"+valid_email_ck)
	    if (agree_chk && agree_chk2 && valid_select && valid_empno && valid_password && valid_password_ck && valid_email && valid_name && valid_file && valid_email_ck) {
	      $('.submit').prop('disabled', false);
	    } else {
	      $('.submit').prop('disabled', true);
	    }
	  }
});

function onClickUpload() {
	let myInput = document.getElementById("upfile");
	myInput.click();
}
