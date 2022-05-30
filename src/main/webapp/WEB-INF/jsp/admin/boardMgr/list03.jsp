<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		<jsp:include page="/common/comCodName">
			<jsp:param name="COMM_CODE" value="BRD_GUBN" />
			<jsp:param name="COMD_CODE" value="${obj.BRD_GUBN }" />
			<jsp:param name="type" value="text" />
		</jsp:include>
		<small></small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>


<%-- <c:set var="strActionUrl" value="${contextPath }/adm/boardMgr/type02/${obj.BRD_GUBN}" /> --%>
<c:set var="strActionUrl" value="${contextPath }/adm/boardMgr/type03/${obj.BRD_GUBN}" />
<c:set var="strMethod" value="get" />

<c:choose>
<c:when test="${empty obj.WRTR_ORDER or obj.WRTR_ORDER =='desc' }"><c:set var="WRTR_ORDER" value="asc" /></c:when>
<c:otherwise><c:set var="WRTR_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
<c:when test="${empty obj.REPLY_ORDER or  obj.REPLY_ORDER =='desc' }"><c:set var="REPLY_ORDER" value="asc" /></c:when>
<c:otherwise><c:set var="REPLY_ORDER" value="desc" /></c:otherwise>
</c:choose>
<c:choose>
<c:when test="${empty obj.PD_NAME_ORDER or  obj.PD_NAME_ORDER =='desc' }"><c:set var="PD_NAME_ORDER" value="asc" /></c:when>
<c:otherwise><c:set var="PD_NAME_ORDER" value="desc" /></c:otherwise>
</c:choose>

<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">
			<jsp:include page="/common/comCodName">
				<jsp:param name="COMM_CODE" value="BRD_GUBN" />
				<jsp:param name="COMD_CODE" value="${obj.BRD_GUBN }" />
				<jsp:param name="type" value="text" />
			</jsp:include> 조건
			</h3>

			<div class="box-tools pull-right">
				<button type="button" class="btn btn-box-tool"
					data-widget="collapse">
					<i class="fa fa-minus"></i>
				</button>
				<button type="button" class="btn btn-box-tool" data-widget="remove">
					<i class="fa fa-remove"></i>
				</button>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			
			<spform:form name="orderFrm" id="orderFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
				<input type="hidden" id="ORDER_GUBUN" name="ORDER_GUBUN" value="${obj.ORDER_GUBUN }" /><!-- 등록일 답변일 정렬 정렬 구분 -->
				<input type="hidden" id="WRTR_ORDER" name="WRTR_ORDER" value="${WRTR_ORDER }" /><!-- 등록일 정렬 -->
				<input type="hidden" id="REPLY_ORDER" name="REPLY_ORDER" value="${REPLY_ORDER }" /><!-- 답변일 정렬 -->
				<input type="hidden" id="PD_NAME_ORDER" name="PD_NAME_ORDER" value="${PD_NAME_ORDER }" /><!-- 제품명 정렬 -->
				<input type="hidden" id="pagerMaxPageItems" name="pagerMaxPageItems" value="${obj.pagerMaxPageItems }" /><!-- 목록수 -->
				
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">답변여부</label>
						<div class="col-sm-2">
							<select name="REPLY_YN" id="REPLY_YN" class="form-control select2" style="width: 100%;">
								<option value="">전체</option>
								<option value="Y" ${obj.REPLY_YN == 'Y' ? 'selected=selected':''}>답변</option>
								<option value="N" ${obj.REPLY_YN == 'N' ? 'selected=selected':''}>미답변</option>
							</select>
						</div>
						<label for="inputEmail3" class="col-sm-1 control-label">검색조건</label>
						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2" style="width: 100%;">
								<option value="WRTR_ID" ${obj.schGbn == 'WRTR_ID' ? 'selected=selected':''}>아이디</option>
								<option value="WRTR_NM" ${obj.schGbn == 'WRTR_NM' ? 'selected=selected':''}>성명</option>
							</select>
						</div>
						<div class="col-sm-2">
							<input name="schTxt" id="schTxt" type="text" class="form-control" placeholder="검색어 입력" value="${obj.schTxt }">
						</div>
						<div class="col-sm-3"></div>
						<div class="col-sm-1">
							<button type="submit" class="btn btn-success pull-right">검색</button>
						</div>
					</div>
				</div>
			<!-- /.box-body -->
			</spform:form>
			
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.box -->
	<!-- <div class="box-header with-border">
		<h3 class="box-title"></h3>
		<div class="box-tools">
			<a href="" class="btn btn-sm btn-primary pull-right">엑셀</a>
		</div>
	</div> -->
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<!-- /.box-header -->
		<div class="box-body">
			<form class="form-horizontal">
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">정렬</label>
						<div class="col-sm-2">
							<button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('WRTR_ORDER');">등록일▼▲</button>
						    <button type="button" class="btn btn-primary btn-sm" onclick="javascript:fn_order_by('REPLY_ORDER');">답변일▼▲</button>
						</div>
						<div class="col-sm-5"></div>
						<div class="col-sm-4">
							<label for="inputEmail3" class="col-sm-6 control-label">목록수</label>
							<div class="col-sm-3">
				                <select name="cnt" id="cnt" class="form-control select2" style="width: 100%;" onchange="javascript:fn_order_by();">
									<option value="10" ${obj.pagerMaxPageItems == '10' ? 'selected=selected':''}>10</option>
									<option value="20" ${obj.pagerMaxPageItems == '20' ? 'selected=selected':''}>20</option>
									<option value="30" ${obj.pagerMaxPageItems == '30' ? 'selected=selected':''}>30</option>
									<option value="40" ${obj.pagerMaxPageItems == '40' ? 'selected=selected':''}>40</option>
									<option value="50" ${obj.pagerMaxPageItems == '50' ? 'selected=selected':''}>50</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<!-- /.row -->
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.box -->
	<!-- 검색 박스 -->
	<div class="box">
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered">
				<colgroup>
					<col style="with:10px" />
					<col />
					<col style="with:300px" />
					<col />
					<col />
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th>순번</th>
						<th>제목</th>
						<th>성명</th>
						<th>등록일</th>
						<th>답변여부</th>
						<th>답변일</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${obj.count == 0}">
					<tr>
						<td colspan="7">조회된 내용이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td>${loop.count }</td>
						<td><a href="${contextPath}/adm/boardMgr/type03/${list.BRD_GUBN }/${list.BRD_NUM }">${list.BRD_SBJT }</a></td>
						<td>${list.WRTR_NM }</td>
						<td>${list.WRT_DTM }</td>
						<td>${list.REPLY_YN == 'Y' ? '답변':'미답변' }</td>
						<td>${list.REPLY_DTM }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>
	</div>
	
</section>

<script>

//카테고리 변경시
function fn_cago_change(gubun){
	
	var frm=document.getElementById("orderFrm");
	var schCago01 = frm.schCago01.value;
	var schCago02 = frm.schCago02.value;
	var schCago03 = frm.schCago03.value;
	var schCago04 = frm.schCago04.value;
	
	var param = "&schCago01="+schCago01+"&schCago02="+schCago02+"&schCago03="+schCago03+"&schCago04="+schCago04
	
	var schCago = "";
	
	var text01 = "<select name=\"schCago02\" id=\"schCago02\" class=\"form-control select2\" style=\"width: 100%;\" onchange=\"javascript:fn_cago_change('schCago03');\">";
		text01+= "<option value=\"\">2단계 분류</option>";
		text01+= "</select>";
	
	var text02 = "<select name=\"schCago03\" id=\"schCago03\" class=\"form-control select2\" style=\"width: 100%;\" onchange=\"javascript:fn_cago_change('schCago04');\">";
		text02+= "<option value=\"\">3단계 분류</option>";
		text02+= "</select>";
	
	var text03 = "<select name=\"schCago04\" id=\"schCago04\" class=\"form-control select2\" style=\"width: 100%;\" >";
		text03+= "<option value=\"\">4단계 분류</option>";
		text03+= "</select>";
		
	if(gubun=="schCago02"){
		schCago=frm.schCago01.value;
		if(schCago==""){
			$("#divCago02").html(text01);
			$("#divCago03").html(text02);
			$("#divCago04").html(text03);
			return;
		}
	}else if(gubun=="schCago03"){
		schCago=frm.schCago02.value;
		if(schCago==""){
			$("#divCago03").html(text02);
			$("#divCago04").html(text03);
			return;
		}
	}else if(gubun=="schCago04"){
		schCago=frm.schCago03.value;
		if(schCago==""){
			$("#divCago04").html(text03);
			return;
		}
	}
	
	var schCagoGubun = gubun;
	
	$.ajax({
	    url: "${contextPath }/adm/boardMgr/cago",
	    type: 'POST',
	    data: 'schCago='+ schCago+'&schCagoGubun='+ schCagoGubun + param,
	    success: function(data){                               
	    	if(gubun=="schCago02"){
	    		$("#divCago02").html(data);
	    		$("#divCago03").html(text02);
				$("#divCago04").html(text03);
	    	}else if(gubun=="schCago03"){
	    		$("#divCago03").html(data);
				$("#divCago04").html(text03);
	    	}else if(gubun=="schCago04"){
	    		$("#divCago04").html(data);;
	    	}
	    },
	    error: function(e){
	       alert("에러:");
	    }
	});
}

//정렬 주문일 & 주문자명 클릭시 , 목록수 변경시
function fn_order_by(str){
	
	var frm=document.getElementById("orderFrm");
	if(str != ""){
		frm.ORDER_GUBUN.value=str;
	}
	
	frm.pagerMaxPageItems.value=$("#cnt").val();
	frm.submit();
}
	
	
</script>