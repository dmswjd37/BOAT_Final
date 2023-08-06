<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<title>MVC 게시판 - view</title>
<script src="../resources/js/view.js" charset="UTF-8"></script>
<script>
	let result="${result}";
	if(result == 'passFail') {
		alert("비밀번호가 일치하지 않습니다.")
	}
	$(function(){
		$("form[action=delete]").submit(function() {
			if($("#board_pass").val() == '') {
				alert("비밀번호를 입력하세요");
				$("#board_pass").focus();
				return false;
			}
		})
	})
</script>
<style>
body > div > table > tbody >tr:nth-child(1) {
	text-align: center
}

td:nth-child(1) {
	width: 20%
}

a {
	color: white
}

body > div > table > tbody tr:last-child {
	text-align: center;
}

.btn-primary {
	background-color: #4f97e5
}

#myModal {
	display: none
}

#comment > table > tbody > tr > td:nth-child(2){
 width:53%
}
#count{
    position: relative;
    top: -10px;
    left: -10px;
    background: orange;
    color: white;
    border-radius: 30%;
}

textarea{resize:none}

form[action=down] > input[type=submit]{
    position: relative;
    top: -20px;
    left: 10px;
    border: none;
    cursor : pointer;
}

</style>
</head>
<body>
	<input type="hidden" id="loginid" value="${id}" name="loginid"> <%-- view.js에서 사용하기 위해 추가합니다. --%>
	<div class="container">
		
		
		
		<div id="comment">
			<button class="btn btn-info float-left">총 50자까지 가능합니다.</button>
			<button id="write" class="btn btn-info float-right">등록</button>
			<textarea rows=3 class="form-control" id="content" maxLength="50"></textarea>
			<table class="table table-striped">
				<thead>
					<tr><td>아이디</td><td>내용</td><td>날짜</td></tr>
				</thead>
				<tbody>
				
				</tbody>
			</table>
				<div id="message"></div>
		</div >
		
		
	</div> <%-- class="container" end --%>		
</body>
</html>










