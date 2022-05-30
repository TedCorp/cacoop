<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!DOCTYPE html>
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
	
    <!-- Libs CSS
	============================================ -->
    <link rel="stylesheet" href="${contextPath}/resources/css/responsive/mobile/bootstrap/css/bootstrap.min.css">
	<link href="${contextPath}/resources/css/responsive/mobile/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/js/responsive/owl-carousel/owl.carousel.css" rel="stylesheet">
    <link href="${contextPath}/resources/js/responsive/owl-carousel/owl.carousel.css" rel="stylesheet">
    <link href="${contextPath}/resources/js/responsive/ratchet/ratchet.css" rel="stylesheet">
	
	<!-- Theme CSS
	============================================ -->
	<%-- <link href="${contextPath}/resources/css/responsive/mobile/mobile.css?v=3" rel="stylesheet"> --%>
	<link href="${contextPath}/resources/js/responsive/ratchet/ratchet.min.css" rel="stylesheet">
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/ratchet/ratchet.min.js"></script>
	

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
		});
	
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
			<h1 class="title">아이디/비밀번호 찾기</h1>
		</header>
		<!-- //End Bar Nav -->
		
		<div class="content">
			<!-- //Begin Main Content -->
			<div class="container page-sitemap">
				<div class="row">
					<div id="content" class="col-xs-12">

						<div class="id-result id-result-demo-1">
							<div class="row">
								<div class="col-xs-12 id-result-image"></div>
								<c:if test="${param.FIND_GBN eq 'ID' }">
								<div class="col-xs-12 id-result-info">
									<h3 class="id-result-title"><span>아이디 찾기 결과</span></h3>
									<div class="id-result-text">
										<c:choose>
											<c:when test="${list.size() == 0}">
												<p>회원정보가 없습니다</p>
											</c:when>
											<c:otherwise>
												<p>회원님의 ID는 
								    			<c:forEach items="${list }" var="lst">
													[<b>${lst.MEMB_ID}</b>]
												</c:forEach>
												입니다.</p>
											</c:otherwise>
										</c:choose>									
									</div>
								</div>
								</c:if>
								<c:if test="${param.FIND_GBN eq 'PW' }">
								<div class="col-xs-12 id-result-info">
									<h3 class="id-result-title"><span>아이디 찾기 결과</span></h3>
									<div class="id-result-text">
										<c:choose>
											<c:when test="${list.size() == 0}">
												<p>회원정보가 없습니다</p>
											</c:when>
											<c:otherwise>
												<p>임시 비밀번호가 발급되었습니다.</p>
								    			<c:forEach items="${list }" var="lst">
													<p>"<b>${lst.MEMB_PW}</b>"
												</c:forEach>
												 입니다.</p>
											</c:otherwise>
										</c:choose>								
									</div>
								</div>
								</c:if>
							</div>
						</div>
					</div>

					<aside class="col-xs-12 content-aside right_column">
						<div class="module">
							<h3 class="modtitle"><span>Account</span></h3>
							<div class="module-content custom-border">
								<ul class="list-box">
									<li><a href="${contextPath}/m/user/loginForm">로그인</a><%--  / <a href="${contextPath}/m/memberJoinStep1">회원가입</a> --%>
									</li>
									<li><a href="${contextPath}/m/findmemberinfo">아이디/비밀번호 찾기</a>
									</li>
								</ul>
							</div>
						</div>
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
							<a href="tel:070-4337-2763"> <i class="fa fa-phone"></i> 070-4337-2763 (상담시간 : 평일 09~17시, 점심시간 12시~13시 / 토일,공휴일은 상담휴무)</a></div>
					</div>
				</div>


				<%-- <div class="footernav-midde">
					<ul class="footer-link-list row">
						<li class="col-xs-6"><a href="${contextPath}/m/intro"> 회사소개 </a></li>
						<li class="col-xs-6"><a href="${contextPath}/m/introPicture"> 매장소개 </a></li>				
					</ul>
				</div> --%>

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
</html>		