$(document).ready(function(){

	winResize();

	$(".full-search > input").on("keyup",function(e){
		if(e.keyCode == 13){
			$(this).siblings("button").trigger("click")
		}
	})

	$(".with-clear").each(function(){
		if($(this).find("input").val().length > 0){
			$(this).find(".btn-clear").show();
		}
	})

	 $(".btn-popup").on("click",function(){
		  //$('html, body').css({'overflow': 'hidden'});
		  var name = $(this).attr('layer-name');
		  $('.layer-popup[layer-name=' + name + ']').addClass("on");
		  popup();
	 })

	 $(document).on("click",".btn-pop-close",function(){
	   $(this).parents(".layer-popup").removeClass("on")
	   //$('html, body').css({'overflow': 'auto'});
	 })
	 $(".layer-popup .popClose").on("click",function(){
		$(this).parents(".layer-popup").removeClass("on")
		//$('html, body').css({'overflow': 'auto'});
	  })
	 $(".auto-popup").addClass("on");
	 popup()

	 $(".bottom-map-wrap .bred-dep01").on("mouseover",function(){
		$(this).addClass("on");
		$(this).find(".bred-dep02").slideDown(200);
	})
	$(".bottom-map-wrap .bred-dep01").on("mouseleave",function(){
		$(this).removeClass("on");
		$(this).find(".bred-dep02").stop().slideUp(200);
	})
    /* ------------------------------------------------------------------------------------------------------------------
        탭
    ------------------------------------------------------------------------------------------------------------------ */
	 $(".tab .tab-item").on("click",function(){
		 var idx = $(this).index();
		 $(this).addClass('on').siblings('.tab-item').removeClass('on');
		 $(this).parents('.tab-list').siblings('.tab-conts').find('.tab-cont').removeClass('on').eq(idx).addClass('on');
	 })


    if($(".casa-input-type01 .tb").length > 1){
    	$(".casa-input-type01 .tb").css({"margin-bottom":"10px"})
    	$(".casa-input-type01 .tb:last-child").css({"margin-bottom":"0px"})
    }
    $("button.basic").on("mouseover",function(){
    	$(this).css({"background-color":"#787878"})
    	$(this).css({"border":"2px solid #787878"})
    })
    $("button.basic").on("mouseleave",function(){
    	$(this).css({"background-color":"#000"})
    	$(this).css({"border":"2px solid #000"})
    })
    $("button.white").on("mouseover",function(){
    	$(this).css({"background-color":"#f7f7f7"})
    })
    $("button.white").on("mouseleave",function(){
    	$(this).css({"background-color":"#fff"})
    })

    // 페이지 내부 title 아코디언열기
    $('.title-area.type01 .title .tit-text').click(function() {
        if ($(this).siblings('.inner-box').hasClass('on')) {
            $('.title-area .inner-box').removeClass('on').find('.layer').stop().slideUp(100);
        } else {
            $(this).siblings('.inner-box').addClass('on').find('.layer').stop().slideDown(200);
        }
    });
    // 페이지 내부 title 아코디언닫기
    $(document).mouseup(function(e) {
        var page = $('.title-area.type01 .inner-box');
        var tit = $('.title-area.type01 .tit-text');
        if (!page.is(e.target) && page.has(e.target).length === 0 && !tit.is(e.target)) {
            $('.title-area .inner-box').removeClass('on').find('.layer').slideUp(100);
        }
    });

   $(".title-area.type01 .layer").css({"width":$(".title-area.type01 .tit-text").outerWidth()})

   $(".radio-type02").on("change",function(){
	   if($(this).find(".active").prop("checked")== true){
		   $(this).addClass("on")
	   }else{
		   $(this).removeClass("on")
	   }
   })

   //전체선택 전체동의
   $(".check-area .all-check input[type=checkbox]").on("change",function(){
		if($(this).prop("checked")==true){
			$(this).parent(".all-check").siblings(".check-items").find("input[type=checkbox]").prop("checked",true)
			$(this).parent(".all-check").siblings(".check-items").find("input[type=checkbox]").val("Y")
		}else{
			$(this).parent(".all-check").siblings(".check-items").find("input[type=checkbox]").prop("checked",false)
			$(this).parent(".all-check").siblings(".check-items").find("input[type=checkbox]").val("N")
		}
	})

	$(".check-area .check-items input[type=checkbox]").on("change",function(){
		var nonchecked = 0

		if($(this).prop("checked") == true) {
			$(this).val('Y')
		} else {
			$(this).val('N')
		}

		$(this).parent(".check-items").find('input[type=checkbox]').each(function(){
			if($(this).prop("checked")==false){
				nonchecked +=1
			}
		})
		if(nonchecked==0){
		$(this).parent(".check-items").siblings(".all-check").find("input[type=checkbox]").prop("checked",true)
		}else{
		$(this).parent(".check-items").siblings(".all-check").find("input[type=checkbox]").prop("checked",false)
		}
	})

	if($(".wrapper").find(".title-area").length > 0){
			$(".container").css({"padding-top":"165px"});
	}

	if($(".wrapper").find(".btn-bottom-area").length == 0){
		$(".container").css({"padding-bottom":"110px"});
	}

	$(".tab.type03").each(function(){
        var lng = $(this).find(".tab-item").length;
        var leng = 100 / lng;
        $(this).find(".tab-item").css({"width": leng+"%"})
	})

	 $(".title-zone .lnb-tab > li").each(function(){
		var leg = $(".title-zone .lnb-tab > li").length;
		var wid = 100 / leg;
		$(this).css({"width":wid + "%"})
	 })

	 $(".nav01 .nav-items01 > li.menu").on("mouseover",function(){
		$(".nav01 .nav-items01 > li").removeClass("on")
		$(this).addClass("on")
		$(".sub-nav").slideDown(200);
	  })

	  $(".nav01 .nav-items01 > li.menu").on("mouseleave",function(e){
		$(".sub-nav").stop().slideUp(200);
		$(".nav01 .nav-items01 > li").removeClass("on");

	})

	$(".sub-nav .dep1 ul li").on("mouseover",function(){
		$(".sub-nav .dep1 ul li").removeClass("on");
		$(this).addClass("on");
		var idx = $(this).index();
		$(".sub-nav .dep2 ul").removeClass("on")
		$(".sub-nav .dep2 ul:eq("+(idx)+")").addClass("on");
	})

	
	$(".location .select").on("click",function(){

		$(this).siblings(".select-op").slideToggle(200);
	})


	

})

$(window).scroll(function(e) {
    scrollEvent()
});

$(document).on('touchstart touchmove touchend', function(e) {
    scrollEvent();// 스크롤 이벤트
});

$( window ).resize(function() {
	winResize();
});

function scrollEvent() {
	var winTop = $(window).scrollTop();
	var scrollY = window.scrollY || window.pageYOffset;
	/* 스크롤다운시 해더 */

    if (winTop >= 0) {
        $('html').addClass('scroll');
		$('.title-area').addClass('fixed');
		if($(".main-top").outerHeight() < scrollY ){
			$(".header").css({"position":"fixed","top":"0"})
			$(".title-area").css({"position":"fixed","top":"0"})
		  }else{
			$(".header").css({"position":"absolute","top":"auto"})
			$(".title-area").css({"position":"absolute","top":"110px"})
		  }
    } else {
        $('html').removeClass('scroll');
		$('.title-area').removeClass('fixed');
	}
}

function winResize(){
	// debugger;
	var conType= $(".container");
	var windowWidth = $( window ).width();
	if(conType.hasClass("online-type")){
		if(windowWidth < 1530) {
			//창 가로 크기가 500 미만일 경우
				$(".log-box").css({"right":"20px"})
			} else {
			//창 가로 크기가 500보다 클 경우
				$(".log-box").css({"right":"calc( 50% - 796px)"})
			}
	}else{
		if(windowWidth < 1440) {
			//창 가로 크기가 500 미만일 경우
				$(".log-box").css({"right":"20px"})
			} else {
			//창 가로 크기가 500보다 클 경우
				$(".log-box").css({"right":"calc( 50% - 700px)"})
			}
	}
}

function popup() {
    $('.layer-popup .popup').each(function() {
        var popW = $(this).outerWidth();
        var popH = $(this)[0].scrollHeight;
        $(this).css({'margin-left': -popW / 2, 'margin-top': -popH / 2}).attr('data', popH);

        var winH = $(window).height();
        var data = Number($(this).attr('data'));
        if (data > winH) {
            $(this).closest('.layer-popup').addClass('h-full');
        } else {
            $(this).closest('.layer-popup').removeClass('h-full');
        }
    });
}


function validater(type,_this){
	 switch(type){
	 	case "email" :
	 		var validateCheckter = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*[.][a-zA-Z]{2,3}$/i;
	 		if(validateCheckter.test(_this.val())){
	 			_this.parent().siblings(".validate").find("span").removeClass("on")
	 			_this.parent().siblings(".validate").find(".pass").addClass("on")
	 		}else{
	 			_this.parent().siblings(".validate").find("span").removeClass("on")
	 			_this.parent().siblings(".validate").find(".non-pass").addClass("on")
	 		}
	 		break;
	 	case "password" :
			var pw=_this.val()
			var num = pw.search(/[0-9]/g);
			var eng = pw.search(/[a-z]/ig);
			var spe = pw.search(/[\~\!\@\#\$\%\^\&\*\(\)\_\+]/gi);
			var espe = /[A-Za-z0-9\~\!\@\#\$\%\^\&\*\(\)\_\+]/; //문자+특수문자+숫자 외 금지
			var id = $("#webId").val() || "";
	 		// ~!@#$%^&*()_+
	 		var type01 = false;
	 		var type02 = false;
			var type03 = true;
			var type04 = true;
			var type05 = true;

			if(id.trim() !== ""){
                id = id.split("@")[0];
			}

	  		if(pw.trim().length > 0){
				$(".vali03").addClass("on");
				$(".vali04").addClass("on");
				$(".vali05").addClass("on");
	 		 }

	 		 if(pw.length < 10 || pw.length > 20){
	 			$(".vali01").removeClass("on")
	 			type01=false
	 		 }else{
	 			$(".vali01").addClass("on")
	 			type01=true
	 		 }

	 		if( (num < 0 && eng < 0) || (eng < 0 && spe < 0) || (spe < 0 && num < 0) ){
	 			$(".vali02").removeClass("on")
	 			type02 = false;
	 		}else{
	 			$(".vali02").addClass("on")
	 			type02 = true;
			 }

			 for(var i =0 ; i < pw.length ; i ++){
                if(espe.test(pw.charAt(i)) === false ){
                    $(".vali03").removeClass("on");
                    type03=false
                }
            }

			if(pwVali(pw,3)){
				$(".vali04").removeClass("on");
	 			type04=false
			}

			if(id.trim().length > 0 ){
				if(pw.indexOf(id) > -1){
					$(".vali05").removeClass("on");
					type05=false
				}
			}

	 		if(type01 == true && type02 == true && type03 == true && type04 == true && type05 == true){
	 			_this.parent().siblings(".validate").find("span").removeClass("on")
	 			_this.parent().siblings(".validate").find(".pass").addClass("on")
	 		}else{
	 			_this.parent().siblings(".validate").find("span").removeClass("on")
	 			_this.parent().siblings(".validate").find(".non-pass").addClass("on")
	 		}
			 break;
	}
}

function pwVali(str, max){
	if(!max) max = 4; // 글자수를 지정하지 않으면 4로 지정
    var i, j, k, x, y;
    var buff = ["0123456789","9876543210", "abcdefghijklmnopqrstuvwxyz", "ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    var src, src2, ptn="";

    for(i=0; i<buff.length; i++){
        src = buff[i]; // 0123456789
        src2 = buff[i] + buff[i]; // 01234567890123456789
        for(j=0; j<src.length; j++){
            x = src.substr(j, 1); // 0
            y = src2.substr(j, max); // 0123
            ptn += "["+x+"]{"+max+",}|"; // [0]{4,}|0123|[1]{4,}|1234|...
            ptn += y+"|";
        }
	}

    ptn = new RegExp(ptn.replace(/.$/, "")); // 맨마지막의 글자를 하나 없애고 정규식으로 만든다.

    if(ptn.test(str)) return true;
    return false;
}

var doubleSubmitCheck={
	isFirst : true,
	check : function (){
		if(this.isFirst){
			this.isFirst = false;
        	return true;
		}else{
			return this.isFirst;
		}
	}
}
