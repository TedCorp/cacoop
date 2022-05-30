<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		진입카테고리관리	
		<!-- <small>그룹 목록</small> -->
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">
	<div class="box-footer">
		<%-- <a href="${contextPath}/adm/entryCategoryRcmdMgr/new" class="btn btn-default pull-right" style="margin-left:5px;">등록</a> --%>
	</div>
	
	<div class="box">
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered">
				<colgroup>
					<col style="with:10px" />
					<col />
					<col style="with:200px" />
					<col />
					<col />
					<!-- <col /> -->
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>코드</th>
						<th>진입카테고리명</th>
						<th>사용여부</th>
						<th>정렬순서</th>
						<!-- <th>그룹구분</th> -->
						<th>수정자</th>
						<th>수정일</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(obj) == 0}">
					<tr>
						<td colspan="8">조회된 리스트가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj}" var="list" varStatus="loop">
					<tr>
						<td>${loop.count }</td>
						<td><a href="${contextPath}/adm/entryCategoryRcmdMgr/${list.ENTRY_ID }">${list.ENTRY_ID }</a></td>
						<td>${list.ENTRY_NAME }</td>
						<td>${list.USE_YN }</td>
						<td>${list.SORT_ORDR }</td>
						<%-- <td>${list.RCMD_GUBN_NM }</td> --%>
						<td>${list.MODP_ID }</td>
						<td>${list.MOD_DTM }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		
	</div>
	
</section>
