<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<ul class="dropdown-menu pull-right shoppingcart-box" role="menu">
	<li>
		<table class="table table-striped">
			<tbody>

				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td class="text-center" style="width: 70px">
							<a href="product.html"> 

							<c:if test="${ !empty(list.ATFL_ID) }">
								<img src="${contextPath }/common/commonFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=${list.RPIMG_SEQ}"
									style="width: 70px" alt="${ list.PD_NAME }"
									title="${ list.PD_NAME }" class="preview">
							</c:if>
							<c:if test="${ empty(list.ATFL_ID) }">
								<img src="${contextPath }/resources/images/mall/goods/noimage.png"
									style="width: 70px" alt="${ list.PD_NAME }"
									title="${ list.PD_NAME }" class="preview">
							</c:if>
							</a>
						</td>
						<td class="text-left">
							<a class="cart_product_name"href="/product/view/${list.PD_CODE }">${list.PD_NAME }</a>
						</td>
						<td class="text-center">
							<c:if test="${list.SALE_CON=='SALE_CON_01'  && list.DEL_YN == 'N'   }">
							<c:if test='${list.QNT_LIMT_USE=="Y" }'>
								<span style="width: 40px;height: 100%;">
									<jsp:include page="/common/comCodForm/">
										<jsp:param name="COMM_CODE" value="QNT_LIMT" />
										<jsp:param name="name" value="PD_QTY" />
										<jsp:param name="value" value="${list.LIMT_PD_QTY }" />
										<jsp:param name="type" value="select" />
										<jsp:param name="top" value="" />
									</jsp:include>
								</span>
							</c:if>
							<c:if test = '${list.QNT_LIMT_USE==null||list.QNT_LIMT_USE=="N" }'>
								<div class="input-group quantity-control" unselectable="on" style="-webkit-user-select: none;">
			                        <input type="text" name="PD_QTY" value="${list.PD_QTY }" id="PD_QTY" size="1" class="form-control" />
			                        <span class="input-group-btn">
			                        <button type="submit" data-toggle="tooltip" title="더하기" class="btn btn-primary btnQty">+</button>
			                        <button type="button" data-toggle="tooltip" title="빼기" class="btn btn-danger btnQty">-</button>
								</div>
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
							</c:if>
						</td>
						<td class="text-center"><fmt:formatNumber value="${(list.PD_QTY * list.REAL_PRICE)-boxsaleval }" /></td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(obj.list) == 0 }">
					<tr>
						<td colspan="4">조회된 장바구니가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</li>
	<!-- li>
		<div>
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td class="text-right"><strong>총 상품 구매액 :</strong></td>
						<td class="text-right"><span id="total"></span>원</td>
					</tr>
					<tr>
						<td class="text-right"><strong>총 배송비 :</strong>
						</td>
						<td class="text-right"><span id="devy_amt"></span>원 </td>
					</tr>
					<tr>
						<td class="text-right"><strong>합계 :</strong></td>
						<td class="text-right"><span id="sum_total"></span>원</td>
					</tr>
				</tbody>
			</table>
			<p class="text-right">
				<a class="btn view-cart" href="${contextPath }/m/basket"><i
					class="fa fa-shopping-cart"></i>&nbsp;View Cart</a>
			</p>
		</div>
	</li>
</ul -->


