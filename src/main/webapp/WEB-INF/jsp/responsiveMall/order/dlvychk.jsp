<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet" type="text/css">

<style>
* {
	font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
	color: #666;
    font-size: 14px;
}
.main-box {
	margin: 20px;
}
.main-box table {
	border: 1px solid #ddd;
	border-collapse: collapse;
	width:100%;
	margin-top:10px;
	text-align:center;
}

.main-box table th {
	background-color: rgba(51, 51, 51, 0.1);
	text-align:center;
	border: 1px solid #ddd;
	border-collapse: collapse;
	text-align:center;
	padding: 6px;
}
.main-box table td {
	border: 1px solid #ddd;
	border-collapse: collapse;
	text-align:center;
	padding: 6px;
}

.main-box table.typeA th { width: 20%; }
.main-box table.typeA td { width: 80%; }

.link:hover{color: #00a8e2;}
</style>

<!-- Main Container  -->
<div class="main-box">
	<b>배송조회</b>	
	<table class="typeA">
		<tr>
			<th>주문번호</th>
			<td>${info.ORDER_NUM}</td>
		</tr>
		<tr>
			<th>주문일시</th>
			<td>${info.ORDER_DATE}</td>
		</tr>
		<tr>
			<th>주문자</th>
			<td>${info.RECV_PERS}</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${info.BASC_ADDR} ${info.DTL_ADDR}</td>
		</tr>
	</table>
	
	<table class="typeB">
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
			<c:forEach items="${list}" var="list" varStatus="loop">
				<tr>
					<td>${loop.count}</td>
					<td>${list.PD_CODE}</td>
					<td>${list.PD_NAME}</td>
					<td>${list.ORDER_QTY}</td>
					<td>${list.ORDER_CON}</td>
					<td>${list.DLVY_COM}</td>
					<td>
						<c:set var="parcel" value="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=" />
						<a href="${parcel}${list.DLVY_TDN}" class="link">${list.DLVY_TDN}</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>