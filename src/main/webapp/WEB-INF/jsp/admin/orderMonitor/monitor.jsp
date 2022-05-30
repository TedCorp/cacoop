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
.content .box .paging_new li.next .ic{background:url("${contextPath}/resources/resources2/images/icon_page_next.png") no-repeat 50% 50%}
</style>
<section class="content-header">
	<h1>
		주문 모니터링
		<small>주문 현황</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<c:set var="strActionUrl" value="${contextPath }/adm/orderMonitor" />
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

<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">검색 조건</h3>
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
			<spform:form class="form-horizontal" name="monitorFrm" id="monitorFrm" method="${strMethod }" action="${strActionUrl }">
				<input type="hidden" id="ORDER_GUBUN" name="ORDER_GUBUN" value="${obj.ORDER_GUBUN }" />						<!-- 주문일 정렬 -->
				<input type="hidden" id="DATE_ORDER" name="DATE_ORDER" value="${DATE_ORDER }" />									<!-- 주문일 정렬 -->
				<input type="hidden" id="MEMB_NM_ORDER" name="MEMB_NM_ORDER" value="${MEMB_NM_ORDER }" />				<!-- 주문자명 정렬 -->
				<input type="hidden" id="COM_NAME_ORDER" name="COM_NAME_ORDER" value="${COM_NAME_ORDER }" />			<!-- 사업사상호 정렬 -->
				<input type="hidden" id="PAY_DATE_ORDER" name="PAY_DATE_ORDER" value="${PAY_DATE_ORDER }" />				<!-- 결제일자 정렬 -->
				<input type="hidden" id="DLAR_DATE_ORDER" name="DLAR_DATE_ORDER" value="${DLAR_DATE_ORDER }" />			<!-- 배송일자 정렬 -->
				<input type="hidden" id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" />	<!-- 목록수 -->
				<input type="hidden" id="ORDER_CON_STATE" name="ORDER_CON_STATE" value="" />											<!-- 배송준비중 변경 상태 변수 -->
				<input type="hidden" id="ORDER_CON_ORDER_NUM" name="ORDER_CON_ORDER_NUM" value="" />						<!-- 배송준비중 변경 상태 체크 항목 -->
				<input type="hidden" id="CHK_ORD_LIST" name="CHK_ORD_LIST" value="" />														<!-- 배송준비중 변경 상태 체크 항목 -->
				
				<div class="box-body">
					<div class="form-group">
						<label for="ORDER_CON" class="col-sm-1 control-label">주문상태</label>
						<div class="col-sm-2">
							<p class="form-control-static">
				                <jsp:include page="${contextPath }/common/comCodForm">
									<jsp:param name="COMM_CODE" value="ORDER_CON" />
									<jsp:param name="name" value="ORDER_CON" />
									<jsp:param name="value" value="${obj.ORDER_CON }" />
									<jsp:param name="type" value="select" />
									<jsp:param name="top" value="전체" />
								</jsp:include>
							</p>
						</div>
						<div class="col-sm-2">
							<p class="form-control-static">
				                <jsp:include page="${contextPath }/common/comCodForm">
									<jsp:param name="COMM_CODE" value="PAY_METD" />
									<jsp:param name="name" value="PAY_METD" />
									<jsp:param name="value" value="${obj.PAY_METD }" />
									<jsp:param name="type" value="select" />
									<jsp:param name="top" value="전체" />
								</jsp:include>
							</p>
						</div>
					</div>
					
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">기간별 조회</label>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">
								<input type="text" class="form-control pull-left" name="datepickerStr" id="datepickerStr" value="${obj.datepickerStr }" placeholder="시작일" readonly>
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>							
						</div>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">
								<input type="text" class="form-control pull-right" name="datepickerEnd" id="datepickerEnd" value="${obj.datepickerEnd }" placeholder="종료일" readonly>
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
						</div>
						
						<label for="schGbn" class="col-sm-1 control-label">검색어</label>
						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2">
								<option value="MEMB_NM" ${obj.schGbn eq 'MEMB_NM' ? 'selected=selected':''}>주문자명</option>
								<option value="RECV_PERS" ${obj.schGbn eq 'RECV_PERS' ? 'selected=selected':''}>수령자명</option>
								<option value="COM_NAME" ${ obj.schGbn eq 'COM_NAME' ? "selected='selected'":''}>사업자상호</option>
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
	<!-- /.검색박스 -->
	
	<!-- 정렬박스 -->
	<div class="box box-default">
		<div class="box-body">
			<div class="box-body">
				<div class="form-group">
					<label for="btnSort" class="col-sm-1 control-label">정렬</label>
					<div class="col-sm-9">
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('DATE_ORDER');">주문일▼▲</button>
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('MEMB_NM_ORDER');">주문자명▼▲</button>
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('COM_NAME_ORDER');">사업사상호▼▲</button>
						<!-- <button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('PAY_DATE_ORDER');">결제시간▼▲</button> -->
					</div>
					
					<label for="pagerMax" class="col-sm-1 control-label txt-right">목록수</label>
					<div class="col-sm-1">
		                <select class="form-control select2" name="cnt" id="cnt" style="width: 100%;" onchange="javascript:fn_order_by();">
							<option value="10" ${obj.pagerMaxPageItems eq '10' ? 'selected=selected':''}>10</option>
							<option value="20" ${obj.pagerMaxPageItems eq '20' ? 'selected=selected':''}>20</option>
							<option value="30" ${obj.pagerMaxPageItems eq '30' ? 'selected=selected':''}>30</option>
							<option value="40" ${obj.pagerMaxPageItems eq '40' ? 'selected=selected':''}>40</option>
							<option value="50" ${obj.pagerMaxPageItems eq '50' ? 'selected=selected':''}>50</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.정렬 박스 -->
	
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">주문현황 목록</h3>
			<div class="box-tools">
				<button type="button" class="btn btn-success btn-sm pull-right" id="btnExcel"><i class="fa fa-file-excel-o" aria-hidden="true"></i> 엑셀</button>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
			<table class="table table-bordered" id="eTable">
				<colgroup>
					<col />
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th class="txt-middle"><input type="checkbox" id="CHK_ALL" name="CHK_ALL" onclick="javascript:fn_all_chk();" /></th>
						<th class="txt-middle">번호</th>
						<th class="txt-middle">공급업체</th>
						<th class="txt-middle">주문일자<br>결제시간</th>
						<th class="txt-middle">주문번호</th>
						<th class="txt-middle">주문자명<br>(사업사상호)</th>
						<th class="txt-middle">사업자번호</th>
						<th class="txt-middle">상품코드</th>
						<th class="txt-middle">상품명</th>						
						<th class="txt-right">수량</th>
						<th class="txt-right">상품소계</th>
						<th class="txt-middle">주문상태<br>결제수단</th>
						<th class="txt-right">매출가</th>
						<th class="txt-right">매입가</th>
						<th class="txt-right">배송비</th>
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
						<td class="txt-middle">
							<input type="checkbox" id="CHK${loop.count }" name="CHKLIST" value="${list.ORDER_NUM }-${list.ORDER_DTNUM }"/>
						</td>
						<td class="txt-middle">
							${list.RNUM }
						</td>
						<td class="txt-middle">
							${list.SUPR_ID_NAME}
						</td>
						<td class="txt-middle">
							${list.ORDER_DATE }<br>${fn:split(list.PAY_DTM,'.')[0]}
						</td>
						<td class="txt-middle">
							<a href="${contextPath}/adm/orderMgr/form/${list.ORDER_NUM }">${list.ORDER_NUM }-${list.ORDER_DTNUM } </a>
						</td>
						<td class="txt-middle">
							${list.MEMB_NM }<br>
							<c:if test="${!empty list.COM_NAME }">( ${list.COM_NAME } )</c:if>
						</td>
						<td class="txt-middle">
							${list.COM_BUNB }
						</td>
						<td class="txt-middle">
							${list.PD_CODE }
						</td>
						<td class="txt-left">
							${list.PD_NAME }
						</td>
						<td class="txt-right">
							<fmt:formatNumber value="${list.ORDER_QTY }" />
						</td>
						<td class="txt-right">
							<fmt:formatNumber value="${list.ORDER_AMT }" />
						</td>
						<td class="txt-middle">
							<c:choose>
								<c:when test="${list.ORDER_CON eq 'ORDER_CON_01'}"><small class="label label-default">${list.ORDER_CON_NM }</small></c:when>
								<c:when test="${list.ORDER_CON eq 'ORDER_CON_02'}"><small class="label label-info">${list.ORDER_CON_NM }</small></c:when>
								<c:when test="${list.ORDER_CON eq 'ORDER_CON_03'}"><small class="label label-warning">${list.ORDER_CON_NM }</small></c:when>
								<c:when test="${list.ORDER_CON eq 'ORDER_CON_04' or list.ORDER_CON eq 'ORDER_CON_07'}"><small class="label label-danger">${list.ORDER_CON_NM }</small></c:when>
								<c:when test="${list.ORDER_CON eq 'ORDER_CON_05' or list.ORDER_CON eq 'ORDER_CON_06'}"><small class="label label-success">${list.ORDER_CON_NM }</small></c:when>								
								<c:otherwise><small class="label label-default">${list.ORDER_CON_NM }</small></c:otherwise>
							</c:choose>
							<br>
							<c:choose>								
								<c:when test="${!empty list.PAY_METD and list.PAY_METD eq 'SC0040' }"><span class="badge-default">${list.PAY_METD_NM }</span></c:when>
								<c:when test="${!empty list.PAY_METD }"><span class="badge-light">${list.PAY_METD_NM }</span></c:when>
							</c:choose>
						</td>
						<td class="txt-right">
							<fmt:formatNumber value="${list.REAL_PRICE }" />
						</td>
						<td class="txt-right">
							<fmt:formatNumber value="${list.PD_IWHUPRC }" />
						</td>
						<td class="txt-right">
							<fmt:formatNumber value="${list.DLVY_AMT }" />
						</td>
						<%-- <td class="txt-right">
							<fmt:formatNumber value="${list.REAL_PRICE - list.PD_IWHUPRC }" />
						</td>
						<td class="txt-right">
							${1-( list.PD_IWHUPRC / list.REAL_PRICE ) }
						</td> --%>
						<%-- <td class="txt-left">
							<c:if test="${!empty list.DLVY_COM }"><b>[${list.DLVY_COM_NM }]</b><br>${list.DLVY_TDN }</c:if>
						</td> --%>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>
	</div>
	
	<!-- 취소상태 변경버튼 -->
	<div class="row">
		<div class="col-xs-12">
			<!-- <button type="button" class="btn btn-success btn-sm pull-right left-5" onclick="javascript:fn_state('ORDER_CON_05');" >배송중</button>
			<button type="button" class="btn btn-warning btn-sm pull-right left-5" onclick="javascript:fn_state('ORDER_CON_09');" >배송준비중2</button>
			<button type="button" class="btn btn-warning btn-sm pull-right left-5" onclick="javascript:fn_state('ORDER_CON_03');" >배송준비중1</button> -->
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
		
		//excel
		$("#btnExcel").click(function() {    	
	    	var checkboxValues = [];
	    	
	
			//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
			$("input:checkbox[name=CHKLIST]:checked").each(function(){
				checkboxValues.push($(this).val());
				
			});
			if(checkboxValues==''||checkboxValues==null){
				checkboxValues.push("");
				
				alert("엑셀을 출력할 주문내역을 선택하세요.");
				return false;
			}
			
			$("#CHK_ORD_LIST").val(checkboxValues);
	    	var strAction = "${contextPath }/adm/orderMonitor/excelDown";
	    	var realAction =  "${strActionUrl }";
	    	
	    	
	        $("#monitorFrm").attr("action", strAction);
	        $("#monitorFrm").submit();
	        
	        //원래대로
	        $("#monitorFrm").attr("action",realAction);
	    });
		
		
		//rowspan
		var table = []; //주문번호 값 입력
	    var table_count = 1; //table 배열의 같은값 
	    var k = 0;
	      $("#eTable tbody").find("tr").each(function(i,v) {
	        table.push($(v).find("td:nth-child(4)").text());
	      });

	      for(var i=0; i<table.length; i++) {
	        for(var j=i+1; j<table.length; j++) {
	          if(table[i] == table[j]) {
	            table_count +=1;
	            k+=1;
	          }
	        }
	        $("#eTable tbody").find("tr")[i].children[14].setAttribute("rowspan", table_count);
	        if(table_count > 1) {
	          for(var q = 1; q < table_count; q++) {
	            $("#eTable tbody").find("tr")[i+q].children[14].style.display = "none";
	          }
	        }
	        table_count = 1;
	        i=k;
	        k++;
	      }
		
		
	});
	
	//정렬 주문일 & 주문자명 클릭시 , 목록수 변경시
	function fn_order_by(str){		
		var frm=document.getElementById("monitorFrm");
		
		if(str != " "){
			frm.ORDER_GUBUN.value=str;
		}
		
		frm.pagerMaxPageItems.value=$("#cnt").val();
		frm.submit();
	}	
	
	function fn_all_chk(){
		var check_yn = false;	
		
		if($("#CHK_ALL").is(":checked")){
			check_yn = true;
		}
		for(var i=1;i<= ${fn:length(obj.list) };i++){
			$("#CHK"+i).prop("checked",check_yn);
		}
	}
</script>