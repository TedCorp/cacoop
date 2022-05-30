<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		주문내역 목록	
		<small>주문내역 목록</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<c:set var="strActionUrl" value="${contextPath }/adm/requestMgr" />
<c:set var="strMethod" value="get" />

<c:choose>
<c:when test="${empty obj.DATE_ORDER or obj.DATE_ORDER =='desc' }"><c:set var="DATE_ORDER" value="asc" /></c:when>
<c:otherwise><c:set var="DATE_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
<c:when test="${empty obj.COM_NAME_ORDER or  obj.COM_NAME_ORDER =='desc' }"><c:set var="COM_NAME_ORDER" value="asc" /></c:when>
<c:otherwise><c:set var="COM_NAME_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
<c:when test="${empty obj.STAFF_NAME_ORDER or  obj.STAFF_NAME_ORDER =='desc' }"><c:set var="STAFF_NAME_ORDER" value="asc" /></c:when>
<c:otherwise><c:set var="STAFF_NAME_ORDER" value="desc" /></c:otherwise>
</c:choose>


<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">주문내역검색 조건</h3>

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
				<input type="hidden" id="DATE_ORDER" name="DATE_ORDER" value="${DATE_ORDER }" /><!-- 주문일 정렬 -->
				<input type="hidden" id="DATE_ORDER" name="COM_NAME_ORDER" value="${COM_NAME_ORDER }" /><!-- 주문일 정렬 -->
				<input type="hidden" id="DATE_ORDER" name="STAFF_NAME_ORDER" value="${STAFF_NAME_ORDER }" /><!-- 주문일 정렬 -->
				
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">주문상태</label>
						<div class="col-sm-2">
			                <jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="XORDER_CON" />
								<jsp:param name="name" value="ORDER_CON" />
								<jsp:param name="value" value="${param.ORDER_CON }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</div>
						<!--div class="col-sm-2">
			                <jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="PAY_METD" />
								<jsp:param name="name" value="PAY_METD" />
								<jsp:param name="value" value="${obj.PAY_METD }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</div-->
						<div class="col-sm-7"></div>
					</div>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">기간별 조회</label>
						
						<div class="col-sm-5">
							<div class="form-group">
								<div class="col-sm-5">
									<input type="text" class="form-control pull-left" name="datepickerStr" id="datepickerStr" value="${obj.datepickerStr }">
								</div>
								<div class="col-sm-1">
									~
								</div>
								<div class="col-sm-6">
									<input type="text" class="form-control pull-right" name="datepickerEnd" id="datepickerEnd" value="${obj.datepickerEnd }">
								</div>
							</div>
						</div>
						<label for="inputEmail3" class="col-sm-1 control-label">검색조건</label>
						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2" style="width: 100%;">
								<option value="COM_NAME" ${obj.schGbn == 'COM_NAME' ? 'selected=selected':''}>업체명</option>
								<option value="MEMB_NM" ${obj.schGbn == 'STAFF_NAME' ? 'selected=selected':''}>담당자명</option>
							</select>
						</div>
						<div class="col-sm-2">
							<input name="schTxt" id="schTxt" type="text" class="form-control" placeholder="검색어 입력" value="${obj.schTxt }">
						</div>
						<div class="col-sm-1">
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

	<!-- 검색 박스 -->
	<div class="box box-primary">
		<!-- /.box-header -->
		<div class="box-body">
			<form class="form-horizontal">
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">정렬</label>
						<div class="col-sm-6">
							<button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('DATE_ORDER');">주문일▼▲</button>
			                <button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('COM_NAME');">업체명▼▲</button>
			                <button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('STAFF_NAME');">담당자명▼▲</button>
						</div>
						<div class="col-sm-2">
						</div>
						<div class="col-sm-4 pull-right">
			                <button type="button" class="btn btn-primary btn-sm pull-right" id="btnExcel">엑셀저장</button>
						</div>
						<!-- label for="inputEmail3" class="col-sm-1 control-label">목록수</label>
						<div class="col-sm-2">
			                <select name="cnt" id="cnt" class="form-control select2" style="width: 100%;" onchange="javascript:fn_order_by();">
								<option value="10" ${obj.pagerMaxPageItems == '10' ? 'selected=selected':''}>10</option>
								<option value="20" ${obj.pagerMaxPageItems == '20' ? 'selected=selected':''}>20</option>
								<option value="30" ${obj.pagerMaxPageItems == '30' ? 'selected=selected':''}>30</option>
								<option value="40" ${obj.pagerMaxPageItems == '40' ? 'selected=selected':''}>40</option>
								<option value="50" ${obj.pagerMaxPageItems == '50' ? 'selected=selected':''}>50</option>
							</select>
						</div -->
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
					<col style="with:50px" />
				</colgroup>
				<thead>
					<tr>
						<!-- th><input type="checkbox" id="CHK_ALL" name="CHK_ALL" onclick="javascript:fn_all_chk();" /></th -->
						<th>주문일시</th>
						<th>주문번호</th>
						<th>업체명(사업자등록번호)</th>
						<th>담당자명</th>
						<th>총 주문금액</th>
						<th>주문상태</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${ empty obj.list}">
					<tr>
						<td colspan="8">조회된 주문내역이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<!-- td><input type="checkbox" id="CHK${loop.count }" name="CHK${loop.count }" value="${list.ORDER_NUM }"/></td -->
						<td>${list.ORDER_DATE }</td>
						<td><a href="${contextPath}/adm/requestMgr/form/${list.ORDER_NUM }">${list.ORDER_NUM }</a></td>
						<td>${list.COM_NAME }(${list.BIZR_NUM })</td>
						<td>${list.STAFF_NAME }(${list.STAFF_CPON })</td>
						<td><fmt:formatNumber value="${list.ORDER_AMT }" /> </td>
						<td>${list.ORDER_CON_NM }</td>
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
	$(function() {

		//Date picker
		$('#datepickerStr').datepicker({
			autoclose: true,
			format: 'yyyy-mm-dd'
		});
		$('#datepickerEnd').datepicker({
			autoclose: true,
			format: 'yyyy-mm-dd'
		});

	    // 목록가기
	    $("#btnExcel").click(function() {
	    	var strAction = "${contextPath }/adm/requestMgr/excelDown";
	        var $form = $('<form method="get" action="'+strAction+'"></form>');
	        $form.appendTo('body');

	        $form.submit();
	    });
	    
	});
	
	//정렬 주문일 & 주문자명 클릭시 , 목록수 변경시
	function fn_order_by(str){
		
		var frm=document.getElementById("orderFrm");
		if(str != ""){
			frm.ORDER_GUBUN.value=str;
		}
		
		frm.submit();
	}
	
	//전체 체크 및 해제 시
	function fn_all_chk(){
		var check_yn = false;		
		if($("#CHK_ALL").is(":checked")){
			check_yn = true;
		}
		for(var i=1;i<= ${fn:length(obj.list) };i++){
			$("#CHK"+i).prop("checked",check_yn);
		}
	}
	
	
</script>