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
	
		<form>
			<input type="hidden" id="BRD_NUM" name="BRD_NUM" value="${detailRev.BRD_NUM }" />
			<input type="hidden" id="BRD_GUBN" name="BRD_GUBN" value="${detailRev.BRD_GUBN }" />
	
		    <table class="table table-intro">
			     <tbody>
			     	<tr class="tb_topline">
			         <th>상품명</th>
			         	<td><label for="PD_CODE" style="width:230px;">${detailRev.PD_NAME }</label></td>
			         <th>평점</th>
				        <td><label for="PD_PTS" style="width:60px;"><img src="${contextPath}/resources/img/sub/sub01/star_ico_${detailRev.PD_PTS}.png" alt="별${detailRev.PD_PTS}개"></label></td>
				     </tr>
					 <tr>
				         <th>제목</th> 
				         <td colspan="3">
				         	<label for="BRD_SBJT" style="width:600px;">${detailRev.BRD_SBJT }</label>
				         </td>
				     </tr>
				     <tr class="tb_line">
				         <th style="height: 140px;">상품평</th>
				         <td colspan="3">
				         	<label for="BRD_CONT">${detailRev.BRD_CONT }</label>
				         </td>
				     </tr>
			     </tbody>
		    </table>
		    <div class="box-tools">
		    	<a href="${contextPath }/community/reviewList" class="btn btn-sm btn-default pull-right">목록</a>
		    	<c:if test="${!empty USER.MEMB_ID}">
					<c:if test="${USER.MEMB_ID eq detailRev.WRTR_ID }">
		    			<a href="${contextPath }/community/review/detail?BRD_NUM=${detailRev.BRD_NUM }" class="btn btn-sm btn-success pull-right" style="margin-right:5px;">수정</a>
			    	</c:if>
		    	</c:if>
			</div> 
		    	
	    </form>
	</div>
</div>

<script type="text/javascript">

$(function() {
	
	$('#BRD_CONT').val("${detailRev.BRD_CONT}");
	
});

</script>
