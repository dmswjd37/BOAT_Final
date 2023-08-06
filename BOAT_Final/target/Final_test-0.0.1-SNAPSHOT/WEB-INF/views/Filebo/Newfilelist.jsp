<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
<jsp:include page="../Main/header.jsp" />
	
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/jhLee/css/filenew.css">
<script src="${pageContext.request.contextPath}/resources/jhLee/js/filelist.js"></script>
<style>

</style>

  <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-4 text-white animated slideInDown mb-3">자료실 게시판</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item text-primary active" aria-current="page"></li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->
<section class="container">
	<!--<div class="row">  -->
		<!-- <div class="col-lg-9 col-12 mb-4"> -->
		<h3 class="border-bottom pb-1 mb-4"><a class = "filebo" href="${pageContext.request.contextPath}/Filebo/list" target="_self">자료실 게시판</a>
		 
		 <!--검색 및 글쓰기  -->
   			<div class = 'search '>
     		
     <a href="${pageContext.request.contextPath}/Filebo/write" class="btn btn-success btn">
			<i class="fas fa-plus"></i> 글쓰기
			</a>
      
        

        <div class="btn-group search form-group">
        
            <div class="dropdown" >
    		  <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="searchsel" data-bs-toggle="dropdown" aria-expanded="false">
    	    검색옵션
   			   </a>
		      <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
		        <li><a class="dropdown-item" >작성자</a></li>
		        <li><a class="dropdown-item" >제목</a></li>
		      </ul>
  		  </div>
 
          <input class ="search form-control" type="text" name="searchinput" id = "searchinput" value="${searchinput}" >
          		
          <button type="submit" class = "searchbutton search" id="searhcbtn2">
        	<img src="${pageContext.request.contextPath}/resources/jhLee/img/2.png"  class ="searchimg">
          </button>
          </div>
        </label>
        
			
		</div>
		</h3>
		<div class="">
			<table class="table table-bordered table-hover">
				<thead>
					<tr class="bg-light">
					<th><span class="invis favorite">즐겨찾기</span>즐겨찾기</th>
						<th title="Discussion List">제목</th>
						<th class="bg-light" title="Created By">작성자</th>
						<th title="Total Replies">조회수</th>
						<th title="Last Updated">작성일</th>
						<th title="Last Updated">파일1</th>
						<th title="Last Updated">파일2</th>
					</tr>
				</thead>
				<tbody>
					<c:set var = "num" value ="${listcount-(page-1)*limit }"/>
					<c:forEach var="FILIBO" items="${boardlist}">
					<tr>
						<c:choose>
								<c:when test="${FILIBO.star.contains(EMPNO)}">
  								<td title="즐겨찾기" class="text-center">
    							<i class="bi bi-star-fill" style="color:#ffd699"id="star${FILIBO.FILE_NUM}" onclick="toggle(${FILIBO.FILE_NUM}, ${EMPNO})"></i>
  								</td>
								</c:when>
								<c:otherwise>
								<td title="즐겨찾기" class="text-center">
    							<i class="bi bi-star" id="star${FILIBO.FILE_NUM}" onclick="toggle(${FILIBO.FILE_NUM}, ${EMPNO})"></i>
  								</td>
  								</c:otherwise>
  								</c:choose>
								
						<td>
						
							<c:if test="${FILIBO.FILE_SUBJECT.length()>=20}">
								&nbsp;	&nbsp;	&nbsp;
								<a href="detail?num=${FILIBO.FILE_NUM}">
									<c:out value="${FILIBO.FILE_SUBJECT.substring(0,20)}..."/>
								</a>
							</c:if>
							
							<c:if test="${FILIBO.FILE_SUBJECT.length()< 20}">
								<a href="detail?num=${FILIBO.FILE_NUM}">
								&nbsp;	&nbsp;	&nbsp;	<c:out value="${FILIBO.FILE_SUBJECT}"/>
								</a>
							</c:if>
						</a>
						[${FILIBO.CNT}]

						
						<c:if test="${FILIBO.FILE_DATE > nowday}">
	 		      	  		<img src="${pageContext.request.contextPath}/jhLee/img/new.png" id="new" style="width:20px">
	 		      	  	</c:if>

							<span class="badge badge-pill badge-warning float-right"style="background-color: #89a5ea;">${FILIBO.DEPT}</span>
							
						</td>

						<td><small>${FILIBO.FILE_NAME} </small></a></td>
						<td>${FILIBO.FILE_READCOUNT}</td>
						<td><div class="date">
							
							<c:if test="${FILIBO.FILE_DATE!=today}">
								${FILIBO.FILE_DATE.substring(5,10)}
							</c:if>
							<c:if test="${FILIBO.FILE_DATE.substring(0,10)==today}">
								${FILIBO.FILE_DATE.substring(11,16)}
							</c:if>
						</div>	</td>
						<td><div class = "file1">
							<c:if test="${!empty FILIBO.FILE_FILE}">
								<span class ="invis">${FILIBO.FILE_ORIGINAL}</span>
							<img alt="파일다운2" src="${pageContext.request.contextPath}/jhLee/img/download.png" class = 'file'style="width:20px">
							</c:if>
							</div>
						</td>
						<td>
							<div class = "file2">
							<c:if test="${!empty FILIBO.FILE_FILE2}">
								<span class ="invis">${FILIBO.FILE_ORIGINAL2}</span>
								<img alt="파일다운2" src="${pageContext.request.contextPath}/jhLee/img/download.png" class = 'file'style="width:20px">
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
											<a href ="list?page=${page-1}"
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
											<a href ="list?page=${a}" class="page-link">${a}</a>
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
											<a href ="list?page=${page+1}"
											 class="page-link">&nbsp;다음</a>
											</li>
										</c:if>
								</ul>
						</nav>
								
			<div class="btn-group search form-group">
        
           <input type="hidden" name = "DEPT" id = "deptval" value =" ${deptval}">
            <div class="dropdown" >
    		  <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="DEPT" data-bs-toggle="dropdown" aria-expanded="false">
    	    부서별
   			   </a>
		      <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
		        <li><a class="dropdown-item" >전체</a></li>
		        <li><a class="dropdown-item" >홍보팀</a></li>
		        <li><a class="dropdown-item" >개발팀</a></li>
		        <li><a class="dropdown-item" >인사팀</a></li>
		        <li><a class="dropdown-item" >기획팀</a></li>
		        <li><a class="dropdown-item" >영업팀</a></li>
		      </ul>
  		  </div>
 
   <input type="hidden" name = "searchsel" id = "orderval" value =" ${orderval}">
            <div class="dropdown" >
    		  <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="ORDER" data-bs-toggle="dropdown" aria-expanded="false">
    	    정렬
   			   </a>
		      <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
		        <li><a class="dropdown-item" >최신순</a></li>
		        <li><a class="dropdown-item" >조회순</a></li>
		        <li><a class="dropdown-item" >댓글순</a></li>
		      </ul>
  		  </div>
		
		</div>
	<!-- .filebofooter end -->
	</div>
				
		</div>
	</div>
	
	
	</div>
</section>

	<script>

    function toggle(FILE_NUM,FILE_EMPNO) {
		var star = document.getElementById('star'+FILE_NUM);
		var file_num = FILE_NUM;
		var file_empno = FILE_EMPNO;
        
    if (star.classList.contains('bi-star-fill')) {
        star.classList.remove('bi-star-fill');
        star.classList.add('bi-star');
        star.style.color = '';
        $.ajax({
              url: "${pageContext.request.contextPath}/Filebo/Fav_delete",
              type: 'POST',
              data: {
                  "FILE_NUM": file_num,
                  "FILE_EMPNO": file_empno
              },
              beforeSend : function(xhr)
              {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
                xhr.setRequestHeader(header, token);         
             },
              success: function(response) {
				console.log(response)
                if(response ==1){
                toastr.options.escapeHtml = true;
                toastr.options.closeButton = true;
                toastr.options.newestOnTop = false;
                toastr.options.progressBar = true;
                toastr.info('즐겨찾기 삭제되었습니다.', '자료실게시판', {timeOut: 3000});
            }
              },
              error: function(request,error) {
                  
              }
          });//delete_ajax 끝
      } else {
        star.classList.remove('bi-star');
        star.classList.add('bi-star-fill');
        star.style.color = '#ffd699';
        
        $.ajax({
              url: "${pageContext.request.contextPath}/Filebo/Fav_add",
              type: 'POST',
              data: {
                  "FILE_NUM": file_num,
                  "FILE_EMPNO": file_empno
              },
			  
              beforeSend : function(xhr)
              {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
                xhr.setRequestHeader(header, token);         
             },
              success: function(response) {
				console.log(response)
                if(response ==1){
                    toastr.options.escapeHtml = true;
                    toastr.options.closeButton = true;
                    toastr.options.newestOnTop = false;
                    toastr.options.progressBar = true;
                    toastr.info('즐겨찾기 추가되었습니다.', '자료실게시판', {timeOut: 3000});
                }
              },
              error: function(request,error) {
                  
                  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
              }
          });//add_ajax 끝
        
        
      }
  
}
</script>
	<jsp:include page="../Main/footer.jsp" />
