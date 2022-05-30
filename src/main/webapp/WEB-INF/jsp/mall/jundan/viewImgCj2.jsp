<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=10.0, minimum-scale=1.0, user-scalable=yes, shrink-to-fit=no">
		
		<title></title>

		<!-- Common CSS -->
		<link rel="stylesheet" href="${contextPath }/resources/css/common.css">
		<!-- BootStrap 3.3.6 -->		
		<link rel="stylesheet" href="${contextPath }/resources/bootstrap/css/bootstrap.min.css">

		<!-- AdminLTE 2.3.5 -->
		<link rel="stylesheet" href="${contextPath }/resources/adminlte/dist/css/AdminLTE.min.css">
		<!-- jQuery 2.1.1 -->
		<script type="text/javascript" src="${contextPath }/resources/js/jquery-2.2.1.min.js"></script>
		<!-- BootStrap 3.3.6 -->
		<script type="text/javascript" src="${contextPath }/resources/bootstrap/js/bootstrap.min.js"></script>


		<style>
		.imgHelp {
		    width:100%;
		}
		</style>
	</head>
<body style="background-color: #ECF0F5;">

	<div id="wrapper">
		<section class="content">
			<div class="row">
				<div class="col-md-12 row-md-12">
					<!-- Custom Tabs -->
					<div class="nav-tabs-custom">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#tab_1" data-toggle="tab"><b>1면</b></a></li>
							<li><a href="#tab_2" data-toggle="tab"><b>2면</b></a></li>
							<li><a href="#tab_3" data-toggle="tab"><b>3면</b></a></li>
							<li><a href="#tab_4" data-toggle="tab"><b>4면</b></a></li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="tab_1">
								<img src="${contextPath }/upload/jundan/cj/online/jundan1.jpg" class="imgHelp" />
							</div>
							<div class="tab-pane" id="tab_2">
								<img src="${contextPath }/upload/jundan/cj/online/jundan2.jpg" class="imgHelp" />
							</div>
							<div class="tab-pane" id="tab_3">
								<img src="${contextPath }/upload/jundan/cj/online/jundan3.jpg" class="imgHelp" />
							</div>
							<div class="tab-pane" id="tab_4">
								<img src="${contextPath }/upload/jundan/cj/online/jundan4.jpg" class="imgHelp" />
							</div>
						</div>
						<!-- /.tab-content -->
					</div>
					<!-- nav-tabs-custom -->
				</div>
				<!-- /.col -->
			</div>
		</section>
	</div>
	
</body>
</html>