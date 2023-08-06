<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>

<title>업무 게시판</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/jkKim/css/all.css" />

<style>
 
  th:nth-child(1):hover {
    color: #009CFF;
    cursor: pointer;
  }
  tr > td:first-child {
  cursor: pointer;
}
#dropdownMenuButton1{
background-color: white;
  border: none;
}
#dropdownMenuButton2{
background-color: white;
  border: none;
}
#dropdownMenuButton3{
background-color: white;
  border: none;
}
h3.pb-1.mb-2.align-self-start.justify-content-start {
  margin-right: 10px;
}
#navbarCollapse > div.d-flex.align-items-center.justify-content-end > div.ps-3 > div > form {
  margin-bottom: 0;
}
</style>

</head>
<body>
	<jsp:include page="../Main/header.jsp" />
	
	<!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-4 text-white animated slideInDown mb-3">업무게시판</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
                    <li class="breadcrumb-item"><a class="text-white" href="#">Pages</a></li>
                    <li class="breadcrumb-item text-primary active" aria-current="page">Our Team</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal" var="pinfo"/>
<input type="hidden" id="hidden-empno" value="${EMPNO}">
<input type="hidden" id="hidden-state" value="main">
<!-- main=초기화면 / fav=즐겨찾기화면 / search=검색화면 -->

	<section class="container">
		<div class="row">
		
<div class="col-lg-12 col-12 mb-2 d-flex align-items-center justify-content-between">
  <h3 class="pb-1 mb-2  align-self-start justify-content-start">
   <a href="${pageContext.request.contextPath}/board/List" >업무용 게시판</a>
  	   </h3>
 <div class="flex-grow-1 ml-auto">
 <a href="${pageContext.request.contextPath}/board/Write" class="btn btn-success  ml-4 mb-2 px-3">글쓰기</a>
 </div>  
  <div class="d-flex align-items-center ml-auto">
  
<form class="d-flex align-items-center" id="searchboard">
<div class="input-group mr-2" style="border: 1px solid #ced4da; min-width: 400px;">
   <div class="dropdown" style="border-right: 2px solid #ced4da;">
      <button class="btn btn-secondary dropdown-toggle" style="min-width:100px;" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
        검색옵션
      </button>
      <ul class="dropdown-menu drop1" aria-labelledby="dropdownMenuButton1" id="drop1">
        <li><a class="dropdown-item">제목</a></li>
        <li><a class="dropdown-item">작성자</a></li>
      </ul>
    </div>
       <input class="form-control border-0" type="search" name="search" placeholder="검색어 입력" aria-label="Search">
      
  </div>
  <button class="btn" type="submit"><i class="bi bi-search"></i></button>
</form>

    
  </div>
</div>




				<div class="table-responsive" id="maintable" style="min-height:350px">
					<table class="table table-bordered table-hover mx-auto" style="table-layout: fixed">
						<thead>
							<tr class="bg-light">
								<th title="즐겨찾기" style="text-align: center; vertical-align: middle" width="5%"onclick=favorite(${EMPNO})>즐겨<br>찾기</th>
								<th title="제목" style="text-align: center; vertical-align: middle" width="50%">제목</th>
								<th class="bg-light" title="작성자" style="text-align: center; vertical-align: middle" width="15%">작성자</th>
								<th title="조회수" style="text-align: center; vertical-align: middle" width="10%">조회수</th>
								<th title="작성일" style="text-align: center; vertical-align: middle" width="20%">작성일</th>
							</tr>
						</thead>
						<tbody>
							 <c:set var="num" value="${listcount-(page-1) * limit }"/>
							 <c:forEach var="b" items="${boardlist }">
							<tr>
								<!-- 즐겨찾기 여부 -->
								<c:choose>
								<c:when test="${b.abc.contains(EMPNO)}">
  								<td title="즐겨찾기" class="text-center">
    							<i class="bi bi-star-fill" style="color:#ffd699"id="star${b.BOARD_NUM}" onclick="toggle(${b.BOARD_NUM}, ${EMPNO},'${b.BOARD_DEPT}')"></i>
  								</td>
								</c:when>
								<c:otherwise>
								<td title="즐겨찾기" class="text-center">
    							<i class="bi bi-star" id="star${b.BOARD_NUM}" onclick="toggle(${b.BOARD_NUM}, ${EMPNO},'${b.BOARD_DEPT}')"></i>
  								</td>
  								</c:otherwise>
  								</c:choose>
								

								
								<!-- 제목 -->
								<td style="display: flex; align-items: center;">
								 <c:if test="${b.BOARD_RE_LEV !=0 }"><%--답글인경우 --%>
            						<c:forEach var="a" begin="0" end="${b.BOARD_RE_LEV*2 }" step="1">
            						&nbsp;	
            						</c:forEach>
            						<img src='${pageContext.request.contextPath}/resources/img/line.gif'>
         						</c:if>
         						<c:if test="${b.BOARD_RE_LEV ==0 }"><!--  원문 인경우 -->
         	 						&nbsp;
         						</c:if>
								<a href="detail?num=${b.BOARD_NUM }" style="flex: 1; font-size:90%">
								<c:if test="${b.BOARD_SUBJECT.length()>=20}">
								<c:out value="${b.BOARD_SUBJECT.substring(0,20)}..." escapeXml="true"/> 
								</c:if>
								<c:if test="${b.BOARD_SUBJECT.length()<20}">
								<c:out value="${b.BOARD_SUBJECT}" escapeXml="true"/> 
								</c:if>
								
								
								<span class="gray small">[<c:out value="${b.CNT}"/>]</span>
								<c:if test="${b.BOARD_DATE > nowday}">
								<span	class="badge badge-pill badge-warning ml-auto" style="background-color: #89a5ea;">new</span>
								</c:if>
								</a>
								<c:if test="${b.BOARD_NOTICE == 1}">
								<span class="badge badge-pill badge-primary float-right" style="background-color: #ffcb6b;">공지</span>
								</c:if>
								<c:if test="${b.BOARD_NOTICE == 0}">
								<span	class="badge badge-pill badge-warning float-right" style="background-color: #89a5ea;">${b.BOARD_DEPT }</span>
								</c:if>
								</td>
								
								
								<!-- 글쓴이 -->
								<td><div style="display: flex; justify-content: center; align-items: center;"><small>${b.BOARD_NAME }</small></div></td>
								
								<!-- 조회수 -->
								<td><div style="display: flex; justify-content: center; align-items: center;">${b.BOARD_READCOUNT }</div></td>
								
								<!-- 올린날짜 -->
								<td><div style="display: flex; justify-content: center; align-items: center;">
									<c:if test="${b.BOARD_DATE!=today}">
											${b.BOARD_DATE.substring(5,10)}
									</c:if>
									<c:if test="${b.BOARD_DATE.substring(0,10)==today}">
											${b.BOARD_DATE.substring(11,16)}
									</c:if>
								
								
								</div></td>
							</tr>
							</c:forEach>
							
						</tbody>
						<tfoot>
  <tr>
    <td colspan="5">
      <nav class="pt-3 d-flex justify-content-between align-items-center" aria-label="Page navigation example">
        <ul class="pagination mb-0">
          <c:if test="${page<=1}">
            <li class="page-item">
              <a class="page-link gray">이전&nbsp;</a>
            </li>
          </c:if>
          <c:if test="${page>1}">
            <li class="page-item">
              <a href="List?page=${page-1}" class="page-link">이전&nbsp;</a>
            </li>
          </c:if>

          <c:forEach var="a" begin="${startpage}" end="${endpage}">
            <c:if test="${a==page }">
              <li class="page-item active">
                <a class="page-link">${a}</a>
              </li>
            </c:if>
            <c:if test="${a!=page }">
              <li class="page-item">
                <a href="List?page=${a}" class="page-link">${a}</a>
              </li>
            </c:if>
          </c:forEach>

          <c:if test="${page >= maxpage }">
            <li class="page-item">
              <a class="page-link gray">&nbsp;다음</a>
            </li>
          </c:if>
          <c:if test="${page < maxpage }">
            <li class="page-item">
              <a href="List?page=${page+1}" class="page-link">&nbsp;다음</a>
            </li>
          </c:if>
        </ul>
		<div class="d-flex align-items-center ml-auto">
        <div class="dropdown mb-2" style="border: 1px solid #ced4da; min-width: 100px;">
        	<button class="btn btn-secondary dropdown-toggle" type="button" style="min-width:115px;" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">
  			  부서별보기
  			</button>
  				<ul class="dropdown-menu drop-dept" id="drop-dept" aria-labelledby="dropdownMenuButton2">
  					<li><a class="dropdown-item active" >부서별보기</a></li>
    				<li><a class="dropdown-item">홍보팀</a></li>
    				<li><a class="dropdown-item">개발팀</a></li>
    				<li><a class="dropdown-item">인사팀</a></li>
    				<li><a class="dropdown-item">기획팀</a></li>
    				<li><a class="dropdown-item">영업팀</a></li>
  				</ul>
  		</div>
  
         <div class="dropdown mb-2" style="border: 1px solid #ced4da; min-width: 100px;">
  	        <button class="btn btn-secondary dropdown-toggle" type="button" style="min-width:115px;" id="dropdownMenuButton3" data-bs-toggle="dropdown" aria-expanded="false">
    			정렬옵션
  			</button>
  				<ul class="dropdown-menu drop-order" id="drop-order" aria-labelledby="dropdownMenuButton3">
  					<li><a class="dropdown-item active">정렬옵션</a></li>
    				<li><a class="dropdown-item">최신순</a></li>
    				<li><a class="dropdown-item">조회순</a></li>
    				<li><a class="dropdown-item">댓글순</a></li>
  				</ul>
  		</div>
  		</div>      









      </nav>
    </td>
  </tr>
</tfoot>

					</table>
				</div>
			</div>

	
		
	</section>
	</sec:authorize>
	
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js"></script>
	<script>
		feather.replace({
			width : 20
		})
	</script>

<script src = "${pageContext.request.contextPath}/jkKim/js/list3.js"></script>
<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");



//즐겨찾기 별모양 function (fav테이블에 insert)
function toggle(BOARD_NUM,BOARD_EMPNO,BOARD_DEPT) {
		var star = document.getElementById('star'+BOARD_NUM);
		var board_num = BOARD_NUM;
		var board_empno = BOARD_EMPNO;
		var board_dept = BOARD_DEPT
		//var board_empno = 2310005;
		
		
	if (star.classList.contains('bi-star-fill')) {
		  star.classList.remove('bi-star-fill');
		  star.classList.add('bi-star');
		  star.style.color = '';
		  $.ajax({
		        url: "${pageContext.request.contextPath}/board/Fav_delete",
		        type: 'POST',
		        data: {
		            "BOARD_NUM": board_num,
		            "BOARD_EMPNO": board_empno
		            
		        },
		        beforeSend : function(xhr)
		        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
		          xhr.setRequestHeader(header, token);         
		       },
		        success: function(response) {
		          // 성공시 테이블바디 재구성
		        },
		        error: function(request,error) {
		            
		        	 toastr.options.escapeHtml = true;
		  	       toastr.options.closeButton = true;
		  	       toastr.options.newestOnTop = false;
		  	       toastr.options.progressBar = true;
		  	       toastr.info('즐겨찾기 등록은 즐겨찾기탭에서 불가능합니다.', {timeOut: 3000});
		        }
			});//delete_ajax 끝
			
		} else {
		  star.classList.remove('bi-star');
		  star.classList.add('bi-star-fill');
		  star.style.color = '#ffd699';
		  
		  $.ajax({
		        url: "${pageContext.request.contextPath}/board/Fav_add",
		        type: 'POST',
		        data: {
		            "BOARD_NUM": board_num,
		            "BOARD_EMPNO": board_empno,
		            "BOARD_DEPT" : board_dept
		        },
		        beforeSend : function(xhr)
		        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
		          xhr.setRequestHeader(header, token);         
		       },
		        success: function(response) {
		          // 성공시 테이블바디 재구성
		        },
		        error: function(request,error) {
		            
		        	 toastr.options.escapeHtml = true;
			  	       toastr.options.closeButton = true;
			  	       toastr.options.newestOnTop = false;
			  	       toastr.options.progressBar = true;
			  	       toastr.info('즐겨찾기 등록은 즐겨찾기탭에서 불가능합니다.', {timeOut: 3000});	        }
			});//add_ajax 끝
		  
		}
	
}//toggle 끝

function favorite(BOARD_EMPNO) {
	var board_empno= BOARD_EMPNO
	var state = $("#hidden-state").val()
	
	if(state == 'fav'){
		$("#maintable > table > thead > tr > th:nth-child(1)").css({
			  "text-decoration": "none",
			  "color": "#777777"
			});
		window.location.href = '${pageContext.request.contextPath}/board/List';
	}else{
		$("#maintable > table > thead > tr > th:nth-child(1)").css({
			  "text-decoration": "underline",
			  "color": "#009CFF"
			});
	$.ajax({
		
        url: "${pageContext.request.contextPath}/board/Fav_List",
        type: 'POST',
        data: {
               "BOARD_EMPNO": board_empno,
               "dept": '부서별보기',
               "order": '정렬옵션'
        },
        beforeSend : function(xhr)
        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
          xhr.setRequestHeader(header, token);         
       },
        success: function(data) {
        	$("tbody").remove();
        	
			let output = "<tbody>";
			
			$(data.boardlist).each(
				
				function(index, item){
					
					
					output += "<tr>"
			            output += "<td title='즐겨찾기' class='text-center'><i class='bi bi-star-fill' style='color:#ffd699' id='star" + item.board_NUM +"' onclick='toggle("+ item.board_NUM + ", ${EMPNO})'></i></td>"
			            const blank_count = item.board_RE_LEV * 2 + 1;
			            let blank = '&nbsp;'; //답글일 때 들여쓰기
			            for (let i = 1; i<blank_count; i++){
			                blank += '&nbsp;&nbsp';
			            }
			            let img="";
			            if (item.board_RE_LEV > 0){
			                img="<img src='${pageContext.request.contextPath}/resources/img/line.gif'>";
			            }
			            let subject=item.board_SUBJECT.replace(/</g,'&lt');
			            subject = subject.replace(/>/g,'&gt');
			            output += "<td style='display: flex; align-items: center;'>" + blank + img;
			            output += "<a href='detail?num="+item.board_NUM + "' style='flex: 1; font-size:90%''>";
			            
			            if(subject.length >=20){
			            	output += subject.substring(0,20) + "...";
			            }
			            else if(subject.length <20){
			            	output += subject;
			            }
			            
			            
			            output += '<span class="gray small " style="margin-left:5px">['+item.cnt+']</span>';
			            //콘트롤러에서 nowday 보내줘야함********************
			            if(item.board_DATE > data.nowday){
			            	output += "<span class='badge badge-pill badge-warning' style='background-color: #89a5ea; margin-left:3px;'>new</span>";
			            }
			            output += "</a>";
			            if(item.board_NOTICE == 1){
			           		 output += "<span class='badge badge-pill badge-warning float-right' style='background-color: #ffcb6b;'>공지</span></td>";
			            }else if (item.board_NOTICE ==0){
				            output += "<span class='badge badge-pill badge-warning float-right' style='background-color: #89a5ea;'>"+item.board_DEPT+"</span></td>";
			            }
			            output += "<td><div style='display: flex; justify-content: center; align-items: center;'><small>" +item.board_NAME+" </small></div></td>";
			            output += "<td><div style='display: flex; justify-content: center; align-items: center;'>"+item.board_READCOUNT+"</div></td>";
			            output += "<td><div style='display: flex; justify-content: center; align-items: center;'>"
			            if(item.board_DATE != data.today){
			            	output += item.board_DATE.substring(5,10);
			            }
			            if( item.board_DATE.substring(0,10) == data.today ){
			            	output += " " + item.board_DATE.substring(11,16);
			            }
			            
			            "</div></td>"
			            output += "</tr>";
				})
				output += "</tbody>"
				
				$(output).insertAfter($("thead"));
				
			$(".pagination").empty();
			output = "";
			
			let digit = '이전&nbsp;'
			let href="";
			if(data.page > 1){
				href = 'href=javascript:go(' + (data.page-1) + ')';
			}
			output += setPaging(href, digit);
			
			for (let i = data.startpage; i <= data.endpage; i++){
				digit = i;
				href ="";
				if ( i != data.page){
					href = 'href=javascript:go(' + i + ')';
				}
				output += setPaging(href, digit);
			}
			
			digit = '다음&nbsp;';
			href="";
			if (data.page < data.maxpage) {
				href = 'href=javascript:go(' + (data.page + 1) + ')';
			}
			output += setPaging(href,digit);
				
			$('.pagination').append(output);
				
			$("#hidden-state").val('fav');
        },
        error: function(request,error) {
            
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
	});//add_ajax 끝
	}//else 끝
}

	

</script>
<jsp:include page="../Main/footer.jsp" />
</body>
</html>