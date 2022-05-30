<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<style>
.imgHelp {
    border: 1px solid #2f87c1;
}
</style>

<body style="background-color: #ECF0F5;">
	<section class="content">
		<div class="row">
			<div class="col-md-12 row-md-12">
				<!-- Custom Tabs -->
				<div class="nav-tabs-custom">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab_1" data-toggle="tab">주문신청</a></li>
						<li><a href="#tab_2" data-toggle="tab">주문신청(장바구니)</a></li>
						<li><a href="#tab_3" data-toggle="tab">주문조회/수정</a></li>
						<li><a href="#tab_4" data-toggle="tab">주문절차 및 계좌번호</a></li>
					</ul>
					<div class="tab-content" style="border:0; OVERFLOW-Y:auto; width:100%; height:500px;">
						<div class="tab-pane active" id="tab_1">
							<h4 class="text-light-blue"><b>1. 상품선택</b></h4>
							<img src="${contextPath }/resources/images/main/helpDesk/tab1_1.png" class="imgHelp" />
							<dl>
							  <dt>1) 주문 상품 선택</dt>
							  <dd> - 목록에서 주문상품 선택(다중선택)</dd>
							  <dt>2) 주문하기</dt>
							  <dd> - 상품 선택 후 주문하기 클릭</dd>
							</dl>
							<h4 class="text-light-blue"><b>2. 주문정보 입력</b></h4>
							<img src="${contextPath }/resources/images/main/helpDesk/tab1_2.png" class="imgHelp" />
							<dl>
							  <dt>1) 기본정보 입력</dt>
							  <dd> - 회사정보, 담당자 정보, 배송지 정보 입력</dd>
							  <dd> - 상품도착요청일, 사업자등록증 사본 입력</dd>
							  <dd> - 차후 주문내역 조회시 사업자등록 번호와 주문비밀번호 사용</dd>
							  <dt>2) 추가배송지 입력</dt>
							  <dd> - 기본 배송지외 지사나 다른곳으로 배송을 원할 경우 [추가하기] 버튼을 클릭하여 배송지 추가</dd>
							  <dd> - 추가 배송지가 없을 경우 또는 해당 라인을 삭제하고 싶을 경우 [삭제] 버튼을 클릭하여 삭제 </dd>
							  <dt>3) 주문상품 수량 입력 및 배송지 선택</dt>
							  <dd> - 선택한 상품의 수량 수정, 동일 상품을 다른곳으로 배송을 원할 경우 [복사추가] 버튼을 클릭해 해당 상품을 복사하여 추가</dd>
							  <dd> - 상품의 삭제을 원할 경우 [삭제] 버튼을 클릭해 상품 삭제</dd>
							  <dd> - 상품의 배송지 선택 - 기본배송지(기본정보의 회사주소), 개별배송(상품별 개별배송, 차후 개별배송지 정보 요청 또는 첨부파일 업로드), 추가배송지 추가배송지에서 추가한 배송지 </dd>
							  <dt>4) 저장</dt>
							  <dd> - 주문정보 모두 입려 후 [저장] 버튼을 클릭해 저장</dd>
							</dl>
	        
						</div>
						<div class="tab-pane" id="tab_2">
							<h4 class="text-light-blue"><b>1. 장바구니 담기</b></h4>
							<img src="${contextPath }/resources/images/main/helpDesk/tab2_2.png" class="imgHelp" />
							<dl>
							  <dt>1) 수량 수정</dt>
							  <dd> - 상품의 수량 수정</dd>
							  <dt>2) 장바구니 담기</dt>
							  <dd> - 수량 입력 후 [장바구니] 버튼 클릭 </dd>
							</dl>
							<h4 class="text-light-blue"><b>2. 주문하기</b></h4>
							<img src="${contextPath }/resources/images/main/helpDesk/tab2_3.png" class="imgHelp" />
							<dl>
							  <dt>1) 장자구니 이동 </dt>
							  <dd> - [장바구니] 버튼 클릭 </dd>
							  <dt>2) 상품수량 수정</dt>
							  <dd> - 장바구니 상품으 수량 수정</dd>
							  <dt>3) 장바주기 삭제</dt>
							  <dd> - 장바구니에서 삭제하고 싶을 경우 해당 상품의 [삭제] 버튼을 클릭하여 삭제</dd>
							  <dt>4) 주문하기</dt>
							  <dd> - 장바구니 상품을 주문하기위해 [주문하기] 버튼을 클릭해 주문화면으로 이동</dd>
							</dl>
						</div>
						<div class="tab-pane" id="tab_3">
							<h4 class="text-light-blue"><b>1. 주문내역 조회</b></h4>
							<img src="${contextPath }/resources/images/main/helpDesk/tab3_1.png" class="imgHelp" />
							<dl>
							  <dt>1) 주문내역 조회 팝업</dt>
							  <dd> - 주문내역 조회를 위해 [주문내역 조회] 버튼을 클릭하여 사용자 확인 팝업 호출</dd>
							  <dt>2) 사용자 확인</dt>
							  <dd> - 주문시 입력한 사업자등록번호와 주문 비밀번호 입력 후 [주문내역 조회] 버튼 클릭</dd>
							</dl>
							<h4 class="text-light-blue"><b>2. 주문내역 확인</b></h4>
							<img src="${contextPath }/resources/images/main/helpDesk/tab3_2.png" class="imgHelp" />
							<dl>
							  <dt>1) 주문내역 목록</dt>
							  <dd> - 주문내역 목록확인 후 상세 조회를 위해 주문번호 또는 상품명 클릭</dd>
							  <dt>2) 주문내역 상세정보 조회</dt>
							  <dd> - 주문내역 확인 및 주문 진행상태 확인</dd>
							  <dt>3) 주문 취소 또는 주문내역 수정</dt>
							  <dd> - 주문을 취소하고 싶을 경우 [주문취소] 버튼을 클릭하여 주문 취소</dd>
							  <dd> - 주문내역을 수정하고 싶을 경우 [수정] 버튼을 클릭하여 주문 수정화면으로 이동</dd>
							  <dt>4) 주문내역 수정</dt>
							  <dd> - 기본정보, 추가배송지, 주문상품 정보를 수정 후 [저장] 버튼을 클릭해 저장</dd>
							</dl>
							<h4 class="text-light-blue"><b>3. 주문내역 수정</b></h4>
							<img src="${contextPath }/resources/images/main/helpDesk/tab3_3.png" class="imgHelp" />
							<dl>
							  <dt>1,2,3) 주문내역 수정</dt>
							  <dd> - 기본정보, 추가배송지, 주문상품 정보를 수정</dd>
							  <dt>4) 주문내역 저장</dt>
							  <dd> - 주문내역 수정 후 [저장] 버튼을 클릭해 저장</dd>
							</dl>
						</div>
						<div class="tab-pane" id="tab_4">
							<h4 class="text-light-blue"><b>1. 주문절차 및 계좌번호</b></h4>
							<img src="${contextPath }/resources/images/main/helpDesk/tab4_1.png" class="imgHelp" />
						</div>
					</div>
					<!-- /.tab-content -->
				</div>
				<!-- nav-tabs-custom -->
			</div>
			<!-- /.col -->
		</div>
	</section>
</body>