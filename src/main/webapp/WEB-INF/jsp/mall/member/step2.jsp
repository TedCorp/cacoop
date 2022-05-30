<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<script type="text/javascript">
$(document).ready(function() {

	//이메일 한글입력 안되게 처리_20190409
	$("input[name=MEMB_MAIL_FRT]").keyup(function(event){
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
		}
	});
});

$(function() {
	fn_memb_gbn();	//사업자구분체크
	
	$('#myModal').on('show.bs.modal', function (event) {
		var modal = $(this);
		
        $("#MEMB_ID_CHK").val("");
        $("#MEMB_ID_CHK").attr("readonly",false).attr("disabled",false); //입력가능
	});

	$(".viewPopup").click(function(){
		/*
		var strMembId = $(this).attr("membId");
		
		$.ajax({
		    type: 'get',
		    dataType: 'json',
		    url: '${contextPath }/adm/memberMgr/edit/'+strMembId+'.json',
		    success: function (data) {
			    var objMbr = data.memberInfo; 

		        $("#MEMB_ID").val(objMbr.memb_ID);
		        $("#MEMB_ID").attr("readonly",true).attr("disabled",false); //입력불가		        
		    },
		    error: function () {
		         console.log('error');
		    }
		}); 
		*/
		
		$('#myModal').modal('show');
	});
	
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

function fregisterform_submit(){
	
   if($('#MEMB_CHK_YN').val() == "N"){
      alert("아이디를 다시 입력해 주세요");
      $("#MEMB_ID").focus();
      return false;   
   }

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
   if($('#MEMB_PN').val()==null||$('#MEMB_PN').val()==''){
	   alert("우편번호와 주소는 필수값입니다.");
	   return false;
   }
   
   if($('#COM_CHK_YN').val() == "N"){
      alert("사업자등록번호를 다시 입력해 주세요");
      $("#COM_BUNB").focus();
      return false;   
   } 
   
   
   var membBtdyYear = $('#MEMB_BTDY_YEAR').val();
   var membBtdyMonth = $('#MEMB_BTDY_MONTH').val();
   var membBtdyDay = $('#MEMB_BTDY_DAY').val();
   
   $('#MEMB_BTDY').val(membBtdyYear+(LPAD(membBtdyMonth,'0',2))+(LPAD(membBtdyDay,'0',2)));
   $('#MEMB_TELN').val($('#MEMB_TELN1').val()+"-"+$('#MEMB_TELN2').val()+"-"+$('#MEMB_TELN3').val());
   $('#MEMB_CPON').val($('#MEMB_CPON1').val()+"-"+$('#MEMB_CPON2').val()+"-"+$('#MEMB_CPON3').val());
   
   if(!($('#ERP_LIST').css("display")=="none")){//사업자일 경우 필수값 체크
      //$('#COM_TELN').val($('#COM_TELN1').val()+"-"+$('#COM_TELN2').val()+"-"+$('#COM_TELN3').val());
      $('#COM_TELN').val($('#COM_TELN1').val()+""+$('#COM_TELN2').val()+""+$('#COM_TELN3').val());
   }
   
   
   //매장 개점시간, 폐점시간
   $('#COM_OPEN').val($('#COM_OPEN_HH').val()+":"+$('#COM_OPEN_MM').val());
   $('#COM_CLOSE').val($('#COM_CLOSE_HH').val()+":"+$('#COM_CLOSE_MM').val());
   
   var strComBunb = $("#COM_BUNB").val().replace(/-/gi, "");
   var strComBunbSub = strComBunb.substring(0,3)+"-"+strComBunb.substring(3,5)+"-"+strComBunb.substring(5,10);
   $("#COM_BUNB").val(strComBunbSub);
   
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
 	
	/*
	var open_hours = parseInt($('#COM_OPEN_HH').val());
	var AMPM = $('input:radio[name="COM_OPEN_TM"]:checked').val();
	if(AMPM == "PM" && open_hours<12) open_hours = open_hours+12;
	if(AMPM == "AM" && open_hours==12) open_hours = open_hours-12;	
	$('#COM_OPEN').val(open_hours+" : "+$('#COM_OPEN_MM').val());
	
	var close_hours = parseInt($('#COM_CLOSE_HH').val());
	var AMPM2 = $('input:radio[name="COM_CLOSE_TM"]:checked').val();
	if(AMPM2 == "PM" && close_hours<12) close_hours = close_hours+12;
	if(AMPM2 == "AM" && close_hours==12) close_hours = close_hours-12;
	$('#COM_CLOSE').val(close_hours+" : "+$('#COM_CLOSE_MM').val());
	*/
	
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

function fn_idChk(){
   
   var strMembId = $("#MEMB_ID").val();
   $("#MEMB_ID_TMP").val(strMembId);
   
   if(strMembId == ""){
      alert("아이디를 입력해 주세요");
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
         
      	 if(strMembId != strMembIdTrim || re.test(strMembId)){
            $('#ID_CHK_MSG').html("<span><font color='red'>아이디에 공백이 들어갈 수 없습니다</font></span>");
            $('#MEMB_CHK_YN').val("N");
         } else if(special_pattern.test(strMembId)) {
        	 $('#ID_CHK_MSG').html("<span><font color='red'>아이디에 특수문자가 들어갈 수 없습니다</font></span>");
             $('#MEMB_CHK_YN').val("N");
         }else{
            // 아이디 중복 여부
            if (data == '0') {
               $('#ID_CHK_MSG').html("<span><font color='blue'>사용할 수 있는 아이디</font></span>");
               $('#MEMB_CHK_YN').val("Y");
            }else{
               $('#ID_CHK_MSG').html("<span><font color='red'>중복된 아이디</font></span>");
               $('#MEMB_CHK_YN').val("N");
            }
         }
         
         
      }, error: function (jqXHR, textStatus, errorThrown) {
         alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
      }
   });
   
}

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

function fnCheckPassword(uid, upw)
{
    if(!/^[a-zA-Z0-9]{5,20}$/.test(upw)&&!(upw==""))
    { 
        alert('비밀번호는 숫자와 영문자 조합으로 5~12자리를 사용해야 합니다.'); 
        $('#MEMB_PW').val('');
        $('#MEMB_PW').focus();
       
        return false;
    }
  
    var chk_num = upw.search(/[0-9]/g); 
    var chk_eng = upw.search(/[a-z]/ig);

    if((chk_num < 0 || chk_eng < 0) &&!(upw==""))
    { 
        alert('비밀번호는 숫자와 영문자를 혼용하여야 합니다.'); 
        $('#MEMB_PW').val('');
        $('#MEMB_PW').focus();
        
        return false;
    }
    
    if(/(\w)\1\1\1/.test(upw) &&!(upw==""))
    {
        alert('비밀번호에 같은 문자를 4번 이상 사용하실 수 없습니다.'); 
        $('#MEMB_PW').val('');
        $('#MEMB_PW').focus();
        
        return false;
    }

    if(upw.search(uid)>-1 &&!(upw==""))
    {
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

// 숫자만 입력
function onlyNumber(obj){
	$(obj).keyup(function(){
        $(this).val($(this).val().replace(/[^0-9]/g,""));
   }); 
}

function fn_bunbChk(){
	var strComBunb = $("#COM_BUNB").val().replace(/-/gi, "");
	
	if(strComBunb.length==0){
		$('#COM_CHK_YN').val("N");
		return;
	}
	
	if(strComBunb.length <10 || strComBunb.length > 10){
		$('#COM_BUNB_CHK_MSG').html("<span><font color='red'>사업자번호 자릿수를 확인해 주세요</font></span>");
		$('#COM_CHK_YN').val("N");
	}else{ 
		
		var strComBunbSub = strComBunb.substring(0,3)+"-"+strComBunb.substring(3,5)+"-"+strComBunb.substring(5,10);
		
		$("#COM_BUNB_TMP").val(strComBunbSub);
		
	 	$.ajax({
	 		type:"POST",
	        url:"${contextPath }/comBunbChk",
			data: $("#bunbChkFrm").serialize(),
			success: function (data) {
	
				// 사업자번호 중복 여부
				if (data == '0') {
					$('#COM_BUNB_CHK_MSG').html("<span><font color='red'></font></span>");
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
</script>

<form id="idChkFrm" name="idChkFrm" action="${contextPath }/idChk" method="post" autocomplete="off">
	<input type="hidden" id="MEMB_ID_TMP" name="MEMB_ID_TMP" />
</form>

<form id="bunbChkFrm" name="bunbChkFrm" action="${contextPath }/comBunbChk" method="post" autocomplete="off">
   <input type="hidden" id="COM_BUNB_TMP" name="COM_BUNB_TMP" />
</form>

<div class="sub-title sub-title-underline" id="wrapper_title">
   <h2>   
      회원가입
   </h2>
   <ul>
      <li><a href='${contextPath }' class="sct_bg">Home</a></li>
      <li><a href="${contextPath }/memberJoinStep1" class=" ">가입하기</a></li>
   </ul>
   <div class="clearfix"></div>

</div><!-- 글자크기 조정 display:none 되어 있음 시작 { -->

<!-- 회원정보 입력/수정 시작 { -->
<div class="mbskin">
    <form id="fregisterform" name="fregisterform" action="${contextPath }/memberInsert" onsubmit="return fregisterform_submit(this);" method="post" autocomplete="off">

   <input type="hidden" id="MEMB_CHK_YN" name="MEMB_CHK_YN" value="N"/>
   <input type="hidden" id="COM_CHK_YN" name="COM_CHK_YN" value="Y"/>
   
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
                     <input type="text" name="MEMB_ID" value="" id="MEMB_ID" required class="form-control input-sm" style="width: 200px;" minlength="3" maxlength="20" onblur="javascript:fn_idChk();">
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
                  <input type="password" name="MEMB_PW" id="MEMB_PW" required class="form-control input-sm" style="width: 200px;" minlength="3" maxlength="20" 
                     onblur="javascript:fnCheckPassword($('#MEMB_ID').val(),$('#MEMB_PW').val());">
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
	                  <input type="radio" name="MEMB_GUBN" value="MEMB_GUBN_02" required checked onclick="fn_memb_gbn()"/>사업자
	               </label>
	               <label class="radio-inline">
	                  <input type="radio" name="MEMB_GUBN" value="MEMB_GUBN_01" required onclick="fn_memb_gbn()">개인
	               </label>
	               <label class="radio-inline">
	                  <input type="radio" name="MEMB_GUBN" value="MEMB_GUBN_04" required onclick="fn_memb_gbn()">도매유통사업자
	               </label>
	               
	               <h6 style="color:red">* 도매유통사업자 회원가입시 쇼핑몰주문시 배송불가능할수도 있습니다.(사전 협의 필수)</h6>
               </td>
           </tr>
           <tr>
               <th><label for="MEMB_NAME">이름<br/>(대표자성명)</label></th>
               <td>
                   <input type="text" name="MEMB_NAME" value="" id="MEMB_NAME" required class="form-control input-sm" style="width: 200px;" minlength="3" maxlength="20">
               </td>
           </tr>
           <tr>
               <th><label for="MEMB_SEX">성별</label></th>
               <td>
               <label class="radio-inline">
                  <input type="radio" name="MEMB_SEX" value="MEMB_SEX_01" required checked />남 
               </label>
               <label class="radio-inline">
                  <input type="radio" name="MEMB_SEX" value="MEMB_SEX_02" required>여
               </label>

               </td>
           </tr>
           <tr>
               <th><label for="MEMB_BTDY">생년월일</label></th>
               <td>
               <div class="form-inline">
                     <select name="MEMB_BTDY_YEAR" id="MEMB_BTDY_YEAR" class="form-control input-sm">
                         <c:forEach var="i" begin="0" end="${TODAY_YEAR - 1950 }" step="1">
                     <option value="${i + 1950}">${i + 1950}</option>
                     </c:forEach>  
                     </select>년 &nbsp;
                     <select name="MEMB_BTDY_MONTH" id="MEMB_BTDY_MONTH" class="form-control input-sm">
                         <c:forEach var="i" begin="1" end="12" step="1">
                     <option value="${i}">${i}</option>
                     </c:forEach>  
                     </select>월 &nbsp;
                     <select name="MEMB_BTDY_DAY" id="MEMB_BTDY_DAY" class="form-control input-sm">
                         <c:forEach var="i" begin="1" end="31" step="1">
                     <option value="${i}">${i}</option>
                     </c:forEach>  
                     </select>일
                     &nbsp;&nbsp;&nbsp;
                  <label class="radio-inline">
                     <input type="radio" name="SLCAL_GUBN" value="SLCAL_GUBN_01" required checked />양력
                  </label>
                  <label class="radio-inline">
                     <input type="radio" name="SLCAL_GUBN" value="SLCAL_GUBN_02" required />음력
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
                     <input type="text" name="MEMB_PN" value="" id="MEMB_PN" required readonly="readonly" class="form-control input-sm" style="width: 70px;" maxlength="6">
                  </div>
                  <button type="button" class="btn btn-sm btn-default" onclick="win_zip('fregisterform', 'MEMB_PN', 'MEMB_BADR', 'MEMB_DADR', 'EXTRA_ADDR', 'ALL_ADDR');">주소검색</button>
               </div> 
               <div class="form-inline">
                  <div class="form-group">
                     <input type="text" name="MEMB_BADR" value="" id="MEMB_BADR" required readonly="readonly" class="form-control input-sm" style="width:300px;" placeholder="기본주소">
                  </div>
                  <div class="form-group">
                     <p class="form-control-static"><label for="MEMB_BADR">기본주소</label></p>
                  </div>
               </div> 
               <div class="form-inline">
                  <div class="form-group">
                     <input type="text" name="MEMB_DADR" value="" id="MEMB_DADR" required class="form-control input-sm" style="width:300px;" placeholder="상세주소">
                  </div>
                  <div class="form-group">
                     <p class="form-control-static"><label for="MEMB_DADR">상세주소</label></p>
                  </div>
               </div> 

               </td>
           </tr>
           <tr>
               <th><label for="MEMB_TELN">전화번호</label></th>
               <td>
               <div class="form-inline">
                     <input type="hidden" name="MEMB_TELN" value="" id="MEMB_TELN" >
                     <input type="text" name="MEMB_TELN1" value="" id="MEMB_TELN1" class="form-control input-sm"  style="width:50px;" maxlength="3" onkeydown="return onlyNumber(this)">&nbsp;-&nbsp;
                     <input type="text" name="MEMB_TELN2" value="" id="MEMB_TELN2" class="form-control input-sm"  style="width:50px;" maxlength="4" onkeydown="return onlyNumber(this)">&nbsp;-&nbsp;
                     <input type="text" name="MEMB_TELN3" value="" id="MEMB_TELN3" class="form-control input-sm"  style="width:50px;" maxlength="4" onkeydown="return onlyNumber(this)">
                  </div>
               </td>
           </tr>
           <tr class="tb_line">
               <th><label for="MEMB_CPON">휴대폰번호</label></th>
               <td>
               <div class="form-inline">
                     <input type="hidden" name="MEMB_CPON" value="" id="MEMB_CPON" >
                     <input type="text" name="MEMB_CPON1" value="" id="MEMB_CPON1" required class="form-control input-sm"  style="width:50px;" maxlength="3" onkeydown="return onlyNumber(this)">&nbsp;-&nbsp;
                     <input type="text" name="MEMB_CPON2" value="" id="MEMB_CPON2" required class="form-control input-sm"  style="width:50px;" maxlength="4" onkeydown="return onlyNumber(this)">&nbsp;-&nbsp;
                     <input type="text" name="MEMB_CPON3" value="" id="MEMB_CPON3" required class="form-control input-sm"  style="width:50px;" maxlength="4" onkeydown="return onlyNumber(this)">
                  </div>
               </td>
           </tr>
           <input type="hidden" name="BANK_NAME" value="${obj.BANK_NAME }" id="BANK_NAME" required class="form-control input-sm" style="width: 200px;" minlength="2" maxlength="20">
				        <input type="hidden" name="BANK_BUNB" value="${obj.BANK_BUNB }" id="BANK_BUNB" required class="form-control input-sm" style="width: 200px;" minlength="3" maxlength="20">
           <!-- <tr>
               <th><label for="MEMB_CPON">은행명</label></th>
               <td>
               <div class="form-inline">
                     <input type="text" name="BANK_NAME" value="" id="BANK_NAME" required class="form-control input-sm" style="width: 200px;" minlength="3" maxlength="20">
                  </div>
               </td>
           </tr>
           <tr class="tb_line">
               <th><label for="MEMB_CPON">통장번호</label></th>
               <td>
               <div class="form-inline">
                     <input type="text" name="BANK_BUNB" value="" id="BANK_BUNB" required class="form-control input-sm" style="width: 200px;" minlength="3" maxlength="20">
                  </div>
               </td>
           </tr> -->
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
               <td><input type="text" name="COM_NAME" value="" id="COM_NAME"  class="form-control input-sm" style="width: 200px;" maxlength="20"></td>
           </tr>
           <tr>
              <th><label for="COM_BUNB">사업자등록번호</label></th>
              <td>
              	<div class="form-inline">
                     <div class="form-group">
                        <input type="text" name="COM_BUNB" value="" id="COM_BUNB"  class="form-control input-sm" style="width: 200px;" onblur="javascript:fn_bunbChk();"
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
                     <input type="text" name="COM_TELN1" value="" id="COM_TELN1" class="form-control input-sm"  style="width:50px;" maxlength="3" onkeydown="return onlyNumber(this)">&nbsp;-&nbsp;
                     <input type="text" name="COM_TELN2" value="" id="COM_TELN2" class="form-control input-sm"  style="width:50px;" maxlength="4" onkeydown="return onlyNumber(this)">&nbsp;-&nbsp;
                     <input type="text" name="COM_TELN3" value="" id="COM_TELN3" class="form-control input-sm"  style="width:50px;" maxlength="4" onkeydown="return onlyNumber(this)">
                  </div>
               </td>
           </tr>
           <tr>
               <th>회사 주소</th>
               <td>
                   <input type="hidden" name="COM_EXTRA_ADDR" value="" id="COM_EXTRA_ADDR">
                   <input type="hidden" name="COM_ALL_ADDR" value="" id="COM_ALL_ADDR">
               <div class="form-inline">
                  <div class="form-group">
                     <p class="form-control-static">우편번호</p>
                  </div>
                  <div class="form-group">
                     <input type="text" name="COM_PN" value="" id="COM_PN" readonly="readonly" class="form-control input-sm" style="width: 70px;" maxlength="6">
                  </div>
                  <button type="button" class="btn btn-sm btn-default" onclick="win_zip('fregisterform', 'COM_PN', 'COM_BADR', 'COM_DADR', 'COM_EXTRA_ADDR', 'COM_ALL_ADDR');">주소검색</button>
                  <input type="checkbox" id="sameChk" onclick="same_chk()"/>개인정보와 동일
               </div> 
               <div class="form-inline">
                  <div class="form-group">
                     <input type="text" name="COM_BADR" value="" id="COM_BADR" readonly="readonly" class="form-control input-sm" style="width:300px;" placeholder="기본주소">
                  </div>
                  <div class="form-group">
                     <p class="form-control-static"><label for="COM_BADR">기본주소</label></p>
                  </div>
               </div> 
               <div class="form-inline">
                  <div class="form-group">
                     <input type="text" name="COM_DADR" value="" id="COM_DADR" class="form-control input-sm" style="width:300px;" placeholder="상세주소">
                  </div>
                  <div class="form-group">
                     <p class="form-control-static"><label for="COM_DADR">상세주소</label></p>
                  </div>
               </div> 
               </td>
           </tr>
           <tr>
              <th>매장 개점시간</th>
              <td>
                 <div class="form-inline">
                     <select name="COM_OPEN_HH" id="COM_OPEN_HH" class="form-control input-sm">
                         <c:forEach var="i" begin="0" end="23" step="1">
                           <c:set var="data">${i}</c:set>
                           <c:if test="${i < 10}">
                              <c:set var="data">0${i}</c:set>
                        </c:if>
                        <option value="${data}">${data}</option>
                     </c:forEach>  
                     </select>시 &nbsp;
                     <select name="COM_OPEN_MM" id="COM_OPEN_MM" class="form-control input-sm">
                         <c:forEach var="i" begin="0" end="59" step="1">
                           <c:set var="data">${i}</c:set>
                           <c:if test="${i < 10}">
                              <c:set var="data">0${i}</c:set>
                        </c:if>
                        <option value="${data}">${data}</option>
                     </c:forEach>  
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
                         <c:forEach var="i" begin="0" end="23" step="1">
                           <c:set var="data">${i}</c:set>
                           <c:if test="${i < 10}">
                              <c:set var="data">0${i}</c:set>
                        </c:if>
                        <option value="${data}">${data}</option>
                     </c:forEach>  
                     </select>시 &nbsp;
                     <select name="COM_CLOSE_MM" id="COM_CLOSE_MM" class="form-control input-sm">
                         <c:forEach var="i" begin="0" end="59" step="1">
                           <c:set var="data">${i}</c:set>
                           <c:if test="${i < 10}">
                              <c:set var="data">0${i}</c:set>
                        </c:if>
                        <option value="${data}">${data}</option>
                     </c:forEach>  
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
                  <input type="text" name="KEEP_LOCATION" value="" id="KEEP_LOCATION"  class="form-control input-sm" style="width: 100%;" maxlength="20">
                  <h6 style="color:red">* 오후 6시 이후 개점 사업장 상품보관장소를 입력하세요.</h6>
               </td>
           </tr>
           </tbody>
        </table>
    </div>
    <div class="btn_confirm">
        <a href="${contextPath }/" class="btn_cancel btn btn-sm btn-default pull-right">취소</a>
        <input type="submit" value="회원가입" id="btn_submit" class="btn_submit btn btn-sm btn-default pull-right" style="margin-right:5px;" accesskey="s">
    </div>
    </form>


</div>



<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
            <h4 class="modal-title" id="myModalLabel">아이디 중복체크</h4>
         </div>
         <div class="modal-body">
            <form role="form">
            </form>
            <!-- 기업정보 박스 -->
               <div class="box box-info">
                  <div class="box-header with-border">
                     <h3 class="box-title">아이디 중복체크</h3>
                  </div>
                  <!-- /.box-header -->
               
                  <!-- box-body -->
                  <spform:form name="customerFrm" id="customerFrm" method="post" action="" role="form" class="form-horizontal">
                  <div class="box-body">

                     <div class="form-group">
                        <label for="MEMB_ID_CHK" class="col-sm-2 control-label">아이디</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" id="MEMB_ID_CHK" name="MEMB_ID_CHK" value="" placeholder="아이디" required="required" />
                        </div>
                     </div>
                  </div>
                  </spform:form>
                  <!-- /.box-body -->
               </div>
            <!-- 기업정보 박스 -->
         </div>
             <div class="text-center">
            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
            <button type="button" class="btn btn-primary">중복확인</button>
         </div>
      </div>
   </div>
</div>

<!-- } 회원정보 입력/수정 끝 -->