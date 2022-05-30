<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!doctype html>
<html>
<head>
<style>
.review_btn{
	display: block;
	border: 1px solid #26c165;
    color: #26c165;
    background: white;
    border-radius: 4px;
    white-space: nowrap;
    font-size: 13px;
    line-height: 38px;
    padding: 0 10px;
    text-decoration: none;
    }
.review_btn:hover {color:#107037;border-color:#107037}
.btn:active, .btn:focus { border: none; box-shadow: none; }
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
						<li class="on"><a href="${contextPath}/m/mypage/review">상품리뷰</a></li>
						<li><a href="${contextPath}/m/mypage/info">개인정보변경</a></li>
						<li><a href="${contextPath}/m/unregister">회원탈퇴</a></li>
					</ul>
				</div>
			</div>
			<div class="mypage-content">
				<div class="mypage-review-list">
					<div class="mypage-title">상품 리뷰</div>
					<div class="mypage-table">
						<table>
							<colgroup>
								<col>
								<col width="160px">
							</colgroup>
							<tbody>
								<c:choose>
								<c:when test="${!empty(obj.list)}">
									<c:forEach items="${obj.list}" var="list" varStatus="loop">
									<c:set var="imgPath" value="${contextPath}/common/commonImgFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=${list.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
										<tr>
											<td class="goods">
												<div class="flex">
													<img src="${imgPath}" alt="">
													<div>
														<a href="${contextPath}/m/product/view/${list.PD_CODE}" style="color:#333; font-size:14px; text-decoration:none;">
															<strong class="tit">${list.PD_NAME}</strong>
														</a>
														<span class="txt">
															<span class="date">주문일 : ${list.ORDER_DATE}</span>
														</span>
													</div>
												</div>
											</td>
											<td class="manage">
											<form id="cmtForm" method="post" name="cmtForm" action="/m/mypage/review/${list.ORDER_NUM}/${list.PD_CODE}">
												<input type="hidden" name="PD_CODE" value="${list.PD_CODE}"/>
												<input type="hidden" name="ORDER_NUM" value="${list.ORDER_NUM}"/>
												<input type="hidden" name="ATFL_ID" value="${list.ATFL_ID}"/>
												<input type="hidden" name="RPIMG_SEQ" value="${list.RPIMG_SEQ}"/>
												<input type="hidden" name="PD_NAME" value="${list.PD_NAME}"/>
												<input type="hidden" name="ORDER_DATE" value="${list.ORDER_DATE}"/>
												<c:choose>
												<c:when test="${list.COMM_CNT == '0'}">
													<button class="btn btn_write review_btn">리뷰 작성하기</button>
												</c:when>
												<c:otherwise>
													 <button class="btn btn_write review_btn">수정하기</button> 
												</c:otherwise>
												</c:choose>
											</form>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="review-empty">
										<img src="${contextPath}/resources/resources2/images/check.png" alt="">
										<span>작성 가능한 리뷰가 없습니다.</span>
									</div>
								</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
 <script>

 </script>
</body>
</html>