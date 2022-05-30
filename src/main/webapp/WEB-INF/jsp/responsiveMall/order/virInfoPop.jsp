<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<!-- Main Container  -->
<!-- <div class="main-container container"> -->
	<!-- <div class="row"> -->
		<!--Middle Part Start-->
		<div id="content" class="col-sm-12">
			<div class="row">
				<div class="col-right col-sm-6">
					<div class="row">
						<div class="table-responsive form-group">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title">
										<i class="fa fa-credit-card"></i><label>&nbsp;가상계좌 정보</label>
									</h4>
								</div>
								<div class="panel-body">
									<div class="table-responsive">
										<table class="table table-bordered">
											<tr>
												<th scope="row">주문번호</th>
												<td>${lguplus.LGD_OID}</td>
											</tr>
											<tr>
												<th scope="row">입금할 금액</th>
												<td><label style="color:red;"><fmt:formatNumber value="${lguplus.LGD_AMOUNT}" pattern="#,###"/></label> 원</td>
												<th scope="row">입금기한</th>
												<td>${lguplus.LGD_CLOSEDATE}</td>
											</tr>
											<tr>
												<th scope="row">입금은행</th>
												<td>${lguplus.LGD_FINANCENAME}</td>
												<th scope="row">입금하실 계좌번호</th>
												<td>${lguplus.LGD_ACCOUNTNUM}</td>
											</tr>					
										</table>
									</div>
								</div>
							</div>
						</div>
						<!-- /.결제 정보 -->
						
						<div class="table-responsive form-group">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title">
										<i class="fa fa-truck"></i><label style="color:red;">&nbsp;주의사항</label>
									</h4>
								</div>
								<div class="panel-body">
									<div class="table-responsive">
										<table class="table table-bordered">
											<tbody>
												<tr>
													<td>
														<b>가상계좌는 일회성 계좌이므로 재사용시(다시 그 계좌로 입금하는 경우) <br>
														타인의 계좌로 입금될 가능성이 있습니다. <br>
														이 경우는 구매고객의 책임이므로 사용에 주의하시기 바랍니다.</b>
													</td>
												</tr>
												<tr>
													<td>
														<b>CD기에서 계좌이체는 가능하나 CD기에서 해당 계좌로 현금을 입금할 수는 없습니다. <br>
														(과오납이 허용되지 않을 수 있으니 CD기 이용은 지양해 주시기 바랍니다.)</b>
													</td>
												</tr>
										</table>
									</div>
								</div>
							</div>
						</div>
						<!-- /.배송지정보 -->
					</div>
				</div>
			</div>
		</div>
		<!--Middle Part End -->
	<!-- </div> -->
<!-- </div> -->
<!-- //Main Container -->
