<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp"%>
<!-- ▲ Key -->

<c:set var="arrCagoIdPath" value="${fn:split(rtnCagoInfo.CAGO_ID_PATH, '>') }" />
<c:set var="arrCagoNmPath" value="${fn:split(rtnCagoInfo.CAGO_NM_PATH, '>') }" />
<!-- 
<script>
$(function() {
	//가격 초기화
	var form = $('.type_2'), range = form.find('.range');	
	var min = ${empty param.min_value ? '10': param.min_value};
	var max = ${empty param.max_value ? '100000' : param.max_value};
	
	form.find('#slider').slider('values', 0, min);
	form.find('#slider').slider('values', 1, max);
	form.find('.options_list').children().eq(0).children().trigger('click');
	
	range.children('.min_value').val(min).next().val(max);
	range.children('.min_val').text( $.number(min) + '원').next().text( $.number(max) + '원');

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
function addCart(pd_code, pd_name, pd_cut, option_gubn, option_cnt){
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
	if(option_cnt != "0"){
		alert("옵션을 선택해야하는 상품입니다.\n상품상세페이지에서 옵션을 선택 후 장바구니에 담아주세요.");
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
   				//alert("장바구니에 등록되었습니다.");
   				$("#myCartListCntHeader").text(parseInt($("#myCartListCntHeader").text())+1)
   				addProductNotice('장바구니 추가', '', '<h3>[' + pd_name + '] 장바구니에 등록되었습니다.</h3>', 'success');
   			}else{
   				//alert("장바구니에 이미 등록된 상품 입니다.");
				addProductNotice('장바구니 추가', '', '<h3 style="color:red;">장바구니에 이미 등록된 상품 입니다.</h3>', 'success');
   			}
   		}, error: function (jqXHR, textStatus, errorThrown) {
   			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
   		}
   	});
}
</script> -->

<script>
/* 파라미터값변경&submit */
	$(document).on("change", ".selectSort", function() {
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

</script>
<style>
	input:checked + label {
 	 font-weight:bold;
	}
</style>

<!-- searchList  -->
<c:if test="${ !empty(obj.list) }">
	<div class="container">
		<div class="location">
			<a href="${contextPath }/m">
				<span class="item">홈
				</span>
			</a>
			<c:forEach var="entPath" items="${ arrCagoNmPath }" varStatus="status">
				<span class="item"> 
					<span class="hp">></span>
					<a href="${contextPath }/m/product?CAGO_ID=${arrCagoIdPath[status.index]}&entcago=${entcagoInfo.ENTRY_ID}"> ${entPath } </a>
				</span>
			</c:forEach>
		</div>


		<div class=page-search>
			<div class="titbox">
				<div class="tit">
					<strong>찾고자 하는 검색어</strong> 검색결과 
					(<span>${totalCnt} </span>)
				</div>
			</div>
			
			<div class="cntbox">
				<div class="search">
					<div class="cate">
						<div class="total">
							<strong>총 ${totalCnt}개</strong> 의 상품이 있습니다.
						</div>
						
						
						<form id="frmOrd" method="GET" action="${contextPath }/m/search">
							<div class="sort">
								<input name="CAGO_ID" id="CAGO_ID" type="hidden" value="${obj.CAGO_ID}" />
								<input name="sortGubun" id="sortGubun" type="hidden" value="${obj.sortGubun}" />
								<input name="sortOdr" id="sortOdr" type="hidden" value="${empty obj.sortOdr ? 'asc' : obj.sortOdr}" />
								<input type="hidden" name="schTxt" id="schTxt" value="${param.schTxt }"/>
								<input type="hidden" name="schGbn" id="schGbn" value="${param.schGbn }"/>
							
								<ul class="clear-fix">
									<%-- <li>
										<input type="radio" id="recom" name="selectSort" value="PD_PRICE_ASC1" ${param.selectSort eq 'PD_PRICE_ASC1' ? 'checked=checked':''} >
										<label for="recom">추천상품순</label>
									</li> --%>
									<li>
										<input type="radio" id="PD_NAME" class="selectSort"  name="selectSort" value="PD_NAME" ${param.selectSort eq 'PD_NAME' ? 'checked=checked':''}>
										<label for="PD_NAME">이름정렬순</label> 
									</li>
									<li>
										<input type="radio" id="ASC" class="selectSort" name="selectSort" value="PD_PRICE_ASC" ${param.selectSort eq 'PD_PRICE_ASC' ? 'checked=checked':''}>
										<label for="ASC">낮은가격순</label>
									</li>
									<li>
										<input type="radio" id="DESC" class="selectSort"  name="selectSort" value="PD_PRICE_DESC" ${param.selectSort eq 'PD_PRICE_DESC' ? 'checked=checked':''}>
										<label for="DESC"> 높은가격순</label>
									</li>
								</ul>
							</div>
						</form>
					</div>

					<!--changed listings-->
					<div class="goods">
						<ul>
							<c:forEach var="ent" items="${ obj.list }" varStatus="status">
								<li>
									<div class="img">
										<c:if test="${ !empty(ent.ATFL_ID)  }">
											<c:if test="${ent.FILEPATH_FLAG eq mainKey }">
												<c:set var="imgPath" value="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" />
											</c:if>
											<c:if test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
												<c:set var="imgPath" value="${ent.STFL_PATH }" />
											</c:if>
										</c:if>
										<c:if test="${ empty(ent.ATFL_ID) }">
											<c:set var="imgPath" value="${contextPath }/resources/images/mall/goods/noimage_270.png" />
										</c:if>
										<c:if test="${  empty(ent.ATFL_ID) && !empty(ent.IMGURL) }">
											<c:set var="imgPath" value="${ent.IMGURL }" />
										</c:if>
									
										<a href="${contextPath }/m/product/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}" target="_self" title= "<c:out value=" ${ ent.PD_NAME }" escapeXml="true" />">
											<img src="${imgPath }" alt="<c:out value=" ${ ent.PD_NAME }" escapeXml="true"/>  상품이미지">
										</a>
									</div>
									
									
									<div class="con">
										<!-- 상품명 -->
										<div class="name">
											<a href="${contextPath }/m/product/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}" title="<c:out value=" ${ ent.PD_NAME }" escapeXml="true" />" target="_self">
												<c:out value="${ ent.PD_NAME }" escapeXml="true" />
											</a>
										</div>
										<!-- 상품가격 -->
										<div class="cost">
											<c:choose>
                                       			<c:when test="${empty ent.MEMBER_PRICE}">
                                       				<div class="value"><fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###" /><em>원</em></div>
                                       				<div class="price"></div>
                                       			</c:when>
                                       			<c:otherwise>
                                       				 <div class="value"><fmt:formatNumber value="${ ent.MEMBER_PRICE }" pattern="#,###" /><em>원</em></div>
                                       				 <div class="price"><fmt:formatNumber value="${ent.PD_PRICE }" pattern="#,###"/><em>원</em></div>
                                       			</c:otherwise>
                                     	 	</c:choose>
										</div>
										
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
					 
					<!--// End Changed listings-->
				</div>
				<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
					<First><Previous><AllPageLink><Next><Last>
				</paging:PageFooter>   
			</div>
			<!--Middle Part End-->
		</div>
	</div>
	<!-- //Main Container -->

</c:if>

<c:if test="${ empty(obj.list) }">

	<div class="container">
			<div class="location">
			<a href="${contextPath }/m">
				<span class="item">홈
				</span>
			</a>
			<c:forEach var="entPath" items="${ arrCagoNmPath }" varStatus="status">
				<span class="item"> 
					<span class="hp">></span>
					<a href="${contextPath }/m/product?CAGO_ID=${arrCagoIdPath[status.index]}&entcago=${entcagoInfo.ENTRY_ID}"> ${entPath } </a>
				</span>
			</c:forEach>
		</div>

		<div class="page-search">
			<div class="titbox">
				<div class="tit">
					<strong>찾고자 하는 검색어</strong> 검색결과 (0)
				</div>
			</div>
			<div class="cntbox">
				<div class="search">
					<div class="goods">
						<div class="goods-empty" id="test">
							<img src="${contextPath }/resources/resources2/images/icon_search_big.png" alt="">
							<span><strong>찾고자 하는 검색어</strong>에 대한 검색 결과가 없습니다.</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	</div>	
	<!-- //Main Container -->
</c:if>




<%-- 

<!-- 장바구니 담기 form -->
<form id="bkInstFrm" name="bkInstFrm" action="${contextPath }/goods/basketInst" method="post" autocomplete="off">
	<input type="hidden" id="PD_CODE" name="PD_CODE" value=""> 
	<input type="hidden" id="PD_NAME" name="PD_NAME" value="" />
	<input type="hidden" id="PD_QTY" name="PD_QTY" value="">	
</form>

<!-- Main Container  -->
<div class="main-container container">
	<ul class="breadcrumb">
		<li><a href="${contextPath }/m"><i class="fa fa-home"></i></a></li>
		<li><a href="${contextPath }/m/search" class=" ">검색하기</a></li>
	</ul>
	
	<div class="row">
		<!--Right Part Start -->
		<aside class="col-sm-4 col-md-3 content-aside" id="column-left">
			<div class="module">
				<h3 class="modtitle">상품검색 하기</h3>
				<div class="modcontent ">
					<form class="type_2">
					<input type="hidden" name="schTxt_bef" value="${ obj.schTxt_bef }" />
						<div class="table_layout filter-shopby">
							<div class="table_row">
								<!-- - - - - - - - - - - - - - Category filter - - - - - - - - - - - - - - - - -->
								<div class="table_cell" style="z-index: 103;">
									<legend>검색</legend>
									<select name="schGbn" id="schGbn" class="form-control">
										<option value="PD_NAME" ${obj.schGbn == 'PD_NAME' ? 'selected=selected':''}>상품명</option>
										<option value="PD_DINFO" ${obj.schGbn == 'PD_DINFO' ? 'selected=selected':''}>상품상세</option>
										<option value="MAKE_COM" ${obj.schGbn == 'MAKE_COM' ? 'selected=selected':''}>제조사</option>
									</select>&nbsp;
									<input value="${param.schTxt }" id="schTxt" name="schTxt" class="form-control" type="text" size="50" autocomplete="off" placeholder="검색어를 입력하세요">
									
								</div>
								<!-- - - - - - - - - - - - - - End of category filter - - - - - - - - - - - - - - - - -->
								<!-- - - - - - - - - - - - - - Category filter - - - - - - - - - - - - - - - - -->
								<div class="table_cell" style="z-index: 103;">
									<legend>결과내 재검색</legend>
									<input value="${param.reSearch }" id="reSearch" name="reSearch" class="form-control" type="text" size="50" autocomplete="off" placeholder="결과내 재검색">
									
								</div>
								<!-- - - - - - - - - - - - - - End of category filter - - - - - - - - - - - - - - - - -->
								<!-- - - - - - - - - - - - - - Price - - - - - - - - - - - - - - - - -->
								<div class="table_cell">
									<fieldset>
										<legend>가격</legend>
										<div class="range">
											범위 : <span class="min_val">₩${param.min_value}</span> - <span class="max_val">₩${param.max_value}</span> 
											<input type="hidden" name="min_value" class="min_value" value="${empty param.min_value ? '10': param.min_value}"> 
											<input type="hidden" name="max_value" class="max_value" value="${empty param.max_value ? '100000' : param.max_value}">
										</div>
										<div id="slider"
											class="ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all">
											<div class="ui-slider-range ui-widget-header ui-corner-all"></div>
											<span class="ui-slider-handle ui-state-default ui-corner-all"></span>
											<span class="ui-slider-handle ui-state-default ui-corner-all"></span>
										</div>
									</fieldset>
								</div>
								<!-- - - - - - - - - - - - - - End price - - - - - - - - - - - - - - - - -->
							</div>
							<!--/ .table_row -->
							<footer class="bottom_box">
								<div class="buttons_row">
									<button type="submit" class="button_grey button_submit">검색</button>
									<button type="reset" class="button_grey filter_reset">초기화</button>
								</div>
								<!--Back To Top-->
								<div class="back-to-top">
									<i class="fa fa-angle-up"></i>
								</div>
							</footer>
						</div>
						<!--/ .table_layout -->
					</form>
				</div>
			</div>
		</aside>

		<!--Middle Part Start-->
       	<div id="content" class="col-md-9 col-sm-8">
       		<div class="products-category">
				<h3 class="title-category ">검색 목록</h3>
       			<!-- Filters -->
				<div class="product-filter product-filter-top filters-panel">
					<div class="row">
					    <div class="col-md-5 col-sm-3 col-xs-12 view-mode">
							<div class="list-view">
								<button class="btn btn-default grid" data-view="grid" data-toggle="tooltip"  data-original-title="바둑판"><i class="fa fa-th"></i></button>
								<button class="btn btn-default list active" data-view="list" data-toggle="tooltip" data-original-title="리스트"><i class="fa fa-th-list"></i></button>
							</div>
						</div>
						
						<div class="short-by-show form-inline text-right col-md-7 col-sm-9 col-xs-12">
							<form id="frmOrd" method="GET" action="${contextPath }/m/search">
								<input name="CAGO_ID" id="CAGO_ID" type="hidden" value="${obj.CAGO_ID}" />
								<input name="sortGubun" id="sortGubun" type="hidden" value="${obj.sortGubun}" />
								<input name="sortOdr" id="sortOdr" type="hidden" value="${empty obj.sortOdr ? 'asc' : obj.sortOdr}" />
								<input type="hidden" name="schTxt" value="${param.schTxt }"/>
								<input type="hidden" name="schGbn" value="${param.schGbn }"/>
								
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
									<option value="16" ${obj.pagerMaxPageItems eq 16 ? 'selected=selected':''} >16</option>
									<option value="26" ${obj.pagerMaxPageItems eq 26 ? 'selected=selected':''}>26</option>
									<option value="50" ${obj.pagerMaxPageItems eq 50 ? 'selected=selected':''}>50</option>
									<option value="76" ${obj.pagerMaxPageItems eq 76 ? 'selected=selected':''}>76</option>
									<option value="100" ${obj.pagerMaxPageItems eq 100 ? 'selected=selected':''}>100</option>
                                   </select>
                               </div>                               
						</form>
					</div>
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
                                            <img src="${imgPath }" class="img-1 img-responsive goodsImg270" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/> 상품이미지">
                                            <img src="${imgPath }" class="img-2 img-responsive goodsImg270" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/> 상품이미지">
                                        </a>
                                    </div>
                                </div>
                                <div class="right-block">
                                    <div class="button-group so-quickview cartinfo--left">
										<c:if test="${ent.SALE_CON ne 'SALE_CON_02' }">
	                                        <button type="button" class="addToCart" title="Add to cart" onclick="cart.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}', '${ent.OPTION_CNT}');">
	                                            <span>장바구니 </span>   
											</button>
	                                        <button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}', '${ent.OPTION_CNT}');">
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
                                        <span class="price-dark"><fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###"/>원</span>
                                        <fmt:parseNumber var="pv" value="${ (ent.REAL_PRICE * PV) / 10 }" integerOnly="true" />
                                        <span class="price-new">| PV ${ pv * 10 }</span>
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
	                                        <button class="addToCart btn-button" type="button" title="Add to Cart" onclick="javascript:addCart('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}', '${ent.OPTION_CNT}');">
	                                        	<i class="fa fa-shopping-basket"></i>
	                                        </button>
	                                        <button class="wishlist btn-button" type="button" title="Add to Wish List" onclick="wishlist.add('${ ent.PD_CODE }', '${ ent.PD_NAME }', ${ent.PD_CUT_SEQ_CNT}, '${ent.OPTION_GUBN}', '${ent.OPTION_CNT}');">
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
        				<div class="product-layout col-lg-15 col-md-4 col-sm-6 col-xs-6">
                            <div class="product-item-container">
								<p class="sct_noitem">검색된 상품이 없습니다.</p>
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
 --%>