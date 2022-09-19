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
	
	<!-- 아임포트 jQuery -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" ></script>
 </head>
 <body>
 
  <form id="pwSrhFrm" name="pwSrhFrm" action="${contextPath}/m/findmemberinfo/result" method="post" autocomplete="off">
 	<input type="hidden" name="FIND_GBN" value="PW"/>
  	<input type="hidden" id="MNAME" name="MEMB_NAME" />
  	<input type="hidden" id="MCPON" name="MEMB_CPON" />
  	<input type="hidden" id="MID" name="MEMB_ID" />
  </form>
 
  <div class="wrapper">
	<div class="narrow-container login join">
		<div class="head">
			<div class="logo-wrap">
				<img src="${contextPath}/resources/resources2/images/logo.jpg" width="100%"/>
			</div>
			<div class="title">비밀번호찾기</div>
		</div>
		<div class="form-type type02">
			<!-- <div class="item mgt30">
				<button class="type02">휴대폰 번호로 찾기</button>

				<p class="add mgt20">가입 시 입력한 회원명과 휴대폰번호를 통해 아이디를 찾을 수 있습니다.</p>
			</div> -->

			

			<p class="border"></p>
			
			<form action="/m/findmemberinfo/updatepw" method="post">
				<div class="item">
					<p  class="tit">아이디</p>
					<input type="text" name="MEMB_ID" id="MEMB_ID" placeholder="아이디 입력">
				</div>
				<div class="item">
					<p  class="tit">이름</p>
					<input type="text" name="MEMB_NAME" id="MEMB_NAME" placeholder="이름 입력">
				</div>
				<div class="item">
					<p  class="tit">휴대폰 번호</p>
					<input type="number" name="MEMB_CPON" id="MEMB_CPON" class="onlyNum" placeholder="휴대폰번호 '-'없이 입력">
	
					<p class="add red mgt30">아이디/비밀번호 찾기 시 제공되는 정보는 회원인증 이외의 용도로 이용 또는 저장하지 않습니다.</p>
				</div>
				
				<div class="item" id = "NEW_PW_AREA" style = "display: none;">
					<p  class="tit">새로운 비밀번호 입력</p>
					<input type="password" name="MEMB_PW" id="NEW_PW" placeholder="새로운 비밀번호"><br>
				</div>
				
				<div class="item" id = "NEW_PW_CHECK_AREA" style = "display: none;">
					<p  class="tit">새로운 비밀번호 확인</p>
					<input type="password" name="NEW_PW_CHECK" id="NEW_PW_CHECK" placeholder="새로운 비밀번호 확인" onkeyup="passwordCheck()">
					<p class="add red" id="passCheck"></p>
				</div>
				
				<div class="item mgt30" id = "CHANGE_PW" style = "display: none;">
					<button>변경하기</button>
				</div>
			</form>
			

			<div class="item mgt30 search_pw" id = "checkUser">
				<button>확인</button>
			</div>
		</div>
	</div>
  </div> <!-- wrapper -->
  
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
  
  <script>
  	/* 휴대폰 번호 숫자만 입력 */
	$(".onlyNum").keydown(function(){
		$(this).keyup(function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		});
	});
  	
	/* 비밀번호 찾기 */
	$(".search_pw").click(function(){
		$('#MID').val($('#MEMB_ID').val());
		$('#MNAME').val($('#MEMB_NAME').val());
		$('#MCPON').val($('#MEMB_CPON').val());
		
		if($("#MEMB_ID").val() == '') {
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("아이디를 입력해 주세요.");
			$("#MEMB_ID").focus();
			return false;
		}
		
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
			data: $("#pwSrhFrm").serialize(),
			success: function (data) {
				if(data != null || data != '') {
					alert("정보가 확인되었습니다. 새로운 비밀번호를 입력해주세요.");
					$('#checkUser').css('display','none');
					$('#MEMB_ID').attr("readonly","readonly");
					$('#MEMB_NAME').attr("readonly","readonly");
					$('#MEMB_CPON').attr("readonly","readonly");
					
					$('#NEW_PW_AREA').removeAttr("style");
					$('#NEW_PW_CHECK_AREA').removeAttr("style");
					$('#CHANGE_PW').removeAttr("style");
					/* $('.layer-popup').addClass('on');
					$('.casa-msg').html("임시 비밀번호가 발급되었습니다."); */
				} else {
					$('.layer-popup').addClass('on');
					$('.casa-msg').html("회원정보를 확인해 주세요.");
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
	
	//비밀번호 확인 입력시 실행
	function passwordCheck() {
		const NEW_PW = document.querySelector("#NEW_PW");
		const NEW_PW_CHECK = document.querySelector("#NEW_PW_CHECK");
		const passCheck = document.querySelector("#passCheck");
		
		if(NEW_PW.value != "") {
			let chk_num = NEW_PW.value.search(/[0-9]/g); 
			let chk_eng = NEW_PW.value.search(/[a-z]/ig);
			let chk_spe = NEW_PW.value.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
			
			if(!/^(?=.*[a-zA-Z0-9])((?=.*\d)|(?=.*\W)).{5,20}$/.test(NEW_PW.value)) {
				passCheck.innerHTML = "비밀번호는 숫자와 영문자, 특수문자를 포함한 5~20자리 문자를 입력해야 합니다.";
				passCheck.className = "add red";
				return;
			} else if((chk_num < 0 || chk_eng < 0 || chk_spe < 0)) {
				passCheck.innerHTML = "비밀번호는 숫자와 영문자, 특수문자를 혼용하여야 합니다.";
				passCheck.className = "add red";
				return;
			} else if(/(\w)\1\1\1/.test(NEW_PW.value)) {
				passCheck.innerHTML = "비밀번호에 같은 문자를 4번 이상 사용하실 수 없습니다.";
				passCheck.className = "add red";
				return;
			} else if(NEW_PW_CHECK.value != NEW_PW.value && NEW_PW.value != ""){
				passCheck.innerHTML = "비밀번호가 일치하지 않습니다. 비밀번호를 확인해주세요.";
				passCheck.className = "add red";
				return;
			} else {
				passCheck.innerHTML = "사용가능한 비밀번호입니다.";
				passCheck.className = "add green";
				return;
			}
		}
	}
	
	
	//회원가입
	$('#CHANGE_PW').click(function(){
		
		/* 비밀번호 조합 체크 */
		var upw = $("#NEW_PW").val();
		var reupw = $("#NEW_PW_CHECK").val();
		var mempw = $("#NEW_PW");
		var memreupw = $("#NEW_PW_CHECK");
		
		if(upw == "" || upw == null){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("비밀번호를 입력해주세요.");
			mempw.focus();
			return false;
		}
		if(reupw == "" || reupw == null){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("비밀번호 확인란을 입력해주세요.");
			reupw.focus();
			return false;
		}
		
		if(upw != ""){
			var chk_num = upw.search(/[0-9]/g); 
			var chk_eng = upw.search(/[a-z]/ig);
			var chk_spe = upw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
			
			if(upw != reupw){
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("비밀번호가 일치하지 않습니다. 비밀번호를 확인해주세요.");
				mempw.val('');
				memreupw.val('');
				return false;
			}
			
			if(!/^(?=.*[a-zA-Z0-9])((?=.*\d)|(?=.*\W)).{5,20}$/.test(upw)) {
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("비밀번호는 숫자와 영문자, 특수문자를 포함한 5~20자리 문자를 입력해야 합니다.");
				mempw.val('');
				memreupw.val('');
				mempw.focus();
				return false;
			}
			
			if((chk_num < 0 || chk_eng < 0 || chk_spe < 0)) {
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("비밀번호는 숫자와 영문자, 특수문자를 혼용하여야 합니다.");
				mempw.val('');
				memreupw.val('');
				mempw.focus();
				return false;
			}
			
			if(/(\w)\1\1\1/.test(upw)) {
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("비밀번호에 같은 문자를 4번 이상 사용하실 수 없습니다.");
				mempw.val('');
				memreupw.val('');
				mempw.focus();
				return false;
			}
		}
		$("#fregisterform").submit();
	});
	
	
	
  </script>
 </body>
 <script>

 </script>
</html>