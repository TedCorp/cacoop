<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${contextPath }/resources/js/jquery-barcode-2.0.2.min.js"></script>

<section class="content-header">
	<h1>
		일정관리	
		<small>일정관리</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<script type="text/javascript">
// 달력의 월 변경
function moveMonth(moveGbn){
	var formMap = {
            "moveGbn":moveGbn,
            "setMonth":${monthStn},
            "setYear":${year} };
	
	cusFormNew("${contextPath }/adm/calendarMgr/list", formMap);
}

function detail(date){
	
	if(date.length==1)
		date = "0"+date;
	
	var selDate = "${year}-${monthStn}-"+date;
	var formMap = { "CAL_DATE":selDate};
	
	cusFormNew("${contextPath }/adm/calendarMgr/view", formMap);
	
}
</script>

<html lang="ko">

<HEAD>
   <TITLE>캘린더</TITLE>

   <meta http-equiv="content-type" content="text/html; charset=utf-8">
   <script type="text/javaScript" language="javascript"> 
   </script>

   <style TYPE="text/css">
        
         .box_type01.schedul {position:relative;}
		.box_type01.schedul .apply_info {position:absolute;left:500px;top:0;padding:40px 0 0 0;}
		
		.schedul_wrap {padding:58px 30px 30px;text-align:left;}
		.schedul_month {position:relative;width:282px;height:36px;margin-left:88px;text-align:center;}
		.schedul_month strong {font-family:'NanumSquare';font-weight:700;font-size:30px;color:#245610;height:36px;}
		.schedul_month a {display:block;width:36px;position:absolute;bottom:0;font-size:30px;color:#245610;line-height:0;height:36px;}
		.schedul_month a.prev {left:0;}
		.schedul_month a.next {right:0;}
		
		.schedul_wrap .schedul_calendar {width:100%;margin:58px 0 0 0;border-top:2px solid #a6a9ab;}
		.schedul_wrap .schedul_calendar thead th {height:49px;padding:0;background:#ccc;border-left:1px solid #e6e6e6;border-bottom:1px solid #e6e6e6;font-family:'NanumSquare';font-size:18px;font-weight:400;text-align:center;}
		.schedul_wrap .schedul_calendar thead th:first-child {color:#ef3116;}
		.schedul_wrap .schedul_calendar tbody td {height:80px;padding:0;background:#fff;border-left:1px solid #e6e6e6;border-bottom:1px solid #e6e6e6;font-size:16px;}
		.schedul_wrap .schedul_calendar th:first-child, 
		.schedul_wrap .schedul_calendar td:first-child {border-left:0;}
		.schedul_wrap .schedul_calendar td div {position:relative;height:100%;font-weight:400;}
		.schedul_wrap .schedul_calendar td div span {display:block;padding:5px 0 0 14px;}
		.schedul_wrap .schedul_calendar .schedul {position:absolute;right:19px;top:10px;width:60px;height:60px;padding:0;font-size:0;line-height:0;}
		.schedul_wrap .schedul_calendar.buy {width:854px;margin:0 auto;}
		.schedul_wrap .schedul_calendar.buy tbody th {height:49px;padding:0;background:#ccc;border-left:1px solid #e6e6e6;border-bottom:1px solid #e6e6e6;font-family:'NanumSquare';font-size:18px;font-weight:400;text-align:center;}

   </style>
</HEAD>
<BODY>

<div class="apply_wrap">
	<div class="box_type01 schedul">	
	<div class="schedul_wrap">
		<p class="schedul_month">
		    <strong onclick="javascript:moveMonth('0')" style="left:0;margin-right: 10px;cursor:pointer;"><</strong>
		    <strong>${year }년 ${monthStn }월</strong>
		    <strong onclick="javascript:moveMonth('1')" style="right:0;margin-left: 10px;cursor:pointer;">></strong>
		</p>
		<table class="schedul_calendar">
		<caption></caption>
		<colgroup>
		    <col style="width:134px;">
		    <col style="width:134px;">
		    <col style="width:134px;">
		    <col style="width:134px;">
		    <col style="width:134px;">
		    <col style="width:135px;">
		    <col style="width:135px;">
		</colgroup>
		<thead>
		    <tr>
		        <th>일</th>
		        <th>월</th>
		        <th>화</th>
		        <th>수</th>
		        <th>목</th>
		        <th>금</th>
		        <th>토</th>
		    </tr>
		</thead>
		<tbody>
		    <c:forEach var="i" begin="1" end="${end }" step="1">
		    <c:if test="${(i-1)%7==0 }"><tr></c:if>
			<td>
	            <div onclick="javascript:detail('${i-start}')"<c:if test = '${start+0 <i }'>style="cursor: pointer;"</c:if>>
	                <c:if test = '${start >= i }'>
		                 <span></span>
		                 <span class="schedul"></span>
		             </c:if>
	
		             <c:if test = '${start+0 <i }'>
		              	<!-- 날짜 표시 -->
		                 <span>${i-start}</span>		
		                 <c:if test='${compChk[i] =="Y" }'>
		                 	<span><strong style="color: #B7F0B1">일정이 있습니다.</strong></span>
		                 </c:if>
		             </c:if>
		         </div>
		     </td>
	    <c:if test="${(i-1)%7==6 }"></tr></c:if>
		</c:forEach>
	    </tbody>
	    </table>
	
	</div>
</div>
</div>

</BODY>
</HTML>