<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		고객정보
		<small>${customer.CUSTOMERNAME }</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">Customers : ${customer.CUSTOMERNAME }</h3>
		</div>
		<div class="box-body">
			${customer.CUSTOMERNAME }
		</div>
		<div class="box-footer">
			<a href="${contextPath }/customers" class="btn btn-default">목록</a>
			<button type="button" id="btn-delete" class="btn btn-warning pull-right">삭제</button>
			<a href="${contextPath }/customers/edit/${customer.CUSTOMERNUMBER}" class="btn btn-info pull-right">수정</a>
		</div>
	</div>
</section>

<spform:form id="deleteForm" name="deleteForm" method="DELETE" action="${contextPath }/customers/${customer.CUSTOMERNUMBER }" />

<script type="text/javascript">
$(document).ready(function() {
	$("#btn-delete").click(function(e) {
		if(confirm("삭제하시겠습니까?")) {
			$("#deleteForm").submit();
		}
	});
});
</script>
