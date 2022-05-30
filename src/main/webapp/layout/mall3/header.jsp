<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- 상단 시작 { -->
<div id="hd">
    <h1 id="hd_h1">시자재몰</h1>
    <div id="skip_to_container"><a href="#container">본문 바로가기</a></div>
    
	<!-- 팝업레이어 시작 { -->
	<div id="hd_pop">
	<h2>팝업레이어 알림</h2>
	<span class="sound_only">팝업레이어 알림이 없습니다.</span>
	</div>
	<script>
	$(function() {
	    $(".hd_pops_reject").click(function() {
	        var id = $(this).attr('class').split(' ');
	        var ck_name = id[1];
	        var exp_time = parseInt(id[2]);
	        $("#"+id[1]).css("display", "none");
	        set_cookie(ck_name, 1, exp_time, g5_cookie_domain);
	    });
	    $('.hd_pops_close').click(function() {
	        var idb = $(this).attr('class').split(' ');
	        $('#'+idb[1]).css('display','none');
	    });
	    $("#hd").css("z-index", 1000);
	    

        var $sch = $('#sch_str');   //검색 input
        var $sch_label = $('#sch_stc_label');    //검색 label
        if ($sch.attr('value') == "") $sch_label.css('visibility','visible');
        else  $sch_label.css('visibility','hidden');

        $sch.focus(function() {
            $sch_label.css('visibility','hidden');
        });
        $sch.blur(function() {
            $this = $(this);
            if ($this.attr('id') == "sch_stc" && $this.attr('value') == "") $sch_label.css('visibility','visible');
        });
        
        var hide_menu = false;
        var mouse_event = false;
        var oldX = oldY = 0;

        $(document).mousemove(function(e) {
            if(oldX == 0) {
                oldX = e.pageX;
                oldY = e.pageY;
            }

            if(oldX != e.pageX || oldY != e.pageY) {
                mouse_event = true;
            }
        });

        // 二쇰찓��
        var $gnb = $(".gnb_1dli > a");
        $gnb.mouseover(function() {
            if(mouse_event) {
                $("#hd").addClass("hd_zindex");
                $(".gnb_1dli").removeClass("gnb_1dli_over gnb_1dli_over2 gnb_1dli_on");
                $(this).parent().addClass("gnb_1dli_over gnb_1dli_on");
                menu_rearrange($(this).parent());
                hide_menu = false;
            }
        });

        $gnb.mouseout(function() {
            hide_menu = true;
        });

        $(".gnb_2dli").mouseover(function() {
            hide_menu = false;
        });

        $(".gnb_2dli").mouseout(function() {
            hide_menu = true;
        });

        $gnb.focusin(function() {
            $("#hd").addClass("hd_zindex");
            $(".gnb_1dli").removeClass("gnb_1dli_over gnb_1dli_over2 gnb_1dli_on");
            $(this).parent().addClass("gnb_1dli_over gnb_1dli_on");
            menu_rearrange($(this).parent());
            hide_menu = false;
        });

        $gnb.focusout(function() {
            hide_menu = true;
        });

        $(".gnb_2da").focusin(function() {
            $(".gnb_1dli").removeClass("gnb_1dli_over gnb_1dli_over2 gnb_1dli_on");
            var $gnb_li = $(this).closest(".gnb_1dli").addClass("gnb_1dli_over gnb_1dli_on");
            menu_rearrange($(this).closest(".gnb_1dli"));
            hide_menu = false;
        });

        $(".gnb_2da").focusout(function() {
            hide_menu = true;
        });

        $('#gnb_1dul>li').bind('mouseleave',function(){
            submenu_hide();
        });

        $(document).bind('click focusin',function(){
            if(hide_menu) {
                submenu_hide();
            }
        });        
	});
	
    function search_submit(f) {
        if (f.q.value.length < 2) {
            alert("검색어는 두글자 이상 입력하십시오.");
            f.q.select();
            f.q.focus();
            return false;
        }

        return true;
    }
    
    function submenu_hide() {
        $("#hd").removeClass("hd_zindex");
        $(".gnb_1dli").removeClass("gnb_1dli_over gnb_1dli_over2 gnb_1dli_on");
    }

    function menu_rearrange(el)
    {
        var width = $("#gnb_1dul").width();
        var left = w1 = w2 = 0;
        var idx = $(".gnb_1dli").index(el);
        var max_menu_count = 0;
        var $gnb_1dli;

        for(i=0; i<=idx; i++) {
            $gnb_1dli = $(".gnb_1dli:eq("+i+")");
            w1 = $gnb_1dli.outerWidth();

            if($gnb_1dli.find(".gnb_2dul").size())
                w2 = $gnb_1dli.find(".gnb_2dli > a").outerWidth(true);
            else
                w2 = w1;

            if((left + w2) > width) {
                if(max_menu_count == 0)
                    max_menu_count = i + 1;
            }

            if(max_menu_count > 0 && (idx + 1) % max_menu_count == 0) {
                el.removeClass("gnb_1dli_over").addClass("gnb_1dli_over2");
                left = 0;
            } else {
                left += w1;
            }
        }
    }
	</script>
	
	<div id="hd_wrapper">
		<div id="hd_sch">
		    <h3>쇼핑몰 검색</h3>
		    <form name="frmsearch1" action="${contextPath}/search.do" onsubmit="return search_submit(this);">
		    <label for="sch_str" id="sch_stc_label">검색어<strong class="sound_only"> 필수</strong></label>
		    <input type="text" name="q" value="" id="sch_str" required>
		    <input type="submit" value="검색" id="sch_submit">
		    </form>
	    </div>
	
	    <div id="logo"><a href="${contextPath}"><img src="${contextPath}/resources/images/mall/logo.png" alt="영카트5 테마데모"></a></div>
	
	    <div id="tnb">
	        <h3>회원메뉴</h3>
	        <ul>
	        	<c:if test="${empty USER.MEMB_ID}">
		            <%-- <li><a href="${contextPath}/memberJoinStep1">회원가입</a></li> --%>
		            <li><a href="${contextPath}/user/loginForm">로그인</a></li>
	            </c:if>
	            <!-- li><a href="#"><b>로그인</b></a></li -->
	            <c:if test="${!empty USER.MEMB_ID}">
		            <li><a href="#">마이페이지</a></li>
		            <li><a href="#">1:1문의게시판</a></li>
		            <li><a href="${contextPath}/basket">장바구니</a></li>
		            <li><a href="${contextPath}/order">주문내역</a></li>
		            <li><a href="${contextPath}/wishList">관심상품</a></li>
		            <li><a href="${contextPath }/user/logout">로그아웃</a></li>
	            </c:if>
	            <!-- li><a href="#">FAQ</a></li -->
	            <!-- li><a href="#">1:1문의</a></li -->
	        </ul>
	    </div>
	</div>

	<!-- 쇼핑몰 카테고리 시작 { -->
	<nav id="gnb">
		<h2>쇼핑몰 카테고리</h2>
		<ul id="gnb_1dul">
			<li class="gnb_1dli" style="z-index: 998">
				<a href="#" class="gnb_1da gnb_1dam">카테고리</a>
				<ul class="gnb_2dul" style="z-index: 998">
					<c:forEach var="ent" items="${ cagoList }" varStatus="status">
						<c:if test="${ent.LVL eq '1' }">
						<li class="gnb_2dli"><a href="${contextPath }/goods?CAGO_ID=${ ent.CAGO_ID }" class="gnb_2da">${ ent.CAGO_NAME }</a></li>
						</c:if>
					</c:forEach>
				</ul></li>
			<li class="gnb_1dli" style="z-index: 997">
				<a href="#" class="gnb_1da gnb_1dam">Top50</a>
			</li>
			<li class="gnb_1dli" style="z-index: 997">
				<a href="#" class="gnb_1da gnb_1dam">신상풀</a>
			</li>
			<li class="gnb_1dli" style="z-index: 997">
				<a href="#" class="gnb_1da gnb_1dam">특가세일</a>
			</li>
		</ul>
		<ul class="gnb_co">
			<!-- li class="bg_no"><a href="#">개인결제</a></li -->
			<li><a href="#">구매후기</a></li>
			<li><a href="#">공지사항</a></li>
		</ul>
	</nav>
	<!-- } 쇼핑몰 카테고리 끝 -->
</div>