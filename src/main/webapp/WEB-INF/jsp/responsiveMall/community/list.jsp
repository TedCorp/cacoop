<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- Main Container  -->
<div class="main-container container">
	<ul class="breadcrumb">
		<li><a href="${contextPath }/m"><i class="fa fa-home"></i></a></li>
		<li><a href="${contextPath }/m/community">고객센터</a></li>
	</ul>
	
	<div class="row">		
		<div id="content" class="col-sm-12">
			<h2 class="title">
				<b>1:1 문의</b>
				<small class="ml_5"> | 회원님의 문의에 대하여 운영자가 1:1답변을 드립니다.</small>	
				<a href="${contextPath }/m/community/faqList" class="btn btn-xs btn-default pull-right">+ 자주묻는 질문 바로가기</a>			
			</h2>
			<div class="table-responsive form-group">
				<table class="table table-bordered">
					<thead>
						<tr>
							<td class="text-center" style="width:60px">번호</td>
							<td class="text-center">제목</td>
							<td class="text-center" style="width:150px;">등록일</td>
							<td class="text-center" style="width:100px;">답변여부</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="ent" items="${tb_pdbordxm.list }" varStatus="status">
						<tr>
							<td class="text-center">
								${ent.RNUM }
							</td>
							<td class="text-left">
								<a href="${contextPath }/m/community/view/${ent.BRD_GUBN}/${ent.BRD_NUM }">
								<b>[${ent.BRD_GUBN_NM}]</b> ${ ent.BRD_SBJT }</a>
							</td>
							<td class="text-center">
								${ent.WRT_DTM }
							</td>
							<td class="text-center">
								<c:if test="${ent.REPLY_YN eq 'Y' }">
									<small class="label label-primary">Y</small>
								</c:if>
								<c:if test="${ent.REPLY_YN ne 'Y' }">
									<small class="label label-warning">N</small>
								</c:if>
							</td>
						</tr>
						</c:forEach>
						<c:if test="${fn:length(tb_pdbordxm.list) eq 0 }">
							<tr>
								<td colspan="4">등록된 게시물이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>				
			</div>
			<!-- /.end table -->
		
			<!-- Filters -->
			<paging:PageFooter totalCount="${ tb_pdbordxm.count }" rowCount="${ tb_pdbordxm.rowCnt }">
				<First><Previous><AllPageLink><Next><Last>
			</paging:PageFooter>
			
			<div class="buttons">
				<div class="pull-right">
					<a  href="${contextPath }/m/community/new" class="btn btn-primary pull-right right-5">글쓰기</a>
				</div>
			</div>
		</div>
		<!-- /.Middle Part -->		
	</div>
</div>
<!-- /.Main Container -->