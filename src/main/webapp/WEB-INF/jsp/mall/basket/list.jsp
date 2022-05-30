<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<style type="text/css">
.form-control.select{
	padding:1px;
}
</style>
<script type="text/javascript">
$(function() {
	$('.goodsImg').each(function(n){
			$(this).error(function(){
				$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
			});
		 });
	
	$(document).on("blur", "#PD_QTY", function() {//뭐지
		price_calculate();
	});
	$(document).on("change", "#PD_QTY", function() {
    	price_calculate2($(this));
    });
	
	
	// 수량변경 및 삭제
	$('.btnQty').click(function(){
	    var mode = $(this).text();
	    var this_qty, max_qty = 9999, min_qty = 1;
	    var $el_qty = $(this).closest("td").find("input[name^=PD_QTY]");	    
	    
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
	            price_calculate2($(this));
	            break;

	        case "-":
	            this_qty = parseInt($el_qty.val().replace(/[^0-9]/, "")) - 1;
	            if(this_qty < min_qty) {
	                this_qty = min_qty;
	                alert("최소 구매수량은 "+number_format(String(min_qty))+" 입니다.");
	            }
	            $el_qty.val(this_qty);
	            price_calculate2($(this));
	            break;

	        default:
	            alert("올바른 방법으로 이용해 주십시오.");
	            break;
	    }
	});
	
	
	//전체선택 체크박스 클릭 
	$("#CHK_ALL").click(function(){ //만약 전체 선택 체크박스가 체크된상태일경우 
		if($("#CHK_ALL").prop("checked")) { //해당화면에 전체 checkbox들을 체크해준다 
			$("input[type=checkbox]").prop("checked",true); // 전체선택 체크박스가 해제된 경우 
		} else { //해당화면에 모든 checkbox들의 체크를해제시킨다. 
			$("input[type=checkbox]").prop("checked",false); 
		} 
		price_calculate();
	});
	
	$("input[type=checkbox]").prop("checked",true);	//기본상태 전체체크
	price_calculate();
	
	



});
// 전체계산
function price_calculate()
{
	//체크박스
	var checkboxValues = [];
	
	//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
	$("input:checkbox[name=CHK_BSKT]:checked").each(function(){
	 	checkboxValues.push($(this).val());
	});
	if(checkboxValues==''||checkboxValues==null){
	 	checkboxValues.push("");
	}
	
	var total = 0;
	var chkBox = $("input:checkbox[name=CHK_BSKT]");
	
	$("input[name^=price_sum]").each(function (i) {
		if(chkBox.eq(i).is(":checked")==true){		//체크항목만 총 상품금액에 추가
			total += parseInt($('input[name^=price_sum]').eq(i).val().replace(/,/g,""));	
		}
        
    });
	
	$('#total').html(number_format(String(total)));

	var dlvyAmt = parseInt(${supplierInfo.DLVY_AMT });						//배송비
	var dlva_fcon = parseInt(${supplierInfo.DLVA_FCON });					//무료배송금액
	
	if(total >= dlva_fcon || total == 0){
		$('#devy_amt').html(number_format('0'))
		$('#sum_total').html(number_format(String(total)));
	}else{
		$('#devy_amt').html(number_format(String(dlvyAmt)))
		$('#sum_total').html(number_format(String(parseInt(total)+parseInt(dlvyAmt))));
	}
}

function price_calculate2(obj)
{	
	 var $el_pq = "";			//수량 node
	 //var $el_pq2 = obj.closest("td").find("#PD_QTY option:selected");			//수량 node
	 var $el_prc = obj.closest("td").find("input[name^=PD_PRICE]");			//가격 node
	 var $el_ps = obj.closest("td").find("input[name^=price_sum]");			//소계 node
	 var $el_pcd = obj.parent("td").prev().find("input[name^=BSKT_REGNO]");	//상품코드 node
	 var $el_bkno = ""; 		//장바구니 NO
	 
	 var check = obj.closest("td").find("#PD_QTY option:selected");
	 var pd_qty = 0;
	 if(check.text()!=null&&check.text()!=""){
		 $el_pq = obj.closest("td").find("#PD_QTY option:selected");			//수량 node
		 $el_ps.val($el_pq.text()*$el_prc.val());
		 $el_ps.parent().parent().find('td[name^=price_sum22]').html(number_format(String($el_pq.text()*$el_prc.val())));
		 pd_qty = $el_pq.text();
		 $el_bkno = obj.parent("span").parent("td").prev().prev().prev().find("input[name^=CHK_BSKT]");	//장바구니 NO
	 }else{
		 $el_pq = obj.closest("td").find("input[name^=PD_QTY]");			//수량 node
		 $el_ps.val($el_pq.val()*$el_prc.val());
		 //$el_ps.val(number_format(String($el_pq.val()*$el_prc.val())));
		 $el_ps.parent().parent().find('td[name^=price_sum22]').html(number_format(String($el_pq.val()*$el_prc.val())));
		 pd_qty = $el_pq.val();
		 $el_bkno = obj.parent("td").prev().prev().prev().find("input[name^=CHK_BSKT]");	//장바구니 NO
	 }
	 
	 /* 박스할인 */
	 var boxpddcgubn = obj.closest("td").find("input[name^=BOX_PDDC_GUBN]").val();	//박스할인구분
	 var inputcnt = parseInt(obj.closest("td").find("input[name^=INPUT_CNT]").val());			//입수량
     var boxpddcval = parseInt(obj.closest("td").find("input[name^=BOX_PDDC_VAL]").val());	//박스할인값
     var boxsalequt = parseInt($el_pq.val()/inputcnt);				//몫
     var boxsaleval = parseInt(boxsalequt*boxpddcval);
     var realtotal = 0;
     
     if(boxpddcgubn=='PDDC_GUBN_02'){
        realtotal = $el_ps.val()-boxsaleval;
        
        $el_ps.parent().parent().find('td[name^=price_sum22]').html(number_format(String(realtotal)));
        $el_ps.val(number_format(String(realtotal)))
     }else if(boxpddcgubn=='PDDC_GUBN_03'){ 
     	boxpddcval = $el_prc.val()* boxpddcval/100;
     	boxsaleval = parseInt(boxsalequt*boxpddcval*inputcnt);
    	
     	realtotal = $el_ps.val()-boxsaleval;
     	
     	$el_ps.parent().parent().find('td[name^=price_sum22]').html(number_format(String(realtotal)));
     	$el_ps.val(number_format(String(realtotal)))
     }else{
     	
     }
     /* ../박스할인 */
	 
	 //장바구니 수량 데이터 업데이트
	 $.ajax({
		    type: 'GET',
		    dataType: 'json',
		    data: { "CHK_BSKT": $el_bkno.val() , "PD_QTY": pd_qty },
		    url: '${contextPath }/basket/qtyUpdate.json',
		    success: function (data) {
		    	
		    },
		    error:function(request,status,error){
		         console.log('error : '+error+"\n"+"code : "+request.status+"\n");
		    }
		});
	 
	
	price_calculate();
	
}

//전체 체크 및 해제 시
function fn_all_chk(){
	var check_yn = false;		
	if($("#CHK_ALL").is(":checked")){
		check_yn = true;
	}
	for(var i=1;i<= ${fn:length(obj.list) };i++){
		$("#CHK"+i).prop("checked",check_yn);
	}
}

//일괄 상태 변경
function fn_state(state_chk){
	
	if(state_chk=="DELETE_ALL"){
		$("#CHK_ALL").prop("checked",true);
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
		frm.action = "${contextPath }/basket/multi";
	}else if(state_chk == "DELETE"){
		frm.action = "${contextPath }/basket/delete/multi";
	}
	frm.STATE_GUBUN.value=state_chk;
	frm.submit();
}

//관심상품으로 이동
function fn_change(bskt_regno){
	if(!confirm("해당 상품을 관심상품으로 이동 하시겠습니까?")) return;
	var frm=document.getElementById("orderFrm");
	frm.BSKT_REGNO.value=bskt_regno;
	frm.action = "${contextPath }/basket/"+bskt_regno;
	//alert(frm.method);
	//frm.method = "put";
	//alert(frm.method);
	frm.submit();
}

//삭제
function fn_delete(bskt_regno){
	if(!confirm("해당 상품을 장바구니에서 삭제 하시겠습니까?")) return;
	var frm=document.getElementById("orderFrm");
	frm.BSKT_REGNO.value=bskt_regno;
	frm.action = "${contextPath }/basket/delete/"+bskt_regno;
	//frm.method = "delete";
	frm.submit();
}

//주문하기
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
			/* 여기야여기 */
			pd_option_list+=$("#OPTION"+i).val();
			pd_option_list+="@@#";
			
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
	
	if(!confirm("주문 하시겠습니까?")){
		return;
	}
	
	var frm=document.getElementById("orderFrm");
	frm.BSKT_REGNO_LIST.value=bskt_regno_list;
	frm.PD_CUT_SEQ_LIST.value=pd_cut_list;
	frm.OPTION_CODE_LIST.value=pd_option_list;
	frm.action = "${contextPath }/order/new";
	frm.submit();
}
</script>


<c:set var="strActionUrl" value="${contextPath }/basket" />
<c:set var="strMethod" value="post" />


<div class="sub-title sub-title-underline">
	<h2>
		장바구니 <small class="ml_5">| 7일간 보관 후 삭제 됩니다. 가격, 적립금 등 정책 변경 시 자동 삭제 됩니다. 수량 변경 시 수정 버튼을 클릭하세요.</small>
	</h2>
	<ul>
		<li><a href='${contextPath }' class="sct_bg">Home</a></li>
		<li><a href="${contextPath }/basket" class=" ">장비구니</a></li>
	</ul>
	<div class="clearfix"></div>
</div>

<form name="frmcartlist" id="sod_bsk_list" method="post" action="">
<table class="table table-order">
    <thead>
		<tr>
			<th scope="col"><input type="checkbox" id="CHK_ALL" name="CHK_ALL"/></th><!-- onclick="javascript:fn_all_chk();"  -->
			<th scope="col" style="width:55px">사진</th>
			<th scope="col">상품명</th>
			<th scope="col" style="width:110px">수량</th>
			<th scope="col">가격</th>
			<th scope="col">소계</th>
			<th scope="col" style="width:136px">기능</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(obj.list) == 0 }">
			<tr>
				<td colspan="6">조회된 장바구니가 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach items="${obj.list }" var="list" varStatus="loop">
		<tr>
			<td class="td_chk">
				<c:if test="${list.SALE_CON=='SALE_CON_01'  && list.DEL_YN == 'N'   }">
					<input type="checkbox" id="CHK${loop.count }" name="CHK_BSKT" value="${list.BSKT_REGNO }" onclick="price_calculate()"/>
					<input type="hidden" id="CUT${loop.count }" name="CHK_CUT" value="${ list.PD_CUT_SEQ}" />
					<input type="hidden" id="OPTION${loop.count }" name="CHK_OPTION" value="${ list.OPTION_CODE}" />
				</c:if>
				<c:if test="${list.SALE_CON!='SALE_CON_01' ||list.DEL_YN != 'N'  }">
					<%-- <input type="checkbox" id="CHK${loop.count }" name="CHK_BSKT" value="${list.BSKT_REGNO }" onclick="price_calculate()" style="display:none"/> --%>
					<input type="hidden" id="CUT${loop.count }" name="CHK_CUT" value="${ list.PD_CUT_SEQ}" />
					<input type="hidden" id="OPTION${loop.count }" name="CHK_OPTION" value="${ list.OPTION_CODE}" />
				</c:if> 
			</td>
			<td>
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
				<img width="50" height="50" src="${imgPath}" alt="<c:out value="${ list.PD_NAME }" escapeXml="true"/>"/>
				<%-- <c:if test="${ !empty(list.ATFL_ID) }">
					<img width="50" height="50" src="${contextPath }/common/commonFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=${list.RPIMG_SEQ}" alt="<c:out value="${ list.PD_NAME }" escapeXml="true"/>"/>
				</c:if> --%>
				<c:if test="${ empty(list.ATFL_ID) }">
					<img width="50" height="50" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ list.PD_NAME }" escapeXml="true"/>"/>
				</c:if>
			</td>
			<td class="sod_img">
				<%-- <img src="${contextPath }/resources/images/mall/goods/noimage.png" width="70" height="70" alt=""> --%>
				<c:if test="${list.SALE_CON!='SALE_CON_01'||list.DEL_YN != 'N' }">
					<div style="position: absolute;font-size:15px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;">
					---------------------<br>
					</div>
				</c:if> 
				<input type="hidden" name="PD_CODE" value="${list.PD_CODE }">
				<a href="/product/view/${list.PD_CODE }"><b>${list.PD_NAME }</b></a>
				<c:if test="${ list.PD_CUT_SEQ ne null }"><br>(세절방식 : ${ list.PD_CUT_SEQ})</c:if>
				<c:if test="${ list.OPTION_CODE ne null }"><br>(색상 : ${ list.OPTION_CODE})</c:if>
				<br>
			</td>
			<td class="td_num">
				<c:if test="${list.SALE_CON=='SALE_CON_01'  && list.DEL_YN == 'N'   }">
				<c:if test='${list.QNT_LIMT_USE=="Y" }'>
					<span style="width: 40px;height: 100%;">
						<jsp:include page="/common/comCodForm">
							<jsp:param name="COMM_CODE" value="QNT_LIMT" />
							<jsp:param name="name" value="PD_QTY" />
							<jsp:param name="value" value="${list.LIMT_PD_QTY }" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="" />
						</jsp:include>
					</span>
				</c:if>
				<c:if test = '${list.QNT_LIMT_USE==null||list.QNT_LIMT_USE=="N" }'>
					<button type="button" class="btn btn-primary btn-xs btnQty">-</button>
					<input type="text" name="PD_QTY" value="${list.PD_QTY }" id="PD_QTY" style="width:40px;text-align:center;" readonly="readonly">
					<button type="button" class="btn btn-primary btn-xs btnQty">+</button>
				</c:if>
				</c:if>
				<c:if test="${list.SALE_CON != 'SALE_CON_01' ||list.DEL_YN != 'N'   }">
					판매하지<br>않는 상품
				</c:if>
				<c:if test="${list.SALE_CON == 'SALE_CON_01' && list.DEL_YN == 'N'   }">
					<!-- 박스할인율 적용  -->
					<c:if test="${list.BOX_PDDC_GUBN eq 'PDDC_GUBN_01'}">
						<c:set var="boxsaleval" value="0" />
					</c:if>
					<c:if test="${list.BOX_PDDC_GUBN eq 'PDDC_GUBN_02'}">
						<fmt:parseNumber var="boxsalequt" value="${list.PD_QTY/list.INPUT_CNT}" integerOnly="true" />
						<c:set var="boxsaleval" value="${list.BOX_PDDC_VAL*boxsalequt}" />
					</c:if>
					<c:if test="${list.BOX_PDDC_GUBN eq 'PDDC_GUBN_03'}">
						<fmt:parseNumber var="boxsalequt" value="${list.PD_QTY/list.INPUT_CNT}" integerOnly="true" />
						<fmt:parseNumber var="boxpddcval" value="${list.REAL_PRICE*list.BOX_PDDC_VAL/100}" integerOnly="true" />
						<c:set var="boxsaleval" value="${boxpddcval*boxsalequt*list.INPUT_CNT}" />
					</c:if>
					<!-- 박스할인율 적용  -->
					<input type="hidden" name="PD_PRICE" value="${list.REAL_PRICE }">
					<input type="hidden" name="price_sum" value="${(list.PD_QTY * list.REAL_PRICE)-boxsaleval }">
					<input type="hidden" name="INPUT_CNT" value="${list.INPUT_CNT }">
					<input type="hidden" name="BOX_PDDC_VAL" value="${list.BOX_PDDC_VAL}">
					<input type="hidden" name="BOX_PDDC_GUBN" value="${list.BOX_PDDC_GUBN}">
					
				</c:if>
			</td>
			<td class="td_numbig">
				<fmt:formatNumber value="${list.REAL_PRICE }" />
			</td>
			<td class="td_num" name="price_sum22">
				<fmt:formatNumber value="${(list.PD_QTY * list.REAL_PRICE)-boxsaleval }" />
				<%-- ${list.PD_QTY * list.PD_PRICE } --%>
			</td>
			<td class="td_numbig">
				<%-- <button type="button" onclick="javascript:fn_info('${list.BSKT_REGNO }');" class="btn_submit">수정</button>
				<br/> --%>
				<button type="button" onclick="javascript:fn_change('${list.BSKT_REGNO }');" class="btn btn-sm btn-default">관심상품</button>
				&nbsp;
				<button type="button" onclick="javascript:fn_delete('${list.BSKT_REGNO }');" class="btn btn-sm btn-success">삭제</button>
				
			</td>
		</tr>
		</c:forEach>
		<tr>
			<td class="td_num" style="text-align: right;" colspan="7">
				총 상품 구매액 : <span id="total"></span>원<%-- <fmt:formatNumber><c:out value="${price_sum}"/></fmt:formatNumber>원 --%> 
				<br>총 배송비 : <span id="devy_amt"></span>원  
				<br>합계 : <span id="sum_total"></span>원
				<br>
			</td>
		</tr>
	</tbody>
</table>


<div id="sod_bsk_act">
	<!-- <a href="#" onclick="javascript:fn_state('MOVE');" class="btn01">선택 관심상품</a> -->
	<!-- <button type="button" onclick="javascript:fn_state('DELETE');" class="btn_submit">계속 쇼핑하기</button> -->
	<button type="button" onclick="javascript:fn_indentation();" class="btn btn-sm btn-success pull-right">주문하기</button>
	<a href="${contextPath }/" class="btn btn-sm btn-default pull-right" style="margin-right:5px;">계속 쇼핑하기</a>
	<button type="button" onclick="javascript:fn_state('DELETE_ALL');" class="btn btn-sm btn-default pull-right" style="margin-right:5px;">장바구니 비우기</button>
	<button type="button" onclick="javascript:fn_state('DELETE');" class="btn btn-sm btn-default pull-right" style="margin-right:5px;">선택 삭제</button>
</div>
</form>



		


<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
<input type="hidden" id="BSKT_REGNO_LIST" name="BSKT_REGNO_LIST" value="" /><!-- 상태 변경 체크 항목 -->
<input type="hidden" id="BSKT_REGNO" name="BSKT_REGNO" value="" /><!-- 선택 장바구니 등록번호-->
<input type="hidden" id="STATE_GUBUN" name="STATE_GUBUN" value="" /><!-- 산태 변경 구분 - 장바구니이동인지 삭제인지 -->
<input type="hidden" id="PD_CUT_SEQ_LIST" name="PD_CUT_SEQ_LIST" value="" /><!-- 산태 변경 구분 - 장바구니이동인지 삭제인지 -->
<input type="hidden" id="OPTION_CODE_LIST" name="OPTION_CODE_LIST" value="" /><!-- 산태 변경 구분 - 장바구니이동인지 삭제인지 -->
</spform:form>
