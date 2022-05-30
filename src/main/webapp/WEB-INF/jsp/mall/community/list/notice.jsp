<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<div class="col-5">
	<div class="my-banner pd_n">
	    <img src="${contextPath }/html/img/sub/sub05/banner.png" class="img-responsive" style="margin-bottom: 30px;">
	</div>
	
	<div class="sub-title">
		<h2>
			공지사항 목록 <small class="ml_5"></small>
		</h2>
		<ul>
			<li><a href='${contextPath }' class="sct_bg">Home</a></li>
			<li><a href='${contextPath }/community' class="sct_bg">Community</a></li>
			<li><a href="${contextPath }/community/noticeList" class=" ">공지사항</a></li>
		</ul>
		<div class="clearfix"></div>
	</div>
	
	<form>
		<table class="table table-order">
			<thead>
				<tr>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일자</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(obj.list) == 0 }">
				<tr>
					<td colspan="5">공지사항이 없습니다.</td>
				</tr>
			</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
				<tr>
					<td><a href="${contextPath }/community/notice/detail?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&BRD_NUM=${list.BRD_NUM }">${ list.BRD_SBJT }</a></td>
					<td>${list.WRTR_NM }</td>
					<td>${list.WRT_DTM }</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
</div>

<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
	<First><Previous><AllPageLink><Next><Last>
</paging:PageFooter>

