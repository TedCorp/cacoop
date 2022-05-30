<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:set var="strActionUrl" value="${contextPath }/adm/deliveryAddrMgr/insert" />
<c:set var="strMethod" value="post" />
<c:if test="${ !empty tb_delivery_addr.ADD_NUM}"><!-- 수정시 사용 -->
	<c:set var="strActionUrl" value="${contextPath }/adm/deliveryAddrMgr/update" />
	<c:set var="strMethod" value="post" />
</c:if>

<style>

.form-control{
	width: 250px;
}
.div-info{
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: stretch;
}
.header-info{
    display: flex;
    width: 100%;
    justify-content: space-between;
    background-color: #526681;
    color:white;
    }
    
.delivery_label{
	display: flex;
	align-items: flex-end;
	margin-right: 15px;
}
</style>

<section class="content-header">
	<div class="box box-info">
		<div class="box-header with-border header-info">
			<h2>주소록 정보</h2>
		</div>
	</div>
	<spform:form name="deliveryfrm" id="deliveryfrm" method="${strMethod}" action="${strActionUrl}">
		<input type="hidden" name="SUPR_ID" value="${loginUser.SUPR_ID}">
		<input type="hidden" name="ADD_NUM" value="${tb_delivery_addr.ADD_NUM}">
		<input type="hidden" name="USE_YN" value="Y">
		<div class="box box-info">
			<div class="box-body">
				<div class="form-group div-info">
					<label for="USE_YN" class="delivery_label required">주소 구분</label>
					<p class="form-control-static">
				        <jsp:include page="${contextPath}/common/comCodForm">
							<jsp:param name="COMM_CODE" value="ADDR_GUBN" />
							<jsp:param name="name" value="ADDR_GUBN" />
							<jsp:param name="value" value="${ tb_delivery_addr.ADDR_GUBN }" />
							<jsp:param name="type" value="radio" />
							<jsp:param name="top" value="선택" />
						</jsp:include>
					</p>
				</div>
				
				<div class="form-group div-info">
					<label for="COM_TELN" class="delivery_label required">전화 번호</label>
					<input type="tel" name="COM_TELN" id="COM_TELN" class="form-control" style="width: 250px;" placeholder="전화번호 '-' 없이 입력"  value="${tb_delivery_addr.COM_TELN }">
				</div>
				<div class="form-group div-info">
					<label for="COM_FAX" class="delivery_label required">팩스 번호</label>
					<input type="tel" name="COM_FAX" id="COM_FAX" class="form-control" style="width: 250px;"  placeholder="팩스번호 '-' 없이 입력" value="${ tb_delivery_addr.COM_FAX}">
				</div>
				<div class="form-group div-info">
					<label for="COM_MOBILE" class="delivery_label required">휴대 전화</label>
					<input type="text" name="COM_MOBILE" id="COM_MOBILE" class="form-control" style="width: 250px;"  placeholder="휴대전화 '-' 없이 입력" value="${tb_delivery_addr.COM_MOBILE }">
				</div>
				<div class="form-group div-info">
					<input type="hidden" name="EXTRA_ADDR" id="EXTRA_ADDR" value="">
					<input type="hidden" name="ALL_ADDR" id="ALL_ADDR" value="">
					
					<label for="COM_PN" class="delivery_label required">우편 번호</label>
					<input type="text" name="COM_PN" id="COM_PN" class="form-control" style="width: 150px;"  value="${tb_delivery_addr.COM_PN }" placeholder="우편번호" readonly="readonly" maxlength="6">
					<span class="input-group-btn">
						<input type="button" class="btn btn-info mg-rigit-10 post_btn" value="주소검색" style="background-color:#3c8dbc;border-color:#3c8dbc;" onclick="win_zip('deliveryfrm', 'COM_PN', 'COM_BADR', 'COM_DADR', 'EXTRA_ADDR', 'ALL_ADDR');">
					</span>									
				</div>
				<div class="form-group div-info">
					<label for="COM_BADR" class="delivery_label required" >기본 주소</label>
					<input type="text" name="COM_BADR" id="COM_BADR" class="form-control" style="width: 300px;"  value="${tb_delivery_addr.COM_BADR }" placeholder="기본주소" readonly="readonly" maxlength="100">
				</div>
				<div class="form-group div-info">
					<label for="COM_DADR" class="delivery_label required" >상세 주소</label>
					<input type="text" name="COM_DADR" id="COM_DADR" class="form-control" style="width: 300px;"  value="${tb_delivery_addr.COM_DADR }" placeholder="상세주소" maxlength="100">
				</div>
			</div>
			<div class="row" style="padding-bottom:10px;">
				<div class="col-xs-12">
					<button type="button" class="btn btn-primary btn-sm pull-right left-5" onclick="javascript:fn_close();" >닫기</button>
					<c:choose>
						<c:when test="${ !empty tb_delivery_addr.ADD_NUM}">
							<button type="submit" class="btn btn-warning btn-sm pull-right left-5" >수정</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-warning btn-sm pull-right left-5" onclick="javascript:fn_save();">저장</button>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>	
	</spform:form>
</section>

<script>
//팝업닫기
function fn_close(){
	window.history.back();
}


 function fn_save(){
	var frm=document.getElementById("deliveryfrm");
	if(frm.COM_TELN.value==""){
		alert("전화번호를 입력해주세요");
		frm.COM_TELN.focus();
		return;
	}
	if(frm.COM_PN.value==""){
		alert("주소를 입력해주세요");
		frm.COM_PN.focus();
		return;
	}
	if(frm.COM_DADR.value==""){
		alert("상세주소를 입력해주세요.")
		return;
	}
	if(!confirm("저장 하시겠습니까?")) return;
	frm.submit();
}

</script>