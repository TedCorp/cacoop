<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>


<script language="javascript" src="https://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<script type="text/javascript">

/*
* 수정불가.
*/
	var LGD_window_type = '<c:out value="${LGD_WINDOW_TYPE}" />';
	
/*
* 수정불가
*/
function launchCrossPlatform(){
	lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), '<c:out value="${CST_PLATFORM}" />', LGD_window_type, null, "", "");
}
/*
* FORM 명만  수정 가능
*/
function getFormObject() {
        return document.getElementById("LGD_PAYINFO");
}

/*
 * 인증결과 처리
 */
function payment_return() {
	var fDoc;
	
	fDoc = lgdwin.contentWindow || lgdwin.contentDocument;
	
	if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {
			document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById('LGD_PAYKEY').value;
			document.getElementById("LGD_PAYINFO").target = "_self";
			document.getElementById("LGD_PAYINFO").action = "${contextPath}/pay/payRes";
			document.getElementById("LGD_PAYINFO").submit();
	} else {
		alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
		closeIframe();
	}
}

</script>

<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="payres.jsp">
	<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="000001"/>
	<input type="hidden" id="MEMB_NM" name="MEMB_NM" value="홍길동"/>
	<input type="hidden" id="CST_MID" name="CST_MID" value="lgdacomxpay"/>
	<input type="hidden" id="CST_PLATFORM" name="CST_PLATFORM" value="test"/>
	
	<table class="tstyle_view">
		<caption>
			결제정보
		</caption>
		<colgroup>
			<col width="25%">
			<col width="*">
		</colgroup>
		<tbody>
			<tr>
				<th>구매자 이름 </th>
        		<td><c:out value="${LGD_BUYER}" /></td>
			</tr>
			<tr>
				<th>상품정보</th>
				<td><c:out value="${LGD_PRODUCTINFO}" /></td>
			</tr>
			<tr>
				<th>결제금액</th>
				<td><fmt:formatNumber value="${ LGD_AMOUNT }" pattern="#,###"/>원</td>
			</tr>
			<tr>
				<th>구매자 이메일</th>
				<td><c:out value="${LGD_BUYEREMAIL}" /></td>
			</tr>
			<tr>
				<th>주문번호</th>
				<td><c:out value="${LGD_OID}" /></td>
			</tr>
			<tr>
		        <td colspan="2">
				<input type="button" value="인증요청" onclick="launchCrossPlatform();"/>
		        </td>
		    </tr>
			
		</tbody>
	</table>
	
<c:forEach items="${PAYREQ_MAP }" var="data" varStatus="loop">
	<input type="hidden" id="${data.key }" name="${data.key }" value="${data.value }" />
</c:forEach>
					
<%
	//for(Iterator i = payReqMap.keySet().iterator(); i.hasNext();){
	//	Object key = i.next();
	//	out.println("<input type='hidden' name='" + key + "' id='"+key+"' value='" + payReqMap.get(key) + "'>" );
	//}
%>
</form>

<div class="btn_area_right">  
    <!--button type="button" class="btn_type01" id="btnCancel">예약 취소</button>
	<button type="button" class="btn_type01" id="btnAppr">예약 승인</button>
	<button type="button" class="btn_type01" id="btnAnsRst">분석이용완료</button>
	<button type="button" class="btn_type01" id="btnPayComp">결제 완료</button>
	<button type="button" class="btn_type01" id="btnChange">예약 수정</button-->
	<button type="button" class="btn_type01" id="btnList">목록</button>
</div>

<spform:form id="listForm" name="listForm" method="GET" action="${contextPath}/resv/myResvList">
    <input type="hidden" name="menuId" value="${obj.menuId}" />
</spform:form>

<script type="text/javascript">

	/**
	 * 파라미터 가져오기
	 * @param parameterText
	 */
	this.getParameter = function(key){
	    var _parammap = {};
	    document.location.search.replace(/\??(?:([^=]+)=([^&]*)&?)/g, function () {
	    	
	        function decode(s) {
	            return decodeURIComponent(s.split("+").join(" "));
	        }
	        _parammap[decode(arguments[1])] = decode(arguments[2]);
	    });
	
	    return _parammap[key];
	};

	var key = getParameter("key"); 
	
	if(key){
		$("input[name=key]").val(key);
	}

	$(function() {
				
		$("#btnCancel").click(function(){
			if(!confirm("예약 취소 하시겠습니까?")) {
				return false;
			}

			var form = document.resvForm;
			form.action = getReserveManageUrl($("input[name=seqNo]").val(), 'cancel', $("input[name=key]").val());
			form.submit();
		});
		
		$("#btnAppr").click(function(){
			if(!confirm("예약 승인 하시겠습니까?")) {
				return false;
			}

			var form = document.resvForm;
			form.action = getReserveManageUrl($("input[name=seqNo]").val(), 'approve', $("input[name=key]").val());
			form.submit();
		});
		
		$("#btnAnsRst").click(function(){
			if(!confirm("이용분석완료 하시겠습니까?")) {
				return false;
			}

			var form = document.resvForm;
			form.action = getReserveManageUrl($("input[name=seqNo]").val(), 'succes', $("input[name=key]").val());
			form.submit();
		});
		
		$("#btnPayComp").click(function(){
			if(!confirm("결제 완료 하시겠습니까?")) {
				return false;
			}

			var form = document.resvForm;
			form.action = getReserveManageUrl($("input[name=seqNo]").val(), 'payment', $("input[name=key]").val());
			form.submit();
		});
		
		$("#btnPayGo").click(function(){
			if(!confirm("결제 하시겠습니까?")) {
				return false;
			}

			var form = document.resvForm;
			form.action = "${contextPath}/pay/Form";
			form.submit();
		});
		
		$("#btnChange").click(function(){
			if(!confirm("예약 수정 하시겠습니까?")) {
				return false;
			}

			var form = document.resvForm;
			form.action = getReserveFormUrl($("input[name=seqNo]").val());
			form.submit();
		});
		
		$("#btnList").click(function(){
			$("#listForm").submit();
		});
	});
	
	//나모첨부파일 시작
	$(window).load(function(){
		createNamoCrossUploader(
		   	"crossUploadManager",   // NamoCrossUploader의 Manager 객체 Id
	     	"crossUploadMonitor",   // NamoCrossUploader의 Monitor 객체 Id 
		    "flashContentManager",  // NamoCrossUploader의 Manager 객체가 위치할 HTML Id (body 태크 내에 선언된 Id와 동일해야 함)
		    "flashContentMonitor"   // NamoCrossUploader의 Monitor 객체가 위치할 HTML Id (body 태크 내에 선언된 Id와 동일해야 함)
	 	);
		
	});


	
	function fn_carrierSelect(element){
		if($(element).val() == 'A'){
			$("#carrier_tbl").show();
		}
		if($(element).val() == 'B'){
			$("#carrier_tbl").hide();
		}
	}

	
	/**
	 * 첨부파일 삭제 처리
	 * @param button
	 */
	this.delAttachmentRow = function(button){
	    $(button).parent("span").parent().css("display","none");
	    $(button).parent("span").parent().find("input:file").removeAttr("value");
	    /*$(button).parent("span").parent().find("input:hidden").each(function (index){
	        if($(this).attr("name").endsWith(".deleteYn")){
	            $(this).val("Y");
	        }
	    });*/
	};
	
	/**
	 * 첨부파일 입력란 추가
	 *  <ul>
	 *      <li>
	 *          <input type="file"/>
	 *          <button>+</button>
	 *          <button>-</button>
	 *      </li>
	 *  </ul>
	 *  형식에서 사용
	 * @param button
	 */
	var buttonDisplayStyle = "inline-block";
	this.addAttachmentRow = function(fileName, button){
	    
		var ul = $(button).parent("span").parent("li").parent("ul");
	    var rowIndex = $(ul).find("li").length;
	    var lastSeq = 0;
	    $(ul).find("li input[name$=\\.fileSeq]").each(function(index){
	        if(parseInt($(this).val()) > lastSeq){
	            lastSeq = parseInt($(this).val());
	        }
	    });
	    lastSeq++;
	    
	    var cloneHtml = $(ul).find("li:last").clone(true);
	    cloneHtml.find("input").each(function (index){
	        var id = $(this).attr("id");
	        $(this).attr("name", fileName + "[" + (rowIndex)+ "]" + id.substring(id.indexOf(".")));
	        $(this).attr("id", fileName + (rowIndex)+ id.substring(id.indexOf(".")));
	    });
	    
	    $(ul).append(cloneHtml);
	    $(ul).find("li:last").find("input#" + fileName + rowIndex +"\\.fileSeq").val(lastSeq);
	    $(ul).find("li:last").find("input:file").attr("value","");
	    $(ul).find("li:last").css("display","list-item");
	    
	    $(ul).find("li > span > button[name='delButton']").parent("span").css("display",buttonDisplayStyle);
	    $(ul).find("li > span > button[name='addButton']").parent("span").css("display","none");
	    $(ul).find("li:last > span > button[name='delButton']").parent("span").css("display","none");
	    $(ul).find("li:last > span > button[name='addButton']").parent("span").css("display",buttonDisplayStyle);

	    $(ul).find("li:last > div > input:hidden").each(function (index){
	        if($(this).attr("name").endsWith(".deleteYn")){
	            $(this).val("");
	        }
	    });
	};

    
	var prefixUrl = "http://127.0.0.1:8080/resv/api/equip";
    
    this.getReserveCancelUrl =  function(key) {
		return prefixUrl + '/reserve/add/' + key;
	};
	this.getReserveReqUrl =  function(key) {
		return prefixUrl + '/reserve/add/' + key;
	};
	this.getReserveManageUrl =  function(resvNo,actCode,key) {
		return prefixUrl + '/manager/' + resvNo + '/' + actCode + '/'+ key;
	};
	this.getReserveFormUrl =  function(resvNo) {
		return prefixUrl + '/reserve/add/form/';
	};
</script>