<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>:::: 식자재몰 - 믿고사는 식자재 ::::</title>

	<link rel="stylesheet" href="${contextPath}/resources/css/mall/default_shop.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/mall/style.css">
	
	<!-- BootStrap 3.3.6 -->		
	<link rel="stylesheet" href="${contextPath }/resources/bootstrap/css/bootstrap.min.css">

	<!-- jQuery 2.1.1 -->
	<script type="text/javascript" src="${contextPath }/resources/js/jquery-2.2.1.min.js"></script>
	<!-- BootStrap 3.3.6 -->
	<script type="text/javascript" src="${contextPath }/resources/bootstrap/js/bootstrap.min.js"></script>
	
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<!-- jQuery FlexSlider v2.6.1 -->
	<script src="${contextPath}/resources/js/jquery.flexslider-min.js"></script>
	
	<script src="${contextPath}/resources/js/slick.js"></script>
	
	<script language="javascript">
	<!--
		var contextPath = "<%= request.getContextPath() %>";
	//-->
	</script>
</head>

<body>
	<tiles:insertAttribute name="header" />
	<div id="wrapper">
	    <!-- 콘텐츠 시작 { -->
	    <div id="container">
		<tiles:insertAttribute name="center" />
	    </div>
	    <!-- } 콘텐츠 끝 -->
	</div>
	
	<tiles:insertAttribute name="footer" />
</body>

</html>
