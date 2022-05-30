<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<c:set var="strActionUrl" value="${contextPath }/m/wishList" />
<c:set var="strMethod" value="post" />

<script type="text/javascript">
	$(function() {		
		$(".btnDeliveryView").click(function(){
			alert("배송 조회 준비중입니다.");
		});	
	});
</script>


<!-- Main Container  -->
<div class="main-container container">
	<ul class="breadcrumb">
		<li><a href="${contextPath }/m"><i class="fa fa-home"></i></a></li>
		<li><a href="${contextPath }/m/mypage/buyBeforeInfo">미결재내역</a></li>
	</ul>

	<div class="row">
		<!--Middle Part Start-->
		<div id="content" class="col-sm-12">
			<h2 class="title">미결재내역<small class="ml_5"> | 결제대기 내역을 조회합니다.</small></h2>
			<div class="table-responsive form-group">
				<table class="table table-bordered">
					<thead>
						<tr>
							<td class="text-center">번호</td>
							<!-- <td class="text-center">주문일자</td> -->
							<td class="text-center">상품명</td>
							<td class="text-center">결제금액</td>
							<td class="text-center">주문상태</td>
							<!-- <td class="text-center">배송조회</td> -->
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${obj.list }" var="list" varStatus="loop">
						<tr>
							<td class="text-center">
								<input type="hidden" name="PD_CODE" value="${list.ORDER_NUM }">
								<a href="${contextPath}/m/order/view/${list.ORDER_NUM }"><b>${list.ORDER_NUM }</b></a>
							</td>
							<%-- <td class="text-center">${list.ORDER_DATE }</td> --%>
							<td class="text-left">
								<a href="${contextPath}/m/order/view/${list.ORDER_NUM }"><b>${list.PD_NAME }
								<c:if test="${list.count > 0 }">
									&nbsp; 외 ${list.count}&nbsp;종
								</c:if>
								</b></a>
							</td>
							<td class=text-right>
								<fmt:formatNumber value="${list.ORDER_AMT }"/>원<br>
								<fmt:parseNumber var="pv_round" value="${ ((list.ORDER_AMT - list.DLVY_AMT) * PV) / 10 }" integerOnly="true" />
								<fmt:parseNumber var="pv_amt" value="${ pv_round * 10 }" integerOnly="true" />
								PV ${ pv_amt }
							</td>
							<td class="text-center">${list.ORDER_CON_NM }</td>
							<%-- <td class="text-center">
								<c:if test="${list.ORDER_CON ne 'ORDER_CON_01' and list.ORDER_CON ne 'ORDER_CON_04' and list.ORDER_CON ne 'ORDER_CON_07'}">
									<button type="button" class="btn btn-xs btn-default btnDeliveryView">조회</button>
								</c:if>
							</td> --%>
						</tr>
						</c:forEach>
						<c:if test="${fn:length(obj.list) eq 0 }">
							<tr>
								<td colspan="6">조회된 주문내역이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
		<!--Middle Part End -->
	</div>
</div>
<!-- //Main Container -->

<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
	<input type="hidden" id="BSKT_REGNO_LIST" name="BSKT_REGNO_LIST" value="" /><!-- 상태 변경 체크 항목 -->
	<input type="hidden" id="BSKT_REGNO" name="BSKT_REGNO" value="" /><!-- 선택 장바구니 등록번호-->
	<input type="hidden" id="STATE_GUBUN" name="STATE_GUBUN" value="" /><!-- 산태 변경 구분 - 장바구니이동인지 삭제인지 -->
	<input type="hidden" id="PD_CUT_SEQ_LIST" name="PD_CUT_SEQ_LIST" value="" /><!-- 산태 변경 구분 - 장바구니이동인지 삭제인지 -->
	<input type="hidden" id="OPTION_CODE_LIST" name="OPTION_CODE_LIST" value="" /><!-- 산태 변경 구분 - 장바구니이동인지 삭제인지 -->
</spform:form>


