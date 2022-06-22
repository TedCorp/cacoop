<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<style>
	.pageBtn{float:left; width:20px; cursor:pointer}
	.box-body .box-body > div:nth-child(2) div{display:inline-block; padding:0 15px;}
	td{height:100px;}
</style>

<section class="content-header">
	<h1>상품연동관리
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
		<div class="box-body">
			<form class="form-horizontal" id="frm" >
				<input type="hidden" name="sortGubun" id="sortGubun" />
				<input type="hidden" name="sortOdr" id="sortOdr" />
				<input type="hidden" name="schTxt_bef" value="${ obj.schTxt_bef }" />
				<input type="hidden" name="pageNum" id="pageNum" value="${param.pageNum }" /> 
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
								<input type="search" class="form-control" name="schTxt" id="schTxt" style="ime-mode:active;"
									placeholder="검색어 입력" value="${param.schTxt }" onclick="javascript:cleanResearch()"
								>
								<span class="input-group-btn">
									<!-- <button type="button" id="btnSearch" class="btn btn-success pull-right">검색</button> -->
									<button type="button" onclick="asdf()" class="btn btn-success pull-right">검색</button>
								</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label txt-right">브랜드</label>
						<div>
							<input type="search" class="form-control" name="brand" id="brand" style="ime-mode:active; width:300px;"
								placeholder="브랜드명 입력" value="${param.brand }" onclick="javascript:cleanResearch()"
							>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label txt-right">목록수</label>
						<div class="col-sm-1">
			                <select name="listCnt" id="listCnt" class="form-control select2" style="width:80px;" onchange="">
								<option value="10" ${param.listCnt eq '10' ? 'selected=selected':''}>10</option>
								<option value="30" ${param.listCnt eq '30' ? 'selected=selected':''}>30</option>
								<option value="50" ${param.listCnt eq '50' ? 'selected=selected':''}>50</option>
								<option value="100" ${param.listCnt eq '20' ? 'selected=selected':''}>20</option>
							</select>
						</div>			
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- 검색 박스 -->		
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">상품 목록 : <font color="green"><b>${totalCnt}</b></font></h3>			
			<div class="box-tools">
				<button type="button" class="btn btn-primary btn-sm pull-right left-5" id="btnSave" >상품연동</button>
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
						<th class="txt-middle">판매가격</th>
						<th class="txt-middle">할인구분</th>
						<th class="txt-middle">할인값</th>
						<th class="txt-middle">판매상태</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach begin="0" end="${test.length() -1}" var="i">
				<tr>
                    <td class="txt-middle">
                    	<input name="chkPdtId" value='${test.getJSONObject(i).get("prdNo")}' type="checkbox"/>
                    	<input name="pdtIdYn" value="N" type="hidden"/>
                    </td>
                    <c:if test='${test.getJSONObject(i).get("repImg") != "null"}'>
                    	<td class="txt-middle"><img src='http://ct.e-kiss.co.kr:24080/uploads/${test.getJSONObject(i).get("repImg")}' style="max-width:60px;"></td>
                    </c:if>
                    <c:if test='${test.getJSONObject(i).get("repImg") == "null"}'>
                    	<td class="txt-middle"><img src='${contextPath }/resources/images/mall/goods/noimage.png' style="max-width:60px;"></td>
                    </c:if>
			    	<td  class="txt-left">소통 클라우드  
			    	<c:if test='${test.getJSONObject(i).get("prductCl1Nm") != "null"}'>
			    		> ${test.getJSONObject(i).get("prductCl1Nm")} 
			    	</c:if> 
			    	<c:if test='${test.getJSONObject(i).get("prductCl2Nm") != "null"}'>
			    		 > ${test.getJSONObject(i).get("prductCl2Nm")} 
			    	</c:if>
			    	<c:if test='${test.getJSONObject(i).get("prductCl3Nm") != "null"}'>
			    		 > ${test.getJSONObject(i).get("prductCl3Nm")} 
			    	</c:if>  
			    	/ ${test.getJSONObject(i).get("prductNm")}</td>
			    	<td class="txt-right">-</td>
			    	<td class="txt-right">${test.getJSONObject(i).get("cnsmrPc")}</td>
			    	<td class="txt-middle">-</td>
			    	<td class="txt-right">0</td>
			    	<c:if test='${test.getJSONObject(i).get("delYn") == "Y" }'>
                    	<td class="txt-middle">판매 불가</td>
                    </c:if>
                    <c:if test='${test.getJSONObject(i).get("delYn") == "N" }'>
                    	<td class="txt-middle">판매 가능</td>
                    </c:if>
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

		<%-- <paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter> --%>
 		<div class="paging_new">
			<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
				<First><Previous><AllPageLink><Next><Last>
			</paging:PageFooter>
		</div>
	</div>
</section>

<form id="excelFrm" method="get" action="${contextPath }/adm/productMgr/excelDown">
</form>

<script type="text/javascript">

function asdf() {
	console.log('${contextPath}');
	console.log(1);
}


$(function() {
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
});

function fn_order_by(str){	
	var frm=document.getElementById("frm");
	frm.pagerMaxPageItems.value=$("#cnt").val();
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

$("#btnSearch").click(function(){
	$("#frm").submit();
});

$(".pageBtn").click(function(){
	$("#pageNum").val(this.textContent);
	$("#frm").submit();
});

$("#btnSave").click(function(){
	var prdNums = $('input[name="chkPdtId"]:checked');
	var prdNum = [];
	for(var i =0;i<prdNums.length;i++){
		prdNum.push(prdNums[i].value);
	}
	
	if (prdNum.length === 0) {
		alert('연동하실 상품을 선택해주세요.');
		return;
	}

	 $.ajax({
		type: "POST",
	    url: "${contextPath}/adm/productMgr/insertLinkProduct",
	    traditional: true,
	    data: {
	    	prdNums : prdNum.toString()
	    },
	    success: function (data) {
	   		alert("선택한 상품의 연동이 완료 되었습니다.");
	   		location.reload();
	    }, error: function (jqXHR, textStatus, errorThrown) {
	       alert("상품 연동중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
	    }
	});
});
</script>