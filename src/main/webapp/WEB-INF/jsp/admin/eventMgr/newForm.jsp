<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.css">
<link rel="stylesheet" href="https://uicdn.toast.com/editor/2.0.0/toastui-editor.min.css">

<!-- <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" /> -->

<section class="content-header">
	<h1>기획전상품관리<small>기획전상품목록</small></h1>
</section>

<section class="content">
	<!-- Horizontal Form -->
	<spform:form name="eventFrm" id="eventFrm" method="POST" action="${contextPath }/adm/eventMgr" class="form-horizontal" enctype="multipart/form-data">
		<input type="hidden" id="GRP_CD_CHK_YN" name="GRP_CD_CHK_YN" value="N"/>
		<input type="hidden" id="ATFL_ID" name="ATFL_ID" value="${tb_event_main.ATFL_ID }"><!-- 메인사진 -->	
		<input type="hidden" id="RPIMG_SEQ" name="RPIMG_SEQ" value="${ tb_event_main.RPIMG_SEQ }"><!-- 메인사진SEQ -->
		<input type="hidden" id="ATFL_ID_D" name="ATFL_ID_D" value="${tb_event_main.ATFL_ID_D }"><!-- 상세사진 -->	
		<!-- <input name="D_USE_YN" id="D_USE_YN" type="hidden" value="Y" /> --><!-- 상세사진 사용여부  -->
		<input name="D_USE_YN" id="D_USE_YN" type="hidden" /><!-- 상세사진 사용여부  -->
		<!-- 내용 시작 -->
		<div class="box box-info">
		
			<div class="box-header with-border">
				<h3 class="box-title">기획전내용</h3>
				<button type="button" class="btn btn-default btn-sm pull-right btnHelp"><i class="fa fa-question-circle"></i> 도움말</button>
			</div>
			<!-- box-body -->
			<div class="box-body">
			
			<!-- 대표사진이 있으면  -->
			  <c:if test="${ !empty(tb_event_main.GRP_CD) and !empty(fileList) }">
					<div class="form-group">                                        
				        <label class="col-md-2 control-label required">대표이미지 목록</label>
				        <div class="col-md-9">
				        	<c:forEach var="var" items="${ fileList }" varStatus="status">
				        		<c:if test="${var.FILEPATH_FLAG eq mainKey }">													
									<c:set var="imgPath" value="${contextPath }/upload/${var.STFL_PATH }/${var.STFL_NAME }" />
								</c:if>
								<c:if test="${!empty(var.FILEPATH_FLAG) and var.FILEPATH_FLAG ne mainKey }">
									<c:set var="imgPath" value="${var.STFL_PATH }" />
								</c:if>
								<input class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" name="mainFileOrdrIn" type="radio" id="seq${var.ATFL_SEQ}" value="${var.ATFL_SEQ}" ${productInfo.RPIMG_SEQ eq var.ATFL_SEQ ? "checked" : ""} />
								<label class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" for="seq${var.ATFL_SEQ}">${var.ORFL_NAME }</label>
								<button type="button" class="btn btn-xs btn-primary file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:doImgPop('${imgPath}')" >이미지 보기</button>
								<button type="button" class="btn btn-xs btn-danger file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:fn_fileDelete(this, '${var.ATFL_ID}', '${var.ATFL_SEQ}')">삭제</button>
				        		<br>
			                </c:forEach>
			                <div class="col-md-5">
		                		<p class="form-control-static required">*대표이미지를 체크해야 정상 노출이 됩니다.</p>
		                	</div>
						</div>
					</div>
			   </c:if>
			   <div class="form-group">
			        <label class="col-md-2 control-label required">대표이미지 첨부</label>
			        <div class="col-md-3">
		                <input name="file" type="file" id="file-simple">
			        </div>
			    </div>
			    
			    <div style="display: none">
					<c:if test="${ !empty(tb_event_main.GRP_CD) and !empty(fileDtlList) }">
						<div class="form-group">                                        
					        <label class="col-md-2 control-label required">상세 첨부파일 목록</label>
					        <div class="col-md-9"> 
					        	<c:forEach var="var" items="${ fileDtlList }" varStatus="status">
							        <c:if test="${var.FILEPATH_FLAG eq mainKey }">													
										<c:set var="imgDtlPath" value="${contextPath }/upload/${var.STFL_PATH }/${var.STFL_NAME }" />
									</c:if>
									<c:if test="${!empty(var.FILEPATH_FLAG) and var.FILEPATH_FLAG ne mainKey }">
										<c:set var="imgDtlPath" value="${var.STFL_PATH }" />
									</c:if>
									<input type="hidden" id="detail" value="${var.ORFL_NAME}"/>
									<label class="file_${var.ATFL_ID}_${var.ATFL_SEQ}"  for="seq${var.ATFL_SEQ}">${var.ORFL_NAME } (경로 : ${imgDtlPath})</label>
									<button type="button" class="btn btn-xs btn-primary file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:doImgPop('${imgDtlPath}')" >이미지 보기</button>
									<button type="button" class="btn btn-xs btn-danger file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:fn_fileDelete(this, '${var.ATFL_ID}', '${var.ATFL_SEQ}')">삭제</button>
					        		<br>
				                </c:forEach>
							</div>
						</div>
				    </c:if>
				    
				    <div class="form-group">                                        
				        <label class="col-md-2 control-label required">상세이미지 첨부</label>
				        <div class="col-md-3">
			                <input onclick="javascript:Imagechk();" name="fileDtl" type="file" id="file-simple" class="fileDtl" onchange="fileUpload()" >
			                <input type="hidden" class="fileDtl2" id="fileDtl2"/><!-- 상세이미지  -->
				        </div>
				    </div>
				</div>
				    
				    
				<div class="form-group">
					<label for="GRP_CD" class="col-sm-2 control-label required">기획전코드</label>
					<div class="col-sm-10">
						<c:choose>
							<c:when test="${ !empty tb_event_main.GRP_CD }">
								<input type="hidden" name="val" value="N"/>
								<p class="form-control-static">
									${tb_event_main.GRP_CD }
									 <input type="hidden" name="GRP_CD" id="GRP_CD" value="${tb_event_main.GRP_CD }">
								</p>
							</c:when>
							<c:otherwise>
								<div class="input-group input-group-sm col-sm-5">
									<input type="hidden" name="val" value="Y"/>
									<input type="text" class="form-control input-sm" name="GRP_CD" id="GRP_CD" maxlength="13" placeholder="예:0000001(13자리숫자)"/>
									<span class="input-group-btn">
										<button type="button" class="btn btn-warning btn-flat" id="btnDupChk">중복확인</button>
									</span>
									
								</div>
								<div class="text-info" id="chkTxt"></div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<div class="form-group">
					<label for="GRP_NM" class="col-sm-2 control-label required">기획전이름</label>
					<div class="col-sm-7">
						<c:choose>
							<c:when test="${ !empty tb_event_main.GRP_CD }">
								<p class="form-control-static">
									<input class="form-control input-sm" type="text" id="GRP_NM" name="GRP_NM" value="${tb_event_main.GRP_NM }" maxlength="50"/>
								</p>
							</c:when>
							<c:otherwise>
								<input class="form-control input-sm" type="text" id="GRP_NM" name="GRP_NM"  placeholder="예:인테리어특가상품" maxlength="50"/>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<div class="form-group">
					<label for="USE_YN" class="col-sm-2 control-label required">사용여부</label>
					<div class="col-sm-7">
						<p class="form-control-static">
			                <jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="COMM_YN" />
								<jsp:param name="name" value="USE_YN" />
								<jsp:param name="value" value="${ tb_event_main.USE_YN }" />
								<jsp:param name="type" value="radio" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-2 control-label required">광고기간 시작</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="START_DT" name="START_DT" value="${tb_event_main.START_DT }" placeholder="예) 2021.01.01" style="width:150px;" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label required">광고기간 종료</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="END_DT" name="END_DT" value="${tb_event_main.END_DT }" placeholder="예) 12.31" style="width:150px;" />
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label required">그룹핑 상품</label>
					<div class="col-sm-8">
						<button type="button" class="btn btn-primary btn-sm btnAdd"  onclick="javascript:fn_pd_popup();" >
						<!---->
							<i class="fa fa-plus"></i> 상품 추가 
						</button>
						<button type="button" class="btn btn-danger btn-sm btnListDelete">
							<i class="fa fa-minus"></i> 목록 초기화
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
										<td align="center"><label>${list.SORT_ORDR}</label></td>
										<td align="left"><label>${list.PD_BARCD}</label></td>
										<td align="left"><label>${list.PD_NAME}</label></td>
										<td align="left"><label>${list.ERROR_CODE}</label></td>
										<td align="left"><label>${list.ERROR_TEXT}</label></td>		
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
				<table id="eventPdList">
					<tbody>
					<c:forEach items="${tb_pdinfoxm.list }" var="list" varStatus="loop">
						<tr>
							<td style="padding-right:5px;padding-bottom:5px;width:240px;">
								<input id="code_${list.PD_CODE }" class="form-control" type="text" name="PD_CODE" value="${list.PD_CODE }" readonly="readonly"/>
							</td>
							<td style="padding-right:5px;padding-bottom:5px;width:240px;">
								<input id="barcd_${list.PD_CODE }" class="form-control" type="text" name="PD_BARCD" value="${list.PD_BARCD }" readonly="readonly"/>
							</td>
							<td style="padding-right:5px;padding-bottom:5px;width:240px;">
								<input id="name_${list.PD_CODE }" class="form-control" type="text" name="PD_NAME" value="${list.PD_NAME }" readonly="readonly"/>
							</td>
							<td style="padding-right:5px;padding-bottom:5px;">
								<a id="btn_${list.PD_CODE }" style="height:33.98px;width:100%" onclick="javascript:fn_pd_delete('${list.PD_CODE}');" class="btn btn-info pull-right">삭제</a>
							</td>
						</tr>
					</c:forEach>	
					</tbody>					
				</table>
			</div>
		</div>
		<!-- /.box-body -->
	<!-- 내용 끝 -->
	
	
	</spform:form>
	
	<!-- toast 에디터 -->
	<div id="editor" style="box-sizing: border-box; height: 500px;"></div>
	<!-- <input type="button" value="test" onclick="testtest123()">
	<button onclick="ToView();">↓↓↓ 불러서 넣기 ↓↓↓</button>
	<div id="viewer"></div> -->
	
	<div class="box-footer" >
		<a href="${contextPath}/adm/eventMgr" class="btn btn-default pull-right"><i class="fa fa-list"></i> 목록</a>
		<button type="button" id="btnSave" class="btn btn-primary pull-right right-5">
				<i class="fa fa-save"></i> 저장
		</button>
		<c:if test="${ !empty tb_event_main.GRP_CD }"><!-- 수정시 사용 -->
		<a onclick="javascript:fn_delete();" class="btn btn-danger pull-right right-5">삭제</a>
		</c:if>
	</div>
	<!-- /.box-footer -->
</section>


 <!-- 기획전삭제 -->
 <spform:form name="deletFrm" id="deletFrm" method="DELETE" action="${contextPath }/adm/eventMgr/${tb_event_main.GRP_CD }" class="form-horizontal">
 </spform:form>
 <!-- 기획전상품삭제 -->
 <spform:form name="delProductFrm" id="delProductFrm" method="GET" action="${contextPath }/adm/eventMgr/deleteProduct">
 	<input type="hidden" name="PD_CODE" value=""/>
 	<input type="hidden" name="GRP_CD" value=""/>
 </spform:form>
 <!-- 기획전코드중복확인 -->
 <form id="grpCdFrm" name="grpCdFrm" action="${contextPath }/adm/eventMgr/grpChk" method="post" autocomplete="off">
	<input type="hidden" id="CHK_GRP_CD" name="GRP_CD" />
</form>
 
<form id="delFrm" name="delFrm" class="form-horizontal" method="post">
	<input type="hidden" id="delATFL_ID" name="ATFL_ID" value=""/>
	<input type="hidden" id="delATFL_SEQ" name="ATFL_SEQ">
</form>


<!-- <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script> -->
<script src="https://uicdn.toast.com/editor/2.0.0/toastui-editor-all.min.js"></script>
<script type="text/javascript">
// toast 에디터
const content = [].join('\n');

const editor = new toastui.Editor({
    el: document.querySelector('#editor'),
    language: "ko-KR",
    previewStyle: 'vertical',
    initialEditType: "markdown",
    height: '500px',
    initialValue: '본문입력영역  \n이미지 이름과 경로에 한글을 제거해주세요'
});

editor.addHook("addImageBlobHook", function(blob, callback){
   // blob 텍스트 
   console.log(blob);
   callback(toastImgUpload(blob));
});

function toastImgUpload(blob){
	let imgPath;
	
	let formData = new FormData();
    formData.append("file", blob);
	$.ajax({
        url:"imgUpload.json",
        type:"POST",
        enctype: 'multipart/form-data',
        dataType: 'json',
        processData: false,   //경로 두번찍힘
        contentType: false,
        async: false,	//리턴시 값 넘기기
        data: formData,
        success : function(data) {
       		//데이터 가져오기
       		imgPath = data.imgPath;
       		//alert(data.test);
        },
        error : function(jqXHR, textStatus, errorThrown) {
       	 alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
        }
  });
	//console.log(test123);
  return imgPath;
}

/* const viewer = toastui.Editor.factory({
    el: document.querySelector('#viewer'),
    viewer: true,
    height: '500px',
    initialValue: content
});

function ToView(){
	alert(editor.getMarkdown());
	alert(editor.getHtml());
    viewer.setMarkdown(editor.getMarkdown());
}; */

/* const editor = new toastui.Editor({
	el: document.querySelector('#editortest123'),
	previewStyle: 'vertical',
	previewHighlight: false,
	height: '500px',
	initialValue: ''
}); */

$(document).ready(function(){

  	//기획전상품초기화
    $(".btnListDelete").click(function(){	
		$('#eventPdList').empty();
    });
	
	/* 상품코드 중복확인 */
	$("#btnDupChk").click(function(){
		var strPdCode = $("#GRP_CD").val();
		
		$("#CHK_GRP_CD").val(strPdCode);
		
		if(strPdCode == ""){
			alert("기획전코드를 입력해 주세요");
			return false;
		}
		
		$.ajax({
			type: "POST",
			url: "${contextPath}/adm/eventMgr/grpChk",
			data: $("#grpCdFrm").serialize(),
			success: function (data) {
				// 제품코드 중복 여부
				if (data == '0') {
					$('#chkTxt').html("<span><font color='blue'>사용할 수 있는 기획전코드입니다.</font></span>");
					$('#GRP_CD_CHK_YN').val("Y");
				}else{
					$('#chkTxt').html("<span><font color='red'>사용할 수 없는 기획전코드입니다.</font></span>");
					$('#GRP_CD_CHK_YN').val("N");
				}
			}, error: function (jqXHR, textStatus, errorThrown) {
				alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
			}
		});		
	});
	
	
	
	/* 저장 */
	$("#btnSave").click(function(){
		
		// 대표이미지 순번 체크
		$("#RPIMG_SEQ").val( $(':radio[name="mainFileOrdrIn"]:checked').val());
		if($(':radio[name="mainFileOrdrIn"]:checked').val() == null || $(':radio[name="mainFileOrdrIn"]:checked').val() == undefined || $(':radio[name="mainFileOrdrIn"]:checked').val() == ''){
			$("#RPIMG_SEQ").val("1");
		}
		
		if(!$('#detail').val() == null || !$('#detail').val() == ""){
			if(!$('#fileDtl2').val() == null || !$('#fileDtl2').val() == ""){
			alert("상세이미지는 하나만 등록할수 있습니다. ");
			return false;
			}
		}
		
		
		document.getElementById("D_USE_YN").value = editor.getHtml();
		
		//alert(document.getElementById("D_USE_YN").value);
		
		$("#eventFrm").submit();
	});
	
	/* 저장 필수값 체크 */
    $('#eventFrm').validate({
        debug: false,
        onfocusout: false,
        rules: {
        	GRP_CD: {
                required: true
            },
            GRP_NM: {
                required: true
            },
            START_DT: {
                required: true
            },
            ENT_DT: {
                required: true
            }
        }, messages: {
        	GRP_CD: {
                required: '기획천코드를 입력해주세요.'
            },
            GRP_NM: {
                required: '기획전명을 선택해주세요.'
            },
            START_DT: {
                required: '시작일자를 입력해주세요.'
            },
            ENT_DT: {
                required: '종료일자를 입력해주세요.'
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

//이미지 값가져오기
function fileUpload(){
	var fileInput = document.getElementsByClassName("fileDtl");
	for( var i=0; i<fileInput.length; i++ ){
		if( fileInput[i].files.length > 0 ){
			for( var j = 0; j < fileInput[i].files.length; j++ ){
				document.getElementById("fileDtl2").value = fileInput[i].files[j].name;
			}
		}
	}
}



//삭제버큰 클릭시
function fn_delete(){
	if(!confirm("삭제 하시겠습니까?")) return;
	var frm=document.getElementById("deletFrm");
	frm.submit();
	
}

//상품선택 팝업 호출
function fn_pd_popup(){
	window.open("${contextPath }/adm/eventMgr/popup", "_blank", "width=900,height=900"); 
}

//상품선택 팝업 리턴값
function fn_pd_popup_return(SEL_PD_CODE,SEL_PD_NAME,SEL_PD_BARCD){
	var frm=document.getElementById("eventFrm");
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
					+'<a id="'+btn_id+'"style="margin-bottom:5px;height:33.98px;width:100%" class="btn btn-info pull-right" onclick="javascript:fn_pd_delete(\''+SEL_PD_CODE+'\');">삭제</a>'
				+'</td>'
			+ '</tr>';
	$("#eventPdList").append(addNum);
	
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
		    url: "${contextPath }/adm/eventMgr/grpPdChk",
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
	
}
/* 첨부파일 삭제 */
function fn_fileDelete(obj, ATFL_ID, ATFL_SEQ) {
	if( "${tb_event_main.ATFL_ID }" == ATFL_ID && $(':radio[name="mainFileOrdrIn"]:checked').val() == ATFL_SEQ){
		alert("대표이미지는 삭제할 수 없습니다.");
		return;
	}
	if(!confirm("삭제하시겠습니까?"))
	return;
	
	location.reload();
	
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
/* 첨부파일 이미지보기 */
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

 function Imagechk(){
	if( !document.getElementById('detail').value == null || !document.getElementById('detail').value ==""){
		alert("기존의 상세첨부파일을 삭제하고 등록해주세요 ");
	}
	 return;
} 
</script>

