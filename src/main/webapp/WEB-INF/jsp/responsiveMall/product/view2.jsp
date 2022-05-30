<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<c:set var="arrCagoIdPath" value="${fn:split(rtnCagoInfo.CAGO_ID_PATH, '>') }" /> 
<c:set var="arrCagoNmPath" value="${fn:split(rtnCagoInfo.CAGO_NM_PATH, '>') }" /> 

	<script>
	$(function() {
		$('.goodsImg').each(function() {
			$(this).error(function(){
				$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage_270.png');
			});
		});
			
	});
	</script>

	<form id="bkInstFrm" name="bkInstFrm" action="${contextPath }/goods/basketInst" method="post" autocomplete="off">
		<input type="hidden" name="PD_CODE" id="PD_CODE" value="${result.PD_CODE }"> 
		<input type="hidden" name="PD_QTY" id="PD_QTY" value=""> 
		<input type="hidden" name="ORDER_QTY" id="ORDER_QTY" value=""> 
		<input type="hidden" id="BSKT_REGNO" name="BSKT_REGNO" value=""> 
		<input type="hidden" id="PD_NAME" name="PD_NAME" value="${result.PD_NAME}" /> 
		<input type="hidden" id="PD_PRICE" name="PD_PRICE" value="${result.PD_PRICE}" /> 
		<input type="hidden" id="PDDC_GUBN" name="PDDC_GUBN" value="${result.PDDC_GUBN}" /> 
		<input type="hidden" id="PDDC_VAL" name="PDDC_VAL" value="${result.PDDC_VAL}" /> 
		<input type="hidden" id="ORDER_AMT" name="ORDER_AMT" value="${ result.PD_PRICE }" /> 
		<input type="hidden" id="DLVY_AMT" name="DLVY_AMT" value="0" /> 
		<input type="hidden" id="DAP_YN" name="DAP_YN" value="N" />
		<input type="hidden" id="PD_CUT_SEQ" name="PD_CUT_SEQ" value="" />
		<input type="hidden" id="PD_CUT_SEQ_UNIT" name="PD_CUT_SEQ_UNIT" value="" />
		
		<input type="hidden" id="OPTION_CODE" name="OPTION_CODE" value="" />
		<input type="hidden" id="OPTION_NAME" name="OPTION_NAME" value="" />
	</form>

	<!-- Main Container  -->
	<div class="main-container container">
		<ul class="breadcrumb">
			<li><a href="${contextPath }/m"><i class="fa fa-home"></i></a></li>
			<c:forEach var="entPath" items="${ arrCagoNmPath }" varStatus="status">
				<li><a href="${contextPath }/m/product?CAGO_ID=${arrCagoIdPath[status.index] }" class=" ">${entPath }</a></li>
			</c:forEach>
		</ul>
		
		<div class="row">
			<!--Left Part Start -->
			<aside class="col-sm-4 col-md-3 content-aside" id="column-left">
				<c:if test="${ !empty rtnCagoList }">
				<div class="module category-style">
                	<h3 class="modtitle">카테고리</h3>
                	<div class="modcontent">
                		<div class="box-category">
                			<ul id="cat_accordion" class="list-group">
								<c:forEach var="ent" items="${ rtnCagoList }" varStatus="status">
									<li class=""><a href="${contextPath }/m/product?CAGO_ID=${ ent.CAGO_ID }" class="cutom-parent"><c:out value="${ ent.CAGO_NAME }" escapeXml="true"/> (${ ent.PRD_CNT })</a>  <span class="dcjq-icon"></span></li>
								</c:forEach>
                			</ul>
                		</div>
                	</div>
                </div>
				</c:if>
            	<div class="module banner-left hidden-xs ">
                	<div class="banner-sidebar banners">
                      <div>
                        <a title="Banner Image" href="${contextPath}/product/m/retailListIcon"> 
                          <img src="${contextPath }/resources/img/retail/retail_button.png" alt="retail"> 
                        </a>
                      </div>
                    </div>
                </div>
            </aside>
            <!--Left Part End -->


			<!--Middle Part Start-->
			<div id="content" class="col-md-9 col-sm-8">
				
				<div class="product-view row">
					<div class="left-content-product">
				
						<div class="content-product-left class-honizol col-md-5 col-sm-12 col-xs-12">
							<c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${result.ATFL_ID }&ATFL_SEQ=${result.RPIMG_SEQ}&IMG_GUBUN=productView1" />
							<c:if test="${ empty(result.ATFL_ID)  }">
								<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage.png" />
							</c:if>
							<div class="large-image  ">
								<img itemprop="image" class="product-image-zoom" src="${imgPath }" title="${ result.PD_NAME }" alt="${ result.PD_NAME }">
							</div>
							<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
								<div class="box-label">
									<span class="label-product label-sale">품절</span>
								</div>
							</c:if>
							
							<div id="thumb-slider" class="yt-content-slider full_slider owl-drag" data-rtl="yes" data-autoplay="no" data-autoheight="no" data-delay="4" data-speed="0.6" data-margin="10" data-items_column00="4" data-items_column0="4" data-items_column1="3" data-items_column2="4"  data-items_column3="1" data-items_column4="1" data-arrows="yes" data-pagination="no" data-lazyload="yes" data-loop="no" data-hoverpause="yes">
								<c:if test="${ !empty(fileList) }">
									<c:forEach var="var" items="${ fileList }" varStatus="status">
										<a data-index="${status.index }" class="img thumbnail " data-image="${contextPath }/common/commonImgFileDown?ATFL_ID=${var.ATFL_ID }&ATFL_SEQ=${var.ATFL_SEQ}&IMG_GUBUN=productView1" title="${ result.PD_NAME }">
											<img src="${contextPath }/common/commonImgFileDown?ATFL_ID=${var.ATFL_ID }&ATFL_SEQ=${var.ATFL_SEQ}&IMG_GUBUN=productView1" title="${ result.PD_NAME }" alt="${ result.PD_NAME }">
										</a>
									</c:forEach>
								</c:if>
								<c:if test="${ empty(fileList) }">
									<a data-index="0" class="img thumbnail " data-image="${contextPath }/resources/images/mall/goods/noimage.png" title="${ result.PD_NAME } 상품이미지 없음">
										<img src="${contextPath }/resources/images/mall/goods/noimage.png" title="${ result.PD_NAME } 상품이미지 없음" alt="${ result.PD_NAME } 상품이미지 없음">
									</a>
								</c:if>
							</div>
							
						</div>

						<div class="content-product-right col-md-7 col-sm-12 col-xs-12">
							<div class="title-product">
								<h1>Chicken swinesha</h1>
							</div>
							<!-- Review ---->
							<div class="box-review form-group">
								<div class="ratings">
									<div class="rating-box">
										<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
										<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
										<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
										<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
										<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
									</div>
								</div>

								<a class="reviews_button" href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;">0 reviews</a>	| 
								<a class="write_review_button" href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;">Write a review</a>
							</div>

							<div class="product-label form-group">
								<div class="product_page_price price" itemprop="offerDetails" itemscope="" itemtype="http://data-vocabulary.org/Offer">
									<span class="price-new" itemprop="price">$114.00</span>
									<span class="price-old">$122.00</span>
								</div>
								<div class="stock"><span>Availability:</span> <span class="status-stock">In Stock</span></div>
							</div>

							<div class="product-box-desc">
								<div class="inner-box-desc">
									<div class="price-tax"><span>Ex Tax:</span> $60.00</div>
									<div class="reward"><span>Price in reward points:</span> 400</div>
									<div class="brand"><span>Brand:</span><a href="#">Apple</a>		</div>
									<div class="model"><span>Product Code:</span> Product 15</div>
									<div class="reward"><span>Reward Points:</span> 100</div>
								</div>
							</div>


							<div id="product">
								<h4>Available Options</h4>
								<div class="image_option_type form-group required">
									<label class="control-label">Colors</label>
									<ul class="product-options clearfix"id="input-option231">
										<li class="radio">
											<label>
												<input class="image_radio" type="radio" name="option[231]" value="33"> 
												<img src="image/demo/colors/blue.jpg" data-original-title="blue +$12.00" class="img-thumbnail icon icon-color">				<i class="fa fa-check"></i>
												<label> </label>
											</label>
										</li>
										<li class="radio">
											<label>
												<input class="image_radio" type="radio" name="option[231]" value="34"> 
												<img src="image/demo/colors/brown.jpg" data-original-title="brown -$12.00" class="img-thumbnail icon icon-color">				<i class="fa fa-check"></i>
												<label> </label>
											</label>
										</li>
										<li class="radio">
											<label>
												<input class="image_radio" type="radio" name="option[231]" value="35"> <img src="image/demo/colors/green.jpg"
												data-original-title="green +$12.00" class="img-thumbnail icon icon-color">				<i class="fa fa-check"></i>
												<label> </label>
											</label>
										</li>
										<li class="selected-option">
										</li>
									</ul>
								</div>
								
								<div class="box-checkbox form-group required">
									<label class="control-label">Checkbox</label>
									<div id="input-option232">
										<div class="checkbox">
											<label for="checkbox_1"><input type="checkbox" name="option[232][]" value="36" id="checkbox_1"> Checkbox 1 (+$12.00)</label>
										</div>
										<div class="checkbox">
											<label for="checkbox_2"><input type="checkbox" name="option[232][]" value="36" id="checkbox_2"> Checkbox 2 (+$36.00)</label>
										</div>
										<div class="checkbox">
											<label for="checkbox_3"><input type="checkbox" name="option[232][]" value="36" id="checkbox_3"> Checkbox 3 (+$24.00)</label>
										</div>
										<div class="checkbox">
											<label for="checkbox_4"><input type="checkbox" name="option[232][]" value="36" id="checkbox_4"> Checkbox 4 (+$48.00)</label>
										</div>
									</div>
								</div>

								<div class="form-group box-info-product">
									<div class="option quantity">
										<div class="input-group quantity-control" unselectable="on" style="-webkit-user-select: none;">
											<label>Qty</label>
											<input class="form-control" type="text" name="quantity"
											value="1">
											<input type="hidden" name="product_id" value="50">
											<span class="input-group-addon product_quantity_down">−</span>
											<span class="input-group-addon product_quantity_up">+</span>
										</div>
									</div>
									<div class="cart">
										<input type="button" data-toggle="tooltip" title="" value="Add to Cart" data-loading-text="Loading..." id="button-cart" class="btn btn-mega btn-lg" onclick="cart.add('42', '1');" data-original-title="Add to Cart">
									</div>
									<div class="add-to-links wish_comp">
										<ul class="blank list-inline">
											<li class="wishlist">
												<a class="icon" data-toggle="tooltip" title=""
												onclick="wishlist.add('50');" data-original-title="Add to Wish List"><i class="fa fa-heart"></i>
												</a>
											</li>
											<li class="compare">
												<a class="icon" data-toggle="tooltip" title=""
												onclick="compare.add('50');" data-original-title="Compare this Product"><i class="fa fa-exchange"></i>
												</a>
											</li>
										</ul>
									</div>

								</div>

							</div>
							<!-- end box info product -->

						</div>
				
					</div>
				</div>
				<!-- Product Tabs -->
				<div class="producttab ">
					<div class="tabsslider  vertical-tabs col-xs-12">
						<ul class="nav nav-tabs col-lg-2 col-sm-3">
							<li class="active"><a data-toggle="tab" href="#tab-1">Description</a></li>
							<li class="item_nonactive"><a data-toggle="tab" href="#tab-review">Reviews (1)</a></li>
							<li class="item_nonactive"><a data-toggle="tab" href="#tab-4">Tags</a></li>
							<li class="item_nonactive"><a data-toggle="tab" href="#tab-5">Custom Tab</a></li>
						</ul>
						<div class="tab-content col-lg-10 col-sm-9 col-xs-12">
							<div id="tab-1" class="tab-pane fade active in">
								<p>
									The 30-inch Apple Cinema HD Display delivers an amazing 2560 x 1600 pixel resolution. Designed specifically for the creative professional, this display provides more space for easier access to all the tools and palettes needed to edit, format and composite your work. Combine this display with a Mac Pro, MacBook Pro, or PowerMac G5 and there's no limit to what you can achieve. <br>
									<br>
									The Cinema HD features an active-matrix liquid crystal display that produces flicker-free images that deliver twice the brightness, twice the sharpness and twice the contrast ratio of a typical CRT display. Unlike other flat panels, it's designed with a pure digital interface to deliver distortion-free images that never need adjusting. With over 4 million digital pixels, the display is uniquely suited for scientific and technical applications such as visualizing molecular structures or analyzing geological data. <br>
									<br>
									Offering accurate, brilliant color performance, the Cinema HD delivers up to 16.7 million colors across a wide gamut allowing you to see subtle nuances between colors from soft pastels to rich jewel tones. A wide viewing angle ensures uniform color from edge to edge. Apple's ColorSync technology allows you to create custom profiles to maintain consistent color onscreen and in print. The result: You can confidently use this display in all your color-critical applications. <br>
									<br>
									Housed in a new aluminum design, the display has a very thin bezel that enhances visual accuracy. Each display features two FireWire 400 ports and two USB 2.0 ports, making attachment of desktop peripherals, such as iSight, iPod, digital and still cameras, hard drives, printers and scanners, even more accessible and convenient. Taking advantage of the much thinner and lighter footprint of an LCD, the new displays support the VESA (Video Electronics Standards Association) mounting interface standard. Customers with the optional Cinema Display VESA Mount Adapter kit gain the flexibility to mount their display in locations most appropriate for their work environment. <br>
									<br>
									The Cinema HD features a single cable design with elegant breakout for the USB 2.0, FireWire 400 and a pure digital connection using the industry standard Digital Video Interface (DVI) interface. The DVI connection allows for a direct pure-digital connection.<br>
									</p>
								<h3>
									Features:</h3>
								<p>
									Unrivaled display performance</p>
								<ul>
									<li>
										30-inch (viewable) active-matrix liquid crystal display provides breathtaking image quality and vivid, richly saturated color.</li>
									<li>
										Support for 2560-by-1600 pixel resolution for display of high definition still and video imagery.</li>
									<li>
										Wide-format design for simultaneous display of two full pages of text and graphics.</li>
									<li>
										Industry standard DVI connector for direct attachment to Mac- and Windows-based desktops and notebooks</li>
									<li>
										Incredibly wide (170 degree) horizontal and vertical viewing angle for maximum visibility and color performance.</li>
									<li>
										Lightning-fast pixel response for full-motion digital video playback.</li>
									<li>
										Support for 16.7 million saturated colors, for use in all graphics-intensive applications.</li>
								</ul>
								<p>
									Simple setup and operation</p>
								<ul>
									<li>
										Single cable with elegant breakout for connection to DVI, USB and FireWire ports</li>
									<li>
										Built-in two-port USB 2.0 hub for easy connection of desktop peripheral devices.</li>
									<li>
										Two FireWire 400 ports to support iSight and other desktop peripherals</li>
								</ul>
								<p>
									Sleek, elegant design</p>
								<ul>
									<li>
										Huge virtual workspace, very small footprint.</li>
									<li>
										Narrow Bezel design to minimize visual impact of using dual displays</li>
									<li>
										Unique hinge design for effortless adjustment</li>
									<li>
										Support for VESA mounting solutions (Apple Cinema Display VESA Mount Adapter sold separately)</li>
								</ul>
								
								
							</div>
							<div id="tab-review" class="tab-pane fade">
								<form>
									<div id="review">
										<table class="table table-striped table-bordered">
											<tbody>
												<tr>
													<td style="width: 50%;"><strong>Super Administrator</strong></td>
													<td class="text-right">29/07/2015</td>
												</tr>
												<tr>
													<td colspan="2">
														<p>Best this product opencart</p>
														<div class="ratings">
															<div class="rating-box">
																<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
																<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
																<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
																<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
																<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
															</div>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
										<div class="text-right"></div>
									</div>
									<h2 id="review-title">Write a review</h2>
									<div class="contacts-form">
										<div class="form-group"> <span class="icon icon-user"></span>
											<input type="text" name="name" class="form-control" value="Your Name" onblur="if (this.value == '') {this.value = 'Your Name';}" onfocus="if(this.value == 'Your Name') {this.value = '';}"> 
										</div>
										<div class="form-group"> <span class="icon icon-bubbles-2"></span>
											<textarea class="form-control" name="text" onblur="if (this.value == '') {this.value = 'Your Review';}" onfocus="if(this.value == 'Your Review') {this.value = '';}">Your Review</textarea>
										</div> 
										<span style="font-size: 11px;"><span class="text-danger">Note:</span>						HTML is not translated!</span>
										
										<div class="form-group">
										 <b>Rating</b> <span>Bad</span>&nbsp;
										<input type="radio" name="rating" value="1"> &nbsp;
										<input type="radio" name="rating"
										value="2"> &nbsp;
										<input type="radio" name="rating"
										value="3"> &nbsp;
										<input type="radio" name="rating"
										value="4"> &nbsp;
										<input type="radio" name="rating"
										value="5"> &nbsp;<span>Good</span>
										
										</div>
										<div class="buttons clearfix"><a id="button-review" class="btn buttonGray">Continue</a></div>
									</div>
								</form>
							</div>
							<div id="tab-4" class="tab-pane fade">
								<a href="#">Monitor</a>,
								<a href="#">Apple</a>				
							</div>
							<div id="tab-5" class="tab-pane fade">
								<h3 class="custom-color">Take a trivial example which of us ever undertakes</h3>
								<p>Lorem ipsum dolor sit amet, consetetur
									sadipscing elitr, sed diam nonumy eirmod
									tempor invidunt ut labore et dolore
									magna aliquyam erat, sed diam voluptua.
									At vero eos et accusam et justo duo
									dolores et ea rebum. Stet clita kasd
									gubergren, no sea takimata sanctus est
									Lorem ipsum dolor sit amet. Lorem ipsum
									dolor sit amet, consetetur sadipscing
									elitr, sed diam nonumy eirmod tempor
									invidunt ut labore et dolore magna aliquyam
									erat, sed diam voluptua. </p>
								<p>At vero eos et accusam et justo duo dolores
									et ea rebum. Stet clita kasd gubergren,
									no sea takimata sanctus est Lorem ipsum
									dolor sit amet. Lorem ipsum dolor sit
									amet, consetetur sadipscing elitr.</p>
									<ul class="marker-simple-list two-columns">
						<li>Nam liberempore</li>
						<li>Cumsoluta nobisest</li>
						<li>Eligendptio cumque</li>
						<li>Nam liberempore</li>
						<li>Cumsoluta nobisest</li>
						<li>Eligendptio cumque</li>
						</ul>
								<p>Sed diam nonumy eirmod tempor invidunt
									ut labore et dolore magna aliquyam erat,
									sed diam voluptua. At vero eos et accusam
									et justo duo dolores et ea rebum. Stet
									clita kasd gubergren, no sea takimata
									sanctus est Lorem ipsum dolor sit amet.</p>
							</div>
						</div>
					</div>
				</div>
				<!-- //Product Tabs -->

			</div>

        </div>
    </div>
	<!-- //Main Container -->
	