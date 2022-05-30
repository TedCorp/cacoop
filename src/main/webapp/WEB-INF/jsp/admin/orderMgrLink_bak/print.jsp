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
	
				<!-- box-body -->
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">주문번호</label>
						<div class="col-sm-4">${tb_odinfoxm.ORDER_NUM }</div>
						<label for="inputEmail3" class="col-sm-2 control-label">주문자</label>
						<div class="col-sm-4">${tb_odinfoxm.MEMB_NM }</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">주문일자</label>
						<div class="col-sm-4">${tb_odinfoxm.ORDER_DATE }</div>
						<label for="inputEmail3" class="col-sm-2 control-label">배송비 결제 여부</label>
						<div class="col-sm-4">${tb_odinfoxm.DAP_YN }</div>
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- 주문 정보 끝 -->
			
			<!-- 주문상품 정보 시작 -->
			<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">주문 정보</h3>
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
								<th>할인가격</th>
								<th>가격</th>
							</tr>
						</thead>
						<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
							<tr>
								<td>${loop.count }</td>
								<td>${list.PD_NAME }</td>
								<td>${list.ORDER_QTY }</td>
								<td>${list.PDDC_VAL }</td>
								<td>${list.ORDER_AMT }</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<!-- 주문상품 정보 끝 -->
			
			<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
			<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM }" /><!-- 주문번호 -->
			
			<!-- 배송지 정보 시작 -->
			<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">배송지 정보</h3>
				<div class="pull-right">
					<jsp:include page="/common/comCodForm">
						<jsp:param name="COMM_CODE" value="DLAR_GUBN" />
						<jsp:param name="name" value="DLAR_GUBN" />
						<jsp:param name="value" value="${tb_oddlaixm.DLAR_GUBN }" />
						<jsp:param name="type" value="radio" />
						<jsp:param name="top" value="선택" />
					</jsp:include>
				</div>
			</div>
			<!-- /.box-header -->
	
				<!-- box-body -->
				<form class="form-horizontal">
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">받으시는 분</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="RECV_PERS" name="RECV_PERS" value="${tb_oddlaixm.RECV_PERS }" required="required"  />
						</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">주소</label>
						
						<div class="col-sm-10">
							<div class="form-group">
								<div class="col-sm-2">
									<input type="text" class="form-control" id="POST_NUM" name="POST_NUM" value="${tb_oddlaixm.POST_NUM }" required="required"  />
								</div>
								<div class="col-sm-3">
									<input type="button" class="btn btn-block btn-warning btn-xs" value="우편번호검색" >
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
									<input type="text" class="form-control" id="BASC_ADDR" name="BASC_ADDR" value="${tb_oddlaixm.BASC_ADDR }" required="required"  />
									<input type="text" class="form-control" id="DTL_ADDR" name="DTL_ADDR" value="${tb_oddlaixm.DTL_ADDR }" required="required"  />
								</div>
							</div>
						</div>
						
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">일반전화</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="RECV_TELN" name="RECV_TELN" value="${tb_oddlaixm.RECV_TELN }" required="required"  />
						</div>
						<label for="inputEmail3" class="col-sm-2 control-label">휴대전화</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="RECV_CPON" name="RECV_CPON" value="${tb_oddlaixm.RECV_CPON }" required="required"  />
						</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">배송 메세지</label>
						<div class="col-sm-10">
							<textarea rows="5" cols="100" id="DLVY_MSG" name="DLVY_MSG" required="required">${tb_oddlaixm.DLVY_MSG }</textarea>
						</div>
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- 배송지 정보 끝 -->
			
			<!-- 주문 상태 및 결제 정보 시작 -->
			<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">주문 상태 및 결제 정보</h3>
			</div>
			<!-- /.box-header -->
	
				<!-- box-body -->
				<form class="form-horizontal">
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">주문상태</label>
						<div class="col-sm-3">
							<jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="ORDER_CON" />
								<jsp:param name="name" value="ORDER_CON" />
								<jsp:param name="value" value="${tb_odinfoxm.ORDER_CON }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</div>
						<div class="col-sm-3">
							<jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="CNCL_CON" />
								<jsp:param name="name" value="CNCL_CON" />
								<jsp:param name="value" value="${tb_odinfoxm.CNCL_CON }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
							<jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="RFND_CON" />
								<jsp:param name="name" value="RFND_CON" />
								<jsp:param name="value" value="${tb_odinfoxm.RFND_CON }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">결제 수단</label>
						<div class="col-sm-2">${tb_odinfoxm.PAY_METD_NM }</div>
						<label for="inputEmail3" class="col-sm-2 control-label">결제 일시</label>
						<div class="col-sm-2"></div>
						<label for="inputEmail3" class="col-sm-2 control-label">결제 상태</label>
						<div class="col-sm-2"></div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">배송 정보</label>
						<div class="col-sm-3">
							<jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="DLVY_COM" />
								<jsp:param name="name" value="DLVY_COM" />
								<jsp:param name="value" value="${tb_odinfoxm.DLVY_COM }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</div>
						<label for="inputEmail3" class="col-sm-2 control-label">운송장번호</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="DLVY_TDN" name="DLVY_TDN" value="${tb_odinfoxm.DLVY_TDN }"  />
						</div>
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- 주문 상태 및 결제 정보 끝 -->
			</spform:form>
			
			<div class="box-footer">
				<a href="${contextPath}/adm/orderMgr" class="btn btn-default pull-right">리스트</a>
				<!-- <button type="submit" class="btn btn-info pull-right">저장</button> -->
				<a onclick="javascript:fn_save();" class="btn btn-info pull-right">저장</a>
				<a onclick="javascript:fn_pg_cancle();" class="btn btn-default  btn-warning">PG사 결제 취소</a>
				<!-- <input type="button" class="btn btn-block btn-warning btn-xs" value="우편번호검색" > -->
			</div>
			
			
			<!-- /.box-footer -->
	
	<!-- /.box -->
</section>
 
<script type="text/javascript">
$(document).ready(function() {
	fn_disabled();
	$("#ORDER_CON").change(function(e) {
		fn_disabled();
	});
});

function fn_disabled(){
	if($("#ORDER_CON").val()=="ORDER_CON_04"){//주문 취소시
		$("#CNCL_CON").show();
		$("#RFND_CON").hide();
		$("#RFND_CON").val("");
	}else if($("#ORDER_CON").val()=="ORDER_CON_07"){//환불시
		$("#CNCL_CON").hide();
		$("#CNCL_CON").val("");
		$("#RFND_CON").show();
	}else{
		$("#CNCL_CON").val("");
		$("#RFND_CON").val("");
		$("#CNCL_CON").hide();
		$("#RFND_CON").hide();
	}
}

function fn_save(){
	if(!confirm("저장 하시겠습니까?")) return;
	var frm=document.getElementById("orderFrm");
	frm.submit();
}

//pg사 결제 취소
function fn_pg_cancle(){
	alert("추후개발");
}
</script>