<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- bootstrap datepicker -->
<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.css">
<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.min.css">

<!-- bootstrap datepicker -->
<script src="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.js"></script>
<script src="${contextPath }/resources/adminlte/plugins/timepicker/bootstrap-timepicker.min.js"></script>
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
		조합원 관리	
		<small>조합원회원 목록</small>
	</h1>
<!-- 	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol> -->
</section>

<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">검색 조건</h3>

			<div class="box-tools pull-right">
				<button type="button" class="btn btn-box-tool"
					data-widget="collapse">
					<i class="fa fa-minus"></i>
				</button>
				<button type="button" class="btn btn-box-tool" data-widget="remove">
					<i class="fa fa-remove"></i>
				</button>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<form class="form-horizontal">
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">검색조건</label>
						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2" style="width: 100%;">
								<option value="CACOOP_NO" selected="selected">조합원번호</option>
								<option value="MEMB_ID">회원ID</option>
								<option value="MEMB_NAME">회원명</option>
							</select>
						</div>
						<div class="col-sm-6">
							<div class="input-group">
								<input name="schTxt" type="text" class="form-control" placeholder="검색어 입력" value="${param.schTxt }">
								<span class="input-group-btn">
									<button type="submit" class="btn btn-success pull-right">검색</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				<!-- /.row -->
			</form>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.box -->
	<!-- 검색 박스 -->
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">조합원회원 목록 (<font color="green"><b>${totalCnt}</b></font>)</h3>
			<div class="box-tools" style="display: -webkit-inline-box;">
				<a href="${contextPath}/adm/memberMgr/new?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }${link}" class="btn btn-sm btn-primary pull-right">등록</a>
				<button type="button"  class="btn btn-warning btn-sm pull-right left-5 btnState" value="SUPMEM_APST_03">승인</button>
				<button type="button"  class="btn btn-success btn-sm pull-right left-5 btnState" value="SUPMEM_APST_04">반려</button>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
			<table class="table table-bordered">
				<colgroup>
					<col />
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="CHK_ALL" name="CHK_ALL" onclick="javascript:fn_all_chk();" /></th>
						<th>번호</th>
						<th>조합원번호</th>
						<th>아이디</th>
						<th>성명</th>
						<th>등록일</th>
						<th>승인상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${obj.list }" var="ent" varStatus="loop">
						<tr>
							<td><input type="checkbox" id="CHK${loop.count}" name="chkOrdList" value="${ent.MEMB_ID}"/></td>
							<td>${ent.RNUM }</td>
							<td>${ent.CACOOP_NO }</td>
							<td><a href="#" class="viewPopup" membId="${ent.MEMB_ID }">${ent.MEMB_ID }</a></td>
							<td>${ent.MEMB_NAME }</td>
							<td>${ent.REG_DTM }</td>
							<td>${ent.SUPMEM_APST_NM }
							<input type="hidden" class="form-control" id="SUPMEM_APST" name="SUPMEM_APST" value="${ent.SUPMEM_APST}" />
							</td>
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
				<h4 class="modal-title" id="myModalLabel">조합원 등록/수정</h4>
			</div>
			<div class="modal-body">
				<!-- 기업정보 박스 -->
				<div class="box box-info">
					<div class="box-header with-border"><h3 class="box-title">기본정보</h3></div>
					<!-- /.box-header -->
					
						<!-- box-body -->
					<spform:form name="customerFrm" id="customerFrm" method="post" action="${contextPath}/adm/supplierMbrMgr" role="form" class="form-horizontal">
					<input type="hidden" name="SUPR_FLAG" id="SUPR_FLAG" value="I" /> 
						
						<div class="box-body">
							<div class="form-group">
								<label for="SUPR_NAME" class="col-sm-2 control-label">업체명</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="COM_NAME" name="COM_NAME" value="" placeholder="업체명" required />
								</div>
							</div>
							<div class="form-group">
								<label for="MEMB_ID" class="col-sm-2 control-label">아이디</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="MEMB_ID" name="MEMB_ID" value="" placeholder="아이디" required />
								</div>
							</div>
							<div class="form-group">
								<label for="MEMB_NAME" class="col-sm-2 control-label">이름</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="MEMB_NAME" name="MEMB_NAME" value="" placeholder="이름" required />
								</div>
							</div>			
							<div class="form-group">
								<label for="MEMB_PW" class="col-sm-2 control-label">비밀번호</label>
								<div class="col-sm-10">
									<input type="password" class="form-control" id="MEMB_PW" name="MEMB_PW" value="" placeholder="비밀번호 변경시 입력해주세요." /><!-- required -->
								</div>
							</div>
							<div class="form-group">
								<label for="MEMB_MAIL" class="col-sm-2 control-label">이메일</label>
								<div class="col-sm-10">
									<input type="email" class="form-control" id="MEMB_MAIL" name="MEMB_MAIL" value="" placeholder="email" required />
								</div>
							</div>
							<div class="form-group">
								<label for="MEMB_CPON" class="col-sm-2 control-label">휴대전화</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="MEMB_CPON" name="MEMB_CPON" value="" placeholder="휴대폰번호" required="required" >
								</div>
							</div>
							<div class="form-group">
								<label for="SUPMEM_APST" class="col-sm-2 control-label">승인상태</label>
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
						<!-- 	<div class="form-group" id="divAPRF_RESN">
								<label for="APRF_RESN" class="col-sm-2 control-label">거부사유</label>
								<div class="col-sm-10">
									<input type="input" class="form-control" id="APRF_RESN" name="APRF_RESN" value="" />
								</div>
							</div> -->
							
						</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary btnSave">저장</button>
					</div>
					</spform:form>
				</div>
				<!-- 기업정보 박스 -->
			</div>
			
		</div>
	</div>  	
</div>

<spform:form name="memberFrm" id="memberFrm" method="post" action="${contextPath}/adm/supplierMbrMgr/listUpdate" role="form" class="form-horizontal">
	<input type="hidden" id="memberId" name="memberId" value=""/>
	<input type="hidden" id="supmemApstNm" name="supmemApstNm" value=""/>
</spform:form>

<script>

$(function(){
	
	<c:if test="${!empty param.schGbn}">
		$('#schGbn').val('${param.schGbn}');
	</c:if>
	
	$('#myModal').on('show.bs.modal', function (event) {
		var modal = $(this);
		
	    $("#COM_NAME").val("");
	    $("#COM_NAME").attr("readonly",false).attr("disabled",false);
        $("#MEMB_ID").val("");
        $("#MEMB_ID").attr("readonly",false).attr("disabled",false); //입력가능
        $("#MEMB_NAME").val("");
        $("#MEMB_MAIL").val("");
        $("#MEMB_CPON").val("");
        $("#SUPMEM_APST").val("");
        $("#APRF_RESN").val(""); //승인상태
        $("#SUPR_FLAG").val("I"); //
	});
	
	// SUPR_ID 존재할때
	$(".viewPopup").click(function(){
		var strMembId = $(this).attr("membId");
		$.ajax({
		    type: 'get',
		    dataType: 'json',
		    url: '${contextPath }/adm/memberMgr/edit/'+strMembId+'.json',
		    success: function (data) {
			    var objMbr = data.memberInfo; 

		        $("#COM_NAME").val(objMbr.com_NAME);
		        $("#COM_NAME").attr("readonly",true).attr("disabled",false); //입력불가  
		        $("#MEMB_ID").val(objMbr.memb_ID);
		        $("#MEMB_ID").attr("readonly",true).attr("disabled",false); //입력불가
		        $("#MEMB_NAME").val(objMbr.memb_NAME);
		        $("#MEMB_MAIL").val(objMbr.memb_MAIL);
		        $("#MEMB_CPON").val(objMbr.memb_CPON);
		        $("#SUPMEM_APST").val(objMbr.supmem_APST);
		        $("#SUPR_FLAG").val("U");
		        
		    },
		    error: function () {
		         console.log('error');
		    }
		});

		$('#myModal').modal('show');
	 }); 
	
	
	$(".btnSave").click(function() {
		$('#customerFrm').submit();
	});
	
	
	/* 주문상태 일괄변경 */
	$(".btnState").click(function(){
		// 체크항목의 값
		var checkboxValues =[];
		var supmemApsState = $(this).val();
		console.log("btnState >> " + $(this).val());
		console.log("supmemApsState >> " + supmemApsState);
		
		
		$("input[name='chkOrdList']:checked").each(function(){
			var member_id=$(this).parent().next().next().next().text();
			checkboxValues.push(member_id);
		});
		
		if(checkboxValues.length < 1){
			checkboxValues.push("");	
			alert("승인상태 변경할 회원을 선택하여 주세요.");
			return;
		} else {
			if(!confirm("선택한 회원의 승인상태를 변경하시겠습니까?")) return;
		}
		
		$('#supmemApstNm').val(supmemApsState);
		$('#memberId').val(checkboxValues);
		$('#memberFrm').submit();
	});
	
});



function fn_all_chk(){
	var check_yn = false;	
	
	if($("#CHK_ALL").is(":checked")){
		check_yn = true;
	}
	for(var i=1;i<= ${fn:length(obj.list)};i++){
		$("#CHK"+i).prop("checked",check_yn);
	}
}

</script>
