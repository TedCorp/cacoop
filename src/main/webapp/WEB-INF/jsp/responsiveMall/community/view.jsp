<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>


<!-- Main Container  -->
<div class="main-container container">
	<ul class="breadcrumb">
		<li><a href="${contextPath }/m"><i class="fa fa-home"></i></a></li>
		<li><a href="${contextPath }/m/community">고객센터</a></li>
		<li><a href="${contextPath }/m/community/list">1:1문의</a></li>
	</ul>
	
	<div class="row">
		<div id="content" class="col-sm-12">
			<h2 class="title">
				<b>문의내역</b>
				<small class="pull-right">작성일 : ${tb_pdbordxm.REG_DTM }</small>
			</h2>
			<spform:form class="form-horizontal" name="qnaFrm" id="qnaFrm" method="GET" action="${contextPath }/m/community/edit">
				<div class="form-group">				
					<input type="hidden" class="form-control" name="BRD_GUBN" value="${tb_pdbordxm.BRD_GUBN }" />
					<input type="hidden" class="form-control" name="BRD_NUM" value="${tb_pdbordxm.BRD_NUM }" />					
					<input type="hidden" class="form-control" name="WRTR_ID" value="${tb_pdbordxm.WRTR_ID }" />
					<input type="hidden" class="form-control" name="SCWT_YN" value="${tb_pdbordxm.SCWT_YN }" />
					<input type="hidden" class="form-control" name="PD_CODE" value="${tb_pdbordxm.PD_CODE }" />
					<input type="hidden" class="form-control" name="ORDER_NUM" value="${tb_pdbordxm.ORDER_NUM }" />
					
					<table class="table table-bordered">
						<tr>
							<th class="text-center" style="width:100px;"><b>제목</b></th>
							<td class="text-left"><b>[${tb_pdbordxm.BRD_GUBN_NM}]</b> ${tb_pdbordxm.BRD_SBJT }</td>
						</tr>
						<tr>
							<th class="text-center" style="width:100px;"><b>이름</b></th>
							<td class="text-left">${tb_pdbordxm.WRTR_NM }</td>
						</tr>
						<tr>
							<th class="text-center" style="width:100px;"><b>이메일</b></th>
							<td class="text-left">${tb_pdbordxm.MEMB_MAIL }</td>
						</tr>
						<tr>
							<th class="text-center" style="width:100px;"><b>연락처</b></th>
							<td class="text-left">${tb_pdbordxm.MEMB_CPON }</td>
						</tr>
						<tr>
							<th class="text-center" style="width:100px;"><b>답변</b></th>
							<td class="text-left">
								<c:if test="${tb_pdbordxm.REPLY_YN eq 'Y' }"><small class="label label-primary">Y</small> 답변이 작성되었습니다.</c:if>
								<c:if test="${tb_pdbordxm.REPLY_YN ne 'Y' }"><small class="label label-warning">N</small> 답변 준비중입니다.</c:if>
							</td>
						</tr>
						<c:if test="${tb_pdbordxm.BRD_GUBN eq 'BRD_GUBN_02' or tb_pdbordxm.BRD_GUBN eq 'BRD_GUBN_03' }">
							<tr>
								<th class="text-center" style="width:100px;"><b>문의정보</b></th>
								<td class="text-left">
									<c:if test="${!empty tb_pdbordxm.ORDER_NUM }"><b><a href="${contextPath }/m/order/view/${tb_pdbordxm.ORDER_NUM }">[${tb_pdbordxm.ORDER_NUM }]</a>&nbsp;</b></c:if>
									<a href="${contextPath }/m/product/view/${ tb_pdbordxm.PD_CODE }">${tb_pdbordxm.PD_NAME }</a>
								</td>
							</tr>
						</c:if>
						<tr style="min-height:150px;">
							<th class="text-center"><b>문의내용</b></th>
							<td colspan="2">
								<div style="white-space:pre; min-height:150px;">${tb_pdbordxm.BRD_CONT }</div>
							</td>
						</tr>
						<tr>
							<th class="text-center"><b>문의답변</b></th>
							<td colspan="2">
								<div style="white-space:pre; min-height:150px;">${tb_pdbordxm.QNA_REPLY }</div>
							</td>
						</tr>
					</table>				
				</div>
			
				<div class="buttons">
					<a href="${contextPath }/m/community/list" class="btn btn-default pull-right">목록</a>
					<c:if test="${tb_pdbordxm.REPLY_YN ne 'Y' }">
						<input type="submit" class="btn btn-primary pull-right mg-rigit-5 btnEdit" value="수정"/>
						<button type="button" class="btn btn-danger pull-right mg-rigit-5 btnDel">삭제</button>
					</c:if>
				</div>
			</spform:form>
		</div>
		<!-- /.Middle Part -->
	</div>
</div>
<!-- /.Main Container -->

<script type="text/javascript">
$(function(){
	/* 삭제하기 */
	$(".btnDel").click(function(){
		if(!confirm("삭제 하시겠습니까?")) return;
		$("#qnaFrm").attr("method", "POST");
		$("#qnaFrm").attr("action", "${contextPath }/m/community/delete");
		$("#qnaFrm").submit();
	});
});
</script>
