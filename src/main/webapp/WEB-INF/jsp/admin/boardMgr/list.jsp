<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:set var="strActionUrl" value="${contextPath }/adm/boardMgr/${obj.BRD_GUBN}" />
<c:set var="strMethod" value="get" />

<style>
.content .box .paging_new{margin-top:30px}
.content .box .paging_new ul{display:flex;flex-direction:row;justify-content:center;align-items:center}
.content .box .paging_new li{width:30px;height:30px;}
.content .box .paging_new li a{display:block;width:30px;line-height:30px;font-size:14px;font-weight:500;color:#333;text-align:center;}
.content .box .paging_new li i{display:block;width:30px;height:30px}
.content .box .paging_new li.on a{background:#111;color:#fff;}
.content .box .paging_new li.start .ic{background:url("${contextPath}/resources/resources2/images/icon_page_start.png") no-repeat 50% 50%}
.content .box .paging_new li.end .ic{background:url("${contextPath}/resources/resources2/images/icon_page_end.png") no-repeat 50% 50%}
.content .box .paging_new li.prev .ic{background:url("${contextPath}/resources/resources2/images/icon_page_prev.png") no-repeat 50% 50%}
.content .box .paging_new li.next .ic{background:url("${contextPath}/resources/resources2/images/icon_page_next.png") no-repeat 50% 50%}
</style>
<c:choose>
	<c:when test="${empty obj.WRTR_ORDER or obj.WRTR_ORDER eq 'desc' }"><c:set var="WRTR_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="WRTR_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${empty obj.REPLY_ORDER or  obj.REPLY_ORDER eq 'desc' }"><c:set var="REPLY_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="REPLY_ORDER" value="desc" /></c:otherwise>
</c:choose>


<section class="content-header">
	<h1>
		<jsp:include page="${contextPath}/common/comCodName">
			<jsp:param name="COMM_CODE" value="BRD_GUBN" />
			<jsp:param name="COMD_CODE" value="${obj.BRD_GUBN }" />
			<jsp:param name="type" value="text" />
		</jsp:include>
		<small>문의 내역</small>
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
			<spform:form class="form-horizontal" name="qnaFrm" id="qnaFrm" method="${strMethod }" action="${strActionUrl }">
				<input type="hidden" id="ORDER_GUBUN" name="ORDER_GUBUN" value="${obj.ORDER_GUBUN }" />						<!-- 등록일 답변일 정렬 정렬 구분 -->
				<input type="hidden" id="WRTR_ORDER" name="WRTR_ORDER" value="${obj.WRTR_ORDER }" />							<!-- 등록일 정렬 -->
				<input type="hidden" id="REPLY_ORDER" name="REPLY_ORDER" value="${obj.REPLY_ORDER }" />							<!-- 답변일 정렬 -->
				<input type="hidden" id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" />	<!-- 목록수 -->
				
				<div class="box-body">
					<div class="form-group">
						<label class="col-sm-1 control-label">답변여부</label>
						<div class="col-sm-2">
							<select name="REPLY_YN" id="REPLY_YN" class="form-control select2">
								<option value="">전체</option>
								<option value="Y" ${obj.REPLY_YN eq 'Y' ? 'selected=selected':''}>답변</option>
								<option value="N" ${obj.REPLY_YN eq 'N' ? 'selected=selected':''}>미답변</option>
							</select>
						</div>
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
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('WRTR_ORDER');">등록일▼▲</button>
					    <button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('REPLY_ORDER');">답변일▼▲</button>
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
	</div>
	<!-- /.정렬 박스 -->
	
	<!-- 검색 박스 -->
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">문의 목록</h3>
			<div class="box-tools pull-right">				
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
						<th class="text-left">제목</th>
						<th class="text-center">성명</th>
						<th class="text-center">등록일</th>
						<th class="text-center">답변여부</th>
						<th class="text-center">답변일</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${obj.count eq 0}">
					<tr>
						<td colspan="7">조회된 내용이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td class="text-center">${list.RNUM }</td>
						<td class="text-left">
							<a href="${contextPath}/adm/boardMgr/${list.BRD_GUBN }/${list.BRD_NUM }">
							<b>[${list.BRD_GUBN_NM }]</b>&nbsp;${list.BRD_SBJT }</a>
						</td>
						<td class="text-center">${list.WRTR_NM }</td>
						<td class="text-center">${list.WRT_DTM }</td>
						<td class="text-center">
							${list.REPLY_YN eq 'Y' ? '<small class="label label-primary">Y</small>':'<small class="label label-warning">N</small>' }
						</td>
						<td class="text-center">${list.REPLY_DTM }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<paging:PageFooter totalCount="${ obj.count }" rowCount="${ obj.rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>
	</div>	
</section>

<script>
	//정렬 주문일 & 주문자명 클릭시 , 목록수 변경시
	function fn_order_by(str){		
		var frm=document.getElementById("qnaFrm");
		
		if(str != ""){
			frm.ORDER_GUBUN.value=str;
		}		
		frm.pagerMaxPageItems.value=$("#cnt").val();
		frm.submit();
	}
</script>