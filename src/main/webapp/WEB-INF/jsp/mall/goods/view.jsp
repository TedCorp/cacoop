<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  
<script type="text/javascript">

	$(document).on('click','#sbjt',function(){
	    
	    var dtl = "reply_" + $(this).attr("val");
	    
	    if($('#'+dtl).is(":visible")){
	    	$('#'+dtl).hide();
	    }else{
		    $('#'+dtl).show();
	    }
	    
	    
	});
	
	function fn_price_calculate(){
	    var PD_PRICE = parseInt($("input#PD_PRICE").val());
	    if(isNaN(PD_PRICE))
	        return;

	    var qty = parseInt($("#CT_QTY").val());
	    var total = PD_PRICE * qty;
	    $("#sit_tot_price").empty().html("총금액 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp;"+number_format(String(total))+"원");
	    
	    $('#ORDER_AMT').val(total);
	}
	
	function fn_sit_btn_buy(){
		$('#PD_QTY').val($('#CT_QTY').val());
		$('#ORDER_QTY').val($('#CT_QTY').val());
		$('#bkInstFrm').attr('action', '${contextPath}/order/buy').submit();
	}

	function fn_sit_btn_cart(){
		
		if("${USER.MEMB_ID}" == ""){
			alert("로그인이 필요합니다.");
			
			location.href = "${contextPath}/user/loginForm";
			
			return false;
		}
		
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
	}

	// 상품보관
	function fn_item_wish(f, it_id)
	{

		if("${USER.MEMB_ID}" == ""){
			alert("로그인이 필요합니다.");
			
			location.href = "${contextPath}/user/loginForm";
			
			return false;
		}
		
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
<c:set var="arrCagoIdPath" value="${fn:split(rtnCagoInfo.CAGO_ID_PATH, '>') }" /> 
<c:set var="arrCagoNmPath" value="${fn:split(rtnCagoInfo.CAGO_NM_PATH, '>') }" /> 
<table border="0" cellpadding="0" cellspacing="0" width="720">
<tr>
	<td width="725" valign="top">
		<!-- 위치타이틀 -->
		<table border="0" cellpadding="0" cellspacing="0" width="687">
		<tr>
			<td width="50%"><img src="${contextPath }/resources/images/dtlimg/title.gif" border="0"></td>
			<td width="50%" align="right" style="font-size:11px;color:#878787">HOME < 상세보기 < 
			<c:forEach var="entPath" items="${ arrCagoNmPath }" varStatus="status">
				<a href="${contextPath }/goods?CAGO_ID=${arrCagoIdPath[status.index] }" class="${ fn:length(arrCagoNmPath) eq status.count ? 'sct_here' : 'sct_bg' } "><font style="font-size:11px;color:#7da41a">${entPath }</font></a>
			</c:forEach>&nbsp;&nbsp;</td></tr>
		</table>
		<!-- /위치타이틀 -->

		<!-- 상품소개 -->
		<table border="0" cellpadding="0" cellspacing="0" background="${contextPath }/resources/images/dtlimg/img_bg.gif">
		<tr>
			<td colspan="3"><img src="${contextPath }/resources/images/dtlimg/img_eg01.gif" border="0"></td></tr>
		<tr>
			<td width="17"></td>
			<td width="332" valign="top">
				<!-- 이미지 -->
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="12"></td></tr>
				<tr>
					<td colspan="3" height="247" valign="top"><img src="${contextPath }/resources/images/dtlimg/img01.gif" border="0"></td></tr>
				<tr>
					<td height="77" valign="top"><a href="#"><img src="${contextPath }/resources/images/dtlimg/img02.gif" border="0"></a></td>
					<td width="114" align="center" valign="top"><a href="#"><img src="${contextPath }/resources/images/dtlimg/img03.gif" border="0"></a></td>
					<td valign="top"><a href="#"><img src="${contextPath }/resources/images/dtlimg/img04.gif" border="0"></a></td></tr>
				<!-- tr>
					<td></td>
					<td align="center" height="31" valign="top"><a href="#"><img src="${contextPath }/resources/images/dtlimg/img_btn.gif" border="0" align="absmiddle"></a> <a href="#"><font style="font-size:11px;color:#9c9c9c"><b>상품확대보기</b></font></a></td>
					<td></td>
				</tr -->
				</table>
				<!-- /이미지 -->
			</td>
			<td width="346" valign="top">
				<!-- 텍스트 -->
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="12"></td></tr>
				<tr>
					<td width="3"></td>
					<td width="5"></td>
					<td colspan="2" height="30" style="font-size:16px;color:#4d4d4d"><b>${result.PD_NAME}</b></td></tr>
				<tr>
					<td></td>
					<td colspan="3" height="2" bgcolor="c0cd9f"></td>
				</tr>
				<c:if test="${ !empty result.PDDC_GUBN and result.PDDC_GUBN ne 'PDDC_GUBN_01' }">
 				<tr>
					<td></td>
					<td></td>
					<td width="12" height="29"><img src="${contextPath }/resources/images/dtlimg/img_dot.gif" border="0"></td>
					<td width="304" style="color:#4e4e4e">정상가 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp;
						<c:if test="${ result.PDDC_GUBN ne 'PDDC_GUBN_01' }">
							<c:set var="nDiscount" value="0" />
							<c:if test="${ result.PDDC_GUBN eq 'PDDC_GUBN_02' }">
								<c:set var="nDiscount" value="${result.PDDC_VAL }" />
							</c:if>
							<c:if test="${ result.PDDC_GUBN eq 'PDDC_GUBN_03' }">
								<c:set var="nDiscount" value="${ result.PD_PRICE* result.PDDC_VAL/100 }" />
							</c:if>
							<s><fmt:formatNumber value="${ result.PD_PRICE + nDiscount}" pattern="#,###"/></s>원
						</c:if>
					</td>
				</tr> 
				</c:if>
				<tr>
					<td></td>
					<td colspan="3" height="1" bgcolor="dee2d7"></td></tr>
				<tr>
					<td></td>
					<td></td>
					<td height="27"><img src="${contextPath }/resources/images/dtlimg/img_dot.gif" border="0"></td>
					<td style="color:#4e4e4e">판매가 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp;<font style="font-size:14px;color:#f33333"><b><fmt:formatNumber value="${ result.PD_PRICE }" pattern="#,###"/>원</b></font></td></tr>
				<tr>
					<td></td>
					<td colspan="3" height="1" bgcolor="dee2d7"></td></tr>
<%-- 				<tr>
					<td></td>
					<td></td>
					<td height="27"><img src="${contextPath }/resources/images/dtlimg/img_dot.gif" border="0"></td>
					<td style="color:#4e4e4e">구매포인트 &nbsp; &nbsp; : &nbsp;내 포인트 확인</td></tr>
				<tr>
					<td></td>
					<td colspan="3" height="1" bgcolor="dee2d7"></td></tr> --%>
<%-- 				<tr>
					<td></td>
					<td></td>
					<td height="27"><img src="${contextPath }/resources/images/dtlimg/img_dot.gif" border="0"></td>
					<td style="color:#4e4e4e">무이자할부 &nbsp; &nbsp; : &nbsp;카드안내</td></tr>
				<tr>
					<td></td>
					<td colspan="3" height="1" bgcolor="dee2d7"></td></tr>
				<tr>
					<td></td>
					<td></td>
					<td height="27"><img src="${contextPath }/resources/images/dtlimg/img_dot.gif" border="0"></td>
					<td style="color:#4e4e4e">판매자정보 &nbsp; &nbsp; : &nbsp;<u>${result.SUPR_NAME }</u></td></tr> --%>
				<tr>
					<td></td>
					<td colspan="3" height="1" bgcolor="dee2d7"></td></tr>
				<tr>
					<td></td>
					<td></td>
					<td height="27"><img src="${contextPath }/resources/images/dtlimg/img_dot.gif" border="0"></td>
					<td style="color:#4e4e4e">제조사 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp;${result.MAKE_COM }</td></tr>
				<tr>
					<td></td>
					<td colspan="3" height="1" bgcolor="dee2d7"></td></tr>
				<tr>
					<td></td>
					<td></td>
					<td height="27"><img src="${contextPath }/resources/images/dtlimg/img_dot.gif" border="0"></td>
					<td style="color:#4e4e4e">배송비 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp;<font style="color:#da7215">무료배송</font>/택배/묶음배송</td></tr>
				<tr>
					<td></td>
					<td colspan="3" height="1" bgcolor="dee2d7"></td></tr>
				<tr>
					<td></td>
					<td></td>
					<td height="27"><img src="${contextPath }/resources/images/dtlimg/img_dot.gif" border="0"></td>
					<td style="color:#4e4e4e">평균배송일 &nbsp; &nbsp; : &nbsp;1.5일/2일이내 배송</td></tr>
				<tr>
					<td></td>
					<td colspan="3" height="1" bgcolor="dee2d7"></td></tr>
				<tr>
					<td></td>
					<td></td>
					<td height="27"><img src="${contextPath }/resources/images/dtlimg/img_dot.gif" border="0"></td>
					<td style="color:#4e4e4e">신청수량 &nbsp; &nbsp; &nbsp; &nbsp;: &nbsp;
					<input id="CT_QTY" style="width:30px;height:15px;border:solid 1px #cecece;font-family:Dotum;font-size:12px;color:#4e4e4e;text-align:right;" value="1" onchange="fn_price_calculate()" /> 개 
					</td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td width="12" height="29"><img src="${contextPath }/resources/images/dtlimg/img_dot.gif" border="0"></td>
					<td width="304" style="color:#4e4e4e">
						<div id="sit_tot_price">총금액 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp;<fmt:formatNumber value="${ result.PD_PRICE }" pattern="#,###"/>원</div>
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="3" height="1" bgcolor="dee2d7"></td></tr>
				</table>
				<!-- /텍스트 -->

				<!-- 공간 -->
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="17"></td></tr>
				</table>
				<!-- /공간 -->

				<!-- 버튼 -->
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><a href="javascript:fn_sit_btn_buy();"><img src="${contextPath }/resources/images/dtlimg/btn01.gif" border="0" alt="구매하기"></a></td>
					<td><a href="javascript:fn_sit_btn_cart();"><img src="${contextPath }/resources/images/dtlimg/btn02.gif" border="0" alt="장바구니담기"></a></td>
					<td><a href="javascript:fn_item_wish(document.fitem, '1442995017');"><img src="${contextPath }/resources/images/dtlimg/btn03.gif" border="0" alt="관심상품등록??"></a></td></tr>
				</table>
				<!-- /버튼 -->
			</td></tr>
		<tr>
			<td colspan="3">
				<img src="${contextPath }/resources/images/dtlimg/img_eg02.gif" border="0">
			</td>
		</tr>
		</table>
		<!-- /상품소개 -->

		<!-- 공간 -->
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="38"></td></tr>
		</table>
		<!-- /공간 -->

		<!-- 탭1 -->
		<table border="0" cellpadding="0" cellspacing="0" id="tabDetail">
		<tr>
			<td rowspan="2"><a href="#tabDetail"><img src="${contextPath }/resources/images/dtlimg/2tab01.gif" border="0" alt="상품상세설명"></a></td>
			<td width="126" align="center"><a href="#tabDlvrefGuide"><img src="${contextPath }/resources/images/dtlimg/tab02.gif" border="0" alt="배송정보"></a></td>
			<td width="323"><a href="#bbsRev"><img src="${contextPath }/resources/images/dtlimg/tab04.gif" border="0" alt="고객상품평"></a></td></tr>
		<tr>
			<td colspan="3" height="2" bgcolor="97ca18"></td></tr>
		</table>
		<!-- /탭1 -->

		<!-- 공간 -->
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="10"></td></tr>
		</table>
		<!-- /공간 -->

		<!-- 상세이미지 -->
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				${ result.PD_DINFO }
			</td>
		</tr>
		</table>
		<!-- /상세이미지 -->

		<!-- 공간 -->
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="20"></td></tr>
		</table>
		<!-- /공간 -->

		<!-- 탭2 -->
		<table border="0" cellpadding="0" cellspacing="0" id="tabDlvrefGuide">
		<tr>
			<td width="124"><a href="#tabDetail"><img src="${contextPath }/resources/images/dtlimg/tab01.gif" border="0" alt="상품상세설명"></a></td>
			<td rowspan="2"><a href="#tabDlvrefGuide"><img src="${contextPath }/resources/images/dtlimg/2tab02.gif" border="0" alt="배송정보"></a></td>
			<td width="323"><a href="#bbsRev"><img src="${contextPath }/resources/images/dtlimg/tab04.gif" border="0" alt="고객상품평"></a></td></tr>
		<tr>
			<td height="2" bgcolor="97ca18"></td>
			<td colspan="2" height="2" bgcolor="97ca18"></td></tr>
		</table>
		<!-- /탭2 -->

		<!-- 공간 -->
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="24"></td></tr>
		</table>
		<!-- /공간 -->

		<!-- 배송정보 -->
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="169" height="161" valign="top"><img src="${contextPath }/resources/images/dtlimg/icon_img01.gif" border="0"></td>
			<td width="526" valign="top">
				<!-- 텍스트 -->
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="27" style="font-size:14px;color:#848483"><b>배송/환불정보</b></td></tr>
				<tr>
					<td height="3"></td></tr>
				<tr>
					<td>${result.DLVREF_GUIDE}</td></tr>
				</table>
				<!-- /텍스트 -->
			</td></tr>
		</table>
		<!-- /배송정보 -->

		<!-- 탭3 -->
		<table border="0" cellpadding="0" cellspacing="0" id="bbsRev">
		<tr>
			<td><a href="#tabDetail"><img src="${contextPath }/resources/images/dtlimg/tab01.gif" border="0" alt="상품상세설명"></a></td>
			<td width="126" align="center"><a href="#tabDlvrefGuide"><img src="${contextPath }/resources/images/dtlimg/tab02.gif" border="0" alt="배송정보"></a></td>
			<td rowspan="2"><a href="#bbsRev"><img src="${contextPath }/resources/images/dtlimg/2tab04.gif" border="0" alt="고객상품평"></a></td>
			<td width="201"></td></tr>
		<tr>
			<td colspan="3" height="2" bgcolor="97ca18"></td>
			<td height="2" bgcolor="97ca18"></td></tr>
		</table>
		<!-- /탭4 -->

		<!-- 공간 -->
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="17"></td></tr>
		</table>
		<!-- /공간 -->

		<!-- 설명텍스트 -->
		<table border="0" cellpadding="0" cellspacing="0">
		<c:if test="${ !empty(resultRev) }">
			<c:forEach var="ent" items="${ resultRev }" varStatus="status">
				<tr>
					<td width="499" height="25" style="color:#ff9759" ><span id="sbjt" val="${ent.BRD_NUM}"><b>&nbsp;${ent.BRD_NUM}. ${ent.BRD_SBJT}</b></span></td>
					<td width="86"><img src="${contextPath }/resources/images/mall/goods/s_star${ent.PD_PTS}.png" alt="별${ent.PD_PTS}개" border="0"></td>
					<td width="110" style="font-size:11px;color:#707070">${ent.WRTR_NM} | ${ent.WRT_DTM}</td>
				</tr>		
				<tr style="display:none;" id="reply_${ent.BRD_NUM}">
					<td colspan="3" height="41" bgcolor="f4f4f4" style="font-size:11px;color:#848483;line-height:14px">&nbsp; ${ent.BRD_CONT}</td>
				</tr>
			</c:forEach>
		</c:if>
	    <c:if test="${ empty(resultRev) }">	
			<tr>
				<td width="595">고객상품평이 없습니다.</td>
			</tr>
	    </c:if>
		<tr>
			<td colspan="3" height="1" bgcolor="ebebeb"></td>
		</tr>
		</table>
		<!-- /설명텍스트 -->
	</td></tr>
</table>
<!-- /메인테이블 -->
		