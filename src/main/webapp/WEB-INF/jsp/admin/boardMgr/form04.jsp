<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:set var="strActionUrl" value="${contextPath }/adm/boardMgr/type04/${tb_pdbordxm.BRD_GUBN }" />
<c:set var="strMethod" value="post" />
<c:if test="${ !empty tb_pdbordxm.BRD_NUM }"><!-- 수정시 사용 -->
	<c:set var="strActionUrl" value="${contextPath }/adm/boardMgr/type04/${tb_pdbordxm.BRD_GUBN }/${tb_pdbordxm.BRD_NUM }" />
	<c:set var="strMethod" value="put" />
</c:if>


<section class="content-header">
	<h1>
		
		<jsp:include page="/common/comCodName">
			<jsp:param name="COMM_CODE" value="BRD_GUBN" />
			<jsp:param name="COMD_CODE" value="${tb_pdbordxm.BRD_GUBN }" />
			<jsp:param name="type" value="text" />
		</jsp:include>
		<small></small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">
	<!-- Horizontal Form -->
			
			<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">

			<input type="hidden" id="DEL_YN" name="DEL_YN" value="" /><!-- 삭제유무 -->
			<input type="hidden" id="BRD_GUBN" name="BRD_GUBN" value="${tb_pdbordxm.BRD_GUBN }" /><!-- 게시글 구분 -->
			<input type="hidden" id="BRD_NUM" name="BRD_NUM" value="${tb_pdbordxm.BRD_NUM }" /><!-- 게시글 번호 -->
			
			<!-- 질문내용 시작 -->
			<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">내용</h3>
			</div>
			<!-- /.box-header -->
	
				<!-- box-body -->
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control input-sm" id="BRD_SBJT" name="BRD_SBJT" value="${tb_pdbordxm.BRD_SBJT }" placeholder="제목을 입력해주세요."/>
						</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">작성자</label>
						<div class="col-sm-4">${tb_pdbordxm.WRTR_NM }</div>
						<label for="inputEmail3" class="col-sm-2 control-label">작성일</label>
						<div class="col-sm-4">${tb_pdbordxm.WRT_DTM }</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">내용</label>
						<div class="col-sm-10"><textarea rows="5" cols="100" id="BRD_CONT" name="BRD_CONT" required="required">${tb_pdbordxm.BRD_CONT }</textarea></div>
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- 질문내용 끝 -->
			
			</spform:form>
			
			<div class="box-footer" >
				<a href="${contextPath}/adm/boardMgr/type04/${tb_pdbordxm.BRD_GUBN}" class="btn btn-default pull-right" style="margin-left:5px">리스트</a>
				<a onclick="javascript:fn_save();" class="btn btn-info pull-right" style="margin-left:5px">저장</a>
				<c:if test="${ !empty tb_pdbordxm.BRD_NUM }"><!-- 수정시 사용 -->
					<a onclick="javascript:fn_delete();" class="btn btn-info pull-right" >삭제</a>
				</c:if>
			</div>
			
			<!-- /.box-footer -->
	<!-- /.box -->
</section>
 
<script type="text/javascript">
$(function() {
	
	CKEDITOR.replace('BRD_CONT');
});
//저장버튼 클릭시
function fn_save(){
	
	var strBRD_CONT = CKEDITOR.instances.BRD_CONT.getData();
	
	var frm=document.getElementById("orderFrm");
	
	frm.BRD_CONT.value=strBRD_CONT;
	
	if(frm.BRD_SBJT.value==""){
		alert("제목을 입력하세요");
		frm.BRD_SBJT.focus();
		return;
	}
	if(frm.BRD_CONT.value==""){
		alert("내용을 입력하세요");
		frm.BRD_CONT.focus();
		return;
	}
	if(!confirm("저장 하시겠습니까?")) return;
	frm.submit();
}
//삭제버큰 클릭시
function fn_delete(){
	if(!confirm("삭제 하시겠습니까?")) return;
	var frm=document.getElementById("orderFrm");
	frm.DEL_YN.value='YES';
	frm.submit();
}

</script>