<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		회원 관리
		<small>회원정보 등록</small>
	</h1>
</section>

<section class="content">
	<!-- form start -->
	<spform:form class="form-horizontal" name="customerFrm" id="customerFrm" method="post" action="${contextPath }/adm/memberMgr" onsubmit="return validatrion_submit(this);">
		<input type="hidden" name="pageNum" id="pageNum" value="${param.pageNum }" /> 
		<input type="hidden" name="rowCnt" id="rowCnt" value="${param.rowCnt }" /> 
		<input type="hidden" name="schGbn" id="schGbn" value="${param.schGbn }" />
		<input type="hidden" name="schTxt" id="schTxt" value="${param.schTxt }" />
		<input type="hidden" name="COM_CHK_YN" id="COM_CHK_YN" value="Y"/>
		<input type="hidden" name="COM_BUNB" id="COM_BUNB" value="${memberInfo.COM_BUNB }"/>
		<!-- 사용 안하는 컬럼 -->
		<input type="hidden" name="CAR_NUM" value="${ memberInfo.CAR_NUM }"/>
		<input type="hidden" name="AREA_GUBN" value="${ memberInfo.AREA_GUBN }"/>
		<%-- <input type="hidden" name="MBDC_RATE" value="${ memberInfo.MBDC_RATE }"/> --%>
	
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">개인정보 - 필수 입력</h3>
			</div>
			<!-- /.box-header -->
			<div class="box-body">
				<div class="form-group required">
					<label for="MEMB_GUBN" class="col-sm-2 control-label">회원구분</label>
					<div class="col-sm-9">
						<p class="form-control-static">
			                <jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="MEMB_GUBN" />
								<jsp:param name="name" value="MEMB_GUBN" />
								<jsp:param name="value" value="${ memberInfo.MEMB_GUBN }" />
								<jsp:param name="type" value="radio" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</p>
					</div>
				</div>
				
				<div class="form-group required">
					<label for="MEMB_ID" class="col-sm-2 control-label">아이디</label>
					<div class="col-sm-4">
						<c:if test="${ !empty memberInfo.MEMB_ID }">
							${memberInfo.MEMB_ID }
							<input type="hidden" name="MEMB_ID" value="${memberInfo.MEMB_ID }" />
							<input type="hidden" id="MEMB_CHK_YN" name="MEMB_CHK_YN" value="Y"/>
						</c:if>
						<c:if test="${ empty memberInfo.MEMB_ID }">
							<input type="text" class="form-control nHangul" name="MEMB_ID" id="MEMB_ID" value="" placeholder="영문자로 시작하는 5~16자의 숫자와 영문자 조합" required="required" minlength="5" maxlength="16"/> <!-- onblur="javascript:fn_idChk();" -->
							<input type="hidden" id="MEMB_CHK_YN" name="MEMB_CHK_YN" value="N"/>
						</c:if>
					</div>
					<div class="col-sm-4">
						<div id="ID_CHK_MSG"></div>
					</div>	
				</div>
				
				<div class="form-group required">
					<label for="MEMB_NAME" class="col-sm-2 control-label">이름</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="MEMB_NAME" id="MEMB_NAME" value="${memberInfo.MEMB_NAME }" placeholder="이름(대표자성명)" minlength="2" maxlength="15" required="required" />
					</div>
				</div>
				
				<c:if test="${ empty memberInfo.MEMB_ID }">					
				<div class="form-group required">
					<label for="MEMB_PW" class="col-sm-2 control-label">비밀번호</label>
					<div class="col-sm-4">
						<input type="password" class="form-control nHangul" id="MEMB_PW" name="MEMB_PW" value="" required="required"
						placeholder="숫자와 영문자 조합으로 5~20자리" minlength="5" maxlength="20"/> <!-- onblur="javascript:fnCheckPassword($('#MEMB_ID').val(),$('#MEMB_PW').val());" -->
					</div>
					<label for="MEMB_PW_CON" class="col-sm-1 control-label">비밀번호 확인</label>
					<div class="col-sm-4">
						<input type="password" class="form-control nHangul" id="MEMB_PW_CON" name="MEMB_PW_CON" value="" required="required"
						placeholder="숫자와 영문자 조합으로 5~20자리" minlength="5" maxlength="20"/> <!-- onchange="javascript:fnCfmPassword($('#MEMB_PW').val());" -->
					</div>
				</div>
				</c:if>
				<c:if test="${ !empty memberInfo.MEMB_ID }">					
				<div class="form-group">
					<label for="MEMB_PW" class="col-sm-2 control-label">비밀번호</label>
					<div class="col-sm-4">
						<input type="hidden" class="form-control nHangul" id="MEMB_PW" name="MEMB_PW" value="${memberInfo.MEMB_PW }" placeholder="비밀번호 변경시 입력해주세요. 숫자와 영문자 조합의 5~20자리" minlength="5" maxlength="20"/>
						<button type="button" class="btn btn-sm btn-danger btnReset">비밀번호 초기화</button>
					</div>
				</div>
				</c:if>
				
				<div class="form-group">
					<label for="MEMB_SEX" class="col-sm-2 control-label">성별</label>
					<div class="col-sm-9">
						<p class="form-control-static">
			                <jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="MEMB_SEX" />
								<jsp:param name="name" value="MEMB_SEX" />
								<jsp:param name="value" value="${ memberInfo.MEMB_SEX }" />
								<jsp:param name="type" value="radio" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</p>
					</div>
				</div>
				
				<div class="form-group">
					<label for="MEMB_BTDY" class="col-sm-2 control-label">생년월일</label>
					<div class="col-sm-4">
						<div class="input-group date">
							<div class="input-group-addon">
								<i class="fa fa-calendar"></i>
							</div>
							<input type="text" class="form-control pull-right" name="MEMB_BTDY" id="datepicker" value="${ empty memberInfo.MEMB_BTDY ? '19500101' : memberInfo.MEMB_BTDY }" required="required" >
						</div>
					</div>
					<div class="col-sm-5">
						<p class="form-control-static">
			                <jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="SLCAL_GUBN" />
								<jsp:param name="name" value="SLCAL_GUBN" />
								<jsp:param name="value" value="${ memberInfo.SLCAL_GUBN }" />
								<jsp:param name="type" value="radio" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</p>
					</div>
				</div>
				
				<div class="form-group required">
					<label for="MEMB_MAIL" class="col-sm-2 control-label">이메일</label>
					<div class="col-sm-4">
						<input type="text" class="form-control nHangul" id="MEMB_MAIL" name="MEMB_MAIL" value="${memberInfo.MEMB_MAIL }" placeholder="이메일주소" maxlength="40"/> <!-- onchange="chk_email($('#MEMB_MAIL').val())" required="required" -->
					</div>
				</div>
				
				<div class="form-group required">
					<input type="hidden" name="EXTRA_ADDR" id="EXTRA_ADDR" value="">
					<input type="hidden" name="ALL_ADDR" id="ALL_ADDR" value="">
					
					<label for="MEMB_PN" class="col-sm-2 control-label">주소</label>
					<div class="col-sm-2">
						<div class="input-group">
							<input type="text" class="form-control" id="MEMB_PN" name="MEMB_PN" value="${memberInfo.MEMB_PN }" placeholder="우편번호" maxlength="6" required="required" readonly/>
							<span class="input-group-btn">
								<button type="button" class="btn btn-default"
								onclick="win_zip('customerFrm', 'MEMB_PN', 'MEMB_BADR', 'MEMB_DADR', 'EXTRA_ADDR', 'ALL_ADDR');">주소검색</button>
							</span>
						</div>
					</div>
				</div>
				
				<div class="form-group required">
					<label for="MEMB_BADR" class="col-sm-2 control-label"></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="MEMB_BADR" name="MEMB_BADR" value="${memberInfo.MEMB_BADR }" placeholder="기본주소" maxlength="100" required="required" readonly/>
					</div>
				</div>
				
				<div class="form-group required">
					<label for="MEMB_DADR" class="col-sm-2 control-label"></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="MEMB_DADR" name="MEMB_DADR" value="${memberInfo.MEMB_DADR }" placeholder="상세주소" maxlength="100" required="required" >
					</div>
				</div>
				
				<div class="form-group required">
					<label for="MEMB_CPON" class="col-sm-2 control-label">휴대전화</label>
					<div class="col-sm-4">
						<input type="hidden" class="form-control" id="MEMB_CPON" name="MEMB_CPON" value="${memberInfo.MEMB_CPON }">
						<input type="tel" class="form-control onlyNum" name="MEMB_CPON1" id="MEMB_CPON1" value="${fn:split(memberInfo.MEMB_CPON,'-')[0]}" required style="width:60px; display: inline-block;" maxlength="3">&nbsp;-&nbsp;
						<input type="tel" class="form-control onlyNum" name="MEMB_CPON2" id="MEMB_CPON2" value="${fn:split(memberInfo.MEMB_CPON,'-')[1]}" required style="width:60px; display: inline-block;" maxlength="4">&nbsp;-&nbsp;
						<input type="tel" class="form-control onlyNum" name="MEMB_CPON3" id="MEMB_CPON3" value="${fn:split(memberInfo.MEMB_CPON,'-')[2]}" required style="width:60px; display: inline-block;" maxlength="4">
					</div>
					
					<label for="MEMB_TELN" class="col-sm-1 control-label">전화번호</label>
					<div class="col-sm-4">
						<input type="hidden" class="form-control" name="MEMB_TELN" id="MEMB_TELN" value="${memberInfo.MEMB_TELN }" >
						<input type="tel" class="form-control onlyNum" name="MEMB_TELN1" id="MEMB_TELN1" value="${fn:split(memberInfo.MEMB_TELN,'-')[0]}" style="width:60px; display: inline-block;" maxlength="3">&nbsp;-&nbsp;
						<input type="tel" class="form-control onlyNum" name="MEMB_TELN2" id="MEMB_TELN2" value="${fn:split(memberInfo.MEMB_TELN,'-')[1]}" style="width:60px; display: inline-block;" maxlength="4">&nbsp;-&nbsp;
						<input type="tel" class="form-control onlyNum" name="MEMB_TELN3" id="MEMB_TELN3" value="${fn:split(memberInfo.MEMB_TELN,'-')[2]}" style="width:60px; display: inline-block;" maxlength="4">
					</div>
				</div>
				
				<div class="form-group">
					<label for="MEMB_TELN" class="col-sm-2 control-label">은행명</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="BANK_NAME" value="${memberInfo.BANK_NAME }" placeholder="은행명" maxlength="15">
					</div>
					<label for="MEMB_TELN" class="col-sm-1 control-label">통장번호</label>
					<div class="col-sm-4">
						<input type="tel" class="form-control onlyNum" name="BANK_BUNB" value="${memberInfo.BANK_BUNB }" placeholder="-를 제외하고 적어주세요" maxlength="50">
					</div>
				</div>
		<%-- 		
				<div class="form-group">
					<label for="DLVY_CPON" class="col-sm-2 control-label" >배송쿠폰</label>
					<div class="col-sm-2" style="width:10%; min-width:150px;">
						<div class="input-group">
							<span class="input-group-btn">
								<button type="button" class="btn btn-primary btnQty">-</button>
							</span>
							<input type="text" class="form-control txt-middle onlyNum" name="DLVY_CPON" id="DLVY_CPON" maxlength="3"
								value="<fmt:formatNumber value="${ memberInfo.DLVY_CPON eq null ? 0 : memberInfo.DLVY_CPON }" pattern="###"/>">
							<span class="input-group-btn">
								<button type="button" class="btn btn-primary btnQty">+</button>
							</span>
						</div>
					</div>
				</div> --%>
				
				<div class="form-group">						
					<label for="MEMB_STAT" class="col-sm-2 control-label">* 회원상태</label>
					<c:if test="${ empty memberInfo.MEMB_ID || memberInfo.SCSS_YN eq 'N' }">
						<div class="col-sm-4">
							<label class="radio-inline">
		                  		<input type="radio" name="STOP_YN" value="N" ${ memberInfo.STOP_YN eq 'N' or empty memberInfo.STOP_YN ? 'checked' : '' } onclick="fn_memb_state()" required />활동
			               	</label>
			               	<label class="radio-inline">
			                  	<input type="radio" name="STOP_YN" value="Y" ${ memberInfo.STOP_YN eq 'Y' ? 'checked' : '' } onclick="fn_memb_state()" required >일시중지
			               	</label>			               	
		               	</div>
	               	</c:if>
	               	<c:if test="${ !empty memberInfo.MEMB_ID && memberInfo.SCSS_YN eq 'Y' }">
	               		<div class="col-sm-4">
	               			<label class="radio-inline">
	                  			<input type="radio" name="SCSS_YN" value="N" ${ memberInfo.SCSS_YN eq 'N' ? 'checked' : '' } onclick="fn_memb_state()" required />활동
		               		</label>
			               	<label class="radio-inline">
			                  	<input type="radio" name="SCSS_YN" value="Y" ${ memberInfo.SCSS_YN eq 'Y' ? 'checked' : '' } onclick="fn_memb_state()" required >탈퇴
			               	</label>
			            </div>
		            </c:if>
		            
	               	<label for="MEMB_STAT" class="col-sm-1 control-label">활동중지일자</label>
	               	<div class="col-sm-4" id="STDT_SHOW">
						<div class="input-group date">
							<div class="input-group-addon">
								<i class="fa fa-calendar"></i>
							</div>
							<input type="text" id="STOP_DTM" name="STOP_DTM" class="form-control pull-right" value="${memberInfo.STOP_DTM }" required="required" readonly>
						</div>
					</div>
				</div>
				
			</div>
			<!-- /.box-body -->
		</div>
	
		<div class="box box-info" id="ERP_LIST">
			<div class="box-header with-border">
				<c:choose>
					<c:when test="${memberInfo.MEMB_GUBN == 'MEMB_GUBN_04' }">
						<h3 class="box-title">조합원정보 - 조합원정보 입력</h3>
					</c:when>
					<c:otherwise>
						<h3 class="box-title">회사정보 - 사업자회원 입력</h3>
					</c:otherwise>
				</c:choose>
			</div>				
			<!-- box-body -->
			<div class="box-body">
				<div class="form-group">
					<label for="COM_NAME" class="col-sm-2 control-label">* 상호명</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="COM_NAME" name="COM_NAME" value="${memberInfo.COM_NAME }" placeholder="상호명" maxlength="50"/>
					</div>		
				</div>
				
				<div class="form-group">
					<c:choose>
						<c:when test="${memberInfo.MEMB_GUBN == 'MEMB_GUBN_04' }">
							<label for="COM_BUNB" class="col-sm-2 control-label">* 조합원번호</label>
							<div class="col-sm-4">
								<input type="tel" class="form-control onlyNum" id="CACOOP_NO" name="CACOOP_NO" value="${memberInfo.CACOOP_NO }" placeholder="-를 제외하고 적어주세요" maxlength="10"/> <!-- onblur="javascript:fn_bunbChk();" -->
							</div>
							<div class="col-sm-4">
	                    		<div id="COM_BUNB_CHK_MSG"></div>
							</div>
						</c:when> 
						<c:otherwise>
							<label for="COM_BUNB" class="col-sm-2 control-label">* 사업자등록번호</label>
							<div class="col-sm-4">
								<input type="tel" class="form-control onlyNum" id="COM_BUNB" name="COM_BUNB" value="${memberInfo.COM_BUNB }" placeholder="-를 제외하고 적어주세요" maxlength="10"/> <!-- onblur="javascript:fn_bunbChk();" -->
							</div>
							<div class="col-sm-4">
	                	    	<div id="COM_BUNB_CHK_MSG"></div>
							</div>
						</c:otherwise>
					</c:choose>		
				</div>
				
				<div class="form-group">
					<input type="hidden" name="COM_EXTRA_ADDR" id="COM_EXTRA_ADDR" value="">
					<input type="hidden" name="COM_ALL_ADDR" id="COM_ALL_ADDR" value="">
					
					<label for="COM_PN" class="col-sm-2 control-label">회사 주소</label>
					<div class="col-sm-2">
						<div class="input-group">
							<input type="text" class="form-control" id="COM_PN" name="COM_PN" value="${memberInfo.COM_PN }" placeholder="우편번호" maxlength="6" readonly/>
							<span class="input-group-btn">
								<button type="button" class="btn btn-default"
											onclick="win_zip('customerFrm', 'COM_PN', 'COM_BADR', 'COM_DADR', 'COM_EXTRA_ADDR', 'COM_ALL_ADDR');">주소검색</button>
							</span>
						</div>
					</div>
					<label class="col-sm-2 pull-left"><input type="checkbox" id="sameChk"/> 개인정보와 동일</label>
				</div>
				
				<div class="form-group">
					<label for="COM_BADR" class="col-sm-2 control-label"></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="COM_BADR" name="COM_BADR" value="${memberInfo.COM_BADR }" placeholder="회사기본주소" maxlength="100" readonly/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="COM_DADR" class="col-sm-2 control-label"></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="COM_DADR" name="COM_DADR" value="${memberInfo.COM_DADR }" placeholder="회사상세주소" maxlength="100">
					</div>
				</div>
				
				<div class="form-group">
					<label for="COM_TELN" class="col-sm-2 control-label">회사연락처</label>
					<div class="col-sm-4">
						<input type="hidden" name="COM_TELN" id="COM_TELN" value="${memberInfo.COM_TELN }">
						<input type="tel" class="form-control onlyNum" name="COM_TELN1" id="COM_TELN1" value="${fn:split(memberInfo.COM_TELN,'-')[0]}" style="width:60px; display: inline-block;" maxlength="3">&nbsp;-&nbsp;
						<input type="tel" class="form-control onlyNum" name="COM_TELN2" id="COM_TELN2" value="${fn:split(memberInfo.COM_TELN,'-')[1]}" style="width:60px; display: inline-block;" maxlength="4">&nbsp;-&nbsp;
						<input type="tel" class="form-control onlyNum" name="COM_TELN3" id="COM_TELN3" value="${fn:split(memberInfo.COM_TELN,'-')[2]}" style="width:60px; display: inline-block;" maxlength="4">
					</div>
				</div>
				
				<%-- <div class="form-group">
					<label for="COM_OPEN" class="col-sm-2 control-label">매장 개점시간</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="COM_OPEN" data-inputmask='"mask": "99:99"' data-mask value="${memberInfo.COM_OPEN }">
					</div>
					<label for="COM_CLOSE" class="col-sm-1 control-label">매장 폐점시간</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="COM_CLOSE" data-inputmask='"mask": "99:99"' data-mask value="${memberInfo.COM_CLOSE }">
					</div>
				</div> --%>
				
				<%-- <div class="form-group">
					<label for="KEEP_LOCATION" class="col-sm-2 control-label">상품보관장소</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" name="KEEP_LOCATION" value="${memberInfo.KEEP_LOCATION }" placeholder="상품보관장소" maxlength="120">
					</div>
				</div> --%>
				
				<%-- <div class="form-group">
					<label for="CAR_NUM" class="col-sm-2 control-label">차량번호</label>
					<div class="col-sm-4">
						<p class="form-control-static">
			                <jsp:include page="/common/comCodForm">
								<jsp:param name="COMM_CODE" value="CAR_NUM" />
								<jsp:param name="name" value="CAR_NUM" />
								<jsp:param name="value" value="${ memberInfo.CAR_NUM }" />
								<jsp:param name="type" value="select" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</p>
					</div>
					<label for="ADM_REF" class="col-sm-1 control-label">지역코드</label>
					<div class="col-sm-4">
						<select name="AREA_GUBN" class="form-control select2" style="width: 100%;">
							<option value="" <c:if test='${memberInfo.AREA_GUBN eq null || memberInfo.AREA_GUBN eq "" }'>selected="selected"</c:if>>선택</option>								
							<c:forEach items="${areaList }" var="area" varStatus="sta">
								<option value="${area.COMD_CODE }" <c:if test='${memberInfo.AREA_GUBN eq area.COMD_CODE }'> selected="selected"</c:if>>
									${area.COMDCD_NAME }
								</option>
							</c:forEach>
						</select>
					</div>
				</div> --%>
				<div class="form-group">
					<label for="ADM_REF" class="col-sm-2 control-label">관리자 참조설명</label>
					<div class="col-sm-9">
						<textarea name="ADM_REF" class="form-control" rows="6" cols="100" placeholder="비고" >${memberInfo.ADM_REF }</textarea>
					</div>
				</div>
				
				<div class="form-group">
					<label for="TAXCAL_YN" class="col-md-2 control-label">* 세금계산서</label>
					<div class="col-sm-4">
						<p class="form-control-static">
							<label class="check" style="margin-right:10px">
								<input type="radio" class="iradio" name="TAXCAL_YN" value="Y" 
									<c:if test="${memberInfo.TAXCAL_YN eq 'Y' || empty memberInfo.TAXCAL_YN }">checked</c:if> /> 발행
							</label>
							<label class="check" style="margin-right:10px">
								<input type="radio" class="iradio" name="TAXCAL_YN" value="N" 
									<c:if test="${memberInfo.TAXCAL_YN eq 'N'}">checked</c:if> /> 미발행
							</label>
						</p>
					</div>
					
					<label for="MONTH_YN" class="col-md-1 control-label">* 월간결제</label>
					<div class="col-sm-4">
						<p class="form-control-static">
			                <jsp:include page="${contextPath }/common/comCodForm">
								<jsp:param name="COMM_CODE" value="COMM_YN" />
								<jsp:param name="name" value="MONTH_YN" />
								<jsp:param name="value" value="${ memberInfo.MONTH_YN }" />
								<jsp:param name="type" value="radio" />
								<jsp:param name="top" value="선택" />
							</jsp:include>
						</p>
					</div>
				</div>
				<%-- 
				<div class="form-group">				
					<label for="MBDC_RATE" class="col-md-2 control-label">회원할인</label>
					<div class="col-sm-1">
						<div class="input-group">
							<input type="text" class="form-control txt-right right-5" name="MBDC_RATE" id="MBDC_RATE" onkeydown="return onlyNumber(this)"  
									  value="<fmt:formatNumber value="${ memberInfo.MBDC_RATE eq null ? 0 : memberInfo.MBDC_RATE }" pattern="###"/>" maxlength="3">
							<div class="input-group-addon">%</div>
						</div>
					</div>
				</div>
				--%>
			</div>
			<!-- /.box-body -->			
		</div>

		<!-- this row will not appear when printing -->
		<div class="row">
			<div class="col-xs-12">
				<!-- 활동회원 -->
				<c:if test="${ !empty memberInfo.MEMB_ID && memberInfo.SCSS_YN ne 'Y' }">
					<a href="${contextPath}/adm/memberMgr?&pageNum=${param.pageNum }&rowCnt=${param.rowCnt }${link}" class="btn btn-default pull-right"><i class="fa fa-list"></i> 목록</a>						
					<button type="submit" class="btn btn-primary pull-right right-5">
						<i class="fa fa-save"></i> 저장
					</button>
					<button type="button" class="btn btn-danger pull-right right-5 btnSec">
						<i class="fa fa-sign-out"></i> 탈퇴
					</button>
				</c:if>
				
				<!-- 탈퇴회원 -->
				<c:if test="${ !empty memberInfo.MEMB_ID && memberInfo.SCSS_YN eq 'Y' }">						
					<a href="${contextPath}/adm/memberScssMgr?&pageNum=${param.pageNum }&rowCnt=${param.rowCnt }${link}" class="btn btn-default pull-right"><i class="fa fa-list"></i> 목록</a>
					<!-- <button type="submit" class="btn btn-primary right-5 pull-right">
						<i class="fa fa-save"></i> 저장
					</button> -->
					<button type="button" class="btn btn-danger pull-right right-5 btnDel">
						<i class="fa fa-sign-out"></i> 영구삭제
					</button>
				</c:if>
				
				<!-- 신규등록 -->
				<c:if test="${ empty memberInfo.MEMB_ID}">
					<a href="${contextPath}/adm/memberMgr?&pageNum=${param.pageNum }&rowCnt=${param.rowCnt }${link}" class="btn btn-default pull-right"><i class="fa fa-list"></i> 목록</a>
					<button type="submit" class="btn btn-primary right-5 pull-right">
						<i class="fa fa-save"></i> 저장
					</button>
				</c:if>
			</div>
		</div>
	</spform:form>
	<!-- /.box -->
</section>

<script>
	$(function(){
		/*  회원구분 */
		fn_memb_gubn();
		
		/* 회원상태 */
		<c:if test = "{!empty memberInfo.STOP_YN || memberInfo.STOP_YN != ''}" >	
			$('input:radio[name=STOP_YN]:input[value="N"]').prop("checked", true);
		</c:if>
		
		/* 매장 운영시간 */
		<c:if test="${!empty memberInfo.COM_OPEN }">
			$('#COM_OPEN_HH').val('${memberInfo.COM_OPEN_HH }');
			$('#COM_OPEN_MM').val('${memberInfo.COM_OPEN_MM }');
		</c:if>
		<c:if test="${!empty memberInfo.COM_CLOSE }">
			$('#COM_CLOSE_HH').val('${memberInfo.COM_CLOSE_HH }');
			$('#COM_CLOSE_MM').val('${memberInfo.COM_CLOSE_MM }');
		</c:if>
		
		/* Date picker */
		$('#datepicker').datepicker({
			autoclose: true,
			format: 'yyyymmdd'
		});
		$('#datepicker_stdt').datepicker({
			autoclose: true,
			format: 'yyyymmdd'
		});
		
	    /* Money Euro */
	    $("[data-mask]").inputmask();
	    
	    /* 탈퇴 */
	    $('.btnSec').click(function(){
	    	if(!confirm("탈퇴하시면 7일이내 재가입이 불가능합니다. 탈퇴하시겠습니까?")) return;
			$("#customerFrm").attr("action","${contextPath }/adm/memberMgr/delete");
			$("#customerFrm").submit();
	    });
	    
	    /* 영구탈퇴 */
	    $('.btnDel').click(function(){
	    	if(!confirm("영구삭제하시면 복구가 불가능합니다. 진행하시겠습니까?")) return;
			$("#customerFrm").attr("action","${contextPath }/adm/memberMgr/delete2");
			$("#customerFrm").submit();
	    });
		
		/* 사업자회원 선택시 사업자정보 필수입력 */
		$("input:radio[name=MEMB_GUBN]").click(function(){	    
			fn_memb_gubn();
		});
		
		/* 아이디 중복 체크 */
		$("#MEMB_ID").change(function(){
			var strMembId = $(this).val();
			$("#MEMB_ID_TMP").val(strMembId);
			
			if(!strMembId){
			   //alert("아이디를 입력해 주세요");
			   return;
			}
			
			$.ajax({
				type: "POST",
				url: "${contextPath}/idChk",
				data: $("#idChkFrm").serialize(),
				success: function (data) {
					var strMembIdTrim = strMembId.trim();
					var re = /\s/g;
					var special_pattern = /[,.`~!@#$%^&*|\\\'\";:\/?]/gi;
					var eng = /^[a-z]+[a-zA-Z0-9]{4,15}$/g;
					
					if(strMembId != strMembIdTrim || re.test(strMembId)){
						$('#ID_CHK_MSG').html("<span><font color='red'>아이디에 공백이 들어갈 수 없습니다</font></span>");
						$('#MEMB_CHK_YN').val("N");
						
					} else if(special_pattern.test(strMembId)) {
						$('#ID_CHK_MSG').html("<span><font color='red'>아이디에 특수문자가 들어갈 수 없습니다</font></span>");
						$('#MEMB_CHK_YN').val("N");
						
					} else if(!eng.test(strMembId)) { 
						$('#ID_CHK_MSG').html("<span><font color='red'>아이디는 영문자로 시작하는 5~16자 영문자 또는 숫자이어야 합니다</font></span>");
						$('#MEMB_CHK_YN').val("N");

					} else{
						// 아이디 중복 여부
						if (data == '0') {
							$('#ID_CHK_MSG').html("<span><font color='blue'>사용 가능한 아이디</font></span>");
							$('#MEMB_CHK_YN').val("Y");
						}else{
							$('#ID_CHK_MSG').html("<span><font color='red'>중복된 아이디</font></span>");
							$('#MEMB_CHK_YN').val("N");
						}
					}
				}, error: function (jqXHR, textStatus, errorThrown) {
					alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
				}
			});
		});
		
		/* 비밀번호 조합 체크 */
		$("#MEMB_PW").change(function(){
			var uid = $("#MEMB_ID").val();
			var upw = $(this).val();
			
			if(upw != ""){
				var chk_num = upw.search(/[0-9]/g); 
				var chk_eng = upw.search(/[a-z]/ig);
				
				if(!/^[a-zA-Z0-9]{5,20}$/.test(upw)) { 
					alert('비밀번호는 숫자와 영문자 조합으로 5~20자리를 사용해야 합니다.'); 
					$(this).val('');
					$(this).focus();
					return;
				}
				
				if((chk_num < 0 || chk_eng < 0)) { 
					alert('비밀번호는 숫자와 영문자를 혼용하여야 합니다.'); 
					$(this).val('');
					$(this).focus();
					return;
				}
				
				if(/(\w)\1\1\1/.test(upw)) {
					alert('비밀번호에 같은 문자를 4번 이상 사용하실 수 없습니다.'); 
					$(this).val('');
					$(this).focus();
					return;
				}
				
				if(upw.includes(uid)) {
					alert('ID가 포함된 비밀번호는 사용하실 수 없습니다.'); 
					$(this).val('');
					$(this).focus();
					return;
				}
			}
		});
		
		/* 비밀번호 확인 체크 */
		$("#MEMB_PW_CON").change(function(){
			var reupw = $(this).val();
			var upw = $('#MEMB_PW').val();
			
			if (reupw != upw && upw != ''){
				alert('비밀번호가 일치하지 않습니다. 비밀번호를 확인해주세요.');
				$(this).val('');
				$(this).focus();
				return;
			}			
		});
		
		/* 사업자번호 중복 체크 */
		$("#COM_BUNB").change(function(){
			var strComBunb = $(this).val().replace(/-/gi, "");
			
			if(strComBunb.length < 1){
				$('#COM_CHK_YN').val("N");
				return;
			}
			
			if(strComBunb.length != 10){
				$('#COM_BUNB_CHK_MSG').html("<span><font color='red'>사업자등록번호 자릿수를 확인해 주세요</font></span>");
				$('#COM_CHK_YN').val("N");
				
			}else{
				//var strComBunbSub = strComBunb.substring(0,3)+"-"+strComBunb.substring(3,5)+"-"+strComBunb.substring(5,10);
				$("#COM_BUNB_TMP").val(strComBunb);

			 	$.ajax({
			 		type:"POST",
			        url:"${contextPath }/comBunbChk",
					data: $("#bunbChkFrm").serialize(),
					success: function (data){
						// 사업자번호 중복 여부
						if (data == '0') {
							$('#COM_BUNB_CHK_MSG').html("<span><font color='blue'>사용 가능한 사업자등록번호</font></span>");
							$('#COM_CHK_YN').val("Y");
						}else{
							$('#COM_BUNB_CHK_MSG').html("<span><font color='red'>중복된 사업자등록번호</font></span>");
							$('#COM_CHK_YN').val("N");
						}
					}, error: function (jqXHR, textStatus, errorThrown) {
						alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
					}
				});
			}			
		});
		
		/* 개인정보와 동일 */
		$("#sameChk").click(function(){
			if($('#sameChk').prop('checked')==true){ 
				$('#COM_PN').val($('#MEMB_PN').val());
				$('#COM_BADR').val($('#MEMB_BADR').val());
				$('#COM_DADR').val($('#MEMB_DADR').val());
			}else{
				$('#COM_PN').val('');
				$('#COM_BADR').val('');
				$('#COM_DADR').val('');
			}
		});
		
		/* 숫자만 입력 */
		$(".onlyNum").keydown(function(){
			$(this).keyup(function(){
				$(this).val($(this).val().replace(/[^0-9]/g,""));
			});
		});
		
		/* 이메일 형식 체크 */
		/* $("#MEMB_MAIL").change(function(){
			if(!$(this).val()) return;
			
			if(!chk_email($(this).val())){
				alert("e-mail 형식이 아닙니다.");
				$(this).focus();
				return;
			}
		}); */
		
		/* 한글입력 안되게 처리 */
		$(".nHangul").keydown(function(){
			$(this).keyup(function(){
				$(this).val( $(this).val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ).trim() );
			});
		});
		
	    /* 쿠폰 수량변경 */
		$('.btnQty').click(function(){
			var mode = $(this).text();
	        var this_qty, max_qty = 999, min_qty = 0;
			var $el_qty = $('#DLVY_CPON').val();	//.replace(/[^0-9]/, ""));			
	        
			if($.isNumeric($el_qty) == false){
				$el_qty = 0;
			}
			
	        switch(mode) {
	            case "+":
	                this_qty = parseInt($el_qty) + 1;
	                if(this_qty > max_qty) {
	                    this_qty = max_qty;
	                    alert("최대수량은 "+number_format(String(max_qty))+" 입니다.");
	                }	                
	                $('#DLVY_CPON').val(this_qty);
	                break;

	            case "-":
	                this_qty = parseInt($el_qty) - 1;	                
	                if(this_qty < min_qty) {
	                    this_qty = min_qty;
	                    alert("최소수량은 "+number_format(String(min_qty))+" 입니다.");
	                }	                
	                $('#DLVY_CPON').val(this_qty);
	                break;

	            default:
	                alert("올바른 방법으로 이용해 주십시오.");
	                break;
			}
	    });
		
		/* 비밀번호 초기화 */
		$(".btnReset").click(function(){
			if(!confirm("비밀번호를 초기화하시겠습니까?")) return;
			
			// 초기비밀번호 : 아이디
			var userId = $("input[name=MEMB_ID]").val();
			console.log(userId);
			
			$.ajax({
				type: 'POST',
				dataType: 'json',
				data: { "MEMB_ID": userId },
				url: '${contextPath }/adm/memberMgr/passInit.json',
				success: function (data) {
					console.log(data);
					alert("비밀번호가 초기화 되었습니다. \n(초기비밀번호 : 아이디)");
				},
				error:function(request,status,error){
				     console.log('error : '+error+"\n"+"code : "+request.status+"\n");
				}
			});
		});
		
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
		
	/* email체크 함수 */
	function chk_email(strEmail) {
		/* 
		 * 이메일의 값은 단순히 문자이며, 이것을 객체화시켜서 비교한다.
		 * ^는 반드시 이런형식으로 시작하라 $는 반드시 요런형식으로 종료
		 * {3,20} 3~20글자만쓸수있다.
		 */
		var em = strEmail;
		var epattern = new RegExp("^([a-zA-Z0-9\-\_]{3,20})" + "@" + "([a-zA-Z0-9\-\_]{3,20})" + "." + "([a-zA-Z0-9\-\_\.]{3,5})$");
	   
	   if (!epattern.test(em)) {
		   alert("e-mail 형식이 아닙니다.");
		   
		   //focus시 chrome에서 무한루프 해결
	       setTimeout(function(){
	       		$("#MEMB_MAIL").focus();
	       }, 10)	      
	      
	      return false;
	   }
	   return true;
	}
	
	/* SaveValidation */	
	function validatrion_submit(){
		// 휴대폰번호
		var membMobile = null;
		var membMobile1 = $('#MEMB_CPON1').val();
		var membMobile2 = $('#MEMB_CPON2').val();
		var membMobile3 = $('#MEMB_CPON3').val();
		
		if(membMobile1 != "" && membMobile2 != "" && membMobile3 != ""){
			membMobile = membMobile1+"-"+membMobile2+"-"+membMobile3;
			
		}else if(membMobile.length < 1){
			alert("휴대폰번호를 입력해주세요." + $('#MEMB_CPON').val());
			$("#MEMB_CPON").focus();
			return false;
		}
				   
		$('#MEMB_CPON').val(membMobile);
		
		// 전화번호
		var membPhone = null;
		var membPhone1 = $('#MEMB_TELN1').val();
		var membPhone2 = $('#MEMB_TELN2').val();
		var membPhone3 = $('#MEMB_TELN3').val();
		
		if(membPhone1 != "" && membPhone2 != "" && membPhone3 != ""){
			membPhone = membPhone1+"-"+membPhone2+"-"+membPhone3;
		} 
		
		$('#MEMB_TELN').val(membPhone);
		
		// 아이디 체크
		if($('#MEMB_CHK_YN').val() == "N"){
			alert("아이디를 확인해주세요");
			$("#MEMB_ID").focus();
			return false;
		}
		
		// 비밀번호 확인
		if(!$("#MEMB_PW").val()){
			alert("비밀번호를 입력해주세요.");
			$("#MEMB_PW").focus();
			return false;
		}
		
		// 회원 주소 체크
		if(!$('#MEMB_PN').val()){
			alert("우편번호와 주소는 필수값입니다.");
			return false;
		}

		// 이메일 체크
		/* if(!chk_email($("#MEMB_MAIL").val())){
			alert("e-mail 형식이 아닙니다.");
			$("#MEMB_MAIL").focus();
			return false;
		} */
		
		
		//사업자일 경우 필수값 체크
		if(!($('#ERP_LIST').css("display")=="none")){
			// 사업자번호 중복체크
			if($('#COM_CHK_YN').val() == "N"){
				alert("사업자등록번호를 확인해주세요.");
				$("#COM_BUNB").focus();
				return false;
			}
			
			var strComBunb = $("#COM_BUNB").val().replace(/-/gi, "");
			strComBunb = fn_comFormat(strComBunb);
			$("#COM_BUNB").val(strComBunb);

			// 회사번호 체크
			var comTel1 = $('#COM_TELN1').val();
			var comTel2 = $('#COM_TELN2').val();
			var comTel3 = $('#COM_TELN3').val();
			console.log("전화번호값"+comTel1,comTel2,comTel3);
			
			if(!comTel1 && !comTel2 && !comTel3){
				comTel = comTel1+"-"+comTel2+"-"+comTel3;
				$('#COM_TELN').val(comTel);
			} 
			
			
			//매장 개점시간, 폐점시간
			$('#COM_OPEN').val($('#COM_OPEN_HH').val()+":"+$('#COM_OPEN_MM').val());
			$('#COM_CLOSE').val($('#COM_CLOSE_HH').val()+":"+$('#COM_CLOSE_MM').val());
		}
		
	 	// 일반회원 선택시 사업자정보 초기화
		if($('input:radio[name="MEMB_GUBN"]:checked').val()=='MEMB_GUBN_01'){
			$('#COM_NAME').val('');
			$('#COM_BUNB').val('');
			$('#COM_TELN').val('');
			$('#COM_EXTRA_ADDR').val('');
			$('#COM_ALL_ADDR').val('');
			$('#COM_PN').val('');
			$('#sameChk').val('');
			$('#COM_BADR').val('');
			$('#COM_DADR').val('');
			$('#COM_OPEN_HH').val('');
			$('#COM_OPEN_MM').val('');
			$('#COM_OPEN').val('');
			$('#COM_CLOSE_HH').val('');
			$('#COM_CLOSE_MM').val('');
			$('#COM_CLOSE').val('');
			$('#KEEP_LOCATION').val('');	
		}  
	}
 
	/* 회원상태 */
	function fn_memb_state(){
		var d = new Date();			 
		var date = d.yyyymmddhhmmss();	//현재일자
		
		if($('input:radio[name="STOP_YN"]:checked').val()=='Y'){
			$('#STDT_SHOW').show();
			$('#STOP_YN').attr("required","");
			$('#STOP_DTM').val(date);			
		}else{
			$('#STDT_SHOW').hide();
			$('#STOP_YN').removeAttr("required");
			$('#STOP_DTM').val('');
		}
		
		if($('input:radio[name="SCSS_YN"]:checked').val()=='Y'){
			$('#STDT_SHOW').show();
			$('#STOP_YN').attr("required","");
			$('#STOP_DTM').val(date);
		}
	}
	
	/* 회원구분 */
	function fn_memb_gubn(){
		if($("input:radio[name=MEMB_GUBN]:checked").val()=='MEMB_GUBN_02' 
	    	||$("input:radio[name=MEMB_GUBN]:checked").val()=='MEMB_GUBN_04'){
	    	
	    	$('#ERP_LIST').show();
	    	$('#COM_NAME').attr("required","");
			$('#COM_BUNB').attr("required","");
	    }else{
	    	$('#ERP_LIST').hide();
	    	$('#COM_NAME').removeAttr("required");
			$('#COM_BUNB').removeAttr("required");
	    }
	}
	
	/* 현재일자 format */
	Date.prototype.yyyymmddhhmmss = function(){		
	    var yyyy = this.getFullYear().toString();
	    var MM = (this.getMonth() + 1).toString();
	    var dd = this.getDate().toString();
	    /* 
	    var HH = this.getHours();
	    var mm = this.getMinutes();
	    var ss = this.getSeconds();
	     */
	    return yyyy + (MM[1] ? MM : '0'+MM[0]) + (dd[1] ? dd : '0'+dd[0]);
	    		/* + [(HH>9 ? '' : '0') + HH, (mm>9 ? '' : '0') + mm, (ss>9 ? '' : '0') + ss, ].join(''); */
	}


	// ===2020.04.20 chjw 사용안함===	
	/* 비밀번호 체크 */
	function fnCheckPassword(uid, upw){
	    if(!/^[a-zA-Z0-9]{5,20}$/.test(upw)&&!(upw=="")){ 
	        alert('비밀번호는 숫자와 영문자 조합으로 5~12자리를 사용해야 합니다.'); 
	        $('#MEMB_PW').val('');
	        $('#MEMB_PW').focus();
	       
	        return false;
	    }
	  
	    var chk_num = upw.search(/[0-9]/g); 
	    var chk_eng = upw.search(/[a-z]/ig);

	    if((chk_num < 0 || chk_eng < 0) &&!(upw=="")){ 
	        alert('비밀번호는 숫자와 영문자를 혼용하여야 합니다.'); 
	        $('#MEMB_PW').val('');
	        $('#MEMB_PW').focus();
	        
	        return false;
	    }	    
	    if(/(\w)\1\1\1/.test(upw) &&!(upw=="")){
	        alert('비밀번호에 같은 문자를 4번 이상 사용하실 수 없습니다.'); 
	        $('#MEMB_PW').val('');
	        $('#MEMB_PW').focus();
	        
	        return false;
	    }
	    if(upw.search(uid)>-1 &&!(upw=="")){
	        alert('ID가 포함된 비밀번호는 사용하실 수 없습니다.'); 
	        $('#MEMB_PW').val('');
	        $('#MEMB_PW').focus();
	        
	        return false;
	    }

	    return true;
	}
	
	/* 비밀번호 확인 */
	function fnCfmPassword(upw){
		if (upw != $('#MEMB_PW_CON').val() && $('#MEMB_PW_CON').val() != ''){
			alert('비밀번호가 일치하지 않습니다.'); 
	        $('#MEMB_PW_CON').val('');
	        
	        //focus시 chrome에서 무한루프 해결
	        setTimeout(function(){
	        	$('#MEMB_PW_CON').focus();
	        }, 10)
	        return false;
		}		
		return true;
	}
	
	/* 아이디 중복확인 */	
	function fn_idChk(){
		
	   var strMembId = $("#MEMB_ID").val();
	   $("#MEMB_ID_TMP").val(strMembId);
	   
	   if(strMembId == ""){
	      alert("아이디를 입력해 주세요");
	      return false;
	   }
	   
	   $.ajax({
	      type: "POST",
	      url: "${contextPath}/idChk",
	      data: $("#idChkFrm").serialize(),
	      success: function (data) {
	
	         var strMembIdTrim = strMembId.trim();
	         var re = /\s/g;
	         var special_pattern = /[,.`~!@#$%^&*|\\\'\";:\/?]/gi;
	         
	      	 if(strMembId != strMembIdTrim || re.test(strMembId)){
	            $('#ID_CHK_MSG').html("<span><font color='red'>아이디에 공백이 들어갈 수 없습니다</font></span>");
	            $('#MEMB_CHK_YN').val("N");
	         } else if(special_pattern.test(strMembId)) {
	        	 $('#ID_CHK_MSG').html("<span><font color='red'>아이디에 특수문자가 들어갈 수 없습니다</font></span>");
	             $('#MEMB_CHK_YN').val("N");
	         }else{
	            // 아이디 중복 여부
	            if (data == '0') {
	               $('#ID_CHK_MSG').html("<span><font color='blue'>사용할 수 있는 아이디</font></span>");
	               $('#MEMB_CHK_YN').val("Y");
	            }else{
	               $('#ID_CHK_MSG').html("<span><font color='red'>중복된 아이디</font></span>");
	               $('#MEMB_CHK_YN').val("N");
	            }
	         }
	      }, error: function (jqXHR, textStatus, errorThrown) {
	         alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
	      }
	   });	   
	}
	
	/* 사업자번호 중복 */		
	function fn_bunbChk(){	   
	   var strComBunb = $("#COM_BUNB").val().replace(/-/gi, "");
	   
	   if(strComBunb.length==0){
	      $('#COM_CHK_YN').val("N");
	      return;
	   }	      
	   
	   if(strComBunb.length <10){
	      $('#COM_BUNB_CHK_MSG').html("<span><font color='red'>사업자번호 자릿수를 확인해 주세요</font></span>");
	      $('#COM_CHK_YN').val("N");
	   }else{	      
	      var strComBunbSub = strComBunb.substring(0,3)+"-"+strComBunb.substring(3,5)+"-"+strComBunb.substring(5,10);
	     
	      $("#COM_BUNB_TMP").val(strComBunbSub);
	      
	       $.ajax({
	          type:"POST",
	           url:"${contextPath }/comBunbChk",
	         data: $("#bunbChkFrm").serialize(),
	         success: function (data) {
	   
	            // 사업자번호 중복 여부
	            if (data == '0') {
	               $('#COM_BUNB_CHK_MSG').html("<span><font color='blue'></font></span>");
	               $('#COM_CHK_YN').val("Y");
	            }else{
	               $('#COM_BUNB_CHK_MSG').html("<span><font color='red'>중복된 사업자번호입니다</font></span>");
	               $('#COM_CHK_YN').val("N");
	            }
	         }, error: function (jqXHR, textStatus, errorThrown) {
	            alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
	         }
	      });
	   }
	}
	
	/* 사업자회원 선택시 사업자정보 필수입력 */ 
	$("input:radio[name=MEMB_GUBN]").click(function(){	    
	    if($("input:radio[name=MEMB_GUBN]:checked").val()=='MEMB_GUBN_02' 
	    		||$("input:radio[name=MEMB_GUBN]:checked").val()=='MEMB_GUBN_04'){
	    	$('#COM_NAME').attr("required","");
			$('#COM_BUNB').attr("required","");
	    }else{
	    	$('#COM_NAME').removeAttr("required");
			$('#COM_BUNB').removeAttr("required");
	    }
	});
 
	/* 숫자만 */
	function onlyNumber(obj){
	   $(obj).keyup(function(){
	        $(this).val($(this).val().replace(/[^0-9]/g,""));
	   }); 
	}
	
	/* 개인정보와 동일 체크 */
	function same_chk(){
	   if($('#sameChk').prop('checked')==true){
	      $('#COM_PN').val($('#MEMB_PN').val());
	      $('#COM_BADR').val($('#MEMB_BADR').val());
	      $('#COM_DADR').val($('#MEMB_DADR').val());
	   }else{ //개인정보와 다름
	      $('#COM_PN').val('');
	      $('#COM_BADR').val('');
	      $('#COM_DADR').val('');
	   }
	}	

	/* SaveValidation
	function validatrion_submit(){
	   //아이디 체크
	   if($('#MEMB_CHK_YN').val() == "N"){
	      alert("아이디를 다시 입력해 주세요");
	      $("#MEMB_ID").focus();
	      return false;   
	   }
	   //비밀번호 체크
	   if($("#MEMB_PW").val() != $("#MEMB_PW_CON").val() && $("#MEMB_PW_CON").val()!=null){
	      alert("비밀번호가 일치하지 않습니다.");
	      $("#MEMB_PW_CON").focus();
	      return false;
	   }
	   //이메일체크
	   if(!chk_email($("#MEMB_MAIL").val())){
	      alert("e-mail 형식이 아닙니다.");
	      $("#MEMB_MAIL").focus();
	      return false;
	   }
	   //주소 체크
	   if($('#MEMB_PN').val()==null||$('#MEMB_PN').val()==''){
		   alert("우편번호와 주소는 필수값입니다.");
		   $("#MEMB_PN").focus();
		   return false;
	   }	 
	   //휴대폰번호 체크
	   if($('#MEMB_CPON').val()==null || $('#MEMB_CPON').val()==''){
		   alert("휴대폰번호를 입력해주세요." + $('#MEMB_CPON').val());
		   $("#MEMB_CPON").focus();
		   return false;
	   }	  
	   //사업자등록번호 체크
	   if($('#COM_CHK_YN').val() == "N"){
	      alert("사업자등록번호를 다시 입력해 주세요");
	      $("#COM_BUNB").focus();
	      return false;   
	   }  	   
	   
	   var strComBunb = $("#COM_BUNB").val().replace(/-/gi, "");
	   var strComBunbSub = strComBunb.substring(0,3)+"-"+strComBunb.substring(3,5)+"-"+strComBunb.substring(5,10);
	   $("#COM_BUNB").val(strComBunbSub);
	   
	 	// 일반회원 선택시 사업자정보 초기화
		if($('input:radio[name="MEMB_GUBN"]:checked').val()=='MEMB_GUBN_01'){
			$('#COM_NAME').val('');
			$('#COM_BUNB').val('');
			$('#COM_TELN').val('');
			$('#COM_EXTRA_ADDR').val('');
			$('#COM_ALL_ADDR').val('');
			$('#COM_PN').val('');
			$('#sameChk').val('');
			$('#COM_BADR').val('');
			$('#COM_DADR').val('');
			$('#COM_OPEN_HH').val('');
			$('#COM_OPEN_MM').val('');
			$('#COM_OPEN').val('');
			$('#COM_CLOSE_HH').val('');
			$('#COM_CLOSE_MM').val('');
			$('#COM_CLOSE').val('');
			$('#KEEP_LOCATION').val('');	
		}  
	} */
</script>

<!-- 아이디 중복체크 -->
<form id="idChkFrm" name="idChkFrm" action="${contextPath }/idChk" method="post" autocomplete="off">
   <input type="hidden" id="MEMB_ID_TMP" name="MEMB_ID_TMP" />
</form>

<!-- 사업자번호 중복체크 -->
<form id="bunbChkFrm" name="bunbChkFrm" action="${contextPath }/comBunbChk" method="post" autocomplete="off">
   <input type="hidden" id="COM_BUNB_TMP" name="COM_BUNB_TMP" />
</form>

<!-- 비밀번호 초기화 form -->
<form class="form-horizontal" id="passfrm" method="post" action="${contextPath }/m/mypage/pwUpdate">
	<input type="hidden" name="MEMB_ID" value="${memberInfo.MEMB_ID }" />
	<input type="hidden" name="MEMB_PW" value="${memberInfo.MEMB_ID }">
</form>
