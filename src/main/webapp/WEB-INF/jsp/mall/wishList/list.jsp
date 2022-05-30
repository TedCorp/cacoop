<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<script>
$(function() {
	$('.goodsImg').each(function(n){
		$(this).error(function(){
			$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
		});
	 });
});
</script>

<c:set var="strActionUrl" value="${contextPath }/wishList" />
<c:set var="strMethod" value="post" />

<div class="sub-title sub-title-underline">
	<h2>
		관심상품 <small class="ml_5">| 자주 구매하시는 상품을 관심상품으로 등록하고 장바구니를 클릭해서  수량만 입력하시면 간편하게 이용하실수 있습니다.</small>
	</h2>
	<ul>
		<li><a href='${contextPath }' class="sct_bg">Home</a></li>
		<li><a href="${contextPath }/wishList" class=" ">관심상품</a></li>
	</ul>
	<div class="clearfix"></div>
</div>

<form name="frmcartlist" id="sod_bsk_list" method="post" action="">
	<table class="table table-order">
		<thead>
			<tr>
				<th scope="col"><input type="checkbox" id="CHK_ALL" name="CHK_ALL" onclick="javascript:fn_all_chk();" /></th>
				<th scope="col" style="width:55px">사진</th>
				<th scope="col">상품명</th>
				<!-- <th scope="col">수량</th> -->
				<th scope="col">가격</th>
				<th scope="col">기능</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(obj.list) eq 0 }">
			<tr>
				<td colspan="5">조회된 관심상품이 없습니다.</td>
			</tr>
		</c:if>
			<c:forEach items="${obj.list }" var="list" varStatus="loop">
			<tr>
				<td class="td_chk">
					<c:if test="${list.SALE_CON eq 'SALE_CON_01' and list.DEL_YN eq 'N'  }">
						<input type="checkbox" id="CHK${loop.count }" name="CHK${loop.count }" value="${list.INTPD_REGNO }"/>
					</c:if>
				</td>
				<td class="sod_img">
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
					<img width="50" height="50" src="${imgPath}" alt="<c:out value="${ list.PD_NAME }" escapeXml="true"/>"/>
					<c:if test="${ empty(list.ATFL_ID) }">
						<img width="50" height="50" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ list.PD_NAME }" escapeXml="true"/>"/>
					</c:if>
				</td>
				<td class="sod_img">
					<input type="hidden" name="PD_CODE" value="${list.PD_CODE }">
					<c:if test="${list.SALE_CON ne 'SALE_CON_01' or list.DEL_YN ne 'N'  }">
						<div style="position: absolute;font-size:15px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;">
						----------------------------------<br>
						</div>
					</c:if>
					<a href="/product/view/${list.PD_CODE }"><b>${list.PD_NAME }</b>
						<c:if test="${ list.PD_CUT_SEQ ne null }"><br>(세절방식 : ${ list.PD_CUT_SEQ})</c:if>
						<c:if test="${ list.OPTION_CODE ne null }"><br>(색상 : ${ list.OPTION_CODE})</c:if>
					</a>
				</td>
				<%-- <td class="td_num"><fmt:formatNumber value="${list.PD_QTY }" /></td> --%>
				<td class="td_numbig"><fmt:formatNumber value="${list.REAL_PRICE }" /></td>
				<td class="td_numbig">
					<c:if test="${list.SALE_CON eq 'SALE_CON_01' and list.DEL_YN eq 'N'  }">
						<button type="button" onclick="javascript:fn_change('${list.INTPD_REGNO }');" class="btn btn-sm btn-default">장바구니</button>
					</c:if>
					&nbsp;
					<button type="button" onclick="javascript:fn_delete('${list.INTPD_REGNO }');" class="btn btn-sm btn-success">삭제</button>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div id="sod_bsk_act">
		<button type="button" onclick="javascript:fn_state('DELETE');" class="btn btn-sm btn-success pull-right">선택 삭제</button>
		<a href="#" onclick="javascript:fn_state('MOVE');" class="btn btn-sm btn-default pull-right" style="margin-right:5px;">선택 장바구니</a>
	</div>
</form>


<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
	<input type="hidden" id="INTPD_REGNO_LIST" name="INTPD_REGNO_LIST" value="" /><!-- 상태 변경 체크 항목 -->
	<input type="hidden" id="INTPD_REGNO" name="INTPD_REGNO" value="" /><!-- 선택 관심상품 등록번호-->
	<input type="hidden" id="STATE_GUBUN" name="STATE_GUBUN" value="" /><!-- 산태 변경 구분 - 장바구니이동인지 삭제인지 -->
	<c:forEach items="${obj.list }" var="list" varStatus="loop">
		<input type="hidden" name="OPTION_CODES" value="${list.OPTION_CODE }"/>
		<input type="hidden" name="PD_CUT_SEQS" value="${list.PD_CUT_SEQ }"/>
	</c:forEach>
</spform:form>

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
		frm.action = "${contextPath }/wishList/multi";
	}else if(state_chk == "DELETE"){
		frm.action = "${contextPath }/wishList/delete/multi";
	}
	frm.STATE_GUBUN.value=state_chk;
	frm.submit();
}

//장바구니 이동
function fn_change(intpd_regno){
	if(!confirm("해당 상품을 장바구니로 이동 하시겠습니까?")) return;
	var frm=document.getElementById("orderFrm");
	frm.INTPD_REGNO.value=intpd_regno;
	frm.action = "${contextPath }/wishList/"+intpd_regno;
	//frm.method = "put";
	frm.submit();
}

//삭제
function fn_delete(intpd_regno){
	if(!confirm("해당 상품을 관심상품에서 삭제 하시겠습니까?")) return;
	var frm=document.getElementById("orderFrm");
	frm.INTPD_REGNO.value=intpd_regno;
	frm.action = "${contextPath }/wishList/delete/"+intpd_regno;
	//frm.method = "delete";
	frm.submit();
}
</script>
