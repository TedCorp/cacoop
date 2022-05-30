<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<style type="text/css">
#position_relative{
	width: 185px;
	height: 171px;
	position: relative;
}
#position_absolute{
	width: 185px;
	height: 171px;	
	position: absolute;
	top: 0px;
}

.product_list li {
    /* width: 19.8%; */
    background: #fff;
    border-right: 1px solid #ccc;
    border-top: 1px solid #ccc;
    float: left;
    height: 248px;
    text-align: center;
    margin-bottom: 0px;
}
.product_list .pro {
    margin: 25px;
    letter-spacing: 2;
    max-width:151px;
    max-height:120px;
    width:auto; height:auto;
}
.new-list .goodsImg {
    max-width:132px;
    max-height:88px;
    width:auto; height:auto;
}
.panel {
    border-radius: 4px;
    border: 0px solid transparent; 
    border-image: none;
    margin-bottom: 0px;
    box-shadow: 0px 1px 1px rgba(0,0,0,0.05);
    background-color: rgb(255, 255, 255);
    -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
} 
.product_list .price {
    font-size: 20px;
    /* display: inline-block; */
    color: #000;
}
.pname{
	overflow: hidden; 
  	text-overflow: ellipsis;
  	white-space: nowrap; 
  	height: 20px;
}

.carousel-indicators {
    /* list-style: none; */
    left: 65%;
    width: 60%;
    text-align: right;
    bottom: 0px;
    padding-left: 0px;
    margin-left: -30%;
    position: absolute;
    z-index: 15;
}
ol {
    margin-top: 0px;
    argin-bottom: 10px;
}
.tab-con-main {
    border-left: 1px solid #efefef;
    border-bottom: 1px solid #efefef;
    border-right: 1px solid #efefef;
    min-height: 300px;
    max-height: 300px;
    overflow: hidden;
}
.category_list > li > p.title {
    /* font-weight: bold; */
    font-size: 13px;
    padding-left: 15px;
    margin: 0;
    /* background: url(../img/common/cate_dot.png) no-repeat left center; */
}
a.pname{
	display: block;
    /* padding-left: 5px; */
    /* margin: 2px; */
}
/* 메인 탭 */
.procago{
	border: 1px solid white;
	background: white;
}
.procago ul li{
	border: 1px solid #c3d510;
	float:left; 
	width : 16.66666%;
	height: 44px;
	text-align: center;
}
.procago ul li a{
	width: 100%;
    text-align: center;
    display: block;
    height: 100%;
    vertical-align:middle;
    background-color: #c3d510;
    font-family: 'hanna', Roboto, Arial, sans-serif;
    font: caption;
    color: initial;
    font-weight: bolder;
}

.procago li.sprice a{
	width: 100%;
    text-align: center;
    display: block;
    height: 100%;
    vertical-align:middle;
    background-color: #ff7f00;
    font-family: 'hanna', Roboto, Arial, sans-serif;
    font: caption;
    color: initial;
    font-weight: bolder;
}

.procago li.active a.sp{
	border-bottom: 1px solid #ffffff; 
	background: #ffffff; 
	color: #ff7f00;
}

.product_list .soldout {
    width:auto; height:auto;
}

#layer-popup{
	width:500px;
	hight:330px;
	background:#84c72c;
	border:2px solid #84c72c;
	position:absolute; top:180px; left:150px;
	text-align:right;	
}

.close-bar{
	margin-top:10px;
}
</style>
<script type="text/javascript">
/* Side Menu */
$(document).ready(function(){
	// 첫번째 탭 보여주기
	$('#rol_1').addClass("active").show();
	
	console.log("===========================================");
	//console.log(${pageContext.request.requestURL});
	console.log('document.location', document.location.href);
	console.log('location.pathname',  window.location.pathname); // Returns path only
	console.log('location.href', window.location.href); // Returns full URL
	console.log("===========================================");
	if(window.location == 'http://www.cjflsmart.co.kr/'){
		//window.location.href='https://www.cjflsmart.co.kr/';
	}

	//탑 2차 지정
    <c:forEach items="${cagoList }" var="subMenu">
	    <c:if test="${subMenu.LVL eq '3'}">
	    	$("#subMenuUl_${subMenu.UPCAGO_ID}").append("<li id='subMenuLi_${subMenu.CAGO_ID }' class='subLi'> <p class='title'><a style='color:rgb(121, 121, 121)' href='${contextPath }/product?CAGO_ID=${ subMenu.CAGO_ID }'>${subMenu.CAGO_NAME}</a></p></li>");
		</c:if>		
	    <c:if test="${subMenu.LVL eq '4'}">	
			if($("#subMenuLi_${subMenu.UPCAGO_ID} > dl").length < 1){
		    	$("#subMenuLi_${subMenu.UPCAGO_ID}").append("<dl></dl>");
			}
			$("#subMenuLi_${subMenu.UPCAGO_ID} > dl").append("<dd><a href='${contextPath }/product?CAGO_ID=${ subMenu.CAGO_ID }'>${subMenu.CAGO_NAME}</a></dd>");
		</c:if>		
    </c:forEach>    
    
	$(".subLi").each(function() {
		$(this).append("<hr>");
	});
	
	$(".subMenu").each(function() {
		var strId = $(this).attr("id");

		if($("#" + strId + " > div > ul > li").length < 1){
			var strCagoId = $(this).attr("cagoId");
			$("#link_"+strCagoId).attr("onmouseover", "");
		}
	});
	
	$('#myModal').modal('show');	
		var getCookie = function(name) {
		var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	  	return value? value[2] : null;
	};
	
	//recommandList(getCookie('RCMD_GUBN'));
	//로드하자마자 이벤트 실행
	var event = document.createEvent("HTMLEvents");
	event.initEvent("click",true,false);
	document.getElementById(getCookie('RCMD_GUBN')).dispatchEvent(event);
	/* 
	if(getCookie("pop_delivery") != "done" ){  // pop_delivery가 설정안되어있으면 보여주기
	     $("div#layer-popup.embed").show();
	}
	 */
	getCookie("Notice");
});


function recommandList(RCMD_GUBN){	
	var rcmdGubn = RCMD_GUBN;
	
	//쿠키생성(1일) 
	var date = new Date();
    date.setTime(date.getTime() + 1000*36000);    
    document.cookie = "RCMD_GUBN = "+rcmdGubn+"; expires=" + date.toUTCString() + ";";	
}
</script>

<div style="display:none;">
	<c:forEach var="ent" items="${ cagoList }" varStatus="status">
		<c:if test="${ent.LVL eq '2' }">
			<div id="subMenu_${ent.CAGO_ID }" class="subMenu" cagoId="${ent.CAGO_ID }">
				<div class="category">
		            <ul id="subMenuUl_${ent.CAGO_ID }" class="category_list">
					</ul>
				</div>
			</div>
		</c:if>
	</c:forEach>
</div>
					
<div class="container main_con">
	<div class="row_01 mb_25">
		<div class="col-1 lnb">

			<div class="category">
				<img src="${contextPath}/resources/img/common/cate_title.png">
				<hr>
				<ul class="category_list">
					<c:forEach var="ent" items="${ cagoList }" varStatus="status">
						<c:if test="${ent.LVL eq '2' }">
						<li id="liCago_${ent.CAGO_ID }">
							<p class="title"><a id="link_${ent.CAGO_ID }" onmouseover="tooltip.pop(this, '#subMenu_${ent.CAGO_ID }');" 
												href="${contextPath }/product?CAGO_ID=${ ent.CAGO_ID }">${ ent.CAGO_NAME }</a></p>
							<dl></dl>
							<hr>
						</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
			<%-- <button type="button" style="background-color: transparent;" onclick="location.href='${contextPath}/product/retailListIcon'">
				<img src="http://www.cjfls.co.kr/resources/img/retail/retail_button.png"/>
			</button> --%>
		</div>

		<div class="col-2">
			<div class="col-sm-12 slide">
				<div id="carousel-example-generic" class="carousel slide"
					data-ride="carousel">
					<!-- Indicators -->
					<c:if test="${obj.count > 0}">						
					<ol class="carousel-indicators">
						<c:forEach items="${obj.list}" var="rolimg" varStatus="loop">
							<li data-target="#carousel-example-generic" data-slide-to="${loop.count}"></li>
						</c:forEach>
					</ol>
					<!-- Wrapper for slides -->
					<div class="carousel-inner" role="listbox">
						<c:forEach items="${obj.list}" var="rolimg" varStatus="loop">
							<div class="item" id="rol_${loop.count}" >
								<img src="${contextPath }/upload/${obj.JD_PATH}${rolimg.JD_LIST}" alt="...">
								<div class="carousel-caption"></div>
							</div>
						</c:forEach>
					</div>
					</c:if>
					<c:if test="${obj.count == 0}">
					<ol class="carousel-indicators">
						<li data-target="#carousel-example-generic" data-slide-to="0"
							class="active"></li>
						<li data-target="#carousel-example-generic" data-slide-to="1"></li>
						<li data-target="#carousel-example-generic" data-slide-to="2"></li>
						<!-- <li data-target="#carousel-example-generic" data-slide-to="3"></li> -->
					</ol>
					<div class="carousel-inner" role="listbox">
						<!-- <div class="item active">
							<img src="http://www.cjfls.co.kr/resources/img/main/main_slide1_20190312" alt="...">
							<div class="carousel-caption"></div>
						</div> -->
						<div class="item active">
							<img src="http://www.cjfls.co.kr/resources/img/main/main_slide2.jpg" alt="...">
							<div class="carousel-caption"></div>
						</div>
						<div class="item">
							<img src="http://www.cjfls.co.kr/resources/img/main/main_slide3.png" alt="...">
							<div class="carousel-caption"></div>
						</div>
						<div class="item">
							<img src="http://www.cjfls.co.kr/resources/img/main/main_slide5.png" alt="...">
							<div class="carousel-caption"></div>
						</div>
					</div>
					</c:if>
					<!-- Controls -->
					<a class="left carousel-control" href="#carousel-example-generic"
						role="button" data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#carousel-example-generic"
						role="button" data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
			</div>
			<div class="col-sm-12">
				<div class="row_02_title" style="width:100%">
					<!-- <span class="green">당일</span> 농산물 경매시세 -->
					<%-- <a href="${contextPath }/product?CAGO_ID=110100000" class="pos_a" style="right:20px; top:5px;font-size:13px;"> 농산물더보기+</a> --%>
				</div>
				<div class="new-box">
					<ul class="new-list">
						<c:forEach var="ent" items="${ newList }" varStatus="status">
							<c:if test="${status.index < 3 }">
							<li> <!-- style="border:1px solid gray"> -->
								<a href="./product/view/${ ent.PD_CODE }">
								
									<!-- 품절시 sold out 이미지 표시_20190314 -->
									<%-- <c:choose>
										<c:when test="${ent.SALE_CON eq 'SALE_CON_02' }">
											<div style="position: absolute;" >					
												<c:if test="${ !empty(ent.ATFL_ID ) }">
													<div style="position: relative; width: 160px; height:100px;" ><img class="goodsImg" width="132" height="88" src="${contextPath }/common/commonFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/></div>
												</c:if>	
												<c:if test="${ empty(ent.ATFL_ID) }" >
													<div style="position: relative; width: 160px; height:100px;" ><img class="goodsImg" width="132" height="88" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/></div>
												</c:if>		
											</div>
											<img src="${contextPath }/resources/images/mall/goods/soldout.png" class="goodsImg" width="132" height="88" style="position: relative;" />
										</c:when>
										<c:otherwise> --%>
											<c:if test="${ !empty(ent.ATFL_ID ) }">
												<c:if test="${ent.FILEPATH_FLAG eq mainKey }">
													<div style="width: 160px; height:100px;" >
														<img class="goodsImg" width="132" height="88" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
														<%-- <img class="goodsImg" width="132" height="88" src="${contextPath }/common/commonFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/> --%>
													</div>
												</c:if>
												<c:if test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
													<div style="width: 160px; height:100px;" >														
														<img class="goodsImg" width="132" height="88" src="${ent.STFL_PATH }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
													</div>
												</c:if>
												<c:if test="${ empty(ent.FILEPATH_FLAG) }">
													<div style="width: 160px; height:100px;" >
														<img class="goodsImg" width="132" height="88" src="https://www.cjfls.co.kr/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
													</div>
												</c:if>
											</c:if>
											<c:if test="${ empty(ent.ATFL_ID) }" >
												<div style="height:100px">
													<img class="goodsImg" width="132" height="88" src="${contextPath}/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
												</div>
											</c:if>
										<%-- </c:otherwise>
									</c:choose>	 --%>								
									<p class="pname">${ ent.PD_NAME }</p>
									<p class="price">\ <fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###"/></p> 
								</a>
							</li>
							</c:if>
						</c:forEach>
					</ul>
					<ul class="new-list">
						<c:forEach var="ent" items="${ newList }" varStatus="status">
							<c:if test="${status.index < 9 && status.index > 2}">
							<li> <!-- style="border:1px solid gray"> -->
								<a href="./product/view/${ ent.PD_CODE }">
								
									<!-- 품절시 sold out 이미지 표시_20190314 -->
									<%-- <c:choose>
										<c:when test="${ent.SALE_CON eq 'SALE_CON_02' }">
											<div style="position: absolute;" >					
												<c:if test="${ !empty(ent.ATFL_ID ) }">
													<div style="position: relative; width: 160px; height:100px;" ><img class="goodsImg" width="132" height="88" src="${contextPath }/common/commonFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/></div>
												</c:if>	
												<c:if test="${ empty(ent.ATFL_ID) }" >
													<div style="position: relative; width: 160px; height:100px;" ><img class="goodsImg" width="132" height="88" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/></div>
												</c:if>		
											</div>
											<img src="${contextPath }/resources/images/mall/goods/soldout.png" class="goodsImg" width="132" height="88" style="position: relative;" />
										</c:when>
										<c:otherwise> --%>
											<c:if test="${ !empty(ent.ATFL_ID ) }">
												<c:if test="${ent.FILEPATH_FLAG eq mainKey }">
													<div style="width: 160px; height:100px;" >
														<img class="goodsImg" width="132" height="88" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
														<%-- <img class="goodsImg" width="132" height="88" src="${contextPath }/common/commonFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/> --%>
													</div>
												</c:if>
												<c:if test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
													<div style="width: 160px; height:100px;" >														
														<img class="goodsImg" width="132" height="88" src="${ent.STFL_PATH }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
													</div>
												</c:if>
												<c:if test="${ empty(ent.FILEPATH_FLAG) }">
													<div style="width: 160px; height:100px;" >
														<img class="goodsImg" width="132" height="88" src="https://www.cjfls.co.kr/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
													</div>
												</c:if>
											</c:if>
											<c:if test="${ empty(ent.ATFL_ID) }" >
												<div style="height:100px">
													<img class="goodsImg" width="132" height="88" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
												</div>
											</c:if>
										<%-- </c:otherwise>
									</c:choose>	 --%>
									<p class="pname">${ ent.PD_NAME }</p>
									<p class="price">\ <fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###"/></p> 
								</a>
							</li>
							</c:if>
						</c:forEach>
					</ul>
					<ul class="new-list">
						<c:forEach var="ent" items="${ newList }" varStatus="status">
							<c:if test="${status.index < 15 && status.index > 8}">
							<li> <!-- style="border:1px solid gray"> -->
								<a href="./product/view/${ ent.PD_CODE }">
								
									<!-- 품절시 sold out 이미지 표시_20190314 -->
									<%-- <c:choose>
										<c:when test="${ent.SALE_CON eq 'SALE_CON_02' }">
											<div style="position: absolute;" >					
												<c:if test="${ !empty(ent.ATFL_ID ) }">
													<div style="position: relative; width: 160px; height:100px;" ><img class="goodsImg" width="132" height="88" src="${contextPath }/common/commonFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/></div>
												</c:if>	
												<c:if test="${ empty(ent.ATFL_ID) }" >
													<div style="position: relative; width: 160px; height:100px;" ><img class="goodsImg" width="132" height="88" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/></div>
												</c:if>		
											</div>
											<img src="${contextPath }/resources/images/mall/goods/soldout.png" class="goodsImg" width="132" height="88" style="position: relative;" />
										</c:when>
										<c:otherwise> --%>
											<c:if test="${ !empty(ent.ATFL_ID ) }">
												<c:if test="${ent.FILEPATH_FLAG eq mainKey }">
													<div style="width: 160px; height:100px;" >
														<img class="goodsImg" width="132" height="88" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
														<%-- <img class="goodsImg" width="132" height="88" src="${contextPath }/common/commonFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/> --%>
													</div>
												</c:if>
												<c:if test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
													<div style="width: 160px; height:100px;" >														
														<img class="goodsImg" width="132" height="88" src="${ent.STFL_PATH }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
													</div>
												</c:if>
												<c:if test="${ empty(ent.FILEPATH_FLAG) }">
													<div style="width: 160px; height:100px;" >
														<img class="goodsImg" width="132" height="88" src="https://www.cjfls.co.kr/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
													</div>
												</c:if>
											</c:if>
											<c:if test="${ empty(ent.ATFL_ID) }" >
												<div style="height:100px">
													<img class="goodsImg" width="132" height="88" src="${contextPath}/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
												</div>
											</c:if>
										<%-- </c:otherwise>
									</c:choose>	 --%>
									<p class="pname">${ ent.PD_NAME }</p>
									<p class="price">\ <fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###"/></p> 
								</a>
							</li>
							</c:if>
						</c:forEach>
					</ul>
					<%-- <a class="pre"><img src="${contextPath}/resources/img/main/new_arrow_left.gif"> </a> <a
						class="next"><img src="${contextPath}/resources/img/main/new_arrow_right.gif"> </a> --%>
				</div>
				<%-- <div class="sale-box">
					<img src="${contextPath}/resources/img/main/onlysale.jpg">
				</div> --%>
			</div>
		</div>		
		<!--col-2 end-->
		
		<div class="col-3">
			<div class="main-tab" style="height:35%">
				<!-- Nav tabs -->
				<ul class="nav nav-main" role="tablist">
					<li role="presentation" class="active" style="width:50%"><a href="#home"
						aria-controls="home" role="tab" data-toggle="tab">FAQ</a></li>
					<li role="presentation" style="width:50%"><a href="#profile"
						aria-controls="profile" role="tab" data-toggle="tab">공지사항</a></li>
					<!-- <li role="presentation"><a href="#messages"
						aria-controls="messages" role="tab" data-toggle="tab">상품후기</a></li> -->
				</ul>

				<!-- Tab panes -->
				<div class="tab-content tab-con-main">
					<div role="tabpanel" class="tab-pane active" id="home" style="margin-left:10px;"> <!-- class ta_c뺌 -->
						<%-- <img src="${contextPath}/resources/img/main/event.jpg"> --%>
						<c:forEach var="ent" items="${ faq }" varStatus="status">
							<c:if test="${status.index < 8 }">
		                    	<a href="${contextPath }/community/faq/detail?BRD_NUM=${ent.BRD_NUM }" class="pname">
		                    		 <img src="http://www.cjfls.co.kr/html/img/sub/sub05/bullet_tit.gif"> 
		                    		 ${ ent.BRD_SBJT }
		                    	</a><br>
		                    </c:if>
		           		</c:forEach>
					</div>
					<div role="tabpanel" class="tab-pane" id="profile"  style="margin-left:10px;"> <!-- class ta_c뺌 -->
						<c:forEach var="ent" items="${ notice }" varStatus="status">
							<c:if test="${status.index < 8 }">
								<a href="${contextPath }/community/notice/detail?BRD_NUM=${ent.BRD_NUM }" class="pname">
								 	<img src="http://www.cjfls.co.kr/html/img/sub/sub05/bullet_tit.gif">
								 	${ ent.BRD_SBJT }
								</a><br>
							</c:if>
						</c:forEach>					
					</div>
				</div>
			</div>
			
			<div class="row_02_title">
				<p>
					<span class="green">인기좋은</span> 판촉물
				</p>
			</div>
			<div class="new-box" style="border: 2px solid #87b212;">
				<ul class="new-list">
					<c:forEach var="ent" items="${ recommendList8 }" varStatus="status">
						<c:if test="${status.index < 5 }">
						<li  style="float:initial;width:100%;"> <!-- style="border:1px solid gray"> -->
							<a href="./product/view/${ ent.PD_CODE }">
							
									<!-- 품절시 sold out 이미지 표시_20190314 -->
									<%-- <c:choose>
										<c:when test="${ent.SALE_CON eq 'SALE_CON_02' }">
											<div style="position: absolute;" >					
												<c:if test="${ !empty(ent.ATFL_ID ) }">
													<div style="position: relative; width: 196px; height:100px;" ><img class="goodsImg" width="132" height="88" src="${contextPath }/common/commonFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/></div>
												</c:if>	
												<c:if test="${ empty(ent.ATFL_ID) }" >
													<div style="position: relative; width: 196px; height:100px;" ><img class="goodsImg" width="132" height="88" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/></div>
												</c:if>		
											</div>
											<img src="${contextPath }/resources/images/mall/goods/soldout.png" class="goodsImg" width="132" height="88" style="position: relative;" />
										</c:when>
										<c:otherwise> --%>
											<c:if test="${ !empty(ent.ATFL_ID ) }">
												<c:if test="${ent.FILEPATH_FLAG eq mainKey }">
													<div style="width: 160px; height:100px;" >
														<img class="goodsImg" width="132" height="88" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
														<%-- <img class="goodsImg" width="132" height="88" src="${contextPath }/common/commonFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/> --%>
													</div>
												</c:if>
												<c:if test="${!empty(ent.FILEPATH_FLAG) && ent.FILEPATH_FLAG ne mainKey }">
													<div style="width: 160px; height:100px;" >														
														<img class="goodsImg" width="132" height="88" src="${ent.STFL_PATH }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
													</div>
												</c:if>
												<c:if test="${ empty(ent.FILEPATH_FLAG) }">
													<div style="width: 160px; height:100px;" >
														<img class="goodsImg" width="132" height="88" src="https://www.cjfls.co.kr/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
													</div>
												</c:if>
											</c:if>
											<c:if test="${ empty(ent.ATFL_ID) }" >
												<div style="height:100px">
													<img class="goodsImg" width="132" height="88" src="${contextPath}/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
												</div>
											</c:if>
										<%-- </c:otherwise>
									</c:choose>	 --%>
								<p class="pname">${ ent.PD_NAME }</p>
								<p class="price">\ <fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###"/></p> 
							</a>
						</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>		
		</div>
		<!--col-3end-->

		<div class="clearfix"></div>
	</div>
	
<div class="row_03 mb_25">
<div class="center-box center-green mb_20">

	<div class="row_04">
		<div class="panel panel-default">
			<div class="panel-body pos_r">
				<h4 class="eng mg_n">
					<span class="blue">RECOMMEND</span> PRODUCT 
					<small class="sm_ft wgray">엄선된 상품만을 제공합니다</small>
				</h4>
				<!-- <a class="pos_a" style="right: 20px; top: 10px">more +</a> -->
			</div>
		</div>
		<div class="main-tab procago">
			<ul class="nav nav-main" role="tablist"> 
				<li role="presentation" class="active">
					<a href="#pro1" id="RCMD_GUBN_01" aria-controls="pro1" role="tab" data-toggle="tab" onclick="recommandList('RCMD_GUBN_01')">복사용지</a>
				</li>
				<li role="presentation" class = "sprice">
					<a href="#pro5" id="RCMD_GUBN_03"class = "sp"  aria-controls="pro5" role="tab" data-toggle="tab" onclick="recommandList('RCMD_GUBN_03')">생활용품</a>
				</li>				
				<li role="presentation">
					<a href="#pro2" id="RCMD_GUBN_04" aria-controls="pro2" role="tab" data-toggle="tab" onclick="recommandList('RCMD_GUBN_04')">디지털용품</a>
				</li>
				<li role="presentation">
					<a href="#pro3" id="RCMD_GUBN_05" aria-controls="pro3" role="tab" data-toggle="tab" onclick="recommandList('RCMD_GUBN_05')">청소/위생용품</a>
				</li>
				<li role="presentation">
					<a href="#pro4" id="RCMD_GUBN_06" aria-controls="pro4" role="tab" data-toggle="tab" onclick="recommandList('RCMD_GUBN_06')">커피/식음료</a>
				</li>				
				<li role="presentation">
					<a href="#pro6" id="RCMD_GUBN_07" aria-controls="pro6" role="tab" data-toggle="tab" onclick="recommandList('RCMD_GUBN_07')">소형가전용품</a>
				</li>
			</ul>
		</div>
		<div class="tab-content tab-con-main" style="max-height: none;min-height: auto; padding: 0px;">
			<c:if test="${ !empty(recommendList) }">
				<div role="tabpanel" class="tab-pane active" id="pro1"> <!-- class ta_c뺌 -->
					<ul class="product_list">
						<c:forEach var="ent" items="${ recommendList }" varStatus="status">
							<li>
								<a href="./product/view/${ ent.PD_CODE }">
								  <div style="height: 70%">								  
									  	<!-- 품절시 sold out 이미지 표시_20190327 -->
									  	<%-- 
									  	<div id="position_relative">				  	
									  		<c:if test="${ !empty(ent.ATFL_ID) }">
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if>
											<c:if test="${ empty(ent.ATFL_ID) }">
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if>
											<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
												<div id="position_absolute">
													<img src="${contextPath }/resources/images/mall/goods/soldout.png" class="goodsImg" width="185" height="171" />
												</div>
											</c:if>
										</div>	
										 --%>										
										<%-- <c:if test='${ent.PDDC_GUBN!="PDDC_GUBN_01" }'>
											<div style="position: absolute;font-size:20px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;margin-left: 10px;margin-top: 10px">
												전단행사상품<br>
												<div style="position: absolute;font-size:10px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;">(5월 22일~6월31일)</div>			
											</div>
										</c:if> --%>
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
										<img class="goodsImg pro" width="151" height="120" src="${imgPath}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
										<%-- <c:if test="${ !empty(ent.ATFL_ID) }">											
											<img class="goodsImg pro" width="151" height="120" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
										</c:if> --%>
										<c:if test="${ empty(ent.ATFL_ID) }">
											<img class="goodsImg pro" width="151" height="120" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
										</c:if>										 
									</div>
									
									<div style="padding-top: 10px; height: 30%; background: #EAEAEA;">
										<p class="pname">${ent.PDDC_GUBN=='PDDC_GUBN_02' ?'<small class="label label-danger">행사</small>':'' }&nbsp;${ ent.PD_NAME }</p>
										<p class="red txt_wg price">\ <fmt:formatNumber value="${ ent.PD_PRICE - ent.PDDC_VAL }" pattern="#,###"/></p>
									</div>
									
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</c:if>
			<div role="tabpanel" class="tab-pane" id="pro2"> <!-- class ta_c뺌 -->
				<c:if test="${ !empty(recommendList3) }">
					<div role="tabpanel" class="tab-pane active" id="pro2"> <!-- class ta_c뺌 -->
						<ul class="product_list">
							<c:forEach var="ent" items="${ recommendList3 }" varStatus="status">
								<li>
									<a href="./product/view/${ ent.PD_CODE }">
										<div style="height: 70%">
											
									  	<!-- 품절시 sold out 이미지 표시_20190327 -->
									  	<%-- <div id="position_relative">						  	
									  		<c:if test="${ !empty(ent.ATFL_ID) }">
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if>
											<c:if test="${ empty(ent.ATFL_ID) }">
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if>
											<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
												<div id="position_absolute">
													<img src="${contextPath }/resources/images/mall/goods/soldout.png" class="goodsImg" width="185" height="171" />
												</div>
											</c:if>
										</div> --%>											
											<%-- <c:if test='${ent.PDDC_GUBN!="PDDC_GUBN_01" }'>
												<div style="position: absolute;font-size:20px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;margin-left: 10px;margin-top: 10px">
													전단행사상품<br>
													<div style="position: absolute;font-size:10px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;">(5월 22일~6월31일)</div>			
												</div>
											</c:if> --%>
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
											<img class="goodsImg pro" width="151" height="120" src="${imgPath}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											<%-- <c:if test="${ !empty(ent.ATFL_ID) }">											
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if> --%>
											<c:if test="${ empty(ent.ATFL_ID) }">
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if>
										</div>
										
										<div style="padding-top: 10px; height: 30%; background: #EAEAEA;">
											<p class="pname">${ent.PDDC_GUBN=='PDDC_GUBN_02' ?'<small class="label label-danger">행사</small>':'' }&nbsp;${ ent.PD_NAME }</p>
											<p class="red txt_wg price">\ <fmt:formatNumber value="${ ent.PD_PRICE - ent.PDDC_VAL }" pattern="#,###"/></p>
										</div>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</c:if>
			</div>
			<div role="tabpanel" class="tab-pane" id="pro3"> <!-- class ta_c뺌 -->
				<c:if test="${ !empty(recommendList4) }">
					<div role="tabpanel" class="tab-pane active" id="pro3"> <!-- class ta_c뺌 -->
						<ul class="product_list">
							<c:forEach var="ent" items="${ recommendList4 }" varStatus="status">
								<li>
									<a href="./product/view/${ ent.PD_CODE }">
										<div style="height: 70%">
											
									  	<!-- 품절시 sold out 이미지 표시_20190327 -->
									  	<%-- <div id="position_relative">						  	
									  		<c:if test="${ !empty(ent.ATFL_ID) }">
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if>
											<c:if test="${ empty(ent.ATFL_ID) }">
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if>
											<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
												<div id="position_absolute">
													<img src="${contextPath }/resources/images/mall/goods/soldout.png" class="goodsImg" width="185" height="171" />
												</div>
											</c:if>
										</div> --%>											
											<%-- <c:if test='${ent.PDDC_GUBN!="PDDC_GUBN_01" }'>
												<div style="position: absolute;font-size:20px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;margin-left: 10px;margin-top: 10px">
													전단행사상품<br>
													<div style="position: absolute;font-size:10px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;">(5월 22일~6월31일)</div>			
												</div>
											</c:if> --%>
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
											<img class="goodsImg pro" width="151" height="120" src="${imgPath}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											<%-- <c:if test="${ !empty(ent.ATFL_ID) }">											
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if> --%>
											<c:if test="${ empty(ent.ATFL_ID) }">
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if>
										</div>
										
										<div style="padding-top: 10px; height: 30%; background: #EAEAEA;">
											<p class="pname">${ent.PDDC_GUBN=='PDDC_GUBN_02' ?'<small class="label label-danger">행사</small>':'' }&nbsp;${ ent.PD_NAME }</p>
											<p class="red txt_wg price">\ <fmt:formatNumber value="${ ent.PD_PRICE - ent.PDDC_VAL }" pattern="#,###"/></p>
										</div>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</c:if>
			</div>
			<div role="tabpanel" class="tab-pane" id="pro4"> <!-- class ta_c뺌 -->
				<c:if test="${ !empty(recommendList5) }">
					<div role="tabpanel" class="tab-pane active" id="pro4"> <!-- class ta_c뺌 -->
						<ul class="product_list">
							<c:forEach var="ent" items="${ recommendList5 }" varStatus="status">
								<li>
									<a href="./product/view/${ ent.PD_CODE }">
										<div style="height: 70%">
												
										  	<!-- 품절시 sold out 이미지 표시_20190327 -->
										  	<%-- <div id="position_relative">						  	
										  		<c:if test="${ !empty(ent.ATFL_ID) }">
													<img class="goodsImg pro" width="151" height="120" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
												</c:if>
												<c:if test="${ empty(ent.ATFL_ID) }">
													<img class="goodsImg pro" width="151" height="120" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
												</c:if>
												<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
													<div id="position_absolute">
														<img src="${contextPath }/resources/images/mall/goods/soldout.png" class="goodsImg" width="185" height="171" />
													</div>
												</c:if>
											</div> --%>	
											<%-- <c:if test='${ent.PDDC_GUBN!="PDDC_GUBN_01" }'>
												<div style="position: absolute;font-size:20px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;margin-left: 10px;margin-top: 10px">
													전단행사상품<br>
													<div style="position: absolute;font-size:10px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;">(5월 22일~6월31일)</div>			
												</div>
											</c:if> --%>
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
											<img class="goodsImg pro" width="151" height="120" src="${imgPath}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											<%-- <c:if test="${ !empty(ent.ATFL_ID) }">											
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if> --%>
											<c:if test="${ empty(ent.ATFL_ID) }">
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if>
										</div>
										
										<div style="padding-top: 10px; height: 30%; background: #EAEAEA;">
											<p class="pname">${ent.PDDC_GUBN=='PDDC_GUBN_02' ?'<small class="label label-danger">행사</small>':'' }&nbsp;${ ent.PD_NAME }</p>
											<p class="red txt_wg price">\ <fmt:formatNumber value="${ ent.PD_PRICE - ent.PDDC_VAL }" pattern="#,###"/></p>
										</div>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</c:if>
			</div>
			<div role="tabpanel" class="tab-pane" id="pro5"> <!-- class ta_c뺌 -->
				<c:if test="${ !empty(recommendList6) }">
					<div role="tabpanel" class="tab-pane active" id="pro5"> <!-- class ta_c뺌 -->
						<ul class="product_list">
							<c:forEach var="ent" items="${ recommendList6 }" varStatus="status">
								<li>
									<a href="./product/view/${ ent.PD_CODE }">
										<div style="height: 70%">
												
										  	<!-- 품절시 sold out 이미지 표시_20190327 -->
										  	<%-- <div id="position_relative">							  	
										  		<c:if test="${ !empty(ent.ATFL_ID) }">
													<img class="goodsImg pro" width="151" height="120" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
												</c:if>
												<c:if test="${ empty(ent.ATFL_ID) }">
													<img class="goodsImg pro" width="151" height="120" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
												</c:if>
												<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
													<div id="position_absolute">
														<img src="${contextPath }/resources/images/mall/goods/soldout.png" class="goodsImg" width="185" height="171" />
													</div>
												</c:if>
											</div> --%>
											<%-- <c:if test='${ent.PDDC_GUBN!="PDDC_GUBN_01" }'>
												<div style="position: absolute;font-size:20px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;margin-left: 10px;margin-top: 10px">
													전단행사상품<br>
													<div style="position: absolute;font-size:10px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;">(5월 22일~6월31일)</div>			
												</div>
											</c:if> --%>
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
											<img class="goodsImg pro" width="151" height="120" src="${imgPath}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											<%-- <c:if test="${ !empty(ent.ATFL_ID) }">											
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if> --%>
											<c:if test="${ empty(ent.ATFL_ID) }">
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if>
										</div>
										
										<div style="padding-top: 10px; height: 30%; background: #EAEAEA;">
											<p class="pname">${ent.PDDC_GUBN=='PDDC_GUBN_02' ?'<small class="label label-danger">행사</small>':'' }&nbsp;${ ent.PD_NAME }</p>
											<p class="red txt_wg price">\ <fmt:formatNumber value="${ ent.PD_PRICE - ent.PDDC_VAL }" pattern="#,###"/></p>
										</div>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</c:if>
			</div>
			<div role="tabpanel" class="tab-pane" id="pro6"> <!-- class ta_c뺌 -->
				<c:if test="${ !empty(recommendList7) }">
					<div role="tabpanel" class="tab-pane active" id="pro6"> <!-- class ta_c뺌 -->
						<ul class="product_list">
							<c:forEach var="ent" items="${ recommendList7 }" varStatus="status">
								<li>
									<a href="./product/view/${ ent.PD_CODE }">
										<div style="height: 70%">
												
										  	<!-- 품절시 sold out 이미지 표시_20190327 -->
										  	<%-- <div id="position_relative">							  	
										  		<c:if test="${ !empty(ent.ATFL_ID) }">
													<img class="goodsImg pro" width="151" height="120" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
												</c:if>
												<c:if test="${ empty(ent.ATFL_ID) }">
													<img class="goodsImg pro" width="151" height="120" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
												</c:if>
												<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
													<div id="position_absolute">
														<img src="${contextPath }/resources/images/mall/goods/soldout.png" class="goodsImg" width="185" height="171" />
													</div>
												</c:if>
											</div> --%>	
											<%-- <c:if test='${ent.PDDC_GUBN!="PDDC_GUBN_01" }'>
												<div style="position: absolute;font-size:20px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;margin-left: 10px;margin-top: 10px">
													전단행사상품<br>
													<div style="position: absolute;font-size:10px;letter-spacing:-0.03em;font-weight:400; color: red;text-align: center; z-index:50;">(5월 22일~6월31일)</div>			
												</div>
											</c:if> --%>
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
											<img class="goodsImg pro" width="151" height="120" src="${imgPath}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											<%-- <c:if test="${ !empty(ent.ATFL_ID) }">											
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/upload/${ent.STFL_PATH }/${ent.STFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if> --%>
											<c:if test="${ empty(ent.ATFL_ID) }">
												<img class="goodsImg pro" width="151" height="120" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
											</c:if>
										</div>
										
										<div style="padding-top: 10px; height: 30%; background: #EAEAEA;">
											<p class="pname">${ent.PDDC_GUBN=='PDDC_GUBN_02' ?'<small class="label label-danger">행사</small>':'' }&nbsp;${ ent.PD_NAME }</p>
											<p class="red txt_wg price">\ <fmt:formatNumber value="${ ent.PD_PRICE - ent.PDDC_VAL }" pattern="#,###"/></p>
										</div>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>
</div>
<!-- /container -->
</div>
<!-- 
<script language="JavaScript">

//레이어 팝업 start
if(getCookie("pop_delivery") != "done" ){  // pop_delivery가 설정안되어있으면 보여주기
     $("div#layer-popup.embed").show();
}

function getCookie( name ) //저장된 쿠키구하기
 { 		
     var nameOfCookie = name + "="; 
     var x = 0; 
     while ( x <= document.cookie.length ) 
     { 
         var y = (x+nameOfCookie.length); 
         if ( document.cookie.substring( x, y ) == nameOfCookie ) 
         { 
             if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
                 endOfCookie = document.cookie.length;
             return unescape( document.cookie.substring( y, endOfCookie ) ); 
         } 
         x = document.cookie.indexOf( " ", x ) + 1; 
         if ( x == 0 ) 
             break; 
     } 
     return "";
 }

 function setCookie( name, value, expiredays ){ //쿠키 설정
      var todayDate = new Date();
      todayDate.setDate( todayDate.getDate() + expiredays );
      document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString()  + ";"
 }

 function closeLayer(){ // 오늘하루보기가 체크 유무에 따른 쿠기 설정
     if (document.popclose.popup.checked){setCookie("pop_delivery", "done" ,1);}          
     $("div#layer-popup").hide(); 
 }
 //레이어 팝업 end

</script>
 -->

<!-- 
 <script language="JavaScript">
 //메인창 쿠키팝업
   function getCookie( name )
   {
    var nameOfCookie = name + "=";
    var x = 0;
    while ( x <= document.cookie.length )
    {
     var y = (x+nameOfCookie.length);
     if ( document.cookie.substring( x, y ) == nameOfCookie ) {
      if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
       endOfCookie = document.cookie.length;
      return unescape( document.cookie.substring( y, endOfCookie ) );
     }
     x = document.cookie.indexOf( " ", x ) + 1;
     if ( x == 0 )
      break;
    }
    return "";
   }
   </script>
    -->
   <script language="JavaScript">
   function getCookie(strName)
   {
	    var strArg = new String(strName + "=");
	    var nArgLen, nCookieLen, nEnd;
	    var i = 0, j;
	
	    nArgLen    = strArg.length;
	    nCookieLen = document.cookie.length;
	
	    if(nCookieLen > 0) {
	
	     while(i < nCookieLen) {
	
	      j = i + nArgLen;
	
	      if(document.cookie.substring(i, j) == strArg) {
	
	       nEnd = document.cookie.indexOf (";", j);
	
	       if(nEnd == -1) nEnd = document.cookie.length;
	
	       return unescape(document.cookie.substring(j, nEnd));
	
	      }
	
	      i = document.cookie.indexOf(" ", i) + 1;
	      if (i == 0) break;
	     }
	    }
	
	    return("");
   }
   
   if ( getCookie( "Notice" ) != "done" )
   {
	//새창으로 열릴 문서의 경로 및 새창의 옵션 설정
    /* window.open('http://www.cjfls.co.kr/upload/jundan/pop_20190520.html', 'event1','left=20,top=100,height=0,width=450,height=360,marginwidth=0,marginheight=0,toolbar=no,location=no,status=no,menubar=no,scrollbars=no'); */
    /* window.open('http://localhost:8080/upload/jundan/pop_20190502.html', 'event1','left=20,top=100,height=0,width=450,height=360,marginwidth=0,marginheight=0,toolbar=no,location=no,status=no,menubar=no,scrollbars=no'); */
    /* window.open('http://www.cjfls.co.kr/upload/jundan/pop_20190122.html', 'event2','left=500,top=100,height=0,width=450,height=360,marginwidth=0,marginheight=0,toolbar=no,location=no,status=no,menubar=no,scrollbars=no'); */
   }
</script> 