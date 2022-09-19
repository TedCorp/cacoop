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
 
 <form id="idSrhFrm" name="idSrhFrm" action="${contextPath}/m/findmemberinfo/result" method="post" autocomplete="off">
 	<input type="hidden" name="FIND_GBN" value="ID"/>
  	<input type="hidden" id="MNAME" name="MEMB_NAME" />
  	<input type="hidden" id="MCPON" name="MEMB_CPON" />
  </form>
  
  <div class="wrapper">
	<div class="narrow-container login join">
		<input type="hidden" name="FIND_GBN" value="ID">
		<div class="head">
			<div class="logo-wrap">
				<img src="${contextPath}/resources/resources2/images/logo.jpg" width="100%"/>
			</div>
			<div class="title">아이디찾기</div>
		</div>
		<div class="form-type type02">
			<!-- <div class="item mgt30">
				<button class="type02">휴대폰 번호로 찾기</button>

				<p class="add mgt20">가입 시 입력한 회원명과 휴대폰번호를 통해 아이디를 찾을 수 있습니다.</p>
			</div> -->

			<p class="border"></p>
			
			<div class="item">
				<p  class="tit">이름</p>
				<input type="text" name="MEMB_NAME" id="MEMB_NAME" placeholder="이름 입력">
			</div>
			<div class="item">
				<p  class="tit">휴대폰 번호</p>
				<input type="number" name="MEMB_CPON" id="MEMB_CPON" class="onlyNum" placeholder="휴대폰번호 '-'없이 입력">

				<p class="add red mgt30">아이디/비밀번호 찾기 시 제공되는 정보는 회원인증 이외의 용도로 이용 또는 저장하지 않습니다.</p>
			</div>
		
			<div class="item mgt30 search_id">
				<button>확인</button>
			</div>
		</div>
	</div>
	
  <!-- 모달창 -->
  <div class='layer-popup confrim-type'>
		<div class='popup' style="max-width: 350px;">
			<button type='button' class='btn-pop-close popClose'data-focus='pop' data-focus-prev='popBtn01'>X</button>
			<div class='pop-conts' style='padding:60px 30px 45px 30px;'>
				<div class='casa-msg'></div>
			</div>
		 	<div class='pop-bottom-btn type02'>
		 		<button type='button' data-focus='popBtn02' data-focus-next='pop' class='btn-pop-next'>확인</button>
			</div>
		</div>
	</div>
 <!-- 
	<div class='layer-popup confrim-type on'>
		<div class='popup'>
			<button type='button' class='btn-pop-close popClose'data-focus='pop' data-focus-prev='popBtn01'>X</button>
			<div class='pop-conts' style='padding:60px 30px 45px 30px'>
				<div class='casa-msg'>
					회원님의 아이디는 <span class="red">test011</span>입니다.
				</div>
			</div>
		 	<div class='pop-bottom-btn type02'>
		 		<button type='button' data-focus='popBtn02' data-focus-next='pop' class='btn-pop-next'>확인</button>
			</div>
		</div>
	</div>
-->

  </div> <!-- wrapper -->
  <script>
  	/* 휴대폰 번호 숫자만 입력 */
	$(".onlyNum").keydown(function(){
		$(this).keyup(function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		});
	});
  
  	/* 아이디 찾기 */
	$(".search_id").click(function(){
		$('#MNAME').val($('#MEMB_NAME').val());
		$('#MCPON').val($('#MEMB_CPON').val());
		
		if($("#MEMB_NAME").val() == '') {
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("이름을 입력해 주세요.");
			$("#MEMB_NAME").focus();
			return false;
		}
		
		if($("#MEMB_CPON").val() == '') {
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("휴대폰 번호를 입력해 주세요.");
			$("#MEMB_CPON").focus();
			return false;
		}
		
		if($("#MEMB_CPON").val().length != 11) {
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("휴대폰 양식을 확인해 주세요.");
			$("#MEMB_CPON").focus();
			return false;
		}
		
		$.ajax({
			type: "POST",
			url: "${contextPath}/m/findmemberinfo/result",
			async: false,
			data: $("#idSrhFrm").serialize(),
			success: function (data) {
				if(data.length != 0) {
					$('.layer-popup').addClass('on');
					$('.casa-msg').html("회원님의 아이디는 " + data + " 입니다.");
				} else {
					$('.layer-popup').addClass('on');
					$('.casa-msg').html("존재하지 않는 회원입니다.");
				}
			}, error: function (jqXHR, textStatus, errorThrown) {
				alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
			}
		});
	});
  	
	/* 모달창 확인 눌렀을 때 */
	$('.btn-pop-next').click(function() {
		$(".layer-popup").removeClass("on");
	});
  </script>
 </body>
 <script>

 </script>
</html>