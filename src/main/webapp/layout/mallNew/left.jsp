<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<style type="text/css">
.category_list > li > p.title {
    /* font-weight: bold; */
    font-size: 13px;
    padding-left: 15px;
    margin: 0;
    /* background: url(../img/common/cate_dot.png) no-repeat left center; */
}

</style>
<script type="text/javascript">
<!--
/* Side Menu */
$(document).ready(function(){

	//탑 2차 지정
    <c:forEach items="${cagoList }" var="subMenu">
	    <c:if test="${subMenu.LVL eq '3'}">

	    $("#subMenuUl_${subMenu.UPCAGO_ID}").append("<li id='subMenuLi_${subMenu.CAGO_ID }' class='subLi'> <p class='title'><a style='color:rgb(121, 121, 121)' href='${contextPath }/product?CAGO_ID=${ subMenu.CAGO_ID }'>${subMenu.CAGO_NAME}</a></p></li>");

		</c:if>
		
	    <c:if test="${subMenu.LVL eq '4'}">
	
			if($("#subMenuLi_${subMenu.UPCAGO_ID} > dl").length < 1){
		    	$("#subMenuLi_${subMenu.UPCAGO_ID}").append("<dl></dl>");
			}
			$("#subMenuLi_${subMenu.UPCAGO_ID} > dl").append("<dd><a href='${contextPath }/product?CAGO_ID=${ subMenu.CAGO_ID }'>${subMenu.CAGO_NAME}</a></dd>");
		</c:if>
		
    </c:forEach>
    
    
	$(".subLi").each(function() {
		$(this).append("<hr>");

	});
	$(".subMenu").each(function() {
		var strId = $(this).attr("id");

		if($("#" + strId + " > div > ul > li").length < 1){
			var strCagoId = $(this).attr("cagoId");
			$("#link_"+strCagoId).attr("onmouseover", "");
		}
	});
	
	//ajax구현...
});
//-->
</script>


<div style="display:none;">
	<c:forEach var="ent" items="${ cagoList }" varStatus="status">
		<c:if test="${ent.LVL eq '2' }">
		<div id="subMenu_${ent.CAGO_ID }" class="subMenu" cagoId="${ent.CAGO_ID }">
			<div class="category">
	            <ul id="subMenuUl_${ent.CAGO_ID }" class="category_list">
				</ul>
			</div>
		</div>
		</c:if>
</c:forEach>
</div>
	
<div class="category mb_20">
	<img src="${contextPath}/resources/img/common/cate_title.png">
	<hr>
	<ul class="category_list">
		<c:forEach var="ent" items="${ cagoList }" varStatus="status">
			<c:if test="${ent.LVL eq '2' }">
			<li id="liCago_${ent.CAGO_ID }">
				<p class="title"><a id="link_${ent.CAGO_ID }" onmouseover="tooltip.pop(this, '#subMenu_${ent.CAGO_ID }');" href="${contextPath }/product?CAGO_ID=${ ent.CAGO_ID }">${ ent.CAGO_NAME }</a></p><!-- (${ ent.PRD_CNT }) -->
				<dl></dl>
				<hr>
			</li>
			</c:if>
		</c:forEach>
	</ul>
</div>
