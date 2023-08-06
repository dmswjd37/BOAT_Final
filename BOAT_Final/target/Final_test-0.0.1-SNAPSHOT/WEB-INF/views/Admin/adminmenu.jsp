<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>admin-list</title>
<style>
#navbarCollapse > div.d-flex.align-items-center.justify-content-end > div.ps-3 > div > form {
  margin-bottom: 0;
}
</style>
<jsp:include page="../Main/header.jsp"/>


 <!-- Service Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                <h6 class="section-title bg-white text-center text-primary px-3">관리자 페이지</h6>
            </div>
            <div class="row g-4">
               
               
                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                    <a class="service-item d-block rounded text-center h-100 p-4" href="${pageContext.request.contextPath}/admin/list">
                        <img class="img-fluid rounded mb-4" src="../resources/img/service-4.jpg" alt="">
                        <h4 class="mb-0">회원 정보/권한 수정</h4>
                    </a>
                </div>
               
                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                    <a class="service-item d-block rounded text-center h-100 p-4" href="${pageContext.request.contextPath}/Attendance/list">
                        <img class="img-fluid rounded mb-4" src="../resources/img/service-2.jpg" alt="">
                        <h4 class="mb-0">근태 관리</h4>
                    </a>
                </div>
               
               
             
                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                    <a class="service-item d-block rounded text-center h-100 p-4" href="${pageContext.request.contextPath}/cal">
                        <img class="img-fluid rounded mb-4" src="../resources/img/service-6.jpg" alt="">
                        <h4 class="mb-0">캘린더</h4>
                    </a>
                </div>
                
                 <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                    <a class="service-item d-block rounded text-center h-100 p-4" href="${pageContext.request.contextPath}/confer/admit">
                        <img class="img-fluid rounded mb-4" src="../resources/jkKim/image/large.jpg" alt="">
                        <h4 class="mb-0">회의실 승인</h4>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Service End -->

    
    	<jsp:include page="../Main/footer.jsp"/>