<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <jsp:include page="../Main/header.jsp" />
  
  <%--
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script> --%>
    
    <script src="${pageContext.request.contextPath}/resources/jkKim/js/view.js"></script>
    <title>업무 게시판</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/jhLee/css/fileview.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/jhLee/css/fileview2.css"><%--댓글 --%>
  
  <style>   
 #board_pass{ 
  margin: 10px auto;
 } 
  </style>
</head>
<body>

<input type="hidden" id ="loginid" value ="${EMPNO }" name="loginid"><%--view.js에서 사용하기 위해 추가합니다. --%>
<%-- <input type="hidden" id ="loginid" value ="${id}" name="loginid"><%--view.js에서 사용하기 위해 추가합니다. --%>
    <div class="board_wrap">
        <div class="board_title">
            <strong><a href="${pageContext.request.contextPath}/board/List" target="_self">업무 게시판</a></strong>
            <p>업무 게시판 입니다.</p>


        </div>
        <div class="board_view_wrap">
        <div class="board_view">
           <div class="title">
          <c:out value ="${boarddata.BOARD_SUBJECT}"/><%--제목 --%>
           </div>
           <div class="info">
            
            <dl>
                <dt>부서명</dt>
                <dt>${boarddata.BOARD_DEPT}</dt>

            </dl>
            <dl>
                <dt>글쓴이</dt>
                <dt>${boarddata.BOARD_NAME}</dt>

            </dl>
            <dl>
                <dt>작성일</dt>
                <dt>${boarddata.BOARD_DATE.substring(0,10)}</dt>

            </dl>
            <dl>
                <dt>조회</dt>
                <dt>${boarddata.BOARD_READCOUNT}</dt>

            </dl>
           </div>
      
           <div class="content">
           <c:out value =" ${boarddata.BOARD_CONTENT}" escapeXml="false" />
           </div>
         
        </div>
        
       
     
        <div class="bt_wrap">
        
           
            <a href="List" class="on">목록</a>
            
			  
<%--           <a href ="reply">답변</a> 
            
<a href ="replyView?num=${boarddata.FILE_NUM}">답변</a>--%>
		<c:if test="${boarddata.BOARD_EMPNO ==EMPNO||empno=='ADMIN'}">
		<div class = "personal">
			 <a href="modifyView?num=${boarddata.BOARD_NUM}" class = "update">
		         수정
			  </a>
			  <a href="replyView?num=${boarddata.BOARD_NUM }" style="color:white; background: #00C73C">
					답변
				</a>
			  <a id ='delete'>
				<button id="deletebtn" type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#myModal">
				삭제
				</button>
			</a>
		  

			</div>
		</c:if>
		
		
		<div class = "next">
		 	<c:if test="${!empty Fileprev}">
		 	<a href ="FileBoadDetailAction.filebo?num=${Fileprev.BOARD_NUM}"><span class = "nextbtn">&lt; 이전글&nbsp;&nbsp;</span><span id ="pretitle">${Fileprev.BOARD_SUBJECT}</span></a>
            </c:if>
            
		 	<c:if test="${!empty Filenext}">
            <a href ="FileBoadDetailAction.filebo?num=${Filenext.BOARD_NUM}"><span id ="nexttitle">${Filenext.BOARD_SUBJECT}</span><span class = "nextbtn">&nbsp;&nbsp;다음글 &gt;</span></a>
            </c:if>
            
		 </div>
		  
		
</div>
        </div><%--"bt_wrap끝 --%>
<%-- modal 시작 --%>

<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
	  <div class="modal-content">
		<div class="modal-header">
		  <h5 class="modal-title" id="exampleModalLabel">글 비밀번호 확인</h5>
		  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		</div>
		<div class="modal-body" style="color:black;">
			  <form name="deleteForm" action="delete" method="post">
			  	
	      <input type="hidden" name ="num" value="${param.num}" id="board_num" style="margin:10px auto;">
	  
	    <div class="form-group">
	      <label for="pwd">비밀번호</label>
	      <input class="form-control" type="password" id="board_pass" placeholder="Enter password" name="BOARD_PASS" >    </div>
		
		<button type="submit" class="btn btn-primary">전송</button>
		<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
		
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	    </form>
		  </div>
	  </div>
	</div>
  </div>


	      
	    
	
<%--id="myModal"end --%>
       <div id="comment">
			<button class="btn float-left flex-grow" style="width:93%; text-align:left;"  disabled='disabled'>총 50자까지 가능합니다.</button>
			
			<button id="write" class="btn btn-secondary float-right">등록</button>
			<textarea rows=3 class="form-control" id="content" maxLength="50"></textarea>
			<table class="table table-striped">
				<thead>
					<tr><td>사번</td><td>내용</td><td>날짜</td></tr>
				</thead>
				<tbody>
				</tbody>
			</table>
				<div id="message"></div>
		</div>
                           </div>		
<%-- class="card bg-light">end --%>
<%-- class="comment end --%>


        
      <jsp:include page="../Main/footer.jsp" />
</body>
</html>