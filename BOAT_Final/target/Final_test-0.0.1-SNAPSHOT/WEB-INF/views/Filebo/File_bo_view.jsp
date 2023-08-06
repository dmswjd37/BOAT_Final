<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../Main/header.jsp" />

<%--
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script> --%>

<script
	src="${pageContext.request.contextPath}/resources/jhLee/js/fileview.js"></script>
<title>자료실 게시판</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/jhLee/css/fileview.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/jhLee/css/fileview2.css">
<%--댓글 --%>

<style>
#board_pass {
	margin: 10px auto;
}
</style>
<script>
let result = "${result}";
if(result =='passFail'){
		toastr.options.escapeHtml = true;
		toastr.options.closeButton = true;
		toastr.options.newestOnTop = false;
		toastr.options.progressBar = true;
		toastr.info('비밀번호를 확인해주세요', '자료실게시판', {timeOut: 1500});
						}
$(function(){
	$("form[action=delete]").submit(function(){
		if($("#board_pass").val()==''){
		$("board_pass").focus();
		return false;}
	})
	
	})



</script>

</head>
<body>
	<input type="hidden" id="loginid" value="${empno }" name="loginid">
	<%--view.js에서 사용하기 위해 추가합니다. --%>
	<%-- <input type="hidden" id ="loginid" value ="${id}" name="loginid"><%--view.js에서 사용하기 위해 추가합니다. --%>
	<div class="board_wrap">
		<div class="board_title">
			<strong><a
				href="${pageContext.request.contextPath}/Filebo/list" target="_self">자료실
					게시판</a></strong>
			<p>자료실 게시판 입니다.</p>


		</div>
		<div class="board_view_wrap">
			<div class="board_view">
				<div class="title">
					<c:out value="${boarddata.FILE_SUBJECT}" />
					<%--제목 --%>
				</div>
				<div class="info">

					<dl>
						<dt>부서명</dt>
						<dt>${boarddata.DEPT}</dt>

					</dl>
					<dl>
						<dt>글쓴이</dt>
						<dt>${boarddata.FILE_NAME}</dt>

					</dl>
					<dl>
						<dt>작성일</dt>
						<dt>${boarddata.FILE_DATE.substring(0,10)}</dt>

					</dl>
					<dl>
						<dt>조회</dt>
						<dt>${boarddata.FILE_READCOUNT}</dt>

					</dl>
				</div>

				<div class="content">
					<c:out value=" ${boarddata.FILE_CONTENT}" escapeXml="false" />
				</div>

			</div>

			<!-- css필요 -->
			<%--  <c:if test="${boarddata.FILE_RE_LEV==0}">
		   원문글인 경우에만 첨부파일을 추가 할 수 있습니다. --%>
			<div class="filedown">
				첨부파일 <br> <br>



				<%--파일을 첨부한 경우 --%>

				<c:if test="${!empty boarddata.FILE_FILE}">
					<dl>
						<dt>
							<img alt="파일다운"
								src="${pageContext.request.contextPath}/resources/jhLee/img/download.png"
								width="20px"> &nbsp;&nbsp;
							<form method="post" action="down" style="height: 0px">
								<input type="hidden" value="${boarddata.FILE_FILE}"
									name="filename"> <input type="hidden"
									value="${boarddata.FILE_ORIGINAL}" name="original"> <input
									type="submit" value="${boarddata.FILE_ORIGINAL}"
									style="border: none; background-color: rgb(238, 247, 250);">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}">
							</form>
						</dt>
					</dl>
				</c:if>
				<c:if test="${!empty boarddata.FILE_FILE2}">
					<dl>
						<dt>
							<img alt="파일다운2"
								src="${pageContext.request.contextPath}/resources/jhLee/img/download.png"
								width="20px"> &nbsp;&nbsp;
							<form method="post" action="down2" style="height: 0px">
								<input type="hidden" value="${boarddata.FILE_FILE2}"
									name="filename2"> <input type="hidden"
									value="${boarddata.FILE_ORIGINAL2}" name="original2"> <input
									type="submit" value="${boarddata.FILE_ORIGINAL2}"
									style="border: none; background-color: rgb(238, 247, 250);">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}">
							</form>
					</dl>
				</c:if>

				<%--파일을 첨부한 경우 --%>

				<c:if test="${empty boarddata.FILE_FILE && boarddata.FILE_FILE2}">

					<dl>
						<dt></dt>
						<dt></dt>
					</dl>
				</c:if>
			</div>
			<%--div class filedown끝 --%>
			<%-- </c:if>--%>


			<div class="bt_wrap">


				<a href="list" class="on">목록</a>


				<%--           <a href ="reply">답변</a> 
            
<a href ="replyView?num=${boarddata.FILE_NUM}">답변</a>--%>
				<c:if test="${boarddata.FILE_EMPNO ==EMPNO||empno=='ADMIN'}">
					<div class="personal">
						<a href="modifyView?num=${boarddata.FILE_NUM}" class="update">
							수정 </a>
							 <a id='delete'>
							<button id="deletebtn" type="button" class="btn btn-danger"
								data-bs-toggle="modal" data-bs-target="#myModal">삭제</button>
						</a>


					</div>
				</c:if>


				<div class="next">
					<c:if test="${!empty Fileprev}">
						<a href="FileBoadDetailAction.filebo?num=${Fileprev.FILE_NUM}"><span
							class="nextbtn">&lt; 이전글&nbsp;&nbsp;</span><span id="pretitle">${Fileprev.FILE_SUBJECT}</span></a>
					</c:if>

					<c:if test="${!empty Filenext}">
						<a href="FileBoadDetailAction.filebo?num=${Filenext.FILE_NUM}"><span
							id="nexttitle">${Filenext.FILE_SUBJECT}</span><span
							class="nextbtn">&nbsp;&nbsp;다음글 &gt;</span></a>
					</c:if>

				</div>


			</div>
		</div>
		<%--"bt_wrap끝 --%>
		<%-- modal 시작 --%>

		<div class="modal fade" id="myModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">글 비밀번호 확인</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body" style="color: black;">
						<form name="deleteForm" action="delete" method="post">

							<input type="hidden" name="num" value="${param.num}"
								id="comment_board_num" style="margin: 10px auto;">

							<div class="form-group">
								<label for="pwd">비밀번호</label> <input class="form-control"
									type="password" id="board_pass" placeholder="Enter password"
									name="FILE_PASS">
							</div>

							<button type="submit" class="btn btn-primary">전송</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>

							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}">
						</form>
					</div>
				</div>
			</div>
		</div>





		<%--id="myModal"end --%>
		<div class="commcard">

			<div class="comment-area">
				<div class="comment-head">
					<h3 class="comment-count">
						댓글<sup id="count"></sup>
						<%--superscript(윗첨자) --%>
					</h3>
					<div class="comment-order">
						<ul class="comment-order-list">
						</ul>
					</div>
				</div>
				<%--comment head 끝 --%>

				<ul class="comment-list">
				</ul>
				<div class="comment-write">
					<div class="comment-write-area">
						<b class="comment-write-area-name"> ${DEPT}${NAME}${empno}</b> <span
							class="comment-write-area-count">0/200</span>
						<textarea placeholder="댓글을 남겨보세요" rows="1"
							class="comment-write-area-text form-control" maxlength="200"></textarea>
					</div>
					<div class="register-box">
						<div class="button btn-cancel">취소</div>
						<%--댓글의 취소는 display:none,등록만 보이도록 합니다. --%>
						<div class="button btn-register">등록</div>
					</div>
				</div>
				<%--comment-write end --%>

			</div>
			<%--card-body end --%>




		</div>
	</div>
	<%-- class="card bg-light">end --%>
	<%-- class="comment end --%>

	</div>











	</div>

	<jsp:include page="../Main/footer.jsp" />
</body>
</html>