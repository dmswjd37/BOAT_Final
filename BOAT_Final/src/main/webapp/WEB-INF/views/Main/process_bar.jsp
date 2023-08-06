<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>	
	$(function(){
		window.onscroll = function () {
			myFunction();
		};
		function myFunction() {
			var winScroll =
					document.body.scrollTop || document.documentElement.scrollTop;
			var height =
					document.documentElement.scrollHeight -
					document.documentElement.clientHeight;
			var scrolled = (winScroll / height) * 100;
			document.getElementById("abboScrollBar").style.width = scrolled + "%";
		}
	});
</script>

<style>
	/* Progress Bar */
.progress-containers {
  position: fixed;
  width: 100%;
  height: 5px;
  background-color: #f2f4f6 !important;
	z-index: 10;
}

.progress-bars {
  width: 0%;
  height: 5px;

  background-color: #006fc7 !important;

}

.shadow-sm {
    top: 5px !important;
}

</style>


</head>
<body>
	<!-- Progress Bar -->
			<div class="progress-containers">
				<div class="progress-bars" id="abboScrollBar"></div>
			</div>
</body>
</html>