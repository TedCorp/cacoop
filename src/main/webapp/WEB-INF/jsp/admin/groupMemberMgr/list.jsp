<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		그룹별 회원관리	
		<small>그룹별 회원 목록</small>
	</h1>
</section>

<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">검색 조건</h3>

			<div class="box-tools pull-right">
				<button type="button" class="btn btn-box-tool" data-widget="collapse">
					<i class="fa fa-minus"></i>
				</button>
				<button type="button" class="btn btn-box-tool" data-widget="remove">
					<i class="fa fa-remove"></i>
				</button>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body">			
			<spform:form name="orderFrm" id="orderFrm" method="get" action="${contextPath }/adm/groupMemberMgr" class="form-horizontal">
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">그룹</label>
						<div class="col-sm-2">
							<select name="GROUP_CD" id="GROUP_CD" class="form-control select2">
								<c:forEach items="${tb_sysgrpxm.list }" var="list" varStatus="loop">
									<option value="${list.GROUP_CD }" ${list.GROUP_CD eq obj.GROUP_CD ? 'selected=selected':''}>${list.GROUP_NAME }</option>
								</c:forEach> 
			                </select>		
						</div>
						<div class="col-sm-1"><button type="submit" class="btn btn-success">검색</button></div>
					</div>
				</div>
			<!-- /.box-body -->
			</spform:form>			
		</div>
	</div>
	<!-- /.box -->

	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">그룹별 회원 목록</h3>
			<div class="box-tools">
				<a onclick="javascript:fn_member_popup();" class="btn btn-sm btn-primary pull-right">추가</a>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered">
				<colgroup>
					<col style="with:10px" />
					<col style="with:50px" />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>아이디</th>
						<th>성명</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(obj.list) == 0 }">
					<tr><td colspan="3">등록된 회원이 없습니다.</td></tr>
				</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td>${loop.count }</td>
						<td>${list.MEMB_ID }</td>
						<td>${list.MEMB_NM }</td>
						<td><a href="#" onclick="javascript:fn_delete('${list.GROUP_CD}','${list.MEMB_ID }');" class="btn btn-danger btn-sm">삭제</a></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</section>

<spform:form name="delFrm" id="delFrm" method="DELETE" action="${contextPath }/adm/groupMemberMgr" class="form-horizontal">
<input type="hidden" id="GROUP_CD" name="GROUP_CD" value="" />
<input type="hidden" id="MEMB_ID" name="MEMB_ID" value="" />
 </spform:form>
 
<script>
//상위메뉴선택 팝업 호출
function fn_member_popup(){
	window.open("${contextPath }/adm/groupMemberMgr/popup?GROUP_CD=${obj.GROUP_CD}", "_blank", "width=1200,height=800");  
}	

function fn_member_popup_return(GROUP_CD){
	var frm=document.getElementById("orderFrm");
	frm.GROUP_CD.value=GROUP_CD;
	frm.submit();
}
//등록한 회원 삭제
function fn_delete(GROUP_CD,MEMB_ID){
	if(!confirm("삭제 하시겠습니까?")) return;
	var frm=document.getElementById("delFrm");
	frm.GROUP_CD.value=GROUP_CD;
	frm.MEMB_ID.value=MEMB_ID;
	frm.submit();
}	
</script>