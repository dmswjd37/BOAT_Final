$(function(){
	//부서명 자동 선택
	let department = '${member.dept}'
	let part = 1;
	switch(department){
		case '개발팀':
			part=2;
			break;
		case '인사팀':
			part=3;
			break;
		case '기획팀':
			part=4;
			break;
		case '영업팀':
			part=5;
			break;
	}
	$('#select option:nth-child('+part+')').prop('selected',true)
		
	//submit 버튼 클릭할 때 이벤트 부분
	$("form").submit(function(){
		
		if($.trim($("#board_subject").val()) == ""){
			alert("제목을 입력하세요");
			$("#board_subject").focus();
			return false;
		}
		
		if($.trim($("#board_name").val()) == ""){
			alert("성함을 입력하세요");
			$("#board_subject").focus();
			return false;
		}
		
		if($.trim($("#board_pass").val()) == ""){
			alert("비밀번호를 입력하세요");
			$("#board_pass").focus();
			return false;
		}
		
		if($.trim($(".board_content").val()) == ""){
			alert("내용을 입력하세요");
			$(".board_content").focus();
			return false;
		}
	});//submit end
	
});//ready() end