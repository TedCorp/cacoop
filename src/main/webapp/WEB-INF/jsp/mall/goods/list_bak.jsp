<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<style>
input[type=checkbox] {  
    display: none;  
}

input[type=checkbox] + label{
    display: inline-block;  
    cursor: pointer;  
    position: relative;  
    padding-left: 25px;  
    margin-right: 15px;  
    font-size: 13px;
}

input[type=checkbox]+ label:before {     

    content: "";  
    display: inline-block;  
  
    width: 20px;  
    height: 20px;  
  
    margin-right: 10px;  
    position: absolute;  
    left: 0;  
    bottom: 1px;  
    background-color: #ccc;  
    border-radius: 2px; 
    box-shadow: inset 0px 1px 1px 0px rgba(0, 0, 0, .3), 0px 1px 0px 0px rgba(255, 255, 255, .8);  
}
input[type=checkbox]:checked + label:before { 

    content: "\2713";  /* 체크모양 */
    text-shadow: 1px 1px 1px rgba(0, 0, 0, .2);  
    font-size: 18px; 
    font-weight:800; 
    color: #fff;  
    background:#2f87c1;
    text-align: center;  
    line-height: 18px;  

} 
.goodsImg {
    width: auto; height: auto;
    max-width: 226px;
    max-height: 227px;
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
		
		    var maxWidth = 226; // Max width for the image
		    var maxHeight = 227;    // Max height for the image

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


		//팝업
		//if ( getCookie( "mainPopupIdNotice2" ) != "done" ){
		//	$('#layerPopNotice2').modal('show');
		//}
		
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

<div class="modal fade" id="layerPopNotice2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">긴급 공지사항 - 상품 주문 안내</h4>
			</div>
			<div class="modal-body">
				종합 선물세트 1호<br>종합 선물세트 4호<br><br>
				황태 멸치 혼합세트<br>황태 선물세트<br><br>
				멸치+견과류 세트(귀한인연)<br>멸치3종세트(귀한인연)<br>멸치4종세트(어부의약속)<br><br>
				<b style="color:red">7개의 상품은 공급사의 사정으로 최소 10개 이상 주문 가능합니다.<br>
				이용에 불편을 드려 대단히 죄송합니다.</b>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="btnPopupWinodwChk" popupId="Notice2">1일 동안 열지 않기</button>
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
			<li><a href="${contextPath }/goods?CAGO_ID=070000000000" id="aTotal">명절선물 전체</a></li>
			<c:set var="totCnt" value="0" />
			<c:forEach var="ent" items="${ rtnCagoList }" varStatus="status">
				<li><a href="${contextPath }/goods?CAGO_ID=${ ent.CAGO_ID }"><c:out value="${ ent.CAGO_NAME }" escapeXml="true"/> (${ ent.PRD_CNT })</a></li>
				<c:set var="totCnt" value="${ totCnt + ent.PRD_CNT }" />
			</c:forEach>
		</ul>
	</aside>
	<!-- } 상품분류 1 끝 -->
	</c:if>
	<div style="padding:0 0 40px 0;">
		<button type="button" class="btn btn-sm btn-primary pull-left btnBasket" style="margin-right: 5px;">장바구니</button>	
		<button type="button" class="btn btn-sm btn-primary pull-left btnOrderView" style="margin-right: 5px;">주문내역 조회</button>	
		<button type="button" class="btn btn-sm btn-success pull-right btnOrder" style="margin-right: 5px;">주문 하기</button>	
		<button type="button" class="btn btn-sm btn-default pull-right btnHelpDesk" style="margin-right: 5px;">도움말</button>	
	</div>

	<div id="sct_sortlst">
		<!-- 상품 정렬 선택 시작 { -->
		<section id="sct_sort">
		    <h2>상품 정렬</h2>
		    <ul id="ssch_sort">
		        <!--  li><a href="#?ca_id=10&amp;sort=it_sum_qty&amp;sortodr=desc" class="btn01">판매많은순</a></li>
		        <li><a href="#?ca_id=10&amp;sort=it_sum_qty&amp;sortodr=desc" class="btn01">판매많은순</a></li-->
		        <li><a href="?CAGO_ID=${obj.CAGO_ID}&amp;sortGubun=PD_NAME&amp;sortOdr=asc" class="btn01">상품명순</a></li>
		        <li><a href="?CAGO_ID=${obj.CAGO_ID}&amp;sortGubun=CAGO_SORT&amp;sortOdr=asc" class="btn01">상품분류순</a></li>
		        <li><a href="?CAGO_ID=${obj.CAGO_ID}&amp;sortGubun=PD_PRICE&amp;sortOdr=asc" class="btn01">낮은가격순</a></li>
		        <li><a href="?CAGO_ID=${obj.CAGO_ID}&amp;sortGubun=PD_PRICE&amp;sortOdr=desc" class="btn01">높은가격순</a></li>
		        <!--li><a href="#?ca_id=10&amp;sort=it_use_avg&amp;sortodr=desc" class="btn01">평점높은순</a></li>
		        <li><a href="#?ca_id=10&amp;sort=it_use_cnt&amp;sortodr=desc" class="btn01">후기많은순</a></li-->
		        <!--li><a href="#?ca_id=10&amp;sort=it_update_time&amp;sortodr=desc" class="btn01">최근등록순</a></li-->
		    </ul>
		</section>
		<!-- } 상품 정렬 선택 끝 -->
	</div>
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
							<img class="goodsImg" src="${contextPath }/common/commonFileDown?IMG_GUBUN=thumbnail&ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
						</c:if>
						<c:if test="${ empty(ent.ATFL_ID) }">
							<img class="goodsImg" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
						</c:if>
						</a>
					</div>
					<div class="sct_txt">
						<c:if test="${ent.SALE_CON eq 'SALE_CON_02' }">
							<input type="checkbox" id="chkOrder${status.count}" name="chkOrder" value="${ent.PD_CODE }" disabled="disabled"/>
							<label for="chkOrder${status.count}" style="color:red">[품절] 선택 불가</label>
						</c:if>
						<c:if test="${ent.SALE_CON ne 'SALE_CON_02' }">
							<input type="checkbox" id="chkOrder${status.count}" name="chkOrder" value="${ent.PD_CODE }" />
							<label for="chkOrder${status.count}">주문선택</label>
						</c:if>
						<a href="${contextPath }/goods/view/${ ent.PD_CODE }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&${link}" class="sct_a">
						<c:out value="${ ent.PD_NAME }" escapeXml="true"/>
						</a>
					</div>
					<div class="sct_basic">제조사(브랜드):<c:out value="${ ent.MAKE_COM }" escapeXml="true"/></div>
					<div class="sct_basic">분류:<c:out value="${ ent.CAGO_NAME }" escapeXml="true"/></div>
					<div class="sct_cost">
						<c:if test="${ ent.REAL_PRICE ne ent.PD_PRICE }">
							<strike><fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###"/>원</strike>
						</c:if>
						<fmt:formatNumber value="${ ent.REAL_PRICE }" pattern="#,###"/>원
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
	
	<div style="border-top:1px solid #e5e5e5; padding-top: 10px;">
		<button type="button" class="btn btn-sm btn-primary pull-left btnBasket" style="margin-right: 5px;">장바구니</button>	
		<button type="button" class="btn btn-sm btn-primary pull-left btnOrderView" style="margin-right: 5px;">주문내역 조회</button>	
		<button type="button" class="btn btn-sm btn-success pull-right btnOrder" style="margin-right: 5px;">주문 하기</button>	
		<button type="button" class="btn btn-sm btn-default pull-right btnHelpDesk" style="margin-right: 5px;">도움말</button>	
	</div>


</div>
<!-- } 상품 목록 끝 -->



<!-- Modal -->
<div class="modal fade" id="divGuestForm" tabindex="-1" role="dialog" aria-labelledby="myDivGuestForm">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">주문 내역조회</h4>
			</div>
			<div class="modal-body">


				<div class="login-box">
				  <!-- /.login-logo -->
				  <div class="login-box-body">
				
				    <form action="${contextPath }/request" method="post">
				      <div class="form-group has-feedback">
				        <input type="input" name="BIZR_NUM" value="" class="form-control" placeholder="사업자등록번호('-'제거)">
				        <span class="glyphicon glyphicon-briefcase form-control-feedback"></span>
				      </div>
				      <div class="form-group has-feedback">
				        <input type="password" name="ORDER_PW" value="" class="form-control" placeholder="주문 비밀번호">
				        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
				      </div>
				      <div class="row">
				        <div class="col-xs-12">
				          <button type="submit" class="btn btn-primary btn-block btn-flat">주문 내역조회</button>
				        </div>
				        <!-- /.col -->
				      </div>
				    </form>
				
				  </div>
				  <!-- /.login-box-body -->
				</div>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="divHelpDesk" tabindex="-1" role="dialog" aria-labelledby="myDivHelpDesk">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">도움말</h4>
			</div>
			<div class="modal-body" style="background-color: #ECF0F5;">


				<iframe id="ifrmHelpDeskLoad" src="${contextPath}/common/helpDesk" style="border:0; width:100%; height:600px;"> </iframe>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(function() {
		$('#aTotal').text("명절선물 전체(${totCnt})");
	});

</script>