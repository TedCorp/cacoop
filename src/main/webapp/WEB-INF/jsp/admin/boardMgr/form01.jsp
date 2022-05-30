<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:set var="strActionUrl" value="${contextPath }/adm/boardMgr/type01/${tb_pdbordxm.BRD_GUBN }/${tb_pdbordxm.BRD_NUM }" />
<c:set var="strMethod" value="post" />

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
			
			<!-- 질문내용 시작 -->
			<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">질문내용</h3>
			</div>
			<!-- /.box-header -->
	
				<!-- box-body -->
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">제목</label>
						<div class="col-sm-10">${tb_pdbordxm.BRD_SBJT }</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">작성자</label>
						<div class="col-sm-4">${tb_pdbordxm.WRTR_NM }</div>
						<label for="inputEmail3" class="col-sm-2 control-label">작성일</label>
						<div class="col-sm-4">${tb_pdbordxm.WRT_DTM }</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">질문 내용</label>
						<div class="col-sm-10">${tb_pdbordxm.BRD_CONT }</div>
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- 질문내용 끝 -->
			
			
			<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
			
			<input type="hidden" id="DEL_YN" name="DEL_YN" value="" /><!-- 삭제유무 -->
			<input type="hidden" id="BRD_GUBN" name="BRD_GUBN" value="${tb_pdbordxm.BRD_GUBN }" /><!-- 게시글 구분-->
			<input type="hidden" id="BRD_NUM" name="BRD_NUM" value="${tb_pdbordxm.BRD_NUM }" /><!-- 게시글 번호 -->
			
			<!-- 답변내용 시작 -->
			<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">답변내용</h3>
			</div>
			<!-- /.box-header -->
	
				<!-- box-body -->
				<form class="form-horizontal">
				<div class="box-body">
						
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">답변자</label>
						<div class="col-sm-4">${tb_pdbordxm.REP_NM }</div>
						<label for="inputEmail3" class="col-sm-2 control-label">답변일</label>
						<div class="col-sm-4">${tb_pdbordxm.REPLY_DTM }</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">질문 답변</label>
						<div class="col-sm-10">
							<textarea rows="5" cols="100" id="QNA_REPLY" name="QNA_REPLY" required="required">${tb_pdbordxm.QNA_REPLY }</textarea>
						</div>
						
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- 답변내용 끝 -->
			</spform:form>
			
			<div class="box-footer" >
				<a href="${contextPath}/adm/boardMgr/type01/${tb_pdbordxm.BRD_GUBN}" class="btn btn-default pull-right">리스트</a>
				<!-- <button type="submit" class="btn btn-info pull-right">저장</button> -->
				<a onclick="javascript:fn_save();" class="btn btn-info pull-right">저장</a>
				<a onclick="javascript:fn_delete();" class="btn btn-info pull-right">삭제</a>
			</div>
			
			<!-- /.box-footer -->
	<!-- /.box -->
</section>
 
<script type="text/javascript">
//저장버튼 클릭시
function fn_save(){
	if(!confirm("저장 하시겠습니까?")) return;
	var frm=document.getElementById("orderFrm");
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