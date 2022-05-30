<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>:::: 식자재몰 - 믿고사는 식자재 ::::</title>


    <!-- CSS -->
    <link href="${contextPath}/resources/css/commonNew.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/NanumBarunGothic.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/bootstrap.min.css?ver=1.0" rel="stylesheet">
    <link href="${contextPath}/resources/css/non-responsive.css" rel="stylesheet">

    <link href="${contextPath}/resources/css/style.css?ver=2.6" rel="stylesheet">
    <!-- JS -->
    <script src="${contextPath}/resources/js/ie-emulation-modes-warning.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="${contextPath}/resources/js/ie10-viewport-bug-workaround.js"></script>

    <!-- IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <![endif]-->
        
    <!-- Bootstrap core JavaScript -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="${contextPath}/resources/js/jquery-2.2.1.min.js"></script>
	<script>window.jQuery || document.write('<script src="${contextPath}/resources/js/jquery-2.2.1.min.js"><\/script>')</script>
	<script src="${contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="${contextPath}/resources/js/ie10-viewport-bug-workaround.js"></script>
	
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    
	<!-- 다음 우편번호
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> -->
	<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
	
	<!-- jquery-number-2.1.5 -->
	<script type="text/javascript" src="${contextPath }/resources/adminlte/plugins/number/jquery.number.min.js"></script>
	
	<!-- tooltip -->
    <link href="${contextPath}/resources/common/tooltip/tooltip.css?ver=1.1" rel="stylesheet">
    <script src="${contextPath}/resources/common/tooltip/tooltip.js"></script>
    
	<script language="javascript">
	<!--
		var contextPath = "<%= request.getContextPath() %>";
	//-->
	</script>
</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">

	<tiles:insertAttribute name="header" />

	<div class="container main_con">
		<div class="row_01 mb_25">
			<div class="col-1 lnb">
				<tiles:insertAttribute name="left" />
			</div>
			
			<div class="col-5">
				<tiles:insertAttribute name="center" />
			</div>

			<div class="clearfix"></div>
		</div>

		<!-- CUSTOMNER CENTER 빼기
		<div class="custom-box mt_30">

			<tiles:insertAttribute name="center_footer" />
			<div class="clearfix"></div>
		</div>
		 -->
	</div>
	<!-- /container -->



	<tiles:insertAttribute name="footer" />

</body>

</html>
