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
	<link rel="stylesheet" href="${contextPath}/resources/css/mall/style.css?ver=1.9">
	
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
			    max-width: 169px;
			    max-height: 138px;
			}
			
			
			</style>
			
			<script>
				$(function() {
				//width: 169px;
			    //height: 138px;
					$('.goodsImg').each(function() {
							//$(this).hide();
						
							$(this).error(function(){
								$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
							});
					});
					
					$('.goodsImg').load(function(){
					
					    var maxWidth = 169; // Max width for the image
					    var maxHeight = 138;    // Max height for the image
			
					    var width = $(this).width();    // Current image width
					    var height = $(this).height();  // Current image height
					    
					    var top = 0;
					    if(height < maxHeight){
					    	top = (maxHeight - height)/2; // get ratio for scaling image
					        $(this).css("margin-top", top);   	// Set top
					    }
					    
					    $(this).show();
						
					});
					
					$('#btnOrdName').click(function(){

						location.href = "?sortGubun=NAME&sortOdr=asc"; 
					});
					$('#btnOrdPrice').click(function(){

						location.href = "?sortGubun=PRICE&sortOdr=asc"; 
					});
					
					var strTop = "124px";
					var strLeft = "116px";
					var strColor = "#ffffff";
					
					<c:if test="${rtnAdInfo.TOP_TYPE eq '1'}">
						strTop = "124px";
						strLeft = "116px";
					</c:if>

					<c:if test="${rtnAdInfo.TOP_TYPE eq '2'}">
						strTop = "124px";
						strLeft = "286px";
					</c:if>
					<c:if test="${rtnAdInfo.TOP_TYPE eq '3'}">
						strTop = "144px";
						strLeft = "120px";
						strColor = "#4B8FCC";
					</c:if>
					
					<c:if test="${rtnAdInfo.TOP_TYPE eq '0'}">
						$("#divEventDate").hide();
					</c:if>
					
					// #div 좌표 새로 설정
					$("#divEventDate").css({
					   "position" : "absolute",
					   "top" : strTop,
					   "left" : strLeft,
					   "color" : strColor,
					   "font-size" : "24px",
					   "font-family" : "Nanum Barun Gothic"
					});
					
				});
			
			</script>
			<div id="divEventDate">${rtnAdInfo.START_DT }부터 ${rtnAdInfo.END_DT }까지</div>
			
			<!-- 상품 목록 시작 { -->
			<div id="sct">


				<c:if test="${rtnAdInfo.TOP_TYPE eq '0'}">
					<img class="imgTop" src="${contextPath }/upload/jundan/${AD_ID }/${rtnAdInfo.TOP_ATFL }" usemap="#mapNaver"/>
				</c:if>
				<c:if test="${rtnAdInfo.TOP_TYPE eq '1'}">
					<img class="imgTop" src="${contextPath}/resources/img/sub/ad/header1_1.jpg" usemap="#mapNaver"/>
				</c:if>
				<c:if test="${rtnAdInfo.TOP_TYPE eq '2'}">
					<img class="imgTop" src="${contextPath}/resources/img/sub/ad/header2.jpg" usemap="#mapNaver"/>
				</c:if>
				<c:if test="${rtnAdInfo.TOP_TYPE eq '3'}">
					<img class="imgTop" src="${contextPath}/resources/img/sub/ad/header3.jpg" usemap="#mapNaver"/>
				</c:if>
				
				<map id="mapNaver" name="mapNaver">
					<c:if test="${rtnAdInfo.TOP_TYPE eq '1'}">
						<area shape="rect" alt="" title="" coords="812,117,1088,267" href="http://map.naver.com/?pinId=37537937&pinType=site&dlevel=12&y=3a14529314559e46b01b41802f766d02&x=538603a0d1a51e02a7050c6566e9a613&enc=b64" target="new" />
					</c:if>
					<c:if test="${rtnAdInfo.TOP_TYPE eq '2'}">
						<area shape="rect" alt="" title="" coords="881,107,1086,220" href="http://map.naver.com/?pinId=37956777&pinType=site&dlevel=12&y=a28273ad6daf4aee8c9bd4d20060bc08&x=baecb03b9d4d7fd52a0eac3fa96fec7c&enc=b64" target="new" />
					</c:if>
					<c:if test="${rtnAdInfo.TOP_TYPE eq '3'}">
						<area shape="rect" alt="" title="" coords="881,107,1086,220" href="http://naver.me/FO3ZjM88" target="new" />
					</c:if>
				</map>
				
				<c:if test="${ !empty(rtnProdList) }">
					<div style="margin:0 0 10px;padding:10px;border:3px solid #E11016; background:#fff;border-radius:5px; height: auto; overflow: auto;">
							<ul id="ulPdtList" class="ad_list">
							<c:set var="pdCnt" value="0" />
							<c:forEach var="ent" items="${ rtnProdList }" varStatus="status">
								<li class="sct_li" title="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>" style="background-color: #fff;">
									<div class="sct_img">
										<c:set var="strPath" value=""/>
										<c:if test="${ !empty(ent.ATFL_NAME) }">
											<c:if test="${ !empty(rtnAdInfo.ATFL_ID) }"><c:set var="strPath" value="${rtnAdInfo.ATFL_ID }/"/></c:if>
											<img class="goodsImg" pd_id="${rtnAdInfo.PD_ID }" src="${contextPath }/imgAdInfo?AD_ID=${ent.AD_ID }&PD_ID=${ent.PD_ID }&ATFL_ID=${rtnAdInfo.ATFL_ID }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
										</c:if>
										<c:if test="${ empty(ent.ATFL_NAME) }">
											<img class="goodsImg" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
										</c:if>
										<c:if test="${ !empty(ent.PD_CONS) }">
										<div style="top:8px;left:5px;position:absolute;">
											<!-- span class="label label-danger">${ent.PD_CONS }</span><br -->
											<div class="alert alert-danger" style="width:158px; padding:0 2px 0 2px; margin:0 2px 0 2px; font-size:13px; background-color: #d9534f;  color:#F7EC38; font-weight:bold; text-align: center;">
											  ${ent.PD_CONS }
											</div>

										</div>
										</c:if>
										<c:if test="${ !empty(ent.OPT_NAME) and !empty(ent.OPT_PRICE) }">
										<div style="top:110px;left:5px;position:absolute;">
											<!-- span class="label label-danger">${ent.PD_CONS }</span><br -->
											<div class="alert" style="width:158px; border:1px solid #B5CB76; padding:2px 2px 2px 2px; margin:2px 2px 2px 2px; font-size:0.9em; font-weight:bold; background-color: #ffffff; color:#d44950; text-align: center;">
											  ${ent.OPT_NAME } : <fmt:formatNumber value="${ ent.OPT_PRICE }" pattern="#,###"/>원
											</div>

										</div>
										</c:if>
									</div>
									<div class="sct_txt">
										<c:out value="${ ent.PD_NAME }" escapeXml="true"/>
									</div>
									<!-- div class="sct_desc"><c:out value="${ ent.PD_DESC }" escapeXml="true"/></div>  -->
									<div class="${ !empty(ent.UNIT_NAME) ? 'sct_cost_sm' : 'sct_cost' }">
										<c:if test="${ ent.PD_PRICE ne 0 && !empty ent.PD_PRICE && ent.PD_PRICE ne ent.SELL_PRICE }">
											<strike><fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###"/>원</strike>
										</c:if>
										<fmt:formatNumber value="${ ent.SELL_PRICE }" pattern="#,###"/>원<c:if test="${ !empty(ent.UNIT_NAME) }">(${ ent.UNIT_NAME })</c:if>										
									</div>
								</li>
							</c:forEach>
							</ul>
					</div>
				</c:if>
			
			    
			
			</div>


	    </div>
	    <!-- } 콘텐츠 끝 -->
	</div>

</body>

</html>

