<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<div class="col-5">
	<div class="my-banner pd_n">
        <img src="${contextPath }/html/img/sub/sub05/banner.png" class="img-responsive" style="margin-bottom: 30px;">
    </div>

    <div class="company mb_30">
		<div class="sub-title">
	    	<h2>상품문의 등록/수정</h2>
		</div>
	
		<spform:form name="qnaFrm" id="qnaFrm" method="POST" action="${contextPath }/community/qna/detail" class="form-horizontal">
			<input type="hidden" id="PD_CODE" name="PD_CODE"  
				<c:if test='${detailQna.PD_CODE!=null && detailQna.PD_CODE!="" }'>value="${detailQna.PD_CODE }" </c:if>/>
				
			<input type="hidden" id="BRD_NUM" name="BRD_NUM" 
				<c:if test='${detailQna.BRD_NUM!=null && detailQna.BRD_NUM!="" }'>value="${detailQna.BRD_NUM }"</c:if> />
				
			<input type="hidden" id="BRD_GUBN" name="BRD_GUBN"  value="BRD_GUBN_02" />
			<input type="hidden" id="BRD_BFPW" name="BRD_BFPW" 
				<c:if test='${detailQna.BRD_PW!=null && detailQna.BRD_PW!="" }'>value="${detailQna.BRD_PW }"</c:if> />
				
	
		    <table class="table table-intro">
			     <tbody>
					 <tr class="tb_topline">
				         <th>제목</th> 
				         <td colspan="3">
							<input type="text" id="BRD_SBJT" name="BRD_SBJT" style="width:600px;"
								<c:if test='${detailQna.BRD_SBJT!=null && detailQna.BRD_SBJT!="" }'>value="${detailQna.BRD_SBJT }"</c:if> />
				         </td>
				     </tr>
				     <tr>
				         <th style="height: 140px;">문의내용</th>
				         <td colspan="3">
				             <!-- <textarea id="BRD_CONT" name="BRD_CONT" rows="10" cols="20" style="width:600px; height:135px" value=""></textarea> -->
				             <textarea id="BRD_CONT" name="BRD_CONT" rows="10" cols="20" style="width:600px; height:135px;"><c:if test='${detailQna.BRD_CONT!=null && detailQna.BRD_CONT!="" }'>${detailQna.BRD_CONT }</c:if></textarea> 
				         </td>
				     </tr>
				     <tr>
				         <th>비밀글</th>
				         <td colspan="3">
				             <input type="checkbox" id="SCWT_YN" name="SCWT_YN" 
				              <c:if test='${detailQna.SCWT_YN!=null && detailQna.SCWT_YN!="" && detailQna.SCWT_YN=="Y"}'> value="${detailQna.SCWT_YN }" checked</c:if>
				              />
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
		    	<c:if test='${detailQna.BRD_NUM==null || detailQna.BRD_NUM=="" }'>
			    	<a href="${contextPath }/community/qnaList" class="btn btn-sm btn-default pull-right">취소</a>
			    	<a id = "saveBtn" class="btn btn-sm btn-success pull-right" style="margin-right:5px;">저장</a>
		    	</c:if>
		    	
		    	<c:if test='${detailQna.BRD_NUM!=null && detailQna.BRD_NUM!="" }'>
			    	<a href="${contextPath }/community/qna/detail/view?BRD_NUM=${detailQna.BRD_NUM }" class="btn btn-sm btn-default pull-right">취소</a>
			    	<button type="submit" id="submitBtn" class="btn btn-sm btn-success pull-right" style="margin-right:5px;">저장</button>
		    	</c:if>
			</div>
	    </spform:form>
	</div>
</div>

<script type="text/javascript">


$(document).ready(function(){	
	
	/* <c:if test='${detailQna.BRD_SBJT==null || detailQna.BRD_SBJT=="" }'> */
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
		/* 비밀글 선택시 비밀번호 필수값 체크 */
		if($("#SCWT_YN").is(":checked") && $('#BRD_PW').val()=="" || $('#BRD_PW').val()==null){
          	alert('비밀번호를 입력해주세요');
            e.preventDefault();                        
        }
		
		var brd_sbjt = $('#BRD_SBJT').val().trim();
		
		$('#BRD_SBJT').val(brd_sbjt);		
		
		$('#qnaFrm').attr("action", "${contextPath }/board/ask/popup");
		
		$('#qnaFrm').submit();
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
