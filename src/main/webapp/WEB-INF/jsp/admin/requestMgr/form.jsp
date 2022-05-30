<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<c:set var="strActionUrl" value="${contextPath }/adm/orderMgr/" />
<c:set var="strMethod" value="post" />

<section class="content-header">
	<h1>
		주문내역	
		<small>주문내역</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">
	<!-- Horizontal Form -->
			
			<!-- 주문 정보 시작 -->
			<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">주문정보</h3>
			</div>
			<!-- /.box-header -->
				<form class="form-horizontal">
				<!-- box-body -->
				<div class="box-body">
					<div class="form-group">
						<label class="col-sm-2 control-label">주문번호</label>
						<div class="col-sm-4">
							<p class="form-control-static">${tb_odinfoxm.ORDER_NUM }</p>
						</div>
						<label class="col-sm-2 control-label">주문일자</label>
						<div class="col-sm-4">
							<p class="form-control-static">${tb_odinfoxm.ORDER_DATE }</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">회사명</label>
						<div class="col-sm-4">
							<p class="form-control-static">${tb_odinfoxm.COM_NAME }</p>
						</div>
						<label class="col-sm-2 control-label">대표자명</label>
						<div class="col-sm-4">
							<p class="form-control-static">${tb_odinfoxm.CEO_NAME }</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">사업자등록번호</label>
						<div class="col-sm-4">
							<p class="form-control-static">${tb_odinfoxm.BIZR_NUM }</p>
						</div>
						<label class="col-sm-2 control-label">회사전화번호</label>
						<div class="col-sm-4">
							<p class="form-control-static">${tb_odinfoxm.COM_TEL }</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">담당자</label>
						<div class="col-sm-4">
							<p class="form-control-static">${tb_odinfoxm.STAFF_NAME }</p>
						</div>
						<label class="col-sm-2 control-label">담당자 휴대폰번호</label>
						<div class="col-sm-4">
							<p class="form-control-static">${tb_odinfoxm.STAFF_CPON }</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">담당자 EMAIL<br>(계산서발행)</label>
						<div class="col-sm-10">
							<p class="form-control-static">${tb_odinfoxm.STAFF_MAIL }</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">회사주소(기본배송지)</label>
						<div class="col-sm-10">
							<p class="form-control-static">(${tb_odinfoxm.POST_NUM })${tb_odinfoxm.BASC_ADDR } ${tb_odinfoxm.DTL_ADDR }</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">상품도착요청일</label>
						<div class="col-sm-10">
							<p class="form-control-static">${tb_odinfoxm.ARRIVAL_DATE }</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">주문메모</label>
						<div class="col-sm-10">
							<p class="form-control-static">${tb_odinfoxm.ORDER_MSG }</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">첨부파일<br>(사업자등록증)</label>
						<div class="col-sm-10">
						<p class="form-control-static">
						<c:if test="${ !empty(fileList) }">
				        	<c:forEach var="var" items="${ fileList }" varStatus="status">
								<label class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" for="seq${var.ATFL_SEQ}">${var.ORFL_NAME }</label>
								<button type="button" class="btn btn-xs btn-primary file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:goDownLoad('${contextPath }/common/commonFileDown?ATFL_ID=${var.ATFL_ID }&ATFL_SEQ=${var.ATFL_SEQ}')" >다운로드</button><br>
			                </c:forEach>
			            </c:if>
			            </p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">개별배송 첨부파일</label>
						<div class="col-sm-10">
						<p class="form-control-static">
						<c:if test="${ !empty(fileListDLVY) }">
				        	<c:forEach var="var" items="${ fileListDLVY }" varStatus="status">
								<label class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" for="seq${var.ATFL_SEQ}">${var.ORFL_NAME }</label>
								<button type="button" class="btn btn-xs btn-primary file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:goDownLoad('${contextPath }/common/commonFileDown?ATFL_ID=${var.ATFL_ID }&ATFL_SEQ=${var.ATFL_SEQ}')" >다운로드</button><br>
			                </c:forEach>
			            </c:if>
			            </p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">신용카드 첨부파일</label>
						<div class="col-sm-10">
						<p class="form-control-static">
						<c:if test="${ !empty(fileListCARD) }">
				        	<c:forEach var="var" items="${ fileListCARD }" varStatus="status">
								<label class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" for="seq${var.ATFL_SEQ}">${var.ORFL_NAME }</label>
								<button type="button" class="btn btn-xs btn-primary file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:goDownLoad('${contextPath }/common/commonFileDown?ATFL_ID=${var.ATFL_ID }&ATFL_SEQ=${var.ATFL_SEQ}')" >다운로드</button><br>
			                </c:forEach>
			            </c:if>
			            </p>
						</div>
					</div>
				</div>
				</form>
				<!-- /.box-body -->
			</div>
			<!-- 주문 정보 끝 -->
						
			<!-- 추가 배송지 정보 시작 -->
			<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">추가 배송지</h3>
			</div>
				<!-- /.box-header -->
				<div class="box-body">
					<table class="table table-bordered">
						<colgroup>
							<col style="with:10px" />
							<col />
							<col style="with:50px" />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>명칭</th>
								<th>담당자</th>
								<th>담당자휴대폰</th>
								<th>배송지 주소</th>
							</tr>
						</thead>
						<c:forEach items="${tb_oddlaixm.list }" var="list" varStatus="loop">
							<tr>
								<td>${loop.count }</td>
								<td>${list.DLVY_NAME }</td>
								<td>${list.STAFF_NAME }</td>
								<td>${list.STAFF_CPON }</td>
								<td>(${list.POST_NUM })${list.BASC_ADDR } ${list.DTL_ADDR } </td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<!-- 추가 배송지 정보 끝 -->
			
			
			<!-- 주문상품 정보 시작 -->
			<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">주문상품</h3>
			</div>
				<!-- /.box-header -->
				<div class="box-body">
					<table class="table table-bordered">
						<colgroup>
							<col style="with:10px" />
							<col />
							<col style="with:50px" />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>상품명</th>
								<th>수량</th>
								<th>판매가</th>
								<th>상품구매금액</th>
								<th>배송지명</th>
							</tr>
						</thead>
						<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
							<tr>
								<td>${loop.count }</td>
								<td>${list.PD_NAME }</td>
								<td align="right">${list.ORDER_QTY }</td>
								<td align="right"><fmt:formatNumber value="${list.REAL_PRICE }" /></td>
								<td align="right"><fmt:formatNumber value="${list.ORDER_AMT }" /></td>
								<td>
									<c:if test="${list.DLVY_ROWNUM eq 'base' }">기본배송지</c:if>
									<c:if test="${list.DLVY_ROWNUM eq 'etc' }">개별배송</c:if>
									<c:if test="${list.DLVY_ROWNUM ne 'etc' and list.DLVY_ROWNUM ne 'base' }">${list.DLVY_NAME }</c:if>
								</td>
							</tr>
						</c:forEach>
							<tr>
								<td colspan="4">합계</td>
								<td align="right"><b><fmt:formatNumber value="${tb_odinfoxm.ORDER_AMT }" /></b></td>
								<td> </td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- 주문상품 정보 끝 -->


			<!-- 주문 상태 및 결제 정보 시작 -->
			<div class="box box-info">
				<div class="box-header with-border">
					<h3 class="box-title">주문 상태 및 결제 정보</h3>
				</div>
				<!-- /.box-header -->
	
				<!-- box-body -->
				<spform:form name="orderFrm" id="orderFrm" method="post" action="${contextPath }/adm/requestMgr" class="form-horizontal">
				<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM }" /><!-- 주문번호 -->
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">주문상태</label>
						<div class="col-sm-3">
							<jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="XORDER_CON" />
								<jsp:param name="name" value="ORDER_CON" />
								<jsp:param name="value" value="${tb_odinfoxm.ORDER_CON }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="" />
							</jsp:include>
						</div>
						<label for="inputEmail3" class="col-sm-2 control-label">결제 수단</label>
						<div class="col-sm-2">
							<jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="XPAY_METD" />
								<jsp:param name="name" value="PAY_METD" />
								<jsp:param name="value" value="${tb_odinfoxm.PAY_METD }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="" />
								<jsp:param name="width" value="200" />
							</jsp:include>
						</div>
					</div>
				</div>
				</spform:form>
				<!-- /.box-body -->
			</div>
			<!-- 주문 상태 및 결제 정보 끝 -->

 			<div class="row">
				<div class="col-xs-12">
					<a href="${contextPath}/adm/requestMgr" class="btn btn-success pull-right"><i class="fa fa-list"></i> 목록</a>
					<button type="button" id="btnSave" class="btn btn-primary pull-right" style="margin-right: 5px;"><i class="fa fa-save"></i> 저장</button>
				</div>
			</div>
	<!-- /.box -->
</section>
<script type="text/javascript">
$(document).ready(function() {
	$("#btnSave").click(function(){
		if(!confirm("저장 하시겠습니까?")) return;
		
		$("#orderFrm").submit();
	});
	
});

function goDownLoad(url){ 
	document.location.href = url; 
} 

</script>