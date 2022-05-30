<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<!doctype html>
<html lang="en">
 <head>
 	<!-- Basic page needs
    ============================================ -->
    <title>:::: 건설건축 협동조합 ::::</title>
    <meta charset="utf-8">
    <meta name="keywords" content="건설건축 협동조합" />

    <!-- Mobile specific metas
    ============================================ -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
	<!-- Google web fonts
	============================================ -->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>
    
	<!-- new Includes
	============================================ -->
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/swiper/dist/css/swiper.min.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/common.css">
	<script type="text/javascript" src="${contextPath}/resources/resources2/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/resources2/js/jquery-ui.1.12.1.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/resources2/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/resources2/swiper/dist/js/swiper.min.js"></script>
 </head>
 <body>
  <div class="wrapper">
	<div class="narrow-container join-result">
		<div class="head">
			<div class="logo-wrap">
				<img src="${contextPath}/resources/resources2/images/logo.png" width="100%"/>
			</div>
			<div class="title">회원가입</div>
		</div>
		<div class="result">
			<p class="big">
				회원가입이 완료 되었습니다.
			</p>
			<p class="add">
				회원가입을 축하합니다.<br>
				건설건축협동조합의 다양한 상품을 만나보세요.
			</p>
			<div class="form-type">
				<div class="item mgt30 dual-btns">
					<button onclick="homeBtn();">홈으로</button>
					<button onclick="loginBtn();">로그인</button>
				</div>
			</div>
		</div>
	</div>
  </div> <!-- wrapper -->
  <script>
  	/* 홈으로 이동 */
	function homeBtn() {
		location.href = "${contextPath}/m";
	}
  	
	/* 로그인화면으로 이동 */
	function loginBtn() {
		location.href = "${contextPath}/m/user/loginForm";
	}
  </script>
 </body>
</html>