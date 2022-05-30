<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		광고관리 테이블
		<small>상품 목록</small>
	</h1>
</section>

<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">

		<!-- /.box-header -->
		<div class="box-body">
			<form id="selectForm" class="form-horizontal">
				<input type="hidden" name="AD_ID_NCOPY" value="${adinfo.AD_ID_NCOPY }" /> 
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">광고번호</label>
						<div class="col-sm-3">
							<select name="AD_ID" id="AD_ID" class="form-control select2" style="width: 100%;" >
								<option value="">-------- 선택 --------</option>
									<c:forEach items="${adList }" var="adInfo" varStatus="loop">
										<c:if test="${adinfo.AD_ID_NCOPY != adInfo.AD_ID}">
											<option value="${adInfo.AD_ID }" ${adinfo.AD_ID eq  adInfo.AD_ID ? 'selected=selected' : ''}>${adInfo.AD_NAME }</option>
										</c:if>
									</c:forEach>
							</select>
						</div>
					</div>
				</div>
				<!-- /.row -->
			</form>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.box -->
	<!-- 검색 박스 -->
	<div class="box">
		<!-- /.box-header -->
		<spform:form name="copyFrm" id="copyFrm" method="post" action="${contextPath}/adm/adMgr/popup/copy" class="form-horizontal"> 
			<input type="hidden" name="AD_ID" value="${adinfo.AD_ID }" />
			<input type="hidden" name="AD_ID_NCOPY" value="${adinfo.AD_ID_NCOPY }" />
			<div class="box-body">
				<table class="table table-bordered">
					<colgroup>
						<col style="with:10px" />
						<col />
						<col style="with:200px" />
						<col />
						<col />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th><input type="checkbox" id="allCheck" /></th>
							<th>상품ID</th>
							<th>상품명</th>
							<th>정상가</th>
							<th>판매가</th>
							<th>제약사항</th>
							<th>첨부파일</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${ empty pdList}">
							<tr>
								<td colspan="8" align="center">조회된 내용이 없습니다.</td>
							</tr>
						</c:if>
						<c:forEach items="${pdList }" var="ent" varStatus="loop">
							<tr>
								<td><input type="checkbox" name="pdIdArr" value="${ent.PD_ID }" /></td>
								<td>${ent.PD_ID }</td>
								<td>${ent.PD_NAME }</td>
								<td>${ent.PD_PRICE }</td>
								<td>${ent.SELL_PRICE }</td>
								<td>${ent.PD_CONS }</td>
								<td>
									<c:set var="strPath" value=""/>
									<c:if test="${ !empty(adverinfo.ATFL_ID) }"><c:set var="strPath" value="${adverinfo.ATFL_ID }/"/></c:if>
									<img class="goodsImg" src="${contextPath }/upload/jundan/${ent.AD_ID }/${strPath}${ent.ATFL_NAME }" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>" width="50" height="50"/>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<button type="button" class="btn btn-primary pull-right btnCopy" style="margin: 20px 10px 20px 0;">복사추가</button>
				<button type="button" class="btn btn-default pull-right btnClose" style="margin: 20px 10px 20px 0;">닫기</button>
			</div>
		</spform:form>
		
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>
	</div>
</section>

<script type="text/javascript">
$(function(){
	$("#allCheck").click(function(){
		if($("#allCheck").prop("checked")) {
			$("input[type=checkbox]").prop("checked",true);
		} else {
			$("input[type=checkbox]").prop("checked",false);
		}
	});
	
	$('.btnClose').click(function(){     
		window.close();
	});
	
	$('.btnCopy').click(function(){
		if( $(":checkbox[name='pdIdArr']:checked").length == 0 ){
			alert("복사할 항목을 1개이상 체크해주세요.");
			return;
		}
		if(!confirm($("input[name=pdIdArr]:checked").length + " 건을 선택하시겠습니까?")) return;
		
		$("#copyFrm").submit();
	});
	  $('#AD_ID').change(function() {
          $('#selectForm').submit();
    });
	  
});

</script>

	