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
		마이페이지 <small class="ml_5">| 문의한 내용과 답변을 확인할 수 있습니다.</small>
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
				<li role="presentation">
					<a href="${contextPath}/mypage">개인정보</a></li>
				<li role="presentation" >
					<a href="${contextPath}/mypage/buyInfo">구매내역</a></li>
				<li role="presentation" class="active" >
					<a href="${contextPath}/mypage/myQna">문의답변</a></li>
				<li role="presentation">
						<a href="${contextPath}/mypage/buyBeforeInfo">미결재내역</a></li>
					
			</ul>
		</div>
	</div>
	
	<table class="table table-order" style="margin-top:20px">
		<thead>
			<tr>
				<th>제목</th>
				<th>상품명</th>
				<th>작성자</th>
				<th>작성일자</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(obj.list) == 0 }">
			<tr>
				<td colspan="5">문의한 내용이 없습니다.</td>
			</tr>
		</c:if>
			<c:forEach items="${obj.list }" var="list" varStatus="loop">
				<tr>
					<c:choose>
            	 		<c:when test="${empty list.BRD_PW }">
       	    				<td><a href="${contextPath}/community/qna/detail/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&BRD_NUM=${list.BRD_NUM }">${list.BRD_SBJT }</a>
   						</c:when>
   						<c:when test="${!empty list.BRD_PW && USER.MEMB_ID eq list.WRTR_ID}">
							<td><img src="${contextPath }/html/img/sub/sub05/locked.png">&nbsp;
							<a href="${contextPath}/community/qna/detail/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&BRD_NUM=${list.BRD_NUM }">${list.BRD_SBJT }</a>
						</c:when>
						<c:when test="${!empty list.BRD_PW && USER.MEMB_ID ne list.WRTR_ID}">
							<td><img src="${contextPath }/html/img/sub/sub05/locked.png">&nbsp;<a>${list.BRD_SBJT }</a>
						</c:when>
					</c:choose>
							<td>${list.PD_NAME }</td>
							<td>${list.WRTR_NM }</td>
							<td>${list.WRT_DTM }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</form>

<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
	<First><Previous><AllPageLink><Next><Last>
</paging:PageFooter>


<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
<input type="hidden" id="BSKT_REGNO_LIST" name="BSKT_REGNO_LIST" value="" /><!-- 상태 변경 체크 항목 -->
<input type="hidden" id="BSKT_REGNO" name="BSKT_REGNO" value="" /><!-- 선택 장바구니 등록번호-->
<input type="hidden" id="STATE_GUBUN" name="STATE_GUBUN" value="" /><!-- 산태 변경 구분 - 장바구니이동인지 삭제인지 -->
</spform:form>

