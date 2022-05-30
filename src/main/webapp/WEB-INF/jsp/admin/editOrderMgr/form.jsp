<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<script type="text/javascript">

$(function(){
	/* 숫자만 입력 */
    $(document).on("keyup", ".number", function() {
    	$(this).number(true);
    });
	
    /* 저장 */
    $("#btnSave").click(function(){
    	if(!confirm("저장 하시겠습니까?")) return;
    	var frm=document.getElementById("editFrm");
    	
    	// validation 체크 
    	if($("input:checkbox[name=RTN_CHK]:checked").length < 1){
    		alert("반품할 주문을 선택하세요.");
    		return false;
    	}
    	
    	$("input:checkbox[name=RTN_CHK]:checked").each(function (i) {
    		if($("#ORDER_QTY_"+$(this).val()).val()==null || $("#ORDER_QTY_"+$(this).val()).val()=='' || $("#RETURN_QTY_"+$(this).val()).val() < 1){
    			alert("반품수량은 필수값입니다."); 
    			return false;
    		}
    	});
    	//..validation 체크
    	
	    	
		var chechkList = new Array();				// 체크항목
		var orderdtnumList = new Array();		// 주문상세번호
		var qtyList = new Array();					// 반품수량
		var gbnList = new Array();					// 증감구분
		
		var codeList = new Array();					// 제품코드
		var nameList = new Array();				// 제품명
		var priceList = new Array();					// 제품단가
		
	    chechkList.push($(this).val());
		qtyList.push($("#ORDER_QTY_"+$(this).val()).val().replace(/[^\d]+/g, ''));
		gbnList.push($("#EDIT_GBN_"+$(this).val()).val());
		orderdtnumList.push($("#ORDER_DTNUM_"+$(this).val()).val());
		codeList.push($("#PD_CODE_"+$(this).val()).val());
		nameList.push($("#PD_NAME_"+$(this).val()).val());
		priceList.push($("#PD_PRICE_"+$(this).val()).val());
		
		console.log('체크항목', chechkList);
		console.log('주문상세번호', orderdtnumList);
		console.log('반품수량', qtyList);
		console.log('증감구분', gbnList);		
		console.log('제품코드', codeList);
		console.log('제품명', nameList);
		console.log('제품단가', priceList);
    	
    	//frm.submit();
    });
    
    /* 필수값 체크 */
    $("#eventFrm").validate({
    	debug: false,
        onfocusout: false,
        rules: {
        	PD_CODE: {
                required: true
            },
        	PDDC_VAL: {
                required: true
            },
            PDDC_GUBN: {
                required: true
            }            
        }, messages: {
        	PD_CODE: {
                required: '상품코드는 필수값 입니다.'
            },
            PDDC_VAL: {
                required: '할인금액 또는 할인율을 입력해주세요.'
            },
            PDDC_GUBN: {
                required: '할인구분을 선택해주세요.'
            }
        }, errorPlacement: function(error, element) {
            // do nothing
        }, invalidHandler: function(form, validator) {
             var errors = validator.numberOfInvalids();
             if (errors) {
                 alert(validator.errorList[0].message);
                 validator.errorList[0].element.focus();
             }          
        }
    });
    
});

/* Enter 이벤트 제거 (비동기 form submit 방지) */
document.addEventListener('keydown', function(event) {
	if (event.keyCode === 13) {
		event.preventDefault();
	};
}, true);
</script>

<c:set var="strActionUrl" value="${contextPath }/adm/productEditMgr" />
<c:set var="strMethod" value="post" />

<section class="content-header">
	<h1>
		전표관리
		<small>확정목록</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>

<section class="content">
	<!-- 주문 정보 시작 -->
	<div class="box box-info">
		<div class="box-header with-border">
			<h3 class="box-title">주문정보</h3>
			<button type="button" class="btn btn-default btn-sm pull-right btnHelp">
				<i class="fa fa-question-circle"></i> 도움말
			</button>
		</div>
		<!-- /.box-header -->
		
		<div class="box-body">
			<div class="form-group">
				<label for="ORDER_NUM" class="col-sm-2 control-label">주문번호</label>
				<div class="col-sm-4">${tb_odinfoxm.ORDER_NUM }</div>
				<label for="MEMB_NM" class="col-sm-2 control-label">주문자</label>
				<div class="col-sm-4">${tb_odinfoxm.MEMB_NM }</div>						
			</div><br/>
			<div class="form-group">
				<label for="ORDER_DATE" class="col-sm-2 control-label">주문일자</label>
				<div class="col-sm-4">${tb_odinfoxm.ORDER_DATE }</div>
				<label for="DAP_YN" class="col-sm-2 control-label">배송비 결제여부</label>
				<div class="col-sm-4">${tb_odinfoxm.DAP_YN }</div>
			</div><br/>
			<div class="form-group">
				<label for="COM_BUNB" class="col-sm-2 control-label">사업자번호</label>
				<div class="col-sm-4">${tb_odinfoxm.COM_BUNB }</div>
				<label for="CPON_YN" class="col-sm-2 control-label">쿠폰 사용여부</label>
				<div class="col-sm-4">${tb_odinfoxm.CPON_YN }</div>
			</div><br>				
		</div>
		<!-- /.box-body -->
	</div>
	<!-- 주문 정보 끝 -->

	<!-- 추가실패목록 START -->
	<c:if test = "${errlist ne null}">
		<!-- 변경실패 -->
		<div class="box">
			<div class="box-header with-border">
				<h3 class="box-title">추가 실패 : <font color = "red"><b>${errlist.size()}</b></font></h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse">
						<i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove">
						<i class="fa fa-remove"></i>
					</button>
				</div>
			</div>		
			<!-- /.box-header -->
			<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th width="70px">순번</th>
							<th width="20%">바코드</th> 
							<th width="20%">상품명</th>
							<th width="150px">에러코드</th>
							<th>메시지</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${errlist}" var="list" varStatus="loop">
						<tr>
							<td align="center">
								<label>${loop.count}</label>
							</td>
							<td align="left">
								<label>${list.PD_BARCD}</label>
							</td>
							<td align="left">
								<label>${list.PD_NAME}</label>
							</td>
							<td align="left">
								<label>${list.ERROR_CODE}</label>
							</td>
							<td align="left">
								<label>${list.ERROR_TEXT}</label>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${errlist.size() eq 0}">
						<tr>
							<td colspan="4"><label>업로드에 성공하였습니다.</label></td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</c:if>					
	<!-- 추가실패목록 END-->
	
	<!-- 기존 주문 START  -->
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">기존 주문 : <font color="green"><b>${tb_odinfoxm.list.size() > 0 ? tb_odinfoxm.list.size() : 0}</b></font></h3>
		</div>		
		<!-- /.box-header -->
		<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
			<table class="table table-bordered" id="eventPdList">
				<thead>
					<tr>
						<th style="width:80px">순번</th>
						<th>상품코드</th>
						<th>상품명</th>
						<th>제품가격</th>
						<th>판매가격</th>
						<th>주문수량</th>
						<th>주문금액</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${tb_odinfoxm.list }" var="list" varStatus="loop">
					<tr>
						<td>${list.ORDER_DTNUM }</td>
						<td>${list.PD_CODE }</td>
						<td>${list.PD_NAME }</td>
						<td>${list.PD_PRICE }</td>
						<td>${list.REAL_PRICE }</td>
						<td>${list.ORDER_QTY }</td>
						<td>${list.REAL_PRICE * list.ORDER_QTY }</td>
					</tr>
				</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<th class="txt-right" colspan="6">상품 합계 </th>
						<td class="txt-right" colspan="1"> <fmt:formatNumber><c:out value="${tb_odinfoxm.ORDER_AMT - tb_odinfoxm.DLVY_AMT}"/></fmt:formatNumber> </td>
					</tr>
					<tr>
						<th class="txt-right" colspan="6">배송비 </th>
						<td class="txt-right" colspan="1"> 
							<c:set var = "dlvyAmt" value="${tb_odinfoxm.DLVY_AMT }"/>
							<fmt:formatNumber><c:out value="${dlvyAmt}"/></fmt:formatNumber>
						</td>
					</tr>
					<tr>
						<th class="txt-right" colspan="6">총 합계 </th>
						<td class="txt-right" colspan="1"> <fmt:formatNumber><c:out value="${tb_odinfoxm.ORDER_AMT}"/></fmt:formatNumber> </td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
	<!-- 기존 주문 START -->
	
	<!-- 마이너스 전표 START -->
	<spform:form class="form-horizontal" name="editFrm" id="editFrm" method="${strMethod }" action="${strActionUrl }">
		<input type="hidden" name="ORDER_NUM" value="${tb_odinfoxm.ORDER_NUM }" />
		<input type="hidden" name="MEMB_ID" value="${tb_odinfoxm.MEMB_ID }" />
		<!-- 디테일  -->
		<input type="hidden" name="ORDER_DTNUMS" value=""/>
		<input type="hidden" name="PD_CODES" value=""/>
		<input type="hidden" name="PD_NAMES" value=""/>
		<input type="hidden" name="PD_PRICES" value=""/>
		<input type="hidden" name="PDDC_GUBNS" value=""/>
		<input type="hidden" name="PDDC_VALS" value=""/>
		<input type="hidden" name="REAL_PRICES" value=""/>
		<input type="hidden" name="EDIT_GBNS" value=""/>
		<input type="hidden" name="ORDER_QTYS" value=""/>
		<input type="hidden" name="ORDER_AMTS" value=""/>											
		<input type="hidden" name="BOX_PDDC_GUBNS" value=""/>
		<input type="hidden" name="BOX_PDDC_VALS" value=""/>
		
		
		<div class="box">
			<div class="box-header with-border">
				<h3 class="box-title">환불 상품</h3>
			</div>		
			<!-- /.box-header -->
			<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
				<table class="table table-bordered" id="editPdList">
					<thead>
						<tr>
							<th class="txt-middle" style="width:50px">
								<input type="checkbox" id="ALLCHK"/>
							</th>
							<th style="width:80px">순번</th>
							<th>상품코드</th>
							<th>상품명</th>
							<th>제품가격</th>							
							<th>판매가격</th>
							<th>구분</th>
							<th>환불수량</th>
							<th>환불금액</th>							
						</tr>					
					</thead>
					<tbody>
					<c:forEach items="${tb_odinfoxd.list }" var="list" varStatus="loop">
						<tr id="list_${list.ORDER_DTNUM }">
							<td class="txt-middle">
								<input type="checkbox" id="rtn_${list.ORDER_DTNUM }" name="RTN_CHK" value="${list.ORDER_DTNUM }"/>
							</td>
							<td>
								<input id="num_${list.ORDER_DTNUM }" class="form-control input-sm"
									type="text" id="PD_CODE_${list.ORDER_DTNUM }" name="ORDER_DTNUM" value="${list.ORDER_DTNUM}" title="순번" readonly="readonly"/>
							</td>
							<td>
								<input id="code_${list.ORDER_DTNUM }" class="form-control input-sm"  
									type="text" name="PD_CODE" value="${list.PD_CODE }" title="${list.PD_CODE }" readonly="readonly"/>
							</td>
							<td>
								<input id="name_${list.ORDER_DTNUM }" class="form-control input-sm"
									type="text" name="PD_NAME" value="${list.PD_NAME }" title="${list.PD_NAME }" readonly="readonly"/>
							</td>
							<td>
								<input id="price_${list.ORDER_DTNUM }" class="form-control input-sm" 
									type="text" name="PD_PRICE" value="${list.PD_PRICE }" title="제품가격" readonly="readonly"/>
							</td>
							<td>
								<input id="real_${list.ORDER_DTNUM }" class="form-control input-sm" 
									type="text" name="REAL_PRICE" value="${list.REAL_PRICE }" title="판매가격" readonly="readonly"/>
							</td>
							<td>
								<select id="gubn_${list.ORDER_DTNUM }" name="QTY_GUBN" class="form-control input-sm select2" >								
									<option value="-" selected>감소</option>
									<option value="+">증가</option>
								</select>
							</td>
							<td>
								<input id="qty_${list.ORDER_DTNUM }" class="form-control input-sm number" 
									type="number" name=RETURN_QTY value="${list.ORDER_QTY ? 0 : 0 }" title="환불수량"/>
							</td>
							<td>
								<input id="total_${list.ORDER_DTNUM }" class="form-control input-sm" 
									type="text" name="RETURN_AMT" value="${list.REAL_PRICE * list.ORDER_QTY}" title="환불금액" readonly="readonly"/>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</spform:form>
	
	<div class="box-footer" >
		<a href="${contextPath}/adm/orderEditMgr" class="btn btn-default pull-right"><i class="fa fa-list"></i> 목록</a>
		<button type="button" class="btn btn-primary pull-right right-5" id="btnSave"><i class="fa fa-save"></i> 수정</button>
	</div>			
	<!-- /.box-footer -->
</section>
 