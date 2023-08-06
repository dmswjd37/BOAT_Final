 
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:include page="../Main/header.jsp" />
<!DOCTYPE html>
<html>

<head>
 
  
  <!-- fullcalendar 언어 CDN 
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>-->
  
  <!-- bootstrap -->

<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js" integrity="sha512-42PE0rd+wZ2hNXftlM78BSehIGzezNeQuzihiBCvUEB3CVxHvsShF86wBWwQORNxNINlBPuq7rG4WWhNiTVHFg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> -->

<!-- the moment-to-fullcalendar connector. must go AFTER the moment lib -->
 
 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  
  <link href ="${pageContext.request.contextPath}/jhLee/css/fullcalendar.css"  rel ="stylesheet">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js" integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://unpkg.com/tippy.js@6"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

  <style>
	.page-header {
		margin: 0!important;
	}
	.tippy-box[data-theme~='tomato'] {
  background-color: tomato;
  color: yellow;
}
	</style>
<script>
	 
$(document).ready(function(){
let token = $("meta[name='_csrf']").attr("content");
let header = $("meta[name='_csrf_header']").attr("content");
	var empno = $('#loginid').text();
	var selectedEvent = null;
	var calendarEl = document.getElementById('calendar');
	var count =0;
	let selDept = $("#calDept").val();
	
	const Empno =$('#loginid').text()
	$('#calEmpno').val(Empno); 						

	//부서 선택시 새로운 캘린더페이지 
	$('#calDept').change(function(){
	selDept = $(this).val();
	showEvents(selDept);
	})
	$('#everyevent').click(function(){
		showEvents()
	})
	//시작시 전체 이벤트 가져옴
	showEvents()
	
	Events = [];		 

	// DB에서 이벤트 가져오기
	function showEvents(dept) {
		
    $.ajax({
        type: 'GET',
        url: 'cal/getEvents',
        data: { DEPT: dept },
        success: function(events) {
			for(i=0; i<events.length; i++){
				//endDate = moment(events[i].end).add(9, 'h').format("YYYY-MM-DD hh:mm");
				//endDate = moment(events[i].end).subtract(9, 'hours').format("YYYY-MM-DD hh:mm");
				//events[i].end = endDate
			}
			Events= events;
	
			calendar.getEventSources().forEach(function(source) {
			source.remove();
			});	
			calendar.addEventSource(events);
			calendar.refetchEvents(); 
			},
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
			}
		});
	}//show event() end

	$('#undo').click(function(){
					$('#title').val("");
					$('#START_DATE').val('');
					$('#END_DATE').val('');
					$('#START_TIME').val('');
					$('#END_TIME').val('');
						location.reload();
							
					})//$('#undo').click end
					
	      // full-calendar 생성하기
var calendar = new FullCalendar.Calendar(calendarEl, {
			events :Events
        	,height: '600px' // calendar 높이 설정
			,dayPopoverFormat: { year: 'numeric', month: 'long', day: 'numeric' }
			 ,eventDidMount: function(info) {
				let endDate = moment(info.event.end).format("MM-DD HH:mm");
			 	let start = moment(info.event.start).format('MM-DD HH:mm');
				let popallDay = info.event._def.allDay

				if(popallDay){
					endDate = '종일일정';
				}
				tippy(info.el,{
				allowHTML: true,
				theme: 'tomato',
	 			content : info.event.title+'<br>'+start+'<br>'+endDate+''
		 		});
				// let start = moment(info.event.start).format('YY-MM-DD:m:s')
		 	
			 }
			,expandRows: true, // 화면에 맞게 높이 재설정	
			headerToolbar:
			{
				prev: 'chevron-left',
				next: 'chevron-right',
				prevYear: 'chevrons-left', // double chevron
				nextYear: 'chevrons-right' // double chevron
				,left:'title,dayGridMonth'
			},
			
   		  	editable: false, //재수정여부 가능
		     //월간 달력으로 시작합니다.
			initialView: 'dayGridMonth',
	        selectable: true, // 달력 일자 드래그 설정가능
	          locale: 'ko', // 한국어 설정
   		   //이벤트 수정
			// eventDrop:function(event){
			// 	console.log('update event'+event)
			// 	console.log(event)
			// var startmoment =moment(event.event.start).format('YYYY-MM-DD HH:mm:ss');
			// var endmoment = moment(event.event.end).format('YYYY-MM-DD HH:mm:ss');	
			// var updateevnet = {EMPNO:empno,
			// 			title:title,
			// 			start:start,
			// 			end:end
			// 			}
			// 	$.ajax({
			// 	type:'POST',
			// 	url:'${pageContext.request.contextPath}/cal/update',
			// 	data:updateevnet,
			// 	success:function(response){
			// 		console.log('success'+response)	
			// 		if(response==-1){
			// 		alert('본인이 작성한 일정만 수정 가능합니다.');
			// 		setTimeout(function(){
			// 		location.reload();},1500);
			// 		}else{
			// 		swal("Good job!", "성공적으로 수정되었습니다.", "success");
			// 		}
			// 	},
			// 	error:function(request,status,error){
			// 	console.log('updateerror')
			// 	},
			// 	complete:function(){}
			// 	})
			// },  
	        eventAdd: function(arg) { // 이벤트가 추가되면 발생하는 이벤트
				console.log(arg);
				console.log('이벤트 변경 및 추가');	
			},
            eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
				console.log(obj);
				console.log('이벤트 삭제함');
			},
			unselectAuto: true,
	        //ok
			//==========================================================
            select:function (addevent) {// 캘린더에서 드래그로 이벤트를 생성할 수 있다.
				console.log(addevent)
				
				$('#addevent').modal('toggle');
				
				var color =null;
				var start = addevent.start;
				var startdate =moment(start).format('YYYY-MM-DD hh:mm');
				var end = moment(addevent.end).subtract(1,'days');
				var enddate = moment(end).format('YYYY-MM-DD hh:mm');
				
				//모달 안의 값
				$('#START_DATE').val(startdate.substr(0,10))
				$('#END_DATE').val(enddate.substr(0,10),-1)
				
				$('#saveBtn').click(function(){
					
					//calendar.unbind();
				if($('#title').val()==""){
					swal('일정을 입력해주세요');
					return false;
					$('#title').focus();
				}
				

				var allDay =false
				var title =$('#title').val();
				let dept = $('#color option:checked').text();
				var color = $('#color').val();
				
				let chk = $('#allday').is(":checked");//.attr('checked'); 
				
					if(!chk) {
						//allDay false
						//시간체크 유효성 검사
						if($('#START_TIME').val()==""){
						swal('시작시간 을 입력해주세요');
						return false;
						$('#START_TIME').focus();
						}
					
						if($('#END_TIME').val()==""){
						swal('종료시간 을 입력해주세요');
						return false;
						$('#END_TIME').focus();
						}

						if($('#color').val()==""){
						swal('부서명 을 입력해주세요');
						return false;
						$('#color').focus();
						}

						//시간선택시 값
					starttime=$('#START_TIME').val()
					console.log(starttime)
					endtime=$('#END_TIME').val()
					console.log(endtime)
					
 			
						
						
						
					starttimee =(startdate.substr(0,10))+' ' +starttime
					endtimee =(enddate.substr(0,10))+' ' +endtime
					var startmoment = starttimee
					var endmoment = endtimee
					
					if (new Date(endtimee)
	                - new Date(starttimee) < 0) { // date 타입으로 변경 후 확인
						swal('종료시간을 확인해주세요','종료시간이 시작시간보다 빠릅니다.');
					return false}
						
						
					}else{
						//allDaytrue
					var startmoment = (startdate.substr(0,10))+' 00:00'
					var endmoment = (enddate.substr(0,10))+' 00:00'
					var allDay =true
					console.log('allDaytrue...........'+allDay)
					console.log('startmomenttrue............'+startmoment);
					console.log('endmomenttrue............'+endmoment);
					}
				console.log('찐막allDay...........'+allDay)
				console.log('찐막startmoment............'+startmoment);
				console.log('찐막endmoment............'+endmoment);
				console.log('찐막color............'+color);
				console.log('찐막dept............'+dept);
				console.log('찐막empno............'+Empno);
				console.log('찐막title............'+title);
				console.log('typeofallDay......'+typeof(allDay))
				
				if(allDay){
					alldayText='true'
				}else{
					alldayText='false'
				}
				console.log('typeofalldayText......'+typeof(alldayText))
					
				var eventData = {
					"EVENT_NAME": title,
					"START_DATE": startmoment,
					"END_DATE": endmoment,
					"COLOR": color,
					"ALLDAY": alldayText,
					"EMPNO":empno,
					"DEPT":dept
				}
				$.ajax({
					type: 'POST',
					url: '../boat/cal/save',
					data: eventData,
					dataType:'json',
					beforeSend: function (jqXHR, settings) {
                    jqXHR.setRequestHeader(header, token);
                    },
					success: function(response) {
						console.log(response);
								
						swal("일정이 추가되었습니다.", {
						      icon: "success",
						    });
					},
					error: function(xhr, status, error) {
						console.log('error')
						console.log(error)
						},
				complete:function(){
				$("#addevent").modal('hide')
				  calendar.unselect();
				//setTimeout(function(){
        	   	//						location.reload();},1500);

				} //complete 끝
				})//ajax끝
   		          //  }// if 끝
				console.log(count++,calendar.toString());
   		      	  });//savebtnclick
   		      	  console.log('end'+calendar);
   		      	event.stopPropagation();
				  //=================================================================
				},
				
		    eventClick: 
			function deleteEvent(event) {
				console.log(event)
				let title = event.event._def.title
				let eventnum = event.event._def.defId
				var deleteevent ={"EMPNO":empno
							,"EVENT_NAME":title}
				console.log(title+'ddddddddddddddddddd')
				console.log(empno+'ddddddddddddddddddd')
				
				var Confirm=swal({
					  title: "일정을 삭제하시겠습니까??",
					  text: "",
					  icon: "warning",
					  buttons: true,
					  dangerMode: true,
					})
					.then((willDelete) => {
					  if (willDelete) {
					$.ajax({
						type: 'POST',
						url: '/boat/cal/delete',
						data:deleteevent
					,
				beforeSend: function (jqXHR, settings) {
				jqXHR.setRequestHeader(header, token);
				},
						success: function(response) {
							if(response==0){
						swal('등록한 글만 삭제 가능합니다.')
						setTimeout(function(){
								location.reload();},1500);	
							}else{
								/* console.log(response);
								toastr.options.escapeHtml = true;
								toastr.options.closeButton = true;
								toastr.options.newestOnTop = false;
								toastr.options.progressBar = true;
								toastr.info('일정이 삭제되었습니다.', '캘린더', {timeOut: 1500}); */
								swal("일정이 삭제되었습니다.", {
								      icon: "success",
								    });
							}
						},
						error: function(xhr, status, error) {
							console.error(xhr.responseText);
						}
						,complete:function(){
						setTimeout(function(){
						location.reload();},1500);

				} //complete 끝
					});//ajax끝
					 
					  } else {
					    swal("취소되었습니다.");
					    setTimeout(function(){
							location.reload();},1500);
					  }
					});
				}

		
			});//캘린더 객체 선언 끝
			calendar.render();
//=============================================================


//모달 창 안에 allday 클릭시 
$("#allday").click(function(){ 
	let chk = $('#allday').is(":checked");//.attr('checked'); 
	console.log('alldayinmodal..............'+chk)
        if(chk) {
		$("input[name='START_TIME']").prop('readonly', true);
		$("input[name='END_TIME']").prop('readonly', true);
		}else{
		$("input[name='START_TIME']").prop('readOnly', false);
		$("input[name='END_TIME']").prop('readOnly', false);
		}
    }); 



		})
		function updateEvent(event) {
			$.ajax({
				type: 'POST',
				url: 'update',
				data: JSON.stringify(event),
				contentType: 'application/json',
				success: function(response) {
					console.log(response);
				},
				error: function(xhr, status, error) {
					console.error(xhr.responseText);
				}
			});
		}
</script>


</head>

<body>

<!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-4 text-white animated slideInDown mb-3">캘린더</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <!-- <li class="breadcrumb-item"><a class="text-white" href="#"></a></li> -->
                    <!-- <li class="breadcrumb-item"><a class="text-white" href="#"></a></li> -->
                    <li class="breadcrumb-item text-primary active" aria-current="page"></li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->
    

<div class="cal_container">
 <div id = cal_wrap>
 <br>
 <br>
 <button id = "everyevent"
  style = "width : 100px; height : 50px; background-color : rgb(0, 173, 238);  
  color :  white; margin-bottom : 20px; border : none;">전체보기</button>

  <select class="form-control" id ="calDept">
			<button id ="">
  			<option value ="" class="">팀별 일정 확인하기</option>
  			<option value ="홍보팀" class="ad">홍보팀</option>
  			<option value ="개발팀" class = "devel">개발팀</option>
  			<option value ="인사팀" class = "hire">인사팀</option>
  			<option value ="기획팀" class = "plan">기획팀</option>
  			<option value ="영업팀" class = "sales">영업팀</option>
		<%-- <c:if test="${empno =='admin'}">
  			<option value ="관리자">(관리자)</option>
		</c:if> --%>
			</select>
			<br>
			<br>

 
<!-- Modal -->

  
<div class="modal fade" id="addevent" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">캘린더 일정등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      일정
      <form action="add"	method = 'post'>
        <input type="text" name="EVENT_NAME" class = "form-control" id = 'title'>
       
		
		
		<div class="cal_date" style="margin-top:15px" >
			<label>일정 시작 날짜: </label>
			<div class="form-group">
			  <input
				type="text"
				name="START_DATE"
				class="form-control time "
				id="START_DATE"
				readonly
			  />
			</div>
			
			<label style="margin-top:15px" >일정 종료 날짜: </label>
			<div class="form-group" >
			  <input
				type="text"
				name="END_DATE"
				class="form-control time "
				id="END_DATE"
				readonly
			  />
			</div>
		</div>
				

		<div class="form-control" style="margin-top:15px" >
			<input 
					   class=form-group
					   id="allday"
					   name="ALLDAY"
					   type="checkbox"     />
					 <label class="form-group" >종일 여부</label>
		   </div>


		<div class="cal_time" style="margin: auto 15px " >
			<label style="width:42%;">일정 시작 시간: 
			<div class="form-group">
			  <input
				type="time"
				name="START_TIME"
				class="form-control time "
				id="START_TIME"
				
			  />
			</div>
		</label>

				<label style="margin-top:15px; margin-left:30px; width:42%;" >일정 종료 시간: 
			<div class="form-group" >
			  <input
				type="time"
				name="END_TIME"
				class="form-control time "
				id="END_TIME"
			  />
			</div>
		</label>


		</div>
	
                
         
        <select class="form-control" id ="color" name='COLOR' style="margin-top:25px;">
  			<option value ="pink" name = "" class="ad">홍보팀</option>
  			<option value ="orange" class = "devel">개발팀</option>
  			<option value ="lightgreen" class = "hire">인사팀</option>
  			<option value ="purple" class = "plan">기획팀</option>
  			<option value ="" class = "sales">영업팀</option>
				<%-- <c:if test="${EMPNO =='ADMIN'}">
		  			<option value ="red">(관리자)</option>
				</c:if> --%>
			</select>
			 <input type="hidden" name ="EMPNO" value="${loginid}" id="calEmpno">
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id ="undo">돌아가기</button>
        <button type="button" class="btn btn-primary" id ="saveBtn">&nbsp;&nbsp;일정 저장&nbsp;&nbsp;</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal end -->  
  
 	<div id='calendar'></div>
 </div>
 </div>
 <%--cal_container --%>
 
 
 <jsp:include page="../Main/footer.jsp" />
</body>
</html>