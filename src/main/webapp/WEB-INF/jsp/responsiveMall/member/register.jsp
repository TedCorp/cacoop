<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<c:set var="strActionUrl" value="${contextPath }/m/wishList" />
<c:set var="strMethod" value="post" />
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
    
    <!-- Include Libs & Plugins
	============================================ -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/jquery-2.2.4.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/bootstrap.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/owl-carousel/owl.carousel.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/slick-slider/slick.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/themejs/libs.js?v=5"></script>
	<%-- <script type="text/javascript" src="${contextPath}/resources/js/responsive/unveil/jquery.unveil.js"></script> --%>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/countdown/jquery.countdown.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/dcjqaccordion/jquery.dcjqaccordion.2.8.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/datetimepicker/moment.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/datetimepicker/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/jquery-ui/jquery-ui.min.js"></script>
	
	<!-- Theme files
	============================================ -->
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/themejs/homepage.js"></script>	
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/themejs/so_megamenu.js?v=3"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/responsive/themejs/addtocart.js"></script>  
	<!--<script type="text/javascript" src="${contextPath}/resources/js/responsive/themejs/application.js?v=${DATE }"></script>-->
	
	<!-- jquery-number-2.1.5 -->
	<script type="text/javascript" src="${contextPath}/resources/adminlte/plugins/number/jquery.number.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js?v=${DATE }"></script>
	<!-- jquery-validation-1.15 -->
	<script type="text/javascript" src="${contextPath }/resources/adminlte/plugins/validation/jquery.validate.min.js"></script>
	<!-- jQuery Cookie Plugin v1.4.1 -->
	<script type="text/javascript" src="${contextPath }/resources/adminlte/plugins/cookie/jquery.cookie.js"></script>
    
	<!-- new Includes
	============================================ -->
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/swiper/dist/css/swiper.min.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/common.css">
	<!-- <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script> -->
	<!-- <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/resources2/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/resources2/js/jquery-ui.1.12.1.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/resources2/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/resources2/swiper/dist/js/swiper.min.js"></script>
  <style>
	.post_btn {
	width:19%;
	height:45px;
    color: #fff;
    background: #26c165;
    font-size: 16px;
    font-weight: 600;
    border-radius: 5px;
    border: 1px solid #26c165;
    }
    .input-hide{
    display:none;
    }
    #PS_COM, #APD_PROD{
    width: 100%;
    border: 1px solid #dddddd;
    border-radius: 5px;
    height: 45px;
    }
    
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
 
  <form id="idChkFrm" name="idChkFrm" action="${contextPath }/idChk" method="post" autocomplete="off">
  	<input type="hidden" id="MEMB_ID_TMP" name="MEMB_ID_TMP" />
  </form>

  <div class="wrapper">
	<div class="narrow-container login join">
		<div class="head">
			<div class="logo-wrap">
				<a href="${contextPath}/m">
					<img src="${contextPath}/resources/resources2/images/logo.jpg" width="100%"/>
				</a>
			</div>
			<div class="title">회원가입</div>
		</div>
		<form class="form-horizontal account-register clearfix" id="fregisterform" name="fregisterform" action="${contextPath }/m/memberInsert" method="post" autocomplete="off">
			<input type="hidden" name="MEMB_CHK_YN" id="MEMB_CHK_YN" value="N"/>
			<div class="item">
				<p  class="tit">회원 구분</p>
				<div style="display:flex;">
					<div class="checkbox">
						<input type="checkbox" name="MEMB_GUBN" value="MEMB_GUBN_01" id="MEMB_GUBN_01" checked="checked"/>
						<label for="MEMB_GUBN_01">일반 회원</label>
					</div>
					<div class="checkbox">
						<input type="checkbox" name="MEMB_GUBN" value="MEMB_GUBN_04" id="MEMB_GUBN_04"/>
						<label for="MEMB_GUBN_04">조합원</label>
					</div>
				</div>
			</div>
			<br>
			<div class="form-type type02">
				<div class="item required btn-with">
					<p class="tit"><span>아이디</span></p>
					<div class="dual">
						<div>
							<input type="text" name="MEMB_ID" id="MEMB_ID" class="nHangul" placeholder="아이디 입력 (5~16자의 숫자와 영문자 조합)">
						</div>
						<div>
							<button type="button" id="chkIdBtn" class="sub">중복확인</button>
						</div>
					</div>
				</div>
				<div class="item required btn-with">
					<p  class="tit"><span>비밀번호</span></p>
					<input type="password" name="MEMB_PW" id="MEMB_PW" placeholder="비밀번호 입력">
					<!-- <p class="add red">숫자와 영문자, 특수문자를 포함한 5~20자리 문자를 입력해야 합니다.</p> -->
				</div>
				<div class="item required btn-with">
					<p  class="tit"><span>비밀번호확인</span></p>
					<input type="password" id="MEMB_PW_RE" onkeyup="passwordCheck()" placeholder="비밀번호 재 입력">
					<p class="add red" id="passCheck"></p>
				</div>
				<div class="item required btn-with">
					<p  class="tit"><span>이름</span></p>
					<input type="text" name="MEMB_NAME" id="MEMB_NAME" placeholder="이름 입력">
				</div>
				<div class="item required btn-with">
					<p  class="tit"><span>이메일</span></p>
					<input type="text" name="MEMB_MAIL" id="MEMB_MAIL" placeholder="이메일 입력 (ex.hongildong@naver.com)">
				</div>
				<div class="item required btn-with">
					<p  class="tit"><span>휴대폰 번호</span></p>
					<input type="text" id="MEMB_PHONE" class="onlyNum" placeholder="휴대폰 번호 '-'없이 입력" maxlength="11">
					<input type="hidden" name="MEMB_CPON" id="MEMB_CPON">
				</div>
				<div class="item">
					<p  class="tit">전화번호</p>
					<input type="text" id="MEMB_TEL" class="onlyNum" placeholder="전화번호 '-'없이 입력" maxlength="11">
					<input type="hidden" name="MEMB_TELN" id="MEMB_TELN">
				</div>
				<div class="item com_name_area input-hide required btn-with">
					<p  class="tit"><span>회사명</span></p>
					<input type="text" id="COM_NAME" name="COM_NAME" placeholder="회사명 입력"/>
				</div>
				<div class="item rprs_name_area input-hide required btn-with">
					<p  class="tit"><span>대표자명</span></p>
					<input type="text" id="RPRS_NAME" name="RPRS_NAME" placeholder="대표자명 입력"/>
				</div>
				<div class="item required btn-with">
					<p  class="tit"><span>우편 번호</span></p>
					<label class="col-sm-2" for="MEMB_PN"></label>
						<div>
							<input type="hidden" name="EXTRA_ADDR" id="EXTRA_ADDR" value="">
							<input type="hidden" name="ALL_ADDR" id="ALL_ADDR" value="">
							
							<div>
								<div class="input-group">
									<input type="text" name="MEMB_PN" value="" id="MEMB_PN" style="width:80%;" placeholder="우편번호" readonly="readonly" maxlength="6">
									<span class="input-group-btn">
										<input type="button" class="btn btn-info mg-rigit-10 post_btn" value="주소검색"
										onclick="win_zip('fregisterform', 'MEMB_PN', 'MEMB_BADR', 'MEMB_DADR', 'EXTRA_ADDR', 'ALL_ADDR');">
									</span>									
								</div>
							</div>
						</div>
				</div>
				<div class="item required btn-with">
					<p  class="tit"><span>기본 주소</span></p>
					<label class="col-sm-2" for="MEMB_BADR"></label>
					<div>
						<input type="text" name="MEMB_BADR" id="MEMB_BADR" value="" placeholder="기본주소" readonly="readonly" maxlength="100">
					</div>
				</div>
				<div class="item required btn-with">
					<p  class="tit"><span>상세 주소</span></p>
					<label class="col-sm-2" for="MEMB_DADR"></label>
					<div>
						<input type="text" name="MEMB_DADR" id="MEMB_DADR" placeholder="상세주소" maxlength="100">
					</div>
				</div>
				<!-- <div class="item">
					<p  class="tit">조합원인 경우 조합원 번호를 입력하세요.</p>
					<input type="text" name="CACOOP_NO" placeholder="조합원 번호 입력">
				</div> -->
				<div class="item com_bunb_area input-hide required btn-with">
					<p class="tit"><span>사업자 번호</span></p>
					<input type="text" id="COM_NUM" name="COM_NUM" class="onlyNum" placeholder="사업자 번호 '-'없이 입력" maxlength="10">
					<input type="hidden" name="COM_BUNB" id="COM_BUNB">
				</div>
				<div class="item cacoop_no_area input-hide">
					<p class="tit">조합원 번호</p>
					<input type="text" id="CACOOP_NO" name="CACOOP_NO" placeholder="조합원 번호 숫자만 입력">
					<p class="add red">조합원 번호를 모르실 경우 가입후 관리자에게 문의 부탁드립니다.</p>
				</div>
				<div class="item cacoop_no_area input-hide required btn-with">
				<p  class="tit"><span>공급사로 등록하시겠습니까?</span></p>
				<div style="display:flex;">
					<div class="checkbox">
						<input type="checkbox" name="USE_YN" value="Y" id="USE_Y" checked="checked"/>
						<label for="USE_Y">네</label>
					</div>
					<div class="checkbox">
						<input type="checkbox" name="USE_YN" value="N" id="USE_N"/>
						<label for="USE_N">아니오</label>
					</div>
				</div>
				<div class="item dlvy_amt_area input-hide required btn-with">
					<p  class="tit"><span>배송비</span></p>
					<input type="text" id="DLVY_AMT" name="DLVY_AMT" class="onlyNum" placeholder="숫자만 입력 (원 단위)">
				</div>
				<div class="item dlva_fcon_area input-hide required btn-with">
					<p  class="tit"><span>배송비 무료 조건</span></p>
					<input type="text" id="DLVA_FCON" name="DLVA_FCON" class="onlyNum" placeholder="숫자만 입력 (-원 이상 구매 시)">
				</div>
				<div class="item ps_com_area input-hide">
					<p  class="tit">지정 택배사</p>
					<div class="col-sm-2">
						<p class="form-control-static">
			                <jsp:include page="${ contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="DLVY_COM" />
								<jsp:param name="name" value="PS_COM" />
								<jsp:param name="value" value="${ supplierInfo.PS_COM }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</p>
					</div>
				</div>
				<div class="item apd_prod_area input-hide">
					<p  class="tit">자동구매 확정 기간</p>
					<div class="col-sm-2">
						<p class="form-control-static">
			                <jsp:include page="${ contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="APD_PROD" />
								<jsp:param name="name" value="APD_PROD" />
								<jsp:param name="value" value="${ supplierInfo.APD_PROD }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</p>
					</div>
				</div>
				<input type="hidden" name="SUPR_NAME" id="SUPR_NAME"/>
				<input type="hidden" name="BIZR_NUM" id="BIZR_NUM"/>
				<input type="hidden" name="TEL_NUM" id="TEL_NUM"/>
				<input type="hidden" name="RPR_MAIL" id="RPR_MAIL"/>
				<input type="hidden" name="POST_NUM" id="POST_NUM"/>
				<input type="hidden" name="BASC_ADDR" id="BASC_ADDR"/>
				<input type="hidden" name="DTL_ADDR" id="DTL_ADDR"/>
				<input type="hidden" name="COM_TELN" id="COM_TELN"/>
				<input type="hidden" name="COM_PN" id="COM_PN"/>
				<input type="hidden" name="COM_BADR" id="COM_BADR"/>
				<input type="hidden" name="COM_DADR" id="COM_DADR"/>
			</div>
	
				<p class="border"></p>
	
				<div class="item">
					<div class="bold checkbox">
						<input type="checkbox" name="terms" id="termsAll"/>
						<label for="termsAll">전체약관 동의하기</label>
					</div>
					<div class="checkbox">
						<input type="checkbox" name="terms" id="terms1"/>
						<label for="terms1">[필수] 만 14세 이상입니다.</label>
					</div>
					<div class="checkbox">
						<input type="checkbox" name="terms" id="terms2"/>
						<label for="terms2">[필수] 이용약관 동의</label>
	
						<span class="view terms_cdt1">내용보기</span>
					</div>
					<div class="checkbox">
						<input type="checkbox" name="terms" id="terms3"/>
						<label for="terms3">[필수] 개인정보처리방침 동의</label>
	
						<span class="view terms_cdt2">내용보기</span>
					</div>
					<div class="checkbox">
						<input type="checkbox" name="terms" id="terms4"/>
						<label for="terms4">[선택] 마케팅정보 활용 및 광고성 정보 수신동의</label>
	
						<span class="view terms_cdt3">내용보기</span>
					</div>
				</div>
				<div class="item">
					<div class="felid">
	
					</div>
				</div>
				<div class="item mgt30">
					<button type="button" id="joinBtn">회원가입</button>
				</div>
			</div>
		</form>
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
  $(function() {
		//fn_memb_gbn();	//사업자구분체크
		
		/* 이용약관 모달 */
		$(".terms_condition1").click(function(){
			$('#myModal').modal('show');
		});
		
		/* 개인정보처리방침 모달 */
		$(".terms_condition2").click(function(){
			$('#myModal').modal('show');
		});
		
		/* 아이디 한글입력 안되게 처리 */
		$(".nHangul").keydown(function(){
			$(this).keyup(function(){
				$(this).val( $(this).val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ).trim() );
			});
		});
		
		/* 아이디 중복 체크 */
		$("#chkIdBtn").click(function(){
			var strMembId = $('#MEMB_ID').val();
			$("#MEMB_ID_TMP").val(strMembId);
			
			if($("#MEMB_ID").val() == '') {
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("아이디를 입력해 주세요.");
				$("#MEMB_ID").focus();
				$('#MEMB_CHK_YN').val("N");
				return false;
			}
			
			$.ajax({
				type: "POST",
				url: "${contextPath}/idChk",
				data: $("#idChkFrm").serialize(),
				success: function (data) {
					var strMembIdTrim = strMembId.trim();
					var re = /\s/g;
					var special_pattern = /[,.`~!@#$%^&*|\\\'\";:\/?]/gi;
					var eng = /^[a-z]+[a-zA-Z0-9]{4,15}$/g;
					
					if(strMembId != strMembIdTrim || re.test(strMembId)){
						$('.layer-popup').addClass('on');
						$('.casa-msg').html("아이디에 공백이 들어갈 수 없습니다");
						$('#MEMB_CHK_YN').val("N");
						
					} else if(special_pattern.test(strMembId)) {
						$('.layer-popup').addClass('on');
						$('.casa-msg').html("아이디에 특수문자가 들어갈 수 없습니다");
						$('#MEMB_CHK_YN').val("N");
						
					} else if(!eng.test(strMembId)) {
						$('.layer-popup').addClass('on');
						$('.casa-msg').html("아이디는 영문자와 숫자를 포함한 5~16자리의 문자여야 합니다");
						$('#MEMB_CHK_YN').val("N");
						
					} else{
						// 아이디 중복 여부
						if (data == '0') {
							$('.layer-popup').addClass('on');
							$('.casa-msg').html("사용 가능한 아이디입니다");
							$('#MEMB_CHK_YN').val("Y");
						}else{
							$('.layer-popup').addClass('on');
							$('.casa-msg').html("이미 사용중인 아이디입니다");
							$('#MEMB_CHK_YN').val("N");
						}
					}
				}, error: function (jqXHR, textStatus, errorThrown) {
					alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
				}
			});
		});
		
		/* email체크 함수 */
		function chk_email(strEmail) {		
			/* 
			 * 이메일의 값은 단순히 문자이며, 이것을 객체화시켜서 비교한다.
			 * ^는 반드시 이런형식으로 시작하라 $는 반드시 요런형식으로 종료
			 * {3,20} 3~20글자만쓸수있다.
			 */
			var em = strEmail;
			var epattern = new RegExp("^([a-zA-Z0-9\-\_]{3,20})" + "@" + "([a-zA-Z0-9\-\_]{3,20})" + "." + "([a-zA-Z0-9\-\_\.]{3,5})$");
			if (!epattern.test(em)) {
				return false;
			}
			return true;
		}
		
		/* 휴대폰 번호 숫자만 입력 */
		$(".onlyNum").keydown(function(){
			$(this).keyup(function(){
				$(this).val($(this).val().replace(/[^0-9]/g,""));
			});
		});
		
		/* 회원 구분 */
		$(function () {
			$('#MEMB_GUBN_01').click(function() {
				$('.com_bunb_area').hide();
				$('.com_name_area').hide();
				$('.rprs_name_area').hide();
				$('.cacoop_no_area').hide();
				$('#MEMB_GUBN_02').prop("checked", false);
				$('#MEMB_GUBN_04').prop("checked", false);
			});
			
			$('#MEMB_GUBN_02').click(function() {
				$('.com_bunb_area').show();
				$('.com_name_area').show();
				$('.rprs_name_area').hide();
				$('.cacoop_no_area').hide();
				$('#MEMB_GUBN_01').prop("checked", false);
				$('#MEMB_GUBN_04').prop("checked", false);
			});
			
			$('#MEMB_GUBN_04').click(function() {
				$('.com_bunb_area').show();
				$('.com_name_area').show();
				$('.rprs_name_area').show();
				$('.cacoop_no_area').show();
				$('.dlvy_amt_area').show();
				$('.dlva_fcon_area').show();
				$('.ps_com_area').show();
				$('.apd_prod_area').show();
				$('#MEMB_GUBN_01').prop("checked", false);
				$('#MEMB_GUBN_02').prop("checked", false);
			});
		});
		
		/* 공급사 구분 */
		$(function () {
			$('#USE_Y').click(function() {
				$('.dlvy_amt_area').show();
				$('.dlva_fcon_area').show();
				$('.ps_com_area').show();
				$('.apd_prod_area').show();
				$('#USE_N').prop("checked", false);
			});
			
			$('#USE_N').click(function() {
				$('.dlvy_amt_area').hide();
				$('.dlva_fcon_area').hide();
				$('.ps_com_area').hide();
				$('.apd_prod_area').hide();
				$('#USE_Y').prop("checked", false);
			});
		});
		
		/* 전체약관 동의 시 전체 선택 */
		$("#termsAll").click(function() {
			if($("#termsAll").is(":checked")) {
				$("input[name=terms]").prop("checked", true);
			} else $("input[name=terms]").prop("checked", false);
		});
		
		/* 회원가입 버튼 눌렀을 때 검사 */
		$('#joinBtn').click(function() {
			if($("input:checkbox[name=MEMB_GUBN]:checked").length == 0){
    			alert("회원 구분을 선택해주세요.");
    			$("#MEMB_GUBN_01").focus();
    			return false;
    		}
			
			if($("#MEMB_ID").val() == ""){
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("아이디를 입력해 주세요.");
				$("#MEMB_ID").focus();
				return false;
			}
			
			/* 아이디 중복확인 체크 */
			if($("#MEMB_CHK_YN").val() == "N"){
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("아이디 중복을 확인해 주세요.");
				$("#MEMB_ID").focus();
				return false;
			}
			
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
			
			if($("#MEMB_NAME").val() == ""){
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("이름을 입력해 주세요.");
				$("#MEMB_NAME").focus();
				return false;
			}
			
			if($("#MEMB_MAIL").val() == ""){
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("이메일을 입력해 주세요.");
				$("#MEMB_MAIL").focus();
				return false;
			}
			
			if($("#MEMB_PHONE").val() == ""){
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("휴대폰 번호를 입력해 주세요.");
				$("#MEMB_PHONE").focus();
				return false;
			}
			
/* 			if($("#MEMB_TEL").val() == ""){
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("전화번호를 입력해 주세요.");
				$("#MEMB_TEL").focus();
				return false;
			} */
			
			/* 주소 */
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
			
			/* 이메일 형식 체크 */
			if(!$("#MEMB_MAIL").val()) return;
			
			if(!chk_email($("#MEMB_MAIL").val())){
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("e-mail 형식이 아닙니다.");
				$("#MEMB_MAIL").select();
				return;
			}
			
			/* 번호 양식 통일 */
			var phone = $('#MEMB_PHONE').val();
			var tel = $('#MEMB_TEL').val();
			var bun = $('#COM_NUM').val();
			var membTel = "";
			if(phone.length == 11){
				membMobile = phone.substring(0,3)+"-"+phone.substring(3,7)+"-"+phone.substring(7,12);
			}
			
			if(tel.length == 9){
				membTel = tel.substring(0,2)+"-"+tel.substring(2,5)+"-"+tel.substring(5,10);
			} else if(tel.length == 10){
				membTel = tel.substring(0,2)+"-"+tel.substring(2,6)+"-"+tel.substring(6,11);
			} else if(tel.length == 11){
				membTel = tel.substring(0,3)+"-"+tel.substring(3,7)+"-"+tel.substring(7,12);
			}
			
			if(bun != null || bun != '') {
				comBunb = bun.substring(0,3)+"-"+bun.substring(3,5)+"-"+bun.substring(5,10);
				$('#COM_BUNB').val(comBunb);
			} 
			
			$('#MEMB_CPON').val(membMobile);
			if(membTel != "" || membTel != null) {
				$('#MEMB_TELN').val(membTel);			
			}
			
			// 회원 주소 체크
			if(!$('#MEMB_PN').val()){
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("우편번호와 주소는 필수값입니다.");
				return;
			}
			
			/* 비밀번호 조합 체크 */
			var uid = $("#MEMB_ID").val();
			var upw = $("#MEMB_PW").val();
			var reupw = $("#MEMB_PW_RE").val();
			var mempw = $("#MEMB_PW");
			var memreupw = $("#MEMB_PW_RE");
			
			if(upw != ""){
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
			if (reupw != upw && upw != ''){
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("비밀번호가 일치하지 않습니다. 비밀번호를 확인해주세요.");
				memreupw.val('');
				memreupw.focus();
				return;
			}
			
			/* 사업자 회원일 때 */
			if($('#MEMB_GUBN_02').is(':checked')) {
				if($("#COM_NAME").val() == ""){
					$('.layer-popup').addClass('on');
					$('.casa-msg').html("회사명을 입력해 주세요.");
					$("#COM_NAME").focus();
					return false;
				}
				
				var comNum = $("#COM_NUM").val();
				if(comNum == ""){
					$('.layer-popup').addClass('on');
					$('.casa-msg').html("사업자 번호를 입력해 주세요.");
					$("#COM_NUM").focus();
					return false;
				}
				
				// 사업자번호 길이 체크
				if(comNum.length < 10){
					$('.layer-popup').addClass('on');
					$('.casa-msg').html("사업자 번호를 확인해 주세요.");
					return;
				}
			}
			
			/* 조합원일 때 */
			if($('#MEMB_GUBN_04').is(':checked')) {
				if($("#COM_NAME").val() == ""){
					$('.layer-popup').addClass('on');
					$('.casa-msg').html("회사명을 입력해 주세요.");
					$("#COM_NAME").focus();
					return false;
				}
				
				if($("#RPRS_NAME").val() == ""){
					$('.layer-popup').addClass('on');
					$('.casa-msg').html("대표자명을 입력해 주세요.");
					$("#RPRS_NAME").focus();
					return false;
				}
				
				var comNum = $("#COM_NUM").val();
				if(comNum == ""){
					$('.layer-popup').addClass('on');
					$('.casa-msg').html("사업자 번호를 입력해 주세요.");
					$("#COM_NUM").focus();
					return false;
				}
				
				// 사업자번호 길이 체크
				if(comNum.length < 10){
					$('.layer-popup').addClass('on');
					$('.casa-msg').html("사업자 번호를 확인해 주세요.");
					return;
				}
				
				/* if($("#CACOOP_NO").val() == ""){
					$('.layer-popup').addClass('on');
					$('.casa-msg').html("조합원 번호를 입력해 주세요.");
					$("#CACOOP_NO").focus();
					return false;
				} */
				
				/* 공급사일 때 */
				if($('#USE_Y').is(':checked')) {
					if($("#DLVY_AMT").val() == ""){
						$('.layer-popup').addClass('on');
						$('.casa-msg').html("배송비를 입력해 주세요.");
						$("#DLVY_AMT").focus();
						return false;
					}
					
					if($("#DLVA_FCON").val() == ""){
						$('.layer-popup').addClass('on');
						$('.casa-msg').html("배송비 무료 조건을 입력해 주세요.");
						$("#DLVA_FCON").focus();
						return false;
					}
					
					if($("#PS_COM").val() == ""){
						$('.layer-popup').addClass('on');
						$('.casa-msg').html("지정 택배사를 선택해 주세요.");
						$("#DLVY_COM").focus();
						return false;
					}
					
					if($("#APD_PROD").val() == ""){
						$('.layer-popup').addClass('on');
						$('.casa-msg').html("자동구매 확정기간을 선택해 주세요.");
						$("#APD_PROD").focus();
						return false;
					}
				}
				
				$('#BIZR_NUM').val($('#COM_BUNB').val());
				$('#TEL_NUM').val($('#MEMB_TELN').val());
				$('#RPR_MAIL').val($('#MEMB_MAIL').val());
				$('#BASC_ADDR').val($('#MEMB_BADR').val());
				$('#DTL_ADDR').val($('#MEMB_DADR').val());
				$('#SUPR_NAME').val($('#COM_NAME').val());
			}
			
			/* 사업자나 조합원일 때 */
			if($('#MEMB_GUBN_02').is(':checked') || $('#MEMB_GUBN_04').is(':checked')) {
				$('#COM_TELN').val($('#MEMB_TELN').val());
				$('#COM_PN').val($('#MEMB_PN').val());
				$('#COM_BADR').val($('#MEMB_BADR').val());
				$('#COM_DADR').val($('#MEMB_DADR').val());
			}
			
			/* 약관동의  체크 */
			if(!$("#terms1").is(":checked")) {
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("만 14세 이상에 동의하셔야 회원가입이 가능합니다.");
				$("#terms1").focus();
				return;
			} else if(!$("#terms2").is(":checked")) {
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("이용약관에 동의하셔야 회원가입이 가능합니다.");
				$("#terms2").focus();
				return;
			} else if(!$("#terms3").is(":checked")) {
				$('.layer-popup').addClass('on');
				$('.casa-msg').html("개인정보처리방침에 동의하셔야 회원가입이 가능합니다.");
				$("#terms3").focus();
				return;
			}
			
			$("#fregisterform").submit();
		});
	});
	
	/* 모달창 확인 눌렀을 때 */
	$('.btn-pop-next').click(function() {
		$(".layer-popup").removeClass("on");
	});
	
	function passwordCheck() {
		const userId = document.querySelector("#MEMB_ID");
		const pass = document.querySelector("#MEMB_PW");
		const pass2 = document.querySelector("#MEMB_PW_RE");
		const passCheck = document.querySelector("#passCheck");
		
		if(pass.value != "") {
			let chk_num = pass.value.search(/[0-9]/g); 
			let chk_eng = pass.value.search(/[a-z]/ig);
			let chk_spe = pass.value.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
			
			if(!/^(?=.*[a-zA-Z0-9])((?=.*\d)|(?=.*\W)).{5,20}$/.test(pass.value)) {
				passCheck.innerHTML = "비밀번호는 숫자와 영문자, 특수문자를 포함한 5~20자리 문자를 입력해야 합니다.";
				passCheck.className = "add red";
				return;
			} else if((chk_num < 0 || chk_eng < 0 || chk_spe < 0)) {
				passCheck.innerHTML = "비밀번호는 숫자와 영문자, 특수문자를 혼용하여야 합니다.";
				passCheck.className = "add red";
				return;
			} else if(/(\w)\1\1\1/.test(pass.value)) {
				passCheck.innerHTML = "비밀번호에 같은 문자를 4번 이상 사용하실 수 없습니다.";
				passCheck.className = "add red";
				return;
			}else if(pass.value.includes(userId.value) && userId != "") {
				passCheck.innerHTML = "ID가 포함된 비밀번호는 사용하실 수 없습니다.";
				passCheck.className = "add red";
				return;
			} else if(pass2.value != pass.value && pass.value != ""){
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
  </script>
 </body>
</html>