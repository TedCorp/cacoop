<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>


<!-- Main Container  -->
<div class="container">
    <div class="page-notice">
		<div class="info" style="margin-bottom: 30px;">
			<div class="ico"><img src="${contextPath }/resources/resources2/images/icon_customer.png" alt=""></div>
			<div class="con">
				<strong>고객센터를 통해 궁금증을 해결하세요</strong>
				<span>고객님의 문의에 대해서 항상 최선을 다해 답변해 드리겠습니다. </span>
			</div>
		</div>
        <div class="titbox">
            <div class="tit">공지사항</div>
        </div>
        <div class="cntbox">                          
            <div class="list">          
                <ul>
                  <c:forEach  var="ent" items="${ tb_pdbordxm.list }">
                    <li>
                        <div class="notice-title">
                            <div class="num">${ent.RNUM }</div>
                            <div class="tit">${ ent.BRD_SBJT } </div>
                            <div class="date">${ent.WRT_DTM }</div>
                            <div class="act"><i class="ic"></i></div>
                        </div>
                        <div class="notice-content">${ent.BRD_CONT }</div>
                    </li>  
                    </c:forEach>
					<c:if test="${fn:length( tb_pdbordxm.list) eq 0 }">
						등록된 게시물이 없습니다.
					</c:if> 
                </ul>      
            </div>            				
						
            <!-- 페이징  -->
           <paging:PageFooter totalCount="${ tb_pdbordxm.count }" rowCount="${ tb_pdbordxm.rowCnt }">
				<First><Previous><AllPageLink><Next><Last>
			</paging:PageFooter>        
            <!-- 페이징 END -->           
            
        </div>
    </div>
	<!-- Filters -->
	
    <!-- //end Filters -->  
</div>

<script>
 /* 게시글 숨기기, 펼치기 */                
$(document).ready(function () {
      $(".notice-title").click(function () {
          if ($(this).hasClass("on")) {
              $(".notice-title").removeClass("on");
              $(".notice-content").removeClass("on")
          } else {
              $(".notice-title").removeClass("on");
              $(".notice-content").removeClass("on")
              $(this).addClass("on");
              $(this).siblings(".notice-content").addClass('on');
          }
      });

      
}) 
                
</script>


<%-- 
<div class="main-container container">

	<ul class="breadcrumb">
		<li><a href="${contextPath }/m"><i class="fa fa-home"></i></a></li>
		<li><a href="${contextPath }/m/community">고객센터</a></li>
	</ul>
	
	<div class="row">		
		<div id="content" class="col-sm-12">
			<h2 class="title">
				<b>공지사항</b>
				<small class="ml_5"> | 공지사항, 안내사항 등을 전해드립니다.</small>
				<a href="${contextPath }/m/community/noticeList" class="btn btn-xs btn-default pull-right">+ 공지사항 더보기</a>
			</h2>
			<div class="table-responsive form-group">
				<table class="table table-bordered">
					<thead>
						<tr>
							<td class="text-center" style="width:60px">번호</td>
							<td class="text-left">제목</td>							
							<td class="text-center" style="width:150px;">등록일</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="ent" items="${ notice }" varStatus="status" end="5">
						<tr>
							<td class="text-center">
								${ent.RNUM }
							</td>
							<td class="text-left">
								<a href="${contextPath }/m/community//noticeView/${ent.BRD_GUBN }/${ent.BRD_NUM }">${ ent.BRD_SBJT }</a>
							</td>
							<td class="text-center">${ent.WRT_DTM }</td>							
						</tr>
						</c:forEach>
						<c:if test="${fn:length(notice) eq 0 }">
							<tr>
								<td colspan="3">등록된 공지사항이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
		<!-- /.Middle Part -->
		
		<div id="content" class="col-sm-12">
			<h2 class="title">
				<b>상품문의</b>
				<small class="ml_5"> | 신규상품 관련 요청사항 및 궁금한 점을 등록해주시면 답변드립니다.</small>
				<a href="${contextPath }/m/community/list" class="btn btn-xs btn-default pull-right">+ 상품문의 더보기</a>
			</h2>
			<div class="table-responsive form-group">
				<table class="table table-bordered">
					<thead>
						<tr>
							<td class="text-center" style="width:60px">번호</td>
							<td class="text-left">제목</td>							
							<td class="text-center" style="width:150px;">등록일</td>
							<td class="text-center" style="width:100px;">답변여부</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="ent" items="${ qna }" varStatus="status" end="5">
						<tr>
							<td class="text-center">
								${ent.RNUM }
							</td>
							<td class="text-left">
								<a href="${contextPath }/m/community/view/${ent.BRD_GUBN }/${ent.BRD_NUM }">
								<b>[${ent.BRD_GUBN_NM}]</b>${ ent.BRD_SBJT }</a>
							</td>
							<td class="text-center">${ent.WRT_DTM }</td>
							<td class="text-center">
								<c:if test="${tb_pdbordxm.REPLY_YN eq 'Y' }">
									<small class="label label-primary">Y</small>
								</c:if>
								<c:if test="${tb_pdbordxm.REPLY_YN ne 'Y' }">
									<small class="label label-warning">N</small>
								</c:if>
							</td>
						</tr>
						</c:forEach>
						<c:if test="${fn:length(qna) eq 0 }">
							<tr>
								<td colspan="4">등록된 상품문의가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>			
		</div>
		<!-- /.Middle Part -->
		
		<div id="content" class="col-sm-12">
			<h2 class="title">
				<b>반품문의</b>
				<small class="ml_5"> | 구매하신 상품의 반품관련 사항을 등록해주시면 답변드립니다.</small>
				<a href="${contextPath }/m/community/list" class="btn btn-xs btn-default pull-right">+ 반품문의 더보기</a>				
			</h2>
			
			<div class="table-responsive form-group">
				<table class="table table-bordered">
					<thead>
						<tr>
							<td class="text-center" style="width:60px">번호</td>
							<td class="text-left">제목</td>							
							<td class="text-center" style="width:150px;">등록일</td>
							<td class="text-center" style="width:100px;">답변여부</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="ent" items="${ review }" varStatus="status" end="5">
						<tr>
							<td class="text-center">
								${ent.RNUM }
							</td>
							<td class="text-left">
								<a href="${contextPath }/m/community/view/${ent.BRD_GUBN }/${ent.BRD_NUM }">
								<b>[${ent.BRD_GUBN_NM}]</b>${ ent.BRD_SBJT }</a>
							</td>
							<td class="text-center">${ent.WRT_DTM }</td>
							<td class="text-center">
								<c:if test="${tb_pdbordxm.REPLY_YN eq 'Y' }">
									<small class="label label-primary">Y</small>
								</c:if>
								<c:if test="${tb_pdbordxm.REPLY_YN ne 'Y' }">
									<small class="label label-warning">N</small>
								</c:if>
							</td>
						</tr>
						</c:forEach>
						<c:if test="${fn:length(review) eq 0 }">
							<tr>
								<td colspan="4">등록된 반품문의가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>			
		</div>
		<!-- /.Middle Part -->
	</div>
</div>
<!-- /.Main Container --> --%>