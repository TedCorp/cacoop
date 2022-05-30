<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>


<!-- Main Container  -->
<div class="main-container container">
	<ul class="breadcrumb">
		<li><a href="${contextPath }/m"><i class="fa fa-home"></i></a></li>
		<li><a href="${contextPath }/m/community">고객센터</a></li>
		<li><a href="${contextPath }/m/community/noticeList">공지사항</a></li>
	</ul>
	
	<div class="row">
		<div id="content" class="col-sm-12">
			<h2 class="title">
				<b>공지사항</b>
			</h2>
			<div class="form-group">
				<table class="table table-bordered">
					<tr>
						<th>제목</th>
						<td colspan="3">${tb_pdbordxm.BRD_SBJT }</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${tb_pdbordxm.WRTR_NM }</td>
						<th>작성일</th>
						<td>${tb_pdbordxm.REG_DTM }</td>
					</tr>
					<tr>
						<td colspan="4">
							<div style="min-height:300px; padding:10px;">${tb_pdbordxm.BRD_CONT }</div>
						</td>
					</tr>
	            </table>
			</div>
			
			<div class="buttons">
				<a href="${contextPath }/m/community/noticeList" class="btn btn-default pull-right mg-rigit-5">목록</a>
			</div>
		</div>
		<!-- /.Middle Part -->
	</div>
</div>
<!-- /.Main Container -->

<script type="text/javascript">
$(function(){
	/* 삭제하기 */
	$(".btnDel").click(function(){
		$("#formId").attr("method", "POST");
		$("#formId").attr("action", "${contextPath }/community/delete");
	});
});
</script>
