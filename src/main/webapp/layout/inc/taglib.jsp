<%@ page contentType="text/html; charset=utf-8" %>

<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"  %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"  %>
<%@ taglib prefix="fn" uri="/WEB-INF/tld/fn.tld"  %>
<%@ taglib prefix="sql" uri="/WEB-INF/tld/sql.tld"  %>
<%@ taglib prefix="x" uri="/WEB-INF/tld/x.tld"  %>

<%@ taglib prefix="tiles" uri="/WEB-INF/tld/tiles-jsp.tld" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="spform" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="paging" uri="/WEB-INF/tld/paging.tld"%>
<% pageContext.setAttribute("newLine", "\n"); %> 

<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="browser" value="${header['user-agent'] }" scope="session" />

<c:set var="currentUrl">${pageContext.request.scheme}://${pageContext.request.serverName}<c:if test="${pageContext.request.serverPort ne '80'}">:${pageContext.request.serverPort}</c:if></c:set>

<jsp:useBean id="DATE" class="java.util.Date"/>


<fmt:formatDate value="${DATE }" var="TODAY" pattern="yyyy/MM/dd" />
<fmt:formatDate value="${DATE }" var="TODAY_YEAR" pattern="yyyy" />
<fmt:formatDate value="${DATE }" var="TODAY_MONTH" pattern="MM" />
<fmt:formatDate value="${DATE }" var="TODAY_DAY" pattern="dd" />


