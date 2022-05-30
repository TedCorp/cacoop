<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- 로딩바스타일 -->
<style type = "text/css">
	body{
		/* text-align: center; */
		margin: 0 auto;
	}
	
	.save-loading-background{
	    position: fixed;
	    left:0;
	    right:0;
	    top:0;
	    bottom:0;
	    background: rgba(0,0,0,0.2); /*not in ie */
	    z-index:100;
	    filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');    /* ie */
	}
	
	.save-loading{
		position: fixed;
	    top:50%;
	    left:50%;
	    margin-left: -21px;
	    margin-top: -21px;
	    z-index:120;
	}
	
	.display-none{
		display:none;
	}
</style>

<!-- ajax 처리중 효과 -->
<!-- 화면 어두워짐 -->
<div id = "Progress_Loading1" name = "Progress_Loading" class ="save-loading-background display-none"></div>
<!-- 로딩바 -->
<div id = "Progress_Loading2" name = "Progress_Loading" class ="save-loading display-none">
	<img src="${contextPath}/resources/img/common/Progress_Loading.gif"/>
</div>

<c:set var="strActionUrl" value="${contextPath }/adm/comCodMgr" />
<c:set var="strMethod" value="post" />
<c:if test="${ !empty tb_comcodxm.COMD_CODE }"><!-- 수정시 사용 -->
	<c:set var="strActionUrl" value="${contextPath }/adm/comCodMgr/${tb_comcodxm.COMD_CODE }" />
</c:if>

<section class="content-header">
	<h1>
		공통코드 관리
		<small></small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">
		<!-- Horizontal Form -->			
		<spform:form name="orderFrm" id="orderFrm" class="form-horizontal">
		
		<!-- 내용 시작 -->
		<div class="box box-info">
		<div class="box-header with-border">
			<h3 class="box-title">내용</h3>
		</div>
		<!-- /.box-header -->

			<!-- box-body -->
			<div class="box-body">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">공통 코드</label>
					<div class="col-sm-4">
					<c:choose>							
						<c:when test="${ !empty tb_comcodxm.COMM_CODE }">
							<input type="text" id="commcode" value="${tb_comcodxm.COMM_CODE }" class='form-control' readonly>
							<input type="hidden" id="commcode_chk" name="commcode_chk" value="Y" />
						</c:when>
						<c:otherwise>
							<div class="input-group input-group-sm">
								<input type="hidden" id="commcode_chk" name="commcode_chk" value="N" />
								<input class="form-control input-sm" type="text" id="commcode" value="" onchange="javascript:fn_commcode_changed(this);" maxlength="15" />
								<span class="input-group-btn">
									<a id = "comm_cd_chk" onclick="javascript:fn_commcode_chk();" class="btn btn-warning btn-sm">중복검사</a>
								</span>
							</div>
						</c:otherwise>
					</c:choose>
					</div>
				</div><br/>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">공통코드명</label>
					<div class="col-sm-4">
						<input class="form-control" type="text" id="MainCommName" name="MainCommName" value="${tb_comcodxm.COMCOD_NAME }" maxlength="50"/>
					</div>
				</div><br/>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">사용여부</label>
					<div class="col-sm-4">
						<select name="USE_YN" id="USE_YN" class="form-control select2" style="width: 100%;">
							<option value="Y" ${tb_comcodxm.USE_YN == 'Y' ? 'selected=selected':''}>Y</option>
							<option value="N" ${tb_comcodxm.USE_YN == 'N' ? 'selected=selected':''}>N</option>
						</select>
					</div>
				</div><br/>
				<div class="form-group">
					<label class="col-sm-2 control-label">등록자</label>
					<div class="col-sm-4">${tb_comcodxm.REGP_ID }</div>
					<label class="col-sm-1 control-label">등록일</label>
					<div class="col-sm-4">${tb_comcodxm.REG_DTM }</div>
				</div><br/>
				<div class="form-group">
					<label class="col-sm-2 control-label">수정자</label>
					<div class="col-sm-4">${tb_comcodxm.MODP_ID }</div>
					<label class="col-sm-1 control-label">수정일</label>
					<div class="col-sm-4">${tb_comcodxm.MOD_DTM }</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">코드 설명</label>
					<div class="col-sm-9">
						<textarea name="MainCodeExpn" id="MainCodeExpn" class="form-control" rows="5">${tb_comcodxm.CODE_EXPN } </textarea>
					</div>
				</div><br/>
						
				<label class="col-sm-2 control-label">공통코드 상세</label>
				
				<div class="col-sm-9">
				<div style= "float:right; margin-right:10px; margin-bottom:5px;">
					<a onclick="javascript:fn_add();" class="btn btn-info btn-sm" style="width:60px;">추가</a>
				</div>
				
				<table class="table table-bordered" style="border: 1px solid #00c0ef" id="tbDetail">
					<colgroup>
						<col style="width:75px" />
						<col />
						<col />
						<col style="width:80px;" />
						<col style="width:15%;"/>
						<col style="width:15%;"/>
						<col style="width:78px;"/>
						<col />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th>정렬순서</th>
							<th>상세 코드</th>
							<th>상세 코드명</th>
							<th>사용여부</th>
							<th>수정자</th>
							<th>수정일</th>
							<th>삭제</th>
						</tr>
					</thead>
					
					<tbody id="CodData">
					<c:if test="${fn:length(tb_comcodxd) == 0}">
						<%-- <tr>
							<td colspan="8">조회된 메뉴가 없습니다.</td>
						</tr> --%>
					</c:if>
					<c:forEach items="${tb_comcodxd }" var="list" varStatus="loop">
						<tr>
							<td><input type ="text" class = "form-control" value = "${list.SORT_ORDR}"></td>
							<td><input type='text' name="COMD_CODE" value="${list.COMD_CODE}"  class='form-control' readonly></td>
							<td><input type="text" value="${list.COMDCD_NAME }" class="form-control"/></td>
							<td>
								<select name="USE_YN" id="USE_YN" class='form-control select2' style='width: 100%;'>
									<option value="Y" ${list.USE_YN == 'Y' ? 'selected=selected':''}>Y</option>
									<option value="N" ${list.USE_YN == 'N' ? 'selected=selected':''}>N</option>
								</select>
							</td>
							<td>${list.MODP_ID }</td>
							<td>${list.MOD_DTM }</td>
							<td>
								<button type='button' name ="DELROW" class='btn btn-sm btn-danger DELROW' style ="width:100%;">삭제</button>
								<input type="hidden" id = "CodStatus" name = "CodStatus" value="Read"/><!-- 상태 -->
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
			<a href="${contextPath}/adm/comCodMgr" class="btn btn-default pull-right"><i class="fa fa-list"></i> 목록</a>
			<a onclick="javascript:fn_save();" class="btn btn-primary pull-right" style="margin-right: 5px;"><i class="fa fa-save"></i> 저장</a>
			<c:if test="${ NewYN == 'N' }">
					<button type="button" class="btn btn-danger pull-right btnDel" style="margin-right: 5px;" onclick="javascript:fn_Delete()">
					<i class="fa fa-remove"></i> 삭제 </button>
			</c:if>
		</div>			
		<!-- /.box-footer -->
<!-- /.box -->
</section>
 
 
<script type="text/javascript">

//저장버튼 클릭시
function fn_save(){
	
	if(!confirm("저장하시겠습니까?")) return;
	
	// 공통마스터 코드
	var comm_code = document.getElementById("commcode").value.toUpperCase();
	var comm_name = document.getElementById("MainCommName").value;
	var comm_useyn = document.getElementById("USE_YN").value;
	var comm_codeexpn = document.getElementById("MainCodeExpn").value;
	
	// 공통 마스터 신규, 기존 구분
	var NewYN = '<c:out value="${NewYN}"/>';
	var CodFlag;
	if(NewYN == "Y")
		codFlag = "CommInsert";
	else
		codFlag = "CommUpdate";
	
	
	//중복검사 - 공통코드
	if($("input[id=commcode_chk]").val() == "N" ) {
		alert("공통코드 중복검사를 해주세요.");	
		return;
	}

	//상세코드 빈값 검사 : 빈값o : true, 빈값x :false
	if( fn_blank_chk() )
		return;
	
	//마스터 저장
	$.ajax({ 
      url:'/adm/comCodMgr/save', //가져오고자하는 서버페이지 주소를 넣는다. 
      type:'post', //데이터를 서버로 전송하게 된다. 
      data:{
   	   	  COMM_CODE : comm_code,
   	   	  COMCOD_NAME : comm_name,
   	   	  USE_YN : comm_useyn,
   	   	  CODE_EXPN : comm_codeexpn,     	   	  
   	   	  CodFlag : codFlag     	   	  
      } , 
      beforeSend:function(){
      	$('div[name=Progress_Loading]').removeClass('display-none');
      },
      success : function(t){ 
      } , 
      error : function(){ 
      },
      complete : function() { //마스터 ajax 처리후 실행
      	
      	//디테일 저장
      	$('#CodData tr').each(function(index){
      		/* 예외처리해야됨 */
      		/* alert(Index); */
      		
      		var tr = $(this);
      		var td = tr.children();
      		
      		$.ajax({ 
                     url:'/adm/comCodMgr/save', //가져오고자하는 서버페이지 주소를 넣는다. 
                     type:'post', //데이터를 서버로 전송하게 된다. 
                     async : true, // 동기화 처리
                     data:{ 
                  	   	  SORT_ORDR : td.eq(0).find('input[type="text"]').val()	,
                  	   	  COMM_CODE : comm_code,
                  	   	  COMD_CODE : td.eq(1).find('input[type="text"]').val().toUpperCase(),
                  	   	  COMDCD_NAME : td.eq(2).find('input[type="text"]').val(),
                  	   	  USE_YN : td.eq(3).find('select[name="USE_YN"]').val(),
                  	      CodFlag : td.eq(6).find('input[name="CodStatus"]').val()
                     } , 
                     success : function(t){ 
                     } , 
                     error : function(){
                     }   
              });				
      	});        	
      }
	});
	

	/* ajax 통신완료 시 새로고침 */
	$( document ).ajaxStop(function() {
		
		alert("저장완료");
				
		if(NewYN == "Y") //신규등록일경우
			window.location.href='/adm/comCodMgr/' + comm_code;
		else
			window.location.reload();
	});
}

//공통마스터 + 디테일 삭제
function fn_Delete()
{
	if(!confirm("삭제하시겠습니까?")) return;
	
	var comm_code = document.getElementById("commcode").value.toUpperCase();
	var codFlag = "CommDelete";
	
	$.ajax({ 
      url:'/adm/comCodMgr/save', //가져오고자하는 서버페이지 주소를 넣는다. 
      type:'post', //데이터를 서버로 전송하게 된다.
      data:{ 
   	   	  COMM_CODE : comm_code,
   	      CodFlag : codFlag	
      } , 
      success : function(t){
      } , 
      error : function(){
      	alert("삭제실패");
      },
      beforeSend:function(){
      	$('div[name=Progress_Loading]').removeClass('display-none');
      },
      complete : function(){
      	alert("삭제완료");
      	window.location.href='/adm/comCodMgr/';
      },
      
	});

}

//빈값 검사 : 빈값o : true, 빈값x :false
function fn_blank_chk()
{
	var check = false;
	
	// 공통코드명이 비어있을 경우
	if ( $('#MainCommName').val().length == 0) {
		alert("공통코드명을 입력해주세요.")
		return true;
	}
		
	$('#CodData tr').each(function(index){
				
		var tr = $(this);
		var td = tr.children();
		
		if(check == true) return;
		
		/* 
		alert('정렬순서 : '+td.eq(0).find('input[type="text"]').val());
		alert('상세코드 : '+td.eq(1).find('input[type="text"]').val());
		alert('상세코드명 : '+td.eq(2).find('input[type="text"]').val());
		 */
		 
		//상세 : 정렬순서가 비어있을 경우
		if(td.eq(0).find('input[type="text"]').val().length == 0)
		{
			alert("정렬순서를 입력해주세요.");
			td.eq(0).find('input[type="text"]').focus();
			check = true;
		}
		
		//상세 : 상세코드
		else if(td.eq(1).find('input[name="COMD_CODE"]').val().length == 0)		
		{
			alert("상세코드를 입력해주세요.");
			td.eq(1).find('input[name="COMD_CODE"]').focus();
			check = true;
		}
		
		//상세 : 상세코드 이름
		else if(td.eq(2).find('input[type="text"]').val().length == 0)		
		{
			alert("상세코드명을 입력해주세요.");
			td.eq(2).find('input[type="text"]').focus();
			check = true;
		}		
	});
	
	return check;
}

//공통코드 상세추가
function fn_add(){
	
	var tbaddtxt = "";
	
	tbaddtxt = "<tr>"+
						"<td>"+
							"<input type ='text' class='form-control' maxlength='5' onKeyPress='return numkeyCheck(event)'>"+
						"</td>"+
						"<td>"+
							"<input type='text' value='' name='COMD_CODE' class='form-control' onchange='javascript:fn_comdcode_changed(this);' maxlength='15'>"+
						"</td>"+
						"<td>"+
							"<input type='text' value='' class='form-control' maxlength='50'>"+
						"</td>"+
						"<td>"+
							"<select name='USE_YN' id='USE_YN' class='form-control select2' style='width: 100%;'>" +
								"<option value='Y'>Y</option>" +
								"<option value='N'>N</option>" +
							"</select>" +
						"</td>"+
						"<td></td>" +
						"<td></td>" +
						"<td>"+
							"<button type='button' name ='DELROW' class='btn btn-danger btn-sm DELROW' style='width:100%;'>삭제</button>"+
							"<input type='hidden' id = 'CodStatus' name = 'CodStatus' value='Insert'/>"	+					
						"</td>"					
					"<tr>";
	
	$("#tbDetail").children("tbody").append(tbaddtxt);
	
	//삭제함수
	$("button[name=DELROW]").click(function(){
			
		if($(this).next().val() == "Read"){
			$(this).next().val('Delete');
			$(this).parent().parent().hide();
		}
		else if($(this).next().val() == "Insert"){
			$(this).parent().parent().remove();
		}
	});
}

//삭제
$("button[name=DELROW]").click(function(){ 
	
	if( $(this).next().val() == "Read" ) {
		$(this).next().val('Delete');	
		$(this).parent().parent().hide();
	}
	else if ( $(this).next().val() == "Insert" ) {
		$(this).parent().parent().remove();
	}
});

//상세코드 변경 : 중복검사
function fn_comdcode_changed(obj){
	// 공백제거
	fn_trimstring(obj);
	
	//중복 갯수 확인용 : 1일경우 중복x
	var cnt = 0;
	
	//입력된 값이 비어있을경우 종료
	if(obj.value.length = 0) return;
	
	//루프하며 중복 검사
	$('#CodData tr').each(function(index){		
		var tr = $(this);
		var td = tr.children();
		
		/* 
		console.log($(this));	// jQuery
		alert('중복검사====Index: '+index);
		alert('중복검사====상세코드: '+td.eq(1).find('input[name="COMD_CODE"]').val().toUpperCase());
		alert('중복검사====삭제여부: '+td.eq(6).find('input[name="CodStatus"]').val());
		 */
		
		 //중복된 코드가 아니고 ,삭제대기중이 아닐경우 : cnt++
		if(td.eq(1).find('input[name="COMD_CODE"]').val().toUpperCase() == obj.value.toString().toUpperCase() 
				&& td.eq(6).find('input[name="CodStatus"]').val() != "Delete")
			cnt++;
	});
	
	//중복확인
	if(cnt != 1){
		alert("중복된 코드!");
		obj.value = "";		
	}
}

//공통코드 값 변경 감지
function fn_commcode_changed(obj){
	$("input[id=commcode_chk]").val("N");

	fn_trimstring(obj);		//공백제거
}

//공통코드 중복검사
function fn_commcode_chk() {
	
	if(!$("input[id=commcode]").val() ) {
		$("input[id=commcode_chk]").val("N");
		alert("공통코드를 입력해 주세요.");	
		return;
	}
	
	$.ajax({ 
        url:'/adm/comCodMgr/chk', //가져오고자하는 서버페이지 주소를 넣는다. 
        type:'post', //데이터를 서버로 전송하게 된다. 
        data:{ 
     	   	  COMM_CODE : $("input[id=commcode]").val().toUpperCase()
        } , 
        success : function(flag){ 
        	
        	if(flag=="true"){
        		$("input[id=commcode_chk]").val("Y");
        		alert("사용가능한 코드 입니다.");
        	}
        	else{
        		$("input[id=commcode_chk]").val("N");
        		alert("중복된 코드 입니다.");
        	}
        } , 
        error : function(){
        	$("input[id=commcode_chk]").val("N");
        	alert("error");
        },          
        beforeSend:function(){
        	$('div[name=Progress_Loading]').removeClass('display-none');
        },
        complete:function(){
            $('div[name=Progress_Loading]').addClass('display-none');
        },        
 	});
	
}

//공백제거
function fn_trimstring(obj) {
	var id = obj.getAttribute('id');

	if(obj.value != "" || obj.value != null){
		$("#"+id).val(obj.value.replace(/(\s*)/g, ""));
	}	
}

//숫자만
function numkeyCheck(e) { 
	var keyValue = event.keyCode;
	
	if( ((keyValue >= 48) && (keyValue <= 57)) ) 
		return true; 
	else 
		return false; 
}
</script>