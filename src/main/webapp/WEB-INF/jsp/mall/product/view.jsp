<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<style>
.goodsImg {
    width: auto; height: auto;
    max-width: 312px;
    max-height: 243px;
}

.goodsImg-sm {
    width: auto; height: auto;
    max-width: 99px;
    max-height: 66px;
}
.form-control.select{
	padding:1px;
}
</style>

<script>
$(function() {
	$('.goodsImg').load(function(){
		/* 
		var maxWidth = 450; 						// Max width for the image
	    var maxHeight = 400;    					// Max height for the image
	    
	    var width = $(this).width();    // Current image width
	    var height = $(this).height();  // Current image height
	    
	    var top = 0;
	    if(height < maxHeight){
	    	top = (maxHeight - height)/2; 		// get ratio for scaling image
	        $(this).css("margin-top", top);   	// Set top
	    }
	 	*/		
	});
	
	$('.goodsImg').each(function() {
		$(this).error(function(){
			$(this).attr('src', 'https://www.cjfls.co.kr/resources/images/mall/goods/noimage.png');
		});
	 });
	
    $(document).on("change", "#CT_QTY", function() {
    	price_calculate();
    });
	    
	$('#btnCart').click(function(){

       	<c:if test="${empty USER.MEMB_ID}">
			alert("로그인이 필요합니다.");
			location.href = "${contextPath}/user/loginForm";
			return false;
		</c:if>
		
		<c:if test="${result.SALE_CON eq 'SALE_CON_02' }">
			alert("품절된 상품은 장바구니에 담을 수 없습니다.");
			return false;
		</c:if>
		
		if($('#PD_CUT_SEL').val()=='nothing'){
			alert("세절방식을 선택해 주세요.");
			return false;
		}
		
		if($('.PD_OPTION_SEL').val()=='nothing'){
			alert("옵션을 선택해 주세요.");
			return false;
		}
		
    	$('#PD_QTY').val($('#CT_QTY').val());
    	
    	<c:if test='${pdcut_cnt >0 }'>
		 	$('#PD_CUT_SEQ').val($('#PD_CUT_SEL').val());
		</c:if>
		
		<c:if test='${option_cnt >0 }'>
	 		$('#OPTION_CODE').val($('.PD_OPTION_SEL').val());
		</c:if>

        <c:if test="${!empty USER.MEMB_ID}">
      		//회원
	    	$.ajax({
	    		type: "POST",
	    		url: '${contextPath}/goods/basketInst',
	    		data: $("#bkInstFrm").serialize(),
	    		success: function (data) {

	    			// 장바구니 등록 여부
	    			if (data == '0') {
	    				alert("장바구니에 등록되었습니다.");
	    			}else{
	    				alert("장바구니에 이미 등록된 상품 입니다.");
	    			}
	    		}, error: function (jqXHR, textStatus, errorThrown) {
	    			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
	    		}
	    	});
        </c:if>    	
	});
		
	$('#btnBuy').click(function(){
       	<c:if test="${empty USER.MEMB_ID}">
			alert("로그인이 필요합니다.");
			location.href = "${contextPath}/user/loginForm";
			return false;
		</c:if>

		<c:if test="${result.SALE_CON eq 'SALE_CON_02' }">
			alert("품절된 상품은 구매 할 수 없습니다.");
			return false;
		</c:if>
		
		if($('#PD_CUT_SEL').val()=='nothing'){
			alert("세절방식을 선택해 주세요.");
			return false;
		}
		
		if($('.PD_OPTION_SEL').val()=='nothing'){
			alert("옵션을 선택해 주세요.");
			return false;
		}
		
		<c:if test='${result.QNT_LIMT_USE=="Y"}'>
			var pd_qty_val = $("#CT_QTY  option:selected").text();
			$('#PD_QTY').val(pd_qty_val);    //CT_QTY : 신청수량
			$('#ORDER_QTY').val(pd_qty_val);
		</c:if>
		
		<c:if test='${result.QNT_LIMT_USE!="Y"}'>
			$('#PD_QTY').val($('#CT_QTY').val());    //CT_QTY : 신청수량
			$('#ORDER_QTY').val($('#CT_QTY').val());
		</c:if>

		<c:if test='${pdcut_cnt >0 }'>
		 	$('#PD_CUT_SEQ').val($('#PD_CUT_SEL').val());
		 	$('#PD_CUT_SEQ_UNIT').val($('#PD_CUT_SEL option:selected').text());
		</c:if>
		
		/* 여기 */
		<c:if test='${option_cnt >0 }'>
		 	$('#OPTION_CODE').val($('.PD_OPTION_SEL').val());
		 	$('#OPTION_NAME').val($('.PD_OPTION_SEL option:selected').text());
		</c:if>		
		
		$('#bkInstFrm').attr('action', '${contextPath}/order/buy').submit();
	});
 
	$('#btnWish').click(function(){
		<c:if test="${empty USER.MEMB_ID}">
			alert("로그인이 필요합니다.");
			location.href = "${contextPath}/user/loginForm";
			return false;
		</c:if>

		<c:if test="${result.SALE_CON eq 'SALE_CON_02' }">
			alert("품절된 상품은 관심상품에 등록 할 수 없습니다.");
			return false;
		</c:if>
		
		if($('#PD_CUT_SEL').val()=='nothing'){
			alert("세절방식을 선택해 주세요.");
			return false;
		}
		
		if($('.PD_OPTION_SEL').val()=='nothing'){
			alert("옵션을 선택해 주세요.");
			return false;
		}
		
    	$('#PD_QTY').val($('#CT_QTY').val());
    	
    	<c:if test='${pdcut_cnt >0 }'>
		 	$('#PD_CUT_SEQ').val($('#PD_CUT_SEL').val());
		</c:if>
		
		<c:if test='${option_cnt >0 }'>
		 	$('#OPTION_CODE').val($('.PD_OPTION_SEL').val());
		</c:if>
    	
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
	});
    	
		
    // 수량변경 및 삭제
	$('.btnQty').click(function(){
        var mode = $(this).text();
        var this_qty, max_qty = 9999, min_qty = 1;
        var $el_qty = $(this).closest("dd").find("input[name^=CT_QTY]");
        var stock = 100;

        switch(mode) {
            case "+":
                this_qty = parseInt($el_qty.val().replace(/[^0-9]/, "")) + 1;
                
                /*
                if(this_qty > stock) {
                    alert("재고수량 보다 많은 수량을 구매할 수 없습니다.");
                    this_qty = stock;
                }
                */

                if(this_qty > max_qty) {
                    this_qty = max_qty;
                    alert("최대 구매수량은 "+number_format(String(max_qty))+" 입니다.");
                }

                $el_qty.val(this_qty);
                price_calculate();
                break;

            case "-":
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

	// 상품평등록
	$('#reviewSave').click(function(){
		window.open("${contextPath }/board/review/popup?PD_CODE=${result.PD_CODE}", "_blank", "width=730, height=450");  
	});		
		
	// 상품문의
	$('#qnaSave').click(function(){
		window.open("${contextPath }/board/ask/popup?PD_CODE=${result.PD_CODE}", "_blank", "width=730, height=450");  
	});	
		
	//이미지 클릭
	$('.popup_item_image').click(function(){
		$('.product-pic').children('.goodsImg').attr('src',$(this).children('.goodsImg-sm').attr('src'));
		//$('.product-pic').children().first('img').attr('src',$(this).children().first('img').attr('src'));
		
	});	
});

// 가격계산
function price_calculate()
{
    var PD_PRICE = parseInt($("input#REAL_PRICE").val());
    if(isNaN(PD_PRICE))
        return;

    if(parseInt($('#CT_QTY').val())<1||$('#CT_QTY').val()==''){
    	alert("최소 구매수량은 1 입니다.");
    	$('#CT_QTY').val(1);    	
    }
    
    if(parseInt($('#CT_QTY').val())>parseInt($('#LIMIT_QTY').val())){
    	alert("한정 구매수량은 "+ $('#LIMIT_QTY').val() +" 입니다.");
    	$('#CT_QTY').val($('#LIMIT_QTY').val());    	
    }

  //var final_qty = 0;
	var final_total = 0;
    <c:if test='${result.QNT_LIMT_USE=="Y"}'>
	    var ct_qty = $("#CT_QTY  option:selected").text()
	    var total = PD_PRICE*ct_qty;
		final_total = total;	    
    	//$("#sit_tot_price").html("<span>총 금액</span> "+number_format(String(total))+"원");
    </c:if>
    
    <c:if test='${result.QNT_LIMT_USE==null||result.QNT_LIMT_USE==""||result.QNT_LIMT_USE=="N"}'>
	    var qty = parseInt($("#CT_QTY").val());			//신청수량
	    var total = parseInt(PD_PRICE * qty);
    	//$("#sit_tot_price").html("<span>총 금액</span> "+number_format(String(total))+"원");
		final_total = total;
    </c:if>
    
    //박스입수량
    var inputcnt = parseInt('${result.INPUT_CNT}');			//입수량
    var boxpddcval = parseInt('${result.BOX_PDDC_VAL}');	//박스할인값
    var boxsalequt = parseInt(qty/inputcnt);				//몫
    var boxsaleval = parseInt(boxsalequt*boxpddcval);
    var realtotal = 0;
    
    if('${result.BOX_PDDC_GUBN}'=='PDDC_GUBN_02'){
    	realtotal = total-boxsaleval;    	
    }else if('${result.BOX_PDDC_GUBN}'=='PDDC_GUBN_03'){    	
    	boxpddcval = PD_PRICE* boxpddcval/100;	//할인율
    	boxsaleval = parseInt(boxsalequt*boxpddcval*inputcnt);    	
    	realtotal = total-boxsaleval;
    }else{
    	realtotal = final_total;
    }
    
    $("#sit_tot_price").html("<span>총 금액</span> "+number_format(String(realtotal))+"원");    
    $('#ORDER_AMT').val(realtotal);
}	
</script>

<c:set var="arrCagoIdPath" value="${fn:split(rtnCagoInfo.CAGO_ID_PATH, '>') }" />
<c:set var="arrCagoNmPath" value="${fn:split(rtnCagoInfo.CAGO_NM_PATH, '>') }" />
	
<div class="submenu-box">
	<div class="panel panel-submenu">
		<div class="panel-heading">
			<p>
				<a href="${contextPath }/product?CAGO_ID=${arrCagoIdPath[0] }">${arrCagoNmPath[0] }</a>
			</p>
		</div>
		<div class="panel-body">
			<ul class="submenu-list">
				<c:forEach var="ent" items="${ rtnCagoList }" varStatus="status">
					<li><a href="${contextPath }/product?CAGO_ID=${ ent.CAGO_ID }"><c:out value="${ ent.CAGO_NAME }" escapeXml="true" /> (${ ent.PRD_CNT })</a></li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>

<div class="sub-title sub-title-underline">
	<h2>
		상품상세 <small class="ml_5">| 엄선된 상품만을 제공합니다.</small>
	</h2>
	<ul>
		<li><a href='${contextPath }/' class="sct_bg">Home</a></li>
		<c:forEach var="entPath" items="${ arrCagoNmPath }" varStatus="status">
			<li><a href="${contextPath }/product?CAGO_ID=${arrCagoIdPath[status.index] }" class=" ">${entPath }</a></li>
		</c:forEach>
	</ul>
	<div class="clearfix"></div>
</div>

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
	<input type="hidden" id="PD_CUT_SEQ" name="PD_CUT_SEQ" value="" />
	<input type="hidden" id="PD_CUT_SEQ_UNIT" name="PD_CUT_SEQ_UNIT" value="" />
	
	<input type="hidden" id="OPTION_CODE" name="OPTION_CODE" value="" />
	<input type="hidden" id="OPTION_NAME" name="OPTION_NAME" value="" />		
	<%-- <c:if test='${pdcut_cnt >0 }'>
		<input type="hidden" id="PD_CUT_SEQ" name="PD_CUT_SEQ" value="" />
	</c:if> --%>
</form>


<!--상품정보-->
<div class="panel panel-default">
	<div class="panel-body row">
		<div class="product-pic" style="text-align: center;">
			<c:if test='${result.PDDC_GUBN!="PDDC_GUBN_01"&& result.PDDC_GUBN!="PDDC_GUBN_05"}'>
				<div style="position: absolute;font-size:25px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;">
					전단행사상품<br>				
				</div>
			</c:if>

			<c:if test="${ !empty(result.ATFL_ID ) }">
				<c:if test="${result.FILEPATH_FLAG eq mainKey }">
					<img src="${contextPath }/upload/${result.STFL_PATH }/${result.STFL_NAME }" alt="" class="goodsImg" style="position: relative;"/>
				</c:if>
				<c:if test="${!empty(result.FILEPATH_FLAG) && result.FILEPATH_FLAG ne mainKey }">
					<img src="${result.STFL_PATH }" class="goodsImg" alt="" style="position: relative;"/>
				</c:if>
				<c:if test="${ empty(result.FILEPATH_FLAG ) }">
					<img src="http://www.cjfls.co.kr/upload/${result.STFL_PATH }/${result.STFL_NAME }" alt="" class="goodsImg" style="position: relative;" />
				</c:if>					
			</c:if>
			
			<ul class="pic-list">
				<c:if test="${ !empty(fileList) }">
					<c:forEach var="var" items="${ fileList }" varStatus="status">
						<c:if test="${var.FILEPATH_FLAG eq mainKey }">
							<li><a class="popup_item_image"><img src="${contextPath }/upload/${var.STFL_PATH }/${var.STFL_NAME }" width="99" height="66" class="goodsImg goodsImg-sm" alt="이미지 오류"></a></li>
						</c:if>
						<c:if test="${!empty(var.FILEPATH_FLAG) && var.FILEPATH_FLAG ne mainKey }">
							<li><a class="popup_item_image"><img src="${var.STFL_PATH }" width="99" height="66" class="goodsImg goodsImg-sm" alt="이미지 오류"></a></li>
						</c:if>
						<c:if test="${ empty(var.FILEPATH_FLAG ) }">
							<li><a class="popup_item_image"><img src="http://www.cjfls.co.kr/upload/${var.STFL_PATH }/${var.STFL_NAME }" width="99" height="66" class="goodsImg goodsImg-sm" alt="이미지 오류"></a></li>
						</c:if>
					</c:forEach>
				</c:if>
				<c:if test="${ empty(fileList) }">
					<li><a class="popup_item_image"><img src="https://www.cjfls.co.kr/resources/images/mall/goods/noimage.png" width="99" height="66" class="goodsImg goodsImg-sm" alt="이미지없음"></a></li>
				</c:if>
			</ul>			
		</div>
		
		<div class="product_info col-sm-6">
			<dl>
				<dt>
					<c:if test="${result.SALE_CON eq 'SALE_CON_02' }">
						<span style="color:red">[품절]</span>
					</c:if>
					<c:out value="${ result.PD_NAME }" escapeXml="true" />
				</dt>
				<c:if test="${ result.REAL_PRICE ne result.PD_PRICE }">
					<dd>
						<span>회원가</span> <b class="ex_price"><fmt:formatNumber value="${ result.PD_PRICE }" pattern="#,###" />원</b>
					</dd>
				</c:if>
				<dd>
					<span>행사가</span> <b class="red md_ft"><fmt:formatNumber value="${ result.REAL_PRICE }" pattern="#,###" />원</b> 
					<input type="hidden" id="REAL_PRICE" value="${ result.REAL_PRICE }">
				</dd>
				<dd>
					<span>제조사</span>
					<c:out value="${ result.MAKE_COM eq '' ? '상세설명참조 ' : result.MAKE_COM}" escapeXml="true" />
				</dd>
				<dd>
					<span>원산지</span>
					<c:out value="${ result.ORG_CT eq '' ? '상세설명참조 ' : result.ORG_CT}" escapeXml="true" />
				</dd>
				<dd>
					<span>신청수량</span> 
					<c:if test='${result.QNT_LIMT_USE eq "Y" }'>
					<span style="width: 80px;height: 100%;">
						<jsp:include page="/common/comCodForm">
							<jsp:param name="COMM_CODE" value="QNT_LIMT" />
							<jsp:param name="name" value="CT_QTY" />
							<jsp:param name="value" value="QNT_LIMT_01" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="" />
						</jsp:include>
					</span>
					</c:if>
					<c:if test = '${result.QNT_LIMT_USE eq null or result.QNT_LIMT_USE eq "" or result.QNT_LIMT_USE eq "N" }'>
						<button type="button" class="btn btn-primary btn-xs btnQty">-</button>
						<input type="text" class="input-sm number" name="CT_QTY" value="1" id="CT_QTY" style="width:60px;text-align:center;" maxlength="4">
						<input type="hidden" id="LIMIT_QTY" name="LIMIT_QTY" value="${ result.LIMIT_QTY }"/>
						<button type="button" class="btn btn-primary btn-xs btnQty">+</button>
					</c:if>
				</dd>
				<dd id="sit_tot_price">
					<c:if test='${result.QNT_LIMT_USE eq "Y" }'>
						<span>총 금액</span> <fmt:formatNumber value="${ result.REAL_PRICE*3 }" pattern="#,###" />원
					</c:if>
					<c:if test='${result.QNT_LIMT_USE ne "Y" }'>
						<span>총 금액</span> <fmt:formatNumber value="${ result.REAL_PRICE }" pattern="#,###" />원
					</c:if>
				</dd>				
				<dd>
					<span>박스입수량</span> <c:if test='${result.INPUT_CNT ne null and result.INPUT_CNT > 0 }'>한 박스에 ${result.INPUT_CNT}개 입수량 입니다.</c:if>					
				</dd>
				<c:if test="${result.BOX_PDDC_GUBN ne 'PDDC_GUBN_01' }">
				<dd>
					<p style="font-size:12px;margin:3px">박스로 구매시 ( ${result.BOX_PDDC_VAL} )${ result.BOX_PDDC_GUBN eq 'PDDC_GUBN_02'? '원':'%'} 할인되는 상품입니다.</p>
				</dd>
				</c:if>
				
				<%-- <c:if test='${pdcut_cnt >0 }'>
					<dd>
						<span>세절방식</span>
						<span style="width: 150px;height: 100%">
							<select class="form-control select"  id="PD_CUT_SEL">
								<option value='nothing'>선택</option>
								<c:forEach var="pdcut" items="${pdcutList }" varStatus="sta">
									<option value='${pdcut.SEQ }'>${pdcut.CUT_UNIT }</option>
								</c:forEach>
							</select>
						</span>
						<br/>
					</dd>	
					<p style="font-size:12px;margin:3px">*축산물은 세절작업을 진행한 후에는 <b style="color:red">반품 빛 교환이 되지않습니다.</b> 이점을 반드시 유의하시어 주문부탁드립니다.</p>			
				</c:if> --%>
				
				<!-- 상품 세절방식 출력 -->				
				<c:if test='${pdcut_cnt >0 }'>
					<dd>
						<span>세절방식</span>
						<span style="width: 150px;height: 100%">
							<select class="form-control select"  id="PD_CUT_SEL">
								<option value='nothing'>선택</option>
								<c:forEach var="pdcut" items="${pdcutList }" varStatus="sta">
									<option value='${pdcut.SEQ }'>${pdcut.CUT_UNIT }</option>
								</c:forEach>
							</select>
						</span>
						<br/>
					</dd>	
					<p style="font-size:12px;margin:3px">*축산물은 세절작업을 진행한 후에는 <b style="color:red">반품 빛 교환이 되지않습니다.</b> 이점을 반드시 유의하시어 주문부탁드립니다.</p>			
				</c:if>
								
				<!-- 옵션 선택 -->
				<c:if test='${ result.OPTION_GUBN eq "OPTION_GUBN_02" }'>
					<dd>
						<span>색상</span>
						
						<span style="width: 150px;height: 100%">
							<select class="form-control select PD_OPTION_SEL"  id="PD_OPTION_SEL">
								<option value='nothing'>선택</option>
								<c:forEach var="pdoption" items="${optionList }" varStatus="sta">
									<option value='${pdoption.COMD_CODE }'>${pdoption.COMDCD_NAME }</option>
								</c:forEach>
							</select>
						</span><br/>
					</dd>
				</c:if> 
				
				<!-- 옵션 선택 -->
				<c:if test='${ result.OPTION_GUBN eq "PLSBAG_GUBN" }'>
					<dd>
						<span>색상</span>
						<span style="width: 80px;height: 100%;">
							<jsp:include page="/common/optCodForm">
								<jsp:param name="OPTM_CODE" value="PLSBAG_GUBN" />
								<jsp:param name="name" value="PLSBAG_GUBN" />
								<jsp:param name="value" value="" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="" />
								<jsp:param name="test" value="PD_OPTION_SEL" />
							</jsp:include>
						</span>
					</dd>
				</c:if>				
				<c:if test='${ result.OPTION_GUBN eq "PLSBAG_GUBN_2" }'>
					<dd>
						<span>색상</span>
						<span style="width: 80px;height: 100%;">
							<jsp:include page="/common/optCodForm">
								<jsp:param name="OPTM_CODE" value="PLSBAG_GUBN_2" />
								<jsp:param name="name" value="PLSBAG_GUBN_2" />
								<jsp:param name="value" value="" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="" />
								<jsp:param name="test" value="PD_OPTION_SEL" />
							</jsp:include>
						</span>
					</dd>
				</c:if>
				<c:if test='${ result.OPTION_GUBN eq "PLSBAG_GUBN_3" }'>
					<dd>
						<span>색상</span>
						<span style="width: 80px;height: 100%;">
							<jsp:include page="/common/optCodForm">
								<jsp:param name="OPTM_CODE" value="PLSBAG_GUBN_3" />
								<jsp:param name="name" value="PLSBAG_GUBN_3" />
								<jsp:param name="value" value="" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="" />
								<jsp:param name="test" value="PD_OPTION_SEL" />
							</jsp:include>
						</span>
					</dd>
				</c:if>
				<c:if test='${ result.OPTION_GUBN eq "PLSBAG_GUBN_4" }'>
					<dd>
						<span>색상</span>
						<span style="width: 80px;height: 100%;">
							<jsp:include page="/common/optCodForm">
								<jsp:param name="OPTM_CODE" value="PLSBAG_GUBN_4" />
								<jsp:param name="name" value="PLSBAG_GUBN_4" />
								<jsp:param name="value" value="" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="" />
								<jsp:param name="test" value="PD_OPTION_SEL" />
							</jsp:include>
						</span>
					</dd>
				</c:if>
			</dl>
			<div>
				<a class="btn btn-success" href="#" role="button" id="btnBuy">구매하기</a>
				<a class="btn btn-success" href="#" role="button" id="btnCart">장바구니담기</a>
				<a class="btn btn-default" id="btnWish" href="#" role="button">관심상품등록</a>
			</div>
		</div>
	</div>
</div>
<!--상세정보-->
<div>

	<!-- Nav tabs -->
	<ul class="nav nav-tabs" role="tablist">
		<li role="presentation" class="active"><a href="#productInfo" aria-controls="productInfo" role="tab" data-toggle="tab">상품상세설명</a></li>
		<li role="presentation"><a href="#deliveryInfo" aria-controls="deliveryInfo" role="tab" data-toggle="tab">배송/환불 안내</a></li>
		<!-- 
		<li role="presentation"><a href="#reviewBoard" aria-controls="reviewBoard" role="tab" data-toggle="tab">반품요청</a></li>구매후기</a></li>
		<li role="presentation"><a href="#qnaBoard" aria-controls="qnaBoard" role="tab" data-toggle="tab">상품문의</a></li>
		 -->
	</ul>

	<!-- Tab panes -->
	<div class="tab-content">
		<div role="tabpanel" class="tab-pane active" id="productInfo">
			<div class="tbl_pdt_detail tbl_wrap">
				${ result.PD_DINFO }
				<c:if test="${ !empty(fileDtlList) && result.DTL_USE_YN eq 'Y' }">
					<br>
					<p>상품 상세정보</p>
					<table>
						<tbody>
							<c:forEach var="var" items="${ fileDtlList }" varStatus="status">
								<c:if test="${var.FILEPATH_FLAG eq mainKey  }">													
									<c:set var="imgDtlPath" value="${contextPath }/upload/${var.STFL_PATH }/${var.STFL_NAME }" />
								</c:if>
								<c:if test="${!empty(var.FILEPATH_FLAG) && var.FILEPATH_FLAG ne mainKey  }">
									<c:set var="imgDtlPath" value="${var.STFL_PATH }" />
								</c:if>
								<c:if test="${ empty(var.FILEPATH_FLAG) }">
									<c:set var="imgDtlPath" value="https://www.cjfls.co.kr/upload/${var.STFL_PATH }/${var.STFL_NAME }" />
								</c:if>
								<tr>
									<td><img src="${imgDtlPath }" />&nbsp;</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
			</div>
		</div>

		<div role="tabpanel" class="tab-pane" id="deliveryInfo">
			${ result.DLVREF_GUIDE }
			<c:if test="${ empty result.DLVREF_GUIDE }">
				<p class="sit_empty">배송/환불 안내 정보가 없습니다.</p>
			</c:if>
		</div>
	</div>

</div>
