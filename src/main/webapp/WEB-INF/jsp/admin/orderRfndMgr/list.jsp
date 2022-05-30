<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="/layout/inc/taglib.jsp" %>
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
	<c:when test="${empty obj.DATE_ORDER or obj.DATE_ORDER eq 'desc' }"><c:set var="DATE_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="DATE_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${empty obj.MEMB_NM_ORDER or  obj.MEMB_NM_ORDER eq 'desc' }"><c:set var="MEMB_NM_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="MEMB_NM_ORDER" value="desc" /></c:otherwise>
</c:choose>

<section class="content-header">
	<h1>
		환불접수
		<small>환불접수 목록</small>
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
			<spform:form class="form-horizontal" name="refundFrm" id="refundFrm" method="GET" action="${contextPath }/adm/orderRfndMgr">
				<input type="hidden" id="ORDER_GUBUN" name="ORDER_GUBUN" value="${obj.ORDER_GUBUN }" />						<!-- 주문일 정렬 -->
				<input type="hidden" id="DATE_ORDER" name="DATE_ORDER" value="${DATE_ORDER }" />							<!-- 주문일 정렬 -->
				<input type="hidden" id="MEMB_NM_ORDER" name="MEMB_NM_ORDER" value="${MEMB_NM_ORDER }" />					<!-- 주문자명 정렬 -->
				<input type="hidden" id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" />	<!-- 목록수 -->
				<input type="hidden" id="CNCL_CON_STATE" name="CNCL_CON_STATE" value="" />									<!-- 주문취소 상태 변수 -->
				<input type="hidden" id="CNCL_CON_ORDER_NUM" name="CNCL_CON_ORDER_NUM" value="" />							<!-- 주문취소 상태 체크 항목 -->
				
				<div class="box-body">
					<div class="form-group">
						<label for="ORDER_CON" class="col-sm-1 control-label">환불상태</label>
						<div class="col-sm-2">
			                <jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="RFND_CON" />
								<jsp:param name="name" value="schParam" />
								<jsp:param name="value" value="${obj.schParam }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="전체" />
							</jsp:include>
						</div>
						<div class="col-sm-2">
			                <jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="PAY_METD" />
								<jsp:param name="name" value="PAY_METD" />
								<jsp:param name="value" value="${obj.PAY_METD }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="전체" />
							</jsp:include>
						</div>
					</div>
					
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">신청기간</label>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">
								<input type="text" class="form-control pull-left" name="datepickerStr" id="datepickerStr" value="${obj.datepickerStr }" placeholder="시작일" readonly>
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>							
						</div>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">
								<input type="text" class="form-control pull-right" name="datepickerEnd" id="datepickerEnd" value="${obj.datepickerEnd }" placeholder="종료일" readonly>
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
						</div>
						
						<label for="schGbn" class="col-sm-1 control-label">검색어</label>
						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2">
								<option value="MEMB_NM" ${obj.schGbn eq 'MEMB_NM' ? 'selected=selected':''}>주문자명</option>
								<option value="ORIGIN_NUM" ${obj.schGbn eq 'ORIGIN_NUM' ? 'selected=selected':''}>원주문번호</option>
							</select>
						</div>
						<div class="col-sm-3">
							<div class="input-group">
								<input type="search" class="form-control" name="schTxt" id="schTxt" placeholder="검색어 입력" value="${obj.schTxt }">
								<span class="input-group-btn">
									<button type="submit" class="btn btn-success pull-right">검색</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</spform:form>			
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.검색박스 -->
	
	<!-- 정렬박스 -->
	<div class="box box-default">
		<div class="box-body">
			<div class="box-body">
				<div class="form-group">
					<label for="btnSort" class="col-sm-1 control-label">정렬</label>
					<div class="col-sm-9">
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('MEMB_NM_ORDER');">주문자명▼▲</button>
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('RFND_REQDTM');">환불요청 일시▼▲</button>
					</div>
					
					<label for="pagerMax" class="col-sm-1 control-label">목록수</label>
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
	
	<!--<div class="row" style="padding-bottom:5px;">
		<div class="col-xs-12">
			<button type="button" class="btn btn-primary btn-sm pull-right left-5" id="btnRefund" value="RFND_CON_03">환불승인</button>
			<button type="button" class="btn btn-danger btn-sm pull-right left-5" id="btnState" value="RFND_CON_02">환불거절</button>
		</div>
	</div>
	 /.환불상태 변경버튼 -->
	
	
	
	<!--  -->
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">환불접수 목록</h3>
		</div>
		<!-- /.box-header -->
		<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
			<table class="table table-bordered">
				<colgroup>
						<col style="width:3%;"/>
						<col style="width:5%;"/>
						<col style="width:15%;"/>
						<col style="width:15%;"/>
						<col style="width:12%;"/>
						<col style="width:38%;"/>
						<col style="width:12%;"/>
				</colgroup>
				<thead>
					<tr>
						<th class="txt-center">
							<input type="checkbox" id="CHK_ALL" name="CHK_ALL" onclick="javascript:fn_all_chk();" />
						</th>
						<th class="txt-middle">번호</th>
						<th class="txt-middle">환불번호</th>
						<th class="txt-middle">환불요청일시</th>
						<th class="txt-middle">주문자명</th>
						<th class="txt-middle">환불요청상품</th>
						<th class="txt-right">환불상품소계</th>
						<!-- <th class="txt-right">반품배송료</th>
						<th class="txt-right">환불예정금액</th>
					 	<th class="txt-middle">주문상태</th>
						<th class="txt-middle">환불상태</th> -->
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${obj.list }" var="list" varStatus="loop">
						<tr>
							<td class="txt-center">
								<input type="checkbox" id="CHK${loop.count }" name="chkOrdList" value="${list.ORDER_NUM }"/>
							</td>
							<td>${list.RNUM }</td>
							<td class="txt-middle">
								<a href="${contextPath}/adm/orderRfndMgr/form/${list.ORDER_NUM }">${list.ORDER_NUM }</a>
							</td>
							<td class="txt-middle">${list.ORDER_DATE}</td>
							<td class="txt-middle">${list.MEMB_NM }</td>
							<td class="txt-middle">${list.PD_NAME }</td>
							<td class="txt-right">
								<fmt:formatNumber value="${list.ORDER_AMT}" />
							</td>
						<%-- 	<td class="txt-right">
								<fmt:formatNumber value="${list.DLVY_AMT }" />
							</td>
							<td class="txt-right">
								<fmt:formatNumber value="${list.ORDER_AMT }" />
							</td> --%>
							<%-- <td class="txt-middle">
								<small class="label label-warning">${list.ORDER_CON_NM }</small>
							</td>
							<td class="txt-middle">
							${tb_odinfoxm.RFND_CON_NM }ㅋ
								<c:choose>
									<c:when test="${!empty list.RFND_CON and list.RFND_CON eq 'RFND_CON_03' }"><small class="label label-primary">${list.RFND_CON_NM }</small></c:when>
									<c:when test="${!empty list.RFND_CON and list.RFND_CON eq 'RFND_CON_02' }"><small class="label label-primary">${list.RFND_CON_NM }</small></c:when>
									<c:when test="${!empty list.RFND_CON and list.RFND_CON eq 'RFND_CON_01' }"><small class="label label-danger">${list.RFND_CON_NM }</small></c:when>
									<c:otherwise><small class="label label-default">${list.RFND_CON_NM }</small></c:otherwise>
								</c:choose>							
							</td> --%>
						</tr>
					</c:forEach>
					<c:if test="${obj.count eq 0}">
						<tr><td colspan="8">조회된 내역이 없습니다.</td></tr>
					</c:if>
				</tbody>
			</table>
		</div>
		
		<!-- 페이징 -->
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>

	</div>
	
	<!-- 환불상태 변경버튼
	<div class="row">
		<div class="col-xs-12">
			<button type="button" class="btn btn-primary btn-sm pull-right left-5" id="btnRefund" value="CNCL_CON_03">환불승인</button>
			<button type="button" class="btn btn-danger btn-sm pull-right left-5" id="btnState" value="CNCL_CON_02">환불거절</button>
		</div>
	</div> -->
</section>

<!-- 상태변경 -->
<form name="stateFrm" id="stateFrm" method="post" action="${contextPath }/adm/orderRfndMgr">
	<input type="hidden" id="stateArray" name="stateArray" value="" />
	<input type="hidden" id="statePay" name="PAY_METD" value="" />
	<input type="hidden" id="stateOrd" name="ORDER_CON" value="" />
	<input type="hidden" id="stateCncl" name="CNCL_CON" value="" />
</form>

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
	

	/* 주문상태 일괄변경
	$("#btnState").click(function(){
		// 체크항목
		var checkboxValues =[];
		var cnclState = $(this).val();
		
		$("input:checkbox[name=chkOrdList]:checked").each(function(){
			console.log($(this).val());
			checkboxValues.push($(this).val());
		});
		
		if(!checkboxValues){
			checkboxValues.push("");	
			alert("취소상태를 변경할 항목을 체크해주세요.");
			return;
			
		} else {
			if(!confirm("선택한 주문의 상태를 변경하시겠습니까?")) return;
		}

		//입금확인 무통장 체크
		if(cnclState == "CNCL_CON_03"){
			$('#stateOrd').val("ORDER_CON_04");	// 취소승인
		}
		
		$('#stateArray').val(checkboxValues);
		$('#stateCncl').val(cnclState);
		$('#stateFrm').submit();
	}); */
});

//정렬 주문일 & 주문자명 클릭시 , 목록수 변경시
function fn_order_by(str){		
	var frm=document.getElementById("refundFrm");
	if(str != ""){
		frm.ORDER_GUBUN.value=str;
	}
	frm.pagerMaxPageItems.value=$("#cnt").val();
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