<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- 내가 보낸 메세지 --%>
<li class="right clearfix">
	<span class="chat-img pull-right">
		<img src="${pageContext.request.contextPath}/resources/${requestScope.profile}" alt="User Avatar">
	</span>
	<div class="chat-body clearfix">
		<div class="header">
			<strong class="primary-font" style="font-size: 0.9rem;">나</strong>
			<small class="pull-right text-muted" style="font-size: 0.8rem;"><i class="fa fa-clock-o"></i>${requestScope.date}</small>
		</div>
		<p class="fs-6">${requestScope.content}</p>
	</div>
</li>