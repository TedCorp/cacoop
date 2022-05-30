<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:set var="strMethod" value="get" />
<c:choose>
	<c:when test="${obj.BRD_GUBN eq 'BRD_GUBN_04' }"><c:set var="strActionUrl" value="${contextPath }/adm/boardMgr/faq/${obj.BRD_GUBN}" /></c:when>
	<c:when test="${obj.BRD_GUBN eq 'BRD_GUBN_05' }"><c:set var="strActionUrl" value="${contextPath }/adm/boardMgr/notice/${obj.BRD_GUBN}" /></c:when>
</c:choose>
<c:choose>
	<c:when test="${empty obj.WRTR_ORDER or obj.WRTR_ORDER eq 'desc' }"><c:set var="DATE_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="WRTR_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${empty obj.REPLY_ORDER or  obj.REPLY_ORDER eq 'desc' }"><c:set var="MEMB_NM_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="REPLY_ORDER" value="desc" /></c:otherwise>
</c:choose>


<section class="content-header">
	<h1>
		<jsp:include page="${contextPath }/common/comCodName">
			<jsp:param name="COMM_CODE" value="BRD_GUBN" />
			<jsp:param name="COMD_CODE" value="${obj.BRD_GUBN }" />
			<jsp:param name="type" value="text" />
		</jsp:include>
		<small>목록</small>
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
			<spform:form class="form-horizontal" name="noticeFrm" id="noticeFrm" method="${strMethod }" action="${strActionUrl }">
				<input type="hidden" id="ORDER_GUBUN" name="ORDER_GUBUN" value="${obj.ORDER_GUBUN }" />						<!-- 주문일 정렬 -->
				<input type="hidden" id="DATE_ORDER" name="DATE_ORDER" value="${obj.WRTR_ORDER }" />								<!-- 등록일 정렬 -->
				<input type="hidden" id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" />	<!-- 목록수 -->
				
				<div class="box-body">
					<div class="form-group">
						<label class="col-sm-1 control-label">검색어</label>
						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2">
								<option value="WRTR_ID" ${obj.schGbn eq 'WRTR_ID' ? 'selected=selected':''}>아이디</option>
								<%-- <option value="WRTR_NM" ${obj.schGbn eq 'WRTR_NM' ? 'selected=selected':''}>성명</option> --%>
							</select>
						</div>
						<div class="col-sm-5">
							<div class="input-group">
								<input type="search" class="form-control" name="schTxt" id="schTxt" placeholder="검색어 입력" value="${obj.schTxt }">
								<span class="input-group-btn">
									<button type="submit" class="btn btn-success pull-right">검색</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			<!-- /.box-body -->
			</spform:form>
		</div>
	</div>
	<!-- /.검색 박스 -->
	
	<!-- 정렬 박스 -->
	<div class="box box-default">
		<div class="box-body">
			<div class="box-body">
				<div class="form-group">
					<label class="col-sm-1 control-label txt-right">정렬</label>
					<div class="col-sm-9">
						<button type="button" class="btn btn-sm" onclick="javascript:fn_order_by('WRTR_ORDER');">등록일▼▲</button>
					</div>
					
					<label class="col-sm-1 control-label txt-left">목록수</label>
					<div class="col-sm-1">
		                <select name="cnt" id="cnt" class="form-control select2" onchange="javascript:fn_order_by();">
							<option value="10" ${obj.pagerMaxPageItems eq '10' ? 'selected=selected':''}>10</option>
							<option value="20" ${obj.pagerMaxPageItems eq '20' ? 'selected=selected':''}>20</option>
							<option value="30" ${obj.pagerMaxPageItems eq '30' ? 'selected=selected':''}>30</option>
							<option value="40" ${obj.pagerMaxPageItems eq '40' ? 'selected=selected':''}>40</option>
							<option value="50" ${obj.pagerMaxPageItems eq '50' ? 'selected=selected':''}>50</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.정렬 박스 -->
	
	<!-- 검색 박스 -->
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">글 목록</h3>
			<div class="box-tools">
				<a href="${contextPath }/adm/boardMgr/new/${obj.BRD_GUBN}" class="btn btn-sm btn-primary pull-right">신규등록</a>
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
						<th class="text-center">순번</th>
						<th>제목</th>
						<th class="text-center">성명</th>
						<th class="text-center">등록일</th>
						<th class="text-center">수정일</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${obj.count eq 0}">
					<tr>
						<td colspan="5">조회된 내용이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td class="text-center">${list.RNUM }</td>
						<td><a href="${strActionUrl }/${list.BRD_NUM }">${list.BRD_SBJT }</a></td>
						<td class="text-center">${list.WRTR_NM }</td>
						<td class="text-center">${list.REG_DTM }</td>
						<td class="text-center">${list.MOD_DTM }</td>
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
	/* 정렬 주문일 & 주문자명 클릭시 , 목록수 변경시 */
	function fn_order_by(str){		
		var frm=document.getElementById("noticeFrm");
		
		if(str != ""){
			frm.ORDER_GUBUN.value=str;
		}		
		frm.pagerMaxPageItems.value=$("#cnt").val();
		frm.submit();
	}
</script>