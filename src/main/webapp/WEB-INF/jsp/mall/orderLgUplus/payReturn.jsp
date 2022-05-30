<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*" %>
<%@ include file="/layout/inc/taglib.jsp" %>


<%
request.setCharacterEncoding("euc-kr");
Map payReqMap = request.getParameterMap();
%>

<script type="text/javascript">
function setLGDResult() {
	parent.payment_return();
	try {
	} catch (e) {
		alert(e.message);
	}
}
</script>
<body onload="setLGDResult()">
<!-- 
<p>LGD_RESPCODE (결과코드) : <c:out value="${LGD_RESPCODE}" /></p>
<p>LGD_RESPMSG (결과메시지): <c:out value="${LGD_RESPMSG}" /></p>
 -->
 
<form method="post" name="LGD_RETURNINFO" id="LGD_RETURNINFO">
	
<c:forEach items="${payReqMap }" var="data" varStatus="loop">
	<c:forEach items="${data.value }" var="valueArr" varStatus="loop">
		<input type="hidden" id="${data.key }" name="${data.key }" value="${valueArr }" />
	</c:forEach>
</c:forEach>

</form>
