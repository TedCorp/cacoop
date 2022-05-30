<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		<jsp:include page="/common/comCodName">
			<jsp:param name="COMM_CODE" value="BRD_GUBN" />
			<jsp:param name="COMD_CODE" value="${obj.BRD_GUBN }" />
			<jsp:param name="type" value="text" />
		</jsp:include>
		<small></small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>


<c:set var="strActionUrl" value="${contextPath }/adm/boardMgr/type04/${obj.BRD_GUBN}" />
<c:set var="strMethod" value="get" />

<c:choose>
<c:when test="${empty obj.WRTR_ORDER or obj.WRTR_ORDER =='desc' }"><c:set var="DATE_ORDER" value="asc" /></c:when>
<c:otherwise><c:set var="WRTR_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
<c:when test="${empty obj.REPLY_ORDER or  obj.REPLY_ORDER =='desc' }"><c:set var="MEMB_NM_ORDER" value="asc" /></c:when>
<c:otherwise><c:set var="REPLY_ORDER" value="desc" /></c:otherwise>
</c:choose>


<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">
			<jsp:include page="/common/comCodName">
				<jsp:param name="COMM_CODE" value="BRD_GUBN" />
				<jsp:param name="COMD_CODE" value="${obj.BRD_GUBN }" />
				<jsp:param name="type" value="text" />
			</jsp:include> 조건
			</h3>

			<div class="box-tools pull-right">
				<button type="button" class="btn btn-box-tool"
					data-widget="collapse">
					<i class="fa fa-minus"></i>
				</button>
				<button type="button" class="btn btn-box-tool" data-widget="remove">
					<i class="fa fa-remove"></i>
				</button>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			
			<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
				<input type="hidden" id="ORDER_GUBUN" name="ORDER_GUBUN" value="${obj.ORDER_GUBUN }" /><!-- 주문일 정렬 -->
				<input type="hidden" id="DATE_ORDER" name="DATE_ORDER" value="${WRTR_ORDER }" /><!-- 등록일 정렬 -->
				<input type="hidden" id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" /><!-- 목록수 -->
				
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">검색조건</label>
						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2" style="width: 100%;">
								<option value="WRTR_ID" ${obj.schGbn == 'WRTR_ID' ? 'selected=selected':''}>아이디</option>
								<option value="WRTR_NM" ${obj.schGbn == 'WRTR_NM' ? 'selected=selected':''}>성명</option>
							</select>
						</div>
						<div class="col-sm-2">
							<input name="schTxt" id="schTxt" type="text" class="form-control" placeholder="검색어 입력" value="${obj.schTxt }">
						</div>
						<div class="col-sm-7">
							<button type="submit" class="btn btn-success pull-right">검색</button>
						</div>
					</div>
				</div>
			<!-- /.box-body -->
			</spform:form>
			
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.box -->
	<div class="box-header with-border">
		<h3 class="box-title"></h3>
		<div class="box-tools">
			<a href="${contextPath }/adm/boardMgr/type04/${obj.BRD_GUBN}/new" class="btn btn-sm btn-primary pull-right">등록</a>
		</div>
	</div>
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<!-- /.box-header -->
		<div class="box-body">
			<form class="form-horizontal">
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">정렬</label>
						<div class="col-sm-2">
							<button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('WRTR_ORDER');">등록일▼▲</button>
						</div>
						<div class="col-sm-5"></div>
						<div class="col-sm-4">
							<label for="inputEmail3" class="col-sm-6 control-label">목록수</label>
							<div class="col-sm-3">
				                <select name="cnt" id="cnt" class="form-control select2" style="width: 100%;" onchange="javascript:fn_order_by();">
									<option value="10" ${obj.pagerMaxPageItems == '10' ? 'selected=selected':''}>10</option>
									<option value="20" ${obj.pagerMaxPageItems == '20' ? 'selected=selected':''}>20</option>
									<option value="30" ${obj.pagerMaxPageItems == '30' ? 'selected=selected':''}>30</option>
									<option value="40" ${obj.pagerMaxPageItems == '40' ? 'selected=selected':''}>40</option>
									<option value="50" ${obj.pagerMaxPageItems == '50' ? 'selected=selected':''}>50</option>
								</select>
							</div>
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
					<col style="with:300px" />
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th>순번</th>
						<th>제목</th>
						<th>성명</th>
						<th>등록일</th>
						<th>삭제여부</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${obj.count == 0}">
					<tr>
						<td colspan="4">조회된 내용이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td>${loop.count }</td>
						<td><a href="${contextPath}/adm/boardMgr/type04/${list.BRD_GUBN }/${list.BRD_NUM }">${list.BRD_SBJT }</a></td>
						<td>${list.WRTR_NM }</td>
						<td>${list.WRT_DTM }</td>
						<td>${list.DEL_YN }</td>
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

<script>
	//정렬 주문일 & 주문자명 클릭시 , 목록수 변경시
	function fn_order_by(str){
		
		var frm=document.getElementById("orderFrm");
		if(str != ""){
			frm.ORDER_GUBUN.value=str;
		}
		
		frm.pagerMaxPageItems.value=$("#cnt").val();
		frm.submit();
	}
	
	
</script>