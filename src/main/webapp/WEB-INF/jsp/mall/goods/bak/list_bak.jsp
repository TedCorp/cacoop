<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<!-- style>
.goodsImg {
    width: auto; height: auto;
    max-width: 227px;
    max-height: 228px;
}
</style -->

<script>
	$(function() {
		//$(".goodsImg").load(function(){
		//	fnLoadComplete($(this));
		//});
		 
		$('.goodsImg').each(function() {
				$(this).hide();
			
				$(this).error(function(){
					$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
				});
		});
		
		$('.goodsImg').load(function(){
		
		    var maxWidth = 226; // Max width for the image
		    var maxHeight = 227;    // Max height for the image
		    var ratio = 0;  // Used for aspect ratio
		    var width = $(this).width();    // Current image width
		    var height = $(this).height();  // Current image height

		    // Check if the current width is larger than the max
		    if(width > maxWidth){
		        ratio = maxWidth / width;   // get ratio for scaling image
		        $(this).css("width", maxWidth); // Set new width
		        $(this).css("height", height * ratio);  // Scale height based on ratio
		        height = height * ratio;    // Reset height to match scaled image
		    }

		    var width = $(this).width();    // Current image width
		    var height = $(this).height();  // Current image height

		    // Check if current height is larger than max
		    if(height > maxHeight){
		        ratio = maxHeight / height; // get ratio for scaling image
		        $(this).css("height", maxHeight);   // Set new height
		        $(this).css("width", width * ratio);    // Scale width based on ratio
		        width = width * ratio;    // Reset width to match scaled image
		    }
		    
		    var width = $(this).width();    // Current image width
		    var height = $(this).height();  // Current image height
		    
		    var top = 0;
		    if(height < maxHeight){
		    	top = (maxHeight - height)/2; // get ratio for scaling image
		        $(this).css("margin-top", top);   	// Set top
		    }
		    
		    $(this).show();
			
		});
		var nPageNum = 1;
		function fnMoreView(){
		    /* 더보기 */
		    
		    var target = $('#pageNum').val();
		    var paramData = { pageNum : nPageNum, CAGO_ID : "${obj.CAGO_ID}"};
		    
		    $.ajax({
		        type : "GET",
		        url : "${contextPath}/goods.json",
		        data : paramData,
		        success : function(data, textStatus, jqXHR) {
		            fnAjaxSuccess(data, textStatus, jqXHR);
		        },
		        error : fnAjaxError
		    });
		    
		    nPageNum = nPageNum+1;
		}
	});
	
	function fnLoadComplete(objImg){
		//objImg.hide();
	    var maxWidth = 226; // Max width for the image
	    var maxHeight = 227;    // Max height for the image
	    var ratio = 0;  // Used for aspect ratio
	    var width = objImg.width();    // Current image width
	    var height = objImg.height();  // Current image height

	    // Check if the current width is larger than the max
	    if(width > maxWidth){
	        ratio = maxWidth / width;   // get ratio for scaling image
	        objImg.css("width", maxWidth); // Set new width
	        objImg.css("height", height * ratio);  // Scale height based on ratio
	        height = height * ratio;    // Reset height to match scaled image
	    }

	    var width = objImg.width();    // Current image width
	    var height = objImg.height();  // Current image height

	    // Check if current height is larger than max
	    if(height > maxHeight){
	        ratio = maxHeight / height; // get ratio for scaling image
	        objImg.css("height", maxHeight);   // Set new height
	        objImg.css("width", width * ratio);    // Scale width based on ratio
	        width = width * ratio;    // Reset width to match scaled image
	    }
	    
	    var width = objImg.width();    // Current image width
	    var height = objImg.height();  // Current image height
	    
	    var top = 0;
	    if(height < maxHeight){
	    	top = (maxHeight - height)/2; // get ratio for scaling image
	        objImg.css("margin-top", top);   	// Set top
	    }
	    
	    objImg.show();
	}
</script>
<div id="wrapper_title">${resultCate[0].ctgryNm } 상품리스트 </div><!-- 글자크기 조정 display:none 되어 있음 시작 { -->

<!-- 상품 목록 시작 { -->
<div id="sct">
	<c:set var="arrCagoIdPath" value="${fn:split(rtnCagoInfo.CAGO_ID_PATH, '>') }" /> 
	<c:set var="arrCagoNmPath" value="${fn:split(rtnCagoInfo.CAGO_NM_PATH, '>') }" /> 

	<div id="sct_location">
		<a href='${contextPath }/goods' class="sct_bg">Home</a>
		<c:forEach var="entPath" items="${ arrCagoNmPath }" varStatus="status">
			<a href="${contextPath }/goods?CAGO_ID=${arrCagoIdPath[status.index] }" class="${ fn:length(arrCagoNmPath) eq status.count ? 'sct_here' : 'sct_bg' } ">${entPath }</a>
		</c:forEach>
	</div>
	<div id="sct_hhtml"></div>

	<c:if test="${ fn:length(rtnCagoList) > 1}">
	<!-- 상품분류 1 시작 { -->
	<aside id="sct_ct_1" class="sct_ct">
		<h2>현재 상품 분류와 관련된 분류</h2>
		<ul>
			<c:forEach var="ent" items="${ rtnCagoList }" varStatus="status">
				<li><a href="${contextPath }/goods?CAGO_ID=${ ent.CAGO_ID }"><c:out value="${ ent.CAGO_NAME }" escapeXml="true"/> (${ ent.PRD_CNT })</a></li>
			</c:forEach>
		</ul>
	</aside>
	<!-- } 상품분류 1 끝 -->
	</c:if>
	<div style="padding:0 0 40px 0;">
		<button type="button" class="btn btn-sm btn-success pull-right">상품신청 하기</button>	
	</div>

	<div id="sct_sortlst">
	<!-- 상품 정렬 선택 시작 { -->
	<section id="sct_sort">
	    <h2>상품 정렬</h2>
	    <ul id="ssch_sort">
	        <li><a href="#?ca_id=10&amp;sort=it_sum_qty&amp;sortodr=desc" class="btn01">판매많은순</a></li>
	        <li><a href="#?ca_id=10&amp;sort=it_sum_qty&amp;sortodr=desc" class="btn01">판매많은순</a></li>
	        <li><a href="#?ca_id=10&amp;sort=it_price&amp;sortodr=asc" class="btn01">낮은가격순</a></li>
	        <li><a href="#?ca_id=10&amp;sort=it_price&amp;sortodr=desc" class="btn01">높은가격순</a></li>
	        <li><a href="#?ca_id=10&amp;sort=it_use_avg&amp;sortodr=desc" class="btn01">평점높은순</a></li>
	        <li><a href="#?ca_id=10&amp;sort=it_use_cnt&amp;sortodr=desc" class="btn01">후기많은순</a></li>
	        <li><a href="#?ca_id=10&amp;sort=it_update_time&amp;sortodr=desc" class="btn01">최근등록순</a></li>
	    </ul>
	</section>
	<!-- } 상품 정렬 선택 끝 --></div>
	<!-- 상품진열 10 시작 { -->
	<ul id="ulPdtList" class="sct sct_list_10">
		<c:if test="${ !empty(obj.list) }">
			<c:forEach var="ent" items="${ obj.list }" varStatus="status">
				<c:set var="strClass" value="" />
				<c:if test="${status.count%4 eq 1 }"><c:set var="strClass" value="sct_clear" /></c:if>
				<c:if test="${status.count%4 eq 0 }"><c:set var="strClass" value="sct_last" /></c:if>
				<li class="sct_li ${strClass} }" style="width:230px">
					<div class="sct_img">
						<a href="./goods/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}" class="sct_a">
						<c:if test="${ !empty(ent.ATFL_ID) }">
							<img class="goodsImg" src="${contextPath }/common/commonFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
						</c:if>
						<c:if test="${ empty(ent.ATFL_ID) }">
							<img class="goodsImg" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
						</c:if>
						</a>
					</div>
					<div class="sct_txt">
						<a href="${contextPath }/goods/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}" class="sct_a"><c:out value="${ ent.PD_NAME }" escapeXml="true"/></a>
					</div>
					<div class="sct_basic">제조사:<c:out value="${ ent.MAKE_COM }" escapeXml="true"/></div>
					<div class="sct_cost">
						<c:if test="${ ent.PDDC_GUBN ne 'PDDC_GUBN_01' }">
							<c:set var="nDiscount" value="0" />
							<c:if test="${ ent.PDDC_GUBN eq 'PDDC_GUBN_02' }">
								<c:set var="nDiscount" value="${ent.PDDC_VAL }" />
							</c:if>
							<c:if test="${ ent.PDDC_GUBN eq 'PDDC_GUBN_03' }">
								<c:set var="nDiscount" value="${ ent.PD_PRICE* ent.PDDC_VAL/100 }" />
							</c:if>
							<strike><fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###"/>원</strike>
							<fmt:formatNumber value="${ ent.PD_PRICE - nDiscount }" pattern="#,###"/>원
						</c:if>
						<c:if test="${ ent.PDDC_GUBN eq 'PDDC_GUBN_01' }">
							<fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###"/>원
						</c:if>
					</div>
				</li>
				
			</c:forEach>
		</c:if>
		
		<c:if test="${ empty(obj.list) }">
			<p class="sct_noitem">등록된 상품이 없습니다.</p>
		</c:if>


	</ul>
	<!-- } 상품진열 10 끝 -->

	<%/*  주석 처리 #################################################################################################################################################  %>
	<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
		<First><Previous><AllPageLink><Next><Last>
	</paging:PageFooter>
	<% 주석 처리 ################################################################################################################################################# */ %>
	
	<div>
		<button type="button" class="btn btn-sm btn-success pull-right">상품신청 하기</button>	
	</div>


</div>
<!-- } 상품 목록 끝 -->