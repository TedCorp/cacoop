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
.tablewrap{border: 1px solid lightgray; margin: 20px; height:600px; overflow-y:scroll}
.uploadResultTable {border: 1px solid lightgrey; text-align: center; font-size: 11px; width: 100%;}
.uploadResultTable th{border: 1px solid lightgrey;text-align:center;height: 30px;font-weight: 300; background: #f7f7f7;}
.uploadResultTable td{border: 1px solid lightgray;text-align:center;height: 25px;}
.btn-white{height:25px; width:fit-content; background:white; border : 1px solid lightgray; border-radius:3px; font-size:10px ;padding:2px;margin-left:5px; font-weight: 700;;}
.button-label{height:25px; width:100px; background:white; border : 1px solid lightgray; border-radius:3px; font-size:10px ;padding:4px;margin-left:5px; text-align:center; cursor:pointer;}
.loding_block{display: block;  position: fixed;  top: 30%;  left: 50%; display:none}
.infotxt{margin: 20px;  font-size: 12px; color:#00BCD4 ;}
</style>

<section class="content-header">
	<h1>상품관리
		<small>상품 일괄 등록</small>
	</h1>
	
</section>
<section class="content">
	<div class="box box-primary">
		<form method="POST" enctype="multipart/form-data" id="uploadForm">
			<div><span class="infotxt">상품 등록은  이미지 업로드  ->  파일 업로드  ->  상품정보 확인 ->  상품등록 순으로 진행됩니다.</span></div>
			<div style="margin-left: 20px;margin-right:20px; margin-top :10px; display: flex;">
				<input type="button" class="btn btn-white" onclick="categorySearch()"value="카테고리 찾기">
				<div style="width:90%;height:100%"></div>
				<input type="button" id="btnExcelDown" class="btn btn-white" value="엑셀양식 다운로드">
				<!-- <input type="button" class="btn btn-white" onclick="imgUpload()"value="이미지 업로드"> -->
				<!-- <form method="POST" enctype="multipart/form-data" id="uploadForm"> -->
		   		<!-- <input type="button" class="btn btn-white" onclick="uploadStart()" value="파일 업로드"  disabled="disabled"> -->
		   		<input type="hidden" id="UPLOAD_CODE" name="UPLOAD_CODE" value="">
				<label id="imageUpload" for="IMG_FILE" class="button-label">이미지 업로드</label>
				<input type="file" id="IMG_FILE" name="IMG_FILE" value="" multiple style="display:none" >
		   		<label for="EXCEL_FILE" id="label_fileUpload" class="button-label" style="opacity: .65;">파일 업로드</label>
				<input type="file" id="EXCEL_FILE" name="EXCEL_FILE" value="" multiple style="display:none" disabled="disabled">
				<!-- </form> -->
				<!-- <input type="button" class="btn btn-white" onclick="uploadStart()" value="파일 업로드">
				<input type="file" id="EXCEL_FILE" name="EXCEL_FILE" value=""> -->
				<input type="button" id="dataChk" class="btn btn-white" onclick="validationChk()" value="상품정보확인"  disabled="disabled">
				<input type="button" id="prdInsert" class="btn btn-white" onclick="fn_prdInsert()" value="상품등록"  style="display:none">
			</div>
		</form>
		<div class="tablewrap">
			<table class="uploadResultTable">
				<colgroup>
					<col style="width:4%">
					<col style="width:8%">
					<col style="width:20%">
					<col style="width:8%">
					<col style="width:8%">
					<col style="width:8%">
					<col style="width:28%">
					<col style="width:8%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>처리상태</th>
						<th>실패사유</th>
						<th>상품번호</th>
						<th>카테고리</th>
						<th>상품명</th>
						<th>판매가</th>
						<th>재고수량</th>
					</tr>
				</thead>
				<tbody class="uploadList">
					<tr>
						<td colspan="8" id="infoMsg" style="height:500px;margin-top:50%;border:1px solid white">데이터가 존재하지 않습니다.</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div style="padding: 20px;">
			<input class="btn btn-primary btn-sm" type="button" value="상품정보 조회/수정">
		</div>
		<div class="loding_block">
			<img src="/resources/images/img/loding.gif" class="" alt="loding Image">
		</div>
	</div>	
</section>


<script type="text/javascript">

function categorySearch(){
	window.open("/adm/productMgr/categorySearch", "_blank", "width=400,height=400");  
}

function uploadStart(){
	 lodingStart();
	var form = $('#uploadForm')[0]
    var data = new FormData(form);
	
	$.ajax({
		type: "POST",
		/* contentType: "application/x-www-form-urlencoded; charset=UTF-8", */
		enctype: 'multipart/form-data',
		processData: false,
		contentType: false,
	    url: "${contextPath}/adm/productMgr/excelUpload",
	    data: data,
	    success: function (data) {
	   		if(data == 'error'){
	   			alert(' 엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식 다운로드 후 다시 저장 하세요.');
	   			lodingEnd();
	   		}else{
	   			
		   		var html = "";
		   		var listArr = JSON.parse(data);
		   		for(var i =0; i < listArr.length ; i++){
		   			html += "<tr>"
		   			html += "<td>"+(i+1)+"</td>"
		   			html +=	"<td class='uploadCode'>"+listArr[i].UPLOAD_STATE+"</td>"
		   			html +=	"<td>"+listArr[i].FAIL_MSG+"</td>"
		   			html +=	"<td>"+listArr[i].PD_CODE+"</td>"
		   			html +=	"<td>"+listArr[i].CAGO_ID+"</td>"
		   			html +=	"<td>"+listArr[i].PD_NAME+"</td>"
		   			html +=	"<td>"+(listArr[i].PD_PRICE*1).toLocaleString()+"</td>"
		   			html +=	"<td>"+listArr[i].INVEN_QTY+"</td>"
		   			html +=	"</tr>"
		   		}
		   		
		   		$('#UPLOAD_CODE').val(listArr[0].UPLOAD_CODE);
		   		$('.uploadList').html(html);
		   		lodingEnd();
		   		$("#infoMsg").html('엑셀파일 업로드가 완료되었습니다. 상품정포 확인을 진행 해 주세요.');
		   		
			   	$("#dataChk").css({'display':'block'});
				$("#prdInsert").css({'display':'none'});
				
				$('#EXCEL_FILE').val("");
	   		};
	   		
	    }, error: function (jqXHR, textStatus, errorThrown) {
	       alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
	    }
	});	
}
	
	function validationChk(){
		lodingStart();
		
		 $.ajax({
				type: "POST",
			    url: "${contextPath}/adm/productMgr/validationChk",
			    data: {
			    	type: 'uploadPrds',
			    	upload_code : $('#UPLOAD_CODE').val()
			    },
			    traditional: true,
			    success: function (data) {
			   		var html = "";
			   		var listArr = JSON.parse(data);
			   		for(var i =0; i < listArr.length ; i++){
			   			html += "<tr>"
			   			html += "<td>"+(i+1)+"</td>"
			   			html +=	"<td>"+listArr[i].UPLOAD_STATE+"</td>"
			   			html +=	"<td>"+listArr[i].FAIL_MSG+"</td>"
			   			html +=	"<td>"+listArr[i].PD_CODE+"</td>"
			   			html +=	"<td>"+listArr[i].CAGO_ID+"</td>"
			   			html +=	"<td>"+listArr[i].PD_NAME+"</td>"
			   			html +=	"<td>"+(listArr[i].PD_PRICE*1).toLocaleString()+"</td>"
			   			html +=	"<td>"+listArr[i].INVEN_QTY+"</td>"
			   			html +=	"</tr>"
			   		}
			   		$('.uploadList').html(html)
			   		lodingEnd();
			   		$("#infoMsg").html('상품정보 확인이 완료되었습니다. 상품등록을 진행 해 주세요.');
			   		$('#label_fileUpload').css({'opacity':'.65'});
			   	
			    }, error: function (jqXHR, textStatus, errorThrown) {
			       alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
			    }
			});	
		 
		 $("#dataChk").css({'display':'none'});
		 $("#prdInsert").css({'display':'block'});
		 
		 $('#EXCEL_FILE').val("");
		
	}
	
	function imgUpload(){
		 lodingStart();
		 var form = $('#uploadForm')[0]
		 var data = new FormData(form);
			$.ajax({
				type: "POST",
				/* contentType: "application/x-www-form-urlencoded; charset=UTF-8", */
				enctype: 'multipart/form-data',
				processData: false,
				contentType: false,
			    url: "${contextPath}/adm/productMgr/imgUpload",
			    data: data,
			    success: function (data) {
			   		$("#UPLOAD_CODE").val(data);
			   		$("#IMG_FILE").remove();
			   		alert("이미지 업로드가 완료되었습니다.")
			   		lodingEnd();
			   		$('#imageUpload').css({'border':'1px solid lightgray','opacity': '.65'});
			   		$("#infoMsg").html('이미지업로드가 완료되었습니다. 엑셀파일 업로드를 진행 해 주세요.');
			   		
			    }, error: function (jqXHR, textStatus, errorThrown) {
			       alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
			    }
			});	
		
	}
	
	$('#IMG_FILE').on('change',function(){
		imgUpload();
		$('#EXCEL_FILE').removeAttr('disabled');
		$('#label_fileUpload').css({'opacity':'1'});
	});
	
	$('#EXCEL_FILE').on('change',function(){
		uploadStart();
		$('#dataChk').removeAttr('disabled');
	});
	
	function fn_prdInsert(){
		// 상품 등록 프로시저 호출
		 $.ajax({
				type: "POST",
			    url: "${contextPath}/adm/productMgr/prdInsert",
			    data: {
			    	type: 'uploadPrds',
			    	upload_code : $('#UPLOAD_CODE').val()
			    },
			    traditional: true,
			    success: function (data) {
			   		if(data*1 > 0 ){
			   			alert(data +'개의 상품이 정상적으로 등록되었습니다.');
			   			location.href="${contextPath}/adm/productMgr";
			   		}else{
			   			alert('상품을 등록하는데 실패하였습니다. 엑셀 데이터를 다시 확인 해 주세요.')
			   		}
			    	
			    }, error: function (jqXHR, textStatus, errorThrown) {
			       alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
			    }
			});	
	};
	
	$("#btnExcelDown").click(function(){	
	    document.location.href = "${contextPath }/upload/jundan/excel/product_upload_form.xlsx";
	});
	
	function lodingStart(){
		$(".loding_block").css({'display':'block'});
	}
	
	function lodingEnd(){
		$(".loding_block").css({'display':'none'});
	}
	

</script>