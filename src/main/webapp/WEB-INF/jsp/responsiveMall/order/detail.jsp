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

<!-- Main Container  -->
<%-- <div class="main-container container">
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
											주문번호 : ${tb_odinfoxm.ORDER_NUM}
										</label>
									</h4>
								</div>
								<div class="panel-body">
									<div class="table-responsive">
										<table class="table table-bordered">
											<thead>
												<tr>
													<td class="text-left">상품명</td>
													<td class="text-right">수량</td>
													<td class="text-right">판매가</td>
													<td class="text-right">상품구매금액</td>
												</tr>
											</thead>
											<tbody>
												<c:set var="tot_amt" value="0" />
												<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
													<tr>
														<td class="text-left">
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
															<!-- 박스할인율 --> 
															<input type="hidden" id="BOX_PDDC_GUBNS" name="BOX_PDDC_GUBNS" value="${list.BOX_PDDC_GUBN}" /> 
															<input type="hidden" id="BOX_PDDC_VALS" name="BOX_PDDC_VALS" value="${list.BOX_PDDC_VAL}" /> 
															<input type="hidden" id="INPUT_CNTS" name="INPUT_CNTS" value="${list.INPUT_CNT}" /> 
															
															<input type="hidden" id="OPTION1_NAMES" name="OPTION1_NAMES" value="${ list.OPTION1_NAME }" /> 
															<input type="hidden" id="OPTION1_VALUES" name="OPTION1_VALUES" value="${list.OPTION1_VALUE}" /> 
															<input type="hidden" id="OPTION2_NAMES" name="OPTION2_NAMES" value="${list.OPTION2_NAME}" /> 
															<input type="hidden" id="OPTION1_VALUES" name="OPTION2_VALUES" value="${list.OPTION2_VALUE}" /> 
															<b><a
																href="${contextPath }/m/product/view/${ list.PD_CODE }"
																target="_blank">${list.PD_NAME }</a></b><br> <c:if
																test="${ list.PD_CUT_SEQ ne null }">(세절방식 : ${ list.PD_CUT_SEQ_UNIT})</c:if>
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
													<td class="text-right" colspan="3"><strong>배송비</strong></td>
													<td class="text-right">
														<fmt:formatNumber value="${tb_odinfoxm.DLVY_AMT }" pattern="#,###" /> 원 
														<c:if test="${tb_odinfoxm.CPON_YN eq 'Y' && tb_odinfoxm.DLVY_AMT eq 0 }">
															<br/>배송비쿠폰
														</c:if>
														<c:if test="${tb_odinfoxm.DLVY_AMT ne 0 }">
															<c:if test="${tb_odinfoxm.DAP_YN eq 'Y' }">
																<br/>배송비 결제
															</c:if>
															<c:if test="${tb_odinfoxm.DAP_YN eq 'N' }">
																<br/>배송비 착불
															</c:if>																
														</c:if>
													</td>
												</tr>
												<tr>
													<td class="text-right" colspan="3"><strong>총 합계</strong></td>
													<td class="text-right"><fmt:formatNumber value="${ tb_odinfoxm.ORDER_AMT }" />원</td>
												</tr>
												<tr>
													<fmt:parseNumber var="pv_round" value="${ (tot_amt * PV) / 10 }" integerOnly="true" />
													<fmt:parseNumber var="pv_amt" value="${ pv_round * 10 }" integerOnly="true" />
													<td class="text-right" colspan="3"><strong>적립 PV<br>(총 결제금액의 6% / 원단위 절사)</strong></td>
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
											<i class="fa fa-credit-card"></i><label>&nbsp;결제 정보</label>
										</h4>
									</div>
									<div class="panel-body">
										<div class="table-responsive">
											<table class="table table-bordered">
												<tr>
													<th scope="row">결제금액</th>
													<td><fmt:formatNumber value="${tb_odinfoxm.ORDER_AMT}" pattern="#,###" /> 원</td>
													<th scope="row">결제수단</th>
													<td>
														<input type="hidden" id="payType" value="${tb_odinfoxm.PAY_METD}" />
														${tb_odinfoxm.PAY_METD_NM}
													</td>
												</tr>
												<tr>
													<th scope="row">주문상태</th>
													<td id="ORDER_CON_NM">${tb_odinfoxm.ORDER_CON_NM}</td>
													<c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_10'}">
														<th scope="row">가상계좌정보</th>
														<td>
															<button type="button" onclick="fnVirtualAcct();">자세히보기</button>
														</td>
													</c:if>
													<th scope="row">운송장번호</th>
													<td>
														<c:if test="${tb_odinfoxm.DLVY_TDN ne null}">
															[${tb_odinfoxm.DLVY_COM_NM}]&nbsp;<b>${tb_odinfoxm.DLVY_TDN}</b>
														</c:if>
													</td>
												</tr>
												<c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_04'}">
													<tr>
														<th>취소사유</th>
														<td colspan="3">${tb_odinfoxm.CNCL_MSG}</td>
													</tr>
													<tr>
														<th>취소상태</th>
														<td colspan="3">${tb_odinfoxm.CNCL_CON_NM}</td>
													</tr>
												</c:if>												
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
											<label>&nbsp;배송지 정보</label>
										</h4>
									</div>
									<div class="panel-body">
										<div class="table-responsive">
											<table class="table table-bordered">
												<tbody>
													<tr>
														<th scope="row">배송지정보</th>
														<td colspan="3">${tb_oddlaixm.DLAR_GUBN_NM}</td>
													</tr>
													<tr>
														<th scope="row">받으시는분</th>
														<td colspan="3">${tb_oddlaixm.RECV_PERS}</td>
													</tr>
													<tr>
														<th scope="row">주소</th>
														<td colspan="3">(${tb_oddlaixm.POST_NUM}) ${tb_oddlaixm.BASC_ADDR} ${tb_oddlaixm.DTL_ADDR}</td>
													</tr>
													<tr>
														<th scope="row">전화번호</th>
														<td>${tb_oddlaixm.RECV_TELN}</td>
														<th scope="row">휴대폰번호</th>
														<td>${tb_oddlaixm.RECV_CPON}</td>
													</tr>
													<tr>
														<th scope="row">배송 메세지</th>
														<td colspan="6">${tb_oddlaixm.DLVY_MSG}</td>
													</tr>
											</table>
										</div>
										<div class="buttons">
											<a href="${contextPath }/m/order/wishList" class="btn btn-sm btn-default pull-right"
												style="height: 48px; padding-top: 14px;">목록
											</a>
											
											<!-- 결제연동 -->
											<c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_01'}">
												<a class="btn btn-sm btn-primary pull-right" id="btnCard"
													style="margin-right: 3px; height: 48px; padding-top: 14px;">신용카드
												</a>
												<a class="btn btn-sm btn-primary pull-right" id="btnAcct"
													style="margin-right: 3px; height: 48px;">실시간<br>계좌이체
												</a>
												<a class="btn btn-sm btn-primary pull-right" id="btnCash"
													style="margin-right: 3px; height: 48px;">무통장입금<br>(가상계좌)
												</a>
												<c:if test="${tb_mbinfoxm.MONTH_YN eq 'Y'}">
													<a onclick="javascript:;" id="btnMonth" class="btn btn-sm btn-success pull-right"
														style="margin-right:3px; height:48px; padding-top:14px;">월간결제</a>
												</c:if>
											</c:if>
											
											<!-- 주문취소 -->
											<c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_02'}">
												<a onclick="fnCancelPopup();" class="btn btn-sm btn-danger pull-right"
													style="margin-right: 3px; height: 48px; padding-top: 14px;">주문취소
												</a>
											</c:if>
											
											<!-- 반품신청 -->
											<c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_03' or tb_odinfoxm.ORDER_CON eq 'ORDER_CON_09' or tb_odinfoxm.ORDER_CON eq 'ORDER_CON_05' 
												or tb_odinfoxm.ORDER_CON eq 'ORDER_CON_06' or tb_odinfoxm.ORDER_CON eq 'ORDER_CON_08'}">
												<a href="${contextPath}/m/order/refund?ORDER_NUM=${tb_odinfoxm.ORDER_NUM}" class="btn btn-sm btn-danger pull-right"
													style="margin-right: 3px; height: 48px; padding-top: 14px;">반품/환불 신청
												</a>
											</c:if>
											
											<c:if test="${tb_odinfoxm.ORDER_CON ne 'ORDER_CON_07'}">
												<a onclick="fnAddToCart();" class="btn btn-sm btn-warning pull-right"
													style="margin-right: 3px; height: 48px; padding-top: 14px;">장바구니 담기
												</a>
											</c:if>
										</div>
									</div>
								</div>
							</div>
							<!-- /.배송지정보 -->
						</div>
					</div>
				</div>
			</div>
			<!--Middle Part End -->
		</form>
	</div>
</div>
<!-- //Main Container -->

<!-- 결제 기능 추가 -->
<div class="modal fade" id="divPayModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
	<iframe id="ifrmPayModal" src=""> </iframe>
</div> --%>
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
				<form name="frmData" id="frmData" method="post">
					<div class="orderResult">
						<input type="hidden" id="status" name="STATUS"/>
						<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM}"/>
						<input type="hidden" id="PD_CODES" name="PD_CODES"/>
						<input type="hidden" id="PD_COSTS" name="PD_COSTS"/>
						<input type="hidden" id="SUPR_IDS" name="SUPR_IDS"/>
						<input type="hidden" id="SETPD_CODES" name="SETPD_CODES"/>
						<input type="hidden" id="OPTION1_VALUES" name="OPTION1_VALUES"/>
						<input type="hidden" id="OPTION2_VALUES" name="OPTION2_VALUES"/>
						<input type="hidden" id="OPTION3_VALUES" name="OPTION3_VALUES"/>
						<input type="hidden" id="PAY_METD" name="PAY_METD" value="${tb_odinfoxm.PAY_METD}"/>
						<input type="hidden" name="ORDER_AMT" value="${ORDER_AMT}"/>
						<input type="hidden" name="DLVY_AMT" value="${DLVY_AMT}"/>
						<input type="hidden" name="RFND_AMT" value="${tb_odinfoxm.RFND_AMT}"/>
						<input type="hidden" name="PAY_MDKY" value="${tb_odinfoxm.PAY_MDKY}"/>
						<div class="order-result-info">
							<div class="order-title"><c:choose><c:when test="${ tb_odinfoxm.REFUND eq 'y' }">상품 선택 (반품 신청)</c:when><c:otherwise>상품 정보</c:otherwise></c:choose></div>
							<div class="order-table">
								<table>
									<colgroup>
										<c:if test="${ tb_odinfoxm.CANCEL eq 'y' or tb_odinfoxm.REFUND eq 'y' or tb_odinfoxm.CONFIRM eq 'y' }">
										<col style="width:3%">
										</c:if>
										<col style="width:60%">
										<col>
										<col>
										<col>
										<col>
									</colgroup>
									<thead>
										<tr>
											<c:if test="${ tb_odinfoxm.CANCEL eq 'y' or tb_odinfoxm.REFUND eq 'y' or tb_odinfoxm.CONFIRM eq 'y' }">
											<th></th>
											</c:if>
											<th>상품명</th>
											<th>판매가</th>
											<th>수량</th>
											<th>합계</th>
											<th>주문상태</th>
										</tr>
									</thead>
									<tbody>
										<c:set var="tot_amt" value="0" />
										<c:choose>
										<c:when test="${ tb_odinfoxm.CANCEL eq 'y' or tb_odinfoxm.REFUND eq 'y' or tb_odinfoxm.CONFIRM eq 'y' }">
											<c:choose>
											<c:when test="${!empty(tb_odinfoxm.list)}">
												<c:set var="noNum" value="1"/>
												<c:forEach items="${tb_odinfoxm.list}" var="list" varStatus="loop">
												<tr>
													<td class="checkbox" style="display:table-cell;">
														<div class="chk">
															<c:choose>
															<c:when test="${ tb_odinfoxm.CANCEL eq 'y' }">
																<c:choose>
																<c:when test="${ list.ORDER_CON_NM eq '결제전' or list.ORDER_CON_NM eq '결제완료' or list.ORDER_CON_NM eq '배송준비중' }">
																	<input type="checkbox" id="CHK${loop.count}" name="PD_CODE" value="${ list.PD_CODE }"/>
																</c:when>
																<c:otherwise>
																	<input type="checkbox" id="CHK${loop.count}" name="PD_CODE" value="${ list.PD_CODE }" disabled="disabled"/>
																</c:otherwise>
																</c:choose>
															</c:when>
															<c:when test="${ tb_odinfoxm.REFUND eq 'y' or tb_odinfoxm.CONFIRM eq 'y' }">
																<c:choose>
																<c:when test="${ list.ORDER_CON_NM eq '배송완료' }">
																	<input type="checkbox" id="CHK${loop.count}" name="PD_CODE" value="${ list.PD_CODE }"/>
																</c:when>
																<c:otherwise>
																	<input type="checkbox" id="CHK${loop.count}" name="PD_CODE" value="${ list.PD_CODE }" disabled="disabled"/>
																</c:otherwise>
																</c:choose>
															</c:when>
															</c:choose>
															<label for="CHK${loop.count}"><i class="ic"></i></label>
														</div>
													</td>
													<td class="name">
														<div class="flex">
														<c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=${list.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
															<img src="${imgPath }" alt="">
															<div>
																<input type="hidden" id="OPTION1_VALUE${loop.count}" name="OPTION1_VALUE" value=${ list.OPTION1_VALUE }/>
																<input type="hidden" id="OPTION2_VALUE${loop.count}" name="OPTION2_VALUE" value=${ list.OPTION2_VALUE }/>
																<input type="hidden" id="OPTION3_VALUE${loop.count}" name="OPTION3_VALUE" value=${ list.OPTION3_VALUE }/>
																<input type="hidden" id="PD_COST${loop.count}" value=${ list.ORDER_QTY * list.PD_PRICE }/>
																<input type="hidden" id="SUPR_ID${loop.count}" value=${ list.SUPR_ID }/>
																<input type="hidden" id="SETPD_CODE${loop.count}" value=${ list.SETPD_CODE }/>
																<c:choose>
																	<c:when test="${ list.PD_CODE eq list.SETPD_CODE }">
																		<input type="hidden" id="EXTRA_YN${loop.count}" name="EXTRA_YN" value="N"/>
																	</c:when>
																	<c:otherwise>
																		<input type="hidden" id="EXTRA_YN${loop.count}" name="EXTRA_YN" value="Y"/>
																	</c:otherwise>
																</c:choose>
																<strong><a href="${contextPath }/m/product/view/${ list.PD_CODE }"target="_blank">${list.PD_NAME }</a></strong>
																<c:if test="${!empty list.OPTION3_VALUE}">
																<span>${list.OPTION1_NAME } : ${list.OPTION1_VALUE }, ${list.OPTION2_NAME } : ${list.OPTION2_VALUE }, ${list.OPTION3_NAME } : ${list.OPTION3_VALUE }</span>
																</c:if>
																<c:if test="${!empty list.OPTION2_VALUE && empty list.OPTION3_VALUE}">
																<span>${list.OPTION1_NAME } : ${list.OPTION1_VALUE }, ${list.OPTION2_NAME } : ${list.OPTION2_VALUE }</span>
																</c:if>
																<c:if test="${!empty list.OPTION1_VALUE && empty list.OPTION2_VALUE}">
																<span>${list.OPTION1_NAME } : ${list.OPTION1_VALUE }</span>
																</c:if>
															</div>
														</div>
													</td>
													<td class="price"><fmt:formatNumber value="${list.PD_PRICE}" /> 원</td>
													<td class="amount"><fmt:formatNumber value="${list.ORDER_QTY}" />개</td>
													<td class="total"><fmt:formatNumber value="${list.ORDER_QTY * list.PD_PRICE}" />원</td>
													<td class="status">${list.ORDER_CON_NM}</td>
													
													
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
											</c:when>
											<c:otherwise>
												<c:set var="noNum" value="0"/>
												<tr id ="tst">
													<c:choose>
														<c:when test="${ tb_odinfoxm.CANCEL eq 'y' }">
															<td colspan="6">주문취소 가능한 상품이 없습니다.</td>
														</c:when>
														<c:when test="${ tb_odinfoxm.REFUND eq 'y' }">
															<td colspan="6">반품 가능한 상품이 없습니다.</td>
														</c:when>
														<c:when test="${ tb_odinfoxm.CONFIRM eq 'y' }">
															<td colspan="6">구매확정 가능한 상품이 없습니다.</td>
														</c:when>
													</c:choose>
												</tr>
											</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
										<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
											<tr>
												<td class="name">
													<div class="flex">
													<c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=${list.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
														<img src="${imgPath }" alt="">
														<div>
															<strong><a href="${contextPath }/m/product/view/${ list.PD_CODE }"target="_blank">${list.PD_NAME }</a></strong>
															<c:if test="${!empty list.OPTION3_VALUE}">
															<span>${list.OPTION1_NAME } : ${list.OPTION1_VALUE }, ${list.OPTION2_NAME } : ${list.OPTION2_VALUE }, ${list.OPTION3_NAME } : ${list.OPTION3_VALUE }</span>
															</c:if>
															<c:if test="${!empty list.OPTION2_VALUE && empty list.OPTION3_VALUE}">
															<span>${list.OPTION1_NAME } : ${list.OPTION1_VALUE }, ${list.OPTION2_NAME } : ${list.OPTION2_VALUE }</span>
															</c:if>
															<c:if test="${!empty list.OPTION1_VALUE && empty list.OPTION2_VALUE}">
															<span>${list.OPTION1_NAME } : ${list.OPTION1_VALUE }</span>
															</c:if>
														</div>
													</div>
												</td>
												<td class="price"><fmt:formatNumber value="${list.PD_PRICE}" /> 원</td>
												<td class="amount"><fmt:formatNumber value="${list.ORDER_QTY}" />개</td>
												<td class="total"><fmt:formatNumber value="${list.ORDER_QTY * list.PD_PRICE}" /> 원</td>
												<td class="status">${list.ORDER_CON_NM}</td>
												
												
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
										</c:otherwise>
										</c:choose>
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
											<c:if test='${tb_odinfoxm.PAY_METD eq "SC0010"}'>
											<td>${ tb_odinfoxm.FINANCENAME }카드 </td>
											</c:if>
											<c:if test='${tb_odinfoxm.PAY_METD eq "SC0030"}'>
											<td>${ tb_odinfoxm.FINANCECODE  }</td>
											</c:if>
											<c:if test='${tb_odinfoxm.PAY_METD eq "SC0060"}'>
											<td>결제 휴대폰 번호 : ${ tb_odinfoxm.FINANCECODE  }</td>
											</c:if>
											<c:if test='${tb_odinfoxm.PAY_METD eq "SC0040"}'>
											<td>${ tb_odinfoxm.FINANCENAME }은행 <br>입금계좌 : ${ tb_odinfoxm.FINANCECODE  }</td>
											</c:if>
											<td class="delivery"><fmt:formatNumber value="${tb_odinfoxm.DLVY_AMT}" pattern="#,###" /> 원</td>
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
						<c:if test="${ tb_odinfoxm.REFUND eq 'y'}">
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
					</c:if>
						<!-- 
						<c:if test="${ tb_odinfoxm.ORDER_CON_NM eq '결제전' }">
						<div class="order-result-paySel">
							<div class="order-title">결제 방식</div>
							<div style="display:flex;">
								<div class="checkbox">
									<input type="checkbox" value="Cash" id="Cash" checked="checked"/>
									<label for="Cash">무통장 입금</label>
									<input type="checkbox" value="Acct" id="Acct"/>
									<label for="Acct">계좌이체</label>
									<input type="checkbox" value="Card" id="Card"/>
									<label for="Card">신용카드</label>
								</div>
							</div>
							<input type="hidden" id="PayType">
						</div>
						</c:if>
						-->
						<div class="order-result-button">
							<c:choose>
								<c:when test="${ (tb_odinfoxm.CANCEL eq 'y' or tb_odinfoxm.REFUND eq 'y' or tb_odinfoxm.CONFIRM eq 'y') and noNum eq '1' }">
									<a href="${contextPath }/m/order/wishList" class="btn btn_01">주문내역 보기</a>
								</c:when>
								<c:otherwise>
									<a href="${contextPath }/m" class="btn btn_01">메인으로</a>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ tb_odinfoxm.CANCEL eq 'y' and noNum eq '1'}">
									<a class="btn btn_02" onclick="javascript:orderStatus('cancel');">주문 취소</a>
								</c:when>
								<c:when test="${ tb_odinfoxm.REFUND eq 'y' and noNum eq '1'}">
									<a class="btn btn_02" onclick="javascript:orderStatus('refund');">반품 신청</a>
								</c:when>
								<c:when test="${ tb_odinfoxm.CONFIRM eq 'y' and noNum eq '1'}">
									<a class="btn btn_02" onclick="javascript:orderStatus('confirm');">구매 확정</a>
								</c:when>
								<c:otherwise>
									<a href="${contextPath }/m/order/wishList" class="btn btn_02">주문내역 보기</a>
								</c:otherwise>
							</c:choose>
							<c:if test="${ tb_odinfoxm.ORDER_CON_NM eq '배송중' or tb_odinfoxm.ORDER_CON_NM eq '배송완료' }">
								<a class="btn btn_01" style="background:#e2f3e9;" onclick="javascript:fn_popup('${tb_odinfoxm.ORDER_NUM}');">배송조회</a>
							</c:if>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- 결제 기능 추가 -->
	<div class="modal fade" id="divPayModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
		<iframe id="ifrmPayModal" src=""> </iframe>
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
</style>

<script type="text/javascript">
$(function() {
	/* 결제 구분 */
	$('#Cash').click(function() {
		$('#Acct').prop("checked", false);
		$('#Card').prop("checked", false);
		$('#PayType').val('Cash');
	});
	
	$('#Acct').click(function() {
		$('#Cash').prop("checked", false);
		$('#Card').prop("checked", false);
		$('#PayType').val('Acct');
	});
	
	$('#Card').click(function() {
		$('#Cash').prop("checked", false);
		$('#Acct').prop("checked", false);
		$('#PayType').val('Card');
	});

	/* 결제 링크 */
	$("#PayPdt").click(function(){
		if($('#PayType').val() == "Cash") {
			var url = '${contextPath}/m/order/orderPay?ORDER_NUM=${tb_odinfoxm.ORDER_NUM }&PAY_METD=SC0040';
		} else if($('#PayType').val() == "Acct") {
			var url = '${contextPath}/m/order/orderPay?ORDER_NUM=${tb_odinfoxm.ORDER_NUM }&PAY_METD=SC0030';
		} else if($('#PayType').val() == "Card") {
			var url = '${contextPath}/m/order/orderPay?ORDER_NUM=${tb_odinfoxm.ORDER_NUM }&PAY_METD=SC0010';
		}
		$('#ifrmPayModal').attr('src', url);
		$("#divPayModal").modal('show');
	});
	
	/* 무통장 (이미지)
	$("#btnCash").click(function(){
		$('#myModal').modal('show');
	}); */
	
	/* 입금확인요청
	$(".btnDspt").click(function(){
		// 입금확인요청전 안내사항
		if(!confirm("입금완료 후 확인요청하셔야 주문상품이 배송진행됩니다. \n입금확인요청을 하시겠습니까?")) return;
		
		// 주문상태 입금확인 요청
		$('#stateFrm').attr('action', '${contextPath}/m/order/state').submit();
	 }); */

	/* 월간결제 - 지정회원전용
	$("#btnMonth").click(function(){
		if(!confirm("월간결제를 진행하시겠습니까?")) return;
		
		// data setting
		$("#monthFrm").find('[name=ORDER_CON]').val('ORDER_CON_02');
		$("#monthFrm").find('[name=PAY_METD]').val('SC9999');
		$("#monthFrm").find('[name=PAY_DTM]').val(new Date());
		
		// 주문상태 및 결제수단 업데이트
		$.ajax({
			type: "POST",
		    dataType: 'json',
			url: '${contextPath}/m/order/stateAjax.json',
			data: $("#monthFrm").serialize(),
			success: function (data) {
				console.log("success : " + data);
				location.reload(true);
			}, error: function (jqXHR, textStatus, errorThrown) {
				alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
			}
		});
	}); */
});

/*
function checkBox(checked){
    var result = document.getElementById("allChk");
    if( checked.checked==true ){
        console.log(result.value);
        if(result.value == "" ){
            result.value = checked.getAttribute("value");
        }else{
            result.value += ","+ checked.getAttribute("value");
        }
    }else {
        var resultArr = result.value.split(",");
        for(var i=0; i<resultArr.length; i++){
            if(resultArr[i] == checked.getAttribute("value")){
                resultArr.splice(i,1);
                break;
            }
        }
        result.value  = resultArr.join(",");
    }
 }
 */
function orderStatus(a){
    var values = document.getElementsByName("PD_CODE");
    var setCodes = document.getElementsByName("SETPD_CODE");
	var pdArr = [];
	var optArr1 = [];
	var optArr2 = [];
	var optArr3 = [];
	var suprArr = [];
	var costArr = [];
	var setpdArr = [];
	
	for(var i = 0; i < values.length; i++) {
		var count = 1;
		var extra_yn = "N";
		var SETPD_CODE = "";
		
		if(values[i].checked) {
			pdArr.push(values[i].value);
			$("#OPTION1_VALUE" + (i+1)).val($("#OPTION1_VALUE" + (i+1)).val().replace("/", ""));
			optArr1.push($("#OPTION1_VALUE" + (i+1)).val());
			$("#OPTION2_VALUE" + (i+1)).val($("#OPTION2_VALUE" + (i+1)).val().replace("/", ""));
			optArr2.push($("#OPTION2_VALUE" + (i+1)).val());
			$("#OPTION3_VALUE" + (i+1)).val($("#OPTION3_VALUE" + (i+1)).val().replace("/", ""));
			optArr3.push($("#OPTION3_VALUE" + (i+1)).val());
			$("#PD_COST" + (i+1)).val($("#PD_COST" + (i+1)).val().replace("/", ""));
			costArr.push($("#PD_COST" + (i+1)).val());
			$("#SUPR_ID" + (i+1)).val($("#SUPR_ID" + (i+1)).val().replace("/", ""));
			suprArr.push($("#SUPR_ID" + (i+1)).val());
			$("#SETPD_CODE" + (i+1)).val($("#SETPD_CODE" + (i+1)).val().replace("/", ""));
			setpdArr.push($("#SETPD_CODE" + (i+1)).val());
			
			SETPD_CODE = $("#SETPD_CODE" + (i+1)).val();
		}
		
		for(var j = 0; j < values.length; j++) {
			$("#SETPD_CODE" + (j+1)).val($("#SETPD_CODE" + (j+1)).val().replace("/", ""));
			//추가상품 포함된 상품 단독 취소 방지 - 이유리
			if(i != j)  {
				if($("#CHK" + (j+1)).attr("disabled") != "disabled") {
					if($("#SETPD_CODE" + (j+1)).val() == SETPD_CODE) {
						if($("#EXTRA_YN" + (i+1)).val() == "Y") extra_yn = "Y";
						if(values[j].checked) extra_yn = "Y";
						count++;
					}	
				}
			}
		}
		if(a == "cancel" && count > 1) {
			if(extra_yn == "N") {
				alert("추가상품과 함께 구매한 상품은 단독 취소가 불가합니다.");
				return false;
			}
		}
	}
	
	$("#PD_CODES").val(pdArr);
	$("#PD_COSTS").val(costArr);
	$("#SUPR_IDS").val(suprArr);
	$("#SETPD_CODES").val(setpdArr);
	$("#OPTION1_VALUES").val(optArr1);
	$("#OPTION2_VALUES").val(optArr2);
	$("#OPTION3_VALUES").val(optArr3);
	
	/* if(values.length == pdArr.length) {
		$("#allChk").val("Y");
	} */
	
	var PD_CODES = $("#PD_CODES").val();
    var arr = PD_CODES.split(",");
    var length = arr.length;
	
	/* 주문 취소 */
	if(a == "cancel") {
		$("#status").val("CANCEL");
		
		var total = (length + 1) + "";
		if($("input:checkbox[name=PD_CODE]:checked").length == 0) {
	        alert("주문 취소할 상품을 선택해 주세요.");
	    } else {
	    	$.ajax({
	    		type: "POST",
	    		url: "${contextPath}/m/order/updateOrder",
	    		data: $("#frmData").serialize(),
	    		success: function (data) {
	    			if(data == total) {
	    				alert("주문 취소가 완료되었습니다.");
	    				location.reload();
	    			} else {
	    				alert("주문 취소 중 문제가 발생했습니다. 관리자에게 문의하세요. data :"+data+" total : "+total);
	    				location.reload();
	    			}
	    		}, error: function (jqXHR, textStatus, errorThrown) {
	    			alert("처리중 에러가 발생했습니다. 관리자에게 문의하세요.(error:"+textStatus+")");
	    		}
	    	});
	    }
	/* 반품 신청 */
	} else if(a == "refund") {
		$("#status").val("REFUND");
		
		if($("input:checkbox[name=PD_CODE]:checked").length == 0) {
	        alert("반품 신청할 상품을 선택해 주세요.");
	        
	     } else {
		     var target = "pop";
		     window.open("${contextPath}/m/order/refundPopup", target, "width=800,height=700");
	
		     var frmData = document.frmData;
		     frmData.target = target;
		     frmData.action = "${contextPath}/m/order/refundPopup";
		     frmData.submit();
	     }
		
	/* 구매 확정 */
	} else if(a == "confirm") {
		$("#status").val("CONFIRM");
		
		var total = (length + 1) + "";
		
		if($("input:checkbox[name=PD_CODE]:checked").length == 0) {
	        alert("구매 확정할 상품을 선택해 주세요.");
	        
	    } else {
	    	$.ajax({
	    		type: "POST",
	    		url: "${contextPath}/m/order/updateOrder",
	    		data: $("#frmData").serialize(),
	    		success: function (data) {
	    			if(data == total) {
	    				alert("구매 확정이 완료되었습니다.");
	    				location.reload();
	    			} else {
	    				alert("구매 확정 중 문제가 발생했습니다. 관리자에게 문의하세요.");
	    				location.reload();
	    			}
	    		}, error: function (jqXHR, textStatus, errorThrown) {
	    			alert("처리중 에러가 발생했습니다. 관리자에게 문의하세요.(error:"+textStatus+")");
	    		}
	    	});
	    }
	}
}
 
 function fn_popup(num){
	 window.open("${contextPath}/m/order/deliveryPopup?order_num=" + num, "_blank", "width=800,height=400");
 }

/* Xpay 팝업 닫기 */
function fnPayClose() {
	$("#divPayModal").modal('hide');
	location.reload();
}

/* 주문취소 */
/*
function fnCancelPopup(){
	var payType = $("#payType").val();	// 결제수단
	if(payType =='SC0040'){
		window.open("${contextPath }/m/order/cancel/popup?ORDER_NUM=${tb_odinfoxm.ORDER_NUM}&PAY_MDKY=${tb_odinfoxm.PAY_MDKY}&PAY_METD=${tb_odinfoxm.PAY_METD}", "_blank", "width=500, height=230");		
	}else{
		window.open("${contextPath }/m/order/cancel/popup?ORDER_NUM=${tb_odinfoxm.ORDER_NUM}&PAY_MDKY=${tb_odinfoxm.PAY_MDKY}&PAY_METD=${tb_odinfoxm.PAY_METD}", "_blank", "width=500, height=230");
	}
 }
 */

/* 가상계좌정보 팝업 */
function fnVirtualAcct(){
	var option = "width=800, height=500, top=100, left=200, location=no";
	window.open("${contextPath}/m/order/virInfoPop?ORDER_NUM="+"${tb_odinfoxm.ORDER_NUM}", "_blank", option);
}

/* 반품신청 팝업 */
function fhPartialCancel(){
	var option = "width=800, height=500, top=100, left=200, location=no";
	window.open("${contextPath}/m/order/partialCancel?ORDER_NUM="+"${tb_odinfoxm.ORDER_NUM}", "_blank", option);
}

/* 무통장입금 (이미지)
function fnPayCall2OkDiv(){ 
	if(!confirm("입금을 완료하셨습니까?"))return;
	
	// 주문상태 입금확인 요청
	$.ajax({
		type: "POST",
	    dataType: 'json',
		url: '${contextPath}/m/order/stateAjax.json',
		data: $("#stateFrm").serialize(),
		success: function (data) {
			console.log(data);
			$('#fnPayCall2OkDiv').modal('show');
		}, error: function (jqXHR, textStatus, errorThrown) {
			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
		}
	});
	
	location.reload(true);
} */
</script>

<!-- 월간결제 주문상태 변경
<form name="monthFrm" id="monthFrm" method="post" action="${contextPath }/m/order/stateAjax">
	<input type="hidden" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM }">
	<input type="hidden" name="ORDER_CON" value="">
	<input type="hidden" name="PAY_METD" value="">
	<input type="hidden" name="PAY_AMT" value="${tb_odinfoxm.ORDER_AMT }">
	<input type="hidden" name="PAY_MDKY" value="">
	<input type="hidden" name="PAY_DTM" value="">
</form> -->

<!-- Modal : 무통장 입금1
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<form role="form" name="stateFrm" id="stateFrm" method="post" action="" autocomplete="off">
			<input type="hidden" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM }">
			<input type="hidden" name="ORDER_CON" value="ORDER_CON_10">
			<input type="hidden" name="PAY_METD" value="SC0040">
			<input type="hidden" name="PAY_AMT" value="${tb_odinfoxm.ORDER_AMT }">
			<input type="hidden" name="PAY_MDKY" value="">
			<input type="hidden" name="PAY_DTM" value="">
			
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="window.location.reload()">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">무통장 입금방법</h4>
				</div>
				<div class="modal-body">
	            	<img src="${contextPath}/resources/img/order/bank_info_20200918.jpg" style="width:100%;height:auto;">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-info btnDspt" data-dismiss="modal">입금확인요청</button>
				</div>
			</div>
		</form>
	</div>  	
</div> -->

<!-- Modal : 무통장 입금2
<div class="modal fade" id="fnPayCall2OkDiv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="window.location.reload()">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">무통장 입금확인</h4>
			</div>
			<div class="modal-body">
            	<img src="${contextPath}/resources/img/order/bank_info2.png" style="width:100%;height:auto;">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>  	
</div>-->
