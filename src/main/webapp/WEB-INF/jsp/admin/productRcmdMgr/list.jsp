<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		추천상품관리	
		<small>그룹 목록</small>
	</h1>
</section>

<section class="content">
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">추천그룹 목록</h3>
			<div class="box-tools">			
				<a href="${contextPath}/adm/productRcmdMgr/new" class="btn btn-primary btn-sm pull-right">신규등록</a>			
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
						<th>그룹코드</th>
						<th>그룹명</th>
						<th class="txt-middle">사용여부</th>
						<th class="txt-middle">정렬순서</th>
						<th>그룹구분</th>
						<th class="txt-middle">수정일</th>
						<th class="txt-middle">수정자</th>
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
						<td><a href="${contextPath}/adm/productRcmdMgr/${list.GRP_CD }">${list.GRP_CD }</a></td>
						<td>${list.GRP_NM }</td>
						<td class="txt-middle">
							<c:if test="${list.USE_YN eq 'Y'}"><small class="label label-info">${list.USE_YN }</small></c:if>
							<c:if test="${list.USE_YN eq 'N'}"><small class="label label-danger">${list.USE_YN }</small></c:if>
						</td>
						<td class="txt-middle">${list.SORT_ORDR }</td>
						<td>${list.RCMD_GUBN_NM }</td>
						<td class="txt-middle">${list.MODP_ID }</td>
						<td class="txt-middle">${list.MOD_DTM }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		
	</div>
	
</section>
