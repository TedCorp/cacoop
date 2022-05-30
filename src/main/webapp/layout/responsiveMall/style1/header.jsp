<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
                                                                                                    
	<script type="text/javascript">
	/* Side Menu */
	$(document).ready(function(){
	
		//탑 2차 지정
	    <c:forEach items="${cagoList }" var="subMenu">
		    <c:if test="${subMenu.LVL eq '3'}">
				if($("#link_${subMenu.UPCAGO_ID} > b").length < 1){
			    	$("#link_${subMenu.UPCAGO_ID}").append("<b class='fa-angle-right'></b>");
				}

		    	$("#subMenuUl_${subMenu.UPCAGO_ID}").append("<li id='subMenuLi_${subMenu.CAGO_ID }'><a href='${contextPath }/m/product?CAGO_ID=${ subMenu.CAGO_ID }' class='main-menu'>${subMenu.CAGO_NAME}</a></li>");
	
			</c:if>
	    </c:forEach>
	    
	    //하위카테고리 없을경우 div 삭제
		$(".cagoMenu").each(function() {
			var strId = $(this).attr('id');
			if($(this).find('.fa-angle-right').length < 1){
				$(this).find('.sub-menu').remove();
			}

		});

	});
	

	// Cart add remove functions
	var cart = {
		'add': function(product_id, product_name, product_cut, product_option) {

	       	<c:if test="${empty USER.MEMB_ID}">
				alert("로그인이 필요합니다.");
				return false;
			</c:if>

			if(product_cut > 0){
				alert("세절방식을 선택해야하는 상품입니다.\n상품상세페이지에서 세절방식을 선택 후 장바구니에 담아주세요.");
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
	    				//alert("장바구니에 등록되었습니다.");
	    				addProductNotice('장바구니 추가', '', '<h3>[' + product_name + '] 장바구니에 등록되었습니다.</h3>', 'success');
	    			}else{
	    				//alert("장바구니에 이미 등록된 상품 입니다.");
						addProductNotice('장바구니 추가', '', '<h3 style="color:red;">장바구니에 이미 등록된 상품 입니다.</h3>', 'success');
	    			}
	    		}, error: function (jqXHR, textStatus, errorThrown) {
	    			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
	    		}
	    	});
		}
	}

	var wishlist = {
		'add': function(product_id, product_name, product_cut, product_option) {
	       	<c:if test="${empty USER.MEMB_ID}">
				alert("로그인이 필요합니다.");
				return false;
			</c:if>

			if(product_cut > 0){
				alert("세절방식을 선택해야하는 상품입니다.\n상품상세페이지에서 세절방식을 선택 후 장바구니에 담아주세요.");
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

    <!-- Header Container  -->
    <header id="header" class=" typeheader-1">
        
        <!-- Header Top -->
        <div class="header-top hidden-compact">
            <div class="container">
                <div class="row">
                    <div class="header-top-left col-lg-7 col-md-8 col-sm-6 col-xs-4">
                        <div class="hidden-md hidden-sm hidden-xs welcome-msg"><b>[배송변경안내]</b> 금요일 낮 3시 이후 ~ 일요일 낮3시까지 결제완료 = <span>월요일 배송 </span> </div>
                        <c:if test="${empty USER.MEMB_ID}">
                        <ul class="top-link list-inline hidden-lg ">
                            <li class="account" id="my_account">
                                <a href="#" title="My Account " class="btn-xs dropdown-toggle" data-toggle="dropdown"> <span class="hidden-xs">회원서비스 </span>  <span class="fa fa-caret-down"></span>
                                </a>
                                <ul class="dropdown-menu ">
                                    <%-- <li><a href="${contextPath}/m/memberJoinStep1"><i class="fa fa-user"></i> 회원가입</a></li> --%>
                                    <li><a href="${contextPath}/m/user/loginForm"><i class="fa fa-pencil-square-o"></i> 로그인</a></li>
                                </ul>
                            </li>
                        </ul>            
                        </c:if>
                    </div>
                    <div class="header-top-right collapsed-block col-lg-5 col-md-4 col-sm-6 col-xs-8">
                        <ul class="top-link list-inline lang-curr">
                            <!-- li class="currency">
                                <div class="btn-group currencies-block">
                                    <form action="index.html" method="post" enctype="multipart/form-data" id="currency">
                                        <a class="btn btn-link dropdown-toggle" data-toggle="dropdown">
                                            <span class="icon icon-credit "></span> MyPage()  <span class="fa fa-angle-down"></span>
                                        </a>
                                        <ul class="dropdown-menu btn-xs">
                                            <li> <a href="#">(€)&nbsp;Euro</a></li>
                                            <li> <a href="#">(£)&nbsp;Pounds    </a></li>
                                            <li> <a href="#">($)&nbsp;US Dollar </a></li>
                                        </ul>
                                    </form>
                                </div>
                            </li -->

							<c:if test="${!empty USER.MEMB_ID}">
                            <li class="language">
                                <div class="btn-group languages-block ">
                                    <form action="index.html" method="post" enctype="multipart/form-data" id="bt-language">
                                        <a class="btn btn-link dropdown-toggle" data-toggle="dropdown">
                                            <span class="">회원서비스(${USER.MEMB_NAME})</span>
                                            <span class="fa fa-angle-down"></span>
                                        </a>
                                        <ul class="dropdown-menu">
									        <li><a href="${contextPath}/m/mypage">MyPage</a></li>
									        <li><a href="${contextPath}/m/basket">장바구니</a></li>
									        <li><a href="${contextPath}/m/wishList">관심상품</a></li>
									        <li><a href="${contextPath}/m/order/wishList">배송/주문조회</a></li>
									        <li><a href="${contextPath}/m/mypage/buyBeforeInfo" style="color:red;">미결재내역(${NOTPAYCNT})</a></li>
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
        <!-- //Header Top -->

        <!-- Header center -->
	<div class="header-middle">
		<div class="container">
			<div class="row">
				<!-- Logo -->
				<div class="navbar-logo col-lg-2 col-md-3 col-sm-4 col-xs-12">
					<div class="logo">
						<a href="${contextPath}/m"><img
							src="${contextPath}/resources/img/common/m_logo.png"
							" title="Your Store" alt="Your Store" /></a>
					</div>
				</div>
				<!-- //end Logo -->
				<!-- Search -->
				<div class="col-lg-7 col-md-6 col-sm-5">
					<div class="search-header-w">
						<div class="icon-search hidden-lg hidden-md hidden-sm">
							<i class="fa fa-search"></i>
						</div>

						<div id="sosearchpro" class="sosearchpro-wrapper so-search ">
							<form method="GET" action="${contextPath}/m/search">
								<div id="search0" class="search input-group form-group">
									<div
										class="select_category filter_type  icon-select hidden-sm hidden-xs">
										<select class="no-border" name="schGbn">
											<option value="PD_NAME">상품명</option>
											<option value="PD_DINFO">상품상세</option>
											<option value="MAKE_COM">제조사</option>
										</select>
									</div>
									<input class="autosearch-input form-control" type="text"
										value="" size="50" autocomplete="off" placeholder="검색어 입력"
										name="schTxt">
									<button type="submit" class="button-search btn btn-primary"
										name="submit_search">
										<i class="fa fa-search"></i>
									</button>
								</div>
								<input type="hidden" name="route" value="product/search" />
							</form>
						</div>
					</div>
				</div>
				<!-- //end Search -->
				<div class="middle-right col-lg-3 col-md-3 col-sm-3">
					<c:if test="${!empty USER.MEMB_ID}">
					<!--cart-->
					<div class="shopping_cart">
						<div id="cart" class="btn-shopping-cart">
							<a data-loading-text="Loading... "
								class="btn-group top_cart dropdown-toggle"
								data-toggle="dropdown" aria-expanded="true">
								<div class="shopcart">
									<span class="icon-c"> <i class="fa fa-shopping-bag"></i>
									</span>
									<div class="shopcart-inner">
										<p class="text-shopping-cart">My cart</p>
										<span class="total-shopping-cart cart-total-full"> 
										<span class="items_cart" id="spanCartCnt">${fn:length(myCartList) }</span>
										<span class="items_cart2">item(s)</span><span class="items_carts"></span>
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
														<a href="${contextPath }/product/view/${ list.PD_CODE }"> 
														<c:if test="${ !empty(list.ATFL_ID) }">
															<img src="${contextPath }/common/commonFileDown?ATFL_ID=${list.ATFL_ID}&ATFL_SEQ=${list.RPIMG_SEQ}"
																style="width: 70px" alt="${ list.PD_NAME }"
																title="${ list.PD_NAME }" class="preview">
														</c:if>
														<c:if test="${ empty(list.ATFL_ID) }">
															<img src="${contextPath }/resources/images/mall/goods/noimage.png"
																style="width: 70px" alt="${ list.PD_NAME }"
																title="${ list.PD_NAME }" class="preview">
														</c:if>
														</a>
													</td>
													<td class="text-left">
														<a class="cart_product_name"href="${contextPath }/m/product/view/${list.PD_CODE }">${list.PD_NAME }</a>
													</td>
													<td class="text-center">
														<c:if test="${list.SALE_CON=='SALE_CON_01'  && list.DEL_YN == 'N'   }">
														${list.PD_QTY }
														</c:if>
														<c:if test="${list.SALE_CON != 'SALE_CON_01' ||list.DEL_YN != 'N'   }">
															판매하지<br>않는 상품
														</c:if>
														<c:if test="${list.SALE_CON == 'SALE_CON_01' && list.DEL_YN == 'N'   }">
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
													<td class="text-center"><fmt:formatNumber value="${(list.PD_QTY * list.REAL_PRICE)-boxsaleval }" /></td>
												</tr>
											</c:forEach>
											<c:if test="${fn:length(myCartList) == 0 }">
												<tr>
													<td colspan="4">조회된 장바구니가 없습니다.</td>
												</tr>
											</c:if>
										</tbody>
									</table>
								</li>
								<li>
									<div>
										<!-- table class="table table-bordered">
											<tbody>
												<tr>
													<td class="text-right"><strong>총 상품 구매액 :</strong></td>
													<td class="text-right"><span id="popup_total"></span>원</td>
												</tr>
												<tr>
													<td class="text-right"><strong>총 배송비 :</strong>
													</td>
													<td class="text-right"><span id="popup_devy_amt"></span>원 </td>
												</tr>
												<tr>
													<td class="text-right"><strong>합계 :</strong></td>
													<td class="text-right"><span id="popup_sum_total"></span>원</td>
												</tr>
											</tbody>
										</table-->
										<p class="text-right">
											<a class="btn view-cart" href="${contextPath }/m/basket"><i
												class="fa fa-shopping-cart"></i>&nbsp;View Cart</a>
										</p>
									</div>
								</li>
							</ul>
						</div>
					</div>
					<!--//cart-->
					</c:if>
					
					<c:if test="${!empty USER.MEMB_ID}">
					<ul class="wishlist-comp hidden-md hidden-sm hidden-xs">
						<li class="wishlist hidden-xs">
							<a href="${contextPath}/m/wishList" id="wishlist-total" class="top-link-wishlist" title="관심상품">
							<i class="fa fa-heart"></i></a>
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
                    
                    <div class="bottom1 menu-vertical col-lg-2 col-md-3 col-sm-3">
                        <div class="responsive so-megamenu megamenu-style-dev ">
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
                                                        All Categories                          
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                     
                                        <div class="navbar-header">
                                            <button type="button" id="show-verticalmenu" data-toggle="collapse" class="navbar-toggle">      
                                                <i class="fa fa-bars"></i>
                                                <span>  All Categories     </span>
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
	                                                            <a class="clearfix" id="link_${ent.CAGO_ID }" href="${contextPath }/m/product?CAGO_ID=${ ent.CAGO_ID }">
	                                                                <img src="${contextPath}/resources/images/responsive/catalog/menu/icons/ico10.png" alt="icon">
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
                                                            <span class="more-view">More Categories</span>
                                                        </li>
                                                            
                                                   </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </nav>
                            </div>
                        </div>

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
                                                    <li class="">
                                                        <p class="close-menu"></p>
                                                        <a href="javascript:window.open('${contextPath}/adCj2');" class="clearfix" title="행사상품전단지 바로보기">
                                                            <strong>행사상품전단지</strong>
                                                            <img class="label-hot" src="${contextPath}/resources/images/responsive/catalog/menu/hot-icon.png" alt="icon items">
                                                        </a>
                                                    </li>
                                                    <li class="">
                                                        <p class="close-menu"></p>
                                                        <a href="${contextPath }/m/intro" class="clearfix">
                                                            <strong>회사소개</strong>
                                                        </a>
                                                    </li>
                                                    <li class="">
                                                        <p class="close-menu"></p>
                                                        <a href="${contextPath }/m/introPicture" class="clearfix">
                                                            <strong>매장소개</strong>
                                                        </a>
                                                    </li>
                                                    <li class="">
                                                        <p class="close-menu"></p>
                                                        <a href="${contextPath }/m/community/faqList" class="clearfix">
                                                            <strong>FAQ</strong>
                                                        </a>
                                                    </li>
                                                </ul>
                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </nav>
                        </div>
                    </div>
                    <!-- //end Main menu -->
                                      
                    <div class="bottom3">                        
                        <div class="telephone hidden-xs hidden-sm hidden-md">
                            <ul class="blank"> 
                                <li><a href="tel:070-4337-2763"><i class="fa fa-phone-square"></i>고객센터 070-4337-2763 (AM 9~PM 6)</a></li> 
                            </ul>
                        </div>  
                        <div class="signin-w hidden-md hidden-sm hidden-xs">
                            <ul class="signin-link blank">    
                            	<c:if test="${!empty USER.MEMB_ID}">                        
                                <li class="log login"><i class="fa fa-lock"></i> <a class="link-lg" href="${contextPath}/m/user/logout">로그아웃 </a></li>                                
                            	</c:if>  
                            	<c:if test="${empty USER.MEMB_ID}">                        
	                                <li class="log login">
	                                	<i class="fa fa-lock"></i> <a class="link-lg" href="${contextPath}/m/user/loginForm">로그인 </a>
	                                 	<%-- or <a href="${contextPath}/m/memberJoinStep1">회원가입</a> --%>
									</li>                                
                            	</c:if>
                            </ul>                       
                        </div>                  
                    </div>
                    
                </div>
            </div>

        </div>
    </header>
    <!-- //Header Container  -->