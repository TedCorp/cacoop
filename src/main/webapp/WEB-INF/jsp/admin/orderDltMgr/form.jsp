
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- bootstrap datepicker -->
<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.css">
<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.min.css">

<!-- bootstrap datepicker -->
<script src="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.js"></script>
<script src="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.min.js"></script>

<c:set var="strActionUrl" value="${contextPath }/adm/orderDtlMgr/" />
<c:set var="strMethod" value="post" />

<section class="content-header">
	<h1>
		취소주문관리	
		<small>취소주문내역</small>
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
			<h3 class="box-title">취소주문정보</h3>
			<button type="button" class="btn btn-default btn-sm pull-right btnHelp">
				<i class="fa fa-question-circle"></i> 도움말
			</button>
			<button type="button" class="btn btn-success btn-sm pull-right right-5" id="btnExcel">
				<i class="fa fa-file-excel-o" aria-hidden="true"></i> 엑셀
			</button>
		</div>
		<!-- /.box-header -->
		
		<div class="box-body">
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label">주문번호</label>
				<div class="col-sm-4">${tb_odinfoxm.ORDER_NUM }</div>
				<label for="inputEmail3" class="col-sm-2 control-label">주문자</label>
				<div class="col-sm-4">${tb_odinfoxm.MEMB_NM }</div>
			</div><br/>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label">주문일자</label>
				<div class="col-sm-4">${tb_odinfoxm.ORDER_DATE }</div>
				<label for="inputEmail3" class="col-sm-2 control-label">배송비 결제 여부</label>
				<div class="col-sm-4">${tb_odinfoxm.DAP_YN } (쿠폰 사용 : ${tb_odinfoxm.CPON_YN })</div>
			</div>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- 주문 정보 끝 -->
	
	<!-- 주문상품 정보 시작 -업체별 상품 출력 2020-02-25 -->
	<spform:form class="form-horizontal" name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }">
		<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM }" /><!-- 주문번호 -->
		<input type="hidden" name="PAY_AMT"/>
		
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">상품 정보</h3>
			</div>
			<!-- /.box-header -->
				
			<div class="box-body">
				<c:set var="totalAmt" value="0"/>
				<c:forEach items="${pd_supr_list}" var="supr" varStatus="loop">
					<table class="table table-bordered">
						<caption><b>${loop.count}. ${supr.SUPR_NAME}</b></caption>
						<colgroup>
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>상품명</th>
								<th>수량</th>
								<th>할인가격</th>
								<th>가격</th>
								<th>주문상태</th>
								<th>운송장번호</th>
								<th>외부주문코드</th>
							</tr>
						</thead>
						
						<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
							<c:if test="${supr.SUPR_ID eq list.SUPR_ID }">
								<tr>
									<td>${list.ORDER_DTNUM }</td>
									<td>${list.PD_NAME } 
										<c:if test="${ list.PD_CUT_SEQ ne null }">(세절방식 : ${ list.PD_CUT_SEQ})</c:if>
										<c:if test="${ list.OPTION_CODE ne null }">(색상 : ${ list.OPTION_CODE})</c:if>
									</td>
									<td>
										${list.ORDER_QTY }
										<input type="hidden" name="UPDATE_NUM" value="${list.ORDER_NUM }"/>
										<input type="hidden" name="UPDATE_DTNUM" value="${list.ORDER_DTNUM }"/>
										<input type="hidden" name="ORDER_DTNUM" value="${list.ORDER_DTNUM }"/>
										<input type="hidden" name="PDDC_VAL" value="${list.PDDC_VAL }"/>
										<input type="hidden" name="PD_PRICE" value="${list.PD_PRICE }"/>
										<input type="hidden" name="PDDC_GUBN" value="${list.PDDC_GUBN }"/>
										<input type="hidden" name="SUPR_ID" value="${list.SUPR_ID }"/>
										<input type="hidden" name="LOGIN_SUPR_ID" value="${login_supr_id }"/>
									</td>
									<td><fmt:formatNumber>${list.PDDC_VAL }</fmt:formatNumber></td>
									<td class="orderAmt"><fmt:formatNumber>${list.ORDER_AMT }</fmt:formatNumber></td>
									
									<!-- 주문상태 -->
									<td>
										<jsp:include page="/common/comCodName">
											<jsp:param name="COMM_CODE" value="ORDER_CON" />
											<jsp:param name="COMD_CODE" value="${tb_odinfoxm.ORDER_CON }" />
											<jsp:param name="type" value="text" />
										</jsp:include>
									</td>
									<!-- 운송장변호 -->
									<td>${list.DLVY_TDN }</td>
									<td> ${list.LINK_ORDER_KEY }</td>
									
									<c:set var= "totalAmt" value="${totalAmt + list.ORDER_AMT}"/>
								</tr>
							</c:if>
						</c:forEach>
							<tr>
								<th colspan="7" style="text-align:right;">상품 합계</th>
								<td id="totalPrdAmt" colspan="1" style="text-align:right">
									<fmt:formatNumber><c:out value="${totalAmt}"/></fmt:formatNumber>
								</td>
							</tr>
							<tr>
								<th colspan="7" style="text-align:right;">배송비 </th>
								<td id="dlvyAmt" colspan="1" style="text-align:right"> 
									<fmt:formatNumber><c:out value="${tb_odinfoxm.DLVY_AMT }"/></fmt:formatNumber>
								</td>
							</tr>
							<tr>
								<th colspan="7" style="text-align:right;">총 합계 </th>
								<td id="totalAmt" colspan="1" style="text-align:right">
									<fmt:formatNumber><c:out value="${tb_odinfoxm.ORDER_AMT }"/></fmt:formatNumber>
								</td>
							</tr>
						</tbody>
					</table>					
				</c:forEach>
			</div>
		</div>
		<!-- 주문상품 정보 끝 -->
		
		<!-- 배송지 정보 시작 -->
		<div class="box box-default">
			<div class="box-header with-border">
				<h3 class="box-title">배송지 정보</h3>
				<div class="pull-right">
					<jsp:include page="/common/comCodForm">
						<jsp:param name="COMM_CODE" value="DLAR_GUBN" />
						<jsp:param name="name" value="DLAR_GUBN" />
						<jsp:param name="value" value="${tb_oddlaixm.DLAR_GUBN }" />
						<jsp:param name="type" value="radio" />
						<jsp:param name="top" value="선택" />
					</jsp:include>
				</div>
			</div>
			<!-- /.box-header -->
			<div class="box-body">
				<div class="form-group">
					<label for="RECV_PERS" class="col-sm-2 control-label required">받으시는 분</label>
					<div class="col-sm-4">
						${tb_oddlaixm.RECV_PERS }
						<%-- <input type="text" class="form-control" id="RECV_PERS" name="RECV_PERS" value="${tb_oddlaixm.RECV_PERS }" required="required" maxlength="20"/> --%>
					</div>
				</div>
				
				<div class="form-group">
					<input type="hidden" name="EXTRA_ADDR" value="" id="EXTRA_ADDR">
					<input type="hidden" name="ALL_ADDR" value="" id="ALL_ADDR">

					<label for="COM_PN" class="col-sm-2 control-label required">주소</label>
					<div class="col-sm-2">
						<div class="input-group">
							<input type="text" class="form-control" id="POST_NUM" name="POST_NUM" value="${tb_oddlaixm.POST_NUM }" readonly="readonly" maxlength="6"/>
							<span class="input-group-btn">
								<input type="button" class="btn btn-block btn-default" value="우편번호검색" >
							</span>
						</div>
					</div>						
				</div>					
				<div class="form-group">
					<label for="BASC_ADDR" class="col-sm-2 control-label"></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="BASC_ADDR" name="BASC_ADDR" value="${tb_oddlaixm.BASC_ADDR }" readonly="readonly" maxlength="100"/>							
					</div>
				</div>
				<div class="form-group">
					<label for="DTL_ADDR" class="col-sm-2 control-label"></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="DTL_ADDR" name="DTL_ADDR" value="${tb_oddlaixm.DTL_ADDR }" readonly="readonly" maxlength="100"/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="RECV_CPON" class="col-sm-2 control-label required">휴대전화</label>
					<div class="col-sm-4">
						${tb_oddlaixm.RECV_CPON }
						<%-- <input type="text" class="form-control" id="RECV_CPON" name="RECV_CPON" value="${tb_oddlaixm.RECV_CPON }" required="required"  /> --%>
					</div>
					<label for="RECV_TELN" class="col-sm-1 control-label">일반전화</label>
					<div class="col-sm-4">
						${tb_oddlaixm.RECV_TELN }
						<%-- <input type="text" class="form-control" id="RECV_TELN" name="RECV_TELN" value="${tb_oddlaixm.RECV_TELN }" required="required"  /> --%>
					</div>					
				</div>
				
				<div class="form-group">				
					<input type="hidden" id="DLAR_DATE" name="DLAR_DATE" value="${tb_oddlaixm.DLAR_DATE }" /><!-- 출고일 -->
					<input type="hidden" id="DLAR_TIME" name="DLAR_TIME" value="${tb_oddlaixm.DLAR_TIME }" /><!-- 출고/배송 시간 -->
					
					 <c:if test = '${tb_oddlaixm.DLAR_GUBN eq "DLAR_GUBN_05" }' >
						<label for="inputEmail3" class="col-sm-2 control-label">현장출고일시</label>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker" style="float: inherit;">		
							<input type="text" class="form-control pull-left" name="datepicker_dlar" id="datepicker_dlar" value="" readonly="readonly">
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
						</div>
						<div class="col-sm-2" style="padding-left:0px;padding-right:0px;padding-top:4px;padding-buttom:4px;">
							<select id="DLAR_TIME_CHK_01" class="form-control" >
								<option value="PM 1시~2시" <c:if test = '${tb_oddlaixm.DLAR_TIME eq "PM 1시~2시" }'>selected="selected"</c:if>>PM 1시~2시</option>
								<option value="PM 2시~3시" <c:if test = '${tb_oddlaixm.DLAR_TIME eq "PM 2시~3시" }'>selected="selected"</c:if>>PM 2시~3시</option>
								<option value="PM 3시~4시" <c:if test = '${tb_oddlaixm.DLAR_TIME eq "PM 3시~4시" }'>selected="selected"</c:if>>PM 3시~4시</option>
								<option value="PM 4시~6시" <c:if test = '${tb_oddlaixm.DLAR_TIME eq "PM 4시~6시" }'>selected="selected"</c:if>>PM 4시~6시</option>
				        	</select>
						</div>
					</c:if>
					 
					 <c:if test="${tb_oddlaixm.DLAR_GUBN ne 'DLAR_GUBN_05' }" >
						<label for="DLAR_TIME" class="col-sm-2 control-label">* 배송일시</label>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker" style="float: inherit;">		
								<input type="text" class="form-control pull-left" name="datepicker_dlar" id="datepicker_dlar" value="" readonly="readonly">
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
						</div>
						<div class="col-sm-1">
							${tb_oddlaixm.DLAR_TIME }
							<%-- <select name="DLAR_TIME_CHK_02" id="DLAR_TIME_CHK_02" class="form-control" >
								<option value="nothing">선택</option>
								<option value="오전" <c:if test = '${tb_oddlaixm.DLAR_TIME eq "오전" }'>selected="selected"</c:if>>오전</option>
								<option value="오후" <c:if test = '${tb_oddlaixm.DLAR_TIME eq "오후" }'>selected="selected"</c:if>>오후</option>									
				        	</select> --%>
						</div>
					</c:if>					
				</div>
				
				<div class="form-group">
					<label for="DLVY_MSG" class="col-sm-2 control-label">배송 메세지</label>
					<div class="col-sm-9">
						<textarea rows="5" class="form-control" id="DLVY_MSG" name="DLVY_MSG" required="required">${tb_oddlaixm.DLVY_MSG }</textarea>
					</div>
				</div>
				
				<div class="form-group">
					<label for="ADM_REF" class="col-sm-2 control-label">관리자 참조설명</label>
					<div class="col-sm-9">							
						<textarea rows="5" class="form-control" id="ADM_REF" name="ADM_REF" readonly="readonly" >${tb_oddlaixm.ADM_REF }</textarea>
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
						<%-- <jsp:include page="/common/comCodForm">
							<jsp:param name="COMM_CODE" value="ORDER_CON" />
							<jsp:param name="name" value="ORDER_CON" />
							<jsp:param name="value" value="${tb_odinfoxm.ORDER_CON }" />
							<jsp:param name="type" value="text" />
							<jsp:param name="top" value="선택" />
						</jsp:include> --%>
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
						<%-- <jsp:include page="/common/comCodForm">
							<jsp:param name="COMM_CODE" value="CNCL_CON" />
							<jsp:param name="name" value="CNCL_CON" />
							<jsp:param name="value" value="${tb_odinfoxm.CNCL_CON }" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="선택" />
						</jsp:include>
						<jsp:include page="/common/comCodForm">
							<jsp:param name="COMM_CODE" value="RFND_CON" />
							<jsp:param name="name" value="RFND_CON" />
							<jsp:param name="value" value="${tb_odinfoxm.RFND_CON }" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="선택" />
						</jsp:include> --%>
					</div>
					<c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_04'}">
						<label for="CNCL_MSG" class="col-sm-1 control-label">취소사유</label>
						<div class="col-sm-2">
							${tb_odinfoxm.CNCL_MSG }
						</div>
					</c:if>
				</div><br>
				
				<div class="form-group">
					<label for="PAY_METD" class="col-sm-1 control-label">결제 수단</label>
					<div class="col-sm-2">
						<jsp:include page="/common/comCodName">
							<jsp:param name="COMM_CODE" value="PAY_METD" />
							<jsp:param name="COMD_CODE" value="${tb_odinfoxm.PAY_METD }" />
							<jsp:param name="type" value="text" />
						</jsp:include>
						<%-- <jsp:include page="/common/comCodForm">
							<jsp:param name="COMM_CODE" value="PAY_METD" />
							<jsp:param name="name" value="PAY_METD" />
							<jsp:param name="value" value="${tb_odinfoxm.PAY_METD }" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="선택" />
						</jsp:include> --%>
					</div>
					
					<label for="PAY_DTM" class="col-sm-1 control-label">결제 일시</label>
					<div class="col-sm-2">
						${tb_odinfoxm.PAY_DTM }
						<input type="hidden" name="PAY_DTM" id="PAY_DTM" value="${tb_odinfoxm.PAY_DTM }"/>
						<!-- <div class="input-group bootstrap-datepicker datepicker" style="float: inherit;">	
							<input type="text" class="form-control pull-left" name="datepicker" id="datepicker" value="" readonly>
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div> -->
					</div>
					<!-- <div class="col-sm-2" style="padding-top:4px;padding-buttom:4px;">
						<div class="input-group bootstrap-timepicker timepicker" style="float: inherit;">		
							<input type="text" class="form-control pull-left" name="timepicker" id="timepicker" value="" readonly>
							<span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
				        </div>	
					</div> -->
					<label for="inputEmail3" class="col-sm-1 control-label">결제 상태</label>
					<div class="col-sm-1"></div>
				</div><br>
				
				<div class="form-group">
					<label for="DLVY_COM" class="col-sm-1 control-label">배송 정보</label>
					<div class="col-sm-2">
						<jsp:include page="/common/comCodName">
							<jsp:param name="COMM_CODE" value="DLVY_COM" />
							<jsp:param name="COMD_CODE" value="${tb_odinfoxm.DLVY_COM }" />
							<jsp:param name="type" value="text" />
						</jsp:include>
						<%-- <jsp:include page="/common/comCodForm">
							<jsp:param name="COMM_CODE" value="DLVY_COM" />
							<jsp:param name="name" value="DLVY_COM" />
							<jsp:param name="value" value="${tb_odinfoxm.DLVY_COM }" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="선택" />
						</jsp:include> --%>
					</div>
					<!-- <label for="inputEmail3" class="col-sm-1 control-label">운송장번호</label> -->
					<div class="col-sm-5">
						<input type="hidden" class="form-control" id="DLVY_TDN" name="DLVY_TDN" value="${tb_odinfoxm.DLVY_TDN }"  />
					</div>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
		<!-- 주문 상태 및 결제 정보 끝 -->
	</spform:form>
	
	<div class="box-footer">
		<a href="${contextPath}/adm/orderDltMgr" class="btn btn-default pull-right">리스트</a>
	</div>
	<!-- /.box-footer -->
</section>

<script type="text/javascript">
$(document).ready(function() {
	fn_disabled();
	
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
	
	//현장출고일시/배송일시 표시
	var dlar_date = ${tb_oddlaixm.DLAR_DATE}+"";
    
	if(dlar_date!=""&&dlar_date!=null){
		$('#datepicker_dlar').datepicker("setDate"
				,new Date(dlar_date.substr(0,4),dlar_date.substr(4,2)-1,dlar_date.substr(6,2)));
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

//엑셀
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

function fn_disabled(){
	//주문 취소
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

function addComma(num) { //숫자콤마만드는 함수
	var regexp = /\B(?=(\d{3})+(?!\d))/g;
	return num.toString().replace(regexp, ',');
}
</script>