<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<link href="../../resources/css/common.css" rel="stylesheet">

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<tiles:insertAttribute name="main-header" flush="true" />
		<tiles:insertAttribute name="main-sidebar" flush="true" />
		
		<div class="content-wrapper">
			<tiles:insertAttribute name="content-wrapper" />
		</div>
		
		<tiles:insertAttribute name="main-footer" flush="true" />
		<tiles:insertAttribute name="control-sidebar" flush="true" />
	</div>
</body>