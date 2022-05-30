<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>


<script type="text/javascript">
$(function() {

    // 목록가기
    $("#btnList").click(function() {
    	//${contextPath }/reuqest
    	
    	history.go(-1);
    });

    // 주문수정
    $("#btnEdit").click(function() {
    	$("#frm").attr('action', '${contextPath }/request/edit/${rtnMaster.ORDER_NUM }');
    	$("#frm").submit();
    });
    
    // 주문취소
    $("#btnCancel").click(function() {

		if(!confirm("주문을 취소 하시겠습니까?")) {
			return false;
		}
		
    	$("#ORDER_CON").val("XORDER_CON_05");
    	
    	$("#frm").attr('action', '${contextPath }/request/condition');
    	$("#frm").submit();
    }); 
/*
	<c:forEach var="ent" items="${ rtnDelivery.list }" varStatus="status">
		$(".selectDelivery").append("<option value='${ent.DLVY_ROWNUM}'>${ent.DLVY_NAME}</option>");
	</c:forEach>


	<c:forEach items="${rtnMaster.list }" var="list" varStatus="loop">
		$(".selectDelivery")eq(${loop.index}).val("${list}");
	</c:forEach>
*/	
});


function goDownLoad(url){ 
	document.location.href = url; 
} 
</script>

<div id="wrapper_title">주문내역 상세조회</div>
<div id="sct_location">
	<a href='${contextPath }/goods' class="sct_bg">Home</a>
	<a href="#" class="sct_here">주문내역 상세조회</a>
</div>

	<div id="wrapper_title_sub">기본정보 - 필수 입력</div>
	<div class="mbskin">
	    <div class="tbl_frm01 tbl_wrap">
	        <table>
		        <tbody>
		        <tr>
		            <th scope="row">회사명</th>
		            <td>
		            	${rtnMaster.COM_NAME }
		            </td>
		            <th scope="row"><label for="CEO_NAME">대표자명</th>
		            <td>
		            	${rtnMaster.CEO_NAME }
		            </td>
		        </tr>
		        <tr>
		            <th scope="row"><label for="BIZR_NUM1">사업자등록번호</th>
		            <td>
		            	${rtnMaster.BIZR_NUM }
		            </td>
		            <th scope="row"><label for="COM_TEL1">회사전화번호</label></th>
		            <td>
		            	${rtnMaster.COM_TEL }
		            </td>
		        </tr>
		        <tr>
		            <th scope="row"><label for="STAFF_NAME">담당자</label></th>
		            <td>
		            	${rtnMaster.STAFF_NAME }
		            </td>
		            <th scope="row"><label for="STAFF_CPON1">담당자 휴대폰번호</label></th>
		            <td>
		            	${rtnMaster.STAFF_CPON }
		            </td>
		        </tr>
		        <tr>
		            <th scope="row"><label for="STAFF_MAIL">담당자EMAIL</label></th>
		            <td colspan="3">
		            	${rtnMaster.STAFF_MAIL }
		            </td>
		        </tr>
		        <tr>
		            <th scope="row">회사주소<BR>(기본배송지)</th>
		            <td colspan="3">
		            	${rtnMaster.POST_NUM} <BR>
		            	${rtnMaster.BASC_ADDR} ${rtnMaster.DTL_ADDR} 
		            </td>
		        </tr>
		        <tr>
		            <th scope="row">상품도착요청일</th>
		            <td colspan="3">
		            	${rtnMaster.ARRIVAL_DATE }
		            </td>
		        </tr>
		        <tr>
			        <th scope="row"><label for="ORDER_MSG">주문 메모</label></th>
		            <td colspan="3">
		                <textarea id="ORDER_MSG" name="ORDER_MSG" rows="10" cols="100" readonly="readonly">${rtnMaster.ORDER_MSG }</textarea>
		            </td>
		        </tr>
		        <tr>
			        <th scope="row"><label for="file-simple">첨부파일<br>(사업자등록증)</label></th>
		            <td colspan="3">
						<c:if test="${ !empty(fileList) }">
				        	<c:forEach var="var" items="${ fileList }" varStatus="status">
								<label class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" for="seq${var.ATFL_SEQ}">${var.ORFL_NAME }</label>
								<button type="button" class="btn btn-xs btn-primary file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:goDownLoad('${contextPath }/common/commonFileDown?ATFL_ID=${var.ATFL_ID }&ATFL_SEQ=${var.ATFL_SEQ}')" >다운로드</button><br>
			                </c:forEach>
			            </c:if>
		            </td>
		        </tr>
		        <tr>
			        <th scope="row"><label for="fileDLVY">첨부파일<br>(사업자등록증)</label></th>
		            <td colspan="3">
						<c:if test="${ !empty(fileListDLVY) }">
				        	<c:forEach var="var" items="${ fileListDLVY }" varStatus="status">
								<label class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" for="seq${var.ATFL_SEQ}">${var.ORFL_NAME }</label>
								<button type="button" class="btn btn-xs btn-primary file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:goDownLoad('${contextPath }/common/commonFileDown?ATFL_ID=${var.ATFL_ID }&ATFL_SEQ=${var.ATFL_SEQ}')" >다운로드</button><br>
			                </c:forEach>
			            </c:if>
		            </td>
		        </tr>
		        </tbody>
	        </table>
	    </div>
	    
	</div>


	<div id="wrapper_title_sub" style="padding:0 0 10px 0;">추가 배송지</div>

	<div id="sod_bsk">
		<div class="tbl_head01 tbl_wrap">
			<table>
				<thead>
					<tr>
						<th scope="col">명칭</th>
						<th scope="col">담당자</th>
						<th scope="col">담당자휴대폰</th>
						<th scope="col">배송지 주소</th>
					</tr>
				</thead>
				<tbody id="tbodyDelivery">
					<c:if test="${ !empty(rtnDelivery.list) }">
			        	<c:forEach var="ent" items="${ rtnDelivery.list }" varStatus="status">
							<tr>
								<td class="grid_2">
									${ent.DLVY_NAME }
								</td>
								<td>
									${ent.STAFF_NAME }
								</td>
								<td class="grid_5">
									${ent.STAFF_CPON }
								</td>
								<td class="grid_10">
									${ent.POST_NUM }<br>
									${ent.BASC_ADDR } ${ent.DTL_ADDR }
								</td>
							</tr>
		                </c:forEach>
		            </c:if>
					<c:if test="${ empty(rtnDelivery.list) }">
						<tr>
							<td colspan="4">
								추가배송지 정보가 없습니다.
							</td>
						</tr>
		            </c:if>
				</tbody>
			</table>
		</div>

	</div>
	
	<div id="wrapper_title_sub">주문 상품 목록</div>
		
	<!-- 글자크기 조정 display:none 되어 있음 시작 { -->
	<div id="sod_bsk">
		<div class="tbl_head01 tbl_wrap">
			<table>
				<thead>
					<tr>
						<th scope="col">상품명</th>
						<th scope="col">수량</th>
						<th scope="col">판매가</th>
						<th scope="col">상품구매금액</th>
						<th scope="col">배송지</th>
					</tr>
				</thead>
				<tbody id="tbodyProduct" >
					<c:set var="tot_amt" value="0" />
					<c:forEach items="${rtnMaster.list }" var="list" varStatus="loop">
					<c:set var="realPrice" value="${ list.PD_PRICE }" />
					<c:if test="${ list.PDDC_GUBN ne 'PDDC_GUBN_01' }">
						<c:set var="nDiscount" value="0" />
						<c:if test="${ list.PDDC_GUBN eq 'PDDC_GUBN_02' }">
							<c:set var="nDiscount" value="${list.PDDC_VAL }" />
						</c:if>
						<c:if test="${ list.PDDC_GUBN eq 'PDDC_GUBN_03' }">
							<c:set var="nDiscount" value="${ list.PD_PRICE* list.PDDC_VAL/100 }" />
						</c:if>
						<c:set var="realPrice" value="${ list.PD_PRICE - nDiscount }" />
					</c:if>
					<tr>
						<td class="sod_img">
							<b>${list.PD_NAME }</b>
						</td>
						<td class="td_num">
							${list.ORDER_QTY}
						</td>
						<td class="td_numbig">
							<c:if test="${ realPrice ne list.PD_PRICE }">
								<strike><fmt:formatNumber value="${ list.PD_PRICE }" pattern="#,###"/>원</strike><br>
							</c:if>
							<fmt:formatNumber value="${ realPrice }" pattern="#,###"/>원
						</td>
						<td class="td_num">
							<div id="divOrderAmt" class="divOrderAmt"><fmt:formatNumber value="${list.ORDER_QTY * realPrice }" /></div>
							<input type="hidden" id="ORDER_AMTS" name="ORDER_AMTS" value="${list.ORDER_QTY * realPrice }" />
						</td>
						<td class="grid_2">
							<c:if test="${list.DLVY_ROWNUM eq 'base' }">기본배송지</c:if>
							<c:if test="${list.DLVY_ROWNUM eq 'etc' }">개별배송</c:if>
							<c:if test="${list.DLVY_ROWNUM ne 'etc' and list.DLVY_ROWNUM ne 'base' }">${list.DLVY_NAME }</c:if>
						</td>
					</tr>
					</c:forEach>
					<tr>
						<td class="td_num" colspan="6">
							<div id="divTotOrderAmt">총 상품 구매액 <fmt:formatNumber value="${rtnMaster.ORDER_AMT }" />원</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>

	</div>


	<div id="wrapper_title_sub">주문진행상태</div>
	<div class="mbskin">
	    <div class="tbl_frm01 tbl_wrap">
	        <table>
		        <tbody>
		        <tr>
		            <th scope="row">주문번호</th>
		            <td>
		            	${rtnMaster.ORDER_NUM }
		            </td>
		            <th scope="row"><label for="CEO_NAME">주문일자</th>
		            <td>
		            	${rtnMaster.ORDER_DATE }
		            </td>
		        </tr>
		        <tr>
		            <th scope="row">주문상태</th>
		            <td colspan="3">
		            	${rtnMaster.ORDER_CON_NM }
		            </td>
		        </tr>
		        <tr>
		            <th scope="row">결제방식</th>
		            <td colspan="3">
		            	${rtnMaster.PAY_METD_NM }
		            </td>
		        </tr>
		        </tbody>
	        </table>
	    </div>
	    
	</div>


	<form  name="frm" id="frm" action="${contextPath }/request/condition" method="POST">
		<input type="hidden" name="ORDER_NUM" id="ORDER_NUM" value="${rtnMaster.ORDER_NUM }">
		<input type="hidden" name="BIZR_NUM" id="BIZR_NUM" value="${rtnMaster.BIZR_NUM }">
		<input type="hidden" name="ORDER_CON" id="ORDER_CON" value="">
    </form>
	<div class="text-center">
    	<c:if test="${rtnMaster.ORDER_CON eq 'XORDER_CON_01'}">
       		 <button type="button" class="btn btn-sm btn-danger" id="btnCancel">주문취소</button>
        </c:if>
    	<c:if test="${rtnMaster.ORDER_CON eq 'XORDER_CON_01' || rtnMaster.ORDER_CON eq 'XORDER_CON_02' || rtnMaster.ORDER_CON eq 'XORDER_CON_03' || rtnMaster.ORDER_CON eq 'XORDER_CON_04' }">
       		 <button type="button" class="btn btn-sm btn-success" id="btnEdit">수정</button>
        </c:if>
		<button type="submit" class="btn btn-sm btn-default" id="btnList">목록</button>
	</div>

	
	
</div>
