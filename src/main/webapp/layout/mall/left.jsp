<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- START PAGE SIDEBAR -->
<div class="page-sidebar">
    <!-- START X-NAVIGATION -->
    <ul class="x-navigation">
        <li class="xn-logo">
            <a href="${CONTEXTPATH}/">YTMall Manager</a>
            <a href="#" class="x-navigation-control"></a>
        </li>
        <c:forEach var="ent1" items="${ MENULISTLEVEL3 }" varStatus="status">
        	<c:if test="${ent1.outptFg eq 'Y' }">
        		<!--------- lvl1 MENU --------->
		        <c:if test="${ ent1.lvl eq '1' }">
		        	<li class="xn-title">${ ent1.menuNm }</li>
		        </c:if>
		        <c:forEach var="ent2" items="${ MENULISTLEVEL3 }" varStatus="status">
			        <c:if test="${ (ent1.menuCd eq ent2.upperMenuCd) && (ent2.lvl eq '2')}">
			        	<!--------- lvl2 MENU --------->
			        	<li class="<c:out value='${ent2.menuUrl eq "#" ? " xn-openable " : ""}'/><c:out value='${ ent2.mnuAct eq "T" ? "active" : ""}'/>">
			        		<a href="${CONTEXTPATH}${ ent2.menuUrl }"><span class="fa fa-file-text-o"></span><span class="xn-text">${ ent2.menuNm }</span></a>
			        		<c:if test="${ ent2.menuUrl eq '#' }">
					        	<ul>
					    			<c:forEach var="ent3" items="${ MENULISTLEVEL3 }" varStatus="status">
					    				<c:if test="${ ent2.menuCd eq ent3.upperMenuCd }">
					    					<!--------- lvl3 MENU --------->
						    				<li class="<c:out value='${ ent3.mnuAct eq "T" ? "active" : ""}'/><c:out value='${ent3.menuUrl eq "#" ? " xn-openable" : ""}'/>"> 
						    					<a href="${CONTEXTPATH}${ ent3.menuUrl }"><span class="fa fa-file-text-o"></span>${ ent3.menuNm }</a>
						    					<c:if test="${ent3.menuUrl eq '#'}">
							    					<ul>
							    						<c:forEach var="ent4" items="${ MENULISTLEVEL3 }" varStatus="status">
							    							<c:if test="${ ent3.menuCd eq ent4.upperMenuCd }">
							    								<!--------- lvl4 MENU --------->
								    							<li class="<c:out value='${ ent4.mnuAct eq "T" ? "active" : ""}'/>">
								    								<a href="${CONTEXTPATH}${ ent4.menuUrl }"><span class="fa fa-file-text-o"></span>${ ent4.menuNm }</a>		
								    							</li>
							    							</c:if>
							    						</c:forEach>
							    					</ul>
						    					</c:if>
						    				</li>
					    				</c:if>
					    			</c:forEach>
					        	</ul>
				        	</c:if>
			        	</li>
			        </c:if>
		        </c:forEach>
	        </c:if>
        </c:forEach>                              
    </ul>
    <!-- END X-NAVIGATION -->
</div>
<!-- END PAGE SIDEBAR -->


