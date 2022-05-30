<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*" %>
<%@ include file="/layout/inc/taglib.jsp" %>


<link href="${contextPath }/resources/danal/css/style.css?v=1.1" type="text/css" rel="stylesheet"  media="all" />
<form name="form" >
	<!-- popSize 530x430  -->
	<div class="popWrap">
		<h1 class="logo"><img src="${contextPath }/resources/danal/img/logo.gif" /></h1>
		<div class="tit_area">
			<p class="tit"><img src="${contextPath }/resources/danal/img/tit03.gif" alt="결제취소 Complete" /></p>
		</div>
		<div class="box">
			<div class="boxTop">
				<div class="boxBtm" style="height:136px;">
					<p class="txt_info">귀하의 결제가 취소되었습니다.</p>
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
						 다날 계좌이체 결제를 이용해주셔서 고맙습니다. [Tel] 1566-3355
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<script type="text/javascript">
	$(function() {
		$("#btnConfirm").click(function(){
			window.parent.fnPayClose();
		});
	});

</script>