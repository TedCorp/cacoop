<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:set var="strActionUrl" value="${contextPath }/m/wishList" />
<c:set var="strMethod" value="post" />
<!doctype html>
<html>
<head>
</head>
<body>
	<div class="container">
		<div class="page-mypage">
			<div class="mypage-aside">
				<div class="tit">나의 쇼핑 정보</div>
				<div class="txt">
					<ul>
						<li><a href="${contextPath}/m/order/wishList">주문/배송 조회</a></li>
						<li><a href="${contextPath}/m/order/exchange">반품/교환 조회</a></li>
						<li><a href="${contextPath}/m/mypage/review">상품리뷰</a></li>
						<li><a href="${contextPath}/m/mypage/info">개인정보변경</a></li>
						<li class="on"><a href="${contextPath}/m/unregister">회원탈퇴</a></li>
					</ul>
				</div>
			</div>
			<div class="mypage-content">
				<div class="mypage-unregister-page">
					<div class="mypage-title">회원탈퇴</div>
					<div class="myinfo-unregister">
						<form id="unregisterform" name="unregisterform" action="${contextPath}/m/exit" method="post" autocomplete="off">
							<div class="caution">
								<div class="tit">회원탈퇴에 앞서 아래 안내 사항을 반드시 확인 해 주세요.</div>
								<div class="txt">
									<strong><i class="ic"></i>알아두세요!</strong>
									<span><em>1.</em> 탈퇴 후 고객님의 정보는 전자상거래 소비자보호법에 의거한 개인정보보호정책에 따라 관리됩니다.</span>
									<span><em>2.</em> 다음의 경우는 회원탈퇴가 불가합니다. 해당 사항이 있으신 경우는 내역을 종료하신 후 탈퇴신청하시기 바랍니다.<br> 현재 고객님의 반품처리 요청사항이나 고객서비스가 완료되지 않은 경우 서비스 처리 완료 후 탈퇴 가능합니다.<br> 배송요청/배송중/반품요청/송금예정 등의 거래가 진행중인 경우 진행 중인 거래를 우선 마무리 해주시기 바랍니다.</span>
									<span><em>3.</em> 회원탈퇴 후 재가입 시에는 신규가입으로 처리되며, 탈퇴하신 ID는 재 사용하실 수 없습니다.</span>
									<span><em>4.</em> 회원 탈퇴 시 해당 아이디와 주문내역은 ‘전자상거래에서의 소비자 보호에 관한 법률’에 의거 5년간 보관됩니다.<br> 보관 기간(5년) 경과 시 주문내역은 즉시 삭제 됩니다.<br> 단, 아이디는 재가입 방지를 위하여 보관됩니다.</span>
								</div>
							</div>
							<div class="form">
								<!-- <div class="tit">회원 탈퇴 사유 [ 더 나은 서비스를 위해 참고 하도록 하겠습니다. ]</div>
								<div class="chk">
									<ul>
										<li><input type="radio" name="unregi" id="unregi1" checked><label for="unregi1">배송불만</label></li>
										<li><input type="radio" name="unregi" id="unregi2"><label for="unregi2">사용이 불편함</label></li>
										<li><input type="radio" name="unregi" id="unregi3"><label for="unregi3">상품의 다양성/가격/품질 불만</label></li>
										<li><input type="radio" name="unregi" id="unregi4"><label for="unregi4">교환/환불/반품 불만</label></li>
										<li><input type="radio" name="unregi" id="unregi5"><label for="unregi5">혜택부족</label></li>
										<li><input type="radio" name="unregi" id="unregi6"><label for="unregi6">기타사유</label></li>
									</ul>
								</div>
								<div class="txt">
									<span>기타사유를 입력해 주세요.</span>
									<textarea></textarea>
								</div>
								<div class="agree">
									<input type="checkbox" id="agree"><label for="agree">회원 탈퇴 안내를 모두 확인하였으며, 탈퇴에 동의합니다.</label>
								</div> -->
								<div class="button">
									<button id="unregister" type="button" class="btn btn_02">탈퇴신청</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 모달창 -->
    <div class='layer-popup confrim-type'>
		<div class='popup' style="max-width: 350px;">
			<button type='button' class='btn-pop-close popClose'data-focus='pop' data-focus-prev='popBtn01'>X</button>
			<div class='pop-conts' style='padding:60px 30px 45px 30px;'>
				<div class='casa-msg'></div>
			</div>
		 	<div class='pop-bottom-btn type02'>
		 		<button type='button' data-focus='popBtn02' data-focus-next='pop' class='btn-pop-next'>확인</button>
		 		<button type='button' data-focus='popBtn02' data-focus-next='pop' class='btn-pop-cancel'>취소</button>
			</div>
		</div>
    </div>
 <script>
	$("#unregister").click(function() {
		$('.layer-popup').addClass('on');
		$('.casa-msg').html("안내 사항을 확인했으며 <br> 탈퇴에 동의합니다.");
	});
	
	/* 모달창 확인 눌렀을 때 */
	$('.btn-pop-next').click(function() {
		$(".layer-popup").removeClass("on");
		$("#unregisterform").submit();
	});
	/* 모달창 취소 눌렀을 때 */
	$('.btn-pop-cancel').click(function(){
		$('.casa-msg').html("탈퇴를 취소하였습니다.");
		$('.btn-pop-next').remove();
		$('.btn-pop-cancel').text('확인');
		$('.btn-pop-cancel').click(function(){
			$('.layer-popup').removeClass("on");
			location.reload();
		});
	});
</script>	
</body>
</html>
