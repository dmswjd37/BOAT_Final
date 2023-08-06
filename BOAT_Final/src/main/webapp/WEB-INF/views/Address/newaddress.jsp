<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>BOAT - 주소록 </title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
<style>
.team-item .team-social{flex-wrap : wrap;
}
.emails{
   width: 100%;
}
</style>
  
 </head>
<body>

 <jsp:include page="../Main/header.jsp"/>


 <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-4 text-white animated slideInDown mb-3">Our Team</h1>
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

  <!-- Team Start -->
    <div class="container-xxl py-5">
        <div class="container">
        
            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                <h6 class="section-title bg-white text-center text-primary px-3">홍보팀</h6>
                <h1 class="display-6 mb-4">Meet your Creative Boat Manager</h1>
            </div>
            
            
            <div class="row g-4">
            
                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                    <div class="team-item text-center p-4">
                        <img class="image-fluid border rounded-circle w-75 p-2 mb-4" src="image/team-1.jpg" alt="">
                        <div class="team-text">
                            <div class="team-title">
                                <h5>김정근</h5>
                                <span>팀장</span>
                                
                            </div>
                            <div class="team-social">
                            
                            	<span class="emails">geo_webhard@naver.com</span>
                                <a class="btn btn-square btn-primary rounded-circle" href=""><i class="bi bi-card-checklist"></i></a>
                                <a class="btn btn-square btn-primary rounded-circle" href=""><i class="bi bi-pencil-square"></i></a>
                                <a class="btn btn-square btn-primary rounded-circle" href=""><i class="bi bi-envelope"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                    <div class="team-item text-center p-4">
                        <img class="image-fluid border rounded-circle w-75 p-2 mb-4" src="image/team-2.jpg" alt="">
                        <div class="team-text">
                            <div class="team-title">
                                <h5>Full Name</h5>
                                <span>Designation</span>
                            </div>
                            <div class="team-social">
                                <a class="btn btn-square btn-primary rounded-circle" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square btn-primary rounded-circle" href=""><i class="fab fa-twitter"></i></a>
                                <a class="btn btn-square btn-primary rounded-circle" href=""><i class="fab fa-instagram"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                    <div class="team-item text-center p-4">
                        <img class="image-fluid border rounded-circle w-75 p-2 mb-4" src="image/team-3.jpg" alt="">
                        <div class="team-text">
                            <div class="team-title">
                                <h5>Full Name</h5>
                                <span>Designation</span>
                            </div>
                            <div class="team-social">
                                <a class="btn btn-square btn-primary rounded-circle" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square btn-primary rounded-circle" href=""><i class="fab fa-twitter"></i></a>
                                <a class="btn btn-square btn-primary rounded-circle" href=""><i class="fab fa-instagram"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                
                    <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                    <div class="team-item text-center p-4">
                        <img class="image-fluid border rounded-circle w-75 p-2 mb-4" src="image/team-3.jpg" alt="">
                        <div class="team-text">
                            <div class="team-title">
                                <h5>Full Name</h5>
                                <span>Designation</span>
                            </div>
                            <div class="team-social">
                                <a class="btn btn-square btn-primary rounded-circle" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square btn-primary rounded-circle" href=""><i class="fab fa-twitter"></i></a>
                                <a class="btn btn-square btn-primary rounded-circle" href=""><i class="fab fa-instagram"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                
                
            </div>
        </div>
    </div>
    <!-- Team End -->
    

    
    
</body>
</html>