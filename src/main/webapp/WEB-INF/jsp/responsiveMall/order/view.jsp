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
--%>
<!-- 결제 기능 추가 -->
<div class="modal fade" id="divPayModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
	<iframe id="ifrmPayModal" src=""> </iframe>
</div> 

 <div class="wrapper">
	
      
	<div class="container">
		
		<div class="page-mycart">
			<div class="titbox">
				<div class="tit">결제완료</div>
				<div class="step">
					<ul>
						<li class="step1"><i class="ic"></i><span>장바구니</span></li>
						<li class="step2"><i class="ic"></i><span>주문결제</span></li>
						<li class="step3 on"><i class="ic"></i><span>결제완료</span></li>
					</ul>
				</div>
			</div>
			<div class="cntbox">
				<div class="orderResult">
					<div class="order-complete">
						<div class="img"><img src="${contextPath }/resources/resources2/images/order-complete.png" alt=""></div>
						<div class="tit">결제가 완료되었습니다.</div>
						<div class="txt">[ 주문번호 : ${tb_odinfoxm.ORDER_NUM} ]</div>
					</div>
					
						<!-- 결제정보 -->
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
										<td>${ method }</td>
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
					<!-- 결제정보 END -->
					
					<!-- 배송정보 -->
					<div class="order-result-delivery">
					<!-- <tr>
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
							</tr>  -->
					
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
					<!-- 배송정보END -->
					
					<!-- 주문상품정보 -->
					<div class="order-result-info">
						<div class="order-title">주문상품 정보</div>
						<div class="order-table">
							<table>
								<colgroup>
									<col style="width:760px">
									<col>
									<col>
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>상품명</th>
										<th>판매가</th>
										<th>수량</th>
										<!-- <th>배송비</th> -->
										<th>합계</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="tot_amt" value="0" />
									<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
									<tr>
										<td class="name">
											<div class="flex">
											<c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=${list.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
												<img src="${imgPath }" alt="">
												<div>
													<strong><a href="${contextPath }/m/product/view/${ list.PD_CODE }"target="_blank">${list.PD_NAME }</a></strong>
													<c:if test="${!empty list.OPTION1_VALUE && empty list.OPTION2_VALUE}">
													<span> ${ list.OPTION1_NAME} : ${ list.OPTION1_VALUE}</span>
													</c:if>
													<c:if test="${!empty list.OPTION2_VALUE && empty list.OPTION3_VALUE}">
													<span> ${ list.OPTION1_NAME} : ${ list.OPTION1_VALUE} / ${ list.OPTION2_NAME} : ${ list.OPTION2_VALUE}</span>
													</c:if>
													<c:if test="${!empty list.OPTION3_VALUE }">
													<span> ${ list.OPTION1_NAME} : ${ list.OPTION1_VALUE} / ${ list.OPTION2_NAME} : ${ list.OPTION2_VALUE} / ${ list.OPTION3_NAME} : ${ list.OPTION3_VALUE}</span>
													</c:if>
												</div>
											</div>
										</td>
										<td class="price"><fmt:formatNumber value="${list.PD_PRICE}" /> 원</td>
										<td class="amount"><fmt:formatNumber value="${list.ORDER_QTY}" />개</td>
										<%-- <td class="delivery"><fmt:formatNumber value="${tb_odinfoxm.DLVY_AMT }" pattern="#,###" /> 원</td> --%>
										<td class="total"><fmt:formatNumber value="${list.ORDER_QTY * list.PD_PRICE}" />원</td>
										
										
										
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
										
											<c:set var="tot_amt" value="${tot_amt + (list.ORDER_QTY * list.REAL_PRICE)}" />
										</tr>
									</c:forEach>
									
								</tbody>
							</table>
						</div>
					</div>
					<!-- 주문정보 END -->
					
				
					<div class="order-result-button">
						<a href="${contextPath }/m" class="btn btn_01">메인으로</a>
						<a href="${contextPath }/m/order/wishList" class="btn btn_02">주문내역 보기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
  </div> <!-- wrapper -->
 
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
	/* 신용카드 */
	$("#btnCard").click(function(){	
		alert('결제하기')
		var url = '${contextPath}/m/order/orderPay?ORDER_NUM=${tb_odinfoxm.ORDER_NUM }&PAY_METD=SC0010';
		$('#ifrmPayModal').attr('src', url);
		$("#divPayModal").modal('show');
	});
	
	/* 실시간계좌이체 */
	$("#btnAcct").click(function(){
		var url = '${contextPath}/m/order/orderPay?ORDER_NUM=${tb_odinfoxm.ORDER_NUM }&PAY_METD=SC0030';
		$('#ifrmPayModal').attr('src', url);
		$("#divPayModal").modal('show');
	});
	
	/* 무통장(가상계좌) */
	$("#btnCash").click(function(){
		var url = '${contextPath}/m/order/orderPay?ORDER_NUM=${tb_odinfoxm.ORDER_NUM }&PAY_METD=SC0040';
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

/* 장바구니 담기 */
function fnAddToCart(){	
	$.ajax({
		type: "POST",
	    dataType: 'json',
		url: '${contextPath}/order/insertBsktAjax.json',
		data: $("#LGD_PAYINFO").serialize(),
		success: function (data) {
			console.info(data);
			alert("장바구니에 등록되었습니다.")
		}, error: function (jqXHR, textStatus, errorThrown) {
			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
		}
	});
}

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
