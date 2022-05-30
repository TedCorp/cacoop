<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  
 
<div class="col-5">
	<div class="my-banner pd_n">
        <img src="${contextPath }/html/img/sub/sub05/banner.png" class="img-responsive" style="margin-bottom: 30px;">
    </div>
 
    <div class="company mb_30">
		<div class="sub-title">
	    	<h2>FAQ</h2>
		</div>
	
		<form>
			<input type="hidden" id="BRD_NUM" name="BRD_NUM" value="${detailFAQ.BRD_NUM }" />
			<input type="hidden" id="BRD_GUBN" name="BRD_GUBN" value="${detailFAQ.BRD_GUBN }" />
	
		    <table class="table table-intro">
			     <tbody>
					 <tr class="tb_topline">
			         <th>제목</th> 
			         	<td><label for="BRD_SBJT" style="width:260px;">${detailFAQ.BRD_SBJT }</label></td>
			         <th>작성자</th>
				        <td><label for="WRTR_NM" style="width:50px;">${detailFAQ.WRTR_NM }</label></td>
				     </tr>
				     <tr>
				         <th style="height: 350px;">내용</th>
				         <td colspan="3">
				         	<label for="BRD_CONT"><%-- <textarea style="width:615px;height:360px;border:0;"readonly="readonly">${detailFAQ.BRD_CONT }</textarea> --%>
				         	${detailFAQ.BRD_CONT }
				         	</label>
				         	
				         </td>
				     </tr>
				     <tr class="tb_line">
				         <th>작성일자</th>
				         <td colspan="3">
				         	<label for="WRT_DTM">${detailFAQ.WRT_DTM }</label>
				         </td>
				     </tr>
			     </tbody>
		    </table>
		    
		    <div class="box-tools">
		    	<a href="#" id="btnBack" class="btn btn-sm btn-default pull-right">이전</a>
			</div>
	    </form>
	</div>
</div>
 
<script type="text/javascript">
 
$(function() {
	
	$("#btnBack").click(function() {
		window.history.go(-1);
	});
	
});
 
</script>
