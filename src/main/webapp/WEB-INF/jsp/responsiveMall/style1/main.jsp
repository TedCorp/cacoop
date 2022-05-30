<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<script type="text/javascript">
$(document).ready(function(){

    $(".btnTab").click(function() {
        var tabName = $(this).attr("tab");
        //alert(tabName);

        //탭 타이틀
        $("#tabTitle").text($(this).text());
        
        //탭 메뉴 컨트롤
        $(".btnTab").css("font-weight", "");
        $(".btnTab").css("color", "#000");
        $(this).css("font-weight", "bold");
        $(this).css("color", "#ff5e00");
        
        //탭 컨텐츠 컨트롤
        $(".divTab").hide();
        $("#"+tabName).show();
        
    });
    $(".yt-content-slide-item").show();
    
});

</script>  

<!-- Main Container  -->
<div class="main-container container">
    <div id="content">
        <div class="content-top-w">
            
            <div class="col-lg-2 col-md-12 col-sm-12 col-xs-12 main-left">
                <div class="module col1 hidden-sm hidden-xs"></div>
            </div>    
            <div class="col-lg-10 col-md-12 col-sm-12 col-xs-12 main-right">
                <div class="slider-container row"> 
                                
                    <div class="col-lg-9 col-md-12 col-sm-12 col-xs-12 col2">
                        <div class="module sohomepage-slider ">
                            <div class="yt-content-slider"  data-rtl="yes" data-autoplay="yes" data-autoheight="no" data-delay="4" data-speed="0.6" data-margin="0" data-items_column00="1" data-items_column0="1" data-items_column1="1" data-items_column2="1"  data-items_column3="1" data-items_column4="1" data-arrows="no" data-pagination="yes" data-lazyload="yes" data-loop="no" data-hoverpause="yes">
                                <!-- 1090*450 -->
                                <div class="yt-content-slide">
                                    <a href="#"><img src="${contextPath}/resources/img/main/main_slide1_20190312.jpg" alt="slider1" class="img-responsive"></a>
                                </div>
                                <div class="yt-content-slide yt-content-slide-item" style="display: none;">
                                    <a href="#"><img src="${contextPath}/resources/img/main/main_slide2.jpg" alt="slider2" class="img-responsive"></a>
                                </div>
                                <div class="yt-content-slide yt-content-slide-item" style="display: none;">
                                    <a href="#"><img src="${contextPath}/resources/img/main/main_slide3.png" alt="slider3" class="img-responsive"></a>
                                </div>
                                <div class="yt-content-slide yt-content-slide-item" style="display: none;">
                                    <a href="#"><img src="${contextPath}/resources/img/main/main_slide5_1903.png" alt="slider4" class="img-responsive"></a>
                                </div>
                                <div class="yt-content-slide yt-content-slide-item" style="display: none;">
                                    <a href="#"><img src="${contextPath}/resources/img/main/main_slide5.png" alt="slider5" class="img-responsive"></a>
                                </div>
                            </div>
                            
                        </div>
                        
                    </div>
                    <div class="col-lg-3 col-md-12 col-sm-12 col-xs-12 col3">
                        <div class="module product-simple extra-layout1">
                            <h3 class="modtitle">
                                <span>오늘만 번개세일</span>
                            </h3>
                            <div class="modcontent">
                                <div id="so_extra_slider_1" class="so-extraslider" >
                                    <!-- Begin extraslider-inner -->
                                    <div class="yt-content-slider extraslider-inner" data-rtl="yes" data-pagination="yes" data-autoplay="no" data-delay="4" data-speed="0.6" data-margin="0" data-items_column00="1" data-items_column0="1" data-items_column1="1" data-items_column2="1" data-items_column3="1" data-items_column4="1" data-arrows="no" data-lazyload="yes" data-loop="no" data-buttonpage="top">
										
										<div class="item ">
										<c:forEach var="ent" items="${ recommendList8 }" varStatus="status">
											<%//!-- 품절시 sold out 이미지 표시_20190314 --%>
											<c:set var="imgPath" value="${contextPath }/common/commonFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" />
											<c:if test="${ empty(ent.ATFL_ID)  }" >
												<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
											</c:if>
                                            <div class="product-layout item-inner style1 ">
                                                <div class="item-image">
                                                    <div class="item-img-info">
														<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
			                                                <div class="box-label">
			                                                    <span class="label-product label-sale">품절</span>
			                                                </div>
														</c:if>
                                                        <a href="${contextPath }/m/product/view/${ ent.PD_CODE }" target="_self" title="${ ent.PD_NAME } ">
                                                            <img src="${imgPath }" alt="${ ent.PD_NAME }" class="goodsImg270">
                                                            </a>
                                                    </div>
                                                    
                                                </div>
                                                <div class="item-info">
                                                    <div class="item-title">
                                                        <a href="${contextPath }/m/product/view/${ ent.PD_CODE }" target="_self" title="${ ent.PD_NAME }">${ ent.PD_NAME } </a>
                                                    </div>
                                                    <div class="content_price price">
                                                        <span class="price-new product-price"><fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###"/> </span>

                                                    </div>
                                                </div>
                                                <!-- End item-info -->
                                                <!-- End item-wrap-inner -->
                                            </div>
											<c:if test="${status.count % 4 eq 0 and status.count ne fn:length(newList)}">
												</div>
												<div class="item ">
											</c:if>
										</c:forEach>
										</div>

                                    </div>
                                    <!--End extraslider-inner -->
                                </div>
                            </div>
                        </div>
                    </div>                
                </div>
            </div>                                        
        </div>
        <div class="row content-main-w">
	<div class="row box-content2">
		<div class="col-lg-10 col-md-12 col-sm-12 col-xs-12">
			<!-- Technology -->
			<div id="so_category_slider_189" class="so-category-slider container-slider module cate-slider2">
				<div class="modcontent">
					<div class="page-top">
						<div class="page-title-categoryslider"
							style="background-color: rgba(255, 255, 255, .15);">
							<span class="green">당일</span> 농산물 경매시세
						</div>
						<div class="item-sub-cat2">
							<ul>
								<li><a href="${contextPath }/m/product?CAGO_ID=110100000" title="농산물더보기+">농산물더보기+</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="categoryslider-content show preset01-4 preset02-4 preset03-3 preset04-2 preset05-1">

					<div
						class="slider category-slider-inner products-list yt-content-slider"
						data-rtl="yes" data-autoplay="yes" data-autoheight="no"
						data-delay="4" data-speed="0.6" data-margin="30"
						data-items_column00="6" data-items_column0="6"
						data-items_column1="6" data-items_column2="4"
						data-items_column3="3" data-items_column4="2" data-arrows="no"
						data-pagination="no" data-lazyload="yes" data-loop="no"
						data-hoverpause="yes">
						<div class="item">
							<c:forEach var="ent" items="${ newList }" varStatus="status">
								<c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
								<c:if test="${ empty(ent.ATFL_ID)  }">
									<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
								</c:if>
								<div class="item-inner product-layout transition product-grid">
									<div class="product-item-container">
										<div class="left-block left-b">
											<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
												<div class="box-label">
													<span class="label-product label-sale">품절</span>
												</div>
											</c:if>
											<div class="product-image-container">
												<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" target="_self" title="${ ent.PD_NAME }">
													<img src="${imgPath}" class="img-1 img-responsive goodsImg270" alt="${ ent.PD_NAME } image1"> 
												</a>
											</div>
											<!--quickview
											<div class="so-quickview">
												<a class="iframe-link btn-button quickview quickview_handler visible-lg"
													href="${contextPath }/m/product/quickview/${ ent.PD_CODE }" title="Quick view"
													data-fancybox-type="iframe">
													<i class="fa fa-eye"></i>
													<span>Quick view</span>
												</a>
											</div>
											end quickview-->
										</div>
										<div class="right-block">
											<div class="button-group so-quickview cartinfo--left">
												<c:if test="${ent.SALE_CON ne 'SALE_CON_02' }">
													<button type="button" class="addToCart" title="Add to cart" onclick="cart.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
														<span>Add to cart </span>
													</button>
													<button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
														<i class="fa fa-heart-o"></i><span>Add to Wish List</span>
													</button>
												</c:if>
											</div>
											<div class="caption hide-cont" style="height: 44px;">
												<h4 class="pname">
													<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" title="${ ent.PD_NAME }" target="_self">${ ent.PD_NAME }</a>
												</h4>
											</div>
											<p class="price">
												<span class="price-new"><fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###" /></span>

											</p>
										</div>

									</div>
								</div>
								<c:if test="${status.count % 2 eq 0 and status.count ne fn:length(newList)}">
									</div>
									<div class="item">
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>

			<!-- 추천상품 -->
			<div id="mainProdList" class="so-category-slider container-slider module cate-slider2">
				<div class="modcontent">
					<div class="page-top">
						<div class="page-title-categoryslider" style="background-color: rgba(255, 255, 255, .15);" id="tabTitle">
							추천상품
						</div>
						<div class="item-sub-cat2">
							<ul>
								<li><a class="btnTab" tab="tabRecommend" title="추가할인상품" style="font-weight:bold;color:#ff5e00;">추천상품</a></li>
								<li><a class="btnTab" tab="tabAddSale" title="추가할인상품">추가할인상품</a></li>
								<li><a class="btnTab" tab="tabPubSnack" title="주점안주류">주점안주류</a></li>
								<li><a class="btnTab" tab="tabChineseJapanese" title="중식/일식 재료">중식/일식 재료</a></li>
								<li><a class="btnTab" tab="tabBakery" title="제과점 재료">제과점 재료</a></li>
								<li><a class="btnTab" tab="tabNewProd" title="신상품 입점">신상품 입점</a></li>
							</ul>
						</div>
					</div>
				</div>
				<!-- 
				tabRecommend		추천상품		recommendList
				tabAddSale			추가할인상품	recommendList6
				tabPubSnack			주점안주류		recommendList3
				tabChineseJapanese	중식/일식 재료	recommendList4
				tabBakery			제과점 재료		recommendList5
				tabNewProd			신상품 입점		recommendList7
				 -->
				<div class="categoryslider-content show preset01-4 preset02-4 preset03-3 preset04-2 preset05-1">
					<!-- 추천상품 시작 -->
					<div
						class="slider category-slider-inner products-list yt-content-slider divTab" id="tabRecommend"
						data-rtl="yes" data-autoplay="yes" data-autoheight="no"
						data-delay="4" data-speed="0.6" data-margin="30"
						data-items_column00="6" data-items_column0="6"
						data-items_column1="6" data-items_column2="4"
						data-items_column3="3" data-items_column4="2" data-arrows="no"
						data-pagination="no" data-lazyload="yes" data-loop="no"
						data-hoverpause="yes">
						<div class="item">
							<c:forEach var="ent" items="${ recommendList }" varStatus="status">
								<c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
								<c:if test="${ empty(ent.ATFL_ID)  }">
									<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
								</c:if>
								<div class="item-inner product-layout transition product-grid">
									<div class="product-item-container">
										<div class="left-block left-b">
											<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
												<div class="box-label">
													<span class="label-product label-sale">품절</span>
												</div>
											</c:if>
											<div class="product-image-container">
												<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" target="_self" title="${ ent.PD_NAME }">
													<img src="${imgPath}" class="img-1 img-responsive goodsImg270" alt="${ ent.PD_NAME } image1"> 
												</a>
											</div>
											<!--quickview
											<div class="so-quickview">
												<a class="iframe-link btn-button quickview quickview_handler visible-lg"
													href="${contextPath }/m/product/quickview/${ ent.PD_CODE }" title="Quick view"
													data-fancybox-type="iframe">
													<i class="fa fa-eye"></i>
													<span>Quick view</span>
												</a>
											</div>
											end quickview-->
										</div>
										<div class="right-block">
											<div class="button-group so-quickview cartinfo--left">
												<c:if test="${ent.SALE_CON ne 'SALE_CON_02' }">
													<button type="button" class="addToCart" title="Add to cart" onclick="cart.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
														<span>Add to cart </span>
													</button>
													<button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
														<i class="fa fa-heart-o"></i><span>Add to Wish List</span>
													</button>
												</c:if>
											</div>
											<div class="caption hide-cont" style="height: 44px;">
												<h4 class="pname">
													<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" title="${ ent.PD_NAME }" target="_self">${ ent.PD_NAME }</a>
												</h4>
											</div>
											<p class="price">
												<span class="price-new"><fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###" /></span>

											</p>
										</div>

									</div>
								</div>
								<c:if test="${status.count % 3 eq 0 and status.count ne fn:length(recommendList)}">
									</div>
									<div class="item">
								</c:if>
							</c:forEach>
						</div>
					</div>
					<!-- 추천상품 종료 -->

					<!-- 추가할인상품 시작 -->
					<div
						class="slider category-slider-inner products-list yt-content-slider divTab" id="tabAddSale" style="display: none;"
						data-rtl="yes" data-autoplay="yes" data-autoheight="no"
						data-delay="4" data-speed="0.6" data-margin="30"
						data-items_column00="6" data-items_column0="6"
						data-items_column1="6" data-items_column2="4"
						data-items_column3="3" data-items_column4="2" data-arrows="no"
						data-pagination="no" data-lazyload="yes" data-loop="no"
						data-hoverpause="yes">
						<div class="item">
							<c:forEach var="ent" items="${ recommendList6 }" varStatus="status">
								<c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
								<c:if test="${ empty(ent.ATFL_ID)  }">
									<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
								</c:if>
								<div class="item-inner product-layout transition product-grid">
									<div class="product-item-container">
										<div class="left-block left-b">
											<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
												<div class="box-label">
													<span class="label-product label-sale">품절</span>
												</div>
											</c:if>
											<div class="product-image-container">
												<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" target="_self" title="${ ent.PD_NAME }">
													<img src="${imgPath}" class="img-1 img-responsive goodsImg270" alt="${ ent.PD_NAME } image1"> 
												</a>
											</div>
											<!--quickview
											<div class="so-quickview">
												<a class="iframe-link btn-button quickview quickview_handler visible-lg"
													href="${contextPath }/m/product/quickview/${ ent.PD_CODE }" title="Quick view"
													data-fancybox-type="iframe">
													<i class="fa fa-eye"></i>
													<span>Quick view</span>
												</a>
											</div>
											end quickview-->
										</div>
										<div class="right-block">
											<div class="button-group so-quickview cartinfo--left">
												<c:if test="${ent.SALE_CON ne 'SALE_CON_02' }">
													<button type="button" class="addToCart" title="Add to cart" onclick="cart.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
														<span>Add to cart </span>
													</button>
													<button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
														<i class="fa fa-heart-o"></i><span>Add to Wish List</span>
													</button>
												</c:if>
											</div>
											<div class="caption hide-cont" style="height: 44px;">
												<h4 class="pname">
													<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" title="${ ent.PD_NAME }" target="_self">${ ent.PD_NAME }</a>
												</h4>
											</div>
											<p class="price">
												<span class="price-new"><fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###" /></span>

											</p>
										</div>

									</div>
								</div>
								<c:if test="${status.count % 2 eq 0 and status.count ne fn:length(recommendList6)}">
									</div>
									<div class="item">
								</c:if>
							</c:forEach>
						</div>
					</div>
					<!-- 추가할인상품 종료 -->

					<!-- 주점안주류 시작 -->
					<div
						class="slider category-slider-inner products-list yt-content-slider divTab" id="tabPubSnack" style="display: none;"
						data-rtl="yes" data-autoplay="yes" data-autoheight="no"
						data-delay="4" data-speed="0.6" data-margin="30"
						data-items_column00="6" data-items_column0="6"
						data-items_column1="6" data-items_column2="4"
						data-items_column3="3" data-items_column4="2" data-arrows="no"
						data-pagination="no" data-lazyload="yes" data-loop="no"
						data-hoverpause="yes">
						<div class="item">
							<c:forEach var="ent" items="${ recommendList3 }" varStatus="status">
								<c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
								<c:if test="${ empty(ent.ATFL_ID)  }">
									<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
								</c:if>
								<div class="item-inner product-layout transition product-grid">
									<div class="product-item-container">
										<div class="left-block left-b">
											<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
												<div class="box-label">
													<span class="label-product label-sale">품절</span>
												</div>
											</c:if>
											<div class="product-image-container">
												<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" target="_self" title="${ ent.PD_NAME }">
													<img src="${imgPath}" class="img-1 img-responsive goodsImg270" alt="${ ent.PD_NAME } image1"> 
												</a>
											</div>
											<!--quickview
											<div class="so-quickview">
												<a class="iframe-link btn-button quickview quickview_handler visible-lg"
													href="${contextPath }/m/product/quickview/${ ent.PD_CODE }" title="Quick view"
													data-fancybox-type="iframe">
													<i class="fa fa-eye"></i>
													<span>Quick view</span>
												</a>
											</div>
											end quickview-->
										</div>
										<div class="right-block">
											<div class="button-group so-quickview cartinfo--left">
												<c:if test="${ent.SALE_CON ne 'SALE_CON_02' }">
													<button type="button" class="addToCart" title="Add to cart" onclick="cart.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
														<span>Add to cart </span>
													</button>
													<button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
														<i class="fa fa-heart-o"></i><span>Add to Wish List</span>
													</button>
												</c:if>
											</div>
											<div class="caption hide-cont" style="height: 44px;">
												<h4 class="pname">
													<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" title="${ ent.PD_NAME }" target="_self">${ ent.PD_NAME }</a>
												</h4>
											</div>
											<p class="price">
												<span class="price-new"><fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###" /></span>

											</p>
										</div>

									</div>
								</div>
								<c:if test="${status.count % 2 eq 0 and status.count ne fn:length(recommendList3)}">
									</div>
									<div class="item">
								</c:if>
							</c:forEach>
						</div>
					</div>
					<!-- 주점안주류 종료 -->

					<!-- 중식/일식 재료 시작 -->
					<div
						class="slider category-slider-inner products-list yt-content-slider divTab" id="tabChineseJapanese" style="display: none;"
						data-rtl="yes" data-autoplay="yes" data-autoheight="no"
						data-delay="4" data-speed="0.6" data-margin="30"
						data-items_column00="6" data-items_column0="6"
						data-items_column1="6" data-items_column2="4"
						data-items_column3="3" data-items_column4="2" data-arrows="no"
						data-pagination="no" data-lazyload="yes" data-loop="no"
						data-hoverpause="yes">
						<div class="item">
							<c:forEach var="ent" items="${ recommendList4 }" varStatus="status">
								<c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
								<c:if test="${ empty(ent.ATFL_ID)  }">
									<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
								</c:if>
								<div class="item-inner product-layout transition product-grid">
									<div class="product-item-container">
										<div class="left-block left-b">
											<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
												<div class="box-label">
													<span class="label-product label-sale">품절</span>
												</div>
											</c:if>
											<div class="product-image-container">
												<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" target="_self" title="${ ent.PD_NAME }">
													<img src="${imgPath}" class="img-1 img-responsive goodsImg270" alt="${ ent.PD_NAME } image1"> 
												</a>
											</div>
											<!--quickview
											<div class="so-quickview">
												<a class="iframe-link btn-button quickview quickview_handler visible-lg"
													href="${contextPath }/m/product/quickview/${ ent.PD_CODE }" title="Quick view"
													data-fancybox-type="iframe">
													<i class="fa fa-eye"></i>
													<span>Quick view</span>
												</a>
											</div>
											end quickview-->
										</div>
										<div class="right-block">
											<div class="button-group so-quickview cartinfo--left">
												<c:if test="${ent.SALE_CON ne 'SALE_CON_02' }">
													<button type="button" class="addToCart" title="Add to cart" onclick="cart.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
														<span>Add to cart </span>
													</button>
													<button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
														<i class="fa fa-heart-o"></i><span>Add to Wish List</span>
													</button>
												</c:if>
											</div>
											<div class="caption hide-cont" style="height: 44px;">
												<h4 class="pname">
													<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" title="${ ent.PD_NAME }" target="_self">${ ent.PD_NAME }</a>
												</h4>
											</div>
											<p class="price">
												<span class="price-new"><fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###" /></span>

											</p>
										</div>

									</div>
								</div>
								<c:if test="${status.count % 2 eq 0 and status.count ne fn:length(recommendList4)}">
									</div>
									<div class="item">
								</c:if>
							</c:forEach>
						</div>
					</div>
					<!-- 중식/일식 재료 종료 -->
					
					<!-- 제과점 재료 시작 -->
					<div
						class="slider category-slider-inner products-list yt-content-slider divTab" id="tabBakery" style="display: none;"
						data-rtl="yes" data-autoplay="yes" data-autoheight="no"
						data-delay="4" data-speed="0.6" data-margin="30"
						data-items_column00="6" data-items_column0="6"
						data-items_column1="6" data-items_column2="4"
						data-items_column3="3" data-items_column4="2" data-arrows="no"
						data-pagination="no" data-lazyload="yes" data-loop="no"
						data-hoverpause="yes">
						<div class="item">
							<c:forEach var="ent" items="${ recommendList5 }" varStatus="status">
								<c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
								<c:if test="${ empty(ent.ATFL_ID)  }">
									<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
								</c:if>
								<div class="item-inner product-layout transition product-grid">
									<div class="product-item-container">
										<div class="left-block left-b">
											<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
												<div class="box-label">
													<span class="label-product label-sale">품절</span>
												</div>
											</c:if>
											<div class="product-image-container">
												<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" target="_self" title="${ ent.PD_NAME }">
													<img src="${imgPath}" class="img-1 img-responsive goodsImg270" alt="${ ent.PD_NAME } image1"> 
												</a>
											</div>
											<!--quickview
											<div class="so-quickview">
												<a class="iframe-link btn-button quickview quickview_handler visible-lg"
													href="${contextPath }/m/product/quickview/${ ent.PD_CODE }" title="Quick view"
													data-fancybox-type="iframe">
													<i class="fa fa-eye"></i>
													<span>Quick view</span>
												</a>
											</div>
											end quickview-->
										</div>
										<div class="right-block">
											<div class="button-group so-quickview cartinfo--left">
												<c:if test="${ent.SALE_CON ne 'SALE_CON_02' }">
													<button type="button" class="addToCart" title="Add to cart" onclick="cart.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
														<span>Add to cart </span>
													</button>
													<button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
														<i class="fa fa-heart-o"></i><span>Add to Wish List</span>
													</button>
												</c:if>
											</div>
											<div class="caption hide-cont" style="height: 44px;">
												<h4 class="pname">
													<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" title="${ ent.PD_NAME }" target="_self">${ ent.PD_NAME }</a>
												</h4>
											</div>
											<p class="price">
												<span class="price-new"><fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###" /></span>

											</p>
										</div>

									</div>
								</div>
								<c:if test="${status.count % 2 eq 0 and status.count ne fn:length(recommendList5)}">
									</div>
									<div class="item">
								</c:if>
							</c:forEach>
						</div>
					</div>
					<!-- 제과점 재료 종료 -->
					
					<!-- 신상품 입점 시작 -->
					<div
						class="slider category-slider-inner products-list yt-content-slider divTab" id="tabNewProd" style="display: none;"
						data-rtl="yes" data-autoplay="yes" data-autoheight="no"
						data-delay="4" data-speed="0.6" data-margin="30"
						data-items_column00="6" data-items_column0="6"
						data-items_column1="6" data-items_column2="4"
						data-items_column3="3" data-items_column4="2" data-arrows="no"
						data-pagination="no" data-lazyload="yes" data-loop="no"
						data-hoverpause="yes">
						<div class="item">
							<c:forEach var="ent" items="${ recommendList7 }" varStatus="status">
								<c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
								<c:if test="${ empty(ent.ATFL_ID)  }">
									<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
								</c:if>
								<div class="item-inner product-layout transition product-grid">
									<div class="product-item-container">
										<div class="left-block left-b">
											<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
												<div class="box-label">
													<span class="label-product label-sale">품절</span>
												</div>
											</c:if>
											<div class="product-image-container">
												<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" target="_self" title="${ ent.PD_NAME }">
													<img src="${imgPath}" class="img-1 img-responsive goodsImg270" alt="${ ent.PD_NAME } image1"> 
												</a>
											</div>
											<!--quickview
											<div class="so-quickview">
												<a class="iframe-link btn-button quickview quickview_handler visible-lg"
													href="${contextPath }/m/product/quickview/${ ent.PD_CODE }" title="Quick view"
													data-fancybox-type="iframe">
													<i class="fa fa-eye"></i>
													<span>Quick view</span>
												</a>
											</div>
											end quickview-->
										</div>
										<div class="right-block">
											<div class="button-group so-quickview cartinfo--left">
												<c:if test="${ent.SALE_CON ne 'SALE_CON_02' }">
													<button type="button" class="addToCart" title="Add to cart" onclick="cart.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
														<span>Add to cart </span>
													</button>
													<button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
														<i class="fa fa-heart-o"></i><span>Add to Wish List</span>
													</button>
												</c:if>
											</div>
											<div class="caption hide-cont" style="height: 44px;">
												<h4 class="pname">
													<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" title="${ ent.PD_NAME }" target="_self">${ ent.PD_NAME }</a>
												</h4>
											</div>
											<p class="price">
												<span class="price-new"><fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###" /></span>

											</p>
										</div>

									</div>
								</div>
								<c:if test="${status.count % 2 eq 0 and status.count ne fn:length(recommendList7)}">
									</div>
									<div class="item">
								</c:if>
							</c:forEach>
						</div>
					</div>
					<!-- 신상품 입점 종료 -->
					
				</div>
			</div>
		</div>
	
		<div class="col-lg-2 col-md-12 col-sm-12 col-xs-12">
			<div class="banners1 banner-t banners">
				<!-- 250*390 -->
				<div>
					<a href="${contextPath}/product/retailListIcon"><img src="${contextPath }/resources/img/retail/retail_button.png" alt="retail"></a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- cate slider bottom -->
        </div>
    </div>




</div>
<!-- //Main Container -->