<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  
<style type="text/css">
.container {
    width: 1010px;
    max-width: none !important;
}
.col-5 {
    width: 790px;
    float: left;
    padding-left: 15px;
}
</style>

<script type="text/javascript">
$(function() {		
	$(".btnDeliveryView").click(function(){
		alert("배송 조회 준비중입니다.");
	});
	
	//전체선택 체크박스 클릭 
	$("#CHK_ALL").click(function(){ //만약 전체 선택 체크박스가 체크된상태일경우 
		if($("#CHK_ALL").prop("checked")) { //해당화면에 전체 checkbox들을 체크해준다 
			$("input[type=checkbox]").prop("checked",true); // 전체선택 체크박스가 해제된 경우 
		} else { //해당화면에 모든 checkbox들의 체크를해제시킨다. 
			$("input[type=checkbox]").prop("checked",false); 
		} 
	});

});

function chk_delete(){
	var checkboxValues = [];

	//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
	$("input:checkbox[name=CHK_WISH]:checked").each(function(){
		checkboxValues.push($(this).val());
		//checkboxValues += $(this).val()+":";
	});
	if(checkboxValues==''||checkboxValues==null){
		checkboxValues.push("");
		
		alert("삭제할 주문내역을 선택해 주세요.");
		return;
	}
	var allData = { "checkArray": checkboxValues };
	
	if (confirm('선택한 결제전 상태의 주문내역이 사라집니다.\n삭제하시겠습니까?')) {
        // Yes click
		$.ajax({
		    type: 'GET',
		    data: allData,
		    url: '${contextPath }/order/updateDelete',
		    success: function (data) {   	
		    	 location.reload();
		   
		    },
		    error:function(request,status,error){
		         console.log('error : '+error+"\n"+"code : "+request.status+"\n");
		    }
		});
   } else {
       // no click
       return;
	}
	//post_to_url("${contextPath }/order/wishList",allData,"get" );
	
	//post_to_url("https://logins.daum.net/accounts/login.do", {"id":"gmltjs2808", "pw":"my10182756"});
}

function post_to_url(path, params, method) {
	method = method || "post"; // Set method to post by default, if not specified.
	// The rest of this code assumes you are not using a library.
	// It can be made less wordy if you use one.
	var form = document.createElement("form");
	form.setAttribute("method", method);
	form.setAttribute("action", path);
	for(var key in params) {
		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		
		hiddenField.setAttribute("name", key);
		hiddenField.setAttribute("value", params[key]);
		alert(params[key]);
		form.appendChild(hiddenField);
	}
	document.body.appendChild(form);
	form.submit();
}
</script>


<%-- <c:set var="strActionUrl" value="${contextPath }/wishList" />
<c:set var="strMethod" value="post" /> --%>


<div class="sub-title sub-title-underline">
	<h2>
		주문내역 <small class="ml_5">| 절차, 배송 등 안내...</small>
	</h2>
	<ul>
		<li><a href='${contextPath }' class="sct_bg">Home</a></li>
		<li><a href="${contextPath }/order/wishList" class=" ">주문내역</a></li>
	</ul>
	<div class="clearfix"></div>
</div>

<form name="frmcartlist" id="sod_bsk_list" method="post" action="${contextPath }/order/wishList">

<table class="table table-order">
	<thead>
		<tr>
			<th scope="col"><input type="checkbox" id="CHK_ALL" name="CHK_ALL"/></th><!--onclick="javascript:fn_all_chk();"  -->
			<th scope="col">번호</th>
			<th scope="col">주문일자</th>
			<th scope="col">상품명</th>
			<th scope="col">결제금액</th>
			<th scope="col">주문상태</th>
			<!-- <th scope="col">배송조회</th> -->
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(obj.list) == 0 }">
		<tr>
			<td colspan="6">조회된 주문내역이 없습니다.</td>
		</tr>
	</c:if>
		<c:forEach items="${obj.list }" var="list" varStatus="loop">
		<tr>
			<td class="td_chk">
				<c:if test="${list.ORDER_CON eq 'ORDER_CON_01'}">
					<input type="checkbox" id="CHK${loop.count }" name="CHK_WISH" value="${list.ORDER_NUM }"/>
				</c:if>
			</td>
			<td class="sod_img">
				<input type="hidden" name="PD_CODE" value="${list.ORDER_NUM }">
				<a href="${contextPath}/order/view/${list.ORDER_NUM }"><b>${list.ORDER_NUM }</b></a>
			</td>
			<td class="td_num">${list.ORDER_DATE }</td>
			<td class="td_num">
				<a href="${contextPath}/order/view/${list.ORDER_NUM }"><b>${list.PD_NAME }
				<c:if test="${list.count > 0 }">
					&nbsp; 외 ${list.count}&nbsp;종
				</c:if>
				</b></a>
			</td>
			<td class="td_num"><fmt:formatNumber value="${list.ORDER_AMT }" /></td>
			<td class="td_num">${list.ORDER_CON_NM }</td>
			<%-- <td class="td_numbig">
				<c:if test="${list.ORDER_CON ne 'ORDER_CON_01' && list.ORDER_CON ne 'ORDER_CON_04' && list.ORDER_CON ne 'ORDER_CON_07'}">
					<button type="button" class="btn btn-xs btn-default btnDeliveryView">조회</button>
				</c:if>
			</td> --%>
		</tr>
		</c:forEach>
	</tbody>
</table>
</form>
<div class="btn_confirm">
	<button type="button" class="btn btn-sm btn-default pull-right" onclick="chk_delete()">선택 삭제</button>
</div>
<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
	<First><Previous><AllPageLink><Next><Last>
</paging:PageFooter>
