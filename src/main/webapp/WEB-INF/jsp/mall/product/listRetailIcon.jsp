<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<style>
.goodsImg {
    width: auto; height: auto;
    max-width: 152px;
    max-height: 111px;
}
.thumbnail-wrappper { 
	width: 13%;	 
	float: left;
	margin-left: 2%;
    margin-bottom: 20px;
    border: 0px solid #ccc;
    -webkit-box-shadow: 0 0 5px 1px #A1A1A1;
    
}
.contact img {
	 max-width: 100%;
	 height: auto; 
	 width : 227px;
	 height: 100px;
}
.contact button {
	 max-width:100%;
	 height: auto; 
	 width : 227px;
	 height: 100px;
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
			$('#divHelpDesk').modal('show');
		    
		});


		
		$(document).on('click', '#btnPopupWinodwChk', function(){
			var strPopupId = $(this).attr("popupId");
			$("#layerPop"+strPopupId).hide();
			
			 setCookie( "mainPopupId"+strPopupId, "done" , 1);
				$('#layerPop'+strPopupId).modal('hide');
		});

		
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
		Retail카테고리목록 <small class="ml_5">| 엄선된 상품만을 제공합니다.</small>
	</h2>
</div>
<div class="contact">
       	<ul>
       		<c:forEach var="i" begin="1" end="30" step="1">
       		<li class="thumbnail-wrappper">
       			<button onclick="location.href='${contextPath}/product/retailList?RETAIL_GUBN=RETAIL_GUBN_${i <10 ? '00' : '0'}${i}'">
       				<img src="http://www.cjfls.co.kr/resources/img/retail/icon/${i <10 ? '00' : '0'}${i}.png" 
       					onmouseover="this.style.opacity='0.5'" onmouseout="this.style.opacity='1'">
       			</button>
       		</li>
       		</c:forEach>
       	</ul>
</div>
      