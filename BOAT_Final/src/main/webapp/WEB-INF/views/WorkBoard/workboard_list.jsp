<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>워크보드 게시판</title>

	<jsp:include page="../Main/header.jsp"/>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.3.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<script src="${pageContext.request.contextPath}/resources/Kimsj/js/workboard.js"></script>		
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
	
	<style>
		.pl{
		    width: 200px;
		    border: 1px solid #C4C4C4;
		    box-sizing: border-box;
		    border-radius: 10px;
		    padding: 12px 13px;
		    font-family: 'Roboto';
		    font-style: normal;
		    font-weight: 400;
		    font-size: 14px;
		    line-height: 16px;
		}
		
		.pl:focus{
		    border: 1px solid #9fdaff;
		    box-sizing: border-box;
		    border-radius: 10px;
		    outline: 3px solid #d2eeff;
		    border-radius: 10px;
		}
		.navbar .navbar-nav .nav-link {
		    color: #FFFFFF;
		}
		
		.exclude>:not(caption)>:* {
		 padding: 0.5rem 0.5rem;
		 box-shadow: inset 0 0 0 9999px var(--bs-table-accent-bg);
		}
		
		
		#message {
		    text-align: center;
		    font-size: 25px;
		    width: 800px;
		    margin-left: 100px;
		    background-color: #ededed;
		}
	</style>
	
	
	
	
</head>
<body>
<input type="hidden" id="login_id" value="${EMPNO}" name="loginid"> <%-- view.js에서 사용하기 위해 추가합니다. --%>
<input type="hidden" id="login_name" value="${NAME}" name="loginname">
<input type="hidden" id="login_dept" value="${DEPT}" name="logindept">
<input type="hidden" id="login_img" value="${pageContext.request.contextPath}/resources/${PROFILE_FILE}" name="loginimg">
	
	<div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-4 text-white animated slideInDown mb-3">워크보드</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                	<li class="breadcrumb-item active"><a href="javascript:go(1,'전체보기')">전체보기</a></li>
                	<li class="breadcrumb-item"><a class="text-white" href="javascript:go(1,'자유')">자유</a></li>
                	<li class="breadcrumb-item"><a class="text-white" href="javascript:go(1,'홍보팀')">홍보팀</a></li>
                    <li class="breadcrumb-item"><a class="text-white" href="javascript:go(1,'개발팀')">개발팀</a></li>
                    <li class="breadcrumb-item"><a class="text-white" href="javascript:go(1,'인사팀')">인사팀</a></li>
                    <li class="breadcrumb-item"><a class="text-white" href="javascript:go(1,'기획팀')">기획팀</a></li>
                    <li class="breadcrumb-item"><a class="text-white" href="javascript:go(1,'영업팀')">영업팀</a></li>
                	<li class="breadcrumb-item"><a class="text-white" href="javascript:go(1,'동호회')">동호회</a></li>
                	<li class="breadcrumb-item"><a class="text-white" href="javascript:go(1,'취미')">취미</a></li>
                </ol>
            </nav>
        </div>
    </div>
	
	<div class="container" style="margin-top:150px !important;">


				
				<div id="workboard_view" style="width: 1000px; margin: auto;">

					<h3>워크보드 게시판</h3>
					

										
					<div class="table-responsive  mt-4">
						<table class="table">	
							<tbody>
								<tr>					
									<th style="width:120px;">카테고리</th>
									<td>
										<select name="category" id="category" class="pl">
								            <option value="선택해주세요" selected>선택해주세요</option>
								            <option value="자유">자유</option>
								            <option value="홍보팀">홍보팀</option>
								            <option value="개발팀">개발팀</option>
								            <option value="인사팀">인사팀</option>
								            <option value="기획팀">기획팀</option>
								            <option value="영업팀">영업팀</option>
								            <option value="동호회">동호회</option>								            
								            <option value="취미">취미</option>
								        </select>
									</td>
								</tr>
								<tr>
									<th>제목</th>
									<td>
										<input name="SUBJECT" id="subject" type="text" maxlength="100"
				    	   					class="form-control" placeholder="제목을 입력해주세요">			
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
										<textarea name="CONTENT" id="content" 
				    		 				cols="67" rows="5" class="form-control" placeholder="내용을 입력해주세요"></textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<button id="write"  class="btn btn-info float-right" style="background-color:#1ca7ff; border-color:#1ca7ff; color:white;">등록</button>
				  						<button id="cancel" type=reset class="btn btn-danger">취소</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
		
			
						
						
					<div id="workboard_card">
						<table class="table table-striped">	
							<tbody>	
							
							</tbody>
						</table>
					</div>
					<br>
					
					<div id="message"></div>
					
			
				</div> <%-- workboard_card end --%>			
			

	</div>  <%-- container end --%>

	<input type="hidden" class="worknum" value="${param.num}">

	<script>
		 
	</script>
<jsp:include page="../Main/footer.jsp"/>
	
</body>
</html>