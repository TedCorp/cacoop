<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>:::: 식자재몰 - 믿고사는 식자재 ::::</title>

	<link rel="stylesheet" href="${contextPath}/resources/css/mall/default_shop.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/mall/style.css">
	
	<!-- BootStrap 3.3.6 -->		
	<link rel="stylesheet" href="${contextPath }/resources/bootstrap/css/bootstrap.min.css">

	<!-- jQuery 2.1.1 -->
	<script type="text/javascript" src="${contextPath }/resources/js/jquery-2.2.1.min.js"></script>
	<!-- BootStrap 3.3.6 -->
	<script type="text/javascript" src="${contextPath }/resources/bootstrap/js/bootstrap.min.js"></script>
	
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<!-- jQuery FlexSlider v2.6.1 -->
	<script src="${contextPath}/resources/js/jquery.flexslider-min.js"></script>
	
	<script src="${contextPath}/resources/js/slick.js"></script>
	
	<!-- 다음 우편번호 -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	<!-- jquery-validation-1.15 -->
	<script type="text/javascript" src="${contextPath }/resources/adminlte/plugins/validation/jquery.validate.min.js"></script>
	<!-- jquery-number-2.1.5 -->
	<script type="text/javascript" src="${contextPath }/resources/adminlte/plugins/number/jquery.number.min.js"></script>
	<!-- jQuery Cookie Plugin v1.4.1 -->
	<script type="text/javascript" src="${contextPath }/resources/adminlte/plugins/cookie/jquery.cookie.js"></script>
		
	<script language="javascript">
	<!--
		var contextPath = "<%= request.getContextPath() %>";
	//-->
	</script>
</head>

<body>
	<div id="wrapper">
	    <!-- 콘텐츠 시작 { -->
	    <div id="container">
	    
<style>

#wrapper {margin:20px auto;width:1120px;zoom:1;position:relative;padding:10px;}

.goodsImg {
    width: auto; height: auto;
    max-width: 100px;
    max-height: 100px;
}


</style>

<script>
	$(function() {

		$('.goodsImg').each(function() {
				//$(this).hide();
			
				$(this).error(function(){
					$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
				});
		});
		
		$('.goodsImg').load(function(){
		
		    var maxWidth = 100; // Max width for the image
		    var maxHeight = 100;    // Max height for the image

		    var width = $(this).width();    // Current image width
		    var height = $(this).height();  // Current image height
		    
		    var top = 0;
		    if(height < maxHeight){
		    	top = (maxHeight - height)/2; // get ratio for scaling image
		        $(this).css("margin-top", top);   	// Set top
		    }
		    
		    $(this).show();
			
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
	
<!-- 1->700*455     2-768*393-->
<!-- Modal -->
<div class="modal fade" id="layerPopNotice1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">공지사항</h4>
			</div>
			<div class="modal-body">
				
				<a href="#"><img src="${contextPath }/resources/images/main/notice1.png" alt="팝업" width="100%"/></a>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="btnPopupWinodwChk" popupId="Notice1">1일 동안 열지 않기</button>
			</div>
		</div>
	</div>
</div>

	
<div id="wrapper_title">상품리스트</div><!-- 글자크기 조정 display:none 되어 있음 시작 { -->

<form id="orderFrm" name="orderFrm" action="${contextPath }/request/buy" method="post" autocomplete="off">
	<input type="hidden" name="PD_CODE_LIST" id="PD_CODE_LIST" value="">
	<input type="hidden" name="inputGRVal" id="inputGRVal" value="">
</form>

<!-- 상품 목록 시작 { -->
<div id="sct">
	<c:set var="arrCagoIdPath" value="${fn:split(rtnCagoInfo.CAGO_ID_PATH, '>') }" /> 
	<c:set var="arrCagoNmPath" value="${fn:split(rtnCagoInfo.CAGO_NM_PATH, '>') }" /> 

	<div id="sct_hhtml"></div>
	<c:if test="${ fn:length(rtnCagoList) > 1}">
	<!-- 상품분류 1 시작 { -->
	<aside id="sct_ct_1" class="sct_ct">
		<h2>현재 상품 분류와 관련된 분류</h2>
		<ul>
			<li><a href="${contextPath }/goods?CAGO_ID=170000000" id="aTotal">행사상품 전체</a></li>
			<c:set var="totCnt" value="0" />
			<c:forEach var="ent" items="${ rtnCagoList }" varStatus="status">
				<li><a href="${contextPath }/goods?CAGO_NAME=${ ent.CAGO_NAME }"><c:out value="${ ent.CAGO_NAME }" escapeXml="true"/> (${ ent.CNT })</a></li>
				<c:set var="totCnt" value="${ totCnt + ent.PRD_CNT }" />
			</c:forEach>
		</ul>
	</aside>
	<!-- } 상품분류 1 끝 -->
	</c:if>

	<!-- 상품진열 10 시작 { -->
	<ul id="ulPdtList" class="ad_list">
		<c:if test="${ !empty(rtnProdList) }">
			
			<c:forEach var="entCago" items="${ rtnCagoList }" varStatus="status">
			<ul>
				<div class="title">${ entCago.CAGO_NAME}</div>
				<c:set var="pdCnt" value="0" />
				<c:forEach var="ent" items="${ rtnProdList }" varStatus="status">
					<c:if test="${ entCago.CAGO_NAME eq ent.CAGO_NAME }">
						<c:set var="strClass" value="" />
						<c:set var="pdCnt" value="${pdCnt +1 }" />
						<c:if test="${pdCnt%8 eq 1 }"><c:set var="strClass" value="sct_clear" /></c:if>
						<c:if test="${pdCnt%8 eq 0 }"><c:set var="strClass" value="sct_last" /></c:if>
						
						<li class="sct_li ${strClass} ${pdCnt}">
							<div class="sct_img">
								<c:if test="${ !empty(ent.ATFL_NAME) }">
									<img class="goodsImg" src="${contextPath }/upload/jundan/${ent.AD_ID }/${ent.ATFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
								</c:if>
								<c:if test="${ empty(ent.ATFL_NAME) }">
									<img class="goodsImg" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
								</c:if>
							</div>
							<div class="sct_txt">
								<!-- label style="color:red">[품절] 선택 불가</label><br -->
								<c:out value="${ ent.PD_NAME }" escapeXml="true"/>
							</div>
							<div class="sct_desc"><c:out value="${ ent.PD_DESC }" escapeXml="true"/></div>
							<div class="sct_cost">
								<c:if test="${ ent.PD_PRICE ne 0  && ent.PD_PRICE ne ent.SELL_PRICE }">
									<strike><fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###"/>원</strike>
								</c:if>
								<fmt:formatNumber value="${ ent.SELL_PRICE }" pattern="#,###"/>원
							</div>
						</li>
					</c:if>	
				</c:forEach>
			</ul>
			
			</c:forEach>
		</c:if>
		
		<c:if test="${ empty(rtnProdList) }">
			<p class="sct_noitem">등록된 상품이 없습니다.</p>
		</c:if>


	</ul>
	<!-- } 상품진열 10 끝 -->
<!-- } 상품 목록 끝 -->



		<c:if test="${ !empty(rtnProdList) }">
			
			<c:forEach var="entCago" items="${ rtnCagoList }" varStatus="status">
				<div class="panel panel-default">
					<div class="panel-heading">${ entCago.CAGO_NAME}</div>
					<div class="panel-body">
						<ul id="ulPdtList" class="ad_list">
						<c:set var="pdCnt" value="0" />
						<c:forEach var="ent" items="${ rtnProdList }" varStatus="status">
							<c:if test="${ entCago.CAGO_NAME eq ent.CAGO_NAME }">
								<c:set var="strClass" value="" />
								<c:set var="pdCnt" value="${pdCnt +1 }" />
								<c:if test="${pdCnt%8 eq 1 }"><c:set var="strClass" value="sct_clear" /></c:if>
								<c:if test="${pdCnt%8 eq 0 }"><c:set var="strClass" value="sct_last" /></c:if>
								
								<li class="sct_li ${strClass} ${pdCnt}">
									<div class="sct_img">
										<c:if test="${ !empty(ent.ATFL_NAME) }">
											<img class="goodsImg" src="${contextPath }/upload/jundan/${ent.AD_ID }/${ent.ATFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
										</c:if>
										<c:if test="${ empty(ent.ATFL_NAME) }">
											<img class="goodsImg" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
										</c:if>
									</div>
									<div class="sct_txt">
										<!-- label style="color:red">[품절] 선택 불가</label><br -->
										<c:out value="${ ent.PD_NAME }" escapeXml="true"/>
									</div>
									<div class="sct_desc"><c:out value="${ ent.PD_DESC }" escapeXml="true"/></div>
									<div class="sct_cost">
										<c:if test="${ ent.PD_PRICE ne 0  && ent.PD_PRICE ne ent.SELL_PRICE }">
											<strike><fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###"/>원</strike>
										</c:if>
										<fmt:formatNumber value="${ ent.SELL_PRICE }" pattern="#,###"/>원
									</div>
								</li>
							</c:if>	
						</c:forEach>
						</ul>
					</div>
				</div>
			</c:forEach>
		</c:if>



<script>
	$(function() {
		$('#aTotal').text("행사상품 전체(${totCnt})");
	});

</script>


	    </div>
	    <!-- } 콘텐츠 끝 -->
	</div>



</body>

</html>