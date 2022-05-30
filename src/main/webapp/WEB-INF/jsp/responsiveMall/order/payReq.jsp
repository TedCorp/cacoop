<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<%
System.out.println("ttttttttttest");
%>
<!-- test일 경우 -->
<script language="javascript" src="https://pretest.uplus.co.kr:9443/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<!-- 
<script language="javascript" src="https://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
  service일 경우 아래 URL을 사용 
<script language="javascript" src="https://xpayvvip.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
 -->
<script type="text/javascript">
/*
* 수정불가.
*/
var LGD_window_type = '<c:out value="${LGD_WINDOW_TYPE}" />';
var LGD_ostype_check = '<c:out value="${LGD_OSTYPE_CHECK}"/>';
	
/*
* 수정불가
*/
function launchCrossPlatform(){
	lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), '<c:out value="${CST_PLATFORM}" />', LGD_window_type, null, "", "");

	console.log('LGD_OSTYPE_CHECK', LGD_ostype_check);
	// Xpay Module CSS Resize
	var _lguplus_popup__iframe = document.getElementById('_lguplus_popup__iframe');
	var _lguplus_popip__div = _lguplus_popup__iframe.parentNode;
	_lguplus_popip__div.style.removeProperty("margin-top");
	_lguplus_popip__div.style.removeProperty("margin-left");
	_lguplus_popip__div.style.removeProperty("top");
	_lguplus_popip__div.style.removeProperty("left");
	_lguplus_popip__div.style.width = "100%";
	_lguplus_popip__div.style.height = "100%";
	if(LGD_ostype_check == "M"){
		_lguplus_popup__iframe.removeAttribute('scrolling');
		_lguplus_popup__iframe.setAttribute("scrolling", "yes");
	}
}

/*
* FORM 명만  수정 가능
*/
function getFormObject() {
	return document.getElementById("LGD_PAYINFO");
}

/*
 * 인증결과 처리 (payReturn에서 호출)
 */
function payment_return() {
	var fDoc;
		fDoc = lgdwin.contentWindow || lgdwin.contentDocument;
	if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {
			document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById('LGD_PAYKEY').value;
			document.getElementById("LGD_PAYINFO").target = "_self";
			document.getElementById("LGD_PAYINFO").action = "${contextPath}/m/order/payRes";
			document.getElementById("LGD_PAYINFO").submit();
	} else {
		alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
		closeIframe();
		parent.fnPayClose();	//부모 팝업 닫기;
	}
}
</script>

<body onload="launchCrossPlatform()">
<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="${contextPath}/m/order/payRes">
	<table>
	    <tr>
	        <td>구매자 이름 </td>
	        <td>${LGD_BUYER}</td>
	    </tr>
	    <tr>
	        <td>상품정보 </td>
	        <td>${LGD_PRODUCTINFO}</td>
	    </tr>
	    <tr>
	        <td>결제금액 </td>
	        <td>${LGD_AMOUNT}</td>
	    </tr>
	    <tr>
	        <td>구매자 이메일 </td>
	        <td>${LGD_BUYEREMAIL}</td>
	    </tr>
	    <tr>
	        <td>주문번호 </td>
	        <td>${LGD_OID}</td>
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
	
	<c:forEach items="${PAYREQ_MAP}" var="data" varStatus="loop">
		<input type="hidden" id="${data.key}" name="${data.key}" value="${data.value}" />
	</c:forEach>
</form>
</body>