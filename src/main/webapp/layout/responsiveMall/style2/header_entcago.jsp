<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->
                                             
<script type="text/javascript">
	/* Side Menu */
	$(document).ready(function(){		
		/* 카테고리 탑 2차 지정 */
	    <c:forEach items="${cagoList }" var="subMenu">
		    <c:if test="${subMenu.LVL eq '3'}">
				if($("#link_${subMenu.UPCAGO_ID} > b").length < 1){
			    	$("#link_${subMenu.UPCAGO_ID}").append("<b class='fa-angle-right'></b>");
				}
		    	$("#subMenuUl_${subMenu.UPCAGO_ID}").append("<li id='subMenuLi_${subMenu.CAGO_ID }'><a href='${contextPath }/m/product?CAGO_ID=${ subMenu.CAGO_ID }&entcago=${entcagoInfo.ENTRY_ID}' class='main-menu'>${subMenu.CAGO_NAME}</a></li>");	
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
			$(this).removeClass('active');
			$('#search0').css('display', 'none');
			$('#searchform').submit();
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
	
	function namee_login()
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
    }
</script>  
<style>
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
</style>

<!-- Header Container  -->
<header>
	<div class="main-top">
		<div class="top-area-wrap tb pt3">
			<div class="logo-area">
				<a href="#">logo</a>
			</div>

			<div class="search-zone">
				<div>
					<input type="text">
					<button></button>
				</div>
			</div>
			<div class="nav">
				<ul>
					<li><a href="#">로그인</a></li>
					<li><a href="#">회원가입</a></li>
					<li><a href="#">장바구니</a></li>
					<li><a href="#">마이페이지</a></li>
				</ul>
			</div>
		</div>
	</div>

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
										<li class=""><a href="javascript::void(0)">대카테고리명칭</a></li>
										<li><a href="javascript::void(0)">대카테고리명칭</a></li>
										<li><a href="javascript::void(0)">대카테고리명칭</a></li>
										<li><a href="#">1차 메뉴</a></li>
										<li><a href="#">1차 메뉴</a></li>
									</ul>
								</div>
								<div class="dep2">
									<ul class="">
										<li><a href="#">중카테고리명칭1</a></li>
										<li><a href="#">2차 메뉴</a></li>
										<li><a href="#">2차 메뉴</a></li>
										<li><a href="#">2차 메뉴</a></li>
										<li><a href="#">2차 메뉴</a></li>
									</ul>
									<ul>
										<li><a href="#">중카테고리명칭2</a></li>
										<li><a href="#">2차 메뉴</a></li>
										<li><a href="#">2차 메뉴</a></li>
										<li><a href="#">2차 메뉴</a></li>
										<li><a href="#">2차 메뉴</a></li>
									</ul>
									<ul>
										<li><a href="#">중카테고리명칭3</a></li>
										<li><a href="#">2차 메뉴</a></li>
										<li><a href="#">2차 메뉴</a></li>
										<li><a href="#">2차 메뉴</a></li>
										<li><a href="#">2차 메뉴</a></li>
									</ul>

								</div>
							</div>
						</div>
					</li>
					<li class="on"><a href="#">건설건축협동조합소개</a></li>
					<li><a href="#">기획전</a></li>
					<li><a href="#">고객센터</a></li>
				</ul>

			</div>
		</div>
	</div>
</header>
<!-- Header Container  -->







<%-- 
<header id="header" class=" typeheader-2">
	<!-- Header Banner
	<div class="hidden-compact" id="hd_banner">
		<p style="background:#f4f4f4  url(https://www.atomyaza.co.kr/data/banner/pCqquB7FzwYqPkdYA49JFd9GBny9WS.jpg) no-repeat center;height:70px;margin:0 0 1px;">
			<a href="https://atomyaza.co.kr/shop/bannerclick.php?code=kyobo" target="_self"></a>
		</p>
		<img src="https://www.atomyaza.co.kr/img/bt_close.gif" id="hd_close">
	</div> -->
    <!-- Header Top -->
    <div class="header-top hidden-compact">
        <div class="container">
        1123123123 
            <div class="row">
                <div class="header-top-left col-lg-8 col-md-8 col-sm-6 col-xs-3">	<!-- id	="tnb" -->
                	<div class="hidden-md hidden-sm hidden-xs telephone">	<!-- id="tnb_inner" -->
	                	<!-- <ul class="fl">
	                		<li>
	                			<a href="javascript:void(0);" onclick="namee_login()" class="cate_tit">
	                				<i></i><span>명함주문</span>
	                			</a>
	                		</li>
	                		<li>
	                			<a href="javascript:void(0);" onclick="kyobo_login()" class="cate_tit">
	                				<i></i><span>교보문고 리딩트리</span>
	                			</a>
							</li>
	                	</ul> -->
	                	<!-- <ul><li><i class="fa fa-phone"></i><a href="tel:1899-9478"> 고객센터 1899-9478  ( 문의시간 : 평일 10~6시 )</a></li></ul> -->
					</div>
                    <c:if test="${empty USER.MEMB_ID}">
                    <ul class="account hidden-lg atomy-wd">                    	
                        <li class="account" id="my_account">
                            <a href="#" title="My Account " class="btn-xs dropdown-toggle" data-toggle="dropdown">
                            	<span class="hidden-xs">회원서비스 </span> <span class="fa fa-caret-down"></span>
                            </a>
                            <ul class="dropdown-menu ">
	                            <li><a href="${contextPath}/m/memberJoinStep1"><i class="fa fa-user"></i> 회원가입</a></li>
	                            <li><a href="${contextPath}/m/user/loginForm"><i class="fa fa-pencil-square-o"></i> 로그인</a></li>
                            </ul>
                        </li>
                        <!-- <li class="atomy">
                            <a href="javascript:void(0);" onclick="namee_login()" class="btn-xs"> 
                            	<i class="atomy-ico ico-ncard"></i> <span>명함주문 </span>
                            </a>
                        </li>
                        <li class="atomy">
                            <a href="javascript:void(0);" onclick="kyobo_login()" class="btn-xs"> 
                            	<i class="atomy-ico ico-book"></i> <span>교보문고 리딩트리 </span>
                            </a>
                        </li> -->
                    </ul> 
                    </c:if> 
                </div>
                <div class="header-top-right collapsed-block col-lg-4 col-md-4 col-sm-6 col-xs-9">
                	<!-- <div id="mb_banner" style="display:none">
                		<ul class="top-link list-inline">
	                		<li class="atomy">
	                            <a href="javascript:void(0);" onclick="namee_login()" class="btn-xs"> 
	                            	<i class="atomy-ico ico-ncard"></i> <span>명함주문 </span>
	                            </a>
	                        </li>
	                        <li class="atomy">
	                            <a href="javascript:void(0);" onclick="kyobo_login()" class="btn-xs"> 
	                            	<i class="atomy-ico ico-book"></i> <span>교보문고 리딩트리 </span>
	                            </a>
	                        </li>
                        </ul>
                	</div> -->
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
									        <li><a href="${contextPath}/m/order/wishList">배송/주문조회</a></li>
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
                    	<a href="${contextPath}/m"><img src="http://image.kyobobook.co.kr/newimages/rtree/upload/mdmngm/1294620200318_163305512.png" title="cjflsmart" alt="cjflsmart" /></a>
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
											<option value="MAKE_COM" ${param.schGbn eq 'MAKE_COM' ? 'selected=selected' : '' }>제조사</option>
										</select>
                                    </div>

                                    <input class="autosearch-input form-control" type="search" value="${param.schTxt }" style="ime-mode:active;" size="50" autocomplete="off" placeholder="아자마트 검색어 입력" name="schTxt">
                                    <span class="input-group-btn">
                                    <button type="submit" class="button-search btn btn-primary" name="submit_search"><i class="fa fa-search"></i><span>Search</span></button>
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
                            <a data-loading-text="Loading... " class="btn-group top_cart dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
								<div class="shopcart">
									<span class="icon-c">
										<i class="fa fa-shopping-bag"></i>
									</span>
									<div class="shopcart-inner">
										<p class="text-shopping-cart">장바구니</p>										
										<span class="total-shopping-cart cart-total-full">
											<span class="items_cart">${fn:length(myCartList)}</span><span class="items_cart2"> item(s)</span>
										</span>
									</div>
								</div>
							</a>
							
                            <ul class="dropdown-menu pull-right shoppingcart-box" role="menu">
                                <li>
                                    <table class="table table-striped">
                                        <tbody>
											<c:forEach items="${myCartList }" var="list" varStatus="loop">
												<tr>
													<td class="text-center" style="width: 70px">
														<a href="${contextPath }/m/product/view/${ list.PD_CODE }"> 
														<c:if test="${ !empty(list.ATFL_ID)  }" >
															<c:if test="${list.FILEPATH_FLAG eq mainKey }">													
																<c:set var="imgPath" value="${contextPath }/upload/${list.STFL_PATH }/${list.STFL_NAME }" />
															</c:if>
															<c:if test="${!empty(list.FILEPATH_FLAG) && list.FILEPATH_FLAG ne mainKey }">
																<c:set var="imgPath" value="${list.STFL_PATH }" />
															</c:if>
															<c:if test="${empty(list.FILEPATH_FLAG)}">
																<c:set var="imgPath" value="https://www.cjfls.co.kr/upload/${list.STFL_PATH }/${list.STFL_NAME }" />
															</c:if>
														</c:if>
														<c:if test="${ empty(list.ATFL_ID)  }">
															<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
														</c:if>
														<img src="${imgPath}" style="width:50px; height:50px;" alt="${ list.PD_NAME }" title="${ list.PD_NAME }" class="preview">														
														</a>
													</td>
													<td class="text-left">
														<a class="cart_product_name"href="${contextPath }/m/product/view/${list.PD_CODE }">${list.PD_NAME }</a>
													</td>
													<td class="text-center">
														<c:if test="${list.SALE_CON eq 'SALE_CON_01' and list.DEL_YN eq 'N'   }">
														${list.PD_QTY }
														</c:if>
														<c:if test="${list.SALE_CON ne 'SALE_CON_01' or list.DEL_YN ne 'N'   }">
															판매하지<br>않는 상품
														</c:if>
														<c:if test="${list.SALE_CON eq 'SALE_CON_01' or list.DEL_YN eq 'N'   }">
															<!-- 박스할인율 적용  -->
															<c:if test="${list.BOX_PDDC_GUBN eq 'PDDC_GUBN_01'}">
																<c:set var="boxsaleval" value="0" />
															</c:if>
															<c:if test="${list.BOX_PDDC_GUBN eq 'PDDC_GUBN_02'}">
																<fmt:parseNumber var="boxsalequt" value="${list.PD_QTY/list.INPUT_CNT}" integerOnly="true" />
																<c:set var="boxsaleval" value="${list.BOX_PDDC_VAL*boxsalequt}" />
															</c:if>
															<c:if test="${list.BOX_PDDC_GUBN eq 'PDDC_GUBN_03'}">
																<fmt:parseNumber var="boxsalequt" value="${list.PD_QTY/list.INPUT_CNT}" integerOnly="true" />
																<fmt:parseNumber var="boxpddcval" value="${list.REAL_PRICE*list.BOX_PDDC_VAL/100}" integerOnly="true" />
																<c:set var="boxsaleval" value="${boxpddcval*boxsalequt*list.INPUT_CNT}" />
															</c:if>
														</c:if>
													</td>
													<td class="text-center">
														<fmt:formatNumber value="${(list.PD_QTY * list.REAL_PRICE) - boxsaleval }" />
													</td>
												</tr>
											</c:forEach>
											<c:if test="${fn:length(myCartList) eq 0 }">
												<tr>
													<td>등록된 장바구니가 없습니다.</td>
												</tr>
											</c:if>  
                                        </tbody>
                                    </table>
                                </li>
                                <li>
                                    <div>                                        
										<p class="text-right">
											<a class="btn view-cart" href="${contextPath }/m/basket">
												<i class="fa fa-shopping-cart"></i>&nbsp;장바구니 보기
											</a>
										</p>
                                    </div>
                                </li>
                            </ul>
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
                                                    <!-- <b>All Categories</b> -->                          
                                                    <b>${entcagoInfo.ENTRY_NAME}</b>
                                                    <c:if test="${empty entcagoInfo}">
                                                    	<b>  전체 카테고리     </b>
                                                    </c:if>                          
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="navbar-header">
                                        <button type="button" id="show-verticalmenu" data-toggle="collapse" class="navbar-toggle">      
                                            <i class="fa fa-bars"></i>
                                            <span>
                                            	<b>${entcagoInfo.ENTRY_NAME}</b>
                                                <c:if test="${empty entcagoInfo}">
                                                	<b>  전체 카테고리     </b>
                                                </c:if>   
                                            </span>
                                        </button>
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
	                                                           <a class="clearfix" id="link_${ent.CAGO_ID }" href="${contextPath }/m/product?CAGO_ID=${ ent.CAGO_ID }&entcago=${entcagoInfo.ENTRY_ID}">	<!-- href="${contextPath }/m/product?CAGO_ID=${ ent.CAGO_ID }" -->	                                                           		
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
                                                    <li class="loadmore">
                                                        <i class="fa fa-plus-square-o"></i>
                                                        <span class="more-view">카테고리 더보기</span>
                                                    </li>                                                        
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
                                <div class="navbar-header">
                                    <button type="button" id="show-megamenu" data-toggle="collapse" class="navbar-toggle">
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                    </button>
                                </div>
                                
                                <div class="megamenu-wrapper">
                                    <span id="remove-megamenu" class="fa fa-times"></span>
                                    <div class="megamenu-pattern">
                                        <div class="container-mega">
                                            <ul class="megamenu" data-transition="slide" data-animationtime="250">                                            
                                            	<c:forEach var="list" items="${entrycagoList}" varStatus="status">
                                            		<c:choose>
                                            			<c:when test="${entcagoInfo.ENTRY_ID eq list.ENTRY_ID}">
                                            				<li>
			                                                    <a href="${contextPath }/m?entcago=${list.ENTRY_ID}" class="clearfix">
			                                                        <strong style="color:#00a8e2;">${list.ENTRY_NAME}</strong>
			                                                    </a>
			                                                </li>
                                            			</c:when>
                                            			<c:otherwise>
                                            				<li>
			                                                    <a href="${contextPath }/m?entcago=${list.ENTRY_ID}" class="clearfix">
			                                                        <strong>${list.ENTRY_NAME}</strong>
			                                                    </a>
			                                                </li>
                                            			</c:otherwise>                                            		
                                            		</c:choose>
						                    	</c:forEach>                                            	
                                            </ul>                                            
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
</header> --%>