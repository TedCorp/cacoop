<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->
<div class="container">
	
	
	<div class="page-exhibition">
		<div class="titbox">
			<div class="tit">기획전</div>
		</div>
		<div class="cntbox">
			<div class="list">
				<!-- 기획전리스트가있으면 -->
				<c:if test="${ !empty(tb_event_main.list) }">
					<ul>
						<c:forEach items="${tb_event_main.list}" var="list" >
							<li>	
								 <a href="${contextPath }/m/product/eventDetail?GRP_CD=${list.GRP_CD}"> 
									<div class="img" >
										<c:if test="${ !empty(list.ATFL_ID)  }">
											<c:if test="${list.FILEPATH_FLAG eq mainKey }">
												<c:set var="imgPath" value="${contextPath }/upload/${list.STFL_PATH }/${list.STFL_NAME }" />
											</c:if>
											<c:if test="${!empty(list.FILEPATH_FLAG) && list.FILEPATH_FLAG ne mainKey }">
												<c:set var="imgPath" value="${contextPath }/upload/${list.STFL_PATH }/${list.STFL_NAME }" />
											</c:if>
										</c:if>
										<c:if test="${ empty(list.ATFL_ID) }">
											<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/snoimage_270.png" />
										</c:if>
										<img style="width: 393px; height: 242px;" src="${imgPath }" alt="<c:out value=" ${ list.GRP_NM }" escapeXml="true"/>  상품이미지">
									</div>
									<!-- 기획전명/기획전기간 -->
									<div class="con">
										<div class="tit">${list.GRP_NM} </div>
										<div class="txt">${list.START_DT } ~ ${list.END_DT }</div>
									</div>
								</a> 
							</li>
						</c:forEach>
					</ul>
				</c:if>
				<!-- 기획전리스트가없으면 -->
				<c:if test="${empty(tb_event_main.list) }">
					<div class="page-search">
						<div class="cntbox">
							<div class="search">
								<div class="goods">
									<div class="goods-empty" id="test">
										<img src="${contextPath }/resources/resources2/images/icon_search_big.png" alt="">
										<span><strong>등록된 기획전</strong>이 없습니다.</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>
