<%--
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<!-- Main Container  -->
<div class="main-container container">
	<ul class="breadcrumb">
		<li><a href="${contextPath }/m"><i class="fa fa-home"></i></a></li>
		<li><a href="${contextPath }/m/order/wishList">배송/주문조회</a></li>
	</ul>

	<div class="row">
		<!--Middle Part Start-->
		<form name="LGD_PAYINFO" id="LGD_PAYINFO" method="POST" action="${contextPath}/order/payRes">
			<div id="content" class="col-sm-12">
				<div class="row">
					<!-- 주문정보 -->
					<div class="col-left col-sm-6">
						<div class="table-responsive form-group">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title">
										<i class="fa fa-shopping-cart"></i>
										<label>&nbsp;
											환불번호 : ${tb_odinfoxm.ORDER_NUM}
										</label>
									</h4>
								</div>
								<div class="panel-body">
									<div class="table-responsive">
										<table class="table table-bordered">
											<thead>
												<tr>
													<td class="text-left">상품명</td>
													<td class="text-right">환불수량</td>
													<td class="text-right">판매가</td>
													<td class="text-right">상품소계</td>
												</tr>
											</thead>
											<tbody>
												<c:set var="tot_amt" value="0" />
												<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
													<tr>
														<td class="text-left">
															<b><a href="${contextPath }/m/product/view/${ list.PD_CODE }"target="_blank">${list.PD_NAME }</a></b><br> 
															<c:if test="${ list.PD_CUT_SEQ ne null }">(세절방식 : ${ list.PD_CUT_SEQ_UNIT})</c:if>
															<c:if test="${ list.OPTION_CODE ne null }">(색상 : ${ list.OPTION_NAME})</c:if>
														</td>
														<td class="text-right"><fmt:formatNumber value="${list.ORDER_QTY}" /></td>
														<td class="text-right"><fmt:formatNumber value="${list.REAL_PRICE}" /> 원</td>
														<td class="text-right">
															<fmt:formatNumber value="${list.ORDER_QTY * list.REAL_PRICE}" /> 원
														</td>
													</tr>
													<c:set var="tot_amt" value="${tot_amt + (list.ORDER_QTY * list.REAL_PRICE)}" />
												</c:forEach>
											</tbody>
											<tfoot>
												<tr>
													<td class="text-right" colspan="3"><strong>상품 합계</strong></td>
													<td class="text-right"><fmt:formatNumber value="${tot_amt }" /> 원</td>
												</tr>
												<tr>
													<td class="text-right" colspan="3"><strong>반품 배송비</strong></td>
													<td class="text-right">
														<fmt:formatNumber value="${tb_odinfoxm.DLVY_AMT }" pattern="#,###" /> 원 
													</td>
												</tr>
												<tr>
													<td class="text-right" colspan="3"><strong>환불(예상)금액</strong></td>
													<td class="text-right"><fmt:formatNumber value="${ tb_odinfoxm.ORDER_AMT }" />원</td>
												</tr>
												<tr>
													<fmt:parseNumber var="pv_round" value="${ (tot_amt * PV) / 10 }" integerOnly="true" />
													<fmt:parseNumber var="pv_amt" value="${ pv_round * 10 }" integerOnly="true" />
													<td class="text-right" colspan="3"><strong>회수(예상) PV<br>(총 결제금액의 6% / 원단위 절사)</strong></td>
													<td class="text-right">PV ${ pv_amt }</td>
												</tr>
											</tfoot>
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
											<i class="fa fa-credit-card"></i><label>&nbsp;환불 상세 정보</label>
										</h4>
									</div>
									<div class="panel-body">
										<div class="table-responsive">
											<table class="table table-bordered">
												<tr>
													<th scope="row">환불수단</th>
													<td>
														<input type="hidden" id="payType" value="${tb_odinfoxm.PAY_METD}" />
														${tb_odinfoxm.PAY_METD_NM}
													</td>
												</tr>
												<tr>
													<th scope="row" rowspan="2">환불사유</th>
													<td>
														<jsp:include page="/common/comCodName">
															<jsp:param name="COMM_CODE" value="RFND_MSG" />
															<jsp:param name="COMD_CODE" value="${tb_odinfoxm.RFND_MSG }" />
															<jsp:param name="type" value="text" />
														</jsp:include>
													</td>
												</tr>
												<tr>
													<td>
														<textarea name="CNCL_MSG" class="form-control" rows="5" readonly="readonly"></textarea>
													</td>
												</tr>
												<tr>
													<th scope="row">반품정보</th>
													<td>
														<c:if test="${ empty tb_odinfoxm.DLVY_COM or empty tb_odinfoxm.DLVY_TDN }">
															<button type="button" id="btnWaybill">운송장등록</button>
														</c:if>
														<span id="waybillInfo">
															<c:set var="parcel" value="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=" />
															<a href="${parcel}${tb_odinfoxm.DLVY_TDN }">${tb_odinfoxm.DLVY_COM_NM} ${tb_odinfoxm.DLVY_TDN}</a>
														</span>
													</td>
												</tr>
												<tr>
													<th scope="row">원 주문번호</th>
													<td>
														<a href="${contextPath}/m/order/view/${tb_odinfoxm.ORIGIN_NUM }">${tb_odinfoxm.ORIGIN_NUM}</a>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
							<!-- /.결제 정보 -->
							
							<c:if test="${tb_odinfoxm.RFND_CON eq 'RFND_CON_02'}">
								<div class="table-responsive form-group">
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<i class="fa fa-truck"></i>
												<label>&nbsp;환불 거절 사유</label>
											</h4>
										</div>
										<div class="panel-body">
											<pre>${tb_odinfoxm.RFND_RMK }</pre>
										</div>
									</div>
								</div>
							</c:if>
							<!--/.관리자 처리정보 -->
							
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
							<a href="${contextPath }/m/order/wishList" class="btn btn-default">목록</a>
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
	/* 반품정보 */
	$("#btnWaybill").click(function(){
		$("#myModal").modal('show');
		$("select[name=DLVY_COM]").attr("required" , true);
		$("input[name=DLVY_TDN]").attr("required" , true);
	});
	
	$("#btnSave").click(function(){
		// 필수값 체크
		var dlvycom = $("select[name=DLVY_COM]").val();
		if(!dlvycom){
			alert("택배사를 선택해주세요.");
			$("select[name=DLVY_COM]").focus();
			return false;
		}
		var dlvytdn = $("input[name=DLVY_TDN]").val();
		if(!dlvytdn){
			alert("운송장번호를 입력해주세요.");
			$("input[name=DLVY_TDN]").focus();
			return false;
		}
		
		// 주문번호 팝업
    	$.ajax({
    		type : "POST",
    		url : "${contextPath}/m/order/updateWaybill",
    		data : $("#waybillFrm").serialize(),
    		success : function(data){
    			if (data == "0") {
    				alert("운송장 정보 등록에 실패하였습니다.");
    			} else {
    				alert("운송장 정보가 등록되었습니다.");
    				$('#btnWaybill').hide();
    				var link = "${parcel}"+ dlvytdn;
    				$('#waybillInfo').find('a').text($("select[name=DLVY_COM] option:selected").text() +" "+ dlvytdn);
    				$('#waybillInfo').find('a').attr("href", link);
    			}
    		},
    		error : function(request, status, error) {
    			alert("반품정보 등록에 실패하였습니다.\n error code: " + request.status + "\n" + "error message: " + error + "\n");
    		}
    	});
	});
});

function fnValidationCheck(){
	if($("select[name=DLVY_COM]").val()){
		alert("택배사를 선택해주세요.");
		$("select[name=DLVY_COM]").focus();
		return false;
	}
	
	if($("input[name=DLVY_TDN]").val()){
		alert("운송장번호를 입력해주세요.");
		$("input[name=DLVY_TDN]").focus();
		return false;
	}
}
</script>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<form role="form" name="waybillFrm" id="waybillFrm" method="POST" action="/m/order/updateWaybill" autocomplete="off">
			<input type="hidden" name="MEMB_ID" value="${tb_odinfoxm.MEMB_ID}">
			<input type="hidden" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM}">
			<input type="hidden" name="DLVY_CON" value="DLVY_CON_02"><!-- 상품발송 -->
			
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">반품 정보 등록</h4>
				</div>
				<div class="modal-body">
					<jsp:include page="/common/comCodForm">
						<jsp:param name="COMM_CODE" value="DLVY_COM" />
						<jsp:param name="name" value="DLVY_COM" />
						<jsp:param name="value" value="${tb_odinfoxm.DLVY_COM}" />
						<jsp:param name="type" value="select" />
						<jsp:param name="top" value="택배사 선택" />
					</jsp:include>
					<br>
	            	<input type="text" class="form-control" name="DLVY_TDN" value="${tb_odinfoxm.DLVY_TDN}" placeholder="운송장번호('-'없이 숫자만 입력)"/>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-info" id="btnSave" data-dismiss="modal">등록</button>
				</div>
			</div>
		</form>
	</div>  	
</div>
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<!-- test일 경우 -->
<script language="javascript" src="https://pretest.uplus.co.kr:9443/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<!--
<script language="javascript" src="https://xpayvvip.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
  service일 경우 아래 URL을 사용 
<script language="javascript" src="https://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
 -->
<script type="text/javascript">
	/*
	* 수정불가.
	*/
	var LGD_window_type = '<c:out value="${LGD_WINDOW_TYPE}" />';
		
	/*
	* 수정불가
	*/
	function launchCrossPlatform(){
		lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), '<c:out value="${CST_PLATFORM}" />', LGD_window_type, null, "", "");
	}
	
	/*
	* FORM 명만  수정 가능
	*/
	function getFormObject() {
		return document.getElementById("LGD_PAYINFO");
	}
	
	/*
	 * 인증결과 처리
	 */
	function payment_return() {
		var fDoc;
		fDoc = lgdwin.contentWindow || lgdwin.contentDocument;
		if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {
				document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById('LGD_PAYKEY').value;
				document.getElementById("LGD_PAYINFO").target = "_self";
				document.getElementById("LGD_PAYINFO").action = "${contextPath}/order/payRes";
				document.getElementById("LGD_PAYINFO").submit();
		} else {
			alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
			closeIframe();
		}
	}
</script>
	<div class="container">
		
		<div class="page-mycart">
			<div class="titbox">
				<div class="tit">주문상세</div>
				<div class="step">
					<ul>
						<li class="step1"><i class="ic"></i><span>장바구니</span></li>
						<li class="step2"><i class="ic"></i><span>주문결제</span></li>
						<li class="step3 on"><i class="ic"></i><span>주문완료</span></li>
					</ul>
				</div>
			</div>
			<div class="cntbox">
				<div class="orderResult">
					<div class="order-result-info">
						<div class="order-title">환불 상품 정보</div>
						<div class="order-table">
							<table>
								<colgroup>
									<col style="width:760px">
									<col>
									<col>
									<col>
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>상품명</th>
										<th>판매가</th>
										<th>수량</th>
										<th>합계</th>
										<th>주문상태</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="tot_amt" value="0" />
									<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
									<c:set var="CNCL_MSG" value="${ list.CNCL_MSG }" />
									<c:set var="RFND_AMT" value="${ list.RFND_AMT }" />
									<tr>
										<td class="name">
											<div class="flex">
											<c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=${list.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
												<img src="${imgPath }" alt="">
												<div>
													<strong><a href="${contextPath }/m/product/view/${ list.PD_CODE }"target="_blank">${list.PD_NAME }</a></strong>
													<!-- <span>1150~1300/오픈형/스타일유리</span> -->
												</div>
											</div>
										</td>
										<td class="price"><fmt:formatNumber value="${list.PD_PRICE}" /> 원</td>
										<td class="amount"><fmt:formatNumber value="${list.ORDER_QTY}" />개</td>
										<td class="total"><fmt:formatNumber value="${list.ORDER_QTY * list.PD_PRICE}" /> 원</td>
										<td class="status">${list.ORDER_CON_NM}</td>
										<c:set var="status" value="${list.ORDER_CON_NM}" />
										
										
										<!-- 
										<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="${list.ORDER_NUM }">
										<input type="hidden" id="BSKT_REGNO" name="BSKT_REGNO" value="${list.BSKT_REGNO }">
										<input type="hidden" id="PD_CODES" name="PD_CODES" value="${list.PD_CODE }">
										<input type="hidden" id="PD_NAMES" name="PD_NAMES" value="${list.PD_NAME}" /> 
										<input type="hidden" id="PD_PRICES" name="PD_PRICES" value="${list.PD_PRICE}" />
										<input type="hidden" id="PDDC_GUBNS" name="PDDC_GUBNS" value="${list.PDDC_GUBN}" /> 
										<input type="hidden" id="PDDC_VALS" name="PDDC_VALS" value="${list.PDDC_VAL}" />
										<input type="hidden" id="ORDER_QTYS" name="ORDER_QTYS" value="${list.ORDER_QTY}" /> 
										<input type="hidden" id="ORDER_AMTS" name="ORDER_AMTS" value="${list.ORDER_AMT}" /> 
										<input type="hidden" id="PD_CUT_SEQS" name="PD_CUT_SEQS" value="${ list.PD_CUT_SEQ }" /> 
										<input type="hidden" id="OPTION_CODES" name="OPTION_CODES" value="${ list.OPTION_CODE }" />
										<input type="hidden" id="BOX_PDDC_GUBNS" name="BOX_PDDC_GUBNS" value="${list.BOX_PDDC_GUBN}" /> 
										<input type="hidden" id="BOX_PDDC_VALS" name="BOX_PDDC_VALS" value="${list.BOX_PDDC_VAL}" /> 
										<input type="hidden" id="INPUT_CNTS" name="INPUT_CNTS" value="${list.INPUT_CNT}" /> 
										
										<input type="hidden" id="OPTION1_NAMES" name="OPTION1_NAMES" value="${ list.OPTION1_NAME }" /> 
										<input type="hidden" id="OPTION1_VALUES" name="OPTION1_VALUES" value="${list.OPTION1_VALUE}" /> 
										<input type="hidden" id="OPTION2_NAMES" name="OPTION2_NAMES" value="${list.OPTION2_NAME}" /> 
										<input type="hidden" id="OPTION1_VALUES" name="OPTION2_VALUES" value="${list.OPTION2_VALUE}" /> 
										-->
										
											<c:set var="tot_amt" value="${tot_amt + (list.ORDER_QTY * list.REAL_PRICE)}" />
										</tr>
									</c:forEach>
									
								</tbody>
							</table>
						</div>
					</div>
					<div class="order-result-pay">
						<div class="order-title">결제 정보</div>
						<div class="order-table">
							<table>
								<thead>
									<tr>
										<th>결제방법</th>
										<th>결제내용</th>
										<th>배송비</th>
										<th>결제금액</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>${ tb_odinfoxm.PAY_METD_NM }</td>
										<td></td>
										<td class="delivery"><fmt:formatNumber value="${tb_odinfoxm.DLVY_AMT }" pattern="#,###" /> 원</td>
										<!--<td><strong><fmt:formatNumber value="${tb_odinfoxm.ORDER_AMT}" pattern="#,###" /> 원</strong></td> -->
										<td><strong><fmt:formatNumber value="${tb_odinfoxm.ORDER_AMT}" pattern="#,###" /> 원</strong></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="order-result-delivery">
						<div class="order-title">배송 정보</div>
						<div class="order-table">
							<table>
								<colgroup>
									<col>
									<col style="width:50%">
									<col>
									<col style="width:25%">
								</colgroup>
								<thead>
									<tr>
										<th>수령자</th>
										<th>배송지</th>
										<!-- <th>전화번호</th> -->
										<th>연락처</th>
										<th>배송메시지</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>${tb_oddlaixm.RECV_PERS}</td>
										<td class="tal">(${tb_oddlaixm.POST_NUM}) ${tb_oddlaixm.BASC_ADDR} ${tb_oddlaixm.DTL_ADDR}</td>
										<%-- <td>${tb_oddlaixm.RECV_TELN}</td> --%>
										<td>${tb_oddlaixm.RECV_CPON}</td>
										<td class="tal">${tb_oddlaixm.DLVY_MSG}</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="order-result-refund">
						<div class="order-title">환불 상세 정보</div>
						<div class="order-table">
							<table>
								<colgroup>
									<col style="width:15%">
									<col style="width:50%">
									<col style="width:10%">
									<col style="width:10%">
									<col style="width:15%">
								</colgroup>
								<thead>
									<tr>
										<th>주문번호</th>
										<th>환불사유</th>
										<th>환불수단</th>
										<th>환불예정금액<div>(배송비 제외)</div></th>
										<th>반품정보</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>${tb_odinfoxm.ORDER_NUM}</td>
										<td class="tal">${CNCL_MSG}</td>
										<td>${tb_odinfoxm.PAY_METD_NM}</td>
										<%-- <td><fmt:formatNumber value="${tb_odinfoxm.ORDER_AMT - tb_odinfoxm.DLVY_AMT}" pattern="#,###" />원</td> --%>
										<td>
										<c:choose>
											<c:when test="${ status eq '환불완료' }">
												<fmt:formatNumber value="${RFND_AMT}" pattern="#,###" />원
											</c:when>
											<c:when test="${ status eq '환불거부' }">
												0원
											</c:when>
											<c:otherwise>
												처리중
											</c:otherwise>
										</c:choose>
										</td>
										<td class="tal">
											<span id="waybillInfo">
												<c:set var="parcel" value="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=" />
												<a href="${parcel}${tb_odinfoxm.DLVY_TDN }">${tb_odinfoxm.DLVY_COM_NM} ${tb_odinfoxm.DLVY_TDN}</a>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
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
					<div class="order-result-button">
						<c:choose>
							<c:when test="${ tb_odinfoxm.ORDER_CON_NM eq '반품신청' }">
								<a href="${contextPath }/m/order/exchange" class="btn btn_01">환불/반품 내역 보기</a>
							</c:when>
							<c:otherwise>
								<a href="${contextPath }/m" class="btn btn_01">메인으로</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${ tb_odinfoxm.ORDER_CON_NM eq '반품신청' }">
								<a href="#" class="btn btn_02">환불/반품 취소</a>
							</c:when>
							<c:otherwise>
								<a href="${contextPath }/m/order/exchange" class="btn btn_02">환불/반품 내역 보기</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 운송장 등록 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<form role="form" name="waybillFrm" id="waybillFrm" method="POST" action="/m/order/updateWaybill" autocomplete="off">
				<input type="hidden" name="MEMB_ID" value="${tb_odinfoxm.MEMB_ID}">
				<input type="hidden" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM}">
				<input type="hidden" name="DLVY_CON" value="DLVY_CON_02"><!-- 상품발송 -->
				
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">반품 정보 등록</h4>
					</div>
					<div class="modal-body">
						<jsp:include page="../../common/comCodForm.jsp">
							<jsp:param name="COMM_CODE" value="DLVY_COM" />
							<jsp:param name="name" value="DLVY_COM" />
							<jsp:param name="value" value="${tb_odinfoxm.DLVY_COM}" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="택배사 선택" />
						</jsp:include>
						<br>
		            	<input type="text" class="form-control" name="DLVY_TDN" value="${tb_odinfoxm.DLVY_TDN}" placeholder="운송장번호('-'없이 숫자만 입력)"/>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-info" id="btnSave" data-dismiss="modal">등록</button>
					</div>
				</div>
			</form>
		</div>  	
	</div>
 
<style>
	#divPayModal {
		text-align: center;
	}
	#ifrmPayModal {
		width: 100%;
		max-width: 650px;
		height: 100%;
		max-height: 650px;
		margin:0 auto; 
	}
	#btnWaybill{
		display:block;
		margin:auto;
	}
	#waybillInfo{
		display:block;
		text-align:center;
		margin-top:5px;
	}
</style>

<script type="text/javascript">
$(function() {
});

/* 운송장 등록 */
$("#btnWaybill").click(function(){
	$("#myModal").modal('show');
	$("select[name=DLVY_COM]").attr("required" , true);
	$("input[name=DLVY_TDN]").attr("required" , true);
});

/* 운송장 등록 -> 등록 */
$("#btnSave").click(function(){
	// 필수값 체크
	var dlvycom = $("select[name=DLVY_COM]").val();
	if(!dlvycom){
		alert("택배사를 선택해주세요.");
		$("select[name=DLVY_COM]").focus();
		return false;
	}
	var dlvytdn = $("input[name=DLVY_TDN]").val();
	if(!dlvytdn){
		alert("운송장번호를 입력해주세요.");
		$("input[name=DLVY_TDN]").focus();
		return false;
	}
	
	// 주문번호 팝업
	$.ajax({
		type : "POST",
		url : "${contextPath}/m/order/updateWaybill",
		data : $("#waybillFrm").serialize(),
		success : function(data){
			if (data == "0") {
				alert("운송장 정보 등록에 실패하였습니다.");
			} else {
				alert("운송장 정보가 등록되었습니다.");
				$('#btnWaybill').hide();
				var link = "${parcel}"+ dlvytdn;
				$('#waybillInfo').find('a').text($("select[name=DLVY_COM] option:selected").text() +" "+ dlvytdn);
				$('#waybillInfo').find('a').attr("href", link);
			}
		},
		error : function(request, status, error) {
			alert("반품정보 등록에 실패하였습니다.\n error code: " + request.status + "\n" + "error message: " + error + "\n");
		}
	});
});

/* Xpay 팝업 닫기 */
function fnPayClose() {
	$("#divPayModal").modal('hide');
	location.reload();
}

/* 주문취소 */
function fnCancelPopup(){
	var payType = $("#payType").val();	// 결제수단
	if(payType =='SC0040'){
		window.open("${contextPath }/m/order/cancel/popup?ORDER_NUM=${tb_odinfoxm.ORDER_NUM}&PAY_MDKY=${tb_odinfoxm.PAY_MDKY}&PAY_METD=${tb_odinfoxm.PAY_METD}", "_blank", "width=500, height=230");		
	}else{
		window.open("${contextPath }/m/order/cancel/popup?ORDER_NUM=${tb_odinfoxm.ORDER_NUM}&PAY_MDKY=${tb_odinfoxm.PAY_MDKY}&PAY_METD=${tb_odinfoxm.PAY_METD}", "_blank", "width=500, height=230");
	}
 }

/* 반품신청 팝업 */
function fhPartialCancel(){
	var option = "width=800, height=500, top=100, left=200, location=no";
	window.open("${contextPath}/m/order/partialCancel?ORDER_NUM="+"${tb_odinfoxm.ORDER_NUM}", "_blank", option);
}
</script>