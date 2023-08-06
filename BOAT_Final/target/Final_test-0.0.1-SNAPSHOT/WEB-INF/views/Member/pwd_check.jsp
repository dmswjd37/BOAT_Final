<%@ page language="java" contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
 <head>
 	<title>BOAT - 비밀번호 찾기</title>
 	<link href="${pageContext.request.contextPath}/resources/ejyang/css/pwdcheck.css" type="text/css" rel="stylesheet">
 	<script src="http://code.jquery.com/jquery-latest.js"></script>
 	<script src="${pageContext.request.contextPath}/resources/ejyang/js/pwdcheck.js"></script>
 	<jsp:include page="../Main/header.jsp" />
 	<script>
 		var result="${message}";
 		if(result == 'membernull'){
 			toastr.options.escapeHtml = true;
 		    toastr.options.closeButton = true;
 		    toastr.options.newestOnTop = false;
 		    toastr.options.progressBar = true;
 		    toastr.info('일치하는 회원정보가 없습니다.', '비밀번호 찾기', {timeOut: 5000});
 		}
 	</script>
 </head>
 <body>
   <div id="form-container">
      <div id="form-inner-container">
        <!-- Sign up form -->
        <div id="sign-up-container">
          <h3>비밀번호 찾기</h3>
          <form action="pwd_check_ok" method="get">
            <label for="name">이름</label>
            <input type="text" class="_input" name="name" placeholder="실명을 입력해 주세요" id="name">
			<div id="validationServerUsernameFeedback" class="invalid-feedback fw-bold">
				이름(실명)을 입력해 주세요
			</div>

            <label for="empno" class="mt-4">사번</label>
			<input type="text" name="empno" placeholder="사번을 입력해 주세요" class="input-id _input error_border" id="empno">
			<div id="validationServerUsernameFeedback2" class="invalid-feedback fw-bold">
				사번을 입력해 주세요
			</div>
	
            <label for="email" class="mt-4">이메일</label>
            <div class="row row-container">
            	<div class="body col-sm-12 col-md-9">
	            	<input type="email" name="email" class="clear focusInteraction _input" id="email" placeholder="이메일">
	            </div>
				<div class="body col-sm-12 col-sm-12 col-md-3 align-self-center">
					<button type="button" id="email_auth_btn" class="emailbtn btn btn-outline-primary w-100" 
							disabled>인증</button>
	            </div>
	            <div id="validationServerUsernameFeedback3" class="invalid-feedback fw-bold">
					올바른 이메일을 입력해주세요
				</div>
			</div>
            
            <!-- 메일 인증 -->
	        <div class="row row-container align-items-center mt-3">
	        	<div class="body col-sm-12">
	            	<input type="text" placeholder="인증번호를 입력해주세요" name="authCode" id="email_auth_key" 
	                	class="w-100 rounded form-control" value="" style="height:55px;" disabled>
	            </div>
	            <div id="validationServerUsernameFeedback4" class="invalid-feedback fw-bold">
					인증인증번호가 요청되었습니다
				</div>
	            <div id="validationServerUsernameFeedback5" class="invalid-feedback fw-bold">
					메일 발송에 실패했습니다. 재시도 해주시기 바랍니다
				</div>
	        </div>
	        
	        <div id="form-controls">
              <button type="submit"  class="btn btn-primary py-3 px-5 mt-4 w-100" disabled>비밀번호 찾기</button>
            </div>

			<div class="find-userinfo__btn_text">
            	<a href="id_check">아이디를 찾으시나요?</a>
            </div>
			
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
          </form>
        </div>


      </div>
  </div>

  

  <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
  <jsp:include page="../Main/footer.jsp" />
 </body>
</html>