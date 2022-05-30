<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		메뉴 관리
		<small>메뉴 목록</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">	
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">메뉴 목록</h3>
			<div class="box-tools">
				<a href="${contextPath}/adm/menuMgr/new" class="btn btn-primary btn-sm pull-right">신규등록</a>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered">
				<colgroup>
					<col />
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th class="txt-middle">번 호</th>
						<th>코드</th>
						<th>메뉴명</th>
						<th>URL</th>
						<th class="txt-middle">출력여부</th>
						<th class="txt-middle">정렬순서</th>
						<th class="txt-middle">수정자</th>
						<th class="txt-middle">수정일</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(obj.list) eq 0}">
					<tr>
						<td colspan="8">조회된 메뉴가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td class="txt-middle">${loop.count }</td>
						<td>${list.MENU_CD }</td>
						<td><a href="${contextPath}/adm/menuMgr/${list.MENU_CD }">${list.MENU_NAME }</a></td>
						<td>${list.MENU_URL }</td>
						<td class="txt-middle">
							<c:if test="${list.OUTPT_FG eq 'Y'}"><small class="label label-info">${list.OUTPT_FG }</small></c:if>
							<c:if test="${list.OUTPT_FG eq 'N'}"><small class="label label-danger">${list.OUTPT_FG }</small></c:if>
						</td>
						<td class="txt-middle">${list.SORT_ORDR }</td>
						<td class="txt-middle">${list.MODP_ID }</td>
						<td class="txt-middle">${list.MOD_DTM }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		
	</div>
	
</section>
