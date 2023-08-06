<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
 <head>
 	<title>BOAT - 회원가입</title>
 	<link href="${pageContext.request.contextPath}/resources/ejyang/css/signup.css" type="text/css" rel="stylesheet">
 	<script src="http://code.jquery.com/jquery-latest.js"></script>
 	<script src="${pageContext.request.contextPath}/resources/ejyang/js/signup.js"></script>
 	<script src="https://accounts.google.com/gsi/client" async defer></script>
 	<jsp:include page="../Main/header.jsp" />
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
            client_id: "",
            callback: handleCredentialResponse,
            context: "signup"
          });
          google.accounts.id.renderButton(
            document.getElementById("buttonDiv"),
            { theme: "outline", size: "large", type: "standard", text: "signup_with", width: "333px" }  // customization attributes
          );
          //google.accounts.id.prompt(); 
        }
    </script>
 </head>
 <body>
 
 <!-- 로고 -->
 <a href="/boat/index" class="navbar-brand m-0 p-0">
 	<h1 class="bodylogo fw-bold text-primary m-0 text-center"><i class="bi bi-tsunami"></i>BOAT</h1>
 </a>
                
                
                
  <div id="form-container">
      <div id="form-inner-container">
        <!-- Sign up form -->
        <div id="sign-up-container">
          <h3>환영합니다!</h3>
          <h4>원하시는 회원가입 방법을 선택해주세요.</h4>
          <form name="sign_up" action="${pageContext.request.contextPath}/member/join" method="GET">
            <label for="email" >이메일</label>
            <input type="email" class="form-control" name="email" id="email" placeholder="이메일을 입력해주세요">
            <div id="user_mail" style="display:none">
		      올바른 이메일을 입력해주세요.
		    </div>

             
            <div id="form-controls">
              <button type="submit"  class="btn btn-primary py-3 px-5" disabled>이메일로 계속하기</button>
            </div>
            
          </form>
            
           	<div class="text-center other"> 또는 </div>
            
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
			<div class="form-group d-grid gap-2 col-10 mx-auto mb-3" style="cursor: pointer">
				<div id="buttonDiv" aria-hidden="true"
				      id="google-login-api"
				      ref="onClickGooglelogin"
				      style="display: none"></div> 
				<a class="btn-google btn-block text-center border" onClick="onClickGooglelogin()"> 구글 계정으로 회원가입 </a>
			</div>
			
	            <div class="form-group d-grid gap-2 col-10 mx-auto">
					<a href="${naverUrl}" class="btn-naver btn-block text-center"> 네이버 계정으로 회원가입</a>
				</div>
			
			
			
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        </div>


      </div>
  </div>

  <script type="text/JavaScript" src="./my-script.js"></script>
  <jsp:include page="../Main/footer.jsp" />
  
 </body>
</html>