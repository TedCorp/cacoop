<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		
		<title><tiles:insertAttribute name="page.title" /></title>

		<!-- Common CSS -->
		<link rel="stylesheet" href="${contextPath }/resources/css/common.css?ver=2.0">
		<!-- BootStrap 3.3.6 -->		
		<link rel="stylesheet" href="${contextPath }/resources/bootstrap/css/bootstrap.min.css">
		<!-- Font Awesome 4.6.3 -->
		<link rel="stylesheet" href="${contextPath }/resources/css/font-awesome/css/font-awesome.min.css">
		<!-- Ionicons 2.0.1 -->
		<link rel="stylesheet" href="${contextPath }/resources/css/ionicons/css/ionicons.min.css">
		<!-- AdminLTE 2.3.5 -->
		<link rel="stylesheet" href="${contextPath }/resources/adminlte/dist/css/AdminLTE.min.css">
		<link rel="stylesheet" href="${contextPath }/resources/adminlte/dist/css/skins/skin-blue.min.css">
		<link rel="stylesheet" href="${contextPath }/resources/adminlte/dist/css/style.css?ver=1">
		<!-- bootstrap datepicker -->
		<link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/datepicker/datepicker3.css">
  	
		<!-- jQuery 2.1.1 -->
		<script type="text/javascript" src="${contextPath }/resources/js/jquery-2.2.1.min.js"></script>
		<!-- BootStrap 3.3.6 -->
		<script type="text/javascript" src="${contextPath }/resources/bootstrap/js/bootstrap.min.js"></script>
		<!-- AdminLTE 2.3.5 -->
		<script type="text/javascript" src="${contextPath }/resources/adminlte/dist/js/app.min.js"></script>
		<!-- bootstrap datepicker -->
		<script src="${contextPath }/resources/adminlte/plugins/datepicker/bootstrap-datepicker.js"></script>
		<!-- CK Editor -->
		<script src="${contextPath }/resources/adminlte/plugins/ckeditor/ckeditor.js"></script>
		<!-- InputMask -->
		<script src="${contextPath }/resources/adminlte/plugins/input-mask/jquery.inputmask.js"></script>
		<script src="${contextPath }/resources/adminlte/plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
		<script src="${contextPath }/resources/adminlte/plugins/input-mask/jquery.inputmask.extensions.js"></script>
		
		<!-- jquery-validation-1.15 -->
		<script type="text/javascript" src="${contextPath }/resources/adminlte/plugins/validation/jquery.validate.min.js"></script>
		<!-- jquery-number-2.1.5 -->
		<script type="text/javascript" src="${contextPath }/resources/adminlte/plugins/number/jquery.number.min.js"></script>
		
		<!-- dTree -->
		<script type="text/javascript" src="${contextPath }/resources/adminlte/plugins/tree/dtree.js"></script>
		<link rel="StyleSheet" href = "${contextPath }/resources/adminlte/plugins/tree/dtree.css" type="text/css"/>

		<!-- ChartJS 1.0.1 -->
		<script src="${contextPath }/resources/adminlte/plugins/chartjs/Chart.min.js"></script>
		<script src="${contextPath }/resources/js/common.js"></script>
			
		<!-- 다음 우편번호
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> -->
		<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<%-- 		<!--건설건축협동조합  -->
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/common.css">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/swiper/dist/css/swiper.min.css">
		<script defer type="text/javascript" src="${contextPath}/resources/resources2/js/common.js"></script>
		<script defer type="text/javascript" src="${contextPath}/resources/resources2/swiper/dist/js/swiper.min.js"></script>
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/211021.css">	
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/reset.css">
	  	<meta name="viewport" content="width=device-width, initial-scale=1.0"> --%>
	</head>
	
	<tiles:insertAttribute name="page.body" />
	
</html>