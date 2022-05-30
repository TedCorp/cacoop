<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:if test="${ param.type eq 'select' }">
	<select name="${ param.name }" id="${ param.name }" class="form-control select" <c:if test="${ !empty(param.event) }">onChange="${ param.event }"</c:if> <c:if test="${ !empty(param.size) }">size="${ param.size }"</c:if> <c:if test="${ !empty(param.width) }">style="width:${ param.width }px;"</c:if> title="${ param.title }" est="${ param.est }" ${param.attr1} }>
		<c:if test="${ !empty(param.top) }">
			<option value="">${ param.top }</option>
		</c:if>
		<c:forEach var="ent" items="${ obj.list }" varStatus="status">
			<option value="${ ent.COMD_CODE }" <c:if test="${ param.value eq ent.COMD_CODE }">selected</c:if>>${ ent.COMDCD_NAME }</option>
		</c:forEach>
	</select>
</c:if>

<c:if test="${ param.type eq 'radio' }">
	<c:forEach var="ent" items="${ obj.list }" varStatus="status">
		<c:if test="${ent.COMD_CODE ne param.filter01}">
			<label class="check" style="margin-right:10px">
				<input type="${ param.type }" class="iradio" name="${ param.name }" value="${ ent.COMD_CODE }" <c:if test="${ param.value eq ent.COMD_CODE or (empty(param.value) and status.count eq 1) }">checked</c:if>/> 
				${ ent.COMDCD_NAME }
			</label>
		</c:if>	
    </c:forEach>
</c:if>

<c:if test="${ param.type eq 'radioOption' }">
	<label class="check" style="margin-right:10px">
		<input type="radio" class="iradio" name="${ param.name }" value="" <c:if test="${empty param.value}">checked</c:if>/>미사용
		 
	</label>
	<c:forEach var="ent" items="${ obj.list }" varStatus="status">
		<c:if test="${ent.COMD_CODE ne param.filter01}">
			<label class="check" style="margin-right:10px">
				<input type="radio" class="iradio" name="${ param.name }" value="${ ent.COMD_CODE }" <c:if test="${ param.value eq ent.COMD_CODE}">checked</c:if>/> 
				${ ent.COMDCD_NAME }
			</label>
		</c:if>	
    </c:forEach>
</c:if>

<c:if test="${ param.type eq 'text' }">
	${obj.COMDCD_NAME }
</c:if>
