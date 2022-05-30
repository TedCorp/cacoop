<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<script type="text/javascript">



$(function() {
	
	$("#btnPay").click(function(){
		if(confirm('결제를 하시겠습니까??')) {
			// OID, TIMESTAMP 생성
			makeoid();
			// 결제창 호출
			$("#payForm").submit();

		}
	});


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
</script>

<spform:form id="payForm" name="payForm" method="POST" action="${contextPath}/pay/payReq" role="form">
	<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="000001"/>
	<input type="hidden" id="MEMB_NM" name="MEMB_NM" value="홍길도"/>
	
	<table class="tstyle_view">
		<caption>
			분석의뢰 결제처리
		</caption>
		<colgroup>
			<col width="25%">
			<col width="*">
		</colgroup>
		<tbody>

			<tr>
				<th>상점아이디</th>
				<td colspan="3">
					<input type="text" name="CST_MID" id="CST_MID" value="cjh3474" class="input_long"/>
				</td>
			</tr>
			<tr>
				<th>서비스,테스트 </th>
				<td colspan="3">
					<input type="text" name="CST_PLATFORM" id="CST_PLATFORM" value="test" class="input_long"/>
				</td>
			</tr>
			<tr>
				<th>구매자 이름</th>
				<td colspan="3">
					<input type="text" name="LGD_BUYER" id="LGD_BUYER" value="${myInfo.userName }" class="input_long"/>
				</td>
			</tr>
			<tr>
				<th>상품정보</th>
				<td colspan="3">
					<input type="text" name="LGD_PRODUCTINFO" id="LGD_PRODUCTINFO" value="장비분석비용" class="input_long"/>
				</td>
			</tr>
			<tr>
				<th>결제금액</th>
				<td colspan="3">
					<input type="text" name="LGD_AMOUNT" id="LGD_AMOUNT" value="${rtnResv[0].RESVPRICE}" class="input_long"/>
				</td>
			</tr>
			
			<tr>
				<th>구매자 이메일</th>
				<td colspan="3">
					<input type="text" name="LGD_BUYEREMAIL" id="LGD_BUYEREMAIL" value="" class="input_long"/>
				</td>
			</tr>
			<tr>
				<th>주문번호</th>
				<td colspan="3">
					<input type="text" name="LGD_OID" id="LGD_OID" value="${rtnResv[0].SEQNO}" class="input_long"/>
				</td>
			</tr>
			<tr>
				<th>타임스탬프</th>
				<td colspan="3">
					<input type="text" name="LGD_TIMESTAMP" id="LGD_TIMESTAMP" value="1234567890" class="input_long"/>
				</td>
			</tr>
			<tr>
				<th>결제수단</th>
				<td colspan="3">
					<select name="LGD_CUSTOM_USABLEPAY" id="LGD_CUSTOM_USABLEPAY">
						<option value="SC0010">신용카드</option>		
					</select>
				</td>
			</tr>
			
		</tbody>
	</table>
</spform:form>

<div class="btn_area_right">  
    <button type="button" class="btn_type01" id="btnPay">결제하기</button>
</div>
