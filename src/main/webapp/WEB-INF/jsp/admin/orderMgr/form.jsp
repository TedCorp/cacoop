<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- bootstrap datepicker -->
<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.css">
<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.min.css">

<!-- bootstrap datepicker -->
<script src="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.js"></script>
<script src="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.min.js"></script>

<c:set var="strActionUrl" value="${contextPath }/adm/orderMgr" />
<c:set var="strMethod" value="post" />



<section class="content-header">
	<h1>
		주문내역
		<small>주문정보</small>
	</h1>
</section>

<section class="content">
	<!-- 주문 정보 시작 -->
	<div class="box box-info">
		<div class="box-header with-border" >
			<h3 class="box-title">주문 정보</h3>
			<button type="button" class="btn btn-default btn-sm pull-right left-5 btnHelp">
				<i class="fa fa-question-circle"></i> 도움말
			</button>
			<button type="button" class="btn btn-success btn-sm pull-right" id="btnExcel">
				<i class="fa fa-file-excel-o" aria-hidden="true"></i> 엑셀
			</button>
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
		</div>
		<!-- /.box-body -->
	</div>
	<!-- 주문 정보 끝 -->
	<!-- 업체별 상품 출력 -->
	<spform:form class="form-horizontal" name="orderFrm" id="orderFrm" method="post" action="${contextPath }/adm/orderMgr">
		<input type="hidden" name="CNCL_MSG" value="${tb_odinfoxm.CNCL_MSG eq null ? '' :  tb_odinfoxm.CNCL_MSG}" />
		<input type="hidden" name="PAY_MDKY" value="${tb_odinfoxm.PAY_MDKY }"/><!--주문번호 key값  -->
		<input type="hidden" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM }"/>
		<input type="hidden" name="DLVY_AMT" value="${tb_odinfoxm.DLVY_AMT}"/>
		<input type="hidden" name="RFND_AMT" value="${tb_odinfoxm.RFND_AMT}"/>
		<input type="hidden" name="ALL_ORDER_AMT" value="${tb_odinfoxm.ORDER_AMT}"/>
		
		<div class="box box-info">
			<!-- /.box-Start -->
				<div class="row" style="padding-bottom:10px;">
					<div class="box-header with-border">
						<div class="col-xs-12">
							<h3 class="box-title">상품 정보</h3>
							<a onclick="javascript:fn_pgCancel();" class="btn btn-warning btn-sm pull-right left-5"><i class="fa fa-credit-card"></i> PG 취소</a> 
							<a onclick="fn_save();" class="btn btn-primary btn-sm pull-right left-5"><i class="fa fa-save"></i> 저장</a>
							<a href="${contextPath}/adm/orderMgr" class="btn btn-default btn-sm pull-right left-5"><i class="fa fa-list"></i> 목록</a>
						</div>
					</div>
				</div>
			<!-- /.box-header -->
			
			
			<!-- 공급사별 정보 START -->
			<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
				<c:set var="totalAmt" value="0"/><!-- 공급사별 총합게 -->
				<c:forEach items="${pd_supr_list}" var="supr" varStatus="loop">	<!-- 공급사명-->				
					<table class="table table-bordered">
						<caption><b>${loop.count}. ${supr.SUPR_NAME}</b></caption>
						<colgroup>
							<col  style="width: 2%"/>
							<col style="width: 2%" />
							<col style="width:10%" />
							<col style="width:21%" />
							<col style="width:5%" />
							<col style="width:10%" />
							<col style="width:10%" />
							<col style="width:10%" />
							<col style="width:10%" />
							<col style="width:10%" />
						</colgroup>
						<thead>
							<tr align="center">
								<th></th>
								<th>번호</th>
								<th>상품코드</th>
								<th>상품명 - 옵션</th>
								<th>수량</th>
								<th>판매가격</th>
								<th>주문금액</th>
								<th>주문상태</th>
								<th>택배사</th>
								<th>운송장번호</th>
							</tr>
						</thead>
									
						<c:set var="cont_cnt" value="0"/><!--  공급사별 상품 번호 -->		
						<c:set var="suprPrice"	 value="0"/>			
						<c:set var="rfnd_dlvy_amt"	 value="0"/>
						<c:set var="dlvyAmt2"  value="0"/>			
						<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop2">
							<c:if test="${supr.SUPR_ID eq list.SUPR_ID }">								
								<c:set var="cont_cnt" value="${cont_cnt + 1}"/>																			
									<tbody>
								<tr>
									<td>
										<input type="checkbox" id="CHK${loop2.count}" name="pg_Cancel_chk"  value="${list.ORDER_NUM}"/>
									</td>
									<td>${cont_cnt}</td>
									<td>${list.PD_CODE }</td>
									<td>${list.PD_NAME } 
										<c:if test="${ list.OPTION_CODE ne null }">(색상 : ${ list.OPTION_CODE})</c:if>
									</td>
									<!-- 수량 -->
									<td>
										<input type="number" name="ORDER_QTY" value="${list.ORDER_QTY }" class="form-control btnQty"  style="width:100%;margin-right:10px;display:inline"/>
										
										<input type="hidden" name="PD_CODE" value="${list.PD_CODE }"/>
										<input type="hidden" name="ORDER_DTNUM" value="${list.ORDER_DTNUM }"/>
										<input type="hidden" name="PD_PRICE" value="${list.PD_PRICE }"/>
										<input type="hidden" name="SUPR_ID" value="${list.SUPR_ID }"/>
										<input type="hidden" name="LOGIN_SUPR_ID" value="${login_supr_id }"/>
										<input type="hidden" name="DLVY_COM" value="${list.DLVY_COM}"/>
										<input type="hidden" name="ORDER_CON" value="${list.ORDER_CON}"/>
										<input type="hidden" name="OPTION1_VALUE" value="${list.OPTION1_VALUE}"/>
										<input type="hidden" name="OPTION2_VALUE" value="${list.OPTION2_VALUE}"/>
										<input type="hidden" name="OPTION3_VALUE" value="${list.OPTION3_VALUE}"/>
										<input type="hidden" name="ORDER_AMT" value="${list.ORDER_AMT}"/>
										<input type="hidden" name="ALL_DLVY_AMT2" value="${list.DLVY_AMT}"/>
										<input type="hidden" name="SETPD_CODE" value="${list.SETPD_CODE}"/>
										 
 									</td>
									<!-- 상품금액 -->
 									<td>
 										<fmt:formatNumber>${list.PD_PRICE }</fmt:formatNumber>
 									</td> 
 									<!-- 주문금액 -->
									<td class="orderAmt">
										<fmt:formatNumber>${list.ORDER_AMT }</fmt:formatNumber>
									</td>
									<!-- 주문상태 -->
									<td>
										<c:choose>
											<c:when test="${list.ORDER_CON eq 'ORDER_CON_10' || list.ORDER_CON eq 'ORDER_CON_04' || list.ORDER_CON eq 'ORDER_CON_11' || list.ORDER_CON eq 'ORDER_CON_07'}">
												<jsp:include page="${contextPath }/common/comCodForm">
													<jsp:param name="COMM_CODE" value="ORDER_CON" />
													<jsp:param name="name" value="DTL_ORDER_CON" />
													<jsp:param name="value" value="${list.ORDER_CON}" />
													<jsp:param name="type" value="select" />
													<jsp:param name="top" value="선택" />
													<jsp:param name="attr1" value="disabled='disabled'" />
												</jsp:include>
												<input type="hidden" name="DTL_ORDER_CON" id="DTL_ORDER_CON" value="${list.ORDER_CON}">
											</c:when>
											<c:otherwise>
											 	<jsp:include page="${contextPath }/common/comCodForm">
													<jsp:param name="COMM_CODE" value="ORDER_CON" />
													<jsp:param name="name" value="DTL_ORDER_CON" />
													<jsp:param name="value" value="${list.ORDER_CON}" />
													<jsp:param name="type" value="select" />
													<jsp:param name="top" value="선택" />
												 	<jsp:param name="disabled" value="true"/>
												</jsp:include>
											</c:otherwise>
										</c:choose>
									</td>
									<!-- 택배사 -->					
									<td>${list.DLVY_COM_NAME} </td>
									<!-- 운송장번호 -->
									<td>
										<input type="text" name="DTL_DLVY_TDN" id="DTL_DLVY_TDN${loop2.count}" value="${list.DLVY_TDN}" class="form-control" onkeyup="dlvyKeyUpEvet();" style="width:100%;margin-right:10px;display:inline"/>
									</td>
 									<c:set var="suprPrice"  value="${suprPrice + list.ORDER_AMT}"/> 
									<%-- <c:set var="dlvyAmt2"  value="${supr.DLVY_AMT_REAL}"/> --%>
									<c:set var="cancel" value="${list.TOTAL_CANCEL}" />
									<c:set var="rfnd_dlvy_amt" value="${rfnd_dlvy_amt+ list.RFND_DLVY_AMT}"/>
								</tr>
							</c:if>
						</c:forEach>
							<c:set var="total" value="${ suprPrice+supr.DLVY_AMT_REAL}"/>
							<c:set var="cncl_amt" value="${ cancel + (supr.DLVY_AMT - supr.DLVY_AMT_REAL) }"/>
							<c:set var="all_amt" value="${ suprPrice + supr.DLVY_AMT }"/>
							<tr>
								<th colspan="8" style="text-align:right;">상품 합계</th>
								<td colspan="2" style="text-align:right">
									<fmt:formatNumber><c:out value="${suprPrice}"/></fmt:formatNumber>
								</td>
							</tr>
						<c:if test="${suprPrice eq cancel}">
							<tr>
								<th colspan="8" style="text-align:right;">배송비</th>
								<td colspan="2" style="text-align:right"> 
									<fmt:formatNumber><c:out value="${supr.DLVY_AMT}"/></fmt:formatNumber>
								</td>
							</tr>
							<tr>
								<th colspan="8" style="text-align:right;">취소 금액</th>
								<td colspan="2" style="text-align:right;"> 
									<!--<fmt:formatNumber><c:out value="${cancel-rfnd_dlvy_amt}"/></fmt:formatNumber>-->
									<fmt:formatNumber><c:out value="${ cncl_amt }"/></fmt:formatNumber>
								</td>
							</tr>
							<tr>
								<th colspan="8" style="text-align:right;">총 합계</th>
								<%-- <td id="totalAmt" colspan="2" style="text-align:right"> <fmt:formatNumber><c:out value="${total-cancel+rfnd_dlvy_amt}"/></fmt:formatNumber> </td> --%>
								<td id="totalAmt" colspan="2" style="text-align:right"> <fmt:formatNumber>${ all_amt - cncl_amt }</fmt:formatNumber> </td>
							</tr>					
						</c:if>
						<c:if test="${suprPrice ne cancel}">
							<tr>
								<th colspan="8" style="text-align:right;">배송비</th>
								<td colspan="2" style="text-align:right"> 
									<fmt:formatNumber><c:out value="${supr.DLVY_AMT}"/></fmt:formatNumber>
								</td>
							</tr>
							<tr>
								<th colspan="8" style="text-align:right;">취소 금액</th>
								<td colspan="2" style="text-align:right;"> 
									<!--<fmt:formatNumber><c:out value="${cancel-rfnd_dlvy_amt}"/></fmt:formatNumber>-->
									<fmt:formatNumber><c:out value="${ cncl_amt }"/></fmt:formatNumber>
								</td>
							</tr>
							<tr>
								<th colspan="8" style="text-align:right;">총 합계</th>
								<%-- <td id="totalAmt" colspan="2" style="text-align:right"> <fmt:formatNumber><c:out value="${total-cancel+rfnd_dlvy_amt}"/></fmt:formatNumber> </td> --%>
								<td id="totalAmt" colspan="2" style="text-align:right"> <fmt:formatNumber>${ all_amt - cncl_amt }</fmt:formatNumber> </td>
							</tr>
						</c:if>					
						</tbody>
					</table>				
				</c:forEach>
			</div>
		</div>
		
		
		
		
		
		<!-- 주문상품 정보 끝 -->		
		
		<!-- 배송지 정보 시작 -->
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">배송지 정보</h3>
				<div class="pull-right">
					<jsp:include page="${contextPath }/common/comCodForm">
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
						<input type="text" class="form-control" id="RECV_PERS" name="RECV_PERS" value="${tb_oddlaixm.RECV_PERS }" required="required" maxlength="20"/>
					</div>
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
						<input type="text" class="form-control" id="DTL_ADDR" name="DTL_ADDR" value="${tb_oddlaixm.DTL_ADDR }" required="required" maxlength="100"/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="RECV_CPON" class="col-sm-2 control-label required">휴대전화</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="RECV_CPON" name="RECV_CPON" value="${tb_oddlaixm.RECV_CPON }" required="required"  />
					</div>
					<label for="RECV_TELN" class="col-sm-1 control-label">일반전화</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="RECV_TELN" name="RECV_TELN" value="${tb_oddlaixm.RECV_TELN }" required="required"  />
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
					 
					 <c:if test = '${tb_oddlaixm.DLAR_GUBN ne "DLAR_GUBN_05" }' >
						<label for="DLAR_TIME" class="col-sm-2 control-label">* 배송일시</label>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker" style="float: inherit;">		
								<input type="text" class="form-control pull-left" name="datepicker_dlar" id="datepicker_dlar" value="" readonly="readonly">
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
						</div>
						<div class="col-sm-1">
							<select name="DLAR_TIME_CHK_02" id="DLAR_TIME_CHK_02" class="form-control" >
								<option value="nothing">선택</option>
								<option value="오전" <c:if test = '${tb_oddlaixm.DLAR_TIME eq "오전" }'>selected="selected"</c:if>>오전</option>
								<option value="오후" <c:if test = '${tb_oddlaixm.DLAR_TIME eq "오후" }'>selected="selected"</c:if>>오후</option>									
				        	</select>
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
					<label for="PAY_METD" class="col-sm-1 control-label">결제 수단</label>
					<div class="col-sm-2">
						<jsp:include page="${contextPath }/common/comCodForm">
							<jsp:param name="COMM_CODE" value="PAY_METD" />
							<jsp:param name="name" value="PAY_METD" />
							<jsp:param name="value" value="${tb_odinfoxm.PAY_METD}" />
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
				</div><br>
			</div>
			<!-- /.box-body -->
		</div> 
		<!-- 주문 상태 및 결제 정보 끝 -->
	</spform:form>
			

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
	
	/* 결제전이 아닌경우 상품수량 변겅 X */
	if($("select[name=ORDER_CON]").val()!="ORDER_CON_01"){
		$("input[name=ORDER_QTY]").attr("readonly","readonly");	
	}
	
	/* 수량변경 계산 */
	$('.btnQty').blur(function(){
		// 변경조건 체2크
		if($(this).closest("td").find("input[name^=ORDER_QTY]").attr("readonly")=="readonly"){
			alert("주문상태가 '결제전'이 아니므로 수량을 변경할 수 없습니다.");
			return;
		}
		
		// 수량 필수값 체크
		if($(this).val() == "" || $(this).val() < 0){
			alert("주문수량은 필수 입력사항입니다.");
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
	
	if(getParameterByName("alertMessage")!=""){
		var alertmsg = getParameterByName("alertMessage");
		history.replaceState({}, null, location.pathname);		
		alert(alertmsg);
	}
	
	$("#DTL_ORDER_CON option[value='ORDER_CON_04']").prop('disabled',true); //주문취소 disabled
	$("#DTL_ORDER_CON option[value*='ORDER_CON_10']").prop('disabled',true); //환불신청 disabled
	$("#DTL_ORDER_CON option[value*='ORDER_CON_11']").prop('disabled',true); //환불거절 disabled
	$("#DTL_ORDER_CON option[value*='ORDER_CON_07']").prop('disabled',true); //환불완료 disabled	
	
	
	/* ORDER_CON이 ORDER_CON_04(주문취소일때 checkbox 비활성화):20211214 장보라 */
	var orgin_Order_Con = new Array();//기존의 select 배열
	var new_Order_Con = new Array();//기존의 select 배열
	var length = $('select[name=DTL_ORDER_CON] option:selected').length;//DTL_ORDER_CON배열길이
	
	var pg_chk_length=$('input[name="pg_Cancel_chk"]').length;	//pg_Cancel_chk 배열길이 
	for(i=0; i<length;i++){
		orgin_Order_Con[i]=$('select[name=DTL_ORDER_CON] option:selected').eq(i).val();
		if(orgin_Order_Con[i] =="ORDER_CON_03" || orgin_Order_Con[i]=="ORDER_CON_02" || orgin_Order_Con[i]=="ORDER_CON_08"){ //만약에 orgin_Order_Con의 [i]배열의 값이 ORDER_CON_04 이라면  pg_Cancel_chk 비활성화
			$('input[name="pg_Cancel_chk"]').eq(eval("'"+i+"'")).prop('disabled', false);
		}else{
			$('input[name="pg_Cancel_chk"]').eq(eval("'"+i+"'")).prop('disabled', true);
		}
	  	  if(orgin_Order_Con[i] !="ORDER_CON_05" ){
			$('input[name="DTL_DLVY_TDN"]').eq(eval("'"+i+"'")).prop('readonly', true);
		}  
	}
	
	/* ORDER_CON의 상태에 따라서 운송장번호 readonly 인지 아닌지 : 20211214 장보라/20211216 이유리 */
 	$('select[name=DTL_ORDER_CON]').on('change', function(){
			var new_Order_Con=$(this).val();
			var dlvy_tdn_input=$(this).parent().next().next().children();
			
			if(new_Order_Con =="ORDER_CON_05" ){
				dlvy_tdn_input.prop('readonly', false);
			}else{
				dlvy_tdn_input.prop('readonly', true);
			}
	});  
		
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
	if($("#ORDER_CON").val()=="ORDER_CON_05"){
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

/* 운송장번호 :20211214 장보라  */
var dlvy_Tdn_Arr = new Array(); //운송장 배열 (DLVY_TDN)
function dlvyKeyUpEvet(){
	var dtl_Dlvy_Tdn_Length=$('input[name=DTL_DLVY_TDN]').length;//input[name=DTL_DLVY_TDN]은 loop2.count가 1부터시작
	for(var i=0; i<dtl_Dlvy_Tdn_Length; i++){
		var DTL_DLVY_TDN_NUM="DTL_DLVY_TDN"+(i+1);
		var dtl_Dlvy_num=$("#"+DTL_DLVY_TDN_NUM).val(); //상품합계
		dlvy_Tdn_Arr[i]=dtl_Dlvy_num;
	}
}

/* 저장 */
function fn_save(){
	/* 주문상태가  */
	 var selArr = new Array(); //주문상태 배열 (DTL_ODRER_CON)
	 var deltext = "N";
	$('select[name=DTL_ORDER_CON] option:selected').each(function(index){
	 	var value = $(this).attr('value');
	 	selArr.push(value);
	});
	for(var i = 0; i < selArr.length; i++) {
		if(selArr[i] == "ORDER_CON_05") deltext = "Y";
	}
	if(deltext == "Y") {
		//만약 운송장이 입력되었다면 submit 아니라면 return false;
		for(var i=0; i<selArr.length; i++){
			if(selArr[i] == "ORDER_CON_05"){
				if($('input[name=DTL_DLVY_TDN]').eq(i).val() ==null || $('input[name=DTL_DLVY_TDN]').eq(i).val() == ''){
					alert("운송장 번호를 입력해주세요");
					return false;
				} 
			}
		}
		
	} 
	var frm=document.getElementById("orderFrm");
	//-결제일시 str 
	var yyyymmdd = $('#datepicker').val().split("-").join("");
	var whatTm = $('#timepicker').val().split(" ")[1];
	var hours = parseInt(($('#timepicker').val().split(" ")[0]).split(":")[0]);
	var minute = ($('#timepicker').val().split(" ")[0]).split(":")[1];
	if(whatTm == "PM" && hours<12) hours = hours+12;
	if(whatTm == "AM" && hours==12) hours = hours-12;
	if(whatTm == "AM" && hours<10) hours = "0"+hours;
	if(yyyymmdd=="") frm.PAY_DTM.value= "";
	if(yyyymmdd!="") frm.PAY_DTM.value= yyyymmdd+hours+minute+"00";
	//-결제일시 end
	
	/* if(frm.ORDER_CON.value=='ORDER_CON_02' || frm.ORDER_CON.value=='ORDER_CON_03')
		frm.PAY_AMT.value = '<c:out value="${totalAmt + dlvyAmt}"/>';	
		
    if(frm.ORDER_CON.value=='ORDER_CON_01')
    	frm.PAY_AMT.value = '0'; */
    
    var dlar_gubn = "${tb_oddlaixm.DLAR_GUBN}";
    if( dlar_gubn  =="DLAR_GUBN_05" ){
	    $('#DLAR_DATE').val( $("#datepicker_dlar").val().split("-")[0]+$("#datepicker_dlar").val().split("-")[1]+$("#datepicker_dlar").val().split("-")[2] )
    	$('#DLAR_TIME').val( $("#DLAR_TIME_CHK_01 option:selected").val());
    }else{    	
    	if($('#datepicker_dlar').val()!=""&&$('#datepicker_dlar').val()!=null)    		
    		$('#DLAR_DATE').val( $("#datepicker_dlar").val().split("-")[0]+$("#datepicker_dlar").val().split("-")[1]+$("#datepicker_dlar").val().split("-")[2] )
    		$('#DLAR_TIME').val( $("#DLAR_TIME_CHK_02 option:selected").val());
    }
   
    if(!confirm("저장 하시겠습니까?")) return;
	frm.submit();
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
	//주문번호 받아오고 
	//ORDER_DTNUM넘어오고 
   	if(!confirm("PG(결제) 취소 하시겠습니까?")) return;
	if($('input[name="pg_Cancel_chk"]:checked').length == '0'){
		alert("체크된 상품이 없습니다. PG취소할 상품을 선택해주세요");	
		return false;
		}	
	$("input[name='pg_Cancel_chk']:unchecked").parents('tr').remove();
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