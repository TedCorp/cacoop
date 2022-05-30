<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>

<!-- 결제 기능 추가 -->
<!-- <div class="modal fade" id="divPayModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">aria-labelledby="myDivPay"> -->
<div class="modal fade" id="divPayModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"><!-- myModalLabel"> -->
	<div class="modal-dialog modal-lg" role="document" style="width: 740px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="window.location.reload()">
					<span aria-hidden="true">&times;</span>
				</button>
				<!-- <h4 class="modal-title" id="myModalLabel">결제창</h4> -->
			</div>
			<div class="modal-body" style="background-color: #ECF0F5;">


				<iframe id="ifrmPayModal" src="" style="border:0; width:700px; height:600px;"> </iframe>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" onclick="window.location.reload()">닫기</button><!-- data-dismiss="modal" -->
			</div>
		</div>
	</div>
</div>



<form name="fregister" id="fregister" action=""	onsubmit="return fregisterform_submit(this);" method="POST"	autocomplete="off">

	<div class="company mb_30">
		<div class="sub-title">
			<h2>주문상품정보</h2>
		</div>

		<table class="table table-order">
			<thead>
				<tr class="tb_topline">
					<th scope="col">상품명</th>
					<th scope="col">수량</th>
					<th scope="col">판매가</th>
					<th scope="col">상품구매금액</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="tot_amt" value="0" />
				<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
					<tr>
						<td class="sod_img"><input type="hidden" id="ORDER_NUM"	name="ORDER_NUM" value="${list.ORDER_NUM }"> 
						<input type="hidden" id="BSKT_REGNO" name="BSKT_REGNO" value="${list.BSKT_REGNO }"> 
						<input type="hidden" id="PD_CODES" name="PD_CODES" value="${list.PD_CODE }"> 
						<input type="hidden" id="PD_NAMES" name="PD_NAMES" value="${list.PD_NAME}" /> 
						<input type="hidden" id="PD_PRICES" name="PD_PRICES" value="${list.PD_PRICE}" /> 
						<input type="hidden" id="PDDC_GUBNS" name="PDDC_GUBNS" value="${list.PDDC_GUBN}" /> 
						<input type="hidden" id="PDDC_VALS" name="PDDC_VALS" value="${list.PDDC_VAL}" /> 
						<input type="hidden" id="ORDER_QTYS" name="ORDER_QTYS" value="${list.ORDER_QTY}" /> 
						<input type="hidden" id="ORDER_AMTS" name="ORDER_AMTS" value="${list.ORDER_AMT}" /> 
						<input type="hidden" id="PD_CUT_SEQS" name="PD_CUT_SEQS" value="${ list.PD_CUT_SEQ }" />
						<input type="hidden" id="OPTION_CODES" name="OPTION_CODES" value="${ list.OPTION_CODE }" />
						<b>${list.PD_NAME }</b><br> 
						<c:if test="${ list.PD_CUT_SEQ ne null }">(세절방식 : ${ list.PD_CUT_SEQ_UNIT})</c:if>
						<c:if test="${ list.OPTION_CODE ne null }">(색상 : ${ list.OPTION_NAME})</c:if>
						
						</td>
						
						<td class="td_num"><fmt:formatNumber value="${list.ORDER_QTY }" /></td>
						<td class="td_numbig"><fmt:formatNumber value="${list.REAL_PRICE }" /> 원</td>
						<td class="td_num"><fmt:formatNumber value="${list.ORDER_QTY * list.REAL_PRICE }" /> 원</td>
					</tr>
					<c:set var="tot_amt" value="${tot_amt + (list.ORDER_QTY * list.REAL_PRICE) }" />
					<c:if test="${loop.count == fn:length(tb_odinfoxm.list) }">
						<tr>
							<td class="td_num" style="text-align: center;" colspan="3">배송비</td>
							<td class="td_num" id="dlvy_amt_gubn"><fmt:formatNumber value="${tb_odinfoxm.DLVY_AMT }" pattern="#,###" /> 원 
							<c:if test="${tb_odinfoxm.DLVY_AMT != 0 }">
								<c:if test="${tb_odinfoxm.DAP_YN eq 'Y' }">	<br />배송비 결제</c:if>
								<c:if test="${tb_odinfoxm.DAP_YN eq 'N' }">	<br />배송비 착불</c:if>
							</c:if></td>
						</tr>
						<tr>
							<td class="td_num" id="tdTotAmt" style="text-align: center;" colspan="4">총 상품 구매액 <fmt:formatNumber value="${tot_amt }" />원 
								+ 총 배송비 <fmt:formatNumber value="${tb_odinfoxm.DLVY_AMT }" />원 = <fmt:formatNumber value="${tot_amt + tb_odinfoxm.DLVY_AMT }" />원
							</td>
						</tr>
					</c:if>
				</c:forEach>
				<input type="hidden" id="ORDER_AMT" name="ORDER_AMT" value="${tot_amt}" />
				<input type="hidden" id="DLVY_AMT" name="DLVY_AMT" value="${tb_odinfoxm.list[0].DLVY_AMT}" />
			</tbody>
		</table>
	</div>

	<div class="company mb_30">
		<div class="sub-title">
			<h2>결제 정보</h2>
		</div>

		<table class="table table-intro">
			<tbody>
				<tr class="tb_topline">
					<th scope="row">결제금액</th>
					<td><fmt:formatNumber value="${tb_odinfoxm.ORDER_AMT}" pattern="#,###" /> 원</td>
					<th scope="row">결제수단</th>
					<td>
						<input type="hidden" id="payType" value="${tb_odinfoxm.PAY_METD_NM}"/>
						${tb_odinfoxm.PAY_METD_NM}
					</td>
				</tr>
				<tr class="tb_line">
					<th scope="row">주문상태</th>
					<td colspan="3" id="ORDER_CON_NM">${tb_odinfoxm.ORDER_CON_NM}</td>
				</tr>
				<c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_04'}">
					<tr>
						<th scope="row">취소사유</th>
						<td colspan="3">${tb_odinfoxm.CNCL_MSG}</td>
					</tr>
					<tr class="tb_line">
						<th scope="row">취소상태</th>
						<td colspan="3">${tb_odinfoxm.CNCL_CON_NM}</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<div class="company mb_30">
		<div class="sub-title">
			<h2>배송지 정보</h2>
		</div>

		<table class="table table-intro">
			<tbody>
				<tr class="tb_topline">
					<th scope="row">배송지정보</th>
					<td colspan="3">${tb_oddlaixm.DLAR_GUBN_NM}</td>
				</tr>
				<tr>
					<th scope="row">받으시는분</th>
					<td colspan="3">${tb_oddlaixm.RECV_PERS}</td>
				</tr>
				<tr>
					<th scope="row">주소</th>
					<td colspan="3"><label for="POST_NUM" class="sound_only">우편번호</label>
						(${tb_oddlaixm.POST_NUM}) ${tb_oddlaixm.BASC_ADDR}
						${tb_oddlaixm.DTL_ADDR}</td>
				</tr>
				<tr>
					<th scope="row">전화번호</th>
					<td>${tb_oddlaixm.RECV_TELN}</td>
					<th scope="row">휴대폰번호</th>
					<td>${tb_oddlaixm.RECV_CPON}</td>
				</tr>
				<tr>
					<th scope="row">배송 메세지</th>
					<td colspan="6">${tb_oddlaixm.DLVY_MSG}</td>
				</tr>
				<tr class="tb_line">
					<th>배송시간</th>
					<td colspan="6"> 
						<div class="form-inline">
							<fmt:parseDate value="${ tb_oddlaixm.DLAR_DATE }" var="noticePostDate" pattern="yyyyMMdd"/>
							<fmt:formatDate value="${noticePostDate}" pattern="yyyy-MM-dd"/>
							&nbsp;&nbsp;${ tb_oddlaixm.DLAR_TIME }
	            		</div>
	            	</td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

<div class="btn_confirm">
	<a href="${contextPath }/order/wishList" class="btn btn-sm btn-default pull-right" style="height:48px;padding-top: 14px;">목록</a>
	<c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_01'}">
		<a onclick="javascript:;" id="btnPayCall" class="btn btn-sm btn-success pull-right" style="margin-right:5px;height:48px;padding-top: 14px;">신용카드</a>
      	<a onclick="javascript:;" id="btnPay2Call" class="btn btn-sm btn-success pull-right" style="margin-right:5px;height:48px;">실시간 계좌이체</br>무통장입금</a>
		<!-- <a onclick="javascript:;" id="btnPay2Call" class="btn btn-sm btn-success pull-right" style="margin-right:5px;">무통장 입금(가상계좌)</a> -->
	</c:if>
	<c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_02'}">
		<a onclick="javascript:cancel_popup();" class="btn btn-sm btn-success pull-right" style="margin-right:5px;height:48px;padding-top: 14px;">주문취소</a>
	</c:if>
	<a type="button" class="btn btn-sm btn-default pull-right"onclick="fn_inst_bskt();" style="margin-right:5px;height:48px;padding-top: 14px;">장바구니에 저장</a>
</div>

<div>	
	<img style="margin-left:40px;"src="http://www.cjfls.co.kr/resources/img/board/faq_no_28.png">
	<!-- <img style="margin-left:40px;"src="http://www.cjfls.co.kr/resources/img/main/dlvy_info_201809.png"> -->
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="window.location.reload()">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">무통장 입금방법</h4>
			</div>
			<div class="modal-body">
            <form role="form">            	
            	<img src="${contextPath}/resources/img/order/bank_info.jpg" style="width:100%;height:auto;">
            </form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>  	
</div>

<script type="text/javascript">
$(function() {		
	$("#btnPayCall").click(function(){
		fnPayCallDiv();
	});
	$("#btnPay2Call").click(function(){
		fnPayCall2Div();
	});
});
	
function fnPayCall() {
	var url = '${contextPath}/order/orderReady?ORDER_NUM=${tb_odinfoxm.ORDER_NUM }';
	window.open(url, "_blank", "width=700, height=500"); 
}

function fnPayCallDiv() {
	var url = '${contextPath}/order/orderReady?ORDER_NUM=${tb_odinfoxm.ORDER_NUM }&DLVY_TIME='+$('#DLVY_TIME').val();
	$('#ifrmPayModal').attr('src', url);
	$("#divPayModal").modal('show');
}
function fnPayCall2Div() {	//실시간계좌이체
	var url = '${contextPath}/order/orderReady2?ORDER_NUM=${tb_odinfoxm.ORDER_NUM }&DLVY_TIME='+$('#DLVY_TIME').val();
	//$('#ifrmPayModal').attr('src', url);
	//$("#divPayModal").modal('show');
	
	$('#myModal').modal('show');
}

function fnPayClose() {
	$("#divPayModal").modal('hide');
}

function cancel_popup(){
	if($("#payType").val()=='계좌이체'){
		window.open("${contextPath }/order/cancel/popup2?ORDER_NUM=${tb_odinfoxm.ORDER_NUM}", "_blank", "width=500, height=230");
	}else{
	 	window.open("${contextPath }/order/cancel/popup?ORDER_NUM=${tb_odinfoxm.ORDER_NUM}", "_blank", "width=500, height=230");
	}
	
 }

function time_change(){
	
	var hour = parseInt($('#DLVY_TIME_HH').val().toString());
	var minute = $('#DLVY_TIME_MM').val();
	var amtm = $('input[name=DLVY_TIME_TM]:checked').val();
	
	if(amtm=='PM' && hour<12) hour = hour + 12;
	if(amtm=='AM' && hour==12) hour = hour - 12;
	
	$('#DLVY_TIME').val(hour+" : "+minute);
	
}
$('#divPayModal').click(function(e) {
	if(!$(e.target).hasClass("area")) { 
		location.reload();
	} 
});

function fn_inst_bskt(){
	
	$.ajax({
		type: "POST",
	    dataType: 'json',
		url: '${contextPath}/order/insertBsktAjax.json',
		data: $("#fregister").serialize(),
		success: function (data) {
			alert("장바구니에 등록되었습니다.")
		}, error: function (jqXHR, textStatus, errorThrown) {
			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
		}
	});
}
</script>

