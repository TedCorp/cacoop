<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<script language="javascript" src="https://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<script type="text/javascript">
/*
* 수정불가.
*/
var LGD_window_type = '<c:out value="${LGD_WINDOW_TYPE}" />';
	
/*
* 수정불가
*/
function launchCrossPlatform(){
	lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), '<c:out value="${CST_PLATFORM}" />', LGD_window_type, null, "", "");
}

/*
* FORM 명만  수정 가능
*/
function getFormObject() {
	return document.getElementById("LGD_PAYINFO");
}

/*
 * 인증결과 처리
 */
function payment_return() {
	var fDoc;
	fDoc = lgdwin.contentWindow || lgdwin.contentDocument;
	if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {
			document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById('LGD_PAYKEY').value;
			document.getElementById("LGD_PAYINFO").target = "_self";
			document.getElementById("LGD_PAYINFO").action = "${contextPath}/order/payRes";
			document.getElementById("LGD_PAYINFO").submit();
	} else {
		alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
		closeIframe();		
	}
}

/*창닫기*/
function popup_close(){
	parent.fnPayClose();
	//window.parent.location.href = "<%= request.getContextPath() %>/order/view/${ORDER_NUM}";
}
</script>

<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="${contextPath}/order/payRes">
	<!-- 
	<table>
	    <tr>
	        <td>구매자 이름 </td>
	        <td><c:out value="${LGD_BUYER}" /></td>
	    </tr>
	    <tr>
	        <td>상품정보 </td>
	        <td><c:out value="${LGD_PRODUCTINFO}" /></td>
	    </tr>
	    <tr>
	        <td>결제금액 </td>
	        <td><c:out value="${LGD_AMOUNT}" /></td>
	    </tr>
	    <tr>
	        <td>구매자 이메일 </td>
	        <td><c:out value="${LGD_BUYEREMAIL}" /></td>
	    </tr>
	    <tr>
	        <td>주문번호 </td>
	        <td><c:out value="${LGD_OID}" /></td>
	    </tr>
	    <tr>
	        <td colspan="2">* 추가 상세 결제요청 파라미터는 메뉴얼을 참조하시기 바랍니다.</td>
	    </tr>
	    <tr>
	        <td colspan="2"></td>
	    </tr>
	    <tr>
	        <td colspan="2">
			<input type="button" value="인증요청" onclick="launchCrossPlatform();"/>
	        </td>
	    </tr>
	</table>
	 -->
	 
	<c:forEach items="${PAYREQ_MAP}" var="data" varStatus="loop">
		<input type="hidden" id="${data.key }" name="${data.key }" value="${data.value }" />
	</c:forEach>
</form>

<div class="btn_confirm">
	<a href="#" id="btnAuth" class="btn btn-sm btn-default pull-right">결제</a>
</div>

<script type="text/javascript">
$(function() {
	if("${payReturnFlag}"=='justget'){
		popup_close();	
			
	}else{
		$("#btnAuth").click(function(){
			launchCrossPlatform();
		});
		// 인증결제창을 호출하는 함수: openXpay
		launchCrossPlatform();	
	}
		
	// Xpay Module CSS Resize
	$("#_lguplus_popup__iframe").closest('div').removeAttr("style")
	$('#_lguplus_popup__iframe').closest('div').css(
			{	'width':'99.5%', 
				'height':'99.5%', 
				'border-radius':'5px', 
				'text-align':'center', 
				'position':'absolute', 
				'z-index':'2147483647', 
				'background':'rgb(255, 255, 255)'
			}
		);		
});	
</script>


