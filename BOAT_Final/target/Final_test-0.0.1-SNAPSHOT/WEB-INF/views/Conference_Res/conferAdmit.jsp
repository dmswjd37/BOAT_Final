<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang='en'>
  <head>
   <meta charset="utf-8">
    <title>BOAT - 회의실 예약 승인시스템</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
<style>
.project-item {
    min-height: 200px; /* Set a minimum height */
    min-width: 200px; /* Set a minimum width */
    height: 100%; /* Ensure each item takes up the full height of the container */
    display: flex; /* Use flexbox layout to align content */
    flex-direction: column; /* Align content vertically */
    justify-content: space-between; /* Add spacing between elements */
}

</style>

</head>
<body>
 <jsp:include page="../Main/header.jsp"/>

   <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-4 text-white animated slideInDown mb-3">회의실 예약 / 비품 대여 승인</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a class="text-white" href="#">회의실</a></li>
                    <li class="breadcrumb-item"><a class="text-white" href="#">노트북</a></li>
                     <li class="breadcrumb-item"><a class="text-white" href="#">프로젝터</a></li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->

	<!-- 탭 시작 -->
	    <div class="container">
      <div class="row">
        <div class="col">
          <p>회의실 예약 승인</p>
         
            <ul class="nav nav-tabs">
              <li class="nav-item">
                <a class="nav-link ${tab == '' || '전체' ? 'active' : ''}" data-toggle="tab" href="admit">전체</a>
              </li>
              <li class="nav-item">
                <a class="nav-link ${tab == '대회의실' ? 'active' : ''}" data-toggle="tab" href="admit?tab=대회의실"  >대회의실</a>
              </li>
              <li class="nav-item">
                <a class="nav-link ${tab == '회의실1' ? 'active' : ''}" data-toggle="tab" href="admit?tab=회의실1"  >회의실1</a>
              </li>
              <li class="nav-item">
                <a class="nav-link ${tab == '회의실2' ? 'active' : ''}" data-toggle="tab" href="admit?tab=회의실2" >회의실2</a>
              </li>
                
              
             <!--  drop down 임시 삭제
              <li class="nav-item">
                 <div class="dropdown" >
              <button class="btn btn-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false">
             회의실
              </button>
              <div class="dropdown-menu">
                <a class="dropdown-item" href="#">회의실</a>
                <a class="dropdown-item" href="#">비품 대여</a>
             </div>
            </div>   
              </li>
               -->
              
             </ul> 
            
            
            
            
            <div class="tab-content">
              <div class="tab-pane fade show active" id="qwe">
              
                  <!-- Project Start -->
    <div class="container-xxl py-5">
        <div class="container">
              <div class="row row-cols-1 row-cols-md-4 g-4" id="admit_list">
               
                <c:forEach var="r" items="${reservation}">          
                <div class="col">
                    <div class="project-item border rounded h-100 p-4" data-dot="01">
                        <div class="position-relative mb-4">
                            <c:choose>
                   			 <c:when test="${r.RENTAL eq '대회의실'}">
                        		<img class="img-fluid rounded" src="${pageContext.request.contextPath}/jkKim/image/large.jpg" alt="">
                           		<a href="${pageContext.request.contextPath}/jkKim/image/large.jpg" data-lightbox="project"><i class="fa fa-eye fa-2x"></i></a>
                        		
                    		</c:when>
                    		<c:when test="${r.RENTAL eq '회의실1'}">
                        		<img class="img-fluid rounded" src="${pageContext.request.contextPath}/jkKim/image/small.jpg" alt="">
                        		<a href="${pageContext.request.contextPath}/jkKim/image/small.jpg" data-lightbox="project"><i class="fa fa-eye fa-2x"></i></a>
                       		</c:when>
                       		<c:when test="${r.RENTAL eq '회의실2'}">
                        		<img class="img-fluid rounded" src="${pageContext.request.contextPath}/jkKim/image/small2.jpg" alt="">
                        		<a href="${pageContext.request.contextPath}/jkKim/image/small2.jpg" data-lightbox="project"><i class="fa fa-eye fa-2x"></i></a>
                       		</c:when>
                    		</c:choose>
                        </div>
                        <h6>${r.RENTAL}</h6>
                        <span>신청자 사번: ${r.ID}</span>
                        <span>예약날짜 : ${r.START_T.substring(0, 2)}월 ${r.START_T.substring(3, 5)}일</span>
                        <span>신청시간 : ${r.START_T.substring(6, 8)}시${r.START_T.substring(9, 11)}분 - ${r.END_T.substring(6, 8)}시${r.END_T.substring(9, 11)}분</span>
                        <c:choose>
                        <c:when test="${r.STATUS ==0 }">
                      <button type="button" class="btn btn-primary" onclick="modal('${r.ID }','${r.RENTAL}','${r.START_TIME }','${r.START_T}','${r.END_TIME }','${r.END_T}','${r.CONTENT}','${r.ABC}')">처리대기</button>
				      	</c:when>
				      	<c:when test="${r.STATUS ==1 }">
				      <button type="button" class="btn btn-success"  disabled>승인완료</button>
				      	</c:when>
				      	<c:when test="${r.STATUS ==2 }">
				      <button type="button" class="btn btn-danger"  disabled>반려</button>
				      	</c:when>
				      
				      </c:choose>
                    </div>
                </div>
            </c:forEach>
                 
        
            
            </div>
        </div>
    </div>
    
    <div class="center-block">
			<ul class="pagination justify-content-center" id="pagination">
			
				<c:if test="${page<=1}">
					<li class="page-item">
						<a class="page-link gray" >이전&nbsp;</a>
					</li>
				</c:if>
				<c:if test="${page>1}">
					<li class="page-item">
						 <a href="admit?page=${page-1 }&tab=${tab}" class="page-link" >이전&nbsp;</a>
					</li>
				</c:if>
				
				<c:forEach var="a" begin="${startpage}" end="${endpage}">
					<c:if test="${a==page }">
						<li class="page-item active">
							<a class="page-link" >${a}</a>
						</li>
					</c:if>
					<c:if test="${a!=page }">
						<li class="page-item">
							<a href="admit?page=${a }&tab=${tab}" class="page-link" >${a}</a>
						</li>
					</c:if>
				</c:forEach>
				
				<c:if test="${page >= maxpage }">
						<li class="page-item">
							<a class="page-link gray" >&nbsp;다음</a>
						</li>
				</c:if>
				<c:if test="${page < maxpage }">
						<li class="page-item">
							<a href="admit?page=${page+1 }&tab=${tab}" class="page-link" >&nbsp;다음</a>
						</li>
				</c:if>
		
			</ul>			
		</div>
    <!-- Project End -->
             
                
              </div>
           </div>
      </div>
    </div>
</div>



    <!-- modal -->
    <div class="modal fade" id="res_Modal" tabindex="-1" role="dialog" aria-labelledby="res_ModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="res_ModalLabel">대여 신청</h5>
       </div>
      <div class="modal-body">
        <form id="res_Form">
        
         <div class="form-group">
            <label for="rental">신청자 사번</label>
            <input type="text" class="form-control" id="rental_id" name="rental" readonly style="margin-bottom: 10px;">
          </div>
        
          <div class="form-group" style="display:none">
            <label for="rental">대여대상</label>
            <input type="hidden" id="rental" name="rental" readonly style="margin-bottom: 10px;">
          </div>
        
          <div class="form-group">
            <label for="startTime">대여시작 시간</label>
            <input type="text" class="form-control" id="startTime" readonly style="margin-bottom: 10px;">
            <input type="hidden" id="startTimeISO" name="startTimeISO">
          </div>
          <div class="form-group">
            <label for="endTime">대여종료 시간</label>
            <input type="text" class="form-control" id="endTime" readonly style="margin-bottom: 10px;">
             <input type="hidden" id="endTimeISO" name="endTimeISO">
          </div>
          <div class="form-group">
            <label for="content">용도</label>
            <textarea class="form-control" id="content" rows="3" readonly style="resize:none; margin-bottom: 5px;"></textarea>
          </div>
           <div class="form-group d-none" >
            <label for="abc">고유값</label>
            <textarea class="form-control" id="abc" rows="3"></textarea>
          </div>
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
      </div>
      <div class="modal-footer">
       <button type="button" class="btn btn-secondary" onclick="$('#res_Modal').modal('hide')">취소</button>
        <button type="button" class="btn btn-danger" id="reject_button" onclick="reject()">거절</button>
        <button type="button" class="btn btn-primary" onclick="confirm()">승인</button>
    
      </div>
    </div>
  </div>
</div>


 <jsp:include page="../Main/footer.jsp"/>
<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function modal(id,rental,start_time,start_t,end_time,end_t,content,abc) {
	  $('#rental_id').val(id);	
	  $('#rental').val(rental);
	  $('#startTimeISO').val(start_time);
	  $('#startTime').val(start_t);
	  $('#endTimeISO').val(end_time);
	  $('#endTime').val(end_t);
	  $('#content').val(content);
	  $('#abc').val(abc);
	  $('#res_Modal').modal('show');
	}
	
function confirm() {
	var id = $('#rental_id').val();
	var rental = $('#rental').val();
	var start_time = $('#startTimeISO').val();
	var end_time =  $('#endTimeISO').val();
	var abc = $('#abc').val();
	
		
	   $.ajax({
           url: "${pageContext.request.contextPath}/confer/permit_ajax/",
           type: 'POST',
           data: {
               "start_time": start_time,
               "end_time": end_time,
               "rental": rental,
               "id": id,
               "abc": abc
           },
           beforeSend : function(xhr)
           {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
             xhr.setRequestHeader(header, token);         
          },
           success: function(response) {
               $('#res_Modal').modal('hide');
               if(response === "overlap") {
            	   toastr.options.escapeHtml = true;
		  	       toastr.options.closeButton = true;
		  	       toastr.options.newestOnTop = false;
		  	       toastr.options.progressBar = true;
		  	       toastr.info('겹치는 시간이 존재합니다.', {timeOut: 3000});
               } else {
                   document.location.reload(); 
               }
           },
           error: function(request,error) {
               
               alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
           }
       }); //ajax 끝
}//confirm 끝

function reject() {
	var id = $('#rental_id').val();
	var rental = $('#rental').val();
	var start_time = $('#startTimeISO').val();
	var end_time =  $('#endTimeISO').val();
	var abc = $('#abc').val();

	
	  
    var modalHtml = '<div class="modal fade" id="rejectModal" tabindex="-1" role="dialog" aria-labelledby="rejectModalLabel" aria-hidden="true">';
    modalHtml += '<div class="modal-dialog" role="document">';
    modalHtml += '<div class="modal-content">';
    modalHtml += '<div class="modal-header">';
    modalHtml += '<h5 class="modal-title" id="rejectModalLabel">반려사유 선택</h5>';
    modalHtml += '</div>';
    modalHtml += '<div class="modal-body">';
    modalHtml += '<label for="rejectReason">반려사유 선택(클릭)</label>';
    modalHtml += '<select class="form-control" id="rejectReason">';
    modalHtml += '<option value="0">먼저 승인된 일정이 있습니다.</option>';
    modalHtml += '<option value="1">수리,보수등으로 인한 사용불가 상태입니다.</option>';
    modalHtml += '<option value="2">일정관리자에게 유선문의 부탁드립니다.</option>';
    modalHtml += '</select>';
    modalHtml += '</div>';
    modalHtml += '<div class="modal-footer">';
    modalHtml += '<button type="button" class="btn btn-danger" id="rejectSubmit">거절사유입력</button>';
    modalHtml += '</div>';
    modalHtml += '</div>';
    modalHtml += '</div>';
    modalHtml += '</div>';
    $('body').append(modalHtml);
    $('#rejectModal').modal('show');

    
    $('#rejectSubmit').on('click', function() {
        var reason = $('#rejectReason').val();
	
	   $.ajax({
           url: "${pageContext.request.contextPath}/confer/reject_ajax/",
           type: 'POST',
           data: {
               "start_time": start_time,
               "end_time": end_time,
               "rental": rental,
               "id": id,
               "reason" : reason,
               "abc":abc
           },
           beforeSend : function(xhr)
           {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
             xhr.setRequestHeader(header, token);         
          },
           success: function(response) {
               $('#res_Modal').modal('hide');
               document.location.reload(); //나중에 삭제해야댐 확인용
           },
           error: function(request,error) {
               
               alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
           }
       }); //ajax 끝
    });
}//reject 끝

function setPaging(href,digit){
	let active="";
	let gray="";
	if(href==""){ //href가 빈문자열인 경우
		if(isNaN(digit)){//이전&nbsp; 또는 다음&nbsp;
			gray="gray";
		}else{
			active="active";
		}
	}
	let output = '<li class="page-item ${active}">';
	//let anchor = "<a class='page-link " + gray + "'" + href + ">" + digit + "</a></li>";
	
	let anchor = `<a class='page-link ${gray}' ${href}>${digit}</a></li>`;
	output += anchor;
	return output;
}
	/*
$(document).ready(function() {
	   $('.nav-tabs a').on('click', function (e) {
		   e.preventDefault();
		   $('.nav-tabs a').removeClass('active'); 
		   $(this).addClass('active'); 
		   var tab_info = $('.nav-tabs .active').text();
		   
		   
		   $.ajax({
	            type: "GET",
	            url: "${pageContext.request.contextPath}/confer/admitTab_ajax",
	            data: {"tab": tab_info},
	            dataType : "json",
	            beforeSend : function(xhr)
             {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
               xhr.setRequestHeader(header, token);         
            },
	            success: function (response) {
	            	 $("#admit_list").empty();
	            	 $("#pagination").empty();

	            	  if (response.length < 1) {
	            		    $("#admit_list").append("<p>신청된 스케줄이 없습니다</p>");
	            		    return;
	            		  }

	            		  for (var i = 0; i < response.length; i++) {
	            			  var id = response[i].id
	            			  var rental = response[i].rental
	            			  var start = response[i].start_t.substring(0, 2)}월 + response[i].start_t.substring(3, 5)}일
	            			  var end = response[i].end_t
	            			  var status = response[i].status
	            			 
	            			  
	            			  var button;
	            			  if (response[i].status == 0) {
	            			    button = `<button type="button" class="btn btn-primary" onclick="modal('${response[i].ID }','${response[i].RENTAL}','${response[i].START_TIME }','${response[i].START_T}','${response[i].END_TIME }','${response[i].END_T}','${response[i].CONTENT}')">처리대기</button>`;
	            			  } else if (response[i].status == 1) {
	            			    button = `<button type="button" class="btn btn-success" onclick="modal('${response[i].ID }','${response[i].RENTAL}','${response[i].START_TIME }','${response[i].START_T}','${response[i].END_TIME }','${response[i].END_T}','${response[i].CONTENT}')" disabled>승인완료</button>`;
	            			  } else {
	            			    button = `<button type="button" class="btn btn-danger" onclick="modal('${response[i].ID }','${response[i].RENTAL}','${response[i].START_TIME }','${response[i].START_T}','${response[i].END_TIME }','${response[i].END_T}','${response[i].CONTENT}')" disabled>반려</button>`;
	            			  }
	            			  var image;
	            			  if(rental == '대회의실'){
	            		      	image = '<img class="img-fluid rounded" src="${pageContext.request.contextPath}/jkKim/image/large.jpg" alt="">'
                           	  	image += '<a href="${pageContext.request.contextPath}/jkKim/image/large.jpg" data-lightbox="project"><i class="fa fa-eye fa-2x"></i></a>'
	            			  }else if(rental =='회의실1'){
	            			  	image =  '<img class="img-fluid rounded" src="${pageContext.request.contextPath}/jkKim/image/small.jpg" alt="">'
	                          	image +=	'<a href="${pageContext.request.contextPath}/jkKim/image/small.jpg" data-lightbox="project"><i class="fa fa-eye fa-2x"></i></a>'
	                       	 
	            			  }else if(rental =='회의실2'){
	            			 	 image = '<img class="img-fluid rounded" src="${pageContext.request.contextPath}/jkKim/image/small2.jpg" alt="">'
	                        	 image +=	'<a href="${pageContext.request.contextPath}/jkKim/image/small2.jpg" data-lightbox="project"><i class="fa fa-eye fa-2x"></i></a>'
		                       		
	            			  }
	            			  
	            		    var output = `
	            		      <div class="col">
	            		        <div class="project-item border rounded h-100 p-4" data-dot="01">
	            		          <div class="position-relative mb-4">
	            		         `+ image + `
	            		          </div>
	            		          <h6>`+rental+`</h6>
	            		          <span>신청자 사번:` +  id +`</span>
	            		          <span>일정: `+start+`</span>
	            		          <span>신청시간: `+end+`</span>
	            		          `+ button +`
	            		        </div>
	            		      </div>
	            		    `;
	            		    $("#admit_list").append(output);
	            		  }

	            	   
	            		 
	            		  
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
	  				}
						
	            },
	            error: function(request,error) {
	                
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            }
	        });
		   
		   
		 });
	 });
	
	*/
	
	
</script>





  

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>

</body>
</html>