<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<style type="text/css">
table.table>thead>tr>th {
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

<c:choose>
	<c:when test="${empty obj.COM_NM_ORDER or obj.COM_NM_ORDER =='desc' }"><c:set var="COM_NM_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="COM_NM_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${empty obj.MEMB_NM_ORDER or  obj.MEMB_NM_ORDER =='desc' }"><c:set var="MEMB_NM_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="MEMB_NM_ORDER" value="desc" /></c:otherwise>
</c:choose>

<c:set var="strActionUrl" value="${contextPath }/adm/memberSalMnthMgr" />
<c:set var="strMethod" value="get" />

<section class="content-header">
	<h1>
		회원-월별매출현황
		<small>회원매출관리</small>
	</h1>
</section>

<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">회원검색 조건</h3>

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
			<spform:form class="form-horizontal" name="memberSalCntDateMgrForm2" id="memberSalCntDateMgrForm2" method="${strMethod }" action="${strActionUrl }">
				<div class="box-body">
					<div class="form-group">
						<!--  -->
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
							<select name="schGbn" class="form-control select2">
								<option value="MEMB_NAME" ${ param.schGbn eq 'MEMB_NAME' ? "selected='selected'":''}>고객명</option>
								<option value="COM_NAME" ${ param.schGbn eq 'COM_NAME' ? "selected='selected'":''}>사업사상호</option>
								<option value="COM_BUNB" ${ param.schGbn eq 'COM_BUNB' ? "selected='selected'":''}>사업사번호</option>
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
						<label for="PAY_METD" class="col-sm-1 control-label">결제방식</label>
						<div class="col-sm-2">
							<select name="PAY_METD" class="form-control select2">
								<option value="" ${ param.PAY_METD eq '' ? "selected='selected'":''}>전체</option>
								<option value="SC0040" ${ param.PAY_METD eq 'SC0040' ? "selected='selected'":''}>무통장입금</option>
								<option value="SC0010" ${ param.PAY_METD eq 'SC0010' ? "selected='selected'":''}>신용카드</option>
							</select>
						</div>
						<label for="datepickerStr" class="col-sm-1 control-label">기간별 조회</label>
						<div class="col-sm-2">
							<div class="input-group bootstrap-datepicker datepicker">
								<input type="text" class="form-control pull-left" name="datepickerStr" id="datepickerStr" value="${obj.datepickerStr }" readonly="readonly">
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
				<button type="button" class="btn btn-success btn-sm pull-right" id="btnExcel">엑셀</button>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
			<spform:form class="form-horizontal" name="sortingForm" id="sortingForm" method="${strMethod }" action="${strActionUrl }">
				<input type="hidden" id="MEMB_ORD_GUBUN" name="MEMB_ORD_GUBUN" value="${obj.MEMB_ORD_GUBUN }" /><!-- 주문일 정렬 -->
				<input type="hidden" id="MEMB_NM_ORDER" name="MEMB_NM_ORDER" value="${MEMB_NM_ORDER }" /><!-- 주문자명 정렬 -->
				<input type="hidden" id="COM_NM_ORDER" name="COM_NM_ORDER" value="${COM_NM_ORDER }" /><!-- 주문자아이디 정렬 -->
				<!-- 검색조건 -->
				<input type="hidden" name="schGbn" value="${param.schGbn }" />
				<input type="hidden" name="schTxt" value="${param.schTxt }" />
				<input type="hidden" name="PAY_METD" value="${ param.PAY_METD }" />
				<input type="hidden" name="datepickerStr" value="${obj.datepickerStr }" />
				<input type="hidden" name="MEMB_GUBN" value="${ param.MEMB_GUBN }" />
				<input type="hidden" name="TAXCAL_YN" value="${ param.TAXCAL_YN }" />
			</spform:form>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>고객아이디</th>
						<th>고객이름</th>
						<th>사업자상호</th>
						<th>사업자번호</th>
						<th>1일</th>
						<th>2일</th>
						<th>3일</th>
						<th>4일</th>
						<th>5일</th>
						<th>6일</th>
						<th>7일</th>
						<th>8일</th>
						<th>9일</th>
						<th>10일</th>
						<th>11일</th>
						<th>12일</th>
						<th>13일</th>
						<th>14일</th>
						<th>15일</th>
						<th>16일</th>
						<th>17일</th>
						<th>18일</th>
						<th>19일</th>
						<th>20일</th>
						<th>21일</th>
						<th>22일</th>
						<th>23일</th>
						<th>24일</th>
						<th>25일</th>
						<th>26일</th>
						<th>27일</th>
						<th>28일</th>
						<c:if test="${dateCnt >= 29 }">
						<th>29일</th>
						</c:if>
						<c:if test="${dateCnt >= 30 }">
						<th>30일</th>
						</c:if>
						<c:if test="${dateCnt >= 31 }">
						<th>31일</th>
						</c:if>
											
					</tr> 
				</thead>
				<tbody>
					<c:forEach items="${obj.list }" var="ent" varStatus="loop">
					<tr>
						<td>${ent.MEMB_ID}</td>
						<td>${ent.MEMB_NAME}</td>
						<td>${ent.COM_NAME}</td>
						<td>${ent.COM_BUNB}</td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY1}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY2}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY3}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY4}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY5}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY6}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY7}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY8}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY9}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY10}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY11}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY12}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY13}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY14}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY15}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY16}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY17}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY18}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY19}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY20}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY21}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY22}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY23}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY24}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY25}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY26}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY27}"/></td>
						<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY28}"/></td>
						<c:if test="${dateCnt >= 29 }">
							<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY29}"/></td>
						</c:if>
						<c:if test="${dateCnt >= 30 }">
							<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY30}"/></td>
						</c:if>
						<c:if test="${dateCnt >= 31 }">
							<td style="text-align:right;"><fmt:formatNumber value="${ent.DAY31}"/></td>
						</c:if>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(obj.list) eq 0}">
					<tr>
						<td colspan="40" style="text-align:center">조회된 내용이 없습니다.</td>
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

<script type="text/javascript">
$(function() {
	//Date picker
 	$('#datepickerStr').datepicker({
		format: "yyyymm",
		minViewMode: 1
	}); 
	
	// 엑셀
    $("#btnExcel").click(function() {    	
    	var strAction = "${contextPath }/adm/memberSalMnthMgr/excelDown";
    	var realAction =  "${strActionUrl }";
    	
        $("#memberSalCntDateMgrForm2").attr("action", strAction);
        $("#memberSalCntDateMgrForm2").submit();
        
        //원래대로
        $("#memberSalCntDateMgrForm2").attr("action",realAction);        
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
