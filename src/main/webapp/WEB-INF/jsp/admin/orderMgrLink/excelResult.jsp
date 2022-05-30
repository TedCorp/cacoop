<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<style>
</style>

<section class="content-header">
	<h1>운송장 업로드</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">결과</h3>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<div class="box-body">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">실패 : <BIG><FONT COLOR = "RED"> ${errlist.size()}</FONT></BIG></label>
					<label for="inputEmail3" class="col-sm-2 control-label">완료 : <BIG>${scslist.size()}</BIG> </label>
				</div>	
			</div>
				
		</div>
		<!-- /.box-body -->
	</div>	

	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">변경 실패 : <font color = "red"><b>${errlist.size()}</b></font> </h3>		
			
			<div class="box-tools pull-right">
				<button type="button" class="btn btn-box-tool" data-widget="collapse">
					<i class="fa fa-minus"></i>
				</button>
				<button type="button" class="btn btn-box-tool" data-widget="remove">
					<i class="fa fa-remove"></i>
				</button>
			</div>	
		</div>		
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>주문번호</th>
						<th>주문상세번호</th>
						<th>상품코드</th>
						<th>상품명</th>
						<th>수량</th>
						<th>주문자</th>
						<th>주소</th>
						<th>배송업체</th>
						<th>운송장번호</th>
						<th>메세지</th>
					</tr>					
				</thead>
				<tbody>
				<c:forEach items="${errlist}" var="list" varStatus="loop">
					<tr>
						<td align="left">
							<label>${list.ORDER_NUM}</label>
						</td>						
						<td align="left">
							<label>${list.ORDER_DTNUM}</label>
						</td>
						<td align="left">
							<label>${list.PD_CODE}</label>
						</td>
						<td align="left">
							<label>${list.PD_NAME}</label>
						</td>
						<td align="left">
							<label>${list.ORDER_QTY}</label>
						</td>
						<td align="left">
							<label>${list.ORDER_NM}</label>
						</td>
						<td align="left">
							<label>${list.ORDER_ADDR}</label>
						</td>
						<td align="left">
							<label>${list.DLVY_COM}</label>
						</td>
						<td align="left">
							<label>${list.DLVY_TDN}</label>
						</td>
						<td align="left">
							<label>${list.EXCEL_MSG}</label>
						</td>						
					</tr>
				</c:forEach>
				
				<c:if test="${errlist.size() eq 0}">
					<tr>
						<td colspan="4"><label>조회된 내용이 없습니다.</label></td>
					</tr>
				</c:if>
				
				</tbody>
			</table>
		</div>
	</div>
	
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">변경 완료 : <b>${scslist.size()}</b></h3>		
			
			<div class="box-tools pull-right">
				<button type="button" class="btn btn-box-tool" data-widget="collapse">
					<i class="fa fa-minus"></i>
				</button>
				<button type="button" class="btn btn-box-tool" data-widget="remove">
					<i class="fa fa-remove"></i>
				</button>
			</div>	
		</div>		
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>주문번호</th>
						<th>주문상세번호</th>
						<th>상품코드</th>
						<th>상품명</th>
						<th>수량</th>
						<th>주문자</th>
						<th>주소</th>
						<th>배송업체</th>
						<th>운송장번호</th>
						<th>메세지</th>
					</tr>					
				</thead>
				<tbody>
				<c:forEach items="${scslist}" var="list" varStatus="loop">
					<tr>
						<td align="left">
							<label>${list.ORDER_NUM}</label>
						</td>						
						<td align="left">
							<label>${list.ORDER_DTNUM}</label>
						</td>
						<td align="left">
							<label>${list.PD_CODE}</label>
						</td>
						<td align="left">
							<label>${list.PD_NAME}</label>
						</td>
						<td align="left">
							<label>${list.ORDER_QTY}</label>
						</td>
						<td align="left">
							<label>${list.ORDER_NM}</label>
						</td>
						<td align="left">
							<label>${list.ORDER_ADDR}</label>
						</td>
						<td align="left">
							<label>${list.DLVY_COM}</label>
						</td>
						<td align="left">
							<label>${list.DLVY_TDN}</label>
						</td>
						<td align="left">
							<label>${list.EXCEL_MSG}</label>
						</td>	
					</tr>
				</c:forEach>
				
				<c:if test="${scslist.size() eq 0}">
					<tr>
						<td colspan="4"><label>조회된 내용이 없습니다.</label></td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="col-xs-12">
			<a href="${contextPath}/adm/orderMgrLink" class="btn btn-default pull-right"><i class="fa fa-list"></i>목록</a>
		</div>
	</div>
</section>