<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<c:set var="strActionUrl" value="${contextPath }/m/wishList" />
<c:set var="strMethod" value="post" />

<script>
	//전체 체크 및 해제 시
	function fn_all_chk(){
		var check_yn = false;		
		if($("#CHK_ALL").is(":checked")){
			check_yn = true;
		}
		for(var i=1;i<= ${fn:length(obj.list) };i++){
			$("#CHK"+i).prop("checked",check_yn);
		}
	}
	
	//일괄 상태 변경
	function fn_state(state_chk){
		var cnt = 0;
		var intpd_regno_list = "";
		
		for(var i=1;i<= ${fn:length(obj.list) };i++){
			if($("#CHK"+i).is(":checked")){
				cnt++;
				if(intpd_regno_list != "") {
					intpd_regno_list+="$";
				}
				intpd_regno_list+=$("#CHK"+i).val();
			}
		}
		
		if(cnt == 0){
			alert("체크한 항목이 없습니다.");
			return;
		}
		
		var str = "";
		if(state_chk == "MOVE"){
			str = "해당 상품을 장바구니로 이동 하시겠습니까?";
		}else if(state_chk == "DELETE"){
			str = "해당 상품을 관심상품에서 삭제 하시겠습니까?";
		}
		
		if(!confirm(str))return;
		
		var frm=document.getElementById("orderFrm");
		frm.INTPD_REGNO_LIST.value=intpd_regno_list;
		if(state_chk == "MOVE"){
			frm.action = "${contextPath }/m/wishList/multi";
		}else if(state_chk == "DELETE"){
			frm.action = "${contextPath }/m/wishList/delete/multi";
		}
		frm.STATE_GUBUN.value=state_chk;
		frm.submit();
	}
	
	//장바구니 이동
	function fn_change(intpd_regno){
		if(!confirm("해당 상품을 장바구니로 이동 하시겠습니까?")) return;
		var frm=document.getElementById("orderFrm");
		frm.INTPD_REGNO.value=intpd_regno;
		frm.action = "${contextPath }/m/wishList/"+intpd_regno;
		//frm.method = "put";
		frm.submit();
	}
	
	//삭제
	function fn_delete(intpd_regno){
		if(!confirm("해당 상품을 관심상품에서 삭제 하시겠습니까?")) return;
		var frm=document.getElementById("orderFrm");
		frm.INTPD_REGNO.value=intpd_regno;
		frm.action = "${contextPath }/m/wishList/delete/"+intpd_regno;
		//frm.method = "delete";
		frm.submit();
	}
</script>

<!-- Main Container  -->
<div class="main-container container">
	<ul class="breadcrumb">
		<li><a href="${contextPath }/m"><i class="fa fa-home"></i></a></li>
		<li><a href="${contextPath }/m/wishList">관심상품</a></li>
	</ul>
	
	<div class="row">
		<!--Middle Part Start-->
		<div id="content" class="col-sm-12">
			<h2 class="title">관심상품 <small class="ml_5">| 자주 구매하시는 상품을 관심상품으로 등록하고 장바구니를 클릭해서  수량만 입력하시면 간편하게 이용하실수 있습니다.</small></h2>
			<div class="table-responsive">
			
				<form name="frmcartlist" id="sod_bsk_list" method="post" action="">
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<td class="text-center"><input type="checkbox" id="CHK_ALL" name="CHK_ALL" onclick="javascript:fn_all_chk();" /></td>
							<td class="text-center">사진</td>
							<td class="text-left">상품명</td>
							<td class="text-center">상품상태</td>
							<td class="text-right">가격</td>
							<td class="text-center">기능</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${obj.list }" var="list" varStatus="loop">
							<tr>
								<td class="text-center">
									<c:if test="${list.SALE_CON eq 'SALE_CON_01' and  list.DEL_YN eq 'N'  }">
										<input type="checkbox" id="CHK${loop.count }" name="CHK${loop.count }" value="${list.INTPD_REGNO }"/>
									</c:if>
								</td>
								<td class="text-center">
									<c:if test="${ !empty(list.ATFL_ID) }" >
										<c:if test="${list.FILEPATH_FLAG eq mainKey }">													
											<c:set var="imgPath" value="${contextPath }/upload/${list.STFL_PATH }/${list.STFL_NAME }" />
										</c:if>
										<c:if test="${!empty(list.FILEPATH_FLAG) && list.FILEPATH_FLAG ne mainKey }">
											<c:set var="imgPath" value="${list.STFL_PATH }" />
										</c:if>
										<c:if test="${ empty(list.FILEPATH_FLAG) }">
											<c:set var="imgPath" value="https://www.cjfls.co.kr/upload/${list.STFL_PATH }/${list.STFL_NAME }" />
										</c:if>
									</c:if>
									<img class="goodsImg" width="50" height="50" src="${imgPath}" alt="<c:out value="${ list.PD_NAME }" escapeXml="true"/>"/>
									<c:if test="${ empty(list.ATFL_ID) }">
										<img width="50" height="50" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ list.PD_NAME }" escapeXml="true"/>"/>
									</c:if>
								</td>
								<td class="text-left">
									<input type="hidden" name="PD_CODE" value="${list.PD_CODE }">
									<a href="${contextPath }/m/product/view/${list.PD_CODE }"><b>${list.PD_NAME }</b>
										<c:if test="${ list.PD_CUT_SEQ ne null }"><br>(세절방식 : ${ list.PD_CUT_SEQ})</c:if>
										<c:if test="${ list.OPTION_CODE ne null }"><br>(색상 : ${ list.OPTION_CODE})</c:if>
									</a>
								</td>
								<td class="text-center">
									<c:if test="${list.SALE_CON eq 'SALE_CON_01'}">
										구매가능
									</c:if>
									<c:if test="${list.SALE_CON ne 'SALE_CON_01'}">
										<span style="color:red">구매불가</span>
									</c:if>
								</td>
								<td class="text-right">
									<div class="price"> <span class="price-new"><fmt:formatNumber value="${list.REAL_PRICE }" />원</span></div>
								
								</td>
								<td class="text-center">
									<button class="btn btn-primary" title="" data-toggle="tooltip" onclick="javascript:fn_change('${list.INTPD_REGNO }');" type="button" data-original-title="장바구니 추가"><i class="fa fa-shopping-cart"></i></button>
									<a class="btn btn-danger" title="" data-toggle="tooltip" href="javascript:fn_delete('${list.INTPD_REGNO }');" data-original-title="삭제"><i class="fa fa-times"></i></a>
								</td>
							</tr>						
						<tr>
						</c:forEach>						
						<c:if test="${fn:length(obj.list) eq 0 }">
							<tr>
								<td colspan="6">조회된 관심상품이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				</form>
			</div>
			<div class="buttons clearfix">
				<div class="pull-right"><a class="btn btn-danger" href="javascript:fn_state('DELETE');">선택 삭제</a></div>
				<div class="pull-right"><a class="btn btn-warning" href="javascript:fn_state('MOVE');" style="margin-right:5px;">선택 장바구니</a></div>
			</div>
		</div>
	</div>
</div>
<!-- //Main Container -->

<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
	<input type="hidden" id="INTPD_REGNO_LIST" name="INTPD_REGNO_LIST" value="" />	<!-- 상태 변경 체크 항목 -->
	<input type="hidden" id="INTPD_REGNO" name="INTPD_REGNO" value="" />					<!-- 관심상품 등록번호-->
	<input type="hidden" id="STATE_GUBUN" name="STATE_GUBUN" value="" />					<!-- 상태 변경 - 장바구니이동인지 삭제인지 -->
	<c:forEach items="${obj.list }" var="list" varStatus="loop">
		<input type="hidden" name="OPTION_CODES" value="${list.OPTION_CODE }"/>
		<input type="hidden" name="PD_CUT_SEQS" value="${list.PD_CUT_SEQ }"/>
		<input type="hidden" id="OPTION1_NAMES" name="OPTION1_NAMES" value="${ list.OPTION1_NAME }" /> 
		<input type="hidden" id="OPTION1_VALUES" name="OPTION1_VALUES" value="${list.OPTION1_VALUE}" /> 
		<input type="hidden" id="OPTION2_NAMES" name="OPTION2_NAMES" value="${list.OPTION2_NAME}" /> 
		<input type="hidden" id="OPTION1_VALUES" name="OPTION2_VALUES" value="${list.OPTION2_VALUE}" /> 
	</c:forEach>
</spform:form>
