<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<%@ taglib prefix="date" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	.templete_table{width:100%; margin:auto; text-align:center;}
	.templete_table tr{height:40px; border:1px solid #dedede;}
</style>

<section class="content-header">
	<h1>배송비 템플릿  <small>목록</small></h1>
</section>

<section class="content">
	<div style="display:flex; justify-content:flex-end;">
		<a href="${contextPath}/adm/productMgr/templete/new" id="saveTempleteBtn" class="btn btn-info btn-warning btn-hgt" style="margin-bottom:10px;">등록</a>&nbsp;&nbsp;
		<button type="button" id="delTempleteBtn" class="btn btn-info btn-primary btn-hgt" style="margin-bottom:10px;">삭제</button>
	</div>
	<div class="box box-primary">
		<!-- /.box-header -->
		<div class="box-body">
			<input type="hidden" id="TEMP_NUMS" name="TEMP_NUMS"/>
			<table class="templete_table">
				<colgroup>
					<col style="width:10%;">
					<col style="width:70%;">
					<col style="width:20%;">
				</colgroup>
				<tr style="font-weight:700; background:#dedede;">
					<td><input type="checkbox" onclick="selectAll();"/></td>
					<td>템플릿명</td>
					<td>등록 날짜</td>
				</tr>
				<!-- 
				<tr>
					<td colspan="4">설정 구간이 존재하지 않습니다</td>
				</tr>
				 -->
			 	<c:choose>
			 		<c:when test="${ !empty(tb_shiptexm.list) }">
			 			<c:forEach var="list" items="${ tb_shiptexm.list }" varStatus="loop">
			 				<tr>
			 					<td><input type="checkbox" name="TEMP_NUM" class="check_box" value="${ list.TEMP_NUM }"/></td>
			 					<td>
			 						<a href="${contextPath}/adm/productMgr/templete/edit?TEMP_NUM=${ list.TEMP_NUM }">${ list.TEMP_NAME }</a>
			 					</td>
			 					<!--<fmt:parseDate value="${ list.REG_DATE }" var="parseDate" pattern="yyyy-MM-dd"/>-->
			 					<td><fmt:formatDate value="${ list.REG_DATE }" pattern="yyyy-MM-dd"/></td>
			 				</tr>
			 			</c:forEach>
			 		</c:when>
			 		<c:otherwise>
			 			<tr>
			 				<td></td>
							<td>템플릿이 존재하지 않습니다</td>
							<td></td>
						</tr>
			 		</c:otherwise>
			 	</c:choose>
			</table>
		</div>
	</div>
</section>
<script type="text/javascript">
function selectAll(){
	$(".check_box").click();
}

$(function() {
	$("#delTempleteBtn").click(function() {
		var values = document.getElementsByName("TEMP_NUM");
		var arr = [];
		
		for(var i = 0; i < values.length; i++) {
			if(values[i].checked) {
				arr.push(values[i].value);
			}
		}
		
		$("#TEMP_NUMS").val(arr);
		var temp_num = $("#TEMP_NUMS").val();
		
		//템플릿 삭제
		$.ajax({
			type: "POST",
		    url: "${contextPath}/adm/productMgr/deleteTemplete",
		    data: { TEMP_NUM : temp_num },
		    success: function (data) {
		   		if(data == values.length) {
		   			alert("템플릿이 삭제되었습니다.");
		   			location.reload();
		   		} else {
		   			alert("템플릿 삭제 중 문제가 발생했습니다. 관리자에게 문의하세요.");
		   			location.reload();
		   		}
		    }, error: function (jqXHR, textStatus, errorThrown) {
		       alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
		    }
		});
	});
});
</script>