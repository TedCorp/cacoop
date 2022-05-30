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
.content .box .paging_new li.next .ic{background:url("${contextPath}/resources/ resources2/images/icon_page_next.png") no-repeat 50% 50%} 
</style>
<c:set var="strActionUrl" value="${contextPath }/adm/memberMgr" />
<c:set var="strMethod" value="get" />

<c:choose>
	<c:when test="${empty obj.DATE_ORDER or obj.DATE_ORDER =='desc' }"><c:set var="DATE_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="DATE_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${empty obj.MEMB_NM_ORDER or  obj.MEMB_NM_ORDER =='desc' }"><c:set var="MEMB_NM_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="MEMB_NM_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${empty obj.MEMB_ID_ORDER or  obj.MEMB_ID_ORDER =='desc' }"><c:set var="MEMB_ID_ORDER" value="asc" /></c:when>
	<c:otherwise><c:set var="MEMB_ID_ORDER" value="desc" /></c:otherwise>
</c:choose>


<section class="content-header">
	<h1>
		회원 관리	
		<small>회원 목록</small>
	</h1>
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
			<spform:form name="sortingForm" id="sortingForm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
				<input type="hidden" id="MEMB_ORD_GUBUN" name="MEMB_ORD_GUBUN" value="${obj.MEMB_ORD_GUBUN }" />	<!-- 회원구분 정렬 -->
				<input type="hidden" id="DATE_ORDER" name="DATE_ORDER" value="${DATE_ORDER }" />									<!-- 주문일 정렬 -->
				<input type="hidden" id="MEMB_NM_ORDER" name="MEMB_NM_ORDER" value="${MEMB_NM_ORDER }" />				<!-- 주문자명 정렬 -->
				<input type="hidden" id="MEMB_ID_ORDER" name="MEMB_ID_ORDER" value="${MEMB_ID_ORDER }" />					<!-- 주문자아이디 정렬 -->
				
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">검색어</label>
						<div class="col-sm-2">
							<select name="schGbn" class="form-control select2">
								<option value="MEMB_NAME" ${ param.schGbn eq 'MEMB_NAME' ? "selected='selected'":''}>회원명</option>
								<option value="COM_NAME" ${ param.schGbn eq 'COM_NAME' ? "selected='selected'":''}>사업자상호</option>
								<option value="MEMB_ID" ${ param.schGbn eq 'MEMB_ID' ? "selected='selected'":''}>회원ID</option>
							</select>
						</div>
						<div class="col-sm-6">
							<div class="input-group">
								<input type="search" class="form-control" name="schTxt" placeholder="검색어 입력" value="${param.schTxt }">
								<span class="input-group-btn">
									<button type="submit" class="btn btn-success pull-right">검색</button>
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
					<label class="col-sm-1 control-label txt-right">정렬</label>
					<div class="col-sm-9">
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('MEMB_NM_ORDER');">성명▼▲</button>
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('MEMB_ID_ORDER');">아이디▼▲</button>
						<button type="button" class="btn btn-sm btnSort" onclick="javascript:fn_order_by('DATE_ORDER');">가입일▼▲</button>
					</div>
				</div>
			</div>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.정렬 박스 -->
	
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">회원 목록 (<font color="green"><b>${totalCnt}</b></font>)</h3>
			<div class="box-tools">
				<button type="button" class="btn btn-success btn-sm pull-right left-5" id="btnExcel">엑셀</button>
				<a href="${contextPath}/adm/memberMgr/new?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }${link}" class="btn btn-sm btn-primary pull-right">신규등록</a>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
			<table class="table table-bordered">
				<colgroup>
					<col />
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th class="txt-middle">번호</th>
						<th class="txt-middle">회원구분</th>
						<th class="txt-middle">아이디</th>
						<th class="txt-middle">사업자상호</th>
						<th class="txt-middle">성명</th>
						<th class="txt-middle">가입일</th>
						<th class="txt-middle">회원상태</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${obj.list }" var="ent" varStatus="loop">
					<tr>
						<td class="txt-middle">${ent.RNUM }</td>
						<td class="txt-middle">${ent.MEMB_GUBN_NM }</td>
						<td class="txt-middle">
							<a href="${contextPath}/adm/memberMgr/edit?MEMB_ID=${ent.MEMB_ID }&pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }${link}"><c:out value="${ent.MEMB_ID }" escapeXml="true"/></a>
						</td> 
						<td class="txt-middle">${ent.COM_NAME }</td>
						<td class="txt-middle">${ent.MEMB_NAME }</td>
						<td class="txt-middle">${ent.REG_DTM }</td>
						<td class="txt-middle">
							<c:if test="${ent.STOP_YN eq 'N' }"><small class="label label-default">활동</small></c:if>
							<c:if test="${ent.STOP_YN eq 'Y' }"><small class="label label-danger">일시중지</small></c:if>														
						</td>
					</tr>
				</c:forEach>
				<c:if test="${obj.count eq 0}">
					<tr>
						<td colspan="6">조회된 내용이 없습니다.</td>
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
<form id="excelFrm" method="get" action="${contextPath }/adm/memberMgr/excelDown">

</form>
<script type="text/javascript">
$(function() {
	//if($("#schGbn").val());

	// 엑셀
    $("#btnExcel").click(function() {    	
    	var checkboxValues = [];
    	
		/*	//나중에 원하는 회원목록 엑셀다운..? 
		$("input:checkbox[name=chkOrdList]:checked").each(function(){
			checkboxValues.push($(this).val());
		});
		if(checkboxValues==''||checkboxValues==null){
			checkboxValues.push("");			
			alert("엑셀을 출력할 주문을 선택하세요.");
			return false;
		} 
		*/
		
        $("#excelFrm").submit();
    });
});

//정렬 주문일 & 주문자명 클릭시 , 목록수 변경시
function fn_order_by(str){
	
	var frm=document.getElementById("sortingForm");
	if(str != ""){
		console.log(str);
		frm.MEMB_ORD_GUBUN.value=str;
	}
	frm.submit();
}

</script>
