<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>기획전관리	<small>기획전 목록</small></h1>
</section>

<section class="content">
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">기획전 목록</h3>
			<div class="box-tools">			
				<a href="${contextPath}/adm/eventMgr/newForm" class="btn btn-primary btn-sm pull-right">신규등록</a>			
			</div>
		</div>		
		<!-- /.box-header -->
		<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
			<table class="table table-bordered">
				<colgroup>
					<col />
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th class="txt-middle">번호</th>
						<th class="txt-middle">기획전코드</th>
						<th class="txt-middle">기획전명</th>
						<th class="txt-middle">사용여부</th>
						<th class="txt-middle">등록자</th>
						<th class="txt-middle">등록일자</th>
						<th class="txt-middle">시작일</th>
						<th class="txt-middle">마감일</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(obj.list) eq 0}">
					<tr>
						<td colspan="8">조회된 리스트가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td class="txt-middle">${loop.count }</td>
						<td><a href="${contextPath}/adm/eventMgr/${list.GRP_CD }">${list.GRP_CD }</a></td>
						<td>${list.GRP_NM }</td>
						<td class="txt-middle">
							<c:if test="${list.USE_YN eq 'Y'}"><small class="label label-info">${list.USE_YN }</small></c:if>
							<c:if test="${list.USE_YN eq 'N'}"><small class="label label-danger">${list.USE_YN }</small></c:if>
						</td>
						<td class="txt-middle">${list.MODP_ID }</td>
						<td class="txt-middle">${list.MOD_DTM }</td>
						<td class="txt-middle">${list.START_DT }</td>
						<td class="txt-middle">${list.END_DT }</td>
					
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</section>
