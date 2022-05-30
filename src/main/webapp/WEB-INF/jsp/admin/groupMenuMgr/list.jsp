<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		그룹별 메뉴관리
		<small>그룹별 메뉴 목록</small>
	</h1>
</section>


<c:set var="strActionUrl" value="${contextPath }/adm/groupMenuMgr" />
<c:set var="strMethod" value="get" />

<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">검색 조건</h3>
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
				<input type="hidden" id="CHK_MENU_CODE" name="CHK_MENU_CODE" value="" /><!-- 메뉴 체크 항목 -->
				
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
			<h3 class="box-title">그룹별 메뉴 목록</h3>
			<div class="box-tools">
				<a onclick="javascript:fn_state();" class="btn btn-sm btn-primary pull-right">저장</a>
			</div>
		</div>
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
						<th class="txt-middle"><input type="checkbox" id="CHK_ALL" name="CHK_ALL" onclick="javascript:fn_all_chk();" /></th>
						<th class="txt-middle">번호</th>
						<th>메뉴명</th>
						<th>URL</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<td class="txt-middle"><input type="checkbox" id="CHK${loop.count }" name="CHK${loop.count }" value="${list.MENU_CD }" ${list.CHK == 'Y' ? 'checked=checked':'' }/></td>
						<td class="txt-middle">${loop.count }</td>
						<td>${list.MENU_NAME }</td>
						<td>${list.MENU_URL }</td>
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
	
	//체크한 메뉴 저장 
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
		/* if(cnt == 0){
			alert("체크한 항목이 없습니다.");
			return;
		} */
		
		if(!confirm("저장 하시겠습니까?"))return;
		
		var frm=document.getElementById("orderFrm");
		frm.CHK_MENU_CODE.value=order_num_list;
		frm.method="post";
		frm.submit();
	}
	
</script>