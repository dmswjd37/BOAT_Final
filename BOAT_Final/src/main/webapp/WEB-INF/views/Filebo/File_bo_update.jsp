<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>


<jsp:include page="../Main/header.jsp" />
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/jhLee/css/writeform.css">
	<script src="${pageContext.request.contextPath}/resources/jhLee/js/updateform.js"></script>
	<%-- 드롭다운바 --%>
	<!-- <script src="${pageContext.request.contextPath}/resources/jhLee/js/4.0bootstrap.bundle4.0.js"></script> -->
	<%--썸머노트 --%>
 	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<style>
.file2{

	display : block;
}
</style>
</head>

<body>
<div class="container">
<form action="update" method="post" enctype = "multipart/form-data" name ="fileboardform">
 <input type="hidden" name="FILE_NUM" value="${boarddata.FILE_NUM}">
			
 	<input type="hidden" name="FILE_FILE"
			value="${boarddata.FILE_FILE}">
	<input type="hidden" name="FILE_FILE2"
				value="${boarddata.FILE_FILE2}">

 	<h1>boat_ 자료실 글수정</h1>
     
	 <div class="form-group">
        <label for="FILE_SUBJECT">제목</label>
        <input name="FILE_SUBJECT" id="FILE_SUBJECT" type="text" maxlength="100"
        class="form-control" placeholder="제목을 입력하세요"value="${boarddata.FILE_SUBJECT}">
    </div>
    <input type ="hidden" name ="EMPNO" value="${EMPNO}">
 	

 	<div class="form-group">
         <label for="FILE_PASS">비밀번호</label>
 		<input name="FILE_PASS" id="FILE_PASS" type="password" maxlength="30"
 		class="form-control" placeholder="비밀번호를 입력하세요">
    </div>

    <div class="form-group">
        <label>글쓴이</label><br>
        <div class="form-control deptwriter">
			<div class="dropdown" id="deptdrop" >
				<a class="btn btn-secondary dropdown-toggle deptsel" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
					${boarddata.DEPT}
					</a>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
				  <li><a class="dropdown-item" href="#">홍보팀</a></li>
				  <li><a class="dropdown-item" href="#">개발팀</a></li>
				  <li><a class="dropdown-item" href="#">인사팀</a></li>
				  <li><a class="dropdown-item" href="#">기획팀</a></li>
				  <li><a class="dropdown-item" href="#">영업팀</a></li>
				</ul>
			  </div>
			


			  <input name="FILE_NAME" id="FILE_NAME" type="text"  class=" writer form-control"
			  placeholder="이름을 입력하세요"  value="${boarddata.FILE_NAME}">
            <input type="hidden" name = "dept" id = "dept">
  	  </div>
        </div>
    

		<div class="form-group content">
			<label for="FILE_CONTENT">내용</label><br>
			<textarea name="FILE_CONTENT" id="summernote"  class="board_content form-control">
				${boarddata.FILE_CONTENT}

			</textarea>
		</div>
	   
    
 	<div class="form-group form-control deptwriter file1">
 		<label>
 		<img alt="파일첨부" src="${pageContext.request.contextPath}/resources/jhLee/img/file.png"> 
 		&nbsp;파일첨부 &nbsp; &nbsp; &nbsp; &nbsp;
 		<input name="uploadfile" id="upfile" type="file">
		 </label>
	 	
 		<span id ="filevalue">${boarddata.FILE_ORIGINAL}</span>
		 <img alt="파일삭제" src="${pageContext.request.contextPath}/resources/jhLee/img/remove.png" style="width:10px;" class="remove1">
	</div>
 	
	
	<div class="form-group form-control deptwriter file2">
 		<label>
 		<img alt="파일첨부2" src="${pageContext.request.contextPath}/resources/jhLee/img/file.png">
 		 &nbsp;파일첨부2 &nbsp; &nbsp; &nbsp;
 		<input name="uploadfile2" id="upfile2" type="file" >
		 </label>
	 	
 		<span id ="filevalue2">${boarddata.FILE_ORIGINAL2}</span>
		 <img alt="파일삭제" src="${pageContext.request.contextPath}/resources/jhLee/img/remove.png" style="width:10px;" class="remove2">
	</div>
 	
 	<div class="form-group btn-group2">
 		<button type="submit" class="btn btn-primary" style="background-color :  rgb(0, 173, 238)!important;border-color:rgb(0, 173, 238)!important">등록</button>
 		<button type="reset" class="btn btn-danger" onclick="history.back(-1)">취소</button>
 	</div>
	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
 </form>
</div><!-- container끝 -->

<jsp:include page="../Main/footer.jsp" />
