<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
				
<spform:form id="searchForm" name="searchForm" method="POST" action="${contextPath}/resv/api/equip/reserve/listTest">
    <input type="hidden" name="menuId" value="${obj.menuId}" />
    <fieldset>
		<legend>검색조건</legend>
		<table class="tstyle_view" summary="사이트명, url 검색">
			<caption>
				검색 조건
			</caption>
			<colgroup>
				<col width="7%" />
				<col width="43%" />
				<col width="7%" />
				<col width="43%" />
			</colgroup>
			<tr>
				<th scope="row"><label>이용희망 기간</label></th>
				<td>
					<input type="text" name="schStartDate" id="schStartDate" value="${obj.schStartDate}" readonly="readonly"/>
					~<input type="text" name="schEndDate" id="schEndDate" value="${obj.schEndDate }" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><label>검색조건</label></th>
				<td >
					<select name="schType" id="schType" title="검색조건">
						<option value="0">전체</option>
						<option value="1" ${obj.schType == 1 ? 'selected="selected"' : ''}>신청자명</option>
						<option value="2" ${obj.schType == 2 ? 'selected="selected"' : ''}>ZEUS예약번호</option>
					</select>
					<input type="text" name="schText" id="schText" value="${obj.schText}" class="input_mid" title="검색어" style="ime-mode:active"/>
                       <span class="float_right">
                       	<input type="button" id="btnSearch" class="btn_black" value="검색">
                       </span>
				</td>
			</tr>
		</table>
	</fieldset>
</spform:form>
	
<spform:form id="listForm" name="listForm" method="GET" action="${contextPath}/resv/api/equip/reserve/view">	
<input type="hidden" name="menuId" value="${obj.menuId}" />
<input type="hidden" name="pageNum" value="${obj.pageNum}">
<input type="hidden" id="seqNo" name="seqNo" value="" />
<input type="hidden" name="schText" value="${param.schText}">

<input type="hidden" name="gubun" id="gubun" value="">

	<div class="articles_search">
		<c:set var="pages" value="${totalCnt/obj.rowCnt}" />
		<p class="articles">전체 <span class="txt_bold">${totalCnt }건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value="${pages+(1-(pages%1))%1}" type="number" /></p>
	</div>			
	<table class="tstyle_list">
		<caption>
			번호, 예약번호, 진행상태, 장비명/보유기관, 희망일/확정일 
		</caption>
		<colgroup>			
			<col style="width:5%" />
			<col style="width:10%" />
			<col style="width:20%" />
			<col style="width:25%" />
			<col style="width:20%" />
			<col style="width:20%" />
		</colgroup>
		<thead>
			<tr>				
				<th scope="col">번호</th>
				<th scope="col">예약번호</th>
				<th scope="col">진행상태</th>
				<th scope="col">장비명/보유기관</th>
				<th scope="col">희망일/확정일</th>
				<th scope="col">결제방법/완료여부</th>
			</tr>
		</thead>
		<tbody>
		<c:choose>			
			<c:when test="${!empty result && fn:length(result) > 0 }">
				<c:forEach items="${result }" var="data" varStatus="loop">
				<tr>
					<td>${totalCnt - data.RNUM+1}</td>
					<td class="ellipsis">
						<a href="javascript:fnGoView('${data.SEQNO }');">${data.SEQNO }</a>
					</td>
					<td>${data.RESVSTATENM }</td>
					<td>${data.EQUIPID }<br>${data.ORGMGNTNO }</td>
					<td>${data.RESVSTARTDT }, ${data.RESVSTARTHOUR }:${data.RESVSTARTMIN }
					   ~${data.RESVENDDT }, ${data.RESVENDHOUR }:${data.RESVENDMIN }<br>
					   ${data.USESTARTDT }, ${data.USESTARTHOUR }:${data.USESTARTMIN }
					   ~${data.USEENDDT }, ${data.USEENDHOUR }:${data.USEENDMIN }
					</td>
					<td>${data.CARRIERPAYTYPENM }<br>${data.PAYYN }</td>	
				</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>		
			<tr>
				<td colspan="5">조회된 데이터가 없습니다.</td>
			</tr>			
			</c:otherwise>			
		</c:choose>			
		</tbody>
	</table>
</spform:form>

<spform:form id="insertForm" name="insertForm" method="GET" action="${contextPath}/resv/api/equip/reserve/add/form">
    <input type="hidden" name="menuId" value="${obj.menuId}" />
</spform:form>

<div class="btn_area">  
    <span class="float_right">      
        <type="button" id="btnAdd" class="btn_type01">예약 신청</button>
    </span>
</div>

<div class="board_pager">
	<paging:PageFooter totalCount="${totalCnt }" rowCount="${obj.rowCnt }" siteGubun="U">
    	<Previous><AllPageLink><Next>
	</paging:PageFooter>
</div>
 
<!-- detail content -->
<script type="text/javascript">

jQuery(document).ready(function($) {
	
	if($("input:radio[name=schEduTerm]:checked").val() == "3"){
		$("#eduDay").show();
		
	}else{
		$("#eduDay").hide();
	}

	if($("input:radio[name=schApplyTerm]:checked").val() == "3"){
		$("#applyDay").show();
		
	}else{
		$("#applyDay").hide();
	}

	$("input:checkbox[name=edu02]").change(function(){
		if($(this).val() != '0'){
			$("#edu0201").attr("checked", false);
		}else if($(this).val() == '0'){
			$("#edu0202").attr("checked", false);
			$("#edu0203").attr("checked", false);
			$("#edu0204").attr("checked", false);
			$("#edu0205").attr("checked", false);
		}
	});

    $("#schText").keydown(function (key) {
        if (key.keyCode == 13) {
           	$nCnt = $("input:checkbox[name=edu02]:checked").length;
        	if( $nCnt > 0 ){
        		var areaShareArr = new Array();
        		$("input[name=edu02]:checked").each(function(i) {
        			areaShareArr.push($(this).attr("value"));			
        		});
        		$("#schEduArea").val(areaShareArr);
        	}
        	
        	if($("input:radio[name=schEduTerm]:checked").val() == "3"){
        		if($("#schEduStartDate").val() == ""){ 
        	     	alert("교육 시작 시간을 입력하세요."); 
        	        return false; 
        		}
        		if($("#schEduEndDate").val() == ""){ 
        	     	alert("교육 종료 시간을 입력하세요."); 
        	        return false; 
        		}    		
        	}

        	if($("input:radio[name=schApplyTerm]:checked").val() == "3"){
        		if($("#schApplyStartDate").val() == ""){ 
        	     	alert("신청 시작 시간을 입력하세요."); 
        	        return false; 
        		}
        		if($("#schApplyEndDate").val() == ""){ 
        	     	alert("신청 종료 시간을 입력하세요."); 
        	        return false; 
        		}          	
        	}
        	
        	
        	$("#schEduType").val($("input:radio[name=edu01]:checked").val());			    	
            $("#searchForm").submit();            
        }
    });

});

function fnGoView(seqNo){
	$("#seqNo").val(seqNo);
    $("#listForm").attr('action', '/resv/api/equip/reserve/view');
	$("#listForm").submit();
};

function fnGoApply(gisuNum){
	
	var s_userId = '${USER.userId }';
	if(s_userId.length > 0){
	    /* var url = "${contextPath}/kps/educationAsk/educationAskForm?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&gisuNum="+gisuNum+"${link}";
	    document.location.href= url; */
	    
	    $("#gisuNum").val(gisuNum);
	    $("#listForm").attr('action', '/kps/educationAsk/educationAskForm');
		$("#listForm").submit();
	}else{
		alert("로그인이 필요합니다");
		var url = "${contextPath}/kps/member/loginForm?menuId=${loginMenu }";
		document.location.href= url;
	}
};
    
$(function() {

	//달력 세팅
    $( "#schStartDate" ).datepicker({
        showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
		buttonImage: "${contextPath}/resources/images/ips/sub/icon_calendar.gif"
    });
	
    $( "#schEndDate" ).datepicker({
        showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
		buttonImage: "${contextPath}/resources/images/ips/sub/icon_calendar.gif"
    });
    
    $("#btnAdd").click(function(){
	    $("#insertForm").attr('action', '${contextPath}/resv/api/equip/reserve/add/form');
		$("#insertForm").submit();
    });

    $("#btnSearch").click(function(){
    	$nCnt = $("input:checkbox[name=edu02]:checked").length;
    	if( $nCnt > 0 ){
    		var areaShareArr = new Array();
    		$("input[name=edu02]:checked").each(function(i) {
    			areaShareArr.push($(this).attr("value"));			
    		});
    		$("#schEduArea").val(areaShareArr);
    	}
    	
    	if($("input:radio[name=schEduTerm]:checked").val() == "3"){
    		if($("#schEduStartDate").val() == ""){ 
    	     	alert("교육 시작 시간을 입력하세요."); 
    	        return false; 
    		}
    		if($("#schEduEndDate").val() == ""){ 
    	     	alert("교육 종료 시간을 입력하세요."); 
    	        return false; 
    		}    		
    	}

    	if($("input:radio[name=schApplyTerm]:checked").val() == "3"){
    		if($("#schApplyStartDate").val() == ""){ 
    	     	alert("신청 시작 시간을 입력하세요."); 
    	        return false; 
    		}
    		if($("#schApplyEndDate").val() == ""){ 
    	     	alert("신청 종료 시간을 입력하세요."); 
    	        return false; 
    		}          	
    	}
    	
    	
    	$("#schEduType").val($("input:radio[name=edu01]:checked").val());			    	
        $("#searchForm").submit();
    	
    });

});

function fnTabSearch(schEduType){
	$("#schEduType").val(schEduType);
	$("#searchForm").submit();
	
}

</script>
