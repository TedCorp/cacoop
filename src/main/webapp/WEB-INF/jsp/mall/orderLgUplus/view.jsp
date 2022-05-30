<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>

<c:set var="strActionUrl" value="${contextPath }/order" />
<c:set var="strMethod" value="post" />

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
						<b>${list.PD_NAME }</b></td>
						<td class="td_num"><fmt:formatNumber value="${list.ORDER_QTY }" /></td>
						<td class="td_numbig"><fmt:formatNumber value="${list.PD_PRICE }" /> 원</td>
						<td class="td_num"><fmt:formatNumber value="${list.ORDER_QTY * list.PD_PRICE }" /> 원</td>
					</tr>
					<c:set var="tot_amt" value="${tot_amt + (list.ORDER_QTY * list.PD_PRICE) }" />
					<c:if test="${loop.count == fn:length(tb_odinfoxm.list) }">
						<tr>
							<td class="td_num" style="text-align: center;" colspan="3">배송비</td>
							<td class="td_num"><fmt:formatNumber value="${tb_odinfoxm.DLVY_AMT }" pattern="#,###" /> 원 
							<c:if test="${tb_odinfoxm.DLVY_AMT != 0 }">
								<c:if test="${tb_odinfoxm.DAP_YN eq 'Y' }">	<br />배송비 결제</c:if>
								<c:if test="${tb_odinfoxm.DAP_YN eq 'N' }">	<br />배송비 착불</c:if>
							</c:if></td>
						</tr>
						<tr>
							<td class="td_num" style="text-align: center;" colspan="4">총 상품 구매액 <fmt:formatNumber value="${tot_amt }" />원 
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
					<td>${tb_odinfoxm.PAY_METD_NM}</td>
				</tr>
				<tr>
					<th scope="row">주문상태</th>
					<td colspan="3">${tb_odinfoxm.ORDER_CON_NM}</td>
				</tr>
				<c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_04'}">
					<tr>
						<th scope="row">취소사유</th>
						<td colspan="3">${tb_odinfoxm.CNCL_MSG}</td>
					</tr>
					<tr>
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
			</tbody>
		</table>
	</div>
</form>

<form id="cancelFrm" name="cancelFrm" method="post" action="${contextPath }/order/cancel/popup">
<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM }" />
<input type="hidden" id="CNCL_MSG" name="CNCL_MSG" value="${tb_odinfoxm.CNCL_MSG }" />
	<div class="btn_confirm">
		<a href="${contextPath }/order/wishList" class="btn btn-sm btn-default pull-right">목록</a>
		<c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_02' || tb_odinfoxm.ORDER_CON eq 'ORDER_CON_03'}">
			<a onclick="javascript:cancel_popup();" class="btn btn-sm btn-success pull-right" style="margin-right:5px;">주문취소</a>
		</c:if>
	</div>
</form>

<script type="text/javascript">
function cancel_popup(){
	 window.open("${contextPath }/order/cancel/popup?ORDER_NUM=${tb_odinfoxm.ORDER_NUM}&PAY_MDKY=${tb_odinfoxm.PAY_MDKY}", "_blank", "width=500, height=230");   
 }
 
function cancel_popup_return(ORDER_NUM, CNCL_MSG){
	var frm=document.getElementById("cancelFrm");
	frm.ORDER_NUM.value=ORDER_NUM;
	frm.CNCL_MSG.value=CNCL_MSG;
	frm.submit();
}
</script>

