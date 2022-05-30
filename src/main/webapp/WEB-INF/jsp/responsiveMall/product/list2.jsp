<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<c:set var="arrCagoIdPath" value="${fn:split(rtnCagoInfo.CAGO_ID_PATH, '>') }" /> 
<c:set var="arrCagoNmPath" value="${fn:split(rtnCagoInfo.CAGO_NM_PATH, '>') }" /> 

	<script>
	$(function() {

	    $(document).on("change", "#selectSort", function() {
    		$("#sortOdr").val("asc");
	    	if($(this).val() == "PD_NAME"){
	    		$("#sortGubun").val("PD_NAME");
	    	}else if($(this).val() == "PD_PRICE_ASC"){
	    		$("#sortGubun").val("PD_PRICE");
	    	}else if($(this).val() == "PD_PRICE_DESC"){
	    		$("#sortGubun").val("PD_PRICE");
	    		$("#sortOdr").val("desc");
	    	}
	    	$("#frmOrd").submit();
	    });
	    
		if($.cookie('display')){
			view = $.cookie('display');
		}else{
			view = 'list';
		}
		if(view) display(view);
		

		// 수량변경 및 삭제
		$('.btnQty').click(function(){
		    var mode = $(this).text();
		    var this_qty, max_qty = 999, min_qty = 1;
		    var $el_qty = $(this).closest(".input-group").find("input[name^=PD_CNT]");	    	    
		    var stock = 100;
		    
		    switch(mode) {
		        case "+":
		            this_qty = parseInt($el_qty.val().replace(/[^0-9]/, "")) + 1;	            
		            /*
		            if(this_qty > stock) {
		                alert("재고수량 보다 많은 수량을 구매할 수 없습니다.");
		                this_qty = stock;
		            }
		            */
		            if(this_qty > max_qty) {
		                this_qty = max_qty;
		                alert("최대 구매수량은 "+number_format(String(max_qty))+" 입니다.");
		            }
		            $el_qty.val(this_qty);		            
		            break;

		        case "-":
		            this_qty = parseInt($el_qty.val().replace(/[^0-9]/, "")) - 1;
		            if(this_qty < min_qty) {
		                this_qty = min_qty;
		                alert("최소 구매수량은 "+number_format(String(min_qty))+" 입니다.");
		            }
		            $el_qty.val(this_qty);
		            break;

		        default:
		            alert("올바른 방법으로 이용해 주십시오.");
		            break;
		    }
		    
		    $('#PD_QTY').val($el_qty.val());
		});
	});
	

	// 장바구니 담기
	function addCart(pd_code, pd_name, pd_cut, option_gubn){

       	<c:if test="${empty USER.MEMB_ID}">
			alert("로그인이 필요합니다.");
			return false;
		</c:if>
		
		if(parseInt(pd_cut) > 0){
			alert("세절방식을 선택해야하는 상품입니다.\n상품상세페이지에서 세절방식을 선택 후 장바구니에 담아주세요.");	
			return false
		}
		if(option_gubn.length > 0){
			alert("색상을 선택해야하는 상품입니다.\n상품상세페이지에서 색상을 선택 후 장바구니에 담아주세요.");
			return false;
		}
		
		$('#PD_CODE').val(pd_code);
		$('#PD_NAME').val(pd_name);
		
		//
    	$.ajax({
    		type: "POST",
    		url: '${contextPath}/goods/basketInst',
    		data: $("#bkInstFrm").serialize(),
    		success: function (data) {

    			// 장바구니 등록 여부
    			if (data == '0') {
    				addProductNotice('장바구니 추가', '', '<h3>[' + pd_name + '] 장바구니에 등록되었습니다.</h3>', 'success');
    			}else{
					addProductNotice('장바구니 추가', '', '<h3 style="color:red;">장바구니에 이미 등록된 상품 입니다.</h3>', 'success');
    			}
    		}, error: function (jqXHR, textStatus, errorThrown) {
    			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
    		}
    	});
	}
	</script>
	
	<!-- 장바구니 담기 form -->
	<form id="bkInstFrm" name="bkInstFrm" action="${contextPath }/goods/basketInst" method="post" autocomplete="off">
		<input type="hidden" id="PD_CODE" name="PD_CODE" value="" /> 
		<input type="hidden" id="PD_NAME" name="PD_NAME" value="" />
		<input type="hidden" id="PD_QTY" name="PD_QTY" value="" />	
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
				<%-- 
            	<div class="module banner-left hidden-xs ">
                	<div class="banner-sidebar banners">
                      <div>
                        <a title="Banner Image" href="${contextPath}/product/m/retailListIcon"> 
                          <img src="${contextPath }/resources/img/retail/retail_button.png" alt="retail"> 
                        </a>
                      </div>
                    </div>
                </div>
                 --%>
            </aside>
            <!--Left Part End -->
			
        	<!--Middle Part Start-->
        	<div id="content" class="col-md-9 col-sm-8">
        		<div class="products-category">
                    <h3 class="title-category ">상품목록</h3>
        			<!-- Filters -->
                    <div class="product-filter product-filter-top filters-panel">
                        <div class="row">
                            <div class="col-md-5 col-sm-3 col-xs-12 view-mode">
                                
                                    <div class="list-view">
                                        <button class="btn btn-default grid" data-view="grid" data-toggle="tooltip"  data-original-title="바둑판"><i class="fa fa-th"></i></button>
                                        <button class="btn btn-default list active" data-view="list" data-toggle="tooltip" data-original-title="리스트ㄴ"><i class="fa fa-th-list"></i></button>
                                    </div>
                        
                            </div>
                            <div class="short-by-show form-inline text-right col-md-7 col-sm-9 col-xs-12">
								<form id="frmOrd" method="GET" action="${contextPath }/m/product">
								<input name="CAGO_ID" id="CAGO_ID" type="hidden" value="${obj.CAGO_ID}" />
								<input name="sortGubun" id="sortGubun" type="hidden" value="${obj.sortGubun}" />
								<input name="sortOdr" id="sortOdr" type="hidden" value="${empty obj.sortOdr ? 'asc' : obj.sortOdr}" />
                                <div class="form-group short-by">
                                    <label class="control-label" for="input-sort">정렬:</label>
                                    <select class="form-control" name="selectSort" id="selectSort">                                        
                                        <option value="PD_PRICE_ASC" ${param.selectSort eq 'PD_PRICE_ASC' ? 'selected=selected':''}>낮은가격순</option>
                                        <option value="PD_PRICE_DESC" ${param.selectSort eq 'PD_PRICE_DESC' ? 'selected=selected':''}>높은가격순</option>
                                        <option value="PD_NAME" ${param.selectSort eq 'PD_NAME' ? 'selected=selected':''}>상품명순</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="control-label" for="input-limit">노출갯수:</label>
                                    <select id="input-limit" class="form-control" onchange="this.form.submit()" name="pagerMaxPageItems">
										<option value="15" ${obj.pagerMaxPageItems== 15 ? 'selected=selected':''} >15</option>
										<option value="25" ${obj.pagerMaxPageItems == 25 ? 'selected=selected':''}>25</option>
										<option value="50" ${obj.pagerMaxPageItems == 50 ? 'selected=selected':''}>50</option>
										<option value="75" ${obj.pagerMaxPageItems == 75 ? 'selected=selected':''}>75</option>
										<option value="100" ${obj.pagerMaxPageItems == 100 ? 'selected=selected':''}>100</option>
                                    </select>
                                </div>
                                </form>
                            </div>
                            <!-- <div class="box-pagination col-md-3 col-sm-4 col-xs-12 text-right">
                                <ul class="pagination">
                                    <li class="active"><span>1</span></li>
                                    <li><a href="">2</a></li><li><a href="">&gt;</a></li>
                                    <li><a href="">&gt;|</a></li>
                                </ul>
                            </div> -->
                        </div>
                    </div>
                    <!-- //end Filters -->

					<c:if test="${ !empty(obj.list) }">
        			<!--changed listings-->
                    <div class="products-list row nopadding-xs so-filter-gird">

						<c:forEach var="ent" items="${ obj.list }" varStatus="status">
	        				<div class="product-layout col-lg-15 col-md-4 col-sm-6 col-xs-6">
	                            <div class="product-item-container">
	                                <div class="left-block left-b">
										<%-- <c:set var="imgPath" value="${contextPath }/common/commonImgFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}&IMG_GUBUN=mainType1" /> --%>
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
	                                    <div class="product-image-container second_img">
	                                        <a href="${contextPath }/m/product/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}" target="_self" title="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>">
	                                            <img src="${imgPath }" class="img-1 img-responsive goodsImg270" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/> 상품이미지" >
	                                            <img src="${imgPath }" class="img-2 img-responsive goodsImg270" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/> 상품이미지">
	                                        </a>
	                                    </div>
	                                </div>
	                                <div class="right-block">
	                                    <div class="button-group so-quickview cartinfo--left">
											<c:if test="${ent.SALE_CON ne 'SALE_CON_02' }">
		                                        <button type="button" class="addToCart" title="Add to cart" onclick="cart.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
		                                            <span>장바구니</span>   
		                                        </button>
		                                        <button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
		                                        	<i class="fa fa-heart-o"></i><span>Add to Wish List</span>
		                                        </button>
											</c:if>
	                                    </div>
	                                    <div class="caption hide-cont">
	                                        <div class="ratings">
	                                        </div>	                                    
	                                        <h4 class="pname"><a href="${contextPath }/m/product/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}" title="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>" target="_self"><c:out value="${ ent.PD_NAME }" escapeXml="true"/></a></h4>
	                                    </div>
	                                    <p class="price">
											<c:if test="${ ent.REAL_PRICE ne ent.PD_PRICE }">
												<span class="price-old"><fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###"/>원</span>
											</c:if>
	                                        <span class="price-new"><fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###"/>원</span>	                                      
	                                    </p>
	                                    <div class="description item-desc">
	                                        <p>제조사(브랜드):<c:out value="${ ent.MAKE_COM }" escapeXml="true"/> </p>
	                                    </div>
	                                    <!-- 수량 -->
	                                    <div class="input-group" unselectable="on" style="-webkit-user-select: none;">
	                                    	<c:if test="${ent.SALE_CON ne 'SALE_CON_02' }">
						                        <input type="text" name="PD_CNT" value=1 id="PD_CNT" size="1" class="form-control" />
						                        <span class="input-group-btn">						                        
							                        <button type="button" data-toggle="tooltip" title="빼기" class="btn btn-danger btnQty">-</button>
							                        <button type="submit" data-toggle="tooltip" title="더하기" class="btn btn-primary btnQty">+</button>
						                        </span>
					                        </c:if>
										</div>
	                                    <div class="list-block">
											<c:if test="${ent.SALE_CON ne 'SALE_CON_02' }">
		                                        <button class="addToCart btn-button" type="button" title="Add to Cart" onclick="javascript:addCart('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
		                                        	<i class="fa fa-shopping-basket"></i>
		                                        </button>
		                                        <button class="wishlist btn-button" type="button" title="Add to Wish List" onclick="wishlist.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}');">
		                                        	<i class="fa fa-heart"></i>
		                                        </button>
											</c:if>
	                                    </div>
	                                </div>
	
	                            </div>
	                        </div>
						</c:forEach>
						
                    </div>
        			<!--// End Changed listings-->
        			</c:if>
					<c:if test="${ empty(obj.list) }">
                    	<div class="products-list row nopadding-xs so-filter-gird">
	        				<div class="product-layout col-lg-15 col-md-4 col-sm-6 col-xs-12">
	                            <div class="product-item-container">
									<p class="sct_noitem">등록된 상품이 없습니다.</p>
								</div>
							</div>
						</div>
					</c:if>
        			
        			<!-- Filters -->
        			<div class="product-filter product-filter-bottom filters-panel">
                        <div class="row">
                            <div class="col-sm-12 text-center">
								<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
									<First><Previous><AllPageLink><Next><Last>
								</paging:PageFooter>
                            </div>
                        </div>
                    </div>
        			<!-- //end Filters -->
        			
        		</div>
        		
        	</div>
        	

        	<!--Middle Part End-->
        </div>
    </div>
	<!-- //Main Container -->
	