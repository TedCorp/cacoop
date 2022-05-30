<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="mall.web.domain.*" %>
<%
	Date nowTime = new Date();
	DateFormat date = new SimpleDateFormat("yyyy-MM-dd");
	TB_ODINFOXM obj = (TB_ODINFOXM)request.getAttribute("obj");
	DefaultDomain dd = (DefaultDomain)request.getAttribute("domain");
     
	Calendar cal1 = Calendar.getInstance();
	cal1.setTime(new Date());
	cal1.add(Calendar.DATE, -7);
	
	Calendar cal2 = Calendar.getInstance();
	cal2.setTime(new Date());
	cal2.add(Calendar.DATE, -15);
	
	Calendar cal3 = Calendar.getInstance();
	cal3.setTime(new Date());
	cal3.add(Calendar.DATE, -30);
%>

<c:set var="strActionUrl" value="${contextPath }/m/wishList" />
<c:set var="strMethod" value="post" />
<!doctype html>
<html>
<head>
	<!-- jquery UI CSS파일 -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- jquery 기본 JS파일 -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<!-- jquery UI 라이브러리 JS파일 -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<%-- <script src="${contextPath}/resources/adminlte/plugins/datepicker/datepicker3.css"></script> --%>
	<style>
		#orderDetail{ width: 57px; height: 24px; font-size: 16px; color: #26c165; text-decoration: underline; background: #fff; }
	</style>
</head>
<body>
	<div class="container">
		<div class="page-mypage">
			<div class="mypage-aside">
				<div class="tit">나의 쇼핑 정보</div>
				<div class="txt">
					<ul>
						<li><a href="${contextPath}/m/order/wishList">주문/배송 조회</a></li>
						<li class="on"><a href="${contextPath}/m/order/exchange">환불/반품 조회</a></li>
						<li><a href="${contextPath}/m/mypage/review">상품리뷰</a></li>
						<li><a href="${contextPath}/m/mypage/info">개인정보변경</a></li>
						<li><a href="${contextPath}/m/unregister">회원탈퇴</a></li>
					</ul>
				</div>
			</div>
			<div class="mypage-content">
				<div class="mypage-order-exchange">
					<div class="mypage-title">환불 반품 조회</div>
					<div class="mypage-sort">
						<spform:form class="form-horizontal" name="dateFrm" id="dateFrm" method="get" action="${contextPath }/m/order/exchange">
							<dl style="margin-bottom:0px; text-align: center;">조회기간</dl>
							<dd>
								<a class="7days" href="${contextPath }/m/order/exchange?datepickerStr=<%= date.format(cal1.getTime()) %>&datepickerEnd=<%= date.format(nowTime) %>">7일</a>
								<a class="15days" href="${contextPath }/m/order/exchange?datepickerStr=<%= date.format(cal2.getTime()) %>&datepickerEnd=<%= date.format(nowTime) %>">15일</a>
								<a class="30days" href="${contextPath }/m/order/exchange?datepickerStr=<%= date.format(cal3.getTime()) %>&datepickerEnd=<%= date.format(nowTime) %>">30일</a>
							</dd>
							<dd>
								<input type="text" readonly="readonly" name="datepickerStr" id="datepickerStr" class="datepicker" value="${obj.datepickerStr}" 
																													placeholder="<%= date.format(nowTime) %>">
								<span>~</span>
								<input type="text" readonly="readonly" name="datepickerEnd" id="datepickerEnd" class=" datepicker" value="${obj.datepickerEnd}"
																													placeholder="<%= date.format(nowTime) %>">
							</dd>
							<dd><button type="submit">조회</button></dd>
						</spform:form>
					</div>
					<div class="mypage-table">
						<table>
							<colgroup>
								<col width="160px">
								<col>
								<col width="110px">
								<col width="120px">
							</colgroup>
							<thead>
								<tr>
									<th>주문일</th>
									<th>주문내역</th>
									<th>환불상태</th>
									<th>주문관리</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
								<c:when test="${!empty(obj.list)}">
									 <c:forEach items="${obj.list}" var="list" varStatus="loop">
									 <c:set var="imgPath" value="${contextPath}/common/commonImgFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=${list.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
											<tr>
												<td class="date">
												<form method="post" action="${contextPath}/m/order/refund/${list.ORDER_NUM}">
													<input type="hidden" name="PD_CODE" value="${list.PD_CODE}"/>
													<input type="hidden" name="ORDER_NUM" value="${list.ORDER_NUM}"/>
												${list.ORDER_DATE}<br>[${list.ORDER_NUM}]<br> <button id="orderDetail">주문상세</button>
												</form>
												</td>
												<td class="goods">
													<div class="flex">
														<img src="${imgPath}" alt="">&nbsp;&nbsp;&nbsp;
														<a href="${contextPath}/m/product/view/${list.PD_CODE}" style="color:#333; font-size:14px; text-decoration:none;">
															<strong>${list.PD_NAME}</strong>
														</a>
													</div>
												</td>
												<td class="state">${list.RFND_CON}</td>
												<td class="manage"></td>
											</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr id ="tst">
										<td colspan="4">환불/반품 내역이 없습니다</td>
									</tr>
								</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
					<div class="mypage-paging">
						<ul>
							<!-- 페이징  -->
				           <paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
								<First><Previous><AllPageLink><Next><Last>
							</paging:PageFooter>        
				            <!-- 페이징 END -->
						</ul>
					</div>
				</div>
				<div class="mypage-order-step">
					<div class="mypage-title"><small>반품 교환 현황 단계</small></div>
					<div class="mypage-step">
						<ul>
							<li>
								<div class="box">
									<i><img src="${contextPath}/resources/resources2/images/order_exchange_step1.png" alt=""></i>
									<strong>STEP. 1</strong>
									<span>신청</span>
								</div>
							</li>
							<li>
								<div class="box">
									<i><img src="${contextPath}/resources/resources2/images/order_exchange_step2.png" alt=""></i>
									<strong>STEP. 2</strong>
									<span>접수</span>
								</div>
							</li>
							<li>
								<div class="box">
									<i><img src="${contextPath}/resources/resources2/images/order_exchange_step3.png" alt=""></i>
									<strong>STEP. 3</strong>
									<span>처리중</span>
								</div>
							</li>
							<li>
								<div class="box">
									<i><img src="${contextPath}/resources/resources2/images/order_exchange_step4.png" alt=""></i>
									<strong>STEP. 4</strong>
									<span>처리완료</span>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
 <script>
 $(function() {
		//Date picker
		$('#datepickerStr').datepicker({
			autoclose: true,
			format: 'yy-mm-dd'
		});
		$('#datepickerEnd').datepicker({
			autoclose: true,
			format: 'yy-mm-dd'
		});	
		
		$.datepicker.setDefaults({
	        dateFormat: 'yy-mm-dd',
	        prevText: '이전 달',
	        nextText: '다음 달',
	        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	        showMonthAfterYear: true,
	        yearSuffix: '년'
	    });
	 });
 </script>
</body>
</html>
