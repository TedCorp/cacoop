<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
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

<!-- 로그인 시작 { -->
<div id="mb_login" class="mbskin">
    <h1><b>비밀번호 찾기</b></h1>
    
    <input type="hidden" name="url" value="">
    <input type="hidden" name="rtnUrl" value='<%= request.getHeader("referer") %>'>

	
	<label class="login_id">결과 </label>
	
	
	<fieldset id="login_fs">
	
		<c:choose>
			<c:when test="${list.size() == 0}">
				<label style ="font-size:20px ">회원정보가 없습니다</label>
			</c:when>
			
			<c:otherwise>
				<label>임시 비밀번호가 발급되었습니다.</label><br>
    			<c:forEach items="${list }" var="lst">
					<label style ="font-size:30px">${lst.MEMB_PW}</label>
					<br>
				</c:forEach>
			</c:otherwise>
		
		</c:choose>
		        
    </fieldset>
    
    <aside id="login_info">
    
        <div>        
        	<!-- <input type="submit" value="찾기" class="btn_submit"> -->
            <!--a href="<?php echo G5_BBS_URL ?>/password_lost.php" target="_blank" id="login_password_lost" class="btn02">아이디 비밀번호 찾기</a -->
            <a href="${contextPath}/findmemberinfo/findid" class="btn01">아이디찾기</a>
            <a href="${contextPath}/findmemberinfo/findpw" class="btn01">비밀번호찾기</a>
        </div>
        
    </aside>
	
	<div class="btn_confirm">
        <a href="${contextPath}/">메인으로 돌아가기</a>
    </div>
	
	
	
	<%-- ${list.MENB_NAME[0]}
	${list.MENB_CPON[0]} --%>

   <%--  <fieldset id="login_fs">
    
    	
        <label for="login_id" class="login_id">회원이름<strong class="sound_only"> 필수</strong></label>    
        <input type="text" name="MEMB_NAME" id="MEMB_NAME" required class="frm_input required" size="20" maxLength="20">
        
        <label for="login_pw" class="login_pw">핸드폰번호<strong class="sound_only"> 필수</strong></label>
        <input type="text" name="MEMBER_HP" id="MEMB_HP" required class="frm_input required" size="20" maxLength="20">
        
        
    </fieldset>
    
    

    <aside id="login_info">
    
        <div>        
        	<input type="submit" value="찾기" class="btn_submit">
            <!--a href="<?php echo G5_BBS_URL ?>/password_lost.php" target="_blank" id="login_password_lost" class="btn02">아이디 비밀번호 찾기</a -->
            <a href="${contextPath}/memberJoinStep1" class="btn01">asdsad</a>
        </div>
        
    </aside>

    </form>

     --%>

</div>

</body>
</html>
<script>

function flogin_submit(f)
{
	
    return true;
}
</script>
