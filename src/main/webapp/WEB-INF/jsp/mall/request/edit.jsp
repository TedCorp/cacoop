<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:set var="orderEditYN" value="N" />
<c:if test="${rtnMaster.ORDER_CON eq 'XORDER_CON_01'}">
	 <c:set var="orderEditYN" value="Y" />
</c:if>

<script type="text/javascript">
var nRowNum = 1;
$(function() {

	$('#btnDeliveryAdd').click(function(){

		if( $("#tbodyDelivery tr").length >= 5 ){
			alert("추가 배송지는 5개까지 입력가능합니다.");
			return false;
		}
			
		nRowNum++;
		var strData = "";

		strData += "<tr id=\"trDeliver_" + nRowNum + "\">";
		strData += "	<td class=\"grid_2\">";
		strData += "		<input type=\"text\" id=\"DLVY_NAMES\" required class=\"frm_input DLVY_NAMES\" name=\"DLVY_NAMES\" ROWNUMS=\"" + nRowNum + "\" value=\"추가배송" + nRowNum + "\" size=\"6\">";
		strData += "	</td>";
		strData += "	<td>";
		strData += "		<input type=\"hidden\" id=\"DLVY_ROWNUMS\" name=\"DLVY_ROWNUMS\" value=\"" + nRowNum + "\">";
		strData += "		<input type=\"text\" id=\"STAFF_NAMES\" required class=\"frm_input\" name=\"STAFF_NAMES\" size=\"6\">";
		strData += "	</td>";
		strData += "	<td class=\"grid_5\">";
		strData += "		<input type=\"hidden\" name=\"STAFF_CPONS\" id=\"STAFF_CPONS\" required class=\"frm_input\" maxlength=\"20\">";
		strData += "		<input type=\"text\" name=\"STAFF_CPONS1\" id=\"STAFF_CPONS1\" required class=\"frm_input\" maxlength=\"4\" size=\"4\">&nbsp;-&nbsp;";
		strData += "		<input type=\"text\" name=\"STAFF_CPONS2\" id=\"STAFF_CPONS2\" required class=\"frm_input\" maxlength=\"4\" size=\"4\">&nbsp;-&nbsp;";
		strData += "		<input type=\"text\" name=\"STAFF_CPONS3\" id=\"STAFF_CPONS3\" required class=\"frm_input\" maxlength=\"4\" size=\"4\">";
		strData += "	</td>";
		strData += "	<td class=\"grid_10\">";
		strData += "		<label for=\"POST_NUMS\" class=\"sound_only\">우편번호</label>";
		strData += "		<input type=\"text\" name=\"POST_NUMS\"id=\"POST_NUMS" + nRowNum + "\" required class=\"frm_input\" size=\"5\" maxlength=\"6\">";
		strData += "		<button type=\"button\" class=\"btn_frmline\" onclick=\"win_zip_id('saveFrm', 'POST_NUMS" + nRowNum + "', 'BASC_ADDRS" + nRowNum + "', 'DTL_ADDRS" + nRowNum + "', 'EXTRA_ADDRS" + nRowNum + "', 'POST_GUBUNS" + nRowNum + "');\">주소 검색</button><br>";
		strData += "		<input type=\"text\" name=\"BASC_ADDRS\"id=\"BASC_ADDRS" + nRowNum + "\" required class=\"frm_input frm_address\" size=\"27\">";
		strData += "		<input type=\"text\" name=\"DTL_ADDRS\"id=\"DTL_ADDRS" + nRowNum + "\" required class=\"frm_input frm_address\" size=\"27\">";
		strData += "		<input type=\"hidden\" name=\"EXTRA_ADDRS\"id=\"EXTRA_ADDRS" + nRowNum + "\">";
		strData += "		<input type=\"hidden\" name=\"POST_GUBUNS\"id=\"POST_GUBUNS" + nRowNum + "\">";
		strData += "	</td>";
		strData += "	<td class=\"grid_1\">";
		strData += "		<button type=\"button\" class=\"btn btn-sm btn-danger btnDelRow\" ROWNUMS=\"" + nRowNum + "\">삭제</button>	";
		strData += "	</td>";
		strData += "</tr>";
		
		$('#tbodyDelivery').append(strData);

		$(".selectDelivery").append("<option value='" + nRowNum + "'>추가배송" + nRowNum + "</option>");
		
	});


    $(document).on('click', '.btnDelRow', function() {
    	
    	var rowNums = $(this).attr("ROWNUMS");
		var bChk = true;
		
    	//삭제하기전 사용중인 배송지일경우 메세지
		$(".selectDelivery").each(function() {
			if(rowNums == $(this).val()){
				alert("주문 상품의 배송지로 선택되어 있습니다. 배송지 변경 후 삭제 하세요.");
				bChk = false;
				$(this).focus();
				return false;
			}
		});
    	
    	if(bChk){
    		var clickedRow = $(this).parent().parent();
    		clickedRow.remove();
    		
    		$(".selectDelivery option[value='"+rowNums+"']").remove();
    		
    	}
		
		
    });
    
    //숫자만 입력토록 함.
    $(document).on("keyup", ".number", function() {
    	$(this).number(true);
    });
    
    $(document).on("blur", ".inpOrderQty", function() {
    	var nIndex = $(this).index(".inpOrderQty");			//현제 인덱스 

    	var nQty = $(this).val();
    	var nPrice = $(this).attr("price");
    	
    	var nOrderAmt = parseInt(nPrice) * parseInt(nQty);
    	$(".divOrderAmt").eq(nIndex).text(number_format(String(nOrderAmt)));
    	$("input[name='ORDER_AMTS']").eq(nIndex).val(nOrderAmt);
    	
    	fnTotalAmt();
    });

    $(document).on("change", ".DLVY_NAMES", function() {

    	var rowNums = $(this).attr("ROWNUMS");
		$(".selectDelivery option[value='"+rowNums+"']").text($(this).val());
    	
    });
    

    $(document).on('click', '.btnProductCopyRow', function() {
     	var clickedRow = $(this).parent().parent();
     	var newrow = clickedRow.clone(); //tr복사

     	var nIndex = $(this).index(".btnProductCopyRow");			//현재 인덱스 
        
        $('#tbodyProduct tr:eq('+nIndex+')').after(newrow);
     	
        fnTotalAmt();
    });
    

    $(document).on('click', '.btnProductDelRow', function() {

		if( $("#tbodyProduct tr").length == 2 ){		//합계 로우
			alert("상품은 모두 삭제 할 수 없습니다.");
			return false;
		}

     	var nIndex = $(this).index(".btnProductDelRow");			//현재 인덱스 
		if(!confirm("[" + $("input[name='PD_NAMES']").eq(nIndex).val() + "] 상품을 삭제 하시겠습니까?")) {
			return false;
		}
		
		var clickedRow = $(this).parent().parent();
		clickedRow.remove();

        fnTotalAmt();
		
    });
    
    $(document).on("change", ".selectDelivery", function() {
    	var strValue = $(this).val();
    	
    	if(strValue == 'etc'){
			alert("개별배송을 원하실 경우 [기본정보>개별배송 첨부파일]에 개별 배송지 정보를 작성하여 업로드 부탁드립니다.(양식 참고)\n개별배송이 많을 경우 추가 배송비가 발생 할 수도 있습니다.");
    	}
    	
    });
    
    // 목록가기
    $("#btnList").click(function() {
		
    	history.go(-1);
    });
    
    // 개별배송 양식 다운로드
    $("#btnTempDown").click(function() {
    	document.location.href = "${contextPath }/common/commonFileDown?ATFL_ID=000000000004&ATFL_SEQ=1"; 
    });    
    
    // 신용카드 양식 다운로드
    $("#btnCardDown").click(function() {
    	document.location.href = "${contextPath }/common/commonFileDown?ATFL_ID=000000000005&ATFL_SEQ=1"; 
    });
    

    $("#fileCARD").change(function () {

        var maxSize  = 2 * 1024 * 1024;   //2MB
		var iSize = 0;
		var browser=navigator.appName;
		
		if (browser=="Microsoft Internet Explorer"){
			var objFSO = new ActiveXObject("Scripting.FileSystemObject");
			var sPath = $("#fileCARD")[0].value;
			var objFile = objFSO.getFile(sPath);
			var iSize = objFile.size;
			iSize = iSize;
		}else {
			iSize = ($("#fileCARD")[0].files[0].size);
		}
	

		if(iSize>maxSize){
			iSize = (Math.round((iSize / 1024 / 1024) * 100) / 100);
			alert("파일 최대 용량은 2MB입니다.\n선택 파일 크기 : " + iSize + "MB" );
			$(this).val("");
		}
    });
});

function saveFrm_submit(f){

	$('#COM_TEL').val($('#COM_TEL1').val()+"-"+$('#COM_TEL2').val()+"-"+$('#COM_TEL3').val());
	//$('#BIZR_NUM').val($('#BIZR_NUM1').val()+"-"+$('#BIZR_NUM2').val()+"-"+$('#BIZR_NUM3').val());
	$('#STAFF_CPON').val($('#STAFF_CPON1').val()+"-"+$('#STAFF_CPON2').val()+"-"+$('#STAFF_CPON3').val());

	var arrivalYear = $('#ARRIVAL_DATE_YEAR').val();
	var arrivalMonth = $('#ARRIVAL_DATE_MONTH').val();
	var arrivalDay = $('#ARRIVAL_DATE_DAY').val();
	
	$('#ARRIVAL_DATE').val(arrivalYear+"-"+(fn_LPAD(arrivalMonth,'0',2))+"-"+(fn_LPAD(arrivalDay,'0',2)));
	
	$("input[name='STAFF_CPONS1']").each(function() {
     	var nIndex = $(this).index("input[name='STAFF_CPONS1']");			//현재 인덱스 
     	var strData = $("input[name='STAFF_CPONS1']").eq(nIndex).val()+"-"+$("input[name='STAFF_CPONS2']").eq(nIndex).val()+"-"+$("input[name='STAFF_CPONS3']").eq(nIndex).val();
     	$("input[name='STAFF_CPONS']").eq(nIndex).val(strData);
	});
	

	var bChk = true;
	var strMsg = "";
	
	$("input[name='DLVY_NAMES']").each(function() {
		if($(this).val() == ""){
			strMsg = "추가배송지 명칭";
			$(this).focus();
	     	bChk = false;
	     	return false;
		}
	});
	
	if(!bChk){
		alert(strMsg + "는(은) 필수 입력 항목입니다.\n추가배송지가 없으면 [삭제] 버튼으로 삭제하세요.");
    	return false;
	}
	

	$("input[name='STAFF_NAMES']").each(function() {
		if($(this).val() == ""){
			strMsg = "담당자명";
			$(this).focus();
	     	bChk = false;
	     	return false;
		}
	});
	
	if(!bChk){
		alert(strMsg + "는(은) 필수 입력 항목입니다.\n추가배송지가 없으면 [삭제] 버튼으로 삭제하세요.");
    	return false;
	}
	
	$("input[name='STAFF_CPONS1']").each(function() {
		if($(this).val() == ""){
			strMsg = "담당자 연락처1";
			$(this).focus();
	     	bChk = false;
	     	return false;
		}
	});
	
	if(!bChk){
		alert(strMsg + "는(은) 필수 입력 항목입니다.\n추가배송지가 없으면 [삭제] 버튼으로 삭제하세요.");
    	return false;
	}
	
	$("input[name='STAFF_CPONS2']").each(function() {
		if($(this).val() == ""){
			strMsg = "담당자 연락처2";
			$(this).focus();
	     	bChk = false;
	     	return false;
		}
	});
	
	if(!bChk){
		alert(strMsg + "는(은) 필수 입력 항목입니다.\n추가배송지가 없으면 [삭제] 버튼으로 삭제하세요.");
    	return false;
	}
	
	$("input[name='STAFF_CPONS3']").each(function() {
		if($(this).val() == ""){
			strMsg = "담당자 연락처3";
			$(this).focus();
	     	bChk = false;
	     	return false;
		}
	});
	
	if(!bChk){
		alert(strMsg + "는(은) 필수 입력 항목입니다.\n추가배송지가 없으면 [삭제] 버튼으로 삭제하세요.");
    	return false;
	}

	$("input[name='POST_NUMS']").each(function() {
		if($(this).val() == ""){
			strMsg = "우편번호";
			$(this).focus();
	     	bChk = false;
	     	return false;
		}
	});
	
	if(!bChk){
		alert(strMsg + "는(은) 필수 입력 항목입니다.\n추가배송지가 없으면 [삭제] 버튼으로 삭제하세요.");
    	return false;
	}


	$("input[name='BASC_ADDRS']").each(function() {
		if($(this).val() == ""){
			strMsg = "기본주소";
			$(this).focus();
	     	bChk = false;
	     	return false;
		}
	});
	
	if(!bChk){
		alert(strMsg + "는(은) 필수 입력 항목입니다.\n추가배송지가 없으면 [삭제] 버튼으로 삭제하세요.");
    	return false;
	}


	$("input[name='DTL_ADDRS']").each(function() {
		if($(this).val() == ""){
			strMsg = "상세주소";
			$(this).focus();
	     	bChk = false;
	     	return false;
		}
	});
	
	if(!bChk){
		alert(strMsg + "는(은) 필수 입력 항목입니다.\n추가배송지가 없으면 [삭제] 버튼으로 삭제하세요.");
    	return false;
	}
	
	return true;	
}



function fnTotalAmt(){

	var nTotOrderAmt = 0;


	$("input[name='ORDER_AMTS']").each(function() {
		nTotOrderAmt += parseInt($(this).val());
		
	});
	
	$('#divTotOrderAmt').text("총 상품 구매액 "+number_format(String(nTotOrderAmt))+"원");
	$('#ORDER_AMT').val(nTotOrderAmt);
	
}

function goDownLoad(url){ 
	document.location.href = url; 
} 

function fn_fileDelete(obj, ATFL_ID, ATFL_SEQ)
{

	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	
	$("#delATFL_ID").val(ATFL_ID);
	$("#delATFL_SEQ").val(ATFL_SEQ);
	
	$.ajax({
         type:"POST",
         url:"${contextPath}/common/commonFileDelete",
         data: $("form[name='delFrm']").serialize(),
         success : function(data) {
        	 var result = data.result;
        	 var contents = "";	
	   			
	       		$('.file_'+ATFL_ID+'_'+ATFL_SEQ).remove();
	       		obj.remove();
         },
         error : function(xhr, status, error) {
               alert(error);
         }
   });
}
</script>

	<div id="wrapper_title">주문하기</div>

	<form  name="saveFrm" id="saveFrm" action="${contextPath }/request/edit" onsubmit="return saveFrm_submit(this);" method="POST" autocomplete="off" enctype="multipart/form-data">
	<input type="hidden" name="ORDER_NUM" id="ORDER_NUM" value="${rtnMaster.ORDER_NUM }">
	<input type="hidden" name="ATFL_ID" value="${ rtnMaster.ATFL_ID }"/>
	<input type="hidden" name="DLVY_ATFL" value="${ rtnMaster.DLVY_ATFL }"/>
	<input type="hidden" name="CARD_ATFL" value="${ rtnMaster.CARD_ATFL }"/>


	<div id="wrapper_title_sub">기본정보 - 필수 입력</div>
	<div class="mbskin">
	    <div class="tbl_frm01 tbl_wrap">
	        <table>
		        <tbody>
		        <tr>
		            <th scope="row"><label for="COM_NAME">회사명<strong class="sound_only">필수</strong></th>
		            <td>
		                <input type="text" name="COM_NAME" value="${rtnMaster.COM_NAME }" id="COM_NAME" required class="frm_input" maxlength="15">
		            </td>
		            <th scope="row"><label for="CEO_NAME">대표자명<strong class="sound_only">필수</strong></th>
		            <td>
		                <input type="text" name="CEO_NAME" value="${rtnMaster.CEO_NAME }" id="CEO_NAME" required class="frm_input" maxlength="15">
		            </td>
		        </tr>
		        <tr>
		            <th scope="row"><label for="BIZR_NUM1">사업자등록번호<strong class="sound_only">필수</strong></th>
		            <td>
		            	<input type="hidden" name="BIZR_NUM" id="BIZR_NUM" value="${rtnMaster.BIZR_NUM }">
		            	${rtnMaster.BIZR_NUM }
		            	<!-- 
						<c:set var="arrBIZR_NUM" value="${fn:split(rtnMaster.BIZR_NUM, '-') }" /> 
		                <input type="text" name="BIZR_NUM1" value="${arrBIZR_NUM[0] }" id="BIZR_NUM1" required class="frm_input" maxlength="3" size="3">&nbsp;-&nbsp;
		                <input type="text" name="BIZR_NUM2" value="${arrBIZR_NUM[1] }" id="BIZR_NUM2" required class="frm_input" maxlength="2" size="2">&nbsp;-&nbsp;
		                <input type="text" name="BIZR_NUM3" value="${arrBIZR_NUM[2] }" id="BIZR_NUM3" required class="frm_input" maxlength="5" size="5">
		                 -->
		            </td>
		            <th scope="row"><label for="COM_TEL1">회사전화번호<strong class="sound_only">필수</strong></label></th>
		            <td>
		            	<input type="hidden" name="COM_TEL" id="COM_TEL" value="${rtnMaster.COM_TEL }">
		            	
						<c:set var="arrCOM_TEL" value="${fn:split(rtnMaster.COM_TEL, '-') }" /> 
		            	<input type="text" name="COM_TEL1" value="${arrCOM_TEL[0] }" id="COM_TEL1" required  class="frm_input" maxlength="4" size="4">&nbsp;-&nbsp;
		            	<input type="text" name="COM_TEL2" value="${arrCOM_TEL[1] }" id="COM_TEL2" required  class="frm_input" maxlength="4" size="4">&nbsp;-&nbsp;
		            	<input type="text" name="COM_TEL3" value="${arrCOM_TEL[2] }" id="COM_TEL3" required  class="frm_input" maxlength="4" size="4">
		            </td>
		        </tr>
		        <tr>
		            <th scope="row"><label for="STAFF_NAME">담당자<strong class="sound_only">필수</strong></label></th>
		            <td>
		                <input type="text" name="STAFF_NAME" value="${rtnMaster.STAFF_NAME }" id="STAFF_NAME" required class="frm_input" maxlength="15">
		            </td>
		            <th scope="row"><label for="STAFF_CPON1">담당자 휴대폰번호<strong class="sound_only">필수</strong></label></th>
		            <td>
		                <input type="hidden" name="STAFF_CPON" value="${rtnMaster.STAFF_CPON }" id="STAFF_CPON" required class="frm_input" maxlength="20">
		            	
						<c:set var="arrSTAFF_CPON" value="${fn:split(rtnMaster.STAFF_CPON, '-') }" /> 
		                <input type="text" name="STAFF_CPON1" value="${arrSTAFF_CPON[0] }" id="STAFF_CPON1" required class="frm_input" maxlength="4" size="4">&nbsp;-&nbsp;
		                <input type="text" name="STAFF_CPON2" value="${arrSTAFF_CPON[1] }" id="STAFF_CPON2" required class="frm_input" maxlength="4" size="4">&nbsp;-&nbsp;
		                <input type="text" name="STAFF_CPON3" value="${arrSTAFF_CPON[2] }" id="STAFF_CPON3" required class="frm_input" maxlength="4" size="4">
		            </td>
		        </tr>
		        <tr>
		            <th scope="row"><label for="STAFF_MAIL">담당자EMAIL<br>(계산서발행)<strong class="sound_only">필수</strong></label></th>
		            <td colspan="3">
		                <input type="text" name="STAFF_MAIL" value="${rtnMaster.STAFF_MAIL }" id="STAFF_MAIL" required class="frm_input" maxlength="50">
		            </td>
		        </tr>
		        <tr>
		            <th scope="row">회사주소<BR>(기본배송지)</th>
		            <td colspan="3">
		                <label for="POST_NUM" class="sound_only">우편번호</label>
		                <input type="text" name="POST_NUM" value="${rtnMaster.POST_NUM }" id="POST_NUM" required class="frm_input" size="5" maxlength="6">
		                <button type="button" class="btn_frmline" onclick="win_zip_id('saveFrm', 'POST_NUM', 'BASC_ADDR', 'DTL_ADDR', 'EXTRA_ADDR', 'ALL_ADDR');">주소 검색</button><br>
		                <input type="text" name="BASC_ADDR" value="${rtnMaster.BASC_ADDR }" id="BASC_ADDR" required class="frm_input frm_address" size="50">
		                <label for="BASC_ADDR">기본주소</label><br>
		                <input type="text" name="DTL_ADDR" value="${rtnMaster.DTL_ADDR }" id="DTL_ADDR" class="frm_input frm_address" size="50">
		                <label for="DTL_ADDR">상세주소</label>
		                <input type="hidden" name="EXTRA_ADDR" value="${rtnMaster.EXTRA_ADDR }" id="EXTRA_ADDR">
		                <input type="hidden" name="ALL_ADDR" value="" id="ALL_ADDR">
		            </td>
		        </tr>
		        <tr>
		            <th scope="row">상품도착요청일</th>
		            <td colspan="3">
		            	<input type="hidden" name="ARRIVAL_DATE" value="${rtnMaster.ARRIVAL_DATE }" id="ARRIVAL_DATE">
		            	<input type="text" name="ARRIVAL_DATE_YEAR" value="2017" id="ARRIVAL_DATE_YEAR" required class="frm_input" maxlength="4" size="4" readonly="readonly">년
		            	<select name="ARRIVAL_DATE_MONTH" id="ARRIVAL_DATE_MONTH">
			            	﻿<c:forEach var="i" begin="1" end="1" step="1">
							<option value="${i}">${i}</option>
							</c:forEach>﻿ 
		            	</select>월
		            	<select name="ARRIVAL_DATE_DAY" id="ARRIVAL_DATE_DAY">
			            	﻿<c:forEach var="i" begin="12" end="26" step="1">
							<option value="${i}">${i}</option>
							</c:forEach>﻿ 
		            	</select>월
	                
		            </td>
		        </tr>
		        <tr>
			        <th scope="row"><label for="ORDER_MSG">주문 메모</label></th>
		            <td colspan="3">
		                <textarea id="ORDER_MSG" name="ORDER_MSG" rows="10" cols="100">${rtnMaster.ORDER_MSG }</textarea>
		            </td>
		        </tr>
		        <tr>
			        <th scope="row"><label for="file">첨부파일<br>(사업자등록증)</label></th>
		            <td colspan="3">
						<c:if test="${ !empty(fileList) }">
				        	<c:forEach var="var" items="${ fileList }" varStatus="status">
								<label class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" for="seq${var.ATFL_SEQ}">${var.ORFL_NAME }</label>
								<button type="button" class="btn btn-xs btn-primary file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:goDownLoad('${contextPath }/common/commonFileDown?ATFL_ID=${var.ATFL_ID }&ATFL_SEQ=${var.ATFL_SEQ}')" >다운로드</button>
								<button type="button" class="btn btn-xs btn-danger file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:fn_fileDelete(this, '${var.ATFL_ID}', '${var.ATFL_SEQ}')">삭제</button>
				        		<br>
              	
			                </c:forEach>
			            </c:if>
		                <input name="file" type="file" id="file">
		            </td>
		        </tr>
		        <tr>
			        <th scope="row"><label for="fileDLVY">개별배송 첨부파일<br></label>
		                <button type="button" class="btn_frmline" id="btnTempDown">양식 다운로드</button>
			        </th>
		            <td colspan="3">
						<c:if test="${ !empty(fileListDLVY) }">
				        	<c:forEach var="var" items="${ fileListDLVY }" varStatus="status">
								<label class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" for="seq${var.ATFL_SEQ}">${var.ORFL_NAME }</label>
								<button type="button" class="btn btn-xs btn-primary file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:goDownLoad('${contextPath }/common/commonFileDown?ATFL_ID=${var.ATFL_ID }&ATFL_SEQ=${var.ATFL_SEQ}')" >다운로드</button>
								<button type="button" class="btn btn-xs btn-danger file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:fn_fileDelete(this, '${var.ATFL_ID}', '${var.ATFL_SEQ}')">삭제</button>
				        		<br>
              	
			                </c:forEach>
			            </c:if>
		                <input name="fileDLVY" type="file" id="fileDLVY">
		            </td>
		        </tr>
		        <tr>
		            <th scope="row"><label for="ORDER_PW">주문비밀번호<strong class="sound_only">필수</strong></label></th>
		            <td colspan="3">
		                <input type="password" name="ORDER_PW" value="" id="ORDER_PW" required class="frm_input">
		                <label for="ORDER_PW"> * 주문 내역 조회 및 수정시 사업자번호와 함께 사용 됩니다.</label>
		            </td>
		        </tr>
		        </tbody>
	        </table>
	    </div>
	    
	</div>


	<div id="wrapper_title_sub" style="padding:0 0 10px 0;">추가 배송지
		<button type="button" class="btn btn-sm btn-primary pull-right" id="btnDeliveryAdd">추가하기</button>	
	</div>

	<div id="sod_bsk">
		<div class="tbl_head01 tbl_wrap">
			<table>
				<thead>
					<tr>
						<th scope="col">명칭</th>
						<th scope="col">담당자</th>
						<th scope="col">담당자휴대폰</th>
						<th scope="col">배송지 주소</th>
						<th scope="col">삭제</th>
					</tr>
				</thead>
				<tbody id="tbodyDelivery">
					<c:set var="maxDLVY_ROWNUM" value="0" />
					<c:if test="${ !empty(rtnDelivery.list) }">
			        	<c:forEach var="ent" items="${ rtnDelivery.list }" varStatus="status">
			        		<c:set var="maxDLVY_ROWNUM" value="${ent.DLVY_ROWNUM }" />
							<tr id="trDeliver_${ent.DLVY_ROWNUM }">
								<td class="grid_2">
									<input type="hidden" id="DLVY_ROWNUMS" name="DLVY_ROWNUMS" value="${ent.DLVY_ROWNUM }">
									<input type="text" id="DLVY_NAMES" required class="frm_input DLVY_NAMES" name="DLVY_NAMES"  ROWNUMS="${ent.DLVY_ROWNUM }" value="${ent.DLVY_NAME }" size="6">
								</td>
								<td>
									<input type="text" id="STAFF_NAMES" required class="frm_input" name="STAFF_NAMES" value="${ent.STAFF_NAME }" size="6">
								</td>
								<td class="grid_5">
					                <input type="hidden" name="STAFF_CPONS" value="" id="STAFF_CPONS" required class="frm_input" maxlength="20">
					                
									<c:set var="arrSTAFF_CPONS" value="${fn:split(ent.STAFF_CPON, '-') }" /> 
					                <input type="text" name="STAFF_CPONS1" value="${arrSTAFF_CPON[0] }" id="STAFF_CPONS1" required class="frm_input" maxlength="4" size="4">&nbsp;-&nbsp;
					                <input type="text" name="STAFF_CPONS2" value="${arrSTAFF_CPON[1] }" id="STAFF_CPONS2" required class="frm_input" maxlength="4" size="4">&nbsp;-&nbsp;
					                <input type="text" name="STAFF_CPONS3" value="${arrSTAFF_CPON[2] }" id="STAFF_CPONS3" required class="frm_input" maxlength="4" size="4">
								</td>
								<td class="grid_10">
					                <label for="POST_NUMS" class="sound_only">우편번호</label>
					                <input type="text" name="POST_NUMS" value="${ent.POST_NUM }" id="POST_NUMS1" required class="frm_input" size="5" maxlength="6">
					                <button type="button" class="btn_frmline" onclick="win_zip_id('saveFrm', 'POST_NUMS1', 'BASC_ADDRS1', 'DTL_ADDRS1', 'EXTRA_ADDRS1', 'POST_GUBUNS1');">주소 검색</button><br>
					                <input type="text" name="BASC_ADDRS" value="${ent.BASC_ADDR }" id="BASC_ADDRS1" required class="frm_input frm_address" size="27">
					                <input type="text" name="DTL_ADDRS" value="${ent.DTL_ADDR }" id="DTL_ADDRS1" required class="frm_input frm_address" size="27">
					                <input type="hidden" name="EXTRA_ADDRS" value="" id="EXTRA_ADDRS1">
					                <input type="hidden" name="POST_GUBUNS" value="" id="POST_GUBUNS1">
								</td>
								<td class="grid_1">
									<button type="button" class="btn btn-sm btn-danger btnDelRow" ROWNUMS="${ent.DLVY_ROWNUM }">삭제</button>	
								</td>
							</tr>
		                </c:forEach>
		            </c:if>
		            
				</tbody>
			</table>
		</div>

	</div>
	
	<div id="wrapper_title_sub">주문 상품 목록 - 하나의 상품을 두곳으로 배송시 [복사추가] 버튼을 이용해 상품을 추가하세요.</div>
		
	<!-- 글자크기 조정 display:none 되어 있음 시작 { -->
	<div id="sod_bsk">
		<div class="tbl_head01 tbl_wrap">
			<table>
				<thead>
					<tr>
						<th scope="col">상품명</th>
						<th scope="col">수량</th>
						<th scope="col">판매가</th>
						<th scope="col">상품구매금액</th>
						<th scope="col">배송지</th>
						<th scope="col">복사</th>
					</tr>
				</thead>
				<tbody id="tbodyProduct" >
					<c:set var="tot_amt" value="0" />
					<c:forEach items="${rtnMaster.list }" var="list" varStatus="loop">
					<c:set var="realPrice" value="${ list.PD_PRICE }" />
					<c:if test="${ list.PDDC_GUBN ne 'PDDC_GUBN_01' }">
						<c:set var="nDiscount" value="0" />
						<c:if test="${ list.PDDC_GUBN eq 'PDDC_GUBN_02' }">
							<c:set var="nDiscount" value="${list.PDDC_VAL }" />
						</c:if>
						<c:if test="${ list.PDDC_GUBN eq 'PDDC_GUBN_03' }">
							<c:set var="nDiscount" value="${ list.PD_PRICE* list.PDDC_VAL/100 }" />
						</c:if>
						<c:set var="realPrice" value="${ list.PD_PRICE - nDiscount }" />
					</c:if>
					<tr>
						<td class="sod_img">
							<input type="hidden" id="PD_CODES" name="PD_CODES" value="${list.PD_CODE }">
							<input type="hidden" id="PD_NAMES" name="PD_NAMES" value="${list.PD_NAME}" />
							<input type="hidden" id="PD_PRICES" name="PD_PRICES" value="${list.PD_PRICE}" />
							<input type="hidden" id="PDDC_GUBNS" name="PDDC_GUBNS" value="${list.PDDC_GUBN}" />
							<input type="hidden" id="PDDC_VALS" name="PDDC_VALS" value="${list.PDDC_VAL}" />
							
							<!-- input type="hidden" id="DLVY_NAMES" name="DLVY_NAMES" value="" / -->
							<b>${list.PD_NAME }</b>
						</td>
						<td class="td_num">
							<c:if test="${orderEditYN eq 'N' }">
								<input type="hidden" id="ORDER_QTYS" name="ORDER_QTYS" price="${realPrice }" value="${list.ORDER_QTY}" size="2" />
								${list.ORDER_QTY}
							</c:if>
							<c:if test="${orderEditYN eq 'Y' }">
								<input type="text" id="ORDER_QTYS" name="ORDER_QTYS" required maxlength="4" class="frm_input number inpOrderQty" style="text-align:right;" price="${realPrice }" value="${list.ORDER_QTY}" size="2" />
							</c:if>
						</td>
						<td class="td_numbig">
							<c:if test="${ realPrice ne list.PD_PRICE }">
								<strike><fmt:formatNumber value="${ list.PD_PRICE }" pattern="#,###"/>원</strike><br>
							</c:if>
							<fmt:formatNumber value="${ realPrice }" pattern="#,###"/>원
						</td>
						<td class="td_num">
							<div id="divOrderAmt" class="divOrderAmt"><fmt:formatNumber value="${list.ORDER_QTY * realPrice }" /></div>
							<input type="hidden" id="ORDER_AMTS" name="ORDER_AMTS" value="${list.ORDER_QTY * realPrice }" />
						</td>
						<td class="grid_2">
							<select name="SELECT_DLVY_ROWNUMS" class="form-control select2 selectDelivery" style="width: 100%;">
								<option value="base" selected="selected">기본배송지</option>
								<option value="etc">개별배송</option>
							</select>
						</td>
						<td class="grid_2">
							<c:if test="${orderEditYN eq 'N' }">
								<button type="button" class="btn btn-sm btn-primary disabled">복사 추가</button>	
								<button type="button" class="btn btn-sm btn-danger disabled">삭제</button>	
							</c:if>
							<c:if test="${orderEditYN eq 'Y' }">
								<button type="button" class="btn btn-sm btn-primary btnProductCopyRow">복사 추가</button>	
								<button type="button" class="btn btn-sm btn-danger btnProductDelRow">삭제</button>	
							</c:if>
						</td>
					</tr>
					<c:set var="tot_amt" value="${tot_amt + (list.ORDER_QTY * realPrice) }" />
					</c:forEach>
					<tr>
						<td class="td_num" colspan="6">
							<div id="divTotOrderAmt">총 상품 구매액 <fmt:formatNumber value="${tot_amt }" />원</div>
						</td>
					</tr>
					<input type="hidden" id="ORDER_AMT" name="ORDER_AMT" value="${tot_amt}"/>
				</tbody>
			</table>
		</div>

	</div>

	<div id="wrapper_title_sub">결제정보</div>
	<div class="mbskin">
	    <div class="tbl_frm01 tbl_wrap">
	        <table>
		        <tbody>
		        <tr>
		            <th scope="row">주문상태</th>
		            <td>
		            	${rtnMaster.ORDER_CON_NM }
		            </td>
		        </tr>
		        <tr>
		            <th scope="row"><label for="PAY_METD">결제방식</label></th>
		            <td>
						<c:if test="${orderEditYN eq 'N' }">
							<input type="hidden" id="PAY_METD" name="PAY_METD" value="${rtnMaster.PAY_METD}" />
							${rtnMaster.PAY_METD_NM }
						</c:if>
						<c:if test="${orderEditYN eq 'Y' }">
							<jsp:include page="/common/comCodForm" flush="false">
								<jsp:param name="COMM_CODE" value="XPAY_METD" />
								<jsp:param name="name" value="PAY_METD" />
								<jsp:param name="value" value="${rtnMaster.PAY_METD }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="width" value="300" />
							</jsp:include>
						</c:if>
		            </td>
		        </tr>
		        <tr id="trCardView">
			        <th scope="row"><label for="fileCARD">카드결제 서류<br></label>
		                <button type="button" class="btn_frmline" id="btnCardDown">양식 다운로드</button>
		            </th>
		            <td>
						<c:if test="${ !empty(fileListCARD) }">
				        	<c:forEach var="var" items="${ fileListCARD }" varStatus="status">
								<label class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" for="seq${var.ATFL_SEQ}">${var.ORFL_NAME }</label>
								<button type="button" class="btn btn-xs btn-primary file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:goDownLoad('${contextPath }/common/commonFileDown?ATFL_ID=${var.ATFL_ID }&ATFL_SEQ=${var.ATFL_SEQ}')" >다운로드</button>
								<button type="button" class="btn btn-xs btn-danger file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:fn_fileDelete(this, '${var.ATFL_ID}', '${var.ATFL_SEQ}')">삭제</button>
				        		<br>
              	
			                </c:forEach>
			            </c:if>
		                <input name="fileCARD" type="file" id="fileCARD">
		            </td>
		        </tr>
		        </tbody>
	        </table>
	    </div>
	    
	</div>
	
	<div class="alert alert-danger alert-dismissible">
	  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	  <h4><i class="icon fa fa-ban"></i> 개별 배송관련 알림!</h4>
		택배발송시 50,000원 이하 상품의 개별 배송 비용은 2,500원 입니다.(계산서 발행시 개별 배송비 추가)<br>
		단 한곳으로 묶은배송은 무료입니다.
	</div>
	
	<div class="text-center">
		<button type="button" class="btn btn-sm btn-default" id="btnList">이전</button>

    	<c:if test="${rtnMaster.ORDER_CON eq 'XORDER_CON_01' || rtnMaster.ORDER_CON eq 'XORDER_CON_02' || rtnMaster.ORDER_CON eq 'XORDER_CON_03' || rtnMaster.ORDER_CON eq 'XORDER_CON_04' }">
       		<button type="submit" class="btn btn-sm btn-success btnSave">저장</button>
        </c:if>
		
	</div>
</form>

<form id="delFrm" name="delFrm" class="form-horizontal" method="post">
	<input type="hidden" name="ATFL_ID" id="delATFL_ID" />
	<input type="hidden" name="ATFL_SEQ" id="delATFL_SEQ" />
</form>

<script type="text/javascript">
$(function() {

	nRowNum = ${maxDLVY_ROWNUM};
	

	<c:forEach var="ent" items="${ rtnDelivery.list }" varStatus="status">
		$(".selectDelivery").append("<option value='${ent.DLVY_ROWNUM }'>${ent.DLVY_NAME }</option>");
	</c:forEach>
	
	
	<c:forEach items="${rtnMaster.list }" var="list" varStatus="loop">
		$(".selectDelivery").eq(${loop.index}).val('${list.DLVY_ROWNUM }');
	</c:forEach>
	
	<c:set var="arrARRIVAL_DATE" value="${fn:split(rtnMaster.ARRIVAL_DATE, '-') }" /> 
	
	<c:if test="${!empty arrARRIVAL_DATE[1] }">
	var nMonth = parseInt('${arrARRIVAL_DATE[1] }');
		$("#ARRIVAL_DATE_MONTH").val(nMonth);
	</c:if>
	<c:if test="${!empty arrARRIVAL_DATE[2] }">
	var nDay = parseInt('${arrARRIVAL_DATE[2] }');
		$("#ARRIVAL_DATE_DAY").val(nDay);
	</c:if>

	<c:if test="${rtnMaster.PAY_METD eq 'XPAY_METD_02' }">
		$("#trCardView").show();
	</c:if>

	<c:if test="${rtnMaster.PAY_METD ne 'XPAY_METD_02' }">
		$("#trCardView").hide();
	</c:if>

    //결제방식 카드일 경우
    $(document).on("change", "#PAY_METD", function() {
    	var strValue = $(this).val();
    	
    	if(strValue == 'XPAY_METD_02'){
			alert("신용카드 결제를 원하실 경우 결제 승인요청 서류를 업로드 하셔야 합니다. 양식 다운로드 후 작성하여 스캔본 업로드 부탁드립니다. ");
			
			$("#trCardView").show();
    	}else{

			$("#trCardView").hide();
    	}
    	
    });
	
});
</script>

