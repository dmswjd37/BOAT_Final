<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:forEach var="user" items="${requestScope.userList}">
	<c:if test="${user != sessionScope.loginUser}">
		<li class="bounceInDown fs-6" data-uuid="${user.EMPNO}" onclick="roomEnter(this);">
			<a class="clearfix">
				<img src="${pageContext.request.contextPath}/resources/${user.PROFILE_FILE}" alt="" class="img-circle">
				<div class="friend-name">
					<strong>${user.NAME}</strong>
					<small class="small text-primary fs-6 text-danger" id="${user.EMPNO}">오프라인</small>
				</div>
				<div class="last-message text-muted">${user.EMPNO}</div>
				<small class="time text-muted"></small>
				<small class="chat-alert label label-danger"></small>
			</a>
		</li>
	</c:if>
</c:forEach>
