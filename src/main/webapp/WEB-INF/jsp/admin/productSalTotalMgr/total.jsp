<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<style type="text/css">
table.table>thead>tr>th,
table.table>tbody>tr>td {
    text-align: center;
    vertical-align: middle;
}
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
		상품-기간별 매출현황
		<small>상품매출관리</small>
	</h1>
</section>

<c:set var="strActionUrl" value="${contextPath }/adm/productSalTotalMgr" />
<c:set var="strMethod" value="get" />

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
			<spform:form  class="form-horizontal" name="productSalTotalMgrForm" id="productSalTotalMgrForm" method="${strMethod }" action="${strActionUrl }"> <!-- onsubmit="return false" -->
				<!-- 검색조건 -->
				<input type="hidden" name="sortGubun" id="sortGubun" />
				<input type="hidden" name="sortOdr" id="sortOdr" />
				<input type="hidden" id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" /><!-- 목록수 -->
				
				<div class="box-body">
					<div class="form-group">
						<label class="col-sm-1 control-label">기간</label>						
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">		
								<input type="text" class="form-control datepicker" readonly="readonly" name="datepickerStr" id="datepickerStr" value="${obj.datepickerStr }" placeholder="시작일">
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
						</div>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">
								<input type="hidden" name="schGbn" id="schGbn" value="PD_CODE">
								<input type="text" class="form-control datepicker" readonly="readonly" name="datepickerEnd" id="datepickerEnd" value="${obj.datepickerEnd }" placeholder="종료일">
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
						</div>
						
						<label for="schGbn" class="col-sm-1 control-label">결제수단</label>
						<div class="col-sm-2">
			                <jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="PAY_METD" />
								<jsp:param name="name" value="PAY_METD" />
								<jsp:param name="value" value="${obj.PAY_METD }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="전체" />
							</jsp:include>
						</div>
						
						<label for="schGbn" class="col-sm-1 control-label">상품선택</label>
						<div class="col-sm-3">
							<div class="input-group">								
								<input type="search" class="form-control" name="schTxt" id="schTxt" placeholder="상품을 선택해주세요" readonly
									<c:if test = '${obj.schTxt ne null && obj.schTxt ne "null" }'>value="${obj.schTxt }"</c:if>>
								<span class="input-group-btn">
									<button type="button" class="btn btn-default" onclick="productModal()">상품선택</button>
									<button type="button" class="btn btn-success" onclick="searchSelect()">검색</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</spform:form>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- 검색 박스 -->
	
	<!-- 정렬 박스 -->
	<div class="box box-default">
		<div class="box-body">
			<div class="box-body">
				<div class="form-group">
					<label class="col-sm-1 control-labe txt-right">정렬</label>
					<div class="col-sm-9">
						<button type="button" class="btn btn-sm btnSort" id="ordORDER_QTY" sortGubun="ORDER_QTY" sortOdr="asc" sortName="판매수량">판매수량▼▲</button>
						<button type="button" class="btn btn-sm btnSort" id="ordREAL_PRICE" sortGubun="REAL_PRICE" sortOdr="asc" sortName="판매가격">판매가격▼▲</button>
					</div>
				</div>				
			</div>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.정렬 박스 -->
	
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">기간별 매출 목록</h3>
			<div class="box-tools">				
				<button type="button" class="btn btn-success btn-sm" id="btnExcel">엑셀</button>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered">
				<colgroup>
				</colgroup>
				<thead>
					<tr>
						<th>순번</th>
                       	<th>상품코드</th>
                       	<th>상품바코드</th>
						<th>상품명</th>
						<th>과세구분</th>
						<th>제품단가</th>
						<th>판매가격</th>
						<th>판매수량</th>
						<th>소계</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${obj.list }" var="ent" varStatus="loop">
						<tr>
							<td> ${ ent.RNUM } </td>
	                        <td> ${ ent.PD_CODE } </td>
	                        <td> ${ ent.PD_BARCD } </td>
							<td>
								<a href="${contextPath }/adm/productMgr/edit/${ ent.PD_CODE }">
									<c:out value="${ ent.PD_NAME }" escapeXml="true"/>
								</a>
							</td>
							<td>
								<jsp:include page="${contextPath }/common/comCodName">
									<jsp:param name="COMM_CODE" value="TAX_GUBN" />
									<jsp:param name="COMD_CODE" value="${ent.TAX_GUBN}" />
									<jsp:param name="type" value="text" />
								</jsp:include>
							</td>
							<td align="right">
								<fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###"/>
							</td>
							<td align="right">
								<fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###"/>
							</td>
							<td>
								<fmt:formatNumber value="${ ent.ORDER_QTY }" pattern="#,###"/>
							</td>
							<td align="right">
								<fmt:formatNumber value="${ ent.REAL_PRICE * ent.ORDER_QTY }" pattern="#,###"/>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${obj.count eq 0}">
						<tr>
							<td colspan="9">조회된 내용이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>
	</div>
</section>

<!-- 상품 선택 팝업 -->
<div class="modal fade" id="pdModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" style="width:50vw;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="pdModalLabel">상품 검색 팝업</h4>
			</div>
			<div class="modal-body">				
				<!-- 검색조건 박스 -->
				<div class="box box-primary">
					<form class="form-horizontal" id="ajaxfrm" method="get" onsubmit="return false">
						<input type="hidden" name="sortGubun" id="sortGubun" />
						<input type="hidden" name="sortOdr" id="sortOdr" />
						<input type="hidden" name="PDDC_GUBN" value="PDDC_GUBN_01"/>
						<!-- box-header -->
						<div class="box-header with-border">
							<h3 class="box-title">검색 조건</h3>
						</div>
						<!-- box-body -->											
						<div class="box-body">
							<div class="form-group">
								<label for="schGbn" class="col-sm-2 control-label">검색어</label>
								<div class="col-sm-2">
									<select name="schGbn" class="form-control select2">
										<option value="PD_NAME" ${ param.schGbn eq 'PD_NAME' ? "selected='selected'":''}>상품명</option>
										<option value="PD_CODE" ${ param.schGbn eq 'PD_CODE' ? "selected='selected'":''}>코드</option>
										<option value="PD_BARCD" ${ param.schGbn eq 'PD_BARCD' ? "selected='selected'":''}>바코드</option>
									</select>
								</div>
								<div class="col-sm-7">
									<div class="input-group">
										<input type="search" class="form-control" name="schTxt" placeholder="검색어 입력" value="${param.schTxt }" required>
										<span class="input-group-btn">
											<button type="button" id="ajaxSearch" class="btn btn-success pull-right">검색</button>
										</span>
									</div>
								</div>
							</div>							
							
							<div class="form-group">
								<label for="SALE_CON" class="col-sm-2 control-label">판매상태</label>
								<div class="col-sm-2">
									<p class="form-control-static">
										<jsp:include page="${contextPath }/common/comCodForm">
											<jsp:param name="COMM_CODE" value="SALE_CON" />
											<jsp:param name="name" value="SALE_CON" />
											<jsp:param name="value" value="${obj.SALE_CON }" />
											<jsp:param name="type" value="select" />
											<jsp:param name="top" value="전체" />
										</jsp:include>
									</p>
								</div>													
							</div>
						</div>
					</form>
				</div>
				<div style="max-height:50vh; overflow-y:scroll;">
					<!--상품정보 테이블 -->
					<table class="table table-bordered" id="ajaxList">
						<colgroup>
							<col style="width: 60px;"/>
							<col style="width: 20%; text-aline: center;"/>
							<col style="width: 40%;"/>
							<col style="width: 20%;"/>
							<col style="width: 15%;"/>
						</colgroup>
						<thead>
							<tr>
								<th></th>
								<th>상품코드</th>
								<th>상품명</th>
								<th>상품가격</th>
								<th>판매상태</th>
							</tr>
						</thead>
						<tbody>
							<!-- append -->
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">				
				<button type="button" class="btn btn-sm btn-default" id="btnClose" data-dismiss="modal">닫기</button>				
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	/* Date picker */
	$('#datepickerStr').datepicker({
		autoclose: true,
		format: 'yyyy-mm-dd',
	});
	/* $('#datepickerStr').change(function(){
		searchSelect();
	}); */
		
	$('#datepickerEnd').datepicker({
		autoclose: true,
		format: 'yyyy-mm-dd',
	});
	/* $('#datepickerEnd').change(function(){
		searchSelect();
	}); */
	
	/* 정렬 */
	if ('${param.sortGubun}') {
		console.log('${param.sortGubun}')
		$('#ord${param.sortGubun}').attr("sortOdr", "${param.sortOdr eq 'desc' ? 'asc' : 'desc'}");
		$('#ord${param.sortGubun}').text( $('#ord${param.sortGubun}').attr("sortName") + " ${param.sortOdr eq 'desc' ? '△▼' : '▲▽'}");
		$("#sortGubun").val('${param.sortGubun}');
		$("#sortOdr").val('${param.sortOdr}');
	}
	
	$('.btnSort').click(function(){
		var frm=document.getElementById("productSalTotalMgrForm");
		var strSortGubun = $(this).attr("sortGubun");
		var strSortOdr = $(this).attr("sortOdr");
		
		$("#sortGubun").val(strSortGubun);
		$("#sortOdr").val(strSortOdr);
		
		frm.submit();
	});

	// 엑셀
    $("#btnExcel").click(function() {
    	var strAction = "${contextPath }/adm/productSalTotalMgr/excel";
    	var realAction = "${strActionUrl }";
    	
        $("#productSalTotalMgrForm").attr("action", strAction);
        $("#productSalTotalMgrForm").submit();
        
        //원래대로
        $("#productSalTotalMgrForm").attr("action", realAction);
    });
});
	
	/* 재검색 */
	function searchSelect(){
		var frm = document.getElementById("productSalTotalMgrForm");
		var search = document.getElementById("schTxt").value;
		//if (!search.trim()) return;				
		frm.submit();
	}

	/* 상품선택 팝업 */
	function productModal(){		
		$('#pdModal').modal('show');
	};
	
	/* 상품 팝업검색 */
	$("#ajaxSearch").click(function(){	
		$.ajax({
			type : "GET",		
			dataType : "json",
			url : "${contextPath}/adm/productSalTotalMgr/pdpop.json",
			data : $("#ajaxfrm").serialize(),    		
			success : function(data){
				console.log(data)
				// 상품추가팝업 Modal에 데이터 add
				var ajaxCnt = data.count;
				var ajaxList = data.list;
				var tbody = $("#ajaxList > tbody");
				tbody.empty();	//초기화
				
				if(ajaxCnt > 0){
						$.each(ajaxList, function(i, val){
							tbody.append($('<tr>')									
									.append($('<td>', {html : '<button class="btn btn-sm chkPdtId" name="chkPdtId" value="'+val.pd_CODE+'">선택</button>'}))
									.append($('<td>', {text : val.pd_CODE}))
									.append($('<td>', {text : val.pd_NAME}))
									.append($('<td>', {text : val.pd_PRICE}))
									.append($('<td>', {text : val.sale_CON_NM}))
								);
					});
				} else{
					tbody.append($('<tr>').append($('<td>', "조회된 내역이 없습니다.")));
				}
			},
			error : function(request, status, error) {
				alert("list search fail :: error code: " + request.status + "\n" + "error message: " + error + "\n");
			}
		});
	});

	$("#ajaxList").on("click", ".chkPdtId", function() {		
		var search = $(this).val();
		var frm=document.getElementById("productSalTotalMgrForm");	
		document.getElementById("schTxt").value = search;
		frm.submit();
		
		$('#btnClose').click();
	});
</script>
