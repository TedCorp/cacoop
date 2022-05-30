<%--
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:set var="strActionUrl" value="${contextPath }/m/wishList" />
<c:set var="strMethod" value="post" />

<script type="text/javascript">
	$(document).ready(function() {
		/* 사업자구분체크 */
		fn_memb_gbn();
		
		/* 개점, 폐점 */
		<c:if test="${!empty obj.COM_OPEN }">
			$('#COM_OPEN_HH').val('${obj.COM_OPEN_HH }');
			$('#COM_OPEN_MM').val('${obj.COM_OPEN_MM }');
		</c:if>
		<c:if test="${!empty obj.COM_CLOSE }">
			$('#COM_CLOSE_HH').val('${obj.COM_CLOSE_HH }');
			$('#COM_CLOSE_MM').val('${obj.COM_CLOSE_MM }');
		</c:if>
		
		/* 비밀번호 변경 팝업 */
		$("#btnModal").click(function(){
			var sha256 = "";
			console.log($("#PRE_PW").val());
			if(!$("#MEMB_PW").val()){
			   alert("비밀번호를 입력해주세요.");
			   $("#MEMB_PW").focus();
			   return;
			}
			
			// 비밀번호 확인			
		    $.ajax({
		        type:'POST',
		        dataType : "text",
		        url:"${contextPath}/m/sha256.json",
		        data: { "password" : $("#MEMB_PW").val() },
		        success:function(data){
		        	sha256 = data;
		        	console.log("sha256 >> "+data);
					if(sha256 != $("#PRE_PW").val()){
					   alert("비밀번호가 일치하지 않습니다. 현재 비밀번호를 확인해주세요.");
					   $("#MEMB_PW").focus();
					   return;
					}
					
					$('#pwModal').modal('show');
		        },
		        error : function(request, status, error) {
        			alert("list search fail :: error code: " + request.status + "\n" + "error message: " + error + "\n");
        		}
		    });
		});
		
		/* 비밀번호 변경 */
		$("#btnCng").click(function(){
			// 변경 비밀번호 확인
			if(!$("#CNG_PW").val()){
			   alert("변경할 비밀번호를 입력해주세요.");
			   $("#CNG_PW").focus();
			   return;
			}
			if($("#CNG_PW").val() != $("input[name='RE_CNG_PW']").val()){
			   alert("비밀번호가 일치하지 않습니다. 변경할 비밀번호를 확인해주세요.");
			   $("input[name='RE_CNG_PW']").focus();
			   return;
			}
			
			$("#ajaxfrm").submit();
		});
		
		/* 비밀번호 조합 체크 */
		$("#CNG_PW").change(function(){
			var uid = $("input[name='MEMB_ID']").val();
			var upw = $(this).val();
			
			if(upw != ""){
			    var chk_num = upw.search(/[0-9]/g); 
			    var chk_eng = upw.search(/[a-z]/ig);
				
				if(!/^[a-zA-Z0-9]{5,20}$/.test(upw)) { 
			        alert('비밀번호는 숫자와 영문자 조합으로 5~12자리를 사용해야 합니다.');
			        $(this).val('');
			        $(this).focus();
			        return;
			    }				
			    if((chk_num < 0 || chk_eng < 0)) { 
			        alert('비밀번호는 숫자와 영문자를 혼용하여야 합니다.'); 
			        $(this).val('');
			        $(this).focus();
			        return;
			    }
			    if(/(\w)\1\1\1/.test(upw)) {
			        alert('비밀번호에 같은 문자를 4번 이상 사용하실 수 없습니다.'); 
			        $(this).val('');
			        $(this).focus();
			        return;
			    }
			    if(upw.includes(uid)) {
			        alert('ID가 포함된 비밀번호는 사용하실 수 없습니다.'); 
			        $(this).val('');
			        $(this).focus();
			        return;
			    }
			    if(upw == $("#MEMB_PW").val()){
			    	alert('이전 비밀번호와 같습니다.'); 
			        $(this).val('');
			        $(this).focus();
			        return;
			    }
			}
			
			$("input[name='RE_CNG_PW']").focus();
		});
		
		/* 저장 */
		$("#btnSave").click(function(){
			// 현재 비밀번호 체크
			/* if(!$("#MEMB_PW").val()){
			   alert("비밀번호를 입력해주세요.");
			   $("#MEMB_PW").focus();
			   return;
			} */
			/* 
			// 현재 비밀번호 확인_20200903 비밀번호 암호화로 주석
			if($("#MEMB_PW").val() != $("#PRE_PW").val()){
				console.log($("#PRE_PW").val());
				alert("비밀번호가 다릅니다. 현재 비밀번호를 확인해주세요.");
				$("#MEMB_PW").focus();
				return;
			} */
			
			//console.log(sha256Chk());
			//if(!sha256Chk()) { console.log('비밀번호 틀림'); return; } else { console.log('비밀번호 맞음'); }
			
			// 생일
			var membBtdyYear = $('#MEMB_BTDY_YEAR').val();
			var membBtdyMonth = $('#MEMB_BTDY_MONTH').val();
			var membBtdyDay = $('#MEMB_BTDY_DAY').val();
			
			$('#MEMB_BTDY').val(membBtdyYear+(LPAD(membBtdyMonth,'0',2))+(LPAD(membBtdyDay,'0',2)));
			
			// 휴대폰번호 유효성
			if($("#MEMB_CPON1").val()!='010' && $("#MEMB_CPON1").val()!='011' && $("#MEMB_CPON1").val()!='016'
					&& $("#MEMB_CPON1").val()!='017' && $("#MEMB_CPON1").val()!='019'){
				alert("핸드폰번호를 확인해 주십세요.");
				$("#MEMB_CPON1").focus();
				return false;
			}
					
			// 휴대폰번호
			var membMobile1 = $('#MEMB_CPON1').val();
			var membMobile2 = $('#MEMB_CPON2').val();
			var membMobile3 = $('#MEMB_CPON3').val();
			var membMobile = membMobile1+membMobile2+membMobile3;
			
			if(membMobile.length > 9){
				membMobile = membMobile1+"-"+membMobile2+"-"+membMobile3;
			} 
			console.log("MEMB_CPON"+membMobile);
			$('#MEMB_CPON').val(membMobile);
			
			// 전화번호
			var membPhone1 = $('#MEMB_TELN1').val();
			var membPhone2 = $('#MEMB_TELN2').val();
			var membPhone3 = $('#MEMB_TELN3').val();
			var membPhone = membPhone1+membPhone2+membPhone3;
			
			if(membPhone.length > 7){
				membPhone = membPhone1+"-"+membPhone2+"-"+membPhone3;
			} 
			console.log("MEMB_TELN"+membPhone);
			$('#MEMB_TELN').val(membPhone);
			
			// 이메일 조합 체크_20200903 연동필수값 제외로 주석
			// 20201207 .. 체크해달라함..ㅇㅅㅇ;
			if(!chk_email($("#MEMB_MAIL").val())){
			   alert("e-mail 형식이 아닙니다.");
			   $("#MEMB_MAIL").focus();
			   return false;
			}
			// 우편번호 체크
			if(!$("#MEMB_PN").val()){
				alert("우편번호와 주소는 필수값입니다.");
				return false;
			}
			
			/* 사업자일 경우 필수값 체크 */
			if(!($('#ERP_LIST').css("display")=="none")){
				// 회사번호
				var comTel1 = $('#COM_TELN1').val();
				var comTel2 = $('#COM_TELN2').val();
				var comTel3 = $('#COM_TELN3').val();
				var comTel = comTel1+comTel2+comTel3
				
				if(comTel.length > 7){
					comTel = comTel1+"-"+comTel2+"-"+comTel3;
				} 
				console.log("COM_TELN"+comTel);
				$('#COM_TELN').val(comTel);
				
				// 사업자번호 중복체크
				if($('#COM_CHK_YN').val() == "N"){
				   alert("사업자등록번호를 확인 해주세요");
				   $("#COM_BUNB").focus();
				   return false;   
				}
				
				var strComBunb = $("#COM_BUNB").val().replace(/-/gi, "");
				strComBunb = fn_comFormat(strComBunb);
				$("#COM_BUNB").val(strComBunb);
				
				// 매장 운영시간
				$('#COM_OPEN').val($('#COM_OPEN_HH').val()+":"+$('#COM_OPEN_MM').val());
				$('#COM_CLOSE').val($('#COM_CLOSE_HH').val()+":"+$('#COM_CLOSE_MM').val());				
			}
			
			// 사업자 구분
			if($('input:radio[name="MEMB_GUBN"]:checked').val() == 'MEMB_GUBN_01'){
				$('#COM_NAME').val('');
				$('#COM_BUNB').val('');
				$('#COM_TELN').val('');
				$('#COM_EXTRA_ADDR').val('');
				$('#COM_ALL_ADDR').val('');
				$('#COM_PN').val('');
				$('#sameChk').val('');
				$('#COM_BADR').val('');
				$('#COM_DADR').val('');
				$('#COM_OPEN_HH').val('');
				$('#COM_OPEN_MM').val('');
				$('#COM_OPEN').val('');
				$('#COM_CLOSE_HH').val('');
				$('#COM_CLOSE_MM').val('');
				$('#COM_CLOSE').val('');
				$('#KEEP_LOCATION').val('');	
			}
			
			$("#fregisterform").submit();
		});
		
		/* 사업자번호 중복체크
		$("#COM_BUNB").change(function(){
			var strComBunb = $(this).val().replace(/-/gi,"");

			if(strComBunb.length==0){
			   $('#COM_CHK_YN').val("N");
			   return;
			}

			if(strComBunb.length != 10){
				$('#COM_BUNB_CHK_MSG').html("<span><font color='red'>사업자번호 자릿수를 확인해 주세요</font></span>");
				$('#COM_CHK_YN').val("N");
				
			}else{
				var preComBunb = $("#BEF_COM_BUNB").val().replace(/-/gi,"");
				
				if(preComBunb == strComBunb){
					$('#COM_BUNB_CHK_MSG').html("<span><font color='blue'>기존 사업자번호 입니다.</font></span>");
					$('#COM_CHK_YN').val("Y");
					
				}else{
					$("#COM_BUNB_TMP").val(strComBunb);
					
					$.ajax({
						type:"POST",
						url:"${contextPath }/comBunbChk",
						data: $("#bunbChkFrm").serialize(),
						success: function (data) {						
							// 사업자번호 중복 여부
							if (data == '0') {
								$('#COM_BUNB_CHK_MSG').html("<span><font color='blue'>사용할 수 있는 사업자번호입니다.</font></span>");
								$('#COM_CHK_YN').val("Y");
							}else{
								$('#COM_BUNB_CHK_MSG').html("<span><font color='red'>중복된 사업자번호입니다</font></span>");
								$('#COM_CHK_YN').val("N");
							}
						}, error: function (jqXHR, textStatus, errorThrown) {
							alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
						}
					});
				}
			}
		});
		 */
		/* 숫자만 입력 */
		$(".onlyNum").keydown(function(){
			$(this).keyup(function(){
				$(this).val($(this).val().replace(/[^0-9]/g,""));
			});
		});

		/* 이메일 한글입력 안되게 처리 */
		$("#MEMB_MAIL").keydown(function(){
			$(this).keyup(function(){
				$(this).val( $(this).val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ).trim() );
			});			
		});
	});
	
	/* 왼쪽에서부터 채운다는 의미 */
	function LPAD(s, c, n) {
	    if (! s || ! c || s.length >= n) {
	        return s;
	    }
	    var max = (n - s.length)/c.length;
	    for (var i = 0; i < max; i++) {
	        s = c + s;
	    }
	    return s;
	}
	
	/* email 조합 체크 */
	function chk_email(strEmail) {	
	   /*
	    * 이메일의 값은 단순히 문자이다 이것을 객체화시켜서 비교한다.
	    * ^는 반드시 이런형식으로 시작하라 $는 반드시 요런형식으로 종료
	    * {3,20} 3~20글자만쓸수있다.
	    */	   
	   var em = strEmail;
	   //var epattern = new RegExp("^([a-zA-Z0-9\-\_]{3,20})" + "@" + "([a-zA-Z0-9\-\_]{3,20})" + "." + "([a-zA-Z0-9\-\_\.]{3,5})$");
	   var epattern = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	   console.log("-----")
	   if (!epattern.test(em)) {
	      return false;
	   }
	   return true;
	}
	
	/* 개인정보 동일체크 */
	function same_chk(){
	   if($('#sameChk').prop('checked')==true){
	      $('#COM_PN').val($('#MEMB_PN').val());
	      $('#COM_BADR').val($('#MEMB_BADR').val());
	      $('#COM_DADR').val($('#MEMB_DADR').val());
	   }else{
	      $('#COM_PN').val('');
	      $('#COM_BADR').val('');
	      $('#COM_DADR').val('');
	   }
	}
	
	/* 회원구분 선택 */
	function fn_memb_gbn(){
		if($('input:radio[name="MEMB_GUBN"]:checked').val() == 'MEMB_GUBN_02'
			||$('input:radio[name="MEMB_GUBN"]:checked').val() == 'MEMB_GUBN_04'){
			
			$('#ERP_LIST').show();
			$('#COM_NAME').attr("required","");
			$('#COM_BUNB').attr("required","");
			
			var strcombunb = $('#COM_BUNB').val().replace(/-/gi, "");
			
			if(!strcombunb){
				if(strcombunb.length == 10){
					$('#COM_NAME').attr("readonly",true);
					$('#COM_BUNB').attr("readonly",true);
					$('#COM_BUNB').removeAttr("onblur");
				}
			}
		}else{
			$('#ERP_LIST').hide();
			$('#COM_NAME').removeAttr("required");
			$('#COM_BUNB').removeAttr("required");
		}
	}
	
	/* 사업자번호 포멧 */
	function fn_comFormat(num) {
		var formatNum = '';
		try{
			if (num.length == 10) {
				formatNum = num.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3');
			}
		} catch(e) {
			formatNum = num;
			console.log(e);
		}
		return formatNum;
	}
	
	function sha256Chk(){		
		// 비밀번호 확인			
	    $.ajax({
	        type:'POST',
	        dataType : "text",
	        url:"${contextPath}/m/sha256.json",
	        data: { "password" : $("#MEMB_PW").val() },
	        success:function(data){
	        	sha256 = data;
	        	console.log("sha256 >> "+data);
				if(sha256 != $("#PRE_PW").val()){
				   alert("비밀번호가 일치하지 않습니다. 현재 비밀번호를 확인해주세요.");
				   $("#MEMB_PW").focus();
				   return;
				}			
	        },
	        error : function(request, status, error) {
				alert("list search fail :: error code: " + request.status + "\n" + "error message: " + error + "\n");
			}
	    });
	}	
</script>

<form id="bunbChkFrm" name="bunbChkFrm" action="${contextPath }/comBunbChk" method="post" autocomplete="off">
   <input type="hidden" name="COM_BUNB_TMP" id="COM_BUNB_TMP" />
</form>

<!-- Main Container  -->
<div class="main-container container">
	<ul class="breadcrumb">
		<li><a href="${contextPath }/m"><i class="fa fa-home"></i></a></li>
		<li><a href="${contextPath }/m/mypage">마이페이지</a></li>
	</ul>
	
	<div class="row">
		<div class="col-sm-12" id="content">
			<h2 class="title">마이페이지</h2>
		    <form class="form-horizontal account-register clearfix" name="fregisterform" id="fregisterform" method="post" action="${contextPath }/m/mypage/memberUpdate" autocomplete="off">
				<input type="hidden" id="MEMB_CHK_YN" name="MEMB_CHK_YN" value="N"/>
				<input type="hidden" id="COM_CHK_YN" name="COM_CHK_YN" value="Y"/>
           		<input type="hidden" id="BANK_NAME" name="BANK_NAME" value="${obj.BANK_NAME }">
				<input type="hidden" id="BANK_BUNB" name="BANK_BUNB" value="${obj.BANK_BUNB }">
				<input type="hidden" id="PRE_PW" value="${obj.MEMB_PW }">
			
				<fieldset id="account">
					<legend>
						기본정보
						<small class="ml_5"> - 필수 입력</small>
					</legend>
					
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="MEMB_GUBN">회원구분</label>
						<div class="col-sm-9">
							<label class="radio-inline">
								<input type="radio" name="MEMB_GUBN" value="MEMB_GUBN_02" required ${ obj.MEMB_GUBN == 'MEMB_GUBN_02' ? 'checked' : '' } onclick="return(false)"> 사업자
							</label>
							<label class="radio-inline">
								<input type="radio" name="MEMB_GUBN" value="MEMB_GUBN_01" required ${ obj.MEMB_GUBN == 'MEMB_GUBN_01' ? 'checked' : '' } onclick="return(false)"> 개인
							</label>
							<!-- <label class="radio-inline">
								<input type="radio" name="MEMB_GUBN" value="MEMB_GUBN_04" required ${ obj.MEMB_GUBN == 'MEMB_GUBN_04' ? 'checked' : '' } onclick="return(false)"> 도매유통사업자	사업자 수정 불가 = fn_memb_gbn()
							</label>
               				<h5 style="color:red">* 도매유통사업자 회원가입시 쇼핑몰주문시 배송불가능할수도 있습니다. (사전 협의 필수)</h5> -->
						</div>
					</div>
					
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="MEMB_ID">아이디</label>
						<div class="col-sm-4">${obj.MEMB_ID }</div>
					</div>
					
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="MEMB_PW">비밀번호</label>
						<div class="col-sm-9">
							<div class="form-inline">
								<div class="input-group">
									<input type="password" class="form-control" name="MEMB_PW" id="MEMB_PW" placeholder="현재 비밀번호" value="" required>
									 ${obj.MEMB_PW }
									<span class="input-group-btn">
										<input type="button" class="btn btn-warning" id="btnModal" value="비밀번호 변경">
									</span>								
								</div>
							</div>
							<span style="color:red">* 초기비밀번호는 아이디와 동일합니다</span>
						</div>						
					</div>
					
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="MEMB_NAME">이름</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" name="MEMB_NAME" id="MEMB_NAME" value="${obj.MEMB_NAME }" placeholder=이름(대표자성명) required>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label" for="MEMB_SEX">성별</label>
						<div class="col-sm-9">
							<jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="MEMB_SEX" />
								<jsp:param name="name" value="MEMB_SEX" />
								<jsp:param name="value" value="${ obj.MEMB_SEX }" />
								<jsp:param name="type" value="radio" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label" for="MEMB_BTDY_YEAR">생년월일</label>
						<div class="col-sm-4">
							<div class="form-inline">
								<select class="form-control" name="MEMB_BTDY_YEAR" id="MEMB_BTDY_YEAR">
									<c:forEach var="i" begin="0" end="${TODAY_YEAR - 1950 }" step="1">
										<option value="${i + 1950}" ${fn:substring(obj.MEMB_BTDY,0,4) eq i+1950 ? 'selected' : ''}>${i + 1950}년</option>
									</c:forEach>  
								</select>&nbsp;
								<select class="form-control" name="MEMB_BTDY_MONTH" id="MEMB_BTDY_MONTH">
									<c:forEach var="i" begin="1" end="12" step="1">
										<option value="${i}" ${fn:substring(obj.MEMB_BTDY,4,6) eq i ? 'selected' : ''}>${i}월</option>
									</c:forEach>  
								</select>&nbsp;
								<select class="form-control" name="MEMB_BTDY_DAY" id="MEMB_BTDY_DAY">
									<c:forEach var="i" begin="1" end="31" step="1">
										<option value="${i}" ${fn:substring(obj.MEMB_BTDY,6,8) eq i ? 'selected' : ''}>${i}일</option>
									</c:forEach>  
								</select>
								<div class="input-group mg-left-10">
									<jsp:include page="/common/comCodForm">
										<jsp:param name="COMM_CODE" value="SLCAL_GUBN" />
										<jsp:param name="name" value="SLCAL_GUBN" />
										<jsp:param name="value" value="${ obj.SLCAL_GUBN }" />
										<jsp:param name="type" value="radio" />
										<jsp:param name="top" value="선택" />
									</jsp:include>
									<input type="hidden" name="MEMB_BTDY" id="MEMB_BTDY" value="" >
								</div>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label" for="MEMB_TELN1">전화번호</label>
						<div class="col-sm-10">
							<div class="form-inline">
								<input type="hidden" name="MEMB_TELN" id="MEMB_TELN" value="" >
								<input type="tel" class="form-control onlyNum" name="MEMB_TELN1" id="MEMB_TELN1" value="${fn:split(obj.MEMB_TELN,'-')[0]}" style="width:60px; display: inline-block;" maxlength="3">&nbsp;-&nbsp;
								<input type="tel" class="form-control onlyNum" name="MEMB_TELN2" id="MEMB_TELN2" value="${fn:split(obj.MEMB_TELN,'-')[1]}" style="width:60px; display: inline-block;" maxlength="4">&nbsp;-&nbsp;
								<input type="tel" class="form-control onlyNum" name="MEMB_TELN3" id="MEMB_TELN3" value="${fn:split(obj.MEMB_TELN,'-')[2]}" style="width:60px; display: inline-block;" maxlength="4">
							</div>
						</div>
					</div>
					
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="MEMB_CPON1">휴대폰번호</label>
						<div class="col-sm-10">
							<div class="form-inline">
								<input type="hidden" name="MEMB_CPON" value="" id="MEMB_CPON" >
								<input type="tel" class="form-control onlyNum" name="MEMB_CPON1" id="MEMB_CPON1" value="${fn:split(obj.MEMB_CPON,'-')[0]}" required style="width:60px; display: inline-block;" maxlength="3">&nbsp;-&nbsp;
								<input type="tel" class="form-control onlyNum" name="MEMB_CPON2" id="MEMB_CPON2" value="${fn:split(obj.MEMB_CPON,'-')[1]}" required style="width:60px; display: inline-block;" maxlength="4">&nbsp;-&nbsp;
								<input type="tel" class="form-control onlyNum" name="MEMB_CPON3" id="MEMB_CPON3" value="${fn:split(obj.MEMB_CPON,'-')[2]}" required style="width:60px; display: inline-block;" maxlength="4">
							</div>
						</div>
					</div>
					
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="MEMB_MAIL">이메일</label>
						<div class="col-sm-4">
							<input type="email" class="form-control" name="MEMB_MAIL" id="MEMB_MAIL" value="${obj.MEMB_MAIL }" placeholder="이메일" >
							<!-- <span style="color:red">* 비밀번호 찾기시 이용됩니다. 사용가능한 이메일을 입력해주세요.</span> -->
						</div>							
					</div>
					
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="MEMB_PN">우편번호</label>
						<div class="col-sm-10">
							<input type="hidden" name="EXTRA_ADDR" id="EXTRA_ADDR" value="">
							<input type="hidden" name="ALL_ADDR" id="ALL_ADDR" value="">
							
							<div class="form-inline">
								<div class="input-group">
									<input type="text" class="form-control" name="MEMB_PN" id="MEMB_PN" value="${obj.MEMB_PN }" placeholder="우편번호" readonly="readonly" maxlength="6" required>
									<span class="input-group-btn">
										<input type="button" class="btn btn-info" value="주소검색" onclick="win_zip('fregisterform', 'MEMB_PN', 'MEMB_BADR', 'MEMB_DADR', 'EXTRA_ADDR', 'ALL_ADDR');">
									</span>
								</div>
							</div> 
						</div>
					</div>
					
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="MEMB_BADR">기본주소</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" name="MEMB_BADR" id="MEMB_BADR" value="${obj.MEMB_BADR }" placeholder="기본주소" readonly="readonly" required>
						</div>
					</div>
					
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="MEMB_DADR">상세주소</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" name="MEMB_DADR" id="MEMB_DADR" value="${obj.MEMB_DADR }" placeholder="상세주소" required>
						</div>
					</div>					
				</fieldset>
				
				<fieldset id="ERP_LIST">
					<legend>
						추가정보(사업자)
						<small class="ml_5"> - 사업자 필수 입력항목</small>
					</legend>
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="COM_NAME">상호명</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" name="COM_NAME" id="COM_NAME" value="${obj.COM_NAME }" placeholder="상호명" readonly="readonly">
						</div>
					</div>
					
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="COM_BUNB">사업자등록번호</label>
						<div class="col-sm-4">
							<input type="hidden" id="BEF_COM_BUNB" value="${obj.COM_BUNB }"/>
							<input type="text" class="form-control onlyNum" name="COM_BUNB" id="COM_BUNB" value="${obj.COM_BUNB }" placeholder="-를 제외하고 적어주세요" maxlength="10" readonly="readonly">
							<div id="COM_BUNB_CHK_MSG"></div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label" for="COM_TELN1">회사 연락처</label>
						<div class="col-sm-9">
							<div class="form-inline">
								<input type="hidden" name="COM_TELN" id="COM_TELN" value="" >
								<input type="tel" class="form-control onlyNum" name="COM_TELN1" id="COM_TELN1" value="${fn:split(obj.COM_TELN,'-')[0]}" style="width:60px; display: inline-block;" maxlength="3">&nbsp;-&nbsp;
								<input type="tel" class="form-control onlyNum" name="COM_TELN2" id="COM_TELN2" value="${fn:split(obj.COM_TELN,'-')[1]}" style="width:60px; display: inline-block;" maxlength="4">&nbsp;-&nbsp;
								<input type="tel" class="form-control onlyNum" name="COM_TELN3" id="COM_TELN3" value="${fn:split(obj.COM_TELN,'-')[2]}" style="width:60px; display: inline-block;" maxlength="4">
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label" for="COM_PN">우편번호</label>
						<div class="col-sm-10">
							<input type="hidden" name="COM_EXTRA_ADDR" id="COM_EXTRA_ADDR" value="">
							<input type="hidden" name="COM_ALL_ADDR" id="COM_ALL_ADDR" value="">
							
							<div class="form-inline">
								<div class="input-group">
									<input type="text" class="form-control" name="COM_PN" id="COM_PN" value="${obj.COM_PN }" placeholder="우편번호" readonly="readonly" maxlength="6">
									<span class="input-group-btn">
										<input type="button" class="btn btn-info mg-rigit-10" value="주소검색" onclick="win_zip('fregisterform', 'COM_PN', 'COM_BADR', 'COM_DADR', 'COM_EXTRA_ADDR', 'COM_ALL_ADDR');">
										<label><input type="checkbox" id="sameChk" onclick="same_chk()"/>&nbsp;개인정보와 동일</label>
									</span>
								</div>
							</div> 
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label" for="COM_BADR">회사 기본주소</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" name="COM_BADR" id="COM_BADR" value="${obj.COM_BADR }" placeholder="회사 기본주소" readonly="readonly">
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label" for="COM_DADR">회사 상세주소</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" name="COM_DADR" id="COM_DADR" value="${obj.COM_DADR }" placeholder="회사 상세주소">
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-address-2">매장 개점시간</label>
						<div class="col-sm-2">
							<div class="form-inline">
								<select class="form-control" name="COM_OPEN_HH" id="COM_OPEN_HH">
									<c:forEach var="i" begin="0" end="23" step="1">
										<c:set var="data">${i}</c:set>
										<c:if test="${i < 10}">
											<c:set var="data">0${i}</c:set>
										</c:if>
										<option value="${data}">${data}시</option>
									</c:forEach>  
								</select>&nbsp;
								<select class="form-control" name="COM_OPEN_MM" id="COM_OPEN_MM">
									<c:forEach var="i" begin="0" end="59" step="1">
										<c:set var="data">${i}</c:set>
										<c:if test="${i < 10}">
											<c:set var="data">0${i}</c:set>
										</c:if>
										<option value="${data}">${data}분</option>
									</c:forEach>  
								</select>
								<input type="hidden" name="COM_OPEN" id="COM_OPEN" value="">
							</div>							
						</div>							
						
						<label class="col-sm-2 control-label" for="input-address-2">매장 폐점시간</label>
						<div class="col-sm-2">
							<div class="form-inline">
								<select class="form-control" name="COM_CLOSE_HH" id="COM_CLOSE_HH">
									<c:forEach var="i" begin="0" end="23" step="1">
										<c:set var="data">${i}</c:set>
										<c:if test="${i < 10}">
											<c:set var="data">0${i}</c:set>
										</c:if>
										<option value="${data}">${data}시</option>
									</c:forEach>  
								</select> &nbsp;
								<select class="form-control" name="COM_CLOSE_MM" id="COM_CLOSE_MM">
									<c:forEach var="i" begin="0" end="59" step="1">
										<c:set var="data">${i}</c:set>
										<c:if test="${i < 10}">
											<c:set var="data">0${i}</c:set>
										</c:if>
										<option value="${data}">${data}분</option>
									</c:forEach>  
								</select>
								<input type="hidden" name="COM_CLOSE" id="COM_CLOSE" value="">									
							</div>
						</div>
						<span style="color:red">* 개점시간과 폐점시간이 00시 00분일 경우 24시 운영입니다.</span>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-city">상품 보관장소</label>
						<div class="col-sm-9">
							<input type="text" name="KEEP_LOCATION" value="${obj.KEEP_LOCATION }" placeholder="상품보관장소" id="KEEP_LOCATION" class="form-control">
							<span style="color:red">* 오후 6시 이후 개점 사업장 상품보관장소를 입력하세요.</span>
						</div>
					</div>
				</fieldset>
				
				<div class="buttons">
					<div class="col-sm-11">
						<div class="pull-right">						
							<button type="button" class="btn btn-primary mg-rigit-5" id="btnSave">회원정보 수정</button>
							<a href="${contextPath }/m" class="btn_cancel btn btn-default ">취소</a>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- /.Main Container -->


<!-- 비밀번호 변경 팝업 -->
<div class="modal fade" id="pwModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" style="width:30vw; min-width:300px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="pwModalLabel">비밀번호 변경 팝업</h4>
			</div>
			<div class="modal-body">
				<!-- 입력 박스 -->
				<div class="box box-primary boxSearch">
					<form class="form-horizontal" id="ajaxfrm" method="post" action="${contextPath }/m/mypage/pwUpdate">
						<input type="hidden" name="MEMB_ID" value="${obj.MEMB_ID }" />
						
						<div class="form-group">
							<label class="col-sm-3 control-label" for="COM_BADR">변경할 비밀번호</label>
							<div class="col-sm-9">
								<input type="password" class="form-control" name="MEMB_PW" id="CNG_PW" value="" placeholder="변경 비밀번호">
							</div>
						</div>
							
						<div class="form-group">
							<label class="col-sm-3 control-label" for="COM_BADR">비밀번호 확인</label>
							<div class="col-sm-9">
								<input type="password" class="form-control" name="RE_CNG_PW" value="" placeholder="변경 비밀번호 확인">
							</div>
						</div>				
					</form>
				</div>
				<!-- /.입력 박스 -->				
			</div>
			<!-- /.modal-body -->
			<div class="modal-footer">
				<button type="button" class="btn btn-sm btn-danger" id="btnCng">비밀번호 변경</button>
			</div>
		</div>
	</div>
</div>
--%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:set var="strActionUrl" value="${contextPath }/m/wishList" />
<c:set var="strMethod" value="post" />
<!doctype html>
<html>
<head>
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
						<li class="on"><a href="${contextPath}/m/mypage">개인정보변경</a></li>
						<li><a href="${contextPath}/m/unregister">회원탈퇴</a></li>
					</ul>
				</div>
			</div>
			<div class="mypage-content">
				<div class="mypage-myinfo-checked">
					<div class="mypage-title">개인정보변경</div>
					<div class="myinfo-checked">
						<form name="pwChkFrm" id="pwChkFrm" method="post" action="${contextPath }/m/mypage/pwChk" autocomplete="off">
							<div class="img"><img src="${contextPath}/resources/resources2/images/myinfo_check.png" alt=""></div>
							<div class="tit"><strong>${ MEMB_NAME }</strong> 고객님의 개인정보 보호를 위해 비밀번호를 한번 더 입력해 주시기 바랍니다.</div>
							<div class="inp">
								<span>비밀번호</span>
								<input type="hidden" id="MEMB_ID" name="MEMB_ID" value="${ USER.MEMB_ID }">
								<input type="password" id="MEMB_PW" name="MEMB_PW" placeholder="비밀번호">
								<button id="chkPwBtn" type="button">확인</button>
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
 	/* 개인정보변경 기본  */
 	$("#MEMB_PW").focus();
 
 	/* 비밀번호 입력후 엔터키 누를시  */
 	$("#MEMB_PW").keydown(function(key){
 		if(key.keyCode == 13){
 			if($("#MEMB_PW").val() != '' && $("#MEMB_PW").val() != null) {
	 			$("#chkPwBtn").click();
 			}else{
	 			$('.layer-popup').addClass('on');
 				$('.casa-msg').html("비밀번호를 입력해 주세요.");
	 			$("#MEMB_PW").focus();
 				return false;
 			}
 			$("#MEMB_PW").focus();
 		}
 	});
 	
 	/* 비밀번호 확인 */
	$("#chkPwBtn").click(function(){
		$.ajax({
			type: "POST",
			url: "${contextPath}/m/mypage/pwChk",
			data: $("#pwChkFrm").serialize(),
			success: function (data) {
				if(data != '0') {
					location.href="${contextPath}/m/mypage/detail";
				} else {
					$('.layer-popup').addClass('on');
					$('.casa-msg').html("비밀번호를 확인해 주세요.");
					location.href="${contextPath}/m/mypage/info";
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
</html>
