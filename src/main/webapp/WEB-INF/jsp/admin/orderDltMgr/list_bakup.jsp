<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<script src="${contextPath }/resources/js/jquery-barcode-2.0.2.min.js"></script>

<section class="content-header">
	<h1>
		주문삭제내역 목록	
		<small>주문삭제내역 목록</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<c:set var="strActionUrl" value="${contextPath }/adm/orderDltMgr" />
<c:set var="strMethod" value="get" />

<c:choose>
<c:when test="${empty obj.DATE_ORDER or obj.DATE_ORDER =='desc' }"><c:set var="DATE_ORDER" value="asc" /></c:when>
<c:otherwise><c:set var="DATE_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
<c:when test="${empty obj.MEMB_NM_ORDER or  obj.MEMB_NM_ORDER =='desc' }"><c:set var="MEMB_NM_ORDER" value="asc" /></c:when>
<c:otherwise><c:set var="MEMB_NM_ORDER" value="desc" /></c:otherwise>
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
				<input type="hidden" id="MEMB_NM_ORDER" name="MEMB_NM_ORDER" value="${MEMB_NM_ORDER }" /><!-- 주문자명 정렬 -->
				<input type="hidden" id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" /><!-- 목록수 -->
				<input type="hidden" id="ORDER_CON_STATE" name="ORDER_CON_STATE" value="" /><!-- 배송준비중 변경 상태 변수 -->
				<input type="hidden" id="ORDER_CON_ORDER_NUM" name="ORDER_CON_ORDER_NUM" value="" /><!-- 배송준비중 변경 상태 체크 항목 -->
				<input type="hidden" id="CHK_ORD_LIST" name="CHK_ORD_LIST" value="" /><!-- 배송준비중 변경 상태 체크 항목 -->					
				
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">기간별 조회</label>
						
						<div class="col-sm-5">
							<div class="form-group">
								<div class="col-sm-5">
									<input type="text" class="form-control pull-left" readonly="readonly"  name="datepickerStr" id="datepickerStr" value="${obj.datepickerStr }" >
								</div>
								<div class="col-sm-1">
									~
								</div>
								<div class="col-sm-6">
									<input type="text" class="form-control pull-right" readonly="readonly" name="datepickerEnd" id="datepickerEnd" value="${obj.datepickerEnd }">
								</div>
							</div>
						</div>
						<label for="inputEmail3" class="col-sm-1 control-label">검색조건</label>
						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2" style="width: 100%;">
								<option value="MEMB_NM" ${obj.schGbn == 'MEMB_NM' ? 'selected=selected':''}>주문자명</option>
								<option value="RECV_PERS" ${obj.schGbn == 'RECV_PERS' ? 'selected=selected':''}>수령자명</option>
								<option value="COM_NAME" ${ obj.schGbn eq 'COM_NAME' ? "selected='selected'":''}>사업자상호</option>
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
	<div class="box-header with-border">
		<h3 class="box-title"></h3>
		<div class="box-tools">
			<button type="button" class="btn btn-primary btn-sm pull-right" onclick="javascript:deleteReturnOrd()">주문내역 복원</button>
			<button type="button" class="btn btn-primary btn-sm pull-right" id="btnExcel">엑셀</button>
			<!-- <button type="button" class="btn btn-primary btn-sm pull-right" id="btnExcel">엑셀</button> -->
		</div>
	</div>
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<!-- /.box-header -->
		<div class="box-body">
			<!-- <form class="form-horizontal"> -->
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">정렬</label>
						<div class="col-sm-6">
							<button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('DATE_ORDER');">주문일▼▲</button>
							<button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('MEMB_NM_ORDER');">주문자명▼▲</button>
							<button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('COM_NAME_ORDER');">사업사상호▼▲</button>
						</div>
						<div class="col-sm-5"></div>
						<div class="col-sm-4">
							<label for="inputEmail3" class="col-sm-6 control-label">목록수</label>
							<div class="col-sm-3">
				                <select name="cnt" id="cnt" class="form-control select2" style="width: 100%;" onchange="javascript:fn_order_by('');">
									<option value="10" ${obj.pagerMaxPageItems == '10' ? 'selected=selected':''}>10</option>
									<option value="20" ${obj.pagerMaxPageItems == '20' ? 'selected=selected':''}>20</option>
									<option value="30" ${obj.pagerMaxPageItems == '30' ? 'selected=selected':''}>30</option>
									<option value="40" ${obj.pagerMaxPageItems == '40' ? 'selected=selected':''}>40</option>
									<option value="50" ${obj.pagerMaxPageItems == '50' ? 'selected=selected':''}>50</option>
									<option value="100" ${obj.pagerMaxPageItems == '100' ? 'selected=selected':''}>100</option>
									<option value="200" ${obj.pagerMaxPageItems == '200' ? 'selected=selected':''}>200</option>
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
		<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
			<table class="table table-bordered">
				<colgroup>
					<col style="with:10px" />
					<col />
					<col style="with:50px" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="CHK_ALL" name="CHK_ALL" onclick="javascript:fn_all_chk();" /></th>						
						<th>번호</th>
						<th style="text-align: center;vertical-align : middle;">주문일자<br>결제시간</th>
						<th style="text-align: center;vertical-align : middle;">주문번호</th>
						<th style="text-align: center;vertical-align : middle;">주문자명<br/>(사업사상호)</th>
						<th style="text-align: center;vertical-align : middle;">주문상품</th>
						<th style="text-align: center;vertical-align : middle;">총결제금액</th>
						<th style="text-align: center;vertical-align : middle;">배송료</th>
						<th style="text-align: center;vertical-align : middle;">상품주문금액</th>
						<th style="text-align: center;vertical-align : middle;">주문상태<br>결제수단</th>
						<th style="text-align: center;vertical-align : middle;">출고방식</th>
						<th style="text-align: center;vertical-align : middle;">고객배송<br>요청사항</th>
						<th style="text-align: center;vertical-align : middle;">배송참조사항<br>(관리자기록)</th>
						<th style="text-align: center;vertical-align : middle;">배송권역</th>
						<th style="text-align: center;vertical-align : middle;">기능</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${obj.count == 0}">
					<tr>
						<td colspan="13">조회된 주문내역이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td style="text-align: center;vertical-align : middle;">
							<input type="checkbox" id="CHK${loop.count }" name="chkOrdList" value="${list.ORDER_NUM }"/>
						</td>
						<td>${list.RNUM }</td>
						<td style="text-align: center;vertical-align : middle;">
							${list.ORDER_DATE }<br>${fn:split(list.PAY_DTM,'.')[0]}
						</td>
						<td style="text-align: center;vertical-align : middle;">
							${list.ORDER_NUM }
						</td>
						<td style="text-align: center;vertical-align : middle;">
							${list.MEMB_NM }<br/>
							<c:if test='${list.COM_NAME==null || list.COM_NAME=="" }'>( ${list.MEMB_NM })</c:if>
							<c:if test='${list.COM_NAME!=null && list.COM_NAME!="" }'>( ${list.COM_NAME } )</c:if>
						</td>
						<td style="text-align: center;vertical-align : middle;">
							${list.PD_NAME }
							<c:if test="${list.count > 0 }">
								&nbsp; 외 ${list.count}&nbsp;종
							</c:if>
						</td>
						<td style="text-align: center;vertical-align : middle;">
							<fmt:formatNumber value="${list.ORDER_AMT }" />
						</td>
						<td style="text-align: center;vertical-align : middle;">
							<fmt:formatNumber value="${list.DLVY_AMT }" />
						</td>
						<td style="text-align: center;vertical-align : middle;">
							<fmt:formatNumber value="${list.ORDER_AMT - list.DLVY_AMT }" />
						</td>						
						<td style="text-align: center;vertical-align : middle;">
							${list.ORDER_CON_NM }<br/><c:if test='${list.PAY_METD_NM!=null && list.PAY_METD_NM!="" }'>(${list.PAY_METD_NM })</c:if>
						</td>
						<td style="text-align: center;vertical-align : middle;">
							${list.DLAR_GUBN }<br>${list.DLAR_DATE_TIME=='nothing'?'':list.DLAR_DATE_TIME }
						</td>  
						<td style="text-align: center;vertical-align : middle;">
							${list.DLVY_MSG }
						</td>
						<td style="text-align: center;vertical-align : middle;">
							${list.ADM_REF }
						</td>
						<td style="text-align: center;vertical-align : middle;">
							준비중
						</td>
						<td style="text-align: center;vertical-align : middle;">
							<a href="${contextPath}/adm/orderDltMgr/form/${list.ORDER_NUM }">상세</a>
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

<form name="dltRtnFrm" id="dltRtnFrm" method="post" action="${contextPath }/adm/orderDltMgr/deleteReturnOrdList" >
	<input type="hidden" name="ORD_DELETE_LIST" id="ORD_DELETE_LIST" value=""/>
</form>


<style type="text/css">
.modal-dialog.modal-lg { 
	width: 80%; 
	margin: 15px auto; 
	padding: 0; 
}
</style>
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
    	var strAction = "${contextPath }/adm/orderDltMgr/excelDown";
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

//일괄 주문상태 변경(배송준비중 변경 버튼 클릭시)
function fn_state(str){
	
	var cnt = 0;
	var order_num_list = "";
	for(var i=1;i<= ${fn:length(obj.list) };i++){
		if($("#CHK"+i).is(":checked")){
			cnt++;
			if(order_num_list != "") {
				order_num_list+="$";
			}
			order_num_list+=$("#CHK"+i).val();
		}
	}
	if(cnt == 0){
		alert("일괄 변경 할 주문을 선택하세요.");
		return;
	}
	
	if(!confirm("일괄 변경 하시겠습니까?"))return;
	
	var frm=document.getElementById("orderFrm");
	frm.ORDER_CON_STATE.value=str;
	frm.ORDER_CON_ORDER_NUM.value=order_num_list;
	frm.submit();
}


//주문내역 삭제복원
function deleteReturnOrd(){
	
	var checkboxValues = [];

	//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
	$("input:checkbox[name=chkOrdList]:checked").each(function(){
		checkboxValues.push($(this).val());
	});
	if(checkboxValues==''||checkboxValues==null){
		checkboxValues.push("");
		
		alert("복원할 주문을 선택하세요.");
		return false;
	}
	var frm = document.getElementById("dltRtnFrm");
	frm.ORD_DELETE_LIST.value=checkboxValues;
	frm.submit();	
	
}
</script>