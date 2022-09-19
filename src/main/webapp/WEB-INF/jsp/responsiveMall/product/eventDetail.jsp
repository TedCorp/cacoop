<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<style>
	input:checked + label {
 	 font-weight:bold;
	}
</style>

<div class="container">
	<div class="page-exhibition">
		<%-- 이전 프로젝트 이름 
		<div class="titbox">
			<div class="tit">${tem.GRP_NM }</div>
		</div> --%>
		<c:if test="${ !empty(tem) }">
			<div class="cntbox">
				<div class="detail">
					<div class="thumb">
						<div class="img" >
						<c:forEach var="var" items="${fileDtlList }" varStatus="status">
							<c:if test="${ !empty(var.ATFL_ID)}">
								<c:if test="${var.FILEPATH_FLAG eq mainKey }">
									<c:set var="imgPath" value="${contextPath }/upload/${var.STFL_PATH }/${var.STFL_NAME }" />
								</c:if>
								<c:if test="${!empty(var.FILEPATH_FLAG) && var.FILEPATH_FLAG ne mainKey }">
									<c:set var="imgPath" value="${contextPath }/upload/${var.STFL_PATH }/${var.STFL_NAME }" />
								</c:if>
							</c:if>
							<c:if test="${ empty(var.ATFL_ID) }">
								<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
							</c:if>
						</c:forEach>
						<div id="temDUSEYN">
						</div>
						${testtest5512}
						<%-- ${tem.D_USE_YN} --%>
						<%-- <img src="${imgPath}" alt="<c:out value=" ${ tem.GRP_NM }" escapeXml="true"/>기획전이미지"> --%>
						</div>
					</div>
					
					<!--상품정렬  -->
					<div class="cate">
						<div class="total">총 ${totalCnt} 건</div>
						
						 <form id="eventDetailFrm" class="eventDetailFrm" method="GET" action="${contextPath }/m/product/eventDetail">
							<div class="sort">
								<input name="GRP_CD" id="GRP_CD" type="hidden" value="${tem.GRP_CD }"> 
								<input name="sortGubun" id="sortGubun" type="hidden" value="${tem.sortGubun}" /> 
								<input name="sortOdr" id="sortOdr" type="hidden" value="${empty tem.sortOdr ? 'asc' : tem.sortOdr}" />
								<ul class="clear-fix">
									<%-- <li>
										<input type="radio" id="recom" name="selectSort" value="PD_PRICE_ASC1" ${param.selectSort eq 'PD_PRICE_ASC1' ? 'checked=checked':''} >
										<label for="recom">추천상품순</label>
									</li> --%>
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
					<!-- 상품정렬END -->
					
					<div class="goods">
						<ul>
							<c:forEach items="${obj.list }" var="ent">
								<c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
								<c:if test="${ !empty(ent.ATFL_ID)  }">
									<c:if test="${ent.FILEPATH_FLAG eq mainKey }">
										<c:set var="imgPath" value="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
									</c:if>
									<c:if test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
										<c:set var="imgPath" value="${ent.STFL_PATH }" />
									</c:if>
								</c:if>
								<c:if test="${ empty(ent.ATFL_ID)  }">
									<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
								</c:if>
								<li>
									<div class="img">
										<a href="${contextPath }/m/product/view/${ ent.PD_CODE }?pageNum=${ent.pageNum }&rowCnt=${ent.rowCnt }&${link}" target="_self" title="<c:out value=" ${ ent.PD_NAME }" escapeXml="true" />">
											<img style="width: 200px; height: 200px;" src="${imgPath }" alt="<c:out value=" ${ ent.PD_NAME }" escapeXml="true"/>  상품이미지">
										</a>
									</div>
									<div class="con">
										<a href="${contextPath }/m/product/view/${ ent.PD_CODE }?pageNum=${ent.pageNum }&rowCnt=${ent.rowCnt }&${link}" title="<c:out value=" ${ ent.PD_NAME }" escapeXml="true" />" target="_self">
											<div class="name"><c:out value="${ ent.PD_NAME }" escapeXml="true" /></div>
											<div class="cost">
												<c:choose>
		                                       		<c:when test="${empty ent.MEMBER_PRICE}">
		                                       			<div class="value" ><fmt:formatNumber value="${ent.PD_PRICE}" pattern="#,###" /><em>원</em></div>
		                                       			<span class="price"></span>
		                                       		</c:when>
		                                       		<c:otherwise>
		                                       			<div class="value" ><fmt:formatNumber value="${ent.MEMBER_PRICE}" pattern="#,###" /><em>원</em></div>
		                                       			 <span class="price"><fmt:formatNumber value="${ent.PD_PRICE }" pattern="#,###"/> 원 </span>
		                                       		</c:otherwise>
		                                       </c:choose>
											</div>
										</a>
										
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
					<!-- 페이징  -->
					<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
						<First><Previous><AllPageLink><Next><Last>
					</paging:PageFooter>
					<!-- 페이징END -->  
				</div>
			</div>
		</c:if>
	</div>
</div>

<script>

/* 파라미터값전달 */
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
     $("#eventDetailFrm").submit();
	});


</script>
