<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/layout/inc/taglib.jsp" %>

			<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
				<!-- ▲ Key -->
<c:set var="strActionUrl" value="${contextPath }/m/wishList" />
<c:set var="strMethod" value="post" />
<!doctype html>
<html>
<head>
	<style type="text/css">
		.delivery-btn{margin:5px 0 5px 0;}
	</style>
</head>
<body>			
	<div class="container">
		<div class="page-mypage">
			<div class="mypage-aside">
				<div class="tit">나의 쇼핑 정보</div>
				<div class="txt">
					<ul>
						<li><a href="${contextPath}/m/order/wishList">주문/배송 조회</a></li>
						<li><a href="${contextPath}/m/order/exchange">환불/반품 조회</a></li>
						<li><a href="${contextPath}/m/mypage/review">상품리뷰</a></li>
						<li><a href="${contextPath}/m/mypage/info">개인정보변경</a></li>
						<li><a href="${contextPath}/m/unregister">회원탈퇴</a></li>
					</ul>
				</div>
			</div>
			<div class="mypage-content">
				<div class="mypage-order-list">
					<div class="mypage-title">주문상품 정보</div>
					<div class="mypage-table">
						<table>
							<colgroup>
								<col width="160px">
								<col>
								<col width="110px">
								<col width="120px">
							</colgroup>
							<thead>
								<tr>
									<th>주문일</th>
									<th>주문내역</th>
									<th>주문상태</th>
									<th>주문관리</th>
								</tr>
							</thead>
							<tbody>
							
								<%-- <c:if test="${empty(obj.list)}">
									<span>${obj.list.PD_NAME}</span>
									<tr id ="tst">
											<td rowspan="4">주문내역이 없습니다</td>
										</tr>
								</c:if> --%>
								<c:choose>
								<c:when test="${!empty(obj.list)}">
									 <c:forEach items="${obj.list}" var="list" varStatus="loop" begin="0" end="0">
									 <c:set var="imgPath" value="${contextPath}/common/commonImgFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=${list.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
											<tr>
												<td class="date">${list.ORDER_DATE}<br>[${list.ORDER_NUM}]<br> <a href="${contextPath}/m/order/detail/${list.ORDER_NUM}">주문상세</a></td>
												<td class="goods">
													<div class="flex">
														<img src="${imgPath}" alt="">&nbsp;&nbsp;&nbsp;
														<a href="${contextPath}/m/product/view/${list.PD_CODE}" style="color:#333; font-size:14px; text-decoration:none;">
															<strong>${list.PD_NAME}</strong>
															<c:if test="${ list.CNT ne 0}">
															<strong>외&nbsp;${list.CNT}개</strong>
															</c:if>
														</a>
													</div>
												</td>
												<td class="state">${list.ORDER_CON_NM}</td>
												<td class="manage">
													<!-- 임시 문구 -->
													<c:choose>
													<c:when test="${list.ORDER_CON_NM eq '결제전' || list.ORDER_CON_NM eq '결제완료' || list.ORDER_CON_NM eq '배송준비중'}">
														<!--<button type="button" class="order-cancel manage-btn" onclick="orderCancel('${list.ORDER_NUM}', '주문취소');">주문취소</button>-->
														<a href="${contextPath}/m/order/detail/${list.ORDER_NUM}?CANCEL=y" class="manage-btn">주문 취소</a>
													</c:when>
													<c:when test="${list.ORDER_CON_NM eq '배송중'}">
														<button type="button" class="manage-btn" onclick="fn_popup('${list.ORDER_NUM}');">배송조회</button>
													</c:when>
													<c:when test="${list.ORDER_CON_NM eq '배송완료'}">
														<a href="${contextPath}/m/order/detail/${list.ORDER_NUM}?CONFIRM=y" class="manage-btn delivery-btn">구매 확정</a>
														<%-- <button type="button" class="order-confirm manage-btn delivery-btn" onclick="orderConfirm('${list.ORDER_NUM}');">구매확정</button> --%>
														<a href="${contextPath}/m/order/detail/${list.ORDER_NUM}?REFUND=y" class="manage-btn delivery-btn">반품 신청</a>
													</c:when>
													<c:otherwise>
														<div><fmt:formatDate value="${list.MOD_DTM}" pattern="yyyy-MM-dd"/></div>
													</c:otherwise>
													</c:choose>
												</td>
											</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr id ="tst">
										<td colspan="4">주문내역이 없습니다</td>
									</tr>
								</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
				<div class="mypage-order-recent">
					<div class="mypage-title">최근 구매상품</div>
					<div class="mypage-list">
						<c:choose>
						<c:when test="${!empty(obj.list)}">
							<c:forEach items="${obj.list}" var="list" varStatus="loop" begin="0" end="4">
							<c:set var="imgPath" value="${contextPath}/common/commonImgFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=${list.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
								<ul>
									<li>
										<div class="img" id="test"><a href="${contextPath}/m/product/view/${list.PD_CODE}"><img src="${imgPath}" alt=""></a></div>
										<div class="con">
											<a href="${contextPath}/m/product/view/${list.PD_CODE}">
												<div class="name">${list.PD_NAME}</div>
												<div class="cost">
													<div class="value"><fmt:formatNumber value="${list.REAL_PRICE}" pattern="#,###" /><em>원</em></div>
													<div class="price"><fmt:formatNumber value="${list.PD_PRICE}" pattern="#,###" /><em>원</em></div>
												</div>
											</a>
										</div>
									</li>
								</ul>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="mypage-list-empty" style="width:100%;">
								<img src="${contextPath}/resources/resources2/images/icon_empty.png" alt="">
								<span>최근에 구매한 상품이 없습니다.</span>
							</div>
						</c:otherwise>
						</c:choose>
					</div>
				</div>
				<c:set var="count" value="0"/>
				<c:forEach var="list" items="${obj2.list}">
				<c:set var="count" value="${count + 1}"/>
				</c:forEach>
				<div class="mypage-cart">
					<div class="mypage-title">장바구니 
						<c:if test="${count > 5}">
							<a href="${contextPath}/m/basket" class="more">더보기<i class="ic"></i></a>
						</c:if>
					</div>
					<div class="mypage-list">
						<c:choose>
						<c:when test="${!empty(obj2.list)}">
							<c:forEach items="${obj2.list}" var="list" varStatus="loop" begin="0" end="4">
							<c:set var="imgPath" value="${contextPath}/common/commonImgFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=${list.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
										<ul>
											<li>
												<div class="img"><a href="${contextPath}/m/product/view/${list.PD_CODE}"><img src="${imgPath}" alt=""></a></div>
												<div class="con">
													<a href="${contextPath}/m/product/view/${list.PD_CODE}">
														<div class="name">${list.PD_NAME}</div>
														<div class="cost">
															<div class="value"><fmt:formatNumber value="${list.PD_PRICE}" pattern="#,###" /><em>원</em></div>
															<div class="price"><fmt:formatNumber value="${list.PD_PRICE}" pattern="#,###" /><em>원</em></div>
														</div>
													</a>
												</div>
											</li>
										</ul>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="mypage-list-empty" style="width:100%;">
								<img src="../resources/resources2/images/icon_empty.png" alt="">
								<span>장바구니에 담긴 상품이 없습니다.</span>
							</div>
						</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
 <script>
 </script>
</body>
</html>
