<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		회원관리 목록	
		<small>회원관리 목록</small>
	</h1>
</section>
	
<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">회원관리 검색 조건</h3>

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
			
			<spform:form name="orderFrm" id="orderFrm" method="get" action="${contextPath }/adm/groupMemberMgr/popup" class="form-horizontal">
			<input type="hidden" id="GROUP_CD" name="GROUP_CD" value="${param.GROUP_CD }"/>
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">회원구분</label>
						<div class="col-sm-2">
							<jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="MEMB_GUBN"/>
								<jsp:param name="name" value="MEMB_GUBN" />
								<jsp:param name="value" value="${ obj.MEMB_GUBN }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="전체" />
							</jsp:include>
						</div>
						<label for="schGbn" class="col-sm-1 control-label">검색조건</label>
						<div class="col-sm-2">
							<select name="schGbn" id="schGbn" class="form-control select2" style="width: 100%;">
								<option value="MEMB_ID" ${obj.schGbn eq 'MEMB_ID' ? 'selected=selected':''}>아이디</option>
								<option value="MEMB_NAME" ${obj.schGbn eq 'MEMB_NAME' ? 'selected=selected':''}>회원명</option>
							</select>
						</div>
						<div class="col-sm-3">
							<input name="schTxt" id="schTxt" type="text" class="form-control" placeholder="검색어 입력" value="${obj.schTxt }">
						</div>
						<div class="col-sm-2"></div>
						<div class="col-sm-2"><button type="submit" class="btn btn-success pull-right">검색</button></div>
					</div>
				</div>
			<!-- /.box-body -->
			</spform:form>
			
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.box -->

	<div class="box-header with-border">
		<h3 class="box-title"></h3>
		<div class="box-tools">
			<a onclick="javascript:fn_state();" class="btn btn-sm btn-primary pull-right">저장</a>
		</div>
	</div>
	
	<div class="box">
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered">
				<colgroup>
					<col />
					<col />
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="CHK_ALL" name="CHK_ALL" onclick="javascript:fn_all_chk();" /></th>
						<th>번호</th>
						<th>아이디</th>
						<th>성명</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(obj.list) == 0 }">
					<tr><td colspan="3">검색된 회원이 없습니다.</td></tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td><input type="checkbox" id="CHK${loop.count }" name="CHK${loop.count }" value="${list.MEMB_ID }" /></td>
						<td>${loop.count }</td>
						<td>${list.MEMB_ID }</td>
						<td>${list.MEMB_NAME }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</section>

<script>
//전체 체크 및 해제 시
function fn_all_chk(){
	var check_yn = false;		
	if($("#CHK_ALL").is(":checked")){
		check_yn = true;
	}
	for(var i=1;i<= ${fn:length(obj.list) };i++){
		$("#CHK"+i).prop("checked",check_yn);
	}
}

//선택 회원 저장
function fn_state(){	
	var cnt = 0;
	var order_num_list = "";
	
	for(var i=1;i<= ${fn:length(obj.list) };i++){
		if($("#CHK"+i).is(":checked")){
			cnt++;
			if(order_num_list != "") {
				order_num_list+="$";
			}
			order_num_list+=$("#CHK"+i).val();
		}
	}
	if(cnt == 0){
		alert("체크한 항목이 없습니다.");
		return;
	}
	
	if(!confirm("저장 하시겠습니까?")) return;
	
	var frm=document.getElementById("orderFrm");
	
	$.ajax({
	    url: "${contextPath }/adm/groupMemberMgr/popup",
	    type: 'post',
	    data: 'CHK_MEMB_ID='+order_num_list+"&GROUP_CD="+frm.GROUP_CD.value,
	    success: function(data){                               
	    	opener.fn_member_popup_return(frm.GROUP_CD.value);
	    	window.close(); 
	    },
	    error: function(e){
	       alert("에러:");
	    }
	});
}

</script>