<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    
    <!-- Basic page needs
    ============================================ -->
    <title>:::: 식자재몰 - 믿고사는 식자재 ::::</title>
    <meta charset="utf-8">
    <meta name="keywords" content="청정식자재몰, cjfls" />
    
    <!-- Mobile specific metas
    ============================================ -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <link rel="shortcut icon" type="image/png" href="ico/favicon-16x16.png"/>
    
   
    <!-- Libs CSS
    ============================================ -->
    <link rel="stylesheet" href="${contextPath}/resources/css/responsive/bootstrap/css/bootstrap.min.css">
    <link href="${contextPath}/resources/css/responsive/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/js/responsive/datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/js/responsive/owl-carousel/owl.carousel.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/responsive/themecss/lib.css" rel="stylesheet">
    <link href="${contextPath}/resources/js/responsive/jquery-ui/jquery-ui.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/js/responsive/minicolors/miniColors.css" rel="stylesheet">
    
    <!-- Theme CSS
    ============================================ -->
    <link href="${contextPath}/resources/css/responsive/themecss/so_searchpro.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/responsive/themecss/so_megamenu.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/responsive/themecss/so-categories.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/responsive/themecss/so-listing-tabs.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/responsive/themecss/so-category-slider.css?v=2" rel="stylesheet">
    <link href="${contextPath}/resources/css/responsive/themecss/so-newletter-popup.css" rel="stylesheet">

    <link href="${contextPath}/resources/css/responsive/footer/footer1.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/responsive/header/header1.css?v=${DATE }" rel="stylesheet">
    <link id="color_scheme" href="${contextPath}/resources/css/responsive/theme.css?v=${DATE }" rel="stylesheet"> 
    <link href="${contextPath}/resources/css/responsive/responsive.css?v=${DATE }" rel="stylesheet">

     <!-- Google web fonts
    ============================================ -->
    <link href='https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700' rel='stylesheet' type='text/css'>
    <style type="text/css">
         /* body{font-family:'Poppins', sans-serif} */
    </style>

	



	<!-- Include Libs & Plugins
	============================================ -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/jquery-2.2.4.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/bootstrap.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/owl-carousel/owl.carousel.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/slick-slider/slick.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/themejs/libs.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/unveil/jquery.unveil.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/countdown/jquery.countdown.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/dcjqaccordion/jquery.dcjqaccordion.2.8.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/datetimepicker/moment.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/datetimepicker/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/jquery-ui/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/modernizr/modernizr-2.6.2.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/minicolors/jquery.miniColors.min.js"></script>
	
	<!-- Theme files
	============================================ -->
	
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/themejs/homepage.js?v=${DATE }"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/themejs/application.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/themejs/toppanel.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/themejs/so_megamenu.js?v=3"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/themejs/addtocart.js"></script>  
	
	<!-- jquery-number-2.1.5 -->
	<script type="text/javascript" src="${contextPath}/resources/adminlte/plugins/number/jquery.number.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js?v=${DATE }"></script>
	
	<!-- Popup css Add - 20191112 -->
	<link href="${contextPath}/resources/css/responsive/themecss/popup.css" rel="stylesheet">
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/themejs/popup.js"></script>
</head>
<body>
    
    <div class="wrapper">
    
	<tiles:insertAttribute name="header" />

	<tiles:insertAttribute name="center" />
	
	<tiles:insertAttribute name="footer" />
    
    </div>
   
</body>

</html>
