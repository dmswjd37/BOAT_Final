<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- 내가 보낸 메세지 --%>
<c:if test="${empty requestScope.sender}">
	<div class="media w-50 ml-auto mb-3">
		<div class="media-body">
		    <div class="bg-primary rounded py-2 px-3 mb-2">
		    	<p class="text-small mb-0 text-white">${requestScope.content}</p>
		    </div>
	    	<p class="small text-muted">${requestScope.date}</p>
	  	</div>
	</div>
</c:if>
<%-- 상대방이 보낸 메세지 --%>
<c:if test="${!empty requestScope.sender}">
	<li class="left clearfix">
		<span class="chat-img pull-left">
			<img src="${pageContext.request.contextPath}/resources/${requestScope.profile}" alt="User Avatar">
		</span>
		<div class="chat-body clearfix">
			<div class="header">
				<strong class="primary-font" style="font-size: 0.9rem;">${requestScope.sender}</strong>
				<small class="pull-right text-muted" style="font-size: 0.8rem;"><i class="fa fa-clock-o" ></i>${requestScope.date}</small>
			</div>
			<p class="fs-6">${requestScope.content}</p>
		</div>
	</li>
</c:if>