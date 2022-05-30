<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		택배사코드
		<small>택배사코드</small>
	</h1>
</section>

<section class="content">
	<div class="box">
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered">
				<colgroup>
					<col style="with:10px" />					
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>코드</th>
						<th>메뉴명</th>						
					</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(obj.list) == 0}">
					<tr>
						<td colspan="6">조회된 메뉴가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td>${loop.count }</td>
						<td>${list.COMD_CODE }</td>
						<td>${list.COMDCD_NAME }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		
	</div>
	
</section>

<script type="text/javascript">
</script>