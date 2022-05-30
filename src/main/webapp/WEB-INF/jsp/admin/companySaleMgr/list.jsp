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


<style type="text/css">
table.table>thead>tr>th {
    text-align: center;
    vertical-align: middle;
}
</style>

<section class="content-header">
	<h1>
		공급사별 매출현황
		<small>공급사매출관리</small>
	</h1>
</section>

<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">검색 조건</h3>
		</div>
		<!-- /.box-header -->
		
		<div class="box-body">
			<spform:form class="form-horizontal" name="companySaleMgrForm" id="companySaleMgrForm" method="get" action="${contextPath}/adm/companySaleMgr">
				<div class="box-body">
					<div class="form-group" style="margin-left:0px; margin-right: 0px;">						
						<label for="schGbn" class="col-sm-1 control-label">검색어</label>
						<div class="col-sm-2">
							<select name="schGbn" class="form-control select2" style="width: 100%;">
								<option value="SUPR_NAME" ${ param.schGbn eq 'SUPR_NAME' ? "selected='selected'":''}>공급사상호</option>
								<option value="BIZR_NUM" ${ param.schGbn eq 'BIZR_NUM' ? "selected='selected'":''}>사업자번호</option>
							</select>
						</div>
						<div class="col-sm-5">
							<div class="input-group">
								<input type="search" class="form-control" name="schTxt" placeholder="검색어 입력" value="${param.schTxt }">
								<span class="input-group-btn">
									<button type="submit" class="btn btn-success pull-right">검색</button>
								</span>
							</div>
						</div>
					</div>
					<label class="col-sm-1 control-label">기간별 조회</label>						
					<div class="col-sm-2">
						<div class="input-group bootstrap-datepicker datepicker">		
							<input type="text" class="form-control" readonly="readonly" name="datepickerStr" id="datepickerStr" value="${obj.datepickerStr } " placeholder="시작일">
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</div>
					<div class="col-sm-2">
						<div class="input-group bootstrap-datepicker datepicker">		
							<input type="text" class="form-control" readonly="readonly" name="datepickerEnd" id="datepickerEnd" value="${obj.datepickerEnd }" placeholder="종료일">
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</div>
				</div>
			</spform:form>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- 검색 박스 -->
	
	
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">공급사 매출 집계 목록</h3>
			 <div class="box-tools">				
				<button type="button" class="btn btn-sm btn-success pull-right" id="btnExcel">엑셀</button>
			</div> 
		</div>
		<!-- /.box-header -->
			<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
				<table class="table table-bordered">
					<colgroup>
						<col width="5%"/>
						<col width="20%"/>
						<col width="20%"/>
						<col width="20%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="15%"/>
					</colgroup>	
					<thead>
						<tr>
							<th>번 호</th>
							<th>공급사 상호</th>
							<th>사업자 번호</th>
							<th>대 표 자</th>
							<th>주 문 금 액</th>
							<th>반 품 금 액</th>							
							<th >총 매 출 금 액</th>							
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${obj.list }" var="ent" varStatus="loop">
						<tr>
							<td style="text-align:center;">${ent.RNUM}</td>
							<td style="text-align:center;"><a href="${contextPath}/adm/companySaleMgr/${ent.SUPR_ID}">${ent.SUPR_NAME}</a></td>
							<td style="text-align:center;">${ent.BIZR_NUM}</td>
							<td style="text-align:center;">${ent.RPRS_NAME}</td>
							<td style="text-align:right;"><fmt:formatNumber value="${ent.ORDER_AMT eq null && ent.ORDER_AMT eq '' ? 0 : ent.ORDER_AMT  }"/></td>
							<td style="text-align:right;"><fmt:formatNumber value="${ent.RFND_AMT eq null ? 0: ent.RFND_AMT }"/></td>
							<td style="text-align:right;"><fmt:formatNumber value="${ent.ORDER_AMT-ent.RFND_AMT eq null? 0: ent.ORDER_AMT-ent.RFND_AMT}"/></td>
						</tr>
					</c:forEach>
					<c:if test="${obj.count eq 0}">
						<tr>
							<td colspan="15">조회된 내용이 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		
		<paging:PageFooter totalCount="${totalCnt}" rowCount="${ rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>
	</div>
</section>
<form id="excelFrm" method="get" action="${contextPath}/adm/companySaleMgr/excelDown">

</form>
<script>
$(function() {	
		//기간별 조회 검색
		$('#datepickerStr').datepicker({
			autoclose: true,
			format: 'yyyy-mm-dd'
		});
		$('#datepickerEnd').datepicker({
			autoclose: true,
			format: 'yyyy-mm-dd'
		});	
		
		//엑셀
		$("#btnExcel").click(function() {

			var checkboxValues = [];
			$("#excelFrm").submit();
		});
			
});	

</script>



