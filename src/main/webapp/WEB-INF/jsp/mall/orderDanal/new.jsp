<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<script src="http://www.cjfls.co.kr/resources/js/addr_check2.js"></script>


<script type="text/javascript">
$(function() {
	
	if("${USER.MEMB_ID}" == ""){
		alert("로그인이 필요합니다.");
		
		location.href = "${contextPath}/user/loginForm";
		
		return false;
	}else{
		fn_dlarGubn();
	}
	fn_dlvy_cal();	//추석선물세트 가격계산
	$("#DAP_YN").change(function(){
		//alert($(this).val());

		var orderSum = parseInt($("#ORDER_SUM").val());		//주문금액
		var dlvyAmt = ${supplierInfo.DLVY_AMT };			//배송비
	    
		if($(this).val() == 'N'){
			dlvyAmt = 0;
		}
		
		var totAmt = orderSum + dlvyAmt;
		
		$("#tdTotAmt").text("총 상품 구매액 " + number_format(String(orderSum)) + "원 + 배송비 " +  number_format(String(dlvyAmt)) + "원 = " + number_format(String(totAmt)) + "원");
		$("#ORDER_AMT").val(totAmt);
	});
	
    $("#btnSave").click(function() {

    	//필수입력 체크
		if($("#RECV_PERS").val() == "") {
            alert("받으시는분은 필수 입력 항목입니다.");
            $("#RECV_PERS").focus();
            return false;
		}

		if($("#POST_NUM").val() == "") {
            alert("우편번호는 필수 입력 항목입니다.\n주소검색을 클릭하여 우편번호를 입력하세요.");
            $("#POST_NUM").focus();
            return false;
		}

		if($("#RECV_TELN1").val() == "" || $("#RECV_TELN2").val() == "" || $("#RECV_TELN3").val() == "") {
            alert("전화번호는 필수 입력 항목입니다.");
            $("#RECV_TELN1").focus();
            return false;
		}
		
		if($("#RECV_CPON1").val() == "" || $("#RECV_CPON2").val() == "" || $("#RECV_CPON3").val() == "") {
            alert("휴대폰번호는 필수 입력 항목입니다.");
            $("#RECV_CPON1").focus();
            return false;
		}
		if($('input[name="DLAR_TIME"]').val()=='nothing'){
			alert("배송시간/출고시간은 필수항목입니다.");
			return false;
		}

		var orderAmt = $("#ORDER_AMT").val();
		var dlvyAmt = $("#DLVY_AMT").val();
		var dapYn = 'Y';//$("#DAP_YN").val();
		
		if(dapYn == 'Y'){
			
		}
		
		
		if(orderAmt > 5000000){
            alert("총 구매 금액이 5,000,000원을 넘을 수 없습니다.");
            //$("#agree").focus();
            return false;
		}
		
		var pdc_gbn = $('input[name=PDDC_GUBNS]');
		var dlvy_total_amt = 0;
		for(var i=0; i<pdc_gbn.length;i++){
			if(pdc_gbn[i].value !='PDDC_GUBN_05'){		//추석선물세트만이 아닐때
				if (!addr_Daejun($("#POST_NUM").val()))	//기존로직
		        {
					alert('대전외 지역은 8월 이후부터 배송 가능합니다. \n\r양해부탁드리겠습니다.');
		           return;
		        }
			}
		}

		
    	if(!confirm('결제를 하시겠습니까?')) {
            return false;
    	}
    	
    	$('#RECV_TELN').val($('#RECV_TELN1').val()+"-"+$('#RECV_TELN2').val()+"-"+$('#RECV_TELN3').val());
    	$('#RECV_CPON').val($('#RECV_CPON1').val()+"-"+$('#RECV_CPON2').val()+"-"+$('#RECV_CPON3').val());
    	
    	// OID, TIMESTA
    	
    	// 결제창 호출
    	document.getElementById("fregisterform").submit();
    });
    
    $("#btnCancel").click(function() {
    	window.history.back();
    });
    
    //배송시간 defualt
    //fn_dlarGubn();
    fn_dlarTime();
    fn_dlarDate();
});

function LPad(digit, size, attatch) {
    var add = "";
    digit = digit.toString();

    if (digit.length < size) {
        var len = size - digit.length;
        for (i = 0; i < len; i++) {
            add += attatch;
        }
    }
    return add + digit;
}

function makeoid() {
	var now = new Date();
	var years = now.getFullYear();
	var months = LPad(now.getMonth() + 1, 2, "0");
	var dates = LPad(now.getDate(), 2, "0");
	var hours = LPad(now.getHours(), 2, "0");
	var minutes = LPad(now.getMinutes(), 2, "0");
	var seconds = LPad(now.getSeconds(), 2, "0");
	var timeValue = years + months + dates + hours + minutes + seconds; 
	document.getElementById("LGD_OID").value = "test_" + timeValue;
	document.getElementById("LGD_TIMESTAMP").value = timeValue;
}

function fn_dlarGubn(){
	
	if($("input:radio[name='DLAR_GUBN']:checked").val()=='DLAR_GUBN_05'){
		$('#dlarGugn5').show();
		$('#dlarGugn1234').hide();
		
		$('input[name="DLAR_DATE"]').val($('#DLAR_DATE_CHK').val());
		
	}else{
		$('#dlarGugn5').hide();
		$('#dlarGugn1234').show();
		
		$('input[name="DLAR_DATE"]').val('');
		
	}
	
	$.ajax({
		type: "POST",
	    dataType: 'json',
		url: '${contextPath}/order/deliveryAddr.json',
		data: $("#fregisterform").serialize(),
		success: function (data) {

			if(data.recv_PERS == "" && $("input:radio[name='DLAR_GUBN']:checked").val() == "DLAR_GUBN_03"){
				alert("주문내역이 없습니다.");
			}
			
			$('#RECV_TELN1').val("");
			$('#RECV_TELN2').val("");
			$('#RECV_TELN3').val("");
			$('#RECV_CPON1').val("");
			$('#RECV_CPON2').val("");
			$('#RECV_CPON3').val("");
			// 배송지 정보
			
			$('#RECV_PERS').val(data.recv_PERS);
			$('#POST_NUM').val(data.post_NUM);
			$('#BASC_ADDR').val(data.basc_ADDR);
			$('#DTL_ADDR').val(data.dtl_ADDR);
			$('#RECV_TELN').val(data.recv_TELN);
			$('#RECV_CPON').val(data.recv_CPON);
			
			var recvTeln = data.recv_TELN;
			var slRecvTeln = recvTeln.split("-");

			$('#RECV_TELN1').val(slRecvTeln[0]);
			$('#RECV_TELN2').val(slRecvTeln[1]);
			$('#RECV_TELN3').val(slRecvTeln[2]);

			var recvCpon = data.recv_CPON;
			var slRecvCpon = recvCpon.split("-");

			$('#RECV_CPON1').val(slRecvCpon[0]);
			$('#RECV_CPON2').val(slRecvCpon[1]);
			$('#RECV_CPON3').val(slRecvCpon[2]);

			
		}, error: function (jqXHR, textStatus, errorThrown) {
			alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
		}
	});
}
function fn_dlarTime(){
	if($("input:radio[name='DLAR_GUBN']:checked").val()=='DLAR_GUBN_05'){
		$('input[name="DLAR_TIME"]').val($('#DLAR_TIME_CHK_01').val());
	}else{
		$('input[name="DLAR_TIME"]').val($('#DLAR_TIME_CHK_02').val());
	}
}
function fn_dlarDate(){
	if($("input:radio[name='DLAR_GUBN']:checked").val()=='DLAR_GUBN_05'){
		$('input[name="DLAR_DATE"]').val($(':radio[name="DLAR_DATE_CHK"]:checked').val());
	}else{		
		$('input[name="DLAR_DATE"]').val('');
	}
}
function fn_dlvy_cal(){	//추석선물세트 가격계산 (9월)
	//추석선물세트(9월 한달)
	var pdc_gbn = $('input[name=PDDC_GUBNS]');
	var dlvy_total_amt = 0;
	var bndl_flag = 0;				//묶음 구별자
	for(var i=0; i<pdc_gbn.length;i++){
		if(pdc_gbn[i].value !='PDDC_GUBN_05'){		//추석선물세트만이 아닐때
			if (!addr_Daejun($("#POST_NUM").val()))	//기존로직
	        {
	           return;
	        }
	
		}else{		// 추석선물세트만 있을때 배송비 로직 변경
			if (!addr_Daejun($("#POST_NUM").val()))		//대전이 아닐경우		
	        {
				if($('input[name=BUNDLE_CNTS]')[i].value==null||$('input[name=BUNDLE_CNTS]')[i].value==''){	//묶음이 없을때
	
				}else{
					bndl_flag++;
					
					var prd_cnt = parseInt($('input[name=ORDER_QTYS]')[i].value/$('input[name=BUNDLE_CNTS]')[i].value);
					if($('input[name=ORDER_QTYS]')[i].value%$('input[name=BUNDLE_CNTS]')[i].value==0){	// 나머지가 없으면
						var dlvy_amt = prd_cnt*2500;
					}else{
						var dlvy_amt = (prd_cnt+1)*2500;	
					}
					
					
					dlvy_total_amt = dlvy_total_amt + dlvy_amt;	
				}
	        }else{//대전지역이면 기존로직
	        	return;
	        }
			
		}
	}//for end..
	
	if(bndl_flag == 0 && !addr_Daejun($("#POST_NUM").val()) ){// 묶음배송이 하나도 없는경우		
		dlvy_total_amt = 2500;
	}
	var orderSum = parseInt($("#ORDER_SUM").val());		//주문금액
	//var dlvyAmt = ${supplierInfo.DLVY_AMT };			//배송비
	
	var totAmt = orderSum + dlvy_total_amt;
	
	$("#devy_amt").text(number_format(String(dlvy_total_amt)));
	$("#tdTotAmt").text("총 상품 구매액 " + number_format(String(orderSum)) + "원 + 배송비 " +  number_format(String(dlvy_total_amt)) + "원 = " + number_format(String(totAmt)) + "원");
	$("#ORDER_AMT").val(totAmt);
	$("#DLVY_AMT").val(dlvy_total_amt);
	console.log("표시완료");
	//..end 추석선물세트(9월)
}
</script>


<c:set var="strActionUrl" value="${contextPath }/order" />
<c:set var="strMethod" value="post" />

<div class="sub-title sub-title-underline">
	<h2>주문하기 <small class="ml_5">| 주문하기</small>	</h2>
	<ul>
		<li><a href='${contextPath }' class="sct_bg">Home</a></li>
		<li><a href="${contextPath }/order" class=" ">주문하기</a></li>
	</ul>
	<div class="clearfix"></div>
</div>
<br>
<div class="sub-title">
	<h2>주문상품정보</h2>
</div>

<form method="post" name="fregisterform" id="fregisterform" action="${contextPath }/order/insert">

	<table class="table table-order">
		<thead>
			<tr>
				<th scope="col">상품명</th>
				<th scope="col">수량</th>
				<th scope="col">판매가</th>
				<th scope="col">상품구매금액</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="tot_amt" value="0" />
			<c:forEach items="${obj.list }" var="list" varStatus="loop">
				<c:set var="order_qty" value="${list.ORDER_QTY}" />
				<c:set var="pd_cut_seq" value="${list.PD_CUT_SEQ}" />
				<c:set var="option_code" value="${list.OPTION_CODE}" />
				<c:if test="${!empty param.ORDER_QTY }">
					<c:set var="order_qty" value="${ param.ORDER_QTY}" />
				</c:if>
				<c:if test="${!empty param.PD_CUT_SEQ }">
					<c:set var="pd_cut_seq" value="${ param.PD_CUT_SEQ}" />
				</c:if>
				<c:if test="${!empty param.OPTION_CODE }">
					<c:set var="option_code" value="${ param.OPTION_CODE}" />
				</c:if>
				
				<tr>
					<td>
						<input type="hidden" id="BSKT_REGNO" name="BSKT_REGNO" value="${list.BSKT_REGNO }">
						<input type="hidden" id="PD_CODES" name="PD_CODES" value="${list.PD_CODE }">
						<input type="hidden" id="PD_NAMES" name="PD_NAMES" value="${list.PD_NAME}" />
						<input type="hidden" id="PD_PRICES" name="PD_PRICES" value="${list.PD_PRICE}" />
						<input type="hidden" id="PDDC_GUBNS" name="PDDC_GUBNS" value="${list.PDDC_GUBN}" />
						<input type="hidden" id="PDDC_VALS" name="PDDC_VALS" value="${list.PDDC_VAL}" />
						<input type="hidden" id="ORDER_QTYS" name="ORDER_QTYS" value="${order_qty}" />
						<input type="hidden" id="ORDER_AMTS" name="ORDER_AMTS" value="${order_qty * list.REAL_PRICE}" />
						<%-- <input type="hidden" id="PD_CUT_SEQS" name="PD_CUT_SEQS" value="${list.PD_CUT_SEQ}" /> --%>
						<input type="hidden" id="PD_CUT_SEQS" name="PD_CUT_SEQS" value="${pd_cut_seq}" />
						<input type="hidden" id="OPTION_CODES" name="OPTION_CODES" value="${option_code}" />
						<input type="hidden" id="BUNDLE_CNTS" name="BUNDLE_CNTS" value="${list.BUNDLE_CNT}" />
						
						<b>${list.PD_NAME }
							<c:if test="${list.PD_CUT_SEQ_UNIT ne null }"><br/>( 세절방식 : ${list.PD_CUT_SEQ_UNIT } )</c:if>
							<c:if test="${param.PD_CUT_SEQ_UNIT ne null && fn:length(param.PD_CUT_SEQ_UNIT)>0}"><br/>( 세절방식 : ${param.PD_CUT_SEQ_UNIT } )</c:if>
							
							<c:if test="${list.OPTION_NAME ne null }"><br/>( 색상 : ${list.OPTION_NAME } )</c:if>
							<c:if test="${param.OPTION_NAME ne null && fn:length(param.OPTION_NAME)>0}"><br/>( 색상 : ${param.OPTION_NAME } )</c:if>
						</b> 
					</td>
					<td><fmt:formatNumber value="${order_qty }" /></td>
					<td><fmt:formatNumber value="${list.REAL_PRICE }" /></td>
					<td><fmt:formatNumber value="${order_qty * list.REAL_PRICE }" /></td>
				</tr>
				<c:set var="tot_amt" value="${tot_amt + (order_qty * list.REAL_PRICE) }" />
			</c:forEach>
			<tr>
				<td class="td_num" colspan="3">배송비(<fmt:formatNumber value="${supplierInfo.DLVA_FCON }" />원 이상 무료)</td>
				<td class="td_num">
				<c:set var="devy_amt" value="0" />
				<c:if test="${ tot_amt < supplierInfo.DLVA_FCON }"><%-- <c:if test="${ tot_amt < 100000 }"> --%>
					<c:set var="devy_amt" value="${supplierInfo.DLVY_AMT }" />
				</c:if>
				
				<c:if test="${ tot_amt >= supplierInfo.DLVA_FCON }">
					<c:set var="devy_amt" value="0" />
					<!-- <input type="text" id="DAP_YN" name="DAP_YN" value="N" /> -->
				</c:if>
				<p id="devy_amt"><fmt:formatNumber value="${devy_amt }" /><br/></p>
				
				<input type="hidden" id="DAP_YN" name="DAP_YN" value="Y"/><!-- 모두 선불로 통일 20180516 -->
				</td>
			</tr>
			<tr>
				<td colspan="4" id="tdTotAmt">총 상품 구매액 <fmt:formatNumber value="${tot_amt }" />원 + 배송비 <fmt:formatNumber value="${devy_amt }" />원 = <fmt:formatNumber value="${tot_amt + devy_amt }" />원 </td>
			</tr>
				
			<input type="hidden" id="ORDER_SUM" name="ORDER_SUM" value="${tot_amt}"/>				<!-- 주문금액 함 -->
			<input type="hidden" id="DLVY_AMT" name="DLVY_AMT" value="${devy_amt}"/>				<!-- 배송비 -->
			
			<input type="hidden" id="ORDER_AMT" name="ORDER_AMT" value="${tot_amt + devy_amt}"/>	<!-- 결제금액 -->
		</tbody>
	</table>

	<div class="company mb_30">
		<div class="sub-title">
	    	<h2>배송지 정보</h2>
		</div>
	    <table class="table table-intro">
		     <tbody>
				 <tr class="tb_topline">
			         <th style="width:150px">배송지정보</th>
			         <td colspan="3">
						<label class="radio-inline">
							<input type="radio" id="DLAR_GUBN" name="DLAR_GUBN" value="DLAR_GUBN_01" onchange="javascript:fn_dlarGubn();" checked="checked"/>자택 
						</label>
						<label class="radio-inline">
							<input type="radio" id="DLAR_GUBN" name="DLAR_GUBN" value="DLAR_GUBN_02" onchange="javascript:fn_dlarGubn();"/>회사
						</label>
						<label class="radio-inline">
							<input type="radio" id="DLAR_GUBN" name="DLAR_GUBN" value="DLAR_GUBN_03" onchange="javascript:fn_dlarGubn();"/>최근배송지
						</label>
						<label class="radio-inline">
							<input type="radio" id="DLAR_GUBN" name="DLAR_GUBN" value="DLAR_GUBN_04" onchange="javascript:fn_dlarGubn();"/>신규
						</label>
						<!-- <label class="radio-inline">
							<input type="radio" id="DLAR_GUBN" name="DLAR_GUBN" value="DLAR_GUBN_05" onchange="javascript:fn_dlarGubn();"/>현장출고
						</label> -->
			         </td>
			     </tr>
			     <tr>
			         <th style="width:150px">받으시는분*</th>
			         <td colspan="3">
			             <input type="text" name="RECV_PERS" value="" id="RECV_PERS" required class="form-control input-sm" style="width:300px;" minlength="3" maxlength="20">
			         </td>
			     </tr>
			     <tr>
			         <th>주소*</th>
			         <td colspan="3">
						<input type="hidden" name="COM_EXTRA_ADDR" value="" id="COM_EXTRA_ADDR">
						<input type="hidden" name="COM_ALL_ADDR" value="" id="COM_ALL_ADDR">
						<div class="form-inline">
							<div class="form-group">
								<p class="form-control-static">우편번호</p>
							</div>
							<div class="form-group">
								<input type="text" name="POST_NUM" value="" id="POST_NUM"required readonly="readonly" class="form-control input-sm" style="width: 70px;" size="5" maxlength="6">
							</div>
							<button type="button" class="btn btn-sm btn-default" onclick="win_zip('fregisterform', 'POST_NUM', 'BASC_ADDR', 'DTL_ADDR', 'COM_EXTRA_ADDR', 'COM_ALL_ADDR');">주소검색</button>
						</div> 
						<div class="form-inline">
							<div class="form-group">
								<input type="text" name="BASC_ADDR" value="" id="BASC_ADDR" required readonly="readonly" class="form-control input-sm" style="width:300px;" size="50" placeholder="기본주소">
							</div>
							<div class="form-group">
								<p class="form-control-static">기본주소</p>
							</div>
						</div> 
						<div class="form-inline">
							<div class="form-group">
								<input type="text" name="DTL_ADDR" value="" id="DTL_ADDR" required class="form-control input-sm" style="width:300px;" size="50" placeholder="상세주소">
							</div>
							<div class="form-group">
								<p class="form-control-static">상세주소</p>
							</div>
						</div> 
			         </td>
			     </tr>
			    <tr>
			         <th>전화번호*</th>
			         <td>
						<div class="form-inline">
				         	<input type="hidden" name="RECV_TELN" value="" id="RECV_TELN" required class="form-control input-sm"  maxlength="20">
				         	<input type="text" name="RECV_TELN1" value="" id="RECV_TELN1" required class="form-control input-sm"  style="width:50px;" maxlength="4">&nbsp;-&nbsp;
				         	<input type="text" name="RECV_TELN2" value="" id="RECV_TELN2" required class="form-control input-sm"  style="width:50px;" maxlength="4">&nbsp;-&nbsp;
				         	<input type="text" name="RECV_TELN3" value="" id="RECV_TELN3" required class="form-control input-sm"  style="width:50px;" maxlength="4">
			         	</div>
			         </td>
			         <th scope="row">휴대폰번호*</th>
			         <td>
						<div class="form-inline">
				             <input type="hidden" name="RECV_CPON" value="" id="RECV_CPON" required class="form-control input-sm" maxlength="20">
				             <input type="text" name="RECV_CPON1" value="" id="RECV_CPON1" required class="form-control input-sm" style="width:50px;"  maxlength="4">&nbsp;-&nbsp;
				             <input type="text" name="RECV_CPON2" value="" id="RECV_CPON2" required class="form-control input-sm" style="width:50px;"  maxlength="4">&nbsp;-&nbsp;
				             <input type="text" name="RECV_CPON3" value="" id="RECV_CPON3" required class="form-control input-sm" style="width:50px;"  maxlength="4">
			             </div>
			         </td>
			    </tr>
			    <tr class="tb_line">
			         <th>배송 메세지</th>
			         <td colspan="3">
			             <textarea id="DLVY_MSG" name="DLVY_MSG" rows="10" cols="20" style="width:600px; height:47px"></textarea>
			         </td>
			    </tr>
				<tr class="tb_line" id="dlarGugn5">
					<th>출고시간</th>
					<td colspan="6">
						<div class="form-inline">
							<label class="radio-inline">
								<input type="radio" id="DLAR_DATE_CHK" name="DLAR_DATE_CHK" value="DLAR_DATE_01" checked="checked" onchange="javascript:fn_dlarDate();"/>명일
							</label>
							<label class="radio-inline">
								<input type="radio" id="DLAR_DATE_CHK" name="DLAR_DATE_CHK" value="DLAR_DATE_02" onchange="javascript:fn_dlarDate();"/>당일
							</label>
							&nbsp;&nbsp;&nbsp;
							<select id="DLAR_TIME_CHK_01" class="form-control input-sm" onchange="javascript:fn_dlarTime();">
								<option value="nothing">선택</option>
								<option value="PM 1시~2시">PM 1시~2시</option>
								<option value="PM 2시~3시">PM 2시~3시</option>
								<option value="PM 3시~4시">PM 3시~4시</option>
								<option value="PM 4시~6시">PM 4시~6시</option>
				        	</select>
			        	</div>
			        </td>
				</tr>
				<tr class="tb_line" id="dlarGugn1234">
					<th>배송시간</th>
					<td colspan="6">
						<div class="form-inline">
							<select name="DLAR_TIME_CHK_02" id="DLAR_TIME_CHK_02" class="form-control input-sm" onchange="javascript:fn_dlarTime();">
								<option value="nothing">선택</option>
								<option value="오전">오전</option>
								<option value="오후">오후</option>
								<option value="5시~6시">5시~6시</option>
								<!-- <option value="AM 10시~12시">AM 10시~12시</option>
								<option value="PM 1시~3시">PM 1시~3시</option>
								<option value="PM 3시~5시">PM 3시~5시</option>
								<option value="PM 5시~6시">PM 5시~6시</option> -->
				        	</select>
				        	<p style="font-size:12px;margin:3px;margin-top:10px">
				        		고객님의 상품도착시간이 당일 배송수량과 교통상황에 따라 요청하신 시간에 도착하지 못할수 있습니다. 
				        		양해부탁드립니다.
				        	</p>
			        	</div>
			        </td>
				 </tr>
		     </tbody>
	    </table>
		<input type="hidden" name="DLAR_DATE" value=""/>
		<input type="hidden" name="DLAR_TIME" value=""/>
	</div>
    <div class="text-center">
        <input type="button" id="btnSave" class="btn btn-sm btn-default" value="결제하기">
        <a href="#" id="btnCancel" class="btn btn-sm btn-default">주문취소</a>
    </div>

</form>

<!-- <script type="text/javascript">
fn_dlarGubn();
</script> -->