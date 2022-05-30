<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- cago_gubun -->
<c:if test="${schCagoGubun == 'schCago02'}">
<select name="schCago02" id="schCago02" class="form-control select2" style="width: 100%;" onchange="javascript:fn_cago_change('schCago03');">
	<option value="">2단계 분류</option>
</c:if>
<c:if test="${schCagoGubun == 'schCago03'}">
<select name="schCago03" id="schCago03" class="form-control select2" style="width: 100%;" onchange="javascript:fn_cago_change('schCago04');">
	<option value="">3단계 분류</option>
</c:if>
<c:if test="${schCagoGubun == 'schCago04'}">
<select name="schCago04" id="schCago04" class="form-control select2" style="width: 100%;">
	<option value="">4단계 분류</option>
</c:if>

	<c:forEach items="${cago_list.list }" var="list" varStatus="loop">
		<option value="${list.CAGO_ID }">${list.CAGO_NAME }</option>
	</c:forEach>
</select>