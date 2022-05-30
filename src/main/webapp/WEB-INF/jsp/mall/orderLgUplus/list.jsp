<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>


<script type="text/javascript">

	$(function() {		
		$(".btnDeliveryView").click(function(){
			alert("배송 조회 준비중입니다.");
		});
	});

</script>


<%-- <c:set var="strActionUrl" value="${contextPath }/wishList" />
<c:set var="strMethod" value="post" /> --%>


<div class="sub-title sub-title-underline">
	<h2>
		주문내역 <small class="ml_5">| 절차, 배송 등 안내...</small>
	</h2>
	<ul>
		<li><a href='${contextPath }' class="sct_bg">Home</a></li>
		<li><a href="${contextPath }/order/wishList" class=" ">주문내역</a></li>
	</ul>
	<div class="clearfix"></div>
</div>

<form name="frmcartlist" id="sod_bsk_list" method="post" action="${contextPath }/order/wishList">

<table class="table table-order">
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">주문일자</th>
			<th scope="col">상품명</th>
			<th scope="col">결제금액</th>
			<th scope="col">주문상태</th>
			<th scope="col">배송조회</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(obj.list) == 0 }">
		<tr>
			<td colspan="6">조회된 주문내역이 없습니다.</td>
		</tr>
	</c:if>
		<c:forEach items="${obj.list }" var="list" varStatus="loop">
		<tr>
			<td class="sod_img">
				<input type="hidden" name="PD_CODE" value="${list.ORDER_NUM }">
				<a href="${contextPath}/order/view/${list.ORDER_NUM }"><b>${list.ORDER_NUM }</b></a>
			</td>
			<td class="td_num">${list.ORDER_DATE }</td>
			<td class="td_num">
				<a href="${contextPath}/order/view/${list.ORDER_NUM }"><b>${list.PD_NAME }
				<c:if test="${list.count > 0 }">
					&nbsp; 외 ${list.count}&nbsp;종
				</c:if>
				</b></a>
			</td>
			<td class="td_num"><fmt:formatNumber value="${list.ORDER_AMT }" /></td>
			<td class="td_num">${list.ORDER_CON_NM }</td>
			<td class="td_numbig">
				<c:if test="${list.ORDER_CON ne 'ORDER_CON_01' && list.ORDER_CON ne 'ORDER_CON_04' && list.ORDER_CON ne 'ORDER_CON_07'}">
					<button type="button" class="btn btn-xs btn-default btnDeliveryView">조회</button>
				</c:if>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>

<!-- 
<div class="box-footer">
	<ul class="pagination pagination-sm no-margin pull-right">
		<li><a href="#">&laquo;</a></li>
		<li><a href="#">1</a></li>
		<li><a href="#">2</a></li>
		<li><a href="#">3</a></li>
		<li><a href="#">&raquo;</a></li>
	</ul>
</div>
 -->