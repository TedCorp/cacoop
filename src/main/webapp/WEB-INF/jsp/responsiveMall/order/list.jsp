<%--<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<c:set var="strActionUrl" value="${contextPath }/m/wishList" />
<c:set var="strMethod" value="post" />

<script type="text/javascript">
$(function() {		
	$(".btnDeliveryView").click(function(){
		var url="${contextPath }/m/order/dlvyChk/"+this.value;
        window.open(url,"","width=900, height=400, left=600");
	});
	
	//전체선택 체크박스 클릭 
	$("#CHK_ALL").click(function(){ //만약 전체 선택 체크박스가 체크된상태일경우 
		if($("#CHK_ALL").prop("checked")) { //해당화면에 전체 checkbox들을 체크해준다 
			$("input[type=checkbox]").prop("checked",true); // 전체선택 체크박스가 해제된 경우 
		} else { //해당화면에 모든 checkbox들의 체크를해제시킨다. 
			$("input[type=checkbox]").prop("checked",false); 
		} 
	});

});

function chk_delete(){
	var checkboxValues = [];
	
	//each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
	$("input:checkbox[name=CHK_WISH]:checked").each(function(){
		checkboxValues.push($(this).val());
		//checkboxValues += $(this).val()+":";
	});
	if(checkboxValues==''||checkboxValues==null){
		checkboxValues.push("");			
		alert("삭제할 주문내역을 선택해 주세요.");
		return;
	}
	var allData = { "checkArray": checkboxValues };
	
	if (confirm('선택한 결제전 상태의 주문내역이 사라집니다.\n삭제하시겠습니까?')) {
        // Yes click
		$.ajax({
		    type: 'GET',
		    data: allData,
		    url: '${contextPath }/m/order/updateDelete',
		    success: function (data) {   	
		    	 location.reload();
		    },
		    error:function(request,status,error){
		         console.log('error : '+error+"\n"+"code : "+request.status+"\n");
		    }
		});
   } else {
       // no click
       return;
	}
}

function post_to_url(path, params, method) {
	method = method || "post"; // Set method to post by default, if not specified.
	// The rest of this code assumes you are not using a library.
	// It can be made less wordy if you use one.
	var form = document.createElement("form");
	form.setAttribute("method", method);
	form.setAttribute("action", path);
	for(var key in params) {
		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		
		hiddenField.setAttribute("name", key);
		hiddenField.setAttribute("value", params[key]);
		alert(params[key]);
		form.appendChild(hiddenField);
	}
	document.body.appendChild(form);
	form.submit();
}
</script>


<!-- Main Container  -->
<div class="main-container container">
	<ul class="breadcrumb">
		<li><a href="${contextPath }/m"><i class="fa fa-home"></i></a></li>
		<li><a href="${contextPath }/m/order/wishList">주문배송조회</a></li>
	</ul>

	<div class="row">
		<!--Middle Part Start-->
		<div id="content" class="col-sm-12">
			<h2 class="title">주문내역<small class="ml_5"> | 주문상태, 배송상태 등 주문내역을 조회합니다.</small></h2>
			<div class="table-responsive form-group">
				<table class="table table-bordered">
					<thead>
						<tr>
							<td class="text-center"><input type="checkbox" id="CHK_ALL" name="CHK_ALL"/></td>
							<td class="text-center">번호</td>
							<!-- <td class="text-center">주문일자</td> -->
							<td class="text-center">상품명</td>
							<td class="text-center">결제금액</td>
							<td class="text-center">주문상태</td>
							<td class="text-center">배송조회</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${obj.list }" var="list" varStatus="loop">
						<tr>
							<td class="text-center">
								<c:if test="${list.ORDER_CON eq 'ORDER_CON_01'}">
									<input type="checkbox" id="CHK${loop.count }" name="CHK_WISH" value="${list.ORDER_NUM }"/>
								</c:if>
							</td>
							<td class="text-center">
								<input type="hidden" name="PD_CODE" value="${list.ORDER_NUM }">
								<a href="${contextPath}/m/order/view/${list.ORDER_NUM }"><b>${list.ORDER_NUM }</b></a>
							</td>
							<td class="text-center">${list.ORDER_DATE }</td>
							<td class="text-left">
								<a href="${contextPath}/m/order/view/${list.ORDER_NUM }"><b>${list.PD_NAME }
								<c:if test="${list.count > 0 }">
									&nbsp; 외 ${list.count}&nbsp;종
								</c:if>
								</b></a>
							</td>
							<td class=text-right>
								<fmt:formatNumber value="${list.ORDER_AMT }" />원<br>
								<fmt:parseNumber var="pv_round" value="${ ((list.ORDER_AMT - list.DLVY_AMT) * PV) / 10 }" integerOnly="true" />
								<fmt:parseNumber var="pv_amt" value="${ pv_round * 10 }" integerOnly="true" />
								PV ${ pv_amt }
							</td>
							<td class="text-center">
								<c:choose>
									<c:when test="${list.ORDER_CON eq 'ORDER_CON_11'}">
										${list.RFND_CON }
									</c:when>
									<c:otherwise>
										${list.ORDER_CON_NM }
									</c:otherwise>                                            		
								</c:choose>
							</td>
							<td class="text-center">
								<c:if test="${list.ORDER_CON ne 'ORDER_CON_01' and list.ORDER_CON ne 'ORDER_CON_04' and list.ORDER_CON ne 'ORDER_CON_07'}">
									<button type="button" class="btn btn-xs btn-default btnDeliveryView" value="${list.ORDER_NUM }">조회</button>
								</c:if>
							</td>
						</tr>
							<tr>
								<td colspan="6">조회된 주문내역이 없습니다.</td>
							</tr>
					</tbody>
				</table>
			</div>

			<div class="buttons">
				<div class="pull-right">
					<button type="button" onclick="chk_delete();" class="btn btn-danger pull-right" style="margin-right:5px;">선택 삭제</button>
				</div>
			</div>
		</div>
		<!--Middle Part End -->
	</div>
</div>
<!-- //Main Container -->

<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
	<input type="hidden" id="BSKT_REGNO_LIST" name="BSKT_REGNO_LIST" value="" /><!-- 상태 변경 체크 항목 -->
	<input type="hidden" id="BSKT_REGNO" name="BSKT_REGNO" value="" /><!-- 선택 장바구니 등록번호-->
	<input type="hidden" id="STATE_GUBUN" name="STATE_GUBUN" value="" /><!-- 산태 변경 구분 - 장바구니이동인지 삭제인지 -->
	<input type="hidden" id="PD_CUT_SEQ_LIST" name="PD_CUT_SEQ_LIST" value="" /><!-- 산태 변경 구분 - 장바구니이동인지 삭제인지 -->
	<input type="hidden" id="OPTION_CODE_LIST" name="OPTION_CODE_LIST" value="" /><!-- 산태 변경 구분 - 장바구니이동인지 삭제인지 -->
</spform:form>
 --%>
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
	<style type="text/css">
		.delivery-btn{margin:5px 0 5px 0;}
	</style>
</head>
<body>
	<div class="container">
		<div class="page-mypage">
			<div class="mypage-aside">
				<div class="tit">나의 쇼핑 정보</div>
				<div class="txt">
					<ul>
						<li class="on"><a href="${contextPath}/m/order/wishList">주문/배송 조회</a></li>
						<li><a href="${contextPath}/m/order/exchange">환불/반품 조회</a></li>
						<li><a href="${contextPath}/m/mypage/review">상품리뷰</a></li>
						<li><a href="${contextPath}/m/mypage/info">개인정보변경</a></li>
						<li><a href="${contextPath}/m/unregister">회원탈퇴</a></li>
					</ul>
				</div>
			</div>
			<div class="mypage-content">
				<div class="mypage-order-delivery">
					<div class="mypage-title">주문배송 조회</div>
					<div class="mypage-sort">
						<spform:form class="form-horizontal" name="dateFrm" id="dateFrm" method="get" action="${contextPath }/m/order/wishList">
							<dl style="margin-bottom:0px; text-align: center;">조회기간</dl>
							<dd>
								<a class="7days" href="${contextPath }/m/order/wishList?datepickerStr=<%= date.format(cal1.getTime()) %>&datepickerEnd=<%= date.format(nowTime) %>">7일</a>
								<a class="15days" href="${contextPath }/m/order/wishList?datepickerStr=<%= date.format(cal2.getTime()) %>&datepickerEnd=<%= date.format(nowTime) %>">15일</a>
								<a class="30days" href="${contextPath }/m/order/wishList?datepickerStr=<%= date.format(cal3.getTime()) %>&datepickerEnd=<%= date.format(nowTime) %>">30일</a>
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
									<th>주문상태</th>
									<th>주문관리</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
								<c:when test="${!empty(obj.list)}">
									<c:forEach items="${obj.list}" var="list" varStatus="loop">
									<c:set var="imgPath" value="${contextPath}/common/commonImgFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=${list.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
										<tr>
											<td class="date">${list.ORDER_DATE}<br>[${list.ORDER_NUM}]<br> <a href="${contextPath}/m/order/detail/${list.ORDER_NUM}">주문상세</a></td>
											<td class="goods">
												<div class="flex">
													<img src="${list.IMGURL}" alt="">&nbsp;&nbsp;&nbsp;
													<a href="${contextPath}/m/product/view/${list.PD_CODE}" style="color:#333; font-size:14px; text-decoration:none;">
														<strong>${list.PD_NAME}</strong>
														<c:if test="${ list.CNT ne 0}">
														<strong>외&nbsp;${list.CNT}개</strong>
														</c:if>
													</a>
												</div>
											</td>
											<td class="state">${list.ORDER_CON_NM}</td>
											<td class="manage">
												<!-- 임시 문구 -->
												<c:choose>
												<c:when test="${list.ORDER_CON_NM eq '결제전' || list.ORDER_CON_NM eq '결제완료' || list.ORDER_CON_NM eq '배송준비중'}">
													<!--<button type="button" class="order-cancel manage-btn" onclick="orderCancel('${list.ORDER_NUM}', '주문취소');">주문취소</button>-->
													<a href="${contextPath}/m/order/detail/${list.ORDER_NUM}?CANCEL=y" class="manage-btn">주문 취소</a>
												</c:when>
												<c:when test="${list.ORDER_CON_NM eq '배송중'}">
													<button type="button" class="manage-btn" onclick="fn_popup('${list.ORDER_NUM}');">배송조회</button>
												</c:when>
												<c:when test="${list.ORDER_CON_NM eq '배송완료'}">
													<a href="${contextPath}/m/order/detail/${list.ORDER_NUM}?CONFIRM=y" class="manage-btn delivery-btn">구매 확정</a>
													<%-- <button type="button" class="order-confirm manage-btn delivery-btn" onclick="orderConfirm('${list.ORDER_NUM}');">구매확정</button> --%>
													<a href="${contextPath}/m/order/detail/${list.ORDER_NUM}?REFUND=y" class="manage-btn delivery-btn">반품 신청</a>
												</c:when>
												<c:otherwise>
													<div><fmt:formatDate value="${list.MOD_DTM}" pattern="yyyy-MM-dd"/></div>
												</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr id ="tst">
										<td colspan="4">주문내역이 없습니다</td>
									</tr>
								</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
					<div class="mypage-paging">
						<ul>
							<%-- <c:choose>
							<c:when test="${obj.list.pageNum == 1}">
								<li class="start"><a href="#"><i class="ic"></i></a></li>
							</c:when>
							<c:otherwise>
								<li class="start"><a href="#"><i class="ic"></i></a></li>
							</c:otherwise>
							</c:choose>
							
							<c:choose>
							<c:when test="${obj.list.pageNum == 1}">
								<li class="prev"><a href="#"><i class="ic"></i></a></li>
							</c:when>
							<c:otherwise>
								<li class="prev"><a href="#"><i class="ic"></i></a></li>
							</c:otherwise>
							</c:choose>
							
							<c:forEach items="${obj.list}" begin="0" end="${((obj.count /3)+0.9)*10/10}" var="list" varStatus="loop">
								<li><a href="#">${loop.current}-------${((obj.count /3)+0.9)*10/10}</a></li>
							</c:forEach>
							
							<c:choose>
							<c:when test="${obj.list.pageNum == obj.list.pagerMaxIndexPages}">
								<li class="next"><a href="#"><i class="ic"></i></a></li>
							</c:when>
							<c:otherwise>
								<li class="next"><a href="#"><i class="ic"></i></a></li>
							</c:otherwise>
							</c:choose>
							
							<c:choose>
							<c:when test="${obj.list.pageNum == obj.list.pagerMaxIndexPages}">
								<li class="end"><a href="#"><i class="ic"></i></a></li>
							</c:when>
							<c:otherwise>
								<li class="end"><a href="#"><i class="ic"></i></a></li>
							</c:otherwise>
							</c:choose> --%>
							<%-- <c:forEach begin="${startPage}" end="${endPage}" var="i" varStatus="loop">
								<li><a href="${contextPath}/m/order/wishList?pageNum=${i}">${i}</a></li>
							</c:forEach> --%>
							<!-- 페이징  -->
				           <paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
								<First><Previous><AllPageLink><Next><Last>
							</paging:PageFooter>        
				            <!-- 페이징 END -->
						</ul>
					</div>
				</div>
				<div class="mypage-order-step">
					<div class="mypage-title"><small>주문현황단계</small></div>
					<div class="mypage-step">
						<ul>
							<li>
								<div class="box">
									<i><img src="${contextPath}/resources/resources2/images/order_step1.png" alt=""></i>
									<strong>STEP. 1</strong>
									<span>주문접수</span>
								</div>
							</li>
							<li>
								<div class="box">
									<i><img src="${contextPath}/resources/resources2/images/order_step2.png" alt=""></i>
									<strong>STEP. 2</strong>
									<span>결제완료</span>
								</div>
							</li>
							<li>
								<div class="box">
									<i><img src="${contextPath}/resources/resources2/images/order_step3.png" alt=""></i>
									<strong>STEP. 3</strong>
									<span>배송준비</span>
								</div>
							</li>
							<li>
								<div class="box">
									<i><img src="${contextPath}/resources/resources2/images/order_step5.png" alt=""></i>
									<strong>STEP. 4</strong>
									<span>배송중</span>
								</div>
							</li>
							<li>
								<div class="box">
									<i><img src="${contextPath}/resources/resources2/images/order_step6.png" alt=""></i>
									<strong>STEP. 5</strong>
									<span>배송완료</span>
								</div>
							</li>
							<li>
								<div class="box">
									<i><img src="${contextPath}/resources/resources2/images/order_step6.png" alt=""></i>
									<strong>STEP. 6</strong>
									<span>구매확정</span>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 모달창 -->
  <div class='layer-popup confrim-type'>
		<div class='popup' style="max-width: 350px;">
			<button type='button' class='btn-pop-close popClose'data-focus='pop' data-focus-prev='popBtn01'>X</button>
			<div class='pop-conts' style='padding:60px 30px 45px 30px;'>
				<div class='casa-msg'></div>
			</div>
		 	<div class='pop-bottom-btn type02'>
		 		<button type='button' data-focus='popBtn02' data-focus-next='pop' class='btn-pop-next'>확인</button>
		 		<button type='button' data-focus='popBtn01' data-focus-next='pop' class='btn-pop-prev'>취소</button>
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
	
	 function dateWeek(a) {
		 var date = new Date();
		 var year = date.getFullYear();
	     var month = date.getMonth() + 1;    //1월이 0으로 되기때문에 +1을 함.
	     var day = date.getDate();
		 
		 var preDate = new Date();
		 
		 if(a == '7') {
			 preDate.setDate(day - 7);
		 } else if(a = '15') {
			 preDate.setDate(day - 15);
		 } else if(a = '30'){
			 preDate.setDate(day - 30);
		 }
		 
		 var preYear = preDate.getFullYear();
	     var preMonth = preDate.getMonth() + 1;    //1월이 0으로 되기때문에 +1을 함.
	     var preDay = preDate.getDate();
		 
		 month = month >= 10 ? month : "0" + month;
	     day  = day  >= 10 ? day : "0" + day;
	     preMonth = preMonth >= 10 ? preMonth : "0" + preMonth;
	     preDay  = preDay  >= 10 ? preDay : "0" + preDay;
	     
	     $('#datepickerStr').val('' + preYear + preMonth + preDay);
	     $('#datepickerEnd').val('' + year + month + day);
	     console.log("처음날짜 : " + $('#datepickerEnd').val());
	     console.log("끝날짜 : " + $('#datepickerEnd').val());
	 }
	 
	 $('.order-cancel').on("click", function() {
		 $('.layer-popup').addClass('on');
		 $('.casa-msg').html("주문을 취소하시겠습니까?");
	 });
	 
	 $('.order-confirm').on("click", function() {
		 $('.layer-popup').addClass('on');
		 $('.casa-msg').html("구매를 확정하시겠습니까?");
	 });
	 
	 $('.btn-pop-prev').click(function() {
		 $(".layer-popup").removeClass("on");
	 });
	 
	 $('.btn-pop-next').click(function() {
		 $(".layer-popup").removeClass("on");
		 /*
		 orderNum = $("#ORDER_NUM").val();
		 orderCon = $("#ORDER_CON").val();
		 name = $("#ORDER_CON_NM").val();
		 
		 $.ajax({
			type: "POST",
			url: "${contextPath}/m/order/orderUpdate",
			data: "ORDER_NUM="+ orderNum + "&ORDER_CON="+ orderCon,
			success: function (data) {
				if(data == '2') {
					alert(name + " 정상적으로 처리되었습니다.");
				} else {
					alert("요청을 처리하는 데 문제가 생겼습니다. 관리자에게 문의 하세요");
				}
			}, error: function (jqXHR, textStatus, errorThrown) {
				alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
			}
		});
		 location.href = "${contextPath}/m/order/wishList";
		 */
	 });
 });
 
 /* 주문 취소 */
 /*
 function orderCancel(num, text) {
	 $('.btn-pop-next').click(function() {
		 $(".layer-popup").removeClass("on");
		 
		 $.ajax({
			type: "POST",
			url: "${contextPath}/m/order/orderUpdate",
			data: "ORDER_NUM="+ num + "&ORDER_CON=ORDER_CON_04",
			success: function (data) {
				if(data == "2") {
					alert("주문취소가 정상적으로 처리되었습니다.");
					location.href = "${contextPath}/m/order/wishList";
				} else {
					alert("주문취소를 처리하는 데 문제가 생겼습니다. 관리자에게 문의 하세요");
				}
			}, error: function (jqXHR, textStatus, errorThrown) {
				alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
			}
		});
	 });
 }
 */
 
 function fn_popup(num){
	 window.open("${contextPath}/m/order/deliveryPopup?order_num=" + num, "_blank", "width=800,height=400");
 }
 </script>
</body>
</html>					