<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
 <head>
 	<title>BOAT - 회원가입</title>
 	<jsp:include page="../Main/headertag.jsp"/>
 	<link href="${pageContext.request.contextPath}/resources/ejyang/css/joinForm.css" type="text/css" rel="stylesheet">
 	<script src="http://code.jquery.com/jquery-latest.js"></script>
 	<script src="${pageContext.request.contextPath}/resources/ejyang/js/joinForm.js"></script>
 	
 	<meta name="_csrf" content="${_csrf.token }">
  	<meta name="_csrf_header" content="${_csrf.headerName }">
 	
    <style>
		@font-face {
		    font-family: 'Pretendard-Regular';
		    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
		    font-weight: 400;
		    font-style: normal;
		}
		
		/*보트 로고*/
		@font-face {
		    font-family: 'BMJUA';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMJUA.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
		.text-primary{
			 font-family:'BMJUA';
			 http://localhost:9700/boat/index
		}
		/*전체 폰트*/
		@font-face {
		     font-family: 'S-CoreDream-3Light';
		     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-3Light.woff') format('woff');
		     font-weight: normal;
		     font-style: normal;
		}
		*{
			 font-family: 'S-CoreDream-3Light';
		}
		
		/*전체 폰트*/
		.flex-shrink-0{font-family : 'Pretendard-Regular';}
 </style>
 </head>
 <body>
 
 <!-- 로고 -->
 <a href="/boat/index" class="navbar-brand p-0">
 	<h1 class="text-center fw-bold text-primary m-0"><i class="bi bi-tsunami"></i>BOAT</h1>
 </a>
                
  
  <div id="w-contents" class="container join_2022_wrap">
    <form class="join_2022_box" name="joinform2" action="userGoogleRegisterPro" method="post" enctype="multipart/form-data" name="boardform">
        <input type="hidden" id="id" name="id" value="${id}"> 
        <h2 class="page_title fw-bold">회원가입</h2>
        <div class="login_info_wrap">
            <h3 class="sub_title fs-5 text fw-bold">로그인 정보</h3>
            
            
            <!-- 사진 -->
            <div class="profile">
            	<label for="upfile" class="bF7skra2CCu8uPGJJ3Jw pe-auto" style="background-image: url(${pageContext.request.contextPath}/resources/img/ano.png); background-size: cover; cursor:pointer;">
            		<img alt="profile" class="bF7skra2CCu8uPGJJ3Jw" style="display:none; cursor:pointer;">	
		 	  	  	<svg width="36" height="36" fill="none" class="g68VV5Ghc0ymGpbFWhEx">
				          	<circle cx="18" cy="18" r="18" fill="#000"></circle>
				          	<path d="M11.375 22.658v2.969h2.969l8.756-8.756-2.97-2.969-8.755 8.756zm14.02-8.083a.788.788 0 000-1.116l-1.852-1.852a.788.788 0 00-1.116 0l-1.45 1.448 2.97 2.97 1.448-1.45z" fill="#fff"></path>
			           </svg>
		 	  	</label>
	            <input type="file" name="uploadfile" id="upfile" accept="image/.jpg, .jpeg, .png, .gif" hidden="">
            </div>
            <div class="body col-sm-12 col-md-12 text-center mb-2">
				<button type="button" id="profilebtn" class="btn btn-outline-primary w-25" onclick="onClickUpload();">프로필사진 등록</button>
	        </div>
            <div id="validationServerUsernameFeedback7" class="invalid-feedback fw-bold ps-0 text-center">
				프로필 사진을 등록해 주세요
			</div>
            
            <!-- 입력 -->
            <!-- 부서명 -->
            <div class="row row-container align-items-center mt-3">
                <div class="head col-sm-12 col-md-3 fw-bold">부서명</div>
                
                <div class="body col-sm-12 col-md-9">
	                <select class="col-sm-12 col-md-9 form-select" aria-label="Default select example" name="DEPT">
					  <option selected>부서명을 선택해 주세요</option>
					  <option value="홍보팀">홍보팀</option>
					  <option value="개발팀">개발팀</option>
					  <option value="인사팀">인사팀</option>
					  <option value="기획팀">기획팀</option>
					  <option value="영업팀">영업팀</option>
					</select>
                </div>
                <div id="validationServerUsernameFeedback" class="invalid-feedback fw-bold">
			        부서명을 선택해 주세요
			    </div>
            </div>
            
            <!-- 사원번호 -->
            <div class="row row-container align-items-center">
                <div class="head col-sm-12 col-md-3 fw-bold">사원번호</div>
                <div class="body col-sm-12 col-md-9">
                    <input type="text" name="EMPNO" placeholder="부서명을 선택하면 사원번호가 자동 생성됩니다" class="input-empno _input" id="_label-id" readOnly>
                </div>
                <div id="validationServerUsernameFeedback2" class="invalid-feedback fw-bold">
			        부서명을 선택해 주세요
			    </div>
            </div>
            
            <!-- 비번 -->
            <div class="row row-container align-items-center">
                <div class="head col-sm-12 col-md-3 fw-bold">비밀번호
                </div>
                <div class="body col-sm-12 col-md-9">
                    <input type="password" name="PASSWORD" class="_input" autocomplete="off" placeholder="6~16자 / 문자, 숫자, 특수 문자 모두 혼용 가능"
                    	    id="_label-pwd" maxlength="16">
                	<i class= "fa fa-solid fa-eye-slash" ></i>
                </div>
                <div id="validationServerUsernameFeedback3" class="invalid-feedback fw-bold">
			        영문, 숫자, 특수 문자 6~16자리로 입력해 주세요
			    </div>
            </div>
            
            <!-- 비번확인 -->
            <div class="row row-container align-items-center">
                <div class="head col-sm-12 col-md-3 fw-bold">비밀번호 확인</div>
                <div class="body col-sm-12 col-md-9">
                    <input type="password" name="user_pwd2" autocomplete="off" placeholder="비밀번호를 다시 입력해 주세요" 
                    	   id="_label-pwd-ck" class="_input" maxlength="16">
                	<i class= "fa fa-solid fa-eye-slash" ></i>
                </div>
                <div id="validationServerUsernameFeedback4" class="invalid-feedback fw-bold">
			        비밀번호와 동일하게 입력해 주세요
			    </div>
            </div>
            
            <!-- 이름 -->
            <div class="row row-container align-items-center">
                <div class="head col-sm-12 col-md-3 fw-bold">이름</div>
                <div class="body col-sm-12 col-md-9">
                    <input type="text" name="NAME" placeholder="이름을 입력해 주세요" class="input-id _input" id="_label-name"
                    		value="${name}">
                </div>
                <div id="validationServerUsernameFeedback5" class="invalid-feedback fw-bold">
			        이름을 입력해 주세요
			    </div>
            </div>
            
            <!-- 메일 -->
	            <div class="row row-container align-items-center">
	                <div class="head col-sm-12 col-md-3 fw-bold">메일</div>
	                <div class="body col-sm-12 col-md-7">
	                    <input type="email" name="EMAIL" placeholder="이메일을 입력해주세요" class="_input" id="email" value="${email}" readonly>
	                </div>
	                <div id="validationServerUsernameFeedback6" class="invalid-feedback fw-bold">
				        올바른 이메일을 입력해주세요
				    </div>
				    <div class="body col-sm-12 col-md-2">
				    		<button type="button" id="email_auth_btn" class="emailbtn btn btn-outline-primary w-100">인증</button>
	                </div>
	            </div>
            
            	<!-- 메일 인증 -->
	            <div class="row row-container align-items-center">
	                <div class="head col-sm-12 col-md-3 fw-bold"></div>
	                <div class="body col-sm-12 col-md-9">
	                	<input type="text" placeholder="인증번호를 입력해주세요" name="authCode" id="email_auth_key" 
	                			class="w-100 rounded form-control" value="" style="height:55px;" disabled>
	                </div>
	                <div id="validationServerUsernameFeedback8" class="invalid-feedback fw-bold">
				        인증인증번호가 요청되었습니다
				    </div>
	                <div id="validationServerUsernameFeedback9" class="invalid-feedback fw-bold">
				        메일 발송에 실패했습니다. 재시도 해주시기 바랍니다
				    </div>
	            </div>
            
            
       


        <!-- 가입 약관 동의 -->
        <div class="policy_agree_wrap">
            <h3 class="sub_title fs-5 text mb-4 fw-bold">가입 약관 동의</h3>
            <div class="row row-container align-items-center">
                <div class="col-sm-12">
                    <label class="checkbox_wrap mb-2 fw-bold" for="agree_all">
	                    <input id="agree_all" class="_checkbox" type="checkbox">
                        모든 약관에 동의합니다.
                    </label>
                </div>
            </div>
            <div class="row row-container align-items-center">
                <div class="head col-sm-12 col-md-10">
                    <label class="checkbox_wrap mb-2">
                    	<input id="agree_chk" class="_checkbox" type="checkbox" >
                        BOAT&nbsp; <a href="" data-bs-toggle="modal" data-bs-target="#Modal">이용 약관</a>   에 동의합니다.<span class="essential">(필수)</span>                    
                    </label>
                </div>
            </div>
            <div class="row row-container align-items-center">
                <div class="head col-sm-12 col-md-10">
                    <label class="checkbox_wrap mb-2">
                    	<input id="agree_chk2" class="_checkbox" type="checkbox" >
                    	<a href="" data-bs-toggle="modal" data-bs-target="#Modal2">개인정보 수집 및 이용에 동의합니다.</a>
                        <span class="essential">(필수)</span>
                    </label>
                </div>
            </div>
            
            <div id="marketingAgreeToggleLine" style="width: 100%; height: 1px; background-color: #e4e4e4; margin-top: 10px;">
                </div>
            
            <div class="w-list dot no_child mb-5">
                <li>14세 미만은 회원 가입이 제한됩니다.</li>
            </div>
        </div>
        <!--  -->

        <div id="form-controls">
        	<button type="submit"  class="submit btn-primary btn py-3 px-5 w-100 fw-bold fs-5 text" disabled>가입하기</button>
        </div>
        
        </div>
        
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>
        
		
		<!-- 이용약관 -->
		<div class="modal fade" id="Modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">BOAT 개인정보 수집∙이용 동의</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		      	<h6><strong>제1장 총칙</strong></h6>
	        	<p><br></p>
	        	<p><strong>제1조 [목적]</strong></p>
	        	<p>이 약관은 (주)3-works(이하 “회사”)이 운영하는 사이트에서 제공하는 “서비스”의 이용과 관련하여 “회사”와 “개인회원”간의 이용조건, 제반 절차, 회원의 권리, 의무 및 책임 사항, 기타 필요한 사항을 규정함을 목적으로 한다.<br>
				<br></p>
				<p><strong>제2조 [정의]</strong></p>
				<p>본 약관에서 사용하는 용어의 정의는 다음과 같다.</p>
				<p>① “사이트”라 함은 “회사”가 “개인회원”에게 서비스를 제공하기 위해 단말기(PC, TV, 휴대형 단말기 등의 각종 유무선 장치를 포함) 등 정보 통신 설비를 이용하여 재화 또는 용역을 거래할 수 있도록 설정한 가상의 영업장을 말하며, “회사”가 운영하는  웹사이트인 boat.co.kr 등이 이에 포함된다.</p>
				<p>② “서비스”라 함은 “회사”의 “사이트”에서 “개인회원”에게 유∙무료로 제공하는 모든 서비스를 일컫는다. 개인정보 및 근태정보 서비스, 내가 작성한 글 조회 서비스, 개인일정을 등록하고 진행도를 확인하는 서비스, 사원들의 주소 정보 서비스, 실시간 채팅 콘텐츠, 개인이 등록한 자료를 관리하여 기업 정보를 제공하는 서비스, 게시판을 운영하고 관리하는 서비스 및 모든 부대 서비스를 의미한다.</p>
				<p>③ “개인회원”이라 함은 “서비스”를 이용하기 위하여 동 약관에 동의하거나, 페이스북 등 연동된 서비스를 통해 “회사”와 이용 계약을 체결한 개인 회원을 말한다.</p>
				<p>④ “ID”라 함은 “개인회원”의 식별과 “개인회원”의 “서비스” 이용을 위하여 가입 시 사용한 이메일 주소를 말한다.</p>
				<p>⑤ “비밀번호”라 함은 “회사”의 "서비스"를 이용하려는 “개인회원”이 이용자 ID를 부여받은 자와 동일인임을 확인하고 회원의 권익을 보호하기 위하여 회원이 선정한 문자와 숫자의 조합을 말한다.<br>
				<br></p>
		      </div>
		    </div>
		  </div>
		</div>
        
        
        
		<!-- 개인정보 수집 -->
		<div class="modal fade" id="Modal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">BOAT 개인정보 수집∙이용 동의</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <p class=""> 주식회사 그렙은 프로그래머스 서비스를 이용하는 귀하의 개인정보를 아래와 같이 수집∙이용합니다.<br> 자세한 내용은 프로그래머스 개인정보 처리방침에서 확인하실 수 있습니다. </p>
	        	<div class="fw-bold">1. 수집하는 개인정보 항목 및 이용 목적</div>
	        	<table class="table table-border">
	        	<tr><th>수집 방법</th><th>수집 항목</th><th>수집 및 이용목적</th></tr><tr><td>회원가입</td><td>[필수] 성명,이메일(아이디),비밀번호,중복가입확인정보(DI) [선택] 성별,휴대폰 번호, 한 줄 소개, 홈페이지, 활동 지역,페이스북 등 외부 서비스와의 연동을 위해 이용자가 설정한 계정 정보</td><td>이용자 식별 및 본인확인, 회원가입 의사의 확인</td></tr><tr><td>교육서비스 이용</td><td>[필수] 성명,이메일,전화번호 [선택] 취업상태,Github 등 블로그/웹사이트 주소, 경력사항</td><td>교육서비스 운영 목적</td></tr><tr><td>채용서비스 이용</td><td>[필수] 성명,이메일,전화번호 [선택] Github 저장소, 블로그/웹사이트 주소, 희망 연봉, 간단 소개,업무 경험(회사 이름, 직무, 업무 시작일, 사용 스택, 상세 업무 및 성과),학력사항(학력,전공,학위,입학/졸업 일,학점),개인 프로젝트(프로젝트명,제작 연도, 설명, 팀, 사용 스택, 상세 업무 및 성과, 오픈 여부, 저장소),수상/자격증(수상/취득 내용, 수상/취득 년월), 출판/논문/특허(출판/논문/특허명, 고유번호,출판사,저자,발행 연월),활동(활동명,시작일),외국어(시험명,점수)</td><td>이력서 등록을 통한 입사지원 등 취업활동 서비스 제공, 각종 맞춤형 취업서비스 제공</td></tr><tr><td>서비스 이용 과정 또는 처리 과정에서 생성되는 정보</td><td>서비스 이용기록,쿠키,방문 기록, 불량 이용 기록, 접속 로그, 접속IP정보</td><td>이상행위 탐지 및 서비스 개선을 위한 분석, 서비스 이용 기록과 접속 빈도 분석</td></tr></table>
	        	<div>2. 개인정보 보유 및 이용기간</div><p> 회사는 이용자의 개인정보를 고지 및 동의 받은 사항에 따라 수집∙이용 목적이 달성되기 전 또는 이용자의 탈퇴 시까지 해당 정보를 보유합니다. 다만, 타 법령에 따라 법령에서 규정한 기간동안 개인정보를 보관할 필요가 있는 경우 외부와 차단된 별도 DB 또는 테이블에 분리 보관 됩니다. </p>
	        	<div>3. 개인정보 수집 및 이용 동의를 거부할 권리</div><p> 귀하는 위 정보에 대한 수집∙이용 동의를 거부할 수 있는 권리가 있으나, 이에 동의하지 않을 경우 프로그래머스 서비스 이용에 제한될 수 있습니다. </p>
		      </div>
		    </div>
		  </div>
		</div>
        
  </div>

  <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
  <script type="text/JavaScript" src="./my-script.js"></script>
  <jsp:include page="../Main/footer.jsp" />
  <script>
  	$(document).ready(function(){
	  var valid_name = true;
  	});
  </script>
 </body>
</html>