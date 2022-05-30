<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<!doctype html>
<html lang="en">
 <head>
 	<!-- Basic page needs
    ============================================ -->
    <title>:::: 건설건축 협동조합 ::::</title>
    <meta charset="utf-8">
    <meta name="keywords" content="건설건축 협동조합" />

    <!-- Mobile specific metas
    ============================================ -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
	<!-- Google web fonts
	============================================ -->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>
    
	<!-- new Includes
	============================================ -->
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/swiper/dist/css/swiper.min.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/common.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/211021.css">	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/reset.css">
<%-- 	<script type="text/javascript" src="${contextPath}/resources/resources2/js/common.js"></script> --%>
<%-- 	<script type="text/javascript" src="${contextPath}/resources/resources2/swiper/dist/js/swiper.min.js"></script> --%>
	<style>
		th{text-align:center;}
		.order_table tbody tr td{text-align:left !important;}
	</style>
 </head>
 <body>
  	<div class="popup">
		<div class="title">배송조회</div>
		<div class="table">
			<table class="order_table">
				<colgroup>
					<col style="width:100px">
					<col>
				</colgroup>
				<tbody>
					<tr><th>주문번호</th><td>${ tb_odinfoxm.ORDER_NUM }</td></tr>
					<tr><th>주문일시</th><td>${ tb_odinfoxm.ORDER_DATE }</td></tr>
					<tr><th>주문자</th><td>${ tb_odinfoxm.MEMB_NM }</td></tr>
					<tr><th>주소</th><td>[${ tb_odinfoxm.POST_NUM }] ${ tb_odinfoxm.BASC_ADDR } &nbsp; ${ tb_odinfoxm.DTL_ADDR }</td></tr>
				</tbody>
			</table>
		</div>
		<div class="table">
			<table>
				<colgroup>
					<col style="width:5%">
					<col style="width:15%">
					<col style="width:35%">
					<col style="width:10%">
					<col style="width:10%">
					<col style="width:10%">
					<col style="width:15%">
				</colgroup>
				<thead>
					<tr>
						<th>no.</th>
						<th>상품코드</th>
						<th>상품명</th>
						<th>수량</th>
						<th>배송상태</th>
						<th>택배사</th>
						<th>송장번호</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
					<c:when test="${ !empty(tb_odinfoxd.list) }">
						<c:forEach items="${tb_odinfoxd.list}" var="list" varStatus="loop">
						<tr>
							<td>${ loop.count }</td>
							<td>${ list.PD_CODE }</td>
							<td>${ list.PD_NAME }</td>
							<td>${ list.ORDER_QTY }</td>
							<td>${ list.ORDER_CON_NM }</td>
							<td>${ list.DLVY_COM_NAME }</td>
							<td>${ list.DLVY_TDN }</td>
						</tr>
							</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="7">배송조회가 가능한 상품이 없습니다</td>
						</tr>
					</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div> <!-- popup -->
 </body>
 <script>
function refundBtn() {
	var PD_CODES = $("#PD_CODES").val();
	var arr = PD_CODES.split(",");
	var length = arr.length;
	var chkYn = 0;
	
	if($("#allChk").val() == "Y") {
	 chkYn = 1;
	}
	
	var total = length + chkYn + "";
	
	$.ajax({
		type: "POST",
		url: "${contextPath}/m/order/updateOrder",
		data: $("#refundFrm").serialize(),
		success: function (data) {
			if(data == total) {
				alert("반품 접수가 완료되었습니다.");
				window.close();
				opener.location.reload();
			} else {
				alert("반품 접수 중 문제가 발생했습니다. 관리자에게 문의하세요.");
				window.close();
				opener.location.reload();
			}
		}, error: function (jqXHR, textStatus, errorThrown) {
			alert("처리중 에러가 발생했습니다. 관리자에게 문의하세요.(error:"+textStatus+")");
		}
	});
}
 </script>
</html>