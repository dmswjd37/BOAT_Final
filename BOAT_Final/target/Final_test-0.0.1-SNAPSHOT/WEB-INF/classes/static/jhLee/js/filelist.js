let token = $("meta[name='_csrf']").attr("content");
let header = $("meta[name='_csrf_header']").attr("content");
let empno = $('#loginid').text();

function GOfav(page){
    const favdata ={"EMPNO":empno
                    ,"page":page}
  //  const data = `state=ajax&page=${page}&searchsel=${searchsel}&searchinput=${searchinput}&dept=${dept}&order=${order}`;
    ajax(favdata,"/boat/Filebo/FAV_list");
}







function go(page){
    searchsel = $("#searchsel").text();
    if(searchsel =="제목")
    searchsel ="TITLE";
    else if(searchsel=="작성자" )
    searchsel ="NAME";
    else
    searchsel ="";

    searchinput = $("#searchinput").val().trim();

    dept = $("#DEPT").text();
    if(dept.trim() =="부서별"||dept=="전체")dept = "";

    order = $("#ORDER").text();
    
    if(order.trim() =="정렬")order ="";
    else if(order.trim() =="최신순")order ="RECENT";
    else if(order.trim() =="조회순")order ="READCOUNT";
    else if(order.trim() =="댓글순")order ="COMMCOUNT";
    
    console.log(order)

    const data = `state=ajax&page=${page}&searchsel=${searchsel}&searchinput=${searchinput}&dept=${dept}&order=${order}`;
    ajax(data,"/boat/Filebo/list_ajax");
};


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
	let output = '<li class="page-item '+active+'">';
	//let anchor = "<a class='page-link " + gray + "'" + href + ">" + digit + "</a></li>";
	
	let anchor = `<a class='page-link ${gray}' ${href}>${digit}</a></li>`;
	output += anchor;
	return output;

}//setpaging끝

function ajax(sdata,URL){
console.log("ajax함수안"+sdata);
// sdata = `state=ajax&page=${page}&searchsel=${searchsel}&searchinput=${searchinput}&dept=${dept}&order=${order}`;
$.ajax({
    type : "GET",
    data: sdata,
    url : URL,
    dataType : "json",
   // beforeSend: function (jqXHR, settings) {
    //    jqXHR.setRequestHeader(header, token);
     //   },
    cache: false,
    //정적브라우저 환경에서는 true로 계속 바뀔 필요가 없지만  그게 아니라면 계속 바뀌어야합니다.
    success : function(data){
      //  $("table").find("span").text("글 개수 : "+data.listcount);
        
        if(data.listcount>0){//총 갯수가 0보다 큰 경우
            $("tbody").remove();
            
            let num = data.listcount-(data.page-1)*data.limit;
            let nowday = new Date(data.nowday);
            console.log(num)
            let output ="<tbody>";
            $(data.boardlist).each(
                function(index,item){
                if(item.filebo.star.contains(empno))
output+="<tr><td><i class='bi bi-star-fill' style='color:#ffd699' id='star" + item.file_NUM +"' onclick='toggle("+ item.file_NUM + ","+empno+")'></i></td><td>"
else
output+="<tr><td><i class='bi bi-star' id='star" + item.file_NUM +"' onclick='toggle("+ item.file_NUM + ","+empno+")'></i></td><td>"
    					// output+="<tr><i class='bi bi-star-fill' style='color:#ffd699'id='star${FILIBO.FILE_NUM}' onclick='toggle(${FILIBO.FILE_NUM}, ${EMPNO})"></i><td title='즐겨찾기' class='text-center'></td><td>"
			            
			            
                    let img="";
                    if(item.file_RE_LEV>0){
                        img='<img alt="파일다운2" src="${pageContext.request.contextPath}/jhLee/img/download.png"class="file"style="width:20px">'
                    }
                    let subject = item.file_SUBJECT;
                    if(subject.length>=20){
                        subject = subject.substr(0,20)+"...";
                    }
                            //let today = new Date();
                            
                          let today= moment().format().substr(0,10)
                            
                            console.log("nowday"+nowday)
                            console.log(item.file_DATE > nowday)
                            let imgnew ="";
                            if(new Date(item.file_DATE) > nowday){
                                imgnew="<img src='../../boat/jhLee/img/new.png' id='new' style='width:20px'>";
                            }
                            let blank = "  ";
                    output +=blank+blank+blank+"<a href='detail?num="+item.file_NUM+"'>"+blank+blank+blank
                    output += subject.replace(/</g,'&lt;').replace(/>/g,'&gt;')
                            +'</a>['+item.cnt+']'+imgnew+'</div>'
                    
                    output +='<span class="badge badge-pill badge-warning float-right"style="background-color: #89a5ea;">'+item.dept+'</span></td>'
                    
                    
                    
                    
                    
                    output +='<td><small>'+item.file_NAME+'</small></a></td>'
                    output +='<td>'+item.file_READCOUNT+'</td>'
					let ckday = item.file_DATE.substr(0,10)
					console.log(ckday);
					console.log(today+"today");
                    if(ckday ==today)
                    filedateTime= item.file_DATE.substr(5,11)
                    else 
                    filedateTime = item.file_DATE.substr(5,5)
                    
                    output +='<td><div class="date">'+filedateTime+'</div></td>'

                    let fileimg =""
                    let fileimg2 =""
                    if(item.file_FILE!=null)
                    fileimg ='<img alt="파일다운2" src="../../boat/jhLee/img/download.png" class = "file"style="width:20px">';
                    if(item.file_FILE2!=null)
                    fileimg2 ='<img alt="파일다운2" src="../../boat/jhLee/img/download.png" class = "file"style="width:20px">';
                    
                    output+='<td><div class = "file1">'+fileimg+'</div></td>'
                    output+='<td><div class = "file2">'+fileimg2+'</div></td>'
                    
                            +'</tr>'
                })
            output+="</tbody>"
            $('table').append(output)//table끝
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
            
            digit = '다음&nbsp;';
            href="";
            if (data.page < data.maxpage) {
                href = 'href=javascript:go(' + (data.page + 1) + ')';
            }
            output += setPaging(href,digit);
            
            $('.pagination').append(output);
        }//if(data.listcount)>0 end
        else{
                $("tbody").empty();
                $('tbody').append("<tr><td colspan ='8'><h2>검색내용이 없습니다</h2></td></tr>")//table끝
                    $(".paging").empty();
        }
    },
    error:function(){
        console.log('에러')
    }
})//$.ajax끝
}//ajax끝


var searchsel;
var searchval;
var dept;
var order;

///////////////////////ready()
$(function() {
    //즐겨찾기 클릭
    $('body > section > div > table > thead > tr > th:nth-child(1)').click(function(){
    
   let state=  $('.favorite').text()
        if(state=="즐겨찾기"){
            GOfav(1)
            $('.favorite').text('');
        }else{
            location.href='../../boat/Filebo/list'
            $('.favorite').text('즐겨찾기');
        }
   })





   //star누르면 색깔 변하고 insert delete
   
//$('body').on('click','.star',function(event){

  //  if($(this).prop('class')=='bi-star'){
   //     console.log('bi-star')
//    $(this).removeClass('bi-star')
//            //    .addClass('bi-star-fill')
//               
 //   }else{
  //  //if($(this).hasClass('bi-star-fill')){
   //     console.log('bi-star-fill')
    //    $(this).removeClass('bi-star-fill')
               // .addClass('bi-star')}
//    }
    //}else{
   
    //$(this).css('background','yellow');



if($('#empno').val()===""){
alert('로그인 후 사용 가능한 게시판입니다.')	
}

//===================================================
    //글쓰기 버튼
$("#write").click(function() {
        location.href = "write";
})		


$("#searchinput").attr('placeholder','검색어를 입력하세요')

$('body > section > h3 > div > div > div > ul > li > a').click(function(){
       
    searchval= $(this).text();
    console.log(searchval);
    $("#searchsel").text(searchval);
    
    $("#searchinput").focus();
    if($("#searchsel").text() === "제목"){
        $("#searchinput").attr('placeholder','제목을 입력하세요')
        console.log(searchval);
    }else if($("#searchsel").text() === "작성자"){
        $("#searchinput").attr('placeholder','이름을 입력하세요')
    }


})

$("#searchinput").keyup(function(event){
    if(event.keyCode==13) {
        go(1);
        }
})
//돋보기
$("#searhcbtn2").click(function(){
    if($("#searchinput")==""){
        alert('검색어를 입럭하세요.')
        return false;
    }
    
    if($("#searchsel").text()==="검색옵션")
    {alert("검색 옵션을 선택하세요.")
    return false;}
    
    go(1);
});
//부서별
$('body > section > div > div > div > div:nth-child(2) > ul > li > a').click(function(){
    searchdept = $(this).text();
    $('#DEPT').text(searchdept);
        $('#deptval').val(searchdept);
        go(1);
    
        console.log(searchdept);
});
        
$('body > section > div > div > div > div:nth-child(4) > ul > li > a').click(function(){
     order =$(this).text();
        $('#ORDER').text(order)
        $('#orderval').val(order);
        console.log(order);

        go(1);
})


//})//button 끝

})//ready 끝