<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- 결제 기능 추가 -->
<div class="modal fade" id="divPayModal" tabindex="-1" role="dialog" aria-labelledby="myDivPay">
   <div class="modal-dialog modal-lg" role="document" style="width: 740px;">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
            <h4 class="modal-title" id="myModalLabel">도움말</h4>
         </div>
         <div class="modal-body" style="background-color: #ECF0F5;">


            <iframe id="ifrmPayModal" src="" style="border:0; width:700px; height:600px;"> </iframe>
            
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
         </div>
      </div>
   </div>
</div>

<form method="post" name="frmInfo" id="frmInfo" action="${contextPath}/order/payRes">

   <div class="company mb_30">
      <div class="sub-title">
         <h2>주문상품정보</h2>
      </div>

      <table class="table table-order">
         <thead>
            <tr class="tb_topline">
               <th scope="col">상품명</th>
               <th scope="col">수량</th>
               <th scope="col">판매가</th>
               <th scope="col">상품구매금액</th>
            </tr>
         </thead>
         <tbody>
            <c:set var="tot_amt" value="0" />
            <c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
               <tr>
                  <td class="sod_img"><input type="hidden" id="ORDER_NUM"   name="ORDER_NUM" value="${list.ORDER_NUM }"> 
                  <input type="hidden" id="BSKT_REGNO" name="BSKT_REGNO" value="${list.BSKT_REGNO }"> 
                  <input type="hidden" id="PD_CODES" name="PD_CODES" value="${list.PD_CODE }"> 
                  <input type="hidden" id="PD_NAMES" name="PD_NAMES" value="${list.PD_NAME}" /> 
                  <input type="hidden" id="PD_PRICES" name="PD_PRICES" value="${list.PD_PRICE}" /> 
                  <input type="hidden" id="PDDC_GUBNS" name="PDDC_GUBNS" value="${list.PDDC_GUBN}" /> 
                  <input type="hidden" id="PDDC_VALS" name="PDDC_VALS" value="${list.PDDC_VAL}" /> 
                  <input type="hidden" id="ORDER_QTYS" name="ORDER_QTYS" value="${list.ORDER_QTY}" /> 
                  <input type="hidden" id="ORDER_AMTS" name="ORDER_AMTS" value="${list.ORDER_AMT}" /> 
                  <b>${list.PD_NAME }</b></td>
                  <td class="td_num"><fmt:formatNumber value="${list.ORDER_QTY }" /></td>
                  <td class="td_numbig"><fmt:formatNumber value="${list.REAL_PRICE }" /> 원</td>
                  <td class="td_num"><fmt:formatNumber value="${list.ORDER_QTY * list.REAL_PRICE }" /> 원</td>
               </tr>
               <c:set var="tot_amt" value="${tot_amt + (list.ORDER_QTY * list.REAL_PRICE) }" />
               <c:if test="${loop.count == fn:length(tb_odinfoxm.list) }">
                  <tr>
                     <td class="td_num" style="text-align: center;" colspan="3">배송비</td>
                     <td class="td_num" id="dlvy_amt_gubn"><fmt:formatNumber value="${tb_odinfoxm.DLVY_AMT }" pattern="#,###" /> 원 
                     <c:if test="${tb_odinfoxm.DLVY_AMT != 0 }">
                        <c:if test="${tb_odinfoxm.DAP_YN eq 'Y' }">   <br />배송비 결제</c:if>
                        <c:if test="${tb_odinfoxm.DAP_YN eq 'N' }">   <br />배송비 착불</c:if>
                     </c:if></td>
                  </tr>
                  <tr>
                     <td class="td_num"  id="tdTotAmt" style="text-align: center;" colspan="4">총 상품 구매액 <fmt:formatNumber value="${tot_amt }" />원 
                        + 총 배송비 <fmt:formatNumber value="${tb_odinfoxm.DLVY_AMT }" />원 = <fmt:formatNumber value="${tot_amt + tb_odinfoxm.DLVY_AMT }" />원
                     </td>
                  </tr>
               </c:if>
            </c:forEach>
            <input type="hidden" id="ORDER_AMT" name="ORDER_AMT" value="${tot_amt}" />
            <input type="hidden" id="DLVY_AMT" name="DLVY_AMT" value="${tb_odinfoxm.list[0].DLVY_AMT}" />
         </tbody>
      </table>
   </div>

   <div class="company mb_30">
      <div class="sub-title">
         <h2>결제 정보</h2>
      </div>

      <table class="table table-intro">
         <tbody>
            <tr class="tb_topline">
               <th scope="row">결제금액</th>
               <td><fmt:formatNumber value="${tb_odinfoxm.ORDER_AMT}" pattern="#,###" /> 원</td>
               <th scope="row">결제수단</th>
               <td>${tb_odinfoxm.PAY_METD_NM}</td>
            </tr>
            <tr>
               <th scope="row">주문상태</th>
               <td colspan="3" id="ORDER_CON_NM">${tb_odinfoxm.ORDER_CON_NM}</td>
            </tr>
            <c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_04'}">
               <tr>
                  <th scope="row">취소사유</th>
                  <td colspan="3">${tb_odinfoxm.CNCL_MSG}</td>
               </tr>
               <tr>
                  <th scope="row">취소상태</th>
                  <td colspan="3">${tb_odinfoxm.CNCL_CON_NM}</td>
               </tr>
            </c:if>
         </tbody>
      </table>
   </div>

   <div class="company mb_30">
      <div class="sub-title">
         <h2>배송지 정보</h2>
      </div>

      <table class="table table-intro">
         <tbody>
            <tr class="tb_topline">
               <th scope="row">배송지정보</th>
               <td colspan="3">${tb_oddlaixm.DLAR_GUBN_NM}</td>
            </tr>
            <tr>
               <th scope="row">받으시는분</th>
               <td colspan="3">${tb_oddlaixm.RECV_PERS}</td>
            </tr>
            <tr>
               <th scope="row">주소</th>
               <td colspan="3"><label for="POST_NUM" class="sound_only">우편번호</label>
                  (${tb_oddlaixm.POST_NUM}) ${tb_oddlaixm.BASC_ADDR}
                  ${tb_oddlaixm.DTL_ADDR}</td>
            </tr>
            <tr>
               <th scope="row">전화번호</th>
               <td>${tb_oddlaixm.RECV_TELN}</td>
               <th scope="row">휴대폰번호</th>
               <td>${tb_oddlaixm.RECV_CPON}</td>
            </tr>
            <tr>
               <th scope="row">배송 메세지</th>
               <td colspan="6">${tb_oddlaixm.DLVY_MSG}</td>
            </tr>
            <tr class="tb_line">
               <th>배송시간</th>
               <td colspan="6"> 
                  <div class="form-inline">
                     <fmt:parseDate value="${ tb_oddlaixm.DLAR_DATE }" var="noticePostDate" pattern="yyyyMMdd"/>
                     <fmt:formatDate value="${noticePostDate}" pattern="yyyy-MM-dd"/>
                     &nbsp;&nbsp;${ tb_oddlaixm.DLAR_TIME }
                     </div>
                  </td>
            </tr>
         </tbody>
      </table>
   </div>
   
   <c:forEach items="${PAYREQ_MAP }" var="data" varStatus="loop">
      <input type="hidden" id="${data.key }" name="${data.key }" value="${data.value }" />
   </c:forEach>
</form>

<div class="btn_confirm">
   <a href="${contextPath }/order/wishList" class="btn btn-sm btn-default pull-right">목록</a>
   <c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_01'}">
      <a onclick="javascript:;" id="btnPayCall" class="btn btn-sm btn-success pull-right" style="margin-right:5px;">신용카드</a>
      <a onclick="javascript:;" id="btnPay2Call" class="btn btn-sm btn-success pull-right" style="margin-right:5px;">실시간 계좌이체</br>무통장입금</a>
      <!-- <a onclick="javascript:;" id="btnPay2Call" class="btn btn-sm btn-success pull-right" style="margin-right:5px;">무통장입금(가상계좌)</a> -->
   </c:if>
   <c:if test="${tb_odinfoxm.ORDER_CON eq 'ORDER_CON_02' || tb_odinfoxm.ORDER_CON eq 'ORDER_CON_03'}">
      <a onclick="javascript:cancel_popup();" class="btn btn-sm btn-success pull-right" style="margin-right:5px;">주문취소</a>
   </c:if>
</div> 

 
<!-- Modal -->  
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
            <h4 class="modal-title" id="myModalLabel">무통장 입금방법</h4>
         </div>
         <div class="modal-body">
            <form role="form">               
               <%-- <img src="${contextPath}/resources/img/order/bank_info.png" style="width:100%;height:auto;"> --%>
               <img src="${contextPath}/resources/img/order/bank_info.jpg" style="width:100%;height:auto;">
            </form>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
         </div>
      </div>
   </div>     
</div>


<script type="text/javascript">
window.onload =function () {
   window.open("${contextPath }/order/returnInfo/popup", "_blank", "width=432, height=295, scrollbars=no, resizable=no, toolbars=no, menubar=no");   
};

$(function() {
   $("#btnPayCall").click(function(){
      fnPayCallDiv();
   });
   $("#btnPay2Call").click(function(){
      fnPayCall2Div();
   });
   /*
   if($('#ORDER_CON_NM').text()!='결제전'){
   //주문 상태가 결제완료이면 배송시간 변경 못하게 막기
    $("select[name=DLVY_TIME_HH]").attr("disabled","disabled");
    $("select[name=DLVY_TIME_MM]").attr("disabled",true);
    $('input[name=DLVY_TIME_TM]').attr("disabled",true);
   }
   
   //배송시간 초기셋팅

   var time = $('#DLVY_TIME').val().split(':');
   var hour = parseInt(time[0]+"".trim()==""||time[0]+"".trim()=="undefined"?1:time[0]+"".trim());
   var minute = parseInt(time[1]+"".trim()==""||time[1]+"".trim()=="undefined"?0:time[1]+"".trim());
   var whatOpenTm ;
   
   if(hour>12){
      hour = hour-12;
      whatOpenTm = "PM";
   }else if(hour==12){
      whatOpenTm = "PM";
   }else if (hour == 0){
      whatOpenTm = "AM";
   }else{
      whatOpenTm = "AM";
   }
   
   $('#DLVY_TIME_HH').val(hour).prop("selected",true);
   $('#DLVY_TIME_MM').val(minute).prop("selected",true);
   $('input:radio[name="DLVY_TIME_TM"]:input[value="'+whatOpenTm+'"]').attr("checked",true);
   */
   /*
   if('${tb_oddlaixm.DLAR_GUBN_NM}' == '직접출고'){
      //배송비 제외
      var orderSum = ${tot_amt }   //parseInt($("#ORDER_SUM").val());      //주문금액
      var dlvyAmt = 0;         //dlvyAmt = ${supplierInfo.DLVY_AMT };         //배송비
      
      
      var totAmt = orderSum + dlvyAmt;
      
      $("#tdTotAmt").text("총 상품 구매액 " + number_format(String(orderSum)) + "원 + 배송비 " +  number_format(String(dlvyAmt)) + "원 = " + number_format(String(totAmt)) + "원");
      $("#ORDER_AMT").val(totAmt);
      
      //$('#devy_amt').html("배송비제외");
      $('#dlvy_amt_gubn').html("배송비제외")
   }
   */

});
   
   function fnPayCall() {
      var url = '${contextPath}/order/orderReady?ORDER_NUM=${tb_odinfoxm.ORDER_NUM }';
      window.open(url, "_blank", "width=700, height=500"); 
   }

   function fnPayCallDiv() {
      var url = '${contextPath}/order/orderReady?ORDER_NUM=${tb_odinfoxm.ORDER_NUM }&DLVY_TIME='+$('#DLVY_TIME').val();
      $('#ifrmPayModal').attr('src', url);
      $("#divPayModal").modal('show');
   }
   function fnPayCall2Div() {   //실시간계좌이체
      var url = '${contextPath}/order/orderReady2?ORDER_NUM=${tb_odinfoxm.ORDER_NUM }&DLVY_TIME='+$('#DLVY_TIME').val();
      //$('#ifrmPayModal').attr('src', url);
      //$("#divPayModal").modal('show');
      
      $('#myModal').modal('show');
   }

   function fnPayClose() {
      $("#divPayModal").modal('hide');
   }
   
   function cancel_popup(){
       window.open("${contextPath }/order/cancel/popup?ORDER_NUM=${tb_odinfoxm.ORDER_NUM}", "_blank", "width=500, height=230");   
    }
</script>

