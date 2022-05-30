<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		환불접수
		<small>환불접수내역</small>
	</h1>
</section>

<section class="content">
	<!-- 주문 정보 시작 -->
	<div class="box box-info">
		<div class="box-header with-border">
			<h3 class="box-title">환불정보</h3>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label">환불번호</label>
				<div class="col-sm-4">${tb_odinfoxm.ORDER_NUM }</div>
				<label for="inputEmail3" class="col-sm-2 control-label">주문자</label>
				<div class="col-sm-4">${tb_odinfoxm.MEMB_NM }</div>
			</div><br/>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label">환불요청일시</label>
				<div class="col-sm-4">${tb_odinfoxm.ORDER_DATE }</div>
				<label for="inputEmail3" class="col-sm-2 control-label">원 주문번호</label>
				<div class="col-sm-4">${tb_odinfoxm.ORDER_NUM }</div>
			</div><br/>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label">환불상태</label>
				<div class="col-sm-4">${tb_odinfoxm.RFND_CON_NM }</div>
				<label for="inputEmail3" class="col-sm-2 control-label">환불수단</label>
				<div class="col-sm-4">${tb_odinfoxm.PAY_METD_NM }</div> 
			</div>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- 주문 정보 끝 -->
	
	<!-- 주문상품 정보 시작 -->
	<form name="refundFrm" id="refundFrm" method="POST" action="${contextPath}/adm/orderRfndMgr" onsubmit="return fnValidationCheck();" autocomplete="off">
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">상품 정보</h3>
					<div class="pull-right">
						<c:choose>
							<c:when test="${ tb_odinfoxm.PAY_METD ne 'SC0040' }">
								<button type="button" class="btn btn-sm btn-danger" id="btnReject" value="RFND_CON_02" style="height: 48.19px;">환불거절</button>
								<button type="button" class="btn btn-sm btn-primary" id="pgCancel" value="RFND_CON_03" style="height: 48.19px;"><i class="fa fa-credit-card"></i> PG취소<br/>(환불승인)</button>
							<!-- 	<a onclick="javascript:fn_pgCancel();" class="btn btn-warning btn-sm pull-right left-5"><i class="fa fa-credit-card"></i> PG취소<br/>(환불승인)</a>  -->
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-sm btn-danger" id="btnReject" value="RFND_CON_02">환불거절</button>
								<button type="button" class="btn btn-sm btn-primary" id="btnRefund" value="RFND_CON_03">환불승인</button>
							</c:otherwise>
						</c:choose>
					</div>
			</div>
			<!-- /.box-header -->
			<div class="box-body">
				<table class="table table-bordered">
					<colgroup>
						<col width="10%"/>
						<col width="40%"/>
						<col width="10%"/>
						<col width="20%"/>
						<col width="20%"/>
					</colgroup>
					<thead>
						<tr>
							<th class="txt-middle">번호</th>
							<th class="txt-left">상품명</th>
							<th class="txt-right">환불수량</th>
							<th class="txt-right">판매가격</th>
							<th class="txt-right">소계</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="cancelPrice" value="0"/>
						<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
							<!-- 컨트롤러로 넘기는 값 -->
							<input type="hidden" id="ORDER_CON" name="ORDER_CON"/>
							<input type="hidden" id="RFND_CON" name="RFND_CON"/>
							<input type="hidden" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM}"/>
							<input type="hidden" name="RFND_AMT" value="${list.ORDER_AMT}"/>
							<input type="hidden" name="PD_CODE" value="${list.PD_CODE}"/>
							<input type="hidden" name="OPTION1_VALUE" value="${list.OPTION1_VALUE}"/>
							<input type="hidden" name="OPTION2_VALUE" value="${list.OPTION2_VALUE}"/>
							<input type="hidden" name="OPTION3_VALUE" value="${list.OPTION3_VALUE}"/> 
							<input type="hidden" name="SUPR_ID" value="${list.SUPR_ID }"/>
							<input type="hidden" name="LOGIN_SUPR_ID" value="${login_supr_id }"/>
							<tr>
								<c:set var="cancelPrice"  value="${ cancelPrice + list.ORDER_AMT }"/>
								<td class="txt-middle">${loop.count }</td>
								<td class="txt-left">${list.PD_NAME }</td>
								<td class="txt-right">${list.ORDER_QTY }</td>
								<td class="txt-right"><fmt:formatNumber>${list.PD_PRICE }</fmt:formatNumber></td>
								<td class="txt-right"><fmt:formatNumber>${list.ORDER_AMT }</fmt:formatNumber></td>
								<c:set var="DLVY_COM_NAME" value="${ list.DLVY_COM_NAME }"/>
								<c:set var="CNCL_MSG" value="${ list.CNCL_MSG }"/>
							</tr>
						</c:forEach>
						<!-- 합계 -->
						<tr>
							<th class="txt-right" colspan="4">상품합계</th>
							<td class="txt-right" id="pdAmt">
								<fmt:formatNumber>${cancelPrice}</fmt:formatNumber>
								<input type="hidden" id="pdAmt2"  value="${cancelPrice}"/>
							</td>
						</tr>
						<tr>
							<th class="txt-right" colspan="4">반품배송비 </th>
							<td class="txt-right" id="dlvyAmt"> 
								<input type="text" class="form-control txt-right number" id="DLVY_AMT" name="RFND_DLVY_AMT" required="required"  onkeyup="keyevent(this);">
							</td>
						</tr>
						<tr>
							<th class="txt-right" colspan="4">환불예상금액 </th>
							<td class="txt-right" >
								<div id="totalAmt"><fmt:formatNumber>${cancelPrice}</fmt:formatNumber></div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<!-- 환불거절사유 -->
		<div class="modal fade" id="msgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">환불거절사유</h4>
					</div>
					<div class="modal-body">
		            	<textarea class="form-control" id="RFND_RMK" name="RFND_RMK" rows="5" placeholder="환불거절사유를 입력해주세요. (50자이내)"></textarea>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-info" id="btnSave" data-dismiss="modal">등록</button>
					</div>
				</div>
			</div>  	
		</div>
	</form>
	<!-- 주문상품 정보 끝 -->
	
	<!-- 반품 상세 정보 -->
	<c:if test="${ tb_odinfoxm.MEMB_GUBN eq 'MEMB_GUBN_04' }">
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">반품 상세 정보</h3>
			</div>
			<!-- /.box-header -->
			<div class="box-body">
				<br>-->
				<div class="form-group">
					<label for="CNCL_MSG" class="col-sm-2 control-label">반품 사유</label>
					<div class="col-sm-9">
							<pre>${empty CNCL_MSG ? '-' : CNCL_MSG}</pre>
					</div>
				</div>
				<br>
			</div>
			<!-- /.box-body -->
		</div>
	</c:if>
	<!-- 반품 상세 정보 끝 -->
	
	<!-- 관리자 처리정보 시작 -->
	<c:if test="${tb_odinfoxm.RFND_CON eq 'RFND_CON_02'}">
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">관리자 처리 정보</h3>
			</div>
			<!-- /.box-header -->
			<div class="box-body">
				<div class="form-group">
					<label for="RECV_PERS" class="col-sm-2 control-label required">환불 거절 사유</label>
					<div class="col-sm-9">
						<pre>${tb_odinfoxm.RFND_RMK }</pre>
					</div>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
	</c:if>
	<!-- 관리자 처리정보 끝 -->
	
	<!-- 배송지 정보 시작 -->
	<div class="box box-info">
		<div class="box-header with-border">
			<h3 class="box-title">수취인 정보</h3>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<div class="form-group">
				<label for="RECV_PERS" class="col-sm-2 control-label required">받으시는 분</label>
				<div class="col-sm-9">${tb_oddlaixm.RECV_PERS }</div>
			</div>
			<br>
			<div class="form-group">
				<label for="COM_PN" class="col-sm-2 control-label required">주소</label>
				<div class="col-sm-9">
					[${tb_oddlaixm.POST_NUM}] ${tb_oddlaixm.BASC_ADDR } ${tb_oddlaixm.DTL_ADDR }
				</div>						
			</div>
			<br>
			<div class="form-group">
				<label for="RECV_CPON" class="col-sm-2 control-label required">휴대전화</label>
				<div class="col-sm-4">${tb_oddlaixm.RECV_CPON }</div>
				<label for="RECV_TELN" class="col-sm-1 control-label">일반전화</label>
				<div class="col-sm-4">${tb_oddlaixm.RECV_TELN }</div>					
			</div>
			<br>
			<div class="form-group">
				<label for="DLVY_MSG" class="col-sm-2 control-label">배송 메세지</label>
				<div class="col-sm-9">
					<pre>${empty tb_oddlaixm.DLVY_MSG ? '-' : tb_oddlaixm.DLVY_MSG}</pre>
				</div>
			</div>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- 배송지 정보 끝 -->
	
	<div class="box-footer" >
		<div class="pull-right">
			<a href="${contextPath}/adm/orderRfndMgr?${link}" class="btn btn-default"><i class="fa fa-list"></i> 목록</a>
		</div>
	</div>
</section>
 
<script type="text/javascript">
$(function() {	
	
	$("#DLVY_AMT").change(function(){
		if($("#DLVY_AMT").val() == ""){
			alert("반품배송비를 입력해주세요.");
			$("#DLVY_AMT").focus();
			return false;
		}
		keyevent();
	});
	
	$("#btnReject").click(function(){
		$("#RFND_CON").val($(this).val());
		$("#msgModal").modal('show');
	});
	
	$("#btnSave").click(function(){
		if($("#RFND_RMK").val() == ""){
			alert("환불거절사유를 입력해주세요. (50자이내)");
			$("#RFND_RMK").focus();
			return false;
		}
		if(!confirm("환불거절 하시겠습니까?")) return;
		$("#ORDER_CON").val("ORDER_CON_11");
		$("#refundFrm").attr("action", "${contextPath}/adm/orderRfndMgr");
		$("#refundFrm").submit();
	});
	
	$("#btnRefund").click(function(){
		if(!confirm("환불완료처리 하시겠습니까?")) return;
		$("#ORDER_CON").val("ORDER_CON_07");
		$("#RFND_CON").val($(this).val());
		$("#refundFrm").attr("action", "${contextPath}/adm/orderRfndMgr");
		$("#refundFrm").submit();
	});
	
	$("#pgCancel").click(function(){
		if(!confirm("환불완료처리 하시겠습니까?")) return;
		$("#ORDER_CON").val("ORDER_CON_07");
		$("#RFND_CON").val($(this).val());
		$("#refundFrm").attr("action", "${contextPath}/adm/orderRfndMgr/pgCancel");
		$("#refundFrm").submit();
	});
	
	/* 20211216:장보라 */
	//option배열길이 구하기
	var options_length=$('input[name=OPTION1_VALUE]').length;
	//option의 값이 없을 경우 - 값넣기 (배열 length길이 맞춰야해서 )
	for(var i=0; i<options_length; i++){
		if($('input[name=OPTION1_VALUE]').eq([i]).val() == ""){
			$('input[name=OPTION1_VALUE]').eq([i]).attr('value','-');
		}
		if($('input[name=OPTION2_VALUE]').eq([i]).val() == ""){
			$('input[name=OPTION2_VALUE]').eq([i]).attr('value','-');
		}
		if($('input[name=OPTION3_VALUE]').eq([i]).val() == ""){
			$('input[name=OPTION3_VALUE]').eq([i]).attr('value','-');
		}
	}
	
	//숫자만 입력하도록
	  $(document).on("keyup", ".number", function() {
	       $(this).number(true);
	    });
	
});

function fnValidationCheck(){
	if($("#DLVY_AMT").val() == ""){
		alert("반품배송비를 입력해주세요.");
		$("#DLVY_AMT").focus();
		return false;
	}
}


//배송비관련 이벤트 (20211208 장보라 / 20211213 이유리)
function keyevent(){
	
	var pd_amt=document.getElementById("pdAmt2").value; //상품합계
	var dlvy_amt= document.getElementById("DLVY_AMT").value; //배송비
	dlvy_amt=dlvy_amt.replace(/,/g, ""); //콤마제거
	var total_amt =Number(pd_amt) - Number(dlvy_amt); //상품합게 - 배송비
 	var cn1 = total_amt.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");  //천단위 콤마
 	document.getElementById("totalAmt").innerText=cn1;
} 

/* 숫자콤마만드는 함수 */
function addComma(num) {
	var regexp = /\B(?=(\d{3})+(?!\d))/g;
	return num.toString().replace(regexp, ',');
}




</script>


<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<form role="form" name="waybillFrm" id="waybillFrm" method="POST" action="/adm/orderRfndMgr/updateWaybill" autocomplete="off">
			<input type="hidden" name="MEMB_ID" value="${tb_odinfoxm.MEMB_ID}">
			<input type="hidden" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM}">
			<input type="text" name="PAY_MDKY" value="${tb_odinfoxm.PAY_MDKY }"/><!--주문번호 key값  -->1212
			<input type="hidden" name="DLVY_CON" value="DLVY_CON_02"><!-- 상품발송 -->
			
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">반품 정보 등록</h4>
				</div>
				<div class="modal-body">
					<jsp:include page="${contextPath}/common/comCodForm">
						<jsp:param name="COMM_CODE" value="DLVY_COM" />
						<jsp:param name="name" value="DLVY_COM" />
						<jsp:param name="value" value="${tb_odinfoxm.DLVY_COM}" />
						<jsp:param name="type" value="select" />
						<jsp:param name="top" value="택배사 선택" />
					</jsp:include>
					<br>
	            	<input type="text" class="form-control" name="DLVY_TDN" value="${tb_odinfoxm.DLVY_TDN}" placeholder="운송장번호('-'없이 숫자만 입력)"/>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-info" id="btnDlvy" data-dismiss="modal">등록</button>
				</div>
			</div>
		</form>
	</div>  	
</div> 
