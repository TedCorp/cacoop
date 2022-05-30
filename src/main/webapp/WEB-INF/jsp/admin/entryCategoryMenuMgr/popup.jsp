<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		카테고리 목록 팝업	
		<small>해당 그룹의 그룹핑할 상품을 선택해 주세요.</small>
		<button type="button" class="btn btn-primary pull-right" id="btnClose" onclick="javascript:fnClose()">닫기</button>
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
			<form class="form-horizontal" id="frm" method="get" action="${contextPath }/adm/entryCategoryMenuMgr/popup">
				<input type="hidden" name="sortGubun" id="sortGubun" />
				<input type="hidden" name="sortOdr" id="sortOdr" />
				<!-- 목록수 -->
				<input type="hidden" id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" />
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">검색어</label>
						<div class="col-sm-2">
							<select name="schGbn" class="form-control select2" style="width: 100%;">
								<option value="CAGO_NAME" ${ param.schGbn eq 'CAGO_NAME' ? "selected='selected'":''}>카테고리명</option>
								<option value="CAGO_ID" ${ param.schGbn eq 'CAGO_ID' ? "selected='selected'":''}>카테고리코드</option>
							</select>
						</div>				
						<div class="col-sm-4">
							<input name="schTxt" type="text" class="form-control" placeholder="검색어 입력" value="${param.schTxt }">
						</div>
						<div class="col-sm-1">
							<button type="submit" class="btn btn-success pull-right">검색</button>
						</div>						
					</div>
					
					<div class="form-group">
						<div class="col-sm-12">							
							<label for="inputEmail3" class="col-sm-8 control-label">목록수</label>
							<div class="col-sm-2">
				                <select name="cnt" id="cnt" class="form-control select2" style="width: 100%;" onchange="javascript:fn_order_by('');">
									<option value="10" ${obj.pagerMaxPageItems == '10' ? 'selected=selected':''}>10</option>
									<option value="20" ${obj.pagerMaxPageItems == '20' ? 'selected=selected':''}>20</option>
									<option value="30" ${obj.pagerMaxPageItems == '30' ? 'selected=selected':''}>30</option>
									<option value="50" ${obj.pagerMaxPageItems == '50' ? 'selected=selected':''}>50</option>
									<option value="100" ${obj.pagerMaxPageItems == '100' ? 'selected=selected':''}>100</option>
								</select>
							</div>		
							<div class="col-sm-2">
								<button type="button" class="btn btn-primary pull-right" id="btnAdd" onclick="javascript:fnCheckPdList()">선택추가</button>
							</div>				
						</div>
					</div>
				</div>
				<!-- /.row -->
			</form>
		</div>
		<!-- /.box-body -->
	</div>
	<div class="box">
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th style = "width:8%"><input id="allCheck" name="toggleChk" type="checkbox" onclick="javascript:fnCheckAll()"></th>
						<th style = "width:10%">No.</th>
						<th style = "width:35%">카테고리코드</th>
						<th style = "width:47%">카테고리명</th>
						<!-- <th>가격</th> -->
					</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(obj.list) == 0}">
					<tr>
						<td colspan="6">조회된 메뉴가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td>
                        	<input name="chkPdtId" value="${list.CAGO_ID },${list.CAGO_NAME },${list.CAGO_ID }" type="checkbox"/>
                        	<input name="pdtIdYn" value="N" type="hidden"/>
                        </td>
						<td>${list.RNUM }</td>
						<td><a href="#" onclick="fn_value('${list.CAGO_ID }','${list.CAGO_NAME }');">${list.CAGO_ID }</a></td>
						<td>${list.CAGO_NAME }</td>
						<%-- <td>${list.USE_YN }</td> --%>
						<%-- <td><fmt:formatNumber value="${ list.PD_PRICE }" pattern="#,###"/></td> --%>
						<%-- <td><a href="#" onclick="fn_value('${list.MENU_CD }','${list.MENU_NAME }');">${list.MENU_NAME }</a></td>
						<td>${list.MENU_URL }</td>
						<td>${list.OUTPT_FG }</td>
						<td>${list.SORT_ORDR }</td> --%>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
				<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>
	</div>
	
</section>

<script type="text/javascript">

// 부모창에 선택 카테고리 정보 전달
function fn_value(CAGO_ID,CAGO_NAME){
	if(!opener.fn_pd_popup_return(CAGO_ID,CAGO_NAME))
		alert("현재 그룹에 카테고리( "+CAGO_ID+" | "+CAGO_NAME+" )이 포함되어 있습니다.");
	/* window.close(); */
	
}

// 목록수 조회
function fn_order_by(str){	
	var frm=document.getElementById("frm");
	
	frm.pagerMaxPageItems.value=$("#cnt").val();
	console.log(frm.pagerMaxPageItems.value);
		
	frm.submit();
}

// 체크박스 전체선택/해제
function fnCheckAll(){	
	if($("#allCheck").prop("checked")) {
		$("input[type=checkbox]").prop("checked",true);
	} else {
		$("input[type=checkbox]").prop("checked",false);
	}
}

//선택상품 멀티추가
function fnCheckPdList(){
	// 체크항목
	var checkboxValues =[];
	$("input:checkbox[name=chkPdtId]:checked").each(function(){
		checkboxValues.push($(this).val());
	});
	
	// 상품선택확인
	if(checkboxValues==''||checkboxValues==null){
		checkboxValues.push("");		
		alert("추가할 상품을 체크해주세요.");
		return false;
	}
	
	//부모창 함수호출
	var msg = opener.fn_pd_multi_return(checkboxValues)
	if(msg != "")
		alert("중복된 카테고리입니다.\n" + msg);
	
	//체크박스 선택 초기화
	$("input[type=checkbox]").prop("checked",false);
}

// 팝업창 닫기
function fnClose(){
	window.close();
}
</script>