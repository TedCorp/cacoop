<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!doctype html>
<html>
<head>
	<style type="text/css">
	#FILE_NM{border: none; background:white; padding:0px;}
	</style>
</head>
<body>
	<div class="container">
		<div class="page-mypage">
			<div class="mypage-aside">
				<div class="tit">나의 쇼핑 정보</div>
				<div class="txt">
					<ul>
						<li><a href="${contextPath}/m/order/wishList">주문/배송 조회</a></li>
						<li><a href="${contextPath}/m/order/exchange">환불/반품 조회</a></li>
						<li class="on"><a href="${contextPath}/m/mypage/review">상품리뷰</a></li>
						<li><a href="${contextPath}/m/mypage/info">개인정보변경</a></li>
						<li><a href="${contextPath}/m/unregister">회원탈퇴</a></li>
					</ul>
				</div>
			</div>
			<div class="mypage-content">
				<div class="mypage-review-write">
					<div class="mypage-title">상품 리뷰</div>
					<div class="mypage-form">
						<spform:form id="saveFrm" method="post" name="saveFrm" action="/m/mypage/review/save" enctype="multipart/form-data">
						<c:set var="imgPath" value="${contextPath}/common/commonImgFileDown?ATFL_ID=${tb_pdcommxm.ATFL_ID}&ATFL_SEQ=${tb_pdcommxm.RPIMG_SEQ}&IMG_GUBUN=mainType1" />
							<input type="hidden" id="BRD_NUM" name="BRD_NUM" value="${obj.BRD_NUM}"/>
							<input type="hidden" id="PD_CODE" name="PD_CODE" value="${tb_pdcommxm.PD_CODE}"/>
							<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="${tb_pdcommxm.ORDER_NUM}"/>
							<input type="hidden" id="PD_PTS" name="PD_PTS" value="${obj.PD_PTS}"/>
							<input type="hidden" id="ATFL_ID" name="ATFL_ID" value="${obj.ATFL_ID}"/>
							<input type="hidden" id="RPIMG_SEQ" name="ATFL_SEQ" value="${obj.ATFL_SEQ}"/>
							<input type="hidden" id="FILE_NM" name="FILE_NM" value="${obj.FILE_NM}"/>
							<div class="mypage-review-item">
								<div class="img"><img src="${imgPath}" alt=""></div>
								<div class="con">
									<strong class="tit">${ PD_NAME }</strong>
									<span class="txt">
										<span class="date">${ ORDER_DATE }</span>
										<!-- <span class="stat stat_1">완료</span>-->
									</span>
								</div>
								<div class="score">
									<div class="star-rating">
										<input type="radio" id="5-stars" name="PD_STAR" value="5"/>
										<label for="5-stars" class="star" onclick="rating('5');">&#9733; <i class="ic"></i></label>
										<input type="radio" id="4-stars" name="PD_STAR" value="4" />
										<label for="4-stars" class="star" onclick="rating('4');">&#9733; <i class="ic"></i></label>
										<input type="radio" id="3-stars" name="PD_STAR" value="3" />
										<label for="3-stars" class="star" onclick="rating('3');">&#9733; <i class="ic"></i></label>
										<input type="radio" id="2-stars" name="PD_STAR" value="2" />
										<label for="2-stars" class="star" onclick="rating('2');">&#9733; <i class="ic"></i></label>
										<input type="radio" id="1-star" name="PD_STAR" value="1" />
										<label for="1-star" class="star" onclick="rating('1');">&#9733; <i class="ic"></i></label>
									</div>
								</div>
							</div>
							<div class="mypage-review-inp">
								<div class="tit">상품리뷰를 작성해주세요</div>
								<div class="txt">
									<textarea id="BRD_CONT" name="BRD_CONT" placeholder="상품품질에 대한 솔직한 리뷰를 남겨 주세요.">${obj.BRD_CONT}</textarea>
								</div>
							</div>
							<div class="mypage-review-file">
									<input type="file" id="reviewFile" name="reviewFile"><label for="reviewFile">사진 첨부하기</label>
									<span id="fileNM">${ obj.FILE_NM }</span>
									<!-- 사진이 있을경우 ${obj.STFL_NAME}의 값이 보이게 하는  EL 문 -->
									<!-- 사진이 없을경우 "등록된사진이 없습니다"라는 식을 글을 보이게 하면될꺼같고  -->
							</div>
							<div class="mypage-review-button">
								<a href="review.html" class="btn btn_01">취소하기</a>
								<button type="button" id="registerBtn" class="btn btn_02">등록하기</button>
							</div>
						</spform:form>
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
			</div>
		</div>
    </div>
 <script>
	$(document).ready(function() {
		var rating_num = $("#PD_PTS").val();
		if(rating_num != null || rating_num != "") {
			$("input:radio[name='PD_STAR']:radio[value='" + rating_num + "']").prop('checked', true);
		}
		
		var index = $("#reviewFile");
		
		index.on('change', function() {
			if(window.FileReader){
				var fileName = $(this)[0].files[0].name;
				
				console.log('파일명1 : ' + fileName);
			} else {
				var fileName = $(this).val().split('/').pop().split('\\').pop(); // 파일명 추출
				
				console.log('파일명2 : ' + fileName);
			}
			
			var text = String(fileName);
			
			$("#fileNM").text(text);
			// 추출한 파일명 삽입
			$("#FILE_NM").val(text);
			//console.log("여기 : " + $("#FILE_NM").val());
		});
	});
	
	function rating(num) {
		$("#PD_PTS").val(num);
		console.log($("#PD_PTS").val(num));
	}
	
	$("#registerBtn").click(function() {
		if($("#BRD_CONT").val() == ''){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("내용을 입력해 주세요.");
			$("#BRD_CONT").focus();
			return false;
		}
		
		if($("#PD_PTS").val() == null || $("#PD_PTS").val() == ''){
			$('.layer-popup').addClass('on');
			$('.casa-msg').html("별점을 등록해 주세요.");
			return false;
		}
		
		$("#saveFrm").submit();
	});
	
	/* 모달창 확인 눌렀을 때 */
	$('.btn-pop-next').click(function() {
		$(".layer-popup").removeClass("on");
	});
 </script>
</body>
</html>