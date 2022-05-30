<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*" %>
<%@ include file="/layout/inc/taglib.jsp" %>


<c:if test="${RETURNCODE eq '0000' }">
<link href="${contextPath }/resources/danal/css/style.css" type="text/css" rel="stylesheet"  media="all" />
<form name="form" >
	<!-- popSize 530x430  -->
	<div class="popWrap">
		<h1 class="logo"><img src="${contextPath }/resources/danal/img/logo.gif" alt="Danal 계좌이체" /></h1>
		<div class="tit_area">
			<p class="tit"><img src="${contextPath }/resources/danal/img/tit05.gif" alt="계좌이체Complete" /></p>
		</div>
		<div class="box">
			<div class="boxTop">
				<div class="boxBtm" style="height:136px;">
					<p class="txt_info"><img src="${contextPath }/resources/danal/img/txt_com.gif" width="202" height="17" alt="귀하의 발급이 완료되었습니다." /></p>
				</div>
			</div>
		</div>
		<p class="btn">
			<a href="#"><img src="${contextPath }/resources/danal/img/btn_confirm.gif" width="91" height="28" alt="확인" id="btnConfirm" /></a>
		</p>
		<div class="popFoot">
			<div class="foot_top">
				<div class="foot_btm">
					<div class="noti_area">
						 다날 계좌이체를 이용해주셔서 고맙습니다. [Tel] 1566-3355
					</div>
				</div>
			</div>
		</div>
	</div>
</form>


<script type="text/javascript">
	$(function() {
		$("#btnConfirm").click(function(){
			window.parent.location.href = "<%= request.getContextPath() %>/order/view/${ORDER_NUM}";
			//window.opener.fnPayClose();
			window.parent.fnPayClose();
		});
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