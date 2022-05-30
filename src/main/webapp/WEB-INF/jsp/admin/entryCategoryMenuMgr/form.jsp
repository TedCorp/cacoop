<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<script type="text/javascript">
$(function(){
	//숫자만 입력토록 함.
    $(document).on("keyup", ".number", function() {
    	$(this).number(true);
    });
	
  	//리스트 삭제 버튼
    $(".btnListDelete").click(function(){	
		$('#rcmdPdList').empty();
		
		$('#rcmdPdList').append(	"<thead><tr>"
								  + "<td style = 'width:8%; padding: 6px 12px; /* text-align:center; */ font-weight: bold;'>정렬순서</td>"
								  + "<td style = 'width:41%; padding: 6px 12px; /* text-align:center; */ font-weight: bold;''>카테고리코드</td>"
								  + "<td style = 'width:41%; padding: 6px 12px; /* text-align:center; */ font-weight: bold;''>카테고리명</td>"
								  + "<td style = 'width:6%; padding: 6px 12px; /* text-align:center; */ font-weight: bold;''><!-- 삭제 --></td>"
								  + "</tr></thead>"
				);
	
    });
  	

});

//저장버튼 클릭시
function fn_save(){
	var frm=document.getElementById("rcmdFrm");
	if(frm.ENTRY_NAME.value==""){
		alert("진입카테고리명을 입력하세요");
		frm.ENTRY_NAME.focus();
		return;
	}
	if(frm.SORT_ORDRM.value==""){
		alert("정렬순서를 입력하세요");
		frm.SORT_ORDR.focus();
		return;
	}	
	
	if(!confirm("저장 하시겠습니까?")) return;
	frm.submit();
}

//삭제버큰 클릭시
function fn_delete(){
	if(!confirm("삭제 하시겠습니까?")) return;
	
	var frm=document.getElementById("rcmdFrm");
	frm.action = "${contextPath }/adm/entryCategoryMenuMgr/delete/${entCagoInfo.ENTRY_ID}";	
	frm.submit();
}

//상품선택 팝업 호출
function fn_pd_popup(){
	window.open("${contextPath }/adm/entryCategoryMenuMgr/popup", "_blank", "width=900,height=900"); 
}

//상품선택 팝업 리턴값
function fn_pd_popup_return(CAGO_ID,CAGO_NAME){
	var frm=document.getElementById("rcmdFrm");

	var num_id = "num_"+CAGO_ID;
	var code_id = "code_"+CAGO_ID;
	var name_id = "name_"+CAGO_ID;
	var btn_id = "btn_"+CAGO_ID;
	
	
	//그룹내 상품 있는지 확인
	if($("#"+code_id).length > 0){
		//alert("현재 그룹에 상품( "+CAGO_ID+" | "+CAGO_NAME+" )이 포함되어 있습니다.");
		return false;
	}
	
	var addNum = "";
	addNum = '<tr>'
				+'<td style="padding-right:5px;padding-bottom:5px;width:8%;">'
					+'<input id="'+num_id+'" class="form-control" type="text" name="SORT_ORDR" value="'+($('input[name="SORT_ORDR"]').length+1)+'""/>'
				+'</td>'
				+'<td style="padding-right:5px;padding-bottom:5px;width:41%;">'
					+'<input id="'+code_id+'" class="form-control" type="text" name="ENTRYD_ID" value="'+CAGO_ID+'" readonly="readonly"/>'
				+'</td>'
				+'<td style="padding-right:5px;padding-bottom:5px;width:41%;">'
					+'<input id="'+name_id+'" class="form-control" type="text" name="ENTRYD_NAME" value="'+CAGO_NAME+'" readonly="readonly"/>'
				+'</td>'				
				+'<td style="padding-right:5px;padding-bottom:5px;width:6%;">'
					+'<a id="'+btn_id+'"class="btn btn-info pull-right" onclick="javascript:fn_pd_delete(\''+CAGO_ID+'\');">삭제</a>'
				+'</td>'
			+ '</tr>';
	$("#rcmdPdList").append(addNum);
	
	//alert($("#code_"+SEL_PD_CODE).val() +"//"+$("#"+row_id).length);	
	
	return true;
}

//상품추가 멀티리턴값
function fn_pd_multi_return(checkboxValues){
	var errormsg = "";

	for(var i=0; i<checkboxValues.length; i++){
		var pd_add = checkboxValues[i];
			
		var pdSplit = pd_add.split(',');	
		var pd_code = pdSplit[0];
		var pd_name = pdSplit[1];
		var pd_barcode = pdSplit[2];
		
		if(!fn_pd_popup_return(pd_code, pd_name))
			errormsg += pd_code + " || " +  pd_name + "\n";	    	
	}
	
	return errormsg;
	
}

// 상품삭제
function fn_pd_delete(pd_code){
	
	$('#name_'+pd_code).remove();
	$('#code_'+pd_code).remove();
	$('#barcd_'+pd_code).remove();
	$('#btn_'+pd_code).remove();
	$('#num_'+pd_code).remove();	

}
</script>

<c:set var="strActionUrl" value="${contextPath }/adm/entryCategoryMenuMgr" />
<c:set var="strMethod" value="post" />
<c:if test="${ !empty entCagoInfo.ENTRY_ID }"><!-- 수정시 사용 -->
	<c:set var="strActionUrl" value="${contextPath }/adm/entryCategoryMenuMgr/${entCagoInfo.ENTRY_ID }" />
	<c:set var="strMethod" value="put" />
</c:if>


<section class="content-header">
	<h1>
		진입카테고리메뉴관리
		<small></small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">
	<!-- Horizontal Form -->
	<spform:form name="rcmdFrm" id="rcmdFrm" method="${strMethod }" action="${strActionUrl }" class="form-horizontal">
		<!-- 내용 시작 -->
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">내용</h3>
			</div>
			<!-- /.box-header -->
	
			<!-- box-body -->
			<div class="box-body">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">코드</label>
						<div class="col-sm-10">
							<c:choose>
							<c:when test="${ !empty entCagoInfo.ENTRY_ID }">
								${entCagoInfo.ENTRY_ID }
								<input type="hidden" id="ENTRY_ID" name="ENTRY_ID" value="${entCagoInfo.ENTRY_ID }" />
							</c:when>
							<c:otherwise>
								자동생성
							</c:otherwise>
							</c:choose>
						</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">진입카테고리명</label>
						<div class="col-sm-8">
							<input class="form-control" type="text" id="ENTRY_NAME" name="ENTRY_NAME" value="${entCagoInfo.ENTRY_NAME }" maxlength="50" readonly/>
						</div>
					</div><br/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">정렬순서</label>
						<div class="col-sm-3">
							<input class="form-control input-sm number" type="text" 
								id="SORT_ORDRM" name="SORT_ORDRM" value="${entCagoInfo.SORT_ORDR }" maxlength="5" readonly/>
						</div>
						<label for="inputEmail3" class="col-sm-2 control-label">사용여부</label>
						<div class="col-sm-3">
							<select name="USE_YN" id="USE_YN" class="form-control select2" style="width: 100%;" disabled>
								<option value="Y" ${entCagoInfo.USE_YN == 'Y' ? 'selected=selected':''}>사용</option>
								<option value="N" ${entCagoInfo.USE_YN == 'N' ? 'selected=selected':''}>미사용</option>
							</select>
							<%-- <input type="text" id="OUTPT_FG" name="OUTPT_FG" value="${tb_pdrcmdxm.OUTPT_FG }" /> --%>
						</div>
					</div><br/>
					
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label"><!-- 그룹핑 상품 --></label>
						<div class="col-sm-8">
							<button type="button" class="btn btn-primary btnAdd" onclick="javascript:fn_pd_popup();">
								<i class="fa fa-plus"></i> 카테고리 추가 
							</button>							
							<button type="button" class="btn btn-primary btnListDelete">
								<i class="fa fa-file-excel-o"></i> 리스트 삭제
							</button>
						</div>
					</div>						
					
					
						<label for="inputEmail3" class="col-sm-2 control-label"></label>
						<table id="rcmdPdList" style = "width:67%;">
							
							<thead>
								<tr>
									<td style = "width:8%; padding: 6px 12px; /* text-align:center; */ font-weight: bold;">정렬순서</td>
									<!-- <td style = "width:5%; padding: 6px 12px;/* text-align:center; */ font-weight: bold;">No.</td> -->
									<td style = "width:41%; padding: 6px 12px; /* text-align:center; */ font-weight: bold;">카테고리코드</td>
									<td style = "width:41%; padding: 6px 12px; /* text-align:center; */ font-weight: bold;">카테고리명</td>
									<td style = "width:6%; padding: 6px 12px; /* text-align:center; */ font-weight: bold;"><!-- 삭제 --></td>
								</tr>								
							</thead>
							
							<tbody>
								<c:forEach items="${entCagoDetail}" var="list" varStatus="loop">
									<tr>
										<td style="padding-right:5px;padding-bottom:5px;width:80px;">
											<input id="num_${list.ENTRYD_ID }" class="form-control"
												type="text" name="SORT_ORDR" value="${list.SORT_ORDR}"/>
										</td>											
										<td style="padding-right:5px;padding-bottom:5px;width:240px;">
											<input id="code_${list.ENTRYD_ID }" class="form-control"  
												type="text" name="ENTRYD_ID" value="${list.ENTRYD_ID }" readonly="readonly"/>
										</td>
										<td style="padding-right:5px;padding-bottom:5px;width:240px;">
											<input id="name_${list.ENTRYD_ID }" class="form-control"  
												type="text" name="ENTRYD_NAME" value="${list.ENTRYD_NAME }" readonly="readonly"/>
										</td>																																				
										<td style="padding-right:5px;padding-bottom:5px;">
											<a id="btn_${list.ENTRYD_ID }" style="height:33.98px;width:100%" 
												onclick="javascript:fn_pd_delete('${list.ENTRYD_ID}');" class="btn btn-info pull-right">삭제</a>
										</td>
									</tr>
								</c:forEach>	
							</tbody>					
							
						</table>
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- 내용 끝 -->
			
			</spform:form>
			
			<div class="box-footer" >
				<a href="${contextPath}/adm/entryCategoryMenuMgr" class="btn btn-default pull-right">리스트</a>
				<a onclick="javascript:fn_save();" class="btn btn-info pull-right">저장</a>
				<c:if test="${ !empty entCagoInfo.ENTRY_ID }"><!-- 수정시 사용 -->
				<a onclick="javascript:fn_delete();" class="btn btn-info pull-right" style="background-color:red;">삭제</a>
				</c:if>
			</div>
			
			<!-- /.box-footer -->
	<!-- /.box -->
</section> 
 