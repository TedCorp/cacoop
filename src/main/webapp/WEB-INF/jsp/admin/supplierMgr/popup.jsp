<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<style>
.deliveybtn{
    display: flex;
    flex-direction: column;
    justify-content: space-around;
}
.deliveyInfo{
    display: flex;
    justify-content: space-evenly;
    align-items: stretch;
} 
.div-info{
    width: 100%;
}
.with-border{
	display: flex;
    flex-direction: row;
}
.header-info{
    display: flex;
    width: 100%;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    background-color: #526681;
    color:white;
    }
.btn-insert{
	background-color: #526681;
    border-color: #526681;
	color: white;
}
.cancel-btn{
	height: 30px;
	background-color: #dbdbdb;
    border-color: #dbdbdb;
    color:#526681;
 }
 .com_info{
 	color: #526681;
    font-weight: bold;
 }
 
.content-header .box-body .paging_new{margin-top:30px}
.content-header .box-body .paging_new ul{display:flex;flex-direction:row;justify-content:center;align-items:center}
.content-header .box-body .paging_new li{width:30px;height:30px;}
.content-header .box-body .paging_new li a{display:block;width:30px;line-height:30px;font-size:14px;font-weight:500;color:#333;text-align:center;}
.content-header .box-body .paging_new li i{display:block;width:30px;height:30px}
.content-header .box-body .paging_new li.on a{background:#111;color:#fff;}
.content-header .box-body .paging_new li.start .ic{background:url("${contextPath}/resources/resources2/images/icon_page_start.png") no-repeat 50% 50%}
.content-header .box-body .paging_new li.end .ic{background:url("${contextPath}/resources/resources2/images/icon_page_end.png") no-repeat 50% 50%}
.content-header .box-body .paging_new li.prev .ic{background:url("${contextPath}/resources/resources2/images/icon_page_prev.png") no-repeat 50% 50%}
.content-header .box-body .paging_new li.next .ic{background:url("${contextPath}/resources/ resources2/images/icon_page_next.png") no-repeat 50% 50%} 
</style>

<section class="content-header">
	<div class="box box-info">
		<div class="box-header with-border header-info">
			<h2 style="width: 100%;">주소록</h2>
			<button type="button" class="btn btn-sm cancel-btn" style="height: 30px;" onclick="javascript:fn_close()"><b>X</b></button>
		</div>
	</div>
	<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
		<div class="box">
		<c:forEach items="${obj.list}" var="ent" varStatus="loop">
			<div class="box-body box-info deliveyInfo">
				<div class="form-group div-info">
					<span style="border: 2px solid #eb9191;">
					<jsp:include page="${contextPath}/common/comCodName">
						<jsp:param name="COMM_CODE" value="ADDR_GUBN" />
						<jsp:param name="COMD_CODE" value="${ent.ADDR_GUBN }" />
						<jsp:param name="type" value="text" />
					</jsp:include>
					</span>
					<br/>
					<b>${ent.SUPR_NAME }</b><br/>
				  	<span class="com_info">( 우 : ${ent.COM_PN } )</span>
				  	<span> ${ent.COM_BADR } </span> 
				  	<span>${ent.COM_DADR }</span><br/>
				  	<c:choose>
				  		<c:when test="${!empty ent.COM_FAX}">
				  			팩스 : ${ent.COM_FAX } /
				  		</c:when>
				  		<c:otherwise>
				  			팩스 : 	- / 
				  		</c:otherwise>
				  	</c:choose>
				  	<c:choose>
				  		<c:when test="${!empty  ent.COM_TELN}">
  				  			전화번호 : ${ent.COM_TELN } /
				  		</c:when>
				  		<c:otherwise>
				  			전화번호 : 	- /
				  		</c:otherwise>
				  	</c:choose>
				  	<c:choose>
				  		<c:when test="${!empty ent.COM_MOBILE}">
				  			핸드폰 : ${ent.COM_MOBILE } 
				  		</c:when>
				  		<c:otherwise>
				  			핸드폰 : -  
				  		</c:otherwise>
				  	</c:choose>
					<br/>
				</div>
				<div class="deliveybtn">
					<input type="hidden" name="ADD_NUM" id="ADD_NUM" value="${ent.ADD_NUM }"/>
					<input type="hidden" name="COM_PN" id="COM_PN" value="${ent.COM_PN }"/>
					<input type="hidden" name="COM_BADR" id="COM_BADR" value="${ent.COM_BADR }"/>
					<input type="hidden" name="COM_DADR" id="COM_DADR" value="${ent.COM_DADR }"/>
					<input type="button" class="btn btn-primary btn-sm left-5" id="deliveryinfo" name="deliveryinfo" style="background-color:#3c763d; border-color:#3c763d;" value="선택">
					<a href="${contextPath}/adm/deliveryAddrMgr/${ent.ADD_NUM}" class="btn btn-primary btn-sm left-5" id="c" style="background-color:#fdaf44; border-color:#fdaf44;">수정</a>
					<form name="deleteFrm" id="deleteFrm" method="post">
						<input type="hidden" name="ADD_NUM" id="ADD_NUM" value="${ent.ADD_NUM }"/>
						<a href="#" onclick="javascript:fn_delete('${ent.ADD_NUM }');" class="btn btn-primary btn-sm  left-5" >삭제</a>
					</form>
				</div>
			</div>
			<hr/>
		</c:forEach>	
		</div>
		<c:if test="${obj.count eq 0}">
			<div class="form-group">
				조회된 내용이 없습니다.
			</div>
		</c:if>
		
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<First><Previous><AllPageLink><Next><Last>
		</paging:PageFooter>
		<div class="col-xs-12">
			<a href="${contextPath}/adm/deliveryAddrMgr/insert"  class="btn btn-insert btnState" style="display: block; width: 100%;">신규등록</a>
		</div>
	</div>
</section>


<script>
//부모창으로 값전달
$(document).ready(function (){
	$("input[name='deliveryinfo']").click(function(){
	 var addNum=$(this).prev().prev().prev().prev().val();
	 var comPn=$(this).prev().prev().prev().val();
	 var comBadr=$(this).prev().prev().val();
	 var comDadr=$(this).prev().val();
	 console.log(addNum, comPn, comBadr, comDadr);
	 opener.fn_selectValue(addNum, comPn, comBadr, comDadr);	
	 self.close();
	});
	
});


//팝업닫기 
function fn_close(){
	window.close();
}

//상품선택 팝업 호출
function fn_popup_insert(){
	window.open("${contextPath}/adm/deliveryAddrMgr/insert", "_blank", "width=460,height=580"); 
}

function fn_delete(add_num){
	console.log(add_num);
	
  	if(!confirm("삭제 하시겠습니까?")) return;
  	
  	$.ajax({
  		url: "${contextPath}/adm/deliveryAddrMgr/delete",
  		method: "POST",
  		data: {ADD_NUM : add_num},
 		success: function (message) {
  			if(message=="success"){
  				alert("주소가 삭제 되었습니다.");
  				location.reload();
  			}else{
  				alert("사용중인 주소입니다. 삭제할 수 없습니다.");
  				location.reload();
  			}
  		}, 
  		error: function (jqXHR, textStatus, errorThrown) {
  			alert("에러가 발생하였습니다. 관리자에게 문의하세요");
  		}
  	});
  }
</script>