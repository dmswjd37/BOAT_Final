
$(function()
{
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
   $("#comment table").hide();//1
   let page = 1; //더 보기에서 보여줄 페이지를 기억할 변수
   const count = parseInt($("#count").text());
   
   console.log(count);
   
   if(count != 0){ //댓글 갯수가 0이 아니면
      getList(1); // 첫 페이지의 댓글을 구해옵니다.(한 페이지에 3개씩 가져옵니다.)
   }
   else{ //댓글이 없는 경우
      $("#message").text("등록 된 댓글이 없습니다.");
   }
   
   let num = 0;
   let url = '';
   let data = {};
   
   function getList(currentPage)
   {
   
      $.ajax({
         type: "post",
         url: "../bcomment/list",
         data:{
            "board_num" : $("#board_num").val(),
            "page" : currentPage
            
         },
         
         dataType : "json",
         beforeSend : function(xhr)
        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        	xhr.setRequestHeader(header, token);			
        },
         success : function(rdata)
         {
            console.log(rdata);
            $("#count").text(rdata.listcount);
            

            
            if(rdata.listcount > 0)
            {
               $("#comment table").show();
               $("#comment tbody").empty();
               
               $(rdata.list).each(function()
               {
                  let output ='';
                  let img ='';
                  
                  if($("#loginid").text() == this.empno)
                  {
                     img = "<img src='../resources/img/pencil2.png' width='15px' class='update'>"
                        +" <img src='../resources/img/delete.png' width='15px' class='remove'>"
                        +" <input type='hidden' value='" + this.num + "'>";
                  }
                  
                  output += "<tr><td>" + this.empno + "</td>";
                  
                  //xss 권한이 없는 사용자가 웹 사이트에 스크립트 삽입하는 공격기법
                  //이것을 방지하기 위해 2번처럼 <td></td> 여역을 만든뒤 3번에서 text()안에
                  //this.content를 넣어 스크립트를 문자열로 만듭니다.
                  
                  output +="<td></td>"; //2
                  
                  //2번과 3번을 이용하지 않고 4번을 이용하면 스크립트가 있는 경우 스크립트가 실행
                  
                 
                  output +="<td>" + this.reg_date + img + "</td></tr>";
                  $("#comment tbody").append(output);
                  
                  //append한 마지막 tr의 2번째 자식 td를 찾아 text()메서드로 content를 넣습니다.
                  
                  $("#comment tbody tr:last").find("td:nth-child(2)").text(this.content);//3
                  
               });//each end
                  
               if(rdata.listcount > rdata.list.length){//전체 댓글수 > 현재까지 보여준 댓글수
               
                  $("#message").text("더보기");
               }
               else{
                  $("#message").text("");
               }
            }
            else{
               $("#message").text("등록된 댓글이 없습니다.");
               
               $("#comment table").hide();//1
            
            }
         }
      });//ajax end
   }
   
   $("#content").on('input',function(){
      let content = $(this).val();
      let length = content.length;
      
      if(length > 50){
         length = 50;
         content = content.substring(0, length);
         $(this).val(content);
      }
      $(".float-left").text(length+"/50")
   })
   
   $("#message").click(function(){
      getList(++page);
   });//click end
   
   //등록 또는 수정 완료 버튼
   //버튼의 라벨이 등록인 경우 댓글 추가
   //라벨이 수정완료 인 경우 업데이트
   
   $("#write").click(function(){
      const content = $("#content").val().trim();
      if(!content){
         alert("내용을 입력하세요")
         return false;
      }
      const buttonText = $("#write").text(); //버튼의 라벨 add할지 update할지 결정
      
      $(".float-left").text("총 50자 까지 가능합니다"); 
      
      console.log(buttonText);
      
      if(buttonText =="등록"){
    
         url = "../bcomment/add";
         data={
            "content": content,
            "empno" : $("#loginid").text(),
            "board_num" : $("#board_num").val()
         };
         
      }else{
      
         url = "../bcomment/update";
         data={
            "content": content,
            "num" : num
         };
         $("#write").text("등록");//등록상태로 변경
         $("#comment .cancel").remove();//취소버튼 삭제
      
      }
    let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
      $.ajax({
         type: "post",
         url: url,
         data: data,
         beforeSend : function(xhr)
        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        	xhr.setRequestHeader(header, token);			
        },
         success: function(result){
            $("#content").val('');
            if(result == 1){
               getList(page);//등록, 수정완료 후 해당 페이지를 보여줍니다.
            }//if
         }//success
      })//ajax
   
   })//$write
   
   $("#comment").on('click', '.update', function(){
   
      const before = $(this).parent().prev().text(); //선택한 내용을 가져옵니다.
      $("#content").focus().val(before); //textarea에 수정전 내용을 보여줍니다.
      
      num = $(this).next().next().val(); //수정 할 댓글 번호 저장
      $("#write").text("수정완료");//등록 버튼을 수정완료로 변경합니다.
      
      
      //이미 취소버튼이 만들어진 상태에서 또 수정을 클릭하면 취소가 계속됩니다.
      if(!$("#write").prev().is(".cancel"))
         $("#wrie").before('<button class="btn btn-danger float-right cancel">취소</button>');
         
      // 모든 행의 배경 색을 white로 지정
      
      $("#comment tr").css('background-color', 'white');
      
      //선택한 행의 배경색을 lightgray로 지정
      
      $(this).parent().parent().css('background-color', 'ligthgray'); //수정할 행의 배경색을 변경합니다.
      $(".remove").prop("disable", true); //[수정완료][취소] 중에는 삭제를 클릭할 수 없도록 합니다.
   })
     
   $("#comment").on('click', '.cancel', function(){
   		$("#comment tr").removeAttr('style'); // <background-color:'white','ligthgray' 속성제거
   		
   		$(this).remove(); //선택한 취소버튼 제거
   		$("#write").text("등록"); // 수정완료를 등록으로 변경
   		$("#content").val('');// content의 값 초기화
   		$(".remove").prop("disable", false);//삭제가 가능하게 합니다.
   	
   	});
   	
   	//delete.png 클릭
   	$("#comment").on('click', '.remove', function(){
   		if(!confirm("정말 삭제하시겠습니까?")){
   			return;
   		}
   		
   		const deleteNum = $(this).next().val();//댓글번호
   		
   		$.ajax({
   			type: "post",
   			url: "../bcomment/delete",
   			data: {
   				"num" : deleteNum
   			},
   			beforeSend : function(xhr)
        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        	xhr.setRequestHeader(header, token);			
        },
   			success: function(result){
   				if(result == 1)
   				{
   					//page = 1;
   					getList(page); // 삭제후 해당 페이지의 내용을 보여줍니다.
   				}
   			}
   		})//ajax end
   	})

});