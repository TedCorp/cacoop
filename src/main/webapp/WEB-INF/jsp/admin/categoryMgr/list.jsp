<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>


<script type="text/javascript">

var strSelectCagoId = "";
var strSelectCagoName = "";
var strSelectLvl = "";

$(function() {

	// 새로고침때 초기화
	if('${catagory.CAGO_ID}' == ''){
		cateTree.clearCookie();
	}else{
		selectNode('${catagory.CAGO_ID}', '${catagory.CAGO_NAME}')
	}
	
    $('#frm').validate({
        onfocusout: false,
        rules: {
        	CAGO_NAME: {
                required: true
            },
            SORT_ORDR: {
                number: true,
                required: true
            }
        }, messages: {
        	CAGO_NAME: {
                required: '카테고리명을 입력하세요.'
            },
            SORT_ORDR: {
            	required: '정렬순서를 입력하세요.',
            	number: '정렬순서는 숫자만 입력하세요.'
            }
        }, errorPlacement: function(error, element) {
            // do nothing
        }, invalidHandler: function(form, validator) {
             var errors = validator.numberOfInvalids();
             if (errors) {
                 alert(validator.errorList[0].message);
                 validator.errorList[0].element.focus();
             }          
        }, submitHandler: function(form) {
        	form.submit();
        }
    });
    
	$("#btnDel").hide();
	
	$("#btnCateAdd").click(function(){		
	    $("#CAGO_ID").val("");
        $("#lblCAGO_ID").text("자동 생성");
	    $("#CAGO_NAME").val("");
	    $("#UPCAGO_ID").val(strSelectCagoId);
	    $("#UPCAGO_NAME").val(strSelectCagoName);
	    $("#SORT_ORDR").val("");
		$("input:radio[name='USE_YN']:radio[value='Y']").prop('checked',true);
		
		$("#btnSave").text("저장");
		$("#btnDel").hide();
		
		strSelectCagoId = "";
		strSelectCagoName = "";
	});
	
	$("#btnCateNew").click(function(){
		strSelectCagoId = "";
		strSelectCagoName = "";
		
	    $("#CAGO_ID").val("");
        $("#lblCAGO_ID").text("자동 생성");
	    $("#CAGO_NAME").val("");
	    $("#UPCAGO_ID").val("");
	    $("#UPCAGO_NAME").val("");
	    $("#SORT_ORDR").val("");
		$("input:radio[name='USE_YN']:radio[value='Y']").prop('checked',true);
		
		$("#btnSave").text("저장");
		$("#btnDel").hide();
	});
	
	
	$("#btnUpCagoDel").click(function(){		
	    $("#UPCAGO_ID").val("");
	    $("#UPCAGO_NAME").val("");
	});
	
	// 삭제
	$("#btnDel").click(function(){

		if(strSelectCagoId == ""){
			alert("삭제할 카테고리를 선택하세요.");
		}else{
		    $("#delCAGO_ID").val(strSelectCagoId);
		    
			$.ajax({
				type: "POST",
				url: "${contextPath}/adm/categoryMgr/deleteChk",
				data: $("#deleteFrm").serialize(),
				success: function (data) {
					//하위 카테고리가 없을 경우
					if (data == '0') {
						if(strSelectCagoId == ""){
							alert("삭제할 카테고리를 선택하세요.");
						}else{
						    $("#delCAGO_ID").val(strSelectCagoId);
							if(confirm("삭제하시겠습니까?")){
								$("#deleteFrm").submit();
							}
						}
					}else{
						alert("하위 카테고리 삭제후 처리하세요.");
					}
				}, error: function (jqXHR, textStatus, errorThrown) {
					alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
				}
			});
		}
	});
	
	// 트리 초기화
	$('#myModal').on('show.bs.modal', function (event) {
		upCateTree.closeAll();
	});
});

function selectNode(strCagoId, strCagoName){
	strSelectCagoId = strCagoId;
	strSelectCagoName = strCagoName;
	//strSelectLvl = strLvl;
    
	$.ajax({
		type: "GET",
		url: "${contextPath}/adm/categoryMgr/view/"+strCagoId+".json",
		data : {
			CAGO_ID : strCagoId
		},
		success:function(data) {
			//alert(JSON.stringify(data));
		    var objCategory = data.category; 
		    $("#CAGO_ID").val(objCategory.cago_ID);
	        $("#lblCAGO_ID").text(objCategory.cago_ID);
		    $("#lblCAGO_ID").val(objCategory.cago_ID);
		    $("#CAGO_NAME").val(objCategory.cago_NAME);
		    $("#UPCAGO_ID").val(objCategory.upcago_ID);
		    $("#UPCAGO_NAME").val(objCategory.upcago_NAME);
		    $("#SORT_ORDR").val(objCategory.sort_ORDR);
			$("input:radio[name='USE_YN']:radio[value='"+ objCategory.use_YN +"']").prop('checked',true);
			

			$("#btnSave").text("수정");
			$("#btnDel").show();

		},
		error: function(result){
			alert(result.status+":"+result.description+"찾을수 없는 페이지입니다.\n관리자에게 문의하세요.");
		}
	});
}

//상위카테고리 세팅
function setHigherCd(strUpCagoId, strUpCagoName){
	// 현제 상위카테고리 체크
	if($("#UPCAGO_ID").val() == strUpCagoId){
		alert("선택하신 카테고리는 현제 상위 카테고리입니다.");
		return;
	}

	if(strUpCagoName != null) $("#UPCAGO_NAME").val(strUpCagoName);
	else $("#UPCAGO_NAME").text("[최상위 카테고리]");
	
	$("#UPCAGO_ID").val(strUpCagoId);

	$('#myModal').modal('hide');
}

//== 2019.02.25 chjw==
//정렬순서 Default Value
function validatrion_submit(){	
	if($('#SORT_ORDR').val() == "" || $('#SORT_ORDR').val() == null){
		alert("정렬순서를 입력해주세요." + $('#SORT_ORDR').val());
		/* $('#SORT_ORDR').val(99); */
	    return false;   
	}
}

//숫자만
function onlyNumber(obj){
	 $(obj).keyup(function(){
	      $(this).val($(this).val().replace(/[^0-9]/g,""));
	 });
 }
 
</script>

<section class="content-header">
	<h1>
		카테고리 관리
		<small>상품 카테고리 정보</small>
	</h1>
</section>

<section class="content">
	<div class="row">
		<!-- Tree -->
		<section class="col-md-4 connectedSortable">
			<div class="box box-primary">
				<div class="box-body">
					<a href="javascript: cateTree.openAll();"><img src="${contextPath}/resources/adminlte/plugins/tree/img/openall.gif" width="15px" /></a> | <a href="javascript: cateTree.closeAll();"><img src="${contextPath}/resources/adminlte/plugins/tree/img/closeall.gif" width="15px"/></a>
					<div class="tree_nav" style="max-height: 65vh; overflow-y: scroll;">						
						<script type="text/javascript">
						/* 		
							mytree.add( p1, p2, p3, p4, p5, p6, p7 ) 에서 
							p1 : id값
							p2 : 부모참조 id값. 여기에 적힌 id가 부모노드가 된다
							p3 : 표시될 노드의 이름 
							p4 : 해당 노드를 클릭했을때 이동될 페이지 주소
							p5 : 해당노드의 이름에 마우스를 가져다 대면 뜨는 설명
							p6 : a태그의 target에 해당하는값. 보통 새창에서 열리게 할때 쓰임
							p7 : 이미지경로및 이름. 여기에 적힌 이미지가 표시된다. 안적을경우엔 기본값으로 표시
						 */
						cateTree = new dTree('cateTree', '${contextPath }'); //dTree 생성

						function declareData(){
							cateTree.add(0,-1,"제품 카테고리");
							<c:forEach var="ent" items="${ obj.list }" varStatus="status">
								cateTree.add("${ent.CAGO_ID}", "${empty ent.UPCAGO_ID ? '0' : ent.UPCAGO_ID}", "${ent.CAGO_NAME}${ent.USE_YN eq 'N' ? '(미사용)' : ''}" , "javascript: selectNode(\'${ent.CAGO_ID}\', \'${ent.CAGO_NAME}\');", "${ent.CAGO_NAME}", "","","");
							</c:forEach>
							document.write(cateTree);
						}
						declareData();
						</script>
					</div>
				</div>
				<div class="box-footer">
					<span class="pull-right">
						<button type="submit" onclick="return;" id="btnCateNew" class="btn btn-info btn-sm">신규등록</button>
						<button type="submit" onclick="return;" id="btnCateAdd" class="btn btn-info btn-sm">현카테고리에 등록</button>
					</span>
				</div>	
			</div>			
		</section>
		<!-- detail -->
		<section class="col-md-8">
			<div class="row">
				<div class="col-xs-12">
					<div class="box box-primary">
						<div class="box-header with-border">
							<button type="button" class="btn btn-default btn-sm pull-right btnHelp">
								<i class="fa fa-question-circle"></i> 도움말
							</button>
						</div>
						<spform:form name="frm" id="frm" method="post" action="" role="form" class="form-horizontal">
						<!-- box-body -->
						<div class="box-body">							
							<input type="hidden" id="CAGO_ID" name="CAGO_ID" />
							<input type="hidden" id="UPCAGO_ID" name="UPCAGO_ID" />
							<input type="hidden" id="LVL" name="LVL" />
							
							<div class="form-group">
								<label for="CAGO_ID" class="col-sm-2 control-label required">카테고리ID</label>
								<div class="col-sm-9">
									<p class="form-control-static"><label id="lblCAGO_ID">자동 생성</label></p>
								</div>
							</div>		
								
							<div class="form-group">
								<label for="CAGO_NAME" class="col-sm-2 control-label required">카테고리명</label>
								<div class="col-sm-6">
										<input type="text" class="form-control" id="CAGO_NAME" name="CAGO_NAME" placeholder="카테고리명" required="required" maxlength="20" />
								</div>
							</div>
							
							<div class="form-group">
								<label for="UPCAGO_NAME" class="col-sm-2 control-label required">상위카테고리</label>
								<div class="col-sm-4">
									<div class="input-group">
										<input type="text" class="form-control" id="UPCAGO_NAME" name="UPCAGO_NAME" readonly />
										<span class="input-group-btn">
											<button type="button" class="btn btn-info right-5" data-toggle="modal" data-target="#myModal">선택</button>
											<button type="button" class="btn btn-default" id="btnUpCagoDel">초기화</button>
										</span>
									</div>										
								</div>
							</div>
							
							<div class="form-group">
								<label for="USE_YN" class="col-sm-2 control-label required">사용여부</label>
								<div class="col-sm-10">
									<input name="USE_YN" id="USE_YN_Y" value="Y" type="radio" title="사용" checked/>
									<label for="USE_YN_Y">사용</label>
									<input name="USE_YN" id="USE_YN_N" value="N" type="radio" title="미사용"/>
									<label for="USE_YN_N">미사용</label>
								</div>
							</div>
							
							<div class="form-group">
								<label for="SORT_ORDR" class="col-sm-2 control-label required">정렬순서</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" name="SORT_ORDR" id="SORT_ORDR" number  onkeydown="return onlyNumber(this)" placeholder="숫자만 입력 가능합니다." maxlength="5"/>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<span class="pull-right">
								<button type="submit" onclick="return validatrion_submit();" id="btnSave"class="btn btn-primary">저장</button>
								<button type="button" id="btnDel" class="btn btn-danger">삭제</button>
							</span>
						</div>	
						</spform:form>
					</div>
				</div>
			</div>	
		</section>
	</div>			
</section>

<spform:form name="deleteFrm" id="deleteFrm" method="post" action="${contextPath}/adm/categoryMgr/delete" role="form" class="form-horizontal">
	<input type="hidden" id="delCAGO_ID" name="CAGO_ID" />
</spform:form>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">상위 카테고리 선택</h4>
			</div>
			<div class="modal-body">
				<div class="box box-primary">
					<div class="box-body">
						<a href="javascript: upCateTree.openAll();"><img src="${contextPath}/resources/adminlte/plugins/tree/img/openall.gif" width="15px"/></a> | 
						<a href="javascript: upCateTree.closeAll();"><img src="${contextPath}/resources/adminlte/plugins/tree/img/closeall.gif" width="15px"/></a><br>
						<div class="tree_nav" style="max-height: 60vh; overflow-y: scroll;">							
							<script type="text/javascript">
								//dTree 생성
								upCateTree = new dTree('upCateTree', '${contextPath }');
	
								upCateTree.add(0,-1,"제품 카테고리");
								<c:forEach var="ent" items="${ obj.list }" varStatus="status">
									upCateTree.add("${ent.CAGO_ID}", "${empty ent.UPCAGO_ID ? '0' : ent.UPCAGO_ID}", "${ent.CAGO_NAME}${ent.USE_YN eq 'N' ? '(미사용)' : ''}" , "javascript: setHigherCd(\'${ent.CAGO_ID}\', \'${ent.CAGO_NAME}\');", "${ent.CAGO_NAME}", "","","");
								</c:forEach>
								document.write(upCateTree);
							</script>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
