<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:set var="strActionUrl" value="${contextPath }/adm/groupMgr" />
<c:set var="strMethod" value="post" />
<c:if test="${ !empty tb_sysgrpxm.GROUP_CD }"><!-- 수정시 사용 -->
	<c:set var="strActionUrl" value="${contextPath }/adm/groupMgr/${tb_sysgrpxm.GROUP_CD }" />
	<c:set var="strMethod" value="put" />
</c:if>


<section class="content-header">
	<h1>
		그룹관리
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
							<c:when test="${ !empty tb_sysgrpxm.GROUP_CD }">
								${tb_sysgrpxm.GROUP_CD }
								<input type="hidden" id="GROUP_CD" name="GROUP_CD" value="${tb_sysgrpxm.GROUP_CD }" />
								<input type="hidden" id="GROUP_CD_CHK" name="GROUP_CD_CHK" value="Y" />
							</c:when>
							<c:otherwise>
								<input type="text" id="GROUP_CD" name="GROUP_CD" value="${tb_sysgrpxm.GROUP_CD }" onchange="javascript:fn_change();"/>
								<a onclick="javascript:fn_group_cd_chk();" class="btn btn-info pull-right">중복검사</a>
								<input type="hidden" id="GROUP_CD_CHK" name="GROUP_CD_CHK" value="N" />
							</c:otherwise>
							</c:choose>
						</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">그룹명</label>
						<div class="col-sm-10"><input type="text" id="GROUP_NAME" name="GROUP_NAME" value="${tb_sysgrpxm.GROUP_NAME }" /></div>
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- 내용 끝 -->
			
			</spform:form>
			
			<div class="box-footer" >
				<a href="${contextPath}/adm/groupMgr" class="btn btn-default pull-right">리스트</a>
				<a onclick="javascript:fn_save();" class="btn btn-info pull-right">저장</a>
				<c:if test="${ !empty tb_sysgrpxm.GROUP_CD }"><!-- 수정시 사용 -->
				<a onclick="javascript:fn_delete();" class="btn btn-info pull-right">삭제</a>
				</c:if>
			</div>
			
			<!-- /.box-footer -->
	<!-- /.box -->
</section>
 
 <spform:form name="delFrm" id="delFrm" method="DELETE" action="${contextPath }/adm/groupMgr/${tb_sysgrpxm.GROUP_CD }" class="form-horizontal">
 </spform:form>
<script type="text/javascript">
//등록시 그룹코드 중복 검사
function fn_group_cd_chk(){
	var frm=document.getElementById("orderFrm");
	$.ajax({
	    url: "${contextPath }/adm/groupMgr/chk",
	    type: 'post',
	    data: 'GROUP_CD='+ frm.GROUP_CD.value,
	    success: function(data){                               
	    	 if(data=="success"){
	    		 alert("이미 존재하는 그룹코드 입니다.");
	    		 frm.GROUP_CD_CHK.focus();
	    	 }else{
	    		 alert("그룹코드를 사용해도 좋습니다.");
	    		 frm.GROUP_CD_CHK.value="Y";
	    	 }
	    },
	    error: function(e){
	       alert("에러:");
	    }
	});
}

//그룹코드 수정시 중복검사 안한걸로 플레그 변경
function fn_change(){
	var frm=document.getElementById("orderFrm");
	frm.GROUP_CD_CHK.value="N";
}
//저장버튼 클릭시
function fn_save(){
	var frm=document.getElementById("orderFrm");
	if(frm.GROUP_CD.value==""){
		alert("그룹코드를 입력하세요");
		frm.GROUP_CD.focus();
		return;
	}
	if(frm.GROUP_CD_CHK.value=="N"){
		alert("그룹코드 중복검사를 먼저 하시기 바랍니다.");
		return;
	}
	if(frm.GROUP_NAME.value==""){
		alert("그룹명을 입력하세요");
		frm.GROUP_NAME.focus();
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

</script>