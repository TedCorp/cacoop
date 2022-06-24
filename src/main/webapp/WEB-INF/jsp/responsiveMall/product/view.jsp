<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>
<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp"%>
<!-- ▲ Key -->
<c:set var="arrCagoIdPath" 	value="${fn:split(rtnCagoInfo.CAGO_ID_PATH, '>') }" />
<c:set var="arrCagoNmPath"	value="${fn:split(rtnCagoInfo.CAGO_NM_PATH, '>') }" />
<script>
	$(function() {	
		// 상품 옵션설정		
		$('.product-image-zoom').each(function(n){		
			$(this).error(function(){
				$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
				$(this).attr('style', 'width:100%;');
			});
		});
		$('.thumb-slider-img').each(function(n){
			$(this).error(function(){
				$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
				$(this).attr('style', 'width:100%;');
			});
		 });
		$('.goodsImg').each(function() {
			$(this).error(function(){
				$(this).attr('src', 'https://www.cjfls.co.kr/resources/images/mall/goods/noimage.png');
				$(this).attr('style', 'width:100%;');
			});
		 });
	    $(document).on("change", "#CT_QTY", function() {
	    	price_calculate();
	    });
	    function optin_calculate(a){
	    	var opPrice = $(a).parent().parent().parent().children('.right').children('input').val();
	    	if(opPrice != '' && opPrice != null){
		       	opPrice = parseInt(opPrice.replace(',','').replace('원',''));
		        $(a).parent().parent().parent().children('.right').children().text(opPrice*parseInt($el_qty.val())+'원')
	    	}
	    }	    	    
	    
	    
	    $(document).on("input", ".optionQty", function(){
	        var this_qty, max_qty = 9999, min_qty = 1;
	        var $el_qty = $(this);
	        var stock = 100;
	        
	        if($el_qty == '' || $el_qty == null){
	        	alert('입력없음')
	        	$el_qty.val("0")
	        }
	        
	        
	    	if(this_qty > max_qty) {
                this_qty = max_qty;
                alert("최대 구매수량은 "+number_format(String(max_qty))+" 입니다.");
            }
            
            // 옵션 가격 계산 minu
            var opPrice = $(this).parent().parent().parent().children('.right').children('input').val();
            if(opPrice != '' && opPrice != null){
    	       	opPrice = parseInt(opPrice.replace(',','').replace('원',''));
    	         $(this).parent().parent().parent().children('.right').children().text((opPrice*parseInt($el_qty.val())).toLocaleString()+'원')
            }
	        calcTotalPrice();
	    });
	    
	    
	    // 수량변경 및 삭제 o
	     $(document).on("click", ".btnQty", function() {
	        var mode = $(this).text();
	        var this_qty, max_qty = 9999, min_qty = 1;
	        var $el_qty = $(this).parent().children('input');
	        var stock = 100;

	        switch(mode) {
	            case "+":
	                this_qty = parseInt($el_qty.val().replace(/[^0-9]/, "")) + 1;

	                if(this_qty > max_qty) {
	                    this_qty = max_qty;
	                    alert("최대 구매수량은 "+number_format(String(max_qty))+" 입니다.");
	                }
	                $el_qty.val(this_qty);
	                // 옵션 가격 계산 minu
	                var opPrice = $(this).parent().parent().parent().children('.right').children('input').val();
	                if(opPrice != '' && opPrice != null){
		    	       	opPrice = parseInt(opPrice.replace(',','').replace('원',''));
		    	         $(this).parent().parent().parent().children('.right').children().text((opPrice*parseInt($el_qty.val())).toLocaleString()+'원')
	             		console.log($(this).parent().parent().parent().children('.right').children().text((opPrice*parseInt($el_qty.val())).toLocaleString()+'원'));
	                }
	    	        calcTotalPrice();
	                break;
	            case "-":
	                this_qty = parseInt($el_qty.val().replace(/[^0-9]/, "")) - 1;
	                if(this_qty < min_qty) {
	                    this_qty = min_qty;
	                    alert("최소 구매수량은 "+number_format(String(min_qty))+" 입니다.");
	                }
	                $el_qty.val(this_qty);
	                // 옵션 가격 계산 minu
	                var opPrice = $(this).parent().parent().parent().children('.right').children('input').val()
	                if(opPrice != '' && opPrice != null){
		    	       	opPrice = parseInt(opPrice.replace(',','').replace('원',''));
		    	        $(this).parent().parent().parent().children('.right').children().text((opPrice*parseInt($el_qty.val())).toLocaleString()+'원')
	                }
	    	        calcTotalPrice();
	                break;
	            default:
	                alert("올바른 방법으로 이용해 주십시오.");
	                break;
	        }
	    });
	    
		// 장바구니 이벤트 
		$('#btnCart').click(function(){			
	       	
			<c:if test="${empty USER.MEMB_ID}">
				alert("로그인이 필요합니다.");
				location.href = "${contextPath}/m/user/loginForm";
				return false;
			</c:if>

			if($("#sit_tot_price").text() =='0원'){
				alert('1개 이상의 상품을 선택 해 주세요');
				return false;
			}
	    	
			$('#PD_QTY').val($('#CT_QTY').val());
			
			<c:if test='${option_cnt >0 }'>
		 		$('#OPTION_CODE').val($('.PD_OPTION_SEL').val());
			</c:if>
			
			// 2021-11-04 minu
			if($(".order-list").children().length > 0){
				// option1,2,3_value,qty 추가
				var options1 = [];
				var options2 = [];
				var options3 = [];
				var pd_qtys = [];
				var price = [];
		
				//추가상품(2022.01장보라)
				var extrPrd_PdCode=[];//추가상품코드
				var extrPrd_PdQty=[];//추가상품갯수 
			    
				
				if($("#PD_OPTION_1").length >0){
				
					for(var i=0; i<$(".prdOption").length; i++){
					    options1.push($(".prdOption")[i].value.split('/')[0]);
						options2.push($(".prdOption")[i].value.split('/')[1]);
						options3.push($(".prdOption")[i].value.split('/')[2]);
						price.push($(".extraPrice")[i].value);
						pd_qtys.push($(".optionQty")[i].value);
					}
					$("#OPTION1_NAME").val($(".option1")[0].textContent.split(" : ")[0]);
					$("#OPTION1_VALUE").val(options1);	
					$("#PD_QTY").val(pd_qtys);
			    }
				
				//추가상품 가격, 코드, 갯수 (2022.01장보라)
				for(var i=0; i<$(".extraPdCode").length; i++){
					extrPrd_PdCode.push($(".extraPdCode")[i].value);
					extrPrd_PdQty.push($(".extraPdQty")[i].value);
				}
				//추가상품 input값 전달  (2022.01장보라)
				if($(".extraPdCode").length != 0){
					document.getElementById("EXTRA_PD_CODE").value=extrPrd_PdCode;
					document.getElementById("EXTRA_PD_QTY").value=extrPrd_PdQty;
				}
					
				if($(".option3").length != 0){
					$("#OPTION3_NAME").val($(".option3")[0].textContent.split(" : ")[0]);
					$("#OPTION3_VALUE").val(options3);
				}
				if($(".option2").length != 0){
					$("#OPTION2_NAME").val($(".option2")[0].textContent.split(" : ")[0]);
					$("#OPTION2_VALUE").val(options2);
				}
				if($(".option3").length != 0){
					$("#OPTION3_NAME").val($(".option3")[0].textContent.split(" : ")[0]);
					$("#OPTION3_VALUE").val(options3);
				}
				
			}
	        <c:if test="${!empty USER.MEMB_ID}">
	      		//회원
		    	$.ajax({
		    		type: "POST",
		    		url: '${contextPath}/goods/basketInst',
		    		data: $("#bkInstFrm").serialize(),
		    		success: function (data) {
		    			// 장바구니 등록 여부
		    			if (data > 0) {
		    				$("#myCartListCntHeader").text(parseInt($("#myCartListCntHeader").text())+1)
		    				$(".casa-msg").text('장바구니에 상품을 담았습니다.');
		    				$("#bascketPop").css('display','block');
		    			}else{
		    				$(".casa-msg").text('장바구니에 이미 등록된 상품 입니다.');
		    				$("#bascketPop").css('display','block');
		    			}
		    		}, error: function (jqXHR, textStatus, errorThrown) {
		    			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
		    		}
		    	});
	        </c:if>	    	
		});
		
		// 구매하기 이벤트 
		$('#btnBuy').click(function(){
			
			if($("#sit_tot_price").text() =='0원'){
				alert('1개 이상의 상품을 선택 해 주세요');
				return false;
			}
			
	      /*  	<c:if test="${empty USER.MEMB_ID}">
				alert("로그인이 필요합니다.");
				location.href = "${contextPath}/m/user/loginForm";
				return false;
			</c:if> */

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
				var pd_qty_val = $($(".optionQty").val());
				 
				$('#PD_QTY').val(pd_qty_val);    //CT_QTY : 신청수량
				$('#ORDER_QTY').val(pd_qty_val);
			</c:if>
			
			<c:if test='${result.QNT_LIMT_USE!="Y"}'>
				$('#PD_QTY').val($('#CT_QTY').val());    //CT_QTY : 신청수량
				$('#ORDER_QTY').val($('#CT_QTY').val());
			</c:if>
			
			$('#PD_PRICE').val('${result.MEMBERS_PRICE}');
		    var options1 = [];
			var options2 = [];
			var options3 = [];
			var pd_qtys = [];
			
			for(var i=0; i<$(".prdOption").length; i++){
			    options1.push($(".prdOption")[i].value.split('/')[0]);
				options2.push($(".prdOption")[i].value.split('/')[1]);
				options3.push($(".prdOption")[i].value.split('/')[2]);
				pd_qtys.push($(".optionQty")[i].value);
			}
			$("#OPTION1").val(options1);			
			$("#OPTION2").val(options2);
			$("#OPTION3").val(options3); 
			
			// 2021-11-04 minu
			if($(".order-list").children().length >0){
				
				// option1,2,3_value,qty 추가
				var options1 = [];
				var options2 = [];
				var options3 = [];
				var pd_qtys = [];
				
				if($("#PD_OPTION_1").length >0){
					for(var i=0; i<$(".prdOption").length; i++){
					    options1.push($(".prdOption")[i].value.split('/')[0]);
						options2.push($(".prdOption")[i].value.split('/')[1]);
						options3.push($(".prdOption")[i].value.split('/')[2]);
						pd_qtys.push($(".optionQty")[i].value);
					}
					$("#OPTION1_NAME").val($(".option1")[0].textContent.split(" : ")[0]);
					$("#OPTION1_VALUE").val(options1);			
					$("#PD_QTY").val(pd_qtys);
				}
				if($(".option3").length != 0){
					$("#OPTION3_NAME").val($(".option3")[0].textContent.split(" : ")[0]);
					$("#OPTION3_VALUE").val(options3);
				}
				if($(".option2").length != 0){
					$("#OPTION2_NAME").val($(".option2")[0].textContent.split(" : ")[0]);
					$("#OPTION2_VALUE").val(options2);
				}
				
				var extrPrd_PdCode=[];//추가상품코드
				var extrPrd_PdQty=[];//추가상품갯수 
				//추가상품 가격, 코드, 갯수 (2022.01장보라)
				for(var i=0; i<$(".extraPdCode").length; i++){
					extrPrd_PdCode.push($(".extraPdCode")[i].value);
					extrPrd_PdQty.push($(".extraPdQty")[i].value);
				}
				//추가상품 input값 전달  (2022.01장보라)
				if($(".extraPdCode").length != 0){
// 					document.getElementById("EXTRA_PD_CODE").value=extrPrd_PdCode;
					document.getElementById("EXTRA_PD_QTY").value=extrPrd_PdQty;
				}
			}
				
				
			// 추가상품 상품 코드
			/* var extraPdCodes = $('.extraPdCode');
			var extraPdQty = $('.extraPdQty');
			var extra_pd_code = "";
			var extra_pd_qty = "";
			for(var i =0; i< extraPdCodes.length;i++){
				if(i==0){
					extra_pd_code += extraPdCodes[i].value;
					extra_pd_qty += extraPdQty[i].value;
				}else{
					extra_pd_code += ","+extraPdCodes[i].value;
					extra_pd_qty += ","+extraPdQty[i].value;
				}
			}
			
			$("#EXTRA_PD_CODE").val(extra_pd_code);
			$("#EXTRA_PD_QTY").val(extra_pd_qty); */
			// 배송비 계산 
			
			var orderPrice = $("#sit_tot_price").text().replaceAll(',','').replace('원','')*1;
			/*
			var dlva_fcon = ${result.DLVA_FCON};
			if( dlva_fcon > orderPrice  ){
				$("#DLVY_AMT").val(${result.DLVY_AMT });
			}*/
			
			$('#bkInstFrm').attr('action', '${contextPath}/m/order/buy2').submit();
		}); 

	 	// toggle
		$("#toggleInfo, #toggleGuide").click(function(){
			if($(this).find("#toggleClose").css("display") == "none"){
				$(this).nextAll([".pdDinfo"]).show();
				
				$(this).find("#toggleClose").show();
				$(this).find("#toggleOpen").hide();
			}else{
				$(this).nextAll([".pdDinfo"]).hide();
				
				$(this).find("#toggleClose").hide();
				$(this).find("#toggleOpen").show();
			}
		})
	});
	 
	// 가격계산
	function price_calculate() {
	    var PD_PRICE = parseInt($("input#MEMBERS_PRICE").val());
	    
	    if(isNaN(PD_PRICE)) return;
	    
		// 옵션 상품 가격설정 정성

	    if(parseInt($('#CT_QTY').val())<1 || $('#CT_QTY').val()==''){
	    	alert("최소 구매수량은 1 입니다.");
	    	$('#CT_QTY').val(1);	    	
	    }
	    
	    if(parseInt($('#CT_QTY').val()) > parseInt($('#LIMIT_QTY').val())){
	    	alert("한정 구매수량은 "+ $('#LIMIT_QTY').val() +" 입니다.");
	    	$('#CT_QTY').val($('#LIMIT_QTY').val());	    	
	    }

		var final_total = 0;
	    <c:if test='${result.QNT_LIMT_USE eq "Y"}'>
		    var qty = $("#CT_QTY  option:selected").text()
		    var total = PD_PRICE*qty;
			final_total = total;
	    </c:if>
	    
	    <c:if test='${result.QNT_LIMT_USE eq null or result.QNT_LIMT_USE eq "" or result.QNT_LIMT_USE eq "N"}'>
		    var qty = parseInt($("#CT_QTY").val());					//신청수량
		    var total = parseInt(PD_PRICE * qty);
			final_total = total;
	    </c:if>
	    
	    //박스입수량
	    var inputcnt = parseInt('${result.INPUT_CNT}');				//입수량
	    var boxpddcval = parseInt('${result.BOX_PDDC_VAL}');	//박스할인값
	    var boxsalequt = parseInt(qty/inputcnt);						//몫
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
<head>
<meta charset="UTF-8">
<style type="text/css">
	.optionQty,.extraPdQty{width: 50px;height: 40px;}
	.QTY {width: 50px!important;height: 40px!important;}
	.tab-cont {margin-top: 30px;}
	th, td {white-space: normal;}
	ul.breadcrumb li a {color: black;}
	ul.breadcrumb li:last-child a {	color: black;}
	#CT_QTY{border: none; padding: 0;text-align: center; background:white;}
    .qnaTable{border-collapse: collapse; border-bottom:1px solid #eeeeee}
    .qnaTable td,th{text-align: center; height: 40px; font-size: 13px;}
    .qnaTable th{color:black;border:1px solid lightgray; }
    #insertQna{float:right;}
    #QnaPaging {margin-top:30px; }
    .qnaContent{height: 200px!important; text-align: left!important; vertical-align: baseline; padding-left: 50px; padding-top: 15px;}
    #QnaPaging .start{background:url("${contextPath}/resources/resources2/images/icon_page_start.png") no-repeat 50% 50%; display:inline-block; width:30px; height:30px;margin-bottom: -10px;}
	#QnaPaging .end{background:url("${contextPath}/resources/resources2/images/icon_page_end.png") no-repeat 50% 50%; display:inline-block; width:30px; height:30px;margin-bottom: -10px;}
	#QnaPaging .page{display:inline-block; width:30px; height:30px;    font-style: inherit;}
	#QnaPaging .paging_new li.prev .ic{background:url("${contextPath}/resources/resources2/images/icon_page_prev.png") no-repeat 50% 50%}
	#QnaPaging .paging_new li.next .ic{background:url("${contextPath}/resources/ resources2/images/icon_page_next.png") no-repeat 50% 50%} 
.com_info {
 	   color: #526681;
 }
    
.modal {
	   position: fixed;
	   top: 0;
	   left: 0;
	   width: 100%;
	   height: 100%;
	   display: flex;
	   justify-content: center;
	   align-items: center;
 }
 .modal .bg {
 	  width: 100%;
  	  height: 100%;
 }
 .modalBox {
     position: absolute;
 	 background-color: #fff;
	 width: 424px;
	 height: 251px;
	 padding: 15px;
	 border-radius: 17px;
	 border-color: black;
	 border-width: 1px;
	 border-style: solid;
	 text-align: center;
 }
 .modalBox button {
   	display: block;
  	 margin: 0 auto;
 }
 .hidden {
   	display: none;
 } 
 .madalTable{
  	border-style: solid;
 	border-width: 1px;
 	text-align: center;
 }
 .memberDiv{
	background-color: #f8f8f8;
	margin-top:10px; 	
	margin-bottom:10px;
	border-bottom: 1px solid #ddd;
    border-top: 1px solid #ddd;
  	padding: 10px;
  	display: flex;
    align-items: center;
 }
.memberPrice{
	color: #b5b5b5;
    margin-left: 10px;
    text-decoration: line-through;
}
.memberPriceSale{
	color:#5a5a5a;
}
.memberPriceInfo{
	display: flex;
    flex-direction: row;
    width: 100%;
    align-items: center;
    justify-content: flex-end;
    font-size: 15px;
}
</style>

<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/swiper/dist/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/common.css">
<script type="text/javascript" src="${contextPath}/resources/resources2/swiper/dist/js/swiper.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body>
<form id="bkInstFrm" name="bkInstFrm" action="${contextPath }/goods/basketInst" method="post" autocomplete="off">
	<input type="hidden" name="PD_CODE" id="PD_CODE"value="${result.PD_CODE }">
	<input type="hidden" name="SETPD_CODE" value="${result.PD_CODE }">
	<input type="hidden" name="PD_QTY"id="PD_QTY" value=""> 
	<input type="hidden" name="PD_QTYs"id="PD_QTYs" value=""> 
	<input type="hidden" name="ORDER_QTY" id="ORDER_QTY" value=""> 
	<input type="hidden" id="BSKT_REGNO" name="BSKT_REGNO" value=""> 
	<input type="hidden" id="PD_NAME" name="PD_NAME" value="${result.PD_NAME}" /> 
 	<input type="hidden" id="PD_PRICE" name="PD_PRICE" value="${result.MEMBERS_PRICE}" />
	<input type="hidden" id="PDDC_GUBN" name="PDDC_GUBN" value="${result.PDDC_GUBN}" /> 
	<input type="hidden" id="PDDC_VAL" name="PDDC_VAL" value="" /> 
	<input type="hidden" id="ORDER_AMT" name="ORDER_AMT" value="${ result.MEMBERS_PRICE }" /> 
	<input type="hidden" id="DLVY_AMT" name="DLVY_AMT" value="0" /> 
	<input type="hidden" id="DAP_YN" name="DAP_YN" value="N" /> 
	<input type="hidden" id="PD_CUT_SEQ" name="PD_CUT_SEQ" value="" /> 
	<input type="hidden" id="PD_CUT_SEQ_UNIT" name="PD_CUT_SEQ_UNIT" value="" />
	<input type="hidden" id="OPTION_CODE" name="OPTION_CODE" value="" /> 
	<input type="hidden" id="OPTION_NAME" name="OPTION_NAME" value="" /> 
	<input type="hidden" id="OPTION1_NAME" name="OPTION1_NAME" value="" /> 
	<input type="hidden" id="OPTION1_VALUE" name="OPTION1_VALUE" value="" /> 
	<input type="hidden" id="OPTION2_NAME" name="OPTION2_NAME" value="" /> 
	<input type="hidden" id="OPTION2_VALUE" name="OPTION2_VALUE" value="" />
	<input type="hidden" id="OPTION3_NAME" name="OPTION3_NAME" value="" /> 
	<input type="hidden" id="OPTION3_VALUE" name="OPTION3_VALUE" value="" />
	<input type="hidden" id="OPTION1" name="OPTION1" value="" />
	<input type="hidden" id="OPTION2" name="OPTION2" value="" />
	<input type="hidden" id="OPTION3" name="OPTION3" value="" />
	<input type="hidden" id="EXTRA_PD_CODE" name="EXTRA_PD_CODE" value=""/>
	<input type="hidden" id="EXTRA_PD_QTY" name="EXTRA_PD_QTY" value=""/>
	<input type="hidden" id="TOTAL_CNT"/>
	<input type="hidden" id="TOTAL_AMT"/>
	<input type="hidden" id="TOTAL_SHIP"/>
	<input type="hidden" id="ORIGIN_DLVY_AMT" value="${ result.DLVY_AMT }"/>
</form>

<div class="wrapper">
	<div class="container detail">
		<div class="location">
			<a href="${contextPath }/m"><span class="item">홈</span></a>
			<c:forEach var="entPath" items="${ arrCagoNmPath }"
				varStatus="status">
				<span class="item"> <span class="hp">></span> <a href="${contextPath }/m/product?CAGO_ID=${arrCagoIdPath[status.index] }&entcago=${entcagoInfo.ENTRY_ID}" class=" ">${entPath }</a>	</span>
			</c:forEach>
		</div>
			<div class="contents">
				<div class="product mgt20">
					<div class="dual clear-fix">
						<div class="img-zone">
							<div class="present-img">
								<c:if test="${ !empty(result.ATFL_ID)  }">
									<c:if test="${result.FILEPATH_FLAG eq mainKey }">
										<c:set var="imgPath" value="${contextPath }/upload/${result.STFL_PATH }/${result.STFL_NAME }" />
									</c:if>
									<c:if
										test="${!empty(result.FILEPATH_FLAG) && result.FILEPATH_FLAG ne mainKey }">
										<c:set var="imgPath" value="${result.STFL_PATH }" />
									</c:if>
									<c:if
										test="${ empty(result.FILEPATH_FLAG) or result.FILEPATH_FLAG eq subKey }">
										<c:set var="imgPath" value="https://www.cjfls.co.kr/upload/${result.STFL_PATH }/${result.STFL_NAME }" />
									</c:if>
								</c:if>
								<c:if test="${ empty(result.ATFL_ID)  }">
									<c:set var="imgPath"
										value="${contextPath }/resources/images/mall/goods/noimage.png" />
								</c:if>
								<c:if test="${  empty(result.ATFL_ID) && !empty(result.IMGURL) }">
									<c:set var="imgPath" value="${result.IMGURL }" />
								</c:if>		
								<img src="${imgPath }" width="100%">
							</div>
							<div class="select mgt20">
								<div class="swiper-wrapper">
									<div class="swiper-container">
										<div class="swiper-wrapper">

											<c:forEach var="var" items="${ fileList }" varStatus="status">
												<c:if test="${ !empty(var.ATFL_ID)  }">
													<c:if test="${var.FILEPATH_FLAG eq mainKey }">
														<c:set var="imgPathSm" value="${contextPath }/upload/${var.STFL_PATH }/${var.STFL_NAME }" />
													</c:if>
													<c:if test="${!empty(var.FILEPATH_FLAG) && var.FILEPATH_FLAG ne mainKey }">
														<c:set var="imgPathSm" value="${var.STFL_PATH }" />
													</c:if>
													<c:if test="${ empty(var.FILEPATH_FLAG) or var.FILEPATH_FLAG eq subKey }">
														<c:set var="imgPathSm" value="https://www.cjfls.co.kr/upload/${var.STFL_PATH }/${var.STFL_NAME }" /> 
													</c:if>
												</c:if>
												<c:if test="${ empty(var.ATFL_ID)  }">
													<c:set var="imgPathSm" value="${contextPath }/resources/images/mall/goods/noimage.png" />
												</c:if>
												<div class="swiper-slide selected">
													<a data-index="${status.index }" class="img thumbnail "
														data-image="${imgPathSm }" title="${ result.PD_NAME }">
														<img class="thumb-slider-img" src="${imgPathSm }"
														title="${ result.PD_NAME }" alt="${ result.PD_NAME }">
													</a>
												</div>
											</c:forEach>
										</div>
										<!-- Add Pagination -->
									</div>
									<div class="swiper-conts-wrap">
										<div class="swiper-conts">
											<!-- Add Arrows -->
											<div class="swiper-button-next"></div>
											<div class="swiper-button-prev"></div>
										</div>
									</div>
								</div>


							</div>
						</div>
						<div class="product-info">
							<p class="title">
								<c:out value="${ result.PD_NAME }" escapeXml="true" />
							</p>
							<div>
							
								<table>
									<colgroup>
										<col width="30%" />
										<col width="*" />
									</colgroup>
									<tbody id="productData">
										<tr>
											<td>판매가격</td>
											<td><span class="price-dark" itemprop="price" style="font-size: 20px;">
												<fmt:formatNumber value="${ result.PD_PRICE }" pattern="#,###" />원</span> 
												<fmt:parseNumber var="pv" value="${ result.PD_PRICE  }" integerOnly="true" />
											</td>
										</tr>
											<c:choose>
											  	<c:when test="${empty result.MEMBER_PRICE}">
											  	</c:when>
											  	<c:otherwise>
													<tr>
														<td>등급가격</td>	
														<td style="display: flex; align-items: center;">
															<span class="price-dark" itemprop="price" style="font-size: 20px;"><fmt:formatNumber value="${ result.MEMBER_PRICE }" pattern="#,###" />원</span> <fmt:parseNumber var="pv" value="${ result.MEMBER_PRICE  }" integerOnly="true" /> ~ 
															<span class="price-dark" itemprop="price" style="font-size: 20px;"><fmt:formatNumber value="${ result.PD_PRICE }" pattern="#,###" />원</span> <fmt:parseNumber var="pv" value="${ result.PD_PRICE  }" integerOnly="true" /> &nbsp;&nbsp;
											  				<button class="openBtn" style="min-width: 23px; border-radius: 20px;height: 23px;font-size: 12px">▽</button>
															<input type="hidden" name="MEMBER_PRICE" id="MEMBER_PRICE" value="${result.MEMBER_PRICE }"/>
															<c:set var="memberPrice_04" value="${result.MEMBER_PRICE }"/><!-- 조합원가격 -->
															<c:set var="memberPrice_02" value="${result.PD_PRICE-((result.PD_PRICE-result.MEMBER_PRICE)/2)}"/><!--사업자가격  -->
															<div class="modal hidden">
			 													<div class="modalBox">
																	<table border="1px" >
																	<tr style="font-weight: bolder;">
																		<td>등 급</td>
																		<td>가 격</td>
																	</tr>
																   	<tr>
																		<td>조합원</td>
																		<td><span class="price-dark" itemprop="price" style="font-size: 20px;"><fmt:formatNumber value="${ memberPrice_04 }"/>원</span><fmt:parseNumber var="pv" value="${ memberPrice_04  }" integerOnly="true" /></td>
																	</tr>
																	<tr>
																		<td>사업자</td>
																		<td><span class="price-dark" itemprop="price" style="font-size: 20px;"><fmt:formatNumber value="${ memberPrice_02 }"/>원</span><fmt:parseNumber var="pv" value="${ memberPrice_02}" integerOnly="true" /></td>
																	</tr>
																	<tr>
																		<td>일 반</td>
																		<td><span class="price-dark" itemprop="price" style="font-size: 20px;"><fmt:formatNumber value="${  result.PD_PRICE }"/>원</span><fmt:parseNumber var="pv" value="${  result.PD_PRICE  }" integerOnly="true" /></td>
																	</tr>
															  	  </table>
															  	  <button class="closeBtn" style="min-width:41px;border-radius:20px;margin-top:9px;" >✖</button>
														  		</div>
															</div>
														</td>
													</tr>
											 </c:otherwise>
										</c:choose>
										<c:if test="${empty option1 }">
										<tr>
											<td>수량</td>
											<td>
												<div class="counter">
													<button class="btnQty">-</button>
													<input type="text"class="QTY" name="CT_QTY" id="CT_QTY" value="1" readonly ></input>
													<button class="btnQty">+</button>
												</div>
											</td>
										</tr>
										</c:if>
											<c:if test="${!empty option1 }">
												<tr>
													<td>${option1[0].OPTION1_NAME }</td>
													<td>													
														<select class=""  id="PD_OPTION_1" >
															<option class="optionName"value="">${ option1[0].OPTION1_NAME } 선택[필수]</option>
															
															<c:forEach var="op" items="${ option1 }" varStatus="sta">
																<c:if test="${op.PRICE eq 0}">	
																	<option value='${op.OPTION1_VALUE }'>${op.OPTION1_VALUE }</option>
																</c:if>
																<c:if test="${op.PRICE ne 0}">
																	<c:choose>
																		<c:when test="${op.PRICE > 0 }">
																			<option value='${op.OPTION1_VALUE }'>${op.OPTION1_VALUE }( +<fmt:formatNumber value="${ op.PRICE }"/>원)</option>
																		</c:when>
																		<c:otherwise>
																			<option value='${op.OPTION1_VALUE }'>${op.OPTION1_VALUE }( <fmt:formatNumber value="${ op.PRICE }"/>원)</option>
																		</c:otherwise>
																	</c:choose>	
																</c:if>
															</c:forEach>
														</select>
														<c:forEach var="op" items="${ option1 }" varStatus="sta">
															<c:if test="${op.PRICE ne 0}">	
																<input type="hidden" id="${op.OPTION1_VALUE }" value="${op.PRICE }"/>
															</c:if>												
														</c:forEach>
													</td>
												</tr>	
											</c:if>
										<tr id="option2Select"></tr>
										<tr id="option3Select"></tr>
										<tr>
											<td>배송비</td>
											<td>
												<c:choose>
													<c:when test="${ empty(tb_pdshipxm) }">
													</c:when>
													<c:otherwise>
														<input type="hidden" class="SHIP_CONFIG" value="${ tb_pdshipxm.SHIP_CONFIG }"/>
														<c:if test="${ tb_pdshipxm.SHIP_CONFIG eq 'SHIP_CONFIG_01' }">
														<fmt:formatNumber value="${ tb_pdshipxm.DLVY_AMT }" pattern="#,###" />원 
														(<fmt:formatNumber value="${ tb_pdshipxm.GUBN_START }" pattern="#,###" />원 이상 주문 시 무료배송)
															<input type="hidden" class="DLVY_PRICE" value="${ tb_pdshipxm.DLVY_AMT }"/>
															<input type="hidden" class="GUBN_START" value="${ tb_pdshipxm.GUBN_START }"/>
														</c:if>
														<c:if test="${ tb_pdshipxm.SHIP_CONFIG eq 'SHIP_CONFIG_02' }">
															<input type="hidden" class="SHIP_GUBN" value="${ tb_pdshipxm.SHIP_GUBN }"/>
															<c:if test="${ tb_pdshipxm.SHIP_GUBN eq 'SHIP_GUBN_01' }">
															무료배송
															<input type="hidden" class="DLVY_PRICE" value="0"/>
															</c:if>
															<c:if test="${ tb_pdshipxm.SHIP_GUBN eq 'SHIP_GUBN_02' }">
																<fmt:formatNumber value="${ tb_pdshipxm.DLVY_AMT }" pattern="#,###" />원 
																(<fmt:formatNumber value="${ tb_pdshipxm.GUBN_START }" pattern="#,###" />원 이상 주문 시 무료배송)
																<input type="hidden" class="DLVY_PRICE" value="${ tb_pdshipxm.DLVY_AMT }"/>
																<input type="hidden" class="GUBN_START" value="${ tb_pdshipxm.GUBN_START }"/>
															</c:if>
															<c:if test="${ tb_pdshipxm.SHIP_GUBN eq 'SHIP_GUBN_03' }">
																<c:if test="${ !empty(tb_pdshipxd.list) }">
																	<c:forEach var="list" items="${ tb_pdshipxd.list }" varStatus="loop">
																	<p>
																	<fmt:formatNumber value="${ list.GUBN_START }" pattern="#,###" />원 이상
																	<fmt:formatNumber value="${ list.GUBN_END }" pattern="#,###" />원 미만 주문 시
																	<fmt:formatNumber value="${ list.DLVY_AMT }" pattern="#,###" />원
																	</p>
																	<input type="hidden" id="DLVY_PRICE${ loop.index }" class="DLVY_PRICE" value="${ list.DLVY_AMT }"/>
																	<input type="hidden" id="GUBN_START${ loop.index }" class="GUBN_START" value="${ list.GUBN_START }"/>
																	<input type="hidden" id="GUBN_END${ loop.index }" class="GUBN_END" value="${ list.GUBN_END }"/>									
																</c:forEach>
																</c:if>
															</c:if>
															<c:if test="${ tb_pdshipxm.SHIP_GUBN eq 'SHIP_GUBN_04' }">
																<c:if test="${ !empty(tb_pdshipxd.list) }">
																	<c:forEach var="list" items="${ tb_pdshipxd.list }" varStatus="loop">
																		<p>
																		<fmt:formatNumber value="${ list.GUBN_START }" pattern="#,###" />개 이상
																		<fmt:formatNumber value="${ list.GUBN_END }" pattern="#,###" />개 미만 주문 시
																		<fmt:formatNumber value="${ list.DLVY_AMT }" pattern="#,###" />원
																		</p>
																		<input type="hidden" id="DLVY_PRICE${ loop.index }" class="DLVY_PRICE" value="${ list.DLVY_AMT }"/>
																		<input type="hidden" id="GUBN_START${ loop.index }" class="GUBN_START" value="${ list.GUBN_START }"/>
																		<input type="hidden" id="GUBN_END${ loop.index }" class="GUBN_END" value="${ list.GUBN_END }"/>										
																	</c:forEach>
																</c:if>
															</c:if>
														</c:if>
														<c:if test="${ tb_pdshipxm.SHIP_CONFIG eq 'SHIP_CONFIG_03' }">
															<input type="hidden" class="SHIP_GUBN" value="${ tb_shiptexm.SHIP_GUBN }"/>
															<c:if test="${ tb_shiptexm.SHIP_GUBN eq 'SHIP_GUBN_01' }">
															무료배송
															<input type="hidden" class="DLVY_PRICE" value="0"/>
															</c:if>
															<c:if test="${ tb_shiptexm.SHIP_GUBN eq 'SHIP_GUBN_02' }">
																<fmt:formatNumber value="${ tb_shiptexm.DLVY_AMT }" pattern="#,###" />원 
																(<fmt:formatNumber value="${ tb_shiptexm.GUBN_START }" pattern="#,###" />원 이상 주문 시 무료배송)
																<input type="hidden" class="DLVY_PRICE" value="${ tb_shiptexm.DLVY_AMT }"/>
																<input type="hidden" class="GUBN_START" value="${ tb_shiptexm.GUBN_START }"/>
															</c:if>
															<c:if test="${ tb_shiptexm.SHIP_GUBN eq 'SHIP_GUBN_03' }">
																<c:if test="${ !empty(tb_shiptexd.list) }">
																	<c:forEach var="list" items="${ tb_shiptexd.list }" varStatus="loop">
																		<p>
																		<fmt:formatNumber value="${ list.GUBN_START }" pattern="#,###" />원 이상
																		<fmt:formatNumber value="${ list.GUBN_END }" pattern="#,###" />원 미만 주문 시
																		<fmt:formatNumber value="${ list.DLVY_AMT }" pattern="#,###" />원
																		</p>		
																		<input type="hidden" id="DLVY_PRICE${ loop.index }" class="DLVY_PRICE" value="${ list.DLVY_AMT }"/>
																		<input type="hidden" id="GUBN_START${ loop.index }" class="GUBN_START" value="${ list.GUBN_START }"/>
																		<input type="hidden" id="GUBN_END${ loop.index }" class="GUBN_END" value="${ list.GUBN_END }"/>				
																	</c:forEach>
																</c:if>
															</c:if>
															<c:if test="${ tb_shiptexm.SHIP_GUBN eq 'SHIP_GUBN_04' }">
																<c:if test="${ !empty(tb_shiptexd.list) }">
																	<c:forEach var="list" items="${ tb_shiptexd.list }" varStatus="loop">
																		<p>
																		<fmt:formatNumber value="${ list.GUBN_START }" pattern="#,###" />개 이상
																		<fmt:formatNumber value="${ list.GUBN_END }" pattern="#,###" />개 미만 주문 시
																		<fmt:formatNumber value="${ list.DLVY_AMT }" pattern="#,###" />원
																		</p>
																		<input type="hidden" id="DLVY_PRICE${ loop.index }" class="DLVY_PRICE" value="${ list.DLVY_AMT }"/>
																		<input type="hidden" id="GUBN_START${ loop.index }" class="GUBN_START" value="${ list.GUBN_START }"/>
																		<input type="hidden" id="GUBN_END${ loop.index }" class="GUBN_END" value="${ list.GUBN_END }"/>											
																	</c:forEach>
																</c:if>
															</c:if>
														</c:if>
													</c:otherwise>
												</c:choose>
												<!-- 
												<select name="" id="">
													<fmt:parseNumber var="dlva_fcon" type="number" value="${result.DLVA_FCON}" />
													<fmt:parseNumber var="members_price" type="number" value="${result.MEMBERS_PRICE}" />
													<c:if test="${dlva_fcon > members_price }">
														<option>${result.DLVY_AMT }원 (${result.DLVA_FCON }원 이상 주문 시 무료배송) </option>
													</c:if>
													<c:if test="${dlva_fcon <= members_price }">
														<option> 배송비 무료</option>
													</c:if>
												</select>
												 -->
											</td>
										</tr>
										<c:choose>
											<c:when  test="${fn:length(extrList) == 0}">
											</c:when>
											<c:otherwise>
											<tr>
												<td>추가상품</td>
												<td>
													<select id="extrPrd">
														<option value="">추가상품을 선택 하세요 </option>
														<c:forEach var="list" items="${extrList}" varStatus="status">
															<option value="extrPd${status.index}">${list.PD_NAME }  [<fmt:formatNumber value="${ list.PD_PRICE }"/>원 ]</option>
														</c:forEach>
													</select>
													<c:forEach var="list" items="${extrList}" varStatus="status">
													    <input type="hidden" name="extrPd${status.index}Code" value="${list.EXTRA_PD_CODE }"/>
														<input type="hidden" name="extrPd${status.index}Price" value="${list.PD_PRICE }"/>
														<input type="hidden" name="extrPd${status.index}Name" value="${list.PD_NAME }"/>  
													</c:forEach>
												</td>
											</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
								<!-- 상품옵션선택 2020-04-29 TB_PDOPTION 정성 -->	
							<div id="product">
								<input type="hidden" id="memberPrice1" class="memberPrice1" value="${ result.MEMBERS_PRICE }"/>
				                <c:choose>
				                	<c:when test="${result.MEMBERS_PRICE eq result.PD_PRICE }">
				                	</c:when>
				                	<c:otherwise> 
				                		<div class="memberDiv">
				                			<div class="memberInfo" style="width: 100%;">
											<c:if test="${!empty loginUser }">
											<span>${loginUser} 님을 위한 특별가격은</span><br/>
												<b><span itemprop="price" style="font-size: 20px;">
													<fmt:formatNumber value="${ result.MEMBERS_PRICE }"/>원
												</span>
												<fmt:parseNumber var="pv" value="${ result.MEMBERS_PRICE  }" integerOnly="true" />
											</b>입니다.
											</c:if>
										</div>
										<div class="memberPriceInfo"> 
					               			 	<span class="memberPriceSale">
				                    		    	<b><fmt:formatNumber value="${ result.MEMBERS_PRICE }" pattern="#,###" />원</b>
				                   			     </span>
					               				<span class="memberPrice"><fmt:formatNumber value="${result.PD_PRICE }" pattern="#,###"/> 원 </span>
			                     		   </div>
		                        	   </div>
				                	</c:otherwise>
				                </c:choose>
								<ul class="order-list mgt30"></ul>
								<div class="tb bold mgt20" style="font-weight: 900; font-size: 20px;">
								<c:set var="dlvafcon"  value="${result.DLVA_FCON*1}" />
								<c:set var="members" value="${result.MEMBERS_PRICE*1}" />
									<div>총 상품금액</div>
									<c:if test="${!empty option1 }">
										<div id="sit_tot_price">0원</div>
									</c:if>
									<!-- 
									<c:if test="${empty option1 }">
										<c:if test="${dlvafcon > members }">
											<div id="sit_tot_price"><fmt:formatNumber value="${ result.MEMBERS_PRICE + result.DLVY_AMT}" pattern="#,###" />원</div>
										</c:if>
										<c:if test="${ dlvafcon <= members}">
											<div id="sit_tot_price"><fmt:formatNumber value="${ result.MEMBERS_PRICE}" pattern="#,###" />원</div>
										</c:if>
									</c:if>
									 -->
									 <c:if test="${empty option1 }">
										<div id="sit_tot_price"><fmt:formatNumber value="${ result.MEMBERS_PRICE + result.DLVY_AMT}" pattern="#,###" />원</div>
									</c:if>
								</div>

								<div class="form-type">
									<div class="item mgt30 dual-btns">
										<button id="btnCart">장바구니</button>
										<button id="btnBuy">구매하기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="tab pt3 mgt60">
					<ul class="tab-list">
						<li class="tab-item on"><span>상품정보</span></li>
						<li class="tab-item"><span>배송/교환/반품</span></li>
						<li class="tab-item"><span>상품리뷰</span></li>
						<li class="tab-item qna-tab"><span>QnA</span></li>

					</ul>

					<div class="tab-conts">
						<div class="tab-cont on" ${fileDtlList }>
						<c:if test="${!empty fileDtlList }">
						 <c:forEach var="var" items="${ fileDtlList }" varStatus="status">
							<c:if test="${var.FILEPATH_FLAG eq mainKey }">													
								<c:set var="imgDtlPath" value="${contextPath }/upload/${var.STFL_PATH }/${var.STFL_NAME }" />
							</c:if>
							<c:if test="${!empty(var.FILEPATH_FLAG) && var.FILEPATH_FLAG ne mainKey }">d
								<c:set var="imgDtlPath" value="${var.STFL_PATH }" />
							</c:if>
							<c:if test="${ empty(var.FILEPATH_FLAG) }">
								<c:set var="imgDtlPath" value="https://www.cjfls.co.kr/upload/${var.STFL_PATH }/${var.STFL_NAME }" />
							</c:if>
							<tr>
								<td><img src="${imgDtlPath }" class="goodsImg" />&nbsp;</td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${empty fileDtlList }">
							${ result.PD_DINFO}
						</c:if>
							<p class="mgt20"></p>
							<div class="pd-info02">
								<h2>상품정보고시</h2>
								<div>
									<div class="section pdDinfo"
										style="white-space: nowrap; overflow-x: scroll;">
										<table>
											<colgroup>
												<col width="40%" />
												<col width="*" />
											</colgroup>
											<tbody>
												<tr>
													<td>품명 및 모델명</td>
													<td>상세설명 참조</td>
												</tr>
												<tr>
													<td>법에 의한 인증,허가등을 받았음을 확인할 수 있는 경우 그에 대한 사항</td>
													<td>상세설명 참조</td>
												</tr>
												<tr>
													<td>제조국 또는 원산지</td>
													<td>상세설명 참조</td>
												</tr>
												<tr>
													<td>제조사, 수입품의 경우 수입자를 함께 표기</td>
													<td>상세설명 참조</td>
												</tr>
												<tr>
													<td>A/S 책임자와 전화번호, 소비자 상담관련 전화번호</td>
													<td>상세설명 참조</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="tab-cont ">
							<div class="section pdDinfo"">
								${ result.DLVREF_GUIDE}</br>
								<c:if test="${ empty result.DLVREF_GUIDE }">
									<p class="sit_empty">배송/환불 안내 정보가 없습니다.</p>
								</c:if>
									배송/환불 주소 정보<br/>
							 	<c:choose>
							 		<c:when test="${empty result.ADD_NUM }">
							 			<p class="sit_empty"> * 배송/환불 주소 정보가 없습니다. * </p>
							 		</c:when>
							 		<c:otherwise>
							 			<span class="com_info">( 우 : ${ tb_delivery_addr.COM_PN} ) </span> ${ tb_delivery_addr.COM_BADR} &nbsp;  ${ tb_delivery_addr.COM_DADR}
							 		</c:otherwise>
							 	</c:choose>
							</div>
						</div>
						<div class="tab-cont review">
							<p class="total">후기(${totalCnt}건)</p>
							<ul class="review-zone">
							<c:choose>
								<c:when test="${!empty(review.list)}">
									<c:forEach items="${review.list}" var="list" varStatus="loop">
									<c:if test="${!empty(list.ATFL_ID)}">
										<c:set var="imgPath" value="${contextPath}/common/commonImgFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=1&IMG_GUBUN=mainType1" />
									</c:if>
										<li>
											<div class="user-star mgb10">
												<span class="stars">
												<input type="hidden" id="STAR" name="STAR" value="${list.PD_PTS}">
												</span>
												<span class="star-count">${list.PD_PTS}.0</span> <span id="userName" class="user">${list.REGP_ID}</span>,
												<span>${list.REG_DTM}</span>
											</div>
											<div class="cmt">
												<!-- <p>제품 선택 : 알파 3연동 중문 ㅡ자형(1150~1500) / 1150~1300/고시형/망입유리</p> -->
												<div>${list.BRD_CONT}</div>
											</div>
											<div class="img">
												<img
													src="${imgPath}"
													width="100%">
											</div>
										</li>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<li>
										<div class="review-empty">
											<span>등록된 리뷰가 없습니다.</span>
										</div>
									</li>
								</c:otherwise>
							</c:choose>
							</ul>
							<ul class="review-paging-box">
							<!-- 페이징  -->
				           <paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
								<First><Previous><AllPageLink><Next><Last>
							</paging:PageFooter>        
				            <!-- 페이징 END -->
							</ul>
						</div>
						<div class="tab-cont ">
						  <div style="font-size: 18px; margin-bottom: 10px; font-weight:900">QnA(${QnaPage}건)</div>
						    <table class="qnaTable">
						        <colgroup>
						            <col width="10%">
						            <!-- <col width="10%"> -->
						            <col width="60%">
						            <col width="10%">
						            <col width="10%">
						        </colgroup>
						        <tr>
						            <th>답변상태</th>
						            <!-- <th>구분</th> -->
						            <th>내용</th>
						            <th>작성자</th>
						            <th>등록일</th>
						        </tr>
						       <c:forEach var="qnaList" items="${ resultQna }" varStatus="status">
						        <tr>
						            <c:if  test="${qnaList.QNA_REPLY == null }">
						            <td>답변대기</td>
						            </c:if>
						            <c:if  test="${qnaList.QNA_REPLY != null }">
						            <td>답변완료</td>
						            </c:if>
						            <%-- <td>${qnaList.BRD_GUBN }</td> --%>
						            <c:if test='${qnaList.SCWT_YN eq "N" || qnaList.WRTR_ID eq USER.MEMB_ID}'>
						            <td><a onclick="showQnaDetail(${status.index})">${qnaList.BRD_SBJT } </a></td>
						            </c:if>
						            <c:if test='${qnaList.SCWT_YN eq "Y" && qnaList.WRTR_ID ne USER.MEMB_ID}'>
						            <td><a onclick="secretAlert()" style="color:lightgray">비밀 글 입니다. </a></td>
						            </c:if>
						            <td>${qnaList.WRTR_ID }</td>
						            <td>${qnaList.WRT_DTM }</td>
						        </tr>
						       	<c:if test='${qnaList.SCWT_YN eq "N" || qnaList.WRTR_ID eq USER.MEMB_ID}'>
						        <tr id="qna${status.index}" style="display:none; border-top:1px solid lightgray;">
						        	<td class="qnaContent"colspan="4">
						        	<span>문의 내용 : </span>
						        	${qnaList.BRD_CONT} 
						        	<br><br>
						        	<span>&nbsp;ㄴ답변 내용 : </span>
						        	${qnaList.QNA_REPLY} 
						        	</td>
						        </tr>
						        </c:if>
						       
						        </c:forEach>
						    </table>
						    <div id="QnaPaging" style="text-align:center">
						        
						    </div>
						    <input type="text" id="BRD_SBJT" name="BRD_SBJT" placeholder="문의사항 제목을 입력하세요." style="width:500px"/>
						    <input type="password" id="BRD_PW" placeholder="비밀번호" style="float:right; width:100px" autocomplete="new-password" >
						    <textarea id="BRD_CONT" cols="104" rows="5" style="resize: none; margin-top:10px" placeholder="이곳에 문의 하실 내용을 입력 해 주세요."></textarea><br>
						    <button id="insertQna" onclick="insertQna()" style="background: lightgray;">문의하기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class='layer-popup confrim-type on' id="bascketPop" style="display:none; left: -280px;top: -120px;" >
			<div class='popup'>
				<button type='button' class='btn-pop-close popClose' onclick="closeBaskPop()" data-focus='pop' data-focus-prev='popBtn01'>X</button>
				<div class='pop-conts' style='padding: 60px 30px 45px 30px'>
					<div class='casa-msg'>장바구니에 상품을 담았습니다.</div>
				</div>
				<div class='pop-bottom-btn type02'>
					<button type='button' data-focus='popBtn01'	data-focus-next='popBtn02' onclick="closeBaskPop()" class='btn-back' style="background-color:#aaaaaa">계속쇼핑하기</button>
					<button type='button' data-focus='popBtn02' data-focus-next='pop' class='btn-pop-next'>장바구니가기</button>
				</div>
			</div>
		</div>
	</div>
</div>	









<script>
 //멤버 가격 모달
  var memberPrice = document.getElementById("MEMBER_PRICE");
  const open = () => {
    document.querySelector(".modal").classList.remove("hidden");
  }
  const close = () => {
    document.querySelector(".modal").classList.add("hidden");
  }
  if( memberPrice !=null ){
  	document.querySelector(".openBtn").addEventListener("click", open);
  	document.querySelector(".closeBtn").addEventListener("click", close);
  }
  //모달 END
  
  
	window.onload = function(){
		var qnaPage = ${QnaPage};
		var html = "";
		html += "<a href='/m/product/view/${result.PD_CODE}?qnaPage=1'><i class='ic start' ></i></a>";
		if(qnaPage != ""){
			for(var i =0; i<qnaPage;i++){
				html += "<a href='/m/product/view/${result.PD_CODE}?qnaPage="+(i+1)+"'style='font-size:13px; fontweight:500; color:black'><i class='page'>"+(i+1)+"</i></a>";
			}
		}
		html += "<a href='/m/product/view/${result.PD_CODE}?qnaPage="+qnaPage+"'><i class='end'></i></a>";
		$("#QnaPaging").html(html)
		
		if("${pagemove}" == "true"){
			$('.qna-tab').click()
			
			var location = document.querySelector('.tab-list').offsetTop;
			var url = "${contextPath}/m/product/view/${result.PD_CODE}"
			window.scrollTo({top:location})
			history.pushState(null, null, url);
		}
	}
	 
	function insertQna(){
		
		<c:if test="${empty USER.MEMB_ID}">
		alert("로그인이 필요합니다.");
		location.href = "${contextPath}/m/user/loginForm";
		return false;
		</c:if>
		
		
		
		
		var BRD_CONT = $("#BRD_CONT").val();
		var BRD_SBJT = $("#BRD_SBJT").val();
		var BRD_PW   = $("#BRD_PW").val()
		
		if(BRD_SBJT == '' || BRD_CONT == ''){
			alert("문의 내용을 입력 해 주세요.")
			return false;
		}
		
			$.ajax({
	    		type: "POST",
	    		url: '${contextPath}/m/product/insertQna',
	    		data: {
	    			"pdCode"   :'${ result.PD_CODE }',
	    			"brd_cont" : BRD_CONT,
	    			"brd_sbjt" : BRD_SBJT,
	    			"brd_pw"   : BRD_PW
	    		},
	    		success: function (data) {
	    			if(parseInt(data) > 0 ){
	    				alert("QnA문의가 정상적으로 접수 되었습니다.")
	    				location.href='/m/product/view/${result.PD_CODE}?qnaPage=1';
	    				
	    			}else{
	    				alert("QnA문의를 접수하는데 오류가 발생하였습니다.")
	    			}
	    		}, error: function (jqXHR, textStatus, errorThrown) {
	    			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
		    	}
			 });	
	}
	 function showQnaDetail(num){
		$("tr[id^='qna']").css('display','none'); 
		$("#qna"+num).css('display','table-row');  
	 };
	 
	 function secretAlert(){
		 alert("비밀 글은 작성자만 확인 할 수 있습니다.")
	 }
	 
  	//20200219
      var swiper = new Swiper('.swiper-container', {
      	navigation: {
        	nextEl: '.swiper-button-next',
        	prevEl: '.swiper-button-prev',
      	},
	  	slidesPerView: 5,
    	spaceBetween: 10
    });
  	
  $(document).on("click",".close",function(){
		$(this).parent('li').remove();
			
		if($('.prdOption').length == 0){ 
			$(".order-list ").html("");
		}
			calcTotalPrice();
    });
  	
  	$('#PD_OPTION_1').change(function(){
		var option1 = $("#PD_OPTION_1 option:selected").val();
   		var opName1 = $(".optionName")[0].textContent.replace(' 선택[필수]','');
  	// 하위 옵션 제거
  	if(document.getElementById('PD_OPTION_2') != null){
		$("#option2Select").html('')
		$("#option3Select").html('')
  	}
  		$.ajax({
    		type: "POST",
    		url: '${contextPath}/goods/optionSelect',
    		data: {
    			"optionValue1": $("#PD_OPTION_1 option:selected").text(),
    			"pdCode":'${ result.PD_CODE }'
    		},
    		success: function (data) {
    			if(data != ""){
    				var options = data.split('PRICE:')[0].split('#@');
    				var price = data.split('PRICE:')[1].split('#@');
    				
    				var appendHtml = '';
   					appendHtml +='<td>'+options[0]+'</td>'
					appendHtml +='<td>'
					appendHtml +='<select name="" id="PD_OPTION_2">'
					appendHtml +='<option class="optionName">'+options[0]+' 선택[필수]</option>'
					for(var i =1; i < options.length; i++){
						if(parseInt(price[i]) > 0 ){
							appendHtml +='<option value="'+options[i]+'">'+options[i]+' ( +'+price[i]+' )</option>'
						}else{
							appendHtml +='<option value="'+options[i]+'">'+options[i]+'</option>'
						}
					}				
					appendHtml +='</select>';
					for(var i =1; i < options.length; i++){
						if(parseInt(price[i]) > 0 ){
							appendHtml +='<input type="hidden" id="'+options[i]+'" value="'+price[i]+'"/>'
						}
					}	
					appendHtml +='</td>';
    				$('#option2Select').html(appendHtml);
    			}else{
    				//같은옵션 상품 있는지 확인 
					var chk = 0;
					if($("#PD_OPTION_1").val() != ''){
						
						for(var i =0;i<$('.prdOption').length;i++){
							console.log($('.prdOption')[i].value == option1)
							if($('.prdOption')[i].value == option1){
								$($('.prdOption')[i]).parent().find('.btnQty')[0].click()
								chk += 1;
							}
						}
					}
    				if($("#PD_OPTION_1").val() != '' && chk < 1){
    					
    					var priceExtra = 0
    					if(parseInt($("#"+option1).val())){
    						priceExtra = parseInt($("#"+option1).val())
    					}
		  				var memberPrice = parseInt(${ result.MEMBERS_PRICE }) + priceExtra;
    		  			var count = 0;
    		  			
    		  			for(i = 0; i<$(".order-list").children().length;i++){
    		  			    if($(".order-list").children()[i].children[1].textContent == $("#PD_OPTION_1").val()) count++;
    		  			} 
    		  		 	if(count<1){
    				  		$(".order-list").append('<li>'
    								+'<button class="close"></button>'
    								+'<p class="mgb10" id="mainProduct">${ result.PD_NAME }</p>'
    								+'<input class="prdOption" type="hidden" value="'+option1+'"/>'
    								+'<p class="option1" >'+opName1+' : '+ option1+'<p>'
    								+'<div class="tb">'
    								+	'<div>'
    								+		'<div class="counter">'
    								+			'<button class="btnQty">-</button>'
    								+			'<input class="optionQty" type="text" value="1" onkeyPress="calcTotalPrice()"></input>'
    								+			'<button class="btnQty">+</button>'
    								+		'</div>'
    								+	'</div>'
    								+	'<div class="right optionPrice">'
    								+		'<strong>'+memberPrice.toLocaleString()+'원</strong>'
    								+		'<input type="hidden" value="'+memberPrice+'"></input>'
    								+		'<input type="hidden" class="extraPrice" value="'+priceExtra+'"></input>'
    								+	'</div>'
    								+'</div>'
    								+'</li>');
    				  		calcTotalPrice();
    		  			} 
    		  		}
    			}
    		}, error: function (jqXHR, textStatus, errorThrown) {
    			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
	    	}
		 });
  	});
  	
  	$(document).on('change','#PD_OPTION_2',function(){
  		var option1 = $("#PD_OPTION_1 option:selected").val();
  		var option2 = $("#PD_OPTION_2 option:selected").val();
  		var opName1 = $(".optionName")[0].textContent.replace(' 선택[필수]','');
  		var opName2 = $(".optionName")[1].textContent.replace(' 선택[필수]','');
  		
  		$.ajax({
    		type: "POST",
    		url: '${contextPath}/goods/optionSelect',
    		data: {
    			"optionValue2": $("#PD_OPTION_2 option:selected").text(),
    			"optionValue1": $("#PD_OPTION_1 option:selected").text(),
    			"pdCode":'${ result.PD_CODE }',
    			"optionDeps":'3'
    		},
    		success: function (data) {
    			if(data != ""){
    				var options = data.split('PRICE:')[0].split('#@');
    				var price = data.split('PRICE:')[1].split('#@');
    				var appendHtml = '';
   					appendHtml +='<td>'+options[0]+'</td>'
					appendHtml +='<td>'
					appendHtml +='<select name="" id="PD_OPTION_3">'
					appendHtml +='<option class="optionName">'+options[0]+' 선택[필수]</option>'
					for(var i =1; i < options.length; i++){
						if(parseInt(price[i]) > 0 ){
							appendHtml +='<option value="'+options[i]+'">'+options[i]+'( +'+price[i]+' )</option>'
						}else{
							appendHtml +='<option value="'+options[i]+'">'+options[i]+'</option>'
						}
					}				
					appendHtml +='</select>';
					for(var i =1; i < options.length; i++){
						if(parseInt(price[i]) > 0 ){
							appendHtml +='<input type="hidden" id="'+options[i]+'" value="'+price[i]+'"/>'
						}
					}	
					appendHtml +='</td>';
    				$('#option3Select').html(appendHtml);
    				
    			}else{
    				if($('#'+option1+option2).length > 0){
    		  			$('#'+option1+option2).val(parseInt($('#'+option1+option2).val())+1)
    		  		}else if($("#PD_OPTION_2").val() != ''){
    		  			
    		  			var count = 0;
    		  			for(i = 0; i<$(".order-list").children().length;i++){
    		  			    if($(".order-list").children()[i].children[1].textContent == $("#PD_OPTION_1").val()) count++;
    		  			} 
    		  			if(count<1){
    		  				var priceExtra = 0
        					if(parseInt($("#"+option2).val())){
        						priceExtra = parseInt($("#"+option2).val())
        					}
    		  				var memberPrice = parseInt(${ result.MEMBERS_PRICE}) + priceExtra;
    		  				console.log("priceExtra : ",priceExtra)
    		  				console.log("memberPrice : ",memberPrice)
    		  			
    				  		$(".order-list").append('<li>'
    								+'<button class="close"></button>'
    								+'<p class="mgb10" id="mainProduct">${ result.PD_NAME }</p>'
    								+'<input class="prdOption" type="hidden" value="'+option1+"/"+option2+'"/>'
    								+'<p class="option1" >'+opName1+' : '+ option1+'<p>'
    								+'<p class="option2" >'+opName2+' : '+ option2+' (+'+priceExtra+')'+'<p>'
    								+'<div class="tb">'
    								+	'<div>'
    								+		'<div class="counter">'
    								+			'<button class="btnQty">-</button>'
    								+			'<input class="optionQty" id="'+option1+option2+'" type="text" value="1" onkeyPress="calcTotalPrice()"></input>'
    								+			'<button class="btnQty">+</button>'
    								+		'</div>'
    								+	'</div>'
    								+	'<div class="right optionPrice">'
    								+		'<strong>'+memberPrice.toLocaleString()+'원</strong>'
    								+		'<input type="hidden" value="'+memberPrice+'"></input>'
    								+		'<input type="hidden" class="extraPrice" value="'+priceExtra+'"></input>'
    								+	'</div>'
    								+'</div>'
    								+'</li>');
    				  		
    				  		calcTotalPrice();
    		  			} 
    				} 
    		  			// 하위 옵션 제거
    		  			$("#option2Select").html('')
    					$('#option3Select').html('');
    					// 최상위 옵션 초기화
    					$("#PD_OPTION_1").val('');
    			}
    		}, error: function (jqXHR, textStatus, errorThrown) {
    			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
    		}
	 	});
  	});
  		
  
  	$(document).on('change','#PD_OPTION_3',function(){
  		var option1 = $("#PD_OPTION_1 option:selected").val();
  		var option2 = $("#PD_OPTION_2 option:selected").val();
  		var option3 = $("#PD_OPTION_3 option:selected").val();
  		var opName1 = $(".optionName")[0].textContent.replace(' 선택[필수]','');
  		var opName2 = $(".optionName")[1].textContent.replace(' 선택[필수]','');
  		var opName3 = $(".optionName")[2].textContent.replace(' 선택[필수]','');
  		
  		if($('#'+option1+option2+option3).length > 0){
  			$('#'+option1+option2+option3).val(parseInt($('#'+option1+option2+option3).val())+1)
  		}else if($("#PD_OPTION_3").val() != ''){
  			
  			var count = 0;
  			for(i = 0; i<$(".order-list").children().length;i++){
  			    if($(".order-list").children()[i].children[1].textContent == $("#PD_OPTION_1").val()) count++;
  			} 
  			if(count<1){
  				var priceExtra = 0
				if(parseInt($("#"+option3).val())){
					priceExtra = parseInt($("#"+option3).val())
				}
  				var memberPrice = parseInt(${ result.MEMBERS_PRICE }) + priceExtra;
  				console.log("priceExtra : ",priceExtra)
  				console.log("memberPrice : ",memberPrice)
  				
		  		$(".order-list").append('<li>'
						+'<button class="close"></button>'
						+'<p class="mgb10" id="mainProduct">${ result.PD_NAME }</p>'
						+'<input class="prdOption" type="hidden" value="'+option1+"/"+option2+"/"+option3+'"/>'
						+'<p class="option1" >'+opName1+' : '+ option1+'<p>'
						+'<p class="option2" >'+opName2+' : '+ option2+'<p>'
						+'<p class="option3" >'+opName3+' : '+ option3+'<p>'
						+'<div class="tb">'
						+	'<div>'
						+		'<div class="counter">'
						+			'<button class="btnQty">-</button>'
						+			'<input class="optionQty" id="'+option1+option2+option3+'" type="text" value="1" onkeyPress="calcTotalPrice()"></input>'
						+			'<button class="btnQty">+</button>'
						+		'</div>'
						+	'</div>'
						+	'<div class="right optionPrice">'
						+		'<strong>'+memberPrice.toLocaleString()+'원</strong>'
						+		'<input type="hidden" value="'+memberPrice+'"></input>'
						+		'<input type="hidden" class="extraPrice" value="'+priceExtra+'"></input>'
						+	'</div>'
						+'</div>'
						+'</li>');
		  		calcTotalPrice();
  			} 
		} 
  			// 하위 옵션 제거
			$('#option2Select').html('');
			$('#option3Select').html('');
			// 최상위 옵션 초기화
			$("#PD_OPTION_1").val('');
  	});
  	
  	function calcTotalPrice(){
  		var totPrice = 0;
  		var onePricetxt = 0;
  		var dlvy_amt = $("#ORIGIN_DLVY_AMT");
		//var dlva_fcon = ${result.DLVA_FCON};
		
		//배송비 계산
		var sum = 0;
		var TOTAL_CNT = $("#TOTAL_CNT");
		var TOTAL_AMT = $("#TOTAL_AMT");
		var TOTAL_SHIP = $("#TOTAL_SHIP");
		
		//상품 개수 합산
		$('input.QTY').each(function(){ 
			if(!isNaN($(this).val())){ // CASE 값에 문자가 없는 경우 (숫자인 경우만 합산) 
				sum += parseInt($(this).val()); 
			}
		});
		//옵션 상품 개수 합산
		$('input.optionQty').each(function(){ 
			if(!isNaN($(this).val())){ // CASE 값에 문자가 없는 경우 (숫자인 경우만 합산) 
				sum += parseInt($(this).val()); 
			}
		});
		
		TOTAL_CNT.val(sum);
		
		
  		if($(".optionPrice").length >0){
  		
  			//상품의 옵션상품은 없고 추가상품이 있는경우 (2022.01장보라)
  			if($('#mainProduct').length==0 && $('#extrPrd').length>0){
  	  			//memberPrice1에서 숫자만추출
  	  			var pricetext=document.getElementById("memberPrice1").value;
  	  			pricetext=parseInt(pricetext.replace(/[^0-9]/g, ''));
  	  			totPrice = $('.QTY').val()*pricetext;
  	  		}
  			
  			for(var i =0; i < $(".optionPrice").length; i++ ){
	  			var priceTxt = $(".optionPrice")[i].textContent.trim().split('원')[0].split(',');
	  			onePricetxt = '';
	  			for(var j =0;j< priceTxt.length ; j++){
	  				 onePricetxt += priceTxt[j];
	  			}
	  				totPrice += parseInt(onePricetxt);
	  		}
	  		
	  		TOTAL_AMT.val(totPrice);
	  	//추가상품이 있을 경우 
  		}else{
	  		totPrice = $('.QTY').val()*parseInt($('.memberPrice1').val().replace(/,/g,'').replace('원',''));
	  		if($('.QTY').length < 1){
	  			totPrice =0;
	  		}
	  		TOTAL_AMT.val(totPrice);
	  	}
  		
		var SHIP_CONFIG = $(".SHIP_CONFIG").val();
		var DLVY_PRICE = $(".DLVY_PRICE").val();
		var length = $(".DLVY_PRICE").length;
		
		//기본, 개별, 템플릿
		//기본
		if(SHIP_CONFIG == "SHIP_CONFIG_01") {
			var GUBN_START = $(".GUBN_START").val();
			
			if(Number(TOTAL_AMT.val()) == Number(GUBN_START) || Number(TOTAL_AMT.val()) > Number(GUBN_START)) {
				TOTAL_SHIP.val(0);
				//console.log(TOTAL_SHIP.val());
				//console.log(1);
			} else {
				TOTAL_SHIP.val(DLVY_PRICE);
				//console.log(2);
			}
		//개별
		} else if(SHIP_CONFIG == "SHIP_CONFIG_02") {
			var SHIP_GUBN = $(".SHIP_GUBN").val();
			
			if(SHIP_GUBN == "SHIP_GUBN_01") {
				TOTAL_SHIP.val(0);
				//console.log(3);
			} else if(SHIP_GUBN == "SHIP_GUBN_02") {
				var GUBN_START = $(".GUBN_START").val();
				
				if(Number(TOTAL_AMT.val()) == Number(GUBN_START) || Number(TOTAL_AMT.val()) > Number(GUBN_START)) {
					TOTAL_SHIP.val(0);
					//console.log(4);
				} else {
					TOTAL_SHIP.val(DLVY_PRICE);
					//console.log(5);
				}
			} else if(SHIP_GUBN == "SHIP_GUBN_03") {
				for(var i = 0; i < length; i++) {
					if((Number($("#GUBN_START" + i).val()) < Number(TOTAL_AMT.val()) || Number($("#GUBN_START" + i).val()) == Number(TOTAL_AMT.val()))
					  && Number(TOTAL_AMT.val()) < Number($("#GUBN_END" + i).val())) {
						TOTAL_SHIP.val($("#DLVY_PRICE" + i).val());
						//console.log(6);
					}
				}
			} else {
				for(var i = 0; i < length; i++) {
					if((Number($("#GUBN_START" + i).val()) < Number(TOTAL_CNT.val()) || Number($("#GUBN_START" + i).val()) == Number(TOTAL_CNT.val()))
						&& Number(TOTAL_CNT.val()) < Number($("#GUBN_END" + i).val())) {
						TOTAL_SHIP.val($("#DLVY_PRICE" + i).val());
						//console.log(8);
					}
				}
			}
		//템플릿
		} else {
			var SHIP_GUBN = $(".SHIP_GUBN").val();
			
			if(SHIP_GUBN == "SHIP_GUBN_01") {
				TOTAL_SHIP.val(0);
				//console.log(10);
			} else if(SHIP_GUBN == "SHIP_GUBN_02") {
				var GUBN_START = $(".GUBN_START").val();
				
				if(Number(TOTAL_AMT.val()) == Number(GUBN_START) || Number(TOTAL_AMT.val()) > Number(GUBN_START)) {
					TOTAL_SHIP.val(0);
					//console.log(11);
				} else {
					TOTAL_SHIP.val(DLVY_PRICE);
					//console.log(12);
				}
			} else if(SHIP_GUBN == "SHIP_GUBN_03") {
				for(var i = 0; i < length; i++) {
					if((Number($("#GUBN_START" + i).val()) < Number(TOTAL_AMT.val()) || Number($("#GUBN_START" + i).val()) == Number(TOTAL_AMT.val()))
						&& Number(TOTAL_AMT.val()) < Number($("#GUBN_END" + i).val())) {
						TOTAL_SHIP.val($("#DLVY_PRICE" + i).val());
						//console.log(13);
					}
				}
			} else {
				TOTAL_SHIP.val(0);
				
				for(var i = 0; i < length; i++) {
					if((Number($("#GUBN_START" + i).val()) < Number(TOTAL_CNT.val()) || Number($("#GUBN_START" + i).val()) == Number(TOTAL_CNT.val()))
						&& Number(TOTAL_CNT.val()) < Number($("#GUBN_END" + i).val())) {
						TOTAL_SHIP.val($("#DLVY_PRICE" + i).val());
					}
				}
			}
		}
		//배송비 - 이유리
		var total_ship = $("#TOTAL_SHIP").val();
		$("#DLVY_AMT").val(total_ship);
  		
  		// 총상품금액 + 배송비
		if(totPrice != 0) {
			$('#sit_tot_price').text((Number(totPrice)+Number(total_ship)).toLocaleString()+'원');
		} else {
			$('#sit_tot_price').text(Number(totPrice).toLocaleString()+'원');
		}
  		console.log(totPrice);
  		console.log(total_ship);
  		
	}
  	
  	function closeBaskPop(){
  		$("#bascketPop").css('display','none');
  	}
  	
  	$('.btn-pop-next').click(function(){
  		location.href="${contextPath}/m/basket";	
  	})
  	
  	/* 댓글 관련 이벤트 - 이유리 */
  	$(function() {
  		/* 댓글유저 아이디 숨기기 */
  		var name = $("#userName").text();
  		var name1 = name.substring(0,4);
  		var nameNum = name.length - 4;
  		var replace = "";
  		for(var i = 0; i < nameNum; i++) {
  			replace += "*";
  		}
  		var newName = name1 + replace;
  		$("#userName").text(newName);
  		
  		/* 별점 매기기 */
  		var starNum = $("#STAR").val();
  		var star = "";
  		var nonstar = "";
  		for(var i = 0; i < starNum; i++) {
  			star += "<span class='star on'></span>";
  		}
  		for(var i = 0; i < 5-starNum; i++) {
  			nonstar += "<span class='star'></span>";
  		}
  		var allStar = star + nonstar;
  		
  		$(".stars").html(allStar);
  		
  		//배송비 계산
  		var totPrice = 0;
  		var onePricetxt = 0;
  		var dlvy_amt = $("#ORIGIN_DLVY_AMT");
		//var dlva_fcon = ${result.DLVA_FCON};
		
		var sum = 0;
		var TOTAL_CNT = $("#TOTAL_CNT");
		var TOTAL_AMT = $("#TOTAL_AMT");
		var TOTAL_SHIP = $("#TOTAL_SHIP");
		
		//상품 개수 합산
		$('input.QTY').each(function(){ 
			if(!isNaN($(this).val())){ // CASE 값에 문자가 없는 경우 (숫자인 경우만 합산) 
				sum += parseInt($(this).val()); 
			}
		});
		//옵션 상품 개수 합산
		$('input.optionQty').each(function(){ 
			if(!isNaN($(this).val())){ // CASE 값에 문자가 없는 경우 (숫자인 경우만 합산) 
				sum += parseInt($(this).val()); 
			}
		});
		
		TOTAL_CNT.val(sum);
		
		
  		if($(".optionPrice").length >0){
  			//상품의 옵션상품은 없고 추가상품이 있는경우 (2022.01장보라)
  			if($('#mainProduct').length==0 && $('#extrPrd').length>0){
  	  			//memberPrice1에서 숫자만추출
  	  			var pricetext=document.getElementById("memberPrice1").value;
  	  			pricetext=parseInt(pricetext.replace(/[^0-9]/g, ''));
  	  			totPrice = $('.QTY').val()*pricetext;
  	  		}
  			
  			for(var i =0; i < $(".optionPrice").length; i++ ){
	  			var priceTxt = $(".optionPrice")[i].textContent.trim().split('원')[0].split(',')
	  			onePricetxt = '';
	  			for(var j =0;j< priceTxt.length ; j++){
	  				 onePricetxt += priceTxt[j];
	  			}
	  				totPrice += parseInt(onePricetxt);
	  		}
	  		
	  		TOTAL_AMT.val(totPrice);
	  	//추가상품이 있을 경우 
  		}else{
	  		
	  		totPrice = $('.QTY').val()*parseInt($('.memberPrice1').val().replace(/,/g,'').replace('원',''));
	  		//console.log(totPrice);
	  		if($('.QTY').length  < 1){
	  			totPrice =0;
	  		}
	  		
	  		TOTAL_AMT.val(totPrice);
	  	}
  		
		var SHIP_CONFIG = $(".SHIP_CONFIG").val();
		var DLVY_PRICE = $(".DLVY_PRICE").val();
		var length = $(".DLVY_PRICE").length;
		
		//기본, 개별, 템플릿
		//기본
		if(SHIP_CONFIG == "SHIP_CONFIG_01") {
			var GUBN_START = $(".GUBN_START").val();
			
			if(Number(TOTAL_AMT.val()) == Number(GUBN_START) || Number(TOTAL_AMT.val()) > Number(GUBN_START)) {
				TOTAL_SHIP.val(0);
				//console.log(TOTAL_SHIP.val());
				//console.log(1);
			} else {
				TOTAL_SHIP.val(DLVY_PRICE);
				//console.log(2);
			}
		//개별
		} else if(SHIP_CONFIG == "SHIP_CONFIG_02") {
			var SHIP_GUBN = $(".SHIP_GUBN").val();
			
			if(SHIP_GUBN == "SHIP_GUBN_01") {
				TOTAL_SHIP.val(0);
				//console.log(3);
			} else if(SHIP_GUBN == "SHIP_GUBN_02") {
				var GUBN_START = $(".GUBN_START").val();
				
				if(Number(TOTAL_AMT.val()) == Number(GUBN_START) || Number(TOTAL_AMT.val()) > Number(GUBN_START)) {
					TOTAL_SHIP.val(0);
					//console.log(4);
				} else {
					TOTAL_SHIP.val(DLVY_PRICE);
					//console.log(5);
				}
			} else if(SHIP_GUBN == "SHIP_GUBN_03") {
				for(var i = 0; i < length; i++) {
					if((Number($("#GUBN_START" + i).val()) < Number(TOTAL_AMT.val()) || Number($("#GUBN_START" + i).val()) == Number(TOTAL_AMT.val()))
					  && Number(TOTAL_AMT.val()) < Number($("#GUBN_END" + i).val())) {
						TOTAL_SHIP.val($("#DLVY_PRICE" + i).val());
						//console.log(6);
					}
				}
			} else {
				for(var i = 0; i < length; i++) {
					if((Number($("#GUBN_START" + i).val()) < Number(TOTAL_CNT.val()) || Number($("#GUBN_START" + i).val()) == Number(TOTAL_CNT.val()))
						&& Number(TOTAL_CNT.val()) < Number($("#GUBN_END" + i).val())) {
						TOTAL_SHIP.val($("#DLVY_PRICE" + i).val());
						//console.log(8);
					}
				}
			}
		//템플릿
		} else {
			var SHIP_GUBN = $(".SHIP_GUBN").val();
			
			if(SHIP_GUBN == "SHIP_GUBN_01") {
				TOTAL_SHIP.val(0);
				//console.log(10);
			} else if(SHIP_GUBN == "SHIP_GUBN_02") {
				var GUBN_START = $(".GUBN_START").val();
				
				if(Number(TOTAL_AMT.val()) == Number(GUBN_START) || Number(TOTAL_AMT.val()) > Number(GUBN_START)) {
					TOTAL_SHIP.val(0);
					//console.log(11);
				} else {
					TOTAL_SHIP.val(DLVY_PRICE);
					//console.log(12);
				}
			} else if(SHIP_GUBN == "SHIP_GUBN_03") {
				for(var i = 0; i < length; i++) {
					if((Number($("#GUBN_START" + i).val()) < Number(TOTAL_AMT.val()) || Number($("#GUBN_START" + i).val()) == Number(TOTAL_AMT.val()))
						&& Number(TOTAL_AMT.val()) < Number($("#GUBN_END" + i).val())) {
						TOTAL_SHIP.val($("#DLVY_PRICE" + i).val());
						//console.log(13);
					}
				}
			} else {
				TOTAL_SHIP.val(0);
				
				for(var i = 0; i < length; i++) {
					if((Number($("#GUBN_START" + i).val()) < Number(TOTAL_CNT.val()) || Number($("#GUBN_START" + i).val()) == Number(TOTAL_CNT.val()))
						&& Number(TOTAL_CNT.val()) < Number($("#GUBN_END" + i).val())) {
						TOTAL_SHIP.val($("#DLVY_PRICE" + i).val());
					}
				}
			}
		}
		//배송비 - 이유리
		var total_ship = $("#TOTAL_SHIP").val();
		$("#DLVY_AMT").val(total_ship);
		
		if(totPrice != 0) {
			// 총상품금액 + 배송비
			$('#sit_tot_price').text((Number(totPrice)+Number(total_ship)).toLocaleString()+'원');
		} else {
			$('#sit_tot_price').text(Number(totPrice).toLocaleString()+'원');
		}
  	});
  	
  	
  	
  	
  	//추가상품
  	$('#extrPrd').change(function(){
  		//옵션이 있는데 추가상품을 먼저 선택할경우(2022.01장보라)
		if($("#PD_OPTION_1").length >0){
		  	if($('#mainProduct').length < 1){
		 	 	alert("상품옵션을 먼저 선택해주세요");
			 	// 셀렉트 박스 초기화
			  	$("#extrPrd").val('');
			  	var chk =0;
				for(var i =0;i<$('.prdExtra').length;i++){
				 	console.log($('.prdExtra')[i].value == extrPrdName)
				 	if($('.prdExtra')[i].value == extrPrdName){
				 		$($('.prdExtra')[i]).parent().find('.btnQty')[0].click()
				 		chk += 1;
				 	}
				}
		  		return false;
	  		}
	  	}
  		//추가상품정보(2022.01장보라)
		var extrPrd = $("#extrPrd option:selected").val(); 
		var extrPrdCode = $("input[name='"+extrPrd+"Code']").val(); //추가상품코드
		var extrPrdPrice = $("input[name='"+extrPrd+"Price']").val(); //추가상품가격
		var extrPrdName = $("input[name='"+extrPrd+"Name']").val() //추가상품이름
		var memberPrice = extrPrdPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");

		// 셀렉트 박스 초기화
		$("#extrPrd").val('')
		var chk =0;
		for(var i =0;i<$('.prdExtra').length;i++){
			console.log($('.prdExtra')[i].value == extrPrdName)
			if($('.prdExtra')[i].value == extrPrdName){
				$($('.prdExtra')[i]).parent().find('.btnQty')[0].click()
				chk += 1;
			}
		}
  		
  			if(chk < 1){
		  		$(".order-list").append('<li>'
					+'<button class="close"></button>'
					+'<p class="mgb10">추가 상품</p>'
					+'<input class="prdExtra" type="hidden" value="'+extrPrdName+'"/>'
					+'<p class="option1" >'+extrPrdName+'<p>'
					+'<div class="tb">'
					+	'<div>'
					+		'<div class="counter">'
					+			'<button class="btnQty">-</button>'
					+			'<input class="extraPdQty" type="text" value="1" onkeyPress="calcTotalPrice()"></input>'
					+			'<button class="btnQty">+</button>'
					+		'</div>'
					+	'</div>'
					+	'<div class="right optionPrice">'
					+		'<strong>'+memberPrice+'원</strong>'
					+		'<input type="hidden" class="extraPrice" value="'+extrPrdPrice+'"></input>'
					+		'<input type="hidden" class="extraPdCode" value="'+extrPrdCode+'"></input>'
					+	'</div>'
					+'</div>'
					+'</li>');
  			}
		  		calcTotalPrice();
  	});
  </script>
</body>

