<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		고객 목록	
		<small>등록 고객 목록</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">Customers List</h3>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered">
				<caption>Customer List</caption>
				<colgroup>
					<col style="with:10px" />
					<col />
					<col style="with:50px" />
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>Name</th>
						<th>CreditLimit</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${customersList }" var="customer" varStatus="loop">
					<tr>
						<td>${customer.CUSTOMERNUMBER }.</td>
						<td><a href="${contextPath}/customers/${customer.CUSTOMERNUMBER }">${customer.CUSTOMERNAME }</a></td>
						<td><span class="badge bg-red">${customer.CREDITLIMIT }</span></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="box-footer">
			<a href="${contextPath }/customers/new" class="btn btn-info pull-right">등록</a>
		</div>
	</div>
</section>
