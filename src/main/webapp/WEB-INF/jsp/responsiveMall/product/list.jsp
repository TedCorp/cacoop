<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp"%>
<!-- ▲ Key -->

<c:set var="arrCagoIdPath"
	value="${fn:split(rtnCagoInfo.CAGO_ID_PATH, '>') }" />
<c:set var="arrCagoNmPath"
	value="${fn:split(rtnCagoInfo.CAGO_NM_PATH, '>') }" />


<!-- 대카테고리 -->
<c:if test="${ !empty rtnCagoList }">
	<style>
input:checked+label {
	font-weight: bold;
}
</style>
	<div class="container ct-main">


		<!--TOP 카테고리  -->
		<div class="location" id="first_category">
			<a href="${contextPath }/m"><span class="item">홈</span></a>
			<c:forEach var="entPath" items="${ arrCagoNmPath }"
				varStatus="status">
				<span class="item"> <span class="hp">></span> <a
					href="${contextPath }/m/product?CAGO_ID=${arrCagoIdPath[status.index]}&entcago=${entcagoInfo.ENTRY_ID}">
						${entPath } </a>
				</span>
			</c:forEach>
		</div>

		<div class="dual-layout">
			<!--카테고리  -->
			<div class="lnb">
				<c:if test="${ !empty rtnCagoList }">
					<p class="dep01" id="cate_name"></p>
					<ul class="dep02">
						<c:forEach var="ent" items="${ rtnCagoList }" varStatus="status">
							<li class=""><a
								href="${contextPath }/m/product?CAGO_ID=${ ent.CAGO_ID }&entcago=${entcagoInfo.ENTRY_ID}"
								class="cutom-parent"> <c:out value="${ ent.CAGO_NAME }"
										escapeXml="true" /> (${ ent.PRD_CNT })
							</a> <span class="dcjq-icon"> </span></li>
						</c:forEach>
					</ul>
				</c:if>
			</div>
			<div class="conts">
				<!-- 배너 -->
				<div class="banner-zone">
					<div class="swiper-container" style="max-height: 315px;">
						<div class="swiper-wrapper">
							<c:if test="${ !empty(tb_event_main.list) }">
								<c:if test="${img.count > 0}">
									<c:forEach items="${img.list}" var="rolimg" varStatus="loop">
										<div class="swiper-slide">
											<a href="${contextPath }/m/product/eventList"> <img
												style="height: 315px;"
												src="${contextPath }/upload/${img.JD_PATH}${rolimg.JD_LIST}"
												style="width=100%;">
											</a>
										</div>
									</c:forEach>
								</c:if>

							</c:if>
						</div>
						<div class="swiper-conts-wrap">
							<div class="swiper-conts">
								<!-- Add Arrows -->
								<div class="swiper-button-next"></div>
								<div class="swiper-button-prev"></div>
							</div>
						</div>
					</div>
				</div>
				<!-- 배너 END -->

				<!-- 상품정렬 -->
				<div class="tb list-top mgt50">
					<div>
						총 <span id="total_count1"> ${totalCnt }</span> 건
					</div>
					<form id="frmOrd" method="GET" action="${contextPath }/m/product">
						<div style="text-align: right;">
							<input name="CAGO_ID" id="CAGO_ID" type="hidden"
								value="${obj.CAGO_ID}" /> <input name="sortGubun"
								id="sortGubun" type="hidden" value="${obj.sortGubun}" /> <input
								name="sortOdr" id="sortOdr" type="hidden"
								value="${empty obj.sortOdr ? 'asc' : obj.sortOdr}" />
							<ul class="clear-fix">
								<%-- 	<li>
									<input type="radio" id="recom" name="selectSort" value="PD_PRICE_ASC1" ${param.selectSort eq 'PD_PRICE_ASC1' ? 'checked=checked':''} >
									<label for="recom">추천상품순</label>
								</li> --%>
								<li><input type="radio" id="PD_NAME" class="selectSort"
									name="selectSort" value="PD_NAME"
									${param.selectSort eq 'PD_NAME' ? 'checked=checked':''}>
									<label for="PD_NAME">이름정렬순</label></li>
								<li><input type="radio" id="ASC" class="selectSort"
									name="selectSort" value="PD_PRICE_ASC"
									${param.selectSort eq 'PD_PRICE_ASC' ? 'checked=checked':''}>
									<label for="ASC">낮은가격순</label></li>
								<li><input type="radio" id="DESC" class="selectSort"
									name="selectSort" value="PD_PRICE_DESC"
									${param.selectSort eq 'PD_PRICE_DESC' ? 'checked=checked':''}>
									<label for="DESC"> 높은가격순</label></li>
							</ul>
						</div>
					</form>
				</div>
				<!-- 상품정렬 END -->
				<div class="img-list-type pt4">
					<c:forEach var="ent" items="${ obj.list }" varStatus="status">
						<c:if test="${status.first}">
							<ul class="row clear-fix"
								style="margin-right: 0px; margin-left: 0px;">
						</c:if>
						<c:choose>


							<c:when test="${status.count % 4 == 0 }">
								<li>
									<c:set var="imgPath"
										value="${contextPath }/common/commonImgFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
									<c:if test="${ !empty(ent.ATFL_ID)  }">
										<c:if test="${ent.FILEPATH_FLAG eq mainKey }">
											<c:set var="imgPath"
												value="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
										</c:if>
										<c:if
											test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
											<c:set var="imgPath" value="${ent.STFL_PATH }" />
										</c:if>
									</c:if>
									<c:if test="${ !empty(ent.IMGURL) }">
										<c:set var="imgPath" value="${ent.IMGURL }" />
									</c:if>
									<a href="${contextPath }/m/product/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}"
									target="_self"
									title="<c:out value=" ${ ent.PD_NAME }" escapeXml="true" />"><img
										src="${imgPath }"
										alt="<c:out value=" ${ ent.PD_NAME }" escapeXml="true"/>  상품이미지"></a>
									<p class="tit">
										<a
											href="${contextPath }/m/product/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}"
											title="<c:out value=" ${ ent.PD_NAME }" escapeXml="true" />"
											target="_self"><c:out value="${ ent.PD_NAME }"
												escapeXml="true" /></a>
									</p> <!-- 상품가격 -->
									<p class="price">
										<c:choose>
											<c:when test="${empty ent.MEMBER_PRICE}">
												<span class="price"><fmt:formatNumber
														value="${ ent.PD_PRICE }" pattern="#,###" />원</span>
												<span class="erased"></span>
											</c:when>
											<c:otherwise>
												<span class="price"><fmt:formatNumber
														value="${ ent.MEMBER_PRICE }" pattern="#,###" />원</span>
												<span class="erased"><fmt:formatNumber
														value="${ent.PD_PRICE }" pattern="#,###" /> 원 </span>
											</c:otherwise>
										</c:choose>
									</p></li>
								</ul>
								<ul class="row clear-fix"
									style="margin-right: 0px; margin-left: 0px;">
							</c:when>
							<c:otherwise>

								<li>									
									<c:set var="imgPath"
										value="${contextPath }/common/commonImgFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
									<c:if test="${ !empty(ent.ATFL_ID)  }">
										<c:if test="${ent.FILEPATH_FLAG eq mainKey }">
											<c:set var="imgPath"
												value="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
										</c:if>
										<c:if
											test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
											<c:set var="imgPath" value="${ent.STFL_PATH }" />
										</c:if>
									</c:if>
									<c:if test="${ !empty(ent.IMGURL) }">
										<c:set var="imgPath" value="${ent.IMGURL }" />
									</c:if>
									<a
									href="${contextPath }/m/product/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}"
									target="_self"
									title="<c:out value=" ${ ent.PD_NAME }" escapeXml="true" />"><img
										src="${imgPath }"
										alt="<c:out value=" ${ ent.PD_NAME }" escapeXml="true"/>  상품이미지"></a>
									<p class="tit">
										<a
											href="${contextPath }/m/product/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}"
											title="<c:out value=" ${ ent.PD_NAME }" escapeXml="true" />"
											target="_self"><c:out value="${ ent.PD_NAME }"
												escapeXml="true" /></a>
									</p> <!-- 상품가격 -->
									<p class="price">
										<c:choose>
											<c:when test="${empty ent.MEMBER_PRICE}">
												<span class="price"><fmt:formatNumber
														value="${ ent.PD_PRICE }" pattern="#,###" />원</span>
												<span class="erased"></span>
											</c:when>
											<c:otherwise>
												<span class="price"><fmt:formatNumber
														value="${ ent.MEMBER_PRICE }" pattern="#,###" />원</span>
												<span class="erased"><fmt:formatNumber
														value="${ent.PD_PRICE }" pattern="#,###" /> 원 </span>
											</c:otherwise>
										</c:choose>
									</p></li>
							</c:otherwise>
						</c:choose>
						<c:if test="${status.last }">
							</ul>
						</c:if>
					</c:forEach>
				</div>
				<!-- 페이징   -->
				<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
					<First> <Previous> <AllPageLink> <Next>
					<Last>
				</paging:PageFooter>
				<!-- 페이징 END  -->
			</div>
		</div>
		<script>
			/* 배너 효과 */
			$(document).ready(function() {
				var swiper = new Swiper('.swiper-container', {
					navigation : {
						nextEl : '.swiper-button-next',
						prevEl : '.swiper-button-prev',
					},
					loop : true,
					init : false,
					on : {
						slideChange : function() {
						}
					}
				});
				swiper.on("init", function() {

				})
				swiper.init()
			});

			/* 카테고리 이름 */
			$(document)
					.ready(
							function() {
								var str = $('.item')[$('.item').length - 1].children[1].textContent
								$("#cate_name").text(str);

							});

			/* 파라미터값변경&submit */
			$(document).on("change", ".selectSort", function() {
				$("#sortOdr").val("asc");
				if ($(this).val() == "PD_NAME") {
					$("#sortGubun").val("PD_NAME");
				} else if ($(this).val() == "PD_PRICE_ASC") {
					$("#sortGubun").val("PD_PRICE");
				} else if ($(this).val() == "PD_PRICE_DESC") {
					$("#sortGubun").val("PD_PRICE");
					$("#sortOdr").val("desc");
				}
				$("#frmOrd").submit();
			});
		</script>
	</div>
</c:if>
<!-- 대카테고리END -->





<!-- 중카테고리 -->
<c:if test="${ empty rtnCagoList }">
	<style>
input:checked+label {
	font-weight: bold;
}
</style>
	<div class="container ct-sub">
		<div class="location">
			<a href="${contextPath }/m"> <span class="item">홈 </span>
			</a>
			<c:forEach var="entPath" items="${ arrCagoNmPath }"
				varStatus="status">
				<span class="item"> <span class="hp"> > </span> <a
					href="${contextPath }/m/product?CAGO_ID=${arrCagoIdPath[status.index]}&entcago=${entcagoInfo.ENTRY_ID}">
						${entPath } </a>
				</span>
			</c:forEach>
		</div>


		<!-- 중카테고리상품 -->
		<div class="sub-title" id="sub_title"></div>

		<!-- 상품정렬 -->
		<div class="tb list-top">
			<div>
				총 <span id="total_count2"> ${ totalCnt}</span> 건
			</div>
			<form id="frmOrd" method="GET" action="${contextPath }/m/product">
				<div style="text-align: right;">
					<input name="CAGO_ID" id="CAGO_ID" type="hidden"
						value="${obj.CAGO_ID}" /> <input name="sortGubun" id="sortGubun"
						type="hidden" value="${obj.sortGubun}" /> <input name="sortOdr"
						id="sortOdr" type="hidden"
						value="${empty obj.sortOdr ? 'asc' : obj.sortOdr}" />
					<ul class="clear-fix">
						<%-- 		<li>
						<input type="radio" id="recom" name="selectSort" value="PD_PRICE_ASC1" ${param.selectSort eq 'PD_PRICE_ASC1' ? 'checked=checked':''} >
						<label for="recom">추천상품순</label>
					</li> --%>
						<li><input type="radio" id="PD_NAME" class="selectSort"
							name="selectSort" value="PD_NAME"
							${param.selectSort eq 'PD_NAME' ? 'checked=checked':''}>
							<label for="PD_NAME">이름정렬순</label></li>
						<li><input type="radio" id="ASC" class="selectSort"
							name="selectSort" value="PD_PRICE_ASC"
							${param.selectSort eq 'PD_PRICE_ASC' ? 'checked=checked':''}>
							<label for="ASC">낮은가격순</label></li>
						<li><input type="radio" id="DESC" class="selectSort"
							name="selectSort" value="PD_PRICE_DESC"
							${param.selectSort eq 'PD_PRICE_DESC' ? 'checked=checked':''}>
							<label for="DESC"> 높은가격순</label></li>
					</ul>
				</div>
			</form>
		</div>
		<!-- 상품정렬 END-->

		<div class="img-list-type">
			<ul class="row clear-fix"
				style="display: flex; flex-direction: row; flex-wrap: wrap; align-content: space-around; margin-right: 0px; margin-left: 0px;">
				<c:forEach var="ent" items="${ obj.list }" varStatus="status">
					<c:set var="imgPath"
						value="${contextPath }/common/commonImgFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
					<c:if test="${ !empty(ent.ATFL_ID)  }">
						<c:if test="${ent.FILEPATH_FLAG eq mainKey }">
							<c:set var="imgPath"
								value="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
						</c:if>
						<c:if
							test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
							<c:set var="imgPath" value="${ent.STFL_PATH }" />
						</c:if>
					</c:if>
					<c:if test="${ empty(ent.ATFL_ID) && !empty(ent.IMGURL) }">
						<c:set var="imgPath" value="${ent.IMGURL }" />
					</c:if>
					<!--상품명  -->
					<li><a
						href="${contextPath }/m/product/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}"
						target="_self"
						title="<c:out value=" ${ ent.PD_NAME }" escapeXml="true" />">
							<img width="100%" src="${imgPath }"
							alt="<c:out value=" ${ ent.PD_NAME }" escapeXml="true"/>  상품이미지">
					</a>
						<p class="tit">
							<a
								href="${contextPath }/m/product/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}"
								title="<c:out value=" ${ ent.PD_NAME }" escapeXml="true" />"
								target="_self"><c:out value="${ ent.PD_NAME }"
									escapeXml="true" /></a>
						</p> <!-- 상품가격 -->
						<p class="price">
							<c:choose>
								<c:when test="${empty ent.MEMBER_PRICE}">
									<span class="price"><fmt:formatNumber
											value="${ ent.PD_PRICE }" pattern="#,###" />원</span>
									<span class="erased"></span>
								</c:when>
								<c:otherwise>
									<span class="price"><fmt:formatNumber
											value="${ ent.MEMBER_PRICE }" pattern="#,###" />원</span>
									<span class="erased"><fmt:formatNumber
											value="${ent.PD_PRICE }" pattern="#,###" /> 원 </span>
								</c:otherwise>
							</c:choose>
						</p></li>
				</c:forEach>
			</ul>

			<!-- 페이징  -->
			<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
				<First> <Previous> <AllPageLink> <Next>
				<Last>
			</paging:PageFooter>
			<!-- 페이징END -->
		</div>

		<script>
			$(document)
					.ready(
							function() {
								var str2 = $('.item')[$('.item').length - 1].children[1].textContent
								$("#sub_title").text(str2);
							});

			/* 파라미터값변경&submit */
			$(document).on("change", ".selectSort", function() {
				$("#sortOdr").val("asc");
				if ($(this).val() == "PD_NAME") {
					$("#sortGubun").val("PD_NAME");
				} else if ($(this).val() == "PD_PRICE_ASC") {
					$("#sortGubun").val("PD_PRICE");
				} else if ($(this).val() == "PD_PRICE_DESC") {
					$("#sortGubun").val("PD_PRICE");
					$("#sortOdr").val("desc");
				}
				$("#frmOrd").submit();
			});
		</script>
	</div>
</c:if>
<!--중카테고리 END  -->





