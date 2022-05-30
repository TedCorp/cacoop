<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script language="Javascript" type="text/javascript">
<!--
alert("${ alertMessage }");

<c:if test="${ returnUrl eq 'back' }">
	history.back();
</c:if>
<c:if test="${ returnUrl eq 'close' }">
	window.close();
</c:if>
<c:if test="${ returnUrl ne 'back' && returnUrl ne 'close' && gubun ne 'popup' }">
	document.location.href = "<%= request.getContextPath() %>${ returnUrl }";
</c:if>
<c:if test="${ gubun eq 'popup' }">
	window.opener.location.href = "<%= request.getContextPath() %>${ returnUrl }";
	window.close();
</c:if>
//-->
</script>
