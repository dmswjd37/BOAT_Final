const t_empno = $("#loginid").val();

//강제 새로고침
function reload() {
    (location || window.location || document.location).reload();
}

//조회
function getList(t_empno){
	
	console.log(t_empno);
	$.ajax({
			type:"post",
			url:"Todolist.my",
			data : {"t_empno" : $("#loginid").val()},
			dataType:"json",
			success :function(rdata){
				let output="";
				let output2="";
				
				if(rdata.todolist.length>0){
					
					
					$(rdata.todolist).each(function(){
						
						
					let content = this.t_content;
					//if(content.length>=55){
						//content=content.substr(0,55) + "...";//0부터 20개 부분 문자열 추출
					//}
					
						output += '<input class="form-check-input" name="chklist" type="checkbox" id="' +this.t_content+ '">'
						output += '<label class="form-check-label" for="'+this.t_content+'">' +content+ '</label>'
					})//each end
					
					$('.order-list').html(output);
					
					
					let per = rdata.ytodolist.length*100/rdata.ntodolist.length;
					let percent = per.toString();
					output2 += '<span>일정 현황 '+percent.substr(0,4)+'%</span>'
					output2 += '<progress value="'+rdata.ytodolist.length+'" max="'+rdata.ntodolist.length+'"></progress>'
					$('.graphbar').html(output2);
				}else{
					$('.order-list').empty();
					$('.graphbar').empty();
			 	}
			}// success end
	});//ajax end
	
}//getList end


//12시 삭제
function getDelete(t_empno){
	$.ajax({
			url: 'TodoDeleteAll.my',
			data : {t_empno : $("#loginid").val()},
			type : 'post',
			success : function(rdata) {
				if(rdata == 1){
					getList(t_empno);
				}
			}
		})//ajax
		
		$("#addValue").val('').focus();
}


$(document).ready(function(){
	getList(t_empno);
	$("#addValue").focus();
	
	//var date = new Date();
	//console.log(date.getHours())
	//console.log(date.getMinutes())
	//if(20-date.getHours()==0 && 36-date.getMinutes()==0){
		//getDelete(t_empno)
	//}
	//12시에 실행 실패
	
	
	
	
	//추가 버튼 클릭할 때 이벤트 부분
	$("#btn").click(function(){
		
		const content = $.trim($("#addValue").val());
		if(content == ""){
			alert("내용을 입력하세요");
			$("#addValue").focus();
			return false;
		}
		
		if($('label[for="'+content+'"]').text()==content){
		    alert("같은 문구는 추가할 수 없습니다.");
		    $("#addValue").val('').focus();
			return false;
		}
		
		//투두리스트 추가
		$.ajax({
			url: 'TodoAdd.my',//원문 등록
			data : {
				t_empno : $("#loginid").val(),
				t_content : content,//$('.comment-write-area-text').val()
			},
			type : 'post',
			success : function(rdata) {
				
				if(rdata == 1){
					getList(t_empno);
					
				}
			}
		})//ajax

		reload()
		$("#addValue").val('').focus();
	});//click end
	
	
	
	
	
	//완료 버튼 클릭할 때 이벤트 부분
	$("#submitbtn").click(function(){
		
		const content = $.trim($("#addValue").val());
		var checkboxValues = [];
		
		$("input:checkbox[name=chklist]:checked").each(function(){
			checkboxValues.push($(this).next().text());
		});
		
		console.log(checkboxValues);
		//var allData = { t_empno: content, "checkArray": checkboxValues };
		//let ival=$("input:checkbox[name=chklist]:checked").next().text()
		
		
		//'N' -> 'Y' 변경
		$.ajax({
			url: 'TodoCheck.my',
			traditional : true,
			data : {t_empno : $("#loginid").val(), checkArray: checkboxValues},
			type : 'post',
			success : function(rdata) {
				
				if(rdata == 1){
					getList(t_empno);
				}
			}
		})//ajax
		
		reload()
		$("#addValue").val('').focus();
	});//click end
	
	
	
	//삭제 버튼
	$("#resetbtn").click(function(){
		
		const content = $.trim($("#addValue").val());
		var checkboxValues = [];
		
		$("input:checkbox[name=chklist]:checked").each(function(){
			checkboxValues.push($(this).next().text());
		});
		
		
		$.ajax({
			url: 'TodoDelete.my',
			traditional : true,
			data : {t_empno : $("#loginid").val(), checkArray: checkboxValues},
			type : 'post',
			success : function(rdata) {
				if(rdata == 1){
					getList(t_empno);
				}
			}
		})//ajax
		
		reload()
		$("#addValue").val('').focus();
	});//click end
	
	
	
	//전체 삭제 버튼
	$("#allresetbtn").click(function(event){
		
		const answer = confirm("정말 삭제하시겠습니까?");
  		console.log(answer);//취소를 클릭한 경우-false
  		if(!answer){//취소를 클릭한 경우
  			event.preventDefault();//이동하지 않습니다.
  		}
		
		$.ajax({
			url: 'TodoDeleteAll.my',
			data : {t_empno : $("#loginid").val()},
			type : 'post',
			success : function(rdata) {
				if(rdata == 1){
					getList(t_empno);
				}
			}
		})//ajax
		
		reload()
		$("#addValue").val('').focus();
	});//click end
	
	
	
	
});//ready() end