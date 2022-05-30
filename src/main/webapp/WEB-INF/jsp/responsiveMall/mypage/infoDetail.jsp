<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mall.web.domain.*" %>

<% 
TB_MBINFOXM tb_mbinfoxm = (TB_MBINFOXM)request.getAttribute("obj");
String mail = tb_mbinfoxm.getMEMB_MAIL();
String front_mail = mail.substring(0, mail.lastIndexOf("@"));
String back_mail = mail.substring(mail.indexOf("@") + 1);

String pon = tb_mbinfoxm.getMEMB_CPON();
String pon1 = "";
String pon2 = "";
String pon3 = "";
if(pon.length() != 0) {
	pon1 = pon.substring(0, pon.indexOf("-", 0));
	pon2 = pon.substring(pon.indexOf("-", 0) + 1, pon.lastIndexOf("-"));
	pon3 = pon.substring(pon.lastIndexOf("-") + 1);
}

String tel = tb_mbinfoxm.getMEMB_TELN();
String tel1 = "";
String tel2 = "";
String tel3 = "";
 if(tel.length() != 0) {
	tel1 = tel.substring(0, tel.indexOf("-", 0));
	tel2 = tel.substring(tel.indexOf("-", 0) + 1, tel.lastIndexOf("-"));
	tel3 = tel.substring(tel.lastIndexOf("-") + 1);
}
%>

<c:set var="strActionUrl" value="${contextPath }/m/wishList" />
<c:set var="strMethod" value="post" />
<!doctype html>
<html>
<head>
<style>
	#btnStyle{border-radius: 4px; height: 100%;}
	.btn-area{margin-left:10px;}
	#daum_juso_rayerMEMB_PN {
    display: block;
    border: 1px solid   !important;
    position: fixed;
    width: 420px;
    height: 480px;
    left: 50%;
    margin-left: -155px;
    top: 50%;
    margin-top: -235px;
    overflow: hidden;
    z-index: 10000;
    border-color: gainsboro;
    border-style: solid;
   }
</style>
</head>
<body>
	<div class="container">
		<div class="page-mypage">
			<div class="mypage-aside">
				<div class="tit">나의 쇼핑 정보</div>
				<div class="txt">
					<ul>
						<li><a href="${contextPath}/m/order/wishList">주문/배송 조회</a></li>
						<li><a href="${contextPath}/m/order/exchange">환불/반품 조회</a></li>
						<li><a href="${contextPath}/m/mypage/review">상품리뷰</a></li>
						<li class="on"><a href="${contextPath}/m/mypage/info">개인정보변경</a></li>
						<li><a href="${contextPath}/m/unregister">회원탈퇴</a></li>
					</ul>
				</div>
			</div>
			<div class="mypage-content">
				<div class="mypage-myinfo-detail">
					<div class="mypage-title">개인정보변경</div>
					<div class="myinfo-detail">
						<form id="fregisterform" name="fregisterform" action="${contextPath }/m/mypage/memberUpdate" method="post" autocomplete="off">
							<input type="hidden" id="MEMB_GUBN" value="${ obj.MEMB_GUBN }">
							<div class="form">
								<dl>
									<dt>이름</dt>
									<dd><div class="desc">${ obj.MEMB_NAME }</div></dd>
								</dl>
								<dl>
									<dt>아이디</dt>
									<dd><div id="uid" class="desc">${ obj.MEMB_ID }</div></dd>
								</dl>
								<c:if test="${ obj.MEMB_GUBN eq 'MEMB_GUBN_02' || obj.MEMB_GUBN eq 'MEMB_GUBN_04'}">
								<dl>
									<dt>회사명</dt>
									<dd><div class="desc">${ obj.COM_NAME }</div></dd>
								</dl>
								</c:if>
								<dl>
									<dt>비밀번호</dt>
									<dd>
										<div class="desc"><input type="password" id="MEMB_PW" name="MEMB_PW"></div>
										<div class="desc"><em class="error_msg"><i class="ic"></i>숫자와 영문자, 특수문자를 포함한 5~20자리 문자</em></div>
									</dd>
								</dl>
								<dl>
									<dt>비밀번호 확인</dt>
									<dd>
										<div class="desc"><input type="password" id="MEMB_PW_RE" name="MEMB_PW_RE"></div>
										<div class="desc"><em class="error_msg"><i class="ic"></i>비밀번호를 한번 더 입력 해 주세요.</em></div>
									</dd>
								</dl>
								<dl>
									<dt>e-mail</dt>
									<dd>
										<div class="desc">
											<input type="text" id="FrontMail" value="<%= front_mail %>">
											<span>@</span><input type="text" id="BackMail" value="<%= back_mail %>">
											<select id="emailDomain">
												<option value="">직접입력</option>
												<option value="naver.com">naver.com</option>
												<option value="hanmail.net">hanmail.net</option>
												<option value="daum.net">daum.net</option>
												<option value="gmail.com">gmail.com</option>
												<option value="nate.com">nate.com</option>
												<option value="hotmail.com">hotmail.com</option>
												<option value="outlook.com">outlook.com</option>
												<option value="icloud.com">icloud.com</option>
											</select>
											<input type="hidden" id="MEMB_MAIL" name="MEMB_MAIL"/>
										</div>
									</dd>
								</dl>
								<dl>
									<dt>휴대폰번호</dt>
									<dd>
										<div class="desc">
											<input type="text" id="Pon1" class="onlyNum" style="min-width: 90px; width: 90px; text-align: center;" 
											value="<%= pon1 %>" maxlength="3">
											<span> - </span>
											<input type="text" id="Pon2" class="onlyNum" style="min-width: 90px; width: 90px; text-align: center;" 
											value="<%= pon2 %>" maxlength="4">
											<span> - </span>
											<input type="text" id="Pon3" class="onlyNum" style="min-width: 90px; width: 90px; text-align: center;" 
											value="<%= pon3 %>" maxlength="4">
											<input type="hidden" id="MEMB_CPON" name="MEMB_CPON" value=""/>
										</div>
									</dd>
								</dl>
								<dl>
									<dt>전화번호</dt>
									<dd>
										<div class="desc">
											<input type="text" id="Tel1" class="onlyNum" style="min-width: 90px; width: 90px; text-align: center;" 
											value="<%= tel1 %>" maxlength="3">
											<span> - </span>
											<input type="text" id="Tel2" class="onlyNum" style="min-width: 90px; width: 90px; text-align: center;" 
											value="<%= tel2 %>" maxlength="4">
											<span> - </span>
											<input type="text" id="Tel3" class="onlyNum" style="min-width: 90px; width: 90px; text-align: center;" 
											value="<%= tel3 %>" maxlength="4">
											<input type="hidden" id="MEMB_TELN" name="MEMB_TELN" value=""/>
										</div>
									</dd>
								</dl>
								<dl>
									<dt>주소</dt>
									<dd>
										<div style="display:flex;">
											<input type="hidden" name="EXTRA_ADDR" id="EXTRA_ADDR" value="">
											<input type="hidden" name="ALL_ADDR" id="ALL_ADDR" value="">
											<input type="text" name="MEMB_PN" id="MEMB_PN" value="${ obj.MEMB_PN }" id="MEMB_PN" placeholder="우편번호" readonly="readonly"
											maxlength="6" style="width:30%;">
											<span class="input-group-btn btn-area">
												<input type="button" id="btnStyle" class="btn btn-info mg-rigit-10 post_btn" value="주소검색"
												onclick="win_zip('fregisterform', 'MEMB_PN', 'MEMB_BADR', 'MEMB_DADR', 'EXTRA_ADDR', 'ALL_ADDR');">
											</span>
										</div>
										<div>
											<input type="text" name="MEMB_BADR" id="MEMB_BADR" value="${ obj.MEMB_BADR }" placeholder="회사 기본주소" readonly="readonly"
											maxlength="100" style="width:70%; margin-top:10px;">
										</div>
										<div>
											<input type="text" name="MEMB_DADR" id="MEMB_DADR" value="${ obj.MEMB_DADR }" placeholder="회사 상세주소" maxlength="100" 
											style="width:70%; margin-top:10px;">
										</div>
									</dd>
								</dl>
								<%-- <c:if test="${ obj.MEMB_GUBN eq 'MEMB_GUBN_02' or  obj.MEMB_GUBN eq 'MEMB_GUBN_04'}">
								<dl>
									<dt>사업자 번호</dt>
									<dd>
										<div class="desc">
											<input type="text" id="COM_NUM" class="onlyNum" name="COM_NUM" value="${ obj.COM_BUNB }" 
											placeholder="사업자 번호 '-'없이 입력" maxlength="10">
											<input type="hidden" name="COM_BUNB" id="COM_BUNB">
										</div>
									</dd>
								</dl>
								</c:if>
								<c:if test="${ obj.MEMB_GUBN eq 'MEMB_GUBN_04' }">
								<dl>
									<dt>건설건축협동 조합원 번호</dt>
									<dd>
										<div class="desc"><input type="text" name="CACOOP_NO" value="${ obj.CACOOP_NO }"></div>
									</dd>
								</dl>
								</c:if> --%>
								<c:if test="${ obj.MEMB_GUBN eq 'MEMB_GUBN_02' || obj.MEMB_GUBN eq 'MEMB_GUBN_04'}">
								<dl>
									<dt>사업자 번호</dt>
									<dd><div class="desc">${ obj.COM_BUNB }</div></dd>
								</dl>
								</c:if>
								<c:if test="${ obj.MEMB_GUBN eq 'MEMB_GUBN_04' }">
								<dl>
									<dt>건설건축협동 조합원 번호</dt>
									<dd><div class="desc">${ obj.CACOOP_NO }</div></dd>
								</dl>
								</c:if>
							</div>
							<div class="button">
								<button type="button" id="modiBtn" class="btn btn_02">저장</button>
							</div>
						</form>
					</div>
				</div>
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
  <script>
  	$("#emailDomain").on("change", function() {
		$("#BackMail").val($("#emailDomain").val());
	});

  	/* 숫자만 입력 */
  	$(".onlyNum").keydown(function(){
		$(this).keyup(function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		});
	});
  	
	$("#modiBtn").click(function(){
		/* 이메일 합치기 */
		var mail = $("#FrontMail").val() + "@" + $("#BackMail").val();
		$("#MEMB_MAIL").val(mail);
		
		/* 휴대폰번호 합치기 */
		var phone = $("#Pon1").val() + "-" + $("#Pon2").val() + "-" + $("#Pon3").val();
		$("#MEMB_CPON").val(phone);
		
		/* 전화번호 합치기 */
		var tel = $("#Tel1").val() + "-" + $("#Tel2").val() + "-" + $("#Tel3").val();
		$("#MEMB_TELN").val(tel);
		
		console.log("mail : " + mail);
		console.log("phone : " + phone);
		console.log("tel : " + tel);
		
		if($("#MEMB_PW").val() == ""){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("비밀번호를 입력해 주세요.");
			$("#MEMB_PW").focus();
			return false;
		}
		
		if($("#MEMB_PW_RE").val() == ""){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("비밀번호 중복을 확인해 주세요.");
			$("#MEMB_PW_RE").focus();
			return false;
		}
		
		if($("#FrontMail").val() == ""){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("이메일을 입력해 주세요.");
			$("#FrontMail").focus();
			return false;
		}
		
		if($("#BackMail").val() == ""){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("이메일을 입력해 주세요.");
			$("#BackMail").focus();
			return false;
		}
		
		if($("#Pon1").val() == ""){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("휴대폰번호를 입력해 주세요.");
			$("#Pon1").focus();
			return false;
		}
		
		if($("#Pon2").val() == ""){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("휴대폰번호를 입력해 주세요.");
			$("#Pon2").focus();
			return false;
		}
		
		if($("#Pon3").val() == ""){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("휴대폰번호를 입력해 주세요.");
			$("#Pon3").focus();
			return false;
		}
		
		if($("#Tel1").val() == ""){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("전화번호를 입력해 주세요.");
			$("#Tel1").focus();
			return false;
		}
		
		if($("#Tel2").val() == ""){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("전화번호를 입력해 주세요.");
			$("#Tel2").focus();
			return false;
		}
		
		if($("#Tel3").val() == ""){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("전화번호를 입력해 주세요.");
			$("#Tel3").focus();
			return false;
		}
		
		if($("#MEMB_PN").val() == ""){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("주소를 입력해 주세요.");
			return false;
		}
		
		if($("#MEMB_DADR").val() == ""){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("상세주소를 입력해 주세요.");
			$("#MEMB_DADR").focus();
			return false;
		}
		
		/* 사업자번호 삽입 */
		/* if($("#MEMB_GUBN").val() == "MEMB_GUBN_02") {
			if($("#COM_NUM").val() == ""){
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("사업자 번호를 입력해 주세요.");
				$("#COM_NUM").focus();
				return false;
			}
			
			var bun = $('#COM_NUM').val();
			if(bun != null || bun != "") {
				comBunb = bun.substring(0,3)+"-"+bun.substring(3,5)+"-"+bun.substring(5,10);
				$('#COM_BUNB').val(comBunb);
			}
		}
		
		if($("#MEMB_GUBN").val() == "MEMB_GUBN_04") {
			if($("#CACOOP_NO").val() == ""){
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("조합원 번호를 입력해 주세요.");
				$("#CACOOP_NO").focus();
				return false;
			}
		} */
		
		/* 비밀번호 조합 체크 */
		var uid = document.getElementById("uid").innerText;
		var upw = $("#MEMB_PW").val();
		var reupw = $("#MEMB_PW_RE").val();
		var mempw = $("#MEMB_PW");
		var memreupw = $("#MEMB_PW_RE");
		
		if(upw != "") {
			var chk_num = upw.search(/[0-9]/g); 
			var chk_eng = upw.search(/[a-z]/ig);
			var chk_spe = upw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
			
			if(!/^(?=.*[a-zA-Z0-9])((?=.*\d)|(?=.*\W)).{5,20}$/.test(upw)) {
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("비밀번호는 숫자와 영문자, 특수문자를 포함한 5~20자리 문자를 입력해야 합니다.");
				mempw.val('');
				memreupw.val('');
				mempw.focus();
				return;
			}
			
			if((chk_num < 0 || chk_eng < 0 || chk_spe < 0)) {
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("비밀번호는 숫자와 영문자, 특수문자를 혼용하여야 합니다.");
				mempw.val('');
				memreupw.val('');
				mempw.focus();
				return;
			}
			
			if(/(\w)\1\1\1/.test(upw)) {
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("비밀번호에 같은 문자를 4번 이상 사용하실 수 없습니다.");
				mempw.val('');
				memreupw.val('');
				mempw.focus();
				return;
			}
			
			if(upw.includes(uid)) {
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("ID가 포함된 비밀번호는 사용하실 수 없습니다.");
				mempw.val('');
				memreupw.val('');
				mempw.focus();
				return;
			}
		}
		
		/* 비밀번호 확인 체크 */
		if (reupw != upw && upw != '') {
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("비밀번호가 일치하지 않습니다. 비밀번호를 확인해주세요.");
			memreupw.val('');
			memreupw.focus();
			return;
		}
		
		$("#fregisterform").submit();
	});
	
	/* 모달창 확인 눌렀을 때 */
	$('.btn-pop-next').click(function() {
		$(".layer-popup").removeClass("on");
	});
  </script>
</body>
</html>
