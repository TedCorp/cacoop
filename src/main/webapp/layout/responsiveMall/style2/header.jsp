<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

   
<script type="text/javascript">
   /* Side Menu */
   $(document).ready(function(){
      // ssl
      if (document.location.protocol == 'http:') {      
           //document.location.href = document.location.href.replace('http:', 'https:');
       }      
   
      /* 카테고리 탑 2차 지정 */
       <c:forEach items="${cagoList }" var="subMenu">
          <c:if test="${subMenu.LVL eq '3'}">
            if($("#link_${subMenu.UPCAGO_ID} > b").length < 1){
                $("#link_${subMenu.UPCAGO_ID}").append("<b class='fa-angle-right'></b>");
            }
             $("#subMenuUl_${subMenu.UPCAGO_ID}").append("<li id='subMenuLi_${subMenu.CAGO_ID }'><a href='${contextPath }/m/product?CAGO_ID=${ subMenu.CAGO_ID }' class='main-menu'>${subMenu.CAGO_NAME}</a></li>");   
         </c:if>
       </c:forEach>
       
       /* 하위카테고리 없을경우 div 삭제 */
      $(".cagoMenu").each(function() {
         var strId = $(this).attr('id');
         if($(this).find('.fa-angle-right').length < 1){
            $(this).find('.sub-menu').remove();
         }
      });
   
      /* 모바일 돋보기 검색 >> 바로 상세검색으로... */
      $('.icon-search').click(function(){
         
         //$(this).removeClass('active');
         //$('#search0').css('display', 'none');
         //$('#searchform').submit();
      });
      
      // 최상단 큰배너
      $("#hd_close").click(function(){
         $("#hd_banner").slideUp('fast');
      });
      
      
   });   
   
   /* Cart add remove functions */
   var cart = {
      'add': function(product_id, product_name, product_cut, product_option, option_cnt) {
             <c:if test="${empty USER.MEMB_ID}">
            alert("로그인이 필요합니다.");
            return false;
         </c:if>

         if(product_cut > 0){
            alert("세절방식을 선택해야하는 상품입니다.\n상품상세페이지에서 세절방식을 선택 후 장바구니에 담아주세요.");
            return false;
         }
         if(option_cnt != "0"){
            alert("옵션을 선택해야하는 상품입니다.\n상품상세페이지에서 옵션을 선택 후 장바구니에 담아주세요.");
            return false;
         }
         if(product_option != ""){
            alert("색상을 선택해야하는 상품입니다.\n상품상세페이지에서 색상을 선택 후 장바구니에 담아주세요.");
            return false;
         }
      
           //장바구니 등록 여부 확인
          $.ajax({
             type: "GET",
             url: '${contextPath}/goods/basketInst?PD_CODE='+product_id,
             success: function (data) {
                // 장바구니 등록 여부
                if (data == '0') {
                   addProductNotice('장바구니 추가', '', '<h3>[' + product_name + '] 장바구니에 등록되었습니다.</h3>', 'success');
                   
                   $("#myCartListCntHeader").text(parseInt($("#myCartListCntHeader").text())+1)
                }else{
                  addProductNotice('장바구니 추가', '', '<h3 style="color:red;">장바구니에 이미 등록된 상품 입니다.</h3>', 'success');
                }
             }, error: function (jqXHR, textStatus, errorThrown) {
                alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
             }
          });
      }
   }
   
   // Wish List add remove functions
   var wishlist = {
      'add': function(product_id, product_name, product_cut, product_option, option_cnt) {
             <c:if test="${empty USER.MEMB_ID}">
            alert("로그인이 필요합니다.");
            return false;
         </c:if>

         if(product_cut > 0){
            alert("세절방식을 선택해야하는 상품입니다.\n상품상세페이지에서 세절방식을 선택 후 장바구니에 담아주세요.");
            return false;
         }
         if(option_cnt != "0"){
            alert("옵션을 선택해야하는 상품입니다.\n상품상세페이지에서 옵션을 선택 후 장바구니에 담아주세요.");
            return false;
         }
         if(product_option != ""){
            alert("색상을 선택해야하는 상품입니다.\n상품상세페이지에서 색상을 선택 후 장바구니에 담아주세요.");
            return false;
         }
         
         // 관심상품 등록 여부 확인
          $.ajax({
            type: "GET",
             url: '${contextPath}/goods/wishInst?PD_CODE='+product_id+'&PD_QTY=1&PD_CUT_SEQ=&OPTION_CODE=',
             success: function (data) {
                // 관심상품 등록 여부
                if (data == '0') {
                   //alert("관심상품에 등록되었습니다.");
                  addProductNotice('관심상품 추가', '', '<h3>[' + product_name + '] 관심상품에 등록되었습니다.</h3>', 'success');
                }else{
                  addProductNotice('관심상품 추가', '', '<h3 style="color:red;">관심상품에 이미 등록되어있습니다.</h3>', 'success');
                }
             }, error: function (jqXHR, textStatus, errorThrown) {
                alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
             }
          });
      }
   }
   
/*    function namee_login()
   {
      var userId = "${USER.MEMB_ID}";
      var userName = "${USER.MEMB_NAME}";
      window.open('https://atomyaza.co.kr/m/shop/service/namee.php?memberId='+ userId +'&name='+encodeURI(userName), '_blank');
    }

   function kyobo_login()
   {
      var userId = "${USER.MEMB_ID}";
      var userName = "${USER.MEMB_NAME}";
      var phone = "${USER.MEMB_CPON}";
        window.open('https://atomyaza.co.kr/m/shop/service/kyobo.php?userId='+ userId +'&userName='+encodeURI(userName)+'&userHp='+phone, '_blank');
    } */
</script>  
<style>
   /* 모바일 상단배너 */
   .p-fixed {height: 40px;}
   .p-fixed ul {white-space:nowrap; overflow:auto; text-align:center; list-style:none;}
   .p-fixed ul li {display:inline-block; padding-right: 10px;}
   .p-fixed ul li a {color:white;}
   
   /* 교보문고 배너 */
   #hd_banner{text-align:center;position:relative;}
   #hd_banner a {height:100%;display:block;text-decoration:none !important;}
   #hd_close{width:26px;height:26px;position:absolute;top:50%;right:17px;margin-top:-13px;cursor:pointer;}
      
   #tnb_inner li:first-child:before {display:none;}
   #tnb_inner li:before {width:1px;height:16px;margin:10px 10px; background-color:#ddd;display:inline-block;float:left;content:'';}
   .atomy-ico, #tnb_inner .fl li i{display:inline-block;width:16px;height:16px;margin-right:6px;background:no-repeat center center / 100% auto;vertical-align:middle;}
   .atomy span, #tnb_inner .fl li span{display:inline-block;vertical-align:middle;}
   .ico-ncard, #tnb_inner .fl li:nth-child(1) i{background-image:url(https://atomyaza.co.kr//img/custom/icon_ncard.png);}
   .ico-book, #tnb_inner .fl li:nth-child(2) i{background-image:url(https://atomyaza.co.kr//img/custom/icon_book.png);}      
   
   .atomy-ico {margin-right:2px;}
   .atomy {float:left;}
   .searchDiv{display: flex;align-items: center;}
   .searceSelect{border: none; padding-top: 3px;}
</style>

<!-- Header Container  -->
<header>
	<form method="GET" name="searchform" id="searchform" action="${contextPath}/m/search" >
	    <div class="main-top">
	        <div class="top-area-wrap tb pt3">
	            <div class="logo-area">
	                <a href="/m">logo</a>
	            </div>
	
	       		<!-- 검색 -->
	            <div class="search-zone">  
	            	<div class="searchDiv">    
	            		<select name="schGbn" class="searceSelect">
	            			<option value="PD_NAME" ${ param.schGbn eq 'PD_NAME' ? "selected='selected'":''}>상품명</option>
	            			<option value="SUPR_NAME" ${ param.schGbn eq 'SUPR_NAME' ? "selected='selected'":''}>상호명</option>
	            		</select>                          
	                	<input type="text" autocomplete="off" name="schTxt" value="${param.schTxt }">
	                	<button type="submit"></button>
	                </div>
	            </div>     
	            <!-- 검색END -->       
	               
	            <div class="nav">
	               <c:choose>
	               <c:when test="${empty USER.MEMB_ID}">
	                   <ul>
	                       <li><a href="${contextPath}/m/user/loginForm">로그인</a></li>
	                       <li><a href="${contextPath}/m/memberJoinStep1">회원가입</a></li>
	                       <li><a href="${contextPath}/m/basket">장바구니</a></li>
	                       <li><a href="${contextPath}/m/mypage">마이페이지</a></li>
	                   </ul>
	                </c:when>
	                <c:when test="${!empty USER.MEMB_ID}">
	                   <ul>
	                    <li class="ic_logout"><a href="${contextPath}/m/user/logout">(${ USER.MEMB_NAME } 님) 로그아웃</a></li>
	                      <li class="ic_mypage"><a href="${contextPath}/m/mypage">마이페이지</a></li>
	                      <li class="ic_cart"><a href="${contextPath}/m/basket">장바구니</a></li>
	                    </ul>
	                </c:when>
	                </c:choose>
	            </div>
	        </div>
	    </div>
    </form> 

    <div class="header" style="position: absolute; top: auto;">
        <div class="header-conts clear-fix">
            <div class="nav01">
                <ul class="nav-items01 clear-fix">
                    <li class="menu">
                        <a href="javascript::void(0)">전체메뉴</a>
                        <div class="sub-nav" style="display: none;">
                            <div class="dep01">
                                <div class="dep1">
                                    <ul>
                                        <c:set var="nCnt" value="0" />
                                        <c:forEach var="ent" items="${ cagoList }" varStatus="status">
                                            <c:if test="${ent.LVL eq '2' }">
                                                <c:set var="nCnt" value="${nCnt+1 }" />
                                                <li class="" id="liCago_${ent.CAGO_ID }" ${nCnt> 10 ? 'style="display:none;"' : '' }>                        
                                                    <a class="" id="link_${ent.CAGO_ID }" href="${contextPath }/m/product?CAGO_ID=${ ent.CAGO_ID }">
                                                       <img src="${contextPath}/resources/images/responsive/catalog/menu/icons/ico0.png" alt="icon">
                                                        <span>${ ent.CAGO_NAME }</span>
                                                    </a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <div class="dep2">
                                    <c:forEach var="ent" items="${ cagoList }" varStatus="status">
                                        <c:if test="${ent.LVL eq '2' }">
                                            <ul>
                                                <li>
                                                    <div class="sub-menu" data-subwidth="20"id='subMenuDiv_${ent.CAGO_ID }'></div>
                                                     <div id='subMenuUl_${ent.CAGO_ID }'></div>                                        
                                                </li>
                                            </ul>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="on"><a href="/m/intro">건설건축협동조합소개</a></li>
                    <li><a href="/m/product/eventList">기획전</a></li>
                    <li><a href="/m/community">고객센터</a></li>
                </ul>
            </div>
        </div>
    </div>

</header>
<!-- Header Container  -->
  
  
<%--  
<header id="header" class=" typeheader-2">
   
    <div class="header-top hidden-compact">
        <div class="container">
            <div class="row">
                <div class="header-top-left col-lg-8 col-md-8 col-sm-6 col-xs-3" id   ="tnb">
                   <div class="hidden-md hidden-sm hidden-xs telephone" id="tnb_inner">
               </div>
                    <c:if test="${empty USER.MEMB_ID}">
                    <ul class="account hidden-lg atomy-wd">                       
                        <li class="account" id="my_account">
                            <a href="#" title="My Account " class="btn-xs dropdown-toggle" data-toggle="dropdown"> <span class="hidden-xs">회원서비스 </span>  <span class="fa fa-caret-down"></span>
                            </a>
                            <ul class="dropdown-menu ">
                               <li><a href="${contextPath}/m/memberJoinStep1"><i class="fa fa-user"></i> 회원가입</a></li>
                               
                               <li><a href="${contextPath}/m/user/loginForm"><i class="fa fa-pencil-square-o"></i> 로그인</a></li>
                            </ul>
                        </li>
                        
                    </ul> 
                    </c:if> 
                </div>
                <div class="header-top-right collapsed-block col-lg-4 col-md-4 col-sm-6 col-xs-9">
                    <div class="inner"> 
                        <ul class="top-link list-inline lang-curr">
                     <c:if test="${!empty USER.MEMB_ID}">
                               <li class="language">
                                   <div class="btn-group languages-block ">
                                       <form action="index.html" method="post" enctype="multipart/form-data" id="bt-language">
                                           <a class="btn btn-link dropdown-toggle" data-toggle="dropdown">
                                               <span class=""><i class="fa fa-user"></i>회원서비스 (${USER.MEMB_NAME})</span>
                                               <span class="fa fa-angle-down"></span>
                                           </a>
                                           <ul class="dropdown-menu">
                                      <li><a href="${contextPath}/m/mypage">마이페이지</a></li>
                                      <li><a href="${contextPath}/m/basket">장바구니</a></li>
                                      <li><a href="${contextPath}/m/wishList">관심상품</a></li>
                                      <li><a href="${contextPath}/m/order/wishList">주문배송조회</a></li>
                                      <li><a href="${contextPath}/m/mypage/buyBeforeInfo" style="color:red;">미결재내역(${NOTPAYCNT})</a></li>
                                      <li><a href="${contextPath}/m/community/list">1:1문의</a></li>
                                      <li><a href="${contextPath}/m/user/logout">로그아웃</a></li>
                                           </ul>
                                       </form>
                                   </div>
                               </li>
                     </c:if>                            
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //Header Top -->

    <!-- Header center -->
    <div class="header-middle">
        <div class="container">
            <div class="row">
                <!-- Logo -->
                <div class="navbar-logo col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <div class="logo">
                       <a href="${contextPath}/m"><img src="https://www.cjflsmart.co.kr/resources/img/common/azalogo.png" title="CJFLSMART" alt="CJFLSMART" /></a>
                    </div>
                </div>
                <!-- //end Logo -->
                <!-- Search -->
                <div class="middle2 col-lg-6 col-md-7 col-sm-6 col-xs-6">
                    <div class="search-header-w">
                        <div class="icon-search hidden-lg hidden-md"><i class="fa fa-search"></i></div><!-- 모바일 돋보기 아이콘 -->
                        <div id="sosearchpro" class="sosearchpro-wrapper so-search ">
                            <form method="GET" name="searchform" id="searchform" action="${contextPath}/m/search">
                                <div id="search0" class="search input-group form-group">
                                    <div class="select_category filter_type  icon-select hidden-sm hidden-xs">
                              <select class="no-border" name="schGbn">
                                 <option value="PD_NAME" ${param.schGbn eq 'PD_NAME' ? 'selected=selected' : '' }>상품명</option>
                                 <option value="PD_DINFO" ${param.schGbn eq 'PD_DINFO' ? 'selected=selected' : '' }>상품상세</option>
                              </select>
                                    </div>
                                    <input class="autosearch-input form-control" type="search" value="${param.schTxt }" style="ime-mode:active;z-index: 999" size="50" autocomplete="off" placeholder="아자마트 검색어 입력" name="schTxt">
                                    <span class="input-group-btn">
                                    <button type="submit" class="button-search btn btn-primary" name="submit_search"><i class="fa fa-search"></i><span>검색</span></button>
                                    </span>
                                </div>
                                <input type="hidden" name="route" value="product/search" />
                            </form>
                        </div>
                    </div>
                </div>
                <!-- //end Search -->
                <div class="middle3 col-lg-3 col-md-2 col-sm-6 col-xs-6">       
                    <c:if test="${!empty USER.MEMB_ID}">
                    <!--cart-->
                    <div class="shopping_cart">
                        <div id="cart" class="btn-shopping-cart">
                            <a data-loading-text="Loading... " class="btn-group top_cart dropdown-toggle" href="${contextPath }/m/basket">
                        <div class="shopcart">
                           <span class="icon-c">
                              <i class="fa fa-shopping-bag"></i>
                           </span>
                           <div class="shopcart-inner">
                              <p class="text-shopping-cart">장바구니</p>                              
                              <span class="total-shopping-cart cart-total-full">
                                 <span class="items_cart" id="myCartListCntHeader">${fn:length(myCartList)}</span><span class="items_cart2"> item(s)</span><!-- span class="items_carts"> ($162.00) </span -->
                              </span>
                           </div>
                        </div>
                     </a>
                        </div>
                    </div>
                    <!--//cart-->
                    </c:if>
                    <c:if test="${empty USER.MEMB_ID}">
                       <ul class="login-w hidden-md hidden-sm hidden-xs">
                           <li>회원서비스</li>
                           <li class="logout">
                              <a href="${contextPath}/m/user/loginForm">로그인</a>
                              / <a href="${contextPath}/m/memberJoinStep1">회원가입</a>
                           </li>
                       </ul>            
                    </c:if>                    
                </div>
            </div>
        </div>
    </div>
    <!-- //Header center -->

    <!-- Header Bottom -->
    <div class="header-bottom hidden-compact">
        <div class="container">
            <div class="row">                
                <div class="bottom1 menu-vertical col-lg-2 col-md-3">
                    <!-- Secondary menu -->
                    <div class="responsive so-megamenu megamenu-style-dev">
                        <div class="so-vertical-menu ">
                            <nav class="navbar-default">    
                                <div class="container-megamenu vertical">
                                    <div id="menuHeading">
                                        <div class="megamenuToogle-wrapper">
                                            <div class="megamenuToogle-pattern">
                                                <div class="container">
                                                    <div>
                                                        <span></span>
                                                        <span></span>
                                                        <span></span>
                                                    </div>
                                                    <b>전체 카테고리</b>                          
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="navbar-header">
                                          <div class="p-fixed">
                                             <ul>
                                                <li>
                                                   <button type="button" id="show-verticalmenu" data-toggle="collapse" class="navbar-toggle">      
                                                     <i class="fa fa-bars"></i><span><b>전체 카테고리</b></span>
                                                 </button>
                                                </li>
                                                <li><a href="${contextPath }/m/order/wishList" class="clearfix">주문배송조회</a></li>
                                    <li><a href="${contextPath }/m/community/faqList" class="clearfix p-fixed">자주묻는 질문</a></li>
                                                <li><a href="${contextPath }/m/community" class="clearfix p-fixed">고객센터</a></li>
                                             </ul>
                                          </div>
                                    </div>
                                    <div class="vertical-wrapper" >
                                        <span id="remove-verticalmenu" class="fa fa-times"></span>
                                        <div class="megamenu-pattern">
                                            <div class="container-mega">
                                                <ul class="megamenu">
                                       <c:set var="nCnt" value="0" />
                                       <c:forEach var="ent" items="${ cagoList }" varStatus="status">
                                          <c:if test="${ent.LVL eq '2' }">
                                          <c:set var="nCnt" value="${nCnt+1 }" />
                                                          <li class="item-vertical cagoMenu css-menu with-sub-menu hover" id="liCago_${ent.CAGO_ID }" ${nCnt > 10 ? 'style="display: none;"' : '' }>
                                                              <p class="close-menu"></p>
                                                              <a class="clearfix" id="link_${ent.CAGO_ID }" href="${contextPath }/m?entcago=${ ent.CAGO_ID }">                                                                    
                                                              <a class="clearfix" id="link_${ent.CAGO_ID }" href="${contextPath }/m/product?CAGO_ID=${ ent.CAGO_ID }">                                                                    
                                                                  <img src="${contextPath}/resources/images/responsive/catalog/menu/icons/ico0.png" alt="icon">
                                                                  <span>${ ent.CAGO_NAME }</span>
                                                              </a>
                                                              <div class="sub-menu" data-subwidth="20" id='subMenuDiv_${ent.CAGO_ID }'>
                                                                  <div class="content" >
                                                                      <div class="row">
                                                                          <div class="col-sm-12">
                                                                              <div class="row">
                                                                                  <div class="col-sm-12 hover-menu">
                                                                                      <div class="menu">
                                                                                          <ul id='subMenuUl_${ent.CAGO_ID }'>
                                                                                          </ul>
                                                                                      </div>
                                                                                  </div>
                                                                              </div>
                                                                          </div>
                                                                      </div>
                                                                  </div>
                                                              </div>
                                                          </li>
                                          </c:if>
                                       </c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                             </nav>
                        </div>
                    </div>
                    <!-- // end Secondary menu -->
                </div>
                <!-- Main menu -->
                <div class="main-menu-w col-lg-10 col-md-9">
                    <div class="responsive so-megamenu megamenu-style-dev">
                        <nav class="navbar-default">
                            <div class=" container-megamenu  horizontal open ">
                                <div class="megamenu-wrapper">
                                    <span id="remove-megamenu" class="fa fa-times"></span>
                                    <div class="megamenu-pattern">
                                        <div class="container-mega">
                                           <ul class="megamenu" data-transition="slide" data-animationtime="250">
                                                <li class="">
                                                    <a href="${contextPath }/m/order/wishList" class="clearfix">
                                                        <strong>주문배송조회</strong>
                                                    </a>
                                                </li>
                                                <li class="">
                                                    <a href="${contextPath }/m/community/faqList" class="clearfix">
                                                        <strong>자주묻는 질문</strong>
                                                    </a>
                                                </li>
                                                <li class="">
                                                    <a href="${contextPath }/m/community" class="clearfix">
                                                        <strong>고객센터</strong>
                                                    </a>
                                                </li>                                                
                                            </ul>
                                            <!-- // Bar menu --> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </nav>
                    </div>
                </div>
                <!-- //end Main menu -->                
            </div>
        </div>
    </div>
</header>     
 --%>