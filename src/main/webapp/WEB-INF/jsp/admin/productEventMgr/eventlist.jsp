<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		행사상품관리	
		<small>할인상품 목록</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

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
		<!-- search box-body -->
		<div class="box-body">
			<form class="form-horizontal" id="frm" method="get" action="${contextPath }/adm/productEventMgr">
				<!-- 검색조건 -->
				<input type="hidden" name="sortGubun" id="sortGubun" />
				<input type="hidden" name="sortOdr" id="sortOdr" />
				<input type="hidden" id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" /><!-- 목록수 -->
				
				<div class="box-body">
					<div class="form-group">
						<label class="col-sm-1 control-label">수정기간</label>						
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
							<select name="schGbn" class="form-control select2">
								<option value="PD_NAME" ${obj.schGbn eq 'PD_NAME' ? 'selected=selected':''}>상품명</option>
								<option value="PD_CODE" ${obj.schGbn eq 'PD_CODE' ? 'selected=selected':''}>상품코드</option>
								<option value="PD_BARCD" ${obj.schGbn eq 'PD_BARCD' ? 'selected=selected':''}>상품바코드</option>
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
				</div>
			</form>
		</div>
	</div>
	
	<!-- 정렬박스 -->	
	<div class="box box-default">		
		<div class="box-body">
			<div class="box-body">
				<div class="form-group">
					<label class="col-sm-1 control-label txt-right">정렬</label>
					<div class="col-sm-9">
						<button type="button" class="btn btn-sm btnSort" id="ordREG_DTM" sortGubun="REG_DTM" sortOdr="asc" sortName="등록일">등록일▼▲</button>
						<button type="button" class="btn btn-sm btnSort" id="ordMOD_DTM" sortGubun="MOD_DTM" sortOdr="asc" sortName="수정일">수정일▼▲</button>
						<button type="button" class="btn btn-sm btnSort" id="ordPD_NAME" sortGubun="PD_NAME" sortOdr="asc" sortName="상품명">상품명▼▲</button>
					</div>
					
					<label class="col-sm-1 control-label txt-right">목록수</label>
					<div class="col-sm-1">
						<select name="cnt" id="cnt" class="form-control select2" onchange="javascript:fn_order_by('');">									
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
	</div>
	
	<div class="box">
		<!-- box-header -->
		<div class="box-header with-border">
			<h3 class="box-title">행사상품  : <font color="green"><b>${ obj.list.size() > 0 ? obj.list.size() : 0 }</b></font></h3>
			<div class="box-tools">
				<button type="button" class="btn btn-sm btn-success pull-right left-5" id="btnExcel" >엑셀</button>
				<a href="${contextPath}/adm/productEventMgr/event" class="btn btn-sm btn-primary pull-right left-5" title="기존 항목 수정">수정</a>
				<a href="${contextPath}/adm/productEventMgr/new" class="btn btn-sm btn-primary pull-right left-5" title="신규 및  추가등록">신규등록</a>
			</div>
		</div>

		<!-- box-body -->
		<div class="box-body" style="white-space:nowrap; overflow-x:scroll;">
			<table class="table table-bordered">
				<colgroup>
					<col />
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th >번호</th>						
						<th>상품코드</th>
						<th>상품바코드</th>
						<th>상품명</th>
						<th>판매가격</th>						
						<th>할인금액</th>
						<th>할인구분</th>
						<th>행사가격</th>
						<th>판매상태</th>
						<th>수정자</th>
						<th>수정일</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(obj.list) eq 0}">
					<tr>
						<td colspan="8">조회된 리스트가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td>${loop.count }</td>						
						<td>${list.PD_CODE }</td>
						<td>${list.PD_BARCD }</td>
						<td>${list.PD_NAME }</td>
						<td align="right" ><fmt:formatNumber value="${list.PD_PRICE }" pattern="#,###"/></td>						
						<td align="right" ><fmt:formatNumber value="${list.PDDC_VAL }" pattern="#,###"/></td>
						<td>${list.PDDC_GUBN_NM }</td>
						<td align="right" ><fmt:formatNumber value="${list.REAL_PRICE }" pattern="#,###"/></td>
						<td>${list.SALE_CON }</td>
						<td>${list.MODP_ID }</td>
						<td>${list.MOD_DTM }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>		
		<!-- 페이징 -->
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>			
	</div>
	
</section>


<script type="text/javascript">
$(function() {
	<c:if test="${!empty param.schGbn}">
		$('#schGbn').val('${param.schGbn}');
	</c:if>
		
	<c:if test="${!empty param.sortGubun}">
		$('#ord${param.sortGubun}').attr("sortOdr", "${param.sortOdr eq 'desc' ? 'asc' : 'desc'}");
		$('#ord${param.sortGubun}').text( $('#ord${param.sortGubun}').attr("sortName") + " ${param.sortOdr eq 'desc' ? '△▼' : '▲▽'}");
		$("#sortGubun").val('${param.sortGubun}');
		$("#sortOdr").val('${param.sortOdr}');
	</c:if>

	
	//Date picker
	$('#datepickerStr').datepicker({
		autoclose: true,
		format: 'yyyy-mm-dd'
	});
	$('#datepickerEnd').datepicker({
		autoclose: true,
		format: 'yyyy-mm-dd'
	});	
	
	// 정렬
	$('.btnSort').click(function(){
		var strSortGubun = $(this).attr("sortGubun");
		var strSortOdr = $(this).attr("sortOdr");
		
		$("#sortGubun").val(strSortGubun);
		$("#sortOdr").val(strSortOdr);		
		$("#frm").submit();		
	});

	// 엑셀
	$("#btnExcel").click(function() {
	    $("#excelFrm").submit();
	});		
});

//정렬 주문일 & 주문자명 클릭시 , 목록수 변경시
function fn_order_by(str){		
	var frm=document.getElementById("frm");

	frm.pagerMaxPageItems.value=$("#cnt").val();
	console.log(frm.pagerMaxPageItems.value);
	frm.submit();
}
</script>

<form id="excelFrm" method="get" action="${contextPath }/adm/productEventMgr/excelDownload"></form>
