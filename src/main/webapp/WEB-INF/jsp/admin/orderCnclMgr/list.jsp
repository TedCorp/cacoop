<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
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
.content .box .paging_new li.next .ic{background:url("${contextPath}/resources/resources2/images/icon_page_next.png") no-repeat 50% 50%}
</style>
<section class="content-header">
	<h1>
		취소내역(접수) 목록	
		<small>취소내역(접수) 목록</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<c:set var="strActionUrl" value="${contextPath }/adm/orderCnclMgr" />
<c:set var="strMethod" value="get" />

<c:choose>
<c:when test="${empty obj.DATE_ORDER or obj.DATE_ORDER =='desc' }"><c:set var="DATE_ORDER" value="asc" /></c:when>
<c:otherwise><c:set var="DATE_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
<c:when test="${empty obj.MEMB_NM_ORDER or  obj.MEMB_NM_ORDER =='desc' }"><c:set var="MEMB_NM_ORDER" value="asc" /></c:when>
<c:otherwise><c:set var="MEMB_NM_ORDER" value="desc" /></c:otherwise>
</c:choose>


<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">취소내역(접수)검색 조건</h3>

			<div class="box-tools pull-right">
				<button type="button" class="btn btn-box-tool" data-widget="collapse">
					<i class="fa fa-minus"></i>
				</button>
				<button type="button" class="btn btn-box-tool" data-widget="remove">
					<i class="fa fa-remove"></i>
				</button>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			
			<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
				<input type="hidden"  id="ORDER_GUBUN" name="ORDER_GUBUN" value="${obj.ORDER_GUBUN }" /><!-- 주문일 정렬 -->
				<input type="hidden"  id="DATE_ORDER" name="DATE_ORDER" value="${DATE_ORDER }" /><!-- 주문일 정렬 -->
				<input type="hidden"  id="MEMB_NM_ORDER" name="MEMB_NM_ORDER" value="${MEMB_NM_ORDER }" /><!-- 주문자명 정렬 -->
				<input type="hidden"  id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" /><!-- 목록수 -->
				<input type="hidden"  id="CNCL_CON_STATE" name="CNCL_CON_STATE" value="" /><!-- 배송준비중 변경 상태 변수 -->
				<input type="hidden"  id="CNCL_CON_ORDER_NUM" name="CNCL_CON_ORDER_NUM" value="" /><!-- 배송준비중 변경 상태 체크 항목 -->
				
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">주문상태</label>
						<div class="col-sm-2">
			                <jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="ORDER_CON" />
								<jsp:param name="name" value="ORDER_CON" />
								<jsp:param name="value" value="${obj.ORDER_CON}" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value=" 전체" />
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
						<label for="inputEmail3" class="col-sm-1 control-label">기간별 조회</label>
						<div class="col-sm-5">
							<div class="form-group">
								<div class="col-sm-5">
									<div class="input-group bootstrap-datepicker datepicker">	
										<input type="text" class="form-control" readonly="readonly" name="datepickerStr" id="datepickerStr" value="${obj.datepickerStr }" placeholder="시작일">
										<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
									</div>
								</div>
								<div class="col-sm-6">
									<div class="input-group bootstrap-datepicker datepicker">	
										<input type="text" class="form-control" readonly="readonly" name="datepickerEnd" id="datepickerEnd" value="${obj.datepickerEnd }" placeholder="종료일">
										<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
									</div>
								</div>
							</div>
						</div>
						<label for="inputEmail3" class="col-sm-1 control-label">검색조건</label>
						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2" style="width: 100%;">
								<option value="MEMB_NM" ${obj.schGbn == 'MEMB_NM' ? 'selected=selected':''}>주문자명</option>
								<option value="RECV_PERS" ${obj.schGbn == 'RECV_PERS' ? 'selected=selected':''}>수령자명</option>
							</select>
						</div>
						<div class="col-sm-2">
							<input name="schTxt" id="schTxt" type="text" class="form-control" placeholder="검색어 입력" value="${obj.schTxt }">
						</div>
						<div class="col-sm-1">
							<button type="submit" class="btn btn-success pull-right">검색</button>
						</div>
					</div>
				</div>
			<!-- /.box-body -->
			</spform:form>
			
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.box -->
	<div class="box-header with-border">
		<h3 class="box-title"></h3>
		<div class="box-tools">
			<a href="" class="btn btn-sm btn-primary pull-right">엑셀</a>
		</div>
	</div>
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<!-- /.box-header -->
		<div class="box-body">
			<form class="form-horizontal">
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">정렬</label>
						<div class="col-sm-6">
							<button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('DATE_ORDER');">주문일▼▲</button>
							<button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('MEMB_NM_ORDER');">주문자명▼▲</button>
							<button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('CNCL_REQDTM');">취소요청 일시▼▲</button>
						</div>
						<div class="col-sm-5"></div>
						<div class="col-sm-4">
							<label for="inputEmail3" class="col-sm-6 control-label">목록수</label>
							<div class="col-sm-3">
				                <select name="cnt" id="cnt" class="form-control select2" style="width: 100%;" onchange="javascript:fn_order_by();">
									<option value="10" ${obj.pagerMaxPageItems == '10' ? 'selected=selected':''}>10</option>
									<option value="20" ${obj.pagerMaxPageItems == '20' ? 'selected=selected':''}>20</option>
									<option value="30" ${obj.pagerMaxPageItems == '30' ? 'selected=selected':''}>30</option>
									<option value="40" ${obj.pagerMaxPageItems == '40' ? 'selected=selected':''}>40</option>
									<option value="50" ${obj.pagerMaxPageItems == '50' ? 'selected=selected':''}>50</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<!-- /.row -->
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.box -->
	<!-- 검색 박스 -->
	<div class="box">
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered">
				<colgroup>
					<col style="with:10px" />
					<col />
					<col style="with:50px" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="CHK_ALL" name="CHK_ALL" onclick="javascript:fn_all_chk();" /></th>
						<th>주문일시</th>
						<th>주문번호</th>
						<th>주문자명<br/>(수령자명)</th>
						<th>주문상품</th>
						<th>총 주문금액</th>
						<th>취소요청 일시</th>
						<th>상태</th>
						<th>기능</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${obj.count == 0}">
					<tr>
						<td colspan="8">조회된 취소내역(접수)이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td><input type="checkbox" id="CHK${loop.count }" name="CHK${loop.count }" value="${list.ORDER_NUM }"/></td>
						<td>${list.ORDER_DATE }</td>
						<td>${list.ORDER_NUM }</td>
						<td>${list.MEMB_NM }<br/>(${list.RECV_PERS })</td>
						<td>${list.PD_NAME }</td>
						<td><fmt:formatNumber value="${list.ORDER_AMT }" /> </td>
							<td>${list.CNCL_REQDTM }</td>
						<td>${list.CNCL_CON_NM }</td>
						<td><a href="${contextPath}/adm/orderCnclMgr/form/${list.ORDER_NUM }">상세</a></td>
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
			<button type="button" class="btn btn-warning btn-sm pull-right" onclick="javascript:fn_state('CNCL_CON_03');" style="margin-left: 10px;">취소승인</button>
			<button type="button" class="btn btn-warning btn-sm pull-right" onclick="javascript:fn_state('CNCL_CON_02');" style="margin-left: 10px;">취소거절</button>
		</div>
	</div>
</section>

<script>
	$(function() {
		//Date picker
		$('#datepickerStr').datepicker({
			autoclose: true,
			format: 'yyyy-mm-dd'
		});
		$('#datepickerEnd').datepicker({
			autoclose: true,
			format: 'yyyy-mm-dd'
		});
	});
	
	//정렬 주문일 & 주문자명 클릭시 , 목록수 변경시
	function fn_order_by(str){
		var frm=document.getElementById("orderFrm");
		if(str != ""){
			frm.ORDER_GUBUN.value=str;
		}
		frm.pagerMaxPageItems.value=$("#cnt").val();
		frm.submit();
	}
	
	//전체 체크 및 해제 시
	function fn_all_chk(){
		var check_yn = false;		
		if($("#CHK_ALL").is(":checked")){
			check_yn = true;
		}
		for(var i=1;i<= ${fn:length(obj.list) };i++){
			$("#CHK"+i).prop("checked",check_yn);
		}
	}
	
	//일괄 취소상태 변경
	function fn_state(str){
		
		var cnt = 0;
		var order_num_list = "";
		for(var i=1;i<= ${fn:length(obj.list) };i++){
			if($("#CHK"+i).is(":checked")){
				cnt++;
				if(order_num_list != "") {
					order_num_list+="$";
				}
				order_num_list+=$("#CHK"+i).val();
			}
		}
		if(cnt == 0){
			alert("체크한 항목이 없습니다.");
			return;
		}
		
		if(!confirm("일괄 변경 하시겠습니까?"))return;
		
		var frm=document.getElementById("orderFrm");
		frm.CNCL_CON_STATE.value=str;
		frm.CNCL_CON_ORDER_NUM.value=order_num_list;
		frm.submit();
	}
	
</script>