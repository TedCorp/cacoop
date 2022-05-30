<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
  
<!-- 바코드 라이브러리 -->
<script src="${contextPath }/resources/js/jquery-barcode-2.0.2.min.js"></script>

<style>
.content .box .paging_new{margin-top:30px}
.content .box .paging_new ul{display:flex;flex-direction:row;justify-content:center;align-items:center}
.content .box .paging_new li{width:30px;height:30px;}
.content .box .paging_new li a{display:block;width:30px;line-height:30px;font-size:14px;font-weight:500;color:#333;text-align:center;}
.content .box .paging_new li i{display:block;width:30px;height:30px}
.content .box .paging_new li.on a{background:#111;color:#fff;}
.content .box .paging_new li.start .ic{background:url("${contextPath}/resources/resources2/images/icon_page_start.png") no-repeat 50% 50%}
.content .box .paging_new li.end .ic{background:url("${contextPath}/resources/resources2/images/icon_page_end.png") no-repeat 50% 50%}
.content .box .paging_new li.prev .ic{background:url("${contextPath}/resources/resources2/images/icon_page_prev.png") no-repeat 50% 50%}
.content .box .paging_new li.next .ic{background:url("${contextPath}/resources/ resources2/images/icon_page_next.png") no-repeat 50% 50%} 



</style>

<c:set var="strActionUrl" value="${contextPath }/adm/orderMgr" />
<c:set var="strMethod" value="get" />

<c:choose>
	<c:when test="${empty obj.DATE_ORDER or obj.DATE_ORDER eq 'desc' }"><c:set var="DATE_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="DATE_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${empty obj.MEMB_NM_ORDER or  obj.MEMB_NM_ORDER eq 'desc' }"><c:set var="MEMB_NM_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="MEMB_NM_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${empty obj.COM_NAME_ORDER or  obj.COM_NAME_ORDER eq 'desc' }"><c:set var="COM_NAME_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="COM_NAME_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${empty obj.PAY_DATE_ORDER or obj.PAY_DATE_ORDER eq 'desc' }"><c:set var="PAY_DATE_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="PAY_DATE_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${empty obj.DLAR_DATE_ORDER or obj.DLAR_DATE_ORDER eq 'desc' }"><c:set var="DLAR_DATE_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="DLAR_DATE_ORDER" value="desc" /></c:otherwise>
</c:choose>

<section class="content-header">
	<h1>
		주문관리	
		<small>주문내역</small>
	</h1>
</section>

<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">검색 조건</h3>
			<div class="box-tools pull-right">
				<button type="button" class="btn btn-box-tool"
					data-widget="collapse">
					<i class="fa fa-minus"></i>
				</button>
				<button type="button" class="btn btn-box-tool" data-widget="remove">
					<i class="fa fa-remove"></i>
				</button>
			</div>
		</div>
		<!-- /.box-header -->
		
		<div class="box-body">
			<spform:form class="form-horizontal" name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }">
				<input type="hidden" id="ORDER_GUBUN" name="ORDER_GUBUN" value="${obj.ORDER_GUBUN }" />						<!-- 주문일 정렬 -->
				<input type="hidden" id="DATE_ORDER" name="DATE_ORDER" value="${DATE_ORDER }" />									<!-- 주문일 정렬 -->
				<input type="hidden" id="MEMB_NM_ORDER" name="MEMB_NM_ORDER" value="${MEMB_NM_ORDER }" />				<!-- 주문자명 정렬 -->
				<input type="hidden" id="COM_NAME_ORDER" name="COM_NAME_ORDER" value="${COM_NAME_ORDER }" />			<!-- 사업사상호 정렬 -->
				<input type="hidden" id="PAY_DATE_ORDER" name="PAY_DATE_ORDER" value="${PAY_DATE_ORDER }" />				<!-- 결제일자 정렬 -->
				<input type="hidden" id="DLAR_DATE_ORDER" name="DLAR_DATE_ORDER" value="${DLAR_DATE_ORDER }" />			<!-- 배송일자 정렬 -->
				<input type="hidden" id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" />	<!-- 목록수 -->
				<input type="hidden" id="ORDER_CON_ORDER_NUM" name="ORDER_CON_ORDER_NUM" value="" />						<!-- 배송준비중 변경 상태 체크 항목 -->
				<input type="hidden" id="CHK_ORD_LIST" name="CHK_ORD_LIST" value="" />														<!-- 배송준비중 변경 상태 체크 항목 -->
				
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">주문상태</label>
						<div class="col-sm-2">
							<jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="ORDER_CON" />
								<jsp:param name="name" value="ORDER_CON" />
								<jsp:param name="value" value="${obj.ORDER_CON }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="전체" />
							</jsp:include>
						</div>
						<div class="col-sm-2">
			                <jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="PAY_METD" />
								<jsp:param name="name" value="PAY_METD" />
								<jsp:param name="value" value="${obj.PAY_METD }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="전체" />
							</jsp:include>
						</div>
						<div class="col-sm-7"></div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-1 control-label">기간별 조회</label>						
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">		
								<input type="text" class="form-control" readonly="readonly" name="datepickerStr" id="datepickerStr" value="${obj.datepickerStr }" placeholder="시작일">
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
						</div>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">		
								<input type="text" class="form-control" readonly="readonly" name="datepickerEnd" id="datepickerEnd" value="${obj.datepickerEnd }" placeholder="종료일">
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
						</div>
						<label class="col-sm-1 control-label">검색어</label>
						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2">
								<option value="SEARCH_ORDER_NUM" ${obj.schGbn eq 'SEARCH_ORDER_NUM' ? 'selected=selected' : '' }">주문번호명</option>
								<option value="MEMB_NM" ${ obj.schGbn eq 'MEMB_NM' ? 'selected=selected' : '' }>주문자명</option>
								<option value="RECV_PERS" ${obj.schGbn eq 'RECV_PERS' ? 'selected=selected' : '' }>수령자명</option>
								<option value="COM_NAME" ${ obj.schGbn eq 'COM_NAME' ? 'selected=selected' : '' }>사업자상호</option>
							</select>
						</div>
						<div class="col-sm-3">
							<div class="input-group">
								<input type="search" class="form-control" name="schTxt" id="schTxt" placeholder="검색어 입력" 
									<c:if test = '${obj.schTxt ne null && obj.schTxt ne "null" }'>value="${obj.schTxt }"</c:if>>
								<span class="input-group-btn">
									<button type="submit" class="btn btn-success pull-right">검색</button>
								</span>
							</div>
						</div>
					</div>
					<!-- /.box-body -->
				</div>
			</spform:form>
		</div>
	</div>
	
	<!-- 정렬 박스 -->
	<div class="box box-default">
		<div class="box-body">
			<div class="box-body">
				<div class="form-group">
					<label class="col-sm-1 control-label">정렬</label>
					<div class="col-sm-9">
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('DATE_ORDER');">주문일▼▲</button>
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('MEMB_NM_ORDER');">주문자명▼▲</button>
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('COM_NAME_ORDER');">사업사상호▼▲</button>
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('PAY_DATE_ORDER');">결제시간▼▲</button>
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('DLAR_DATE_ORDER');">오전/오후▼▲</button>
					</div>
				
					<label class="col-sm-1 control-label txt-right">목록수</label>
					<div class="col-sm-1">
		                <select name="cnt" id="cnt" class="form-control select2" onchange="javascript:fn_order_by('');">
							<option value="10" ${obj.pagerMaxPageItems eq '10' ? 'selected=selected':''}>10</option>
							<option value="20" ${obj.pagerMaxPageItems eq '20' ? 'selected=selected':''}>20</option>
							<option value="30" ${obj.pagerMaxPageItems eq '30' ? 'selected=selected':''}>30</option>
							<option value="40" ${obj.pagerMaxPageItems eq '40' ? 'selected=selected':''}>40</option>
							<option value="50" ${obj.pagerMaxPageItems eq '50' ? 'selected=selected':''}>50</option>
							<option value="100" ${obj.pagerMaxPageItems eq '100' ? 'selected=selected':''}>100</option>
							<option value="200" ${obj.pagerMaxPageItems eq '200' ? 'selected=selected':''}>200</option>
						</select>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /.정렬 박스 -->

	<div class="row" style="padding-bottom:10px;">
		<div class="col-xs-12">
			<button type="button" class="btn btn-primary btn-sm viewPopup" gubun="goods">피킹리스트(상품별)</button>
			<button type="button" class="btn btn-primary btn-sm viewPopup" gubun="com">피킹리스트(매출처별)</button>
			<button type="button" class="btn btn-primary btn-sm viewPopup" gubun="car">피킹리스트(차량별)</button>
			<button type="button"class="btn btn-info btn-sm btnDlvy">배송전표</button>

			
			<button type="button" class="btn btn-primary btn-sm pull-right left-5 btnState" value="ORDER_CON_08">구매확정</button>
			<button type="button" class="btn btn-default btn-sm pull-right left-5 btnState" value="ORDER_CON_06">배송완료</button>
			<button type="button" class="btn btn-success btn-sm pull-right left-5 btnState" value="ORDER_CON_05">배송중</button>
			<button type="button" class="btn btn-warning btn-sm pull-right left-5 btnState" value="ORDER_CON_03">배송준비중</button>
			<button type="button" class="btn btn-default btn-sm pull-right btnDlvyUpload"><i class="fa fa-truck"></i> 운송장 엑셀 업로드</button>
		</div>
	</div>
	
	 <div class="box"> 
		<div class="box-header with-border">
			<h3 class="box-title">주문 목록</h3>
			<div class="box-tools">
				<button type="button" class="btn btn-success btn-sm pull-right" id="btnExcel"><i class="fa fa-file-excel-o" aria-hidden="true"></i> 엑셀</button>
			</div>
		</div>
	 	<div class="box-body" style="white-space:nowrap;overflow-x:scroll;"> 
			<table class="table table-bordered">
				<colgroup>
					<col width="2%" />
					<col width="3%"/>
					<col width="10%"/>
					<col width="12%"/>
					<col width="10%"/>
					<col width="15%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
				</colgroup>
				<thead>
					<tr>
						<th class="txt-middle"><input type="checkbox" id="CHK_ALL" name="CHK_ALL" onclick="javascript:fn_all_chk();" /></th>
						<th class="txt-middle">번호</th>				
						<th class="txt-middle">주문일자<br>결제시간</th>
						<th class="txt-middle">주문번호</th>
						<th class="txt-middle">주문자명<br>(사업사상호)</th>
						<th class="txt-middle">주문상품</th>
						<th class="txt-middle">상품주문금액</th>
						<th class="txt-middle">배 송 료</th>
						<th class="txt-middle">취소금액</th>
						<th class="txt-middle">총결제금액</th>
						<th class="txt-middle">주문상태<br>결제수단</th>
						<th class="txt-middle">고객요청사항 / <br>배송참조사항</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${obj.count eq 0}">
						<tr>
							<td colspan="13">조회된 주문내역이 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach items="${obj.list }" var="list" varStatus="loop">
						<tr>
							<td class="txt-middle"><input type="checkbox" id="CHK${loop.count }" name="chkOrdList" value="${list.ORDER_NUM }"/></td>
							<td class="txt-middle">${list.RNUM }</td>
							<td class="txt-middle">${list.ORDER_DATE }<br>${fn:split(list.PAY_DTM,'.')[0]}</td>
							<td class="txt-middle"><a href="${contextPath}/adm/orderMgr/form/${list.ORDER_NUM }">${list.ORDER_NUM }</a></td>
							<td class="txt-middle">
							 	${list.MEMB_NM }<br>
								<c:if test='${list.COM_NAME eq null or list.COM_NAME eq "" }'>( ${list.MEMB_NM })</c:if>
								<c:if test='${list.COM_NAME ne null and list.COM_NAME ne "" }'>( ${list.COM_NAME } )</c:if>
							</td>
							<td class="txt-left">${list.PD_NAME }</td>						
							<td class="txt-right"><fmt:formatNumber value="${list.ORDER_AMT}" /></td>
							<td class="txt-right"><fmt:formatNumber value="${list.DLVY_AMT_REAL }" /></td>	<!-- 배송비 -->
							<td class="txt-right" style="color: red;"><fmt:formatNumber value="${list.TOTAL_CANCEL + (list.DLVY_AMT_REAL-list.DLVY_AMT_NEW)}" /></td><!--취소금액  -->
							<td class="txt-right" style="font-weight: bold;"><fmt:formatNumber value="${(list.ORDER_AMT+list.DLVY_AMT_REAL)-(list.TOTAL_CANCEL + (list.DLVY_AMT_REAL-list.DLVY_AMT_NEW))}" /></td><!-- 주문금액 - 취소금액 + 취소배송비  -->
					<%-- 		<c:choose>
								<c:when test="${list.ORDER_AMT eq  list.TOTAL_CANCEL}"><!-- 주문금액과 취소금액이 같을경우 -->
									<td class="txt-right"><fmt:formatNumber value="${list.DLVY_AMT }" /></td>	<!-- 배송비 -->
									<td class="txt-right" style="color: red;"><fmt:formatNumber value="${list.TOTAL_CANCEL + list.DLVY_AMT-list.RFND_DLVY_AMT}" /></td><!--취소금액 + 배송비 - 취소배송비  -->
									<td class="txt-right" style="font-weight: bold;"><fmt:formatNumber value="${list.ORDER_AMT-list.TOTAL_CANCEL+list.RFND_DLVY_AMT}" /></td><!-- 주문금액 - 취소금액 + 취소배송비  -->
								</c:when>
								<c:otherwise><!-- 환불이 있을 경우  -->
									<td class="txt-right"><fmt:formatNumber value="${list.DLVY_AMT}"/></td>	
									<td class="txt-right"  style="color: red;"><fmt:formatNumber value="${list.TOTAL_CANCEL-list.RFND_DLVY_AMT}" /></td>
									<td class="txt-right" style="font-weight: bold;"><fmt:formatNumber value="${list.ORDER_AMT+list.DLVY_AMT-list.TOTAL_CANCEL}" /></td>								
								</c:otherwise>
							</c:choose> --%>						
							<td class="txt-middle payMetd">
								<input type="hidden" name="PAY_METD" value="${list.PAY_METD }"/>
								<input type="hidden" name="ORDER_CON_STATE" value="${list.ORDER_CON }"/><!-- 주문상태 변경 변수 -->
								<c:choose>
									<c:when test="${list.ORDER_CON eq 'ORDER_CON_01'}"><small class="label label-default">${list.ORDER_CON_NM }</small></c:when>
									<c:when test="${list.ORDER_CON eq 'ORDER_CON_02'}"><small class="label label-info">${list.ORDER_CON_NM }</small></c:when>
									<c:when test="${list.ORDER_CON eq 'ORDER_CON_03'}"><small class="label label-warning">${list.ORDER_CON_NM }</small></c:when>
									<c:when test="${list.ORDER_CON eq 'ORDER_CON_04' or list.ORDER_CON eq 'ORDER_CON_07'}"><small class="label label-danger">${list.ORDER_CON_NM }</small></c:when>
									<c:when test="${list.ORDER_CON eq 'ORDER_CON_05' or list.ORDER_CON eq 'ORDER_CON_06'}"><small class="label label-success">${list.ORDER_CON_NM }</small></c:when>
									<c:otherwise><small class="label label-default">${list.ORDER_CON_NM }</small></c:otherwise>
								</c:choose><br>
								<c:choose>								
									<c:when test="${!empty list.PAY_METD and list.PAY_METD eq 'SC0040' }"><span class="badge-default">${list.PAY_METD_NM }</span></c:when>								
									<c:when test="${!empty list.PAY_METD }"><span class="badge-light">${list.PAY_METD_NM }</span></c:when>
								</c:choose>
							</td>
							<td class="txt-middle">
								<small class="label label-${!empty list.DLVY_MSG ? 'info' : 'default'}" title="${list.DLVY_MSG }">${!empty list.DLVY_MSG ? 'Y' : 'N'}</small> / 
								<small class="label label-${!empty list.ADM_REF ? 'info' : 'default'}" title="${list.ADM_REF }">${!empty list.ADM_REF ? 'Y' : 'N'}</small>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		 </div> 
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>
	 </div>
	
	<div class="row">
		<div class="col-xs-12">
			<button type="button" class="btn btn-primary btn-sm viewPopup" gubun="goods">피킹리스트(상품별)</button>
			<button type="button" class="btn btn-primary btn-sm viewPopup" gubun="com">피킹리스트(매출처별)</button>
			<button type="button" class="btn btn-primary btn-sm viewPopup" gubun="car">피킹리스트(차량별)</button>
			<button type="button"class="btn btn-info btn-sm btnDlvy">배송전표</button>
			<button type="button" class="btn btn-primary btn-sm pull-right left-5 btnState" value="ORDER_CON_08">구매확정</button>
			<button type="button" class="btn btn-default btn-sm pull-right left-5 btnState" value="ORDER_CON_06">배송완료</button>
			<button type="button" class="btn btn-success btn-sm pull-right left-5 btnState" value="ORDER_CON_05">배송중</button>
			<button type="button" class="btn btn-warning btn-sm pull-right left-5 btnState" value="ORDER_CON_03">배송준비중</button>
		<!-- 	<button type="button" class="btn btn-danger btn-sm pull-right" onclick="javascript:deleteOrd();" >주문삭제</button> -->
		</div>
	</div>
</section>


<style type="text/css">
.modal-dialog.modal-lg { 
	width: 80%; 
	margin: 15px auto; 
	padding: 0; 
}
</style>

<!-- Modal : 피킹리스트 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">피킹리스트</h4>
			</div>
			<div class="modal-body" id="printPickingList">
				<!-- 정보 박스 -->
				<div class="box box-info">
				<spform:form class="form-horizontal" name="customerFrm" id="customerFrm" method="post" action="${contextPath}/adm/supplierMbrMgr" role="form">
					<div class="box-header with-border">
						<span class="box-title"></span>
					</div>
					<!-- /.box-header -->	
					<div class="box-body">						
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>순번</th>
									<th>상품이미지</th>
									<th class="tdCar">차량별</th>
									<th class="tdCom">매출처명</th>
									<th>상품명</th>
									<th>규격</th>
									<th>입수</th>
									<th>주문수량</th>
									<th>바코드</th>
									<th>바코드이미지</th>
									<th>배송구분</th>
								</tr>
							</thead>
							<tbody id="tBody">
							</tbody>
						</table>																		
					</div>
				</spform:form>
				<!-- /.box-body -->
				</div>
				<!-- 기업정보 박스 -->
			</div>
			<div class="modal-footer">				
				<button type="button" class="btn btn-sm btn-primary" onclick="pickingListPrint()"><i class="fa fa-print"></i> 출력</button>
				<button type="button" class="btn btn-sm btn-success" onclick="pickingListExcel()"><i class="fa fa-file-excel-o"></i> 엑셀</button>
				<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">닫기</button>
				<input type="hidden" id="pickingGbun"/>
			</div>
		</div>
	</div>  	
</div>

<!-- 주문내역 삭제 -->
<form name="deleteFrm" id="deleteFrm" method="post" action="${contextPath }/adm/orderMgr/deleteOrdList" >
	<input type="hidden" id="ORD_DELETE_LIST" name="ORD_DELETE_LIST" value="" /><!-- 배송준비중 변경 상태 체크 항목 -->
</form>

<!-- 배송전표 출력 -->
<form name="deliverFrm" id="deliverFrm" method="post" action="${contextPath }/adm/delivery" target="_blank">
	<input type="hidden" id="checkArray" name="checkArray" value="" />
	<input type="hidden" name="SUPR_ID" value="C00001" />
</form>

<!-- 주문상태 변경 -->
<form name="stateFrm" id="stateFrm" method="post" action="${contextPath }/adm/orderMgr/state">
	<input type="hidden" id="stateArray" name="stateArray" value="" />
	<input type="hidden" id="statePay" name="PAY_METD" value="" />
	<input type="hidden" id="stateOrd" name="ORDER_CON" value="" />
</form>


<script>
$(function() {	
	/* 운송장 업로드 모달 -- 20191211 */
	$(".btnDlvyUpload").click(function(){
		$('#dlvyModal').modal('show');
    });
	//엑셀 양식 받기
	$("#btnDlvyDown").click(function(){
		fn_excel_dlvyTdn(); 	
		//document.location.href = "${contextPath }/upload/jundan/excel/dlvy_excel_form.xls";
    });
	//엑셀저장
	$("#btnDlvySave").click(function(){		
		var filechk = $("#EXCEL_FILE").val();		
		if(filechk == null || filechk == ""){
			alert("업로드할 엑셀파일을 첨부해주세요.");
			return false;
		}
		if(!confirm("운송장번호를 업로드 하시겠습니까?"))return;
		$('#excelDlvyFrm').submit();
    });
	//상품검색 팝업 호출
	$("#btnDlvyCode").click(function(){
		window.open("${contextPath }/adm/comCodMgr/popup/DLVY_COM", "_blank", "width=650,height=650");
	});
	/* 운송장 업로드 모달 */
	
	//Date picker
	$('#datepickerStr').datepicker({
		autoclose: true,
		format: 'yyyy-mm-dd'
	});
	$('#datepickerEnd').datepicker({
		autoclose: true,
		format: 'yyyy-mm-dd'
	});	
	
	$('#myModal').on('show.bs.modal', function (event) {
		var modal = $(this);
        $(".btnSave").text("저장");
	});
	
	$(".btnDlvy").click(function(){
		var checkboxValues = [];
		
		//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
		$("input:checkbox[name=chkOrdList]:checked").each(function(){
			checkboxValues.push($(this).val());
		});
		
		if(checkboxValues.length < 1){
			checkboxValues.push("");			
			alert("배송전표를 생성할 주문을 선택해주세요.");
			return;
		}
		
		$('#checkArray').val(checkboxValues);
		$('#deliverFrm').submit();
	});
	
	$(".viewPopup").click(function(){
		var strGubun = $(this).attr("gubun");
		$('#pickingGbun').val(strGubun);

		var checkboxValues = [];
		//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
		$("input:checkbox[name=chkOrdList]:checked").each(function(){
			checkboxValues.push($(this).val());
		});
		
		if(checkboxValues=='' || checkboxValues==null){
			checkboxValues.push("");			
			alert("피킹리스트를 작성 할 주문을 선택하세요.");
			return false;
		}
		
	    var allData = { "checkArray": checkboxValues, "ORDER_GUBUN" : strGubun };
		var addTotalRow = "";
		
		$.ajax({
		    type: 'GET',
		    dataType: 'json',
		    data: allData,
		    url: '${contextPath }/adm/orderMgr/picking.json',
		    success: function (data) {		    	
		    	var objList = data.objList;
		    	
		    	if(objList.length>0){
		    		for(i=0;i<objList.length;i++){
			    		var addRow = "";
			    		addRow = '<tr>'
			    				+	'<td>'+(i+1)+'</td>'
			    				if(objList[i].atfl_ID != null){
			    					addRow = addRow +	'<td>'+//objList[i].atfl_ID+'</td>'
			    					'<img width="50" height="50" src="${contextPath }/common/commonFileDown?ATFL_ID='+objList[i].atfl_ID+'&ATFL_SEQ='+objList[i].rpimg_SEQ+'" />'
			    					+'</td>';
			    				}else{
			    					addRow = addRow +	'<td>'+
			    					'<img width="50" height="50" src="${contextPath }/resources/images/mall/goods/noimage.png"/>'
			    					+'</td>';
			    				}
			    				addRow = addRow +	'<td class="tdCar">'+((objList[i].car_NUM_NM==null) ? "미등록" : objList[i].car_NUM_NM)+'</td>';
			    				
			    		if(objList[i].com_NAME==null){
			    			addRow = addRow +	'<td class="tdCom">'+objList[i].memb_NM+'</td>';
			    		}else{
			    			addRow = addRow +	'<td class="tdCom">'+objList[i].com_NAME+"("+objList[i].memb_NM+")"+'</td>';
			    		}
			    		
			    		addRow = addRow +	'<td>'+objList[i].pd_NAME
			    					if(objList[i].pd_CUT_SEQ !=null && objList[i].pd_CUT_SEQ !='undefined'){
			    						addRow = addRow +'(세절방식 :'+objList[i].pd_CUT_SEQ+' )';
			    					}
						    		if(objList[i].option_CODE !=null && objList[i].option_CODE !='undefined'){
						    			addRow = addRow +'(색상 :'+objList[i].option_CODE+' )';	
			    					}
						    	addRow = addRow + '</td>';	
						    	addRow = addRow +	'<td>'+((objList[i].pd_STD==null) ? "" : objList[i].pd_STD)+'</td>'
			    				+	'<td>'+((objList[i].input_CNT==null) ? "" : objList[i].input_CNT)+'</td>'
			    				+	'<td>'+((objList[i].order_QTY==null) ? "" : objList[i].order_QTY)+'</td>'
			    				+	'<td>'+((objList[i].pd_BARCD==null) ? "" : objList[i].pd_BARCD)+'</td>'
			    				+	'<td>'+'<p id="barcodeTarget'+i+'" class="barcodeTarget"></p></td>'
			    				+	'<td>'+((objList[i].dlvy_GUBN==null) ? "" : objList[i].dlvy_GUBN)+'</td>'
			    				+'</tr>'
			    		addTotalRow += addRow;		    			
			    	}
		    	}else{
		    		var addRow = "";
		    		
		    		addRow = '<tr>'
		    				+	'<td colspan="6" style="text-align:center">조회된 데이터가 없습니다.</td>'
		    				+'</tr>';
		    		addTotalRow += addRow;
		    	}
		    	
		    	$("#tBody").html(addTotalRow);
		    	
		    	for(j=0;j<objList.length;j++){
		    		if(objList[j].pd_BARCD!=null){
			    		$("#barcodeTarget"+j).barcode(objList[j].pd_BARCD, "ean13");
			    	}else{
			    		$("#barcodeTarget"+j).text("데이터없음")
			    	}
		    	}
		    	
		    	$("#today").text("주문일자 : "+data.today);
		    	
		    	if(strGubun == "goods"){
		    		$(".tdCar").hide();
		    		$(".tdCom").hide();
		    		
		    	}else if(strGubun == "com"){
		    		$(".tdCar").hide();
		    		$(".tdCom").show();
		    		
		    	}else if(strGubun == "car"){
		    		$(".tdCar").show();
		    		$(".tdCom").show();		    		
		    	}
		    },
		    error:function(request,status,error){
		         console.log('error : '+error+"\n"+"code : "+request.status+"\n");
		    }
		});
		
		$('#myModal').modal('show');
		return false;
	 }); 
		
	// 엑셀
    $("#btnExcel").click(function() {
    	var checkboxValues = [];

		//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
		$("input:checkbox[name=chkOrdList]:checked").each(function(){
			checkboxValues.push($(this).val());
		});
		if(checkboxValues=='' || checkboxValues==null){
			checkboxValues.push("");
			alert("엑셀을 출력할 주문내역을 선택하세요.");
			return false;
		} 
		$("#CHK_ORD_LIST").val(checkboxValues);
    	/* var strAction = "${contextPath }/adm/orderMgr/excelDown"; */
    	var strAction = "${contextPath }/adm/orderMgr/OrderExcelDown";
    	var realAction = "${strActionUrl }";
    	
        $("#orderFrm").attr("action", strAction);
        $("#orderFrm").submit();
        
        //원래대로
        $("#orderFrm").attr("action", realAction);
    });
	
	/* 주문상태 일괄변경 */
	$(".btnState").click(function(){
		// 체크항목
		var checkboxValues =[];
		var ordState = $(this).val();
		console.log("btnState >> " + $(this).val());
		
		//입금확인 무통장 체크
		if(ordState == "ORDER_CON_02"){
			$('#statePay').val("SC0040");
			
			$("input:checkbox[name=chkOrdList]:checked").each(function(){
				console.log($(this).parent().parent().find('[name=ORDER_CON_STATE]').val());
				if($(this).parent().parent().find('[name=PAY_METD]').val() == "SC0040"
					&& $(this).parent().parent().find('[name=ORDER_CON_STATE]').val() == "ORDER_CON_10"){
					checkboxValues.push($(this).val());
				}
			});
		} else {
			$("input:checkbox[name=chkOrdList]:checked").each(function(){
				var ordState = $(this).parent().parent().find('[name=ORDER_CON_STATE]').val();
				console.log(ordState);
				if(ordState != "ORDER_CON_01" && ordState !="ORDER_CON_04" && ordState!= "ORDER_CON_07"){
					checkboxValues.push($(this).val());
				}
			});
		}
		
		console.log(checkboxValues);
		
		if(checkboxValues.length < 1){
			checkboxValues.push("");	
			alert("주문상태를 변경할 항목을 체크해주세요. 결제완료된 상태만 변경 가능합니다 (입금확인 제외)");
			return;
			
		} else {
			if(!confirm("선택한 주문의 상태를 변경하시겠습니까?")) return;
		}
		
		$('#stateArray').val(checkboxValues);
		$('#stateOrd').val(ordState);
		$('#stateFrm').submit();
	});
});

function winFrm(){
	var neWin = window.open("","print");
	//$(neWin.document.body).html("<input type=text value='"+checkboxValues+"'>");
}

/* 정렬 주문일 & 주문자명 클릭시 , 목록수 변경시 */
function fn_order_by(str){	
	var frm=document.getElementById("orderFrm");
	
	if(str != ""){
		frm.ORDER_GUBUN.value=str;
	}
	
	frm.pagerMaxPageItems.value=$("#cnt").val();
	console.log(frm.pagerMaxPageItems.value);
	frm.submit();
}

/* 전체 체크 및 해제 시 */
function fn_all_chk(){
	var check_yn = false;	
	
	if($("#CHK_ALL").is(":checked")){
		check_yn = true;
	}
	for(var i=1;i<= ${fn:length(obj.list)};i++){
		$("#CHK"+i).prop("checked",check_yn);
	}
}

//일괄 주문상태 변경(배송준비중 변경 버튼 클릭시)
function fn_state(str){	
	var cnt = 0;
	var order_num_list = "";
	
	for(var i=1;i<= ${fn:length(obj.list)};i++){
		if($("#CHK"+i).is(":checked")){
			cnt++;
			if(order_num_list != "") {
				order_num_list+="$";
			}
			order_num_list+=$("#CHK"+i).val();
		}
	}
	
	if(cnt < 1){
		alert("상태를 변경할 주문을 선택해주세요.");
		return;
	}
	
	if(!confirm("주문상태를 변경 하시겠습니까?"))return;

 	var frm=document.getElementById("orderFrm");
		
	frm.ORDER_CON_STATE.value=str;
	frm.ORDER_CON_ORDER_NUM.value=order_num_list;
	frm.submit();
}

//운송장 번호 양식 다운로드(운송장번호 양식 다운 버튼 클릭시)
function fn_excel_dlvyTdn(/* str */){	
	var cnt = 0;
	var order_num_list = "";
	//정성
	for(var i=1;i<= ${fn:length(obj.list) };i++){
		if($("#CHK"+i).is(":checked")){
			cnt++;
			if(order_num_list != "") {
				order_num_list+=",";
			}
			order_num_list+=$("#CHK"+i).val();
		}
	}
	
	if(cnt == 0){
		alert("송장번호 > 불러올 주문을 선택하세요.");
		return;
	}
	
	//if(!confirm("일괄 변경 하시겠습니까?"))return;	
	
	//엑셀 양식 다운
	var form = document.createElement("form");

	form.target = "_blank";

	form.method = "get";
	form.action = "${contextPath }/adm/orderMgr/DlvyTdnExcelDown";

	document.body.appendChild(form);

	var input_id = document.createElement("input");
	input_id.setAttribute("type", "hidden");
	input_id.setAttribute("name", "DLVY_TDN_ORDERNUM");
	input_id.setAttribute("value", order_num_list);

	form.appendChild(input_id);
	form.submit();
	
}

function pickingListPrint(){
	//결제완료 > 배송 준비중으로  update	
	
	var checkboxValues = [];				//var checkboxValues = new Array();

	//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
	$("input:checkbox[name=chkOrdList]:checked").each(function(){
		checkboxValues.push($(this).val());
	});
	
	if(checkboxValues==''||checkboxValues==null){
		checkboxValues.push("");
	}
	
    var allData = { "checkArray": checkboxValues };
	var addTotalRow = "";
		
	$.ajax({
	    type: 'GET',
	    dataType: 'json',
	    data: allData,
	    url: '${contextPath }/adm/orderMgr/pickingUpdate',
	    success: function (data) {   	
	    },
	    error:function(request,status,error){
	         console.log('error : '+error+"\n"+"code : "+request.status+"\n");
	    }
	});
		
	var initBody = document.body.innnerHTML;
	
	/* 
	var mediaQueryList = window.matchMedia('print');
    mediaQueryList.addListener(function(mql) {
        if (mql.matches) {
        	document.body.innerHTML = document.getElementById("printPickingList").innerHTML;
             //console.log('이 Function은 프린트 이전에 호출됩니다.');
        } else {
        	document.body.innerHTML = initBody;
             //console.log('이 Function은 프린트 이후에 호출됩니다.');
        }
    }); 
    */
	
	window.onbeforeprint = function(){
		document.body.innerHTML = document.getElementById("printPickingList").innerHTML;		
	}
	window.onafterprint = function(){
		//document.body.innerHTML = initBody;		
		window.location.reload(true);
	} 
	
	window.print();	
}

function delivery_slip(){	
	var checkboxValues ="";
	
	//체크값들 넣기
	$("input:checkbox[name=chkOrdList]:checked").each(function(){
		//checkboxValues.push($(this).val());
		checkboxValues += $(this).val()+":";
	});
	if(checkboxValues==''||checkboxValues==null){
		alert("주문을 하나이상 선택해 주세요.")
		return;
	}
	window.open('http://121.183.206.41/cjflsRptWeb/Clickonce/cjflsRpt.application?'
			+'qr='+checkboxValues+'');
}

function pickingListExcel(){	
	//엑셀정보가져오기
	var strGubun = $('#pickingGbun').val();
	var checkboxValues = [];

	//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
	$("input:checkbox[name=chkOrdList]:checked").each(function(){
		checkboxValues.push($(this).val());
	});
	
	if(checkboxValues==''||checkboxValues==null){
		checkboxValues.push("");		
		alert("출력할 정보가 없습니다.");
		return false;
	}
	
    var allData = { "checkArray": checkboxValues, "ORDER_GUBUN" : strGubun };
    var form = "<form action='${contextPath }/adm/orderMgr/pickingExcelDown' method='get'>"; 
    
    form += "<input type='hidden' name='checkArray' value='"+checkboxValues+"' />"; 
    form += "<input type='hidden' name='ORDER_GUBUN' value='"+strGubun+"' />"; 
    form += "</form>"; 
    
    jQuery(form).appendTo("body").submit().remove(); 	
}

//주문내역 삭제
function deleteOrd(){	
	var checkboxValues = [];

	//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
	$("input:checkbox[name=chkOrdList]:checked").each(function(){
		checkboxValues.push($(this).val());
	});
	
	if(checkboxValues==''||checkboxValues==null){
		checkboxValues.push("");		
		alert("삭제할 주문을 선택하세요.");
		return false;
	}
	
	var frm=document.getElementById("deleteFrm");
	frm.ORD_DELETE_LIST.value=checkboxValues;
	
	if(confirm("결제전 상태의 주문내역만 삭제됩니다.\n삭제하시겠습니까?")){
		frm.submit();	
	}	
}
</script>


<!-- Modal : 운송장 엑셀 업로드 모달 -->
<div class="modal fade" id="dlvyModal" tabindex="-1" role="dialog" aria-labelledby="dlvyModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="dlvyModalLabel">운송장 엑셀 업로드</h4>
			</div>
			<!-- 정보 박스 -->
			<div class="modal-body">
            	<spform:form name="excelDlvyFrm" id="excelDlvyFrm" method="post" action="${contextPath }/adm/orderMgr/excelDlvyUpload" role="form" class="form-horizontal" enctype="multipart/form-data">				
					<div class="box box-info">
						<!-- /.box-header -->					
						<div class="box-body">
							<div class="form-group">
								<label class="col-sm-3 control-label">택배사코드</label>
								<div class="col-sm-9">
									<button type="button" class="btn btn-default btn-sm pull-left" id="btnDlvyCode"><i class="fa fa-search"></i>&nbsp;조회하기</button>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">양식파일</label>
								<div class="col-sm-9">
									<button type="button" class="btn btn-info btn-sm pull-left" id="btnDlvyDown"><i class="fa fa-download"></i>&nbsp;양식 받기</button>
								</div>
							</div>						
							<div class="form-group">
								<label class="col-sm-3 control-label">엑셀파일</label>
								<div class="col-sm-9">
									<input type="file" id="EXCEL_FILE" name="EXCEL_FILE" id="file-simple" value=""> 
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">안내사항</label>
								<div class="col-sm-9">
									<span style="color:red">운송장 업로드시 주문상태가 '배송중'으로 변경됩니다.</span> 
								</div>
							</div>
						</div>					
						<!-- /.box-body -->
					</div>
				</spform:form>
			</div>
			<!-- /.정보 박스 -->
			<div class="modal-footer">				
				<button type="button" class="btn btn-primary btn-sm" id="btnDlvySave">업로드</button>
				<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div> 