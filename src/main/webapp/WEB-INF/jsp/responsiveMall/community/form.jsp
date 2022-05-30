<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- Main Container  -->
<div class="main-container container">
	<ul class="breadcrumb">
		<li><a href="${contextPath }/m"><i class="fa fa-home"></i></a></li>
		<li><a href="${contextPath }/m/community">고객센터</a></li>
		<li><a href="${contextPath }/m/community/list">1:1문의</a></li>
	</ul>
	
	<div class="row">
		<div id="content" class="col-sm-12">
			<h2 class="title">
				<b>문의하기</b>
			</h2>
			<spform:form class="form-horizontal" name="qnaFrm" id="qnaFrm" method="POST" action="${contextPath }/m/community/edit">
				<div class="table-responsive form-group">
					<input type="hidden" class="form-control" name="BRD_NUM" value="${tb_pdbordxm.BRD_NUM }" />					
					<input type="hidden" class="form-control" name="WRTR_ID" value="${tb_pdbordxm.WRTR_ID }" />					
					<input type="hidden" class="form-control" name="SCWT_YN" value="${tb_pdbordxm.SCWT_YN }" />
					<input type="hidden" class="form-control" name="BRD_PW" value="${tb_pdbordxm.BRD_PW }" />
					<input type="hidden" class="form-control" name="PD_CODE" value="${tb_pdbordxm.PD_CODE }" />
					<input type="hidden" class="form-control" name="ORDER_NUM" value="${tb_pdbordxm.ORDER_NUM }" />
					
					<table class="table table-bordered" id="qtable">
						<tr>
							<td class="text-center" style="width:100px; background:#eee;"><b>분류</b></td>
							<td class="text-left">
								<c:if test="${tb_pdbordxm.BRD_GUBN eq null }">
									<select class="form-control" name="BRD_GUBN" id="BRD_GUBN" required>
										<option value="">선택</option>
										<option value="BRD_GUBN_01" ${tb_pdbordxm.BRD_GUBN eq 'BRD_GUBN_01' ? 'selected=selected' : '' }>1:1문의</option>
										<option value="BRD_GUBN_02" ${tb_pdbordxm.BRD_GUBN eq 'BRD_GUBN_02' ? 'selected=selected' : '' }>상품문의</option>
										<option value="BRD_GUBN_03" ${tb_pdbordxm.BRD_GUBN eq 'BRD_GUBN_03' ? 'selected=selected' : '' }>반품문의</option>
									</select>
								</c:if>
								<c:if test="${tb_pdbordxm.BRD_GUBN ne null }">
									<input class="form-control" type="hidden"name="BRD_GUBN" id="BRD_GUBN" value="${tb_pdbordxm.BRD_GUBN }" />
									${ tb_pdbordxm.BRD_GUBN_NM }
								</c:if>
							</td>
						</tr>
						<tr>
							<th class="text-center" style="width:100px;"><b>제목</b></th>
							<td class="text-left"><input type="text" class="form-control" name="BRD_SBJT" id="BRD_SBJT" value="${tb_pdbordxm.BRD_SBJT }" required/></td>
						</tr>
						<tr>
							<th class="text-center" style="width:100px;"><b>이름</b></th>
							<td class="text-left">${tb_pdbordxm.WRTR_NM }</td>
						</tr>
						<tr>
							<th class="text-center" style="width:100px;"><b>이메일</b></th>
							<td class="text-left">${tb_pdbordxm.MEMB_MAIL }</td>
						</tr>
						<tr>
							<th class="text-center" style="width:100px;"><b>연락처</b></th>
							<td class="text-left">${tb_pdbordxm.MEMB_CPON }</td>
						</tr>
						<tr>
							<th class="text-center" style="width:100px;"><b>문의내용</b></th>
							<td>
								<textarea id="BRD_CONT" name="BRD_CONT" rows="10" cols="20" style="width:100%;" required><c:if test="${tb_pdbordxm.BRD_CONT ne null or tb_pdbordxm.BRD_CONT ne '' }">${tb_pdbordxm.BRD_CONT }</c:if></textarea>
							</td>
						</tr>
					</table>
				</div>
				
				<div class="buttons">
					<a href="${contextPath }/m/community/list" class="btn btn-default pull-right mg-rigit-5">목록</a>
					<button type="button" class="btn btn-primary pull-right mg-rigit-5 btnSave">등록하기</button>
				</div>			
			</spform:form>
		</div>
		<!-- /.Middle Part -->
	</div>
</div>
<!-- /.Main Container -->


<script type="text/javascript">
$(function(){
	/* 초기 양식 설정 */
	fnMakeHtml($('#BRD_GUBN').val());
	
	/* 저장 */
	$(".btnSave").click(function(){
		// 동적 추가된 필드 체크
		var brdGubn = $('#BRD_GUBN').val();
		var pdCode = $('input[name=PD_CODE]').val();
		var ordNum = $('input[name=ORDER_NUM]').val();
    	
    	if(brdGubn == 'BRD_GUBN_02'){
    		if(!pdCode){ alert("문의상품을 선택해주세요."); return; }
    		
    	}else if(brdGubn == 'BRD_GUBN_03'){
    		if(!ordNum){ alert("반품주문을 선택해주세요."); return; }
    		if(!pdCode){ alert("반품상품을 선택해주세요."); return; }		
    	}
		
		if(!confirm("저장하시겠습니까?")) return;
		$('#qnaFrm').submit();
	});
	
	/* 필수값 체크 */
    $("#qnaFrm").validate({
        debug: false,
        onfocusout: false,
        rules: {
        	BRD_GUBN: {
                required: true
            },
            BRD_SBJT: {
                required: true
            },
            BRD_CONT: {
                required: true
            }
        }, messages: {
        	BRD_GUBN: {
                required: '분류를 선택해주세요.'
            },
            BRD_SBJT: {
                required: '제목를 입력해주세요.'
            },
            BRD_CONT: {
                required: '내용을 입력해주세요.'
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
	
    /* 문의구분 변경 */
	$("#BRD_GUBN").change(function(){
		var strHtml = "";
		var content = $("#BRD_CONT").val();
		var brdGubn = $(this).val();
		
		// 초기화
		$(".tnew").remove();
		
		// 문의구분별 양식 설정
		fnMakeHtml(brdGubn);
		
		/* 
		// 문의내용이 있을 경우
		if(content){
			if(confirm("문의내용이 초기화 됩니다. 적용하시겠습니까?")) return;
		}
		
		// 문의 구분별 지정양식
		strHtml = fnMakeText($(this).val());
		
		$('#BRD_CONT').val(strHtml)
		 */
	});

	/* 동적으로 추가된 버튼 제어 */
    $("#qtable").on("click", "#btnSlct", function() {
    	var brdGubn = $('#BRD_GUBN').val();
    	
    	if(brdGubn == 'BRD_GUBN_02'){
    		$('#pdModal').modal('show');
    	
    	}else if(brdGubn == 'BRD_GUBN_03'){
			// 주문번호 팝업
        	$.ajax({
        		type : "GET",
        		dataType : "json",
        		url : "${contextPath}/m/community/ordpop.json",
        		data : $("#qnaFrm").serialize(),
        		success : function(data){
        			// 상품추가팝업 Modal에 데이터 add
        			var ajaxCnt = data.count;
        			var ordList = data.list;
        			var tbody = $("#ordList > tbody");
        			tbody.empty();	//초기화
        			
        			if(ajaxCnt > 0){    				
       					$.each(ordList, function(i, val){	
       						tbody.append($('<tr>')	
    									.append($('<td>', {text : val.order_NUM}))
    									.append($('<td>', {text : val.pd_NAME+' 외'}))
    									.append($('<td>', {text : val.order_AMT}))
    									.append($('<td>', {html : "<button type='button' id='chkOrd' value='"+val.order_NUM+"'>선택</button>"}))
    								);
    					});
        			} else{
        				tbody.append($('<tr>').append($('<td>', "조회된 내역이 없습니다.")));
        			}
        		},
        		error : function(request, status, error) {
        			alert("list search fail :: error code: " + request.status + "\n" + "error message: " + error + "\n");
        		}
        	});
        	
    		$('#ordModal').modal('show');
    	}    	
    });

	/* 주문번호 선택 */
    $("#ordList").on("click", "#chkOrd", function() {
    	$("input[name=ORDER_NUM]").val($(this).val());
    	$(".ordText").text($(this).val());
    	$("#ordModal").modal('hide');
    	
    	// 상품선택 초기화
    	$(".pdText").text("");
		$("input[name=PD_CODE]").val("");
    });
	
	/* 동적으로 추가된 주문상품 버튼 */
    $("#qtable").on("click", "#btnPdCd", function() {
    	var ordNum = $('input[name=ORDER_NUM]').val();
    	
    	if(!ordNum){
    		alert("주문번호를 선택해주세요.");
    		return;
    	}
		
    	$.ajax({
    		type : "GET",
    		dataType : "json",
    		url : "${contextPath}/m/community/pdpop.json",
    		data : $("#qnaFrm").serialize(),
    		success : function(data){
    			// 주문상품 팝업 Modal에 데이터 add
    			var ajaxCnt = data.count;
    			var ajaxList = data.list;
    			var tbody = $("#ajaxList > tbody");
    			tbody.empty();	//초기화
    			
    			if(ajaxCnt > 0){    				
   					$.each(ajaxList, function(i, val){	
   						tbody.append($('<tr>')	
	   								.append($('<td>', {text : i+1}))
									.append($('<td>', {text : val.pd_NAME}))
									.append($('<td>', {html : "<button type='button' id='chkPd' value='"+val.pd_CODE+"'>선택</button>"}))
								);
					});
    			} else {
    				tbody.append($('<tr>').append($('<td>', "조회된 내역이 없습니다.")));
    			}
    		},
    		error : function(request, status, error) {
    			alert("list search fail :: error code: " + request.status + "\n" + "error message: " + error + "\n");
    		}
    	});
    	
    	$('.boxSearch').addClass('hidden');
    	$('#pdModal').modal('show');
    });
	
	/* 상품코드 선택 */
    $("#ajaxList").on("click", "#chkPd", function() {
    	$("input[name=PD_CODE]").val($(this).val());
    	$('.pdText').text('	'+$(this).parent().prev().text());
    	$('.boxSearch').removeClass('hidden');
    	$('#ajaxList > tbody').empty();
    	$('#pdModal').modal('hide');
    });
	
  	/* 상품 팝업검색 */
    $("#ajaxSearch").click(function(){

    	$.ajax({
    		type : "GET",		
    		dataType : "json",
    		url : "${contextPath}/m/community/popup.json",
    		data : $("#ajaxfrm").serialize(),    		
    		success : function(data){    			
    			// 상품팝업 Modal에 데이터 add
    			var ajaxCnt = data.count;
    			var ajaxList = data.list;
    			var tbody = $("#ajaxList > tbody");
    			tbody.empty();	//초기화
    			
    			if(ajaxCnt > 0){    				
   					$.each(ajaxList, function(i, val){	
   						tbody.append($('<tr>')
									.append($('<td>', {text : i+1}))
									.append($('<td>', {text : val.pd_NAME}))
									.append($('<td>', {html : "<button type='button' id='chkPd' value='"+val.pd_CODE+"'>선택</button>"}))
								);
					});
    			} else{
    				tbody.append($('<tr>').append($('<td>', "조회된 내역이 없습니다.")));
    			}
    		},
    		error : function(request, status, error) {
    			alert("list search fail :: error code: " + request.status + "\n" + "error message: " + error + "\n");
    		}
    	});    	
    });
  	
});

/* 문의구분별 추가 선택 양식 */
function fnMakeHtml(brdGubn){
		
	if(brdGubn == 'BRD_GUBN_02'){
		// tr element 추가
		var newitem = $("#qtable tbody tr:eq(4)").clone();
		newitem.addClass("tnew");
		newitem.find("th:eq(0)").text("문의상품");
		newitem.find("td:eq(0)").text("").append('<button type="button" class="btn btn-xs btn-default" id="btnSlct">상품 선택</button>');
		newitem.find("td:eq(0)").append('<label class="control-label pdText">${tb_pdbordxm.PD_NAME }</label>');
		
		$("#qtable tbody tr:eq(4)").after(newitem);
				
	}else if(brdGubn == 'BRD_GUBN_03'){
		// tr element 추가			
		var newitem = $("#qtable tbody tr:eq(4)").clone();
		newitem.addClass("tnew");
		newitem.find("th:eq(0)").text("문의상품");
		newitem.find("td:eq(0)").text("").append('<button type="button" class="btn btn-xs btn-default" id="btnPdCd">상품 선택</button>');
		newitem.find("td:eq(0)").append('<label class="control-label pdText">${tb_pdbordxm.PD_NAME }</label>');
		
		$("#qtable tbody tr:eq(4)").after(newitem);
		
		var orditem = $("#qtable tbody tr:eq(4)").clone();
		orditem.addClass("tnew");
		orditem.find("th:eq(0)").text("주문번호");
		orditem.find("td:eq(0)").text("").append('<button type="button" class="btn btn-xs btn-default" id="btnSlct">주문번호 선택</button>');
		orditem.find("td:eq(0)").append('<label class="control-label ordText">${tb_pdbordxm.ORDER_NUM }</label>');
		
		$("#qtable tbody tr:eq(4)").after(orditem);
	}
}
 
/* 문의구분별 지정양식 */
function fnMakeText(brdGubn) {
	var rtnHtml = "";
	
	if(brdGubn == 'BRD_GUBN_02'){
		rtnHtml += '1.주문번호 : \r';
		rtnHtml += '2.상품명 : \r';
		rtnHtml += '\r';
		rtnHtml += '3.내용 ------------ \r';		
		rtnHtml += '\r';
	}else if(brdGubn == 'BRD_GUBN_03'){
		rtnHtml += '교환/반품 안내 \r';
		rtnHtml += '1.주문번호 : \r';
		rtnHtml += '2.상품명 : \r';
		rtnHtml += '\r';
		rtnHtml += '3.내용 ------------ \r';		
		rtnHtml += '\r';
	}else{
		
	}
	
	return rtnHtml;
}

</script>


<!-- 상품 선택 팝업 -->
<div class="modal fade" id="pdModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" style="width:50vw; min-width:340px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="pdModalLabel">상품 팝업</h4>
			</div>
			<div class="modal-body">
				<!-- 검색조건 박스 -->
				<div class="box box-primary boxSearch">
					<form class="form-horizontal" id="ajaxfrm" method="get">
						<input type="hidden" name="sortGubun" id="sortGubun" />
						<input type="hidden" name="sortOdr" id="sortOdr" />
						<input type="hidden" name="SALE_CON" id="SALE_CON" value="SALE_CON_01"/>
																	
						<div class="box-body">
							<div class="form-group">
								<label for="schGbn" class="col-sm-2 control-label">검색어</label>
								<div class="col-sm-2">
									<select name="schGbn" class="form-control select2">
										<option value="PD_NAME" ${ param.schGbn eq 'PD_NAME' ? "selected='selected'":''}>상품명</option>
									</select>
								</div>
								<div class="col-sm-7">
									<div class="input-group">
										<input type="search" class="form-control" name="schTxt" placeholder="검색어 입력" value="${param.schTxt }">
										<span class="input-group-btn">
											<button type="button" id="ajaxSearch" class="btn btn-success pull-right">검색</button>
										</span>
									</div>
								</div>
							</div>
						</div>
						<!-- /.box-body -->
					</form>
				</div>
				<!--상품정보 테이블 -->
				<div style="max-height:50vh; overflow-y:scroll;">					
					<table class="table table-bordered" id="ajaxList">
						<thead>
							<tr>
								<th style="width:55px;">번호</th>
								<th>상품명</th>
								<th style="width:60px;">선택</th>
							</tr>
						</thead>
						<tbody>
							<!-- append -->
						</tbody>
					</table>
				</div>
			</div>
			<!-- /.modal-body -->
		</div>
	</div>
</div>

<!-- 주문번호 선택 팝업 -->
<div class="modal fade" id="ordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" style="width:50vw;  min-width:340px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="pdModalLabel">주문번호 팝업</h4>
			</div>
			<div class="modal-body">			
				<!--상품정보 테이블 -->
				<div style="max-height:50vh; overflow-y:scroll;">					
					<table class="table table-bordered" id="ordList">
						<thead>
							<tr>
								<th>주문번호</th>
								<th>상품명</th>
								<th>주문금액</th>
								<th style="width:60px;">선택</th>
							</tr>
						</thead>
						<tbody>
							<!-- append -->
						</tbody>
					</table>
				</div>
			</div>
			<!-- /.modal-body -->
		</div>
	</div>
</div>
