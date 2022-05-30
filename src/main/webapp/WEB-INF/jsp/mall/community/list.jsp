<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  

<div class="col-5">
    <div class="my-banner pd_n">
        <img src="${contextPath }/html/img/sub/sub05/banner.png" class="img-responsive" style="margin-bottom: 30px;">
    </div>

    <!--게시판들-->
    <div class="gesi-box" >
    	
        <div class="col-sm-6 pd_n left" >
            <div class="panel panel-default panel-gesi">
                <div class="panel-body pos_r">
                    <h5 class="gesi-title eng mg_n fl_l"><span class="green">공지사항</span></h5>
                    <%-- <a href="${contextPath }/community/noticeList" class="pos_a" style="right:20px; top:8px">
                    <img src="${contextPath }/html/img/sub/sub05/more.png"></a> --%>
                    <a href="${contextPath }/community/noticeList" class="pos_a" style="right:20px; top:10px;font-size:5px;">
                    	더보기+</a>
                </div>
            </div>
            <div class="mb_20" style="height: 120px;">
              <ul class="gesi-list">
              	<c:forEach var="ent" items="${ notice }" varStatus="status">
					<li><a href="${contextPath }/community/notice/detail?BRD_NUM=${ent.BRD_NUM }">${ ent.BRD_SBJT }</a>
					<span>[${ent.WRT_DTM }]</span></li>
				</c:forEach>
              </ul>
            </div>
        </div>
        <div class="col-sm-6 pd_n right">
            <div class="panel panel-default panel-gesi">
                <div class="panel-body pos_r">
                    <h5 class="gesi-title eng mg_n fl_l"><span class="green">FAQ</span></h5>
                    <%-- <a href="${contextPath }/community/faqList" class="pos_a" style="right:20px; top:8px">
                    <img src="${contextPath }/html/img/sub/sub05/more.png"></a> --%>
                    <a href="${contextPath }/community/faqList" class="pos_a" style="right:20px; top:10px;font-size:5px;">
                    	더보기+</a>
                </div>
            </div>
            <div class="mb_20">
                <ul class="gesi-list">
                <c:forEach var="ent" items="${ faq }" varStatus="status">
                    <li><a href="${contextPath }/community/faq/detail?BRD_NUM=${ent.BRD_NUM }">${ ent.BRD_SBJT }</a>
					<span>[${ent.WRT_DTM }]</span></li>
           		</c:forEach>
                </ul>
            </div>
        </div>
        <div class="clearfix"></div>
        
    </div>
    <div class="gesi-box">
        <div class="col-sm-6 pd_n left">
            <div class="panel panel-default panel-gesi">
                <div class="panel-body pos_r">
                    <h5 class="gesi-title eng mg_n fl_l"><span class="green">상품문의하기</span></h5>
                    <%-- <a href="${contextPath }/community/qnaList" class="pos_a" style="right:20px; top:8px">
                    <img src="${contextPath }/html/img/sub/sub05/more.png"></a> --%>
                    <a href="${contextPath }/community/qnaList" class="pos_a" style="right:20px; top:10px;font-size:5px;">
                    	더보기+</a>
                </div>
            </div>
            <div class="mb_20">
                <ul class="gesi-list">
                	 <c:forEach var="ent" items="${ qna }" varStatus="status">
                	 	<c:choose>
                	 		<c:when test="${empty ent.BRD_PW }">
           	    				<li><a href="${contextPath}/community/qna/detail/view?BRD_NUM=${ent.BRD_NUM }">${ent.BRD_SBJT }</a>
       							<span>[${ent.WRT_DTM }]</span></li>
       						</c:when>
       						<c:when test="${!empty ent.BRD_PW && USER.MEMB_ID eq ent.WRTR_ID}">
   								<li><img src="${contextPath }/html/img/sub/sub05/locked.png">&nbsp;<a href="${contextPath}/community/qna/detail/view?BRD_NUM=${ent.BRD_NUM }">${ent.BRD_SBJT }</a>
   								<span>[${ent.WRT_DTM }]</span></li>
   							</c:when>
   							<c:when test="${!empty ent.BRD_PW && USER.MEMB_ID ne ent.WRTR_ID}">
   								<li><img src="${contextPath }/html/img/sub/sub05/locked.png">&nbsp;<a>${ent.BRD_SBJT }</a>
   								<span>[${ent.WRT_DTM }]</span></li>
   							</c:when>
       					</c:choose>
	           		</c:forEach>
                </ul>
            </div>
            
        </div>
        <div class="col-sm-6 pd_n right">
            <div class="panel panel-default panel-gesi">
                <div class="panel-body pos_r">
                    <h5 class="gesi-title eng mg_n fl_l"><span class="green">반품문의하기</span></h5>
                    <%--<a href="${contextPath }/community/orderReturnList" class="pos_a" style="right:20px; top:8px;">
                    <img src="${contextPath }/html/img/sub/sub05/more.png"></a> --%>
                    <a href="${contextPath }/community/orderReturnList" class="pos_a" style="right:20px; top:10px;font-size:5px;">
                    	더보기+</a>
                </div>
            </div>
            <div class="mb_20">
                <ul class="gesi-list">
                    <c:forEach var="ent" items="${ review }" varStatus="status">
	                    <li><a href="${contextPath }/community/orderReturn/detail/view?BRD_NUM=${ent.BRD_NUM }">${ent.BRD_SBJT }</a>
	           			<span>[${ent.WRT_DTM }]</span></li>
	           		</c:forEach>
                </ul>
            </div>
            
        </div>
        
        
        <%-- <div class="col-sm-6 pd_n right">
            <div class="panel panel-default panel-gesi">
                <div class="panel-body pos_r">
                    <h5 class="gesi-title eng mg_n fl_l"><span class="green">구매후기</span></h5>
                    <a href="${contextPath }/community/reviewList" class="pos_a" style="right:20px; top:8px">
                    <img src="${contextPath }/html/img/sub/sub05/more.png"></a>
                </div>
            </div>
            <div class="mb_20">
                <ul class="gesi-list">
                    <c:forEach var="ent" items="${ review }" varStatus="status">
	                    <li><a href="${contextPath }/community/review/detail/view?BRD_NUM=${ent.BRD_NUM }">${ent.BRD_SBJT }</a>
	           			<span>[${ent.WRT_DTM }]</span></li>
	           		</c:forEach>
                </ul>
            </div>
        </div> --%>
        <div class="clearfix"></div>
    </div>
    
    <div class="gesi-box">
	    <div class="col-sm-6 pd_n left">
		    <div style="margin-bottom: 10px;font-size: 14px;color: #87b212;font-weight: bold;">
		           신규상품관련 요청사항등록하시면 답변드립니다.
	           </div>
	    </div>
	    <div class="col-sm-6 pd_n left">
	    <div style="margin-bottom: 10px;font-size: 14px;padding-left: 20px;color: #87b212;font-weight: bold;">
	            	구매하신상품에 대하여 반품관련 등록하시면 답변드립니다.
	            </div>
	    </div>
    </div>
</div> 


<script type="text/javascript">

$(function() {
	
}); 

</script>



