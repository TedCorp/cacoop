<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		기업정보 관리 
	</h1>
</section>

<c:set var="strActionUrl" value="${contextPath }/adm/supplierInfoMgr/edit" />
<c:set var="strMethod" value="put" />

<section class="content">
	<!-- Horizontal Form -->
	<!-- form start -->
	<spform:form name="supplierFrm" id="supplierFrm" method="${strMethod}" action="${strActionUrl}" class="form-horizontal">
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">기본정보</h3>
			</div>
			<!-- /.box-header -->
	
			<input type="hidden" name="SUPR_ID" value="${supplierInfo.SUPR_ID }" />
			<input type="hidden" name="SVMN_USCON" value="${supplierInfo.SVMN_USCON }" />
			<input type="hidden" name="DLVREF_CONT" value="${supplierInfo.DLVREF_CONT }" />
			
			<input type="hidden" name="RPRS_NAME" value="${supplierInfo.RPRS_NAME }" />
			<input type="hidden" name="BIZR_NUM" value="${supplierInfo.BIZR_NUM }" />
			<input type="hidden" name="SUPR_NAME" value="${supplierInfo.SUPR_NAME }" />
						
			<!-- box-body -->
			<div class="box-body">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">기업코드</label>
					<div class="col-sm-10">
						${supplierInfo.SUPR_ID }
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">기업명</label>
					<div class="col-sm-4">
						${supplierInfo.SUPR_NAME }
					</div>
					<label for="inputEmail3" class="col-sm-2 control-label">사업자등록번호</label>
					<div class="col-sm-4">
						${supplierInfo.BIZR_NUM }
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">대표자명</label>
					<div class="col-sm-10">
						${supplierInfo.RPRS_NAME }
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">전화번호</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="TEL_NUM"  value="${supplierInfo.TEL_NUM }" required="required" style="text-align:left;" maxlength="15" />
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">팩스번호</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="FAX_NUM"  data-mask value="${supplierInfo.FAX_NUM }" style="text-align:left;" maxlength="15" />
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">대표이메일</label>
					<div class="col-sm-10">
						<input type="email" class="form-control" id="RPR_MAIL" name="RPR_MAIL" value="${supplierInfo.RPR_MAIL }" />
					</div>
				</div>
				<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">주소</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="POST_NUM" name="POST_NUM" value="${supplierInfo.POST_NUM }" placeholder="우편번호" required="required" style="text-align:left;" maxlength="5" />
						</div>
					</div>
					<div class="form-group">
						<label for="BASC_ADDR" class="col-sm-2 control-label"></label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="BASC_ADDR" name="BASC_ADDR" value="${supplierInfo.BASC_ADDR }" placeholder="기본주소" required="required" />
						</div>
					</div>
					<div class="form-group">
						<label for="DTL_ADDR" class="col-sm-2 control-label"></label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="DTL_ADDR" name="DTL_ADDR" value="${supplierInfo.DTL_ADDR }" placeholder="상세주소">
						</div>
					</div>
			</div>
			<!-- /.box-body -->
		</div>
		

		
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">운영정책</h3>
			</div>
			
			<!-- box-body -->
			<div class="box-body">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">배송비</label>
					<div class="col-sm-10">
						<input type="text" class="form-control number" id="DLVY_AMT" name="DLVY_AMT" value="<fmt:formatNumber value="${supplierInfo.DLVY_AMT }" pattern="#,###"/>" style="text-align:left;" maxlength="15" />원
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">배송비무료조건</label>
					<div class="col-sm-10">
						<input type="text" class="form-control number" id="DLVA_FCON" name="DLVA_FCON" value="<fmt:formatNumber value="${supplierInfo.DLVA_FCON }" pattern="#,###"/>" style="text-align:left;" maxlength="15" />원 이상 구매시
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">택배사</label>
					<div class="col-sm-10">
		                <jsp:include page="${contextPath }/common/comCodForm">
							<jsp:param name="COMM_CODE" value="DLVY_COM" />
							<jsp:param name="name" value="PS_COM" />
							<jsp:param name="value" value="${ supplierInfo.PS_COM }" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="선택" />
						</jsp:include>
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">자동 상품수령 기간</label>
					<div class="col-sm-10">
		                <jsp:include page="${contextPath }/common/comCodForm">
							<jsp:param name="COMM_CODE" value="APR_PROD" />
							<jsp:param name="name" value="APR_PROD" />
							<jsp:param name="value" value="${ supplierInfo.APR_PROD }" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="선택" />
						</jsp:include>
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">자동 구매확정 기간</label>
					<div class="col-sm-10">
		                <jsp:include page="${contextPath }/common/comCodForm">
							<jsp:param name="COMM_CODE" value="APD_PROD" />
							<jsp:param name="name" value="APD_PROD" />
							<jsp:param name="value" value="${ supplierInfo.APD_PROD }" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="선택" />
						</jsp:include>
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">장바구니 보관기간</label>
					<div class="col-sm-10">
		                <jsp:include page="${contextPath }/common/comCodForm">
							<jsp:param name="COMM_CODE" value="SBK_PROD" />
							<jsp:param name="name" value="SBK_PROD" />
							<jsp:param name="value" value="${ supplierInfo.SBK_PROD }" />
							<jsp:param name="type" value="select" />
							<jsp:param name="top" value="선택" />
						</jsp:include>
					</div>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
		
		<!-- 주소록 box  -->
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">주소록확인</h3>
			</div>
			<!-- box-body -->
			<div class="box-body">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">출고지/반품지 주소록</label>
					<div class="col-sm-10">
						<button type="button" class="btn btn-primary btn-sm btnAdd" onclick="javascript:fn_popup();">주소록보기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 주소록 box END-->
		
		
		<!-- this row will not appear when printing -->
		<div class="row">
			<div class="col-xs-12">
				<button type="submit" class="btn btn-primary pull-right" style="margin-right: 5px;">
					<i class="fa fa-save"></i> 저장
				</button>
			</div>
		</div>
		
	</spform:form>
	<!-- /.box -->
</section>

<script>
	$(function() {

		$(".number").keyup(function(e) {
	    	$(this).number(true);
		});
		
		//Date picker
		$('#datepicker').datepicker({
			autoclose: true
		});
		
	    //Money Euro
	    $("[data-mask]").inputmask();
	});
	
	//상품선택 팝업 호출
	function fn_popup(){
		window.open("${contextPath}/adm/deliveryAddrMgr", "_blank", "width=700,height=800"); 
	}
	
</script>