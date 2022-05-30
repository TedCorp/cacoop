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

<section class="content-header">
	<h1>
		상품 선택	
		<small>해당 상품을 선택해 주세요.</small>
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
			<form class="form-horizontal" id="frm" method="get" action="${contextPath }/adm/productMgr/${type}/${supr_id}">
				<input type="hidden" name="sortGubun" id="sortGubun" />
				<input type="hidden" name="sortOdr" id="sortOdr" />
				<!-- 목록수 -->
				<input type="hidden" id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" />
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">검색어</label>
						<div class="col-sm-2">
							<select name="schGbn" class="form-control select2" style="width: 100%;">
								<option value="PD_NAME" ${ param.schGbn eq 'PD_NAME' ? "selected='selected'":''}>상품명</option>
								<option value="PD_CODE" ${ param.schGbn eq 'PD_CODE' ? "selected='selected'":''}>상품코드</option>
							</select>
						</div>						
						<label for="inputEmail3" class="col-sm-2 control-label">판매상태</label>
						<div class="col-sm-2">
							<jsp:include page="${contextPath}/common/comCodForm">
								<jsp:param name="COMM_CODE" value="SALE_CON" />
								<jsp:param name="name" value="SALE_CON" />
								<jsp:param name="value" value="${obj.SALE_CON }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
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
							<c:if test='${type eq "getExtraPrd" }'>
								<div class="col-sm-2">
									<button type="button" class="btn btn-primary pull-right" id="btnAdd" onclick="addExtraPrd()">선택상품추가</button>
								</div>			
							</c:if>
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
				<colgroup>
					<col style="with:10px" />
					<col />
					<col style="with:200px" />
					<col />
					<col />
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<c:if test='${type eq "getExtraPrd" }'>
							<th><input id="allCheck" name="toggleChk" type="checkbox" onclick="javascript:fnCheckAll()"></th>
						</c:if>
						<th>번호</th>
						<th>코드</th>
						<th>상품명</th>
						<th>가격</th>
					</tr>
				</thead>
				<tbody>
				
				
				<c:if test='${type ne "searchPop" }'>
					<c:if test="${fn:length(obj.list) == 0}">
						<tr><td colspan="6">조회된 메뉴가 없습니다.</td></tr>
					</c:if>
					<c:forEach items="${obj.list }" var="list" varStatus="loop">
						<tr>
							<!-- 추가상품 팝업시 체크박스 -->
							<c:if test='${type eq "getExtraPrd" }'>
								<td><input name="chkPdtId" value="${list.PD_CODE }" type="checkbox"/></td> 
							</c:if>
							<td>${list.RNUM }</td>
							<!-- 다른상품 옵션 목록 -->
							<c:if test='${type eq "getOptionPop" }'>
								<td>${list.PD_CODE }</td>
								<td><a href="#" onclick="selectOption('${list.PD_CODE }')">${list.PD_NAME }</a></td>
								<td><fmt:formatNumber value="${ list.PD_PRICE }" pattern="#,###"/></td>
							</c:if>
							<!-- 추가상품 팝업시 목록 -->
							<c:if test='${type eq "getExtraPrd" }'>
								<td><a href="#" onclick="selectPrd('${list.PD_CODE }')">${list.PD_CODE }</a></td>
								<td>${list.PD_NAME }</td>
								<td><fmt:formatNumber value="${ list.PD_PRICE }" pattern="#,###"/></td>
							</c:if>
						</tr>
					</c:forEach>
				</c:if>
				
				
				<c:if test='${type eq "searchPop" }'>
					<c:if test="${fn:length(obj.list) == 0}">
						<tr><td colspan="6">조회된 메뉴가 없습니다.</td></tr>
					</c:if>
					<c:forEach items="${obj.list }" var="list" varStatus="count"> 
						<tr>
							<!-- 상품옵션검색(관리코드) 목록 -->
							<td>${list.RNUM }</td>
							<td><a href="javascript:selectCode('${list.PD_CODE}','${list.INVEN_QTY}','${list.PD_PRICE}')">${list.PD_CODE }</a></td>
							<td>${list.PD_NAME }</td>
							<td><fmt:formatNumber value="${ list.PD_PRICE }" pattern="#,###"/>
							</td>
						</tr>
					 </c:forEach> 
				</c:if>
				</tbody>
			</table>
		</div>
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
				<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>
	</div>
	


<script type="text/javascript">

// 상품 그루핑 중복조회_상품개별추가
function fn_value(PD_CODE,PD_NAME,PD_BARCD){
	
	$.ajax({
	    url: "${contextPath}/adm/eventMgr/grpPdChk",
	    type: 'post',
	    data: 'PD_CODE='+ PD_CODE,
	    success: function(data){                               
	    	 if(data=="success"){
	    		alert("이미 그룹핑된 상품입니다.")
	    		return;
	    	 }else{
	    		opener.fn_pd_popup_return(PD_CODE,PD_NAME,PD_BARCD);
	    		window.close();
	    	 }
	    },
	    error: function(e){
	       alert("에러 :: 관리자에게 문의하세요.");
	    }
	});
} 

// 목록수 조회
function fn_order_by(str){	
	var frm=document.getElementById("frm");
	
	frm.pagerMaxPageItems.value=$("#cnt").val();
	console.log(frm.pagerMaxPageItems.value);
		
	frm.submit();
}


// 팝업창 닫기
function fnClose(){
	window.close();
}

//관리코드 상품옵션
function selectCode(pdCode,lnvenQty,pdPrice){
	console.log(pdCode,lnvenQty,pdPrice);
	opener.selectCodeParent(pdCode,lnvenQty,pdPrice);
	window.close();
}

//추가상품
function selectOption(code){
	opener.getOption(code);
	window.close();
}
//추가상품 
function selectPrd(code){
	opener.getExtraPrd(code);
	window.close();
}
function addExtraPrd(){
	var checkedList = $('input[name="chkPdtId"]:checked');
	var prdlist = "";
	for(var i =0;i<checkedList.length;i++){
		if(i==0){
            prdlist += checkedList[i].value;
        }else{
            prdlist += ','+checkedList[i].value;
        }
	}
	opener.getExtraPrd(prdlist);
	window.close();
}

</script>
</section>

