<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>



<c:forEach items="${payResMap }" var="data" varStatus="loop">
	<c:out value="${data.value}" />
</c:forEach>
					

<div class="btn_area_right">  

	<button type="button" class="btn_type01" id="btnList">목록</button>
</div>

<spform:form id="listForm" name="listForm" method="GET" action="${contextPath}/resv/myResvList">
    <input type="hidden" name="menuId" value="${obj.menuId}" />
</spform:form>

<script type="text/javascript">

	$(function() {

		$("#btnList").click(function(){
			$("#listForm").submit();
		});
	});
	
</script>