<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<script type="text/javascript">
$(function(){
	//숫자만 입력토록 함.
    $(document).on("keyup", ".number", function() {
    	$(this).number(true);
    });
	
  	//엑셀 업로드 버튼
    $(".btnExcelUpload").click(function(){	
		$('#myModal').modal('show');
    });
  	
  	//엑셀 양식 받기
    $("#btnExcelDown").click(function(){	
		document.location.href = "${contextPath }/upload/jundan/excel/rcmd_excel_form.xls";
    });
  	
  	//엑셀 저장
    $("#btnExcelSave").click(function(){	
		$('#excelFrm').submit();
    });    
    
  	//엑셀 다운로드
    $(".btnExcelDownload").click(function() {    	
    	var form = document.createElement("form");

    	//form.target = "_blank";
    	form.method = "post";
    	form.action = "${contextPath }/adm/productRcmdMgr/excelDownload";

    	document.body.appendChild(form);

    	var input_id = document.createElement("input");
    	input_id.setAttribute("type", "hidden");
    	input_id.setAttribute("name", "GRP_CD");
    	input_id.setAttribute("value", "${tb_pdrcmdxm.GRP_CD }");

    	form.appendChild(input_id);
    	form.submit();        
    });
  
  	//리스트 삭제 버튼
    $(".btnListDelete").click(function(){	
		$('#rcmdPdList').empty();
    });
  	

	//상품바코드 입력 변경시
	$("#RCMD_GUBN").change(function(){
		if($("#RCMD_GUBN").val() == "RCMD_GUBN_09"){
			/* var frm=document.getElementById("rcmdFrm");
			form.method = "get";
	    	form.action = "${contextPath }/adm/productRcmdMgr/new";
			frm.submit(); */
			$("#rcmdFrm").attr("method","get");
			$("#rcmdFrm").attr("action","${contextPath }/adm/productRcmdMgr/new");
			$("#rcmdFrm").submit();
		}
	});

});

//등록시 메뉴코드 중복 검사
function fn_ordr_chk(){	
	var frm=document.getElementById("rcmdFrm");
	
	if(frm.SORT_ORDR.value!=''){
		/* $.ajax({
		    url: "${contextPath }/adm/productRcmdMgr/ordrChk",
		    type: 'post',
		    data: 'SORT_ORDR='+ frm.SORT_ORDR.value,
		    success: function(data){                               
		    	 if(data=="success"){
		    		 alert("이미 존재하는 정렬순서 입니다.");
		    		 //frm.SORT_ORDR.focus();
		    	 }else{
		    		 //alert("정렬순서를 사용해도 좋습니다.");
		    		 frm.SORT_ORDR_CHK.value="Y";
		    	 }
		    },
		    error: function(e){
		       alert("에러: 관리자에게 문의하세요\n");
		    }
		}); */
	}
}

//저장버튼 클릭시
function fn_save(){
	var frm=document.getElementById("rcmdFrm");
	if(frm.GRP_NM.value==""){
		alert("그룹명을 입력하세요");
		frm.GRP_NM.focus();
		return;
	}
	if(frm.SORT_ORDR.value==""){
		alert("정렬순서를 입력하세요");
		frm.SORT_ORDR.focus();
		return;
	}
	if(frm.SORT_ORDR_CHK.value=="N"){
		alert("정렬순서 중복을 확인해주세요.")
		return;
	}
	
	if(!confirm("저장 하시겠습니까?")) return;
	frm.submit();
}

//삭제버큰 클릭시
function fn_delete(){
	if(!confirm("삭제 하시겠습니까?")) return;
	var frm=document.getElementById("delFrm");
	frm.submit();
}

//상품선택 팝업 호출
function fn_pd_popup(){
	window.open("${contextPath }/adm/productRcmdMgr/popup", "_blank", "width=900,height=900"); 
}

//상품선택 팝업 리턴값
function fn_pd_popup_return(SEL_PD_CODE,SEL_PD_NAME,SEL_PD_BARCD){
	var frm=document.getElementById("rcmdFrm");
	//frm.PD_CODE.value=SEL_PD_CODE;
	//frm.PD_NAME.value=SEL_PD_NAME;
	//$("#addCd").text('');	//상품추가 메세지 없애기
	
	var row_id = "code_"+SEL_PD_CODE;
	var bar_id = "barcd_"+SEL_PD_CODE;
	var nm_id = "name_"+SEL_PD_CODE;
	var btn_id = "btn_"+SEL_PD_CODE;
	var num_id = "num_"+SEL_PD_CODE;
	
	//그룹내 상품 있는지 확인
	if($("#"+row_id).length > 0){
		alert("현재 그룹에 상품( "+SEL_PD_CODE+" | "+SEL_PD_NAME+" )이 포함되어 있습니다.");
		return;
	}
	
	var addNum = "";
	addNum = '<tr>'
				+'<td style="padding-right:5px;padding-bottom:5px;width:80px;">'
					+'<input id="'+num_id+'" class="form-control" style="margin-bottom:5px" type="text" name="PD_SORT" value="'+($('input[name="PD_SORT"]').length+1)+'" readonly="readonly"/>'
				+'</td>'
				+'<td style="padding-right:5px;padding-bottom:5px;width:240px;">'
					+'<input id="'+row_id+'" class="form-control" style="margin-bottom:5px" type="text" name="PD_CODE" value="'+SEL_PD_CODE+'" readonly="readonly"/>'
				+'</td>'
				+'<td style="padding-right:5px;padding-bottom:5px;width:240px;">'
					+'<input id="'+bar_id+'" class="form-control" style="margin-bottom:5px" type="text" name="PD_BARCD" value="'+SEL_PD_BARCD+'" readonly="readonly"/>'
				+'</td>'
				+'<td style="padding-right:5px;padding-bottom:5px;width:240px;">'
					+'<input id="'+nm_id+'"class="form-control" style="margin-bottom:5px" type="text" name="PD_NAME" value="'+SEL_PD_NAME+'" readonly="readonly"/>'
				+'</td>'
				+'<td style="padding-right:5px;padding-bottom:5px;">'
					//+'<a id="'+btn_id+'"style="margin-bottom:5px;height:33.98px;width:100%" class="btn btn-info pull-right" onclick="javascript:fn_pd_delete('+SEL_PD_CODE+');">삭제</a>'
					+'<a id="'+btn_id+'"style="margin-bottom:5px;height:33.98px;width:100%" class="btn btn-info pull-right" onclick="javascript:fn_pd_delete(\''+SEL_PD_CODE+'\');">삭제</a>'
				+'</td>'
			+ '</tr>';
	$("#rcmdPdList").append(addNum);
	
	//alert($("#code_"+SEL_PD_CODE).val() +"//"+$("#"+row_id).length);	
}

//상품추가 멀티리턴값
function fn_pd_multi_return(checkboxValues){
	var errormsg = "";

	for(var i=0; i<checkboxValues.length; i++){
		var pd_add = checkboxValues[i];
			
		var pdSplit = pd_add.split(',');	
		var pd_code = pdSplit[0];
		var pd_name = pdSplit[1];
		var pd_barcode = pdSplit[2];
		
		//그루핑 중복조회	
		$.ajax({
		    url: "${contextPath }/adm/productRcmdMgr/grpPdChk",
		    type: 'post',
		    data: 'PD_CODE='+ pd_code,
		    async: false,								//순차적으로 실행
		    success: function(data){                               
		    	 if(data=="success"){
		    		// 중복값이면 errormsg에 상품코드 쌓기
		    		if(errormsg.length < 1){
		    			errormsg = pd_code		    			
		    		}else{
		    			errormsg = errormsg + ', ' +pd_code	
		    		}
		    	 }else{
		    		// 중복이 아니면 상품추가,
		    		fn_pd_popup_return(pd_code, pd_name, pd_barcode);	    		
		    	 }
		    },
		    error: function(e){
		       alert("에러 :: 관리자에게 문의하세요.");
		    }
		});
	}
	
	// 중복상품 확인창
    if(errormsg.length > 0){
    	alert("이미 타그룹에 그룹핑된 상품이 포함되어 있습니다. 상품코드 : "+errormsg);
    }    
}

// 상품삭제
function fn_pd_delete(pd_code){
	
	$('#name_'+pd_code).remove();
	$('#code_'+pd_code).remove();
	$('#barcd_'+pd_code).remove();
	$('#btn_'+pd_code).remove();
	$('#num_'+pd_code).remove();
	
	/*
	var count = $('input[name="PD_SORT"]').length;
	for(i=0;i<count;i++){
		$("input[name=PD_SORT]:eq("+i+")").val(i+1) ;
	}
	*/
	/* var frm=document.getElementById("delProductFrm");
	frm.PD_CODE.value=pd_code;
	frm.GRP_CD.value=$('#GRP_CD').val();
	
	frm.submit(); */
}
</script>

<c:set var="strActionUrl" value="${contextPath }/adm/productRcmdMgr" />
<c:set var="strMethod" value="post" />
<c:if test="${ !empty tb_pdrcmdxm.GRP_CD }"><!-- 수정시 사용 -->
	<c:set var="strActionUrl" value="${contextPath }/adm/productRcmdMgr/${tb_pdrcmdxm.GRP_CD }" />
	<c:set var="strMethod" value="put" />
</c:if>


<section class="content-header">
	<h1>
		추천상품관리
		<small></small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">
	<!-- Horizontal Form -->
	<spform:form name="rcmdFrm" id="rcmdFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
		<!-- 내용 시작 -->
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">내용</h3>
			</div>
			<!-- /.box-header -->
	
			<!-- box-body -->
			<div class="box-body">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">그룹코드</label>
						<div class="col-sm-10">
							<c:choose>
							<c:when test="${ !empty tb_pdrcmdxm.GRP_CD }">
								${tb_pdrcmdxm.GRP_CD }
								<input type="hidden" id="GRP_CD" name="GRP_CD" value="${tb_pdrcmdxm.GRP_CD }" />
							</c:when>
							<c:otherwise>
								자동생성
							</c:otherwise>
							</c:choose>
						</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">그룹명</label>
						<div class="col-sm-8">
							<input class="form-control" type="text" id="GRP_NM" name="GRP_NM" value="${tb_pdrcmdxm.GRP_NM }" />
						</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">정렬순서</label>
						<div class="col-sm-3">
							<input class="form-control input-sm number" type="text" 
								id="SORT_ORDR" name="SORT_ORDR" value="${tb_pdrcmdxm.SORT_ORDR }" onblur="javascript:fn_ordr_chk();"
								maxlength="5"/>
							<input type="hidden" id="SORT_ORDR_CHK" name="SORT_ORDR_CHK" value="Y" />
						</div>
						<label for="inputEmail3" class="col-sm-2 control-label">사용여부</label>
						<div class="col-sm-3">
							<select name="USE_YN" id="USE_YN" class="form-control select2" style="width: 100%;">
								<option value="Y" ${tb_pdrcmdxm.USE_YN == 'Y' ? 'selected=selected':''}>사용</option>
								<option value="N" ${tb_pdrcmdxm.USE_YN == 'N' ? 'selected=selected':''}>미사용</option>
							</select>
							<%-- <input type="text" id="OUTPT_FG" name="OUTPT_FG" value="${tb_pdrcmdxm.OUTPT_FG }" /> --%>
						</div>
					</div><br/>
					<div class="form-group">
						<label for="RCMD_GUBN" class="col-sm-2 control-label">상품그룹구분</label>
						<div class="col-sm-3">
			                <jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="RCMD_GUBN" />
								<jsp:param name="name" value="RCMD_GUBN" />
								<jsp:param name="value" value="${ tb_pdrcmdxm.RCMD_GUBN }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</div>
					</div>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">그룹핑 상품</label>
						<div class="col-sm-8">
							<button type="button" class="btn btn-primary btnAdd" onclick="javascript:fn_pd_popup();">
								<i class="fa fa-plus"></i> 상품 추가 
							</button>
							<button type="button" class="btn btn-primary btnExcelUpload">
								<i class="fa fa-file-excel-o"></i> 상품 엑셀 업로드 
							</button>
							<button type="button" class="btn btn-primary btnExcelDownload">
								<i class="fa fa-file-excel-o"></i> 상품 엑셀 다운로드
							</button>
							<button type="button" class="btn btn-primary btnListDelete">
								<i class="fa fa-file-excel-o"></i> 상품 리스트 삭제
							</button>
						</div>
					</div>
						
						<!-- 추가실패목록 -->
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
								<div class="box-body">
									<table class="table table-bordered">
										<!-- <colgroup>
											<col style="with:50px "/>
											<col style="with:200px" />
											<col style="with:50px" />
										</colgroup> -->
										
										<thead>
											<tr>
												<th width = "70px">정렬순서</th> 
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
													<label>${list.SORT_ORDR}</label>
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
										
										<c:if test="${errlist.size() == 0}">
											<tr>
												<td colspan="4"><label>조회된 내용이 없습니다.</label></td>
											</tr>
										</c:if>
										
										</tbody>
									</table>
								</div>
							</div>
						
						</c:if>
					
						<label for="inputEmail3" class="col-sm-2 control-label"></label>
						<table id="rcmdPdList">
							<c:forEach items="${tb_pdinfoxm.list }" var="list" varStatus="loop">
								<tr>
									<td style="padding-right:5px;padding-bottom:5px;width:80px;">
										<input id="num_${list.PD_CODE }" class="form-control"
											type="text" name="PD_SORT" value="${list.SORT_ORDR}"/>
									</td>
									<td style="padding-right:5px;padding-bottom:5px;width:240px;">
										<input id="code_${list.PD_CODE }" class="form-control"  
											type="text" name="PD_CODE" value="${list.PD_CODE }" readonly="readonly"/>
									</td>
									<td style="padding-right:5px;padding-bottom:5px;width:240px;">
										<input id="barcd_${list.PD_CODE }" class="form-control" 
											type="text" name="PD_BARCD" value="${list.PD_BARCD }" readonly="readonly"/>
									</td>
									<td style="padding-right:5px;padding-bottom:5px;width:240px;">
										<input id="name_${list.PD_CODE }" class="form-control"
											type="text" name="PD_NAME" value="${list.PD_NAME }" readonly="readonly"/>
									</td>
									<td style="padding-right:5px;padding-bottom:5px;">
										<a id="btn_${list.PD_CODE }" style="height:33.98px;width:100%" 
											onclick="javascript:fn_pd_delete('${list.PD_CODE}');" class="btn btn-info pull-right">삭제</a>
									</td>
								</tr>
							</c:forEach>						
						</table>
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- 내용 끝 -->
			
			</spform:form>
			
			<div class="box-footer" >
				<a href="${contextPath}/adm/productRcmdMgr" class="btn btn-default pull-right">리스트</a>
				<a onclick="javascript:fn_save();" class="btn btn-info pull-right">저장</a>
				<c:if test="${ !empty tb_pdrcmdxm.GRP_CD }"><!-- 수정시 사용 -->
				<a onclick="javascript:fn_delete();" class="btn btn-info pull-right">삭제</a>
				</c:if>
			</div>
			
			<!-- /.box-footer -->
	<!-- /.box -->
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
            <form role="form">
            </form>
				<!-- 기업정보 박스 -->
					<div class="box box-info">
						<div class="box-header with-border">
							<h3 class="box-title">업로드</h3>
						</div>
						<!-- /.box-header -->
					
						<!-- box-body -->
						<spform:form name="excelFrm" id="excelFrm" method="post" action="${contextPath }/adm/productRcmdMgr/excelUpload" role="form" class="form-horizontal" enctype="multipart/form-data">
						<input type="hidden" name="GRP_CD" value="${tb_pdrcmdxm.GRP_CD }" />
						<div class="box-body">

							<div class="form-group">
								<label for="MEMB_ID" class="col-sm-2 control-label">양식파일</label>
								<div class="col-sm-10">
									<button type="button" class="btn btn-primary pull-left" id="btnExcelDown"><i class="fa fa-download"></i> 양식 받기 </button>
								</div>
							</div>
							<div class="form-group">
								<label for="MEMB_MAIL" class="col-sm-2 control-label">중복처리</label>
								<div class="col-sm-10">
				                  <div class="checkbox">
				                    <label>
				                      <input name="CHK_UPDATE" value="Y" type="checkbox">상품바코드 중복시 엑셀파일 데이타로 덮어쓰기
				                    </label>
				                  </div>
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
 
 
 <spform:form name="delFrm" id="delFrm" method="DELETE" action="${contextPath }/adm/productRcmdMgr/${tb_pdrcmdxm.GRP_CD }" class="form-horizontal">
 </spform:form>
 
 <spform:form name="delProductFrm" id="delProductFrm" method="GET" action="${contextPath }/adm/productRcmdMgr/deleteProduct">
 	<input type="hidden" name="PD_CODE" value=""/>
 	<input type="hidden" name="GRP_CD" value=""/>
 </spform:form>
