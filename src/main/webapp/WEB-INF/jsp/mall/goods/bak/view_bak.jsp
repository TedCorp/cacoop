<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<script>
	$(function() {
		$('.goodsImg').load(function(){

		    var maxWidth = 450; 						// Max width for the image
		    var maxHeight = 400;    					// Max height for the image
		    var ratio = 0;  							// Used for aspect ratio
		    var width = $(this).width();    			// Current image width
		    var height = $(this).height();  			// Current image height

		    // Check if the current width is larger than the max
		    if(width > maxWidth){
		        ratio = maxWidth / width;   			// get ratio for scaling image
		        $(this).css("width", maxWidth); 		// Set new width
		        $(this).css("height", height * ratio);  // Scale height based on ratio
		        height = height * ratio;    			// Reset height to match scaled image
		    }

		    var width = $(this).width();    // Current image width
		    var height = $(this).height();  // Current image height

		    // Check if current height is larger than max
		    if(height > maxHeight){
		        ratio = maxHeight / height; 			// get ratio for scaling image
		        $(this).css("height", maxHeight);   	// Set new height
		        $(this).css("width", width * ratio);    // Scale width based on ratio
		        width = width * ratio;    				// Reset width to match scaled image
		    }
		    
		    var width = $(this).width();    // Current image width
		    var height = $(this).height();  // Current image height
		    
		    var top = 0;
		    if(height < maxHeight){
		    	top = (maxHeight - height)/2; 		// get ratio for scaling image
		        $(this).css("margin-top", top);   	// Set top
		    }
		    
		    $(this).show();
			
		});
		$('.goodsImg').each(function() {
			$(this).error(function(){
				$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
			});
		 });
		
		$('#sit_btn_cart').click(function(){
			
	    	$('#PD_QTY').val($('#CT_QTY').val());
	    	
	    	$.ajax({
	    		type: "POST",
	    		url: '${contextPath}/goods/basketInst',
	    		data: $("#bkInstFrm").serialize(),
	    		success: function (data) {

	    			// 장바구니 등록 여부
	    			if (data == '0') {
	    				alert("장바구니에 등록되었습니다.");
	    			}else{
	    				alert("장바구니에 이미 등록되어있습니다.");
	    			}
	    		}, error: function (jqXHR, textStatus, errorThrown) {
	    			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
	    		}
	    	});
		});
		
		$('#sit_btn_buy').click(function(){
			$('#PD_QTY').val($('#CT_QTY').val());
			$('#ORDER_QTY').val($('#CT_QTY').val());
			$('#bkInstFrm').attr('action', '${contextPath}/order/buy').submit();
		});

	    // 수량변경 및 삭제
	    $(document).on("click", "#divQty button", function() {
	        var mode = $(this).text();
	        var this_qty, max_qty = 9999, min_qty = 1;
	        var $el_qty = $(this).closest("div").find("input[name^=CT_QTY]");
	        var stock = 100;

	        switch(mode) {
	            case "증가":
	                this_qty = parseInt($el_qty.val().replace(/[^0-9]/, "")) + 1;
	                if(this_qty > stock) {
	                    alert("재고수량 보다 많은 수량을 구매할 수 없습니다.");
	                    this_qty = stock;
	                }

	                if(this_qty > max_qty) {
	                    this_qty = max_qty;
	                    alert("최대 구매수량은 "+number_format(String(max_qty))+" 입니다.");
	                }

	                $el_qty.val(this_qty);
	                price_calculate();
	                break;

	            case "감소":
	                this_qty = parseInt($el_qty.val().replace(/[^0-9]/, "")) - 1;
	                if(this_qty < min_qty) {
	                    this_qty = min_qty;
	                    alert("최소 구매수량은 "+number_format(String(min_qty))+" 입니다.");
	                }
	                $el_qty.val(this_qty);
	                price_calculate();
	                break;

	            default:
	                alert("올바른 방법으로 이용해 주십시오.");
	                break;
	        }
	    });
	});
	
	// 가격계산
	function price_calculate()
	{
	    var PD_PRICE = parseInt($("input#PD_PRICE").val());
	    if(isNaN(PD_PRICE))
	        return;

	    var qty = parseInt($("#CT_QTY").val());
	    var total = PD_PRICE * qty;

	    $("#sit_tot_price").empty().html("<span>총 금액 :</span> "+number_format(String(total))+"원");
	    
	    $('#ORDER_AMT').val(total);
	}
	
	// 상품보관
	function item_wish(f, it_id)
	{
		
    	$('#PD_QTY').val($('#CT_QTY').val());
    	
    	$.ajax({
    		type: "POST",
    		url: '${contextPath}/goods/wishInst',
    		data: $("#bkInstFrm").serialize(),
    		success: function (data) {

    			// 관심상품 등록 여부
    			if (data == '0') {
    				alert("관심상품에 등록되었습니다.");
    			}else{
    				alert("관심상품에 이미 등록되어있습니다.");
    			}
    		}, error: function (jqXHR, textStatus, errorThrown) {
    			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
    		}
    	});
	}
	
	
</script>
<c:set var="arrCagoIdPath" value="${fn:split(rtnCagoInfo.CAGO_ID_PATH, '>') }" /> 
<c:set var="arrCagoNmPath" value="${fn:split(rtnCagoInfo.CAGO_NM_PATH, '>') }" /> 

<div id="wrapper_title">상품 상세정보</div>
<div id="sct_location">
	<a href='${contextPath }/goods' class="sct_bg">Home</a>
	<c:forEach var="entPath" items="${ arrCagoNmPath }" varStatus="status">
		<a href="${contextPath }/goods?CAGO_ID=${arrCagoIdPath[status.index] }" class="${ fn:length(arrCagoNmPath) eq status.count ? 'sct_here' : 'sct_bg' } ">${entPath }</a>
	</c:forEach>
</div>

<c:if test="${ fn:length(rtnCagoList) > 1}">
	<!-- 상품분류 1 시작 { -->
	<aside id="sct_ct_1" class="sct_ct">
		<h2>현재 상품 분류와 관련된 분류</h2>
		<ul>
			<c:forEach var="ent" items="${ rtnCagoList }" varStatus="status">
				<li><a href="${contextPath }/goods?CAGO_ID=${ ent.CAGO_ID }"><b><c:out value="${ ent.CAGO_NAME }" escapeXml="true"/> (${ ent.PRD_CNT })</b></a></li>
			</c:forEach>
		</ul>
	</aside>
	<!-- } 상품분류 1 끝 -->
</c:if>

<form id="bkInstFrm" name="bkInstFrm" action="${contextPath }/goods/basketInst" method="post" autocomplete="off">
	<input type="hidden" name="PD_CODE" id="PD_CODE" value="${result.PD_CODE }">
	<input type="hidden" name="PD_QTY" id="PD_QTY" value="">
	<input type="hidden" name="ORDER_QTY" id="ORDER_QTY" value="">
	<input type="hidden" id="BSKT_REGNO" name="BSKT_REGNO" value="">
	<input type="hidden" id="PD_NAME" name="PD_NAME" value="${result.PD_NAME}" />
	<input type="hidden" id="PD_PRICE" name="PD_PRICE" value="${result.PD_PRICE}" />
	<input type="hidden" id="PDDC_GUBN" name="PDDC_GUBN" value="${result.PDDC_GUBN}" />
	<input type="hidden" id="PDDC_VAL" name="PDDC_VAL" value="${result.PDDC_VAL}" />
	<input type="hidden" id="ORDER_AMT" name="ORDER_AMT" value="${ result.PD_PRICE }" />
	<input type="hidden" id="DLVY_AMT" name="DLVY_AMT" value="0" />
	<input type="hidden" id="DAP_YN" name="DAP_YN" value="N" />
</form>
<!-- 상품 상세보기 시작 { -->
<div id="sit_hhtml"></div>

	<div id="sit">
	

		<form name="fitem" name="fitem" method="post" action="#" onsubmit="return fitem_submit(this);">
		<input type="hidden" name="it_id[]" value="1442995017">
		<input type="hidden" name="sw_direct">
		<input type="hidden" name="url">
		
		<!-- 상품이미지 미리보기 시작 { -->
		<div id="sit_pvi">
		    <div id="sit_pvi_big">
		        <div id="mslider" class="flexslider">
		            <ul class="slides">
					<c:if test="${ !empty(fileList) }">
						<c:forEach var="var" items="${ fileList }" varStatus="status">
							<li><a href="${contextPath }/common/commonFileDown?ATFL_ID=${var.ATFL_ID }&ATFL_SEQ=${var.ATFL_SEQ}" target="_new" class="popup_item_image"><img src="${contextPath }/common/commonFileDown?ATFL_ID=${var.ATFL_ID }&ATFL_SEQ=${var.ATFL_SEQ}" width="400" height="450" class="goodsImg" alt=""></a></li>
						</c:forEach>
					</c:if>
					<c:if test="${ empty(fileList) }">
						<li><a target="_blank" class="popup_item_image"><img src="${contextPath }/resources/images/mall/goods/noimage.png" width="450" height="400" class="goodsImg" alt=""></a></li>
					</c:if>
			       </ul>
		        </div>
		    </div>
		</div>
		<!-- } 상품이미지 미리보기 끝 -->
		<!-- 상품 요약정보 및 구매 시작-->
		<section id="sit_ov">
			<h2 id="sit_title"><c:out value="${ result.PD_NAME }" escapeXml="true"/> <span class="sound_only">요약정보 및 구매</span></h2>
			<div class="sit_pr">
				<h3>판매가격</h3>
				<fmt:formatNumber value="${ result.PD_PRICE }" pattern="#,###"/>
				<input type="hidden" id="PD_PRICE" value="${ result.PD_PRICE }">
			</div>
			<div id="sit_star">
				<c:if test="${ !empty result.AVG_PD_PTS and result.AVG_PD_PTS ne '0'}">
				<h3>고객평점 <span>별${ result.AVG_PD_PTS }개</span></h3>
				<img src="${contextPath }/resources/images/mall/goods/s_star${ result.AVG_PD_PTS }.png" alt="" class="sit_star">
				</c:if>
			</div>
		    <!-- p id="sit_desc">상품설명입니다.</p  -->
			<ul id="sit_ov_if">
				<li><button type="button"  class="accordion-toggle">상품정보</button>
				<!--상품정보-->
				<div class="dt_ul_op">
					<table>
						<tr>
							<th scope="row">제조사</th>
							<td><c:out value="${ result.MAKE_COM }" escapeXml="true"/> </td>
						</tr>
						<tr>
							<th scope="row">원산지</th>
							<td><c:out value="${ result.ORG_CT }" escapeXml="true"/></td>
						</tr>
						<tr>
							<th scope="row">판매가격</th>
							<td> 
								<fmt:formatNumber value="${ result.PD_PRICE }" pattern="#,###"/>원 
							</td>
						</tr>
					</table>
		        </div>
		        <!--상품정보-->
			</li>
		
			<li class="dt_dv">
				<span class="dt_dv_tit">수량</span>
				<div id="divQty">
					<label for="CT_QTY" class="sound_only">수량</label>
					<input type="text" name="CT_QTY" value="1" id="CT_QTY" class="frm_input" size="5">
					<button type="button" class="sit_qty_plus btn_frmline">증가</button>
					<button type="button" class="sit_qty_minus btn_frmline">감소</button>
				</div>
			</li>
			<li class="dt_dv">
				<div id="sit_tot_price">총 금액 : <fmt:formatNumber value="${ result.PD_PRICE }" pattern="#,###"/>원</div>
			</li>
			
		</ul>
		<!-- 총 구매액 -->
		<%/*  주석 처리 #################################################################################################################################################  %>
		<div id="sit_ov_btn">
			<input type="button" onclick="document.pressed=this.value;" value="바로구매" id="sit_btn_buy">
			<input type="button" onclick="document.pressed=this.value;" value="장바구니" id="sit_btn_cart">
			<!-- a href="javascript:item_wish(document.fitem, '1442995017');" id="sit_btn_wish">위시리스트</a><a href="javascript:popup_item_recommend('1442995017');" id="sit_btn_rec">추천하기</a -->
		</div>
		<% 주석 처리 ################################################################################################################################################# */ %>
		</section>
	</form>
	
	<script>
	//이미지슬라이드
	$(window).load(function() {
	    $('#mslider').flexslider({animation: "slide"});
	});
	
	//상품정보 탭
	  $(document).ready(function($) {
	    $("#sit_ov_if").find(".accordion-toggle").click(function(){
	        $(this).next().slideToggle('fast');
	        $(".dt_ul_op").not($(this).next()).slideUp('fast');
	    });
	  });

	$(function(){
	    // 상품이미지 첫번째 링크
	    $("#sit_pvi_big a:first").addClass("visible");
	
	    // 상품이미지 미리보기 (썸네일에 마우스 오버시)
	    $("#sit_pvi .img_thumb").bind("mouseover focus", function(){
	        var idx = $("#sit_pvi .img_thumb").index($(this));
	        $("#sit_pvi_big a.visible").removeClass("visible");
	        $("#sit_pvi_big a:eq("+idx+")").addClass("visible");
	    });
	
	    // 상품이미지 크게보기
	    $(".popup_item_image").click(function() {
	        var url = $(this).attr("href");
	        var top = 10;
	        var left = 10;
	        var opt = 'scrollbars=yes,top='+top+',left='+left;
	        popup_window(url, "largeimage", opt);
	
	        return false;
	    });
	    
	    // 목록가기
	    $("#btnList").click(function() {
	    	history.go(-1)();
	    });
	        
	});
	
	
	// 바로구매, 장바구니 폼 전송
	function fitem_submit(f)
	{
		var pdCd = $('#PD_CODE').val();		

	    if (document.pressed == "장바구니") {
	        f.sw_direct.value = 0;
	        //$('#fitem').attr('action', '${contextPath}/basketInst/'+pdCd);
	    } else { // 바로구매
	        f.sw_direct.value = 1;
	    }
	
	    // 판매가격이 0 보다 작다면
	    if (document.getElementById("PD_PRICE").value < 0) {
	        alert("전화로 문의해 주시면 감사하겠습니다.");
	        return false;
	    }
	
/* 	    if($(".sit_opt_list").size() < 1) {
	        alert("상품의 선택옵션을 선택해 주십시오.");
	        return false;
	    } */
	
	    var val, io_type, result = true;
	    var sum_qty = 0;
	    var min_qty = parseInt(0);
	    var max_qty = parseInt(0);
	    var $el_type = $("input[name^=io_type]");
	
	    $("input[name^=CT_QTY]").each(function(index) {
	        val = $(this).val();
	
	        if(val.length < 1) {
	            alert("수량을 입력해 주십시오.");
	            result = false;
	            return false;
	        }
	
	        if(val.replace(/[0-9]/g, "").length > 0) {
	            alert("수량은 숫자로 입력해 주십시오.");
	            result = false;
	            return false;
	        }
	
	        if(parseInt(val.replace(/[^0-9]/g, "")) < 1) {
	            alert("수량은 1이상 입력해 주십시오.");
	            result = false;
	            return false;
	        }
	
	        io_type = $el_type.eq(index).val();
	        if(io_type == "0")
	            sum_qty += parseInt(val);
	    });
	
	    if(!result) {
	        return false;
	    }
	
	    if(min_qty > 0 && sum_qty < min_qty) {
	        alert("선택옵션 개수 총합 "+number_format(String(min_qty))+"개 이상 주문해 주십시오.");
	        return false;
	    }
	
	    if(max_qty > 0 && sum_qty > max_qty) {
	        alert("선택옵션 개수 총합 "+number_format(String(max_qty))+"개 이하로 주문해 주십시오.");
	        return false;
	    }
	

	    if (document.pressed == "장바구니") {
	        //f.action = '${contextPath}/basketInst/'+pdCd;
	    	alert($('#CT_QTY').val());
	    	$.ajax({
	    		type: "POST",
	    		url: '${contextPath}/goods/basketInst',
	    		data: $("#fitem").serialize(),
	    		success: function (data) {

	    			alert(data);
	    			// 아이디 중복 여부
	    			if (data == '0') {
	    			}else{
	    			}
	    		}, error: function (jqXHR, textStatus, errorThrown) {
	    			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
	    		}
	    	});
	    	return false;
	    } else { // 바로구매
		    return true;
	    }
	    
	}
	</script>
	</div>
	<div id="sit">
	<div id="sif_inf_wr">
		<!-- 상품 정보 시작 { -->
		<button type="button" class="inf_btn">상품정보</button>
		<section id="sit_inf"  class="inf_con">
			${ result.PD_DINFO }
		</section>
		<!-- } 상품 정보 끝 -->


<%/*  주석 처리 #################################################################################################################################################  %>
		<!-- 사용후기 시작 { -->
		<button type="button" class="inf_btn">사용후기(${fn:length(resultRev) })</button>
		<section id="sit_use"  class="inf_con">
			<h2>사용후기</h2>
			<div id="itemuse">
	
				<!-- 상품 사용후기 시작 { -->
				<section id="sit_use_list">
					<h3>등록된 사용후기</h3>
					<c:if test="${ !empty(resultRev) }">
					    <ol id="sit_use_ol">
							<c:forEach var="ent" items="${ resultRev }" varStatus="status">
					        <li class="sit_use_li">
								<button type="button" class="sit_use_li_title"><b>${ent.BRD_NUM}.</b> ${ent.BRD_SBJT}</button>
								<dl class="sit_use_dl">
									<dt>작성자</dt>
									<dd>${ent.WRTR_NM}</dd>
									<dt>작성일</dt>
									<dd>${ent.WRT_DTM}</dd>
									<dt>평점<dt>
									<dd class="sit_use_star"><img src="${contextPath }/resources/images/mall/goods/s_star${ent.PD_PTS}.png" alt="별${ent.PD_PTS}개"></dd>
								</dl>
								<div id="sit_use_con_0" class="sit_use_con">
									<div class="sit_use_p">
										<p>${ent.BRD_CONT}</p>                
									</div>
								</div>
					        </li>
					        </c:forEach>
					    </ol>
				    </c:if>
				    <c:if test="${ empty(resultRev) }">
				    	<p class="sit_empty">사용후기가 없습니다.</p>
				    </c:if>
				</section>
		
			
				<div id="sit_use_wbtn">
				    <a href="./itemuseform.php?it_id=1442995017" class="btn02 itemuse_form">사용후기 쓰기<span class="sound_only"> 새 창</span></a>
				    <a href="./itemuselist.php" class="btn01 itemuse_list">더보기</a>
				</div>
			
			<!-- } 상품 사용후기 끝 -->
			</div>
		</section>
		<!-- } 사용후기 끝 -->
		
		<!-- 상품문의 시작 { -->
		<button type="button" class="inf_btn">상품문의(${fn:length(resultQna) })</button>
		
		<section id="sit_qa" class="inf_con">
			<h2>상품문의</h2>
			<div id="itemqa">
		
				<!-- 상품문의 목록 시작 { -->
				<section id="sit_qa_list">
					<h3>등록된 상품문의</h3>
				
				    <c:if test="${ !empty(resultQna) }">
						<ol id="sit_qa_ol">
							<c:forEach var="ent" items="${ resultQna }" varStatus="status">
								<li class="sit_qa_li">
									<button type="button" class="sit_qa_li_title"><b>${ent.BRD_NUM}.</b> ${ent.BRD_SBJT}</button>
									<dl class="sit_qa_dl">
										<dt>작성자</dt>
										<dd>${ent.WRTR_NM}</dd>
										<dt>작성일</dt>
										<dd>${ent.WRT_DTM}</dd>
										<dt>상태</dt>
										<dd class="sit_qaa_done">${ent.REPLY_YN eq 'Y' ? '답변완료' : '답변대기'}</dd>
									</dl>
									
									<div id="sit_qa_con_0" class="sit_qa_con">
										<div class="sit_qa_p">
											<div class="sit_qa_qaq">
												<strong>문의내용</strong><br>
												<p>${ent.BRD_CONT} </p>                    
											</div>
											<div class="sit_qa_qaq">
												<strong>답변내용</strong><br>
												<p>${ent.QNA_REPLY} </p>                    
											</div>
										</div>
									</div>
								</li>
							</c:forEach>
						</ol>
					</c:if>
				    <c:if test="${ empty(resultQna) }">
				    	<p class="sit_empty">상품문의가 없습니다.</p>
				    </c:if>
				</section>
				
				<div id="sit_qa_wbtn">
					<!-- <a href="javascript:itemqawin('it_id=1442995017');">상품문의 쓰기<span class="sound_only"> 새 창</span></a> -->
					<a href="./itemqaform.php?it_id=1442995017" class="btn02 itemqa_form">상품문의 쓰기<span class="sound_only"> 새 창</span></a>
					<a href="./itemqalist.php" id="itemqa_list" class="btn01">더보기</a>
				</div>
		
			<!-- } 상품문의 목록 끝 -->
			</div>
		</section>
		<!-- } 상품문의 끝 -->
		
		<!-- 배송/환불정보 시작 { -->
		<button type="button" class="inf_btn">배송/환불정보</button>
		<section id="sit_dvr" class="inf_con">
		    <h2>배송/환불정보</h2>
		    <p>${result.DLVREF_GUIDE}</p><p> </p>
		</section>
		<!-- } 배송/환불정보 끝 -->
<%주석 처리 #################################################################################################################################################   */ %>
	</div>


</div>

<div style="padding:20px 0 20px 0;">
	<button type="button" class="btn btn-sm btn-success pull-right" id="btnList">목록</button>	
</div>

<script>
//상품정보 탭
  $(document).ready(function($) {
    $("#sif_inf_wr").find(".inf_btn").click(function(){
        $(this).next().slideToggle('fast');
        $(".inf_con").not($(this).next()).slideUp('fast');
    });
    
    $('#sif_inf_wr').find(".inf_btn").first().trigger('click');
  });

</script>
