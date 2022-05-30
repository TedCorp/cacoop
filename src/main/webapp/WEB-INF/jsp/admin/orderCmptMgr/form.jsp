<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- bootstrap datepicker -->
<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.css">
<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.min.css">

<!-- bootstrap datepicker -->
<script src="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.js"></script>
<script src="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.min.js"></script>

<c:set var="strActionUrl" value="${contextPath }/adm/orderCmptMgr"/>
<c:set var="strMethod" value="post" />

<section class="content-header">
	<h1>
		확정주문내역
		<small>확정주문정보</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">
	<!-- 주문 정보 시작 -->
	<div class="box box-info">
		<div class="box-header with-border">
			<h3 class="box-title">주문 정보</h3>
			<button type="button" class="btn btn-success btn-sm pull-right left-5" id="btnExcel">엑셀</button>
		</div>
		<!-- /.box-header -->
		
		<div class="box-body">
			<div class="form-group">
				<label for="ORDER_NUM" class="col-sm-2 control-label">주문번호</label>
				<div class="col-sm-4">${tb_odinfoxm.ORDER_NUM }</div>
				<label for="ORDER_DATE" class="col-sm-2 control-label">주문일자</label>
				<div class="col-sm-4">${tb_odinfoxm.ORDER_DATE }</div>
			</div><br/>
			<div class="form-group">
				<label for="CPON_YN" class="col-sm-2 control-label">환불번호</label>
				<div class="col-sm-4">
					<c:set var="returnCnt" value="${returnNum.size()}"/>
					<c:forEach items="${returnNum}" var="rtnInfo" varStatus="loop">
						<a href="${contextPath}/adm/orderRfndMgr/form/${rtnInfo.ORDER_NUM }">${rtnInfo.ORDER_NUM }</a>${returnCnt > 1 && returnCnt != loop.count ? ',' : ''} 
					</c:forEach>
				</div>
				<label for="DAP_YN" class="col-sm-2 control-label">배송비 결제여부</label>
				<div class="col-sm-4">${tb_odinfoxm.DAP_YN } (쿠폰사용 : ${tb_odinfoxm.CPON_YN })</div>
			</div><br>
			<div class="form-group">
				<label for="MEMB_NM" class="col-sm-2 control-label">주문자</label>
				<div class="col-sm-4">${tb_odinfoxm.MEMB_NM }</div>
				<label for="COM_BUNB" class="col-sm-2 control-label">사업자번호</label>
				<div class="col-sm-4">${tb_odinfoxm.COM_BUNB }</div>
			</div><br/>				
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
				<a onclick="javascript:fn_ord_return();" class="btn btn-default btn-warning pull-right"><i class="fa fa-sign-out"></i> 반품신청</a>
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
							<col style="width:100px" />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>상품코드</th>
								<th>상품명</th>
								<th>주문수량</th>
								<th>판매가격</th>
								<th>주문금액</th>
								<th>주문상태</th>
								<th>택배사</th>
								<th>운송장번호</th>
								<!-- <th>외부주문코드</th> -->
							</tr>
						</thead>
						
						<c:set var="cont_cnt" value="0"/>
						<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
							<c:if test="${supr.SUPR_ID eq list.SUPR_ID }">
								<c:set var= "cont_cnt" value="${cont_cnt + 1}"/>																			
								<tr>
									<td>${cont_cnt }</td>
									<td>${list.PD_CODE }</td>
									<td>${list.PD_NAME } 
										<c:if test="${ list.PD_CUT_SEQ ne null }">(세절방식 : ${ list.PD_CUT_SEQ})</c:if>
										<c:if test="${ list.OPTION_CODE ne null }">(색상 : ${ list.OPTION_CODE})</c:if>
									</td>
									<td>
										<%
											String userAgent = request.getHeader("user-agent");
											boolean mobile1 = userAgent.matches(".*(iPhone|iPad|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|POLATIS|IEMobile|lgtelecom|mokia|SonyEricsson).*");
											boolean mobile2 = userAgent.matches(".*(LG|SAMSUNG|Samsung).*");
											if(mobile1 || mobile2){
										%>
											<input type="text" name="ORDER_QTY" value="${list.ORDER_QTY }" class="form-control btnQty" readonly/>
										<%
											}else{
										%>
											<input type="text" name="ORDER_QTY" value="${list.ORDER_QTY }" class="form-control btnQty" readonly/>
										<%
											}
										%>
										<input type="hidden" name="UPDATE_NUM" value="${list.ORDER_NUM }"/>
										<input type="hidden" name="UPDATE_DTNUM" value="${list.ORDER_DTNUM }"/>
										<input type="hidden" name="ORDER_DTNUM" value="${list.ORDER_DTNUM }"/>
										<input type="hidden" name="PDDC_VAL" value="${list.PDDC_VAL }"/>
										<input type="hidden" name="PD_PRICE" value="${list.PD_PRICE }"/>
										<input type="hidden" name="PDDC_GUBN" value="${list.PDDC_GUBN }"/>
										<input type="hidden" name="SUPR_ID" value="${list.SUPR_ID }"/>
										<input type="hidden" name="LOGIN_SUPR_ID" value="${login_supr_id }"/>
									</td>
									<td><fmt:formatNumber>${list.REAL_PRICE }</fmt:formatNumber></td>
									<td class="orderAmt"><fmt:formatNumber>${list.ORDER_AMT }</fmt:formatNumber></td>
									<td><!-- 주문상태 -->
										<jsp:include page="/common/comCodName">
											<jsp:param name="COMM_CODE" value="ORDER_CON" />
											<jsp:param name="COMD_CODE" value="${list.ORDER_CON }" />
											<jsp:param name="type" value="text" />
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/common/comCodName">
											<jsp:param name="COMM_CODE" value="DLVY_COM" />
											<jsp:param name="COMD_CODE" value="${list.DLVY_COM}" />
											<jsp:param name="type" value="text" />
										</jsp:include>
									</td>
									<td>
										<input type="text" name="DTL_DLVY_TDN" value="${list.DLVY_TDN }" class="form-control" readonly/>
									</td>							
									<%-- <td>
										<input class="form-control btnQty" type="text" name="LOGIN_SUPR_ID" value="${list.LINK_ORDER_KEY }" readonly/>
									</td> --%>						
									<c:set var= "totalAmt" value="${totalAmt + list.ORDER_AMT}"/>
								</tr>
							</c:if>
						</c:forEach>
							<tr>
								<th class="txt-right" colspan="8">상품 합계</th>
								<td class="txt-right" colspan="1" id="totalPrdAmt">
									<fmt:formatNumber><c:out value="${totalAmt}"/></fmt:formatNumber>
								</td>
							</tr>
							<tr>
								<th class="txt-right" colspan="8">배송비 </th>
								<td class="txt-right" colspan="1" id="dlvyAmt">
									<fmt:formatNumber><c:out value="${tb_odinfoxm.DLVY_AMT}"/></fmt:formatNumber>
								</td>
							</tr>
							<tr>
								<th class="txt-right" colspan="8">총 합계 </th>
								<td class="txt-right" colspan="1" id="totalAmt">
									<fmt:formatNumber><c:out value="${tb_odinfoxm.ORDER_AMT}"/></fmt:formatNumber>
								</td>
							</tr>						
						</tbody>
					</table>				
				</c:forEach>				
			</div>
		</div>
		<!-- 구매확정 정보 끝 -->
		
		<!-- 배송지 정보 시작 -->
		<div class="box box-default">
			<div class="box-header with-border">
				<h3 class="box-title">배송지 정보</h3>
				<%-- <div class="pull-right">
					<jsp:include page="/common/comCodForm">
						<jsp:param name="COMM_CODE" value="DLAR_GUBN" />
						<jsp:param name="name" value="DLAR_GUBN" />
						<jsp:param name="value" value="${tb_oddlaixm.DLAR_GUBN }" />
						<jsp:param name="type" value="radio" />
						<jsp:param name="top" value="선택" />
					</jsp:include>
				</div> --%>
			</div>
			<!-- /.box-header -->
			
			<div class="box-body">
				<div class="form-group">
					<label for="RECV_PERS" class="col-sm-2 control-label required">받으시는 분</label>
					<div class="col-sm-4">
						${tb_oddlaixm.RECV_PERS }
					</div>
				</div>
				
				<div class="form-group">
					<label for="COM_PN" class="col-sm-2 control-label required">주소</label>
					<div class="col-sm-9">
						 [${tb_oddlaixm.POST_NUM }] ${tb_oddlaixm.BASC_ADDR } ${tb_oddlaixm.DTL_ADDR }
					</div>						
				</div>
				
				<div class="form-group">
					<label for="RECV_CPON" class="col-sm-2 control-label required">휴대전화</label>
					<div class="col-sm-4">
						${tb_oddlaixm.RECV_CPON }
					</div>
					
					<label for="RECV_TELN" class="col-sm-1 control-label">일반전화</label>
					<div class="col-sm-4">
						${tb_oddlaixm.RECV_TELN }
					</div>					
				</div>
				
				<div class="form-group">
					<label for="DLVY_MSG" class="col-sm-2 control-label">배송 메세지</label>
					<div class="col-sm-9">
						<pre>${ empty tb_oddlaixm.DLVY_MSG ? '-' : tb_oddlaixm.DLVY_MSG }</pre>
					</div>
				</div>
				
				<div class="form-group">
					<label for="ADM_REF" class="col-sm-2 control-label">회원 메세지</label>
					<div class="col-sm-9">							
						<pre>${tb_oddlaixm.ADM_REF }</pre>
						<h6 style="color:red">* 관리자 참조설명은 회원관리에서 변경할 수 있습니다.</h6>
					</div>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
		<!-- 배송지 정보 끝 -->
		
		<!-- 주문 상태 및 결제 정보 시작 -->
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">주문 상태 및 결제 정보</h3>
			</div>
			<!-- /.box-header -->
			<div class="box-body">
				<div class="form-group">
					<label for="ORDER_CON" class="col-sm-1 control-label">주문상태</label>
					<div class="col-sm-2">
						<jsp:include page="/common/comCodName">
							<jsp:param name="COMM_CODE" value="ORDER_CON" />
							<jsp:param name="COMD_CODE" value="${tb_odinfoxm.ORDER_CON }" />
							<jsp:param name="type" value="text" />
						</jsp:include>
					</div>
					<div class="col-sm-3">
						<jsp:include page="/common/comCodName">
							<jsp:param name="COMM_CODE" value="CNCL_CON" />
							<jsp:param name="COMD_CODE" value="${tb_odinfoxm.CNCL_CON }" />
							<jsp:param name="type" value="text" />
						</jsp:include>
						<jsp:include page="/common/comCodName">
							<jsp:param name="COMM_CODE" value="RFND_CON" />
							<jsp:param name="COMD_CODE" value="${tb_odinfoxm.RFND_CON }" />
							<jsp:param name="type" value="text" />
						</jsp:include>
					</div>
					<c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_04'}">
						<label for="CNCL_MSG" class="col-sm-1 control-label">취소사유</label>
						<div class="col-sm-2">
							${tb_odinfoxm.CNCL_MSG }
						</div>
					</c:if>
				</div>
				
				<div class="form-group">
					<label for="PAY_METD" class="col-sm-1 control-label">결제 수단</label>
					<div class="col-sm-2">
						<jsp:include page="/common/comCodName">
							<jsp:param name="COMM_CODE" value="PAY_METD" />
							<jsp:param name="COMD_CODE" value="${tb_odinfoxm.PAY_METD }" />
							<jsp:param name="type" value="text" />
						</jsp:include>
					</div>
					
					<label for="PAY_DTM" class="col-sm-2 control-label">결제 일시</label>
					<div class="col-sm-2">
						${tb_odinfoxm.PAY_DTM }
						<input type="hidden" name="PAY_DTM" id="PAY_DTM" value="${tb_odinfoxm.PAY_DTM }"/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="DLVY_COM" class="col-sm-1 control-label">배송 정보</label>
					<div class="col-sm-2">
						<jsp:include page="/common/comCodForm">
							<jsp:param name="COMM_CODE" value="DLVY_COM" />
							<jsp:param name="name" value="DLVY_COM" />
							<jsp:param name="value" value="${tb_odinfoxm.DLVY_COM }" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="선택" />
						</jsp:include>
					</div>
					<label for="DLVY_TDN" class="col-sm-2 control-label">운송장번호</label>
					<div class="col-sm-5">
						${tb_odinfoxm.DLVY_TDN }
						<input type="hidden" class="form-control" id="DLVY_TDN" name="DLVY_TDN" value="${tb_odinfoxm.DLVY_TDN }" maxlength="50" />
					</div>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
		<!-- 주문 상태 및 결제 정보 끝 -->
	</spform:form>
	
	<div class="box-footer">
		<a href="${contextPath}/adm/orderCmptMgr" class="btn btn-default pull-right"><i class="fa fa-list"></i> 목록</a>
		<a onclick="javascript:fn_save();" class="btn btn-primary pull-right right-5"><i class="fa fa-save"></i> 저장</a>
		<%-- <a href="${contextPath}/adm/orderEditMgr/edit/${tb_odinfoxm.ORDER_NUM }" class="btn btn-primary pull-right right-5">
			<i class="fa fa-save"></i> 수정
		</a> --%>
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
	$('#timepicker').timepicker({
		timeFormat : "H:i:s"
	});
	
	$('#datepicker_return').datepicker({
		autoclose: true,
		format: 'yyyy-mm-dd'
	}); 
	
	$('#datepicker_return').change(function() {
		var date = new Date();
		var rtn_date = $('#datepicker_return').val();
		
		rtn_date = rtn_date.split("-").join("");
		
		var toYear = rtn_date.substring(0,4); 
		var toMonth = rtn_date.substring(4,6); 
		var toDay = rtn_date.substring(6,8); 
		
		var toHour = pad(date.getHours(), 2);
		var toMinute = pad(date.getMinutes(), 2);
		var toSecond = pad(date.getSeconds(), 2);		
		var nowDate = toYear+toMonth+toDay+toHour+toMinute+toSecond;
		
		//console.log("nowDate", nowDate);
		
		$('#ORDER_DATE').val(nowDate);
	});
	
	
	/* 결제전이 아닌경우 상품수량 변겅 X */
	if($("select[name=ORDER_CON]").val() != "ORDER_CON_01"){
		$("input[name=ORDER_QTY]").attr("readonly","readonly");
		$("input[name=RETURN_QTY]").attr("readonly","readonly");
	}
	
	/* 수량변경 계산 */
	$('.btnQty').change(function(){
		// 변경조건 체크
		if($(this).closest("td").find("input[name^=ORDER_QTY]").attr("readonly")=="readonly"){
			alert("주문상태가 '결제전'이 아니므로 수량을 변경할 수 없습니다.");
			return;
		}
		var $_price = $(this).closest("td").find("input[name^=PD_PRICE]").val();
		var $_qty = $(this).closest("td").find("input[name^=ORDER_QTY]").val();
		var $_pdval = $(this).closest("td").find("input[name^=PDDC_VAL]").val();
		var $_pdgb = $(this).closest("td").find("input[name^=PDDC_GUBN]").val();
		
		var $_calamt = 0;
		
		if($_pdgb == 'PDDC_GUBN_02'){
			$_calamt = ($_price-$_pdval)*$_qty;
		}else if($_pdgb == 'PDDC_GUBN_03'){
			$_calamt = ($_price-($_price*$_pdval/100))*$_qty;
		}else{
			$_calamt = $_price * $_qty;
		}
		//$(this).closest("td").find(".orderAmt").text($_calamt);
		$(this).closest("td").next().next().text(addComma($_calamt));
		
		var totalOrderAmt = 0;
		
		for(var i=0;i<$(".orderAmt").size();i++){
			totalOrderAmt += parseInt($(".orderAmt:eq("+i+")").text().replace(/,/g, ''));
		}
		
		$("#totalPrdAmt").text(addComma(totalOrderAmt));
		$("#totalAmt").text(addComma(totalOrderAmt+parseInt($("#dlvyAmt").text().replace(/,/g, ''))));
	});
	
	/* //수량변경
	$('.btnQty').click(function(){
	
		if($(this).closest("td").find("input[name^=UPDATE_QTY]").attr("readonly")=="readonly"){
			alert("주문상태가 '결제전'이 아니므로 수량을 변경할 수 없습니다.")
			return;
		}
		var this_qty = $(this).closest("td").find("input[name^=UPDATE_QTY]").val();
		var this_num = $(this).closest("td").find("input[name^=UPDATE_NUM]").val();
		var this_dtnum = $(this).closest("td").find("input[name^=UPDATE_DTNUM]").val();
		
		var frm = document.getElementById("updateQtyFrm");
		
		frm.ORDER_NUM.value = this_num;
		frm.ORDER_DTNUM.value = this_dtnum;
		frm.ORDER_QTY.value = this_qty;
		
		frm.submit();
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

/* 반품신청 팝업 */
function fn_ord_return(){
	// 해당 주문번호에 대한 반품내역이 존재하면 알림팝업
	/* $.ajax({
		type: "GET",
		url: "${contextPath}/adm/returnOrderMgr/rtnCheck",
		data: $("#rtnInsertFrm").serialize(),
		success: function (data) {
			console.log(data);
			
			//반품내역 확인
			if(data == '0'){
				$('#myModal').modal('show');
			}else{				
				if(!confirm("해당 주문번호에 대한 기존 반품내역("+data+"건)이 존재합니다. \r계속 진행하시겠습니까?")) return;
				$('#myModal').modal('show');		
			}
		}, error: function (jqXHR, textStatus, errorThrown) {
			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
		}
	}); */
	
	var returnCnt = ${returnNum.size()};
	
	if(returnCnt > 0){
		if(!confirm("해당 주문번호에 대한 기존 반품내역("+returnCnt+"건)이 존재합니다. \r계속 진행하시겠습니까?")) return;
	}
	
	$('#myModal').modal('show');
}

/* 반품수량 체크*/
function isNumDash(ordQty, idx) {
	var e = document.getElementById("QTY_"+idx);
	var rtnQty = e.value;
	
	if(rtnQty > ordQty){
		alert("주문수량 이하의 값만 입력할 수 있습니다.");
		e.value = null;
	}
	if(rtnQty < 0){
		alert("0이상의 값만 입력할 수 있습니다.");
		e.value = null;
	}
}

/* 반품등록 */
function fn_rtn_insert(){
	var frm = document.getElementById("rtnInsertFrm");
	
	// 배송비 체크
	if(frm.DLVY_AMT.value == "" || frm.DLVY_AMT.value == null) {
		alert("반품 배송비를 입력해주세요.");
		return;
	}
	// 반품일자 체크
	if(frm.ORDER_DATE.value == "" || frm.ORDER_DATE.value == null) {
		alert("반품일자를 입력해주세요.");
		return;
	}
	// 반품사유 체크
	if(frm.RFND_MSG.value == "" || frm.RFND_MSG.value == null) {
		alert("반품사유를 선택해주세요.");
		return;
	}
	
	var checkboxValues = [];		// 상세번호
	var ordqtyValues = [];			// 반품수량
	var ordamtValues = [];		// 반품금액
	var dlvytdnValues = [];		// 운송장번호
	var check = 0;					// 수량체크
	var total = 0;						// 상품소계
	var dlvy = parseInt(frm.DLVY_AMT.value);
	
	if (isNaN(dlvy)){ dlvy = 0; }
	
	//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
	$("input:checkbox[name=RTN_CHK]:checked").each(function(){
		var idx = $(this).val();
		var qty = $("#QTY_"+idx).val();
		var real = $("#REAL_"+idx).val();
		var sum = qty * real;
		
		if(qty.trim().length < 1){
			check ++;
		}
		
		total += sum;
		
	 	checkboxValues.push(idx);
	 	ordqtyValues.push(qty);
	 	ordamtValues.push(sum);
	 	dlvytdnValues.push($("#TDN_"+idx).val());
	});

	if (check > 0) {
		alert("체크한 상품의 반품수량을 입력해주세요.");
		return;
	}
	
	if(checkboxValues.length < 1){
		checkboxValues.push("");			
		alert("반품할 상품을 선택해주세요.");
		return;
	}
	
	// form값 세팅
	frm.ORDER_AMT.value = total - dlvy;
	frm.ORDER_DTNUMS.value = checkboxValues;
	frm.ORDER_QTYS.value = ordqtyValues;
	frm.ORDER_AMTS.value = ordamtValues;
	frm.DLVY_TDNS.value = dlvytdnValues;
	
	//console.log("======str======");
	//console.log(frm.ORDER_AMT.value);
	//console.log(frm.ORDER_DTNUMS.value);
	//console.log(frm.ORDER_QTYS.value);
	//console.log(frm.ORDER_AMTS.value);
	//console.log(frm.DLVY_TDNS.value);
	//console.log("======end======");
	
	if(!confirm("반품을 등록하시겠습니까? (한번 등록된 수량은 변경할 수 없습니다)")) return;
	frm.submit();
}

/* 전체 체크 및 해제 */
function fn_all_chk(){
	var check_yn = false;
	
	if($("#CHK_ALL").is(":checked")){ check_yn = true; }
	console.log("str------" + check_yn);
	for(var i=1; i<= ${fn:length(tb_rtninfoxm.list) }; i++){
		$("#RTN_"+i).prop("checked", check_yn);
		console.log("ing------" + i);
	}
	console.log("end------");
}

//반품일시 format
function pad(number, length){
	var str = number.toString();
	
	while(str.length < length){
		str = '0' + str;
	}	
	return str;
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


<!-- Modal(반품) -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">반품신청</h4>
			</div>
			<spform:form class="form-horizontal" name="rtnInsertFrm" id="rtnInsertFrm" method="post" action="${contextPath}/adm/returnOrderMgr/insert2">
				<div class="modal-body">
					<div class="box box-info">
						<!-- 마스터 -->
						<input type="hidden" name="MEMB_ID" value="${tb_odinfoxm.MEMB_ID}" />		<!-- 주문자ID -->
						<input type="hidden" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM}"/>	<!-- 주문번호 -->
						<input type="hidden" name="ORIGIN_NUM" value="${tb_odinfoxm.ORDER_NUM}"/>	<!-- 원 주문번호 -->
						<input type="hidden" name="DAP_YN" value="Y"/>								<!-- 배송비 결제여부 -->
						<input type="hidden" name="PAY_METD" value="PAY_METD_99"/>					<!-- 결제수단: 무통장 환불 -->
						<input type="hidden" name="ORDER_CON" value="ORDER_CON_07"/>				<!-- 주문상태: 환불완료 -->
						<input type="hidden" name="DLVY_CON" value="DLVY_CON_03"/>					<!-- 배송상태: 배송완료 -->
						<input type="hidden" name="RFND_CON" value="RFND_CON_03"/>					<!-- 환불상태: 환불완료 -->
						<input type="hidden" name="CNCL_MSG" value="관리자 반품처리"/>					<!-- 취소/환불 상세사유 -->
						<input type="hidden" name="ORDER_AMT" value="0"/>							<!-- 반품합계 -->
						<input type="hidden" name="DLVY_TDN" value=""/>								<!-- 운송장번호 -->
						<input type="hidden" id="ORDER_DATE" name="ORDER_DATE" value="" />			<!-- 주문/반품일자 -->
																		
						<input type="hidden" id="ORDER_DTNUMS" name="ORDER_DTNUMS" value=""/>		
						<input type="hidden" id="ORDER_QTYS" name="ORDER_QTYS" value="" />				
						<input type="hidden" id="ORDER_AMTS" name="ORDER_AMTS" value="" />				
						<input type="hidden" id="DLVY_TDNS" name="DLVY_TDNS" value=""/>				<!-- 운송장번호 -->
						
						<div class="box-body">
							<table class="table table-bordered">
								<colgroup>
									<col />
									<col />
									<col />
								</colgroup>
								<thead>
									<tr>
										<th class="txt-middle"><input type="checkbox" id="CHK_ALL" onclick="fn_all_chk()"/></th>
										<th class="txt-middle">번호</th>
										<th>상품명</th>
										<th class="txt-right" style="width:14%">확정수량</th>
										<th class="txt-right" style="width:14%">반품수량</th>
										<th>운송장번호</th>
									</tr>
								</thead>
								<c:forEach items="${tb_rtninfoxm.list }" var="list" varStatus="loop">
									<!-- 옵션  -->
									<input type="hidden" id="OPTION_CODES" name="OPTION_CODES" value="${option_code}" />
									<input type="hidden" id="OPTION1_NAMES" name="OPTION1_NAMES" value="${list.OPTION1_NAME }">
									<input type="hidden" id="OPTION1_VALUES" name="OPTION1_VALUES" value="${list.OPTION1_VALUE}" />
									<input type="hidden" id="OPTION2_NAMES" name="OPTION2_NAMES" value="${list.OPTION2_NAME }">
									<input type="hidden" id="OPTION2_VALUES" name="OPTION2_VALUES" value="${list.OPTION2_VALUE}" />
				
									<!-- 디테일  -->
									<input type="hidden" id="PD_CODES" name="PD_CODES" value="${list.PD_CODE }"/>
									<input type="hidden" id="PD_NAMES" name="PD_NAMES" value="${list.PD_NAME }"/>
									<input type="hidden" id="PD_PRICES" name="PD_PRICES" value="${list.PD_PRICE }"/>
									<input type="hidden" id="PDDC_GUBNS" name="PDDC_GUBNS" value="${list.PDDC_GUBN}"/>
									<input type="hidden" id="PDDC_VALS" name="PDDC_VALS" value="${list.PDDC_VAL}"/>
									<input type="hidden" id="REAL_${list.ORDER_DTNUM }" name="REAL_PRICES" value="${list.REAL_PRICE}"/>									
									<input type="hidden" id="BOX_PDDC_GUBNS" name="BOX_PDDC_GUBNS" value="${list.BOX_PDDC_GUBN}"/>
									<input type="hidden" id="BOX_PDDC_VALS" name="BOX_PDDC_VALS" value="${list.BOX_PDDC_VAL}"/>
									<input type="hidden" id="BUNDLE_CNTS" name="BUNDLE_CNTS" value="${list.BUNDLE_CNT}" />
									<input type="hidden" id="INPUT_CNTS" name="INPUT_CNTS" value="${list.INPUT_CNT }"/>
																			
									<tr>
										<th class="txt-middle">
											<input type="checkbox" id="RTN_${list.ORDER_DTNUM }" name="RTN_CHK" value="${list.ORDER_DTNUM }"/>
										</th>
										<td class="txt-middle">${loop.count }</td>
										<td>${list.PD_NAME }
											<c:if test="${ list.PD_CUT_SEQ ne null }">(옵션 : ${ list.PD_CUT_SEQ})</c:if>
										</td>
										<td class="txt-right">
											<input type="hidden" class="form-control" id="ORIGIN_QTYS" value="${list.ORDER_QTY}"/> ${list.ORDER_QTY}											
										</td>
										<td class="txt-right">
											<input type="number" class="form-control" id="QTY_${list.ORDER_DTNUM }" value="" required onchange="javascript:isNumDash(${list.ORDER_QTY}, ${list.ORDER_DTNUM })"/>
										</td>
										<td>
											<input type="text" class="form-control" id="TDN_${list.ORDER_DTNUM }" value="" />
										</td>
									</tr>
								</c:forEach>
									<tr>
										<th class="txt-right" colspan="5">배송비 </th>
										<td class="txt-right">
											<div class="input-group">
												<input type="number" class="form-control" id="DLVY_AMT" name="DLVY_AMT" value="0" readonly required /><%-- ${ tb_odinfoxm.DLVY_AMT eq null ? 0 : tb_odinfoxm.DLVY_AMT } --%>
												<div class="input-group-addon">원</div>
											</div>
										</td>
									</tr>
									<tr>
										<th class="txt-right" colspan="5">반품일자</th>										
										<td class="txt-right" >
											<div class="input-group bootstrap-datepicker datepicker">		
												<input type="text" class="form-control" name="datepicker_return" id="datepicker_return" value="" readonly required>
												<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
											</div>											
										</td>
									</tr>
									<tr>
										<th class="txt-right" colspan="5">반품사유</th>										
										<td class="txt-right" >
											<jsp:include page="/common/comCodForm">
												<jsp:param name="COMM_CODE" value="RFND_MSG" />
												<jsp:param name="name" value="RFND_MSG" />
												<jsp:param name="value" value="${tb_odinfoxm.RFND_MSG }" />
												<jsp:param name="type" value="select" />
												<jsp:param name="top" value="선택해주세요." />
											</jsp:include>
										</td>
									</tr>
									<tr>
										<th class="txt-right" colspan="5">택배사</th>										
										<td class="txt-right" >
											<jsp:include page="/common/comCodForm">
												<jsp:param name="COMM_CODE" value="DLVY_COM" />
												<jsp:param name="name" value="DLVY_COM" />
												<jsp:param name="value" value="${tb_odinfoxm.DLVY_COM }" />
												<jsp:param name="type" value="select" />
												<jsp:param name="top" value="선택해주세요." />
											</jsp:include>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- /.box-body -->
					</div>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="fn_rtn_insert()">반품등록</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>				
				</div>
			</spform:form>
		</div>
	</div>
</div>
<!--/.반품신청  -->
 