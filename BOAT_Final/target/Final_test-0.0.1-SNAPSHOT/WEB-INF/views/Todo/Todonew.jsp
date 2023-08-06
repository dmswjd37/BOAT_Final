<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일별근무시간</title>
<jsp:include page="../Main/header.jsp" />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- <script src="${path}/resources/js/attendance/board.js" defer ></script> -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/jhLee/css/Todonew.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/jhLee/css/Todonew2.css">
<script
	src="${pageContext.request.contextPath}/resources/jhLee/js/Todonew.js"></script>
<%--tab 전환에 필요 bootstrap4 --%>
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<style>
.page-header {
	margin: 0 !important
}

body>div.container-fluid.bg-dark.text-body.footer.mt-5.pt-5.wow.fadeIn {
	margin: 0 !important
}
</style>

</head>


<%--

 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
 
  5.0 번들에서 모달 작동안함... --%>


<!-- 내 할일 TODO 수정 Modal -->

<div class="modal fade" id="updateTodo" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">할 일 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" style="color: black;">
				일정<br>

				<form action="updateTodo" method='post'>
					<input type="hidden" id="todonum" name="NUM"></input> <input
						type="text" name="T_CONTENT" class="form-control" id='updatetitle'>


					<div class="cal_time" style="margin-top: 15px">
						<label>일정 시작 날짜: </label><br>
						<div class="form-group" style="margin-top: 15px">
							<input id="updatestart" type="DATE" name="START_DATE"
								class="form-control time" value="" />
						</div>

						<label style="margin-top: 15px">일정 종료 날짜: </label><br>
						<div class="form-group" style="margin-top: 15px">
							<input id="updateend" type="DATE" name="END_DATE"
								class="form-control time" />
						</div>
					</div>


					<input type="hidden" name="EMPNO" value="${EMPNO}" id="Todoempno">
					<input type="hidden" name="DEPT" value="${DEPT}" id="Tododept">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}">
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal" id="undo">돌아가기</button>
						<button type="submit" class="btn btn-primary" id="saveUpdate">&nbsp;&nbsp;일정
							저장&nbsp;&nbsp;</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- 내 할일 TODO 추가 Modal end-->
<body>

	<!-- 내 할일 TODO 추가 Modal -->

	<div class="modal fade" id="addTodo" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">새 할 일 등록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" style="color: black;">
					일정<br>

					<form action="add" method='post'>
						<input type="hidden" name="state" value="0"> <input
							type="text" name="T_CONTENT" class="form-control" id='title'>


						<div class="cal_time" style="margin-top: 15px">
							<label>일정 시작 날짜: </label><br>
							<div class="form-group" style="margin-top: 15px">
								<input type="DATE" id="addstartdate" name="START_DATE"
									class="form-control time" />
							</div>

							<label style="margin-top: 15px">일정 종료 날짜: </label><br>
							<div class="form-group" style="margin-top: 15px">
								<input type="DATE" id="addenddate" name="END_DATE"
									class="form-control time" />
							</div>
						</div>
						<!-- cal_time-->

						<script>
							$(document).ready(function() {
								let addstartdate = $('#addstartdate').val();
								let addenddate = $('#addenddate').val();
								
								if (new Date(addenddate)
				                - new Date(addstartdate) < 0) { // date 타입으로 변경 후 확인
									toastr.options.escapeHtml = true;
									toastr.options.closeButton = true;
									toastr.options.newestOnTop = false;
									toastr.options.progressBar = true;
									toastr.info('종료날짜를	확인해주세요', '내 할일 ', {timeOut: 1500});
								return false}
			
							})
						</script>

						<input type="hidden" name="EMPNO" value="${EMPNO}" id="Todoempno">
						<input type="hidden" name="DEPT" value="${DEPT}" id="Tododept">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}">
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal" id="undo">돌아가기</button>
							<button type="submit" class="btn btn-primary" id="saveBtn">&nbsp;&nbsp;일정
								저장&nbsp;&nbsp;</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- 내 할일 TODO 추가 Modal end-->

	<!-- Page Header Start -->
	<div class="container-fluid page-header py-5 mb-5 wow fadeIn"
		data-wow-delay="0.1s">
		<div class="container text-center py-5">
			<h1 class="display-4 text-white animated slideInDown mb-3">내 할 일
				보기</h1>
			<nav aria-label="breadcrumb animated slideInDown">
				<ol class="breadcrumb justify-content-center mb-0">
					<li class="breadcrumb-item text-primary active" aria-current="page"></li>
				</ol>
			</nav>
		</div>
	</div>
	<!-- Page Header End -->



	<main class="main-box">
		<div id="right-content"></div>

		<div id="main-content">
			<div>
				<div id="search-box" class="box">
					<h1>내 할 일 보기</h1>
				</div>

			</div>
			<div>
				<div id="notice-box" class="box">
					<div class='todocontainer'>



						<!-- Button trigger modal -->
						<button type="button" class="btn btn-primary"
							data-bs-toggle="modal" data-bs-target="#addTodo">
							<i class="fas fa-plus"></i> 새 일정 추가</a>
						</button>


						<section id="tabs" class="project-tab">
							<div class="container">
								<div class="row">
									<div class="col-md-12">
										<nav>
											<div class="nav nav-tabs nav-fill" id="nav-tab"
												role="tablist">
												<a class="nav-item nav-link active" id="nav-home-tab"
													data-toggle="tab" href="#nav-home" role="tab"
													aria-controls="nav-home" aria-selected="true">할 일 목록</a> <a
													class="nav-item nav-link" id="nav-profile-tab"
													data-toggle="tab" href="#nav-profile" role="tab"
													aria-controls="nav-profile" aria-selected="false">진행정도</a>
												<a class="nav-item nav-link" id="nav-contact-tab"
													data-toggle="tab" href="#nav-contact" role="tab"
													aria-controls="nav-contact" aria-selected="false">나의 팀
													할 일 목록</a>
											</div>
										</nav>
										<div class="tab-content" id="nav-tabContent">
											<div class="tab-pane fade show active" id="nav-home"
												role="tabpanel" aria-labelledby="nav-home-tab">
												<table class="table" cellspacing="0">
													<thead>
														<tr>
															<th>내 할일</th>
															<th>시작날짜</th>
															<th>예상 마감일</th>
														</tr>
													</thead>
													<tbody>

														<!-- 내 할일보기 -->
														<c:forEach var="mt" items="${MyTodo}">
															<tr>
																<td><a href="#">${mt.t_CONTENT}</a></td>
																<td>${mt.START_DATE}</td>
																<td>${mt.END_DATE}</td>
															</tr>

														</c:forEach>

													</tbody>
												</table>
												<c:if test="${fn:length(MyTodo)==0}">
													<h3 style="text-align: center">등록된 할일이 없습니다.</h3>
												</c:if>
											</div>


											<!-- 진행정도 -->
											<div class="tab-pane fade" id="nav-profile" role="tabpanel"
												aria-labelledby="nav-profile-tab">

												<c:set var="protageall" value="${fn:length(MyTodo)}" />

												<c:if test="${!empty MyTodo}">
													<div class='myallprogress progress'>
														<div class=" myallprogress-bar progress-bar bg-info"
															role="progressbar" style="width:${mydoneper}%"
															aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
															<c:if test="${mydonper!=100}">
											${mydoneper}%
										</c:if>
															<c:if test="${mydonper==100}">
										백이야
									
										</c:if>

														</div>
														<%--<c:out value="${protageall}"> --%>



													</div>
												</c:if>
												<table class="table" cellspacing="0">
													<!-- 내 할일보기 그래프 -->
													<c:set var="ptotage" value="0" />
													<c:forEach var="mt" items="${MyTodo}">
														<!-- 개인 todo 갯수 그래프 작성예정 -->

														<thead>
															<tr>
																<th>${mt.t_CONTENT}</th>
																<%-- --%>
																<c:if test="${mt.state==1}">
																	<th>
																		<div></div>
																		<div class="ddddone">완료</div>

																	</th>
																	<th></th>

																</c:if>


																<c:set var="ptotage" value="${ptotage+1}" />

																<c:if test="${mt.state!=1}">
																	<th>
																		<!-- <div class='todoprogress progress'></div> -->
																	</th>
																	<th>
																		<div class="btn_wrap">
																			<a class="btn btn-warning btn updateTodo"
																				data-id="${mt.NUM}"> <i class="fas fa-plus"></i>
																				수정
																			</a> <a class="done btn btn-success btn"
																				data-id="${mt.NUM}"> <i
																				class="fas  fa-check-circle"></i> 완료
																			</a>
																		</div>
																	</th>

																</c:if>
																<th>
																<img alt="삭제" class="deleteTodo" data-id="${mt.NUM}"
																	src="${pageContext.request.contextPath}/resources/jhLee/img/delete.png"
																	style="width: 20px;">
																	</th>
															</tr>

														</thead>

													</c:forEach>
												</table>

											</div>





											<div class="tab-pane fade" id="nav-contact" role="tabpanel"
												aria-labelledby="nav-contact-tab">

												<%--아코디언 시작 --%>
												<div class="accordion" id="accordionExample">

													<div class="accordion-item">
														<c:set var="num" value="0" />

														<c:forEach var="MDT" items="${MydeptList}">
															<h2 class="accordion-header" id="${'heading'}${num}">
																<button class="accordion-button collapsed" type="button"
																	data-bs-toggle="collapse"
																	data-bs-target="#${'collapse'}${num}"
																	aria-expanded="false"
																	aria-controls="${'collapse'}${num}">
																	${MDT.NAME}
																	<div class="progress"></div>
																</button>
																<div>
																	<div class='deptprogress todoprogress progress'>

																		<div class=" myallprogress-bar progress-bar bg-info"
																			role="progressbar" style="width:${MDT.count}%"
																			aria-valuenow="100" aria-valuemin="0"
																			aria-valuemax="100">

																			<c:if test="${MDT.count!=100}">
                              ${MDT.count}%
                              </c:if>

																		</div>

																	</div>
																</div>
															</h2>

															<c:set var="count" value="0" />
															<c:set var="countzero" value="0" />

															<div id="${'collapse'}${num}"
																class="accordion-collapse collapse"
																aria-labelledby="${'heading'}${num}"
																data-bs-parent="#accordionExample">
																<c:set var="num" value="${num+1}" />


																<div class="accordion-body">
																	<div class="ibox-content forum-container">
																		<div class="forum-title">
																			<div class="pull-right forum-desc">
																				<samll></samll>
																			</div>
																			<h3>${MDT.DEPT}${MDT.NAME}</h3>
																		</div>



																		<div class="forum-item active">
																			<div class="row">
																				<div class="col-md-9">
																					<div class="forum-icon">
																						<i class="fa fa-shield"></i>
																					</div>
																					<!-- 부서명 사원명 end /// -->
																					<a class="forum-item-title"> 진행중</a>
																					<div class="forum-sub-title"></div>
																				</div>


																			</div>
																		</div>
																		<c:forEach items="${MDT.todo}" var="e">

																			<c:if test="${e.state==0}">
																				<%--  <c:set var="count" value="${count+1}"/>
                       
                        <c:if test="${e.state==0}">
                       	 <c:set var="countzero" value="${countzero+1}"/>
                        </c:if>
                        
                        <c:out value="${e.state}"/>
                        <c:out value="${count}"/>
                        <c:out value="${countzero}"/>
                         --%>

																				<div class="forum-item">
																					<div class="row">
																						<div class="col-md-6">
																							<div class="forum-icon">
																								<i class="fa fa-bolt"></i>
																							</div>
																							<a href="forum_post.html"
																								class="forum-item-title">${e.t_CONTENT}</a>
																							<div class="forum-sub-title">할일상세보기</div>
																						</div>
																						<div class="col-md-2 forum-info">
																							<span class="views-number"> </span>
																							<div>
																								<small>${e.START_DATE}</small>
																							</div>
																						</div>

																						<div class="col-md-2 forum-info">
																							<span class="views-number"> </span>
																							<div>
																								<small>${e.END_DATE}</small>
																							</div>
																						</div>

																					</div>
																				</div>
																			</c:if>

																		</c:forEach>



																		<div class="forum-item active">
																			<div class="row">
																				<div class="col-md-9">
																					<div class="forum-icon">
																						<i class="fa fa-shield"></i>
																					</div>
																					<!-- 부서명 사원명 end /// -->
																					<a class="forum-item-title">완료</a>
																					<div class="forum-sub-title"></div>
																				</div>


																			</div>
																		</div>

																		<c:forEach items="${MDT.todo}" var="e">

																			<c:if test="${e.state==1}">
																				<%--  <c:set var="count" value="${count+1}"/>
                       
                        <c:if test="${e.state==0}">
                       	 <c:set var="countzero" value="${countzero+1}"/>
                        </c:if>
                        
                        <c:out value="${e.state}"/>
                        <c:out value="${count}"/>
                        <c:out value="${countzero}"/>
                         --%>

																				<div class="forum-item">
																					<div class="row">
																						<div class="col-md-6">
																							<div class="forum-icon">
																								<i class="fa fa-bolt"></i>
																							</div>
																							<a href="forum_post.html"
																								class="forum-item-title">${e.t_CONTENT}</a>
																							<div class="forum-sub-title">할일상세보기</div>
																						</div>
																						<div class="col-md-2 forum-info">
																							<span class="views-number"> </span>
																							<div>
																								<small>${e.START_DATE}</small>
																							</div>
																						</div>

																						<div class="col-md-2 forum-info">
																							<span class="views-number"> </span>
																							<div>
																								<small>${e.END_DATE}</small>
																							</div>
																						</div>

																					</div>
																				</div>
																			</c:if>

																		</c:forEach>























																	</div>
																	<!--  <div class="ibox-content forum-container"> -->


																</div>
																<!--<div class="accordion-body">  -->




															</div>
															<!--   <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample"> -->


														</c:forEach>
														<c:if test="${fn:length(MydeptList)==0}">
															<h3 style="text-align: center">등록된 할일이 없습니다.</h3>
														</c:if>
													</div>
													<!--    <div class="accordion-item"> -->

												</div>
												<%-- 아코디언 끝 --%>



											</div>
										</div>
									</div>
								</div>
							</div>
						</section>
					</div>

				</div>
			</div>
		</div>


	</main>
	<jsp:include page="../Main/footer.jsp" />

</body>
</html>