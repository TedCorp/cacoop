<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<script src="${contextPath }/resources/js/jquery-barcode-2.0.2.min.js"></script>

<section class="content-header">
	<h1>
		환불(반품)
		<small>환불(반품)내역</small>
	</h1>
</section>

<c:set var="strActionUrl" value="${contextPath }/adm/returnOrderMgr" />
<c:set var="strMethod" value="get" />

<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">검색 조건</h3>
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
			<spform:form class="form-horizontal" name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }">
				<%-- 
				<input type="hidden" id="DATE_ORDER" name="DATE_ORDER" value="${DATE_ORDER }" />							<!-- 주문일 정렬 -->
				<input type="hidden" id="MEMB_NM_ORDER" name="MEMB_NM_ORDER" value="${MEMB_NM_ORDER }" />		<!-- 주문자명 정렬 -->
				<input type="hidden" id="COM_NAME_ORDER" name="COM_NAME_ORDER" value="${COM_NAME_ORDER }" />	<!-- 사업사상호 정렬 -->
				 --%>
				<input type="hidden" id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" /><!-- 목록수 -->
				
				<div class="box-body">
					<div class="form-group">
						<label class="col-sm-1 control-label">주문일자</label>						
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">		
								<input type="text" class="form-control" readonly="readonly" name="datepickerStr" id="datepickerStr" value="${obj.datepickerStr }" placeholder="시작일">								
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
						</div>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">		
								<input type="text" class="form-control" readonly="readonly" name="datepickerEnd" id="datepickerEnd" value="${obj.datepickerEnd }" placeholder="종료일">
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
						</div>						
					</div>
					
					<div class="form-group">						
						<label class="col-sm-1 control-label">주문번호</label>
						<div class="col-sm-4">
							<input name="schNum" id="schNum" type="text" class="form-control" placeholder="주문번호 입력" <c:if test = '${obj.schNum !=null && obj.schNum != "null" }'>value="${obj.schNum }"</c:if>>
						</div>
						
						<label class="col-sm-1 control-label">검색조건</label>
						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2" >
								<option value="MEMB_NM" ${obj.schGbn eq 'MEMB_NM' ? 'selected=selected':''}>주문자명</option>
								<%-- <option value="RECV_PERS" ${obj.schGbn eq 'RECV_PERS' ? 'selected=selected':''}>수령자명</option> --%>
								<option value="COM_NAME" ${ obj.schGbn eq 'COM_NAME' ? "selected='selected'":''}>사업자상호</option>
							</select>
						</div>
						<div class="col-sm-3">
							<div class="input-group">
							<input type="search" class="form-control" name="schTxt" id="schTxt" placeholder="검색어 입력" 
								<c:if test = '${obj.schTxt ne null && obj.schTxt ne "null" }'>value="${obj.schTxt }"</c:if>>
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
	<!-- /.검색박스 -->
	
	<!-- 정렬 박스 -->
	<div class="box box-default">		
		<div class="box-body">
			<div class="box-body">
				<div class="form-group">
					<!-- 
					<label class="col-sm-1 control-label">정렬</label>
					<div class="col-sm-9">
						<button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('DATE_ORDER');">주문일▼▲</button>
						<button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('MEMB_NM_ORDER');">주문자명▼▲</button>
						<button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('COM_NAME_ORDER');">사업사상호▼▲</button>
						<button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('PAY_DATE_ORDER');">결제시간▼▲</button>
					</div> 
					-->
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
	
	<!-- <div class="row" style="padding-bottom:10px;">
		<div class="col-xs-12">
			<button type="button" class="btn btn-primary btn-sm pull-right left-5" onclick="javascript:fn_state('RFND_CON_03');">환불완료</button>
			<button type="button" class="btn btn-danger btn-sm pull-right left-5" onclick="javascript:fn_state('RFND_CON_02');">환불거절</button>
		</div>
	</div> -->
	<!-- /.일괄상태 변경버튼 -->
	
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">반품 목록</h3>
			<div class="box-tools">
				<!-- <button type="button" class="btn btn-primary btn-sm pull-right" id="btnExcel">엑셀</button> -->
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
						<th class="txt-middle">반품번호</th>
						<th class="txt-right">환불요청일시</th>
						<th class="txt-middle">주문번호</th>
						<th class="txt-middle">주문자명<br>(사업사상호)</th>
						<th class="txt-left">반품상품</th>
						<th class="txt-right">반품상품금액</th>
						<th class="txt-right">배송비</th>
						<th class="txt-right">총 환불금액</th>
						<!-- <th class="txt-right">상태</th> -->
					</tr>
				</thead>
				<tbody>
				<c:if test="${obj.count eq 0}">
					<tr>
						<td colspan="13">조회된 주문내역이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<c:if test="${list.ORDER_CON ne 'ORDER_CON_04' && list.ORDER_CON ne 'ORDER_CON_08' }">
					</c:if>
					<tr>
						<td class="txt-middle">
							<input type="checkbox" id="CHK${ loop.count }" name="chkOrdList" value="${list.ORDER_NUM }"/>
						</td>
						<td class="txt-middle">
							${list.RNUM }
						</td>
						<td class="txt-middle">
							<a href="${contextPath}/adm/returnOrderMgr/form/${list.RETURN_NUM }">${list.RETURN_NUM }</a>
						</td>
						<td class="txt-middle">
							${list.REG_DTM }
						</td>
						<td class="txt-middle">
							${list.ORDER_NUM }
						</td>
						<td class="txt-middle">
							${list.MEMB_NM }<br/>
							<c:if test='${list.COM_NAME eq null || list.COM_NAME eq "" }'>( ${list.MEMB_NM })</c:if>
							<c:if test='${list.COM_NAME ne null && list.COM_NAME ne "" }'>( ${list.COM_NAME } )</c:if>
						</td>
						<td class="txt-left">
							${list.PD_NAME }
							<c:if test="${list.count > 0 }">&nbsp; 외 ${list.count}&nbsp;종</c:if>
						</td>
						<td class="txt-right">
							<fmt:formatNumber value="${ list.RETURN_AMT }" />
						</td>
						<td class="txt-right">
							<fmt:formatNumber value="${ list.DLVY_AMT eq '' ? 0 : list.DLVY_AMT }" />
						</td>
						<td class="txt-right">
							<fmt:formatNumber value="${ list.RETURN_AMT + list.DLVY_AMT }" />
						</td>
						<%-- <td class="txt-middle">
							<c:choose>
								<c:when test="${!empty list.RFND_CON and list.RFND_CON eq 'RFND_CON_03' }"><small class="label label-primary">${list.RFND_CON_NM }</small></c:when>
								<c:when test="${!empty list.RFND_CON and list.RFND_CON eq 'RFND_CON_02' }"><small class="label label-danger">${list.RFND_CON_NM }</small></c:when>
								<c:otherwise><small class="label label-default">${list.RFND_CON_NM }</small></c:otherwise>
							</c:choose>							
						</td> --%>
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
		
		if(checkboxValues=='' || checkboxValues==null){
			checkboxValues.push("");			
			alert("엑셀을 출력할 주문내역을 선택하세요.");
			return false;
		} 
		
		$("#CHK_ORD_LIST").val(checkboxValues);
		
    	var strAction = "${contextPath }/adm/orderMgr/excelDown";
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