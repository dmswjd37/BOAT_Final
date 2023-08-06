<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>BOAT</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

	<jsp:include page="header.jsp"/>
	<jsp:include page="popup.jsp"/>
	<script>
		var result="${message}";
		if(result == 'updateSuccess'){
			toastr.options.escapeHtml = true;
		    toastr.options.closeButton = true;
		    toastr.options.newestOnTop = false;
		    toastr.options.progressBar = true;
		    toastr.info('회원 정보가 수정되었습니다.', '내 정보', {timeOut: 5000});
		}else if(result == 'deleteSuccess') {
			toastr.options.escapeHtml = true;
		    toastr.options.closeButton = true;
		    toastr.options.newestOnTop = false;
		    toastr.options.progressBar = true;
		    toastr.info('계정 삭제에 성공했습니다.', '내 정보', {timeOut: 5000});
		}
	</script>
	 
</head>

<body>
   


    <!-- Carousel Start -->
    <div class="container-fluid p-0 mb-5 wow fadeIn" data-wow-delay="0.1s" style="height:630px;">
        <div id="header-carousel" class="carousel slide" data-bs-ride="carousel" style="height:630px;">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#header-carousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1" style="height:1px !important"/>

                <button type="button" data-bs-target="#header-carousel" data-bs-slide-to="1" aria-label="Slide 2" style="height:1px !important"/>

                <button type="button" data-bs-target="#header-carousel" data-bs-slide-to="2" aria-label="Slide 3" style="height:1px !important"/>
            </div>
            <div class="carousel-inner" style="height:630px;">
                <div class="carousel-item active">
                    <img class="w-100" src="${pageContext.request.contextPath}/resources/img/carousel-1.jpg" alt="Image">
                    <div class="carousel-caption" style="height:630px;">
                        <div class="p-3" style="max-width: 900px;">
                            <h4 class="text-white text-uppercase mb-4 animated zoomIn">공지사항</h4>
                            <h1 class="display-1 text-white mb-0 animated zoomIn">파이널 프로젝트 시작</h1>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <img class="w-100" src="${pageContext.request.contextPath}/resources/img/carousel-2.jpg" alt="Image">
                    <div class="carousel-caption" style="height:630px;">
                        <div class="p-3" style="max-width: 900px;">
                            <h4 class="text-white text-uppercase mb-4 animated zoomIn">3-WORKS</h4>
                            <h1 class="display-1 text-white mb-0 animated zoomIn">소통 협업 관리를 한 번에</h1>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <img class="w-100" src="${pageContext.request.contextPath}/resources/img/carousel-3.jpg" alt="Image">
                    <div class="carousel-caption" style="height:630px;">
                        <div class="p-3" style="max-width: 900px;">
                            <h4 class="text-white text-uppercase mb-4 animated zoomIn">BOAT</h4>
                            <h1 class="display-1 text-white mb-0 animated zoomIn">실시간 업무공유 협업 툴</h1>
                        </div>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#header-carousel"
                data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#header-carousel"
                data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>
    <!-- Carousel End -->


   


    <!-- About Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="row g-5">
                <div class="col-lg-6 wow fadeInUp" data-wow-delay="0.1s">
                    <div class="img-border">
                        <img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/about.jpg" alt="">
                    </div>
                </div>
                <div class="col-lg-6 wow fadeInUp" data-wow-delay="0.5s">
                    <div class="h-100">
                        <h6 class="section-title bg-white text-start text-primary pe-3">About Us</h6>
                        <h1 class="display-6 mb-4">실시간 업무공유 협업 툴  관리와 이용하는 <span class="text-primary">BOAT</span> 사이트 제작 </h1>
                        <p>협업이라는 기본적인 내용에 충실하면서 필요한 정보를 확인하기 편하게 구성하여 업무효율을 높이는 것을 목표로 하는 툴 입니다.</p>
                        <p class="mb-4">실제 협업툴에서 쓰이는 기능들을 베이스로 관리/유지/이용에 필요한 기능구현을 목표.  또 각각의 게시판에 기본적인 기능 외에도 가시성과 활용성을 높여줄 만한 기능들을 추가로 제공하는 것을 목표로 합니다. </p>
                        <div class="d-flex align-items-center mb-4 pb-2">
                            
                            <div class="ps-4">
                                <h6>BOAT</h6>
                                <small>ⓒCorporation company</small>
                            </div>
                        </div>
                        <a class="btn btn-primary rounded-pill py-3 px-5" href="${pageContext.request.contextPath}/map">더보기</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- About End -->


    <!-- Service Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                <h6 class="section-title bg-white text-center text-primary px-3">빠른 메뉴 가기</h6>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                    <a class="service-item d-block rounded text-center h-100 p-4" href="${pageContext.request.contextPath}/map">
                        <img class="img-fluid rounded mb-4" src="${pageContext.request.contextPath}/resources/img/service-1.jpg" alt="">
                        <h4 class="mb-0">회사 소개</h4>
                    </a>
                </div>
                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                    <a class="service-item d-block rounded text-center h-100 p-4" href="${pageContext.request.contextPath}/Attendance/list">
                        <img class="img-fluid rounded mb-4" src="${pageContext.request.contextPath}/resources/img/service-2.jpg" alt="">
                        <h4 class="mb-0">근태 관리</h4>
                    </a>
                </div>
                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                    <a class="service-item d-block rounded text-center h-100 p-4" href="${pageContext.request.contextPath}/member/myboardList">
                        <img class="img-fluid rounded mb-4" src="${pageContext.request.contextPath}/resources/img/service-3.jpg" alt="">
                        <h4 class="mb-0">내 글 보기</h4>
                    </a>
                </div>
                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                    <a class="service-item d-block rounded text-center h-100 p-4" href="${pageContext.request.contextPath}/Todo/list">
                        <img class="img-fluid rounded mb-4" src="${pageContext.request.contextPath}/resources/img/service-4.jpg" alt="">
                        <h4 class="mb-0">내 할일 보기</h4>
                    </a>
                </div>
                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                    <a class="service-item d-block rounded text-center h-100 p-4" href="${pageContext.request.contextPath}/board/List">
                        <img class="img-fluid rounded mb-4" src="${pageContext.request.contextPath}/resources/img/service-5.jpg" alt="">
                        <h4 class="mb-0">업무 게시판</h4>
                    </a>
                </div>
                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                    <a class="service-item d-block rounded text-center h-100 p-4" href="${pageContext.request.contextPath}/cal">
                        <img class="img-fluid rounded mb-4" src="${pageContext.request.contextPath}/resources/img/service-6.jpg" alt="">
                        <h4 class="mb-0">캘린더</h4>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Service End -->



    <!-- Testimonial Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                <h6 class="section-title bg-white text-center text-primary px-3">BOAT</h6>
                <h1 class="display-6 mb-4">Best Of A Trendy</h1>
            </div>
        </div>
    </div>
    <!-- Testimonial End -->


   
	<jsp:include page="footer.jsp"/>

   
</body>
	
</html>