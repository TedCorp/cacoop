<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>

<%@ include file="/includes/taglib.jsp" %>

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

<p>LGD_RESPCODE (결과코드) : <c:out value="${LGD_RESPCODE}" /></p>
<p>LGD_RESPMSG (결과메시지): <c:out value="${LGD_RESPMSG}" /></p>

<form method="post" name="LGD_RETURNINFO" id="LGD_RETURNINFO">
<%
for (Iterator i = payReqMap.keySet().iterator(); i.hasNext();) {
	Object key = i.next();
	if (payReqMap.get(key) instanceof String[]) {
		String[] valueArr = (String[])payReqMap.get(key);
		for(int k = 0; k < valueArr.length; k++)
			out.println("<input type='hidden' name='" + key + "' id='"+key+"'value='" + valueArr[k] + "'/>");
	} else {
		String value = payReqMap.get(key) == null ? "" : (String) payReqMap.get(key);
		out.println("<input type='hidden' name='" + key + "' id='"+key+"'value='" + value + "'/>");
	}
}
%>
</form>



<script type="text/javascript">

	$(function() {
		setLGDResult();
	});
	
</script>