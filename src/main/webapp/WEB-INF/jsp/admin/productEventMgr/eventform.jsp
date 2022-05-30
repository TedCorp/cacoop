<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<script type="text/javascript">

$(function(){
	/* 숫자만 입력 */
    $(document).on("keyup", ".number", function() {
    	$(this).number(true);
    });
	
  	/* 엑셀 업로드 버튼 */
    $(".btnExcelUpload").click(function(){	
		$('#myModal').modal('show');
    });
  	
  	/* 엑셀 양식 받기 */
    $("#btnExcelDown").click(function(){	
		document.location.href = "${contextPath}/upload/jundan/excel/event_excel_form.xls";
    });
    
  	/* 엑셀 저장 */
    $("#btnExcelSave").click(function(){	
    	// 파일첨부 체크	
		if(!$("#EXCEL_FILE").val()){
			alert("업로드할 엑셀파일을 첨부해주세요.");
			return;
		}
		
		if(!confirm("업로드 하시겠습니까?")) return;
		$('#excelFrm').submit();
    });
	
    /* 행사상품 엑셀 다운로드 */
  	$(".btnExcelDownload").click(function() {  		
	    $("#downFrm").submit();
	});
    
  	/* 리스트 삭제 버튼 */
    $(".btnListDelete").click(function(){
    	if(!confirm("상품목록을 초기화 하시겠습니까? \n신규추가된 상품만 삭제됩니다.")) return;
		//$('#eventPdList').empty();
		$('.addNew').remove();
    });
  	
	/* 상품추가 팝업 */
    $(".btnPdAdd").click(function(){	
		$('#pdModal').modal('show');
    });
    
  	/* 상품 팝업검색 */
    $("#ajaxSearch").click(function(){
    	
    	$.ajax({
    		type : "GET",		
    		dataType : "json",
    		url : "${contextPath}/adm/productEventMgr/pdpop.json",
    		data : $("#ajaxfrm").serialize(),    		
    		success : function(data){    			
    			// 상품추가팝업 Modal에 데이터 add
    			var ajaxCnt = data.count;
    			var ajaxList = data.list;
    			var tbody = $("#ajaxList > tbody");
    			tbody.empty();	//초기화
    			
    			if(ajaxCnt > 0){    				
   					$.each(ajaxList, function(i, val){	
   						tbody.append($('<tr>')
									.append($('<td>', {html : "<input type='checkbox' name='chkPdtId' value='"+val.pd_CODE+"@!"+val.pd_NAME+"@!"+val.pd_BARCD+"@!"+val.pd_PRICE+"@!"+val.pddc_VAL+"@!"+val.pddc_GUBN+"'>"+
																		"<input name='pdtIdYn' value='N' type='hidden'/>"}))
									.append($('<td>', {text : i+1}))
									.append($('<td>', {text : val.pd_CODE}))
									.append($('<td>', {text : val.pd_NAME}))
									.append($('<td>', {text : val.pd_PRICE}))
								);
					});
    			} else{
    				tbody.append($('<tr>').append($('<td>', "조회된 내역이 없습니다.")));
    			}
    		},
    		error : function(request, status, error) {
    			alert("list search fail :: error code: " + request.status + "\n" + "error message: " + error + "\n");
    		}
    	});
    });
    
    /* 선택상품추가 */
    $("#btnChkAdd").click(function(){
    	// 체크항목
    	var checkboxValues =[];
    	$("input:checkbox[name=chkPdtId]:checked").each(function(){
    		checkboxValues.push($(this).val());
    	});
    	
    	// 상품선택확인
    	if(checkboxValues=='' || checkboxValues==null){
    		checkboxValues.push("");		
    		alert("추가할 상품을 체크해주세요.");
    		return false;
    	}
    	
    	var addNum = "";
    	
    	for(var i=0; i<checkboxValues.length; i++){
    		var pd_add = checkboxValues[i];    		
    		var pdSplit = pd_add.split('@!');
    		var pd_code = pdSplit[0];
    		var pd_name = pdSplit[1];
    		var pd_barcode = pdSplit[2];
    		var pd_price = pdSplit[3];
    		var pddc_val = pdSplit[4];
    		var pddc_gubn = pdSplit[5];
    		console.log(pdSplit);
    		
    		addNum = '<tr id="list_'+pd_code+'" class="addNew">'
								+'<td>'
									+'<input id="num_'+pd_code+'" class="form-control input-sm" type="text" name="PD_SORT" value="'+($('input[name="PD_SORT"]').length+1)+'" title="정렬순서" readonly="readonly"/>'
								+'</td>'
								+'<td>'
									+'<input id="code_'+pd_code+'" class="form-control input-sm" type="text" name="PD_CODE" value="'+pd_code+'" title="상품코드" readonly="readonly"/>'
								+'</td>'
								+'<td>'
									+'<input id="barcd_'+pd_code+'" class="form-control input-sm" type="text" name="PD_BARCD" value="'+pd_barcode+'" title="상품바코드" readonly="readonly"/>'
								+'</td>'
								+'<td>'
									+'<input id="name_'+pd_code+'"class="form-control input-sm" type="text" name="PD_NAME" value="'+pd_name+'" title="상품명" readonly="readonly"/>'
								+'</td>'
								+'<td>'
									+'<div class="input-group">'
										+'<input id="price_'+pd_code+'"class="form-control input-sm number" type="text" name="PD_PRICE" value="'+pd_price+'" placeholder="판매가" title="판매가" readonly="readonly" />'
										+'<div class="input-group-addon">원</div>'
									+'</div>'
								+'</td>'
								+'<td>'
									+'<div class="input-group">'
										+'<input id="pddc_'+pd_code+'"class="form-control input-sm number" type="text" name="PDDC_VAL" value="'+pddc_val+'" placeholder="할인값" title="할인값" maxlength="15" />'
										+'<div class="input-group-addon">원</div>'
									+'</div>'
								+'</td>'	
								+'<td>'
									+'<select id="gubn_'+pd_code+'" name="PDDC_GUBN" class="form-control input-sm select2">'
										+'<option value="PDDC_GUBN_01" selected="selected">할인안함</option>'
										+'<option value="PDDC_GUBN_02">할인금액</option>'
										+'<option value="PDDC_GUBN_03">할인율</option>'
									+'</select>'
								+'</td>'	
								+'<td>'
									+'<div class="input-group">'
										+'<input id="sale_'+pd_code+'"class="form-control input-sm number" type="text" name="PD_SALE" value=0 placeholder="행사가" title="행사가" readonly="readonly"/>'
										+'<div class="input-group-addon">원</div>'
									+'</div>'
								+'</td>'		
								+'<td>'
									+'<a id="btn_'+pd_code+'" class="btn btn-warning btn-sm pull-right" onclick="javascript:fn_pd_delete(\''+pd_code+'\');">삭제</a>'
								+'</td>'
							+ '</tr>';
    		// 중복체크
    		if($("#code_"+pd_code).length < 1){
				// 행추가
    			$("#eventPdList").append(addNum);
    		}
    	}
		
    	//팝업 초기화
    	$("input[type=checkbox]").prop("checked",false);
    	$("input[name=schTxt]").val("");
    	$("#ajaxList > tbody").empty();
    });
	
	/* 동적으로 추가된 select 제어 */
    $("#eventPdList").on("change", "select[name='PDDC_GUBN']", function() {
		console.log("할인구분 변경됨, 재계산 >>")
		
		if($(this).val()){
			var $pddc_gubn = $(this).val();
	    	var $pd_code = $(this).closest('tr').find('input[name=PD_CODE]').val();
	    	var strIdVal = "#"+$(this).closest('tr').find('input[name=PDDC_VAL]').attr('id');
	    	
	    	if($pddc_gubn == "PDDC_GUBN_01"){
	    		$(strIdVal).val("0");
	    		$(strIdVal).next().text("원");
	    		$(strIdVal).attr("readonly",true);		
	    	}else if($pddc_gubn == "PDDC_GUBN_03"){
	    		$(strIdVal).next().text("%");
	    		$(strIdVal).attr("readonly",false);
	    	}else{
	    		$(strIdVal).next().text("원");
	    		$(strIdVal).attr("readonly",false);
	    	}
	    	// 행사가격 재계산
	    	fn_calculPrice($pd_code);
		}
    });

	/* 할인값 변경시 재계산 */
    $("#eventPdList").on("blur", "input[name='PDDC_VAL']", function() {
    	// 빈값 체크
		if($(this).val()){
			var $pd_code = $(this).closest('tr').find('input[name=PD_CODE]').val();			
			fn_calculPrice($pd_code);
			
		}else{
			alert("할인값을 입력해주세요.");
		}
    });
	
	/* 추가상품 중복체크 */
    $("#ajaxList").on("click", "input:checkbox", function() {
		console.log("상품 중복체크 >>")
		var pdSplit = $(this).val().split('@!');
		var pd_code = pdSplit[0];
		var pd_name = pdSplit[1];
		
		if($(this).is(":checked")){
			if($("#code_"+pd_code).length > 0){
    			alert("현재 행사그룹에 ["+pd_name+"] 상품이 이미 포함되어 있습니다.");
    			$(this).prop("checked",false);
    		}
		}
    });
		
    /* 저장 */
    $("#btnSave").click(function(){
    	if(!confirm("저장 하시겠습니까?")) return;
    	var frm=document.getElementById("eventFrm");	
    	frm.submit();
    });
    
    /* 필수값 체크 */
    $("#eventFrm").validate({
    	debug: false,
        onfocusout: false,
        rules: {
        	PD_CODE: {
                required: true
            },
        	PDDC_VAL: {
                required: true
            },
            PDDC_GUBN: {
                required: true
            }            
        }, messages: {
        	PD_CODE: {
                required: '상품코드는 필수값 입니다.'
            },
            PDDC_VAL: {
                required: '할인금액 또는 할인율을 입력해주세요.'
            },
            PDDC_GUBN: {
                required: '할인구분을 선택해주세요.'
            }
        }, errorPlacement: function(error, element) {
            // do nothing
        }, invalidHandler: function(form, validator) {
             var errors = validator.numberOfInvalids();
             if (errors) {
                 alert(validator.errorList[0].message);
                 validator.errorList[0].element.focus();
             }          
        }
    });
    
});

/* Enter 이벤트 제거 (비동기 form submit 방지) */
document.addEventListener('keydown', function(event) {
	if (event.keyCode === 13) {
		event.preventDefault();
	};
}, true);

/* 행삭제 */
function fn_pd_delete(pd_code){
	$('#list_'+pd_code).remove();
}

/* 할인금액 계산 */
function fn_calculPrice(pdCode){
	var $pddc_gubn = $('#gubn_'+pdCode).val();														//할인구분
	var $pddcVal = $('#pddc_'+pdCode).val().replace(/[^\d]+/g, '');				//할인값
	//alert($pddcVal);
	$('#pddc_'+pdCode).val().replace(/[^\d]+/g, '') > 0 ? $pddcVal =  Number($pddcVal) : $pddcVal = 0;
	//alert($pddcVal);
	var $pdPrice = Number($('#price_'+pdCode).val().replace(/[^\d]+/g, ''));				//제품값
	var $pdSale = $pdPrice;
	
	console.log("계산="+$pddc_gubn);
	
	if($pddc_gubn == "PDDC_GUBN_02"){
		$pdSale = $pdPrice - $pddcVal;
	}else if($pddc_gubn == "PDDC_GUBN_03"){
		$pdSale = $pdPrice - ($pdPrice * ($pddcVal/100));
	}
	
	$('#sale_'+pdCode).val(Math.floor($pdSale).toLocaleString());							//소수점 버림
}

/* 체크박스 전체선택 */
function fnCheckAll(){	
	if($("#allCheck").prop("checked")) {
		$("input[type=checkbox]").prop("checked",true);
	} else {
		$("input[type=checkbox]").prop("checked",false);
	}
}
</script>

<c:set var="strActionUrl" value="${contextPath }/adm/productEventMgr" />
<c:set var="strMethod" value="post" />

<section class="content-header">
	<h1>
		행사상품관리
		<small>할인상품목록</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">	
	<!-- 내용 시작 -->
	<div class="box box-info">
		<div class="box-header with-border">
			<h3 class="box-title">할인상품</h3>
			<button type="button" class="btn btn-default btn-sm pull-right btnHelp">
				<i class="fa fa-question-circle"></i> 도움말
			</button>
		</div>
		<!-- box-body -->
		<div class="box-body">
			<div class="box-body">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">행사그룹</label>
					<div class="col-sm-9">
						<button type="button" class="btn btn-primary btn-sm btnPdAdd" title="개별상품 추가">
							<i class="fa fa-plus"></i> 상품 추가 
						</button>												
						<button type="button" class="btn btn-info btn-sm btnExcelUpload" title="행사상품 엑셀 양식 업로드">
							<i class="fa fa-file-excel-o"></i> 행사 엑셀 업로드 
						</button>
						<button type="button" class="btn btn-success btn-sm btnExcelDownload" title="행사상품 엑셀 다운로드">
							<i class="fa fa-file-excel-o"></i> 엑셀 다운로드
						</button>
						<button type="button" class="btn btn-danger btn-sm btnListDelete" title="행사상품 목록 비우기">
							<i class="fa fa-minus"></i> 목록 초기화
						</button>
					</div>
				</div>
			</div>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- 내용 끝 -->			

	<!-- 추가실패목록 START -->					
	<c:if test = "${errlist ne null}">
		<!-- 변경실패 -->
		<div class="box">
			<div class="box-header with-border">
				<h3 class="box-title">추가 실패 : <font color = "red"><b>${errlist.size()}</b></font> </h3>	
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
			<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th width="70px">순번</th>
							<th width="20%">바코드</th> 
							<th width="20%">상품명</th>
							<th width="150px">에러코드</th>
							<th>메시지</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${errlist}" var="list" varStatus="loop">
						<tr>
							<td align="center">
								<label>${loop.count}</label>
							</td>
							<td align="left">
								<label>${list.PD_BARCD}</label>
							</td>
							<td align="left">
								<label>${list.PD_NAME}</label>
							</td>
							<td align="left">
								<label>${list.ERROR_CODE}</label>
							</td>
							<td align="left">
								<label>${list.ERROR_TEXT}</label>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${errlist.size() eq 0}">
						<tr>
							<td colspan="4"><label>업로드에 성공하였습니다.</label></td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</c:if>					
	<!-- 추가실패목록 END-->
	
	<!-- 추가상품목록 START -->
	<spform:form name="eventFrm" id="eventFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
		<div class="box">
			<div class="box-header with-border">
				<h3 class="box-title">행사 상품 : <font color="blue"><b>${tb_pdinfoxm.list.size() > 0 ? tb_pdinfoxm.list.size() : 0}</b></font></h3>
			</div>		
			<!-- /.box-header -->
			<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
				<table class="table table-bordered" id="eventPdList">
					<thead>
						<tr>
							<th style="width:80px">순번</th>
							<th>상품코드</th> 
							<th>상품바코드</th>
							<th>상품명</th>
							<th>판매가</th>
							<th>할인값</th>
							<th>할인구분</th>
							<th>행사가</th>
							<th>삭제</th>
						</tr>					
					</thead>
					<tbody>
					<c:forEach items="${tb_pdinfoxm.list }" var="list" varStatus="loop">
						<tr id="list_${list.PD_CODE }">
							<td>
								<input id="num_${list.PD_CODE }" class="form-control input-sm"
									type="text" name="PD_SORT" value="${loop.count}" title="순번" readonly="readonly"/>
							</td>
							<td>
								<input id="code_${list.PD_CODE }" class="form-control input-sm"  
									type="text" name="PD_CODE" value="${list.PD_CODE }" title="상품코드" readonly="readonly"/>
							</td>
							<td>
								<input id="barcd_${list.PD_CODE }" class="form-control input-sm" 
									type="text" name="PD_BARCD" value="${list.PD_BARCD }" title="상품바코드" readonly="readonly"/>
							</td>
							<td>
								<input id="name_${list.PD_CODE }" class="form-control input-sm"
									type="text" name="PD_NAME" value="${list.PD_NAME }" title="상품명" readonly="readonly"/>
							</td>
							<td>
								<div class="input-group">
									<input id="price_${list.PD_CODE }" class="form-control input-sm number"
										type="text" name="PD_PRICE" value="<fmt:formatNumber value="${ list.PD_PRICE eq null ? 0 : list.PD_PRICE }" pattern="#,###"/>" placeholder="판매가" title="판매가" readonly="readonly"/>
									<div class="input-group-addon">원</div>
								</div>								
							</td>
							<td>
								<div class="input-group">
									<input id="pddc_${list.PD_CODE }" class="form-control input-sm number"
										type="text" name="PDDC_VAL" value="<fmt:formatNumber value="${list.PDDC_VAL }" pattern="#,###"/>" placeholder="할인값" title="할인값" maxlength="15" required="required"/>
									<div class="input-group-addon">
										 ${list.PDDC_GUBN eq 'PDDC_GUBN_03' ? '%' : '원'}
									</div>
								</div>
							</td>
							<td>
								<select id="gubn_${list.PD_CODE }" name="PDDC_GUBN" class="form-control input-sm select2" >								
									<option value="PDDC_GUBN_01" <c:if test='${list.PDDC_GUBN eq "PDDC_GUBN_01" }'>selected="selected"</c:if>>할인안함</option>
									<option value="PDDC_GUBN_02" <c:if test='${list.PDDC_GUBN eq "PDDC_GUBN_02" }'>selected="selected"</c:if>>할인금액</option>
									<option value="PDDC_GUBN_03" <c:if test='${list.PDDC_GUBN eq "PDDC_GUBN_03" }'>selected="selected"</c:if>>할인율</option>
								</select>
							</td>
							<td>
								<div class="input-group">
									<input id="sale_${list.PD_CODE }" class="form-control input-sm number"
										type="text" name="PD_SALE" value="<fmt:formatNumber value="${list.REAL_PRICE }" pattern="#,###"/>" placeholder="할인가" title="할인가" readonly="readonly"/>
									<div class="input-group-addon">원</div>
								</div>
							</td>
							<%-- <td>
								<a class="btn btn-sm btn-warning pull-right" id="btn_${list.PD_CODE }"  
									onclick="javascript:fn_pd_delete('${list.PD_CODE}');">삭제</a>
							</td> --%>
						</tr>
					</c:forEach>
					</tbody>						
				</table>
			</div>
		</div>
	</spform:form>
	
	<div class="box-footer" >
		<a href="${contextPath}/adm/productEventMgr" class="btn btn-default pull-right"><i class="fa fa-list"></i> 목록</a>
		<button type="button" class="btn btn-primary pull-right right-5" id="btnSave"><i class="fa fa-save"></i> 저장</button>
	</div>			
	<!-- /.box-footer -->
</section>
 
<!-- 상품엑셀 업로드 모달 -->
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
				<!-- 행사상품정보 박스 -->
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">업로드</h3>
					</div>
					<!-- ./box-header -->
					<spform:form name="excelFrm" id="excelFrm" method="post" action="${contextPath }/adm/productEventMgr/excelUpload" role="form" class="form-horizontal" enctype="multipart/form-data">						
						<div class="box-body">
							<div class="form-group">
								<label for="MEMB_ID" class="col-sm-2 control-label">양식파일</label>
								<div class="col-sm-9">
									<button type="button" class="btn btn-primary btn-sm pull-left" id="btnExcelDown"><i class="fa fa-download"></i> 양식 받기 </button>
								</div>
							</div>
							<div class="form-group">
								<label for="MEMB_NAME" class="col-sm-2 control-label">엑셀파일</label>
								<div class="col-sm-9">
									<input type="file" id="EXCEL_FILE" name="EXCEL_FILE" id="file-simple" value=""> 
								</div>
							</div>
							<div class="form-group">
								<label for="GUIDE" class="col-sm-2 control-label">이용안내</label>
								<div class="col-sm-9">
									<textarea name="CONTENT" class="form-control" rows="2" cols="100" 
									  readonly="readonly" style="color:red"> 할인금액 0으로 업로드시, 할인안함으로 적용됩니다. </textarea>
								</div>
							</div>
						</div>
					</spform:form>
					<!-- /.box-body -->
				</div>
				<!-- 행사상품정보 박스 -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary btn-sm" id="btnExcelSave">업로드</button>
			</div>
		</div>
	</div>
</div>  
 
<!-- 상품 추가 팝업 -->
<div class="modal fade" id="pdModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" style="width:50vw;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="pdModalLabel">상품 추가 팝업</h4>
			</div>
			<div class="modal-body">				
				<!-- 검색조건 박스 -->
				<div class="box box-primary">
					<form class="form-horizontal" id="ajaxfrm" method="get">
						<input type="hidden" name="sortGubun" id="sortGubun" />
						<input type="hidden" name="sortOdr" id="sortOdr" />
						<input type="hidden" name="PDDC_GUBN" value="PDDC_GUBN_01"/>
						<!-- box-header -->
						<div class="box-header with-border">
							<h3 class="box-title">검색 조건</h3>
						</div>
						<!-- box-body -->											
						<div class="box-body">
							<div class="form-group">
								<label for="schGbn" class="col-sm-2 control-label">검색어</label>
								<div class="col-sm-2">
									<select name="schGbn" class="form-control select2">
										<option value="PD_NAME" ${ param.schGbn eq 'PD_NAME' ? "selected='selected'":''}>상품명</option>
										<option value="PD_CODE" ${ param.schGbn eq 'PD_CODE' ? "selected='selected'":''}>코드</option>
										<option value="PD_BARCD" ${ param.schGbn eq 'PD_BARCD' ? "selected='selected'":''}>바코드</option>
									</select>
								</div>
								<div class="col-sm-7">
									<div class="input-group">
										<input type="search" class="form-control" name="schTxt" placeholder="검색어 입력" value="${param.schTxt }">
										<span class="input-group-btn">
											<button type="button" id="ajaxSearch" class="btn btn-success pull-right">검색</button>
										</span>
									</div>
								</div>
							</div>							
							
							<div class="form-group">
								<label for="SALE_CON" class="col-sm-2 control-label">판매상태</label>
								<div class="col-sm-2">
									<p class="form-control-static">
										<jsp:include page="/common/comCodForm">
											<jsp:param name="COMM_CODE" value="SALE_CON" />
											<jsp:param name="name" value="SALE_CON" />
											<jsp:param name="value" value="${obj.SALE_CON }" />
											<jsp:param name="type" value="select" />
											<jsp:param name="top" value="전체" />
										</jsp:include>
									</p>
								</div>													
							</div>
						</div>
					</form>
				</div>
				<div style="max-height:50vh; overflow-y:scroll;">
					<!--상품정보 테이블 -->
					<table class="table table-bordered" id="ajaxList">
						<colgroup>
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th style="width:60px"><input type="checkbox" id="allCheck" name="toggleChk" onclick="javascript:fnCheckAll()"></th>
								<th>번호</th>
								<th>상품코드</th>
								<th>상품명</th>
								<th>상품가격</th>
							</tr>
						</thead>
						<tbody>
							<!-- append -->
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnChkAdd">선택상품추가</button>
			</div>
		</div>
	</div>
</div>

<form id="downFrm" method="get" action="${contextPath }/adm/productEventMgr/excelDownload"></form>

<spform:form name="delFrm" id="delFrm" method="DELETE" action="${contextPath }/adm/productEventMgr/${tb_pdrcmdxm.GRP_CD }" class="form-horizontal"> 	
</spform:form>

<spform:form name="delProductFrm" id="delProductFrm" method="GET" action="${contextPath }/adm/productEventMgr/deleteProduct">
	<input type="hidden" name="PD_CODE" value=""/>
	<input type="hidden" name="GRP_CD" value=""/>
</spform:form>
