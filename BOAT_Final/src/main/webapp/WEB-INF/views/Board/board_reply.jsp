<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>

<title>업무 게시판 - write</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/jkKim/css/writeform.css">

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">



<!-- 임시 css링크 -->

</head>
<body>
	<jsp:include page="../Main/header.jsp" />

	<!-- Page Header Start -->
	<div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
		<div class="container text-center py-5">
			<h1 class="display-4 text-white animated slideInDown mb-3">업무게시판</h1>
			<nav aria-label="breadcrumb animated slideInDown">
				<ol class="breadcrumb justify-content-center mb-0">
					
				</ol>
			</nav>
		</div>
	</div>
	<!-- Page Header End -->



<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal" var="pinfo"/>


	<div class="container mt-5">
		<form action = "${pageContext.request.contextPath}/board/replyAction" method="post" enctype="multipart/form-data" name="boardform" id="boardform">
		<input type="hidden" name="BOARD_RE_REF" value="${boarddata.BOARD_RE_REF }">
   		<input type="hidden" name="BOARD_RE_LEV" value="${boarddata.BOARD_RE_LEV }">	
   		<input type="hidden" name="BOARD_RE_SEQ" value="${boarddata.BOARD_RE_SEQ }">
		<h2 class="text-center">업무 게시판</h2>
		 
			<div class="form-group">
				<label for="board_subject">제목</label>
				 <input	name="BOARD_SUBJECT" id="board_subject"  maxlength="50" class="form-control"  placeholder="제목">
			</div>
			<input type ="hidden" name ="BOARD_EMPNO" value="${EMPNO}">
			
			
			<div class="form-group row">
				<label for="board_dept" class="col-sm-2 col-form-label">부서
				<input type="text" class="form-control" id="board_dept" name="BOARD_DEPT" value="${DEPT}" readonly/>
				</label> 
			
			
			
				<label for="board_job" class="col-sm-2 col-form-label">직책 
				<input type="text" class="form-control" id="board_job" name="BOARD_JOB" value="${JOB}" readonly>
				</label>
			
			
			
				 <label for="board_name" class="col-sm-2 col-form-label">이름
				 <input	type="text" class="form-control" id="board_name" name="BOARD_NAME" value="${NAME}" readonly>
				 </label>
			
				<label for="board_password" class="col-sm-5 col-form-label">비밀번호
				 <input	type="password" class="form-control" id="board_pass" name="BOARD_PASS">
				 </label>
				 
				
				 
			</div>
			
			<div class="form-group content">
			<label for="board_content" class="form-label">내용</label>
			<textarea class="form-control board_content" id="summernote" name="BOARD_CONTENT" ></textarea>
			</div>
			
			
			
			
			<div class="form-group btn-group2">
			<button type="submit" class="btn btn-primary">등록</button>
			<button type="reset" class="btn btn-danger" onclick="history.go(-1)">취소</button>
			    		
    		
			</div>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</form>
	</div>
 </sec:authorize>
	<!-- Bootstrap JavaScript -->
	
	<jsp:include page="../Main/footer.jsp" />	



<script src = "${pageContext.request.contextPath}/jkKim/js/writeform.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
</body>
</html>