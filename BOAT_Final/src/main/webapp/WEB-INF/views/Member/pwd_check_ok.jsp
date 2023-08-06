<%@ page language="java" contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
 <head>
 	<title>BOAT - 비밀번호 재설정</title>
 	<link href="${pageContext.request.contextPath}/resources/ejyang/css/pwdok.css" type="text/css" rel="stylesheet">
 	<script src="http://code.jquery.com/jquery-latest.js"></script>
 	<script src="${pageContext.request.contextPath}/resources/ejyang/js/pwdok.js"></script>
 	<jsp:include page="../Main/header.jsp" />
 </head>
 <body>
   <div id="form-container">
      <div id="form-inner-container">
        <!-- Sign up form -->
        <div id="sign-up-container">
          <h3>비밀번호 재설정</h3>
          <p class="brick-idpw_2022__desc">사번 <span class="w-blue-text">${empno}</span> 의 새 비밀번호를 등록해 주세요</p>
          <form action="pwdmodify" method="post">
          	<input type="hidden" name="empno" value="${empno}">
          
            <label for="name">새 비밀번호</label>
            <input type="password" class="_input" name="password" placeholder="6~16자 / 문자, 숫자, 특수 문자 모두 혼용 가능" 
            	id="_label-pwd">
            <div class="first_icon"><i class= "fa fa-solid fa-eye-slash" ></i></div>
			<div id="validationServerUsernameFeedback" class="invalid-feedback fw-bold">
				영문, 숫자, 특수 문자 6~16자리로 입력해 주세요
			</div>

            <label for="empno" class="mt-4">새 비밀번호 확인</label>
			<input type="password" name="password_ck" placeholder="새 비밀번호 확인" class="input-id _input error_border" 
				id="_label-pwd-ck">
			<div class="second_icon"><i class= "fa fa-solid fa-eye-slash" ></i></div>
			<div id="validationServerUsernameFeedback2" class="invalid-feedback fw-bold">
				비밀번호와 동일하게 입력해 주세요
			</div>
	
            <div id="form-controls">
              <button type="submit"  class="btn btn-primary py-3 px-5 mt-4 w-100" disabled>변경하기</button>
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