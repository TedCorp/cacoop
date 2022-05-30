<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<script src="${contextPath }/resources/js/jquery-barcode-2.0.2.min.js"></script>

<c:set var="strActionUrl" value="${contextPath }/adm/orderCmptMgr" />
<c:set var="strMethod" value="get" />

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
		전표관리
		<small>확정전표내역</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
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
			<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">				
				<input type="hidden" id="ORDER_GUBUN" name="ORDER_GUBUN" value="${obj.ORDER_GUBUN }" />						<!-- 주문일 정렬 -->
				<input type="hidden" id="DATE_ORDER" name="DATE_ORDER" value="${DATE_ORDER }" />									<!-- 주문일 정렬 -->
				<input type="hidden" id="MEMB_NM_ORDER" name="MEMB_NM_ORDER" value="${MEMB_NM_ORDER }" />				<!-- 주문자명 정렬 -->
				<input type="hidden" id="COM_NAME_ORDER" name="COM_NAME_ORDER" value="${COM_NAME_ORDER }" />			<!-- 사업사상호 정렬 -->
				<input type="hidden" id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" />	<!-- 목록수 -->
				
				<div class="box-body">
					<div class="form-group">
						<label class="col-sm-1 control-label">결제상태</label>
						<div class="col-sm-2">
			                <jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="PAY_METD" />
								<jsp:param name="name" value="PAY_METD" />
								<jsp:param name="value" value="${obj.PAY_METD }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="전체" />
							</jsp:include>
						</div>						
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label">기간별 조회</label>						
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">		
								<input type="text" class="form-control pull-left" readonly="readonly" name="datepickerStr" id="datepickerStr" value="${obj.datepickerStr }" placeholder="시작일">
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>							
						</div>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">		
								<input type="text" class="form-control pull-right" readonly="readonly" name="datepickerEnd" id="datepickerEnd" value="${obj.datepickerEnd }" placeholder="종료일">
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>							
						</div>
						
						<label class="col-sm-1 control-label">검색어</label>
						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2">
								<option value="MEMB_NM" ${obj.schGbn eq 'MEMB_NM' ? 'selected=selected':''}>주문자명</option>
								<option value="RECV_PERS" ${obj.schGbn eq 'RECV_PERS' ? 'selected=selected':''}>수령자명</option>
								<option value="COM_NAME" ${ obj.schGbn eq 'COM_NAME' ? "selected='selected'":''}>사업자상호</option>
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
				<!-- /.box-body -->
			</spform:form>
		</div>
	</div>
	<!-- /.검색 박스 -->
	
	<div class="box box-default">		
		<div class="box-body">
			<div class="box-body">
				<div class="form-group">
					<label class="col-sm-1 control-label">정렬</label>
					<div class="col-sm-9">
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('DATE_ORDER');">주문일▼▲</button>
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('MEMB_NM_ORDER');">주문자명▼▲</button>
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('COM_NAME_ORDER');">사업사상호▼▲</button>
					</div>
				
					<label class="col-sm-1 control-label txt-right">목록수</label>
					<div class="col-sm-1">
		                <select name="cnt" id="cnt" class="form-control select2" onchange="javascript:fn_order_by('');">
							<option value="10" ${obj.pagerMaxPageItems eq '10' ? 'selected=selected':''}>10</option>
							<option value="20" ${obj.pagerMaxPageItems eq '20' ? 'selected=selected':''}>20</option>
							<option value="30" ${obj.pagerMaxPageItems eq '30' ? 'selected=selected':''}>30</option>
							<option value="40" ${obj.pagerMaxPageItems eq '40' ? 'selected=selected':''}>40</option>
							<option value="50" ${obj.pagerMaxPageItems eq '50' ? 'selected=selected':''}>50</option>
							<option value="100" ${obj.pagerMaxPageItems eq '100' ? 'selected=selected':''}>100</option>
							<option value="200" ${obj.pagerMaxPageItems eq '200' ? 'selected=selected':''}>200</option>
						</select>
					</div>
				</div>
			</div>
			<!-- /.box-body -->
		</div>		
	</div>
	<!-- /.정렬 박스 -->
	
	<div class="box">		
		<div class="box-header with-border">
			<h3 class="box-title">확정전표 목록</h3>
			<div class="box-tools">
				<button type="button" class="btn btn-success btn-sm pull-right" id="btnExcel"><i class="fa fa-file-excel-o" aria-hidden="true"></i> 엑셀</button>
			</div>
		</div>
		<!-- /.box-header -->
		
		<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
			<table class="table table-bordered">
				<colgroup>
					<col />
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th class="txt-middle"><input type="checkbox" id="CHK_ALL" name="CHK_ALL" onclick="javascript:fn_all_chk();" /></th>
						<th class="txt-middle">번호</th>
						<th class="txt-middle">주문일자<br>결제시간</th>
						<th class="txt-middle">주문번호</th>
						<th class="txt-middle">주문자명<br/>(사업사상호)</th>
						<th class="txt-middle">주문상품</th>
						<th class="txt-middle">총결제금액</th>
						<th class="txt-middle">배송료</th>
						<th class="txt-middle">상품주문금액</th>
						<th class="txt-middle">주문상태<br>결제수단</th>
						<th class="txt-middle">고객요청사항 / <br>배송참조사항</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${obj.count eq 0}">
					<tr>
						<td colspan="13">조회된 주문내역이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td class="txt-middle">
							<input type="checkbox" id="CHK${loop.count }" name="chkOrdList" value="${list.ORDER_NUM }"/>
						</td>
						<td class="txt-middle">${list.RNUM }</td>
						<td class="txt-middle">
							${list.ORDER_DATE }<br>${fn:split(list.PAY_DTM,'.')[0]}
						</td>
						<td class="txt-middle">
							<a href="${contextPath}/adm/orderEditMgr/form/${list.ORDER_NUM }">${list.ORDER_NUM }</a>
						</td>
						<td class="txt-middle">
							${list.MEMB_NM }<br/>
							<c:if test='${list.COM_NAME eq null or list.COM_NAME eq "" }'>( ${list.MEMB_NM })</c:if>
							<c:if test='${list.COM_NAME ne null and list.COM_NAME ne "" }'>( ${list.COM_NAME } )</c:if>
						</td>
						<td>
							${list.PD_NAME }
							<c:if test="${list.count > 0 }">&nbsp; 외 ${list.count}&nbsp;종</c:if>
						</td>
						<td class="txt-right">
							<fmt:formatNumber value="${list.ORDER_AMT }" />
						</td>
						<td class="txt-right">
							<fmt:formatNumber value="${list.DLVY_AMT }" />
						</td>
						<td class="txt-right">
							<fmt:formatNumber value="${list.ORDER_AMT - list.DLVY_AMT }" />
						</td>						
						<td class="txt-middle">
							<c:choose>
								<c:when test="${list.ORDER_CON eq 'ORDER_CON_08'}"><small class="label label-primary">${list.ORDER_CON_NM }</small></c:when>																
								<c:otherwise><small class="label label-default">${list.ORDER_CON_NM }</small></c:otherwise>
							</c:choose>
							<br/>
							<c:choose>
								<c:when test="${!empty list.PAY_METD and list.PAY_METD eq 'SC0040' }"><span class="badge-default">${list.PAY_METD_NM }</span></c:when>								
								<c:when test="${!empty list.PAY_METD }"><span class="badge-light">${list.PAY_METD_NM }</span></c:when>
							</c:choose>					
						</td>
						<td class="txt-middle">
							<small class="label label-${!empty list.DLVY_MSG ? 'info' : 'default'}" title="${list.DLVY_MSG }">${!empty list.DLVY_MSG ? 'Y' : 'N'}</small> / 
							<small class="label label-${!empty list.ADM_REF ? 'info' : 'default'}" title="${list.ADM_REF }">${!empty list.ADM_REF ? 'Y' : 'N'}</small>
						</td>
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
	
	// 엑셀
    $("#btnExcel").click(function() {    	
    	var checkboxValues = [];

		//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
		$("input:checkbox[name=chkOrdList]:checked").each(function(){
			checkboxValues.push($(this).val());
		});
		if(checkboxValues==''||checkboxValues==null){
			checkboxValues.push("");
			
			alert("엑셀을 출력할 주문을 선택하세요.");
			return false;
		}
		$("#CHK_ORD_LIST").val(checkboxValues);
    	var strAction = "${contextPath }/adm/orderCmptMgr/excelDown";
    	var realAction =  "${strActionUrl }";
    	
        $("#orderFrm").attr("action", strAction);
        $("#orderFrm").submit();
        
        //원래대로
        $("#orderFrm").attr("action",realAction);
    });
	
    $("#btnExcelAll").click(function() {
    	var strAction = "${contextPath }/adm/orderCmptMgr/excelAllDown";
    	var realAction =  "${strActionUrl }";
    	
        $("#orderFrm").attr("action", strAction);
        $("#orderFrm").submit();
        
        //원래대로
        $("#orderFrm").attr("action",realAction);    	
    });	
});

//정렬 주문일 & 주문자명 클릭시 , 목록수 변경시
function fn_order_by(str){
	
	var frm=document.getElementById("orderFrm");
	if(str != ""){
		frm.ORDER_GUBUN.value=str;
	}
	
	frm.pagerMaxPageItems.value=$("#cnt").val();
	console.log(frm.pagerMaxPageItems.value);
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