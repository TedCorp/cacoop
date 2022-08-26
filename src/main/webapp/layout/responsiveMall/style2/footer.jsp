<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>



<!-- Footer Container -->
    <!-- Footer Bottom Container -->
        <div class="footer-wrap" >
            <div class="footer-conts">
                <div class="content">
                    <ul class="redirect-conts" style="font-size: 15px;">
                        <li><span onclick="termscheck('terms');">이용약관</span></li>
                        <li><span onclick="termscheck('personalInfo');" style="color: #26c165;">개인정보취급방침</span></li>
                    </ul>
                    <div class="info-list">
                        <p>
                            <span>건설건축협동조합</span>
                            <span>대표이사: 송일기</span>
                        </p>
                        <p>
                            <span>대전 대덕구 신탄진로115번안길 23 2층(신대동)</span>
                            <span>대표번호 : 042 - 627 - 0099</span>
                            <span>전자우편: ilkisong@hanmail.net</span>
                        </p>
                        <p>
                            <span>사업자등록번호:294-81-01258 </span>
                            <span>통신판매업 신고: 2022-대전대덕-0250 <button onclick="license();">사업자정보확인</button></span>
                            <span>개인정보 관리 책임자: 송일기</span>
                        </p>
                    </div>
                    <div class="copyright"> COPYRIGHT©Construction and Building Cooperatives. ALL RIGHT RESERVED.</div>
                </div>

                <div class="right-cont">
                    <p style="font-size: 14px;font-weight: 600;margin-bottom: 5px;">구매안전(에스크로)서비스 가맹점
                        <button>서비스 가입사실 확인</button>
                    </p>
                    <p>
                      	  고객님의 안전한 거래를 위해 현금으로 결제 시 저희 쇼핑몰에서 가입한
                      	  구매안전(에스크로)서비스를 이용하실 수 있습니다.
                    </p>
                </div>
            </div>
        </div>
	<div class='layer-popup confrim-type' style='position: absolute;'>
		<div class='popup' style="max-width: 1400px; left: 300px; top: 1800px;">
			<button type='button' class='btn-pop-close popClose'data-focus='pop' data-focus-prev='popBtn01'>X</button>
			<div class='pop-conts' style='padding:20px 20px 20px 20px;'>
				<div class='casa-msg' style="text-align: initial; word-break: keep-all; overflow: scroll;"></div>
			</div>
			<div class='pop-bottom-btn type02'>
		 		<button type='button' data-focus='popBtn02' data-focus-next='pop' class='btn-pop-next' onclick="popClose()">확인</button>
			</div>
		</div>
	</div>
	
<script>
	
	function popClose() {
		$('.layer-popup').removeClass('on');
	}

	function license(){
		window.open('http://www.ftc.go.kr/info/bizinfo/communicationViewPopup.jsp?wrkr_no=2948101258','wowbook','width=750,height=700');
		return false;
	}
	function termscheck(clicktype){
		if(clicktype === 'terms'){
			$.ajax({
				type: "POST",
				url: "${contextPath}/html/terms.html",
				data: $("#idChkFrm").serialize(),
				success: function (data) {
					$('.layer-popup').addClass('on');
					$('.casa-msg').html(data);
				}, error: function (jqXHR, textStatus, errorThrown) {
					alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
				}
			});
		} else if(clicktype === 'personalInfo'){
			$.ajax({
				type: "POST",
				url: "${contextPath}/html/personalInfo.html",
				data: $("#idChkFrm").serialize(),
				success: function (data) {
					$('.layer-popup').addClass('on');
					$('.casa-msg').html(data);
				}, error: function (jqXHR, textStatus, errorThrown) {
					alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
				}
			});
		}
	}
	
</script>