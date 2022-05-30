<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<style>
.goodsImg {
    width: auto; height: auto;
    max-width: 152px;
    max-height: 111px;
}
.addImg {
    width: auto; height: auto;
    max-width: 152px;
    max-height: 220px;
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
			/* 			
 			var page = "${contextPath}/common/helpDesk";			
			if(bChk){
				$('#ifrmHelpDeskLoad').attr('src', page);
			    $('#ifrmHelpDeskLoad').load(function () {
					$('#divHelpDesk').modal('show');					
					bChk = false;
			    });
			}else{
				$('#divHelpDesk').modal('show');
			} 
			*/			
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
		
	/* 	
		//주문하기
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
</script>

<c:set var="arrCagoIdPath" value="${fn:split(rtnCagoInfo.CAGO_ID_PATH, '>') }" /> 
<c:set var="arrCagoNmPath" value="${fn:split(rtnCagoInfo.CAGO_NM_PATH, '>') }" /> 

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
<div class="sub-title sub-title-underline">
	<h2>
		가정용 추천상품 목록 <small class="ml_5">| 엄선된 상품만을 제공합니다.</small>
	</h2>
	<ul>
		<li><a href='${contextPath }/' class="sct_bg">Home</a></li>
		<%-- <c:forEach var="entPath" items="${ arrCagoNmPath }" varStatus="status">
			<li><a href="${contextPath }/product?CAGO_ID=${arrCagoIdPath[status.index] }" class=" ">${entPath }</a></li>
		</c:forEach> --%>
	</ul>
	<div class="clearfix"></div>
</div>

<!--제품리스트-->
<div class="product-box">
	<ul class="product-box-list">
		<c:if test="${ !empty(obj.list) }">
			<c:forEach var="ent" items="${ obj.list }" varStatus="status">
				<li>
					<a href="./view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}">					
						<div class="img-thumbnail text-center" style="width:161px; height:120px;">
							<c:if test="${ !empty(ent.ATFL_ID) }">
								<%-- <img class="goodsImg" src="${contextPath }/common/commonFileDown?IMG_GUBUN=thumbnail&ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/> --%>
								<img class="goodsImg" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
							</c:if>
							<c:if test="${ empty(ent.ATFL_ID) }">
								<img class="goodsImg" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
							</c:if>							
							<%-- 
							<div style="position: absolute; width:161px; height:120px;">
								<c:if test="${ !empty(ent.ATFL_ID) }">
									<img class="goodsImg" src="${contextPath }/common/commonFileDown?IMG_GUBUN=thumbnail&ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
									<img class="goodsImg" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
								</c:if>
								<c:if test="${ empty(ent.ATFL_ID) }">
									<img class="goodsImg" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
								</c:if>
							</div>
							<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
								<img src="${contextPath }/resources/images/mall/goods/soldout.png" class="goodsImg" width="161px" height="120px" style="position: relative;" />
							</c:if>
							</div> 
							--%>
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
						</div>						
					</a>
					<c:if test="${ent.PD_CUT_SEQ_CNT > 0}">
						<a href="void(0);" onclick="alert('옵션을 선택해야하는 상품입니다.\n상품상세페이지에서 옵션을 선택 후 장바구니에 담아주세요.');return false;" class="btn btn-buy" style="margin-left:50px;">구매하기</a>
					</c:if>
					<c:if test="${ent.PD_CUT_SEQ_CNT <= 0}">
						<a href="${contextPath}/order/buy?PD_CODE=${ent.PD_CODE}" class="btn btn-buy" style="margin-left:50px;">구매하기</a>
					</c:if>					   
				</li>
			</c:forEach>
			<!-- 더보기 -->
				<li>
					<a href="./retailRcmd">					
						<div class="img-thumbnail text-center" style="width:161px; height:227px;">
							<div style="position: absolute; width:161px; height:227px;">								
								<img class="addImg" src="${contextPath }/resources/images/mall/goods/retailadd_btn2.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>								
							</div>
						</div>				
					</a>			   
				</li>
		</c:if>
		<c:if test="${ empty(obj.list) }">
			<!-- <li><p class="sct_noitem">등록된 상품이 없습니다.</p></li> -->
			<li>
				<a href="./retailRcmd">					
					<div class="img-thumbnail text-center" style="width:161px; height:227px;">
						<div style="position: absolute; width:161px; height:227px;">								
							<img class="addImg" src="${contextPath }/resources/images/mall/goods/retailadd_btn2.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>								
						</div>
					</div>				
				</a>			   
			</li>
		</c:if>
	</ul>
	<div class="clearfix"></div>
</div>
<%-- 
<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
	<First><Previous><AllPageLink><Next><Last>
</paging:PageFooter>
 --%>
