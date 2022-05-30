<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<style type="text/css">

li{
	float:left; 
	list-style:none;	
	width : 16.66666%;
	height: 44px;
	text-align: center;
}

li.a{
	/* border-bottom: 1px solid #cfded8; */
	
	
	border-right: 1px solid #cfded8;
}

li.b{
	border-bottom: 1px solid #cfded8;
	border-left: 1px solid #cfded8;	
	background: #f5f6fa;
}
	
#a1 {
	position:absolute;top:26px;left:95px
}
#a2 {
	position:absolute;top:52px;left:95px
}
#a3 {
	position:absolute;top:78px;left:95px
}
#a4 {
	position:absolute;top:104px;left:95px
}				
#maint {
	border: 1px solid #cfded8;
}


</style>




<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>:::: 식자재몰 - 믿고사는 식자재 ::::</title>

	<link rel="stylesheet" href="${contextPath}/resources/css/mall/default_shop.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/mall/style.css">
	
	<!-- BootStrap 3.3.6 -->		
	<link rel="stylesheet" href="${contextPath }/resources/bootstrap/css/bootstrap.min.css">

	<!-- jQuery 2.1.1 -->
	<script type="text/javascript" src="${contextPath }/resources/js/jquery-2.2.1.min.js"></script>
	<!-- BootStrap 3.3.6 -->
	<script type="text/javascript" src="${contextPath }/resources/bootstrap/js/bootstrap.min.js"></script>
	
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<!-- jQuery FlexSlider v2.6.1 -->
	<script src="${contextPath}/resources/js/jquery.flexslider-min.js"></script>
	
	<script language="javascript">
	//<!--
		var contextPath = "<%= request.getContextPath() %>";
		
	//-->
	</script>
</head>

<body>

<div id="mb_login" class="mbskin">
    <h1><b>비밀번호 찾기</b></h1>
    
    
    <div id="maint" class="main-tab" style="height:340px">
		<!-- 탭 헤드 -->
		<ul class="nav nav-main" role="tablist">
			<li role="presentation" class="a" id="a" style="width:50%" onclick='aclick()'><a href="#home"
				aria-controls="home" role="tab" data-toggle="tab"><b>개인</b></a></li>
			<li role="presentation" class="b" id="b" style="width:50%" onclick='bclick()'><a href="#profile"
				aria-controls="profile" role="tab" data-toggle="tab"><b>사업자</b></a></li>
		</ul>
		<br>
	
		<!-- 탭 바디 -->
		<div class="tab-content tab-con-main">
			<div role="tabpanel" class="tab-pane active" id="home" style="margin-left:10px; margin-right:10px;"> <!-- class ta_c뺌 -->
			
				<!-- 탭 : 개인 -->		
				<div id = "private">				
				    <form name="flogin" action="${contextPath }/findmemberinfo/result2" onsubmit="return flogin_submit(this);" method="post">
					    <input type="hidden" name="url" value="">
					    <input type="hidden" name="rtnUrl" value='<%= request.getHeader("referer") %>'>
						<label class="login_id">개인</label>
						
					    <fieldset id="login_fs" style="height:150px;">    
					    	
					    	<label id="a1">회원ID<strong class="sound_only"> 필수</strong></label>    
					        <input type="text" name="MEMB_ID" id="MEMB_ID" required class="frm_input required" size="20" maxLength="20">
					    	
					        <label id="a2"">회원이름<strong class="sound_only"> 필수</strong></label>    
					        <input type="text" name="MEMB_NAME" id="MEMB_NAME" required class="frm_input required" size="20" maxLength="20">
					        
					        <label for="login_pw" id = "a3">휴대폰번호<strong class="sound_only"> 필수</strong></label>
					        <div class="form-inline" style="margin: 0 0 5px 80px;">
					         	<input type="hidden" name="MEMB_CPON" value="" id="MEMB_CPON" >
					         	<input type="text" name="MEMB_CPON1" value="" id="MEMB_CPON1" required   style="width:50px; background-color: #f7f7f7; border: 1px solid #e4eaec;" maxlength="4">&nbsp;-&nbsp;
					         	<input type="text" name="MEMB_CPON2" value="" id="MEMB_CPON2" required   style="width:50px; background-color: #f7f7f7; border: 1px solid #e4eaec;" maxlength="4">&nbsp;-&nbsp;
					         	<input type="text" name="MEMB_CPON3" value="" id="MEMB_CPON3" required   style="width:50px; background-color: #f7f7f7; border: 1px solid #e4eaec;;" maxlength="4">
		         			</div>  
					        
					    </fieldset>        
					
					    <aside id="login_info">
					    
					        <div>        
					        	<a href="${contextPath}/findmemberinfo/findid" class="btn01">아이디 찾기</a>        
					        	<input type="submit" value="찾기" class="btn_submit">
					        </div>
					        
					    </aside>	
				    </form>
				</div>	
			</div>
			
			<!-- 탭 : 사업자 -->
			<div role="tabpanel" class="tab-pane" id="profile"  style="margin-left:10px; margin-right:10px;"> <!-- class ta_c뺌 -->
				<div id = "business">
				    <form name="flogin" action="${contextPath }/findmemberinfo/result2" onsubmit="return flogin_submit(this);" method="post">
					    <input type="hidden" name="url" value="">
					    <input type="hidden" name="rtnUrl" value='<%= request.getHeader("referer") %>'>
								
						<label class="login_id">사업자</label>
						
					    <fieldset id="login_fs" style="height:150px;">    
					    
					    	<label id="a1">회원ID<strong class="sound_only"> 필수</strong></label>    
					        <input type="text" name="MEMB_ID" id="MEMB_ID" required class="frm_input required" size="20" maxLength="20">
					    	
					        <label id="a2">회원이름<strong class="sound_only"> 필수</strong></label>    
					        <input type="text" name="MEMB_NAME" id="MEMB_NAME" required class="frm_input required" size="20" maxLength="20">
					        
					        <label for="login_pw" id = "a3">휴대폰번호<strong class="sound_only"> 필수</strong></label>
					        <div class="form-inline" style="margin: 0 0 5px 80px;">
					         	<input type="hidden" name="MEMB_CPON" value="" id="MEMB_CPON20" >
					         	<input type="text" name="MEMB_CPON1" value="" id="MEMB_CPON21" required   style="width:50px; background-color: #f7f7f7; border: 1px solid #e4eaec;" maxlength="4">&nbsp;-&nbsp;
					         	<input type="text" name="MEMB_CPON2" value="" id="MEMB_CPON22" required   style="width:50px; background-color: #f7f7f7; border: 1px solid #e4eaec;" maxlength="4">&nbsp;-&nbsp;
					         	<input type="text" name="MEMB_CPON3" value="" id="MEMB_CPON23" required   style="width:50px; background-color: #f7f7f7; border: 1px solid #e4eaec;;" maxlength="4">
		         			</div>
					        
					        <label id="a4">사업자번호<strong class="sound_only"> 필수</strong></label>
					        <input type="text" name="COM_BUNB" id="COM_BUNB" required class="frm_input required" size="20" maxLength="20">        
					        
					    </fieldset>        
					
					    <aside id="login_info">
					    
					        <div>
					        	<a href="${contextPath}/findmemberinfo/findid" class="btn01">아이디 찾기</a>        
					        	<input type="submit" value="찾기" class="btn_submit">
					        </div>
					        
					    </aside>	
				    </form>
				</div>     
			
			</div>
		</div>
	</div>
    
	    <div class="btn_confirm">
	        <br><a href="${contextPath}/">메인으로 돌아가기</a>
	    </div>
    

</div>

</body>
</html>
<script>


function flogin_submit(f)
{
	
	$('#MEMB_CPON').val($('#MEMB_CPON1').val()+"-"+$('#MEMB_CPON2').val()+"-"+$('#MEMB_CPON3').val());
	$('#MEMB_CPON20').val($('#MEMB_CPON21').val()+"-"+$('#MEMB_CPON22').val()+"-"+$('#MEMB_CPON23').val());
	
    return true;
}

function aclick() {
	$("#a").css("border-bottom", "1px solid #ffffff");
	$("#b").css("border-bottom", "1px solid #cfded8");
	
	$("#a").css("background-color","#ffffff");
	$("#b").css("background-color","f5f6fa");
	
}
	

function bclick() {	
	$("#a").css("border-bottom", "1px solid #cfded8");
	$("#b").css("border-bottom", "1px solid #ffffff");
	
	$("#a").css("background-color","f5f6fa");
	$("#b").css("background-color","#ffffff");
}

</script>
