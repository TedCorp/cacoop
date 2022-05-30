<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<style>
.goodsImg {
    width: auto; height: auto;
    max-width: 50px;
    max-height: 50px;
}
</style>

<section class="content-header">
	<h1>
		연계상품
		<small>연계 상품 가격 목록</small>
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
			<form class="form-horizontal" id="frm">
				<input type="hidden" name="sortGubun" id="sortGubun" />
				<input type="hidden" name="sortOdr" id="sortOdr" />
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">검색어</label>

						<div class="col-sm-2">
							<select name="schGbn" class="form-control select2" style="width: 100%;">
								<option value="PD_NAME" selected="selected">상품명</option>
								<option value="PD_CODE">상품코드</option>
							</select>
						</div>
						<div class="col-sm-8">
							<input name="schTxt" type="text" class="form-control" placeholder="검색어 입력" value="${param.schTxt }">
						</div>
						<div class="col-sm-1">
							<button type="submit" class="btn btn-success pull-right">검색</button>
						</div>
					</div>
				</div>
				<!-- /.row -->
			</form>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.box -->
	<!-- 검색 박스 -->

	<!-- 검색 박스 -->
	<div class="box box-primary">
		<!-- /.box-header -->
		<div class="box-body">
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">정렬</label>
						<div class="col-sm-6">
							<button type="button" class="btn btn-primary btn-sm btnSort" id="ordREG_DTM" sortGubun="REG_DTM" sortOdr="asc" sortName="등록일">등록일 △▽</button>
							<button type="button" class="btn btn-primary btn-sm btnSort" id="ordPD_NAME" sortGubun="PD_NAME" sortOdr="asc" sortName="상품명">상품명 △▽</button>
						</div>
					</div>
				</div>
				<!-- /.row -->
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.box -->
	<!-- 검색 박스 -->
	
	<spform:form name="saveFrm" id="saveFrm" method="post" action="" class="form-horizontal" >
	<input name="schGbn" type="hidden" value="${param.schGbn }">
	<input name="schTxt" type="hidden" value="${param.schTxt }">
	
	<input name="pageNum" type="hidden" value="${obj.pageNum }">
	<input name="rowCnt" type="hidden" value="${obj.rowCnt }">
	<input name="sortGubun" type="hidden" value="${param.sortGubun }">
	<input name="sortOdr" type="hidden" value="${param.sortOdr }">
	
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">상품 목록</h3>
			<div class="box-tools">
				<a href="#" id="btnSave" class="btn btn-sm btn-primary pull-right">저장</a>
				<button type="button" class="btn btn-sm btn-primary pull-right btnExcelUpload" style="margin-right: 10px; margin-bottom: 20px;"><i class="fa fa-file-excel-o"></i> 엑셀 업로드 </button>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-sm table-bordered">
				<colgroup>
					<col style="with:100px" />
					<col />
					<col style="with:50px" />
					<c:forEach items="${codMALL_GUBN }" var="ent" varStatus="loop">
						<col style="with:50px" />
					</c:forEach>
					
				</colgroup>
				<thead>
					<tr>
						<th rowspan="2" class="text-center" style="vertical-align:middle">대표이미지</th>
						<th rowspan="2" class="text-center" style="vertical-align:middle">카테고리/상품명</th>
						<th rowspan="2" class="text-center" style="vertical-align:middle">판매가격</th>
						<th colspan="${fn:length(codMALL_GUBN)}" class="text-center">연계 쇼핑몰</th>
					</tr>
					<tr>
						<c:forEach items="${codMALL_GUBN }" var="ent" varStatus="loop">
							<th class="text-center">
								<input type="hidden" name="MALL_GUBNS" value="${ ent.COMD_CODE }" />
								${ent.COMDCD_NAME}
							</th>
						</c:forEach>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${obj.list }" var="ent" varStatus="loop">
					<tr>
						<td align="center">
							<c:if test="${ !empty(ent.ATFL_ID) }">
								<img class="goodsImg" src="${contextPath }/common/commonFileDown?IMG_GUBUN=thumbnail&ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" onclick="doImgPop('${contextPath }/common/commonFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}')"  title="클릭하시면 원본크기로 보실 수 있습니다." style="cursor: pointer;"/>
							</c:if>
							<c:if test="${ empty(ent.ATFL_ID) }">
								<img class="goodsImg" src="${contextPath }/resources/images/mall/goods/noimage.png" />
							</c:if>
						</td>
						<td align="left">
							<input type="hidden" name="PD_CODES" value="${ ent.PD_CODE }" />
							<c:out value="${ ent.CAGO_NM_PATH }" escapeXml="true"/><br>
							<!-- a href="${contextPath }/adm/productMgr/edit/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }${link}" -->
								<b><c:out value="${ ent.PD_NAME }" escapeXml="true"/></b>
							<!-- /a -->
						</td>
						<td align="right" style="padding-left: 20px"><fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###"/></td>	
						<c:if test="${fn:length(codMALL_GUBN) > 0}"><td align="right" style="padding-left: 20px"><input class="form-control input-sm number" type="text" name="PD_PRICES01" value="<fmt:formatNumber value="${ ent.PD_PRICE01 }" pattern="#,###"/>"></td></c:if>	
						<c:if test="${fn:length(codMALL_GUBN) > 1}"><td align="right" style="padding-left: 20px"><input class="form-control input-sm number" type="text" name="PD_PRICES02" value="<fmt:formatNumber value="${ ent.PD_PRICE02 }" pattern="#,###"/>"></td></c:if>	
						<c:if test="${fn:length(codMALL_GUBN) > 2}"><td align="right" style="padding-left: 20px"><input class="form-control input-sm number" type="text" name="PD_PRICES03" value="<fmt:formatNumber value="${ ent.PD_PRICE03 }" pattern="#,###"/>"></td></c:if>	
						<c:if test="${fn:length(codMALL_GUBN) > 3}"><td align="right" style="padding-left: 20px"><input class="form-control input-sm number" type="text" name="PD_PRICES04" value="<fmt:formatNumber value="${ ent.PD_PRICE04 }" pattern="#,###"/>"></td></c:if>	
						<c:if test="${fn:length(codMALL_GUBN) > 4}"><td align="right" style="padding-left: 20px"><input class="form-control input-sm number" type="text" name="PD_PRICES05" value="<fmt:formatNumber value="${ ent.PD_PRICE05 }" pattern="#,###"/>"></td></c:if>					
						<!-- td>---</td -->	
					</tr>
				</c:forEach>
				<c:if test="${obj.count == 0}">
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
	</spform:form>
</section>



<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">상품 엑셀 업로드</h4>
			</div>
			<div class="modal-body">
            <form role="form">
            </form>
				<!-- 기업정보 박스 -->
					<div class="box box-info">
						<div class="box-header with-border">
							<h3 class="box-title">업로드</h3>
						</div>
						<!-- /.box-header -->
					
						<!-- box-body -->
						<spform:form name="excelFrm" id="excelFrm" method="post" action="${contextPath }/adm/adMgr/excelUpload" role="form" class="form-horizontal" enctype="multipart/form-data">
						<input type="hidden" name="AD_ID" value="${adverinfo.AD_ID }" />
						<div class="box-body">

							<div class="form-group">
								<label for="MEMB_ID" class="col-sm-2 control-label">양식파일</label>
								<div class="col-sm-10">
									<button type="button" class="btn btn-sm btn-primary pull-left" id="btnExcelDown"><i class="fa fa-download"></i> 양식 받기 </button>
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
				<!-- 기업정보 박스 -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="btnExcelSave">업로드</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	<c:if test="${!empty param.schGbn}">
		$('#schGbn').val('${param.schGbn}');
	</c:if>
		
	<c:if test="${!empty param.sortGubun}">
		$('#ord${param.sortGubun}').attr("sortOdr", "${param.sortOdr eq 'desc' ? 'asc' : 'desc'}");
		$('#ord${param.sortGubun}').text( $('#ord${param.sortGubun}').attr("sortName") + " ${param.sortOdr eq 'desc' ? '△▼' : '▲▽'}");
	</c:if>
	
	$('.goodsImg').each(function() {
		$(this).error(function(){
			$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
		});
	});
	
	$("#allCheck").click(function(){
		if($("#allCheck").prop("checked")) {
			$("input[type=checkbox]").prop("checked",true);
		} else {
			$("input[type=checkbox]").prop("checked",false);
		}
	});

	$('.btnSort').click(function(){
		var strSortGubun = $(this).attr("sortGubun");
		var strSortOdr = $(this).attr("sortOdr");
		
		$("#sortGubun").val(strSortGubun);
		$("#sortOdr").val(strSortOdr);
		
		$("#frm").submit();
		
	});
	

	$("#btnSave").click(function() {

		if(!confirm("저장하시겠습니까?")) return;

		$("#saveFrm").attr("action","${contextPath }/adm/productLinkMgr");
		$("#saveFrm").submit();
	});
	
	$(".btnExcelUpload").click(function(){
		//$('#myModal').modal('show');
		alert("준비중입니다.");
    });
	
});

var img1= new Image(); 
function doImgPop(img){ 
	img1= new Image(); 
	img1.src=(img); 
	imgControll(img); 
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
