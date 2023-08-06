$(document).ready(function(){

    $('.fa-eye-slash').on('click',function(){
        $('input').toggleClass('active');
        if($('input').hasClass('active')){
            $(this).attr('class',"fa fa-eye")
            .prev('input').attr('type',"text");
        }else{
            $(this).attr('class',"fa fa-eye-slash")
            .prev('input').attr('type','password');
        }
    });
    
    const naverLoginBtn = document.querySelector('.btn-naver');
	const naverLoginSpan = document.querySelector('#naver-login');
	
	naverLoginSpan.addEventListener('click', () => {
	  naverLoginBtn.click();
	});
});
