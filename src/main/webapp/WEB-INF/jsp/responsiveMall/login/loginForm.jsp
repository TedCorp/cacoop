<%-- <%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    
    <!-- Basic page needs
    ============================================ -->
    <title>:::: CJFLSMART ::::</title>
    <meta charset="utf-8">
    <meta name="keywords" content="청정FLS, cjflsmart" />

    <!-- Mobile specific metas
    ============================================ -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
	<!-- Google web fonts
	============================================ -->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>
	
    <!-- Libs CSS
	============================================ -->
    <link rel="stylesheet" href="${contextPath}/resources/css/responsive/mobile/bootstrap/css/bootstrap.min.css">
	<link href="${contextPath}/resources/css/responsive/mobile/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/js/responsive/owl-carousel/owl.carousel.css" rel="stylesheet">
    <link href="${contextPath}/resources/js/responsive/owl-carousel/owl.carousel.css" rel="stylesheet">
    <link href="${contextPath}/resources/js/responsive/ratchet/ratchet.css?v=12" rel="stylesheet">
	
	<!-- Theme CSS
	============================================ -->
	<link href="${contextPath}/resources/css/responsive/mobile/mobile.css?v=12" rel="stylesheet">
	

	<!-- Include Libs & Plugins
	============================================ -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/jquery-2.2.4.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/bootstrap.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/owl-carousel/owl.carousel.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/slick-slider/slick.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/ratchet/ratchet.js"></script>
	
	<!-- Theme files
	============================================ -->
	
	
	<script language="javascript">
		$(function(){
			if('${param.flag }' != null && '${param.flag }' == 'chklogin'){
				alert("로그인 정보가 없습니다. 로그인 후 이용해주시기 바랍니다.");
			}			
		});
		
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
	</script>	
</head>

<body class="ltr mobilelayout-0">
	<!-- Begin Main wrapper -->
    <div id="wrapper" >
		
		<!-- Begin Bar Tab -->
		<nav class="bar bar-tab">
			<a class="tab-item " href="${contextPath}/m" data-transition="slide-in">
				<span class="icon icon-home"></span>
				<span class="tab-label">Home</span>
			</a>
		</nav>
		<!-- //End Bar Tab -->
		
		<!-- Begin Bar Nav -->
		<header class="bar bar-nav ">
			<a class="btn btn-link btn-nav pull-left" href="#" onclick="history.go(-1); return false;">
				<span class="icon icon-left-nav"></span>
			</a>
			<h1 class="title">Login</h1>
		</header>
		<!-- //End Bar Nav -->
		
		<div class="content">
			<!-- //Begin Main Content -->
			<div class="container page-sitemap">
				<div class="row">
					<div id="content" class="col-xs-12">
						<div class="tab-account">
							<div class="icon-custom"></div>
							<ul class="nav nav-tabs segmented-control">
								<li class="active">
									<a class="platform-switch control-item active" data-toggle="tab" href="#home" aria-expanded="true">로그인</a>
								</li>
								<li class="">
									<a class="platform-switch control-item active" data-toggle="tab" href="#menu1" aria-expanded="false">회원가입</a>
								</li>
							</ul>

							<div class="tab-content">
								<div id="home" class="tab-pane form-login fade active in">
									<div class="well col-sm-12">
										<h2 class="hidden">Returning Customer</h2>
										<p class="hidden"><strong>I am a returning customer</strong></p>
										
										<form name="flogin" action="${contextPath }/m/user/login" onsubmit="return flogin_submit(this);" method="post">
										    <input type="hidden" name="url" value="">
										    <input type="hidden" name="rtnUrl" value='<%= request.getHeader("referer") %>'>
											<div class="form-group form-user">
												<label class="control-label font-ct" for="MEMB_ID">아이디</label>
												<input type="text" name="MEMB_ID" value="" placeholder="아이디 입력" id="MEMB_ID" class="form-control">
											</div>
											<div class="form-group form-pw">
												<label class="control-label font-ct" for="MEMB_PW">비밀번호</label>
												<input type="password" name="MEMB_PW" value="" placeholder="Password" id="비밀번호 입력" class="form-control">
												<a href="${contextPath}/m/findmemberinfo">아이디/비밀번호 찾기</a>
											</div>

											<input type="submit" value="로그인" class="btn btn-primary pull-left">
										</form>										
									</div>
								</div>
								
								 <div id="menu1" class="tab-pane fade in">
									<div class="well col-sm-12">
										<h2 class="hidden">New Customer</h2>
										<p><strong class="font-ct">회원등록</strong>
										</p>
										<p style="margin-bottom: 2em;">회원가입을 하시면 주문 내용을 확인 수 있으며 관심상품 등 회원 서비스를 이용할 수 있습니다. </p>
										<a href="${contextPath}/m/memberJoinStep1" class="btn btn-sn">회원가입 이동</a>
									</div>
								</div> 
								
							</div>
						</div>
					</div>
					<!-- aside class="col-xs-12 content-aside right_column">
						<div class="module">
							<h3 class="modtitle"><span>Account</span></h3>
							<div class="module-content custom-border">
								<ul class="list-box">
									<li><a href="#">아이디 찾기</a>
									</li>
									<li><a href="#">비밀번호 찾기</a>
									</li>
								</ul>
							</div>
						</div -->
					</aside>
				</div>
			</div>
			<!-- //End Main Content -->
			
			<!-- //Begin Footer Content -->
			<div class="container footer-content">
				<div class="footernav-top">
					<div class="need-help">
						<p>고객센터</p>
						<div class="nh-contact">
							<a href="tel:070-4337-2910"> <i class="fa fa-phone"></i> 070-4337-2910<br>
							(상담시간 : 10:00 ~ 16:00 / 토일,공휴일은 상담휴무)</a></div>
					</div>
				</div>

				<div class="footernav-midde">
					<ul class="footer-link-list row">
						<li class="col-xs-12"><a href="${contextPath}/m/intro"> 회사소개 </a></li>
						<li class="col-xs-6"><a href="${contextPath}/m/introPicture"> 매장소개 </a></li>				
					</ul>
				</div>

				<div class="footernav-bottom">
					<div class="text-center">
						청정FLS All right reserverd. <a href="https://www.cjflsmart.co.kr/m" target="_blank">www.cjflsmart.co.kr</a>
					</div>
				</div>
			</div>
			<!-- //End Footer Content -->
		</div>

    </div>

</body>
</html> --%>
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
					<img src="${contextPath}/resources/resources2/images/logo.png" width="100%"/>
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