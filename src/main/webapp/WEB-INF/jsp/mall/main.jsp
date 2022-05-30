<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

	<script src="${contextPath}/resources/js/jquery-2.2.1.min.js"></script>
	<script>window.jQuery || document.write('<script src="${contextPath}/resources/js/jquery-2.2.1.min.js"><\/script>')</script>
	<script src="${contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="${contextPath}/resources/js/ie10-viewport-bug-workaround.js"></script>
	
	
    <!-- tooltip -->
    <link href="${contextPath}/resources/common/tooltip/tooltip.css?ver=1.1" rel="stylesheet">
    <script src="${contextPath}/resources/common/tooltip/tooltip.js"></script>
    
	<script language="javascript">
	<!--
		var contextPath = "<%= request.getContextPath() %>";
	//-->
	</script>


<script type="text/javascript">
/* Side Menu */
$(document).ready(function(){
	alert("사이트 점검중 입니다. 사용자의 양해 부탁드립니다.\n점검시간 : 5시~5시15분");
});
</script>
<body bgcolor="#F1F1F1">
<br><br><br><br>
<img src="${contextPath}/resources/img/common/open_read.gif" style="margin-left: auto; margin-right: auto; display: block;"/>
</body>