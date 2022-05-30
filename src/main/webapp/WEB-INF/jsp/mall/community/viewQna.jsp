<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<div class="col-5">
	<div class="my-banner pd_n">
        <img src="${contextPath }/html/img/sub/sub05/banner.png" class="img-responsive" style="margin-bottom: 30px;">
    </div>

    <div class="company mb_30">
		<div class="sub-title">
	    	<h2>상품문의 상세정보</h2>
		</div>
	
		<form>
			<input type="hidden" id="BRD_NUM" name="BRD_NUM" value="${detailQna.BRD_NUM }" />
			<input type="hidden" id="BRD_GUBN" name="BRD_GUBN" value="${detailQna.BRD_GUBN }" />
			<input type="hidden" id="WRTR_ID" name="WRTR_ID" value="${detailQna.WRTR_ID }" />
			<input type="hidden" id="WRT_DTM" name="WRT_DTM" value="${detailQna.WRT_DTM }" />
	
		    <table class="table table-intro">
			     <tbody>
					 <tr class="tb_topline">
				         <th>제목</th> 
				         <td colspan="3">
				         	<label for="BRD_SBJT" style="width:600px;">${detailQna.BRD_SBJT }</label>
				         </td>
				     </tr>
				     <tr>
				         <th style="height: 140px;">문의내용</th>
				         <td colspan="3">
				         	<label for="BRD_CONT">${detailQna.BRD_CONT }</label>
				         </td>
				     </tr>
				     <tr>
				         <th>답변내용</th>
				         <td colspan="3">
				         	<c:if test="${ !empty detailQna.QNA_REPLY }">
				         		<label for="BRD_CONT" style="height: 140px;">${detailQna.QNA_REPLY }</label>
				         	</c:if>
				         	<c:if test="${ empty detailQna.QNA_REPLY }">
				         		<label for="BRD_CONT" style="height: 20px;">답변대기</label>
				         	</c:if>
				         </td>
				     </tr>
				     <tr class="tb_line">
				         <th>비밀글여부</th>
				         <td colspan="3">
				         	<c:if test="${ !empty detailQna.BRD_PW }">
				         		<label>Y</label>
				         	</c:if>
				         	<c:if test="${ empty detailQna.BRD_PW }">
				         		<label>N</label>
				         	</c:if>
				         </td>
				     </tr>
			     </tbody>
		    </table>
		    
		    <div class="box-tools">
		    	<a href="${contextPath }/community/qnaList" class="btn btn-sm btn-default pull-right">목록</a>
		    	<c:if test="${detailQna.WRTR_ID eq USER.MEMB_ID}">
			    	<c:if test="${ empty detailQna.QNA_REPLY}">
			    		<a href="${contextPath }/community/qna/detail?BRD_NUM=${detailQna.BRD_NUM }" class="btn btn-sm btn-success pull-right" style="margin-right:5px;">수정</a>
			    	</c:if>
		    	</c:if>
			</div>
	    </form>
	</div>
</div>

<script type="text/javascript">

$(function() {
	
	$('#BRD_CONT').val("${detailQna.BRD_CONT}");
	
});

</script>
