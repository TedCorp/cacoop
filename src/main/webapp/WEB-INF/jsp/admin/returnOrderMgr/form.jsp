<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:set var="strActionUrl" value="${contextPath }/adm/returnOrderMgr/" />
<c:set var="strMethod" value="post" />

<section class="content-header">
	<h1>
		반품정보
		<small>반품내역</small>
	</h1>
</section>

<section class="content">
	<!-- 주문 정보 시작 -->
	<div class="box box-info">
		<div class="box-header with-border">
			<h3 class="box-title">반품정보</h3>
			<!-- <button type="button" class="btn btn-primary btn-sm pull-right left-5" id="btnExcel">엑셀</button> -->
		</div>
		<!-- /.box-header -->
		
		<div class="box-body">
			<div class="form-group">
				<label for="RETURN_NUM" class="col-sm-2 control-label">반품번호</label>
				<div class="col-sm-4">${tb_rtodinfoxm.RETURN_NUM }</div>
				<label for="MEMB_NM" class="col-sm-2 control-label">주문자</label>
				<div class="col-sm-4">${tb_rtodinfoxm.MEMB_NM }</div>						
			</div><br/>
			<div class="form-group">
				<label for="RETURN_DATE" class="col-sm-2 control-label">반품일자</label>
				<div class="col-sm-4">${tb_rtodinfoxm.RETURN_DATE }</div>
				<label for="ORDER_NUM" class="col-sm-2 control-label">주문번호</label>
				<div class="col-sm-4">${tb_rtodinfoxm.ORDER_NUM }</div> 
			</div><br/>
			<div class="form-group">
				<label for="PAY_METD_NM" class="col-sm-2 control-label">주문결제수단</label>
				<div class="col-sm-4">${tb_rtodinfoxm.PAY_METD_NM }</div>
			</div><br/>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- 주문 정보 끝 -->
	
	<!-- 주문상품 정보 시작 -->
	<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
		<input type="hidden" id="RETURN_NUM" name="RETURN_NUM" value="${tb_rtodinfoxm.RETURN_NUM }" /><!-- 주문번호 -->			
		
		<div class="box box-default">
			<div class="box-header with-border">
				<h3 class="box-title">상품 정보</h3>
			</div>
			<!-- /.box-header -->
			<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
				<c:set var="totalAmt" value="0"/>
				<table class="table table-bordered">
					<colgroup>
						<col />
						<col />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th class="txt-middle">번호</th>
							<th class="txt-middle">상품명</th>
							<th class="txt-right">제품가격</th>
							<th class="txt-right">판매금액</th>
							<!-- <th class="txt-right">주문수량</th> -->
							<th class="txt-right">반품수량</th>
							<th class="txt-right">환불금액</th>
							<th class="txt-right">등록일자</th>
						</tr>
					</thead>
					<c:set var="totalAmt" value="0"/> 
					<c:forEach items="${tb_rtodinfoxm.list }" var="list" varStatus="loop">
						<tr>
							<td>${list.RETURN_DTNUM }</td>
							<td>${list.PD_NAME }</td>
							<td style="text-align:right"><fmt:formatNumber>${list.ORDER_PRICE }</fmt:formatNumber></td>
							<td style="text-align:right"><fmt:formatNumber>${list.ORDER_REAL_PRICE }</fmt:formatNumber></td>
							<%-- <td style="text-align:right">${list.ORDER_QTY }</td> --%>
							<td style="text-align:right">${list.RETURN_QTY }</td>
							<td style="text-align:right"><fmt:formatNumber><c:out value="${list.RETURN_AMT }"/></fmt:formatNumber></td>
							<td>${list.REG_DTM }</td>
						</tr>
					</c:forEach>
					<tr>
						<th colspan="6" style="text-align:right;">환불 합계</th>
						<td id="totalPrdAmt" colspan="1" style="text-align:right">
							<fmt:formatNumber><c:out value="${tb_rtodinfoxm.RETURN_AMT}"/></fmt:formatNumber>
						</td>
					</tr>
					<tr>
						<th colspan="6" style="text-align:right;">배송비 </th>
						<td id="dlvyAmt" colspan="1" style="text-align:right">
							<fmt:formatNumber><c:out value="${tb_rtodinfoxm.DLVY_AMT}"/></fmt:formatNumber>
						</td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 주문상품 정보 끝 -->			
	</spform:form>
	
	<div class="box-footer">
		<a href="${contextPath}/adm/returnOrderMgr" class="btn btn-default pull-right"><i class="fa fa-list"></i> 목록</a>				
	</div>
	<!-- /.box-footer -->
</section>

<script type="text/javascript">
//엑셀
$("#btnExcel").click(function() {
	
	var form = document.createElement("form");

	form.target = "_blank";

	form.method = "get";
	form.action = "${contextPath }/adm/orderMgr/detailExcelDown";

	document.body.appendChild(form);

	var input_id = document.createElement("input");
	input_id.setAttribute("type", "hidden");
	input_id.setAttribute("name", "ORDER_NUM");
	input_id.setAttribute("value", "${tb_odinfoxm.ORDER_NUM }");

	form.appendChild(input_id);
	form.submit();
    
});
function fn_save(){

	var frm=document.getElementById("orderFrm");
	var count = 0;
	//$("input[name='RETURN_QTYS'][value='']").size()
	
	$("input[name='RETURN_QTYS']").each(function (i) {
		 console.log(i+"============"+$("input[name='RETURN_QTYS']").eq(i).val());
        if($("input[name='RETURN_QTYS']").eq(i).val()==null||$("input[name='RETURN_QTYS']").eq(i).val()==''){
        	count ++;
        }
        if($("input[name='RETURN_GBNS']").eq(i).val()==null||$("input[name='RETURN_GBNS']").eq(i).val()==''){
        	count++;
        }
    });
	
	if($("input[name='DLVY_AMT']").val()==null || $("input[name='DLVY_AMT']").val()==''){
		alert("배송비는 필수값입니다.") 
		return;
	}
	
	if(count>0){
		alert("반품수량과 반품사유는 필수값입니다.") 
		return;
	}
	
    if(!confirm("저장 하시겠습니까?")) return;
	
	frm.submit();
}

//pg사 결제 취소
function fn_pg_cancle(){
	alert("추후개발");
}

function addComma(num) { //숫자콤마만드는 함수
	  var regexp = /\B(?=(\d{3})+(?!\d))/g;
	  return num.toString().replace(regexp, ',');
}

function fn_qtychk(dtnum){
	var orderqty = parseInt($("#ORDER_QTY_"+dtnum).val());
	var returnqty = parseInt($("#RETURN_QTY_"+dtnum).val());
	
	if(orderqty < returnqty){
		alert("주문수량보다 반품수량이 더 많을 수 없습니다.");
		setTimeout(function(){
			$("#RETURN_QTY_"+dtnum).focus();
		})
		return false;
	}
	
	return true;
}
</script>