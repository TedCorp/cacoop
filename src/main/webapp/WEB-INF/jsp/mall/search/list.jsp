<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<style>
.goodsImg {
    width: auto; height: auto;
    max-width: 152px;
    max-height: 111px;
}
</style>

<script>
	$(function() {
		
		$('.goodsImg').each(function() {
			$(this).error(function(){
				$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
			});
		});
		
		$('.goodsImg').bind('click', function(){
			 alert($(this).exif('Orientation') );
		});
		
		$('.btnOrder').click(function(){

			var nChkCnt = $("input[name='chkOrder']:checkbox:checked").length;
			
			if (nChkCnt == 0){
				alert("주문하실 상품을 하나이상 선택하세요.");
				return false;
			}
			
			var strData = "";
			$("input[name='chkOrder']:checked").each(function() {

				if(strData != "") {
					strData +="$";
				}
				
				strData += $(this).val();
				
			});
			//alert(strData);
			$('#PD_CODE_LIST').val(strData);

			if(!confirm("선택을 완료하고 주문 신청 페이지로 이동하시겠습니까?")) {
				return false;
			}
			
			$("#orderFrm").submit();
		});
		
		$('.btnBasket').click(function(){
			location.href = "${contextPath}/request/basket"; 
		});


		$(".btnOrderView").click(function(){
			$('#divGuestForm').modal('show');
		});
		

		var bChk = true;
		$(".btnHelpDesk").click(function(){
/* 			var page = "${contextPath}/common/helpDesk";
			
			if(bChk){
				$('#ifrmHelpDeskLoad').attr('src', page);

			    $('#ifrmHelpDeskLoad').load(function () {
					$('#divHelpDesk').modal('show');
					
					bChk = false;
			    });
			}else{
				$('#divHelpDesk').modal('show');
			} */
			
			$('#divHelpDesk').modal('show');
		    
		});


//팝업 주석
//		if ( getCookie( "mainPopupIdNotice1" ) != "done" ){
//			$('#layerPopNotice1').modal('show');
//		}
		
		$(document).on('click', '#btnPopupWinodwChk', function(){
			var strPopupId = $(this).attr("popupId");
			$("#layerPop"+strPopupId).hide();
			
			 setCookie( "mainPopupId"+strPopupId, "done" , 1);
				$('#layerPop'+strPopupId).modal('hide');
		});

		
	/* 	//주문하기
		function fn_buy(){
	 
		 	var cnt = 0;
		
			var pd_code_list = "";
			for(var i=1;i<= ${fn:length(obj.list) };i++){
				if($("#CHK"+i).is(":checked")){
					cnt++;
					if(pd_code_list != "") {
						pd_code_list+="$";
					}
					pd_code_list+=$("#CHK"+i).val();
				}
			}
			if(cnt == 0){
				alert("체크한 항목이 없습니다.");
				return;
			}
			
			if(!confirm("주문 하시겠습니까?")){
				return;
			}
			
			var frm=document.getElementById("buyFrm");
			frm.PD_CODE.value=pd_code_list;
			frm.action = "${contextPath }/order/buy";
			frm.submit();
		}
 */
		
	});

function fn_paing_search(){
	alert(document.searchPaging.getAttribute('action'));
	document.searchPaging.submit()
}
</script>

<c:set var="arrCagoIdPath" value="${fn:split(rtnCagoInfo.CAGO_ID_PATH, '>') }" /> 
<c:set var="arrCagoNmPath" value="${fn:split(rtnCagoInfo.CAGO_NM_PATH, '>') }" /> 

<!--질문검색-->
<div class="mt_15 mb_30">

	<!-- Tab panes -->
	<div class="tab-content pd_n">
		<div  class="tab-pane active" id="1">
			<div class="fqa-box">
				<div class="col-sm-2 ta_c">
					<img src="${contextPath }/resources/img/sub/search_icon.png">
				</div>
				<div class="col-sm-10 fqa-search">
					<form class="form-inline">
						<div class="form-group">
							<input type="hidden" name="schTxt_bef" value="${ obj.schTxt_bef }" />
							<select name="schGbn" class="form-control">
								<option value="PD_NAME" ${obj.schGbn == 'PD_NAME' ? 'selected=selected':''}>상품명</option>
								<option value="PD_DINFO" ${obj.schGbn == 'PD_DINFO' ? 'selected=selected':''}>상품상세</option>
								<option value="MAKE_COM" ${obj.schGbn == 'MAKE_COM' ? 'selected=selected':''}>제조사</option>
							</select> 
							<input type="text" class="form-control" name="schTxt" id="search" style="width: 270px;" placeholder="입력하세요" value="${param.schTxt }" onclick="javascript:cleanResearch()"/>
							<button class="btn btn-xs btn-black">검색</button>
						</div>
						<div>
						<!-- <input type="checkbox" name="reSearchChk"><span class="sm_ft mt_5 gray">결과 내 재검색</span> -->
							<div class="col-sm-2 ta_c"></div>
							<input type = "text" class="form-control"  name="reSearch" id="reSearch" style="width: 270px;margin-top: 3px" placeholder="결과내 재검색" value="${param.reSearch }">
						</div>
					</form>
					<p class="sm_ft mt_5 gray">원하시는 상품에 맞는 조건을 입력 후 검색하세요.</p>
					<img src="${contextPath }/resources/img/sub/sub05/faq_img.png" class="pos_a fqa-img">
				</div>
			</div>
		</div>
	</div> 

</div>

<c:if test="${ !empty rtnCagoList }">
<div class="submenu-box">
	<div class="panel panel-submenu">
		<div class="panel-heading">
			<p><a href="${contextPath }/product?CAGO_ID=${arrCagoIdPath[0] }">${arrCagoNmPath[fn:length(arrCagoNmPath)-1] }</a></p>
		</div>
		<div class="panel-body">
			<ul class="submenu-list">
				<c:forEach var="ent" items="${ rtnCagoList }" varStatus="status">
					<li><a href="${contextPath }/product?CAGO_ID=${ ent.CAGO_ID }"><c:out value="${ ent.CAGO_NAME }" escapeXml="true"/> (${ ent.PRD_CNT })</a></li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>
</c:if>
<div>
		<div class="panel panel-default panel-search">
			<div class="panel-body pos_r">
				<h5 class="search-title eng mg_n fl_l">
					<span class="green">상품</span>
				</h5>
				<p class="gray sm_ft fl_l ml_5">검색 목록</p>
				<form method="GET" name="searchPaging" action="${contextPath }/search">
				<span class="pos_a" style="right:20px; top:8px">
					<a href="?CAGO_ID=${obj.CAGO_ID}&amp;schTxt=${param.schTxt }&amp;schGbn=${param.schGbn }&amp;sortGubun=PD_NAME&amp;sortOdr=asc&amp;pagerMaxPageItems=${obj.pagerMaxPageItems}" class="btn btn-order" >상품명순</a>
					<a href="?CAGO_ID=${obj.CAGO_ID}&amp;schTxt=${param.schTxt }&amp;schGbn=${param.schGbn }&amp;sortGubun=CAGO_SORT&amp;sortOdr=asc&amp;pagerMaxPageItems=${obj.pagerMaxPageItems}" class="btn btn-order" >상품분류순</a>
					<a href="?CAGO_ID=${obj.CAGO_ID}&amp;schTxt=${param.schTxt }&amp;schGbn=${param.schGbn }&amp;sortGubun=PD_PRICE&amp;sortOdr=asc&amp;pagerMaxPageItems=${obj.pagerMaxPageItems}" class="btn btn-order" >낮은가격순</a>
					<a href="?CAGO_ID=${obj.CAGO_ID}&amp;schTxt=${param.schTxt }&amp;schGbn=${param.schGbn }&amp;sortGubun=PD_PRICE&amp;sortOdr=desc&amp;pagerMaxPageItems=${obj.pagerMaxPageItems}" class="btn btn-order" >높은가격순</a>
					<select name="pagerMaxPageItems" onchange="this.form.submit()">
						<option value="16" ${obj.pagerMaxPageItems== 16 ? 'selected=selected':''} >16</option>
						<option value="50" ${obj.pagerMaxPageItems == 50 ? 'selected=selected':''}>50</option>
						<option value="100" ${obj.pagerMaxPageItems == 100 ? 'selected=selected':''}>100</option>
					</select>
					<input type="hidden" name="schTxt" value="${param.schTxt }"/>
					<input type="hidden" name="schGbn" value="${param.schGbn }"/>
				</span>
				</form>
			</div>
		</div>
</div>

<!--제품리스트-->
<div class="product-box">
	<ul class="product-box-list">
		<c:if test="${ !empty(obj.list) }">
			<c:forEach var="ent" items="${ obj.list }" varStatus="status">
				<li>
					<a href="./product/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}">
					
						<div class="img-thumbnail text-center" style="width:161px; height:120px;">
							<div style="position: absolute; width:161px; height:120px;">							
								<c:if test="${ !empty(ent.ATFL_ID) }">
									<c:if test="${ent.FILEPATH_FLAG eq mainKey }">
										<img class="goodsImg" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
									</c:if>
									<c:if test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
										<img class="goodsImg" src="${ent.STFL_PATH }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
									</c:if>
									<c:if test="${ empty(ent.FILEPATH_FLAG) }">
										<img class="goodsImg" src="https://www.cjfls.co.kr/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
									</c:if>	
								</c:if>
								<c:if test="${ empty(ent.ATFL_ID) }">
									<img class="goodsImg" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
								</c:if>
							</div>
							<%-- <c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
								<img src="${contextPath }/resources/images/mall/goods/soldout.png" class="goodsImg" width="161px" height="120px" style="position: relative;" />
							</c:if> --%>
						</div>						
						
						<div class="prod_info">
							<p class="title">
								${ent.PDDC_GUBN=='PDDC_GUBN_02' ?'<small class="label label-danger">행사</small>':'' }&nbsp;
								<c:out value="${ ent.PD_NAME }" escapeXml="true"/>
							</p>
							<p class="price">
								<img src="${contextPath }/resources/img/sub/sub02/price.png">
								<c:if test="${ ent.REAL_PRICE ne ent.PD_PRICE }">
									<strike><fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###"/>원</strike>
								</c:if>
								<fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###"/>원
							</p>
							<p class="point">
								제조사(브랜드):<c:out value="${ ent.MAKE_COM }" escapeXml="true"/>
							</p>
						    <!-- <button class="btn btn-buy">구매하기</button> -->
						</div>						
					</a>
					
					<!-- 세절 방식, 색상 옵션 존재 여부에 따른 버튼 활성화 -->
					<c:choose>					
						<c:when test="${ent.PD_CUT_SEQ_CNT > 0}">
							<a href="void(0);" onclick="alert('세절방식을 선택해야하는 상품입니다.\n상품상세페이지에서 세절방식을 선택 후 장바구니에 담아주세요.');return false;" class="btn btn-buy" style="margin-left:50px;">구매하기</a>
						</c:when>						
						<c:when test="${!empty ent.OPTION_GUBN}">
							<a href="void(0);" onclick="alert('색상을 선택해야하는 상품입니다.\n상품상세페이지에서 색상을 선택 후 장바구니에 담아주세요.');return false;" class="btn btn-buy" style="margin-left:50px;">구매하기</a>
						</c:when>						
						<c:otherwise>
							<a href="${contextPath}/order/buy?PD_CODE=${ent.PD_CODE}" class="btn btn-buy" style="margin-left:50px;">구매하기</a>
						</c:otherwise>						
					</c:choose>
										
					<%-- 
					 <c:if test="${ent.PD_CUT_SEQ_CNT > 0}">
						<a href="void(0);" onclick="alert('세절방식을 선택해야하는 상품입니다.\n상품상세페이지에서 옵션을 선택 후 장바구니에 담아주세요.');return false;" class="btn btn-buy" style="margin-left:50px;">구매하기</a>
					</c:if>					
					<c:if test="${!empty ent.OPTION_GUBN}">
						<a href="void(0);" onclick="alert('색상을 골라야 됩니다.');return false;" class="btn btn-buy" style="margin-left:50px;">구매하기</a>
					</c:if>					
					<c:if test="${ent.PD_CUT_SEQ_CNT <= 0}">
						<a href="${contextPath}/order/buy?PD_CODE=${ent.PD_CODE}" class="btn btn-buy" style="margin-left:50px;">구매하기</a>
					</c:if> --%>	
					
				</li>
			</c:forEach>
		</c:if>
		<c:if test="${ empty(obj.list) }">
			<li><p class="sct_noitem">등록된 상품이 없습니다.</p></li>
		</c:if>
	</ul>
	<div class="clearfix"></div>
</div>

<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
	<First><Previous><AllPageLink><Next><Last>
</paging:PageFooter>
