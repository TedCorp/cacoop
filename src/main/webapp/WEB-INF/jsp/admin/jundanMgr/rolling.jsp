<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>

<section class="content-header">
	<h1>메인관리</h1>
</section>

<c:set var="strActionUrl" value="${contextPath }/adm/jundanMgr/rolling" />
<c:set var="strMethod" value="post" />

<section class="content">
	<!-- 롤링 정보 시작 -->
	<spform:form name="saveFrm" id="saveFrm" method="${strMethod}" action="${strActionUrl}" class="form-horizontal" enctype="multipart/form-data" >

		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">롤링이미지정보</h3>
			</div>
			<!-- box-body -->			
			<div class="box-body">
				<!-- 롤링이미지 구분 -->
				<div class="form-group">
					<label class="col-sm-2 control-label">노출 타입</label>
					<div>
						<p class="form-control-static" style="padding-top : 5px;">
							<strong>웹 페이지</strong> <input type="radio" name="uploadtype" value="web" checked="checked" onchange="javascript:fn_chk_yn();" />
							&ensp;
							<strong>모바일</strong> <input type="radio" name="uploadtype" value="mobile" onchange="javascript:fn_chk_yn();" />
							&emsp;
							<span style="color:red">* 체크 한 페이지에 해당 이미지가 적용됩니다.</span>
						</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-2 control-label">롤링 구분</label>
					<div class="col-sm-10">
						<c:set var="JD_GUBN" value="1" />
						<c:if test="${ !empty obj.JD_ID }">
							<c:set var="JD_GUBN" value="${ obj.JD_GUBN }" />
						</c:if>
						<label class="check" style="margin-right: 10px">
							<input type="radio" class="iradio" name="JD_GUBN" value="1" ${JD_GUBN eq '1' ? 'checked' : '' } onchange="javascript:fn_chk_yn();" /> 1면
						</label>
						<label class="check" style="margin-right: 10px"> 
							<input type="radio" class="iradio" name="JD_GUBN" value="2" ${JD_GUBN eq '2' ? 'checked' : '' } onchange="javascript:fn_chk_yn();" /> 2면
						</label>
						<label class="check" style="margin-right: 10px">
							<input type="radio" class="iradio" name="JD_GUBN" value="3" ${JD_GUBN eq '3' ? 'checked' : '' } onchange="javascript:fn_chk_yn();" /> 3면
						</label>
						<label class="check" style="margin-right: 10px"> 
							<input type="radio" class="iradio" name="JD_GUBN" value="4" ${JD_GUBN eq '4' ? 'checked' : '' } onchange="javascript:fn_chk_yn();" /> 4면
						</label> 
						<label class="check" style="margin-right: 10px">
							<input type="radio" class="iradio" name="JD_GUBN" value="5" ${JD_GUBN eq '5' ? 'checked' : '' } onchange="javascript:fn_chk_yn();" /> 5면
						</label>
						<label class="check" style="margin-right: 10px">
							<input type="radio" class="iradio" name="JD_GUBN" value="6" ${JD_GUBN eq '6' ? 'checked' : '' } onchange="javascript:fn_chk_yn();" /> 6면
						</label> 
					</div>
				</div>				
				
				<!-- 현재등록된 롤링이미지 -->
				<div class="form-group">
					<label class="col-md-2 control-label">현재이미지</label>
					<div class="col-md-8">
						<img id= "file-rolImg" class="imgHelp" src="${contextPath }/upload/${obj.JD_PATH}${obj.JD_FL1 }" alt="...">
						<input type="hidden" id="JD_LIST" name="JD_LIST" value = "">						
					</div>
				</div>
				
				<!-- 롤링 첨부파일 -->
				<div class="form-group">
					<label class="col-md-2 control-label">교체이미지</label>					
					<div class="col-md-3">
						<input type="file" name="rolImgFile" id="file-simple">
						<button type="button" class="btn btn-xs btn-primary" onclick="javascript:readURL($('#file-simple').val())" >이미지 보기</button>						
					</div>					
				</div>		
				
				<!-- 안내사항 -->
				<div class="form-group">
					<label for="PD_DINFO" class="col-md-2 control-label">이용안내</label>
					<div class="col-md-4">
						<p class="form-control-static" style="color:red">
							* Web Img Size: 1462px X 362px <br>
							* Mobile Img Size: 390px X 362px
						</p>
					</div>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
		<div class="row">
			<div class="col-xs-12">
				<button type="button" class="btn btn-danger pull-right btnDel" style="margin-left: 5px; margin-bottom: 20px;">
					<i class="fa fa-remove"></i> 삭제 </button>						
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
		// 롤링이미지 불러오기
		fn_chk_yn();
		
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
	    	// 롤링구분 체크
	    	var jdgbun = $("input[name=JD_GUBN]:checked").val();	    	
	    	if(jdgbun == "" || jdgbun == null){
	    		alert( "롤링구분은 필수 입력 항목입니다.");
	        	return false;
	    	}
	    	
	    	// 파일체크
	    	var filenull = $('#file-simple').val();
	    	if(filenull == null || filenull == ""){
	    		alert( "저장할 파일이 없습니다. 파일을 첨부해주세요.");
	        	return false;
	    	}
	    	
			if(!confirm("롤링이미지 "+jdgbun+"면을 저장하시겠습니까?")) return;			
			
			$("#saveFrm").attr("action","${contextPath }/adm/jundanMgr/rolling");
			$("#saveFrm").submit();
		});
		
		$(".btnDel").click(function(){
			if(!confirm("해당 이미지가 삭제됩니다. 삭제하시겠습니까?")) return;
			$("#saveFrm").attr("action","${contextPath }/adm/jundanMgr/move");
			$("#saveFrm").submit();
		});
		
		$(".btnView").click(function(){
		    window.open("${contextPath }/jundanNew?JD_ID=${jdverinfo.JD_ID}&view=preview", "전단 미리보기", "width=1150, height=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes" );
        });

	});
	
	/* 구분별 현재 롤링이미지 */
	function fn_chk_yn(){
		var uploadtype = $("input[name='uploadtype']:checked").val();
		
		//alert(uploadtype);
		// 현재 등록된 이미지 불러오기
		$.ajax({
	         type:"GET",
	         dataType: 'json',
	         url:"${contextPath}/adm/jundanMgr/rolImg.json",
	         data: $("form[name='saveFrm']").serialize(),
	         success : function(data) {
              	console.log(data);
	        	
	        	//image value change
	        	if(data.jd_LIST == null || data.jd_LIST == ""){
	        		$("#file-rolImg").attr("src", "${contextPath }/resources/images/mall/goods/noimage.png");	        			
	        	}else{
	        		if (uploadtype === "web"){
	        			$("#file-rolImg").attr("src", "${contextPath }/upload/jundan/main/"+data.jd_LIST);
	        		} else if (uploadtype === "mobile"){
	        			$("#file-rolImg").attr("src", "${contextPath }/upload/jundan/mobile/"+data.jd_LIST);
	        		}
	        		
	        		$('#JD_LIST').val(data.jd_LIST);
	        	}
	         },
	         error : function(jqXHR, textStatus, errorThrown) {
	        	 alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
	         }
	   });
	}

	
	/* 이미지 미리보기 */	
	function readURL(img){
		var fileName = img.split('\\').pop();					//파일명		
		ext = fileName.split('.').pop().toLowerCase();		//확장자
		
		//배열에 추출한 확장자가 존재하는지 체크
		if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
            resetFormElement($('#file-simple')); 	//폼 초기화
            window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
        } else {
            file = $('#file-simple').prop("files")[0];
            blobURL = window.URL.createObjectURL(file);      //file url 생성
            viewImage(blobURL);
        }
	}
	
	/* 미리보기 레이아웃 */	
	var img1= new Image();
	function viewImage(img){
		W=img1.width+499; 
		H=img1.height+331; 
		O="width="+W+",height="+H+",scrollbars=yes"; 
		imgWin=window.open("","",O); 
		imgWin.document.write("<html><head><title>:: 이미지상세보기 ::</title></head>");
		imgWin.document.write("<body topmargin=0 leftmargin=0>");
		imgWin.document.write("<img src="+img+" onclick='self.close()' class='imgHelp' style='cursor:pointer;' title ='클릭하시면 창이 닫힙니다.'>");
		imgWin.document.close();
	}

</script>

<style>
.imgHelp {
    width:499px;
    height:331px;'
}
</style>
