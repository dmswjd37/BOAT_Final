<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
 <head>
 	<title>BOAT - 아이디 찾기</title>
 	<link href="${pageContext.request.contextPath}/resources/ejyang/css/idlist.css" type="text/css" rel="stylesheet">
 	<script src="http://code.jquery.com/jquery-latest.js"></script>
 	<jsp:include page="../Main/header.jsp" />
 	<script>
 		$(document).ready(function() {
 			var smallestInput = $('.find-userinfo__list input[type="checkbox"]').sort(function(a, b) {
 	            return a.id - b.id;
 	        }).first();

 	        smallestInput.prop('checked', true);

 	        $('.find-userinfo__list input[type="checkbox"]').change(function() {
 	            if ($(this).is(':checked')) {
 	                $('.find-userinfo__list input[type="checkbox"]').not(this).prop('checked', false);
 	            } else {
 	                // Prevent unchecking of currently checked input
 	                if ($('.find-userinfo__list input[type="checkbox"]:checked').length === 0) {
 	                    $(this).prop('checked', true);
 	                }
 	            }
 	        });
 	        
 		});
 		
 		function onClicklogin() {
 			$("#idlogin").submit();
 		}
 	</script>
 </head>
 <body>
   <div id="form-container">
      <div id="form-inner-container">
        <!-- Sign up form -->
        <div id="sign-up-container">
          <h3>아이디 받기</h3>
          <form action="id_login" method="get" id="idlogin">
            <div class="idpw_userinfo">

            	<!-- <span class="sub_title"></span> -->
            	<div class="find-userinfo">
            	
            	  <c:set var="num" value="1"/>
            	  <c:forEach var="b" items="${idlist}">
	            	<c:if test="${b.NAVERLOGIN == null && b.GOOGLELOGIN == null}">
	            	  
	                	<div class="find-userinfo__item id_list">
	                        <div class="find-userinfo__list id_list position-relative">
			                    <input id="${num}" class="terms position-absolute" type="checkbox" 
			                    		name="userid" value="${b.EMPNO}">
		                        <label for="${num}" class="fw-bold">${b.EMPNO}</label>
	                    	</div>
	                    </div>
	                    
	              	</c:if>    
                  <c:set var="num" value="${num+1}"/> 
                  </c:forEach>
                  
                </div>
                

	            <div class="brick-idpw_2022__findinfo">
	                <a href="#" onClick="onClicklogin()">로그인하기</a>
	                <a href="pwd_check">비밀번호를 찾으시나요?</a>
	            </div>
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