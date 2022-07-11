<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<c:set var="strActionUrl" value="${contextPath }/m/wishList" />
<c:set var="strMethod" value="post" />

<script type="text/javascript">
	$(function() {
		/* 견적서 */
		$('.btnEste').click(function(){
			//체크박스
			var checkboxValues = [];
			
			//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
			$("input:checkbox[name=CHK_BSKT]:checked").each(function(){
			 	checkboxValues.push($(this).val());
			});
			
			if(checkboxValues.length < 1){
				checkboxValues.push("");			
				alert("견적서를 생성할 상품을 선택해주세요.");
				return;
			}
			console.log(checkboxValues);
			$('#checkArray').val(checkboxValues);
			$('#esteFrm').submit();
		});
		
		/* 이미지 에러 */
		$(document).on("blur", "#PD_QTY", function() {//뭐지
			price_calculate();
		});
		
		/* 수량체크 */
		$(document).on("change", "#PD_QTY", function() {
			var $el_qty = $(this).closest("td").find("input[name^=PD_QTY]");	
			var stock = $(this).closest("td").find("input[name^=INVEN_QTY]").val();
			var limit = $(this).closest("td").find("input[name^=LIMIT_QTY]").val();
			var this_qty, min_qty = 1, max_qty = (limit > 0) ? max_qty = parseInt(limit) : max_qty = 999;
			this_qty = parseInt($el_qty.val().replace(/[^0-9]/, ""));
		    
			if(this_qty > stock) {
				alert("재고수량 보다 많은 수량을 구매할 수 없습니다.");
				this_qty = stock;
				$el_qty.val(this_qty);
				return;
			}		   
			if(this_qty > max_qty) {
				this_qty = max_qty;
				alert("최대 구매수량은 "+number_format(String(max_qty))+" 입니다.");
				$el_qty.val(this_qty);
				return;
			}		
			if(this_qty < min_qty) {
				this_qty = min_qty;
				alert("최소 구매수량은 "+number_format(String(min_qty))+" 입니다.");
				$el_qty.val(this_qty);
				return;
			}		  
					   
			price_calculate2($(this));
		});
		
		/* 수량변경 */
		$('.btnQty').click(function(){
		    var mode = $(this).text();		    
		    var $el_qty = $(this).closest("div").find("input[name^=PD_QTY]");	
		    var prdPrice = $(this).closest("div").find("input[name^=prdPrice]");
		    var priceSum = 	$(this).closest("div").siblings("div[name^=price_sum]");
		    var stock = $(this).closest("td").find("input[name^=INVEN_QTY]").val();
		    var limit = $(this).closest("td").find("input[name^=LIMIT_QTY]").val();
		    var prdCode= $(this).closest("li").find("input[name^=PD_CODE]").val();
		    var setPrdCode= $(this).closest("li").find("input[name^=SETPD_CODE]").val();
		    var totalCost = $(".prdtsPrice").text().replaceAll(',','').replace('원','')*1
		   
		    var this_qty, min_qty = 1, max_qty = (limit > 0) ? max_qty = parseInt(limit) : max_qty = 999;
		    this_qty = parseInt($el_qty.val().replace(/[^0-9]/, ""));
		   
		    
		    
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
		          	
		          	priceSum.text((parseInt(prdPrice.val())*parseInt($el_qty.val())).toLocaleString() + '원');
		          	
		          	var $el_bkno = $(this).closest('div').closest('li').find("input[name^=BSKT_REGNO]");
		          	var pd_qty = 0;
		          	
		          	if(pd_qty = $(this).closest('div').find('input[name^=PD_QTY]') != null){
			          	pd_qty = $(this).closest('div').find('input[name^=PD_QTY]')
		          		
		          	}
		          
		          	$.ajax({
		    			type: 'GET',
		    		    dataType: 'json',
		    		    data: { "CHK_BSKT": $el_bkno.val() , "PD_QTY": pd_qty.val(), "PD_CODE": prdCode, "SETPD_CODE": setPrdCode },
		    		    url: '${contextPath }/m/basket/qtyUpdate.json',
		    		    success: function (data) {
		    		    	$('.devy_total').text(data.toLocaleString()+"원");
		    		    	calTotPrice();
		    		    },
		    		    error:function(request,status,error){
		    		         console.log('error : '+error+"\n"+"code : "+request.status+"\n");
		    		    }
		    		});
		          	
		            //price_calculate2($(this));		            
		            break;
	
		        case "-":
		            this_qty = parseInt($el_qty.val().replace(/[^0-9]/, "")) - 1;
		            
		            if(this_qty < min_qty) {
		                this_qty = min_qty;
		                alert("최소 구매수량은 "+number_format(String(min_qty))+" 입니다.");
		            }
		            $el_qty.val(this_qty);
		            
		            priceSum.text((parseInt(prdPrice.val())*parseInt($el_qty.val())).toLocaleString() + '원');

		            //price_calculate2($(this));	
		            
		            var $el_bkno = $(this).closest('div').closest('li').find("input[name^=BSKT_REGNO]");
		          	var pd_qty = 0;
		          	
		          	if(pd_qty = $(this).closest('div').find('input[name^=PD_QTY]') != null){
			          	pd_qty = $(this).closest('div').find('input[name^=PD_QTY]')
		          		
		          	}
		          
		          	$.ajax({
		    			type: 'GET',
		    		    dataType: 'json',
		    		    data: { "CHK_BSKT": $el_bkno.val() , "PD_QTY": pd_qty.val(), "PD_CODE": prdCode, "SETPD_CODE": setPrdCode },
		    		    url: '${contextPath }/m/basket/qtyUpdate.json',
		    		    success: function (data) {
		    		    	$('.devy_total').text(data.toLocaleString()+"원");
		    		    	calTotPrice();
		    		    },
		    		    error:function(request,status,error){
		    		         console.log('error : '+error+"\n"+"code : "+request.status+"\n");
		    		    }
		    		});
		          	
		            break;
	
		        default:
		            alert("올바른 방법으로 이용해 주십시오.");
		            break;
			}
		});
		
		/* 전체선택 체크박스 */
		$("#CHK_ALL").click(function(){ 
			//만약 전체 선택 체크박스가 체크된 상태일 경우 
			if($("#CHK_ALL").prop("checked")) { 
				//해당화면에 전체 checkbox들을 체크해준다 
				$("input[type=checkbox]").prop("checked",true); 
			// 전체선택 체크박스가 해제된 경우 
			} else { 
				//해당화면에 모든 checkbox들의 체크를해제시킨다. 
				$("input[type=checkbox]").prop("checked",false); 
			}
			price_calculate();		// 금액 재계산
		}); 
	
		 //기본상태 전체체크
		$("input[type=checkbox]").prop("checked",true);
		price_calculate(); 
	});
		
	/* 총계 계산 */
	function price_calculate() {		
		//체크박스
		var checkboxValues = [];
		
		//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
		$("input:checkbox[name=CHK_BSKT]:checked").each(function(){
		 	checkboxValues.push($(this).val());
		});
		if(checkboxValues=='' || checkboxValues==null){
		 	checkboxValues.push("");
		}
		
		var $pv = ${PV}																					// 아자몰 pv 적립율
		var pvn = 10;																					// 원단위 절삭
		var alltotal = 0;																				// 총합계 (상품합계 + 배송비)
		var pvtotal = 0;																				// PV합계
		var total = 0;																					// 상품합계
		var chkBox = $("input:checkbox[name=CHK_BSKT]");
		
		$("input[name^=price_sum]").each(function (i) {
			//체크항목만 총 상품금액에 추가
			if(chkBox.eq(i).is(":checked")==true){
				total += parseInt($('input[name^=price_sum]').eq(i).val().replace(/,/g,""));
				//pvtotal += parseInt($('input[name^=pv_sum]').eq(i).val().replace(/,/g,""));
			}	        
	    });

		var dlvyAmt = parseInt(${supplierInfo.DLVY_AMT});						//배송비
		var dlva_fcon = parseInt(${supplierInfo.DLVA_FCON});					//무료배송금액
		
		$('#total').html(number_format(String(total)));
		
		dlvyAmt = (total == 0 ? 0 : dlvyAmt);
		alltotal = parseInt(total)+parseInt(dlvyAmt);
		
		//
		var pvtotal = Math.floor((parseInt(total) * $pv) / pvn) * pvn;
		$('#pv_total').html(number_format(String(pvtotal)));
		
		if(total >= dlva_fcon || total == 0){
			$('#devy_amt').html(number_format('0'))
			$('#sum_total').html(number_format(String(total)));
		}else{
			$('#devy_amt').html(number_format(String(dlvyAmt)))
			$('#sum_total').html(number_format(String(alltotal)));
		}	
	}
	
	/* 상품 소계 계산*/
	function price_calculate2(obj) {
		var $pv = ${PV}																				// 아자몰 pv 적립율
		var $el_bkno = obj.closest("td").find("input[name^=BSKT_REGNO]"); 	// 장바구니 NO	
		var $el_prc = obj.closest("td").find("input[name^=PD_PRICE]");			// 판매가 node (REAL_PRICE)
		var $el_ps = obj.closest("td").find("input[name^=price_sum]");			// 소계 node	
		var $check = obj.closest("td").find("#PD_QTY option:selected");			// 선택수량 node
		//var $el_pv = obj.closest("td").find("input[name^=pv_sum]");				// pv소계 node	
		var $el_pq = "";																				// 수량 node
		var pd_qty = 0;																				// 입력수량
		var pvn = 10;
		 
		/* 선택수량 */
		
		if($check.text() != null && $check.text() != ""){
			// 선택수량
			$el_pq = obj.closest("td").find("#PD_QTY option:selected");
			pd_qty = $el_pq.text();
			
			var subtotal = $el_pq.text() * $el_prc.val();
			$el_ps.val(subtotal);
			$el_ps.parent().parent().find('td[name^=price_sum22]').html(number_format(String(subtotal)));
			
			/* 
			// PV 상품별 소계 
			var pvone = Math.floor(($el_prc.val() * $pv) / pvn) * pvn;
			var pvtotal = parseInt(pvone * $el_pq.text());
			$el_pv.val(pvtotal);
			$el_pv.parent().parent().find('td[name^=pv]').html(number_format(String(pvtotal)));
			*/			
		}else{
			// 기본수량
			$el_pq = obj.closest("td").find("input[name^=PD_QTY]");			//수량 node
			pd_qty = $el_pq.val();
			
			var subtotal = $el_pq.val()*$el_prc.val();
			$el_ps.val(subtotal);
			$el_ps.parent().parent().find('td[name^=price_sum22]').html(number_format(String(subtotal)));
			
		
		}
		 
		
		//장바구니 수량 데이터 업데이트
		$.ajax({
			type: 'GET',
		    dataType: 'json',
		    data: { "CHK_BSKT": $el_bkno.val() , "PD_QTY": pd_qty },
		    url: '${contextPath }/m/basket/qtyUpdate.json',
		    success: function (data) {
		    	
		    },
		    error:function(request,status,error){
		         console.log('error : '+error+"\n"+"code : "+request.status+"\n");
		    }
		});
		
		price_calculate();
	}
	
	/* 전체 체크 및 해제 시 */
	function fn_all_chk(){
		var check_yn = false;		
		if($("#CHK_ALL").is(":checked")){
			check_yn = true;
		}
		for(var i=1;i<= ${fn:length(obj.list) };i++){
			$("#CHK"+i).prop("checked",check_yn);
		}
	}
	
	/* 일괄 상태 변경 */
	function fn_state(state_chk){
		if(state_chk=="DELETE_ALL"){
// 			$("#CHK_ALL").prop("checked",true);
			fn_all_chk();
		}
	
		var cnt = 0;
		var bskt_regno_list = "";
		
		for(var i=1;i<= ${fn:length(obj.list) };i++){
			if($("#CHK"+i).is(":checked")){
				cnt++;
				if(bskt_regno_list != "") {
					bskt_regno_list+="$";
				}
				bskt_regno_list+=$("#CHK"+i).val();
			}
		}
		
		if(cnt == 0){
			alert("체크한 항목이 없습니다.");
			return;
		}
		
		var str = "";
		if(state_chk == "MOVE"){
			str = "해당 상품을 관심상품으로 이동 하시겠습니까?";
		}else if(state_chk == "DELETE"){
			str = "해당 상품을 장바구니에서 삭제 하시겠습니까?";
		}else if(state_chk == "DELETE_ALL"){
			str = "장바구니를 지우시겠습니까?";
		}
		
		if(!confirm(str)){
			if(state_chk == "DELETE_ALL"){
				$("#CHK_ALL").prop("checked",false);			
				for(var i=1;i<= ${fn:length(obj.list) };i++){
					$("#CHK"+i).prop("checked",false);
				}
			}
			return;
		}
		
		if(state_chk == "DELETE_ALL"){
			state_chk="DELETE";
		}
		
		var frm=document.getElementById("orderFrm");
		frm.BSKT_REGNO_LIST.value=bskt_regno_list;
		
		if(state_chk == "MOVE"){
			frm.action = "${contextPath }/m/basket/multi";
		}else if(state_chk == "DELETE"){
			frm.action = "${contextPath }/m/basket/delete/multi";
		}
		
		frm.STATE_GUBUN.value=state_chk;
		frm.submit();
	}
	
	/* 관심상품으로 이동 */
	function fn_change(bskt_regno){
		if(!confirm("해당 상품을 관심상품으로 이동 하시겠습니까?")) return;
		var frm=document.getElementById("orderFrm");
		frm.BSKT_REGNO.value=bskt_regno;
		frm.action = "${contextPath }/m/basket/"+bskt_regno;		
		frm.submit();
	}
	
	/* 삭제 */
	function fn_delete(bskt_regno){
		if(!confirm("해당 상품을 장바구니에서 삭제 하시겠습니까?")) return;
		var frm=document.getElementById("orderFrm");
		frm.BSKT_REGNO.value=bskt_regno;
		frm.action = "${contextPath }/m/basket/delete/"+bskt_regno;
		frm.submit();
	}
	
	/* 주문하기 */
	function fn_indentation(){		
		var cnt = 0;		
		var bskt_regno_list = "";
		var pd_cut_list = "";
		var pd_option_list = "";
		
		for(var i=1;i<= ${fn:length(obj.list) };i++){
			if($("#CHK"+i).is(":checked")){
				cnt++;
				
				pd_cut_list+=$("#CUT"+i).val();
				pd_cut_list+="@@!";
				pd_option_list+=$("#OPTION"+i).val();
				pd_option_list+="@@#";
				
				if(bskt_regno_list != "") {
					bskt_regno_list+="$";
				}
				bskt_regno_list+=$("#CHK"+i).val();		
			}
		}
		
		$("#DLVY_AMT").val($('.devy_total').text().replaceAll(',','').replace('원','')*1)
		
		if(cnt == 0){
			alert("체크한 항목이 없습니다.");
			return;
		}
		
		var frm=document.getElementById("orderFrm");
		frm.BSKT_REGNO_LIST.value=bskt_regno_list;
		frm.PD_CUT_SEQ_LIST.value=pd_cut_list;
		frm.OPTION_CODE_LIST.value=pd_option_list;
		frm.action = "${contextPath }/m/order/new";
		frm.submit();
	}
</script>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/reset.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/common.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/211021.css">
	<script type="text/javascript" src="${contextPath}/resources/resources2/js/common.js"></script>
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<div class="wrapper">
	
      
	<div class="container">
		
		<div class="page-mycart">
			<div class="titbox">
				<div class="tit">장바구니</div>
				<div class="step">
					<ul>
						<li class="step1 on"><i class="ic"></i><span>장바구니</span></li>
						<li class="step2"><i class="ic"></i><span>주문결제</span></li>
						<li class="step3"><i class="ic"></i><span>결제완료</span></li>
					</ul>
				</div>
			</div>
			<div class="cntbox">
				<div class="goods">
					<div class="tool">
						<div class="allchk"><input type="checkbox" id="CHK_ALL" ><label for="CHK_ALL">전체 선택</label></div>
						<div class="alldel"><a href="#" onclick="delChekedPd()">선택삭제</a></div>
					</div>
					<div class="list">
						<ul>
							
							<!-- 원래소스   -->
							<c:forEach items="${obj.list }" var="list" varStatus="loop">
								<li>
								<c:if test="${list.SALE_CON eq 'SALE_CON_01' or list.DEL_YN eq 'N' }">
									<div class="chk"><input type="checkbox" id="CHK${loop.count }" name="CHK_BSKT" value="${list.BSKT_REGNO }" onclick="price_calculate()"/><label for="CHK${loop.count }"><i class="ic"></i></label></div> 
									<input type="hidden" id="CUT${loop.count }" name="CHK_CUT" value="${ list.PD_CUT_SEQ}" />
									<input type="hidden" id="OPTION${loop.count }" name="CHK_OPTION" value="${ list.OPTION_CODE}" />
								</c:if>
								<c:if test="${list.SALE_CON ne 'SALE_CON_01' and list.DEL_YN ne 'N' }">
									<input type="hidden" id="CUT${loop.count }" name="CHK_CUT" value="${ list.PD_CUT_SEQ}" />
									<input type="hidden" id="OPTION${loop.count }" name="CHK_OPTION" value="${ list.OPTION_CODE}" />
								</c:if> 
							
								<input type="hidden" name="PD_CODE" value="${list.PD_CODE }">
								<input type="hidden" name="SETPD_CODE" value="${list.SETPD_CODE }">
								<c:if test="${ list.PD_CUT_SEQ ne null }"><br>(세절방식 : ${ list.PD_CUT_SEQ})</c:if>
								<c:if test="${ list.OPTION_CODE ne null }"><br>(색상 : ${ list.OPTION_CODE})</c:if>
								<br>
								<c:if test="${ !empty(list.ATFL_ID) }" >
									<c:if test="${list.FILEPATH_FLAG eq mainKey }">													
										<c:set var="imgPath" value="${contextPath }/upload/${list.STFL_PATH }/${list.STFL_NAME }" />
									</c:if>
									<c:if test="${!empty(list.FILEPATH_FLAG) && list.FILEPATH_FLAG ne mainKey }">
										<c:set var="imgPath" value="${list.STFL_PATH }" />
									</c:if>
									<c:if test="${ empty(list.FILEPATH_FLAG) }">
										<c:set var="imgPath" value="https://www.cjfls.co.kr/upload/${list.STFL_PATH }/${list.STFL_NAME }" />
									</c:if>
								</c:if>
								<div class="img">
                  					<c:if test='${empty list.IMGURL}'>
										<c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=${list.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
										<img src="${imgPath }" alt="">
									</c:if>
									<c:if test='${!empty list.IMGURL }'>
										<img src="${list.IMGURL }" alt="">
									</c:if>
							    </div>
								<div class="con">
									<strong>
										<c:if test="${list.EXTRA_YN eq 'Y'}">
											[추가상품]<br/>
										</c:if>
										<a href="${contextPath }/m/product/view/${list.PD_CODE }">${list.PD_NAME }</a>
									</strong>
									<span>
										<c:if test="${!empty list.OPTION1_VALUE }">
											${list.OPTION1_NAME } : ${list.OPTION1_VALUE }
										</c:if>
										<c:if test="${!empty list.OPTION2_VALUE }">
											/ ${list.OPTION2_NAME } : ${list.OPTION2_VALUE }
										</c:if>
										<c:if test="${!empty list.OPTION3_VALUE }">
											/ ${list.OPTION3_NAME } : ${list.OPTION3_VALUE }
										</c:if>
									</span>
								</div>
								<c:if test="${ list.DEL_YN eq 'N'   }">
								<c:if test='${list.QNT_LIMT_USE eq "Y" }'>
									<span style="width: 40px;height: 100%;min-width: 30px;">
										<jsp:include page="${contextPath}/common/comCodForm/">
											<jsp:param name="COMM_CODE" value="QNT_LIMT" />
											<jsp:param name="name" value="PD_QTY" />
											<jsp:param name="value" value="${list.LIMT_PD_QTY }" />
											<jsp:param name="type" value="select" />
											<jsp:param name="top" value="" />
										</jsp:include>
									</span>
								</c:if>
								<c:if test = '${list.QNT_LIMT_USE eq null or list.QNT_LIMT_USE eq "N" }'>
									<div class="num">
										<button type="button" data-toggle="tooltip" class="numDown btnQty"><i class="ic"></i><span style="display:none">-</span></button>
										<input type="text" name="PD_QTY" id="PD_QTY" class="number" value="${list.PD_QTY }">
										<input type="hidden" name="prdPrice" value="${list.PD_PRICE  }"/>
										<button type="button" data-toggle="tooltip" class="numUp btnQty"><i class="ic"></i><span style="display:none">+</span></button>
									</div>
									<!--
									 <div class="num" style="width:70px;">
										<input type="text" name="PD_QTY" id="PD_QTY" class="number" value="${list.PD_QTY }" disabled>
										<input type="hidden" name="prdPrice" value="${list.PD_PRICE  }"/>
									</div>
									-->
								</c:if>
								</c:if>
								<c:if test="${ list.DEL_YN ne 'N' }">
									판매하지<br>않는 상품
								</c:if>
								<c:if test="${ list.DEL_YN eq 'N' }">
									<!-- 박스할인율 적용  -->
									<c:set var="boxsaleval" value="0" />
									<input type="hidden" name="BSKT_REGNO" value="${list.BSKT_REGNO }">
									<input type="hidden" name="PD_PRICE" value="${list.PD_PRICE }">
									<input type="hidden" name="INVEN_QTY" value="${list.INVEN_QTY }">
									<input type="hidden" name="LIMIT_QTY" value="${list.LIMIT_QTY }">
									<input type="hidden" class="${list.SUPR_ID }DF" name="DLVY_FCON" value="${list.DLVA_FCON }">
									<input type="hidden" name="SUPR_IDS" value="${list.SUPR_ID }" />
									<!-- 박스할인율 적용  -->
									<input type="hidden" name="INPUT_CNT" value="${list.INPUT_CNT }">
									<input type="hidden" name="BOX_PDDC_VAL" value="${list.BOX_PDDC_VAL}">
									<input type="hidden" name="BOX_PDDC_GUBN" value="${list.BOX_PDDC_GUBN}">
									<!-- 계산용 -->
									<input type="hidden" name="price_sum" value="${(list.PD_PRICE * list.PD_QTY) - boxsaleval }">
									<fmt:parseNumber var="pv_round" value="${ (list.PD_PRICE * PV) / 10 }" integerOnly="true" />
									<input type="hidden" name="pv_sum" value="${ (pv_round * 10) * list.PD_QTY }">
									
								</c:if>
						
								<div class="cost ${list.SUPR_ID }" name="price_sum22">
									<fmt:formatNumber value="${(list.PD_PRICE * list.PD_QTY) }" />원
								</div>
								
								<div class="delete"><a href="javascript:fn_delete('${list.BSKT_REGNO }');"><i class="ic"></i></a></div>
							</li>		
						</c:forEach>
						</ul>
					</div>
					<div class="price">
						<span>상품금액 0원</span>
						<i class="ic ic-plus"></i>
						<span>배송비 <fmt:formatNumber value="${ tb_pdshipxm.DLVY_AMT }" />원</span>
						<i class="ic ic-sum"></i>
						<span>주문금액 &nbsp;</span>
						<strong> 0</strong><span>원</span>
					</div>
				</div>
				<div class="total">
					<div class="box" style="  min-height: 110%;">
						<div class="tit">전체 합계</div>
						<div class="txt">
							<dl><dt>상품수</dt><dd class="totalCnt">0<em>개</em></dd></dl>
							<dl><dt>상품금액</dt><dd class="prdtsPrice"><em></em></dd></dl>
							<dl><dt>배송비</dt><dd class="devy_total"><fmt:formatNumber value="${ tb_pdshipxm.DLVY_AMT }" /><em>원</em></dd></dl>
							<dl class="sum"><dt>전체 주문금액</dt><dd><em></em></dd></dl>
						</div>
						<div class="act">
							<a href="javascript:fn_indentation();" class="btn btn-sm pull-right btn-primary">구매하기</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
  </div> <!-- wrapper -->

<spform:form class="form-horizontal" name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }">
	<input type="hidden" id="BSKT_REGNO_LIST" name="BSKT_REGNO_LIST" value="" />	<!-- 상태 변경 체크 항목 -->
	<input type="hidden" id="BSKT_REGNO" name="BSKT_REGNO" value="" />				<!-- 선택 장바구니 등록번호-->
	<input type="hidden" id="STATE_GUBUN" name="STATE_GUBUN" value="" />			<!-- 상태변경 구분 - 장바구니이동인지 삭제인지 -->
	<input type="hidden" id="PD_CUT_SEQ_LIST" name="PD_CUT_SEQ_LIST" value="" />	<!-- 세절방식 -->
	<input type="hidden" id="OPTION_CODE_LIST" name="OPTION_CODE_LIST" value="" />	<!-- 옵션 -->
	<input type="hidden" id="DLVY_AMT" name="DLVY_AMT" value="" />	<!-- 옵션 -->
	
</spform:form>

<!-- 견적서 출력 -->
<form name="esteFrm" id="esteFrm" method="post" action="${contextPath }/m/basket/estimate" target="_blank">
	<input type="hidden" id="checkArray" name="checkArray" value="" />
	<input type="hidden" name="SUPR_ID" value="C00001" />
</form>

<script>


$(document).ready(function(){
	$("input:checkbox[name=CHK_BSKT]").change(function(){
		var chklength=$("input:checkbox[name=CHK_BSKT]:checked").length; //선택된 상품의 length
		var AddPrice=new Array();
		for(var i=0; i<chklength;i++){
			if($(this).is(":checked")){
				console.log("체크");
				var Price= parseInt($("input:checkbox[name=CHK_BSKT]:checked").parent().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().val());
				AddPrice[i]=Price;
			}else{
				console.log("해제!");
			}
		}
		console.log("가격 :"+ AddPrice);
	});
}); 
	
	
		window.onload =function(){
			calTotPrice();
		}

		function calTotPrice(){
			var costs = $(".cost").text().replaceAll(',','').split('원');
			var qnty = $('input[name="PD_QTY"]');
			var devy_amt = $('.devy_total').text().replaceAll(',','').replace('원','')*1
			var totalCost = 0;
			var suprids = [];
			
			
			for(var i =0; i< costs.length;i++){
				if(costs[i].trim() != "") totalCost += parseInt(costs[i])
			}
			
			for(var i =0; i<$("input[name='SUPR_IDS']").length;i++){
				   suprids.push($("input[name='SUPR_IDS']")[i].value)
				}
			//console.log(suprids)
			var supridsTemp = new Set(suprids);
			var uniqueSuprids = [...supridsTemp];
			//console.log("uniqueSuprids.length : "+uniqueSuprids.length)
			for(var i =0; i< uniqueSuprids.length;i++){
				//var dlvy_fcon = parseInt($('.'+uniqueSuprids[i]+'DF').val()); 
				//console.log("$('.'+uniqueSuprids[i]+'DF').val() : "  + $('.'+uniqueSuprids[i]+'DF').val());
			    var suprid_tot = 0;
			    for(var j =0; j<$("."+uniqueSuprids[i]).length;j++){
			       suprid_tot += parseInt($("."+uniqueSuprids[i])[j].textContent.replaceAll(',','').split('원'));
			    }
			    //if(suprid_tot < dlvy_fcon) devy_amt += 3000;
			    
			    //console.log("suprid_tot < dlvy_fcon : " + suprid_tot < dlvy_fcon);
			}
				
			
			
			$('.price').children()[0].textContent = '상품금액 ' + totalCost.toLocaleString() +'원';
			$(".price").children()[2].textContent = '배송비 ' + devy_amt.toLocaleString() + '원';
			$('.price').children()[5].textContent = (devy_amt + totalCost).toLocaleString();
			$(".devy_total").text(devy_amt.toLocaleString() + '원');
			
			$(".sum").children('dd').text((devy_amt + totalCost).toLocaleString()+"원"); 
			$('.prdtsPrice').text(totalCost.toLocaleString()+'원');
			
			var counts = $(".number");
			var totalCnt = 0;
			for(var i =0; i < $(".number").length;i++){
				totalCnt += parseInt(counts[i].value);
			}
			$('.totalCnt').text(totalCnt+'개');
			
		}
		
		// 선택한 상품 장바구니에서 제거  minu 20211110
		function delChekedPd(){
			
			if(!confirm("선택한 상품을 장바구니에서 삭제 하시겠습니까?")) return;
			
			var chklist = $('input[name="CHK_BSKT"]:checked');
			var bskt_regnolist ='';
			for(var i =0; i < chklist.length ; i++){
			    if(i == (chklist.length-1)){
			        bskt_regnolist +=chklist[i].value
			    }else{
			        bskt_regnolist += chklist[i].value+'$';
			    }
			    console.log(chklist[i].value)
			}		
			
			
			var frm=document.getElementById("orderFrm");
			frm.BSKT_REGNO_LIST.value=bskt_regnolist;
			frm.STATE_GUBUN.value='DELETE';
			frm.action = "${contextPath }/m/basket/delete/"+bskt_regnolist;
			frm.submit();
		}
	
</script>
