<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인팝업창</title>

<style>
font-family: SF Pro KR, SF Pro Display, SF Pro Icons, AOS Icons, Apple Gothic, HY Gulim, MalgunGothic, HY Dotum, Lexi Gulim, Helvetica Neue, Helvetica, Arial, sans-serif;
.layerPopup img{
margin-bottom : 20px;}
.layerPopup:before {
		display:block; content:""; 
		position:fixed; 
		left:0; 
		top:0; 
		width:100%; 
		height:100%; 
		background:rgba(0,0,0,.5); 
		z-index:9000
}

.layerPopup .layerBox {    
		z-index:10000;   
		position:fixed; 
		left:50%; 
		top:50%; 
		transform:translate(-50%, -50%); 
		padding:30px; 
		background:#fff; 
		border-radius:6px; 
}

.layerPopup .layerBox .title {
		margin-bottom:10px; 
		padding-bottom:10px; 
		font-weight:600; 
		border-bottom:1px solid #d9d9d9;
		}
		
.layerPopup .layerBox .btnTodayHide {
		font-size:14px; 
		font-weight:600; 
		color:black; 
		float: left;
		text-decoration:none;
		width: 150px; 
		height : 30px;
		line-height:30px;
		border:black solid 1px; 
		text-align : center;
		text-decoration:none;
}


.layerPopup form{
	margin-top : 5px;
	font-size:16px; font-weight:600;
	weight: 100%;
	height : 30px;
	line-height:30px
}
.layerPopup #close {
	font-size:16px; 
	font-weight:600; 
	width: 40px; 
	height : 30px;
	color:black; 
	float: right; 
	line-height:30px; 
	text-align : center;
	text-decoration:underline;
}
.layerPopup a{
	text-decoration : none;
	color : black;width: 50px;height : 40px;
}
</style>


 
</head>
<body>
<!-- layer popup content -->
<div class="layerPopup" id="layer_popup" style="visibility: visible;">
    <div class="layerBox">
        <h2 class="title" style="text-align:center;">공지사항</h2>
        <div class="content_box">
        	<br><h3>BOAT 인사과 전달사항</h3><br>
        	<h4>여름휴가 및 대체공휴일</h4><br>
        	<div style="background-color:black !important;">
        	<div class="content_smallbox" style="padding:20px !important; background-color:#f1f1f1 !important;">
        	
        	<h5 style="line-height: normal;">
       
        	안녕하세요, boat 입니다.<br>
        	상반기 또한 여러분들의<br>
        	노고에 감사드리며,<br>
    		휴가 안내 드립니다.<br>
    		<hr>
    		5월 1일(일) 근로자의 날<br>
    		-> 5월 2일(월) 대체휴무,<br>
    		5월 5일(금) 어린이날 휴무를 시작으로<br>
    		-> 5월 8일(월)까지 휴무,<br>
    		5월 27일(토) 부처님오신날<br>
    		-> 5월 29일(월) 대체휴무 <br>  		
        	</h5>
        	</div>
        	</div>
			
        </div>
          <form name="pop_form">
        <div id="check" ><input type="checkbox" name="chkbox" value="checkbox" id='chkbox' >
        <label for="chkbox">&nbsp&nbsp오늘 하루동안 보지 않기</label></div>
		<div id="close" ><a href="javascript:closePop();">닫기</a></div>    
		</form>
	</div>
</div>

<script>
//쿠키 읽어오기
cookiedata = document.cookie;   
console.log("#="+cookiedata);
console.log( cookiedata.indexOf("maindiv=done") < 0)
if ( cookiedata.indexOf("maindiv=done") < 0 ){     
    console.log("2")
    document.getElementById('layer_popup').style.visibility = "visible";
}
else {
    console.log("3")
    document.getElementById('layer_popup').style.visibility = "hidden";
}


//head 태그 안에 스크립트 선언
function setCookie( name, value, expiredays ) {
    var todayDate = new Date();
    todayDate.setTime(todayDate.getTime() + (expiredays * 1000 * 60 * 60)); // expiredays시간 후로 설정
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function closePop() {
	
	console.log("1")
	
    if ( document.pop_form.chkbox.checked ){
        setCookie( "maindiv", "done" , 6 ); // 6시간
    }
    document.getElementById('layer_popup').style.visibility = "hidden";
} 
</script>

</body>



</html>