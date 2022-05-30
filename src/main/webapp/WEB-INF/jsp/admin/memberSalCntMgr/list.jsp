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
<c:choose>
	<c:when test="${empty obj.MEMB_NM_ORDER or  obj.MEMB_NM_ORDER eq'desc' }"><c:set var="MEMB_NM_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="MEMB_NM_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${empty obj.COM_NM_ORDER or  obj.COM_NM_ORDER eq'desc' }"><c:set var="COM_NM_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="COM_NM_ORDER" value="desc" /></c:otherwise>
</c:choose>

<c:set var="strActionUrl" value="${contextPath }/adm/memberSalCntMgr" />
<c:set var="strMethod" value="get" />

<style type="text/css">
table.table>thead>tr>th {
    text-align: center;
    vertical-align: middle;
}
</style>

<section class="content-header">
	<h1>
		회원별 매출관리
		<small>회원매출관리</small>
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
		<!-- /.box-header -->
		
		<div class="box-body">
			<spform:form class="form-horizontal" name="memberSalCntMgrForm" id="memberSalCntMgrForm" method="${strMethod }" action="${strActionUrl }">
				<div class="box-body">
					<div class="form-group">						
						<label for="MEMB_GUBN" class="col-sm-1 control-label">회원구분</label>
						<div class="col-sm-2">
							<select name="MEMB_GUBN" class="form-control select2">
								<option value="">전체</option>
								<option value="MEMB_GUBN_01" ${ param.MEMB_GUBN eq 'MEMB_GUBN_01' ? "selected='selected'":''}>일반회원</option>
								<option value="MEMB_GUBN_02" ${ param.MEMB_GUBN eq 'MEMB_GUBN_02' ? "selected='selected'":''}>사업자회원</option>
							</select>
						</div>
						
						<label for="schGbn" class="col-sm-1 control-label">검색어</label>
						<div class="col-sm-2">
							<select name="schGbn" class="form-control select2" style="width: 100%;">
								<option value="MEMB_NAME" ${ param.schGbn eq 'MEMB_NAME' ? "selected='selected'":''}>회원명</option>
								<option value="MEMB_ID" ${ param.schGbn eq 'MEMB_ID' ? "selected='selected'":''}>회원ID</option>
								<option value="COM_NAME" ${ param.schGbn eq 'COM_NAME' ? "selected='selected'":''}>사업자상호</option>
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
					
					<div class="form-group">						
						<label for="PAY_GUBN" class="col-sm-1 control-label">결제방법</label>
						<div class="col-sm-2">
							<select name="PAY_GUBN" class="form-control select2">
								<option value="">전체</option>
								<option value="SC0010" ${ param.PAY_GUBN eq 'SC0010' ? "selected='selected'":''}>신용카드</option>
								<option value="SC0040" ${ param.PAY_GUBN eq 'SC0040' ? "selected='selected'":''}>무통장입금</option>
							</select>
						</div>
						
						<label for="datepickerStr" class="col-sm-1 control-label">기간설정</label>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">
								<input type="text" class="form-control pull-left" name="datepickerStr" id="datepickerStr" value="${obj.datepickerStr }" readonly="readonly">
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
						</div>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">
								<input type="text" class="form-control pull-left" name="datepickerEnd" id="datepickerEnd" value="${obj.datepickerEnd }" readonly="readonly">
								<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
						</div>
						
						<label for="TAXCAL_YN" class="col-sm-1 control-label">계산서발행구분</label>
						<div class="col-sm-2">
							<select name="TAXCAL_YN" class="form-control select2">
								<option value="">전체</option>
								<option value="Y" ${ param.TAXCAL_YN eq 'Y' ? "selected='selected'":''}>발행</option>
								<option value="N" ${ param.TAXCAL_YN eq 'N' ? "selected='selected'":''}>미발행</option>								
							</select>
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
					<label class="col-sm-1 control-label">정렬</label>
					<div class="col-sm-9">
						<button type="button" class="btn btn-sm" onclick="javascript:fn_order_by('MEMB_NM_ORDER');">성명▼▲</button>
						<button type="button" class="btn btn-sm" onclick="javascript:fn_order_by('COM_NM_ORDER');">사업자상호▼▲</button>
					</div>				
				</div>
			</div>
		</div>
	</div>
	<!-- /.정렬 박스 -->
	
	
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">회원 매출 집계 목록</h3>
			<div class="box-tools">				
				<button type="button" class="btn btn-sm btn-success pull-right" id="btnExcel">엑셀</button>
			</div>
		</div>
		<!-- /.box-header -->
		
		<div class="box-body">
			<spform:form class="form-horizontal" name="sortingForm" id="sortingForm" method="${strMethod }" action="${strActionUrl }">
				<input type="hidden" id="MEMB_ORD_GUBUN" name="MEMB_ORD_GUBUN" value="${obj.MEMB_ORD_GUBUN }" /><!-- 주문일 정렬 -->
				<input type="hidden" id="MEMB_NM_ORDER" name="MEMB_NM_ORDER" value="${MEMB_NM_ORDER }" /><!-- 주문자명 정렬 -->
				<input type="hidden" id="COM_NM_ORDER" name="COM_NM_ORDER" value="${COM_NM_ORDER }" /><!-- 주문자아이디 정렬 -->
				<!-- 검색조건 유지 -->
				<input type="hidden" name="schGbn" value="${param.schGbn }" />
				<input type="hidden" name="schTxt" value="${param.schTxt }" />
				<input type="hidden" name="PAY_GUBN" value="${ param.PAY_GUBN }" />
				<input type="hidden" name="datepickerStr" value="${obj.datepickerStr }" />
				<input type="hidden" name="datepickerEnd" value="${obj.datepickerEnd }" />
				<input type="hidden" name="MEMB_GUBN" value="${ param.MEMB_GUBN }" />
				<input type="hidden" name="TAXCAL_YN" value="${ param.TAXCAL_YN }" />
			</spform:form>
			
			<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th rowspan="3">번호</th>
							<th rowspan="3">회원구분</th>
							<th rowspan="3">아이디</th>
							<th rowspan="3">고객명<br>(대표자명)</th>
							<th rowspan="3">사업자상호</th>
							<th rowspan="3">사업자번호</th>
							<th rowspan="2" colspan="4">주문</th>
							<th rowspan="2" colspan="4">반품</th>							
							<!-- 확정금액 -->
							<th rowspan="3">총<br>매출금액</th>							
							<th colspan="4">결제구분</th>
							<th rowspan="3">사업자 주소</th>
							<th rowspan="3">사업자 이메일</th>
						</tr>
						<tr>
							<th colspan="2">카드</th>
							<th colspan="2">무통장</th>
						</tr>
						<tr>
							<!-- 주문금액 -->
							<th>매출</th>
							<th>배송비</th>
							<th>과세</th>
							<th>면세</th>
							<!-- 반품금액 -->
							<th>매출</th>
							<th>배송비</th>
							<th>과세</th>
							<th>면세</th>
							<!-- 확정금액 -->
							<th>과세</th>
							<th>면세</th>
							<th>과세</th>
							<th>면세</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${obj.list }" var="ent" varStatus="loop">
						<tr>
							<td>${ent.RNUM }</td>
							<td>${ent.MEMB_GUBN_NM}</td>
							<td>${ent.MEMB_ID}</td>
							<td>${ent.MEMB_NAME}</td>
							<td>${ent.COM_NAME}</td>
							<td>${ent.COM_BUNB}</td>
							<!-- 누적매출 -->
							<td style="text-align:right;">
								<fmt:formatNumber value="${ent.ORDER_AMT_SUM }"/><!-- 주문금액 -->
							</td>
							<td style="text-align:right;">
								<fmt:formatNumber value="${ent.ORDER_DLVY_SUM}"/><!-- 주문배송비 -->
							</td>
							<td style="text-align:right;">
								<fmt:formatNumber value="${ent.ORDER_TAX_GUBN_01_SUM}"/><!-- 주문과세매출 -->
							</td>
							<td style="text-align:right;">
								<fmt:formatNumber value="${ent.ORDER_TAX_GUBN_02_SUM }"/><!-- 주문면세매출 -->
							</td>
							<!-- 반송매출 -->
							<td style="text-align:right;">
								<fmt:formatNumber value="${ent.RETURN_AMT_SUM}"/><!-- 반품금액 -->
							</td>
							<td style="text-align:right;">
								<fmt:formatNumber value="${ent.RETURN_DLVY_SUM}"/><!-- 반품배송비 -->
							</td>
							<td style="text-align:right;">
								<fmt:formatNumber value="${ent.RETURN_TAX_GUBN_01_SUM}"/><!-- 반품과세매출 -->
							</td>
							<td style="text-align:right;">
								<fmt:formatNumber value="${ent.RETURN_TAX_GUBN_02_SUM}"/><!-- 반품면세매출 -->
							</td>
							<!-- 확정매출 -->
							<td style="text-align:right;">
								<fmt:formatNumber value="${ent.TOTAL_PROD_SUM + ent.TOTAL_DLVY_SUM}"/><!-- 총매출금액 (주문금액 + 반품금액) -->
							</td>							
							<td style="text-align:right;">
								<fmt:formatNumber value="${ent.PAY_METD_01_TAX_GUBN_01_SUM }"/><!-- 카드과세 (주문금액 + 반품금액) -->
							</td>
							<td style="text-align:right;">
								<fmt:formatNumber value="${ent.PAY_METD_01_TAX_GUBN_02_SUM }"/><!-- 카드면세 (주문금액 + 반품금액) -->
							</td>
							<td style="text-align:right;">
								<fmt:formatNumber value="${ent.PAY_METD_02_TAX_GUBN_01_SUM }"/><!-- 무통장과세 (주문금액 + 반품금액) -->
							</td>
							<td style="text-align:right;">
								<fmt:formatNumber value="${ent.PAY_METD_02_TAX_GUBN_02_SUM }"/><!-- 무통장면세 (주문금액 + 반품금액) -->
							</td>
							<td>${ent.COM_BADR }</td>
							<td>${ent.MEMB_MAIL}</td>
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
		</div>
		
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>
	</div>
</section>

<form id="excelFrm" method="get" action="${contextPath }/adm/memberSalCntMgr/excelDown"></form>

<script type="text/javascript">
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
	
	// 엑셀
    $("#btnExcel").click(function() {    	
    	var strAction = "${contextPath }/adm/memberSalCntMgr/excelDown";
    	var realAction =  "${strActionUrl }";
    	
        $("#memberSalCntMgrForm").attr("action", strAction);
        $("#memberSalCntMgrForm").submit();
        
        //원래대로
        $("#memberSalCntMgrForm").attr("action",realAction);        
    });
});

//정렬 주문일 & 주문자명 클릭시 , 목록수 변경시
function fn_order_by(str){	
	var frm=document.getElementById("sortingForm");
	
	if(str != ""){
		frm.MEMB_ORD_GUBUN.value=str;
	}
	frm.submit();
}
</script>
