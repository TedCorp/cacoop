<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- header -->
<header class="head">
    <div class="container">
        <div class="col-sm-3 left pd_n" ><a href="${contextPath}/"><img src="${contextPath}/resources/img/common/logo.png"></a></div>
        <div class="col-sm-9 right">
            <div class="row">
                <div class="col-sm-6 pd_n">
               <c:if test="${empty USER.MEMB_ID}">
                    <form class="form-inline" action="${contextPath }/user/login" method="post">
                   <input type="hidden" name="rtnUrl" value=''>
                        <div class="form-group">
                            <label for="LOGIN_ID" class="mt_5">ID</label>
                            <input type="text" class="form-control" style="width:120px;" name="MEMB_ID"  id="LOGIN_ID" placeholder="아이디" >
                        </div>
                        <div class="form-group">
                            <label for="LOGIN_PW" class="mt_5">PW</label>
                            <input type="password" class="form-control" style="width:120px;"  name="MEMB_PW" id="LOGIN_PW" placeholder="비밀번호" >
                        </div>
                        <button type="submit" class="btn btn-xs btn-success">로그인</button>
                    </form>
               </c:if>
                </div>
                <div class="col-sm-6 pd_n">
                    <ul class="nav nav-utill">
                  <c:if test="${empty USER.MEMB_ID}">
                  		   <%-- <li><a href="${contextPath}/user/loginForm" style="color:red">아이디/비밀번호찾기</a></li> --%>
                           <%-- <li><a href="${contextPath}/memberJoinStep1">회원가입</a></li> --%>                           
                           <!-- <li><a href="https://atomyaza.co.kr/bbs/login.php">로그인</a></li> -->
                           <li><a href="${contextPath}/user/loginForm">로그인</a></li>
                           <li><a href="${contextPath}/">첫화면이동</a></li>
                  </c:if>
                  <c:if test="${!empty USER.MEMB_ID}">
                           <li><a href="#">${USER.MEMB_NAME}</a></li>
                           <li><a href="${contextPath}/mypage">마이페이지</a></li>
                           <li><a href="${contextPath}/basket">장바구니</a></li>
                           <li><a href="${contextPath}/wishList">관심상품</a></li>
                           <li><a href="${contextPath}/order/wishList">배송/주문조회</a></li>
                           <li><a href="${contextPath}/mypage/buyBeforeInfo" style="color:red;">미결재내역(${NOTPAYCNT})</a></li>
                           <%-- <li><a style="color:red;">배송비쿠폰(${DELICUPON})</a></li> --%>
                           <li><a href="${contextPath}/user/logout">로그아웃</a></li>
                           <li><a href="${contextPath}/">첫화면이동</a></li>
                  </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- 내용 -->
<nav class="navbar navbar-bg">
    <div class="container">
        <div class="navbar-header">
            <img src="${contextPath}/resources/img/common/gnb_img1.png">
            <button style="margin-left:20px;" type="button" class="btn btn-xs btn-danger" onclick="javascript:window.open('http://www.cjfls.co.kr/adCj2');"   >행사상품전단지 바로보기</button>
        </div>
        
        <div id="navbar">
            <ul class="nav navbar-nav" style="margin-left:20px"><!-- style="margin-left:300px"> -->
                <!-- <li class="active"><a href="#">베스트 상품</a></li>
                <li><a href="#">신규등록 상품</a></li>
                <li><a href="#">이달의 특가상품</a></li>  -->
                <li><a href="${contextPath}/community" style="font-size:14px;">고객센터</a></li>
                <li><a href="${contextPath}/intro" style="font-size:14px;">회사소개</a></li>
                <li><a href="${contextPath}/introPicture" style="font-size:14px;">매장소개</a></li>
            </ul>
            <spform:form name="searchFrm" id="searchFrm" method="get" action="${contextPath }/search" class="navbar-form navbar-gnb pd_n navbar-right">
                <div class="form-group">
                    <input name="schTxt" class="form-control" style="width:200px; ime-mode:active; " type="text" placeholder="검색어를 입력하세요" value="${param.schTxt }">
                </div>
                <button type="submit" class="btn btn-xs btn-black">검색</button>
           </spform:form>
        </div><!--/nav -->
    </div>
</nav>