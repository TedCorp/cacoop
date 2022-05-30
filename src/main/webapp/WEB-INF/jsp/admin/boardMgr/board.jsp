<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		<jsp:include page="${contextPath}/common/comCodName">
			<jsp:param name="COMM_CODE" value="BRD_GUBN" />
			<jsp:param name="COMD_CODE" value="${tb_pdbordxm.BRD_GUBN }" />
			<jsp:param name="type" value="text" />
		</jsp:include>
		<small>${strListUrl}</small>
	</h1>
</section>

<section class="content">
	<!-- Horizontal Form -->			
	<spform:form class="form-horizontal" name="qnaFrm" id="qnaFrm" method="post" action="${contextPath }/adm/boardMgr/insert">
		<input type="hidden" id="BRD_GUBN" name="BRD_GUBN" value="${tb_pdbordxm.BRD_GUBN }" />	<!-- 게시글 구분 -->
		<input type="hidden" id="BRD_NUM" name="BRD_NUM" value="${tb_pdbordxm.BRD_NUM }" />		<!-- 게시글 번호 -->
		
		<!-- 질문내용 시작 -->
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">내용</h3>
			</div>			
			<!-- /.box-header -->
			
			<div class="box-body">
				<div class="form-group">
					<label class="col-sm-1 control-label">제목</label>
					<div class="col-sm-10">
						<input type="text" class="form-control input-sm" id="BRD_SBJT" name="BRD_SBJT" value="${tb_pdbordxm.BRD_SBJT }" placeholder="제목을 입력해주세요." required/>
					</div>
				</div><br>
				
				<div class="form-group">
					<label class="col-sm-1 control-label">작성자</label>
					<div class="col-sm-4">${tb_pdbordxm.WRTR_NM }</div>
					<label class="col-sm-1 control-label">작성일</label>
					<div class="col-sm-4">${tb_pdbordxm.WRT_DTM }</div>
				</div><br>
				
				<div class="form-group">
					<label class="col-sm-1 control-label">내용</label>
					<div class="col-sm-10">
						<textarea rows="10" cols="100" id="BRD_CONT" name="BRD_CONT" style="width:100%;"required="required">${tb_pdbordxm.BRD_CONT }</textarea>
					</div>
				</div><br>
			</div>
			<!-- /.box-body -->
		</div>
		<!-- 질문내용 끝 -->		
	</spform:form>
	
	<div class="box-footer" >
		<c:if test="${ tb_pdbordxm.BRD_GUBN eq 'BRD_GUBN_04'}">
			<a href="${contextPath}/adm/boardMgr/faq/${tb_pdbordxm.BRD_GUBN}" class="btn btn-default pull-right right-5"><i class="fa fa-list"></i> 목록</a>
		</c:if>
		<c:if test="${ tb_pdbordxm.BRD_GUBN eq 'BRD_GUBN_05'}">
			<a href="${contextPath}/adm/boardMgr/notice/${tb_pdbordxm.BRD_GUBN}" class="btn btn-default pull-right right-5"><i class="fa fa-list"></i> 목록</a>
		</c:if>		
		<button type="button" class="btn btn-primary pull-right right-5 btnSave"><i class="fa fa-save"></i> 저장</button>				
		<c:if test="${ !empty tb_pdbordxm.BRD_NUM }"><!-- 수정시 사용 -->
			<button type="button" class="btn btn-danger pull-right right-5 btnDel"><i class="fa fa-remove"></i> 삭제</button>
		</c:if>
	</div>
</section>
 
<script type="text/javascript">
$(function() {	
	/* 편집기 */
	CKEDITOR.replace('BRD_CONT');
	
	/* 저장하기 */
	$(".btnSave").click(function(){
		var strBRD_CONT = CKEDITOR.instances.BRD_CONT.getData();
		$("#BRD_CONT").val(strBRD_CONT);
		$("#qnaFrm").attr("method", "POST");
		
		if(!confirm("저장 하시겠습니까?")) return;
		$("#qnaFrm").submit();
	});
	
	/* 삭제하기 */
	$(".btnDel").click(function(){
		if(!confirm("삭제 하시겠습니까?")) return;
		$("#qnaFrm").attr("method", "POST");
		$("#qnaFrm").attr("action", "${contextPath }/adm/boardMgr/delete");
		$("#qnaFrm").submit();
	});

	/* 필수값 체크 */
    $('#qnaFrm').validate({
        debug: false,
        onfocusout: false,
        rules: {
        	BRD_GUBN: {
                required: true
            },
            BRD_SBJT: {
                required: true
            },
            BRD_CONT: {
                required: true
            }
        }, messages: {
        	BRD_GUBN: {
                required: '분류를 선택해주세요.'
            },
            BRD_SBJT: {
                required: '제목를 입력해주세요.'
            },
            BRD_CONT: {
                required: '내용을 입력해주세요.'
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

</script>