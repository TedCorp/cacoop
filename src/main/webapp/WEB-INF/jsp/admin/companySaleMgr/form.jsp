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
			<h3 class="box-title">기간별 검색</h3>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<spform:form class="form-horizontal" name="companySaleMgrForm" id="companySaleMgrForm" method="get" action="${contextPath}/adm/companySaleMgr/${SUPR_ID}/search">
				<div class="box-body">
					<label class="col-sm-1 control-label">기간별 지정</label>						
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
					<button type="submit" class="btn btn-success pull-right">검색</button>
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
				<table class="table table-bordered" id="eTable">
					<colgroup>
						<col width="5%"/>
						<col width="20%"/>
						<col width="30%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
					</colgroup>	
					<thead>
						<tr>
							<th>번 호</th>
							<th>주문번호</th>
							<th>상품이름</th>
							<th>주 문 금 액</th>
							<th>반 품 금 액</th>							
							<th>총 매 출 금 액</th>							
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${obj.list }" var="ent" varStatus="loop">
							<tr>
								<td style="text-align:center;">${ent.RNUM }</td>
								<td style="text-align:center; vertical-align: middle !important;">${ent.ORDER_NUM}</td>
								<td style="text-align:left;"><a href="${contextPath }/adm/productMgr/edit/${ent.PD_CODE}"> ${ent.PD_NAME}</a></td>
								<td style="text-align:right;"><fmt:formatNumber value="${ent.ORDER_AMT}"/></td>
								<td style="text-align:right;"><fmt:formatNumber value="${ent.RFND_AMT }"/></td>
								<td style="text-align:right;"><fmt:formatNumber value="${ent.ORDER_AMT-ent.RFND_AMT}"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		
		<paging:PageFooter totalCount="${totalCnt}" rowCount="${ rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter> 
	</div>
</section>
<form id="excelFrm" method="get" action="${contextPath}/adm/companySaleMgr/excelDownDetail">
	<input type="hidden" name="SUPR_ID" value="${SUPR_ID}">
</form> 
<script>
$(function() {
		//기간별검색
		$('#datepickerStr').datepicker({
			autoclose: true,
			format: 'yyyy-mm-dd'
		});
		$('#datepickerEnd').datepicker({
			autoclose: true,
			format: 'yyyy-mm-dd'
		});	
		
		//rowspan
		var table = [];
	    var table_count = 1;
	    var k = 0;
	      $("#eTable tbody").find("tr").each(function(i,v) {
	        table.push($(v).find("td:nth-child(2)").text());
	      });

	      for(var i=0; i<table.length; i++) {
	        for(var j=i+1; j<table.length; j++) {
	          if(table[i] == table[j]) {
	            table_count +=1;
	            k+=1;
	          }
	        }
	        $("#eTable tbody").find("tr")[i].children[1].setAttribute("rowspan", table_count);
	        if(table_count > 1) {
	          for(var q = 1; q < table_count; q++) {
	            $("#eTable tbody").find("tr")[i+q].children[1].style.display = "none";
	          }
	        }
	        table_count = 1;
	        i=k;
	        k++;
	      }
	      
	      //엑셀
	      $("#btnExcel").click(function() {

				var checkboxValues = [];
				$("#excelFrm").submit();
			});


});
</script>



