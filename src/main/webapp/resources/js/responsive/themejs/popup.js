/**
 * cookie
 */ 
$(document).ready(function(){
	// Animate loader off screen
	$(window).load(function() {	
		if(getCookie("Notice") != "done") {
			layer_popup();
		}
	});
	
	//cookie 조회
	function getCookie(name) {
		var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
		return value? value[2] : null;
	}
	
	// cookie 저장
	function setCookie(name, value, expiredays ) {    
	    /*
	     * name=value 형태로 cookie에 저장하는데 expiredays 만큼 저장한다
	     * path=/ 는 모든 페이지에 적용
	     */
	     var date = new Date();
	     date.setTime(date.getTime() + expiredays * 60 * 60 * 24 * 1000);
	     document.cookie = name + '=' + escape( value ) + ';expires=' + date.toUTCString() + ';path=/';    
	}
	
	// 하루동안 보지않기
	function closeDay() {
		/*
		 * 함수를 호출하면 cookie 값에 현재 페이지를 열었다는 정보를 넣는다
		 * notice=yes라는 정보를 1일동안 유지한다
		 * 부모창의 빨간색 굵은걸로 표시한 부분과 이름이 동일해야함. 
		 * Notice, done 까지!!! 뒤에 숫자1은 하루만 열지않는다는뜻
		 */   
	    setCookie("Notice", "done" , 1);
	    console.log("쿠키저장 : "+getCookie("Notice"));    
	    $('#pop-layer').css("display", "none");	/*$('#pop-layer').hide();*/
	}
	
	function layer_popup(){
		console.log("팝업함수!!");
	    $("#pop-layer").css("display", "block");	/*$('#pop-layer').show();*/	    
	}	
	
	$('#pop-layer').find('a.layer-exit').click(function(){
    	console.log("팝업닫힘!!");
    	$('#pop-layer').css("display", "none");
        return false;
    });
		
	$('#pop-layer').find('a.day-exit').click(function(){
		closeDay();
    });
});