<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<!doctype html>
<html lang="en">
 <head>
 	<!-- Basic page needs
    ============================================ -->
    <title>:::: 건설건축 협동조합 ::::</title>
    <meta charset="utf-8">
    <meta name="keywords" content="건설건축 협동조합" />

    <!-- Mobile specific metas
    ============================================ -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
	<!-- Google web fonts
	============================================ -->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>
    
	<!-- new Includes
	============================================ -->
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/swiper/dist/css/swiper.min.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/common.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/211021.css">	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/resources2/css/reset.css">
<%-- 	<script type="text/javascript" src="${contextPath}/resources/resources2/js/common.js"></script> --%>
<%-- 	<script type="text/javascript" src="${contextPath}/resources/resources2/swiper/dist/js/swiper.min.js"></script> --%>
 </head>
 <body>
<%    
  String PD_CODES =request.getParameter("PD_CODES");
  String OPTION1_VALUES =request.getParameter("OPTION1_VALUES");
  String OPTION2_VALUES =request.getParameter("OPTION2_VALUES");
  String OPTION3_VALUES =request.getParameter("OPTION3_VALUES");
  String STATUS = request.getParameter("STATUS");
  String ORDER_NUM =request.getParameter("ORDER_NUM");
  String PAY_METD =request.getParameter("PAY_METD");
  
  if(PAY_METD.equals("SC0010")) {
	  PAY_METD = "신용카드";
  } else if(PAY_METD.equals("SC0030")) {
	  PAY_METD = "계좌이체";
  } else if(PAY_METD.equals("SC0060")) {
	  PAY_METD = "휴대폰결제";
  } else if(PAY_METD.equals("SC0040")) {
	  PAY_METD = "무통장(가상계좌)";
  }
%>
 
  	<div class="popup">
  		<form id="refundFrm" action="${contextPath }/m/order/updateOrder" method="post" autocomplete="off">
			<div class="title">환불 상세 정보</div>
			<div class="form">
				<dl>
					<dt>환불수단</dt>
					<dd><%= PAY_METD %></dd>
				</dl>
				<dl>
					<dt>환불사유</dt>
					<dd>
						<div>
							<textarea name="CNCL_MSG" placeholder="상세사유를 입력해주세요."></textarea>
						</div>
					</dd>
				</dl>
			</div>
		
			<input type="hidden" id="PD_CODES" name="PD_CODES" value="<%= PD_CODES %>">
			<input type="hidden" id="OPTION1_VALUES" name="OPTION1_VALUES" value="<%= OPTION1_VALUES %>"/>
			<input type="hidden" id="OPTION2_VALUES" name="OPTION2_VALUES" value="<%= OPTION2_VALUES %>"/>
			<input type="hidden" id="OPTION3_VALUES" name="OPTION3_VALUES" value="<%= OPTION3_VALUES %>"/>
			<input type="hidden" name="STATUS" value="<%= STATUS %>"/>
			<input type="hidden" name="ORDER_NUM" value="<%= ORDER_NUM %>">
			<input type="hidden" id="status" name="status" value="REFUND"/>
			<div class="caut">
				<div class="tit">반품시 주의사항</div>
				<div class="txt">
					<span>* 단순 변심에 의한 환불시 <p>'반품 배송비'</p>를 부담하셔야 합니다.</span>
					<span>* 상품이 사용/손상/훼손된 경우에는 반품이 불가능합니다</span>
					<span>* 무료배송, 조건부 무료 상품인 경우 <p>[최초 배송비 + 반품배송비]</p>가 발생되고, 선결제 상품은 <p>[반품배송비]</p>만 발생됩니다.</span>
					<span>* 추가 문의사항은 고객센터(070-4337-2910) 또는 1:1문의를 이용해주세요.</span>
				</div>
			</div>
			<div class="button">
				<a href="javascript:;" class="btn btn01" onclick="window.close();">닫기</a>
				<a href="javascript:;" class="btn btn02" onclick="refundBtn();">환불 요청하기</a>
			</div>
		</form>
	</div> <!-- popup -->
 </body>
 <script>
function refundBtn() {
	var PD_CODES = $("#PD_CODES").val();
	var arr = PD_CODES.split(",");
	var length = arr.length;
	
	/* if($("#allChk").val() == "Y") {
	 chkYn = 1;
	} */
	
	var total = (length + 1) + "";
	
	$.ajax({
		type: "POST",
		url: "${contextPath}/m/order/updateOrder",
		data: $("#refundFrm").serialize(),
		success: function (data) {
			if(data == total) {
				alert("반품 접수가 완료되었습니다.");
				window.close();
				opener.location.reload();
			} else {
				alert("반품 접수 중 문제가 발생했습니다. 관리자에게 문의하세요.");
				window.close();
				opener.location.reload();
			}
		}, error: function (jqXHR, textStatus, errorThrown) {
			alert("처리중 에러가 발생했습니다. 관리자에게 문의하세요.(error:"+textStatus+")");
		}
	});
}
 </script>
</html>