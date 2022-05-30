<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<div class="col-5">
	<div class="my-banner pd_n">
	    <img src="${contextPath }/html/img/sub/sub05/banner.png" class="img-responsive" style="margin-bottom: 30px;">
	</div>
	
	<div class="sub-title">
		<h2>
			상품문의 목록 <small class="ml_5"></small>
		</h2>
		<ul>
			<li><a href='${contextPath }' class="sct_bg">Home</a></li>
			<li><a href='${contextPath }/community' class="sct_bg">Community</a></li>
			<li><a href="${contextPath }/community/qnaList" class=" ">상품문의</a></li>
		</ul>
		<div class="clearfix"></div>
	</div> 
	
	<form>
		<table class="table table-order">
			<thead>
				<tr>
					<th>제목</th>
					<th width="20%">작성자</th>
					<th width="15%">작성일자</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(obj.list) == 0 }">
				<tr>
					<td colspan="3">상품문의가 없습니다.</td>
				</tr>
			</c:if>
				<c:forEach items="${obj.list }" var="list" varStatus="loop">
					<tr>
						<c:choose>
	            	 		<c:when test="${empty list.BRD_PW }">
	       	    				<td style="text-align: left;"><a href="${contextPath}/community/qna/detail/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&BRD_NUM=${list.BRD_NUM }">${list.BRD_SBJT }</a>
	   						</c:when>
	   						<c:when test="${!empty list.BRD_PW && USER.MEMB_ID eq list.WRTR_ID}">
								<td style="text-align: left;"><img src="${contextPath }/html/img/sub/sub05/locked.png">&nbsp;
								<a href="${contextPath}/community/qna/detail/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&BRD_NUM=${list.BRD_NUM }">${list.BRD_SBJT }</a>
							</c:when>
							
							<c:when test="${!empty list.BRD_PW && USER.MEMB_ID ne list.WRTR_ID}">
								<td style="text-align: left;"><img src="${contextPath }/html/img/sub/sub05/locked.png">&nbsp;<a>${list.BRD_SBJT }</a>
							</c:when>
						</c:choose>
								<td>${list.WRTR_NM }</td>
								<td>${list.WRT_DTM }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
	<div style="text-align: right; "><a class="btn btn-success"  role="button" id="btnIns" onclick="javascript:insBtnQna();">등록하기</a></div>
</div>

<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
	<First><Previous><AllPageLink><Next><Last>
</paging:PageFooter>




<script type="text/javascript">

function insBtnQna(){
	
	location.href ='${contextPath }/community/qna/detail?BRD_NUM=';   
}


</script>

