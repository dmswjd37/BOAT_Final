$(document).ready(function(){
	
	let check = 0;
	
	//submit 버튼 클릭할때 이벤트 
	
		
	$("form[name=modifyform]").submit(function(){
		
		if($.trim($("#board_pass").val())==""){
			   toastr.options.escapeHtml = true;
       toastr.options.closeButton = true;
       toastr.options.newestOnTop = false;
       toastr.options.progressBar = true;
       toastr.info('비밀번호를 입력하세요.', {timeOut: 3000});
			$("#board_pass").focus();
			return false;
						
		}
		if($.trim($("#board_subject").val())==""){
			   toastr.options.escapeHtml = true;
       toastr.options.closeButton = true;
       toastr.options.newestOnTop = false;
       toastr.options.progressBar = true;
       toastr.info('제목을 입력해주세요.', {timeOut: 3000});
			$("#board_subject").focus();
			return false;
						
		}
		if($.trim($("#board_content").val())==""){
			   toastr.options.escapeHtml = true;
       toastr.options.closeButton = true;
       toastr.options.newestOnTop = false;
       toastr.options.progressBar = true;
       toastr.info('내용을 입력해주세요.', {timeOut: 3000});
			$("#board_content").focus();
			return false;
						
		}
		
		if(check == 0){
			const value = $('#filevalue').text();
			const html = "<input type='hidden' value'"+value+"' name='check'>";
			
			console.log(html);
			$(this).append(html);
			
		}
		
	});
	
	function show(){
		
		//파일이름이있는 경우 remove 이미지가 보이고 없으면 보이지 않습니다.
		
		if($('#filevalue').text()==''){
			$(".remove").css('display','none');
		
		}
		else{
			$(".remove").css({'display':'inline-block', 'position':'relative','top':'-5px'});
			
		}
		
		
	}
	show();
	
	$("#upfile").change(function(){
		check++;
		const inputfile = $(this).val().split('\\'); 
		
		$('#filevalue').text(inputfile[inputfile.length-1]);
		show();
		console.log(check);
		
	});
	
	$(".remove").click(function(){
		$('#filevalue').text('');
		$(this).css('display','none');
		$('#upfile').val('');//파일을 선택하고 remove 이미지를 클릭하면 input type=file의 값도 없앰
		
	})
	
});