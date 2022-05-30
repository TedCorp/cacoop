<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<%
	String PD_CODE =request.getParameter("PD_CODE");
%>
<style>
	#shipDetail{margin-bottom:0; text-align:left;}
	#detailTd{padding:0;}
	.shipping_table{width:100%;}
	.shipping_table td {padding:4px;}
	.shipping_dtl_table{width:90%; margin:5px;text-align:center;}
	.shipping_dtl_table td{border:1px solid #3c8dbc;}
	.td_wdt{width:50%;}
	.input_wdt {width:20%;}
	.input_wdt2 {width:24%;}
	.input_wdt3 {width:17%;}
	.line-hgt{line-height:34px;}
	.flex{display:flex; justify-content:space-between;}
	.select2{width:50%;}
	.none{display:none;}
	.margin-lft{margin-left:10px;}
	.btn-hgt{height:34px;}
</style>

<section class="content-header">
	<h1>배송 설정  <small>상세 정보 등록</small></h1>
</section>

<section class="content">
	<form id="shippingFrm" class="form-horizontal" action="${contextPath }/adm/productMgr/updateShipping" method="post" autocomplete="off">
		<div class="box box-primary">
			<!-- /.box-header -->
			<div class="box-body">
			<input type="hidden" name="PD_CODE" value="<%= PD_CODE %>"/>
			<input type="hidden" name="TEMP_NUM" value=""/>
					<div class="box-body">
						<table class="shipping_table">
							<colgroup>
								<col style="width:20%">
								<col style="width:80%">
							</colgroup>
							<tr>
								<td><label class="control-label required">배송 방법</label></td>
								<td>
									<select id="DLVY_GUBN" name="DLVY_GUBN" class="form-control select2">
									<c:choose>
										<c:when test='${ tb_pdshipxm.DLVY_GUBN eq "DLVY_GUBN_01" }'>
											<option value="DLVY_GUBN_01" selected>직접배송</option>
											<option value="DLVY_GUBN_02">택배배송</option>
										</c:when>
										<c:otherwise>
											<option value="DLVY_GUBN_01">직접배송</option>
											<option value="DLVY_GUBN_02" selected>택배배송</option>
										</c:otherwise>
									</c:choose>
									</select>
								</td>
							</tr>
							<tr>
								<td><label class="control-label required">배송비 책정 방식</label></td>
								<td>
									<select name="SHIP_GUBN" class="form-control select2">
										<option value="SHIP_GUBN_02">조건부 무료 배송</option>
									</select>
								</td>
							</tr>
							<tr>
								<td><label class="control-label required">배송비</label></td>
								<td>
									<input type="text" id="DLVY_AMT" name="DLVY_AMT" class="form-control td_wdt number" placeholder="숫자만 입력(원 단위)" 
											value="<fmt:formatNumber value="${tb_spinfoxm.DLVY_AMT}" pattern="#,###"/>" />
								</td>
							</tr>
							<tr>
								<td><label class="control-label required">배송비 무료 조건</label></td>
								<td>
									<input type="text" id="GUBN_START" name="GUBN_START" class="form-control td_wdt number" placeholder="숫자만 입력(-원 이상 구매 시)"
										   value="<fmt:formatNumber value="${ tb_spinfoxm.DLVA_FCON }" pattern="#,###"/>"/>
								</td>
							</tr>
							<tr>
								<td><label class="control-label margin-lft">배송 규격(cm)</label></td>
								<td class="flex line-hgt td_wdt">
									가로<input type="text" id="SHIP_WIDTH" name="SHIP_WIDTH" class="form-control input_wdt" value="${ tb_pdshipxm.SHIP_WIDTH }"/> 
									세로<input type="text" id="SHIP_LENGTH" name="SHIP_LENGTH" class="form-control input_wdt" value="${ tb_pdshipxm.SHIP_LENGTH }"/> 
									높이<input type="text" id="SHIP_HEIGHT" name="SHIP_HEIGHT" class="form-control input_wdt" value="${ tb_pdshipxm.SHIP_HEIGHT }"/>
								</td>
							</tr>
							<tr>
								<td><label class="control-label margin-lft">상품 총 중량(kg)</label></td>
								<td>
									<input type="text" id="PD_WEIGHT" name="PD_WEIGHT" class="form-control td_wdt" value="${ tb_pdshipxm.PD_WEIGHT }"/>
								</td>
							</tr>
							<tr>
								<td><label for="inputEmail3" class="control-label required">반품 배송비</label></td>
								<td>
									<input type="text" id="RFND_DLVY_AMT" name="RFND_DLVY_AMT" class="form-control td_wdt number" placeholder="숫자만 입력(원 단위)"
									       value="<fmt:formatNumber value="${ tb_pdshipxm.RFND_DLVY_AMT }" pattern="#,###"/>"/>
								</td>
							</tr>
							<tr>
								<td><label for="inputEmail3" class="control-label margin-lft">지역 추가 배송비</label></td>
								<td>
									<input type="text" id="AREA_DLVY_AMT" name="AREA_DLVY_AMT" class="form-control td_wdt number"  placeholder="제주도/산간지방 등의 지역에 부과되는 추가 배송비" value="${ tb_pdshipxm.AREA_DLVY_AMT }"/>
								</td>
							</tr>
						</table>
					</div>
			</div>
		</div>
		<button type="button" id="saveShippingBtn" class="btn btn-info btn-warning btn-hgt" style="float:right; margin-bottom:10px;">변경 및 저장</button>
		<!--
		<div class="box">
			<div class="box-body">
				
			</div>
		</div>
		-->
	</form>
</section>
<script type="text/javascript">
$(function() {
	$("#saveShippingBtn").click(function() {
		if($("input[name=DLVY_AMT]").val() == null || $("input[name=DLVY_AMT]").val() == "") {
			alert("배송비를 입력하세요.");
			$("input[name=DLVY_AMT]").focus();
			return false;
		}
		
		if($("input[name=GUBN_START]").val() == null || $("input[name=GUBN_START]").val() == "") {
			alert("배송비 무료 조건을 입력하세요.");
			$("input[name=GUBN_START]").focus();
			return false;
		}
		
		if($("input[name=RFND_DLVY_AMT]").val() == null || $("input[name=RFND_DLVY_AMT]").val() == "") {
			alert("반품 배송비를 입력하세요.");
			$("input[name=RFND_DLVY_AMT]").focus();
			return false;
		}
		
		//opener.document.getElementById("NEW_TEMP_NAME").value = document.getElementById("NEW_TEMP_NAME").value;
		// form.jsp에 값 넘기기
		var DLVY_GUBN = $("#DLVY_GUBN").val();
		var DLVY_AMT = $("#DLVY_AMT").val();
		var GUBN_START = $("#GUBN_START").val();
		var SHIP_WIDTH = $("#SHIP_WIDTH").val();
		var SHIP_LENGTH = $("#SHIP_LENGTH").val();
		var SHIP_HEIGHT = $("#SHIP_HEIGHT").val();
		var PD_WEIGHT = $("#PD_WEIGHT").val();
		var RFND_DLVY_AMT = $("#RFND_DLVY_AMT").val();
		var AREA_DLVY_AMT = $("#AREA_DLVY_AMT").val();
		
		opener.setOriginShip(DLVY_GUBN, DLVY_AMT, GUBN_START, SHIP_WIDTH, SHIP_LENGTH, SHIP_HEIGHT, PD_WEIGHT, RFND_DLVY_AMT, AREA_DLVY_AMT);
		//alert("배송 상세 정보가 저장되었습니다.");
		//window.close();
		
		
		$.ajax({
			type: "POST",
			url: "${contextPath}/adm/productMgr/updateShipping",
			data: $("#shippingFrm").serialize(),
			success: function (data) {
				console.log(data);
				if(data == "2") {
					alert("배송 상세 정보가 저장되었습니다.");
					window.close();
					//opener.location.reload();
				} else {
					alert("배송 정보 저장 중 문제가 발생했습니다. 관리자에게 문의하세요.");
					window.close();
					//opener.location.reload();
				}
			}, error: function (jqXHR, textStatus, errorThrown) {
				alert("처리중 에러가 발생했습니다. 관리자에게 문의하세요.(error:"+textStatus+")");
				window.close();
			}
		});
	});
	
	//숫자만 입력하도록
	$(document).on("keyup", ".number", function() {
		$(this).number(true);
	});


	
});

function fn_value(GOODS_CODE,POS_NAME,CAGO_ID,CAGO_NAME){
	opener.fn_popup_return(GOODS_CODE,POS_NAME,CAGO_ID,CAGO_NAME);
	window.close();
}
</script>