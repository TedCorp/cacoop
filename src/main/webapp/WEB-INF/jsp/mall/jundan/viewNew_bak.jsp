<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>:::: 할인행사 안내 ::::</title>

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
			
			#wrapper {margin:20px auto;width:1120px;zoom:1;position:relative;padding:0 10px 0 10px;}
			
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
			
			<!-- 상품 목록 시작 { -->
			<div id="sct">
			
				<div class="page-header" style="margin:10px 0 10px;">
				  <h1 style="color:#d44950;">초특가 할인 행사 - 농.수.축산물센터(유성점)<small> 식자재 전문기업</small></h1>
				</div>
			
				<div class="panel panel-default">
				  <div class="panel-body">
				
				      <!-- info row -->
				      <div class="row">
				        <div class="col-sm-5">
				            <h4 class="text-primary"><strong>행사안내</strong></h4>
				            행사점포 : <strong class="text-success">농.수.축산물센터(유성점)</strong><br>
				            행사기간 : <strong class="text-success">10월 00일(월)~10월 00일(일), 10일간</strong><br>
				            영업시간 : 5.AM~7.PM(월~토요일), 8.AM~7.PM(일요일)<br>
				            문의전화 : (042) 825-7811<br>
				            네비주소 : 대전 유성구 한밭대로 492번길 19(봉명동)
				        </div>
				        <!-- /.col -->
				        <div class="col-sm-7">
				            <h4 class="text-primary"><strong>이용안내</strong></h4>
				            1. 본매장은 외식업을 운영하시는 사업주님들을 위한 <strong class="text-primary">무료가입 회원제</strong> 매장입니다.<br>
				            2. 방문시 반드시 <strong class="text-primary">사업자등록증(사본)</strong>을 가져오셔야 <strong class="text-primary">사업자회원으로 가입</strong>가능합니다.<br>
				            3. 매월 사업자회원님을을 위한 <strong class="text-primary">정기적인 식자재 단가 할인행사가 진행</strong>됩니다.<br>
				            4. 축산물,농산물,수산물,각종공산품과 잡화가 <strong class="text-primary">5,000가지 이상 매장에 입점되어 일일 경매시세 및 산지시황에 대하여 정보를 정확하게 제공</strong>합니다.<br>
				            5. <span class="label label-primary">신용카드결제</span>,<span class="label label-primary">세금계산서(현금결제시)</span>등 사업장운영에 편리하도록 시스템화 되어 있습니다.<br>
				            6. 식자재도매사업자는 판매수량이 제한합니다.
				        </div>
				      </div>
				      <!-- /.row -->
				      
				  </div>
				</div>
				<c:if test="${ !empty(rtnProdList) }">
					
					<c:forEach var="entCago" items="${ rtnCagoList }" varStatus="status">
						<c:set var="strClass" value="panel-success" />
						
						<c:if test="${ status.count%3 eq 0}"><c:set var="strClass" value="panel-info" /></c:if>
						<c:if test="${ status.count%3 eq 1}"><c:set var="strClass" value="panel-warning" /></c:if>
						
						<c:if test="${ entCago.CAGO_NAME eq '메인'}"><c:set var="strClass" value="panel-primary" /></c:if>
						
						<div class="panel  ${strClass }">
							<div class="panel-heading">${ entCago.CAGO_NAME}</div>
							<div class="panel-body">
								<ul id="ulPdtList" class="ad_list">
								<c:set var="pdCnt" value="0" />
								<c:forEach var="ent" items="${ rtnProdList }" varStatus="status">
									<c:if test="${ entCago.CAGO_NAME eq ent.CAGO_NAME }">
										<li class="sct_li" title="<c:out value="${ ent.PD_DESC }" escapeXml="true"/>">
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
			
			    
			
			</div>


	    </div>
	    <!-- } 콘텐츠 끝 -->
	</div>

</body>

</html>

