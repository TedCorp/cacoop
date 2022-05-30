<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>

<div class="company mb_30">
	<div class="sub-title">
    	<h2>문의하기</h2>
	</div>
	
	<form name="askPopFrm" id="askPopFrm" method="POST" action="${contextPath }/board/ask/popup" class="form-horizontal">
		<input type="hidden" id="PD_CODE" name="PD_CODE" value="${param.PD_CODE }" />
		<input type="hidden" id="BRD_NUM" name="BRD_NUM" value="${param.BRD_NUM }" />
		<input type="hidden" id="BRD_GUBN" name="BRD_GUBN" value="${param.BRD_GUBN }" />
		<input type="hidden" id="WRTR_ID" name="WRTR_ID" value="${param.WRTR_ID }" />
		<input type="hidden" id="WRT_DTM" name="WRT_DTM" value="${param.WRT_DTM }" />
		
	    <table class="table table-intro">
	       <tbody>
		     <tr>
		         <th style="width:150px">제목</th>
		         <td colspan="3">
		             <input type="text" name="BRD_SBJT" value="" id="BRD_SBJT" required style="width:540px;" minlength="3" maxlength="20">
		             <span id="BRD_SBJT"></span>
		         </td>
		     </tr>
		     <tr>
		         <th>내용</th>
		         <td colspan="3">
		             <textarea id="BRD_CONT" name="BRD_CONT" rows="10" cols="20" style="width:540px; height:200px;"></textarea>
		         </td>
		     </tr>
		     <tr>
		         <th>잠금비밀번호</th>
		         <td colspan="3">
					<input type="password" name="BRD_PW" id="BRD_PW" maxlength="4" /> (숫자4자리)
		         </td>
		     </tr>
	       </tbody>
	    </table>
    
	    <div class="box-tools" style="text-align:center;">
			<button type="submit" id="btnSave" class="btn btn-sm btn-success" style="margin-left:100px; margin-right: 5px;">저장</button>
	    	<button type="button" id="btnClose" class="btn btn-sm btn-default">닫기</button>
		</div>
    </form>
</div>

<script type="text/javascript">

<c:if test="${flag eq 'true'}">
	opener.window.location.reload();
	window.close(); 
</c:if>

$(function() {
	$('#btnSave').click(function(){
		if(!confirm("등록하시겠습니까?")) return;
		var frm=document.getElementById("askPopFrm");
		frm.submit();
	});
	
	$('#btnClose').click(function(){
		window.close(); 
	});
	
	
}); 

</script>