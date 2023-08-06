$(document).ready(function(){
let token = $("meta[name='_csrf']").attr("content");
let header = $("meta[name='_csrf_header']").attr("content");


 $('#summernote').summernote({
	        placeholder: '내용을 입력하세요',
	        tabsize: 2,
	        lang : "ko-KR",
	        height: 200,
	        enterParagraphs: false,
	        codeview: true
	      });




	//submit할때 이벤트 부분
	$('#boardform').submit(function(){
	
	  var content = $('#summernote').summernote('code').replace(/(<p>|<\/p>)/ig, '');
	  
    	$('#summernote').val(content);
    	
	
	
	if ($("#board_notice").is(":checked")) {
            $("#board_notice").val("1");
        } else {
            $("#board_notice").val("0");
        }
     var tes = $("#board_notice").val();
     


		
		if($.trim($("#board_pass").val()) ==""){
		console.log('걸림 board_pass')
	   toastr.options.escapeHtml = true;
       toastr.options.closeButton = true;
       toastr.options.newestOnTop = false;
       toastr.options.progressBar = true;
       toastr.info('비밀번호를 입력해주세요.','업무 게시판', {timeOut: 3000});
			$("#board_pass").focus();
			return false;
		}
		if($.trim($("#board_subject").val()) ==""){
			   toastr.options.escapeHtml = true;
       toastr.options.closeButton = true;
       toastr.options.newestOnTop = false;
       toastr.options.progressBar = true;
       toastr.info('제목을 입력해주세요.','업무 게시판', {timeOut: 3000});
			$("#board_subject").focus();
			return false;
		}
		if($.trim($("#summernote").val()) ==""){
			   toastr.options.escapeHtml = true;
       toastr.options.closeButton = true;
       toastr.options.newestOnTop = false;
       toastr.options.progressBar = true;
       toastr.info('내용을 입력해주세요.','업무 게시판', {timeOut: 3000});
			$("#summernote").focus();
			return false;
		}
	}); //submit end
	

	
	
	
}); //ready() end