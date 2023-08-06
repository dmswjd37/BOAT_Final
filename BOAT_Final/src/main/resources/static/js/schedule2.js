$(document).ready(function(){
	let output='';
	let result='1';
	//추가 버튼 클릭할 때 이벤트 부분
	$("#btn").click(function(){
		
		if($.trim($("#addValue").val()) == ""){
			alert("내용을 입력하세요");
			$("#addValue").focus();
			return false;
		}else{
			output += '<input class="form-check-input" type="checkbox" id="result'+result+'">'
			output += '<label class="form-check-label" for="result'+result+'">'
			output += $.trim($("#addValue").val())
			output += '</label>';
			result = result+1;
		}
		$('.order-list').html(output);
		
		$("#addValue").val('');
		$("#addValue").focus();
	});//submit end
});//ready() end