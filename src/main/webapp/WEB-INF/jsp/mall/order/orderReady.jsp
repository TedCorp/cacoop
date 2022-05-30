<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:if test="${RETURNCODE eq '0000' }">
<form name="form" ACTION="${STARTURL}" METHOD="POST">
	<input TYPE="HIDDEN" NAME="STARTPARAMS" VALUE="${STARTPARAMS}"> 
	<input TYPE="HIDDEN" NAME="CIURL" VALUE=""> <input TYPE="HIDDEN" NAME="COLOR" VALUE="">
</form>

<script type="text/javascript">

	$(function() {
		document.form.submit();
	});
	
</script>
</c:if>

<c:if test="${RETURNCODE ne '0000' }">

<script type="text/javascript">

	$(function() {
		alert("[${RETURNCODE}] ${RETURNMSG}\n결제처리중 에러가 발생했습니다. 관리자에게 문의하세요.");
		
	});
	
</script>

</c:if>