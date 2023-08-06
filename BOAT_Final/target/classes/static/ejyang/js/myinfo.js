
function getList(tab){
	console.log('tab'+tab)
      	
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
      		   
    $.ajax({
    	type: "POST",
      	url: "view_ajax",
      	data: {"tab": tab},
      	dataType:"json",
      	cache : false,
      	beforeSend : function(xhr)
        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        	xhr.setRequestHeader(header, token);         
        },
      	success: function (response) {
      		console.log('response'+response.tab)
      		let output = "";
      		
	      	$('.myinfo .container').remove();
      		if(response.tab == '회원 탈퇴') {
      			
      			output += '<div class="container">';
      			output += '<div class="row justify-content-md-center d-flex align-items-center" style="margin-top: 30px; padding: 150px 130px 150px;">';
      			output += '<div class="col-sm-12 col-md-8">';
      			output += '<p class="fs-3 text-dark">비밀번호 재확인</p>';
      			output += '<p class="fs-5 fw-normal text-dark">정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 확인합니다.</p>';
      			output += '<div class="mt-4 row row-container ps-2">';
      			output += '<input type="password" autocomplete="off" class="form-control w-50"  style="height: 50px;">';
      			output += '<button type="button" class="col-2 ms-3 btn btn-outline-primary">확인</button></div></div>';
      			output += '<div class="col-sm-12 col-md-4">';
      			output += '<img src="../resources/img/secession.png" style="width: 260px;">';
      			output += '</div></div></div>';
      			
	      		$('.myinfo').append(output)
      			
      		}else {
				$('.myinfo > div').remove();
      			$('.myinfo').load('myinfo.jsp');
      		}
      		
      	            	
      	},
      	error: function (error) {
      		toastr.options.escapeHtml = true;
			toastr.options.closeButton = true;
			toastr.options.newestOnTop = false;
			toastr.options.progressBar = true;
			toastr.info('회원 탈퇴 페이지 오류입니다.', '내 정보', {timeOut: 5000});
      	}
	});//ajax
	
}//getList

$(document).ready(function(){

	var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");


	var valid_password = true;
	var valid_password_ck = false;
	var valid_name = true;
	
	
	//사진 첨부
    $("#upfile").on('change',function(){
		const reader = new FileReader();
		reader.readAsDataURL(event.target.files[0]);
					
		reader.onload = function() { //읽기에 성공했을 때 실행되는 이벤트 핸들러
			$('.profile img').attr('src', this.result); 
			$('.profile img').show();
			$(".profile label").removeAttr("style");
		};
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
    
    //버튼 활성화
	function activateButton() {
		console.log("===================")
		console.log("valid_password"+valid_password)
		console.log("valid_password_ck"+valid_password_ck)
		console.log("valid_name"+valid_name)
	    if (valid_password && valid_password_ck && valid_name) {
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

