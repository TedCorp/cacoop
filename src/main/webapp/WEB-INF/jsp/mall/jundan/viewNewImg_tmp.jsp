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
					
				});
			
			</script>
			
			<!-- 상품 목록 시작 { -->
			<div id="sct">

				<img class="imgTop" src="${contextPath }/upload/jundan/ad.png" usemap="#mapNaver"/>

			</div>


	    </div>
	    <!-- } 콘텐츠 끝 -->
	</div>

</body>

</html>

