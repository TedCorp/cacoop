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

<div id="wrapper_title">주문내역</div>
<div id="sct_location">
	<a href='${contextPath }/goods' class="sct_bg">Home</a>
	<a href="${contextPath }/request" class="sct_here">주문내역 조회</a>
</div>

<!-- div class="mbskin">
    <p>주문 안내<br/>절차, 배송 등 안내...</p>
</div -->


<!-- 글자크기 조정 display:none 되어 있음 시작 { -->
<div id="sod_bsk">
	<form name="frmcartlist" id="sod_bsk_list" method="post" action="">
		<div class="tbl_head01 tbl_wrap">
			<table>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">주문일자</th>
						<th scope="col">상품명</th>
						<th scope="col">결제금액</th>
						<th scope="col">주문상태</th>
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
						<td class="grid_4 td_center">
							<input type="hidden" name="PD_CODE" value="${list.ORDER_NUM }">
							<a href="${contextPath}/request/view/${list.ORDER_NUM }"><b>${list.ORDER_NUM }</b></a>
						</td>
						<td class="grid_3 td_center">${list.ORDER_DATE }</td>
						<td>
							<a href="${contextPath}/request/view/${list.ORDER_NUM }"><b>${list.PD_NAME }
							<c:if test="${list.count > 0 }">
								&nbsp;외 ${list.count}&nbsp;종
							</c:if>
							</b></a>
						</td>
						<td class="grid_3 td_right"><fmt:formatNumber value="${list.ORDER_AMT }" /></td>
						<td class="grid_3 td_center">${list.ORDER_CON_NM }</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		
	</form>

</div>

<div class="text-center" style="padding:20px; 0 0 0">
	<img src="${contextPath }/resources/images/main/helpDesk/tab4_1.png" class="imgHelp" />
</div>