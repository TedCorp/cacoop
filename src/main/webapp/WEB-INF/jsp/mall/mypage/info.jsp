<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<script type="text/javascript">
$(function() {
	
	//개점, 폐점
	<c:if test="${!empty obj.COM_OPEN }">
	$('#COM_OPEN_HH').val('${obj.COM_OPEN_HH }');
	$('#COM_OPEN_MM').val('${obj.COM_OPEN_MM }');
	</c:if>
	<c:if test="${!empty obj.COM_CLOSE }">
	$('#COM_CLOSE_HH').val('${obj.COM_CLOSE_HH }');
	$('#COM_CLOSE_MM').val('${obj.COM_CLOSE_MM }');
	</c:if>
	
	$('#myModal').on('show.bs.modal', function (event) {
		var modal = $(this);
		
        $("#MEMB_ID_CHK").val("");
        $("#MEMB_ID_CHK").attr("readonly",false).attr("disabled",false); //입력가능	  
	});		
	$(".viewPopup").click(function(){
		$('#myModal').modal('show');
	});
	
		
	fn_memb_gbn();	//사업자 구분 체크
	
	var emailString = $('#MEMB_MAIL').val().split('@');
	var emailFrt = emailString[0];
	var emailEnd = emailString[1];
	
	$('#MEMB_MAIL_FRT').val(emailFrt);	//첫번째 값
	$("#MEMB_MAIL_END").find('option').each(function (i) {
		if($("#MEMB_MAIL_END option:eq("+i+")").val() == emailEnd){
			$("#MEMB_MAIL_END option:eq("+i+")").attr("selected", "selected");
			$('#EMAIL_DIRECT').hide();
			return false;
		}else{			
			$('#EMAIL_DIRECT').show();
			$('#EMAIL_DIRECT').val(emailEnd);
		}
	});	

});

//비밀번호 확인_CHJW
function fnCfmPassword(upw){
	if (upw != $('#MEMB_PW_RE').val() && $('#MEMB_PW_RE').val() != ''){
		alert('비밀번호가 일치하지 않습니다.'); 
     $('#MEMB_PW_RE').val('');
     
     //focus시 chrome에서 무한루프 해결
     setTimeout(function(){
     	$('#MEMB_PW_RE').focus();
     }, 10)
     return false;
	}		
	return true;
}

function fupdateform_submit(){

	if($("#MEMB_PW").val() != $("#MEMB_PW_RE").val()){
		alert("비밀번호가 다릅니다.");
		return false;
	}
	
	//이메일 값 합치기
	if($('#MEMB_MAIL_END option:selected').val() == 'direct'){
		$("#MEMB_MAIL").val($('#MEMB_MAIL_FRT').val()+'@'+$('#EMAIL_DIRECT').val())
	}else{
		$("#MEMB_MAIL").val($('#MEMB_MAIL_FRT').val()+'@'+$('#MEMB_MAIL_END option:selected').val())
	}
	
	if(!chk_email($("#MEMB_MAIL").val())){
		alert("e-mail 형식이 아닙니다.");
		$("#MEMB_MAIL").focus();
		return false;
	}
	
	var membBtdyYear = $('#MEMB_BTDY_YEAR').val();
	var membBtdyMonth = $('#MEMB_BTDY_MONTH').val();
	var membBtdyDay = $('#MEMB_BTDY_DAY').val();
	
	$('#MEMB_BTDY').val(membBtdyYear+(LPAD(membBtdyMonth,'0',2))+(LPAD(membBtdyDay,'0',2)));
	$('#MEMB_TELN').val($('#MEMB_TELN1').val()+"-"+$('#MEMB_TELN2').val()+"-"+$('#MEMB_TELN3').val());
	$('#MEMB_CPON').val($('#MEMB_CPON1').val()+"-"+$('#MEMB_CPON2').val()+"-"+$('#MEMB_CPON3').val());
	
	if(!($('#ERP_LIST').css("display")=="none")){//사업자일 경우 필수값 체크
		$('#COM_TELN').val($('#COM_TELN1').val()+"-"+$('#COM_TELN2').val()+"-"+$('#COM_TELN3').val());	
	}
	
	//매장 개점시간, 폐점시간
	$('#COM_OPEN').val($('#COM_OPEN_HH').val()+":"+$('#COM_OPEN_MM').val());
	$('#COM_CLOSE').val($('#COM_CLOSE_HH').val()+":"+$('#COM_CLOSE_MM').val());
	
	var strComBunb = $("#COM_BUNB").val().replace(/-/gi, "");
    var strComBunbSub = strComBunb.substring(0,3)+"-"+strComBunb.substring(3,5)+"-"+strComBunb.substring(5,10);
    
    if($("#BEF_COM_BUNB").val()!=strComBunb){
    	$("#COM_BUNB").val(strComBunbSub);	
    }
	
	//사업자 구분
	if($('input:radio[name="MEMB_GUBN"]:checked').val()=='MEMB_GUBN_01'){
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
}

//왼쪽에서부터 채운다는 의미
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


// email체크 함수
function chk_email(strEmail) {
	var em = strEmail; //이메일의 값은 단순히 문자이다 이것을 객체화시켜서 비교한다..

	//^는 반드시 이런형식으로 시작하라 $는 반드시 요런형식으로 종료
	// {3,20} 3~20글자만쓸수있다..
	var epattern = new RegExp("^([a-zA-Z0-9\-\_]{3,20})" + "@" + "([a-zA-Z0-9\-\_]{3,20})" + "." + "([a-zA-Z0-9\-\_\.]{3,5})$");
	
	if (!epattern.test(em)) {
		return false;
	}
	
	return true;
}

function fnCheckPassword(uid, upw)
{
    if(!/^[a-zA-Z0-9]{5,20}$/.test(upw)&&!(upw=="")){ 
        alert('비밀번호는 숫자와 영문자 조합으로 5~12자리를 사용해야 합니다.'); 
        $('#MEMB_PW').val('');
        $('#MEMB_PW').focus();
       
        return false;
    }
  
    var chk_num = upw.search(/[0-9]/g); 
    var chk_eng = upw.search(/[a-z]/ig);

    if((chk_num < 0 || chk_eng < 0) &&!(upw=="")){ 
        alert('비밀번호는 숫자와 영문자를 혼용하여야 합니다.'); 
        $('#MEMB_PW').val('');
        $('#MEMB_PW').focus();
        
        return false;
    }
    
    if(/(\w)\1\1\1/.test(upw) &&!(upw=="")){
        alert('비밀번호에 같은 문자를 4번 이상 사용하실 수 없습니다.'); 
        $('#MEMB_PW').val('');
        $('#MEMB_PW').focus();
        
        return false;
    }

    if(upw.search(uid)>-1 &&!(upw=="")){
        alert('ID가 포함된 비밀번호는 사용하실 수 없습니다.'); 
        $('#MEMB_PW').val('');
        $('#MEMB_PW').focus();
        
        return false;
    }

    return true;
}

//사업자,개인 선택
function fn_memb_gbn(){		
	if($('input:radio[name="MEMB_GUBN"]:checked').val()=='MEMB_GUBN_02'
			||$('input:radio[name="MEMB_GUBN"]:checked').val()=='MEMB_GUBN_04'){
		$('#ERP_LIST').show();
		$('#COM_NAME').attr("required","");
		$('#COM_BUNB').attr("required","");
		
		var strcombunb = $('#COM_BUNB').val().replace(/-/gi, "");
		/* alert(strcombunb); */
		
		if(strcombunb != null || strcombunb != ''){
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

function email_back(){
	$('#EMAIL_DIRECT').val('');	//값 초기화
	if($('#MEMB_MAIL_END option:selected').val() == 'direct'){
		$('#EMAIL_DIRECT').show();
	}else{
		$('#EMAIL_DIRECT').hide(); 
	}
}

function same_chk(){
	if($('#sameChk').prop('checked')==true){ //개인정보와 동일
		$('#COM_PN').val($('#MEMB_PN').val());
		$('#COM_BADR').val($('#MEMB_BADR').val());
		$('#COM_DADR').val($('#MEMB_DADR').val());
	}else{ //개인정보와 다름
		$('#COM_PN').val('');
		$('#COM_BADR').val('');
		$('#COM_DADR').val('');
	}
}

function onlyNumber(obj){
   $(obj).keyup(function(){
        $(this).val($(this).val().replace(/[^0-9]/g,""));
   }); 
}

function fn_bunbChk(){
   
   var strComBunb = $("#COM_BUNB").val().replace(/-/gi,"");
   /* alert(strComBunb); */
   
   if(strComBunb.length==0){
      $('#COM_CHK_YN').val("N");
      return;
   }
         
   if(strComBunb.length <10 || strComBunb.length > 10){
      $('#COM_BUNB_CHK_MSG').html("<span><font color='red'>사업자번호 자릿수를 확인해 주세요</font></span>");
      $('#COM_CHK_YN').val("N");
   }else{
      
      var strComBunbSub = strComBunb.substring(0,3)+"-"+strComBunb.substring(3,5)+"-"+strComBunb.substring(5,10);
      /* alert(strComBunbSub); */
      if($("#BEF_COM_BUNB").val()==strComBunbSub){
    	  $('#COM_BUNB_CHK_MSG').html("<span><font color='blue'>기존에 사용한 사업자번호 입니다.</font></span>");
          $('#COM_CHK_YN').val("Y");
      }else{
    	  $("#COM_BUNB_TMP").val(strComBunbSub);
    	  
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
}
</script>

<c:set var="strActionUrl" value="${contextPath }/basket" />
<c:set var="strMethod" value="post" />

<form id="bunbChkFrm" name="bunbChkFrm" action="${contextPath }/comBunbChk" method="post" autocomplete="off">
   <input type="hidden" id="COM_BUNB_TMP" name="COM_BUNB_TMP" />
</form>

<div class="sub-title sub-title-underline">
	<h2>
		마이페이지 <small class="ml_5">| 개인정보를 수정할 수 있습니다.</small>
	</h2>
	<ul>
		<li><a href='${contextPath }' class="sct_bg">Home</a></li>
		<li><a href="${contextPath }/mypage" class=" ">마이페이지</a></li>
	</ul>
	<div class="clearfix"></div>
</div>

<form name="fupdateform" id="fupdateform" method="post" action="${contextPath }/mypage/memberUpdate" onsubmit="return fupdateform_submit(this);">

	<div class="col-10">
			<div class="main-tab">
				<!-- Nav tabs -->
				<ul class="nav nav-main" role="tablist">
					<li role="presentation" class="active">
						<a href="${contextPath}/mypage">개인정보</a></li>
					<li role="presentation">
						<a href="${contextPath}/mypage/buyInfo">구매내역</a></li>
					<li role="presentation" >
							<a href="${contextPath}/mypage/myQna">문의답변</a></li>
					<li role="presentation" >
							<a href="${contextPath}/mypage/buyBeforeInfo">미결재내역</a></li>
						
				</ul>
			</div>
			<!-- 회원정보 입력/수정 시작 { -->
			<div class="mbskin" style="margin-top:20px">
			
				<input type="hidden" id="MEMB_CHK_YN" name="MEMB_CHK_YN" value="N"/>
				
			    <div class="tbl_wrap">
			        <table class="table table-intro">
				        <!-- <caption>개인정보 - 필수 입력항목</caption> -->
				         <small class="ml_5">개인정보 - 필수 입력항목</small>
				        <tbody>
				        <tr class="tb_topline">
				        	<th><label for="MEMB_ID">아이디</label></th>
				            <td>
								<div class="form-inline">
									<div class="form-group">
										<small class="ml_10">${obj.MEMB_ID }</small>
									</div>
									<div class="form-group">
										 <div id="ID_CHK_MSG"></div>
									</div>
								</div> 
				            </td>
				        </tr>
				        <tr>
				            <th><label for="MEMB_PW">비밀번호</label></th>
				            <td>
				            	<input type="password" name="MEMB_PW" id="MEMB_PW" required class="form-control input-sm" style="width: 200px;" minlength="3" maxlength="20" >
				            	<!-- onblur="javascript:fnCheckPassword($('#MEMB_ID').val(),$('#MEMB_PW').val());" -->
							</td>
				        </tr>
				        <tr>
				            <th><label for="MEMB_PW_RE">비밀번호 확인</label></th>
				            <td>
				            	<input type="password" name="MEMB_PW_RE" id="MEMB_PW_RE" required class="form-control input-sm" style="width: 200px;" minlength="3" maxlength="20"
				            	onchange="javascript:fnCfmPassword($('#MEMB_PW').val());">
				            </td>
				        </tr>
				        <tr>
				            <th><label for="MEMB_GUBN"></label>사업자 구분</th>
				            <td>
								<label class="radio-inline">
									<input type="radio" name="MEMB_GUBN" value="MEMB_GUBN_02" required ${ obj.MEMB_GUBN == 'MEMB_GUBN_02' ? 'checked' : '' } onclick="return(false)"/>사업자
								</label>
								<label class="radio-inline">
									<input type="radio" name="MEMB_GUBN" value="MEMB_GUBN_01" required ${ obj.MEMB_GUBN == 'MEMB_GUBN_01' ? 'checked' : '' } onclick="return(false)">개인
								</label>
								<label class="radio-inline">
									<input type="radio" name="MEMB_GUBN" value="MEMB_GUBN_04" required ${ obj.MEMB_GUBN == 'MEMB_GUBN_04' ? 'checked' : '' } onclick="return(false)">도매유통사업자	
								</label>
								
								<h6 style="color:red">* 도매유통사업자 회원가입시 쇼핑몰주문시 배송불가능할수도 있습니다.(사전 협의 필수)</h6>
								
				            </td>
				        </tr>
				        <tr>
				            <th><label for="MEMB_NAME">이름</label></th>
				            <td>
				                <input type="text" name="MEMB_NAME" value="${obj.MEMB_NAME }" id="MEMB_NAME" required class="form-control input-sm" style="width: 200px;" minlength="3" maxlength="20">
				            </td>
				        </tr>
				        <tr>
				            <th><label for="MEMB_SEX">성별</label></th>
				            <td>
								<label class="radio-inline">
									<input type="radio" name="MEMB_SEX" value="MEMB_SEX_01" required ${ obj.MEMB_SEX == 'MEMB_SEX_01' ? 'checked' : '' } />남 
								</label>
								<label class="radio-inline">
									<input type="radio" name="MEMB_SEX" value="MEMB_SEX_02" required ${ obj.MEMB_SEX == 'MEMB_SEX_02' ? 'checked' : '' } />여
								</label>
			
				            </td>
				        </tr>
				        <tr>
				            <th><label for="MEMB_BTDY">생년월일</label></th>
				            <td>
								<div class="form-inline">
									<%-- <c:set var="year" value="${fn:substgring }" --%>
					            	<select name="MEMB_BTDY_YEAR" id="MEMB_BTDY_YEAR" class="form-control input-sm">
						            	﻿<c:forEach var="i" begin="0" end="${TODAY_YEAR - 1950 }" step="1">
										<option value="${i + 1950}">${i + 1950}</option>
										<c:if test="${fn:substring(obj.MEMB_BTDY,0,4) == i+1950}">
										<option value="${i + 1950}" selected>${i + 1950}</option>
										</c:if>
										</c:forEach>﻿ 
					            	</select>년 &nbsp;
					            	<select name="MEMB_BTDY_MONTH" id="MEMB_BTDY_MONTH" class="form-control input-sm">
						            	﻿<c:forEach var="i" begin="1" end="12" step="1">
										<option value="${i}">${i}</option>
										<c:if test="${fn:substring(obj.MEMB_BTDY,4,6) == i}">
										<option value="${i}" selected>${i}</option>
										</c:if>
										</c:forEach>﻿ 
					            	</select>월 &nbsp;
					            	<select name="MEMB_BTDY_DAY" id="MEMB_BTDY_DAY" class="form-control input-sm">
						            	﻿<c:forEach var="i" begin="1" end="31" step="1">
										<option value="${i}">${i}</option>
										<c:if test="${fn:substring(obj.MEMB_BTDY,6,8) == i}">
										<option value="${i}" selected>${i}</option>
										</c:if>
										</c:forEach>﻿ 
					            	</select>일
					            	&nbsp;&nbsp;&nbsp;
									<label class="radio-inline">
										<input type="radio" name="SLCAL_GUBN" value="SLCAL_GUBN_01" required ${ obj.SLCAL_GUBN == 'SLCAL_GUBN_01' ? 'checked' : '' } />양력
									</label>
									<label class="radio-inline">
										<input type="radio" name="SLCAL_GUBN" value="SLCAL_GUBN_02" required ${ obj.SLCAL_GUBN == 'SLCAL_GUBN_02' ? 'checked' : '' } />음력
									</label>
					                <input type="hidden" name="MEMB_BTDY" value="" id="MEMB_BTDY">
					         	</div>
			
				            </td>
				        </tr>
				        <tr>
				            <th><label for="MEMB_MAIL">E-mail</label></th>
				            <td>
				            	<div class="form-inline">
				            		<input type="hidden" name="MEMB_MAIL" value="${obj.MEMB_MAIL }" id="MEMB_MAIL"/>	
					                <input type="text" name="MEMB_MAIL_FRT" value="${obj.MEMB_MAIL }" id="MEMB_MAIL_FRT" required class="form-control input-sm" style="width:150px" maxlength="20">
					                <!-- <input type="text" name="MEMB_MAIL" value="${obj.MEMB_MAIL }" id="MEMB_MAIL" required class="form-control input-sm" style="width: 150px;" maxlength="100"> -->
					                @
					                <input type="text" name="EMAIL_DIRECT" id="EMAIL_DIRECT" class="form-control input-sm" style="width: 150px;" maxlength="20"/>
					                <select name="MEMB_MAIL_END" id="MEMB_MAIL_END"class="form-control input-sm" style="width: 150px;" onchange="email_back()">
									  	<option value="direct">직접입력</option>
							            <option value="naver.com">naver.com</option>
							            <option value="daum.net">daum.net</option>
							            <option value="hanmail.net">hanmail.net</option>
							            <option value="nate.com">nate.com</option>
							            <option value="gmail.com">gmail.com</option>
							            <option value="paran.com">paran.com</option>
							            <option value="chol.com">chol.com</option>
							            <option value="dreamwiz.com">dreamwiz.com</option>
							            <option value="empal.com">empal.com</option>
							            <option value="freechal.com">freechal.com</option>
							            <option value="hanafos.com">hanafos.com</option>
							            <option value="hanmir.com">hanmir.com</option>
							            <option value="hitel.net">hitel.net</option>
							            <option value="hotmail.com">hotmail.com</option>
							            <option value="korea.com">korea.com</option>
							            <option value="lycos.co.kr">lycos.co.kr</option>
							            <option value="netian.com">netian.com</option>
							            <option value="yahoo.co.kr">yahoo.co.kr</option>
							            <option value="yahoo.com">yahoo.com</option>
									</select>
								</div>
				            </td>
				        </tr>
				        <tr>
				            <th>주소</th>
				            <td>
			
				                <input type="hidden" name="EXTRA_ADDR" value="" id="EXTRA_ADDR">
				                <input type="hidden" name="ALL_ADDR" value="" id="ALL_ADDR">
								<div class="form-inline">
									<div class="form-group">
										<p class="form-control-static">우편번호</p>
									</div>
									<div class="form-group">
										<input type="text" name="MEMB_PN" value="${obj.MEMB_PN }" id="MEMB_PN" required readonly="readonly" class="form-control input-sm" style="width: 70px;" maxlength="6">
									</div>
									<button type="button" class="btn btn-sm btn-default" onclick="win_zip('fupdateform', 'MEMB_PN', 'MEMB_BADR', 'MEMB_DADR', 'EXTRA_ADDR', 'ALL_ADDR');">주소검색</button>
								</div> 
								<div class="form-inline">
									<div class="form-group">
										<input type="text" name="MEMB_BADR" value="${obj.MEMB_BADR }" id="MEMB_BADR" required readonly="readonly" class="form-control input-sm" style="width:300px;" placeholder="기본주소">
									</div>
									<div class="form-group">
										<!-- <p class="form-control-static"><label for="MEMB_BADR">기본주소</label></p> -->
									</div>
								</div> 
								<div class="form-inline">
									<div class="form-group">
										<input type="text" name="MEMB_DADR" value="${obj.MEMB_DADR }" id="MEMB_DADR" required class="form-control input-sm" style="width:300px;" placeholder="상세주소">
									</div>
									<div class="form-group">
										<!-- <p class="form-control-static"><label for="MEMB_DADR">상세주소</label></p> -->
									</div>
								</div> 
			
				            </td>
				        </tr>
				        <tr>
				            <th><label for="MEMB_TELN">전화번호</label></th>
				            <td>
								<div class="form-inline">
						         	<input type="hidden" name="MEMB_TELN" value="" id="MEMB_TELN" >
						         	<input type="text" name="MEMB_TELN1" value="${fn:split(obj.MEMB_TELN,'-')[0]}" id="MEMB_TELN1"  class="form-control input-sm"  style="width:50px;" maxlength="3">&nbsp;-&nbsp;
						         	<input type="text" name="MEMB_TELN2" value="${fn:split(obj.MEMB_TELN,'-')[1]}" id="MEMB_TELN2"  class="form-control input-sm"  style="width:50px;" maxlength="4">&nbsp;-&nbsp;
						         	<input type="text" name="MEMB_TELN3" value="${fn:split(obj.MEMB_TELN,'-')[2]}" id="MEMB_TELN3"  class="form-control input-sm"  style="width:50px;" maxlength="4">
					         	</div>
				            </td>
				        </tr>
				        <tr class="tb_line">
				            <th><label for="MEMB_CPON">휴대폰번호</label></th>
				            <td>
								<div class="form-inline">
						         	<input type="hidden" name="MEMB_CPON" value="" id="MEMB_CPON" >
						         	<input type="text" name="MEMB_CPON1" value="${fn:split(obj.MEMB_CPON,'-')[0]}" id="MEMB_CPON1" required class="form-control input-sm"  style="width:50px;" maxlength="3">&nbsp;-&nbsp;
						         	<input type="text" name="MEMB_CPON2" value="${fn:split(obj.MEMB_CPON,'-')[1]}" id="MEMB_CPON2" required class="form-control input-sm"  style="width:50px;" maxlength="4">&nbsp;-&nbsp;
						         	<input type="text" name="MEMB_CPON3" value="${fn:split(obj.MEMB_CPON,'-')[2]}" id="MEMB_CPON3" required class="form-control input-sm"  style="width:50px;" maxlength="4">
					         	</div>
				            </td>
				        </tr>
				        <input type="hidden" name="BANK_NAME" value="${obj.BANK_NAME }" id="BANK_NAME" required class="form-control input-sm" style="width: 200px;" minlength="2" maxlength="20">
				        <input type="hidden" name="BANK_BUNB" value="${obj.BANK_BUNB }" id="BANK_BUNB" required class="form-control input-sm" style="width: 200px;" minlength="3" maxlength="20">
				        <%-- <tr>
			               <th><label for="MEMB_CPON">은행명</label></th>
			               <td>
			               <div class="form-inline">
			                     <input type="text" name="BANK_NAME" value="${obj.BANK_NAME }" id="BANK_NAME" required class="form-control input-sm" style="width: 200px;" minlength="2" maxlength="20">
			                  </div>
			               </td>
			           </tr>
			           <tr class="tb_line">
			               <th><label for="MEMB_CPON">통장번호</label></th>
			               <td>
			               <div class="form-inline">
			                     <input type="text" name="BANK_BUNB" value="${obj.BANK_BUNB }" id="BANK_BUNB" required class="form-control input-sm" style="width: 200px;" minlength="3" maxlength="20">
			                  </div>
			               </td>
			           </tr> --%>
				        </tbody>
			        </table>
			    </div>
			    
			    <div class="tbl_frm01 tbl_wrap" id="ERP_LIST" >
			        <table class="table table-intro">
				        <!-- <caption>추가정보(회사정보) - 선택 입력항목</caption> -->
				        <small class="ml_5">추가정보(사업자) - 사업자 필수 입력항목</small>
				        <tbody>
				        <tr class="tb_topline">
				            <th><label for="COM_NAME">상호명</label></th>
				            <td><input type="text" name="COM_NAME" value="${obj.COM_NAME }" id="COM_NAME"
				            		class="form-control input-sm" style="width: 200px;" maxlength="20"></td>
				        </tr>
				        <tr>
				        	<th><label for="COM_BUNB">사업자등록번호</label></th>
				            <td>
				              	<div class="form-inline">
				                     <div class="form-group">
				                     	<input type="hidden" id="BEF_COM_BUNB" value="${obj.COM_BUNB }"/>
				                        <input type="text" name="COM_BUNB" value="${obj.COM_BUNB }" id="COM_BUNB"  class="form-control input-sm" style="width: 200px;" onblur="javascript:fn_bunbChk();"
				                              onkeydown="return onlyNumber(this)" maxlength="10" placeholder="-를 제외하고 적어주세요">
				                     </div>
				                     <div class="form-group">
				                     	<div id="COM_BUNB_CHK_MSG"></div>
				                  	 </div>
				               	</div>
							</td>
				        </tr>
				        <tr>
				            <th><label for="COM_TELN">전화번호</label></th>
			            	<td>
								<div class="form-inline">
						         	<input type="hidden" name="COM_TELN" value="" id="COM_TELN" >
						         	<input type="text" name="COM_TELN1" value="${fn:split(obj.COM_TELN,'-')[0]}" id="COM_TELN1" class="form-control input-sm"  style="width:50px;" maxlength="3">&nbsp;-&nbsp;
						         	<input type="text" name="COM_TELN2" value="${fn:split(obj.COM_TELN,'-')[1]}" id="COM_TELN2" class="form-control input-sm"  style="width:50px;" maxlength="4">&nbsp;-&nbsp;
						         	<input type="text" name="COM_TELN3" value="${fn:split(obj.COM_TELN,'-')[2]}" id="COM_TELN3" class="form-control input-sm"  style="width:50px;" maxlength="4">
					         	</div>
			            	</td>
				        </tr>
				        <tr class="tb_line">
				            <th>회사 주소</th>
				            <td>
				                <input type="hidden" name="COM_EXTRA_ADDR" value="" id="COM_EXTRA_ADDR">
				                <input type="hidden" name="COM_ALL_ADDR" value="" id="COM_ALL_ADDR">
								<div class="form-inline">
									<div class="form-group">
										<p class="form-control-static">우편번호</p>
									</div>
									<div class="form-group">
										<input type="text" name="COM_PN" value="${obj.COM_PN }" id="COM_PN" readonly="readonly" class="form-control input-sm" style="width: 70px;" maxlength="6">
									</div>
									<button type="button" class="btn btn-sm btn-default" onclick="win_zip('fupdateform', 'COM_PN', 'COM_BADR', 'COM_DADR', 'COM_EXTRA_ADDR', 'COM_ALL_ADDR');">주소검색</button>
									<input type="checkbox" id="sameChk" onclick="same_chk()"/>개인정보와 동일
								</div> 
								<div class="form-inline">
									<div class="form-group">
										<input type="text" name="COM_BADR" value="${obj.COM_BADR }" id="COM_BADR" readonly="readonly" class="form-control input-sm" style="width:300px;" placeholder="기본주소">
									</div>
									<div class="form-group">
										<p class="form-control-static"><label for="COM_BADR">기본주소</label></p>
									</div>
								</div> 
								<div class="form-inline">
									<div class="form-group">
										<input type="text" name="COM_DADR" value="${obj.COM_DADR }" id="COM_DADR" class="form-control input-sm" style="width:300px;" placeholder="상세주소">
									</div>
									<div class="form-group">
										<p class="form-control-static"><label for="COM_DADR">상세주소</label></p>
									</div>
								</div> 
				            </td>
				        </tr>
				        <tr class="tb_line">
				        	<th>매장 개점시간</th>
				        	<td>
				        		<div class="form-inline">
					            	<select name="COM_OPEN_HH" id="COM_OPEN_HH" class="form-control input-sm">
						            	﻿<c:forEach var="i" begin="0" end="23" step="1">
						            		<c:set var="data">${i}</c:set>
						            		<c:if test="${i < 10}">
						            			<c:set var="data">0${i}</c:set>
											</c:if>
											<option value="${data}">${data}</option>
										</c:forEach>﻿ 
					            	</select>시 &nbsp;
					            	<select name="COM_OPEN_MM" id="COM_OPEN_MM" class="form-control input-sm">
						            	﻿<c:forEach var="i" begin="0" end="59" step="1">
						            		<c:set var="data">${i}</c:set>
						            		<c:if test="${i < 10}">
						            			<c:set var="data">0${i}</c:set>
											</c:if>
											<option value="${data}">${data}</option>
										</c:forEach>﻿ 
					            	</select>분
					            	<!-- 
					            	&nbsp;&nbsp;&nbsp;
									<label class="radio-inline">
										<input type="radio" name="COM_OPEN_TM" value="AM" required checked />AM
									</label>
									<label class="radio-inline">
										<input type="radio" name="COM_OPEN_TM" value="PM" required />PM
									</label>
									 -->
					                <input type="hidden" name="COM_OPEN" value="" id="COM_OPEN">
					         	</div>
				        	</td>
				        </tr>
				        <tr class="tb_line">
				        	<th>매장 폐점시간</th>
				        	<td>
				        		<div class="form-inline">
					            	<select name="COM_CLOSE_HH" id="COM_CLOSE_HH" class="form-control input-sm">
						            	﻿<c:forEach var="i" begin="0" end="23" step="1">
						            		<c:set var="data">${i}</c:set>
						            		<c:if test="${i < 10}">
						            			<c:set var="data">0${i}</c:set>
											</c:if>
											<option value="${data}">${data}</option>
										</c:forEach>﻿ 
					            	</select>시 &nbsp;
					            	<select name="COM_CLOSE_MM" id="COM_CLOSE_MM" class="form-control input-sm">
						            	﻿<c:forEach var="i" begin="0" end="59" step="1">
						            		<c:set var="data">${i}</c:set>
						            		<c:if test="${i < 10}">
						            			<c:set var="data">0${i}</c:set>
											</c:if>
											<option value="${data}">${data}</option>
										</c:forEach>﻿ 
					            	</select>분
					            	<!-- 
					            	&nbsp;&nbsp;&nbsp;
									<label class="radio-inline">
										<input type="radio" name="COM_CLOSE_TM" value="AM" required checked />AM
									</label>
									<label class="radio-inline">
										<input type="radio" name="COM_CLOSE_TM" value="PM" required />PM
									</label>
									 -->
									<h6 style="color:red">* 개점시간과 폐점시간이 00시 00분일 경우 24시 운영입니다.</h6>
					                <input type="hidden" name="COM_CLOSE" value="" id="COM_CLOSE">
					         	</div>
				        	</td>
				        </tr>
				        <tr class="tb_line">
				            <th><label for="KEEP_LOCATION">상품보관장소</label></th>
				            <td>
				            	<input type="text" name="KEEP_LOCATION" value="${obj.KEEP_LOCATION }" id="KEEP_LOCATION"  class="form-control input-sm" style="width: 100%;" maxlength="20">
				            	<h6 style="color:red">* 오후 6시 이후 개점 사업장 상품보관장소를 입력하세요.</h6>
				            </td>
				        </tr>
				        </tbody>
			        </table>
			    </div>
			    <div class="btn_confirm">
			        <a href="${contextPath }/" class="btn_cancel btn btn-sm btn-default pull-right">취소</a>
			        <input type="submit" value="개인정보 수정" id="btn_submit" class="btn_submit btn btn-sm btn-default pull-right" style="margin-right:5px;" accesskey="s">
			    </div>
			
			</div>
	</div>

</form>


