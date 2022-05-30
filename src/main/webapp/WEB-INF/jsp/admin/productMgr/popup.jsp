<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		상품 정보 테이블
		<small>상품 목록</small>
	</h1>
</section>

<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">

		<!-- /.box-header -->
		<div class="box-body">
			<form class="form-horizontal">
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">검색어</label>

						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2" style="width: 100%;">
								<option value="GOODS_NAME" selected="selected">상품명</option>
								<option value="POS_NAME">POS명</option>
								<option value="GUBUN">레벨</option>
							</select>
						</div>
						<div class="col-sm-8">
							<input name="schTxt" type="text" class="form-control" placeholder="검색어 입력" value="${param.schTxt }">
						</div>
						<div class="col-sm-1">
							<button type="submit" class="btn btn-success pull-right">검색</button>
						</div>
					</div>
				</div>
				<!-- /.row -->
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.box -->
	<!-- 검색 박스 -->
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
					<col />
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>상품명</th>
						<th>포스상품명</th>
						<th>단위</th>
						<th>1레벨</th>
						<th>2레벨</th>
						<th>3레벨</th>
						<th>4레벨</th>
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
						<td>${list.GOODS_NAME }</td>
						<td><a href="#" onclick="fn_value('${list.GOODS_CODE }','${list.POS_NAME }','${list.CAGO_ID }','${list.CAGO_NAME }');">${list.POS_NAME }</a></td>
						<td>${list.STDARD }</td>
						<td>${list.GUBUN1 }</td>
						<td>${list.GUBUN2 }</td>
						<td>${list.GUBUN3 }</td>
						<td>${list.GUBUN4 }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>

		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>

	</div>
	
</section>
<script type="text/javascript">
$(function() {
	<c:if test="${!empty param.schGbn}">
		$('#schGbn').val('${param.schGbn}');
	</c:if>
	 
});

function fn_value(GOODS_CODE,POS_NAME,CAGO_ID,CAGO_NAME){
	opener.fn_popup_return(GOODS_CODE,POS_NAME,CAGO_ID,CAGO_NAME);
	window.close();
}
</script>