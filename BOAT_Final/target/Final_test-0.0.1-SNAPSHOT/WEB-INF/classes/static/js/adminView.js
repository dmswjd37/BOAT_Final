function go(page) {
   const dept = $("#dept").val();
   const data = `dept=${dept}&state=ajax&page=${page}`; //el이 아닌 백틱 (js에서만 사용추천)
   ajax(data);
}

function search(page){
	let igo = "여기까지왔습니다";
	console.log(igo)
	const name2 = $("#search").val();
	const data2 = `name2=${name2}&state=search&page=${page}`;
	ajax(data2);
	
}





function setPaging(href,digit){
   let active="";
   let gray="";
   if(href==""){ //href가 빈문자열인 경우
      if(isNaN(digit)){//이전&nbsp; 또는 다음&nbsp;
         gray="gray";
      }else{
         active="active";
      }
   }
   let output = '<li class="page-item ${active}">';
   //let anchor = "<a class='page-link " + gray + "'" + href + ">" + digit + "</a></li>";
   let anchor = `<a class='page-link ${gray}' ${href}>${digit}</a></li>`;
   output += anchor;
   return output;
}

function ajax(sdata){
   console.log(sdata)
   
   $.ajax({ 
      type : "POST",
      data : sdata,
      url : "address.jk",
      dataType : "json",
      cache : false,
      success : function(data){
         
         
         
         if (data.listcount > 0) {//총 개수가 0보다 큰 경우
         $("#no_result").remove();
            $("#cardbody").remove();
            
            let output = "<div class='row' id='cardbody' style='width:100%'>";
            
            $(data.memberlist).each(
	
			function(index, item){
            let empno = item.empno;
            output += " <div class='col-md-3'>"
            output += "<p> </p>"
            let dept = item.dept;
            
            output += "<div class='card' style='height:376px'>"
            let name = item.name;
            output += " <div class='card-header' onclick=location.href='../memberInfo.net?empno=" +empno +"'  id='onclickpart1'>" + dept + "</div>"
            output +=  "<div style='width:100%; height:210px; object-fit:cover;'>" 
            let imgsrc = "/Boat"+item.imgsrc;
            //output += "<img src="+  imgsrc + " width='100%'/>"

            output += "<img src="+  imgsrc + " id='onclickpart2' onclick=location.href='../memberInfo.net?empno=" +empno +"' onerror=\"this.src='../image/ano.png'\" style='width:100%; height:100%; object-fit:cover;' />"

            output += "</div>"
            output += "<div class='card-body'>"
            output += "<h5 class='card-title' id='onclickpart3' onclick=location.href='../memberInfo.net?empno=" +empno +"'>" + name +"</h5>"
            let email = item.email;
            output += "<p class='card-text' id='ori-email-tag' onclick=location.href='../email.ne?empno="+ empno +"'>이메일: " + email + "</p>"
            //output += "<p class='card-text'>이메일: " + email + "</p>"
            //output += " <a href='#' class='btn btn-primary'>More</a>"
           
            
			
            
            
            output += "</div>"
            output += "</div>"
            output += "</div>"
            
            
         })
         output += "</div>"
         console.log(output);
          $("#whole-body").append(output)
          
          
           $(".pagination").empty(); //페이징 처리 영역 내용 제거
               output = "";
               
               let digit = '이전&nbsp;'
               let href="";
               if(data.page > 1){
                  href = 'href=javascript:go(' + (data.page-1) + ')';
               }
               output += setPaging(href, digit);
               
               for (let i = data.startpage; i <= data.endpage; i++){
                  digit = i;
                  href ="";
                  if ( i != data.page){
                     href = 'href=javascript:go(' + i + ')';
                  }
                  output += setPaging(href, digit);
               }
               
               digit = '&nbsp;다음&nbsp;';
               href="";
               if (data.page < data.maxpage) {
                  href = 'href=javascript:go(' + (data.page + 1) + ')';
               }
               output += setPaging(href,digit);
               
               console.log(output)
               $('.pagination').append(output);
            }//if(data.listcount>0)
            else{
			$("#cardbody").remove();
			$(".pagination").empty();
			let output = "<h3 id='no_result'> 결과값이 없습니다</h3>";
			$("#no_result").remove();
			$("#whole-body").append(output)
		}
                
            
         }, //success end
         error : function() {
            console.log('에러');
         }
   })//ajax end
}//function ajax end

//켜질때 데이터 받아오는 쿼리로




$(function(){
 $("#search-btn").click(function(){
	let wego= "form submit펑션까지 왔습니다";
	console.log(wego)
      search(1); //보여줄 페이지를 1페이지로 설정
   });

});



$(function(){
    
   $('#dept').change(function(){
      go(1); //보여줄 페이지를 1페이지로 설정
   });
   

  
});



