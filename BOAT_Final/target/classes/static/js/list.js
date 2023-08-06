function go(page){
	let search_field = $('#country').val();//검색 셀렉트
	
	let search_word = $('#search_word').val().trim();//검색어
	
	let department = $('#department').val();//부서명
	
	let listse = $('#listse').val();//정렬
	
	const data = `state=ajax&page=${page}&search_field=${search_field}&search_word=${search_word}&department=${department}&listse=${listse}`;
	ajax(data);
}


function ajax(sdata){
	console.log(sdata)
	
	$.ajax({
		type : "POST",
		data : sdata,
		url : "BoardList.bo",
		dataType : "json",
		cache : false,
		success : function(data){
			//$("#country").val(0).prop("selected", true);
			//$('input').attr("placeholder", "작성자를 입력하세요.");
			$(".search-window").find("span").text("총 글 개수 : " + data.listcount);
			
			if(data.listcount > 0){//총갯수가 0보다 큰 경우
				$("tbody").remove();
				let num = data.listcount - (data.page - 1) * data.limit;
				let nowday = data.nowday;
				console.log(num)
				console.log('nowday='+nowday)
				let output = "<tbody>";
				
				$(data.boardlist).each(function(index, item){
					output += '<tr><td>'
					if(item.board_notice == 'Y'){
						output += '공지' + '</td>'
						num--
					}
					if(item.board_notice == 'N'){
						output += (num--) + '</td>'
					}
					const blank_count = item.board_re_lev * 2 + 1;
					console.log('blank_count='+blank_count);
					let blank = '&nbsp;';
					let blank1 = '&nbsp;';
					for(let i = 1; i <blank_count; i++){
						blank += '&nbsp;';
					}
					
					let img="";
					if(item.board_re_lev > 0){
						img='<img src="ejYang/image/line.png">';
					}
					
					let subject=item.board_subject;
					if(subject.length>=20){
						subject=subject.substr(0,20) + "...";//0부터 20개 부분 문자열 추출
					}
					
					let date=item.board_date
					console.log('date='+date)
					let img2="";
					if(date > nowday){
						img2="<img src='ejYang/image/new.jpg' id='new'>"
					}
					
					output += '<td class="title-td"><div>' + blank + img
					
					if($('#loginboard')==null){
						output += '<a href="BoardDetailAction.bo?num='+ item.board_num + '">'
					}
					output += subject.replace(/</g,'&lt;').replace(/>/g,'&gt;')
									+ '</a>'+blank1+'[' + item.cnt + ']'
					output += img2 + '</div></td>'
					output += '<td><div>' + item.board_dept + '</div></td>'
					output += '<td><div>' + item.board_name + '</div></td>'
					output += '<td><div>' + item.board_readcount + '</div></td>'
					output += '<td><div>' + item.board_date + '</div></td></tr>'
				})
				output += '</tbody>'
				$('table').append(output)//table 완성
				
				$(".page_nation").empty();//페이징 처리 영역 내용 제거
				output = "";
				
				let href="";
				if(data.page > 1){
					href = 'href=javascript:go(' + (data.page -1) + ')';
					output += '<a class="arrow prev" '+href+'></a>';
				}else{
					output += '<a class="arrow prev gray"></a>';
				}
				
				for(let i = data.startpage; i <= data.endpage; i++){
					digit = i;
					href="";
					if(i != data.page){
						href = 'href=javascript:go(' + i + ')';
						output += '<a '+href+' class="page-link">'+digit+'</a>';
					}else{
						output += '<a class="page-link active">'+digit+'</a>';
					}
				}
				
				href="";
				if(data.page < data.maxpage){
					href = 'href=javascript:go(' + (data.page +1) + ')';
					output += '<a class="arrow next" '+href+'></a>';
				}else{
					output += '<a class="arrow next gray"></a>';
				}
				
				$('.page_nation').append(output)
			}//if(data.listcount)>0 end
			else{
				$('tbody').empty();
				output = '<tr><td colspan="6"><h2>글이 없습니다.</h2></td></tr>'
				$('tbody').append(output)
			}
		},//success end
		error : function(){
			console.log('에러')
		}
	})//ajax end
}//function ajax end


$(function(){
	//let search_field = $('#country').val();
	//console.log('search_field='+search_field)	
	
	
	
	//검색 버튼 클릭한 경우
	$(".btn-dark").click(function(){
		//검색어 공백 유효성 검사합니다.
		if($("#search_word").val() == ''){
			alert("검색어를 입력하세요.");
			$("#search_word").focus();
			return false;
		}
		
		go(1);
	});//button click end
	
	
	//검색 클릭 후 응답화면에는 검색시 선택한 필드가 선택되도록 합니다.
	let selectedValue = '${search_field}'
	if(selectedValue != -1)
		$('#country').val(selectedValue);
	else
		selectedValue=0;	//선택된 필드가 없는 경우 기본적으로 작성자를 선택하도록 합니다.
	console.log('selectedValue='+selectedValue)	
	
	
	//검색 후 selectedValue값에 따라 placeholder가 나타나도록 합니다.
	const message = ["작성자를","제목을"];
	$('input').attr("placeholder", message[selectedValue] + " 입력하세요.");
	
	
	
	//부서명 변경한 경우
	$("#department").change(function(){
		go(1);
	});
	
	//정렬 변경한 경우
	$("#listse").change(function(){
		go(1);
	});
	
	//검색어 입력창에 placeholder가 나타나도록 합니다.
	$('#country').change(function(){
		selectedValue = $(this).val();
		$("input").val('');
		const message = ["작성자를","제목을"];
		$("input").attr("placeholder",message[selectedValue] + " 입력하세요.");
	})//$('#country').change end
	
	if($('#loginboard').val()===""){
		alert('로그인 후 사용 가능한 게시판입니다.')	
	}
	
	$(".page_wrap button").click(function(){
		location.href="BoardWrite.bo";
	})
	
	
})