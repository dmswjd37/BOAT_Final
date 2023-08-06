<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>BOAT - 채팅</title>
	<link href="${pageContext.request.contextPath}/resources/ejyang/css/chat.css" type="text/css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
	<jsp:include page="../Main/header.jsp" />
</head>
<body>


  <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-4 text-white animated slideInDown mb-3">채팅</h1>
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

<!-- 회원 목록 -->
<div class="container bootstrap snippets bootdey">
	<div class="row">
		<div class="col-md-4 bg-white ">
			<div class=" row border-bottom padding-sm fs-5" style="height: 40px;">회원 목록</div>
			<ul class="friend-list" id="userList">
			</ul>
			<!-- 단톡방 생성 -->
			<!-- <div class="input-group">
				<input type="text" class="form-control border no-shadow no-rounded ms-2" placeholder="채팅방을 생성합니다." id="chatroom">
				<button class="btn btn-outline-success no-rounded" type="button">방 만들기</button>
			</div> -->
		</div>

		<!-- 채팅 상세 -->
		<div class="col-md-8 bg-white ">
		<div class="chat-message">
			<ul class="chat" id="message">
			<!-- 채팅 말풍선 -->
			</ul>
		</div>
		<!-- 메세지 작성 -->
		
		<div class="chat-box bg-white">
			<div class="input-group">
				
				<input type="text" class="form-control border no-shadow no-rounded" placeholder="보내실 메시지를 입력하세요." id="chat">
				<button onclick="send('message');" class="btn btn-outline-primary no-rounded" type="button" id="sendBtn">전송</button>
			</div>
		</div>
		</div>
	</div>
</div>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<jsp:include page="../Main/footer.jsp" />
</body>
</html>