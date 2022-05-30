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
	<link href="${contextPath}/resources/css/responsive/mobile/mobile.css?v=1" rel="stylesheet">
	

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

    		$("#divCompany").hide();
		    $("input[name^=mem_gbn]").click(function(){
		    	if($(this).val() == "company"){
					$("input[name=COM_BUNB]").attr("required" , true);
		    		$("#divCompany").show();
		    	}else{
					$("input[name=COM_BUNB]").attr("required" , false);
		    		$("#divCompany").hide();
		    	}
		    });

    		$("#divCompany1").hide();
		    $("input[name^=mem_gbn1]").click(function(){
		    	if($(this).val() == "company"){
					$("#COM_BUNB1").attr("required" , true);
		    		$("#divCompany1").show();
		    	}else{
					$("#COM_BUNB1").attr("required" , false);
		    		$("#divCompany1").hide();
		    	}
		    });
		});
	
		function flogin_submit(f)
		{
		    return true;
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
			<h1 class="title">아이디/비밀번호 찾기</h1>
		</header>
		<!-- //End Bar Nav -->
		
		<div class="content">
			<!-- //Begin Main Content -->
			<div class="container page-sitemap">
				<div class="row">
					<div id="content" class="col-xs-12">
						<div class="tab-account">
							<div class="icon-finder"></div>
							<ul class="nav nav-tabs segmented-control">
								<li class="active"><a class="platform-switch control-item active" data-toggle="tab" href="#home" aria-expanded="true">아이디 찾기</a> </li>
								<li class=""><a class="platform-switch control-item active" data-toggle="tab" href="#menu1" aria-expanded="false">비밀번호 찾기</a></li>
							</ul>

							<div class="tab-content">
								<div id="home" class="tab-pane fade active in">

									<div class="well col-sm-12">

										<form name="flogin" action="${contextPath }/m/findmemberinfo/result" onsubmit="return flogin_submit(this);" method="post">
									    <input type="hidden" name="FIND_GBN" value="ID">
										<div class="panel panel-default">
											<div class="panel-heading">
												<h4 class="panel-title"><i class="fa fa-user"></i> 회원정보</h4>
											</div>
											<div class="panel-body">
												<fieldset id="account">
													<div class="form-group">
														<div class="radio-inline">
															<label><input type="radio" checked="checked" value="member" name="mem_gbn"> 개인</label>
														</div>
														<div class="radio-inline">
															<label><input type="radio" value="company" name="mem_gbn"> 사업자</label>
														</div>
													</div>
													<div class="form-group required">
														<label for="MEMB_NAME" class="control-label">회원이름</label>
														<input type="text" required  class="form-control" id=MEMB_NAME placeholder="회원이름 입력" value="" name="MEMB_NAME">
													</div>
													<div class="form-group required">
														<label for="MEMB_CPON" class="control-label">휴대폰번호 ('-' 없이 입력)</label>
														<input type="text" required class="form-control" id="MEMB_CPON" placeholder="휴대폰번호(- 제거)" value="" name="MEMB_CPON">
													</div>
													<div class="form-group required" id="divCompany">
														<label for="COM_BUNB" class="control-label">사업자번호</label>
														<input type="text" class="form-control" id="COM_BUNB" placeholder="사업자번호 입력" value="" name="COM_BUNB">
													</div>
												</fieldset>
												<div class="buttons">
													<div class="pull-right">
														<input type="submit" class="btn btn-primary" id="button-confirm" value="찾기">
													</div>
												</div>
											</div>
										</div>
										</form>
									</div>
								</div>
								<div id="menu1" class="tab-pane fade in">

										<form name="flogin1" action="${contextPath }/m/findmemberinfo/result" onsubmit="return flogin_submit(this);" method="post">
									    <input type="hidden" name="FIND_GBN" value="PW">
										<div class="panel panel-default">
											<div class="panel-heading">
												<h4 class="panel-title"><i class="fa fa-user"></i> 회원정보</h4>
											</div>
											<div class="panel-body">
												<fieldset id="account">
													<div class="form-group">
														<div class="radio-inline">
															<label><input type="radio" checked="checked" value="member" name="mem_gbn1"> 개인</label>
														</div>
														<div class="radio-inline">
															<label><input type="radio" value="company" name="mem_gbn1"> 사업자</label>
														</div>
													</div>
													<div class="form-group required">
														<label for="MEMB_ID1" class="control-label">회원아이디</label>
														<input type="text" required  class="form-control" id=MEMB_ID1 placeholder="회원아이디 입력" value="" name="MEMB_ID">
													</div>
													<div class="form-group required">
														<label for="MEMB_NAME1" class="control-label">회원이름</label>
														<input type="text" required  class="form-control" id=MEMB_NAME1 placeholder="회원이름 입력" value="" name="MEMB_NAME">
													</div>
													<div class="form-group required">
														<label for="MEMB_CPON1" class="control-label">휴대폰번호 ('-' 없이 입력)</label>
														<input type="text" required class="form-control" id="MEMB_CPON1" placeholder="휴대폰번호(- 제거)" value="" name="MEMB_CPON">
													</div>
													<div class="form-group required" id="divCompany1">
														<label for="COM_BUNB" class="control-label">사업자번호</label>
														<input type="text" class="form-control" id="COM_BUNB1" placeholder="사업자번호 입력" value="" name="COM_BUNB">
													</div>
												</fieldset>
												<div class="buttons">
													<div class="pull-right">
														<input type="submit" class="btn btn-primary" id="button-confirm" value="찾기">
													</div>
												</div>
											</div>
										</div>
										</form>
								</div>
								
							</div>
						</div>
					</div>
					<aside class="col-xs-12 content-aside right_column">
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
						</div>
					</aside>
				</div>
			</div>
			<!-- //End Main Content -->
			
			<!-- //Begin Footer Content -->
			<div class="container footer-content">

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