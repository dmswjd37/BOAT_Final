<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
 <head>
 	<title>BOAT - 로그인</title>
 	<link href="${pageContext.request.contextPath}/resources/ejyang/css/login.css" type="text/css" rel="stylesheet">
 	<script src="http://code.jquery.com/jquery-latest.js"></script>
 	<script src="${pageContext.request.contextPath}/resources/ejyang/js/signin.js"></script>
 	<script src="https://accounts.google.com/gsi/client" async defer></script>
 	<jsp:include page="../Main/header.jsp" />
 	<script>
 		var result="${result}";
 		if(result == 'joinSuccess'){
 			toastr.options.escapeHtml = true;
 		    toastr.options.closeButton = true;
 		    toastr.options.newestOnTop = false;
 		    toastr.options.progressBar = true;
 		    toastr.info('회원가입을 축하합니다.', '로그인', {timeOut: 5000});
 		    
 		}else if(result == "googleSuccess"){
 			toastr.options.escapeHtml = true;
 		    toastr.options.closeButton = true;
 		    toastr.options.newestOnTop = false;
 		    toastr.options.progressBar = true;
 		    toastr.info('구글 계정 회원가입을 축하합니다.', '로그인', {timeOut: 5000});
 		    
 		}else if("${loginfail}" == "loginFailMsg"){
 			toastr.options.escapeHtml = true;
 		    toastr.options.closeButton = true;
 		    toastr.options.newestOnTop = false;
 		    toastr.options.progressBar = true;
 		    toastr.info('아이디나 비밀번호 오류 입니다.', '로그인', {timeOut: 5000});
 		    
 		}else if(result == "naverSuccess"){
 			toastr.options.escapeHtml = true;
 		    toastr.options.closeButton = true;
 		    toastr.options.newestOnTop = false;
 		    toastr.options.progressBar = true;
 		    toastr.info('네이버 계정 회원가입을 축하합니다.', '로그인', {timeOut: 5000});
 		    
 		}else if(result == 'passSuccess'){
 			toastr.options.escapeHtml = true;
 		    toastr.options.closeButton = true;
 		    toastr.options.newestOnTop = false;
 		    toastr.options.progressBar = true;
 		    toastr.info('비밀번호가 수정되었습니다.', '로그인', {timeOut: 5000});
 		}
 		
 		
 	</script>
 </head>
 <body>
   <div id="form-container">
      <div id="form-inner-container">
        <!-- Sign up form -->
        <div id="sign-up-container">
          <h3 class="fw-bold text">로그인</h3>
          <form name="loginform" action="${pageContext.request.contextPath}/member/loginProcess" method="post">
            <label for="name">사번</label>
            <i class= "fas fa-user"></i>
            
            <!-- sns 로그인 경우 -->
            <c:if test="${!empty EMPNO}">
	            <input type="text" name="id" id="name" class="form-control" placeholder="사번을 입력해주세요" value="${EMPNO}">
	
	            <label for="password">비밀번호</label>
	            <i class= "fas fa-lock"></i>
	            <input type="password" name="password" id="password" class="form-control" placeholder="비밀번호를 입력해주세요" 
	            		value="${PASSWORD_OG}">
            </c:if>
            
            <c:if test="${empty EMPNO}">
	            <input type="text" name="id" id="name" class="form-control" placeholder="사번을 입력해주세요"
	            		<c:if test="${userid != null}"> value="${userid}" </c:if> >
	
	            <label for="password">비밀번호</label>
	            <i class= "fas fa-lock"></i>
	            <input type="password" name="password" id="password" class="form-control" placeholder="비밀번호를 입력해주세요">
            </c:if>
            
		    <i class= "fa fa-solid fa-eye-slash" ></i>

            <div>
	        	<input type="checkbox" id="terms" name="remember-me">
	        	<label for="terms" class="terms_lable">로그인 유지하기</label>
			</div>
			 
            <div id="form-controls">
              <button type="submit"  class="btn btn-primary py-3 px-5">로그인</button>
              <!--<button type="button" id="toggleSignIn">Sign In</button> -->
            </div>
            
		<c:if test="${!empty EMPNO}"> 
            <button type="submit" id="loginButton" class="btn btn-primary py-3 px-5" autofocus hidden="">Log in</button>
        </c:if>
            
            <div class="sns_login">
            	<div class="brick-login_2023__sns"> 다른 계정으로 로그인 하기 </div>
            </div>
            
            <!-- 구글 가입 -->
	        <form name="GoogleForm" id="GoogleForm" method = "post" action="setSnsInfo">
	        	<input type="hidden" name="id" id="GoogleId">
				<input type="hidden" name="name" id="GoogleName">
				<input type="hidden" name="email" id="GoogleEmail">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			</form>
			  
	        <!-- 구글 로그인 -->
	        <form name="GoogleLogin" id="GoogleLogin" method = "post" action="GoogleLogin">
	          	<input type="hidden" name="id" id="GoogleLoginId">
				<input type="hidden" name="email" id="GoogleLoginEmail">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			</form>
            
            <div class="container mt-5 mb-4">
			  <div class="row">
			    <div class="col">
			      	<div class="form-group d-grid gap-2 col-10 mx-auto">
						<div id="buttonDiv" aria-hidden="true"
						      id="google-login-api"
						      ref="onClickGooglelogin"
						      style="display: none"></div> 
						<a class="btn-google btn-block border rounded-circle m-auto" onClick="onClickGooglelogin()"
							style="cursor: pointer">  </a>
						<span class="text-center mt-2" style="cursor: pointer" onClick="onClickGooglelogin()">구글 로그인</span>
					</div>
			    </div>
			    
			    <div class="col">
			    	<div class="form-group d-grid gap-2 col-10 mx-auto">
						<a href="${naverUrl}" class="btn-naver btn-block rounded-circle m-auto"></a>
						<span id="naver-login" class="text-center mt-2" style="cursor: pointer">네이버 로그인</span>
					</div>
			    </div>
			  </div>
			</div>
            
            
            <div class="findinfo">
            	<a href="id_check">아이디 찾기</a>
                <a href="pwd_check">비밀번호 찾기</a>
                <a href="sign_up">회원 가입</a>
            </div>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
          </form>
        </div>


      </div>
  </div>

  

  <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
  <jsp:include page="../Main/footer.jsp" />
  <script>
    
    function onClickGooglelogin() {
 	    document.querySelector('[aria-labelledby="button-label"]').click();
 	  }
	
    function handleCredentialResponse(response) {
      console.log("Encoded JWT ID token: " + response.credential);
      
      const responsePayload = decodeJwtResponse(response.credential);

      console.log("ID: " + responsePayload.sub);
      console.log('Full Name: ' + responsePayload.name);
      console.log('Given Name: ' + responsePayload.given_name);
      console.log('Family Name: ' + responsePayload.family_name);
      console.log("Image URL: " + responsePayload.picture);
      console.log("Email: " + responsePayload.email);
      
      let token = $("meta[name='_csrf']").attr("content");
  	  let header = $("meta[name='_csrf_header']").attr("content");
      
      $.ajax({
			type : "POST",
			url : "loginGoogle",
			data : {"id" : responsePayload.sub,
					"name" : responsePayload.name,
					"email" : responsePayload.email
			},
			beforeSend : function(xhr)
	        {   
	        	xhr.setRequestHeader(header, token);			
	        },
			success: function(data){
				console.log(data)
				if(data == "YES"){
					console.log("로그인")
					$("#GoogleLoginEmail").val(responsePayload.email);
					$("#GoogleLoginId").val(responsePayload.sub);
					$("#GoogleLogin").submit();
					
				}else if(data == "register"){
					console.log("가입")
					$("#GoogleEmail").val(responsePayload.email);
					$("#GoogleId").val(responsePayload.sub);
					$("#GoogleName").val(responsePayload.name);
					$("#GoogleForm").submit();
				}
			},
			error: function(data){
				alert("로그인에 실패했습니다")
			}
		}); //ajax end
      
    }
    
    function decodeJwtResponse(token) {
        var base64Url = token.split(".")[1];
        var base64 = base64Url.replace(/-/g, "+").replace(/_/g, "/");
        var jsonPayload = decodeURIComponent(
          atob(base64)
            .split("")
            .map(function (c) {
              return "%" + ("00" + c.charCodeAt(0).toString(16)).slice(-2);
            })
            .join("")
        );

        return JSON.parse(jsonPayload);
      }
    
    window.onload = function () {
      google.accounts.id.initialize({
        client_id: "197091871700-c8bvdtnt6l0ms7nq0bjgb87rrii413up.apps.googleusercontent.com",
        callback: handleCredentialResponse,
        context: "signup"
      });
      google.accounts.id.renderButton(
        document.getElementById("buttonDiv"),
        { theme: "outline", size: "large", type: "standard", text: "signup_with", width: "333px" }  // customization attributes
      );
      //google.accounts.id.prompt(); 
      
      document.getElementById("loginButton").click();
    	
    }
  </script>
 </body>
</html>