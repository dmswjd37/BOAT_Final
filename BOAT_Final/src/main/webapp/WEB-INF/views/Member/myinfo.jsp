<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
 <head>
 	<script src="http://code.jquery.com/jquery-latest.js"></script>
 	<jsp:include page="../Main/header.jsp" />
 	<style>
 		.body .mail_input {
		    height: 60px;
		    width: 100%;
		    font-size: 1rem;
		    border: none;
		    outline: none;
		    border-bottom: 1px solid #009CFF;
		}
		
 		._input {
		    height: 60px;
		    width: 100%;
		    font-size: 1rem;
		    border: none;
		    outline: none;
		    border-bottom: 1px solid #cdcdcd;
		}
		
		._input:focus {
			border-color: #009CFF;
		}
		
		.profileimg {
		    position: relative;
		    width: 124px;
		    height: 124px;
		    border-radius: 50%;
		    border: 0;
		    background: none;
		    margin-bottom: 20px;
		}
		.profileimg2 {
		    position: absolute;
		    width: 124px;
		    height: 124px;
		    right: 0;
		    bottom: 0;
		    border-radius: 50%;
		}
		
		.head + .body {
			margin-bottom: 5px;
		}
		.head + .body select {
			height: 50px;
			border: none;
			border-bottom: 1px solid #cdcdcd;
			border-radius: 0px;
			padding-left: 2px;
		}
		
		.body select:focus {
			outline: none;
			border-color: #009CFF;
			box-shadow: none;
		}
		
		.body {
		    position: relative;
		}
		
		.row-container .fa-eye, .row-container .fa-eye-slash{
		    position: absolute;
		    left: 87%;
		    cursor: pointer;
		    color: rgb(184, 184, 184);
		    top: 20px;
		    font-size: 20px;
		}

		.invalid-feedback {
			padding-left: 169px;
		}
 	</style>
 	<script>
 		$(function(){
 			//부서명
 			let department = '${memberinfo.DEPT}'
 			console.log(department)
 				
 			let part = 1;
 			switch(department){
 				case '개발팀':
 					part=2;
 					break;
 				case '인사팀':
 					part=3;
 					break;
 				case '기획팀':
 					part=4;
 					break;
 				case '영업팀':
 					part=5;
 					break;
 			}
 			$('#dept-select option:nth-child('+part+')').prop('selected',true)
 			
 			//탭 클릭
 			$('.nav-tabs a').on('click', function (e) {
				e.preventDefault();
				$('.nav-tabs a').removeClass('active'); 
				$(this).addClass('active'); 
				
				var tab_info = $('.nav-tabs .active').text();
				console.log("tab_info"+tab_info)
				
				if(tab_info == '회원 정보') {
					$('#qwe').addClass('show active');
					$('#zxc').removeClass('show active')
				}else {
					$('#zxc').addClass('show active')
					$('#qwe').removeClass('show active');
				}
			})
 			
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
			
			
		    var key = '${memberinfo.PASSWORD_OG}';
		    console.log('key='+key)
		    
		    $('.passwordtext button').on('click', function() {
			    var pwdinput = $.trim($('.passwordinput').val());
			    console.log('pwdinput='+pwdinput)
		    	if(pwdinput == key){
			        $('#exampleModal').modal('show'); 
			    } else {
			        $('#exampleModal').modal('hide'); 
		    		toastr.options.escapeHtml = true;
				    toastr.options.closeButton = true;
				    toastr.options.newestOnTop = false;
				    toastr.options.progressBar = true;
				    toastr.info('비밀번호를 잘못 입력하였습니다.', '내 정보', {timeOut: 5000});
			    }
		    	
		    });
		    
 		})
 		
 		function onClickUpload() {
			let myInput = document.getElementById("upfile");
			myInput.click();
		}
 		
 		
 	</script>
 </head>
 <body>
<div class="gt-relative">
   <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-4 text-white animated slideInDown mb-3">내 정보</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                	<!-- 
                    <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
                    <li class="breadcrumb-item"><a class="text-white" href="#">Pages</a></li>
                    <li class="breadcrumb-item text-primary active" aria-current="page">Our Team</li>
                     -->
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->
    
    <div class="container">
      
      <div class="row">
        <div class="col">
         
            <ul class="nav nav-tabs">
              <li class="nav-item">
                <a href="#qwe" data-toggle="tab" class="nav-link active">회원 정보</a>
              </li>
              <li class="nav-item">
                <a href="#zxc" data-toggle="tab" class="nav-link">회원 탈퇴</a>
              </li>
             </ul> 
            <div class="tab-content">
              <div class="tab-pane fade show active" id="qwe">
              
              
              
                <!-- 내용 -->
				    <div class="container">
				      <form action="updateProcess" method="post" enctype="multipart/form-data">
				      <input type="hidden" name="EMPNO" value="${memberinfo.EMPNO}">
				      <input type="hidden" name="PROFILE_FILE" value="${memberinfo.PROFILE_FILE}">
				      <input type="hidden" name="PROFILE_IMG" value="${memberinfo.PROFILE_IMG}">
				      
					  <div class="row" style="margin-top: 30px;">
					  
					    <!-- 왼쪽 -->
					    <div class="col border-end mt-5">
					      <div class="left ps-3 pe-3">
							<div class="containers">
								<div class="gt-mb-15">
									<span class="text-dark" style="font-size:3rem;">${memberinfo.EMPNO} / ${memberinfo.JOB}</span> 
									<span class="fs-3 text-dark ms-4">${memberinfo.NAME}</span> 
								</div>
							</div> 
							
							<!----> 
							<div class="mt-5 row">
								<div class="title-area col-sm-12 col-md-3 pt-3">
									<i class="fas fa-chevron-right text-dark"></i> 
									<span class="title fs-5 text-dark">메일</span> <!----> 
								</div> 
								<div class="body col-sm-12 col-md-7 ">
					            	<input type="email" name="EMAIL" class="mail_input" id="email" value="${memberinfo.EMAIL}" 
					                    	readonly>
					            </div>
							</div> 
							
							
							<!----> 
							<div class="" style="margin-top:100px;">
								<div class="title-area">
									<i class="fas fa-chevron-right text-dark"></i> 
									<span class="title fs-5 text-dark">SNS 연동</span> <!----> 
								</div> 
								<div class="mt-3">
									<table class="table">
										<thead class="table-light">
											<tr>
												<th class="text-center">구분</th> 
												<th class="text-center">연동</th>
											</tr> 
										</thead>
										<colgroup>
											<col width="75%"><col>
										</colgroup> 
										<tbody>
											<!-- 구글 --> 
							                <tr>
							                	<td class="pb-0 pt-3 ps-3">구글
							                	  <c:if test="${memberinfo.GOOGLELOGIN == null}">
							                    		<p></p>
							                      </c:if>
							                      <c:if test="${memberinfo.GOOGLELOGIN != null}">
							                    		<p>${memberinfo.REGISTER_DATE} 연동 완료</p>
							                      </c:if>
							                    </td>
							                    <td class="text-center align-middle">
							                    	<c:if test="${memberinfo.GOOGLELOGIN == null}">
							                    		<span>비연동</span>
							                    	</c:if>
							                    	<c:if test="${memberinfo.GOOGLELOGIN != null}">
							                    		<span>연동</span>
							                    	</c:if>
							                    </td>
							                </tr>
							                
											<!-- 네이버 --> 
											<tr>
												<td class="pb-0 pt-3 ps-3">네이버
							                      <c:if test="${memberinfo.NAVERLOGIN == null}">
							                    		<p></p>
							                      </c:if>
							                      <c:if test="${memberinfo.NAVERLOGIN != null}">
							                    		<p>${memberinfo.REGISTER_DATE} 연동 완료</p>
							                      </c:if>
							                    </td> 
							                    <td class="text-center align-middle">
							                    	<c:if test="${memberinfo.NAVERLOGIN == null}">
							                    		<span>비연동</span>
							                    	</c:if>
							                    	<c:if test="${memberinfo.NAVERLOGIN != null}">
							                    		<span>연동</span>
							                    	</c:if>
							                    </td>
							                </tr> 
							                
							                
							            </tbody>
							       </table>
								</div> 
								
							</div> 
						  </div>
					    </div>
					   
					  
					    <div class="col">
					      <div class="right" style="padding-left: 60px;">
					      	<div class="mt-5">
								<div class="title-area">
									<i class="fas fa-chevron-right text-dark"></i> 
									<span class="title fs-5 text-dark">내 정보</span> <!----> 
								</div> 
								
								<!-- 사진 -->
					            <div class="profile d-flex justify-content-center">
					            	<label for="upfile" class="profileimg text-center" style="background-size: cover; cursor:pointer;">
					            		<img alt="profile" class="profileimg2" style="cursor:pointer;" src="${pageContext.request.contextPath}/resources/${memberinfo.PROFILE_FILE}">	
							 	  	</label>
						            <input type="file" name="uploadfile" id="upfile" accept="image/.jpg, .jpeg, .png, .gif" hidden="">
					            </div>
					            <div class="body col-sm-12 col-md-12 text-center mb-5">
									<button type="button" id="profilebtn" class="btn btn-outline-primary" onclick="onClickUpload();">프로필사진 수정</button>
						        </div>
					            
					            <!-- 부서명 -->
					            <div class="row row-container align-items-center">
					                <div class="head col-sm-12 col-md-3 fw-bold">부서명</div>
					                
					                <div class="body col-sm-12 col-md-8">
						                <select class="col-sm-12 col-md-9 form-select" id="dept-select" name="DEPT">
										  <option value="홍보팀">홍보팀</option>
										  <option value="개발팀">개발팀</option>
										  <option value="인사팀">인사팀</option>
										  <option value="기획팀">기획팀</option>
										  <option value="영업팀">영업팀</option>
										</select>
					                </div>
					            </div>
								
								<!-- 비번 -->
					            <div class="row row-container align-items-center">
					                <div class="head col-sm-12 col-md-3 fw-bold">비밀번호
					                </div>
					                <div class="body col-sm-12 col-md-8 ">
					                    <input type="password" name="PASSWORD" class="_input" autocomplete="off" 
					                    	placeholder="6~16자 / 문자, 숫자, 특수 문자 모두 혼용 가능" id="_label-pwd" maxlength="16"
					                    	value="${memberinfo.PASSWORD_OG}">
					                	<i class= "fa fa-solid fa-eye-slash" ></i>
					                </div>
					                <div id="validationServerUsernameFeedback3" class="invalid-feedback fw-bold">
								        영문, 숫자, 특수 문자 6~16자리로 입력해 주세요
								    </div>
					            </div>
					            
					            <!-- 비번확인 -->
					            <div class="row row-container align-items-center">
					                <div class="head col-sm-12 col-md-3 fw-bold">비밀번호 확인</div>
					                <div class="body col-sm-12 col-md-8 ">
					                    <input type="password" name="user_pwd2" autocomplete="off" 
					                    	placeholder="비밀번호를 다시 입력해 주세요" id="_label-pwd-ck" class="_input" maxlength="16">
					                	<i class= "fa fa-solid fa-eye-slash" ></i>
					                </div>
					                <div id="validationServerUsernameFeedback4" class="invalid-feedback fw-bold">
								        비밀번호와 동일하게 입력해 주세요
								    </div>
					            </div>
					            
					            <!-- 이름 -->
					            <div class="row row-container align-items-center">
					                <div class="head col-sm-12 col-md-3 fw-bold">이름</div>
					                <div class="body col-sm-12 col-md-8">
					                    <input type="text" name="NAME" placeholder="이름을 입력해 주세요" class="input-id _input" id="_label-name"
					                    		value="${memberinfo.NAME}">
					                </div>
					                <div id="validationServerUsernameFeedback5" class="invalid-feedback fw-bold">
								        이름을 입력해 주세요
								    </div>
					            </div>
								
							</div>
					      </div>
					    </div>
					    
					    <div id="form-controls" class="d-flex justify-content-center" style="margin: 70px 0 50px 0;">
					      <div class="text-center">
				        	<button type="submit" class="submit btn-primary btn py-2 px-3 fw-bold text" style="width:100px;" disabled>변경하기</button>
				        	<button type="button" class="btn-light btn py-2 px-3 fw-bold text ms-1" style="width:100px;" onclick="history.back()">취소</button>
				          </div>
				        </div>
					   
					  </div>
					  
					  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					  </form>
					</div>
					
					
					
              </div> 
              <div class="tab-pane fade" id="zxc">
			  	
			  	
			  	<!-- 내용2 -->
			    <div class="container">
			    	<div class="row justify-content-md-center d-flex align-items-center" style="margin-top: 30px; padding: 150px 130px 150px;">
					    <div class="col-sm-12 col-md-8">
						    <p class="fs-3 text-dark">비밀번호 재확인</p> 
						    <p class="fs-5 fw-normal text-dark">정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 확인합니다.</p> 
						    <div class="mt-4 row row-container ps-2 passwordtext">
						    	<input type="password" autocomplete="off" class="passwordinput form-control w-50"  
						    			style="height: 50px;"> 
							    <button type="button" class="col-2 ms-3 btn btn-outline-primary" data-bs-toggle="modal"
							    		>
							    	확인
							    </button>
						    </div> 
					    </div>
					    <div class="col-sm-12 col-md-4">
					      <img src="${pageContext.request.contextPath}/resources/img/secession.png" style="width: 260px;">
					    </div>
					</div>
				</div>
				
				<!-- Modal -->
				<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">계정 삭제</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        계정을 삭제하면 되돌릴 수 없으며, 삭제한 데이터를 복구할 수 없음을 이해했습니다.
				      </div>
				      
				        <form action="delete" method="get">
				          <input type="hidden" value="${memberinfo.EMPNO}" name="empno">
					      <div class="modal-footer">
					        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
					        <button type="submit" class="btn btn-outline-primary">회원 탈퇴</button>
					      </div>
					    </form>
					    
				    </div>
				  </div>
				</div>
			  	
			  	
              </div>
            </div>
       </div>
      </div>
    </div>





</div>

  <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
  <jsp:include page="../Main/footer.jsp" />
 </body>
</html>