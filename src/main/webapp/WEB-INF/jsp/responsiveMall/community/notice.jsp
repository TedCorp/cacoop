<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- Main Container  -->
<div class="main-container container">
	<ul class="breadcrumb">
		<li><a href="${contextPath }/m"><i class="fa fa-home"></i></a></li>
		<li><a href="${contextPath }/m/community">고객센터</a></li>
		<li><a href="${contextPath }/m/community/noticeList">공지사항</a></li>
	</ul>
	
	<div class="row">		
		<div id="content" class="col-sm-12">
			<h2 class="title">
				<b>공지사항</b>
				<small class="ml_5"> | 공지사항, 안내사항 등을 전해드립니다.</small>
			</h2>
			<div class="table-responsive form-group">
				<table class="table table-bordered">
					<thead>
						<tr>
							<td class="text-center" style="width:60px">번호</td>
							<td class="text-center">제목</td>							
							<td class="text-center" style="width:150px">등록일</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="ent" items="${ tb_pdbordxm.list }" varStatus="status">
						<tr>
							<td class="text-center">
								<div>${ent.RNUM }</div>
							</td>
							<td class="text-left">
								<div><a href="${contextPath }/m/community/noticeView/${ent.BRD_GUBN }/${ent.BRD_NUM }">${ ent.BRD_SBJT }</a></div>
							</td>
							<td class="text-center">
								<div>${ent.WRT_DTM }</div>
							</td>
						</tr>
						</c:forEach>
						<c:if test="${fn:length(tb_pdbordxm.list) eq 0 }">
							<tr>
								<td colspan="3">등록된 공지사항이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			
			<!-- Filters -->
			<paging:PageFooter totalCount="${ tb_pdbordxm.count }" rowCount="${ tb_pdbordxm.rowCnt }">
				<First><Previous><AllPageLink><Next><Last>
			</paging:PageFooter>
			
		</div>
		<!-- /.Middle Part -->		
	</div>
</div>
<!-- /.Main Container -->