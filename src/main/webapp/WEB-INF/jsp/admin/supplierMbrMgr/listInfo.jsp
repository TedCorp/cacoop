<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>


<style>
.content .box .paging_new{margin-top:30px}
.content .box .paging_new ul{display:flex;flex-direction:row;justify-content:center;align-items:center}
.content .box .paging_new li{width:30px;height:30px;}
.content .box .paging_new li a{display:block;width:30px;line-height:30px;font-size:14px;font-weight:500;color:#333;text-align:center;}
.content .box .paging_new li i{display:block;width:30px;height:30px}
.content .box .paging_new li.on a{background:#111;color:#fff;}
.content .box .paging_new li.start .ic{background:url("${contextPath}/resources/resources2/images/icon_page_start.png") no-repeat 50% 50%}
.content .box .paging_new li.end .ic{background:url("${contextPath}/resources/resources2/images/icon_page_end.png") no-repeat 50% 50%}
.content .box .paging_new li.prev .ic{background:url("${contextPath}/resources/resources2/images/icon_page_prev.png") no-repeat 50% 50%}
.content .box .paging_new li.next .ic{background:url("${contextPath}/resources/ resources2/images/icon_page_next.png") no-repeat 50% 50%}

</style>

<section class="content-header">
	<h1>
		기업회원 관리	
		<small>회원 목록</small>
	</h1>
</section>

<section class="content">
	<!-- 기업정보 박스 -->
	<spform:form name="supplierFrm" id="supplierFrm" class="form-horizontal">
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">기본정보</h3>
			</div>
			<!-- /.box-header -->
		
			<!-- box-body -->
			<div class="box-body">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">기업명</label>
					<div class="col-sm-10">
						${supplierInfo.SUPR_NAME }(${supplierInfo.SUPR_ID })
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">대표자명</label>
					<div class="col-sm-4">
						${supplierInfo.RPRS_NAME }
					</div>
					<label for="inputEmail3" class="col-sm-2 control-label">사업자등록번호</label>
					<div class="col-sm-4">
						${supplierInfo.BIZR_NUM }
					</div>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
	</spform:form>
	<!-- 기업정보 박스 -->

	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">기업회원 목록(${totalCnt})</h3>
			<div class="box-tools">
				<a href="javascirpt:;" class="btn btn-sm btn-primary pull-right" data-toggle="modal" data-target="#myModal">등록</a>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered">
				<colgroup>
					<col style="with:10px" />
					<col />
					<col style="with:50px" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>업체명</th>
						<th>아이디</th>
						<th>성명</th>
						<th>등록일</th>
						<th>승인상태</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${obj.list }" var="ent" varStatus="loop">
					<tr>
						<td>${ent.RNUM }</td>
						<td>${ent.SUPR_NAME }</td>
						<td><a href="javascirpt:;" class="viewPopup" membId="${ent.MEMB_ID }">${ent.MEMB_ID }</a></td>
						<td><a href="javascirpt:;" class="viewPopup" membId="${ent.MEMB_ID }">${ent.MEMB_NAME }</a></td>
						<td>${ent.REG_DTM }</td>
						<td>${ent.SUPMEM_APST_NM }</td>
					</tr>
				</c:forEach>
				<c:if test="${obj.count == 0}">
					<tr>
						<td colspan="6">조회된 내용이 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</div>
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
				<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>
	</div>
</section>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">기업회원 등록/수정</h4>
			</div>
			<div class="modal-body">
            <form role="form">
            </form>
				<!-- 기업정보 박스 -->
					<div class="box box-info">
						<div class="box-header with-border">
							<h3 class="box-title">기본정보</h3>
						</div>
						<!-- /.box-header -->
					
						<!-- box-body -->
						<spform:form name="customerFrm" id="customerFrm" method="post" action="${contextPath}/adm/supplierMbrInfoMgr" role="form" class="form-horizontal">
						<input type="hidden" name="SUPR_ID" id="SUPR_ID" value="${supplierInfo.SUPR_ID }" />
						<input type="hidden" name="SUPR_FLAG" id="SUPR_FLAG" value="I" />
						
						<div class="box-body">
							<div class="form-group">
								<label for="MEMB_ID" class="col-sm-2 control-label">아이디</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="MEMB_ID" name="MEMB_ID" value="" placeholder="아이디" required="required" />
								</div>
							</div>
							<div class="form-group">
								<label for="MEMB_NAME" class="col-sm-2 control-label">이름</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="MEMB_NAME" name="MEMB_NAME" value="" placeholder="이름" required="required" />
								</div>
							</div>			
							<div class="form-group">
								<label for="MEMB_PW" class="col-sm-2 control-label">비밀번호</label>
								<div class="col-sm-10">
										<input type="password" class="form-control" id="MEMB_PW" name="MEMB_PW" value="" placeholder="비밀번호" required="required" />
								</div>
							</div>
							<div class="form-group">
								<label for="MEMB_MAIL" class="col-sm-2 control-label">이메일</label>
								<div class="col-sm-10">
									<input type="email" class="form-control" id="MEMB_MAIL" name="MEMB_MAIL" value="" placeholder="email" required="required" />
								</div>
							</div>
							<div class="form-group">
								<label for="MEMB_CPON" class="col-sm-2 control-label">휴대전화</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" name="MEMB_CPON" data-inputmask='"mask": "999-9999-9999"'>
								</div>
							</div>
							<div class="form-group">
								<label for="MEMB_TELN" class="col-sm-2 control-label">승인상태</label>
								<div class="col-sm-10">
					                <jsp:include page="${contextPath}/common/comCodForm">
										<jsp:param name="COMM_CODE" value="SUPMEM_APST" />
										<jsp:param name="name" value="SUPMEM_APST" />
										<jsp:param name="value" value="" />
										<jsp:param name="type" value="select" />
										<jsp:param name="top" value="선택" />
									</jsp:include>
								</div>
							</div>
							<div class="form-group" id="divAPRF_RESN" id="divAPRF_RESN">
								<label for="APRF_RESN" class="col-sm-2 control-label">거부사유</label>
								<div class="col-sm-10">
									<input type="input" class="form-control" id="APRF_RESN" name="APRF_RESN" value="" />
								</div>
							</div>

						</div>
						</spform:form>
						<!-- /.box-body -->
					</div>
				<!-- 기업정보 박스 -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary btnSave"></button>
				<button type="button" class="btn btn-danger btnSec"></button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	<c:if test="${!empty param.schGbn}">
		$('#schGbn').val('${param.schGbn}');
	</c:if>

	$('#myModal').on('show.bs.modal', function (event) {

		var modal = $(this);
        $("#MEMB_ID").val("");
        $("#MEMB_ID").attr("readonly",false).attr("disabled",false); //입력가능
        $("#MEMB_NAME").val("");
        $("#MEMB_MAIL").val("");
        $("#MEMB_CPON").val("");
        $("#SUPMEM_APST").val("");
        $("#APRF_RESN").val("");
        $("#divAPRF_RESN").hide();

        $("#SUPR_FLAG").val("I");
        $(".btnSave").text("저장");
        $('.btnSec').hide();
	});
		
	$(".viewPopup").click(function(){
		var strMembId = $(this).attr("membId");
		$.ajax({
		    type: 'get',
		    dataType: 'json',
		    url: '${contextPath }/adm/memberMgr/edit/'+strMembId+'.json',
		    success: function (data) {
			    var objMbr = data.memberInfo; 

		        $("#MEMB_ID").val(objMbr.memb_ID);
		        $("#MEMB_ID").attr("readonly",true).attr("disabled",false); //입력불가
		        $("#MEMB_NAME").val(objMbr.memb_NAME);
		        $("#MEMB_MAIL").val(objMbr.memb_MAIL);
		        $("#MEMB_CPON").val(objMbr.memb_CPON);
		        $("#SUPMEM_APST").val(objMbr.supmem_APST);
		        $("#APRF_RESN").val(objMbr.aprf_RESN);
		       
		        $("#SUPR_FLAG").val("U");
		        $(".btnSave").text("수정");
		        $('.btnSec').show().text("탈퇴");
		    },
		    error: function () {
		         console.log('error');
		    }
		});
		
		$('#myModal').modal('show');
	});  
	
	 $(".btnSave").click(function() {
		$("#customerFrm").submit();
	});  
	 
	 $('.btnSec').click(function(){
    	if(!confirm("탈퇴하시면 7일이내 재가입이 불가능합니다. 탈퇴하시겠습니까?")) return;
		$("#customerFrm").attr("action","${contextPath }/adm/supplierMbrInfoMgr/delete");
		$("#customerFrm").submit();
    });
});

</script>
