//boardList.jsp 내용을 js로 바꾸기

//앵커태크 스크립트를 쓰고싶으면 레디 밖에다 먼저 적어야함
/* 백틱(`) js에선 el로 인식 , jsp에선 안됨 */
function go(page) {
	const limit = $('#viewcount').val();
	const data = `limit=${limit}&state=ajax&page=${page}`;
	ajax(data);
}

//총 2페이지 페이징 처리된 경우
//이전 1 2 다음
//현재 페이지가 1페이지인 경우 아래와 같은 페이징 코드가 필요
//<li class="page-item"><a class="page-link gray">이전&nbsp;</a></li>
//<li class="page-item active"><a class="page-link">1</a></li>
//<li class="page-item"><a class="page-link" href="javascript:go(2)">2</a></li>
//<li class="page-item"><a class="page-link" href="javascript:go(2)">다음&nbsp;</a></li>

//현재 페이지가 2페이지인 경우 아래와 같은 페이징 코드가 필요
//<li class="page-item"><a class="page-link" href="javascript:go(1)">이전&nbsp;</a></li>
//<li class="page-item"><a class="page-link" href="javascript:go(1)">1</a></li>
//<li class="page-item active"><a class="page-link">2</a></li>
//<li class="page-item"><a class="page-link gray">다음&nbsp;</a></li>

function setPaging(href, digit) {
	let active="";
	let gray="";
	if(href=="") { //href가 빈문자열인 경우
		if(isNaN(digit)){ //이전&nbsp; 또는 다음&nbsp;
			gray="gray";
		}else{
			active="active";
		}
	}
	let output = `<li class="page-item ${active}">`;
	//let anchor = "<a class='page-link "+ gray + "'" + href + ">" + digit + "</a></li>";
	let anchor = `<a class='page-link ${gray}' ${href}>${digit}</a></li>`;
	output += anchor;
	return output;
}


function ajax(data) {
	//1줄보기 선택시 리턴된 데이터
	/*
	 {"listcount":10,"startpage":1,"limit":3,"boardlist":[{"uploadfile":
	 "board_NUM":7,"board_SUBJECT":"test","board_CONTENT": ....}
	*/
	console.log(data)
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	output="";
	$.ajax({
		type: "POST",
		data: data,
		url: "list_ajax",
		dataType: "json",
		cache: false,
		beforeSend : function(xhr)
        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        	xhr.setRequestHeader(header, token);			
        },
		success: function(data) {
			$("#viewcount").val(data.limit);
			$("thead").find("span").text("글 개수 : " + data.listcount);
			
			if(data.listcount > 0) { // 총갯수가 0보다 큰 경우
				$("tbody").remove();
				let num = data.listcount - (data.page - 1) * data.limit;
				console.log(num)
				let output = "<tbody>";
				$(data.boardlist).each(
					function(index, item) {
						output += '<tr><td>' + (num--) + '</td>'
						const blank_count = item.board_RE_LEV * 2 + 1;
						let blank = '&nbsp;';
						for (let i = 0; i < blank_count; i++) {
							blank += '&nbsp;&nbsp;';
						}
						
						let img ="";
						if (item.board_RE_LEV > 0) {
							img = "<img src='../resources/image/line.gif'>";
						}
						
						let subject=item.board_SUBJECT.replace(/</g,'&lt;')					
							subject=subject.replace(/>/g,'&gt;')
						
						
						output += "<td><div>" + blank + img
						output += ' <a href="detail?num=' + item.board_NUM + '">'
						output += subject + '<span class="gray small">[' + item.cnt + ']</span></a></div></td>'
						output += '<td><div>' + item.board_NAME + '</div></td>'
						output += '<td><div>' + item.board_DATA + '</div></td>'
						output += '<td><div>' + item.board_READCOUNT + '</div></td></tr>'
					})
				output += "</tbody>"
				$('table').append(output) //table 완성
				
				$(".pagination").empty(); //페이징 처리 영역 내용 제거
				output = "";
				
				let digit = '이전&nbsp;'
				let href = "";
				if(data.page > 1) {
					href = 'href=javascript:go(' + (data.page - 1) + ')';
				}
				output += setPaging(href, digit);
				
				for (let i = data.startpage; i <= data.endpage; i++) {
					digit = i;
					href="";
					if(i != data.page) {
						href = 'href=javascript:go(' + i + ')';
					}
					output += setPaging(href, digit);
				}
				
				digit = '&nbsp;다음&nbsp;';
				href="";
				if(data.page < data.maxpage) {
					href = 'href=javascript:go(' + (data.page + 1) + ')';
				}
				output += setPaging(href, digit);
				
				$('.pagination').append(output)
			}//if(data.listcount)>0 end
			
		}, //success end
		error : function(){
			console.log('에러')
		}
	})// ajax end
} //function ajax end



$(function() {
	$("#viewcount").change(function(){
		go(1); //보여줄 페이지를 1페이지로 설정합니다.
	}); // change end
	
	$("button").click(function(){
		location.href="write";
	})
	
	
})