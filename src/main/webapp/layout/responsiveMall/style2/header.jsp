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
                    <li><a href="/m/product/eventList">프로젝트</a></li>
                    <li><a href="/m/community">고객센터</a></li>
                </ul>
            </div>
        </div>
    </div>
</header>
<!-- Header Container  -->