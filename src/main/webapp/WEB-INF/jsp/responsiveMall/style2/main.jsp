<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp"%>
<!-- ▲ Key -->


    <div class="main-container container"> 
        <div id="content">

			 <!--배너  -->
			<div class="banner-zone">
				<div class="swiper-container" style="height: 362px;">
					<div class="swiper-wrapper">					
							<c:if test="${obj.count > 0}">
								<c:forEach items="${obj.list}" var="rolimg" varStatus="loop">
									 <div class="swiper-slide">
						              <a href="${contextPath }/m/product/eventList">
						              	<img src="${contextPath }/upload/${obj.JD_PATH}${rolimg.JD_LIST}" style="width:100%; height: 362px;" >
						              </a>
						              </div>									
								</c:forEach>
							</c:if>								
					</div>
					<!-- Add Pagination -->
					<div class="swiper-conts-wrap">
						<div class="swiper-conts">
							<div class="swiper-pagination"></div>
							<!-- Add Arrows -->
							<div class="swiper-button-next"></div>
							<div class="swiper-button-prev"></div>
						</div>
					</div>
				</div>
			</div>
            <!--배너END-->
            <!-- 상품리스트 -->
            <c:forEach var="list" items="${ rcmdInfo }" varStatus="status">
                <div class="main-item"> 
                    <!-- 상품제목 -->
                    <h2>${list.GRP_NM}</h2>
                    <div class="img-list-type">
                        <ul class="row clear-fix " style="display: flex;flex-direction: row; flex-wrap: wrap; align-items: center;">
                            <c:forEach var="ent" items="${ list.PDLIST }" varStatus="status">
                                <c:if test="${ !empty(ent.ATFL_ID)  }">
                                
                                    <c:if test="${ent.FILEPATH_FLAG eq mainKey }">
                                        <c:set var="imgPath" value="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
                                    </c:if>
                                    
                                    <c:if test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
                                        <c:set var="imgPath" value="${ent.STFL_PATH }" />
                                    </c:if>
                                    
                                    <c:if test="${ empty(ent.FILEPATH_FLAG) }">
                                        <c:set var="imgPath" value="https://www.cjfls.co.kr/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
                                    </c:if>
                                </c:if>
                                <c:if test="${ !empty(ent.IMGURL) }">
									<c:set var="imgPath" value="${ent.IMGURL }" />
								</c:if>
                                <c:if test="${ empty(ent.ATFL_ID) && empty(ent.IMGURL) }">
                                    <c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
                                </c:if>

                                <li>
                                    <!-- 상품명 -->
                                    <a href="${contextPath }/m/product/view/${ ent.PD_CODE }?entcago=${list.ENTRY_ID}" target="_self" title="${ ent.PD_NAME }">
                                        <img src="${imgPath}" class="img-1 img-responsive goodsImg270 test" style="width:232px; height:232px;" alt="${ ent.PD_NAME } image1">
                                    </a>
                                    <p class="tit"><a href="${contextPath }/m/product/view/${ ent.PD_CODE }" title="${ ent.PD_NAME }" target="_self">${ ent.PD_NAME }</a> </p>
                                    <!-- 상품가격 -->
                                    <p class="price">
                                    	<c:choose>
                                       		<c:when test="${empty ent.MEMBER_PRICE}">
                                       			<span class="price"><fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###" />원</span>
                                       			<span class="erased"></span>
                                       		</c:when>
                                       		<c:otherwise>
                                       			 <span class="price"><fmt:formatNumber value="${ ent.MEMBER_PRICE }" pattern="#,###" />원</span>
                                       			 <span class="erased"><fmt:formatNumber value="${ent.PD_PRICE }" pattern="#,###"/> 원 </span>
                                       		</c:otherwise>
                                       </c:choose>
                                    </p>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </c:forEach> 
            <!-- 상품리스트END -->
        </div>
    </div>

<script type="text/javascript">
	$(document).ready(function(){
	    var swiper = new Swiper('.swiper-container', {
	        navigation: {
	            nextEl: '.swiper-button-next',
	            prevEl: '.swiper-button-prev',
	        },
	        loop: true,
	        init: false,
	        on: {
	            slideChange: function () {
	            }
	        }
	    });
	    swiper.on("init", function () {
	
	    })
	    swiper.init()
   });
</script>


<%-- 

<script type="text/javascript">
$(document).ready(function(){
	// 롤링이미지 Action
    $(".yt-content-slide-item").show();    
});
</script>  

<style>
@media (max-width: 1200px){
	.entcago {
	display:block;	
	}
}

@media (min-width: 1200px){
	.entcago {
	display:none;
	}
}

.entcago {
	padding-top : 25px;
}

.main_hdtable{
	width : 100%;
	height : 100%;
	border-collapse: separate;
	border-spacing: 0 10px; 

}

.main_hdtable tr {
	width : 100%;
	height: 34px;
	
}

.main_hdtable tr td {
	border : 1px solid black;
  	border-radius: 14px;
  	text-align : center;
  	cursor : pointer;  	
   	background-color: #1C5B7E;
  	border-color : #1C5B7E; 
	
}
.main_hdtable tr td:hover {
	/* background-color: blue; */
	opacity: 0.8;
}

.hfont {
	color:white;
	font-size : 18px;
	font-weight: 600;
}
</style>

<!-- Main Container  -->
<div class="main-container container">
    <div id="content">
        <div class="content-top-w main-box">
            <div class="col-lg-2 col-md-12 col-sm-12 col-xs-12 main-left">
                <div class="module col1 hidden-sm hidden-xs"></div>
            </div>
             
            <div class="col-lg-10 col-md-12 col-sm-12 col-xs-12 main-right">
                <div class="slider-container row"> 
					<!-- 롤링이미지 -->
                    <div class="col-lg-9 col-md-12 col-sm-12 col-xs-12 col2">
                        <div class="module sohomepage-slider ">
                            <div class="yt-content-slider"  data-rtl="yes" data-autoplay="yes" data-autoheight="no" data-delay="4" data-speed="0.6" data-margin="0" data-items_column00="1" data-items_column0="1" data-items_column1="1" data-items_column2="1"  data-items_column3="1" data-items_column4="1" data-arrows="no" data-pagination="yes" data-lazyload="yes" data-loop="yes" data-hoverpause="yes">
                                <!-- 1090*450 -->
                                <c:if test="${obj.count > 0}">	
                                	<c:forEach items="${obj.list}" var="rolimg" varStatus="loop">
                                		<c:if test="${loop.count eq 1}">
                                			<div class="yt-content-slide">
                                		</c:if>
                                		<c:if test="${loop.count > 1}">
                                			<div class="yt-content-slide yt-content-slide-item" style="display: none;">
                                		</c:if>
	                                    	<a href="#"><img src="${contextPath }/upload/${obj.JD_PATH}${rolimg.JD_LIST}" alt="slider${loop.count}" class="img-responsive" id="slider${loop.count}"></a>
	                                	</div>
                                	</c:forEach>
                                </c:if>
                                <c:if test="${obj.count eq 0}">
	                                <div class="yt-content-slide">
	                                    <a href="#"><img src="${contextPath }/resources/img/main/main_slide5_1903.png" alt="slider1" class="img-responsive"></a>
	                                </div>
                                </c:if>
                            </div>     
                            
                            <div class="entcago">
                            	<table class="main_hdtable">
			                    	<c:forEach var = "list" items = "${entrycagoList}" varStatus = "status">
			                    		<tr onClick = "location.href='${contextPath }/m?entcago=${list.ENTRY_ID}'">	                    			
			                    			<td>	         
		                    					<font class="hfont">
		                    					${list.ENTRY_NAME}
		                    					</font>
			                    			</td>
			                    		</tr>
			                    	</c:forEach>
			                    </table> 
                            </div>                       
                        </div>                        
                    </div>
	            
	            	<!-- Center Category START-->
	                <div class="slider-container row main_hdcont">
	                    <div class="col-lg-9 col-md-12 col-sm-12 col-xs-12 main_hddiv">
		                    	진입카테고리
		                    <table class="main_hdtable">
		                    	<c:forEach var = "list" items = "${entrycagoList}" varStatus = "status">
		                    		<tr onClick = "location.href='${contextPath }/m?entcago=${list.ENTRY_ID}'">	                    			
		                    			<td>	         
	                    					<font class="hfont">
	                    					${list.ENTRY_NAME}
	                    					</font>
		                    			</td>
		                    		</tr>
		                    	</c:forEach>
		                    </table>
	                    </div>
	                </div>
	                <!-- Center Category End-->
                    
                    <!-- 우측 미니 추천상품 -->
                    <div class="col-lg-3 col-md-12 col-sm-12 col-xs-12 col3">
                        <div class="module product-simple extra-layout1">
                            <h3 class="modtitle">
                                <span>${list.GRP_NM}</span>
                            </h3>
                            <div class="modcontent">
                                <div id="so_extra_slider_1" class="so-extraslider" >
                                    <!-- Begin extraslider-inner -->
                                    <div class="yt-content-slider extraslider-inner" data-rtl="yes" data-pagination="yes" data-autoplay="no" data-delay="4" data-speed="0.6" data-margin="0" data-items_column00="1" data-items_column0="1" data-items_column1="1" data-items_column2="1" data-items_column3="1" data-items_column4="1" data-arrows="no" data-lazyload="yes" data-loop="no" data-buttonpage="top">										
										<div class="item ">
										<c:forEach var="ent" items="${ miniInfo }" varStatus="status">
											<c:if test="${ !empty(ent.ATFL_ID)  }" >
												<c:if test="${ent.FILEPATH_FLAG eq mainKey }">													
													<c:set var="imgPath" value="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
												</c:if>
												<c:if test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
													<c:set var="imgPath" value="${ent.STFL_PATH }" />
												</c:if>
												<c:if test="${ empty(ent.FILEPATH_FLAG) }">
													<c:set var="imgPath" value="https://www.cjfls.co.kr/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />													
												</c:if>
											</c:if>
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
														<c:if test="${ent.PDDC_GUBN eq 'PDDC_GUBN_02' }">
			                                                <div class="box-label">
			                                                    <span class="label-product label-new">행사</span>
			                                                </div>
														</c:if>														
                                                        <a href="${contextPath }/m/product/view/${ ent.PD_CODE }" target="_self" title="${ ent.PD_NAME } ">
                                                            <img src="${imgPath }" alt="${ ent.PD_NAME }" class="goodsImg270" >
                                                         </a>
                                                    </div>                                                    
                                                </div>
                                                <div class="item-info">
                                                    <div class="item-title">
                                                        <a href="${contextPath }/m/product/view/${ ent.PD_CODE }" target="_self" title="${ ent.PD_NAME }">${ ent.PD_NAME } </a>
                                                    </div>
                                                    <div class="content_price price">                                                    	
                                                        <span class="price-new product-price"><fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###"/>원 </span>
                                                    </div>
                                                </div>
                                                <!-- End item-info -->
                                                <!-- End item-wrap-inner -->
                                            </div>
											<c:if test="${status.count % 4 eq 0 and status.count ne fn:length(miniInfo)}">
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
                    <!-- Right Slider End-->                
                </div>
            </div>                                        
        </div>
        
        <!-- Tab Slider -->
        <div class="row content-main-w">
			<div class="row box-content2">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<!-- 추천상품 -->					
					<c:forEach var="list" items="${ rcmdInfo }" varStatus="status">
						<div id="so_category_slider_189" class="so-category-slider container-slider module cate-slider2">
							<div class="modcontent">
								<div class="page-top" style="margin-bottom: 0;">
									<div class="page-title-categoryslider" >
										<font style="color:white;">${list.GRP_NM}</font>
									</div>
								</div>
							</div>
							<div class="products-list">
								<c:forEach var="ent" items="${ list.PDLIST }" varStatus="status">
									<c:if test="${ !empty(ent.ATFL_ID)  }" >
										<c:if test="${ent.FILEPATH_FLAG eq mainKey }">
											<c:set var="imgPath" value="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
										</c:if>
										<c:if test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
											<c:set var="imgPath" value="${ent.STFL_PATH }" />
										</c:if>
										<c:if test="${ empty(ent.FILEPATH_FLAG) }">
											<c:set var="imgPath" value="https://www.cjfls.co.kr/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
										</c:if>
									</c:if>
									<c:if test="${ empty(ent.ATFL_ID)  }">
										<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
									</c:if>
								
			        				<div class="item-inner product-layout transition product-grid col-lg-15 col-md-4 col-sm-6 col-xs-4">
										<div class="product-item-container" >
			                                <div class="left-block left-b">
			                                	<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
													<div class="box-label">
														<span class="label-product label-sale">품절</span>
													</div>
												</c:if>
												<div class="product-image-container">
													<a href="${contextPath }/m/product/view/${ ent.PD_CODE }?entcago=${list.ENTRY_ID}" target="_self" title="${ ent.PD_NAME }">
														<img src="${imgPath}" class="img-1 img-responsive goodsImg270" alt="${ ent.PD_NAME } image1" > 
													</a>
												</div>	
											</div>
                                			<div class="right-block">
                                				<div class="button-group so-quickview cartinfo--left">
													<c:if test="${ent.SALE_CON ne 'SALE_CON_02' }">
														<button type="button" class="addToCart" title="Add to cart" onclick="cart.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}', '${ent.OPTION_CNT}');">
															<span>장바구니</span>
														</button>
														<button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}', '${ent.OPTION_CNT}');">
															<i class="fa fa-heart-o"></i><span>Add to Wish List</span>
														</button>
													</c:if>
												</div>
                                    			<div class="caption hide-cont">
	                                    			<div class="ratings">
	                                        		</div>
													<h4 class="pname" style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;height: 20px;">
														<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" title="${ ent.PD_NAME }" target="_self">${ ent.PD_NAME }</a>
													</h4>
												</div>
												<p class="price">
													<span class="price-dark"><fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###" />원</span>
													<fmt:parseNumber var="pv" value="${ (ent.REAL_PRICE * PV) / 10 }" integerOnly="true" />
													<span class="price-new">| PV ${ pv * 10 }</span>
												</p>
											</div>
										</div>
			                        </div>
								</c:forEach>
		                    </div>
		                    
							<div class="categoryslider-content show preset01-4 preset02-4 preset03-3 preset04-2 preset05-1">		
								<div
									class="slider category-slider-inner products-list yt-content-slider"
									data-rtl="yes" data-autoplay="yes" data-autoheight="no"
									data-delay="4" data-speed="0.6"
									data-items_column00="6" data-items_column0="6"
									data-items_column1="6" data-items_column2="4"
									data-items_column3="3" data-items_column4="2" data-arrows="yes"
									data-pagination="no" data-lazyload="yes" data-loop="yes"
									data-hoverpause="yes"><!-- data-margin="30" -->
									<div class="item">
										<c:forEach var="ent" items="${ list.PDLIST }" varStatus="status">
											<c:if test="${ !empty(ent.ATFL_ID)  }" >
												<c:if test="${ent.FILEPATH_FLAG eq mainKey }">
													<c:set var="imgPath" value="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
												</c:if>
												<c:if test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
													<c:set var="imgPath" value="${ent.STFL_PATH }" />
												</c:if>
												<c:if test="${ empty(ent.FILEPATH_FLAG) }">
													<c:set var="imgPath" value="https://www.cjfls.co.kr/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
												</c:if>
											</c:if>
											<c:if test="${ empty(ent.ATFL_ID)  }">
												<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
											</c:if>
											<div class="item-inner product-layout transition product-grid">
												<div class="product-item-container" style="border: solid #e1e1e1; border-width: 1px 1px 0 0; padding: 13px; margin: 0;">
													<div class="left-block left-b">
														<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
															<div class="box-label">
																<span class="label-product label-sale">품절</span>
															</div>
														</c:if>
														<div class="product-image-container">
															<a href="${contextPath }/m/product/view/${ ent.PD_CODE }?entcago=${list.ENTRY_ID}" target="_self" title="${ ent.PD_NAME }">
																<img src="${imgPath}" class="img-1 img-responsive goodsImg270" alt="${ ent.PD_NAME } image1" > 
															</a>
														</div>														
													</div>
													
													<div class="right-block">
														<div class="button-group so-quickview cartinfo--left">
															<c:if test="${ent.SALE_CON ne 'SALE_CON_02' }">
																<button type="button" class="addToCart" title="Add to cart" onclick="cart.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}', '${ent.OPTION_CNT}');">
																	<span>장바구니</span>
																</button>
																<button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}', '${ent.OPTION_CNT}');">
																	<i class="fa fa-heart-o"></i><span>Add to Wish List</span>
																</button>
															</c:if>
														</div>
														<div class="caption hide-cont" style="height: 35px;">
															<h4 class="pname">
																<a href="${contextPath }/m/product/view/${ ent.PD_CODE }" title="${ ent.PD_NAME }" target="_self">${ ent.PD_NAME }</a>
															</h4>
														</div>
														<p class="price">
															<span class="price-dark"><fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###" />원</span>
															<fmt:parseNumber var="pv" value="${ (ent.REAL_PRICE * PV) / 10 }" integerOnly="true" />
															<span class="price-new">| PV ${ pv * 10 }</span>
														</p>
													</div>		
												</div>
											</div>
											<c:if test="${status.count % 2 eq 0 and status.count ne fn:length( list.PDLIST )}">
												</div>
												<div class="item">
											</c:if>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					<!-- /.추천상품 -->
				</div>
			</div>
        </div>
        <!-- cate slider bottom -->
    </div>
</div>
//Main Container --%>




