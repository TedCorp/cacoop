<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		고객 등록	
		<small>add new customers</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">
	<!-- Horizontal Form -->
	<div class="box box-info">
		<div class="box-header with-border">
			<h3 class="box-title">고객정보</h3>
		</div>
		<!-- /.box-header -->

		<!-- form start -->
		<spform:form name="customerFrm" id="customerFrm" method="put" action="${contextPath }/customers/edit/${customer.CUSTOMERNUMBER}" class="form-horizontal">
			<input type="hidden" name="SALESREPEMPLOYEENUMBER" value="${customer.SALESREPEMPLOYEENUMBER }" />
			<!-- box-body -->
			<div class="box-body">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">Name</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="customerName" name="CUSTOMERNAME" value="${customer.CUSTOMERNAME }" placeholder="Customer Name" required="required" />
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">Contact Last Name</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="contactLastName" name="CONTACTLASTNAME" value="${customer.CONTACTLASTNAME }" placeholder="Contact Last Name" required="required" />
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">Contact First Name</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="contactFirstName" name="CONTACTFIRSTNAME" value="${customer.CONTACTFIRSTNAME }" placeholder="Contact First Name" required="required" />
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">Phone</label>
					<div class="col-sm-10">
						<input type="phone" class="form-control" id="phone" name="PHONE" value="${customer.PHONE }" placeholder="Phone Number" required="required" />
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">Address Line1</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="addressLine1" name="ADDRESSLINE1" value="${customer.ADDRESSLINE1 }" placeholder="AddressLine 1" required="required" />
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">Address Line2</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="addressLine2" name="ADDRESSLINE2" value="${customer.ADDRESSLINE2 }" placeholder="AddressLine 2">
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">City</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="city" name="CITY" value="${customer.CITY }" placeholder="City" required="required" />
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">Country</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="country" name="COUNTRY" value="${customer.COUNTRY }" placeholder="Country" required="required" />
					</div>
				</div>
			</div>
			<!-- /.box-body -->

			<div class="box-footer">
				<a href="${contextPath}/customers" class="btn btn-default">취소</a>
				<button type="submit" class="btn btn-info pull-right">저장</button>
			</div>
			<!-- /.box-footer -->
		</spform:form>
	</div>
	<!-- /.box -->
</section>
