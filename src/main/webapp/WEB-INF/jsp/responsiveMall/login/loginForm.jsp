<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<!doctype html>
<html lang="ko">
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
	<div class="narrow-container login">
		<div class="head">
			<div class="logo-wrap">
				<a href="${contextPath}/m">
					<img src="${contextPath}/resources/resources2/images/logo.jpg" width="100%"/>
				</a>
			</div>
			<div class="title">로그인</div>
		</div>
		<form id="loginForm" method="post" name="loginForm" action="/m/user/login">
			<div class="form-type type01">
				<div class="item">
					<input type="text" id="MEMB_ID" name="MEMB_ID" placeholder="아이디 입력">
				</div>
				<div class="item">
					<input type="password" id="MEMB_PW" name="MEMB_PW" placeholder="비밀번호 입력">
				</div>
				<div class="item mgt20">
					<button id="loginBtn" type="button">로그인</button>
				</div>
			</div>
			<div class="tb redir">
				<div>
					<input type="checkbox" id="item01"/>
					<label for="item01">ID 저장</label>
				</div>
				<div class="right">
					<a href="${contextPath}/m/findMemberId">아이디찾기</a><a href="${contextPath}/m/findMemberPw">비밀번호찾기</a>
				</div>
			</div>
			<input type="hidden" id="rtnUrl" name="rtnUrl" value="${rtnUrl }"/>
		</form>
		<div>
			<p class="join-cmt mgb30 mgt60"><span>아직 회원이 아니세요?</span></p>
			<div class="form-type type01">
				<div class="item mgt20">
					<button id="joinBtn" class="type02" onclick="joinBtn();">회원가입</button>
				</div>
			</div>
			
		</div>
	</div>
  </div> <!-- wrapper -->
  <script>
	
	function flogin_submit(f) {
	    return true;
	}

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
	
	/* 로그인 검사 */
	$(function () {
		
		$('#MEMB_ID').keydown(function(key){
			if(key.keyCode==13){
				$('#loginBtn').click();
			}
		});
		
		$('#MEMB_PW').keydown(function(key){
			if(key.keyCode==13){
				$('#loginBtn').click();
			}
		});
		
		$('#loginBtn').click(function() {
			if($("#MEMB_ID").val() == ""){
				alert("아이디를 입력해 주세요.");
				$("#MEMB_ID").focus();
				return false;
			}
			
			if($("#MEMB_PW").val() == ""){
				alert("비밀번호를 입력해 주세요.");
				$("#MEMB_PW").focus();
				return false;
			}
			
			$("#loginForm").submit();
		});
	});
	
	/* 회원가입 창으로 이동 */
	function joinBtn() {
		location.href = "${contextPath}/m/memberJoinStep1";
	}
  </script>
 </body>
</html>