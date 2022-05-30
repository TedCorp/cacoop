<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  
<%@page isELIgnored="false" %>
<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<!-- Main Container  -->
<div class="main-container container">
	<ul class="breadcrumb">
		<li><a href="${contextPath }/m"><i class="fa fa-home"></i></a></li>
		<li><a href="${contextPath }/m/order/wishList">반품/환불 신청</a></li>
	</ul>

	<div class="row">
		<!--Middle Part Start-->
		<form name="refundFrm" id="refundFrm" method="POST" action="${contextPath}/m/order/refund" onsubmit="return fnValidationCheck();" autocomplete="off">
			<!-- 마스터 -->
			<input type="hidden" name="MEMB_ID" value="${tb_odinfoxm.MEMB_ID}" />			<!-- 주문자ID -->
			<input type="hidden" name="ORIGIN_NUM" value="${tb_odinfoxm.ORDER_NUM}"/>		<!-- 원 주문번호 -->
			<input type="hidden" name="DAP_YN" value="Y"/>									<!-- 배송비결제YN -->
			<input type="hidden" name="DLVY_AMT" value="0"/>								<!-- 배송비 -->
			<input type="hidden" name="PAY_METD" value="${tb_odinfoxm.PAY_METD}"/>			<!-- 결제수단 -->
			<input type="hidden" name="ORDER_CON" value="ORDER_CON_11"/>					<!-- 주문상태: 환불신청 -->
			<input type="hidden" name="DLVY_CON" value="DLVY_CON_01"/>						<!-- 배송상태: 배송전 -->
			<input type="hidden" name="RFND_CON" value="RFND_CON_01"/>						<!-- 환불상태: 환불접수 -->
			<input type="hidden" name="ORDER_AMT" value="0"/>								<!-- 반품합계 -->
			<input type="hidden" name="DLVY_TDN" value=""/>									<!-- 운송장번호 -->
			<input type="hidden" name="ORDER_DATE" value="" />								<!-- 주문/반품일자 -->
			<input type="hidden" id="DLVY_FEE" value="${supplierInfo.DLVY_AMT}" />			<!-- 기본배송비 -->
			<!-- 상품정보 -->
			<input type="hidden" name="ORDER_DTNUMS" id="ORDER_DTNUMS" value="">
			<input type="hidden" name="PD_CODES" id="PD_CODES" value="">
			<input type="hidden" name="PD_NAMES" id="PD_NAMES" value="" /> 
			<input type="hidden" name="PD_PRICES" id="PD_PRICES" value="" />
			<input type="hidden" name="PDDC_GUBNS" id="PDDC_GUBNS" value="" /> 
			<input type="hidden" name="PDDC_VALS" id="PDDC_VALS" value="" />
			<input type="hidden" name="ORDER_QTYS" id="ORDER_QTYS" value="" />
			<input type="hidden" name="REAL_PRICES" id="REAL_PRICES" value="" />
			<input type="hidden" name="ORDER_AMTS" id="ORDER_AMTS" value="" /> 
			<input type="hidden" name="PD_CUT_SEQS" id="PD_CUT_SEQS" value="" />
			
			<div id="content" class="col-sm-12">
				<div class="row">
					<!-- 주문정보 -->
					<div class="col-left col-sm-6">
						<div class="table-responsive form-group">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title">
										<i class="fa fa-shopping-cart"></i>
										<label>&nbsp;환불 상품 정보</label>
									</h4>
								</div>
								<div class="panel-body">
									<div class="table-responsive">
										<table class="table table-bordered">
											<thead>
												<tr>
													<td class="text-center"></td>
													<td class="text-center">상품명</td>
													<td class="text-center">환불가능수량</td>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
													<tr>
														<td class="text-center">
															<!-- 상품정보 -->
															<input type="hidden" id="PD_CODE_${list.ORDER_DTNUM}" name="PD_CODE" value="${list.PD_CODE }">
															<input type="hidden" id="PD_NAME_${list.ORDER_DTNUM}" name="PD_NAME" value="${list.PD_NAME}" /> 
															<input type="hidden" id="PD_PRICE_${list.ORDER_DTNUM}" name="PD_PRICE" value="${list.PD_PRICE}" />
															<input type="hidden" id="PDDC_GUBN_${list.ORDER_DTNUM}" name="PDDC_GUBN" value="${list.PDDC_GUBN}" /> 
															<input type="hidden" id="PDDC_VAL_${list.ORDER_DTNUM}" name="PDDC_VAL" value="${list.PDDC_VAL}" />
															<input type="hidden" id="ORDER_AMT_${list.ORDER_DTNUM}" name="ORDER_AMT" value="${list.ORDER_AMT}" /> 
															<input type="hidden" id="PD_CUT_SEQ_${list.ORDER_DTNUM}" name="PD_CUT_SEQ" value="${list.PD_CUT_SEQ }" />
															<!-- 박스할인율
															<input type="hidden" id="BOX_PDDC_GUBN_${list.ORDER_DTNUM}" name="BOX_PDDC_GUBN" value="${list.BOX_PDDC_GUBN}"/>
															<input type="hidden" id="BOX_PDDC_VAL_${list.ORDER_DTNUM}" name="BOX_PDDC_VAL" value="${list.BOX_PDDC_VAL}"/>
															<input type="hidden" id="BUNDLE_CNT_${list.ORDER_DTNUM}" name="BUNDLE_CNT" value="${list.BUNDLE_CNT}" />
															<input type="hidden" id="INPUT_CNT_${list.ORDER_DTNUM}" name="INPUT_CNT" value="${list.INPUT_CNT }"/> -->
															<!-- 운송장번호 -->
															<input type="hidden" id="DLVY_TDN_${list.ORDER_DTNUM}" name="DLVY_TDN" value="${list.DLVY_TDN}"/>
															<input type="hidden" id="REAL_PRICE_${list.ORDER_DTNUM}" name="REAL_PRICE" value="${list.REAL_PRICE}"/>								
															
															<!-- 체크박스 -->
															<input type="checkbox" id="ORDER_DTNUM_${list.ORDER_DTNUM}" name="ORDER_DTNUM" value="${list.ORDER_DTNUM}"/>
														</td>
														<td class="text-left">
															<b><a href="${contextPath}/m/product/view/${list.PD_CODE}" target="_blank">${ list.PD_NAME }</a></b>
															<c:if test="${list.PD_CUT_SEQ ne null}"><br>(세절방식 : ${list.PD_CUT_SEQ_UNIT})</c:if>
															<c:if test="${list.OPTION_CODE ne null}"><br>(색상 : ${list.OPTION_NAME})</c:if>
														</td>
														<td class="text-center">
															<select class="form-control select" id="ORDER_QTY_${list.ORDER_DTNUM}" name="ORDER_QTY">
																<option value="">수량을 선택해주세요.</option>
																<c:forEach var="i" begin="1" end="${list.ORDER_QTY}">
																	<option value="${i}">${i}</option>
																</c:forEach>
															</select>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /.주문상세 정보 -->
					
					<div class="col-right col-sm-6">
						<div class="row">
							<div class="table-responsive form-group">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<i class="fa fa-credit-card"></i><label>&nbsp; 환불 상세 정보</label>
										</h4>
									</div>
									<div class="panel-body">
										<div class="table-responsive">
											<table class="table table-bordered">
												<tr>
													<th scope="row">환불수단</th>
													<td>${tb_odinfoxm.PAY_METD_NM}</td>
												</tr>
												<tr>
													<th scope="row" rowspan="2">환불사유</th>
													<td>
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
													<td>
														<textarea name="CNCL_MSG" class="form-control" rows="5" placeholder="상세사유를 입력해주세요."></textarea>
													</td>
												</tr>
												<!-- <tr>
													<th scope="row">환불예정금액</th>
													<td>--원</td>
												</tr> -->
											</table>
										</div>
									</div>
								</div>
							</div>
							<!-- /.결제 정보 -->
							
							<div class="table-responsive form-group">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<i class="fa fa-truck"></i>
											<label>&nbsp;반품시 주의사항</label>
										</h4>
									</div>
									<div class="panel-body">
										<label>* 단순 변심에 의한 환불 시 <b style="color:orange;">'반품 배송비'</b>를 부담하셔야 합니다.</label>
										<label>* 상품이 사용/손상/훼손된 경우에는 반품이 불가능합니다.</label>
										<label>* 무료배송, 조건부 무료 상품인 경우 <b style="color:orange;">[최초 배송비 + 반품 배송비]</b>가 발생되고, 선결제 상품은 <b style="color:orange;">[반품배송비]</b>만 발생됩니다.</label>
										<label>* 추가 문의사항은 고객센터(070-4337-2910) 또는 1:1문의를 이용해주세요.</label>
									</div>
								</div>
							</div>
							<!--/.반품안내 -->
						</div>
						
						<div class="buttons pull-right">
							<a href="${contextPath }/m/order/view/${tb_odinfoxm.ORDER_NUM}" class="btn btn-default">이전</a>
							<button type="submit" id="btnRefund" class="btn btn-primary">환불 요청하기</button>
						</div>
					</div>
				</div>
			</div>
			<!--Middle Part End -->
		</form>
	</div>
</div>
<!-- //Main Container -->

<script type="text/javascript">
$(function() {
	//환불사유 required
	$("select[name=RFND_MSG]").attr("required" , true);
	$("select[name=RFND_MSG]").change(function(){
		console.log($(this).val());
		if($(this).val() == "RFND_MSG_01"){
			$("[name=DLVY_AMT]").val($("#DLVY_FEE").val());
		} else {
			$("[name=DLVY_AMT]").val("0");
		}
	});
	
	//체크박스 선택시 수량 required
	$("[name=ORDER_DTNUM]").change(function(){
		var idx = $(this).val();
		if($(this).is(":checked")){
			$("#ORDER_QTY_"+idx).attr("required" , true);
		} else {
			$("#ORDER_QTY_"+idx).attr("required" , false);
		}
	});
	
});

function fnValidationCheck(){
	// 환불사유 
	if($("select[name=RFND_MSG]").val() == ""){
		alert("환불사유를 선택해주세요.");
		$("select[name=RFND_MSG]").focus();
		return false;
	}
	
	if($("input:checkbox[name=ORDER_DTNUM]:checked").length < 1){
		alert("환불요청할 상품을 선택해주세요.");
		return false;
	}
	
	// 변수
	var orderdtnums = [];
	var pdcodes = [];
	var pdnames = [];
	var pdprices = [];
	var pddcgubns = [];
	var pddcvals = [];
	var orderqtys = [];
	var realprices = [];
	var orderamts = [];
	var pdcutseqs = [];
	
	// 선택된 상품 필수값 체크
	$("input:checkbox[name=ORDER_DTNUM]:checked").each(function(){
		var idx = $(this).val();
		var qty = $("#ORDER_QTY_"+idx).val();
		var price = $("#REAL_PRICE_"+idx).val();

		if (qty == ""){
			alert("수량을 선택해주세요.");
			$("#ORDER_QTY_"+idx).focus();
			return false;
		}
		$("#ORDER_AMT_"+idx).val(qty * price);
		
		// 값 세팅
		orderdtnums.push(idx);
		pdcodes.push($('#PD_CODE_'+idx).val());
		pdnames.push($('#PD_NAME_'+idx).val().replaceAll(",","@!"));
		pdprices.push($('#PD_PRICE_'+idx).val());
		pddcgubns.push($('#PDDC_GUBN_'+idx).val());
		pddcvals.push($('#PDDC_VAL_'+idx).val());
		orderqtys.push(qty);
		realprices.push(price);
		orderamts.push($('#ORDER_QTY_'+idx).val());
		pdcutseqs.push($('#PD_CUT_SEQ_'+idx).val());
	});

	if(!confirm("환불요청 하시겠습니까?")) return;
	
	console.log('orderdtnums', orderdtnums);
	console.log('pdcodes', pdcodes);
	console.log('pdnames', pdnames);
	console.log('pdprices', pdprices);
	console.log('pddcgubns', pddcgubns);
	console.log('pddcvals', pddcvals);
	console.log('orderqtys', orderqtys);
	console.log('pdcutseqs', pdcutseqs);
	console.log('realprices', realprices);
	console.log('orderamts', orderamts);
	
	$("#ORDER_DTNUMS").val(orderdtnums);
	$("#PD_CODES").val(pdcodes);
	$("#PD_NAMES").val(pdnames);
	$("#PD_PRICES").val(pdprices);
	$("#PDDC_GUBNS").val(pddcgubns);
	$("#PDDC_VALS").val(pddcvals);
	$("#ORDER_QTYS").val(orderqtys);
	$("#REAL_PRICES").val(realprices);
	$("#ORDER_AMTS").val(orderamts);
	$("#PD_CUT_SEQS").val(pdcutseqs);
}
</script>