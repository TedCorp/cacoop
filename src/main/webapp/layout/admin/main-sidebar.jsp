<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">

		<!-- Sidebar Menu -->
		<ul class="sidebar-menu">
			<li class="header">메 뉴 목 록</li>
			<c:forEach items="${MENU_LIST }" var="ent">
				<c:if test="${ent.LVL eq '1'}">
					<c:set var="strCSS" value="${ent.MENU_CSS eq null ? 'fa-circle-o' : ent.MENU_CSS }" />
					<li class="treeview" id="menu_${ent.MENU_CD}">
						<a href="${contextPath}${ent.MENU_URL}"><i class="fa ${strCSS }"></i><span>${ent.MENU_NAME}</span> 
							<c:if test="${ent.LEAF eq '0'}">
								<span class="pull-right-container">
									<i class="fa fa-angle-left pull-right"></i>
								</span>
							</c:if>
						</a>
					</li>
				</c:if>
			</c:forEach>

		</ul>
		<!-- /.sidebar-menu -->
	</section>
	<!-- /.sidebar -->
</aside>


<script type="text/javascript">
<!--

/* Side Menu */
$(document).ready(function(){

	//탑 2차 지정
    <c:forEach items="${MENU_LIST }" var="subMenu">
	    <c:if test="${subMenu.LVL ne '1'}">

			<c:set var="strCSS" value="${ent.MENU_CSS eq null ? 'fa-circle-o' : ent.MENU_CSS }" />
			if($("#menu_${subMenu.UPPER_MENU_CD} > ul").length < 1){
		    	$("#menu_${subMenu.UPPER_MENU_CD}").append("<ul class='treeview-menu'></ul>");
			}
			$("#menu_${subMenu.UPPER_MENU_CD} > ul").append("<li id='menu_${subMenu.MENU_CD}'><a href='${contextPath}${subMenu.MENU_URL}'><i class='fa ${strCSS}'></i> ${subMenu.MENU_NAME}</a></li>");
			<c:if test="${subMenu.LEAF eq '0'}">
				$("#menu_${subMenu.MENU_CD} > a").append("<span class='pull-right-container'><i class='fa fa-angle-left pull-right'></i></span>");
			</c:if>
		</c:if>
    </c:forEach>

    <c:set var="menuPath" value="${fn:split(MENU_INFO.MENU_CD_PATH, '|')}" />
    <c:forEach items="${menuPath}" var="ent">
    	$("#menu_${ent}").addClass("active");
    </c:forEach>
    
});
//-->
</script>