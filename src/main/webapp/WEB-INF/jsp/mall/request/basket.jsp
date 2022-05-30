<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<script>
	$(function() {
		$('.goodsImg').each(function(n){
				$(this).error(function(){
					$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
				});
			 });
	});
</script>


<c:set var="strActionUrl" value="${contextPath }/wishList" />
<c:set var="strMethod" value="post" />

<div id="wrapper_title">장바구니</div>
<div id="sct_location">
	<a href='${contextPath }/goods' class="sct_bg">Home</a>
	<a href="${contextPath }/request" class="sct_here">장바구니 조회</a>
</div>

<!-- div class="mbskin">
    <p>주문 안내<br/>절차, 배송 등 안내...</p>
</div -->


<!-- 글자크기 조정 display:none 되어 있음 시작 { -->
<div id="sod_bsk">
	<form name="frmBasket" id="frmBasket" method="post" action="${contextPath }/request/basketNew">
		<div class="tbl_head01 tbl_wrap">

			<table>
				<thead>
					<tr>
						<th scope="col">상품명</th>
						<th scope="col">수량</th>
						<th scope="col">판매가</th>
						<th scope="col">상품구매금액</th>
						<th scope="col">삭제</th>
					</tr>
				</thead>
				<tbody id="tbodyProduct" >
					<c:set var="tot_amt" value="0" />
					<c:if test="${!empty obj.list }">
						<c:forEach items="${obj.list }" var="list" varStatus="loop">
							<c:set var="realPrice" value="${ list.PD_PRICE }" />
							<c:if test="${ list.PDDC_GUBN ne 'PDDC_GUBN_01' }">
								<c:set var="nDiscount" value="0" />
								<c:if test="${ list.PDDC_GUBN eq 'PDDC_GUBN_02' }">
									<c:set var="nDiscount" value="${list.PDDC_VAL }" />
								</c:if>
								<c:if test="${ list.PDDC_GUBN eq 'PDDC_GUBN_03' }">
									<c:set var="nDiscount" value="${ list.PD_PRICE* list.PDDC_VAL/100 }" />
								</c:if>
								<c:set var="realPrice" value="${ list.PD_PRICE - nDiscount }" />
							</c:if>
							<tr>
								<td class="sod_img">
									<input type="hidden" id="PD_CODES" name="PD_CODES" value="${list.PD_CODE }">
									<input type="hidden" id="PD_NAMES" name="PD_NAMES" value="${list.PD_NAME}" />
									<input type="hidden" id="PD_PRICES" name="PD_PRICES" value="${list.PD_PRICE}" />
									<input type="hidden" id="PDDC_GUBNS" name="PDDC_GUBNS" value="${list.PDDC_GUBN}" />
									<input type="hidden" id="PDDC_VALS" name="PDDC_VALS" value="${list.PDDC_VAL}" />
									<input type="hidden" id="realPrice" name="PDDC_VALS" value="${realPrice}" />
									
									<!-- input type="hidden" id="DLVY_NAMES" name="DLVY_NAMES" value="" / -->
									<b>${list.PD_NAME }</b>
								</td>
								<td class="td_num">
									<input type="text" id="ORDER_QTYS" name="ORDER_QTYS" required maxlength="4" class="frm_input number inpOrderQty" style="text-align:right;" price="${realPrice }" value="${list.ORDER_QTY}" size="2" />
								</td>
								<td class="td_numbig">
									<c:if test="${ realPrice ne list.PD_PRICE }">
										<strike><fmt:formatNumber value="${ list.PD_PRICE }" pattern="#,###"/>원</strike><br>
									</c:if>
									<fmt:formatNumber value="${ realPrice }" pattern="#,###"/>원
								</td>
								<td class="td_num">
									<div id="divOrderAmt" class="divOrderAmt"><fmt:formatNumber value="${list.ORDER_QTY * realPrice }" /></div>
									<input type="hidden" id="ORDER_AMTS" name="ORDER_AMTS" value="${list.ORDER_QTY * realPrice }" />
								</td>
								<td class="grid_1">
									<button type="button" class="btn btn-sm btn-danger btnDelRow" PD_CODE="${list.PD_CODE }">삭제</button>	
								</td>
							</tr>
							<c:set var="tot_amt" value="${tot_amt + (list.ORDER_QTY * realPrice) }" />
						</c:forEach>
						<tr>
							<td class="td_num" colspan="5">
								<div id="divTotOrderAmt">총 선택 상품 구매액 <fmt:formatNumber value="${tot_amt }" />원</div>
							</td>
						</tr>
					</c:if>

					<c:if test="${ empty obj.list }">
						<tr>
							<td colspan="5">등록된 장바구니가 없습니다. 없습니다.</td>
						</tr>
					</c:if>
					<input type="hidden" id="ORDER_AMT" name="ORDER_AMT" value="${tot_amt}"/>
				</tbody>
			</table>

		</div>

	</form>

    
	<div class="text-center">
		<button type="button" class="btn btn-sm btn-default" id="btnPre">이전</button>
		<button type="button" class="btn btn-sm btn-default" id="btnList">계속소핑하기</button>
		<button type="button" class="btn btn-sm btn-success" id="btnOrder">주문하기</button>
	</div>
</div>



<script type="text/javascript">
	$(function() {
	    $(document).on("blur", ".inpOrderQty", function() {
	    	var nIndex = $(this).index(".inpOrderQty");			//현제 인덱스 
	
	    	var nQty = $(this).val();
	    	var nPrice = $(this).attr("price");
	    	
	    	var nOrderAmt = parseInt(nPrice) * parseInt(nQty);
	    	$(".divOrderAmt").eq(nIndex).text(number_format(String(nOrderAmt)));
	    	$("input[name='ORDER_AMTS']").eq(nIndex).val(nOrderAmt);
	    	
	    	fnTotalAmt();
	    });
	    
	    $(document).on('click', '.btnDelRow', function() {
	    	
	    	var strPdCode = $(this).attr("PD_CODE");

    		var clickedRow = $(this).parent().parent();
    		clickedRow.remove();

			//쿠키 조정
       		var strCookieBasket = $.cookie('guestBasket');			// 제품코드1#수량1$제품코드2#수량2$제품코드3#수량3$
       		var strNewBasket = "";
       		$.cookie.raw = true;
       		
			//alert(strCookieBasket);
       	    if(strCookieBasket != undefined) {
           		var arrCookieBasket = strCookieBasket.split('$');
           		var bChk = false;
           		$.each(arrCookieBasket, function(key, line) {
           		    var data = line.split('#');
           		    
           		    if(data[0] != strPdCode){
           		    	if(strNewBasket != ""){
           		    		strNewBasket += "$";
           		    	}
           		    	strNewBasket += data[0] + "#" +  data[1];
           		    }
           		});
           		$.cookie('guestBasket',strNewBasket,{
                    expires : 1
                   ,path : "/"
		        });
		   		
				alert("장바구니에서 삭제 했습니다.");
				fnCalculationAmt();
       	    }

	    });


		$('#btnOrder').click(function(){

			var nChkCnt = $("input[name='PD_CODES']").length;
			
			if (nChkCnt == 0){
				alert("주문하실 상품을 장바구니에 담으세요.");
				return false;
			}

			$("#frmBasket").submit();
		});

	    // 이전
	    $("#btnPre").click(function() {
	    	history.go(-1);
	    });
		
	    // 계속소핑하기
	    $("#btnList").click(function() {
	    	location.href = "${contextPath}/goods"; 
	    });
	    
	    //장바구니에서 수량 넣기
		<c:forEach items="${basketList }" var="list" varStatus="loop">
			var nIndex = $("input[name='PD_CODES']:input[value='${list.PD_CODE}']").index("input[name='PD_CODES']");
			$("input[name='ORDER_QTYS']").eq(nIndex).val('${list.ORDER_QTY}');
		</c:forEach>
		
		fnCalculationAmt();

	});
	
	//수량*단가 계산
	function fnCalculationAmt(){
		$("input[name='ORDER_QTYS']").each(function() {
	    	var nIndex = $(this).index(".inpOrderQty");			//현제 인덱스 
	    	
	    	var nQty = $(this).val();
	    	var nPrice = $(this).attr("price");
	    	
	    	var nOrderAmt = parseInt(nPrice) * parseInt(nQty);
	    	$(".divOrderAmt").eq(nIndex).text(number_format(String(nOrderAmt)));
	    	$("input[name='ORDER_AMTS']").eq(nIndex).val(nOrderAmt);
	    				
		});

    	fnTotalAmt();
	}
	
	function fnTotalAmt(){

		var nTotOrderAmt = 0;


		$("input[name='ORDER_AMTS']").each(function() {
			nTotOrderAmt += parseInt($(this).val());
			
		});
		
		$('#divTotOrderAmt').text("총 선택 상품 구매액 "+number_format(String(nTotOrderAmt))+"원");
		$('#ORDER_AMT').val(nTotOrderAmt);
		
	}
</script>