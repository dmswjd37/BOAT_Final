<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <!-- Footer Start -->
    <div class="container-fluid bg-dark text-body footer mt-5 pt-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container py-5">
            <div class="row g-5">
                <div class="col-lg-3 col-md-6">
                    <h5 class="text-light mb-4">주소</h5>
                    <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>서울 특별시 종로구 율곡로 10길 105 디아망 4층</p>
                    <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+02 345 6789</p>
                    <p class="mb-2"><i class="fa fa-envelope me-3"></i>boat@gmail.com</p>
                    <div class="d-flex pt-2">
                        <a class="btn btn-square btn-outline-secondary rounded-circle me-1" href=""><i class="fab fa-twitter"></i></a>
                        <a class="btn btn-square btn-outline-secondary rounded-circle me-1" href=""><i class="fab fa-facebook-f"></i></a>
                        <a class="btn btn-square btn-outline-secondary rounded-circle me-1" href=""><i class="fab fa-youtube"></i></a>
                        <a class="btn btn-square btn-outline-secondary rounded-circle me-0" href=""><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5 class="text-light mb-4">관련링크</h5>
                    <a class="btn btn-link" href="">About Us</a>
                    <a class="btn btn-link" href="">Contact Us</a>
                    <a class="btn btn-link" href="">Our Services</a>
                    <a class="btn btn-link" href="">Terms & Condition</a>
                    <a class="btn btn-link" href="">Support</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5 class="text-light mb-4">갤러리</h5>
                    <div class="row g-2">
                        <div class="col-4">
                            <img class="img-fluid rounded" src="${pageContext.request.contextPath}/resources/img/project-1.jpg" alt="Image">
                        </div>
                        <div class="col-4">
                            <img class="img-fluid rounded" src="${pageContext.request.contextPath}/resources/img/project-2.jpg" alt="Image">
                        </div>
                        <div class="col-4">
                            <img class="img-fluid rounded" src="${pageContext.request.contextPath}/resources/img/project-3.jpg" alt="Image">
                        </div>
                        <div class="col-4">
                            <img class="img-fluid rounded" src="${pageContext.request.contextPath}/resources/img/project-4.jpg" alt="Image">
                        </div>
                        <div class="col-4">
                            <img class="img-fluid rounded" src="${pageContext.request.contextPath}/resources/img/project-5.jpg" alt="Image">
                        </div>
                        <div class="col-4">
                            <img class="img-fluid rounded" src="${pageContext.request.contextPath}/resources/img/project-6.jpg" alt="Image">
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5 class="text-light mb-4">뉴스레터</h5>
                    <p>회사에 관한 뉴스정보를 원하시면 아래 이메일 주소를 입력해주세요.</p>
                    <div class="position-relative mx-auto" style="max-width: 400px;">
                        <input class="form-control bg-transparent border-secondary w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                        <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">구독</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid copyright">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                        &copy; <a href="#">BOAT</a>, All Right Reserved.
                    </div>
                    <div class="col-md-6 text-center text-md-end">
                        <!--/*** This template is free as long as you keep the footer author��s credit link/attribution link/backlink. If you'd like to use the template without the footer author��s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                        Designed By <a href="https://htmlcodex.com">Boat Codex</a>
                        <br>Distributed By: <a class="border-bottom" href="https://themewagon.com" target="_blank">Boat</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer End -->
</body>
</html>