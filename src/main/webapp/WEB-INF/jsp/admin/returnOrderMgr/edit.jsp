<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:set var="strActionUrl" value="${contextPath}/adm/returnOrderMgr" />
<c:set var="strMethod" value="post" />

<section class="content-header">
	<h1>
		반품/환불내역
		<small>반품/환불정보</small>
	</h1>
</section>

<section class="content">
	<!-- 주문 정보 시작 -->
	<div class="box box-info">
		<div class="box-header with-border">
			<h3 class="box-title">환불 정보</h3>
			<!-- <button type="button" class="btn btn-success btn-sm pull-right left-5" id="btnExcel">엑셀</button> -->
		</div>
		<!-- /.box-header -->
		
		<div class="box-body">
			<div class="form-group">
				<label for="ORDER_NUM" class="col-sm-2 control-label">환불번호</label>
				<div class="col-sm-4">${tb_odinfoxm.ORDER_NUM }</div>
				<label for="MEMB_NM" class="col-sm-2 control-label">주문자</label>
				<div class="col-sm-4">${tb_odinfoxm.MEMB_NM }</div>
			</div><br/>
			<div class="form-group">
				<label for="ORDER_DATE" class="col-sm-2 control-label">환불일자</label>
				<div class="col-sm-4">${tb_odinfoxm.ORDER_DATE }</div>
				<label for="PAY_METD" class="col-sm-2 control-label">환불수단</label>
				<div class="col-sm-4">${tb_odinfoxm.PAY_METD_NM }</div>
				
			</div><br>
		<%-- 	<div class="form-group">
				<label for="COM_BUNB" class="col-sm-2 control-label">사업자번호</label>
				<div class="col-sm-4">${tb_odinfoxm.COM_BUNB }</div> 
			    <label for="ORIGIN_NUM" class="col-sm-2 control-label">원 주문번호</label>
				<div class="col-sm-4">${tb_odinfoxm.ORIGIN_NUM }</div>
			</div><br/> --%>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- 주문 정보 끝 -->
	
	<!-- 업체별 상품 출력 2020-02-25 -->
	<spform:form class="form-horizontal" name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }">
		<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM }" /><!-- 주문번호 -->
		<input type="hidden" name="PAY_AMT"/>
		
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">상품 정보</h3>
			</div>
			<!-- /.box-header -->
			<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
				<c:set var="totalAmt" value="0"/>
				<c:forEach items="${pd_supr_list}" var="supr" varStatus="loop">					
					<table class="table table-bordered">
						<caption><b>${loop.count}. ${supr.SUPR_NAME}</b></caption>
						<colgroup>
							<col style="width:45px" />
							<col style="width:100px" />
							<col style="width:150px" />
							<col style="width:60px" />
							<col style="width:90px" />
							<col style="width:90px" />
							<col style="width:80px" />
							<col style="width:80px" />
							<col style="width:100px" />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>상품코드</th>
								<th>상품명</th>
								<th>수량</th>
								<th>판매가격</th>
								<th>환불금액</th>
								<th>환불상태</th>
								<th>택배사</th> 
								<th>운송장번호(환불)</th>
							</tr>
						</thead>
						<tbody>
						<c:set var="cont_cnt" value="0"/>
						<c:set var="total_Cancel_Price"	 value="0"/>	
						<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
							<c:if test="${supr.SUPR_ID eq list.SUPR_ID }">		
								<c:set var="cont_cnt" value="${cont_cnt + 1}"/>	
																					
								<tr>
									<td>${cont_cnt}</td>
									<td>${list.PD_CODE }</td>
									<td>${list.PD_NAME } </td>
									<td>${list.ORDER_QTY}</td>
									<td><fmt:formatNumber>${list.PD_PRICE }</fmt:formatNumber></td>
									<td class="orderAmt"><fmt:formatNumber>${list.RFND_AMT}</fmt:formatNumber></td>
									<td>
										<jsp:include page="${contextPath}/common/comCodForm">
											<jsp:param name="COMM_CODE" value="ORDER_CON" />
											<jsp:param name="name" value="ORDER_CON" />
											<jsp:param name="value" value="${list.ORDER_CON}" />
											<jsp:param name="type" value="select" />
											<jsp:param name="top" value="전체" />
											<jsp:param name="attr1" value="disabled='true'" />
										</jsp:include>
									</td>								
									<td>${list.DLVY_COM_NAME}</td>
									<td><!-- 운송장변호 -->
										<input type="text" name="DTL_RFND_DLVY_TDN" value="${list.RFND_DLVY_TDN}" class="form-control" />
										<input type="hidden" name="ORDER_NUM" value="${list.ORDER_NUM}"/>
										<input type="hidden" name="PD_CODE" value="${list.PD_CODE}"/>
										<input type="hidden" name="OPTION1_VALUE" value="${list.OPTION1_VALUE}"/> 
										<input type="hidden" name="OPTION2_VALUE" value="${list.OPTION2_VALUE}"/>
										<input type="hidden" name="OPTION3_VALUE" value="${list.OPTION3_VALUE}"/> 
										<input type="hidden" name="SUPR_ID" value="${list.SUPR_ID}"/>			
									</td>							
									<c:set var= "total_Cancel_Price" value="${total_Cancel_Price + list.RFND_AMT}"/>
									<c:set var="Rfnd_Dlvy_Amt" value="${list.RFND_DLVY_AMT }"/>
								</tr>
							</c:if>
						</c:forEach>
							<tr>
								<th class="txt-right" colspan="7">상품 합계</th>
								<td class="txt-right" colspan="2">
									<fmt:formatNumber><c:out value="${total_Cancel_Price}"/></fmt:formatNumber>
								</td>
							</tr>
							<tr>
								<th class="txt-right" colspan="7">반품 배송비 </th>
								<td class="txt-right" colspan="2">
									<fmt:formatNumber><c:out value="${Rfnd_Dlvy_Amt}"/></fmt:formatNumber>
								</td>
							</tr>
							<tr>
								<th class="txt-right" colspan="7">총 합계 </th>
								<td class="txt-right" colspan="2" >
									<fmt:formatNumber><c:out value="${total_Cancel_Price - Rfnd_Dlvy_Amt}"/></fmt:formatNumber>
								</td>
							</tr>						
						</tbody>
					</table>				
				</c:forEach>				
			</div>
		</div>
		<!-- 구매확정 정보 끝 -->
			
		<!-- 반품 상세 정보 -->
		<%-- <div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">환불 상세 정보</h3>
			</div>
			<!-- /.box-header -->
			<div class="box-body">
				<div class="form-group">
					<label for="CNCL_MSG" class="col-sm-1 control-label">반품 사유</label>
					<div class="col-sm-9">${tb_odinfoxm.RFND_MSG_NM}</div>
				</div>
				<div class="form-group">
					<label for="CNCL_MSG" class="col-sm-1 control-label">상세사유</label>
					<div class="col-sm-9">							
						<pre>${tb_odinfoxm.CNCL_MSG}</pre>
					</div>
				</div>
				<div class="form-group">
					<label for="DLVY_COM" class="col-sm-1 control-label">배송 정보</label>
					<div class="col-sm-2">
						<jsp:include page="${contextPath}/common/comCodForm">
							<jsp:param name="COMM_CODE" value="DLVY_COM" />
							<jsp:param name="name" value="DLVY_COM" />
							<jsp:param name="value" value="${tb_odinfoxm.DLVY_COM }" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="선택" />
						</jsp:include>
					</div>
					<div class="col-sm-7">
						<input type="text" class="form-control" value="${tb_odinfoxm.DLVY_TDN }" readonly/>
					</div>
				</div>
			</div>
			<!-- /.box-body -->
		</div> --%>
		<!-- 반품 상세 정보 끝 -->
		
		<!-- 주문 상태 및 결제 정보 시작 -->
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">관리자 처리 정보</h3>
			</div>
			<!-- /.box-header -->
			<div class="box-body">
				<div class="form-group">
					<label for="ORDER_CON" class="col-sm-1 control-label">주문상태</label>
					<div class="col-sm-2">
						<jsp:include page="${contextPath}/common/comCodName">
							<jsp:param name="COMM_CODE" value="ORDER_CON" />
							<jsp:param name="COMD_CODE" value="${tb_odinfoxm.ORDER_CON }" />
							<jsp:param name="type" value="text" />
						</jsp:include>
					</div>
					
					<label for="ORDER_CON" class="col-sm-2 control-label">취소/환불상태</label>
					<div class="col-sm-2">						
						<jsp:include page="${contextPath}/common/comCodName">
							<jsp:param name="COMM_CODE" value="CNCL_CON" />
							<jsp:param name="COMD_CODE" value="${tb_odinfoxm.CNCL_CON }" />
							<jsp:param name="type" value="text" />
						</jsp:include>
						<jsp:include page="${contextPath}/common/comCodName">
							<jsp:param name="COMM_CODE" value="RFND_CON" />
							<jsp:param name="COMD_CODE" value="${tb_odinfoxm.RFND_CON }" />
							<jsp:param name="type" value="text" />
						</jsp:include>
					</div>
				</div>
				
				<div class="form-group">
					<label for="PAY_METD" class="col-sm-1 control-label">환불수단</label>
					<div class="col-sm-2">
						<jsp:include page="${contextPath}/common/comCodName">
							<jsp:param name="COMM_CODE" value="PAY_METD" />
							<jsp:param name="COMD_CODE" value="${tb_odinfoxm.PAY_METD }" />
							<jsp:param name="type" value="text" />
						</jsp:include>
					</div>
					
					<label for="PAY_DTM" class="col-sm-2 control-label">환불일시</label>
					<div class="col-sm-3">
						${tb_odinfoxm.PAY_DTM }
						<input type="hidden" name="PAY_DTM" id="PAY_DTM" value="${tb_odinfoxm.PAY_DTM }"/>
					</div>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
		<!-- 주문 상태 및 결제 정보 끝 -->
	</spform:form>
	
	<div class="box-footer">
		<a href="${contextPath}/adm/returnOrderMgr" class="btn btn-default pull-right"><i class="fa fa-list"></i> 목록</a>
		<a onclick="javascript:fn_save();" class="btn btn-primary pull-right right-5"><i class="fa fa-save"></i> 저장</a>
	</div>
	<!-- /.box-footer -->
</section>

<script type="text/javascript">
$(document).ready(function() {
	/* 초기 로드시, form 설정 */
	fn_disabled();
	
	$("#ORDER_CON").change(function(e) {
		fn_disabled();
	});
	
	//Date picker
	$('#datepicker_dlar').datepicker({
		autoclose: true,
		format: 'yyyy-mm-dd'
	});
	$('#datepicker').datepicker({
		autoclose: true,
		format: 'yyyy-mm-dd'
	}); 
/* 	$('#timepicker').timepicker({
		timeFormat : "H:i:s"
	});
	 */
	//현장출고일시/배송일시 표시
	var dlar_date = ${tb_oddlaixm.DLAR_DATE}+"";
    
	if(dlar_date != "" && dlar_date != null){
		$('#datepicker_dlar').datepicker("setDate", new Date(dlar_date.substr(0,4),dlar_date.substr(4,2)-1,dlar_date.substr(6,2)));
	}
	 	
	//결제일시 표시
	var dtmToString = $('#PAY_DTM').val();

	dtmToString = dtmToString.split("-").join("")
	dtmToString = dtmToString.split(":").join("");
	dtmToString = dtmToString.split(" ").join("");
	dtmToString = dtmToString.substring(0,14);
	
	var hour = dtmToString.substring(8,10);
	var minute = dtmToString.substring(10,12);
    var whatTm ="";
    
    if(hour>12){
    	hour = hour-12;
    	whatTm = "PM";
	}else if(hour==12){
		whatTm = "PM";
	}else if (hour == 0){
		whatTm = "AM";
	}else{
		whatTm = "AM";
	}
	if(dtmToString=="" || hour == "" || minute =="" ){
		$('#datepicker').val("");
		$('#timepicker').val("");
	}else {
		$('#datepicker').datepicker("setDate"
				,new Date(dtmToString.substring(0,4),dtmToString.substring(4,6)-1,dtmToString.substring(6,8)));
		$('#timepicker').val(hour+":"+minute+" "+whatTm);
	}

	/* 20211216:장보라 */
	//option배열길이 구하기
	var options_length=$('input[name=OPTION1_VALUE]').length;
	//option의 값이 없을 경우 - 값넣기 (배열 length길이 맞춰야해서 )
	for(var i=0; i<options_length; i++){
		if($('input[name=OPTION1_VALUE]').eq([i]).val() == ""){
			$('input[name=OPTION1_VALUE]').eq([i]).attr('value','-');
		}
		if($('input[name=OPTION2_VALUE]').eq([i]).val() == ""){
			$('input[name=OPTION2_VALUE]').eq([i]).attr('value','-');
		}
		if($('input[name=OPTION3_VALUE]').eq([i]).val() == ""){
			$('input[name=OPTION3_VALUE]').eq([i]).attr('value','-');
		}
	}
	
	
	
});

/* 엑셀 */
$("#btnExcel").click(function() {	
	var form = document.createElement("form");

	form.target = "_blank";
	form.method = "get";
	form.action = "${contextPath }/adm/orderMgr/detailExcelDown";

	document.body.appendChild(form);

	var input_id = document.createElement("input");
	
	input_id.setAttribute("type", "hidden");
	input_id.setAttribute("name", "ORDER_NUM");
	input_id.setAttribute("value", "${tb_odinfoxm.ORDER_NUM }");

	form.appendChild(input_id);
	form.submit();    
});

/* form 설정 */
function fn_disabled(){	
	//주문 취소시
	if($("#ORDER_CON").val()=="ORDER_CON_04"){
		$("#CNCL_CON").show();
		$("#RFND_CON").hide();
		$("#RFND_CON").val("");
		$("#CNCL_CON").val("CNCL_CON_01");
	//환불시
	}else if($("#ORDER_CON").val()=="ORDER_CON_07"){
		$("#CNCL_CON").hide();
		$("#CNCL_CON").val("");
		$("#RFND_CON").show();
	}else{
		$("#CNCL_CON").val("");
		$("#RFND_CON").val("");
		$("#CNCL_CON").hide();
		$("#RFND_CON").hide();
	}
}

/* 저장 */
function fn_save(){

	var frm=document.getElementById("orderFrm");	
    if(!confirm("저장 하시겠습니까?")) return;	
	frm.submit();
}

/* 숫자콤마만드는 함수 */
function addComma(num) {
	var regexp = /\B(?=(\d{3})+(?!\d))/g;
	return num.toString().replace(regexp, ',');
}

/* get 파라미터를 네임으로 가지고오는 함수 */
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}
</script>
