<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>


<!-- bootstrap datepicker -->
<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.css">
<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.min.css">

<!-- bootstrap datepicker -->
<script src="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.js"></script>
<script src="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.min.js"></script>

<c:set var="strActionUrl" value="${contextPath }/adm/orderMgr/" />
<c:set var="strMethod" value="post" />

<section class="content-header">
	<h1>
		주문내역	
		<small>주문내역</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">
	<!-- Horizontal Form -->
		<!-- 주문 정보 시작 -->
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">주문정보</h3>
			</div>
			<!-- /.box-header -->
		
				<!-- box-body -->
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">주문번호</label>
						<div class="col-sm-4">${tb_odinfoxm.ORDER_NUM }</div>
						<label for="inputEmail3" class="col-sm-2 control-label">주문자</label>
						<div class="col-sm-4">${tb_odinfoxm.MEMB_NM }</div>
						<button type="button" class="btn btn-primary btn-sm pull-right" id="btnExcel" style="margin-left:5px;">엑셀</button>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">주문일자</label>
						<div class="col-sm-4">${tb_odinfoxm.ORDER_DATE }</div>
						<label for="inputEmail3" class="col-sm-2 control-label">배송비 결제 여부</label>
						<div class="col-sm-4">${tb_odinfoxm.DAP_YN }</div>
					</div>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label"></label>
						<div class="col-sm-4"></div>
						<label for="inputEmail3" class="col-sm-2 control-label">쿠폰 사용 여부</label>
						<div class="col-sm-4">${tb_odinfoxm.CPON_YN }</div>
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- 주문 정보 끝 -->
			
		<!-- 주문상품 정보 시작 -->
		<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">	
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">주문 정보</h3>
			</div>
				<!-- /.box-header -->
				<div class="box-body">
					<c:set var="totalAmt" value="0"/>
					<table class="table table-bordered">
						<colgroup>
							<col style="with:10px" />
							<col />
							<col style="with:50px" />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>상품명</th>
								<th style="width:14%">수량</th>
								<th>할인가격</th>
								<th>가격</th>
							</tr>
						</thead>
						<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
							<tr>
								<td>${loop.count }</td>
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
											<input type="text" name="ORDER_QTY" value="${list.ORDER_QTY }" class="form-control btnQty" 
												style="width:100%;margin-right:10px;display:inline"/>
									<%
										}else{
									%>
											<input type="text" name="ORDER_QTY" value="${list.ORDER_QTY }" class="form-control btnQty" 
												style="width:40%;margin-right:10px;display:inline"/>
									<%
										}
									%>
									<%-- <input type="text" name="UPDATE_QTY" value="${list.ORDER_QTY }" class="form-control" style="width:40%;margin-right:10px;display:inline"/> --%>
									<input type="hidden" name="UPDATE_NUM" value="${list.ORDER_NUM }"/>
									<input type="hidden" name="UPDATE_DTNUM" value="${list.ORDER_DTNUM }"/>
									<input type="hidden" name="ORDER_DTNUM" value="${list.ORDER_DTNUM }"/>
									<input type="hidden" name="PDDC_VAL" value="${list.PDDC_VAL }"/>
									<input type="hidden" name="PD_PRICE" value="${list.PD_PRICE }"/>
									<input type="hidden" name="PDDC_GUBN" value="${list.PDDC_GUBN }"/>
									<!-- <button type="button" class="btn btn-default btnQty">수량변경</button> -->
								</td>
								<td><fmt:formatNumber>${list.PDDC_VAL }</fmt:formatNumber></td>
								<td class="orderAmt"><fmt:formatNumber>${list.ORDER_AMT }</fmt:formatNumber></td>
								<c:set var= "totalAmt" value="${totalAmt + list.ORDER_AMT}"/>
							</tr>
						</c:forEach>
						<tr>
							<th colspan="4" style="text-align:right;">상품 합계</th>
							<td id="totalPrdAmt" colspan="4" style="text-align:right"> <fmt:formatNumber><c:out value="${totalAmt}"/></fmt:formatNumber> </td>
						</tr>
						<tr>
							<th colspan="4" style="text-align:right;">배송비 </th>
							<td id="dlvyAmt" colspan="4" style="text-align:right"> 
								<c:set var = "dlvyAmt" value="${tb_odinfoxm.DLVY_AMT }"/>
								<%-- <c:if test="${totalAmt >= 200000 }">
									<c:set var="dlvyAmt" value="0"/>
								</c:if>
								<c:if test="${totalAmt >= 100000 && totalAmt < 200000}">
									<c:set var="dlvyAmt" value="10000"/>
								</c:if>
								<c:if test="${totalAmt < 100000 }">
									<c:set var="dlvyAmt" value="15000"/>
								</c:if> --%>
								<fmt:formatNumber><c:out value="${dlvyAmt}"/></fmt:formatNumber>
							</td>
						</tr>
						<tr>
							<th colspan="4" style="text-align:right;">총 합계 </th>
							<td id="totalAmt" colspan="4" style="text-align:right"> <fmt:formatNumber><c:out value="${totalAmt + dlvyAmt}"/></fmt:formatNumber> </td>
						</tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- 주문상품 정보 끝 -->
			
		
			<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM }" /><!-- 주문번호 -->
			
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
	
				<!-- box-body -->
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">받으시는 분</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="RECV_PERS" name="RECV_PERS" value="${tb_oddlaixm.RECV_PERS }" required="required"  />
						</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">주소</label>
						
						<div class="col-sm-10">
							<div class="form-group">
								<div class="col-sm-2">
									<input type="text" class="form-control" id="POST_NUM" name="POST_NUM" value="${tb_oddlaixm.POST_NUM }" required="required"  />
								</div>
								<div class="col-sm-3">
									<input type="button" class="btn btn-block btn-warning btn-xs" value="우편번호검색" >
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
									<input type="text" class="form-control" id="BASC_ADDR" name="BASC_ADDR" value="${tb_oddlaixm.BASC_ADDR }" required="required"  />
									<input type="text" class="form-control" id="DTL_ADDR" name="DTL_ADDR" value="${tb_oddlaixm.DTL_ADDR }" required="required"  />
								</div>
							</div>
						</div>
						
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">일반전화</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="RECV_TELN" name="RECV_TELN" value="${tb_oddlaixm.RECV_TELN }" required="required"  />
						</div>
						<label for="inputEmail3" class="col-sm-2 control-label">휴대전화</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="RECV_CPON" name="RECV_CPON" value="${tb_oddlaixm.RECV_CPON }" required="required"  />
						</div>
					</div><br/>
					<div class="form-group">
					
						<input type="hidden" id="DLAR_DATE" name="DLAR_DATE" value="${tb_oddlaixm.DLAR_DATE }" /><!-- 출고일 -->
						<input type="hidden" id="DLAR_TIME" name="DLAR_TIME" value="${tb_oddlaixm.DLAR_TIME }" /><!-- 출고/배송 시간 -->
						
						 <c:if test = '${tb_oddlaixm.DLAR_GUBN=="DLAR_GUBN_05" }' >
							<label for="inputEmail3" class="col-sm-2 control-label">현장출고일시</label>
							<div class="col-sm-2">
								<div class="input-group bootstrap-datepicker datepicker col-sm-10" style="float: inherit;">		
								<input type="text" class="form-control pull-left" name="datepicker_dlar" id="datepicker_dlar" value="" readonly="readonly">
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
								</div>
							</div>
							<div class="col-sm-2" style="padding-left:0px;padding-right:0px;padding-top:4px;padding-buttom:4px;">
								<select id="DLAR_TIME_CHK_01" class="form-control input-sm" >
									<option value="PM 1시~2시" <c:if test = '${tb_oddlaixm.DLAR_TIME =="PM 1시~2시" }'>selected="selected"</c:if>>PM 1시~2시</option>
									<option value="PM 2시~3시" <c:if test = '${tb_oddlaixm.DLAR_TIME =="PM 2시~3시" }'>selected="selected"</c:if>>PM 2시~3시</option>
									<option value="PM 3시~4시" <c:if test = '${tb_oddlaixm.DLAR_TIME =="PM 3시~4시" }'>selected="selected"</c:if>>PM 3시~4시</option>
									<option value="PM 4시~6시" <c:if test = '${tb_oddlaixm.DLAR_TIME =="PM 4시~6시" }'>selected="selected"</c:if>>PM 4시~6시</option>
					        	</select>
							</div>
						</c:if>
						 
						 <c:if test = '${tb_oddlaixm.DLAR_GUBN!="DLAR_GUBN_05" }' >
							<label for="inputEmail3" class="col-sm-2 control-label">배송일시</label>
							<div class="col-sm-2">
								<div class="input-group bootstrap-datepicker datepicker col-sm-10" style="float: inherit;">		
								<input type="text" class="form-control pull-left" name="datepicker_dlar" id="datepicker_dlar" value="" readonly="readonly">
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
								</div>
							</div>
							<div class="col-sm-2">
								<select name="DLAR_TIME_CHK_02" id="DLAR_TIME_CHK_02" class="form-control input-sm" >
									<option value="nothing">선택</option>
									<option value="오전" <c:if test = '${tb_oddlaixm.DLAR_TIME =="오전" }'>selected="selected"</c:if>>오전</option>
									<option value="오후" <c:if test = '${tb_oddlaixm.DLAR_TIME =="오후" }'>selected="selected"</c:if>>오후</option>
									<option value="5시~6시" <c:if test = '${tb_oddlaixm.DLAR_TIME =="5시~6시" }'>selected="selected"</c:if>>5시~6시</option>
									<%-- <option value="AM 10시~12시" <c:if test = '${tb_oddlaixm.DLAR_TIME =="AM 10시~12시" }'>selected="selected"</c:if>>AM 10시~12시</option>
									<option value="PM 1시~3시" <c:if test = '${tb_oddlaixm.DLAR_TIME =="PM 1시~3시" }'>selected="selected"</c:if>>PM 1시~3시</option>
									<option value="PM 3시~6시" <c:if test = '${tb_oddlaixm.DLAR_TIME =="PM 3시~6시" }'>selected="selected"</c:if>>PM 3시~6시</option> --%>
					        	</select>
							</div>
						</c:if>
						
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">배송 메세지</label>
						<div class="col-sm-10">
							<textarea rows="5" class="form-control" id="DLVY_MSG" name="DLVY_MSG" required="required">${tb_oddlaixm.DLVY_MSG }</textarea>
						</div>
					</div>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">관리자 참조설명</label>
						<div class="col-sm-10">
							<%-- <input type="text" class="form-control" id="ADM_REF" name="ADM_REF" value="${tb_oddlaixm.ADM_REF }" readonly="readonly" /> --%>
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
	
				<!-- box-body -->
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">주문상태</label>
						<div class="col-sm-3">
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
							<label for="inputEmail3" class="col-sm-1 control-label">취소사유</label>
							<div class="col-sm-2">
								${tb_odinfoxm.CNCL_MSG }
							</div>
						</c:if>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">결제 수단</label>
						<div class="col-sm-3"><%-- ${tb_odinfoxm.PAY_METD_NM } --%>
							<jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="PAY_METD" />
								<jsp:param name="name" value="PAY_METD" />
								<jsp:param name="value" value="${tb_odinfoxm.PAY_METD }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</div>
						<label for="inputEmail3" class="col-sm-1 control-label">결제 일시</label>
						<input type="hidden" name="PAY_DTM" id="PAY_DTM" value="${tb_odinfoxm.PAY_DTM }"/>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker col-sm-10" style="float: inherit;">		
							<input type="text" class="form-control pull-left" name="datepicker" id="datepicker" value="">
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
						</div>
						<div class="col-sm-2" style="padding-left:0px;padding-right:0px;padding-top:4px;padding-buttom:4px;">
							<div class="input-group bootstrap-timepicker timepicker col-sm-10" style="float: inherit;">		
								<input type="text" class="form-control pull-left" name="timepicker" id="timepicker" value="">
							<span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
					        </div>	
						</div>
						<label for="inputEmail3" class="col-sm-1 control-label">결제 상태</label>
						<div class="col-sm-1">
						</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">배송 정보</label>
						<div class="col-sm-3">
							<jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="DLVY_COM" />
								<jsp:param name="name" value="DLVY_COM" />
								<jsp:param name="value" value="${tb_odinfoxm.DLVY_COM }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</div>
						<label for="inputEmail3" class="col-sm-1 control-label">운송장번호</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="DLVY_TDN" name="DLVY_TDN" value="${tb_odinfoxm.DLVY_TDN }"  />
						</div>
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<input type="hidden" name="PAY_AMT"/>
			<!-- 주문 상태 및 결제 정보 끝 -->
			</spform:form>
			
			<div class="box-footer">
				<a href="${contextPath}/adm/orderMgr" class="btn btn-default pull-right">리스트</a>
				<!-- <button type="submit" class="btn btn-info pull-right">저장</button> -->
				<a onclick="javascript:fn_save();" class="btn btn-info pull-right">저장</a>
				<a onclick="javascript:fn_pg_cancle();" class="btn btn-default  btn-warning">PG사 결제 취소</a>
				<!-- <input type="button" class="btn btn-block btn-warning btn-xs" value="우편번호검색" > -->
			</div>
			
			
			<!-- /.box-footer -->
	
	<!-- /.box -->
</section>

<form name="updateQtyFrm" id="updateQtyFrm" method="post" action="${contextPath }/adm/orderMgr/orderQtyUpdate" >
<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="" /><!-- 주문번호  -->
<input type="hidden" id="ORDER_DTNUM" name="ORDER_DTNUM" value="" /><!-- 주문번호-detail  -->
<input type="hidden" id="ORDER_QTY" name="ORDER_QTY" value="" /><!-- 수량 -->
</form>
 
<script type="text/javascript">
$(document).ready(function() {
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
	
	//결제전이 아닌경우 상품수량 변겅 X
	if($("select[name=ORDER_CON]").val()!="ORDER_CON_01"){
		$("input[name=ORDER_QTY]").attr("readonly","readonly");	
	}
	
	//수량변경
	$('.btnQty').blur(function(){
		if($(this).closest("td").find("input[name^=ORDER_QTY]").attr("readonly")=="readonly"){
			alert("주문상태가 '결제전'이 아니므로 수량을 변경할 수 없습니다.")
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
	if($("#ORDER_CON").val()=="ORDER_CON_04"){//주문 취소시
		$("#CNCL_CON").show();
		$("#RFND_CON").hide();
		$("#RFND_CON").val("");
		$("#CNCL_CON").val("CNCL_CON_01");
		// $("#CNCL_CON option:eq(1)").attr("selected", "selected");
		// $("#CNCL_CON option:eq(1)").prop("selected", true);
	}else if($("#ORDER_CON").val()=="ORDER_CON_07"){//환불시
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

function fn_save(){

	
	
	var frm=document.getElementById("orderFrm");
	
	//결제일시 
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
	
	if(frm.ORDER_CON.value=='ORDER_CON_02'||frm.ORDER_CON.value=='ORDER_CON_03')
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
    }
   
    if(!confirm("저장 하시겠습니까?")) return;
	
	frm.submit();
}

//pg사 결제 취소
function fn_pg_cancle(){
	alert("추후개발");
}

function addComma(num) { //숫자콤마만드는 함수
	  var regexp = /\B(?=(\d{3})+(?!\d))/g;
	  return num.toString().replace(regexp, ',');
	}
</script>