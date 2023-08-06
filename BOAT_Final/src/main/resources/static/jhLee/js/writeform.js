$(document).ready(function(){
	
	  $('#summernote').summernote({
	        placeholder: '내용을 입력하세요',
	        tabsize: 2,
	        lang : "ko-KR",
	        height: 300
	      });
	      
	   var loginDept = $('#loginDept').text();
	   $('#dropdownMenuLink').text(loginDept);
	      

//dept dropdown 입력칸
// #dropdownMenuLink
$('body > div.container > form > div:nth-child(5) > div > div > ul > li > a').click(function(){
// $('#deptbutton+div a').click(function(){
			const dept =$(this).text();
				console.log(dept)
			const sel =$('#dropdownMenuLink').text();
			
		$('#dropdownMenuLink').text(dept);
			console.log(sel)
		
			
		$('#dept').val(dept);
			console.log($('#dept').val())	
			return false;
	
	})//drop downclick 끝
	
	

$("#upfile").change(function(){
	console.log($(this).val())
	const inputfile = $(this).val().split('\\');//c:\facepath\upload.png
	$('#filevalue').text(inputfile[inputfile.length -1]);
	$('.file2').css('display','block');
	});
$("#upfile2").change(function(){
	console.log($(this).val())
	const inputfile2 = $(this).val().split('\\');//c:\facepath\upload.png
	$('#filevalue2').text(inputfile2[inputfile2.length -1]);
	});
	
	
	//submit 버튼 클릭할 때 이벤트 부분
	$("form").submit(function(){
		
		if($.trim($("#FILE_SUBJECT").val()) == ""){
			toastr.options.escapeHtml = true;
			toastr.options.closeButton = true;
			toastr.options.newestOnTop = false;
			toastr.options.progressBar = true;
			toastr.info('제목을 입력하세요', '자료실 게시판', {timeOut: 3000});

			$("#FILE_SUBJECT").focus();
			console.log($("#FILE_SUBJECT").val());
			return false;
		}
		
		
			const name=$.trim($("#FILE_NAME").val());
			
		if($.trim($("#FILE_NAME").val())==""){
			toastr.options.escapeHtml = true;
			toastr.options.closeButton = true;
			toastr.options.newestOnTop = false;
			toastr.options.progressBar = true;
			toastr.info('이름을 입력하세요', '자료실 게시판', {timeOut: 3000});

			$("FILE_NAME").focus();
			return false;	
			}
			
		if(name.length >10){
			toastr.options.escapeHtml = true;
			toastr.options.closeButton = true;
			toastr.options.newestOnTop = false;
			toastr.options.progressBar = true;
			toastr.info('이름의 최대 글자는 10글자입니다.', '자료실 게시판', {timeOut: 3000});

			$("FILE_NAME").focus();
			return false;
		}
		if($.trim($('#dropdownMenuLink').text())== "부서"){
			toastr.options.escapeHtml = true;
			toastr.options.closeButton = true;
			toastr.options.newestOnTop = false;
			toastr.options.progressBar = true;
			toastr.info('부서를 선택하세요', '자료실 게시판', {timeOut: 3000});

			return false;
			
		} 
		if($.trim($("#FILE_PASS").val()) == ""){
			toastr.options.escapeHtml = true;
			toastr.options.closeButton = true;
			toastr.options.newestOnTop = false;
			toastr.options.progressBar = true;
			toastr.info('비밀번호를 입력하세요', '자료실 게시판', {timeOut: 3000});

			$("#FILE_PASS").focus();
			return false;
		}

		
		if($.trim($("#summernote").val()) == ""){
			toastr.options.escapeHtml = true;
			toastr.options.closeButton = true;
			toastr.options.newestOnTop = false;
			toastr.options.progressBar = true;
			toastr.info('내용을 입력하세요', '자료실 게시판', {timeOut: 3000});

			$("#FILE_CONTENT").focus();
			return false;
		}
		if($.trim($("#filevalue").text())==""){
			toastr.options.escapeHtml = true;
			toastr.options.closeButton = true;
			toastr.options.newestOnTop = false;
			toastr.options.progressBar = true;
			toastr.info('자료실 게시판입니다. 하나 이상의 자료를 입력해주세요.', '자료실 게시판', {timeOut: 3000});

			return false;
		}
		
	});//submit end
	
});//ready() end