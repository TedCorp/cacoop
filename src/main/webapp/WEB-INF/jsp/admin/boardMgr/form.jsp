<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:set var="strActionUrl" value="${contextPath }/adm/boardMgr/update" />
<c:set var="strMethod" value="post" />

<section class="content-header">
	<h1>
		<jsp:include page="${contextPath }/common/comCodName">
			<jsp:param name="COMM_CODE" value="BRD_GUBN" />
			<jsp:param name="COMD_CODE" value="${tb_pdbordxm.BRD_GUBN }" />
			<jsp:param name="type" value="text" />
		</jsp:include>
		<small></small>
	</h1>
</section>

<section class="content">
	<!-- 질문내용 시작 -->
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">질문내용</h3>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<div class="form-group">
				<label class="col-sm-1 control-label">제목</label>
				<div class="col-sm-10">${tb_pdbordxm.BRD_SBJT }</div>
			</div><br>
			<div class="form-group">
				<label class="col-sm-1 control-label">작성자</label>
				<div class="col-sm-5">${tb_pdbordxm.WRTR_NM }</div>
				<label class="col-sm-1 control-label">작성일</label>
				<div class="col-sm-4">${tb_pdbordxm.WRT_DTM }</div>
			</div><br>
			<c:if test="${tb_pdbordxm.BRD_GUBN ne 'BRD_GUBN_01' }">
				<div class="form-group">
				<c:if test="${tb_pdbordxm.BRD_GUBN eq 'BRD_GUBN_03' }">
					<label class="col-sm-1 control-label">주문번호</label>
					<div class="col-sm-5"><a href="${contextPath}/adm/orderMgr/form/${tb_pdbordxm.ORDER_NUM }">${tb_pdbordxm.ORDER_NUM }</a></div>
				</c:if>
					<label class="col-sm-1 control-label">상품정보</label>
					<div class="col-sm-4">
						<a href="${contextPath }/adm/productMgr/edit/${ tb_pdbordxm.PD_CODE }">[${tb_pdbordxm.PD_CODE }]&nbsp;${tb_pdbordxm.PD_NAME }</a>
					</div>
				</div><br>
			</c:if>
			<div class="form-group">
				<label class="col-sm-1 control-label">질문 내용</label>
				<div class="col-sm-10">
					<textarea rows="10" cols="100" style="width:100%; padding:10px;" disabled >${tb_pdbordxm.BRD_CONT }</textarea>
				</div>
			</div><br>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- 질문내용 끝 -->
	
	<spform:form class="form-horizontal" name="qnaFrm" id="qnaFrm" method="${strMethod }" action="${strActionUrl }">
		<input type="hidden" id="BRD_GUBN" name="BRD_GUBN" value="${tb_pdbordxm.BRD_GUBN }" />	<!-- 게시글 구분-->
		<input type="hidden" id="BRD_NUM" name="BRD_NUM" value="${tb_pdbordxm.BRD_NUM }" />		<!-- 게시글 번호 -->
		
		<!-- 답변내용 시작 -->
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">답변내용</h3>
				&nbsp;${tb_pdbordxm.REPLY_YN eq 'Y' ? '<small class="label label-primary">Y</small>':'<small class="label label-warning">N</small>' }
			</div>
			<!-- /.box-header -->
			<div class="box-body">						
				<div class="form-group">
					<label class="col-sm-1 control-label">답변자</label>
					<div class="col-sm-5">${tb_pdbordxm.REP_NM }</div>
					<label class="col-sm-1 control-label">답변일</label>
					<div class="col-sm-4">${tb_pdbordxm.REPLY_DTM }</div>
				</div><br>
				<div class="form-group">
					<label class="col-sm-1 control-label">질문 답변</label>
					<div class="col-sm-10">
						<textarea rows="10" cols="100" name="QNA_REPLY" id="QNA_REPLY" style="width:100%; padding:10px;" required="required">${tb_pdbordxm.QNA_REPLY }</textarea>
					</div>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
		<!-- 답변내용 끝 -->
	</spform:form>
	
	<div class="box-footer" >
		<a href="${contextPath}/adm/boardMgr/${tb_pdbordxm.BRD_GUBN}" class="btn btn-default pull-right"><i class="fa fa-list"></i> 목록</a>
		<button type="button" class="btn btn-primary pull-right right-5 btnSave"><i class="fa fa-save"></i> 저장</button>
		<button type="button" class="btn btn-danger pull-right right-5 btnDel"><i class="fa fa-remove"></i> 삭제</button>
	</div>
</section>
 
<script type="text/javascript">
$(function(){
	/* 저장하기 */
	$(".btnSave").click(function(){
		if(!confirm("답변을 등록하시겠습니까?")) return;
		$("#qnaFrm").submit();
	});
	
	/* 삭제하기 */
	$(".btnDel").click(function(){
		if(!confirm("문의글을 삭제 하시겠습니까?")) return;
		console.log("delete111-----");
		$("#qnaFrm").attr("method", "POST");
		$("#qnaFrm").attr("action", "${contextPath }/adm/boardMgr/delete");
		$("#qnaFrm").submit();
		console.log("delete222-----");
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