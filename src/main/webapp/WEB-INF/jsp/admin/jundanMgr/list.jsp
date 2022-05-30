<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<style>
.imgHelp {
    width:auto;
    height:auto;
    max-width:100%;
    max-height:100%;  
}
</style>

<script type="text/javascript">

$(function() {
	// 이미지 오류시 Default Img
	$('.imgHelp').each(function() {
		$(this).error(function(){
			$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
		});
	});
	
	// 새로고침때 초기화
	if('${obj.JD_GUBN}' == ''){
		cateTree.clearCookie();
	}else{
		selectNode('${obj.JD_PATH}', '${obj.JD_NAME}')
	}
	
	$("#btnDel").hide();		
	
	$("#btnDel").click(function(){
		if(!$("input[name=JD_GUBN]:checked")){
			alert("구분값을 선택하세요.");
		}
		if($("#JD_NAME").val() == "" || $("#JD_NAME").val() == null ||
			$("#JD_PATH").val() == "" || $("#JD_PATH").val() == null ){
			alert("삭제할 파일을 선택하세요.");
		}

		console.log($("#JD_NAME").val() +" || "+$("#JD_PATH").val());
		
		if(!confirm("해당 이미지가 삭제됩니다. 삭제하시겠습니까?")) return;
		$("#frm").attr("action","${contextPath }/adm/jundanMgr/delete2");
		$("#frm").submit();		
	});	
});

function selectNode(strImgPath, strImgName){
	var gubn = $("input[name=JD_GUBN]:checked").val();
	
	$("#JD_PATH").val(strImgPath);
	$("#JD_NAME").val(strImgName);
	
	if(gubn == '1'){
		$("#file-Img").attr("src", "${contextPath }/upload/jundan/"+strImgPath);			
	}else if(gubn == '2'){
		$("#file-Img").attr("src", "${contextPath }/upload/jundan/"+strImgPath);
	}else if(gubn == '3'){
		$("#file-Img").attr("src", "${contextPath }/upload/jundan/"+strImgPath);
	}
	
	if(strImgName == '${obj.TOP_ATFL}'){
		$("#btnDel").hide();	
	}else{
		$("#btnDel").show();
	}
}

/* 구분별 현재 롤링이미지 */
function fn_chk_yn(){
	// 이미지 초기화
	$("#file-Img").attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
	
	//디렉토리 내역 조회
	$("#frm").attr("method","get");
	$("#frm").attr("action","${contextPath }/adm/jundanMgr/history");
	$("#frm").submit();	
}

</script>
 
<section class="content-header">
	<h1>
		이미지 관리	
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">		
	<div class="row">
		<!-- 경로 구분값 -->
		<spform:form name="frm" id="frm" method="post" action="" role="form" class="form-horizontal">
			<input type="hidden" id="JD_NAME" name="JD_NAME" value=""/><!-- 파일명 -->
			<input type="hidden" id="JD_PATH" name="JD_PATH" value=""/><!-- 디렉토리명 -->
			
			<div class="form-group">
				<label class="col-sm-2 control-label">디렉토리 구분</label>
				<div class="col-sm-10">
					<c:if test="${ !empty obj.JD_GUBN }">
						<c:set var="JD_GUBN" value="${ obj.JD_GUBN }" />
					</c:if>
					<label class="check" style="margin-right: 10px"> 
						<input type="radio" class="iradio" name="JD_GUBN" value="3" ${JD_GUBN eq '3' ? 'checked' : '' } onchange="javascript:fn_chk_yn();" /> 롤링이미지
					</label>  
					<label class="check" style="margin-right: 10px">
						<input type="radio" class="iradio" name="JD_GUBN" value="1" ${JD_GUBN eq '1' ? 'checked' : '' } onchange="javascript:fn_chk_yn();" /> 온라인전단
					</label>
					<label class="check" style="margin-right: 10px"> 
						<input type="radio" class="iradio" name="JD_GUBN" value="2" ${JD_GUBN eq '2' ? 'checked' : '' } onchange="javascript:fn_chk_yn();" /> 오프라인전단
					</label>
				</div>
			</div>		
		</spform:form>		
		<!-- File Directory Tree -->
		<section class="col-md-4 connectedSortable">
			<div class="box box-primary">
				<div class="box-body" style="height: 400px;">
					<a href="javascript: cateTree.openAll();"><img src="${contextPath}/resources/adminlte/plugins/tree/img/openall.gif" width="15px" /></a> | <a href="javascript: cateTree.closeAll();"><img src="${contextPath}/resources/adminlte/plugins/tree/img/closeall.gif" width="15px"/></a>
					<div class="tree_nav" style="height: 350px; overflow-y: scroll;">
						
						<script type="text/javascript">
						/* 		mytree.add( p1, p2, p3, p4, p5, p6, p7 ) 에서 
								p1 : id값
								p2 : 부모참조 id값. 여기에 적힌 id가 부모노드가 된다
								p3 : 표시될 노드의 이름 
								p4 : 해당 노드를 클릭했을때 이동될 페이지 주소
								p5 : 해당노드의 이름에 마우스를 가져다 대면 뜨는 설명
								p6 : a태그의 target에 해당하는값. 보통 새창에서 열리게 할때 쓰임
								p7 : 이미지경로및 이름. 여기에 적힌 이미지가 표시된다. 안적을경우엔 기본값으로 표시
						 */
						cateTree = new dTree('cateTree', '${contextPath }'); //dTree 생성

						function declareData(){
							cateTree.add(0,-1,"이미지 경로");
							<c:forEach var="ent" items="${ obj.list }" varStatus="status">
								cateTree.add("${ent.JD_ID}", "${empty ent.JD_ID_NEW ? '0' : ent.JD_ID_NEW}", "${ent.JD_NAME}", "javascript: selectNode(\'${ent.JD_PATH}\', \'${ent.JD_NAME}\');", "${ent.JD_NAME}", "","","");
							</c:forEach>
							document.write(cateTree);
						}
						declareData();
						</script>
						
					</div>
				</div>
				<div class="box-footer">
					<span class="pull-right">
						<!-- <button type="submit" onclick="return;" id="btnCateNew" class="btn btn-info">신규등록</button> -->
					</span>
				</div>	
			</div>			
		</section>
		<section class="col-md-8">
			<div class="row">
				<div class="col-xs-12">
					<div class="box box-primary">
						<%-- <spform:form name="frm" id="frm" method="post" action="" role="form" class="form-horizontal"> --%>
						<div class="box-body">
							<div class="box-body">
								<img id= "file-Img" class="imgHelp" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="...">
							</div>
						</div>
						<div class="box-footer">
							<span class="pull-right">
								<button type="button" onclick="return;" id="btnDel" class="btn btn-danger">삭제</button>
							</span>
						</div>	
						<%-- </spform:form> --%>
					</div>
				</div>
			</div>	
		</section>
	</div>			
</section>
