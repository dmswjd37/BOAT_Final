let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
let option=1;  //선택한 등록순과 최신순을 수정, 삭제, 추가 후에도 유지되도록 하기위한 변수로 사용됩니다.
let empno = $('#loginid').text();
let name = $('#loginname').text();
let dept = $('#loginDept').text();
function del(num){//num : 댓글 번호
  	
  	if(!confirm('정말 삭제하시겠습니까?')){
	
	$('#comment-list-item-layer'+num).hide();// 수정삭제영역숨김
	return;
}
	$.ajax({
			url : '../Filebocom/delete',
			data : {num:num},
			success : function(rdata){
				if(rdata==1){
					getList(option);
				}
			}
		})//ajax

}//function(del) end


	
function getList(state){//현재 선택한 댓글 정렬방식을 저장합니다. 1=>등록순, 2=>최신순
	    console.log('state = '+state)
	    option=state;
	    console.log($("#comment_board_num").val());
		$.ajax({
			type:"get",
			url:"../Filebocom/list",
			data : {"FILE_BO_NUM" : $("#comment_board_num").val(), 
			state:state}
			,
			dataType:"json",
			beforeSend: function (jqXHR, settings) {
				jqXHR.setRequestHeader(header, token);
		 },
			success:function(rdata){
				console.log(rdata.list+"1313");
				$('#count').text(rdata.listcount).css('font-family','arial,sans-serif')
				let red1 = 'red';
				let red2 ='red';
				if(state ==1){
					red2='gray';
				}else if(state==2){
					red1='gray';
				}
				let output="";
				if(rdata.list.length>0){
					console.log('success')
					output +='<li class = "comment-order-item '+ red1+'">'
							+'	<a href="javascript:getList(1)" class ="comment-order-button">등록순</a>'
							+'</li>'
							+'<li class ="comment-order-item '+ red2+'">'
							+' 	<a href="javascript:getList(2)" class ="comment-order-button">최신순</a>'
							+'</li>';
			$('.comment-order-list').html(output);
			output='';
			$(rdata.list).each(function(){
				const lev = this.file_COMMENT_RE_LEV;
				console.log(lev);
				let comment_reply ='';
				if(lev==1){
					comment_reply =' comment-list-item--reply lev1';
				}else if(lev==2){
					comment_reply =' comment-list-item--reply lev2';
					
				}
				const profile = this.profile;
				let src ='image/profile.png';
				if(profile){
					src='/boat/resources/'+profile;
				}
				output +='<li id ="'+this.file_C_NUM+'"class="comment-list-item '+comment_reply + '">'
						+'	<div class ="comment-nick-area">'
						+'	<img src="'+src+'" alt ="프로필사진" width="36" height="36">'
						+'	<div class ="comment-box">'
						+'		<div class ="comment-nick-box">'
						+'			<div class="comment-nick-info">'
						+'				<div class="comment-nickname">'+this.file_C_DEPT+' '+ this.file_C_NAME + '</div>'
						+'			</div>'//comment-nick-info
						+'		</div>'//comment-nick-box
						+'	</div>'//comment-box
						+'	<div class ="comment-text-box">'
						+'		<p class-"comment-text-view">'
						+'			<span class="text-comment">'+ this.file_CONTENT + '</span>'
						+'		</p>'
						+'	</div>'//comment-text-box
						+'	<div class="comment-info-box">'
						+'		<span class="comment-info-data">'+this.file_COMMENT_DATE + '</span>';	
						+'	</div>'//comment-text-box
				if(lev<2){
					output +='	<a href="javascript:replyform('+this.file_C_NUM +','
							+ lev +','+this.file_COMMENT_RE_SEQ+','
							+ this.file_COMMENT_RE_REF +')" class="comment-info-button">답글쓰기</a>'
				}
				output+='</div>'//comment-info-box;
				
				if(empno==this.file_C_ID){
					output+='<div class="comment-tool">'
						+'	<div title="더보기" class="comment-tool-button">'
						+'			<div>&#46;&#46;&#46;</div>'
						+'		</div>'
						+'		<div id = "comment-list-item-layer'+this.file_C_NUM+'" class="LayerMore">'//스타일에서 display:none
						+'		<ul class="layer-list">'
						+'			<li class="layer-item">'
						+'			<a href="javascript:updateForm('+this.file_C_NUM+')"'
						+'			class="layer-button">수정</a>&nbsp;&nbsp;'
						+'			<a href="javascript:del('+this.file_C_NUM+')"'
						+'			class="layer-button">삭제</a></li></ul>'
						+'		</div>'
						+'		</div>'
				}
						output+='</div>'//comment-nick-area
						+'		</li>'//li.comment-list-item
			})//each end

			$('.comment-list').html(output);
			}//if(rdata.boardlist.length>0)
			else{//댓글 1개가 있는 상태에서 삭제하는 경우 갯수는 0이라 if문을 수행하지 않고 이곳으로 옵니다.
				//이곳에서 아래의 두 영역을 없앱니다.
				$('.comment-list').empty();
				$('.comment-order-list').empty();
			}
				
			
			}//success end
			, error: function(){
				console.log('error');
			}
		});//ajax end
	}//function(getList) end


	function updateForm(num){ //num : 수정할 댓글 글번호

    //수정 폼이 있는 상태에서 더보기를 클릭할 수 없도록 더 보기 영역을 숨겨요
	$(".comment-tool").hide();
	
	$(".LayerMore").hide(); //수정 삭제 영역도 숨겨요
	
	let $num = $('#'+num);
	
	//선택한 내용을 구합니다.
	const content=$num.find('.text-comment').text(); 
	
	const selector = '#'+num + '> .comment-nick-area'
	$(selector).hide(); //selector 영역 숨겨요-수정에서 취소를 선택하면 보여줄 예정입니다.
	
	//$('.comment-list+.comment-write').clone() : 기본 글쓰기 영역 복사합니다.
	//글이 있던 영역에 글을 수정할 수 있는 폼으로 바꿉니다.
	$num.append($('.comment-list+.comment-write').clone());
	
	//수정 폼의 <textarea>에 내용을 나타냅니다.
	$num.find('textarea').val(content); 
	
	//'.btn-register' 영역에 수정할 글 번호를 속성 'data-id'에 나타내고 클래스 'update'를 추가합니다.
	$num.find('.btn-register').attr('data-id',num).addClass('update').text('수정완료');
	
	//폼에서 취소를 사용할 수 있도록 보이게 합니다.원래 안보였던건데  점점점클릭하면 보이게 
	$num.find('.btn-cancel').css('display','block'); 
	
	const count=content.length;
	$num.find('.comment-write-area-count').text(count+"/200");
	
}//function(updateForm) end

function replyform(num,lev,seq,ref){
	//수정 삭제 영역 선택 후 답글쓰기를 클릭한 경우
	$(".LayerMore").hide();//수정삭제영역숨경요
	
	let output='<li class="comment-list-item comment-list-item--reply lev'+lev+'"></li>'
	const $num= $('#'+num);
	//선택한 글 뒤에 답글 폼을 추가합니다.
	$num.after(output);
	
	//글쓰기 영역 복사합니다.
	output =$('.comment-list+.comment-write').clone();
	
	const $num_next =$num.next();
	//선택한 글 뒤에 답글 폼 생성합니다.
	$num_next.html(output);
	
	// 답글 폼의 < textarea>의 속성 'placeholder' 를 답글을 남겨보세요
	$num_next.find('textarea').attr('placeholder','답글을 남겨보세요');
	
	// 답글 폼의 '.btn-cancel 보여주고 .reply-cancel클래스추가
	$num_next.find('.btn-cancel').css('display','block').addClass('reply-cancel');

	$num_next.find('.btn-register').addClass('reply')
				.attr('data-ref',ref).attr('data-lev',lev).attr('data-seq',seq).text('답글완료');
}//function(replyform) end

$(function() {





	console.log(empno+"empno있나요");
	
	getList(option);  //처음 로드 될때는 등록순 정렬
	
	$('form[name="deleteForm"]').submit(function() {
		if ($("#board_pass").val() == '') {
			alert("비밀번호를 입력하세요");
			$("#board_pass").focus();
			return false;
		}
	})// form

	
	$('.comment-area').on('keyup','.comment-write-area-text', function() {
		const length =$(this).val().length;
		$('.comment-write-area-count').text(200-length+'/200');
	});// keyup','.comment-write-area-text', function() {
	
	
	//댓글 등록을 클릭하면 데이터베이스에 저장 -> 저장 성공 후에 리스트 불러옵니다.
	$('ul+.comment-write .btn-register').click(function() {
			const content=$('.comment-write-area-text.form-control').val();
		if(!content){//내용없이 등록 클릭한 경우
			alert("댓글을 입력하세요");
			return;
		}
		console.log('등록합니다 '+empno)
		$.ajax({
			url : '../Filebocom/add',//원문 등록
			data : {
				FILE_C_ID:empno,

				FILE_CONTENT : content,
				FILE_BO_NUM : $("#comment_board_num").val(),
				FILE_COMMENT_RE_LEV : 0,//원문인 경우 comment_re_seq는 0,
									//comment_re_ref는 댓글의 원문 글번호
				FILE_COMMENT_RE_SEQ:0,
				FILE_C_NAME :name,
				FILE_C_DEPT :dept
			},
			beforeSend: function (jqXHR, settings) {
				jqXHR.setRequestHeader(header, token);
		 	},
		 	type :'post',
			success : function(rdata){
				if(rdata==1){
					getList(option);
					}
		}
		})//ajax
		$('.comment-write-area-text').val('');
		$('.comment-write-area-text').text('0/200');
		
	})// $('.btn-register').click(function(){
	
	
	//더보기를 클릭한 경우
	$(".comment-list").on('click', '.comment-tool-button', function(){        		
	//더보기를 클릭하면 수저과 삭제 영역이 나타나고 다시 클릭하면 사라져요
	//버튼 다음에 있는
	 $(this).next().toggle();
	 
	 //클릭 한 곳만 수정 삭제 영역이 나타나도록 합니다.***점점점한데서만 나타나게함
	 							//onclick .comment-tool-button 빼고
	 	 $(".comment-tool-button").not(this).next().hide();
	})
	
	

	//수정 후 수정완료를 클릭한 경우
	$('.comment-area').on('click','.update',function(){
		const content=$(this).parent().parent().find('textarea').val();
		if(!content){//내용없이 등록 클릭한 경우
			alert("수정할 글을 입력하세요");
			return;
		}
		const num=$(this).attr('data-id');
		$.ajax({
				url :'../Filebocom/update',
				data:{FILE_C_NUM:num,FILE_CONTENT:content},
				success:function(rdata){
					if(rdata==1){
						getList(option)
					}
				}
			})

	})//수정 후 수정완료를 클릭한 경우
	
	
	//수정 후 취소 버튼을 클릭한 경우
	$('.comment-area').on('click','.btn-cancel',function(){
		//댓글 번호를 구합니다.
		const num= $(this).next().attr('data-id');
		const selector='#' +num;  
		
		//.comment-write 영역 삭제 합니다.
		$(selector + ' .comment-write').remove();
		
		//숨겨두었던 .comment-nick-area 영역 보여줍니다.
		$(selector + '>.comment-nick-area').css('display','block');	
				
		
		//수정 폼이 있는 상태에서 더보기를 클릭할 수 없도록 더 보기 영역을 숨겼는데 취소를 선택하면 보여주도록 합니다.
	    $(".comment-tool").show();
	})//수정 후 취소 버튼을 클릭한 경우
	
	
	
	//답글완료 클릭한 경우
	$('.comment-area').on('click','.reply',function(){
		const content = $(this).parent().parent().find('.comment-write-area-text').val();
		console.log('답글완료')
		if(!content){//내용없이 답글완료 클릭한 경우
			alert("답글을 입력하세요")
			 return;
		}
		const comment_re_ref = $(this).attr('data-ref');
		const lev = $(this).attr('data-lev');
		const seq = $(this).attr('data-seq');
		$.ajax({
				url :'../Filebocom/reply',
				data:{
					FILE_C_ID : empno,
						FILE_CONTENT : content,
						FILE_BO_NUM : $("#comment_board_num").val(),
						FILE_COMMENT_RE_LEV :lev,
						FILE_COMMENT_RE_REF :comment_re_ref,
						FILE_COMMENT_RE_SEQ :seq,
						FILE_C_NAME :name,
						FILE_C_DEPT :dept
						
					},
					dataType:"json",
			beforeSend: function (jqXHR, settings) {
				jqXHR.setRequestHeader(header, token);
		 	},
					type : 'post',
					
					success:function(rdata){
					if(rdata==1){
						getList(option)
					}
				}
			})
		
	})//답글완료 클릭한 경우
	
	
	//답글쓰기 후 취소 버튼을 클릭한 경우
	$('.comment-area').on('click','.reply-cancel',function(){
		$(this).parent().parent().remove();
		$(".comment-tool").show();//더보기 보이도록
	})//답글쓰기  후 취소 버튼을 클릭한 경우
	
	//답글쓰기 클릭 후 계속 누르는 것을 방지하기 위한 작업
	$('.comment-area').on('click','.comment-info-button',function(event){
		//답변쓰기 폼이 있는 상태에서 더보기를 클릭할 수 없도록 더 보기 영역을 숨겨요
		$(".comment-tool").hide();
		
		// 답글쓰기 폼의 갯수를 구합니다.
		const length=$(".comment-area .btn-register.reply").length;
		if(length==1){//답글쓰기 폼이 한 개 존재하면   anchor태그<a> 의 기본 이벤트를 막아 또 다른 답글쓰기 폼이 나타나지 않도록 합니다.
			
		event.preventDefault()
		}
		
	})//답글쓰기  후 취소 버튼을 클릭한 경우
	
	
})//ready
	
	
	