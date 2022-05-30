<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>

<section class="content-header">
	<h1>전단관리</h1>
</section>

<c:set var="strActionUrl" value="${contextPath }/adm/jundanMgr" />
<c:set var="strMethod" value="post" />
<%-- 
<c:if test="${ !empty jdinfo.JD_ID }">
	<c:set var="strActionUrl" value="${contextPath }/adm/jundanMgr/edit" />
	<c:set var="strMethod" value="put" />
</c:if>
 --%>
<section class="content">
	<!-- 전단 정보 시작 -->
	<spform:form name="saveFrm" id="saveFrm" method="${strMethod}" action="${strActionUrl}" class="form-horizontal" enctype="multipart/form-data" >
		<!-- hidden value -->
		<%-- <input type="hidden" id="pageNum" name="pageNum" value="${param.pageNum }" /> --%> 
		<%-- <input type="hidden" id="rowCnt" name="rowCnt" value="${param.rowCnt }" /> --%> 
		<%-- <input type="hidden" id="schTxt" name="schTxt" value="${param.schTxt }" />  --%>
		
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">전단정보</h3>
			</div>
			<!-- /.box-header -->

			<!-- box-body -->			
			<div class="box-body">
				
				<div class="form-group">
					<label class="col-sm-2 control-label">전단 구분</label>
					<div class="col-sm-10">
						<c:set var="JD_GUBN" value="1" />
						<c:if test="${ !empty jdverinfo.JD_ID }">
							<c:set var="JD_GUBN" value="${ jdverinfo.JD_GUBN }" />
						</c:if>
						<label class="check" style="margin-right: 10px">
							<input type="radio" class="iradio" name="JD_GUBN" value="1" ${JD_GUBN eq '1' ? 'checked' : '' } /> 온라인
						</label>
						<label class="check" style="margin-right: 10px"> 
							<input type="radio" class="iradio" name="JD_GUBN" value="2" ${JD_GUBN eq '2' ? 'checked' : '' }/> 오프라인
						</label>
					</div>
				</div>				
				
				<div class="form-group">
					<label class="col-sm-2 control-label">전단 주소</label>
					<div class="col-sm-8">
						<p>
							온라인 : http://www.cjflsmart.co.kr/adCjOn<br>
							오프라인(삼성점) : http://www.cjflsmart.co.kr/adCjOff
						</p>
					</div>
				</div>				
						
				<!-- 전단 첨부파일 -->
				<div class="form-group">
					<label class="col-md-2 control-label">전단 1면</label>					
					<div class="col-md-3">
						<input type="file" name="jdImgFile1" id="file-simple1" >
						<button type="button" class="btn btn-xs btn-primary" onclick="javascript:readURL($('#file-simple1').val(), 1)" >이미지 보기</button>
					</div>					
				</div>				
				<div class="form-group">
					<label class="col-md-2 control-label">전단 2면</label>
					<div class="col-md-3">
						<input type="file" name="jdImgFile2" id="file-simple2">
						<button type="button" class="btn btn-xs btn-primary" onclick="javascript:readURL($('#file-simple2').val(), 2)" >이미지 보기</button>
					</div>
				</div>	
				<!-- 							
				<div class="form-group">
					<label class="col-md-2 control-label">전단 3면</label>
					<div class="col-md-3">
						<input type="file" name="jdImgFile3" id="file-simple3">
						<button type="button" class="btn btn-xs btn-primary" onclick="javascript:readURL($('#file-simple3').val())" >이미지 보기</button>
					</div>
				</div>								
				<div class="form-group">
					<label class="col-md-2 control-label">전단 4면</label>
					<div class="col-md-3">
						<input type="file" name="jdImgFile4" id="file-simple4">
						<button type="button" class="btn btn-xs btn-primary" onclick="javascript:readURL($('#file-simple4').val())" >이미지 보기</button>
					</div>
				</div>
				 -->
				<div class="form-group">
					<label for="PD_DINFO" class="col-md-2 control-label">이용안내</label>
					<div class="col-md-8">
						<p class="form-control-static" style="color:red">* 전단교체 : 교체할 이미지를 첨부한 후 저장해주세요.<br>
																							* 전단삭제 : 전단을 교체하지 않고, 기존전단을 내릴경우 전단삭제를 눌러주세요.</p>
					</div>
				</div>
				<%-- 
				<c:if test="${ empty(jdverinfo.JD_FL4) || empty(fileList4) }">
					<div class="form-group">                                        
				        <label class="col-md-2 control-label">4면 이미지목록</label>
				        <div class="col-md-10">
				        	<c:forEach var="var" items="${ fileList4 }" varStatus="status">
				        		<input class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" name="mainFileOrdrIn" type="radio" id="seq${var.ATFL_SEQ}" value="${var.ATFL_SEQ}" ${productInfo.RPIMG_SEQ eq var.ATFL_SEQ ? "checked" : ""} />
								<label class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" for="seq${var.ATFL_SEQ}">${var.ORFL_NAME } (경로 : ${contextPath }/common/commonFileDown?ATFL_ID=${var.ATFL_ID }&ATFL_SEQ=${var.ATFL_SEQ})</label>
								<button type="button" class="btn btn-xs btn-primary file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:doImgPop('${contextPath }/common/commonFileDown?ATFL_ID=${var.ATFL_ID }&ATFL_SEQ=${var.ATFL_SEQ}')" >이미지 보기</button>
								<button type="button" class="btn btn-xs btn-danger file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:fn_fileDelete(this, '${var.ATFL_ID}', '${var.ATFL_SEQ}')">삭제</button>
				        		<br>
			                </c:forEach>						
						</div>				
					</div>
				</c:if>
				 --%>	
				<!-- 전단 정보 끝 -->

			</div>
			<!-- /.box-body -->
		</div>
		<div class="row">
			<div class="col-xs-12">
				<button type="button" class="btn btn-danger pull-right btnDel" style="margin-left: 5px; margin-bottom: 20px;">
					<i class="fa fa-remove"></i> 전단삭제 </button>						
				<button type="button" class="btn btn-primary pull-right btnSave" style="margin-left: 5px; margin-bottom: 20px;">
					<i class="fa fa-save"></i> 저장 </button>	
				<!-- <button type="button" class="btn btn-success pull-right btnView" style="margin-left: 10px; margin-bottom: 20px;">
					<i class="fa fa-clone"></i> 미리보기 </button>	 -->				
			</div>
		</div>
		
	</spform:form>
</section>

<script type="text/javascript">
	$(function() {
	    //숫자만 입력토록 함.
	    $(document).on("keyup", ".number", function() {
	    	$(this).number(true);
	    });
	    
		$('.goodsImg').each(function() {
			$(this).error(function(){
				$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
			});
		});
		
		$(".btnSave").click(function() {
	    	// 전단체크
	    	var jdgbun = $("input[name=JD_GUBN]:checked").val();
	    	var onoff;	    	
	    	if(jdgbun == "1"){
	    		onoff = "온라인 전단";
	    	}else if(jdgbun == "2"){
	    		onoff = "오프라인 전단";
	    	}else{
	    		alert( "전단구분은 필수 입력 항목입니다.");
	        	return false;
	    	}
	    	
	    	// 파일체크
	    	var filenull = $('#file-simple1').val() + $('#file-simple2').val();  /* + $('#file-simple3').val() + $('#file-simple4').val(); */
	    	if(filenull == null || filenull == ""){
	    		alert( "저장할 파일이 없습니다. 파일을 첨부해주세요.");
	        	return false;
	    	}
	    		    	
			if(!confirm(onoff+"을 저장하시겠습니까?")) return;			
			
			$("#saveFrm").attr("action","${contextPath }/adm/jundanMgr");
			$("#saveFrm").submit();
		});
		
		$(".btnDel").click(function(){
			if(!confirm("현재 진행중인 전단이 모두 삭제 됩니다. 삭제하시겠습니까?")) return;
			$("#saveFrm").attr("action","${contextPath }/adm/jundanMgr/delete");
			$("#saveFrm").submit();
		});
		
		$(".btnView").click(function(){
		    window.open("${contextPath }/jundanNew?JD_ID=${jdverinfo.JD_ID}&view=preview", "전단 미리보기", "width=1150, height=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes" );
        });

	});
	
	function readURL(img, index){
		var fileName = img.split('\\').pop();					//파일명		
		ext = fileName.split('.').pop().toLowerCase();		//확장자
		
		//배열에 추출한 확장자가 존재하는지 체크
		if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
            resetFormElement($('#file-simple'+index)); 	//폼 초기화
            window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
        } else {
            file = $('#file-simple'+index).prop("files")[0];
            blobURL = window.URL.createObjectURL(file);      //file url 생성
            viewImage(blobURL);
        }
	}
	
	// 이미지보기(준비중)	-- 로컬 경로 가져와서 팝업 띄워줘야함
	var img1= new Image(); 	
	function doImgPop(img){ 
		alert("개발 준비중입니다....");
		/* 
		img1= new Image(); 
		img1.src=(img); 
		imgControll(img);
		 */
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
		W=img1.width+549; 
		H=img1.height+768; 
		O="width="+W+",height="+H+",scrollbars=yes"; 
		imgWin=window.open("","",O); 
		imgWin.document.write("<html><head><title>:: 이미지상세보기 ::</title></head>");
		imgWin.document.write("<body topmargin=0 leftmargin=0>");
		imgWin.document.write("<img src="+img+" onclick='self.close()' style='cursor:pointer; width:549; height:768;' title ='클릭하시면 창이 닫힙니다.'>");
		imgWin.document.close();
	}
</script>
