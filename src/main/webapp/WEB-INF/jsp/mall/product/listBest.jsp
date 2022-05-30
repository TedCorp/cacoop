<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

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
	

</script>

<div class="sub-title sub-title-underline">
	<h2>
		이달의 특가상품 목록 <small class="ml_5">| 이달의 특가 행사 상폼을 표시합니다.</small>
	</h2>
	<ul>
		<li><a href='${contextPath }/' class="sct_bg">Home</a></li>
		<li><a href="${contextPath }/product/bestList" class=" ">이달의 특가상품 상품</a></li>
	</ul>
	<div class="clearfix"></div>
</div>

<!--제품리스트-->
<div class="product-box">
	<ul class="product-box-list">
		<c:if test="${ !empty(obj.list) }">
			<c:forEach var="ent" items="${ obj.list }" varStatus="status">
				<li>
					<a href="./product/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}">
						<div class="img-thumbnail text-center" style="width:161px; height:120px;">
						<c:if test="${ !empty(ent.ATFL_ID) }">
							<img class="goodsImg" src="${contextPath }/common/commonFileDown?IMG_GUBUN=thumbnail&ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
						</c:if>
						<c:if test="${ empty(ent.ATFL_ID) }">
							<img class="goodsImg" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
						</c:if>
						</div>
						<div class="prod_info">
							<p class="title"><c:out value="${ ent.PD_NAME }" escapeXml="true"/></p>
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
					 <a href="${contextPath}/order/buy?PD_CODE=${ent.PD_CODE}" class="btn btn-buy" style="margin-left:50px;">구매하기</a> 
				</li>
			</c:forEach>
		</c:if>
		<c:if test="${ empty(obj.list) }">
			<li><p class="sct_noitem">등록된 상품이 없습니다.</p></li>
		</c:if>
	</ul>
	<div class="clearfix"></div>
</div>

