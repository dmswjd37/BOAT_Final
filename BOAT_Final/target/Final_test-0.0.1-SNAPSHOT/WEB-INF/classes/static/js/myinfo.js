$(function(){
	if($('#headerloginid').val()!=''){
		$('#work').html(getCookie('work'));
		$('#out').html(getCookie('out'));
		$('#outin').html(getCookie('outin'));
		$('#leaves').html(getCookie('leaves'));
		
		//오늘 근무시간
		//let work_h = '';
		//if(getCookie('work').length == 14){
			//let tday_hw = Number(getCookie('work').substring(7,9)*60);//출근 시
			//let tday_mmw = Number(getCookie('work').substring(11,13));//출근 분
			//work_h = tday_hw + tday_mmw;//출근 시간
		//}else{
			//let tday_hw = Number(getCookie('work').substring(7,8)*60);//출근 시
			//let tday_mmw = Number(getCookie('work').substring(10,12));//출근 분
			//work_h = tday_hw + tday_mmw;//출근 시간
		//}
		
		//let out_h = '';
		//if(getCookie('out').length == 14){
			//let tday_ho = Number(getCookie('out').substring(7,9)*60);//외출 시
			//let tday_mmo = Number(getCookie('out').substring(11,13));//외출 분
			//out_h = tday_ho + tday_mmo;//외출 시간
		//}else{
			//let tday_ho = Number(getCookie('out').substring(7,8)*60);//외출 시
			//let tday_mmo = Number(getCookie('out').substring(10,12));//외출 분
			//out_h = tday_ho + tday_mmo;//외출 시간
		//}
		
		//let outin_h = '';
		//if(getCookie('outin').length == 14){
			//let tday_hoi = Number(getCookie('outin').substring(7,9)*60);//복귀 시
			//let tday_mmi = Number(getCookie('outin').substring(11,13));//복귀 분
			//outin_h = tday_hoi + tday_mmi;//복귀 시간
		//}else{
			//let tday_hoi = Number(getCookie('outin').substring(7,8)*60);//복귀 시
			//let tday_mmi = Number(getCookie('outin').substring(10,12));//복귀 분
			//outin_h = tday_hoi + tday_mmi;//복귀 시간
		//}
		
		//let leaves_h = '';
		//if(getCookie('leaves').length == 14){
			//let tday_hl = Number(getCookie('leaves').substring(7,9)*60);//퇴근 시
			//let tday_mml = Number(getCookie('leaves').substring(11,13));//퇴근 분
			//leaves_h = tday_hl + tday_mml;//퇴근 시간
		//}else{
			//let tday_hl = Number(getCookie('leaves').substring(7,8)*60);//퇴근 시
			//let tday_mml = Number(getCookie('leaves').substring(10,12));//퇴근 분
			//leaves_h = tday_hl + tday_mml;//퇴근 시간
		//}
		//let todaytimeMSec = leaves_h-outin_h+out_h-work_h;//퇴근-복귀 + 외출-출근
		//console.log(work_h);
		//console.log(out_h);
		//console.log(outin_h);
		//console.log(getCookie('leaves').length);
		//let todaytimeMin = Math.floor(todaytimeMSec / 60)+'시간 '+todaytimeMSec%60+'분';
		
		//출근 눌렀으면 출근 다시 못누르게
		if(checkCookie('work')==true){
			console.log(1);
			$('#works').prop("disabled", true);
		}
		
		//외출누르면 복귀로 변경
		if(checkCookie('out')==true && checkCookie('outin')==false){
			console.log(2);
			$("#outs").val('복귀');
			$("#outs").html('복귀');
		}
		
		//복귀한담에 외출 못 누르게
		if(checkCookie('out')==true && checkCookie('outin')==true){
			console.log(3);
			$('#outs').prop("disabled", true);
		}
		
		//퇴근 눌렀으면 외출, 퇴근 다시 못누르게
		if(checkCookie('leaves')==true){
			console.log(4);
			$('#outs').prop("disabled", true);
			$('#leave').prop("disabled", true);
			
			//$('#gu').html(todaytimeMin);//오늘 근무시간
		}
		
		$('#inout').change(function(){
			let output="";
			
		    let checked = $("#inout option:checked").val();
		    
		    var today = new Date();
		    var year = today.getFullYear();
			var m = today.getMonth()+1;
			var d = today.getDate();
			var h = today.getHours();
			var mm = today.getMinutes();
			
			if(checked=='출근'){
				output += m+'월 '+d+'일 '+h+'시 '+mm+'분 '
				console.log(output);
				
				setCookie('work',output, 23-today.getHours(), 60-today.getMinutes());
				reload()
			}
			
			if(checked=='외출'){
				output += m+'월 '+d+'일 '+h+'시 '+mm+'분 '
				console.log(output);
				
				setCookie('out',output, 23-today.getHours(), 60-today.getMinutes());
				reload()
			}
			
			if(checked=='복귀'){
				output += m+'월 '+d+'일 '+h+'시 '+mm+'분 '
				console.log(output);
				
				setCookie('outin',output, 23-today.getHours(), 60-today.getMinutes());
				reload()
			}
			
			if(checked=='퇴근'){
				output += m+'월 '+d+'일 '+h+'시 '+mm+'분 '
				console.log(output);
				
				setCookie('leaves',output, 23-today.getHours(), 60-today.getMinutes());
				reload()
			}
		});
	}else{
		$('#works').prop("disabled", true);
		$('#outs').prop("disabled", true);
		$('#leave').prop("disabled", true);
	}
})


//강제 새로고침
function reload() {
    (location || window.location || document.location).reload();
}

//쿠키 생성
function setCookie(name, value, expiretime, expireminutes) {
    var date = new Date();
    date.setHours(date.getHours() + expiretime);
    date.setMinutes(date.getMinutes() + expireminutes);
		      
    var mycookie = '';
    mycookie += name + '=' + value +';';
    mycookie += 'expires=' + date.toUTCString() +';';
		      
    document.cookie = mycookie;
    console.log(date.toUTCString());
}	



//도메인 설정 - 헤더에 설정해서 필요없어짐
function getDomainWithoutSubdomain() {
    var urlParts = window.location.hostname.split('.');
    var subDomainArr = ["co", "go", "or", "ac", "ne"] 
    var countryDomainArr = ["kr", "jp", "cn", "us"];
    var isTopLevelDomain = true;
    
    subDomainArr.forEach(function(subDomain){
        countryDomainArr.forEach(function(countryDomain){
            if(urlParts.length > 1 && subDomain == urlParts[urlParts.length - 2] && countryDomain == urlParts[urlParts.length - 1]){
                isTopLevelDomain = false;
            }
        });
    });
    
    return urlParts
        .slice(0)
        .slice(-(urlParts.length === 4 || isTopLevelDomain == false ? 3 : 2))
        .join('.');
}




//쿠키값 가져오기
function getCookie(cName) {
      cName = cName + '=';
      var cookieData = document.cookie;
      var start = cookieData.indexOf(cName);
      var cValue = '';
      if(start != -1){
        start += cName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cValue = cookieData.substring(start, end);
      }
      return unescape(cValue);
}


//쿠키 확인
function checkCookie(name) {
    var cookies = document.cookie.split(';');
    
    document.cookie.split(';');
    var visited = false;
		    
    for(var i=0; i<cookies.length; i++){
    	if(cookies[i].indexOf(name) > -1){
    		visited = true;
    	}
    }
	return visited 
}