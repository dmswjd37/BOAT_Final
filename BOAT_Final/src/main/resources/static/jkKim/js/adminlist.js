var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var auth2 = $('#hidden_auth').val();

function go(page,dept) {
	console.log('go2');
	
	$('.breadcrumb-item').removeClass('active'); 
	$('.breadcrumb-item a').addClass('text-white'); 
	$('a[href="javascript:go(1,\''+dept+'\')"]').removeClass('text-white');
	$('a[href="javascript:go(1,\''+dept+'\')"]').parent('li').addClass('active'); 
	
	
	const data = `dept=${dept}&page=${page}`;
	
	ajax(data); //fav_list용
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
	
	let output = '<li class="page-item ' + active + '">';
	let anchor = "<a class='page-link " + gray + "'" + href + ">" + digit + "</a></li>";
	
	//let anchor = `<a class='page-link ${gray}' ${href}>${digit}</a></li>`;
	output += anchor;
	return output;
}


function ajax(sdata){
	
	
	$.ajax({ //줄보기로 개수 바꾸면 그거에 맞게 새로고침안하고 변하게 하기 위해서 ajax쓴다.
		type : "POST",
		data : sdata,
		url : "../../boat/admin/list_ajax",
		dataType : "json",
		cache : false,
		beforeSend : function(xhr)
        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        	xhr.setRequestHeader(header, token);			
        },
		success : function(data){
			$("#addressbody").remove();
			$("#navpage").remove();
			
			let output = "<div class='container' id='addressbody'>";
			
			 output += "<div class='text-center mx-auto mb-5 wow fadeInUp' data-wow-delay='0.1s' style='max-width: 600px;'>";
			 output += "<h6 class='section-title bg-white text-center text-primary px-3'>" + data.dept + "</h6>";
             output += "<h1 class='display-6 mb-4'>" + data.title1 + "<br>"+ data.title2 + "</h1>";
             output += "</div>";
			
			 output += "<div class='row g-4'>";
			 
		$(data.memberlist).each(function(index, item){
    		
    		
    
    		output += "<div class='col-lg-4 col-md-6 wow fadeInUp' data-wow-delay='0.1s'>";
	    
		    output += "<div class='team-item text-center p-4'>";
    		output += "<img class='image-fluid border rounded-circle w-75 p-2 mb-4' style='height:230.98px;' src='../resources/" + item.profile_FILE + "' onerror=\"this.src='../resources/img/team-1.jpg';\">";
    
    		output += "<div class='team-text'>";
    		output += "<div class='team-title'>";
    		output += "<h5>" +item.dept +" / "+item.name +"</h5>";
    		output += "<span>"+ item.job+" / " +item.empno+"</span>";    
        
		    output += "</div>";
    		output += "<div class='team-social'>";
    		output += "<span class='emails'>"+ item.email +"</span>";
        	
        	
        	console.log(auth2);
    		if(auth2 =="ROLE_ADMIN" || auth2 == "ROLE_MGR"){
    		output += "<a class='btn btn-square btn-primary rounded-circle' href='../admin/modify?empno=" + item.empno + "'><i class='bi bi-pencil-square'></i></a>";
			}

	    
    		output += "<a class='btn btn-square btn-primary rounded-circle' href=''><i class='bi bi-envelope'></i></a>";
    		output += "</div>";
    		output += "</div>";
    		output += "</div>";    
    		output += "</div>";    
    		   
		});

				
				output += "</div>";
				output += "</div>";
				output += "<nav class='pt-3 d-flex justify-content-center align-items-center' aria-label='Page navigation example' id='navpage'>";
				output += "<ul class='pagination mb-0 '>"
				output += "</ul>";
				output += "</nav>";
				$("#address-container").append(output);
				
				
			
			$(".pagination").empty(); //페이징 처리 영역 내용 제거
				output = "";
				let digit = '이전&nbsp;';
				let href="";
				
				if(data.page > 1){
  			
  				href = 'href=javascript:go(' + (data.page -1 ) +',\'' +(data.dept)+ '\')';
  				
				}
				
				output += setPaging(href, digit);
			
				for (let i = data.startpage; i <= data.endpage; i++){
					
  					digit = i;
  					href ="";
  					
  					if ( i != data.page){
    						href = 'href=javascript:go(' + i +',\'' +(data.dept)+ '\')';
    						
  					}
  					if (i == data.page) {
  					   		output += '<li class="page-item active"><a class="page-link">' + digit + '</a></li>';
  					} else {
    						output += setPaging(href, digit);
  				}
				}//for (let i = data.startpage; i <= data.endpage; i++) end
			
				digit = '다음&nbsp;';
				href="";
				
					if (data.page < data.maxpage) {
  					href = 'href=javascript:go(' + (data.page + 1) +',\'' +(data.dept)+ '\')';

					}
					
					output += setPaging(href,digit);
					output += "</div>"; 
					output += "</div>";
					
				
				$('.pagination').append(output);
				
			}, //success end
			
			
			
			error : function() {
				console.log('에러');
			}
	})//ajax end
}//function ajax end



  






