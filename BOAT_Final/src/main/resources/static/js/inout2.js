function select_inout(){
    
}

$(function(){
	let output="";
    let checked = $("#inout option:checked").val();
    
	if(checked=='출근'){
		var today = new Date();
		var m = today.getMonth()+1;
		var d = today.getDate();
		var h = today.getHours();
		var mm = today.getMinutes();
		
		output += m+'월 '+d+'일 '+h+'시 '+mm+'분 '
		console.log(output);
		
		$('#work').html(output);
	}
})


