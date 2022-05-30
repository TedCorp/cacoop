<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		기업 관리
		<small>기업 등록</small>
	</h1>
</section>

<section class="content">
	<!-- form start -->
	<spform:form class="form-horizontal" name="supplierFrm" id="supplierFrm" method="post" action="${contextPath }/adm/supplierMgr" onsubmit="return fn_validation(this);">
		<input type="hidden" id="pageNum" name="pageNum" value="${param.pageNum }" />
		<input type="hidden" id="rowCnt" name="rowCnt" value="${param.rowCnt }" /> 
		<input type="hidden" id="schGbn" name="schGbn" value="${param.schGbn }" /> 
		<input type="hidden" id="schTxt" name="schTxt" value="${param.schTxt }" /> 
		<!--  -->
		<input type="hidden" name="SUPR_ID" value="${supplierInfo.SUPR_ID }" />					<!-- 공급업체 ID -->
		<input type="hidden" name="SVMN_USCON" value="${supplierInfo.SVMN_USCON }" />	<!-- 적립금 사용조건 -->
		<input type="hidden" name="DLVREF_CONT" value="${supplierInfo.DLVREF_CONT }" />	<!-- 배송/환불 내용 -->
		
		<input type="hidden" name="BIZR_CHK_YN" id="BIZR_CHK_YN" value="Y"/>
		
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">기본정보</h3>
			</div>
			<!-- /.box-header -->
			<div class="box-body">
				<div class="form-group">
					<label for="SUPR_ID" class="col-sm-2 control-label required">공급사코드</label>
					<div class="col-sm-9">${supplierInfo.SUPR_ID }</div>
				</div>
				
				<div class="form-group">
					<label for="SUPR_NAME" class="col-sm-2 control-label required">공급사명</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="SUPR_NAME" name="SUPR_NAME" value="${supplierInfo.SUPR_NAME }" title="기업명" placeholder="기업명" required="required" />
					</div>
					<label for="RPRS_NAME" class="col-sm-1 control-label required">대표자명</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="RPRS_NAME" name="RPRS_NAME" value="${supplierInfo.RPRS_NAME }" title="대표자명" placeholder="대표자명" required="required" />
					</div>
				</div>
				
				<div class="form-group">
					<!-- 사업자번호 중복확인 로직필요 -->
					<label for="BIZR_NUM" class="col-sm-2 control-label required">사업자등록번호</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="BIZR_NUM" name="BIZR_NUM" value="${supplierInfo.BIZR_NUM }" title="사업자번호는 숫자만 입력해주세요" placeholder="-를 입력해하고 적어주세요" required="required" maxlength="12" />
					</div>
					<div class="col-sm-4">
						<div id="BIZR_NUM_CHK_MSG"></div>
					</div>
				</div>
				
				<div class="form-group">
					<label for="TEL_NUM" class="col-sm-2 control-label required">전화번호</label>
					<div class="col-sm-4">
						<div class="form-inline">
							<input type="hidden" name="TEL_NUM" id="TEL_NUM" value="">
							<input type="tel" class="form-control onlyNum" name="TEL_NUM1" id="TEL_NUM1" value="${fn:split(supplierInfo.TEL_NUM,'-')[0]}" style="width:60px; display: inline-block;" maxlength="3" required="required">&nbsp;-&nbsp;
							<input type="tel" class="form-control onlyNum" name="TEL_NUM2" id="TEL_NUM2" value="${fn:split(supplierInfo.TEL_NUM,'-')[1]}" style="width:60px; display: inline-block;" maxlength="4" required="required">&nbsp;-&nbsp;
							<input type="tel" class="form-control onlyNum" name="TEL_NUM3" id="TEL_NUM3" value="${fn:split(supplierInfo.TEL_NUM,'-')[2]}" style="width:60px; display: inline-block;" maxlength="4" required="required">
						</div>
					</div>
					
					<label for="FAX_NUM" class="col-sm-1 control-label">팩스번호</label>
					<div class="col-sm-4">
						<div class="form-inline">
							<input type="hidden" name="FAX_NUM" id="FAX_NUM" value="">
							<input type="tel" class="form-control onlyNum" name="FAX_NUM1" id="FAX_NUM1" value="${fn:split(supplierInfo.FAX_NUM,'-')[0]}" style="width:60px; display: inline-block;" maxlength="3">&nbsp;-&nbsp;
							<input type="tel" class="form-control onlyNum" name="FAX_NUM2" id="FAX_NUM2" value="${fn:split(supplierInfo.FAX_NUM,'-')[1]}" style="width:60px; display: inline-block;" maxlength="4">&nbsp;-&nbsp;
							<input type="tel" class="form-control onlyNum" name="FAX_NUM3" id="FAX_NUM3" value="${fn:split(supplierInfo.FAX_NUM,'-')[2]}" style="width:60px; display: inline-block;" maxlength="4">
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label for="RPR_MAIL" class="col-sm-2 control-label">대표이메일</label>
					<div class="col-sm-4">
						<input type="email" class="form-control noHangul" id="RPR_MAIL" name="RPR_MAIL" value="${supplierInfo.RPR_MAIL }" title="대표 이메일" placeholder="대표 이메일"/>
					</div>
					<%-- 
					<label for="AUTH_MAIL" class="col-sm-1 control-label sendMail">발신이메일</label>
					<div class="col-sm-3 sendMail">
						<div class="input-group">
							<input type="email" class="form-control noHangul" id="SEND_MAIL" value="${supplierInfo. AUTH_MAIL }" title="발신용 이메일" placeholder="발신용 이메일" readonly/>
							<span class="input-group-btn">
								<button type="button" class="btn btn-warning btnModal">계정변경</button>
								<button type="button" class="btn btn-default left-5 btnHelp"><i class="fa fa-question-circle"></i> 도움말</button>
							</span>
						</div>
					</div>
					<div class="col-sm-2">
						<p class="form-control-static">
			                <jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="COMM_YN" />
								<jsp:param name="name" value="MAIL_YN" />
								<jsp:param name="value" value="${ supplierInfo.MAIL_YN }" />
								<jsp:param name="type" value="radio" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</p>
					</div>
					 --%>
				</div>
				
				<div class="form-group">
					<label for="POST_NUM" class="col-sm-2 control-label required">주소</label>
					<div class="col-sm-2">
						<input type="hidden" name="EXTRA_ADDR" id="EXTRA_ADDR" value="">
						<input type="hidden" name="ALL_ADDR" id="ALL_ADDR" value="">
						
						<div class="input-group">
							<input type="text" class="form-control" id="POST_NUM" name="POST_NUM" value="${supplierInfo.POST_NUM }" placeholder="우편번호" maxlength="5" required="required" readonly/>
							<span class="input-group-btn">
								<button type="button" class="btn btn-default"
											onclick="win_zip('supplierFrm', 'POST_NUM', 'BASC_ADDR', 'DTL_ADDR', 'EXTRA_ADDR', 'ALL_ADDR');">주소검색</button>
							</span>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label for="BASC_ADDR" class="col-sm-2 control-label"></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="BASC_ADDR" name="BASC_ADDR" value="${supplierInfo.BASC_ADDR }" placeholder="기본주소" required="required" readonly/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="DTL_ADDR" class="col-sm-2 control-label"></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="DTL_ADDR" name="DTL_ADDR" value="${supplierInfo.DTL_ADDR }" placeholder="상세주소">
					</div>
				</div>
				
			<%-- 	<div class="form-group">
					<label for="BIZR_STYLE" class="col-sm-2 control-label required">업태</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="BIZR_STYLE" value="${supplierInfo.BIZR_STYLE }" placeholder="업태" required="required" maxlength="50" />
					</div>
					<label for="BIZR_EVENT" class="col-sm-1 control-label required">종목</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="BIZR_EVENT" value="${supplierInfo.BIZR_EVENT }" placeholder="종목" required="required" maxlength="50" />
					</div>
				</div> --%>
			</div>			
			<!-- /.box-body -->
		</div>
	
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">운영정책</h3>
			</div>				
			<!-- /.box-header -->
			<div class="box-body">
				<div class="form-group">
					<label for="DLVY_AMT" class="col-sm-2 control-label required">배송비</label>
					<div class="col-sm-2">
						<div class="input-group">
							<input type="text" class="form-control number" id="DLVY_AMT" name="DLVY_AMT" value="<fmt:formatNumber value="${supplierInfo.DLVY_AMT eq null ? 0 : supplierInfo.DLVY_AMT }" pattern="#,###"/>" maxlength="15" />
							<div class="input-group-addon">원</div>
						</div>
					</div>
					
					<label for="DLVA_FCON" class="col-sm-3 control-label required">배송비 무료조건</label>
					<div class="col-sm-2">
						<div class="input-group">
							<input type="text" class="form-control number" id="DLVA_FCON" name="DLVA_FCON" value="<fmt:formatNumber value="${supplierInfo.DLVA_FCON eq null ? 0 : supplierInfo.DLVA_FCON }" pattern="#,###"/>" maxlength="15" />
							<div class="input-group-addon">원 이상 구매시</div>
						</div> 
					</div>
				</div>
				
				<div class="form-group">
					<label for="DLVY_COM" class="col-sm-2 control-label required">지정 택배사</label>
					<div class="col-sm-2">
						<p class="form-control-static">
			                <jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="DLVY_COM" />
								<jsp:param name="name" value="PS_COM" />
								<jsp:param name="value" value="${ supplierInfo.PS_COM }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</p>
					</div>
					
					<label for="SBK_PROD" class="col-sm-3 control-label">장바구니 보관기간</label>
					<div class="col-sm-2">
						<p class="form-control-static">
			                <jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="SBK_PROD" />
								<jsp:param name="name" value="SBK_PROD" />
								<jsp:param name="value" value="${ supplierInfo.SBK_PROD }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</p>
					</div>
				</div>
				
				<!-- 자동확정 로직 없음 -->
				<div class="form-group">
					<label for="APR_PROD" class="col-sm-2 control-label">자동 상품수령 기간</label>
					<div class="col-sm-2">
						<p class="form-control-static">
			                <jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="APR_PROD" />
								<jsp:param name="name" value="APR_PROD" />
								<jsp:param name="value" value="${ supplierInfo.APR_PROD }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</p>
					</div>
					
					<label for="APD_PROD" class="col-sm-3 control-label">자동 구매확정 기간</label>
					<div class="col-sm-2">
						<p class="form-control-static">
			                <jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="APD_PROD" />
								<jsp:param name="name" value="APD_PROD" />
								<jsp:param name="value" value="${ supplierInfo.APD_PROD }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</p>
					</div>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
		
		<!-- this row will not appear when printing -->
		<div class="row">
			<div class="col-xs-12">
				<a href="${contextPath}/adm/supplierMgr?pageNum=${param.pageNum }&rowCnt=${param.rowCnt }${link}" class="btn btn-default right-5 pull-right">
					<i class="fa fa-list"></i> 목록
				</a>
				<button type="submit" class="btn btn-primary right-5 pull-right btnSave">
					<i class="fa fa-save"></i> 저장
				</button>
				<c:if test="${supplierInfo.SUPR_ID ne null }">
					<button type="button" class="btn btn-danger pull-right right-5 btnSec">
						<i class="fa fa-sign-out"></i> 탈퇴
					</button>
				</c:if>
			</div>
		</div>		
	</spform:form>
	<!-- /.box -->
</section>


<!-- 이메일 계정 입력 -->
<%-- 
<div class="modal fade" id="mailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" style="width:30vw; min-width:300px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="pwModalLabel">발송용 메일 변경</h4>
			</div>
			<div class="modal-body">
				<!-- 입력 박스 -->
				<form class="form-horizontal" name="mailFrm" id="mailFrm" method="POST" action="${contextPath }/adm/supplierMgr/mailAdd">
					<input type="hidden" name="SUPR_ID" value="${supplierInfo.SUPR_ID }" />
					<input type="hidden" name="AUTH_MAIL" id="AUTH_MAIL" value="">
					<input type="hidden" name="MAIL_GUBN" id="MAIL_GUBN" value="">
					
					<div class="box-body">
						<div class="form-group">
							<label class="col-sm-2 control-label" for="AUTH_MAIL">아이디</label>
							<div class="col-sm-9">
								<div class="input-group input-group-sm">
									<input type="text" class="form-control input-sm noHangul" id="AUTH_MAIL1" value="" placeholder="계정 아이디" required>
									<div class="input-group-addon">@</div>
									<select class="form-control select2" id="AUTH_MAIL2" required>
										<option value="" selected>선택하세요</option>
										<option value="naver.com">naver.com</option>
										<option value="gmail.com">gmail.com</option>
										<!-- <option value="1">직접입력</option> -->
									</select>
								</div>
							</div>							
						</div>
						
						<div class="form-group">
							<label class="col-sm-2 control-label" for="RPR_PASS">비밀번호</label>
							<div class="col-sm-9">
								<div class="input-group input-group-sm">
									<input type="password" class="form-control input-sm" name="RPR_PASS" id="RPR_PASS" value="" placeholder="계정 비밀번호" required>
									<span class="input-group-btn">
										<button type="button" class="btn btn-sm btn-warning" id="btnAuth">이메일 인증</button>
									</span>
								</div>
							</div>
						</div>
						
						<div class="form-group mailAuth">
							<label class="col-sm-2 control-label" for="RPR_AUTH">인증번호</label>
							<div class="col-sm-9">
								<div class="input-group input-group-sm">
									<input type="text" class="form-control input-sm" id="RPR_AUTH" value="" placeholder="인증번호">
									<span class="input-group-btn">
										<button type="button" class="btn btn-sm btn-default" id="btnKey">인증확인</button>
									</span>
								</div>
							</div>
						</div>
						<!--  -->
					</div>				
				</form>
				<!-- /.입력 박스 -->				
			</div>
			<div class="modal-footer mailUpdt">
				<button type="button" class="btn btn-sm btn-danger pull-right" id="btnMail">계정변경</button>
			</div>			
		</div>
	</div>
</div>
 --%>
<script>
$(function() {
	/* 숫자만 입력 가능 */
	$(".number").keyup(function(e) {
    	$(this).number(true);
	});
	
	/* Date picker */
	$('#datepicker').datepicker({
		autoclose: true
	});
	
    /* Money Euro */
    $("[data-mask]").inputmask();
    
    if(!$('input[name=SUPR_ID]').val()){
    	$('.sendMail').hide();
    }
    
    $('.mailAuth').hide();
    $('.mailUpdt').hide();
    
    /* 이메일 계정 변경 */
    $('.btnModal').click(function(){
    	$('#mailModal').modal('show');
    });
    
    /* 이메일 서비스 구분 */
    $('#AUTH_MAIL2').change(function(){
    	$('#MAIL_GUBN').val($(this).val().split('.')[0]);
    });
    
    /* 이메일 인증 */
    $('#btnAuth').click(function(){
    	// 이메일 및 비밀번호 입력체크
    	if(!$("#AUTH_MAIL1").val() || !$("#AUTH_MAIL2").val()){
    		alert("이메일을 입력해주세요.");
    		return;
    	}
    	if(!$("#RPR_PASS").val()){
    		alert("이메일 비밀번호를 입력해주세요.");
    		return;
    	}
    	
    	var authMail = $("#AUTH_MAIL1").val().trim() +"@"+ $("#AUTH_MAIL2").val();
    	$("#AUTH_MAIL").val(authMail);
    	
    	// ajax로 인증 이메일 send
	    $.ajax({
	        type:'POST',
	        url:"${contextPath}/adm/supplierMgr/sendAuth.json",
	        data: $("#mailFrm").serialize(),
	        success:function(data){
	        	// 성공시, 인증번호 입력창 show
	        	alert("이메일로 인증번호가 발송되었습니다.");
	        	
	        	// 이메일 비밀번호 readonly
	        	$("#AUTH_MAIL1").attr("readonly", true);
	        	$("#AUTH_MAIL2").attr("disabled", true);
	        	$("#RPR_PASS").attr("readonly", true);
	        	
	        	$('.mailAuth').show();	// 인증번호 입력창
	        },
	        error : function(request, status, error) {
       			alert("인증메일 발송실패 :: error code: " + request.status + "\n" + "error message: " + error + "\n");
       		}
	    });
    });
    
    $('#btnKey').click(function(){
    	// 인증번호
    	var AuthenticationUser = $('#RPR_AUTH').val().trim();
    	
    	// 세션에 넣어둔 값과 비교
    	$.ajax({
	        type:'POST',
	        url:"${contextPath}/m/getAuth",
	        data: { AuthenticationUser : AuthenticationUser },
	        success:function(data){
	        	// 인증번호 확인
	        	if(data){
	        		alert("인증이 완료되었습니다.");	        	
		        	$('.mailUpdt').show();
	        	}else{
	        		alert("인증번호가 일치하지 않습니다.");
	        	}        	
	        },
	        error : function(request, status, error) {
       			alert("인증 실패 :: error code: " + request.status + "\n" + "error message: " + error + "\n");
       		}
	    });    	
    });

    $('#btnMail').click(function(){
    	// 이메일정보 업데이트
    	$.ajax({
	        type:'POST',
	        url:"${contextPath}/adm/supplierMgr/updateMail.json",
	        data: $("#mailFrm").serialize(),
	        success:function(data){
				// 업데이트 성공시
	        	if(data == "1"){
	        		// Modal 초기화
		        	$('#mailModal').modal('hide');
		        	$("#AUTH_MAIL1").attr("readonly", false).val('');
		        	$("#AUTH_MAIL2").attr("disabled", false).val('');
		        	$("#RPR_PASS").attr("readonly", false).val('');
		        	$('.mailAuth').hide();
		        	$('.mailUpdt').hide();
		        	
		        	$('#SEND_MAIL').val($("#AUTH_MAIL").val());
		        	
		        	alert("발신용 계정이 변경되었습니다.");
	        	}else{
	        		alert("계정변경에 실패하였습니다.");
	        	}	        	
	        },
	        error : function(request, status, error) {
       			alert("계정변경 실패 :: error code: " + request.status + "\n" + "error message: " + error + "\n");
       		}
	    });
    });

    /* 숫자만 입력 */
	$(".onlyNum").keydown(function(){
		$(this).keyup(function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		});
	});

	/* 이메일 한글입력 안되게 처리 */
	$(".noHangul").keydown(function(){
		$(this).keyup(function(){
			$(this).val( $(this).val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ).trim() );
		});			
	});
	
    /* 탈퇴 */
    $('.btnSec').click(function(){
    	if(!confirm("탈퇴하시면 7일이내 재가입이 불가능합니다. 탈퇴하시겠습니까?")) return;
		$("#supplierFrm").attr("action","${contextPath }/adm/supplierMgr/delete");
		$("#supplierFrm").submit();
    });
    
    /* 필수값 체크 */
    $("#supplierFrm").validate({
    	debug: false,
        onfocusout: false,
        rules: {
        	SUPR_ID: {
                required: true
            },
            SUPR_NAME: {
                required: true
            },
            BIZR_NUM: {
                required: true
            } ,
            RPRS_NAME: {
                required: true
            },
            TEL_NUM: {
                required: true
            },
            POST_NUM: {
                required: true
            },
            BASC_ADDR: {
                required: true
            },
            DTL_ADDR: {
                required: true
            },
            DLVY_AMT: {
                required: true
            },
            DLVY_FCON: {
                required: true
            },
            DLVY_COM: {
                required: true
            }
           /*  ,
            BIZR_STYLE: {
                required: true
            },
            BIZR_EVENT: {
                required: true
            } */
        }, messages: {
        	SUPR_ID: {
                required: '기업코드는 필수값 입니다.'
            },
            SUPR_NAME: {
                required: '기업명을 입력해주세요.'
            },
            BIZR_NUM: {
                required: '사업자번호를 입력해주세요.'
            },
            RPRS_NAME: {
                required: '대표자명을 입력해주세요.'
            },
            TEL_NUM: {
                required: '전화번호를 입력해주세요.'
            },
            POST_NUM: {
                required: '우편번호를 입력해주세요.'
            },
            BASC_ADDR: {
                required: '기본주소를 입력해주세요.'
            },
            DTL_ADDR: {
                required: '상세주소를 입력해주세요.'
            },
            DLVY_AMT: {
                required: '배송비를 입력해주세요.'
            },
            DLVY_FCON: {
                required: '배송비조건을 입력해주세요.'
            },
            DLVY_COM: {
                required: '지정택배사를 선택해주세요.'
            }
         /*    ,
            BIZR_STYLE: {
                required: '업태를 입력해주세요.'
            },
            BIZR_EVENT: {
                required: '종목를 입력해주세요.'
            } */
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

	/* 사업자번호 중복 체크 */
	$("#BIZR_NUM").change(function(){
		var strComBunb = $(this).val().replace(/-/gi, "");
		
		if(strComBunb.length < 1){
			$('#BIZR_CHK_YN').val("N");
			return;
		}
		
		if(strComBunb.length != 10){
			$('#BIZR_NUM_CHK_MSG').html("<span><font color='red'>사업자등록번호 자릿수를 확인해 주세요</font></span>");
			$('#BIZR_CHK_YN').val("N");
			
		}else{
			//var strComBunbSub = strComBunb.substring(0,3)+"-"+strComBunb.substring(3,5)+"-"+strComBunb.substring(5,10);
			$("#BIZR_NUM_TMP").val(strComBunb);

		 	$.ajax({
		 		type:"POST",
		        url:"${contextPath }/adm/supplierMgr/comBunbChk",
				data: $("#bunbChkFrm").serialize(),
				success: function (data){
					// 사업자번호 중복 여부
					if (data == '0') {
						$('#BIZR_NUM_CHK_MSG').html("<span><font color='blue'>사용 가능한 사업자등록번호 입니다</font></span>");
						$('#BIZR_CHK_YN').val("Y");
					}else{
						$('#BIZR_NUM_CHK_MSG').html("<span><font color='red'>중복된 사업자등록번호 입니다</font></span>");
						$('#BIZR_CHK_YN').val("N");
					}
				}, error: function (jqXHR, textStatus, errorThrown) {
					alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
				}
			});
		}			
	});

    /* 저장
    $('.btnSave').click(function(){
    	// 회사번호
		var comTel1 = $('#TEL_NUM1').val();
		var comTel2 = $('#TEL_NUM2').val();
		var comTel3 = $('#TEL_NUM3').val();
		var comTel = comTel1+comTel2+comTel3;
		
		if(comTel.length > 7){
			comTel = comTel1+"-"+comTel2+"-"+comTel3;
		}
		$('#TEL_NUM').val(comTel);
		
		// 팩스번호
		var faxNum1 = $('#FAX_NUM1').val();
		var faxNum2 = $('#FAX_NUM2').val();
		var faxNum3 = $('#FAX_NUM3').val();
		var faxNum = faxNum1+faxNum2+faxNum3;
		
		if(faxNum.length > 7){
			faxNum = faxNum1+"-"+faxNum2+"-"+faxNum3;
		}
		$('#FAX_NUM').val(faxNum);
		
		// 사업자번호
		var strComBunb = $("#BIZR_NUM").val().replace(/-/gi, "");
		strComBunb = fn_comFormat(strComBunb);
		if(!strComBunb){
			alert("사업자번호를 확인해주세요.");
			return;
		}
		$("#BIZR_NUM").val(strComBunb);
		
		
    	if(!confirm("저장하시겠습니까?")) return;    	
		$("#supplierFrm").submit();
    });
	 */
});

/* 사업자번호 포멧 */
function fn_comFormat(num) {
	var formatNum = '';
	try{
		if (num.length == 10) {
			formatNum = num.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3');
		}
	} catch(e) {
		formatNum = num;
		console.log(e);
	}
	return formatNum;
}

/* SaveValidation */	
function fn_validation(){
	// 회사번호
	var comTel1 = $('#TEL_NUM1').val();
	var comTel2 = $('#TEL_NUM2').val();
	var comTel3 = $('#TEL_NUM3').val();
	var comTel = "";
	
	if(comTel1 && comTel2 && comTel3){
		comTel = comTel1+"-"+comTel2+"-"+comTel3;
	}
	$('#TEL_NUM').val(comTel);
	
	// 팩스번호
	var faxNum1 = $('#FAX_NUM1').val();
	var faxNum2 = $('#FAX_NUM2').val();
	var faxNum3 = $('#FAX_NUM3').val();
	var faxNum = "";
	
	if(faxNum1 && faxNum2 && faxNum3){
		faxNum = faxNum1+"-"+faxNum2+"-"+faxNum3;
	}
	$('#FAX_NUM').val(faxNum);
	
	// 사업자번호
	var strComBunb = $("#BIZR_NUM").val().replace(/-/gi, "");
	
	if(!strComBunb){
		alert("사업자번호를 확인해주세요.");
		return false;
	}
	
	strComBunb = fn_comFormat(strComBunb);
	$("#BIZR_NUM").val(strComBunb);
	
	if(!confirm("저장하시겠습니까?")) return false;
}
</script>

<!-- 사업자번호 중복체크 -->
<form id="bunbChkFrm" name="bunbChkFrm" action="${contextPath }/adm/supplierMgr/comBunbChk" method="post" autocomplete="off">
   <input type="hidden" id="BIZR_NUM_TMP" name="BIZR_NUM" />
</form>