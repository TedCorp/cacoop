<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<style>
	.shipping_table_area {border:1px solid #d2d6de;}
	#shipDetail{margin-bottom:0; text-align:left;}
	.shipping_table{width:100%;}
	.shipping_table td {padding:4px;}
	.shipping_table td:last-of-type{padding-left:15px;}
	.shipping_dtl_table{width:95%; margin:5px;text-align:center;}
	.shipping_dtl_table tr{height:30px;}
	.shipping_dtl_table td{border-bottom:1px solid #3c8dbc;}
	.td_wdt{width:50%;}
	.input_wdt {width:20%;}
	.input_wdt2 {width:24%;}
	.input_wdt3 {width:15%;}
	.line-hgt{line-height:34px;}
	.flex{display:flex; justify-content:space-between;}
	.select2{width:50%;}
	.none{display:none;}
	.margin-lft{margin-left:10px;}
	.btn-hgt{height:34px;}
	#DLVY_GUBN{width:50%;}
	.ship_btn{background:#ffffff; outline:none;}
</style>

<section class="content-header">
	<h1>배송비 템플릿  <small>상세 정보 등록</small></h1>
</section>

<section class="content">
	<form id="templeteFrm" class="form-horizontal" method="post" autocomplete="off">
		<div class="box box-primary">
			<!-- /.box-header -->
			<div class="box-body">
			<input type="hidden" name="TEMP_NUM" value="${ tb_shiptexm.TEMP_NUM }"/>
				<div class="box-body">
					<table class="shipping_table">
						<colgroup>
							<col style="width:20%">
							<col style="width:80%">
						</colgroup>
						<tr>
							<td><label for="inputEmail3" class="control-label required">템플릿명</label></td>
							<td>
								<input type="text" name="TEMP_NAME" class="form-control td_wdt" value="${ tb_shiptexm.TEMP_NAME }"/>
								<input type="hidden" id="NEW_TEMP_NAME" name="NEW_TEMP_NAME" class="form-control td_wdt"/>
							</td>
						</tr>
						<tr>
							<td><label class="control-label required">배송 방법</label></td>
							<td>
								<select name="DLVY_GUBN" class="form-control select2">
									<option value="DLVY_GUBN_01" <c:if test="${ tb_shiptexm.DLVY_GUBN eq 'DLVY_GUBN_01' }">selected</c:if>>직접배송</option>
									<option value="DLVY_GUBN_02" <c:if test="${ tb_shiptexm.DLVY_GUBN eq 'DLVY_GUBN_02' }">selected</c:if>>택배배송</option>
								</select>
							</td>
						</tr>
						<tr>
							<td><label class="control-label required">배송비 책정 방식</label></td>
							<td>
								<select id="shipGubn" name="SHIP_GUBN" class="form-control select2">
									<option value="SHIP_GUBN_01" <c:if test="${ tb_shiptexm.SHIP_GUBN eq 'SHIP_GUBN_01' }">selected</c:if>>배송비 무료</option>
									<option value="SHIP_GUBN_02" <c:if test="${ tb_shiptexm.SHIP_GUBN eq 'SHIP_GUBN_02' }">selected</c:if>>조건부 무료 배송</option>
									<option value="SHIP_GUBN_03" <c:if test="${ tb_shiptexm.SHIP_GUBN eq 'SHIP_GUBN_03' }">selected</c:if>>구매 금액별 차등 배송료 부과</option>
									<option value="SHIP_GUBN_04" <c:if test="${ tb_shiptexm.SHIP_GUBN eq 'SHIP_GUBN_04' }">selected</c:if>>상품 수량별 차등 배송료 부과</option>
								</select>
							</td>
						</tr>
						<tr>
							<td><label id="shipDetail" class="control-label required none">배송비 상세 설정</label></td>
							<td>
								<div id="priceOnly" class="flex line-hgt none" style="padding:4px 0 4px 0;">
									구매 금액 &nbsp;
									<input type="text" name="GUBN_START" class="form-control input_wdt input7 number" value="<fmt:formatNumber value="${tb_shiptexm.GUBN_START}" pattern="#,###"/>"/>원 미만이면 &nbsp; 
									배송비 &nbsp;
									<input type="text" name="DLVY_AMT" class="form-control input_wdt input8 number" value="<fmt:formatNumber value="${tb_shiptexm.DLVY_AMT}" pattern="#,###"/>"/>원
								</div>
								<div id="priceUnit" class="flex line-hgt none" style="padding:4px 0 4px 0;">
									구매 금액 &nbsp;
									<input type="text" class="form-control input_wdt3 input1 number"/>원 이상 &nbsp; 
									<input type="text" class="form-control input_wdt3 input2 number"/>원 미만이면 &nbsp;
									배송비 &nbsp;
									<input type="text" class="form-control input_wdt3 input3 number"/>원&nbsp;
									<button type="button" class="btn btn-info btn-flat btn-hgt" onclick="addDetail('a');">추가</button>
								</div>
								<div id="countUnit" class="flex line-hgt none" style="padding:4px 0 4px 0;">
									구매 수량 &nbsp;
									<input type="text" class="form-control input_wdt3 input4"/>개 이상 &nbsp; 
									<input type="text" class="form-control input_wdt3 input5"/>개 미만이면 &nbsp;
									배송비 &nbsp;
									<input type="text" class="form-control input_wdt3 input6 number"/>원&nbsp;
									<button type="button" class="btn btn-info btn-flat btn-hgt" onclick="addDetail('b');">추가</button>
								</div>
								<table class="shipping_dtl_table none">
									<colgroup>
										<col style="width:10%;">
										<col style="width:55%;">
										<col style="width:20%;">
										<col style="width:15%;">
									</colgroup>
									<tr style="font-weight:700; background:#3c8dbc; color:#ffff;">
										<td>번호</td>
										<td>상세 설정</td>
										<td>배송비</td>
										<td>삭제</td>
									</tr>
									<c:set var="rownum" value="0"/>
									<c:if test="${ tb_shiptexm.SHIP_GUBN eq 'SHIP_GUBN_03' or tb_shiptexm.SHIP_GUBN eq 'SHIP_GUBN_04' }">
									 	<c:choose>
									 		<c:when test="${ !empty(tb_shiptexd.list) }">
									 			<c:forEach var="list" items="${ tb_shiptexd.list }" varStatus="loop">
									 			<c:set var="rownum" value="${ rownum + 1 }"/>
									 				<tr>
									 					<td>${ rownum }</td>
									 					<td><fmt:formatNumber value="${list.GUBN_START}"/>원 이상 <fmt:formatNumber value="${list.GUBN_END}"/>원 미만</td>
									 					<td><fmt:formatNumber value="${list.DLVY_AMT}"/>원</td>
									 					<td>
									 					<input type="button" id="btn${ list.TEMP_SEQ }" class="del_ship_btn" onclick="delShipBtn('${ rownum }');" value="삭제"/>
									 					<input type="hidden" name="GUBN_STARTS" value="${ list.GUBN_START }"/>
														<input type="hidden" name="GUBN_ENDS" value="${ list.GUBN_END }"/>
														<input type="hidden" name="DLVY_AMTS" value="${ list.DLVY_AMT }"/>
														</td>
									 				</tr>
									 			</c:forEach>
									 		</c:when>
									 		<c:otherwise>
									 			<tr>
													<td colspan="4">설정 구간이 존재하지 않습니다</td>
												</tr>
									 		</c:otherwise>
									 	</c:choose>
									 </c:if>
								</table>
							</td>
						</tr>
						<tr>
							<td><label for="inputEmail3" class="control-label required ">반품 배송비</label></td>
							<td>
								<input type="text" name="RFND_DLVY_AMT" class="form-control td_wdt number" placeholder="숫자만 입력(원 단위)" value="<fmt:formatNumber value="${tb_shiptexm.RFND_DLVY_AMT}" pattern="#,###"/>"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div style="display:flex; justify-content:flex-end;">
			<c:choose>
				<c:when test="${ tb_shiptexm.TEMP_NUM eq null || tb_shiptexm.TEMP_NUM eq '' }">
					<button type="button" class="btn btn-info btn-warning btn-hgt" style="margin-bottom:10px;" onclick="saveTempBtn('insert');">저장</button>&nbsp;&nbsp;
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-info btn-warning btn-hgt" style="margin-bottom:10px;" onclick="saveTempBtn('update')">저장</button>&nbsp;&nbsp;
				</c:otherwise>
			</c:choose>
			<a href="${contextPath}/adm/productMgr/getTempletePop" class="btn btn-info btn-hgt" style="margin-bottom:10px; background:#3c763d;">뒤로</a>
		</div>
		<!--
		<div class="box">
			<div class="box-body">
				
			</div>
		</div>
		-->
	</form>
</section>
<script type="text/javascript">
var rownum = ${ rownum };
$(function() {
    /* 숫자만 입력토록 함 */
    $(document).on("keyup", ".number", function() {
       $(this).number(true);
    });
	
	// 배송비 설정에 따라 display
	if($("input:radio[name='SHIP_CONFIG']:checked").val() == "SHIP_CONFIG_01"){	
        $("#shipDefaultBtn").css("display", "block");
        $(".shipping_table_area").css("display", "none");
        $("#tempBtn").css("display", "none");
     } else if($("input:radio[name='SHIP_CONFIG']:checked").val() == "SHIP_CONFIG_02"){	
   		$("#shipDefaultBtn").css("display", "none");
   	 	$(".shipping_table_area").css("display", "block");
   	 	$("#tempBtn").css("display", "none");
     }	else {
   	 	$("#shipDefaultBtn").css("display", "none");
    	$(".shipping_table_area").css("display", "none");
    	$("#tempBtn").css("display", "inline-flex");
     }
	
	// 배송비 책정 방식에 따라 display
	if($("#shipGubn option:selected").val() == "SHIP_GUBN_01"){
   		$("#shipDetail").css("display", "none");
   	 	$(".shipping_dtl_table").css("display", "none");
        $("#priceOnly").css("display", "none");
        $("#priceUnit").css("display", "none");
        $("#countUnit").css("display", "none");
	   } else if($("#shipGubn option:selected").val() == "SHIP_GUBN_02") {
   	 $("#shipDetail").css("display", "block");
    	$(".shipping_dtl_table").css("display", "none");
        $("#priceOnly").css("display", "flex");
        $("#priceOnly").css("justify-content", "flex-start");
        $("#priceUnit").css("display", "none");
        $("#countUnit").css("display", "none");
	   } else if($("#shipGubn option:selected").val() == "SHIP_GUBN_03") {
   	 	$("#shipDetail").css("display", "block");
   	 	$(".shipping_dtl_table").css("display", "inline-table");
   	 	$("#priceOnly").css("display", "none");
        $("#priceUnit").css("display", "flex");
        $("#priceUnit").css("justify-content", "flex-start");
        $("#countUnit").css("display", "none");
     } else {
   	 	$("#shipDetail").css("display", "block");
   	 	$(".shipping_dtl_table").css("display", "inline-table");
   	 	$("#priceOnly").css("display", "none");
        $("#priceUnit").css("display", "none");
        $("#countUnit").css("display", "flex");
        $("#countUnit").css("justify-content", "flex-start");
     }
	
    // 배송비 설정 변경 시 (기본, 개별, 템플릿)
    $("input:radio[name='SHIP_CONFIG']").change(function(){	
      if($("input:radio[name='SHIP_CONFIG']:checked").val() == "SHIP_CONFIG_01"){	
         $("#shipDefaultBtn").css("display", "block");
         $(".shipping_table_area").css("display", "none");
         $("#tempBtn").css("display", "none");
      } else if($("input:radio[name='SHIP_CONFIG']:checked").val() == "SHIP_CONFIG_02"){	
    	 $("#shipDefaultBtn").css("display", "none");
    	 $(".shipping_table_area").css("display", "block");
    	 $("#tempBtn").css("display", "none");
      }	else {
    	 $("#shipDefaultBtn").css("display", "none");
     	 $(".shipping_table_area").css("display", "none");
     	 $("#tempBtn").css("display", "inline-flex");
      }
      
      // 개별이 아닐 때 테이블 비우기
      if($("input:radio[name='SHIP_CONFIG']:checked").val() != "SHIP_CONFIG_02") {
    	  $(".input1").val(''); $(".input2").val(''); $(".input3").val(''); $(".input4").val('');
      	  $(".input5").val(''); $(".input6").val(''); $(".input7").val(''); $(".input8").val('');
      	  $("input[name=SHIP_WIDTH]").val(''); $("input[name=SHIP_LENGTH]").val(''); $("input[name=SHIP_HEIGHT]").val('');
    	  $("input[name=PD_WEIGHT]").val(''); $("input[name=RFND_DLVY_AMT]").val(''); $("input[name=AREA_DLVY_AMT]").val('');
    	  
    	  var html = '';
      	  
      	  html += '<tr style="font-weight:700; background:#3c8dbc; color:#ffff;">';
    	  html += '<td>번호</td>';
    	  html += '<td>상세 설정</td>';
    	  html += '<td>배송비</td>';
    	  html += '<td>삭제</td>';
          html += '</tr>';
      	  html += '<tr>';
      	  html += '<td colspan="4">설정 구간이 존재하지 않습니다</td>';
      	  html += '</tr>';
      	  
      	  $(".shipping_dtl_table").html(html);
       }
    });
	
    // 배송비 책정 방식 변경 시 (배송비 무료, 조건비 무료 배송...)
    $("select[name='SHIP_GUBN']").change(function(){
	   if($("#shipGubn option:selected").val() == "SHIP_GUBN_01"){
    	 $("#shipDetail").css("display", "none");
    	 $(".shipping_dtl_table").css("display", "none");
         $("#priceOnly").css("display", "none");
         $("#priceUnit").css("display", "none");
         $("#countUnit").css("display", "none");
	   } else if($("#shipGubn option:selected").val() == "SHIP_GUBN_02") {
    	 $("#shipDetail").css("display", "block");
     	 $(".shipping_dtl_table").css("display", "none");
         $("#priceOnly").css("display", "flex");
         $("#priceOnly").css("justify-content", "flex-start");
         $("#priceUnit").css("display", "none");
         $("#countUnit").css("display", "none");
	   } else if($("#shipGubn option:selected").val() == "SHIP_GUBN_03") {
    	 $("#shipDetail").css("display", "block");
    	 $(".shipping_dtl_table").css("display", "inline-table");
    	 $("#priceOnly").css("display", "none");
         $("#priceUnit").css("display", "flex");
         $("#priceUnit").css("justify-content", "flex-start");
         $("#countUnit").css("display", "none");
       } else {
    	 $("#shipDetail").css("display", "block");
    	 $(".shipping_dtl_table").css("display", "inline-table");
    	 $("#priceOnly").css("display", "none");
         $("#priceUnit").css("display", "none");
         $("#countUnit").css("display", "flex");
         $("#countUnit").css("justify-content", "flex-start");
       }
      
      $(".input1").val(''); $(".input2").val(''); $(".input3").val(''); $(".input4").val('');
  	  $(".input5").val(''); $(".input6").val(''); $(".input7").val(''); $(".input8").val('');
  	  
  	  rownum = 0;
  	  
  	  var html = '';
  	  
  	  html += '<tr style="font-weight:700; background:#3c8dbc; color:#ffff;">';
	  html += '<td>번호</td>';
	  html += '<td>상세 설정</td>';
	  html += '<td>배송비</td>';
	  html += '<td>삭제</td>';
      html += '</tr>';
  	  html += '<tr>';
  	  html += '<td colspan="4">설정 구간이 존재하지 않습니다</td>';
  	  html += '</tr>';
  	  
  	  $(".shipping_dtl_table").html(html);
    });
});

//배송비 테이블 컬럼 추가
function addDetail(type) {
	var input1 = $(".input1").val().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","); //GUBN_STARTS
	var input2 = $(".input2").val().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","); //GUBN_ENDS
	var input3 = $(".input3").val().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","); //DLVY_AMTS
	var input4 = $(".input4").val(); //GUBN_STARTS(수량)
	var input5 = $(".input5").val(); //GUBN_ENDS(수량)
	var input6 = $(".input6").val().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	if(type == 'a') {
		if((input1 == null || input1 == '') || (input2 == null || input2 == '') || (input3 == null || input3 == '')) {
			alert("배송비를 입력해주세요");
			return false;
		}
	} else {
		if((input4 == null || input4 == '') || (input5 == null || input5 == '') || (input6 == null || input6 == '')) {
			alert("배송비를 입력해주세요");
			return false;
		}
	}
	
	var html ='';
	
	if(rownum == 0) {
	   $(".shipping_dtl_table").html('');
		
	   html += '<tr style="font-weight:700; background:#3c8dbc; color:#ffff;">';
	   html += '<td>번호</td>';
	   html += '<td>상세 설정</td>';
	   html += '<td>배송비</td>';
	   html += '<td>삭제</td>';
       html += '</tr>';
	}
	
	html += '<tr>';
	html += 	'<td>';
	html += 	rownum+1;
	html += 	'</td>';
	
	if(type == 'a') {
		$(".input1").val('');
		$(".input2").val('');
		$(".input3").val('');
		
		html += 	'<td>';
		html += 	input1 + '원 이상 ' + input2 + '원 미만';
		html += 	'</td>';
		html += 	'<td>';
		html += 	input3 + '원';
		html += 	'</td>';

		//, 제거하고 hidden에 값 넣기  
		 input1 = input1.replace(",", "");
		 input2 = input2.replace(",", "");
		 input3 = input3.replace(",", "");
		
		
		html += '<input type="hidden" name="GUBN_STARTS" value="' + input1 + '"/>';
		html += '<input type="hidden" name="GUBN_ENDS" value="' + input2 + '"/>';
		html += '<input type="hidden" name="DLVY_AMTS" value="' + input3 + '"/>';
	} else {
		$(".input4").val('');
		$(".input5").val('');
		$(".input6").val('');
		
		html += 	'<td>';
		html += 	input4 + '개 이상 ' + input5 + '개 미만';
		html += 	'</td>';
		html += 	'<td>';
		html += 	input6 + '원';
		html += 	'</td>';
		

		//, 제거하고 hidden에 값 넣기 
		var input6 = input6.replace(",", "");
		
		html += '<input type="hidden" name="GUBN_STARTS" value="' + input4 + '"/>';
		html += '<input type="hidden" name="GUBN_ENDS" value="' + input5 + '"/>';
		html += '<input type="hidden" name="DLVY_AMTS" value="' + input6 + '"/>';
	}
	
	html += 	'<td>';
	html += 	'<input type="button" id="btn' + (rownum+1) + '" class="del_ship_btn" onclick="delShipBtn(' + (rownum+1) + ');" value="삭제"/>';
	html += 	'</td>';
	html += '</tr>';
	
	$(".shipping_dtl_table").append(html);
	rownum++;
}

//배송비 테이블 컬럼 삭제
function delShipBtn(num) {
	$("#btn" + num).parent().parent().remove();
	rownum--;
	
	if(rownum == 0) {
		$(".shipping_dtl_table").html('');
		
		var html = '';
	    html += '<tr style="font-weight:700; background:#3c8dbc; color:#ffff;">';
	    html += '<td>번호</td>';
	    html += '<td>상세 설정</td>';
	    html += '<td>배송비</td>';
	    html += '<td>삭제</td>';
        html += '</tr>';
        html += '<tr>';
    	html += '<td colspan="4">설정 구간이 존재하지 않습니다</td>';
    	html += '</tr>';
    	
        $(".shipping_dtl_table").append(html);
	}
}

//저장 버튼
function saveTempBtn(text) {
	//템플릿 필수값 입력
  	if($("input[name=TEMP_NAME]").val() == null || $("input[name=TEMP_NAME]").val() == "") {
	   	  alert("템플릿명을 입력하세요.");
	   	  $("input[name=TEMP_NAME]").focus();
	   	  return false;
	}
  	 
   if($("select[name=SHIP_GUBN]").val() == "SHIP_GUBN_02") {
   	  if($("input[name=GUBN_START]").val() == null || $("input[name=GUBN_START]").val() == "" ||
   	     $("input[name=DLVY_AMT]").val() == null || $("input[name=DLVY_AMT]").val() == "") {
	   		  	alert("배송비 상세 설정을 입력하세요.");
	   		  	$("input[name=SHIP_GUBN]").focus();
	   		  	return false;
   	  }
    } else if($("select[name=SHIP_GUBN]").val() == "SHIP_GUBN_03" || $("select[name=SHIP_GUBN]").val() == "SHIP_GUBN_04") {
   	  if($("input[name=GUBN_STARTS]").val() == null || $("input[name=GUBN_STARTS]").val() == "" || 
   	     $("input[name=GUBN_ENDS]").val() == null || $("input[name=GUBN_ENDS]").val() == "" ||
   	     $("input[name=DLVY_AMTS]").val() == null || $("input[name=DLVY_AMTS]").val() == "") {
   		  alert("배송비 상세 설정을 입력하세요.");
   		  $("input[name=SHIP_GUBN]").focus();
   		  return false;
   	  }
    }
	    
    if($("input[name=RFND_DLVY_AMT]").val() == null || $("input[name=RFND_DLVY_AMT]").val() == "") {
   	  alert("반품 배송비를 입력하세요.");
   	  $("input[name=RFND_DLVY_AMT]").focus();
   	  return false;
    }
    
	var total = $("input[name=DLVY_AMTS]").length + 1;
	var url = '';
	
	if(text == 'insert') url = 'insertTemplete'; else url = 'updateTemplete';
	
	//템플릿명 넘기기
	var temp_name = $("input[name=TEMP_NAME]").val();
    $("input[name=NEW_TEMP_NAME]").val(temp_name);
    var new_temp_name = $("input[name=NEW_TEMP_NAME]").val();
    
	//opener.document.getElementById("NEW_TEMP_NUM").value = document.getElementById("NEW_TEMP_NUM").value;
	opener.document.getElementById("NEW_TEMP_NAME").value = document.getElementById("NEW_TEMP_NAME").value;
	
	$.ajax({
		type: "POST",
		url: "${contextPath}/adm/productMgr/" + url,
		data: $("#templeteFrm").serialize(),
		success: function (data) {
			console.log(data);
			if(data == total) {
				opener.setTempName(new_temp_name);
				alert("배송 상세 정보가 저장되었습니다.");
				location.href = "${contextPath}/adm/productMgr/getTempletePop";
			} else {
				alert("배송 정보 저장 중 문제가 발생했습니다. 관리자에게 문의하세요.");
				location.href = "${contextPath}/adm/productMgr/getTempletePop";
			}
		}, error: function (jqXHR, textStatus, errorThrown) {
			alert("처리중 에러가 발생했습니다. 관리자에게 문의하세요.(error:"+textStatus+")");
			location.href = "${contextPath}/adm/productMgr/getTempletePop";
		}
	});
}
</script>