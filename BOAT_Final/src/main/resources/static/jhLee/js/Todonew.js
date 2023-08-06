


$(document).ready(function(){


$(document).on("click", ".updateTodo", function () {
    let num = $(this).data('id');
    $.ajax({
        url :'../Todo/getTodo',
        data:{num:num
            },
        success:function(rdata){
           console.log("todolist 가져옴")
         let num =rdata.num;
         console.log(num);
         let content=rdata.t_CONTENT;
         let startdate= rdata.start_DATE;
         let enddate = rdata.end_DATE;

        $('#updatestart').val(startdate)
                     .attr('readonly',true);
        $('#updateend').val(enddate);
        $('#updatetitle').val(content)
                         .attr('readonly',true);
        $('#todonum').val(num)

        $('#updateTodo').modal('toggle');
        
        }
        })
    })

$(document).on("click", ".done", function () {
    var num = $(this).data('id');
    let done = $(this)
    $.ajax({
        url :'../Todo/done',
        data:{num:num
            },
        success:function(rdata){
            console.log(rdata);
            toastr.options.escapeHtml = true;
            toastr.options.closeButton = true;
            toastr.options.newestOnTop = false;
            toastr.options.progressBar = true;
            toastr.info('할일을 완료하였습니다.', '내 할일', {timeOut: 1500});
            setTimeout(function(){
			 		location.reload();},1500);
        }
        })
    })
$(document).on("click", ".deleteTodo", function () {
    var num = $(this).data('id');
    let done = $(this)
    
    swal({
					  title: "할일을 삭제하시겠습니까??",
					  text: "",
					  icon: "warning",
					  buttons: true,
					  dangerMode: true,
					})
					.then((willDelete) => {
					  if (willDelete) {
    $.ajax({
        url :'../Todo/delete',
        data:{num:num
            },
        success:function(rdata){
            console.log(rdata);
           /* toastr.options.escapeHtml = true;
            toastr.options.closeButton = true;
            toastr.options.newestOnTop = false;
            toastr.options.progressBar = true;
            toastr.info('할일을 삭제하였습니다..', '내 할일', {timeOut: 1500});
            */
			 		swal("일정이 삭제되었습니다.", {
								      icon: "success",
								    });
								    setTimeout(function(){
			 		location.reload();},1500);
        }
        })
        	  } else {
					    swal("취소되었습니다.");
					    setTimeout(function(){
							location.reload();},1500);
					  }
					});
    })


 $('#saveUpdate').click(function(){
     let num = $(this).data('id');
     let enddate = $('#updateend').val();
     
     $.ajax({
         url :'../Todo/updateTodo',
         data:{num:num,
             END_DATE:enddate },
         success:function(rdata){
             console.log(rdata);
             toastr.options.escapeHtml = true;
             toastr.options.closeButton = true;
             toastr.options.newestOnTop = false;
             toastr.options.progressBar = true;
             toastr.info('일정을 완료하였습니다.', '내 할일', {timeOut: 1500});
         },
        	complete:function(){
        	 $('#updateTodo').modal('hide')}
         })

})



})