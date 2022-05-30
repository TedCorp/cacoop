<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<div class="col-5">
	<div class="my-banner pd_n">
        <img src="${contextPath }/html/img/sub/sub05/banner.png" class="img-responsive" style="margin-bottom: 30px;">
    </div>
    
    <div class="company mb_30">
		<div class="sub-title">
	    	<h2>구매후기 상세정보</h2>
		</div>
	
		<spform:form name="revFrm" id="revFrm" method="POST" action="${contextPath }/community/review/detail" class="form-horizontal">
			<input type="hidden" id="PD_CODE" name="PD_CODE" value="${detailRev.PD_CODE }" />
			<input type="hidden" id="BRD_NUM" name="BRD_NUM" value="${detailRev.BRD_NUM }" />
			<input type="hidden" id="BRD_GUBN" name="BRD_GUBN" value="${detailRev.BRD_GUBN }" />
	
		    <table class="table table-intro">
			     <tbody>
					 <tr class="tb_topline">
				         <th>평점</th> 
				         <td colspan="3">
							<input type="radio" name="PD_PTS" value="1" /> &nbsp;
							<img src="${contextPath}/resources/img/sub/sub01/star_ico_1.png" alt="별1개">&nbsp;&nbsp;
					     	<input type="radio" name="PD_PTS" value="2" /> &nbsp;
					     	<img src="${contextPath}/resources/img/sub/sub01/star_ico_2.png" alt="별2개">&nbsp;&nbsp;
					     	<input type="radio" name="PD_PTS" value="3" /> &nbsp;
					     	<img src="${contextPath}/resources/img/sub/sub01/star_ico_3.png" alt="별3개">&nbsp;&nbsp;
					     	<input type="radio" name="PD_PTS" value="4" /> &nbsp;
					     	<img src="${contextPath}/resources/img/sub/sub01/star_ico_4.png" alt="별4개">&nbsp;&nbsp;
					     	<input type="radio" name="PD_PTS" value="5" /> &nbsp;
					     	<img src="${contextPath}/resources/img/sub/sub01/star_ico_5.png" alt="별5개">&nbsp;&nbsp;
				         </td>
				     </tr>
				     <tr>
				         <th>제목</th> 
				         <td colspan="3">
							<input type="text" id="BRD_SBJT" name="BRD_SBJT" style="width:600px;" value="${detailRev.BRD_SBJT }" />
				         </td>
				     </tr>
				     <tr>
				         <th style="height: 140px;">내용</th>
				         <td colspan="3">
							<textarea id="BRD_CONT" name="BRD_CONT" rows="10" cols="20" style="width:600px; height:135px" value=""></textarea>
				         </td>
				     </tr>
			     </tbody>
		    </table>
		    
		    <div class="box-tools">
		    	<a href="${contextPath }/community/review/detail/view?BRD_NUM=${detailRev.BRD_NUM }" class="btn btn-sm btn-default pull-right">취소</a>
		    	<button type="submit" class="btn btn-sm btn-success pull-right" style="margin-right:5px;">저장</button>
			</div>
	    </spform:form>
	</div>
</div>

<script type="text/javascript">

$(function() {
	
	$('#BRD_CONT').val("${detailRev.BRD_CONT}");
	
});

</script>
