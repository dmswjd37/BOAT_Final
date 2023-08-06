<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
 <head> 
  <title>BOAT - 내 글 보기</title>
  <script src="http://code.jquery.com/jquery-latest.js"></script>
  <jsp:include page="../Main/header.jsp" />
  <style>
  	body  div  table  thead  tr  th:nth-child(1){width:8%}
   	body  div  table  thead  tr  th:nth-child(2){width:47%}
   	body  div  table  thead  tr  th:nth-child(3){width:15%}
   	body  div  table  thead  tr  th:nth-child(4){width:10%}
   	body  div  table  thead  tr  th:nth-child(5){width:20%}
   	
   	thead th {
		text-align: center;
		vertical-align: middle;
	}
	
	form[name=logout] {
		margin-bottom: 0px;
	}
  </style>
 </head>
 <body>
 <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-4 text-white animated slideInDown mb-3">내 글 보기</h1>
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
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal" var="pinfo"/>
<input type="hidden" id="hidden-empno" value="${EMPNO}">
<input type="hidden" id="hidden-state" value="main">
<section class="container">
		<h3 class="pb-1 mb-4">내 글 보기
		 
		 <!--검색 및 글쓰기  -->
		</h3>
		<div class="table-responsive">
			<table class="table table-bordered table-hover">
				<thead>
					<tr class="bg-light">
						<th title="category">카테고리</th>
						<th title="Discussion List">제목</th>
						<th class="bg-light" title="Created By">작성자</th>
						<th title="Total Replies">조회수</th>
						<th title="Last Updated">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:set var = "num" value ="${listcount-(page-1)*limit }"/>
					<c:forEach var="b" items="${boardlist}">
					<tr>
						<!-- 카테고리 -->
						<td class="text-center">
		                    <c:choose>
	                    		<c:when test="${b.BOARD_NOTICE eq '0' or b.BOARD_NOTICE eq '1'}">
	                    			<c:out value="업무"/>
	                    		</c:when>
	                    		<c:when test="${b.BOARD_NOTICE eq null}">
	                    			<c:out value="워크보드"/>
	                    		</c:when>
	                    		<c:otherwise>	
	                    			<c:out value="자료실"/>
						 	    </c:otherwise>
	                    	</c:choose>
	                    </td>
	                    
	                    <!-- 제목 -->
	                    <c:choose>
	                    	<c:when test="${b.BOARD_NOTICE eq '0' or b.BOARD_NOTICE eq '1'}">
								<td style="display: flex; align-items: center;">
								 <c:if test="${b.BOARD_RE_LEV !=0 }"><%--답글인경우 --%>
            						<c:forEach var="a" begin="0" end="${b.BOARD_RE_LEV*2 }" step="1">
            						&nbsp;	
            						</c:forEach>
         						</c:if>
         						<c:if test="${b.BOARD_RE_LEV ==0 }">
         	 						&nbsp;
         						</c:if>
								<a href="${pageContext.request.contextPath}/board/detail?num=${b.BOARD_NUM }" style="flex: 1; font-size:90%">
								<c:out value="${b.BOARD_SUBJECT}" escapeXml="true"/> 
								<span class="gray small">[<c:out value="${b.CNT}"/>]</span>
								<c:if test="${b.BOARD_DATE > nowday}">
								<span	class="badge badge-pill badge-warning ml-auto" style="background-color: #89a5ea;">new</span>
								</c:if>
								</a>
								<c:if test="${b.BOARD_NOTICE eq '1'}">
								<span class="badge badge-pill badge-primary float-right" style="background-color: #ffcb6b;">공지</span>
								</c:if>
								<c:if test="${b.BOARD_NOTICE eq '0'}">
								<span	class="badge badge-pill badge-warning float-right" style="background-color: #89a5ea;">${b.BOARD_DEPT }</span>
								</c:if>
								</td>
							</c:when>
	                    	<c:when test="${b.BOARD_NOTICE eq null}">
								<td style="display: flex; align-items: center;">
								 <c:if test="${b.BOARD_RE_LEV !=0 }">
            						<c:forEach var="a" begin="0" end="${b.BOARD_RE_LEV*2 }" step="1">
            						&nbsp;	
            						</c:forEach>
         						</c:if>
         						<c:if test="${b.BOARD_RE_LEV ==0 }">
         	 						&nbsp;
         						</c:if>
								<a href="${pageContext.request.contextPath}/workboard/detail?num=${b.BOARD_NUM}" style="flex: 1; font-size:90%">
								<c:out value="${b.BOARD_SUBJECT}" escapeXml="true"/> 
								<c:if test="${b.BOARD_DATE > nowday}">
								<span	class="badge badge-pill badge-warning ml-auto" style="background-color: #89a5ea;">new</span>
								</c:if>
								</a>
								<span	class="badge badge-pill badge-warning float-right" style="background-color: #89a5ea;">${b.BOARD_DEPT}</span>
								</td>
							</c:when>
	                    	<c:otherwise>
								<td style="display: flex; align-items: center;">
								 <c:if test="${b.BOARD_RE_LEV !=0 }">
            						<c:forEach var="a" begin="0" end="${b.BOARD_RE_LEV*2 }" step="1">
            						&nbsp;	
            						</c:forEach>
         						</c:if>
         						<c:if test="${b.BOARD_RE_LEV ==0 }">
         	 						&nbsp;
         						</c:if>
								<a href="${pageContext.request.contextPath}/Filebo/detail?num=${b.BOARD_NUM }" style="flex: 1; font-size:90%">
								<c:out value="${b.BOARD_SUBJECT}" escapeXml="true"/> 
								<span class="gray small">[<c:out value="${b.CNT}"/>]</span>
								<c:if test="${b.BOARD_DATE > nowday}">
								<span	class="badge badge-pill badge-warning ml-auto" style="background-color: #89a5ea;">new</span>
								</c:if>
								</a>
								<span	class="badge badge-pill badge-warning float-right" style="background-color: #89a5ea;">${b.BOARD_DEPT}</span>
								</td>
							</c:otherwise>
						</c:choose>
								
						<!-- 글쓴이 -->
						<td><div style="display: flex; justify-content: center; align-items: center;"><small>${b.BOARD_NAME }</small></div></td>
						
						<!-- 조회수 -->
						<c:if test="${b.BOARD_NOTICE ne null}">
						<td><div style="display: flex; justify-content: center; align-items: center;">${b.BOARD_READCOUNT }</div></td>
						</c:if>
						<c:if test="${b.BOARD_NOTICE eq null}">
						<td><div style="display: flex; justify-content: center; align-items: center;">-</div></td>
						</c:if>
						<!-- 올린날짜 -->
						<c:set var="boardDate" value="${b.BOARD_DATE.toString()}"/>
						<td>
							<div style="display: flex; justify-content: center; align-items: center;">
								<c:if test="${boardDate!=today}">
									${boardDate.substring(5,10)}
								</c:if>
								<c:if test="${boardDate.substring(0,10)==today}">
									${boardDate.substring(11,16)}
								</c:if>	
							</div>
						</td>
						
					</tr>
					</c:forEach>
				</tbody>
				<tfoot>
				</tfoot>
			</table>
					<div class="filebofooter">

							<nav class="pt-3" aria-label="Page navigation example">
								<ul class = "pagination justify-content-center">
									<c:if test="${page<=1}">
									<li class="page-item">
										<a class="page-link gray">이전&nbsp;</a>
									</li>
									</c:if>
									<c:if test="${page>1}">
										<li class="page-item">
											<a href ="myboardList?page=${page-1}"
											class="page-link">이전&nbsp;</a>
										</li>
									</c:if>
									
									<c:forEach var="a" begin="${startpage}" end="${endpage}">
										<c:if test="${a==page}">
											<li class="page-item active">
											<a class="page-link">${a}</a>
											</li>
										</c:if>
										<c:if test="${a !=page}">
											<li class="page-item">
											<a href ="myboardList?page=${a}" class="page-link">${a}</a>
											</li>
										</c:if>
									</c:forEach>
									
									<c:if test="${page>=maxpage}">
											<li class="page-item">
											<a class="page-link gray">&nbsp;다음</a>
											</li>
										</c:if>
										<c:if test="${page<maxpage}">
											<li class="page-item">
											<a href ="myboardList?page=${page+1}"
											 class="page-link">&nbsp;다음</a>
											</li>
										</c:if>
								</ul>
							</nav>
					</div>
				
		</div>
</section>
</sec:authorize>
<script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
<jsp:include page="../Main/footer.jsp" />
 </body>
</html>