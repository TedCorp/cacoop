<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp"%>
<!-- ▲ Key -->

<c:set var="arrCagoIdPath" value="${fn:split(rtnCagoInfo.CAGO_ID_PATH, '>') }" />
<c:set var="arrCagoNmPath" value="${fn:split(rtnCagoInfo.CAGO_NM_PATH, '>') }" />
<script>
/* 파라미터값변경&submit */
	$(document).on("change", ".selectSort", function() {
   	  $("#sortOdr").val("asc");
   	  if($(this).val() == "PD_NAME"){
         $("#sortGubun").val("PD_NAME");
      }else if($(this).val() == "PD_PRICE_ASC"){
         $("#sortGubun").val("PD_PRICE");
      }else if($(this).val() == "PD_PRICE_DESC"){
         $("#sortGubun").val("PD_PRICE");
         $("#sortOdr").val("desc");
      }
      $("#frmOrd").submit();
	});

</script>
<style>
	input:checked + label {
 	 font-weight:bold;
	}
</style>

<!-- searchList  -->
<c:if test="${ !empty(obj.list) }">
	<div class="container">
		<div class="location">
			<a href="${contextPath }/m">
				<span class="item">홈
				</span>
			</a>
			<c:forEach var="entPath" items="${ arrCagoNmPath }" varStatus="status">
				<span class="item"> 
					<span class="hp">></span>
					<a href="${contextPath }/m/product?CAGO_ID=${arrCagoIdPath[status.index]}&entcago=${entcagoInfo.ENTRY_ID}"> ${entPath } </a>
				</span>
			</c:forEach>
		</div>
		
		<div class=page-search>
			<div class="titbox">
				<div class="tit">
					<strong>찾고자 하는 검색어</strong> 검색결과
					(<span>${totalCnt} </span>)
				</div>
			</div>
			<div class="cntbox">
				<div class="search">
					<div class="cate">
						<div class="total">
							<strong>총 ${totalCnt}개</strong> 의 상품이 있습니다.
						</div>
						<form id="frmOrd" method="GET" action="${contextPath }/m/search">
							<div class="sort">
								<input name="CAGO_ID" id="CAGO_ID" type="hidden" value="${obj.CAGO_ID}" />
								<input name="sortGubun" id="sortGubun" type="hidden" value="${obj.sortGubun}" />
								<input name="sortOdr" id="sortOdr" type="hidden" value="${empty obj.sortOdr ? 'asc' : obj.sortOdr}" />
								<input type="hidden" name="schTxt" id="schTxt" value="${param.schTxt }"/>
								<input type="hidden" name="schGbn" id="schGbn" value="${param.schGbn }"/>
								<ul class="clear-fix">
									<li>
										<input type="radio" id="PD_NAME" class="selectSort"  name="selectSort" value="PD_NAME" ${param.selectSort eq 'PD_NAME' ? 'checked=checked':''}>
										<label for="PD_NAME">이름정렬순</label> 
									</li>
									<li>
										<input type="radio" id="ASC" class="selectSort" name="selectSort" value="PD_PRICE_ASC" ${param.selectSort eq 'PD_PRICE_ASC' ? 'checked=checked':''}>
										<label for="ASC">낮은가격순</label>
									</li>
									<li>
										<input type="radio" id="DESC" class="selectSort"  name="selectSort" value="PD_PRICE_DESC" ${param.selectSort eq 'PD_PRICE_DESC' ? 'checked=checked':''}>
										<label for="DESC"> 높은가격순</label>
									</li>
								</ul>
							</div>
						</form>
					</div>
					<!--changed listings-->
					<div class="goods">
						<ul>
							<c:forEach var="ent" items="${ obj.list }" varStatus="status">
								<li>
									<div class="img">
										<c:if test="${ !empty(ent.ATFL_ID)  }">
											<c:if test="${ent.FILEPATH_FLAG eq mainKey }">
												<c:set var="imgPath" value="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
											</c:if>
											<c:if test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
												<c:set var="imgPath" value="${ent.STFL_PATH }" />
											</c:if>
										</c:if>
										<c:if test="${ empty(ent.ATFL_ID) }">
											<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
										</c:if>
										<c:if test="${  empty(ent.ATFL_ID) && !empty(ent.IMGURL) }">
											<c:set var="imgPath" value="${ent.IMGURL }" />
										</c:if>
										<a href="${contextPath }/m/product/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}" target="_self" title= "<c:out value=" ${ ent.PD_NAME }" escapeXml="true" />">
											<img src="${imgPath }" alt="<c:out value=" ${ ent.PD_NAME }" escapeXml="true"/>  상품이미지">
										</a>
									</div>
									<div class="con">
										<!-- 상품명 -->
										<div class="name">
 												<a href="${contextPath }/m/product/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}" title="<c:out value=" ${ ent.PD_NAME }" escapeXml="true" />" target="_self">
													<c:if test="${ 'SALE_CON_02' eq ent.SALE_CON }">
														<span style="color:red;">(품절)</span>
													</c:if>
													<c:out value="${ ent.PD_NAME}" escapeXml="true" />
												</a>
										</div>
										<!-- 상품가격 -->
										<div class="cost">
											<c:if test="${USER.MEMB_GUBN=='MEMB_GUBN_01'}">
												<c:choose>
	                                       			<c:when test="${empty ent.MEMBER_PRICE}">
	                                       				<div class="value"><fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###" /><em>원</em></div>
	                                       			</c:when>
	                                       			<c:otherwise>
	                                       				 <div class="value"><fmt:formatNumber value="${ent.PD_PRICE }" pattern="#,###"/><em>원</em></div>
	                                       			</c:otherwise>
	                                     	 	</c:choose>
											</c:if>
											<c:if test="${USER.MEMB_GUBN!='MEMB_GUBN_01'}">
												<c:choose>
	                                       			<c:when test="${empty ent.MEMBER_PRICE}">
	                                       				<div class="value"><fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###" /><em>원</em></div>
	                                       				<div class="price"></div>
	                                       			</c:when>
	                                       			<c:otherwise>
	                                       				 <div class="value"><fmt:formatNumber value="${ ent.MEMBER_PRICE }" pattern="#,###" /><em>원</em></div>
	                                       				 <div class="price"><fmt:formatNumber value="${ent.PD_PRICE }" pattern="#,###"/><em>원</em></div>
	                                       			</c:otherwise>
	                                     	 	</c:choose>
	                                     	</c:if>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
					<!--// End Changed listings-->
				</div>
				<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
					<First><Previous><AllPageLink><Next><Last>
				</paging:PageFooter>   
			</div>
			<!--Middle Part End-->
		</div>
	</div>
	<!-- //Main Container -->
</c:if>
<c:if test="${ empty(obj.list) }">
	<div class="container">
			<div class="location">
			<a href="${contextPath }/m">
				<span class="item">홈
				</span>
			</a>
			<c:forEach var="entPath" items="${ arrCagoNmPath }" varStatus="status">
				<span class="item"> 
					<span class="hp">></span>
					<a href="${contextPath }/m/product?CAGO_ID=${arrCagoIdPath[status.index]}&entcago=${entcagoInfo.ENTRY_ID}"> ${entPath } </a>
				</span>
			</c:forEach>
		</div>

		<div class="page-search">
			<div class="titbox">
				<div class="tit">
					<strong>찾고자 하는 검색어</strong> 검색결과 (0)
				</div>
			</div>
			<div class="cntbox">
				<div class="search">
					<div class="goods">
						<div class="goods-empty" id="test">
							<img src="${contextPath }/resources/resources2/images/icon_search_big.png" alt="">
							<span><strong>찾고자 하는 검색어</strong>에 대한 검색 결과가 없습니다.</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	</div>	
	<!-- //Main Container -->
</c:if>