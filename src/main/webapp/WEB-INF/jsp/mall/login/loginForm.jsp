<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>:::: 식자재몰 - 믿고사는 식자재 ::::</title>

	<link rel="stylesheet" href="${contextPath}/resources/css/mall/default_shop.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/mall/style.css">
	
	<!-- BootStrap 3.3.6 -->		
	<link rel="stylesheet" href="${contextPath }/resources/bootstrap/css/bootstrap.min.css">

	<!-- jQuery 2.1.1 -->
	<script type="text/javascript" src="${contextPath }/resources/js/jquery-2.2.1.min.js"></script>
	<!-- BootStrap 3.3.6 -->
	<script type="text/javascript" src="${contextPath }/resources/bootstrap/js/bootstrap.min.js"></script>
	
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<!-- jQuery FlexSlider v2.6.1 -->
	<script src="${contextPath}/resources/js/jquery.flexslider-min.js"></script>
	
<script language="javascript">
<!--
	var contextPath = "<%= request.getContextPath() %>"; 
//-->
$(function(){
	if('${param.flag }' != null && '${param.flag }' == 'chklogin'){
		alert("장시간 사용하지 않아 로그아웃 되었습니다. 재로그인 해주시기 바랍니다.");
		//window.open('https://atomyaza.co.kr/bbs/login.php', 'login', 'top=10, left=10, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no');
		//self.close();
	}
	
	// 애터미아자 로그인페이지로 리다이렉트
	// window.location.href='https://atomyaza.co.kr/bbs/login.php';
});
</script>
</head>

<body>	
	<!-- 로그인 시작 { -->
	<div id="mb_login" class="mbskin">
	    <h1>로그인</h1>	
	    <form name="flogin" action="${contextPath }/user/login" onsubmit="return flogin_submit(this);" method="post">
		    <input type="hidden" name="url" value="">
		    <input type="hidden" name="rtnUrl" value='<%= request.getHeader("referer") %>'>
		
		    <fieldset id="login_fs">
		        <label for="login_id" class="login_id">회원아이디<strong class="sound_only"> 필수</strong></label>
		        <input type="text" name="MEMB_ID" id="MEMB_ID" required class="frm_input required" size="20" maxLength="20" onchange="strtrimid(this)">
		        <label for="login_pw" class="login_pw">비밀번호<strong class="sound_only"> 필수</strong></label>
		        <input type="password" name="MEMB_PW" id="MEMB_PW" required class="frm_input required" size="20" maxLength="20" onchange="strtrimpw(this)">
		        <input type="submit" value="로그인" class="btn_submit">
		        <input type="checkbox" name="auto_login" id="login_auto_login">
		        <label for="login_auto_login">자동로그인</label>
		    </fieldset>
		
		    <aside id="login_info">
		        <div>
		            <!--a href="<?php echo G5_BBS_URL ?>/password_lost.php" target="_blank" id="login_password_lost" class="btn02">아이디 비밀번호 찾기</a -->
		            <%-- <a href="${contextPath}/findmemberinfo/findid" class="btn01">아이디 찾기</a>
		            <a href="${contextPath}/findmemberinfo/findpw" class="btn01">비밀번호 찾기</a>
		            <a href="${contextPath}/memberJoinStep1" class="btn01">회원 가입</a> --%>
		        </div>
		    </aside>
	    </form>
	
	    <div class="btn_confirm">
	        <a href="${contextPath}/">메인으로 돌아가기</a>
	    </div>
	</div>

</body>
</html>
<script>
$(function(){
    $("#login_auto_login").click(function(){
        if (this.checked) {
            this.checked = confirm("자동로그인을 사용하시면 다음부터 회원아이디와 비밀번호를 입력하실 필요가 없습니다.\n\n공공장소에서는 개인정보가 유출될 수 있으니 사용을 자제하여 주십시오.\n\n자동로그인을 사용하시겠습니까?");
        }
    });
});

function flogin_submit(f) { return true; }


/* 공백제거 */
function strtrimid(obj){	
	/* alert('아이디 공백제거 전 : '+$('#MEMB_ID').val()); */
	var idtxt = $('#MEMB_ID').val().replace(/ /gi, '');	
	/* alert('아이디 공백제거 후 : '+idtxt); */
	$('#MEMB_ID').val(idtxt);
}

function strtrimpw(obj){
	/* alert('비번 공백제거 전 : '+$('#MEMB_PW').val()); */
	var pwtxt = $('#MEMB_PW').val().replace(/ /gi, '');	
	/* alert('비번 공백제거 후 : '+pwtxt); */
	$('#MEMB_PW').val(pwtxt);
}
</script>
<!-- } 로그인 끝 -->