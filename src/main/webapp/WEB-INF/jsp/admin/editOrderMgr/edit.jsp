<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- bootstrap datepicker -->
<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.css">
<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.min.css">

<!-- bootstrap datepicker -->
<script src="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.js"></script>
<script src="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.min.js"></script>

<c:set var="strActionUrl" value="${contextPath }/adm/orderEditMgr" />
<c:set var="strMethod" value="post" />

<section class="content-header">
	<h1>
		전표관리
		<small>전표수정</small>
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
			<!-- <button type="button" class="btn btn-success btn-sm pull-right left-5" id="btnExcel">엑셀</button> -->
		</div>
		<!-- /.box-header -->
		
		<div class="box-body">
			<div class="form-group">
				<label for="ORDER_NUM" class="col-sm-2 control-label">주문번호</label>
				<div class="col-sm-4">${tb_odinfoxm.ORDER_NUM }</div>
				<label for="MEMB_NM" class="col-sm-2 control-label">주문자</label>
				<div class="col-sm-4">${tb_odinfoxm.MEMB_NM }</div>						
			</div><br/>
			<div class="form-group">
				<label for="ORDER_DATE" class="col-sm-2 control-label">주문일자</label>
				<div class="col-sm-4">${tb_odinfoxm.ORDER_DATE }</div>
				<label for="DAP_YN" class="col-sm-2 control-label">배송비 결제여부</label>
				<div class="col-sm-4">${tb_odinfoxm.DAP_YN }</div>
			</div><br/>
			<div class="form-group">
				<label for="COM_BUNB" class="col-sm-2 control-label">사업자번호</label>
				<div class="col-sm-4">${tb_odinfoxm.COM_BUNB }</div>
				<label for="CPON_YN" class="col-sm-2 control-label">쿠폰 사용여부</label>
				<div class="col-sm-4">${tb_odinfoxm.CPON_YN }</div>
			</div><br>				
		</div>
		<!-- /.box-body -->
	</div>
	<!-- 주문 정보 끝 -->
	
	<!-- 업체별 상품 출력 2020-02-25 -->
	<spform:form class="form-horizontal" name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }">
		<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM }" /><!-- 주문번호 -->
		<input type="hidden" name="ORDER_DTM" value="${tb_odinfoxm.ORDER_DTM }" /><!-- 주문번호 -->
		<input type="hidden" name="CNCL_MSG" value="${tb_odinfoxm.CNCL_MSG eq null ? '' :  tb_odinfoxm.CNCL_MSG}" />
		<input type="hidden" name="MEMB_ID" value="${tb_odinfoxm.MEMB_ID }" /><!-- 주문자ID -->
		<input type="hidden" name="MEMB_NM" value="${tb_odinfoxm.MEMB_NM }" /><!-- 주문자명 -->
		<input type="hidden" name="MEMB_CPON" value="${tb_odinfoxm.MEMB_CPON }" /><!-- 주문자명 -->
		<input type="hidden" name="PAY_AMT"/>
		
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">상품 정보</h3>
			</div>
			<!-- /.box-header -->
			
			<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
				<c:set var="totalAmt" value="0"/><!-- 총합계 -->
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
								<th>수량</th>
								<th>판매가격</th>
								<th>주문금액</th>
								<th>주문상태</th>
								<th>택배사</th>
								<th>운송장번호</th>
								<th>외부주문코드</th>
							</tr>
						</thead>
						<tbody>
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
											<input type="number" name="ORDER_QTY" value="${list.ORDER_QTY }" class="form-control btnQty" 
												style="width:100%;margin-right:10px;display:inline"/>
											<input type="hidden" name="ORIGIN_QTY" value="${list.ORDER_QTY }" class="form-control btnQty" 
												style="width:100%;margin-right:10px;display:inline"/>
										<%
											}else{
										%>
											<input type="number" name="ORDER_QTY" value="${list.ORDER_QTY }" class="form-control btnQty" 
												style="width:100%;margin-right:10px;display:inline"/>
										<%
											}
										%>
										<input type="hidden" name="PD_CODE" value="${list.PD_CODE }"/>
										<input type="hidden" name="PD_NAME" value="${list.PD_NAME }"/>
										<input type="hidden" name="ORIGIN_QTY" value="${list.ORDER_QTY }"/>
										<input type="hidden" name="UPDATE_NUM" value="${list.ORDER_NUM }"/>
										<input type="hidden" name="UPDATE_DTNUM" value="${list.ORDER_DTNUM }"/>
										<input type="hidden" name="ORDER_DTNUM" value="${list.ORDER_DTNUM }"/>
										<input type="hidden" name="PDDC_VAL" value="${list.PDDC_VAL }"/>
										<input type="hidden" name="PD_PRICE" value="${list.PD_PRICE }"/>
										<input type="hidden" name="REAL_PRICE" value="${list.REAL_PRICE }"/>
										<input type="hidden" name="PDDC_GUBN" value="${list.PDDC_GUBN }"/>
										<input type="hidden" name="SUPR_ID" value="${list.SUPR_ID }"/>
										<input type="hidden" name="LOGIN_SUPR_ID" value="${login_supr_id }"/>
									</td>
									<td>
										<fmt:formatNumber>${list.REAL_PRICE }</fmt:formatNumber>
									</td>
									<td class="orderAmt">
										<fmt:formatNumber>${list.ORDER_AMT }</fmt:formatNumber>
									</td>
									<!-- 주문상태 -->
									<td>
										<jsp:include page="/common/comCodForm">
											<jsp:param name="COMM_CODE" value="ORDER_CON" />
											<jsp:param name="name" value="DTL_ORDER_CON" />
											<jsp:param name="value" value="${list.ORDER_CON }" />
											<jsp:param name="type" value="select" />
											<jsp:param name="top" value="선택" />
											<jsp:param name="attr1" value="disabled='disabled'" />
										</jsp:include>
									</td>									
									<td>${list.DLVY_COM }</td>
									<!-- 운송장변호 -->
									<c:if test="${supr.SUPR_ID eq login_supr_id or supr.SUPR_ID eq 'C00005'}">
										<td>
											<input type="text" name="DTL_DLVY_TDN" value="${list.DLVY_TDN }" class="form-control" 
														style="width:100%;margin-right:10px;display:inline" readonly/>
										</td>
									</c:if>
									<c:if test="${supr.SUPR_ID ne login_supr_id and supr.SUPR_ID ne 'C00005'}">
										<td>
											<input type="text" name="DTL_DLVY_TDN" value="${list.DLVY_TDN }" class="form-control" 
														style="width:100%;margin-right:10px;display:inline" readonly/>
										</td>
									</c:if>										
									<td>
										<input class="form-control" type="text" name="LOGIN_SUPR_ID" value="${list.LINK_ORDER_KEY }" style="width:100%;margin-right:10px;display:inline" readonly/>
									</td>
									<c:set var= "totalAmt" value="${totalAmt + list.ORDER_AMT}"/>
								</tr>
							</c:if>
						</c:forEach>						
						</tbody>
					</table>
				</c:forEach>				
				<!-- 주문상품 정보 끝 -->
				
				<!-- 주문 정보 footer -->	
				<table class="table table-bordered">
					<colgroup>
						<col style="width:10%" />
						<col style="width:44%" />
						<col style="with:14%" />
						<col style="width:16%" />
						<col style="width:16%" />
					</colgroup>
					<thead>
						<tr>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
						</tr>
					</thead>					
					<tbody>
						<tr>
							<th colspan="4" style="text-align:right;">상품 합계</th>
							<td id="totalPrdAmt" colspan="4" style="text-align:right">
								<fmt:formatNumber><c:out value="${tb_odinfoxm.ORDER_AMT - tb_odinfoxm.DLVY_AMT}"/></fmt:formatNumber>
							</td>
						</tr>
						<tr>
							<th colspan="4" style="text-align:right;">배송비 </th>
							<td id="dlvyAmt" colspan="4" style="text-align:right"> 
								<input type="hidden" name="PRE_DLVY_AMT" value="${tb_odinfoxm.DLVY_AMT }"/>
								<input type="number" class="form-control" style="text-align:right" 
									name="DLVY_AMT" id="DLVY_AMT" value="${tb_odinfoxm.DLVY_AMT }" readonly/>
							</td>
						</tr>
						<tr>
							<th colspan="4" style="text-align:right;">총 합계 </th>
							<td id="totalAmt" colspan="4" style="text-align:right">
								<fmt:formatNumber><c:out value="${tb_odinfoxm.ORDER_AMT}"/></fmt:formatNumber>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<!-- 배송지 정보 시작 -->
		<div class="box box-info">
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
					<div class="col-sm-4">${tb_oddlaixm.RECV_PERS }</div>
				</div>
				
				<div class="form-group">
					<input type="hidden" name="EXTRA_ADDR" value="" id="EXTRA_ADDR">
					<input type="hidden" name="ALL_ADDR" value="" id="ALL_ADDR">

					<label for="COM_PN" class="col-sm-2 control-label required">주소</label>
					<div class="col-sm-2">
						<div class="input-group">
							<input type="text" class="form-control" id="POST_NUM" name="POST_NUM" value="${tb_oddlaixm.POST_NUM }" required="required" readonly="readonly" maxlength="6"/>
							<span class="input-group-btn">
								<input type="button" class="btn btn-block btn-default" value="우편번호검색" >
							</span>
						</div>
					</div>						
				</div>					
				<div class="form-group">
					<label for="BASC_ADDR" class="col-sm-2 control-label"></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="BASC_ADDR" name="BASC_ADDR" value="${tb_oddlaixm.BASC_ADDR }" required="required" readonly="readonly" maxlength="100"/>							
					</div>
				</div>
				<div class="form-group">
					<label for="DTL_ADDR" class="col-sm-2 control-label"></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="DTL_ADDR" name="DTL_ADDR" value="${tb_oddlaixm.DTL_ADDR }" required="required" readonly="readonly" maxlength="100"/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="RECV_CPON" class="col-sm-2 control-label required">휴대전화</label>
					<div class="col-sm-4">${tb_oddlaixm.RECV_CPON }</div>
					<label for="RECV_TELN" class="col-sm-1 control-label">일반전화</label>
					<div class="col-sm-4">${tb_oddlaixm.RECV_TELN }</div>
				</div>
				
				<%-- <div class="form-group">
					<label for="DLVY_MSG" class="col-sm-2 control-label">배송 메세지</label>
					<div class="col-sm-9">
						<textarea rows="5" class="form-control" id="DLVY_MSG" name="DLVY_MSG" readonly="readonly">${tb_oddlaixm.DLVY_MSG }</textarea>
					</div>
				</div>
				
				<div class="form-group">
					<label for="ADM_REF" class="col-sm-2 control-label">관리자 참조설명</label>
					<div class="col-sm-9">							
						<textarea rows="5" class="form-control" id="ADM_REF" name="ADM_REF" readonly="readonly" >${tb_oddlaixm.ADM_REF }</textarea>
						<h6 style="color:red">* 관리자 참조설명은 회원관리에서 변경할 수 있습니다.</h6>
					</div>
				</div> --%>
			</div>
			<!-- /.box-body -->
		</div>
		<!-- 배송지 정보 끝 -->
		
		<!-- 주문 상태 및 결제 정보 시작 -->
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">주문 상태 및 결제 정보 (변경불가)</h3>
			</div>
			<!-- /.box-header -->
			<div class="box-body">
				<div class="form-group">
					<label for="ORDER_CON" class="col-sm-1 control-label">주문상태</label>
					<div class="col-sm-2">
						<jsp:include page="/common/comCodForm">
							<jsp:param name="COMM_CODE" value="ORDER_CON" />
							<jsp:param name="name" value="ORDER_CON" />
							<jsp:param name="value" value="${tb_odinfoxm.ORDER_CON }" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="선택" />
						</jsp:include>
					</div>
					<div class="col-sm-3">
						<jsp:include page="/common/comCodForm">
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
						</jsp:include>
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
						<jsp:include page="/common/comCodForm">
							<jsp:param name="COMM_CODE" value="PAY_METD" />
							<jsp:param name="name" value="PAY_METD" />
							<jsp:param name="value" value="${tb_odinfoxm.PAY_METD }" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="선택" />
						</jsp:include>
					</div>
					
					<label for="PAY_DTM" class="col-sm-1 control-label">결제 일시</label>
					<input type="hidden" name="PAY_DTM" id="PAY_DTM" value="${tb_odinfoxm.PAY_DTM }"/>
					<div class="col-sm-2">
						<div class="input-group bootstrap-datepicker datepicker" style="float: inherit;">	
							<input type="text" class="form-control pull-left" name="datepicker" id="datepicker" value="" readonly>
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</div>
					<div class="col-sm-2" style="padding-top:4px;padding-buttom:4px;">
						<div class="input-group bootstrap-timepicker timepicker" style="float: inherit;">		
							<input type="text" class="form-control pull-left" name="timepicker" id="timepicker" value="" readonly>
							<span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
				        </div>	
					</div>
					<label for="inputEmail3" class="col-sm-1 control-label">결제 상태</label>
					<div class="col-sm-1"></div>
				</div><br>
				
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
					<!-- <label for="DLVY_TDN" class="col-sm-1 control-label">운송장번호</label> -->
					<div class="col-sm-5">
						<input type="hidden" class="form-control" id="DLVY_TDN" name="DLVY_TDN" value="${tb_odinfoxm.DLVY_TDN }" maxlength="50"/>
					</div>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
		<!-- 주문 상태 및 결제 정보 끝 -->
		
		<div class="box-footer">
			<a href="${contextPath}/adm/orderCmptMgr" class="btn btn-default pull-right"><i class="fa fa-list"></i> 목록</a>
			<!-- <a onclick="javascript:fn_save();" class="btn btn-primary pull-right right-5"><i class="fa fa-save"></i> 저장</a> -->
			<button type="submit" class="btn btn-primary pull-right right-5"><i class="fa fa-save"></i> 저장</button>
			<a onclick="javascript:fn_pgCancel();" class="btn btn-warning"><i class="fa fa-credit-card"></i> PG 취소(전체취소)</a>
		</div>
		<!-- /.box-footer -->
	</spform:form>
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
	
	/* 수량변경 계산 */
	$('.btnQty').change(function(){
		var $_calamt = 0;																					// 소계
		var $_price = $(this).closest("td").find("input[name^=PD_PRICE]").val();		// 제품가격
		var $_real = $(this).closest("td").find("input[name^=REAL_PRICE]").val();		// 판매가격
		var $_origin = $(this).closest("td").find("input[name^=ORIGIN_QTY]").val();	// 원 주문수량
		var $_qty = $(this).closest("td").find("input[name^=ORDER_QTY]").val();		// 변동 주문수량
		var $_pdval = $(this).closest("td").find("input[name^=PDDC_VAL]").val();		// 제품할인 값
		var $_pdgb = $(this).closest("td").find("input[name^=PDDC_GUBN]").val();	// 제품할인구분
		$_calamt = $_real * $_qty;																		// 주문금액
		
		// 최대값 체크
		if ($_qty > $_origin){
			alert("변경수량은 원 주문수량보다 클 수 없습니다.");
			$(this).closest("td").find("input[name^=ORDER_QTY]").val($_origin);
			return;
		}
		
		/* if($_pdgb == 'PDDC_GUBN_02'){
			$_calamt = ($_price-$_pdval)*$_qty;
		}else if($_pdgb == 'PDDC_GUBN_03'){
			$_calamt = ($_price-($_price*$_pdval/100))*$_qty;
		}else{
			$_calamt = $_price * $_qty;
		} */
		
		//$(this).closest("td").find(".orderAmt").text($_calamt);
		$(this).closest("td").next().next().text(addComma($_calamt));
		
		var totalOrderAmt = 0;
		
		for(var i=0;i<$(".orderAmt").size();i++){
			totalOrderAmt += parseInt($(".orderAmt:eq("+i+")").text().replace(/,/g, ''));
		}
		
		if (totalOrderAmt == 0){
			$("#DLVY_AMT").val(0);
		}
		
		$("#totalPrdAmt").text(addComma(totalOrderAmt));
		$("#totalAmt").text(addComma(totalOrderAmt+parseInt($("#DLVY_AMT").val().replace(/,/g, ''))));
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
	
	if(getParameterByName("alertMessage")!=""){
		
		var alertmsg = getParameterByName("alertMessage");
		history.replaceState({}, null, location.pathname);		
		alert(alertmsg);
	}
	

    /* 필수값 체크 */
    $("#orderFrm").validate({
    	debug: false,
        onfocusout: false,
        rules: {
        	ORDER_QTY: {
        		number: true,
                required: true
            },
        	DLVY_AMT: {
        		number: true,
                required: true
            },
            PD_CODE: {
                required: true
            }            
        }, messages: {
        	PD_CODE: {
                required: '상품코드는 필수값입니다.'
            },
            DLVY_AMT: {
                required: '배송비를 입력해주세요.',
            	number: '배송비는 숫자만 입력하세요.'
            },
            ORDER_QTY: {
                required: '수량을 입력해주세요.',
            	number: '수량은 숫자만 입력하세요.'
            }
        }, errorPlacement: function(error, element) {
            // do nothing
        }, invalidHandler: function(form, validator) {
             var errors = validator.numberOfInvalids();
             if (errors) {
                 alert(validator.errorList[0].message);
                 validator.errorList[0].element.focus();
             }          
        }, submitHandler: function(form) {
        	 if(!confirm("저장 하시겠습니까?")) return;
        	form.submit();
        }
    });
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
	
	//-결제일시 str 
	/* var yyyymmdd = $('#datepicker').val().split("-").join("");
	var whatTm = $('#timepicker').val().split(" ")[1];
	var hours = parseInt(($('#timepicker').val().split(" ")[0]).split(":")[0]);
	var minute = ($('#timepicker').val().split(" ")[0]).split(":")[1];
	
	if(whatTm == "PM" && hours<12) hours = hours+12;
	if(whatTm == "AM" && hours==12) hours = hours-12;
	if(whatTm == "AM" && hours<10) hours = "0"+hours;
	
	if(yyyymmdd=="") frm.PAY_DTM.value= "";
	if(yyyymmdd!="") frm.PAY_DTM.value= yyyymmdd+hours+minute+"00";
	//-결제일시 end
	
	if(frm.ORDER_CON.value=='ORDER_CON_02' || frm.ORDER_CON.value=='ORDER_CON_03')
		frm.PAY_AMT.value = '<c:out value="${totalAmt + dlvyAmt}"/>';	
		
    if(frm.ORDER_CON.value=='ORDER_CON_01')
    	frm.PAY_AMT.value = '0';
    
    var dlar_gubn = "${tb_oddlaixm.DLAR_GUBN}";
    
    if( dlar_gubn  =="DLAR_GUBN_05" ){
	    $('#DLAR_DATE').val( $("#datepicker_dlar").val().split("-")[0]+$("#datepicker_dlar").val().split("-")[1]+$("#datepicker_dlar").val().split("-")[2] )
    	$('#DLAR_TIME').val( $("#DLAR_TIME_CHK_01 option:selected").val());
    }else{    	
    	if($('#datepicker_dlar').val()!=""&&$('#datepicker_dlar').val()!=null)    		
    		$('#DLAR_DATE').val( $("#datepicker_dlar").val().split("-")[0]+$("#datepicker_dlar").val().split("-")[1]+$("#datepicker_dlar").val().split("-")[2] )
    	
    	$('#DLAR_TIME').val( $("#DLAR_TIME_CHK_02 option:selected").val());
    } */
   
    //if(!confirm("저장 하시겠습니까?")) return;
	
	//frm.submit();
}

// 연동상품 주문
function fn_orderLink(){
	var frm=document.getElementById("orderFrm");
	if(!confirm("오너클랜, 모든오피스\n주문요청 하시겠습니까?")) return;
	$("#orderFrm").attr("action", "/adm/orderMgr/orderlinkapi");
	frm.submit();
}

// pg취소 (결제취소)
function fn_pgCancel(){
	var frm=document.getElementById("orderFrm");
	if(!confirm("PG(결제) 전체취소 하시겠습니까?")) return;
	$("#orderFrm").attr("action", "/adm/orderMgr/pgCancel");
	frm.submit();
}

/* 숫자콤마만드는 함수 */
function addComma(num) {
	var regexp = /\B(?=(\d{3})+(?!\d))/g;
	return num.toString().replace(regexp, ',');
}

// get 파라미터를 네임으로 가지고오는 함수
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}
</script>