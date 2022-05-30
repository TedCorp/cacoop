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
	

function calculSum(){
	
}
</script>


<c:set var="strActionUrl" value="${contextPath }/basket" />
<c:set var="strMethod" value="post" />


<div class="sub-title sub-title-underline">
	<h2>
		마이페이지 <small class="ml_5">| 구매내역을 확인할 수 있습니다.</small>
	</h2>
	<ul>
		<li><a href='${contextPath }' class="sct_bg">Home</a></li>
		<li><a href="${contextPath }/mypage" class=" ">마이페이지</a></li>
	</ul>
	<div class="clearfix"></div>
</div>

<form name="frmcartlist" id="sod_bsk_list" method="post" action="">

	<div class="col-10">
		<div class="main-tab">
			<!-- Nav tabs -->
			<ul class="nav nav-main" role="tablist">
				<li role="presentation" >
					<a href="${contextPath}/mypage">개인정보</a></li>
				<li role="presentation" class="active" >
					<a href="${contextPath}/mypage/buyInfo">구매내역</a></li>
				<li role="presentation" >
						<a href="${contextPath}/mypage/myQna">문의답변</a></li>
				<li role="presentation">
						<a href="${contextPath}/mypage/buyBeforeInfo">미결재내역</a></li>
					
			</ul>
		</div>
	</div>
	<table class="table table-order" style="margin-top:20px">
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">주문일자</th>
				<th scope="col">상품명</th>
				<th scope="col">결제금액</th>
				<th scope="col">주문상태</th>
				<!-- <th scope="col">배송조회</th> -->
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
				<%-- <td class="td_numbig">
					<c:if test="${list.ORDER_CON ne 'ORDER_CON_01' && list.ORDER_CON ne 'ORDER_CON_04' && list.ORDER_CON ne 'ORDER_CON_07'}">
						<button type="button" class="btn btn-xs btn-default btnDeliveryView">조회</button>
					</c:if>
				</td> --%>
			</tr>
			</c:forEach>
		</tbody>
	</table>



<%-- <div id="sod_bsk_act">
	<!-- <a href="#" onclick="javascript:fn_state('MOVE');" class="btn01">선택 관심상품</a> -->
	<!-- <button type="button" onclick="javascript:fn_state('DELETE');" class="btn_submit">계속 쇼핑하기</button> -->
	<button type="button" onclick="javascript:fn_indentation();" class="btn btn-sm btn-success pull-right">주문하기</button>
	<a href="${contextPath }" class="btn btn-sm btn-default pull-right" style="margin-right:5px;">계속 쇼핑하기</a>
	<button type="button" onclick="javascript:fn_state('DELETE_ALL');" class="btn btn-sm btn-default pull-right" style="margin-right:5px;">장바구니 비우기</button>
	<button type="button" onclick="javascript:fn_state('DELETE');" class="btn btn-sm btn-default pull-right" style="margin-right:5px;">선택 삭제</button>
</div> --%>
</form>

<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
<input type="hidden" id="BSKT_REGNO_LIST" name="BSKT_REGNO_LIST" value="" /><!-- 상태 변경 체크 항목 -->
<input type="hidden" id="BSKT_REGNO" name="BSKT_REGNO" value="" /><!-- 선택 장바구니 등록번호-->
<input type="hidden" id="STATE_GUBUN" name="STATE_GUBUN" value="" /><!-- 산태 변경 구분 - 장바구니이동인지 삭제인지 -->
</spform:form>

