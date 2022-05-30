<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		공통코드관리
		<small>공통코드 목록</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">	
	<div class="box">		
		<div class="box-header with-border">
			<h3 class="box-title">공통코드 목록</h3>
			<div class="box-tools">
				<a href="${contextPath}/adm/comCodMgr/new" class="btn btn-primary btn-sm pull-right">등록</a>
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
						<th class="txt-middle">순번</th>
						<th>코드명</th>
						<th>코드</th>
						<th class="txt-middle">사용여부</th>
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
						<td>${list.COMCOD_NAME}</td>
						<td><a href="${contextPath}/adm/comCodMgr/${list.COMM_CODE }">${list.COMM_CODE }</a></td>
						<td class="txt-middle">
							<c:if test="${list.USE_YN eq 'Y'}"><small class="label label-info">${list.USE_YN }</small></c:if>
							<c:if test="${list.USE_YN eq 'N'}"><small class="label label-danger">${list.USE_YN }</small></c:if>
						</td>
						<td class="txt-middle">${list.MODP_ID }</td>
						<td class="txt-middle">${list.MOD_DTM }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		
	</div>
	
</section>
