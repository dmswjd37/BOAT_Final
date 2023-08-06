$(document).ready(function(){
	let check = 0;
	let check2 = 0;

	  $('#summernote').summernote({
	        placeholder: '내용을 입력하세요',
	        tabsize: 2,
	        lang : "ko-KR",
	        height: 300
	      });
	      
	   var loginDept = $('#loginDept').text();
	  // $('#dropdownMenuLink').text(loginDept);
	      //부서선택
$('body > div.container > form > div:nth-child(5) > div > div > ul > li > a').click(function(){
			const dept =$(this).text();
				console.log(dept)
			const sel =$('#dropdownMenuLink').text();
			
		$('#dropdownMenuLink').text(dept);
			console.log(sel)
		
			
		$('#dept').val(dept);
			console.log($('#dept').val())	
			return false;
	
	})//drop downclick 끝
	
	function show(){
		//파일이름이 있는 경우 remove이미지를 보이게 하고
		//파일이름이 없는 경우 remove 이미지를 보이지 않게 합니다.
		
		if($("#filevalue").text()==''){
			$('.remove1').css('display','none');
		}else{
			$(".remove1").css({'display':'inline-block',
							'position':'relative','top':'-5px'});
			
		}
		if($("#filevalue2").text()==''){
			$('.remove2').css('display','none');
		}else{
			$(".remove2").css({'display':'inline-block',
							'position':'relative','top':'-5px'});
		}
	}//show end
	show();

$("#upfile").change(function(){
	check++
	console.log($(this).val())
	const inputfile = $(this).val().split('\\');//c:\facepath\upload.png
	$('#filevalue').text(inputfile[inputfile.length -1]);
	$('.remove1').css('display','inline-block');
	$('.file2').css('display','block');

});

$("#upfile2").change(function(){
	check2++
	console.log($(this).val())
	const inputfile2 = $(this).val().split('\\');//c:\facepath\upload.png
	$('#filevalue2').text(inputfile2[inputfile2.length -1]);
	$('.remove2').css('display','inline-block');
	});

$(".remove1").click(function(){
			
	$('#filevalue').text('');
	$(this).css('display','none');
	
	
	
})
	$(".remove2").click(function(){
	$('#filevalue2').text('');
	$(".remove2").css('display','none');
	
})


	
	
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
		if($.trim($('#dropdownMenuLink').text())== "부서"||$.trim($('#dropdownMenuLink').text())== ""){
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
		
			//파일첨부를 변경하지 않으면 #('#filevalue').text()의 파일명을
			//파라미터 'check'라는 이름으로 form에 추가하여 전송합니다.
			if(check ==0){
				const value =$('#filevalue').text();
				const html = "<input type='hidden' value='"+value+"' name ='check'>";
				console.log(html);
				$(this).append(html);
				
			}
			if(check2 ==0){
				const value2 =$('#filevalue2').text();
				const html = "<input type='hidden' value='"+value2+"' name ='check2'>";
				console.log(html);
				$(this).append(html);
				
			}
	});//submit end
	
});//ready() end