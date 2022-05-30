<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<div class="col-5">
	<div class="my-banner pd_n">
        <img src="${contextPath }/html/img/sub/sub05/banner.png" class="img-responsive" style="margin-bottom: 30px;">
    </div>

    <div class="company mb_30">
		<div class="sub-title">
	    	<h2>반품문의 등록/수정</h2>
		</div>
	
		<spform:form name="orderReturnFrm" id="orderReturnFrm" method="POST" action="${contextPath }/community/orderReturn/detail" class="form-horizontal">
			<input type="hidden" id="PD_CODE" name="PD_CODE"  
				<c:if test='${detailOrderReturn.PD_CODE!=null && detailOrderReturn.PD_CODE!="" }'>value="${detailOrderReturn.PD_CODE }" </c:if>/>
				
			<input type="hidden" id="BRD_NUM" name="BRD_NUM" 
				<c:if test='${detailOrderReturn.BRD_NUM!=null && detailOrderReturn.BRD_NUM!="" }'>value="${detailOrderReturn.BRD_NUM }"</c:if> />
				
			<input type="hidden" id="BRD_GUBN" name="BRD_GUBN"  value="BRD_GUBN_03" />
				
			<input type="hidden" id="BRD_BFPW" name="BRD_BFPW" 
				<c:if test='${detailOrderReturn.BRD_PW!=null && detailOrderReturn.BRD_PW!="" }'>value="${detailOrderReturn.BRD_PW }"</c:if> />
				
	
		    <table class="table table-intro">
			     <tbody>
					 <tr class="tb_topline">
				         <th>제목</th> 
				         <td colspan="3">
							<input type="text" id="BRD_SBJT" name="BRD_SBJT" style="width:600px;"
								<c:if test='${detailOrderReturn.BRD_SBJT!=null && detailOrderReturn.BRD_SBJT!="" }'>value="${detailOrderReturn.BRD_SBJT }"</c:if> />
				         </td>
				     </tr>
				     <tr>
				         <th style="height: 140px;">문의내용</th>
				         <td colspan="3">
				             <!-- <textarea id="BRD_CONT" name="BRD_CONT" rows="10" cols="20" style="width:600px; height:135px" value=""></textarea> -->
				             <textarea id="BRD_CONT" name="BRD_CONT" rows="10" cols="20" style="width:600px; height:135px"><c:if test='${detailOrderReturn.BRD_CONT!=null && detailOrderReturn.BRD_CONT!="" }'>${detailOrderReturn.BRD_CONT }</c:if></textarea>
				         </td>
				     </tr>
				     <tr>
				         <th>비밀글</th>
				         <td colspan="3">
				             <input type="checkbox" id="SCWT_YN" name="SCWT_YN" 
				              <c:if test='${detailOrderReturn.SCWT_YN!=null && detailOrderReturn.SCWT_YN!="" && detailOrderReturn.SCWT_YN=="Y"}'> value="${detailOrderReturn.SCWT_YN }" checked</c:if> />
				         </td>
				     </tr>
				     <tr>
				         <th>잠금비밀번호</th>
				         <td colspan="3">
							<input type="password" name="BRD_PW" id="BRD_PW" maxlength="4" value="" size="8"/> &nbsp; (숫자4자리)
				         </td>
				     </tr>
			     </tbody>
		    </table>
		    
		    <div class="box-tools">
		    	<c:if test='${detailOrderReturn.BRD_NUM==null || detailOrderReturn.BRD_NUM=="" }'>
			    	<a href="${contextPath }/community/orderReturnList" class="btn btn-sm btn-default pull-right">취소</a>
			    	<a id = "saveBtn" class="btn btn-sm btn-success pull-right" style="margin-right:5px;">저장</a>
		    	</c:if>
		    	
		    	<c:if test='${detailOrderReturn.BRD_NUM!=null && detailOrderReturn.BRD_NUM!="" }'>
			    	<a href="${contextPath }/community/orderReturn/detail/view?BRD_NUM=${detailOrderReturn.BRD_NUM }" class="btn btn-sm btn-default pull-right">취소</a>
			    	<button type="submit" id= "submitBtn" class="btn btn-sm btn-success pull-right" style="margin-right:5px;">저장</button>
		    	</c:if>
			</div>
	    </spform:form>
	</div>
</div>

<script type="text/javascript">


$(document).ready(function(){
	
	/* <c:if test='${detailOrderReturn.BRD_SBJT==null || detailOrderReturn.BRD_SBJT=="" }'> */
		var brd_sbjt = $('#BRD_SBJT');
		brd_sbjt.val(" ");
	/* </c:if> */

 	/* 비밀글 선택시 비밀번호 Readonly여부 */
	 $("#SCWT_YN").change(function(){		 
		 		 		 
	     if($("#SCWT_YN").is(":checked")){
	         /* alert("체크박스 체크했음!"); */
	         $("#BRD_PW").attr("readonly", false);
           	 $('#SCWT_YN').val('Y');
	         /* alert(document.getElementById("SCWT_YN").value); */
	     }else{
	         /* alert("체크박스 체크 해제!"); */
	         $("#BRD_PW").attr("readonly", true);
	         $('#BRD_PW').val('');
	         $('#SCWT_YN').val('N');
	         /* alert(document.getElementById("SCWT_YN").value); */
	     }
	 });
 
	$('#saveBtn').on('click',function(){
		
		/* 비밀번호 필수값 체크 */
		if($("#SCWT_YN").is(":checked") && $('#BRD_PW').val()=="" || $('#BRD_PW').val()==null){
          	alert('비밀번호를 입력해주세요');
            e.preventDefault();                        
        }
				
		var brd_sbjt = $('#BRD_SBJT').val().trim();
		
		$('#BRD_SBJT').val(brd_sbjt);		
		
		$('#orderReturnFrm').attr("action", "${contextPath }/board/ask/popup");
		
		$('#orderReturnFrm').submit();
	})
	
	// 비밀번호 숫자만 입력
	$("#BRD_PW").keyup(function(){
		$(this).val( $(this).val().replace(/[^0-9]/g,"") );
	});
	
});

/* 비밀글 선택시 비밀번호 필수값 체크 */
$(function(){
    $('#submitBtn').click(function(e){
    	if($("#SCWT_YN").is(":checked")){
    		
    		if($('#BRD_PW').val()=="" || $('#BRD_PW').val()==null){
              	alert('비밀번호를 입력해주세요');
                e.preventDefault();     
                return;
            }
    		
    		if ($('#BRD_BFPW').val() != null && $('#BRD_BFPW').val() != ""){
        		if($('#BRD_BFPW').val() != $('#BRD_PW').val()){
        			alert('비밀번호가 일치하지 않습니다');
                    e.preventDefault();
                    return;
        		}
        	}	
    	}    	
    });    
});

</script>
