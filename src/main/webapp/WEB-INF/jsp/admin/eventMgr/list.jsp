<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		행사관리
	</h1>
</section>

<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">검색 조건</h3>
			<div class="box-tools pull-right">
				<button type="button" class="btn btn-box-tool" data-widget="collapse">
					<i class="fa fa-minus"></i>
				</button>
				<button type="button" class="btn btn-box-tool" data-widget="remove">
					<i class="fa fa-remove"></i>
				</button>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<form class="form-horizontal">
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">행사명</label>
						<div class="col-sm-10">
							<input name="schTxt" type="text" class="form-control" placeholder="행사명 입력" value="${param.schTxt }">
						</div>
						<div class="col-sm-1">
							<button type="submit" class="btn btn-success pull-right">검색</button>
						</div>
					</div>
				</div>
				<!-- /.row -->
			</form>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.box -->
	<!-- 검색 박스 -->

	<spform:form id="adTable" name="adTable" action="${contextPath}/adm/eventMgr/copyInsert" method="post">
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">목록</h3>
			<div class="box-tools">
				<a href="${contextPath}/adm/eventMgr/new?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }${link}" class="btn btn-sm btn-primary pull-right" style="margin-right: 10px; margin-bottom: 20px;">등록</a>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered">
				<colgroup>
					<col style="with:20px" />
					<col style="with:20px" />
					<col style="with:80px" />
					<col style="with:110px" />
					<col style="with:150px" />
					<col style="with:70px" />
				</colgroup>
				<thead>
					<tr>
                       	<th><input type="checkbox" id="allCheck"/></th>
						<th>번호</th>
						<th>행사번호</th>
						<th>행사명</th>
						<th>행사기간</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${obj.list }" var="ent" varStatus="loop">
					<tr>
                        <td><input name="adIdArr" value="${ent.AD_ID }" type="checkbox"/></td>
                        <td>${loop.count }</td>
						<td><a href="${contextPath }/adm/eventMgr/edit/${ent.EVENT_ID }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }${link}"><c:out value="${ent.EVENT_ID }" escapeXml="true"/></a></td>
						<td><a href="${contextPath }/adm/eventMgr/edit/${ent.EVENT_ID }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }${link}">${ent.EVENT_NAME }</a></td>							
						<td>${ent.START_DT } ~ ${ent.END_DT }</td>
						<td>${ent.REG_DTM }</td>						
					</tr>
				</c:forEach>
				<c:if test="${obj.count == 0}">
					<tr>
						<td colspan="8" align="center">조회된 내용이 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</div>
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>
	</div>
	</spform:form>
</section>

<script type="text/javascript">
$(function(){
	$("#allCheck").click(function(){
		if($("#allCheck").prop("checked")) {
			$("input[type=checkbox]").prop("checked",true);
		} else {
			$("input[type=checkbox]").prop("checked",false);
		}
	});
});
</script>