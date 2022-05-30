<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<style>
.goodsImg {
    width: auto; height: auto;
    max-width: 50px;
    max-height: 50px;
    min-width: 25px;
    min-height: 25px;
}

.content .box-default .paging_new{margin-top:30px}
.content .box-default .paging_new ul{display:flex;flex-direction:row;justify-content:center;align-items:center}
.content .box-default .paging_new li{width:30px;height:30px;}
.content .box-default .paging_new li a{display:block;width:30px;line-height:30px;font-size:14px;font-weight:500;color:#333;text-align:center;}
.content .box-default .paging_new li i{display:block;width:30px;height:30px}
.content .box-default .paging_new li.on a{background:#111;color:#fff;}
.content .box-default .paging_new li.start .ic{background:url("${contextPath}/resources/resources2/images/icon_page_start.png") no-repeat 50% 50%}
.content .box-default .paging_new li.end .ic{background:url("${contextPath}/resources/resources2/images/icon_page_end.png") no-repeat 50% 50%}
.content .box-default .paging_new li.prev .ic{background:url("${contextPath}/resources/resources2/images/icon_page_prev.png") no-repeat 50% 50%}
.content .box-default .paging_new li.next .ic{background:url("${contextPath}/resources/resources2/images/icon_page_next.png") no-repeat 50% 50%}
</style>

<section class="content-header">
	<h1>상품관리
		<small>상품 목록</small>
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
			<form class="form-horizontal" id="frm" >
				<input type="hidden" name="sortGubun" id="sortGubun" />
				<input type="hidden" name="sortOdr" id="sortOdr" />
				<input type="hidden" name="schTxt_bef" value="${ obj.schTxt_bef }" />
				<input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum }" /> 
				<input type="hidden" name="pagerMaxPageItems" id="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" />	<!-- 목록수 -->
				
				<div class="box-body">
					<div class="form-group">
						<label class="col-sm-1 control-label">검색어</label>
						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2">
								<option value="PD_NAME" ${obj.schGbn eq 'PD_NAME' ? 'selected=selected':''}>상품명</option>
								<option value="PD_CODE" ${obj.schGbn eq 'PD_CODE' ? 'selected=selected':''}>상품코드</option>
								<option value="PD_BARCD" ${ obj.schGbn eq 'PD_BARCD' ? "selected='selected'":''}>상품바코드</option>
							</select>
						</div>
						<div class="col-sm-7">
							<div class="input-group input-group">
								<input type="search" class="form-control" name="schTxt" style="ime-mode:active;" placeholder="검색어 입력" value="${param.schTxt }" onclick="javascript:cleanResearch()">
								<span class="input-group-btn">
									<button type="submit" class="btn btn-success pull-right">검색</button>
								</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-3"></div>
						<div class="col-sm-7">
							<input type = "text" class="form-control" style="ime-mode:active;" name="reSearch" id ="reSearch"  placeholder="결과내 재검색" value="${param.reSearch }">
						</div>
					</div>
					
					<div class="form-group">
						<%-- <label for="ONDY_GUBN" class="col-sm-1 control-label">일배상품</label>
						<div class="col-sm-2">
							<jsp:include page="${contextPath}/common/comCodForm">
								<jsp:param name="COMM_CODE" value="ONDY_GUBN" />
								<jsp:param name="name" value="ONDY_GUBN" />
								<jsp:param name="value" value="${obj.ONDY_GUBN }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="전체" />
							</jsp:include>
						</div> --%>
						<label for="salecon_sch" class="col-sm-1 control-label">판매상태</label>
						<div class="col-sm-2">
							<jsp:include page="${contextPath}/common/comCodForm">
								<jsp:param name="COMM_CODE" value="SALE_CON" />
								<jsp:param name="name" value="salecon_sch" />
								<jsp:param name="value" value="${obj.salecon_sch }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="전체" />
							</jsp:include>
						</div>
					</div>
				</div>	
				<!-- /.row -->
			</form>
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
						<button type="button" class="btn btn-sm btnSort" id="ordREG_DTM" sortGubun="REG_DTM" sortOdr="asc" sortName="등록일">등록일 △▽</button>
						<button type="button" class="btn btn-sm btnSort" id="ordMOD_DTM" sortGubun="MOD_DTM" sortOdr="asc" sortName="수정일">수정일 △▽</button>
						<button type="button" class="btn btn-sm btnSort" id="ordPD_NAME" sortGubun="PD_NAME" sortOdr="asc" sortName="상품명">상품명 △▽</button>
					</div>
					
					<label class="col-sm-1 control-label txt-right">목록수</label>
					<div class="col-sm-1">
		                <select name="cnt" id="cnt" class="form-control select2" style="width: 100%;" onchange="javascript:fn_order_by('');">
							<option value="10" ${obj.pagerMaxPageItems eq '10' ? 'selected=selected':''}>10</option>
							<option value="20" ${obj.pagerMaxPageItems eq '20' ? 'selected=selected':''}>20</option>
							<option value="30" ${obj.pagerMaxPageItems eq '30' ? 'selected=selected':''}>30</option>
							<option value="40" ${obj.pagerMaxPageItems eq '40' ? 'selected=selected':''}>40</option>
							<option value="50" ${obj.pagerMaxPageItems eq '50' ? 'selected=selected':''}>50</option>
						</select>
					</div>					
				</div>
			</div>
			<!-- /.row -->
		</div>
		<!-- /.box-body -->
	</div>
	<!-- 정렬 박스 -->
		
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">상품 목록 : <font color="green"><b>${obj.count}</b></font></h3>			
			<div class="box-tools">
				<button type="button" class="btn btn-danger btn-sm pull-right left-5" id="btnDelete">삭제</button>
				<button type="button" class="btn btn-success btn-sm pull-right left-5" id="btnExcel"><i class="fa fa-file-excel-o" aria-hidden="true"></i> 엑셀</button>
				<a href="${contextPath}/adm/productMgr/new?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }${link}" 
					 class="btn btn-sm btn-primary pull-right left-5">신규등록</a>
				<button type="button" class="btn btn-primary btn-sm pull-right left-5" id="btnSave" >저장</button>
				<!-- 상품단가 변경 엑셀 업로드 -->
				<button type="button" class="btn btn-info btn-sm btnExcelUpload"><i class="fa fa-file-excel-o"></i> 단가 엑셀 업로드</button>				
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
                       	<th class="txt-middle" style="width:3%"><input id="allCheck" name="toggleChk" type="checkbox" onclick="javascript:fnCheckAll('pdtIdArr')"></th>
						<th class="txt-middle" style="width:8%">대표이미지</th>
						<th class="txt-middle">카테고리/상품명</th>
						<th class="txt-middle" style="width:12%">변경판가</th>
						<th class="txt-right">판매가격</th>
						<th class="txt-middle">할인구분</th>
						<th class="txt-right">할인값</th>
						<th class="txt-middle">판매상태</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${obj.list }" var="ent" varStatus="loop">
					<tr>
                        <td class="txt-middle">
                        	<input name="chkPdtId" value="${ent.PD_CODE }" type="checkbox"/>
                        	<input name="pdtIdYn" value="N" type="hidden"/>
                        </td>
						<td class="txt-middle">
							<c:if test="${ent.FILEPATH_FLAG eq mainKey }">													
								<c:set var="imgPath" value="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
							</c:if>
							<c:if test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
								<c:set var="imgPath" value="${ent.STFL_PATH }" />
							</c:if>
							<c:if test="${ empty(ent.FILEPATH_FLAG) }">
								<c:set var="imgPath" value="https://www.cjfls.co.kr/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
							</c:if>
							<c:if test="${ empty(ent.ATFL_ID)}">
								<c:set var="imgPath" value="${ent.IMGURL }" />
							</c:if>
							<img class="goodsImg" src="${imgPath}" onclick="doImgPop('${imgPath}')"  title="클릭하시면 원본크기로 보실 수 있습니다." style="cursor: pointer;"/>
							<c:if test="${ empty(ent.ATFL_ID) && empty(ent.IMGURL)}">
								<img class="goodsImg50" src="${contextPath }/resources/images/mall/goods/noimage.png" />
							</c:if>
						</td>
						<td>
							<c:out value="${ ent.CAGO_NM_PATH }" escapeXml="true"/><br>
							<a href="${contextPath }/adm/productMgr/edit/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }${link}">
								<c:out value="${ ent.PD_NAME }" escapeXml="true"/>
							</a>
						</td>
						<td class="txt-right">
							<%-- <c:if test='${ent.ONDY_GUBN ne null && ent.ONDY_GUBN eq "Y" }'> 일배상품만 보이게 하려면 주석해제 --%>
								<input type="number" class="form-control txt-right" id="PRICE_CHANGE_${ent.PD_CODE }">
							<%-- </c:if> --%>
						</td>
						<td class="txt-right" id="PRICE_BEFORE_${ent.PD_CODE }" <c:if test='${ent.TODAY_CHANGE_YN eq "Y"}'>color: red;</c:if>">
							<fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###"/>
						</td>							
						<td>
							<select name="PDDC_GUBN" class="form-control select" id = "PDDC_GUBN_${ent.PD_CODE }">
								<c:forEach var="entCode" items="${ codPDDC_GUBN }" varStatus="status">
									<option value="${ entCode.COMD_CODE }" <c:if test="${ ent.PDDC_GUBN eq entCode.COMD_CODE }">selected</c:if>>${ entCode.COMDCD_NAME }</option>
								</c:forEach>
							</select>
						</td>
						<td class="txt-right">${ ent.PDDC_VAL }</td>						
						<td>		
							<select name="SALE_CON" class="form-control select" id = "SALE_CON_${ent.PD_CODE }">
								<c:forEach var="entCode" items="${ codSALE_CON }" varStatus="status">
									<option value="${ entCode.COMD_CODE }" <c:if test="${ ent.SALE_CON eq entCode.COMD_CODE }">selected</c:if>>${ entCode.COMDCD_NAME }</option>
								</c:forEach>
							</select>						
						</td>
					</tr>
				</c:forEach>
				<c:if test="${obj.count eq 0}">
					<tr>
						<td colspan="8">조회된 내용이 없습니다.</td>
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

<form id="excelFrm" method="get" action="${contextPath }/adm/productMgr/excelDown">
</form>

<script type="text/javascript">
$(function() {
	// 선택 저장
	$('#btnSave').on('click',function(){
		// 체크항목
		var checkboxValues =[];		
		$("input:checkbox[name=chkPdtId]:checked").each(function(){
			checkboxValues.push($(this).val());
		});
		
		if(checkboxValues==''||checkboxValues==null){
			checkboxValues.push("");			
			alert("저장할 항목을 체크해주세요.");
			return false;
		}
	
		var saveValues =[];
		
		for(var i=0; i<checkboxValues.length;i++){
			
			var price_change = "#PRICE_CHANGE_"+checkboxValues[i];
			var pddc_gubn = "#PDDC_GUBN_"+checkboxValues[i];
			var sale_con = "#SALE_CON_"+checkboxValues[i];
			var price_before = "#PRICE_BEFORE_"+checkboxValues[i];
			
			if($(price_change).val() != null){
				var price_change_val = $(price_change).val().trim();
				var pddc_gubn_val =$(pddc_gubn).val(); 
				var sale_con_val = $(sale_con).val();
				var price_before = parseInt($(price_before).text().replace(/[^\d]+/g, ''));
				if(price_change_val!=""){	
					var save_val = checkboxValues[i]+"!!@"+pddc_gubn_val+"!!@"+sale_con_val+"!!@"+price_change_val
					saveValues.push(save_val);
				}else{
					var save_val = checkboxValues[i]+"!!@"+pddc_gubn_val+"!!@"+sale_con_val+"!!@"+price_before
					saveValues.push(save_val);
				}
				
			}else{
				var save_val = checkboxValues[i]+"!!@"+pddc_gubn_val+"!!@"+sale_con_val+"!!@"+price_before
				saveValues.push(save_val);
			}
		}
		
		var formMap = {	 "saveValues":saveValues
								,"schGbn": $('select[name=schGbn]').val()
								,"schTxt_bef": $('input[name=schTxt_bef]').val()
								,"schTxt": $('input[name=schTxt]').val()
								,"reSearch": $('#reSearch').val()
								,"sortGubun": $('#sortGubun').val()
								,"pagerMaxPageItems": $('#pagerMaxPageItems').val()
								,"ONDY_GUBN": $('select[name=ONDY_GUBN]').val()
								,"sortOdr": $('#sortOdr').val()								
								,"salecon_sch": $('select[name=salecon_sch]').val()
								,"pageNum": $('#pageNum').val()
							};
       
		cusFormNew("${contextPath }/adm/productMgr/updateList", formMap);
	})
	
	
	// 엑셀
    $("#btnExcel").click(function() {
        $("#excelFrm").submit();        
    });
	
	/* 
	$('.goodsImg').each(function() {
		$(this).error(function(){
			$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
		});
	});
	 */
	
	// 체크박스 전체선택
	$("#allCheck").click(function(){
		if($("#allCheck").prop("checked")) {
			$("input[type=checkbox]").prop("checked",true);
		} else {
			$("input[type=checkbox]").prop("checked",false);
		}
	});

	// 정렬순서
	$('.btnSort').click(function(){
		var strSortGubun = $(this).attr("sortGubun");
		var strSortOdr = $(this).attr("sortOdr");
		
		$("#sortGubun").val(strSortGubun);
		$("#sortOdr").val(strSortOdr);		
		$("#frm").submit();		
	});
	
	/* 상품 엑셀 업로드 관련 */
	//엑셀 업로드 버튼
	$(".btnExcelUpload").click(function(){	
		$('#myModal').modal('show');
    });
	//엑셀 양식 받기
	$("#btnExcelDown").click(function(){	
		document.location.href = "${contextPath }/upload/jundan/excel/pdprice_excel_form.xls";
    });
	//엑셀저장
	$("#btnExcelSave").click(function(){	
		var filechk = $("#EXCEL_FILE").val();		
		if(filechk == null || filechk == ""){
			alert("업로드할 엑셀파일을 첨부해주세요.");
			return false;
		}
		if(!confirm("업로드 하시겠습니까?"))return;
		$('#excelFrm2').submit();
    });
	/* !-상품 엑셀 업로드 관련 */
	
	// 선택 삭제
	$('#btnDelete').on('click',function(){
		// 체크항목
		var checkboxValues =[];
		
		$("input:checkbox[name=chkPdtId]:checked").each(function(){
			checkboxValues.push($(this).val());
		});
		
		if(checkboxValues==''||checkboxValues==null){
			checkboxValues.push("");	
			alert("삭제할 항목을 체크해주세요.");
			return false;
		} else {
			if(!confirm("선택한 상품을 삭제하시겠습니까?")) return;
		}
		
		var formMap = {	 "deleteValues":checkboxValues
								,"sortGubun": $('#sortGubun').val()
								,"sortOdr": $('#sortOdr').val()
								,"schTxt_bef": $('input[name=schTxt_bef]').val()
								,"pagerMaxPageItems": $('#pagerMaxPageItems').val()
								,"schGbn": $('select[name=schGbn]').val()
								,"schTxt": $('input[name=schTxt]').val()
								,"reSearch": $('#reSearch').val()
								,"ONDY_GUBN": $('select[name=ONDY_GUBN]').val()
								,"salecon_sch": $('select[name=salecon_sch]').val()
								,"pageNum": $('#pageNum').val()
							};
		
		cusFormNew("${contextPath }/adm/productMgr/deleteList", formMap);
	});
});

function fn_order_by(str){	
	var frm=document.getElementById("frm");
	
	frm.pagerMaxPageItems.value=$("#cnt").val();
	console.log(frm.pagerMaxPageItems.value);		
	frm.submit();
}

var img1= new Image(); 
function doImgPop(img){ 
	img1= new Image(); 
	img1.src=(img); 
	imgControll(img); 
} 

function cleanResearch(){
	$('#reSearch').val("");
}
	  
function imgControll(img){ 
	if((img1.width!=0)&&(img1.height!=0)){ 
		viewImage(img); 
	} 
	else{ 
		controller="imgControll('"+img+"')"; 
		intervalID=setTimeout(controller,20); 
	} 
}
function viewImage(img){ 
	W=img1.width+20; 
	H=img1.height+20; 
	O="width="+W+",height="+H+",scrollbars=yes"; 
	imgWin=window.open("","",O); 
	imgWin.document.write("<html><head><title>:: 이미지상세보기 ::</title></head>");
	imgWin.document.write("<body topmargin=0 leftmargin=0>");
	imgWin.document.write("<img src="+img+" onclick='self.close()' style='cursor:pointer;' title ='클릭하시면 창이 닫힙니다.'>");
	imgWin.document.close();
}
</script>

<!-- 상품엑셀 업로드 모달 -->
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">상품단가 엑셀 업로드</h4>
			</div>
			<div class="modal-body">
            <form role="form"></form>
				<!-- 기업정보 박스 -->
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">단가 변경 업로드</h3>
						<button type="button" class="btn btn-default btn-sm pull-right btnHelp">
							<i class="fa fa-question-circle"></i> 도움말
						</button>
					</div>		
					<!-- box-body -->
					<spform:form name="excelFrm2" id="excelFrm2" method="post" action="${contextPath }/adm/productMgr/excelUpload" role="form" class="form-horizontal" enctype="multipart/form-data">
					<div class="box-body">
						<div class="form-group">
							<label for="MEMB_ID" class="col-sm-2 control-label">양식파일</label>
							<div class="col-sm-10">
								<button type="button" class="btn btn-primary btn-sm pull-left" id="btnExcelDown"><i class="fa fa-download"></i> 양식 받기 </button>
							</div>
						</div>
						
						<div class="form-group">
							<label for="MEMB_NAME" class="col-sm-2 control-label">엑셀파일</label>
							<div class="col-sm-10">
								<input type="file" id="EXCEL_FILE" name="EXCEL_FILE" id="file-simple" value=""> 
							</div>
						</div>
					</div>
					</spform:form>
					<!-- /.box-body -->
				</div>
				<!-- /.기업정보 박스 -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary btn-sm" id="btnExcelSave">업로드</button>
			</div>
		</div>
	</div>
</div> 