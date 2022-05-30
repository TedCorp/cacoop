<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<div class="row_02_title">
	<p>
		<span class="green">HIT</span> 상품전
	</p>
	<ul class="controller">
		<li><a><img src="${contextPath}/resources/img/main/hit_arrow_left.gif"></a></li>
		<li><a><img src="${contextPath}/resources/img/main/hit_arrow_right.gif"></a></li>
	</ul>
</div>

<ul class="hit-list">
	<c:forEach var="ent" items="${ hitList }" varStatus="status">
		<c:if test="${status.index < 2 }">
		<li>
			<a href="/product/view/${ ent.PD_CODE }"><!-- <a href="./product/view/${ ent.PD_CODE }"> --> 
				<c:if test="${ !empty(ent.ATFL_ID) }">
					<img class="hitImg" width="60" height="53" src="${contextPath }/common/commonFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
				</c:if>
				<c:if test="${ empty(ent.ATFL_ID) }">
					<img class="hitImg" width="60" height="53" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
				</c:if>
				<div class="text-box">
					<small class="label label-danger">HIT</small>
					<p class="txt_wg">${ ent.PD_NAME }</p>
					<p class="gray">${ ent.PD_NAME }</p>
					<p class="price">\ <fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###"/></p>
				</div>
			</a>
		</li>
		</c:if>
	</c:forEach>
</ul>
