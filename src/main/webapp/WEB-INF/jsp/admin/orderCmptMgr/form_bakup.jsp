<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>


<!-- bootstrap datepicker -->
<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.css">
<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.min.css">

<!-- bootstrap datepicker -->
<script src="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.js"></script>
<script src="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.min.js"></script>

<c:set var="strActionUrl" value="${contextPath }/adm/orderCmptMgr/" />
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
				</div>
				<!-- /.box-body -->
			</div>
			<!-- 주문 정보 끝 -->
			
			<!-- 주문상품 정보 시작 -->
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
								<td>${list.ORDER_QTY }</td>
								<td><fmt:formatNumber>${list.PDDC_VAL }</fmt:formatNumber></td>
								<td><fmt:formatNumber>${list.ORDER_AMT }</fmt:formatNumber></td>
								<c:set var= "totalAmt" value="${totalAmt + list.ORDER_AMT}"/>
							</tr>
						</c:forEach>
						<tr>
							<th colspan="4" style="text-align:right;">상품 합계 </th>
							<td colspan="4" style="text-align:right"> <fmt:formatNumber><c:out value="${totalAmt}"/></fmt:formatNumber> </td>
						</tr>
						<tr>
							<th colspan="4" style="text-align:right;">배송비 </th>
							<td colspan="4" style="text-align:right"> 
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
							<td colspan="4" style="text-align:right"> <fmt:formatNumber><c:out value="${totalAmt + dlvyAmt}"/></fmt:formatNumber> </td>
						</tr>
						<tr>
							<td colspan="5">
								<a onclick="javascript:fn_ord_return();" class="btn btn-default btn-warning pull-right">반품신청</a>
							</td>
						</tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- 주문상품 정보 끝 -->
			
		<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
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
				<form class="form-horizontal">
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
				<form class="form-horizontal">
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
				<a href="${contextPath}/adm/orderCmptMgr" class="btn btn-default pull-right">리스트</a>
				<!-- <button type="submit" class="btn btn-info pull-right">저장</button> -->
				<a onclick="javascript:fn_save();" class="btn btn-info pull-right">저장</a>
				<a onclick="javascript:fn_pg_cancle();" class="btn btn-default  btn-warning">PG사 결제 취소</a>
				<!-- <input type="button" class="btn btn-block btn-warning btn-xs" value="우편번호검색" > -->
			</div>
			
			
			<!-- /.box-footer -->
	
	<!-- /.box -->
</section>

<form name="updateQtyFrm" id="updateQtyFrm" method="post" action="${contextPath }/adm/orderCmptMgr/orderQtyUpdate" >
<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="" /><!-- 주문번호  -->
<input type="hidden" id="ORDER_DTNUM" name="ORDER_DTNUM" value="" /><!-- 주문번호-detail  -->
<input type="hidden" id="ORDER_QTY" name="ORDER_QTY" value="" /><!-- 수량 -->
</form>
 
 
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
			<div class="modal-body">
            <form role="form">
            </form>
				<!-- 기업정보 박스 -->
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">반품신청리스트</h3>
					</div>
						<!-- /.box-header -->
					
					<!-- box-body -->
					<spform:form name="rtnInsertFrm" id="rtnInsertFrm" method="post" action="${contextPath }/adm/returnOrderMgr/insert" role="form" class="form-horizontal" enctype="multipart/form-data">
						<input type="hidden" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM }" />
						<input type="hidden" name="ORDER_DTNUM" value="" />
						<input type="hidden" name="RETURN_QTY" value="" />
						<input type="hidden" name="RETURN_GBN" value="" />
						<input type="hidden" name="MEMB_ID" value="${tb_odinfoxm.MEMB_ID }" />
						<input type="hidden" name="RETURN_AMT" value="" />
						<!-- 디테일  -->
						<input type="hidden" name="PD_CODES" value=""/>
						<input type="hidden" name="PD_NAMES" value=""/>
						<input type="hidden" name="PD_PRICES" value=""/>
						<input type="hidden" name="PDDC_GUBNS" value=""/>
						<input type="hidden" name="PDDC_VALS" value=""/>
						<input type="hidden" name="RETURN_QTYS" value=""/>
						<input type="hidden" name="RETURN_AMTS" value=""/>
						<input type="hidden" name="RETURN_GBNS" value=""/>
						<input type="hidden" name="ORDER_DTNUMS" value=""/>
						<!-- ..//디테일 -->
						<div class="box-body">

							<table class="table table-bordered">
								<colgroup>
									<col style="with:10px" />
									<col />
									<col style="with:50px" />
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" id="ALLCHK"/></th>
										<th>번호</th>
										<th>상품명</th>
										<th style="width:14%">주문수량</th>
										<th style="width:14%">반품수량</th>
										<th>반품사유</th>
									</tr>
								</thead>
								<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
										<input type="hidden" id="PD_PRICE_${list.ORDER_DTNUM }" value="${list.PD_PRICE }"/>
										<input type="hidden" id="PDDC_GUBN_${list.ORDER_DTNUM }" value="${list.PDDC_GUBN }"/>
										<input type="hidden" id="PDDC_VAL_${list.ORDER_DTNUM }" value="${list.PDDC_VAL }"/>
										             
										<input type="hidden" id="PD_CODE_${list.ORDER_DTNUM }" value="${list.PD_CODE }"/>
										<input type="hidden" id="PD_NAME_${list.ORDER_DTNUM }" value="${list.PD_NAME }"/>
										<input type="hidden" id="ORDER_DTNUM_${list.ORDER_DTNUM }" value="${list.ORDER_DTNUM }"/>
										
									<tr>
										<th><input type="checkbox" id="RTN_${list.ORDER_DTNUM }" name="RTN_CHK" value="${list.ORDER_DTNUM }"/></th>
										<td>${loop.count }</td>
										<td>${list.PD_NAME } <c:if test="${ list.PD_CUT_SEQ ne null }">(옵션 : ${ list.PD_CUT_SEQ})</c:if></td>
										<td><input type="hidden" id="ORDER_QTY_${list.ORDER_DTNUM }" value="${list.ORDER_QTY }"/>${list.ORDER_QTY }</td>
										<td><input class="form-control number" type="text" id="RETURN_QTY_${list.ORDER_DTNUM }" value="" onblur="javascript:fn_qtychk('${list.ORDER_DTNUM }');"/></td>
										<td><input class="form-control" type="text" id="RETURN_GBN_${list.ORDER_DTNUM }" value=""/></td>
										<c:set var= "totalAmt" value="${totalAmt + list.ORDER_AMT}"/>
									</tr>
								</c:forEach>
									<tr>
										<th colspan="5" style="text-align:right;">배송비 </th>
										<td style="text-align:right">
											<input type="text" name="DLVY_AMT" class="form-control number"/>
										</td>
									</tr>
									<tr>
										<th colspan="5" style="text-align:right;">반품일자 </th>										
										<td style="text-align:right">									
											<input type="hidden" id="RETURN_DATE" name="RETURN_DATE" value="" />
											<div class="input-group bootstrap-datepicker datepicker col-sm-10" style="float: inherit;">		
												<input type="text" class="form-control" name="datepicker_return" id="datepicker_return" value="">
												<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
											</div>											
										</td>
									</tr>
								</tbody>
							</table>

						</div>
					</spform:form>
						<!-- /.box-body -->
				</div>
				<!-- 기업정보 박스 -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" onclick="fn_rtn_insert()">반품등록</button>
			</div>
		</div>
	</div>
</div>
<!--..//반품신청  -->
 
 
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
		$("input[name=UPDATE_QTY]").attr("readonly","readonly");	
	}
		

	//반품일시
	/*
	$('#datepicker_return').datepicker({
		onSelect: function(strdate){			
			alert('working' + strdate);			
		}
	});
    */
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
		
		//var toYear = date.getFullYear();
		//var toMonth = pad(date.getMonth()+1, 2);
		//var toDay = pad(date.getDate(), 2);
		var toHour = pad(date.getHours(), 2);
		var toMinute = pad(date.getMinutes(), 2);
		var toSecond = pad(date.getSeconds(), 2);		
		var nowDate = toYear+toMonth+toDay+toHour+toMinute+toSecond;
		
		/* alert(nowDate); */
		$('#RETURN_DATE').val(nowDate);
		/* alert($('#RETURN_DATE').val()); */
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
	
	$("#ALLCHK").click(function() {		//체크박스
		if ($("#ALLCHK").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});
	
});

//엑셀
$("#btnExcel").click(function() {
	
	var form = document.createElement("form");

	form.target = "_blank";

	form.method = "get";
	form.action = "${contextPath }/adm/orderCmptMgr/detailExcelDown";

	document.body.appendChild(form);

	var input_id = document.createElement("input");
	input_id.setAttribute("type", "hidden");
	input_id.setAttribute("name", "ORDER_NUM");
	input_id.setAttribute("value", "${tb_odinfoxm.ORDER_NUM }");

	form.appendChild(input_id);
	form.submit();
    
});

//반품일시 format
function pad(number, length){
	var str = number.toString();
	
	while(str.length < length){
		str = '0' + str;
	}	
	return str;
}

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
	
	if(frm.ORDER_CON.value=='ORDER_CON_02')
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
    if($('#DLAR_TIME').val()==null||$('#DLAR_TIME').val()=='nothing'){
    	alert("배송시간은 필수값입니다. 입력해주세요")
    	 return;
    }
    if(!confirm("저장 하시겠습니까?")) return;
	
	frm.submit();
}

//pg사 결제 취소
function fn_pg_cancle(){
	alert("추후개발");
}

//반품요청
function fn_ord_return(){
	// 해당 주문번호에 대한 반품내역이 존재하면 알림팝업
	$.ajax({
		type: "POST",
		url: "${contextPath}/adm/returnOrderMgr/ordCheck",
		data: $("#rtnInsertFrm").serialize(),
		success: function (data) {
			//반품내역 확인
			if(data=='0'){
				$('#myModal').modal('show');
			}else{				
				if(!confirm("해당 주문번호에 대한 기존 반품내역이 존재합니다. 계속 진행하시겠습니까?")) return;
				$('#myModal').modal('show');		
			}
		}, error: function (jqXHR, textStatus, errorThrown) {
			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
		}
	});	
	
	//$('#myModal').modal('show');	
}

function fn_rtn_insert(){
	
	var frm=document.getElementById("rtnInsertFrm");
	var chechklist = new Array();
	var qtylist = new Array();
	var gbnlist = new Array();
	
	var codelist = new Array();
	var namelist = new Array();
	var pricelist = new Array();
	var pddcgubnlist = new Array();
	var pddcvallist = new Array();
    var orderdtnumlist = new Array();
	
	
	var returnAmt = 0;
	
	//validation 체크 
	if($("input:checkbox[name=RTN_CHK]:checked").length<1){
		alert("반품할 주문을 선택하세요.");
		return false;
	}
	
	var count = 0;
	//$("input[name='RETURN_QTYS'][value='']").size()
	$("input:checkbox[name=RTN_CHK]:checked").each(function (i) {
		 if($("#RETURN_QTY_"+$(this).val()).val()==null||$("#RETURN_QTY_"+$(this).val()).val()==''){
				count++;
		 }
		 if($("#RETURN_GBN_"+$(this).val()).val()==null||$("#RETURN_GBN_"+$(this).val()).val()==''){
				count++;
		 }
    });
	
	if(count>0){
		alert("반품수량과 반품사유는 필수값입니다.") 
		return false;
	}
		
	if($("input[name='DLVY_AMT']").val()==null||$("input[name='DLVY_AMT']").val()==''){
		alert("배송비는 필수값입니다.");
		return false;
	}

	if($("input:hidden[name=RETURN_DATE]").val() == null  || $("input:hidden[name=RETURN_DATE]").val() == ""){
		alert("반품일자를 입력해주세요.");
		return false;
	}
	
	//..validation 체크 
	
	$("input:checkbox[name=RTN_CHK]:checked").each(function(){
					
			var pd_price = parseInt($("#PD_PRICE_"+$(this).val()).val().replace(/[^\d]+/g, ''));
			var pddc_val = parseInt($("#PDDC_VAL_"+$(this).val()).val().replace(/[^\d]+/g, ''));
			var return_qty = parseInt($("#RETURN_QTY_"+$(this).val()).val().replace(/[^\d]+/g, ''));
			
			if($("#PDDC_GUBN_"+$(this).val()).val() == 'PDDC_GUBN_02'){
				returnAmt += (pd_price - pddc_val) * return_qty;
			}else if($("#PDDC_GUBN_"+$(this).val()).val() == 'PDDC_GUBN_03'){
				returnAmt += (pd_price - (pd_price*pddc_val/100))* return_qty;
			}else{
				returnAmt += pd_price * return_qty;
			}
			
			chechklist.push($(this).val());
			qtylist.push($("#RETURN_QTY_"+$(this).val()).val().replace(/[^\d]+/g, ''));
			gbnlist.push($("#RETURN_GBN_"+$(this).val()).val());
			
			codelist.push($("#PD_CODE_"+$(this).val()).val());
			namelist.push($("#PD_NAME_"+$(this).val()).val());
			pricelist.push($("#PD_PRICE_"+$(this).val()).val());
			pddcgubnlist.push($("#PDDC_GUBN_"+$(this).val()).val());
			pddcvallist.push($("#PDDC_VAL_"+$(this).val()).val());
			orderdtnumlist.push($("#ORDER_DTNUM_"+$(this).val()).val());
			
		
	});
	
	frm.RETURN_AMT.value = returnAmt;
	frm.ORDER_DTNUM.value=chechklist;
	frm.RETURN_QTY.value=qtylist;	
	frm.RETURN_GBN.value=gbnlist;
	
	frm.PD_CODES.value = codelist;
	frm.PD_NAMES.value = namelist;
	frm.PD_PRICES.value = pricelist;
	frm.PDDC_GUBNS.value = pddcgubnlist;
	frm.PDDC_VALS.value = pddcvallist;
	frm.RETURN_QTYS.value = qtylist;
	frm.RETURN_GBNS.value=gbnlist;
	frm.ORDER_DTNUMS.value=orderdtnumlist;
	frm.DLVY_AMT.value = frm.DLVY_AMT.value.replace(/[^\d]+/g, ''); 
	
		
	frm.submit();
	
}
function fn_qtychk(dtnum){
	var orderqty = parseInt($("#ORDER_QTY_"+dtnum).val());
	var returnqty = parseInt($("#RETURN_QTY_"+dtnum).val());
	
	if(orderqty < returnqty){
		alert("주문수량보다 반품수량이 더 많을 수 없습니다.");
		setTimeout(function(){
			$("#RETURN_QTY_"+dtnum).focus();
		})
		return false;
	}
	
	return true;
	
}

</script>