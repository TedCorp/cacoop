<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!-- ▼ Key -->
<%@ include file="/layout/inc/mallKey.jsp" %>
<!-- ▲ Key -->

<style>
/* 폼 테이블 */
.tbl_pdt_detail {margin:0 0 20px}
.tbl_pdt_detail table {width:100%;border-collapse:collapse;border-spacing:0;border-top:2px solid #000}
.tbl_pdt_detail th {width:100px;padding:7px 13px;border:1px solid #e9e9e9;border-left:0;background:#f7f7f7;text-align:left}
.tbl_pdt_detail td {padding:7px 10px;border-top:1px solid #e9e9e9;border-bottom:1px solid #e9e9e9;background:transparent}
.tbl_pdt_detail textarea, .frm_input {border:1px solid #e4eaec;background:#f7f7f7;color:#000;vertical-align:middle;line-height:2em}
.tbl_pdt_detail textarea {padding:2px 2px 3px}
.tbl_pdt_detail textarea {width:98%;height:100px}
.tbl_pdt_detail a {text-decoration:none}
.tbl_pdt_detail .frm_address {margin-top:5px}
.tbl_pdt_detail .frm_file {display:block;margin-bottom:5px}
.tbl_pdt_detail .frm_info {display:block;padding:0 0 5px;line-height:1.4em}
#extraProducts{ width:100%; text-align:center;}
#extraProducts th{text-align:center; border:1px solid lightgrey;height:40px;}
#extraProducts td{text-align:center; border:1px solid lightgrey; height:30px;}
.wrapdiv{max-height:400px;overflow-y:scroll; border:2px solid lightgrey;margin-top:15px; }
.option_tr > th{
	text-align: center;
	padding: 10px;
}
.option_input,.extrPd_input{
	border: none;
	text-align: center;
}
.option_tr2 > th{
	text-align: center;
	padding: 10px;
}
 .option_tr2 > td { 
	text-align: center;
	padding: 10px;
}
.option_tr3{
	text-align: center;
}
#optionList > tr > td > input{
	border: none;
	text-align: center;
	padding: 5px;
}


.supr_id_style{
	padding-top: 7px;
	font-weight: bolder;
}

/* 배송비 설정 - 이유리 */
.shipping_table_area, .templete_table_area {border:1px solid #d2d6de;}
#shipDetail{margin-bottom:0; text-align:left;}
.shipping_table{width:100%;}
.shipping_table td {padding:4px;}
.shipping_table > tbody > tr > td:first-of-type{border-right: 1px solid #d2d6de;}
.shipping_table td:last-of-type{padding-left:15px;}
.shipping_dtl_table{width:95%; margin:5px;text-align:center;}
.shipping_dtl_table td{border-bottom:1px solid #3c8dbc;}
.td_wdt{width:50%;}
.input_wdt {width:20%;}
.input_wdt2 {width:24%;}
.input_wdt3 {width:15%;}
.line-hgt{line-height:34px;}
.flex{display:flex; justify-content:space-between;}
.select2{width:50%;}
.none{display:none;}
.margin-lft{margin-left:10px;}
.btn-hgt{height:34px;}
#DLVY_GUBN{width:50%;}
.ship_btn{background:#ffffff; outline:none;}
#DLVY_SORT{width:60%;}
.dlvy_sort_area{display:none;}
</style>

<section class="content-header">
   <h1>
      상품관리
      <small>상품 등록/수정</small>
   </h1>
   <ol class="breadcrumb">
      <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
      <li class="active">Here</li>
   </ol>
</section>

<section class="content">
   <!-- form start -->
   <spform:form name="saveFrm" id="saveFrm" method="post" action="${contextPath }/adm/productMgr" class="form-horizontal" enctype="multipart/form-data">
      <input type="hidden" id="ATFL_ID" name="ATFL_ID" value="${productInfo.ATFL_ID }">   
      <input type="hidden" id="DTL_ATFL_ID" name="DTL_ATFL_ID" value="${productInfo.DTL_ATFL_ID }">   
      <input type="hidden" id="RPIMG_SEQ" name="RPIMG_SEQ" value="${ productInfo.RPIMG_SEQ }">
      <input type="hidden" id="PD_CODE_CHK_YN" name="PD_CODE_CHK_YN" value="N"/>
      <input type="hidden" id="PD_BARCD_CHK_YN" name="PD_BARCD_CHK_YN" value="N"/>
      <!--<input type="hidden" id="DLVR_INDI_YN" name="DLVR_INDI_YN" value="N"/> 개별배송 여부 -->
      <!-- 검색조건 -->
      <input type="hidden" id="pageNum" name="pageNum" value="${param.pageNum }">
      <input type="hidden" id="rowCnt" name="rowCnt" value="${param.rowCnt }">
      <input type="hidden" id="schTxt" name="schTxt" value="${param.schTxt }">
      <input type="hidden" id="schGbn" name="schGbn" value="${param.schGbn }">      
      <input type="hidden" id="sortGubun" name="sortGubun" value="${param.sortGubun }">
      <input type="hidden" id="sortOdr" name="sortOdr" value="${param.sortOdr }">
      
      <input type="hidden" id="SEQ" name="SEQ" value="">
      <input type="hidden" id="USE_YN" name="USE_YN" value=""> 
      <input type="hidden" id="CUT_UNIT" name="CUT_UNIT" value="">
      
      <input type="hidden" id="Click_Yn" name="Click_Yn" value="N">
      
      <div class="box box-info">
         <div class="box-header with-border">
            <h3 class="box-title">상품정보</h3>
            <button type="button" class="btn btn-default btn-sm pull-right btnHelp">
               <i class="fa fa-question-circle"></i> 도움말
            </button>
         </div>
         <!-- /.box-header -->
         
            <!-- 공급업체 선택 추가 2020.02.12 -->
            <div class="form-group">
               <label for="SUPR_ID" class="col-md-2 control-label">공급업체</label> 
               <input type="hidden" name="supr" id="supr" value="${suprid}" />              
<!--                <div class="col-md-2">    -->
               <c:choose>
               		<c:when test="${ empty productInfo.PD_CODE }">
               			<div class="supr_id_style">&nbsp;&nbsp;${product.SUPR_NAME}</div>
               			<input type="hidden"  name="SUPR_ID"  id="SUPR_ID"  value="${product.SUPR_ID} "/>
               		</c:when>
               		<c:otherwise>
               			<div class="supr_id_style">&nbsp;&nbsp;${productInfo.SUPR_NAME}</div>
               			<input type="hidden" class="supr_id_style" name="SUPR_ID" value="${productInfo.SUPR_ID}" readonly/><br/>
               		</c:otherwise>
               </c:choose>
               	            
                 <%--  <!-- 정성 -->                     
                  <c:forEach var="var" items="${ suprList }" varStatus="status">
                     <label class="check" style="margin-right:10px">
                        <input type="radio" class="iradio" name="SUPR_ID" value="${var.SUPR_ID}" 
                           <c:if test='${productInfo.SUPR_ID == var.SUPR_ID || SUPR_NEW == var.SUPR_ID}'>checked</c:if>
                        onclick="" />
                        ${var.SUPR_NAME}
                     </label>
                    </c:forEach> --%>
               </div>
            
            <div class="form-group">
               <label class="col-md-2 control-label required">상품코드</label>
               <c:choose>
                  <c:when test="${ empty productInfo.PD_CODE }">
                     <div class="col-md-2">
                        <p class="form-control-static">
                           <label class="check right-10">
                              <input type="radio" class="iradio" name="PD_CODE_IN" value="AUTO" checked /> 자동발급
                           </label>
                           <label class="check right-10">
                              <input type="radio" class="iradio" name="PD_CODE_IN" value="INPUT" /> 수동입력
                           </label>
                        </p>
                        
                        <div class="input-group input-group-sm divInputCode">
                           <input type="text" class="form-control input-sm" name="PD_CODE" id="PD_CODE" value="${ productInfo.PD_CODE }" maxlength="13" onchange="fn_trimstring(this)"/> 
                           <span class="input-group-btn">
                              <button type="button" class="btn btn-warning btn-flat" id="btnDupChk">중복확인</button>
                           </span>
                        </div>
                        <div class="text-info" id="chkTxt"></div>
                     </div>
                  </c:when>
                  <c:otherwise>
                     <div class="col-md-2">
                        <p class="form-control-static">
                           <c:out value="${productInfo.PD_CODE }" escapeXml="true" />
                        </p>
                        <input name="PD_CODE" value="${ productInfo.PD_CODE }" type="hidden" />
                     </div>
                  </c:otherwise>
               </c:choose>
            </div>
            
            <div class="form-group">
               <label for="MEMB_NAME" class="col-sm-2 control-label required">상품명</label>
               <div class="col-sm-4">
                  <c:if test="${ empty productInfo.PD_CODE }">
                     <div class="input-group input-group-sm">
                        <input type="text" class="form-control input-sm" id="PD_NAME" name="PD_NAME" value="${productInfo.PD_NAME }" placeholder="상품명" maxlength="100"/>
                        <span class="input-group-btn">
                           <button type="button" class="btn btn-default" id="btnGoodsPopup">상품검색</button>
                        </span>
                     </div>
                  </c:if>
                  <c:if test="${ !empty productInfo.PD_CODE }">
                     <input type="text" class="form-control input-sm" id="PD_NAME" name="PD_NAME" value="${productInfo.PD_NAME }" placeholder="상품명" maxlength="100"/>
                  </c:if>
               </div>
            </div>
            
            <div class="form-group">
               <label class="col-md-2 control-label required">상품바코드</label>
               <div class="col-md-4">
                  <c:choose>   
                     <c:when test="${ empty productInfo.PD_BARCD }">
                        <div class="input-group input-group-sm divInputBarCode">
                           <input type="hidden" name="PD_BARCD_IN" value="INPUT" />
                           <input type="text" class="form-control input-sm" name="PD_BARCD" id="PD_BARCD" value="${ productInfo.PD_BARCD }" maxlength="20" 
                                 title="상품 바코드 번호" placeholder="상품바코드를 입력해주세요" onchange="fn_trimstring(this)"/> 
                           <span class="input-group-btn">
                              <button type="button" class="btn btn-warning btn-flat" id="btnBarcdDupChk">중복확인</button>
                           </span>
                        </div>
                        <div class="text-info divInputBarCode" id="chkBarcdTxt"></div>
                     </c:when>
                     <c:otherwise>
                        <div class="input-group input-group-sm">
                           <input type="text" class="form-control input-sm" name="PD_BARCD" id="PD_BARCD" value="${ productInfo.PD_BARCD }" maxlength="20" 
                                 title="상품 바코드 번호" placeholder="상품바코드를 입력해주세요" onchange="fn_trimstring(this)"/> 
                           <input type="hidden" id="ORG_BARCD" value="${ productInfo.PD_BARCD }"/>
                           <span class="input-group-btn">
                              <button type="button" class="btn btn-warning btn-flat" id="btnBarcdDupChk">중복확인</button>
                           </span>
                        </div>
                        <div class="text-info" id="chkBarcdTxt"></div>
                     </c:otherwise>
                  </c:choose>
               </div>
            </div>
            
             <div class="form-group">
               <label for="CAGO_NAME" class="col-md-2 control-label required">상품분류</label>
               <div class="col-md-4">
                  <input name="CAGO_ID" id="CAGO_ID" value="${ productInfo.CAGO_ID }" type="hidden" /> 
                  <div class="input-group input-group-sm">
                     <input type="text" class="form-control" name="CAGO_NAME" id="CAGO_NAME" value="${ productInfo.CAGO_NAME }${ent.USE_YN eq 'N' ? '(미사용)' : ''}" title="상품 카테고리" placeholder="카테고리를 선택해주세요" readonly/> 
                     <span class="input-group-btn">
                        <button type="button" class="btn btn-info btn-flat" id="btnCateSel">카테고리선택</button>
                     </span>
                  </div>
               </div>
               
               <%-- <label for="RETAIL_YN" class="col-md-1 control-label">리테일 분류</label>
               <div class="col-md-2">
                  <p class="form-control-static">
                     <label class="check" style="margin-right:10px">
                        <input type="radio" class="iradio" name="RETAIL_YN" value="Y" 
                           <c:if test="${productInfo.RETAIL_YN eq 'Y' }">checked</c:if>
                           onclick="fn_chk_rta_yn()" /> 사용
                     </label>
                     <label class="check" style="margin-right:10px">
                        <input type="radio" class="iradio" name="RETAIL_YN" value="N" 
                           <c:if test="${productInfo.RETAIL_YN eq 'N' or productInfo.RETAIL_YN eq null }">checked</c:if>
                           onclick="fn_chk_rta_yn()" /> 미사용
                     </label>
                  </p>
               </div> --%>
               <div class="col-md-2 retail" style="display:none;">
                  <p class="form-control-static">
                         <jsp:include page="${contextPath }/common/comCodForm">
                        <jsp:param name="COMM_CODE" value="RETAIL_GUBN" />
                        <jsp:param name="name" value="RETAIL_GUBN" />
                        <jsp:param name="value" value="${ productInfo.RETAIL_GUBN }" />
                        <jsp:param name="type" value="select" />
                        <jsp:param name="top" value="선택" />
                     </jsp:include>
                  </p>
               </div>
            </div>
            
            <div class="form-group">
               <label for="PD_PRICE" class="col-md-2 control-label required">매출가</label>
               <div class="col-md-2">
                  <div class="input-group">
                     <input type="text" class="form-control input-sm txt-right number" name="PD_PRICE" id="PD_PRICE" onchange="keyevent();" value="<fmt:formatNumber value="${ productInfo.PD_PRICE eq null ? 0 : productInfo.PD_PRICE }" pattern="#,###"/>" maxlength="15" title="상품가격" placeholder="숫자만 입력해주세요" >
                     <input type="hidden" name="orgin_price" id="orgin_price" value="${ productInfo.PD_PRICE}" />
                     <div class="input-group-addon">원</div>
                  </div>
               </div>
               
               <label for="PD_IWHUPRC" class="col-md-1 control-label">매입가</label>
               <div class="col-md-2">
                  <div class="input-group">
                     <input type="text" class="form-control input-sm txt-right number" name="PD_IWHUPRC" id="PD_IWHUPRC" value="<fmt:formatNumber value="${ productInfo.PD_IWHUPRC eq null ? 0 : productInfo.PD_IWHUPRC }" pattern="#,###"/>" maxlength="15" title="입고가" placeholder="숫자만 입력해주세요">
                     <div class="input-group-addon">원</div>
                  </div>
               </div>
            </div>
               
         <%--    <div class="form-group">
               <label for="PDDC_GUBN" class="col-md-2 control-label required">상품할인</label>
               <div class="col-md-3">
                  <p class="form-control-static">
                         <jsp:include page="${contextPath }/common/comCodForm">
                        <jsp:param name="COMM_CODE" value="PDDC_GUBN" />
                        <jsp:param name="name" value="PDDC_GUBN" />
                        <jsp:param name="value" value="${ productInfo.PDDC_GUBN }" />
                        <jsp:param name="type" value="radio" />
                        <jsp:param name="top" value="선택" />
                     </jsp:include>
                  </p>
               </div>
               <div class="col-md-2">
                  <div class="input-group">
                     <input type="text" class="form-control input-sm txt-right number" name="PDDC_VAL" id="PDDC_VAL"  
                           value="<fmt:formatNumber value="${ productInfo.PDDC_VAL eq null ? 0 : productInfo.PDDC_VAL }" pattern="#,###"/>" 
                           onblur="calculPrice()" maxlength="15" title="상품할인 값" placeholder="숫자만 입력해주세요">
                     <div class="input-group-addon">원</div>
                  </div>
               </div>
               <label for="PDDC_PRICE" class="col-md-1 control-label">행사가</label>
               <div class="col-md-3">
                  <div class="input-group">
                     <input id="PDDC_PRICE" type="text" class="form-control input-sm txt-right number" maxlength="15" title="상품할인 적용금액" readonly="readonly" placeholder="숫자만 입력해주세요">
                     <div class="input-group-addon">원</div>
                  </div>
               </div>
            </div> --%>
            
	       <div class="form-group">
			       	 <label for="MEMBER_PRICE" class="col-md-2 control-label required">조합원판매가</label>
              		 <div class="col-md-3">
              			<div class="input-group">	
							<input type="text" class="form-control input-sm txt-right number" name="MEMBER_PRICE" id="MEMBER_PRICE"value="<fmt:formatNumber value="${ productInfo.MEMBER_PRICE eq null ? 0 : productInfo.MEMBER_PRICE }" pattern="#,###"/>" maxlength="15" placeholder="숫자만 입력해주세요"/>
							<div class="input-group-addon">원</div>             				
	          			</div>
	          		</div>
	       </div>
            
            <div class="form-group">
               <label for="INVEN_QTY" class="col-md-2 control-label required">재고수량</label>
               <div class="col-md-2">
                  <div class="input-group">
                     <input type="text" class="form-control input-sm txt-right number" name="INVEN_QTY" id="INVEN_QTY" value="<fmt:formatNumber value="${ productInfo.INVEN_QTY eq '' or productInfo.INVEN_QTY eq null ? 9999 : productInfo.INVEN_QTY }" pattern="#,###"/>" maxlength="5" title="재고 수량" placeholder="숫자만 입력해주세요">
                     <div class="input-group-addon">개</div>
                  </div>
               </div>
               
               <label for="INVEN_QTY" class="col-md-1 control-label required">한정수량</label>
               <div class="col-md-2">
                  <div class="input-group">
                     <input type="text" class="form-control input-sm txt-right number" name="LIMIT_QTY" id="LIMIT_QTY" value="<fmt:formatNumber value="${ productInfo.LIMIT_QTY eq '' or productInfo.LIMIT_QTY eq null ? 999 : productInfo.LIMIT_QTY }" pattern="#,###"/>" maxlength="4" title="최대 구매가능 수량" placeholder="숫자만 입력해주세요">
                     <div class="input-group-addon">개</div>
                  </div>
               </div>
               
               <%-- <label for="QNT_LIMT_USE" class="col-md-1 control-label">선택수량</label>
               <div class="col-md-3" title="지정 수량 (수량제한)">
                  <p class="form-control-static">
                         <jsp:include page="/common/comCodForm">
                        <jsp:param name="COMM_CODE" value="COMM_YN" />
                        <jsp:param name="name" value="QNT_LIMT_USE" />
                        <jsp:param name="value" value="${ empty(productInfo.QNT_LIMT_USE) ? 'N' : productInfo.QNT_LIMT_USE }" />
                        <jsp:param name="type" value="radio" />
                        <jsp:param name="top" value="" />
                     </jsp:include>
                  </p>
               </div> --%>
            </div>
            
            <div class="form-group">
               <label for="MAKE_COM" class="col-md-2 control-label">제조사</label>
               <div class="col-md-2">
                  <input type="text" class="form-control input-sm" name="MAKE_COM" value="${ productInfo.MAKE_COM }" maxlength="25" title="제조사(브랜드)" placeholder="제조사(브랜드)">
               </div>
               <label for="ORG_CT" class="col-md-1 control-label">원산지</label>
               <div class="col-md-2">
                  <input type="text" class="form-control input-sm" name="ORG_CT" value="${ productInfo.ORG_CT }" maxlength="15" title="원산지" placeholder="원산지">
               </div>
            </div>
            
            <div class="form-group">
               <label for="PD_STD" class="col-md-2 control-label">제품규격</label>
               <div class="col-md-2">
                  <input type="text" class="form-control input-sm" name="PD_STD" value="${ productInfo.PD_STD }" maxlength="35" title="제품규격" placeholder="제품규격">
               </div>
               <label for="STD_UNIT" class="col-md-1 control-label">규격단위</label>
               <div class="col-md-2">
                  <input type="text" class="form-control input-sm" name="STD_UNIT" value="${ productInfo.STD_UNIT }" maxlength="15" title="규격단위" placeholder="규격단위">
               </div>
               <%-- <label for="BUNDLE_CNT" class="col-md-1 control-label">묶음배송</label>
               <div class="col-md-3">
                  <input type="text" class="form-control input-sm txt-right number" name="BUNDLE_CNT" id="BUNDLE_CNT" value="<fmt:formatNumber value="${ productInfo.BUNDLE_CNT }" pattern="#,###"/>" maxlength="4" title="묶음배송 수량" placeholder="숫자만 입력해주세요" readonly>
               </div> --%>
            </div>
            
            <%-- <div class="form-group">
               <label for="ADC_VAL" class="col-md-2 control-label">추가 컬럼</label>
               <div class="col-md-4">
                  <button type="button" class="btn btn-default btn-sm" id="btnAddColumns" data-toggle="button" aria-pressed="false" autocomplete="off">추가 컬럼 열기</button>
               </div>
               <label for="PD_CUT_SEQ" class="col-md-2 control-label">세절방식</label>
               <div class="col-md-4">
                  <button type="button" class="btn btn-primary btn-sm" id="productCutBtn" data-toggle="button" aria-pressed="false" autocomplete="off">세절방식 등록</button>                                    
               </div> 
            </div>
            <div class="divAdd" style="display:none;">
               <div class="form-group divAdd">
                  <label for="ADC_NAME" class="col-md-2 control-label"></label>
                  <div class="col-md-4">
                     <div class="input-group">
                        <span class="input-group-addon">컬럼명1</span>
                        <input type="text" class="form-control input-sm" name="ADC1_NAME" value="${ productInfo.ADC1_NAME }" maxlength="25" placeholder="컬럼명">
                     </div>
                  </div>
                  <div class="col-md-5">
                     <div class="input-group">
                        <span class="input-group-addon">컬럼값1</span>
                        <input type="text" class="form-control input-sm" name="ADC1_VAL" value="${ productInfo.ADC1_VAL }" maxlength="50" placeholder="컬럼값">
                     </div>
                  </div>
               </div>
               <div class="form-group divAdd">
                  <div class="col-md-4 col-md-offset-2">
                     <div class="input-group">
                        <span class="input-group-addon">컬럼명2</span>
                        <input type="text" class="form-control input-sm" name="ADC2_NAME" value="${ productInfo.ADC2_NAME }" maxlength="25" placeholder="컬럼명">
                     </div>
                  </div>
                  <div class="col-md-5">
                     <div class="input-group">
                        <span class="input-group-addon">컬럼값2</span>
                        <input type="text" class="form-control input-sm" name="ADC2_VAL" value="${ productInfo.ADC2_VAL }" maxlength="50" placeholder="컬럼값">
                     </div>
                  </div>
               </div>
               <div class="form-group divAdd">
                  <div class="col-md-4 col-md-offset-2">
                     <div class="input-group">
                        <span class="input-group-addon">컬럼명3</span>
                        <input type="text" class="form-control input-sm" name="ADC3_NAME" value="${ productInfo.ADC3_NAME }" maxlength="25" placeholder="컬럼명">
                     </div>
                  </div>
                  <div class="col-md-5">
                     <div class="input-group">
                        <span class="input-group-addon">컬럼값3</span>
                        <input type="text" class="form-control input-sm" name="ADC3_VAL" value="${ productInfo.ADC3_VAL }" maxlength="50" placeholder="컬럼값">
                     </div>
                  </div>
               </div>
               <div class="form-group divAdd">
                  <div class="col-md-4 col-md-offset-2">
                     <div class="input-group">
                        <span class="input-group-addon">컬럼명4</span>
                        <input type="text" class="form-control input-sm" name="ADC4_NAME" value="${ productInfo.ADC4_NAME }" maxlength="25" placeholder="컬럼명">
                     </div>
                  </div>
                  <div class="col-md-5">
                     <div class="input-group">
                        <span class="input-group-addon">컬럼값2</span>
                        <input type="text" class="form-control input-sm" name="ADC4_VAL" value="${ productInfo.ADC4_VAL }" maxlength="50" placeholder="컬럼값">
                     </div>
                  </div>
               </div>
               <div class="form-group divAdd">
                  <div class="col-md-4 col-md-offset-2">
                     <div class="input-group">
                        <span class="input-group-addon">컬럼명5</span>
                        <input type="text" class="form-control input-sm" name="ADC5_NAME" value="${ productInfo.ADC5_NAME }" maxlength="25" placeholder="컬럼명">
                     </div>
                  </div>
                  <div class="col-md-5">
                     <div class="input-group">
                        <span class="input-group-addon">컬럼값5</span>
                        <input type="text" class="form-control input-sm" name="ADC5_VAL" value="${ productInfo.ADC5_VAL }" maxlength="50" placeholder="컬럼값">
                     </div>
                  </div>
               </div>
            </div> --%>
            
            <div class="form-group">
               <label for="SALE_CON" class="col-md-2 control-label required">판매상태</label>
               <div class="col-md-4">
                  <p class="form-control-static">
                         <jsp:include page="${contextPath }/common/comCodForm">
                        <jsp:param name="COMM_CODE" value="SALE_CON" />
                        <jsp:param name="name" value="SALE_CON" />
                        <jsp:param name="value" value="${ productInfo.SALE_CON }" />
                        <jsp:param name="type" value="radio" />
                        <jsp:param name="top" value="선택" />
                     </jsp:include>
                  </p>
               </div>
               
               <input type="hidden" name="BOX_PDDC_GUBN" value="PDDC_GUBN_01" />
               <input type="hidden" name="BOX_PDDC_VAL" value="0"/>
            </div>
            
            <div class="form-group">
               <label for="TAX_GUBN" class="col-md-2 control-label required">과세구분</label>
               <div class="col-md-4">
                  <p class="form-control-static">
                         <jsp:include page="${contextPath }/common/comCodForm">
                        <jsp:param name="COMM_CODE" value="TAX_GUBN" />
                        <jsp:param name="name" value="TAX_GUBN" />
                        <jsp:param name="value" value="${ productInfo.TAX_GUBN }" />
                        <jsp:param name="type" value="radio" />
                        <jsp:param name="top" value="" />
                     </jsp:include>
                  </p>
               </div>               
               
               <%-- <label for="INPUT_CNT" class="col-md-2 control-label">입수량</label>
               <div class="col-md-3">
                  <div class="input-group">
                     <input name="INPUT_CNT" id="INPUT_CNT" value="<fmt:formatNumber value="${ productInfo.INPUT_CNT }" pattern="#,###"/>" 
                        type="text" class="form-control input-sm txt-right number" maxlength="4" title="입수량" placeholder="숫자만 입력해주세요">
                     <div class="input-group-addon">개</div>
                  </div>
               </div> --%>
            </div>
             
      <%--       <div class="form-group">
               <label for="KEEP_GUBN" class="col-md-2 control-label">보관기준</label>
               <div class="col-md-4">
                  <p class="form-control-static">
                         <jsp:include page="/common/comCodForm">
                        <jsp:param name="COMM_CODE" value="KEEP_GUBN" />
                        <jsp:param name="name" value="KEEP_GUBN" />
                        <jsp:param name="value" value="${ productInfo.KEEP_GUBN }" />
                        <jsp:param name="type" value="select" />
                        <jsp:param name="top" value="선택" />
                     </jsp:include>
                  </p>
               </div>
               <label for="KEEP_LOCATION" class="col-md-2 control-label">보관위치</label>
               <div class="col-md-3">
                  <input type="text" class="form-control input-sm" name="KEEP_LOCATION" value="${ productInfo.KEEP_LOCATION }" maxlength="120" title="보관위치" placeholder="보관위치">
               </div>
            </div> --%>
            
            <div class="form-group">
               <label for="SHIP_CONFIG" class="col-md-2 control-label required">배송비 설정</label>	
               <div class="col-md-9">
               	  <!-- 
                  <jsp:include page="${contextPath }/common/comCodForm">	
                        <jsp:param name="COMM_CODE" value="SHIP_CONFIG" />	
                        <jsp:param name="name" value="SHIP_CONFIG" />	
                        <jsp:param name="value" value="" />	
                        <jsp:param name="type" value="radio" />	
                        <jsp:param name="top" value="" />
                  </jsp:include>
                  -->
                  <input type="radio" id="SHIP_CONFIG_01" name="SHIP_CONFIG" value="SHIP_CONFIG_01" <c:if test="${ tb_pdshipxm.SHIP_CONFIG eq 'SHIP_CONFIG_01' || tb_pdshipxm.SHIP_CONFIG eq null }">checked</c:if>/>
                  <label for="SHIP_CONFIG_01">기본</label>&nbsp;&nbsp;
                  <input type="radio" id="SHIP_CONFIG_02" name="SHIP_CONFIG" value="SHIP_CONFIG_02" <c:if test="${ tb_pdshipxm.SHIP_CONFIG eq 'SHIP_CONFIG_02' }">checked</c:if>/>
                  <label for="SHIP_CONFIG_02">개별</label>&nbsp;&nbsp;
                  <input type="radio" id="SHIP_CONFIG_03" name="SHIP_CONFIG" value="SHIP_CONFIG_03" <c:if test="${ tb_pdshipxm.SHIP_CONFIG eq 'SHIP_CONFIG_03' }">checked</c:if>/>
                  <label for="SHIP_CONFIG_03">템플릿</label>&nbsp;&nbsp;
                  <button type="button" id="shipDefaultBtn" class="btn btn-default btn-sm ship_btn" style="display:block;" onclick="loadShipping();">배송 상세 정보 저장</button>
                  <div class="config1">
                  	<input type="hidden" id="DLVY_GUBN" name="DLVY_GUBN" value="${ tb_pdshipxm.DLVY_GUBN }"/>
                  	<input type="hidden" id="SHIP_GUBN" name="SHIP_GUBN" value="SHIP_GUBN_02"/>
                  	<input type="hidden" id="GUBN_START" name="GUBN_START" value="${ tb_spinfoxm.DLVA_FCON }"/>
                  	<input type="hidden" id="PD_WEIGHT" name="PD_WEIGHT" value="${ tb_pdshipxm.PD_WEIGHT }"/>
                  	<input type="hidden" id="SHIP_WIDTH" name="SHIP_WIDTH" value="${ tb_pdshipxm.SHIP_WIDTH }"/>
                  	<input type="hidden" id="SHIP_LENGTH" name="SHIP_LENGTH" value="${ tb_pdshipxm.SHIP_LENGTH }"/>
                  	<input type="hidden" id="SHIP_HEIGHT" name="SHIP_HEIGHT" value="${ tb_pdshipxm.SHIP_HEIGHT }"/>
                  	<input type="hidden" id="DLVY_AMT" name="DLVY_AMT" value="${ tb_spinfoxm.DLVY_AMT }"/>
                  	<input type="hidden" id="RFND_DLVY_AMT" name="RFND_DLVY_AMT" value="${ tb_pdshipxm.RFND_DLVY_AMT }"/>
                  	<input type="hidden" id="AREA_DLVY_AMT" name="AREA_DLVY_AMT" value="${ tb_pdshipxm.AREA_DLVY_AMT }"/>
                  	<input type="hidden" name="TEMP_NUM" value="${ tb_pdshipxm.TEMP_NUM }"/>
                  </div>
                  <form class="form-horizontal">
					<div class="box-body shipping_table_area" style="display:none;">
						<table class="shipping_table config2">
							<colgroup>
								<col style="width:20%">
								<col style="width:80%">
							</colgroup>
							<tr>
								<td><label class="control-label">배송 방법</label></td>
								<td>
									<select name="DLVY_GUBN" class="form-control select2">
										<option value="DLVY_GUBN_01" <c:if test="${ tb_pdshipxm.DLVY_GUBN eq 'DLVY_GUBN_01' }">selected</c:if>>직접배송</option>
										<option value="DLVY_GUBN_02" <c:if test="${ tb_pdshipxm.DLVY_GUBN eq 'DLVY_GUBN_02' }">selected</c:if>>택배배송</option>
									</select>
								</td>
							</tr>
							<tr>
								<td><label class="control-label">배송비 책정 방식</label></td>
								<td>
									<select id="shipGubn" name="SHIP_GUBN" class="form-control select2">
										<option value="SHIP_GUBN_01" <c:if test="${ tb_pdshipxm.SHIP_GUBN eq 'SHIP_GUBN_01' }">selected</c:if>>배송비 무료</option>
										<option value="SHIP_GUBN_02" <c:if test="${ tb_pdshipxm.SHIP_GUBN eq 'SHIP_GUBN_02' }">selected</c:if>>조건부 무료 배송</option>
										<option value="SHIP_GUBN_03" <c:if test="${ tb_pdshipxm.SHIP_GUBN eq 'SHIP_GUBN_03' }">selected</c:if>>구매 금액별 차등 배송료 부과</option>
										<option value="SHIP_GUBN_04" <c:if test="${ tb_pdshipxm.SHIP_GUBN eq 'SHIP_GUBN_04' }">selected</c:if>>상품 수량별 차등 배송료 부과</option>
									</select>
								</td>
							</tr>
							<tr>
								<td><label id="shipDetail" class="control-label none">배송비 상세 설정</label></td>
								<td>
									<div id="priceOnly" class="flex line-hgt none" style="padding:4px 0 4px 0;">
										구매 금액 &nbsp;
										<input type="text" name="GUBN_START" class="form-control input_wdt input7 radio2 number" value="<fmt:formatNumber value="${tb_pdshipxm.GUBN_START}" pattern="#,###"/>"/>원 미만이면 &nbsp; 
										배송비 &nbsp;
										<input type="text" name="DLVY_AMT" class="form-control input_wdt input8 radio2 number" value="<fmt:formatNumber value="${tb_pdshipxm.DLVY_AMT}" pattern="#,###"/>"/>원
									</div>
									<div id="priceUnit" class="flex line-hgt none" style="padding:4px 0 4px 0;">
										구매 금액 &nbsp;
										<input type="text" class="form-control input_wdt3 input1 number"/>원 이상 &nbsp; 
										<input type="text" class="form-control input_wdt3 input2 number"/>원 미만이면 &nbsp;
										배송비 &nbsp;
										<input type="text" class="form-control input_wdt3 input3 number"/>원&nbsp;
										<button type="button" class="btn btn-info btn-flat btn-hgt" onclick="addDetail('a');">추가</button>
									</div>
									<div id="countUnit" class="flex line-hgt none" style="padding:4px 0 4px 0;">
										구매 수량 &nbsp;
										<input type="text" class="form-control input_wdt3 input4"/>개 이상 &nbsp; 
										<input type="text" class="form-control input_wdt3 input5"/>개 미만이면 &nbsp;
										배송비 &nbsp;
										<input type="text" class="form-control input_wdt3 input6 number"/>원&nbsp;
										<button type="button" class="btn btn-info btn-flat btn-hgt" onclick="addDetail('b');">추가</button>
									</div>
									<table class="shipping_dtl_table none">
										<colgroup>
											<col style="width:10%;">
											<col style="width:55%;">
											<col style="width:20%;">
											<col style="width:15%;">
										</colgroup>
										<tr style="font-weight:700; background:#3c8dbc; color:#ffff;">
											<td>번호</td>
											<td>상세 설정</td>
											<td>배송비</td>
											<td>삭제</td>
										</tr>
										<c:set var="rownum" value="0"/>
										 <c:if test="${ tb_pdshipxm.SHIP_GUBN eq 'SHIP_GUBN_03' or tb_pdshipxm.SHIP_GUBN eq 'SHIP_GUBN_04' }">
										 	<c:choose>
										 		<c:when test="${ !empty(tb_pdshipxd.list) }">
										 			<c:forEach var="list" items="${ tb_pdshipxd.list }" varStatus="loop">
										 			<c:set var="rownum" value="${ rownum + 1 }"/>
										 				<tr>
										 					<td>${ rownum }</td>
										 					<c:if test="${tb_pdshipxm.SHIP_GUBN eq 'SHIP_GUBN_03'}">
											 					<td><fmt:formatNumber value="${list.GUBN_START}"/>원 이상 <fmt:formatNumber value="${list.GUBN_END}"/>원 미만</td>
											 					<td><fmt:formatNumber value="${list.DLVY_AMT}"/>원</td>
										 					</c:if>
										 					<c:if test="${tb_pdshipxm.SHIP_GUBN eq 'SHIP_GUBN_04'}">
										 						<td><fmt:formatNumber value="${list.GUBN_START}"/>개 이상 <fmt:formatNumber value="${list.GUBN_END}"/>개 미만</td>
											 					<td><fmt:formatNumber value="${list.DLVY_AMT}"/>원</td>
										 					</c:if>
										 					<td>
										 					<input type="button" id="btn${ list.SHIP_SEQ }" class="del_ship_btn" value="삭제" onclick="delShipBtn('${ rownum }');"/>
										 					<input type="hidden" name="GUBN_STARTS" value="${ list.GUBN_START }"/>
															<input type="hidden" name="GUBN_ENDS" value="${ list.GUBN_END }"/>
															<input type="hidden" name="DLVY_AMTS" value="${ list.DLVY_AMT }"/>
															</td>
										 				</tr>
										 			</c:forEach>
										 		</c:when>
										 		<c:otherwise>
										 			<tr>
														<td colspan="4">설정 구간이 존재하지 않습니다</td>
													</tr>
										 		</c:otherwise>
										 	</c:choose>
										 </c:if>
									</table>
								</td>
							</tr>
							<tr>
								<td><label class="control-label">배송 규격(cm)</label></td>
								<td class="flex line-hgt td_wdt">
									가로<input type="text" name="SHIP_WIDTH" class="form-control input_wdt radio2" value="${ tb_pdshipxm.SHIP_WIDTH }"/> 
									세로<input type="text" name="SHIP_LENGTH" class="form-control input_wdt radio2" value="${ tb_pdshipxm.SHIP_LENGTH }"/> 
									높이<input type="text" name="SHIP_HEIGHT" class="form-control input_wdt radio2" value="${ tb_pdshipxm.SHIP_HEIGHT }"/>
								</td>
							</tr>
							<tr>
								<td><label class="control-label">상품 총 중량(kg)</label></td>
								<td>
									<input type="text" name="PD_WEIGHT" class="form-control td_wdt radio2" value="${ tb_pdshipxm.PD_WEIGHT }"/>
								</td>
							</tr>
							<tr>
								<td><label for="inputEmail3" class="control-label">반품 배송비</label></td>
								<td>
									<input type="text" name="RFND_DLVY_AMT" class="form-control td_wdt radio2 number" placeholder="숫자만 입력(원 단위)" value="<fmt:formatNumber value="${tb_pdshipxm.RFND_DLVY_AMT}" pattern="#,###"/>"/>
								</td>
							</tr>
							<tr>
								<td><label for="inputEmail3" class="control-label">지역 추가 배송비</label></td>
								<td>
									<input type="text" name="AREA_DLVY_AMT" class="form-control td_wdt radio2 number" placeholder="없으면 0 또는 공백 표시(원 단위)" value="<fmt:formatNumber value="${tb_pdshipxm.AREA_DLVY_AMT}" pattern="#,###"/>"/>
								</td>
							</tr>
						</table>
					</div>
				</form>
					<div class="box-body templete_table_area">
						<table class="shipping_table config3">
							<colgroup>
								<col style="width:20%">
								<col style="width:80%">
							</colgroup>
							<tr>
								<td><label class="control-label">템플릿명</label></td>
								<td style="display:flex;">
									<input type="hidden" id="NEW_TEMP_NAME" name="NEW_TEMP_NAME"/>
									<input type="hidden" id="TEMP_NAME" name="TEMP_NAME"/>
									<select id="SelTempNum" name="TEMP_NUM" class="form-control select2">
										<c:choose>
											<c:when test="${ !empty(tb_shiptexm.list) }">
												<c:forEach var="list" items="${ tb_shiptexm.list }" varStatus="loop">
													<option value="${ list.TEMP_NUM }" <c:if test="${ list.TEMP_NUM eq tb_pdshipxm.TEMP_NUM }">selected</c:if>>${ list.TEMP_NAME }</option>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<option value="">템플릿명을 선택하세요</option>
											</c:otherwise>
										</c:choose>
									</select>&nbsp;&nbsp;
									<button type="button" id="tempBtn" class="btn btn-default btn-sm ship_btn" style="display:none;" onclick="loadTemplete();">템플릿 관리</button>
								</td>
							</tr>
							<tr>
								<td><label class="control-label">배송 규격(cm)</label></td>
								<td class="flex line-hgt td_wdt">
									가로<input type="text" name="SHIP_WIDTH" class="form-control input_wdt radio3" value="${ tb_pdshipxm.SHIP_WIDTH }"/> 
									세로<input type="text" name="SHIP_LENGTH" class="form-control input_wdt radio3" value="${ tb_pdshipxm.SHIP_LENGTH }"/> 
									높이<input type="text" name="SHIP_HEIGHT" class="form-control input_wdt radio3" value="${ tb_pdshipxm.SHIP_HEIGHT }"/>
								</td>
							</tr>
							<tr>
								<td><label class="control-label">상품 총 중량(kg)</label></td>
								<td>
									<input type="text" name="PD_WEIGHT" class="form-control td_wdt radio3" value="${ tb_pdshipxm.PD_WEIGHT }"/>
								</td>
							</tr>
							<tr>
								<td><label for="inputEmail3" class="control-label">지역 추가 배송비</label></td>
								<td>
									<input type="text" name="AREA_DLVY_AMT" class="form-control td_wdt radio3" placeholder="없으면 0 또는 공백 표시(원 단위)" value="${ tb_pdshipxm.AREA_DLVY_AMT }"/>
								</td>
							</tr>
						</table>
					</div>
               </div>	
            </div>
            
            <div class="form-group">
           	   <label for="PACKING_GUBN" class="col-md-2 control-label required">배송 타입</label>
               <div class="col-md-4">
                  <p class="form-control-static">
                  	<input type="radio" id="INDI_Y" name="DLVR_INDI_YN" value="Y" <c:if test="${ productInfo.DLVR_INDI_YN eq 'Y' || productInfo.DLVR_INDI_YN eq null }">checked</c:if>/>
	                <label for="INDI_Y">개별배송</label>&nbsp;&nbsp;
	                <input type="radio" id="INDI_N" name="DLVR_INDI_YN" value="N" <c:if test="${ productInfo.DLVR_INDI_YN eq 'N' }">checked</c:if>/>
	                <label for="INDI_N">묶음배송</label>
                     	<p class="dlvy_sort_area">
                     		<select name="DLVY_SORT" class="form-control select2">
								<option value="PRICE_DESC" <c:if test="${ productInfo.DLVY_SORT eq 'PRICE_DESC' }">selected</c:if>>배송비 최고가 적용</option>
								<option value="PRICE_ASC" <c:if test="${ productInfo.DLVY_SORT eq 'PRICE_ASC' }">selected</c:if>>배송비 최저가 적용</option>
							</select>
	                    </p>
                  </p>
              </div>
           </div>
            	
            <div class="form-group">
            <%--    <label for="PACKING_GUBN" class="col-md-2 control-label">팩킹기준</label>
               <div class="col-md-4">
                  <p class="form-control-static">
                         <jsp:include page="/common/comCodForm">
                        <jsp:param name="COMM_CODE" value="PACKING_GUBN" />
                        <jsp:param name="name" value="PACKING_GUBN" />
                        <jsp:param name="value" value="${ productInfo.PACKING_GUBN }" />
                        <jsp:param name="type" value="select" />
                        <jsp:param name="top" value="선택" />
                     </jsp:include>
                  </p>
               </div> --%>
               
            </div>
            <div class="form-group" style="display:flex;">
           		<label for="COM_PN" class="col-md-2 control-label required">반품주소</label>
              	<div class="input-group" style="display: flex; padding-left: 14px;">
					<input type="hidden" name="ADD_NUM" id="ADD_NUM" value="${productInfo.ADD_NUM}"/>
					<input type="text" name="COM_PN" id="COM_PN" class="form-control" style="width: 100px;border:0 solid black;" value="${tb_delivery_addr.COM_PN}" readonly/>
					<input type="text" name="COM_BADR" id="COM_BADR" class="form-control" style="width: 300px;border:0 solid black;" value="${tb_delivery_addr.COM_BADR}" readonly/>
					<input type="text" name="COM_DADR" id="COM_DADR"  class="form-control" style="width: 200px;border:0 solid black;" value="${tb_delivery_addr.COM_DADR}" readonly/>
					<button type="button" class="btn btn-primary btn-sm btnAdd" onclick="javascript:fn_popup();">주소선택</button>
				</div>
			</div>
            <div class="form-group">
	             <label for="optionAdd" class="col-md-2 control-label">상품 옵션</label>
			  	 <div class="col-md-9">
			        <table border="1px;" style="border-color: #d2d6de;margin: 14px 0px;">
				            <colgroup>
				                <col width="80px" style="" />
				                <col width="200px" style="" />
				                <col width="50px" style="" />
				              </colgroup>
				    
				            <thead>
				                <tr class="option_tr">
				                    <th>옵션명</th>
				                    <th>옵션값</th>
				                    <th></th>
				                </tr>
				            </thead>
				            <tbody id="pdOptionCreate">
				            <!-- optiontitle -->
				            	<c:if test="${empty optiontitle }">
				                <tr>
				                    <td>
				                        <input class="optionName option_input" type="text" placeholder="ex) 색상" value="">
				                    </td>
				                    <td>
				                        <input class="optionValue option_input" type="text" placeholder='ex) 빨강,노랑,파랑 (","로 구분)'>
				                    </td>
				                    <td style="text-align: center;">
				                    	<input type="button" id="addOption" onclick="addoption()" value="+" style="width: 100%;" class="btn btn-warning"/>
				                    </td>
				                </tr>
				                </c:if>
				              
				                <c:if test="${!empty optiontitle }">
					                <c:forEach var='optitle' items='${optiontitle }' varStatus='sta'>
						                <tr id="optionTR${sta.count}">
						                    <td>
						                        <input class="optionName option_input" type="text" placeholder="ex) 색상" value="${optitle.OPTION_NAME }">
						                    </td>
						                    <td>
						                        <input class="optionValue option_input" type="text" placeholder='ex) 빨강,노랑,파랑 (","로 구분)' value="${optitle.OPTION_VALUE }">
						                    </td>
						                    <td style="text-align: center;">
												<c:choose>
													<c:when test="${sta.count > 1}">
														<c:set var="count" value="${sta.count}"/>
														<input class="btn btn-warning" type="button" name="test" onclick="delOption(${count})" style="width: 100%;" value="x">
													</c:when>
													<c:otherwise>
														<input type="button" id="addOption" onclick="addoption()" value="+" style="width: 100%;" class="btn btn-warning"/>
													</c:otherwise>
												</c:choose>
											</td>
						                </tr>
					                </c:forEach>
				                </c:if>
				            </tbody>
				        </table>
				        <input type="button"  onclick="loadOption()" class="btn btn-info" value="다른상품 옵션 불러오기"/>
				        <input type="button"  onclick="sendToList()" class="btn btn-info" value="옵션 목록으로 적용"/>
					    <input type="button"  onclick="optionSet()" class="btn btn-info" value="옵션 저장"/>
				        <c:if test="${!empty optionList }">
					        <input type="button"  onclick="optionDelete('${productInfo.PD_CODE}');" class="btn btn-info" value="옵션 삭제"/>
				        </c:if>
				        <br/>
				        <br/>
				        <div id="opTable" style="height:fit-content; max-height : 500px; overflow-y:scroll; border:3px solid lightgray; ">
				        	<c:if test="${!empty optionList }">
					        	<table border="1" style="border-color: #d2d6de;">
							    	<colgroup>
								        <col width="3%" />
											<c:if test="${ empty optionList[0].OPTION2_VALUE && empty optionList[0].OPTION3_VALUE}">
								           		 <col width="18%" />
											</c:if>
											<c:if test="${ !empty optionList[0].OPTION2_VALUE && empty optionList[0].OPTION3_VALUE}">	
									            <col width="9%" />
									            <col width="9%" />
											</c:if>
											<c:if test="${ !empty optionList[0].OPTION3_VALUE}">	
									            <col width="6%" />
									            <col width="6%" />
									            <col width="6%" />
											</c:if>
								        <col width="10%" />
								        <col width="10%" />
								        <col width="10%" />
								        <col width="25%" />
								        <col width="10%" />
							        </colgroup>
							        <thead>
								        <tr class="option_tr2">
								            <th rowspan="2"><input type="checkbox"></th>
								            <c:if test="${ empty optionList[0].OPTION2_VALUE && empty optionList[0].OPTION3_VALUE}">
								               <th colspan="1">옵션명</th>
											</c:if>
											<c:if test="${ !empty optionList[0].OPTION2_VALUE && empty optionList[0].OPTION3_VALUE}">	
											   <th colspan="2">옵션명</th>
											</c:if>
											<c:if test="${ !empty optionList[0].OPTION3_VALUE}">	
											   <th colspan="3">옵션명</th>
											</c:if>
								            <th rowspan="2">옵션가</th>
								            <th rowspan="2">재고수량</th>
								            <th rowspan="2">판매상태</th>
								            <th rowspan="2">관리코드</th>
								            <th rowspan="2">삭제</th>
								        </tr>
								        <tr class="option_tr2">
											<c:if test="${ empty optionList[0].OPTION2_VALUE && empty optionList[0].OPTION3_VALUE}">
									       		<td class="option_name">${optionList[0].OPTION1_NAME }</td>
											</c:if>
											<c:if test="${ !empty optionList[0].OPTION2_VALUE && empty optionList[0].OPTION3_VALUE}">	
										        <td class="option_name">${optionList[0].OPTION1_NAME }</td>
										        <td class="option_name">${optionList[0].OPTION2_NAME }</td>
											</c:if>
											<c:if test="${ !empty optionList[0].OPTION3_VALUE}">	
										        <td class="option_name">${optionList[0].OPTION1_NAME }</td>
										        <td class="option_name">${optionList[0].OPTION2_NAME }</td>
										        <td class="option_name">${optionList[0].OPTION3_NAME }</td>
											</c:if>
								        </tr>
							        </thead>
							        <tbody id="optionList">
								        <c:forEach var='oplist' items='${optionList }' varStatus='sta'>
								        	<tr class="option_tr3">
								                <td><input type="checkbox" name="" id=""></td>
								            	<c:if test="${ empty optionList[0].OPTION2_VALUE && empty optionList[0].OPTION3_VALUE}">
							                   		 <td><input type="text" class="option1_values option_input" name="OPTION1_VALUE" id="OPTION1_VALUE" value="${oplist.OPTION1_VALUE }" style="width:60px"></td>
								            	</c:if>
												<c:if test="${ !empty optionList[0].OPTION2_VALUE && empty optionList[0].OPTION3_VALUE}">	
								                    <td><input type="text" class="option1_values option_input" name="OPTION1_VALUE" id="OPTION1_VALUE" value="${oplist.OPTION1_VALUE }" style="width:60px"></td>
								                    <td><input type="text" class="option2_values option_input" name="OPTION2_VALUE" id="OPTION2_VALUE" value="${oplist.OPTION2_VALUE }" style="width:60px"></td>
									            </c:if>
												<c:if test="${ !empty optionList[0].OPTION3_VALUE}">
								                    <td><input type="text" class="option1_values option_input" name="OPTION1_VALUE" id="OPTION1_VALUE" value="${oplist.OPTION1_VALUE }" style="width:60px"></td>
								                    <td><input type="text" class="option2_values option_input" name="OPTION2_VALUE" id="OPTION2_VALUE" value="${oplist.OPTION2_VALUE }" style="width:60px"></td>
								                    <td><input type="text" class="option3_values option_input" name="OPTION3_VALUE" id="OPTION3_VALUE" value="${oplist.OPTION3_VALUE }" style="width:60px"></td>
								            	</c:if>
									            <td>
									            	<input type="text" class="price" name="PRICE" id="PRICE" value="${oplist.PRICE}">
									            </td>
									            <td><input type="text" class="quantity" name="QUANTITY" id="QUANTITY" value="${oplist.QUANTITY}"></td>
									            <td>
									                <select class="sell_yn" name="SELL_YN" id="SELL_YN" >
									                    <c:if test="${oplist.SELL_YN eq 'N' }">
									                    	<option value="Y">Y</option>
									                    	<option value="N" selected>N</option>
									                    </c:if>
									                    <c:if test="${oplist.SELL_YN eq 'Y' }">
									                    	<option value="Y" selected>Y</option>
									                    	<option value="N" >N</option>
									                    </c:if>
									                </select>
									            </td>
								                <td>
								                	<input type="text" class="mgr_code" name="MGR_CODE" id="MGR_CODE" value="${oplist.MGR_CODE }">
								                	<input type="hidden" class="option_orig_price" name="OPTION_ORIG_PRICE" id="OPTION_ORIG_PRICE" value="${oplist.OPTION_ORIG_PRICE }">
								                	<input type="button" name="searchbtn" onclick="searchCode()" value="검색"/>
								                </td>
								                <td>
									                <select class="del_yn"name="DEL_YN" id="DEL_YN">
									                    <c:if test="${oplist.DEL_YN eq 'N' }">
									                        <option value="N" selected>N</option>
									                        <option value="Y">Y</option>
									                    </c:if>
									                    <c:if test="${oplist.DEL_YN eq 'Y' }">
									                        <option value="N" >N</option>
									                        <option value="Y" selected>Y</option>
									                    </c:if>
									                </select>
								                </td>
								            </tr>
								        </c:forEach>
							        </tbody>
							  </table>
	             		</c:if>
			        </div>
			    </div>
		    </div>
            <%-- 
            <div class="form-group">
               <label for="ONDY_GUBN" class="col-md-2 control-label">일배상품구분</label>
               <div class="col-md-4">
                  <p class="form-control-static">
                         <jsp:include page="/common/comCodForm">
                        <jsp:param name="COMM_CODE" value="ONDY_GUBN" />
                        <jsp:param name="name" value="ONDY_GUBN" />
                        <jsp:param name="value" value="${ productInfo.ONDY_GUBN }" />
                        <jsp:param name="type" value="radio" />
                        <jsp:param name="top" value="" />
                     </jsp:include>
                  </p>
               </div>
               <!-- 상품 옵션 설정 -->
               <!-- 현재 비닐봉투 단일 옵션 가능 -->
               <label for="OPTION_GUBN" class="col-md-2 control-label">비닐봉투 옵션</label>
               <p class="form-control-static col-md-3">
                  <label class="check" style="margin-right:10px">
                     <input type="radio" class="" name="OPTION_GUBN" value="" 
                        <c:if test="${ productInfo.OPTION_GUBN eq null or productInfo.OPTION_GUBN eq '' }">checked</c:if>
                     />
                     미사용
                  </label>
               </p>
               <!-- END 상품 옵션 설정 -->   
            </div> --%>
             <div class="form-group">
            <%--    <label for="PACKING_GUBN" class="col-md-2 control-label">팩킹기준</label>
               <div class="col-md-4">
                  <p class="form-control-static">
                         <jsp:include page="/common/comCodForm">
                        <jsp:param name="COMM_CODE" value="PACKING_GUBN" />
                        <jsp:param name="name" value="PACKING_GUBN" />
                        <jsp:param name="value" value="${ productInfo.PACKING_GUBN }" />
                        <jsp:param name="type" value="select" />
                        <jsp:param name="top" value="선택" />
                     </jsp:include>
                  </p>
               </div> --%>
               
               <label for="DLVY_GUBN" class="col-md-2 control-label required">추가 상품</label>
               <div class="col-md-3" style='width:75%;'>
               	<input type="button"  onclick="extraPrd();" class="btn btn-info" value="상품 불러오기"/>
               	<!-- <input type="button"  onclick="extraPrdSave()" class="btn btn-info" value="추가상품 정보 저장"/> -->
               	<input type="button"  onclick="extraPrdDelete()" class="btn btn-info" value="선택상품 삭제"/>
               	<div class="wrapdiv">
	                 <table id="extraProducts" >
		                  <colgroup>
		                  	<col width="5%" style="" />
		                  	<col width="60%" style="" />
			                <col width="15%" style="" />
			                <col width="20%" style="" />
		                  </colgroup>
							<tr>
								<th><input type="checkbox" onclick="selectAll()"/></th>
								<th style="text-align:center">상품명</th>
								<th style="text-align:center">가격</th>
								<th style="text-align:center">상품코드</th>
							</tr>
							<c:if test="${!empty extrPrd }"> <!--extrPrd  -->
							 <c:forEach var='list' items='${extrPrd }' varStatus='sta'>
							  <tr>
								<td><input name="extrPrd" type="checkbox" value="${list.EXTRA_PD_CODE }"></td>
								<td>${list.PD_NAME }</td>
								<td><input class="extrPdPrice extrPd_input" type="text" value="${list.PD_PRICE }"></td>
								<td><input class="extrPdValue extrPd_input" type="text" value="${list.EXTRA_PD_CODE }"></td>
							  </tr>
							 </c:forEach>
							</c:if>
	                  </table>
                  </div>
               </div>
            </div>
            <div class="form-group">
               <label for="PD_DINFO" class="col-md-2 control-label">상품 상세정보</label>
               <div class="col-md-9">
                       <textarea id="txtaPD_DINFO" rows="15">${productInfo.PD_DINFO } </textarea>
                       <input name="PD_DINFO" id="PD_DINFO" type="hidden" />
               </div>
            </div>
            
            <div class="form-group">
               <label for="DLVREF_GUIDE" class="col-md-2 control-label">배송/환불 안내</label>
               <div class="col-md-9">
                       <textarea id="txtaDLVREF_GUIDE" rows="15">${productInfo.DLVREF_GUIDE } </textarea>
                       <input name="DLVREF_GUIDE" id="DLVREF_GUIDE" type="hidden" />
               </div>
            </div>
            <c:if test="${ empty(productInfo.PD_CODE) or empty(fileDtlList) }">
               <input name="DTL_USE_YN" id="DTL_USE_YN" type="hidden" value="Y" />
            </c:if>
            <c:if test="${ !empty(productInfo.PD_CODE) and !empty(fileDtlList) }">
               <div class="form-group">
                  <label for="DTL_USE_YN" class="col-md-2 control-label">상세 첨부파일</label>
                  <div class="col-md-9">
                     <p class="form-control-static">
                            <jsp:include page="${contextPath }/common/comCodForm">
                           <jsp:param name="COMM_CODE" value="COMM_YN" />
                           <jsp:param name="name" value="DTL_USE_YN" />
                           <jsp:param name="value" value="${ productInfo.DTL_USE_YN }" />
                           <jsp:param name="type" value="radio" />
                           <jsp:param name="top" value="" />
                        </jsp:include>
                     </p>
                  </div>
               </div>
               <div class="form-group">                                        
                    <label class="col-md-2 control-label">상세 첨부파일 목록</label>
                    <div class="col-md-9">
                       <c:forEach var="var" items="${ fileDtlList }" varStatus="status">
                          <c:if test="${var.FILEPATH_FLAG eq mainKey }">                                       
                           <c:set var="imgDtlPath" value="${contextPath }/upload/${var.STFL_PATH }/${var.STFL_NAME }" />
                        </c:if>
                        <c:if test="${!empty(var.FILEPATH_FLAG) and var.FILEPATH_FLAG ne mainKey }">
                           <c:set var="imgDtlPath" value="${var.STFL_PATH }" />
                        </c:if>
                        <c:if test="${empty(var.FILEPATH_FLAG)}">
                           <c:set var="imgDtlPath" value="https://www.cjfls.co.kr/upload/${var.STFL_PATH }/${var.STFL_NAME }" />
                        </c:if>
                        <label class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" for="seq${var.ATFL_SEQ}">${var.ORFL_NAME } (경로 : ${imgDtlPath})</label>
                        <button type="button" class="btn btn-xs btn-primary file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:doImgPop('${imgDtlPath}')" >이미지 보기</button>
                        <button type="button" class="btn btn-xs btn-danger file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:fn_fileDelete(this, '${var.ATFL_ID}', '${var.ATFL_SEQ}')">삭제</button>
                          <br>
                         </c:forEach>
                  </div>
               </div>
             </c:if>
             <div class="form-group">                                        
                 <label class="col-md-2 control-label">상세이미지 첨부</label>
                 <div class="col-md-3">
                      <input name="fileDtl" type="file" multiple id="file-simple">
                 </div>
             </div><br>
             
            <c:if test="${ !empty(productInfo.PD_CODE) and !empty(fileList) }">
               <div class="form-group">                                        
                    <label class="col-md-2 control-label">대표이미지 목록</label>
                    <div class="col-md-9">
                       <c:forEach var="var" items="${ fileList }" varStatus="status">
                          <c:if test="${var.FILEPATH_FLAG eq mainKey }">                                       
                           <c:set var="imgPath" value="${contextPath }/upload/${var.STFL_PATH }/${var.STFL_NAME }" />
                        </c:if>
                        <c:if test="${!empty(var.FILEPATH_FLAG) and var.FILEPATH_FLAG ne mainKey }">
                           <c:set var="imgPath" value="${var.STFL_PATH }" />
                        </c:if>
                        <c:if test="${empty(var.FILEPATH_FLAG)}">
                           <c:set var="imgPath" value="https://www.cjfls.co.kr/upload/${var.STFL_PATH }/${var.STFL_NAME }" />
                        </c:if>
                        <input class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" name="mainFileOrdrIn" type="radio" id="seq${var.ATFL_SEQ}" value="${var.ATFL_SEQ}" ${productInfo.RPIMG_SEQ eq var.ATFL_SEQ ? "checked" : ""} />
                        <label class="file_${var.ATFL_ID}_${var.ATFL_SEQ}" for="seq${var.ATFL_SEQ}">${var.ORFL_NAME }</label>
                        <button type="button" class="btn btn-xs btn-primary file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:doImgPop('${imgPath}')" >이미지 보기</button>
                        <button type="button" class="btn btn-xs btn-danger file_${var.ATFL_ID}_${var.ATFL_SEQ}" onclick="javascript:fn_fileDelete(this, '${var.ATFL_ID}', '${var.ATFL_SEQ}')">삭제</button>
                          <br>
                         </c:forEach>
                         <div class="col-md-2">
                            <p class="form-control-static">* 대표이미지 지정</p>
                         </div>
                  </div>
               </div>
             </c:if>
             <div class="form-group">
                 <label class="col-md-2 control-label">대표이미지 첨부</label>
                 <div class="col-md-3">
                      <input name="file" type="file" multiple id="file-simple">
                 </div>
             </div>
         </div>
      <!-- </div> -->

      <!-- this row will not appear when printing -->
      <div class="row">
         <div class="col-xs-12">
            <a href="${contextPath}/adm/productMgr?pageNum=${param.pageNum }&rowCnt=${param.rowCnt }${link}" class="btn btn-default pull-right"><i class="fa fa-list"></i> 목록</a>
            <button type="button" id="btnSave" class="btn btn-primary pull-right right-5">
               <i class="fa fa-save"></i> 저장
            </button>
            <c:if test="${ !empty productInfo.PD_CODE }">
               <button type="button" class="btn btn-danger pull-right right-5 btnDel">
                  <i class="fa fa-remove"></i> 상품삭제
               </button>
            </c:if>
         </div>
      </div>
   </spform:form>
   <!-- /.box -->
</section>

<form id="delFrm" name="delFrm" class="form-horizontal" method="post">
   <input type="hidden" id="delATFL_ID" name="ATFL_ID" value=""/>
   <input type="hidden" id="delATFL_SEQ" name="ATFL_SEQ">
</form>

<!-- Modal : 카테고리선택용 -->
<div class="modal fade" id="divCategory" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
            <h4 class="modal-title" id="myModalLabel">카테고리 선택</h4>
         </div>
         
         <div class="modal-body">
            <div class="box box-primary">
               <div class="box-body">
                  <a href="javascript: cateTree.openAll();"><img src="${contextPath}/resources/adminlte/plugins/tree/img/openall.gif" width="15px" /></a> | 
                  <a href="javascript: cateTree.closeAll();"><img src="${contextPath}/resources/adminlte/plugins/tree/img/closeall.gif" width="15px"/></a>
                  <div class="tree_nav" style="max-height: 60vh; overflow-y: scroll;">                     
                     <script type="text/javascript">
                        //dTree 생성
                        cateTree = new dTree('cateTree', '${contextPath }');   
                        cateTree.add(0,-1,"상품 카테고리");
                        <c:forEach var="ent" items="${ categoryList }" varStatus="status">
                           cateTree.add("${ent.CAGO_ID}", "${empty ent.UPCAGO_ID ? '0' : ent.UPCAGO_ID}", "${ent.CAGO_NAME}${ent.USE_YN eq 'N' ? '(미사용)' : ''}" , "javascript: fnSeleteCategory(\'${ent.CAGO_ID}\', \'${ent.CAGO_NAME}\', \'${ent.CAGO_ID_PATH}\');", "${ent.CAGO_NAME}", "","","");
                        </c:forEach>
                        document.write(cateTree);
                     </script>
                  </div>
               </div>
            </div>
            <!-- blockquote>
              <p id="pSelectCategory">카테고리를 선택하세요.</p>
            </blockquote -->
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
         </div>
      </div>
   </div>
</div>


<!-- Modal : 세절방식 -->
<div class="modal fade" id="productCut" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="max-height:100%;overflow-y:scroll;">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <!-- <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div> -->
         <div class="modal-body">
            <div class="box box-primary">
               <div class="box-header with-border">
                  <h3 class="box-title">세절방식</h3>
                  <button type="button" class="btn btn-sm btn-primary pull-right right-10"  onclick="javascript:proCutAdd();" >추가</button>
               </div>
               <div class="box-body" style="max-height: 60vh; overflow-y: scroll;">
                  <table class="table table-bordered">
                     <thead>
                        <tr>
                           <th width="80%">세절방식</th>
                           <th class="tdCar">사용여부</th>
                        </tr>
                     </thead>
                     <tbody id="tBody" >                     
                        <c:if test='${ productCut eq null || productCut.size() eq 0 }'>
                           <tr>
                              <input type="hidden" name = "SEQ_LST" value="0">
                              <td><input type="text" class = "form-control input-sm" name = "CUT_UNIT_LST" maxlength="10"></td>
                              <td>
                                 <select class="form-control select2 input-sm" name = "USE_YN_LST">
                                    <option value="Y">Y</option>
                                    <option value="N">N</option>
                                 </select>
                              </td>                        
                           </tr>
                        </c:if>
                        <c:forEach var="proCut" items="${productCut }" varStatus="sta">
                        <tr>
                           <input type="hidden" name = "SEQ_LST" value="${proCut.SEQ }">
                           <td>
                              <input type="text" class = "form-control input-sm"  value="${proCut.CUT_UNIT }" name = "CUT_UNIT_LST" readonly="readonly">
                           </td>
                           <td>
                              <select class="form-control select2 input-sm" name = "USE_YN_LST">
                                 <option value="Y" <c:if test="${proCut.USE_YN eq 'Y' }">selected="selected"</c:if>>Y</option>
                                 <option value="N"<c:if test="${proCut.USE_YN eq 'N' }">selected="selected"</c:if>>N</option>
                              </select>
                           </td>   
                        </tr>
                        </c:forEach>                        
                     </tbody>
                  </table>                  
               </div>
            </div>
            
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
         </div>
      </div>
   </div>
</div>

<form id="pdCodeChkFrm" name="pdCodeChkFrm" action="${contextPath }/adm/productMgr/pdCodeChk" method="post" autocomplete="off">
   <input type="hidden" id="CHK_PD_CODE" name="PD_CODE" />
</form>
<form id="pdBarCodeChkFrm" name="pdBarCodeChkFrm" action="${contextPath }/adm/productMgr/pdBarCodeChk" method="post" autocomplete="off">
   <input type="hidden" id="CHK_PD_BARCD" name="PD_BARCD" />
</form>


<script>
var rownum = ${ rownum };
var strSelectCagoId = "";
var strSelectCagoName = "";
var numProCut = 0;   

/* 세절방식 추가 */
function proCutAdd(){
   //numProCut++;      
   $('#tBody').append('<tr><input type="hidden" name = "SEQ_LST" value="'+numProCut+'"><td><input type="text" class = "form-control input-sm" name = "CUT_UNIT_LST" maxlength="10"></td><td><select class="form-control select2 input-sm" name = "USE_YN_LST"><option value="Y">Y</option><option value="N">N</option></select></td></tr>');   
}

function fn_popup(){
	window.open("${contextPath}/adm/deliveryAddrMgr/productMgr", "_blank", "width=700,height=800"); 
}

var num = 1;

/* 배송비 설정 - 이유리 */
// 배송비 테이블 컬럼 추가
function addDetail(type) {
	var input1 = $(".input1").val().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","); //GUBN_STARTS
	var input2 = $(".input2").val().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","); //GUBN_ENDS
	var input3 = $(".input3").val().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","); //DLVY_AMTS
	var input4 = $(".input4").val(); //GUBN_STARTS(수량)
	var input5 = $(".input5").val(); //GUBN_ENDS(수량)
	var input6 = $(".input6").val().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	if(type == 'a') {
		if((input1 == null || input1 == '') || (input2 == null || input2 == '') || (input3 == null || input3 == '')) {
			alert("배송비를 입력해주세요");
			return false;
		}
	} else {
		if((input4 == null || input4 == '') || (input5 == null || input5 == '') || (input6 == null || input6 == '')) {
			alert("배송비를 입력해주세요");
			return false;
		}
	}
	
	var html ='';
	
	if(rownum == 0) {
	   $(".shipping_dtl_table").html('');
		
	   html += '<tr style="font-weight:700; background:#3c8dbc; color:#ffff;">';
  	   html += '<td>번호</td>';
  	   html += '<td>상세 설정</td>';
  	   html += '<td>배송비</td>';
  	   html += '<td>삭제</td>';
       html += '</tr>';
	}
	
	html += '<tr>';
	html += 	'<td>';
	html += 	rownum+1;
	html += 	'</td>';
	
	if(type == 'a') {
		$(".input1").val('');
		$(".input2").val('');
		$(".input3").val('');
		html += 	'<td>';
		html += 	input1 + '원 이상 ' + input2 + '원 미만';
		html += 	'</td>';
		html += 	'<td>';
		html += 	input3 + '원';
		html += 	'</td>';
		
		//, 제거하고 hidden에 값 넣기  
		 input1 = input1.replace(",", "");
		 input2 = input2.replace(",", "");
		 input3 = input3.replace(",", "");
		
		html += '<input type="hidden" name="GUBN_STARTS" value="' + input1 + '"/>';
		html += '<input type="hidden" name="GUBN_ENDS" value="' + input2 + '"/>';
		html += '<input type="hidden" name="DLVY_AMTS" value="' + input3 + '"/>';
	} else {
		$(".input4").val('');
		$(".input5").val('');
		$(".input6").val('');
	
		html += 	'<td>';
		html += 	input4 + '개 이상 ' + input5 + '개 미만';
		html += 	'</td>';
		html += 	'<td>';
		html += 	input6 + '원';
		html += 	'</td>';
	
		//, 제거하고 hidden에 값 넣기 
		var input6 = input6.replace(",", "");
		
		html += '<input type="hidden" name="GUBN_STARTS" value="' + input4 + '"/>';
		html += '<input type="hidden" name="GUBN_ENDS" value="' + input5 + '"/>';
		html += '<input type="hidden" name="DLVY_AMTS" value="' + input6 + '"/>';
	}
	
	html += 	'<td>';
	html += 	'<input type="button" id="btn' + (rownum+1) + '" class="del_ship_btn" value="삭제" onclick="delShipBtn(' + (rownum+1) + ');"/>';
	html += 	'</td>';
	html += '</tr>';
	
	$(".shipping_dtl_table").append(html);
	rownum++;
}

//배송비 테이블 컬럼 삭제
function delShipBtn(num) {
	$("#btn" + num).parent().parent().remove();
	rownum--;
	
	if(rownum == 0) {
		$(".shipping_dtl_table").html('');
		
		var html = '';
	    html += '<tr style="font-weight:700; background:#3c8dbc; color:#ffff;">';
	    html += '<td>번호</td>';
	    html += '<td>상세 설정</td>';
	    html += '<td>배송비</td>';
	    html += '<td>삭제</td>';
        html += '</tr>';
        html += '<tr>';
    	html += '<td colspan="4">설정 구간이 존재하지 않습니다</td>';
    	html += '</tr>';
    	
        $(".shipping_dtl_table").append(html);
	}
}

function setTempName(name) {
	document.getElementById("NEW_TEMP_NAME").value = name;
	//템플릿명 추가
	var temp_name = $("#NEW_TEMP_NAME").val();
	
	if(temp_name != null && temp_name != "") {
		var html = '<option value="">' + temp_name + '</option>';
		$("select[name=TEMP_NUM]").append(html);
	}
	
}

function setOriginShip(DLVY_GUBN, DLVY_AMT, GUBN_START, SHIP_WIDTH, SHIP_LENGTH, SHIP_HEIGHT, PD_WEIGHT, RFND_DLVY_AMT, AREA_DLVY_AMT) {
	document.getElementById("DLVY_GUBN").value = DLVY_GUBN;
	document.getElementById("DLVY_AMT").value = DLVY_AMT;
	document.getElementById("GUBN_START").value = GUBN_START;
	document.getElementById("SHIP_WIDTH").value = SHIP_WIDTH;
	document.getElementById("SHIP_LENGTH").value = SHIP_LENGTH;
	document.getElementById("SHIP_HEIGHT").value = SHIP_HEIGHT;
	document.getElementById("PD_WEIGHT").value = PD_WEIGHT;
	document.getElementById("RFND_DLVY_AMT").value = RFND_DLVY_AMT;
	document.getElementById("AREA_DLVY_AMT").value = AREA_DLVY_AMT;
}

$(function() {
	/* 배송비 설정 - 이유리 */
	// 배송비 설정에 따라 display
	if($("input:radio[name='SHIP_CONFIG']:checked").val() == "SHIP_CONFIG_01"){	
        $("#shipDefaultBtn").css("display", "block");
        $(".shipping_table_area").css("display", "none");
        $(".templete_table_area").css("display", "none");
        $("#tempBtn").css("display", "none");
     } else if($("input:radio[name='SHIP_CONFIG']:checked").val() == "SHIP_CONFIG_02"){	
   		$("#shipDefaultBtn").css("display", "none");
   	 	$(".shipping_table_area").css("display", "block");
   	 	$(".templete_table_area").css("display", "none");
   	 	$("#tempBtn").css("display", "none");
     }	else {
   	 	$("#shipDefaultBtn").css("display", "none");
    	$(".shipping_table_area").css("display", "none");
    	$(".templete_table_area").css("display", "block");
    	$("#tempBtn").css("display", "inline-flex");
     }
	
	// 배송비 책정 방식에 따라 display
	if($("#shipGubn option:selected").val() == "SHIP_GUBN_01"){
   		$("#shipDetail").css("display", "none");
   	 	$(".shipping_dtl_table").css("display", "none");
        $("#priceOnly").css("display", "none");
        $("#priceUnit").css("display", "none");
        $("#countUnit").css("display", "none");
	   } else if($("#shipGubn option:selected").val() == "SHIP_GUBN_02") {
   	 $("#shipDetail").css("display", "block");
    	$(".shipping_dtl_table").css("display", "none");
        $("#priceOnly").css("display", "flex");
        $("#priceOnly").css("justify-content", "flex-start");
        $("#priceUnit").css("display", "none");
        $("#countUnit").css("display", "none");
	   } else if($("#shipGubn option:selected").val() == "SHIP_GUBN_03") {
   	 	$("#shipDetail").css("display", "block");
   	 	$(".shipping_dtl_table").css("display", "inline-table");
   	 	$("#priceOnly").css("display", "none");
        $("#priceUnit").css("display", "flex");
        $("#priceUnit").css("justify-content", "flex-start");
        $("#countUnit").css("display", "none");
     } else {
   	 	$("#shipDetail").css("display", "block");
   	 	$(".shipping_dtl_table").css("display", "inline-table");
   	 	$("#priceOnly").css("display", "none");
        $("#priceUnit").css("display", "none");
        $("#countUnit").css("display", "flex");
        $("#countUnit").css("justify-content", "flex-start");
     }
	
	// 배송타입에 따라 display
	if($("input:radio[name='DLVR_INDI_YN']:checked").val() == "N"){	
        $(".dlvy_sort_area").css("display", "block");
     }	else {
    	 $(".dlvy_sort_area").css("display", "none");
     }
	
	
   /* 레이어 초기화 */
   $(".divAdd").hide();                  //추가컬럼 숨김
   $(".divInputCode").hide();            //수동입력 숨김
   //$(".divInputBarCode").hide();      //수동입력 숨김
   fn_chk_rta_yn();                     //리테일 카테고리 숨김
  // calculPrice();                        //행사가계산
   
   
   /* 세절방식 팝업 */
   $('#productCutBtn').on('click',function(){
      $('#productCut').modal('show');
   });

   CKEDITOR.replace('txtaPD_DINFO');
   CKEDITOR.replace('txtaDLVREF_GUIDE');

    /* 숫자만 입력토록 함 */
    $(document).on("keyup", ".number", function() {
       $(this).number(true);
    });
   
   var bToggle = true;
   var strToggle = "";
   
   /* 추가컬럼 입력 */
   $("#btnAddColumns").click(function(){      
      if(bToggle){
         strToggle = "추가 컬럼 닫기";
         $(".divAdd").show();
      }else{
         strToggle = "추가 컬럼 열기";
         $(".divAdd").hide();
      }      
      $(this).text(strToggle);
      
      bToggle = !bToggle;
   });

   /* 상품코드 입력구분 */
   $("input:radio[name='PD_CODE_IN']").change(function(){
      var strChkVal = $("input:radio[name='PD_CODE_IN']:checked").val();
      // 자동발급 & 수동입력
      if(strChkVal == "INPUT"){
         $(".divInputCode").show();
      }else{
         $(".divInputCode").hide();
      }
   });
   
   /* 상품바코드 입력구분 */
   $("input:radio[name='PD_BARCD_IN']").change(function(){
      var strChkVal = $("input:radio[name='PD_BARCD_IN']:checked").val();
      // 자동발급 & 수동입력
      if(strChkVal == "INPUT"){
         $(".divInputBarCode").show();
      }else{
         $(".divInputBarCode").hide();
      }
   });

   /* 상품할인 변경시 할인가계산 */
/*    $("input:radio[name='PDDC_GUBN']").change(function(){
      fn_pddc_disabled();
      calculPrice();
   }); */
   
   /* 카테고리 팝업 */
   $("#btnCateSel").click(function(){
      $('#divCategory').modal('show');
   });
   
   /* 카테고리 선택 */
   $("#btnSetCategory").click(function(){
      if(strSelectCagoId == ""){
         alert("적용할 카테고리를 선택하세요.");
         return;
      }
      
      $("#CAGO_NAME").val(strSelectCagoName);
      $("#CAGO_ID").val(strSelectCagoId);

      //초기화
      strSelectCagoId = "";
      strSelectCagoName = "";
      cateTree.closeAll();
      
      $('#divCategory').modal('hide');
   });
   
   /* 재고수량 변경시 판매상태 체크 */
   $("#INVEN_QTY").change(function(){      
      if($(this).val() == 0){
         $('input:radio[name=SALE_CON]:input[value="SALE_CON_02"]').prop("checked", true);   /* attr()과 prop() 차이 */
      }else if ($(this).val() > 0){
         $('input:radio[name=SALE_CON]:input[value="SALE_CON_01"]').prop("checked", true);   /* attr()과 prop() 차이 */
      }
   });
   
   /* 판매상태 변경시 재고수량 체크 */
   $("input:radio[name='SALE_CON']").change(function(){
      if($("input:radio[name='SALE_CON']:checked").val() != "SALE_CON_02"){
         if($("#INVEN_QTY").val() == 0){
            alert("재고수량을 확인해주세요.");
         }
      }
   });
   
   /* 배송비 설정 - 이유리 */
   // 배송비 설정 변경 시 (기본, 개별, 템플릿)
   $("input:radio[name='SHIP_CONFIG']").change(function(){
	  $(".radio2").val(''); 
	  $(".radio3").val('');
	  
      if($("input:radio[name='SHIP_CONFIG']:checked").val() == "SHIP_CONFIG_01"){	
         $("#shipDefaultBtn").css("display", "block");
         $(".shipping_table_area").css("display", "none");
         $(".templete_table_area").css("display", "none");
         $("#tempBtn").css("display", "none");
      } else if($("input:radio[name='SHIP_CONFIG']:checked").val() == "SHIP_CONFIG_02"){	
    	 $("#shipDefaultBtn").css("display", "none");
    	 $(".shipping_table_area").css("display", "block");
    	 $(".templete_table_area").css("display", "none");
    	 $("#tempBtn").css("display", "none");
      }	else {
    	 $("#shipDefaultBtn").css("display", "none");
     	 $(".shipping_table_area").css("display", "none");
     	 $(".templete_table_area").css("display", "block");
     	 $("#tempBtn").css("display", "inline-flex");
      }
      
      // 개별이 아닐 때 테이블 비우기
      if($("input:radio[name='SHIP_CONFIG']:checked").val() != "SHIP_CONFIG_02") {
    	  $(".input1").val(''); $(".input2").val(''); $(".input3").val(''); $(".input4").val('');
      	  $(".input5").val(''); $(".input6").val(''); $(".input7").val(''); $(".input8").val('');
    	  
    	  var html = '';
      	  
      	  html += '<tr style="font-weight:700; background:#3c8dbc; color:#ffff;">';
    	  html += '<td>번호</td>';
    	  html += '<td>상세 설정</td>';
    	  html += '<td>배송비</td>';
    	  html += '<td>삭제</td>';
          html += '</tr>';
      	  html += '<tr>';
      	  html += '<td colspan="4">설정 구간이 존재하지 않습니다</td>';
      	  html += '</tr>';
      	  
      	  $(".shipping_dtl_table").html(html);
      }
   });
   
   /* 배송비 설정 - 이유리 */
   // 배송비 책정 방식 변경 시 (배송비 무료, 조건비 무료 배송...)
   $("select[name='SHIP_GUBN']").change(function(){
	   if($("#shipGubn option:selected").val() == "SHIP_GUBN_01"){
    	 $("#shipDetail").css("display", "none");
    	 $(".shipping_dtl_table").css("display", "none");
         $("#priceOnly").css("display", "none");
         $("#priceUnit").css("display", "none");
         $("#countUnit").css("display", "none");
	   } else if($("#shipGubn option:selected").val() == "SHIP_GUBN_02") {
    	 $("#shipDetail").css("display", "block");
     	 $(".shipping_dtl_table").css("display", "none");
         $("#priceOnly").css("display", "flex");
         $("#priceOnly").css("justify-content", "flex-start");
         $("#priceUnit").css("display", "none");
         $("#countUnit").css("display", "none");
	   } else if($("#shipGubn option:selected").val() == "SHIP_GUBN_03") {
    	 $("#shipDetail").css("display", "block");
    	 $(".shipping_dtl_table").css("display", "inline-table");
    	 $("#priceOnly").css("display", "none");
         $("#priceUnit").css("display", "flex");
         $("#priceUnit").css("justify-content", "flex-start");
         $("#countUnit").css("display", "none");
      } else {
    	 $("#shipDetail").css("display", "block");
    	 $(".shipping_dtl_table").css("display", "inline-table");
    	 $("#priceOnly").css("display", "none");
         $("#priceUnit").css("display", "none");
         $("#countUnit").css("display", "flex");
         $("#countUnit").css("justify-content", "flex-start");
      }
      
      $(".input1").val(''); $(".input2").val(''); $(".input3").val(''); $(".input4").val('');
  	  $(".input5").val(''); $(".input6").val(''); $(".input7").val(''); $(".input8").val('');
  	  
  	  rownum = 0;
  	  
  	  var html = '';
  	  
  	  html += '<tr style="font-weight:700; background:#3c8dbc; color:#ffff;">';
	  html += '<td>번호</td>';
	  html += '<td>상세 설정</td>';
	  html += '<td>배송비</td>';
	  html += '<td>삭제</td>';
      html += '</tr>';
  	  html += '<tr>';
  	  html += '<td colspan="4">설정 구간이 존재하지 않습니다</td>';
  	  html += '</tr>';
  	  
  	  $(".shipping_dtl_table").html(html);
   });
   
   /* 배송비 설정 - 이유리 */
   //배송 타입(묶음배송, 개별배송) 변경 시
   $("input:radio[name='DLVR_INDI_YN']").change(function(){
	 if($("input:radio[name='DLVR_INDI_YN']:checked").val() == "Y"){	
        $(".dlvy_sort_area").css("display", "none");
     } else {
   	 	$(".dlvy_sort_area").css("display", "block");
     }
   });
   
   
   /* 저장 */
   $("#btnSave").click(function(){
      // 상품코드 발급구분 체크
    
      var strChkVal = $("input:radio[name='PD_CODE_IN']:checked").val();
      // 수동입력시
      if(strChkVal == "INPUT"){
         if($('#PD_CODE_CHK_YN').val() == "N"){
            alert("상품코드 중복확인 후 저장해주세요.");
            $("#PD_CODE").focus();
            return false;   
         }
      }
      
      // 상품바코드 중복확인 체크
      var strChkVal2 = $("input[name='PD_BARCD_IN']").val();      //$("input:radio[name='PD_BARCD_IN']:checked").val();
      // 수동입력시
      if(strChkVal2 == "INPUT"){
         if($('#PD_BARCD_CHK_YN').val() == "N"){
            alert("상품바코드 중복확인 후 저장해주세요.");
            $("#PD_BARCD").focus();
            return false;   
         }
      }
      
      // 상품상세정보 & 반품환불안내
      var strPD_DINFO = CKEDITOR.instances.txtaPD_DINFO.getData();
      var strDLVREF_GUIDE = CKEDITOR.instances.txtaDLVREF_GUIDE.getData();
      
      $("#PD_DINFO").val(strPD_DINFO);
      $("#DLVREF_GUIDE").val(strDLVREF_GUIDE);
      
      // 대표이미지 순번 체크
      $("#RPIMG_SEQ").val( $(':radio[name="mainFileOrdrIn"]:checked').val());
      if($(':radio[name="mainFileOrdrIn"]:checked').val() == null || $(':radio[name="mainFileOrdrIn"]:checked').val() == undefined || $(':radio[name="mainFileOrdrIn"]:checked').val() == ''){
         $("#RPIMG_SEQ").val("1");
      }
      
      // 제품할인 체크
  /*     if($('input:radio[name="PDDC_GUBN"]:checked').val() == "PDDC_GUBN_01"){
         $("#PDDC_VAL").val("0");
      }
      if($('input:radio[name="PDDC_GUBN"]:checked').val()==null || $('input:radio[name="PDDC_GUBN"]:checked').val()==""){      //할인구분 값 null이면 0으로 셋팅
         $("#PDDC_VAL").val("0");
      } */
      
      // 세절방식
      var seq_lst = document.getElementsByName("SEQ_LST");
      var use_yn_lst = document.getElementsByName('USE_YN_LST'); 
      var cut_unit_lst = document.getElementsByName('CUT_UNIT_LST');
      
      var seq_str ="";
      var use_yn_str = "";
      var cut_unit_str = "";

      for (var i = 0; i < seq_lst.length; i++) {
         if(cut_unit_lst[i].value !=""){
            if(seq_str==""){
               seq_str +=""+seq_lst[i].value;
            }else{
               seq_str +="!!@"+seq_lst[i].value;
            }
         }
       }
      for (var i = 0; i < use_yn_lst.length; i++) {
         if(cut_unit_lst[i].value !=""){
            if(use_yn_str==""){
               use_yn_str +=""+use_yn_lst[i].value;               
            }else{
               use_yn_str +="!!@"+use_yn_lst[i].value;
            }
         }
       }
      for (var i = 0; i < cut_unit_lst.length; i++) {
         if(cut_unit_lst[i].value !=""){
            if(cut_unit_str==""){
               cut_unit_str +=""+cut_unit_lst[i].value;
            }else{
               cut_unit_str +="!!@"+cut_unit_lst[i].value;               
            }
         }
       }
      
      $("#SEQ").val(seq_str)
      $("#USE_YN").val(use_yn_str)
      $("#CUT_UNIT").val(cut_unit_str)
      
      /* 배송비 설정 - 이유리 */
      //배송비 필수값 입력
      if($("input[name=SHIP_CONFIG]:checked").val() == "SHIP_CONFIG_02") {
    	  $(".config1").html('');
    	  $(".config3").html('');
    	  
    	  if($("select[name=SHIP_GUBN]").val() == "SHIP_GUBN_02") {
        	  if($("input[name=GUBN_START]").val() == null || $("input[name=START]").val() == "" ||
        	     $("input[name=DLVY_AMT]").val() == null || $("input[name=DLVY_AMT]").val() == "") {
    			  alert("배송비 상세 설정을 입력하세요.");
    			  $("select[name=SHIP_GUBN]").focus();
    			  return false;
        	  }
    	  } else if($("select[name=SHIP_GUBN]").val() == "SHIP_GUBN_03" || $("select[name=SHIP_GUBN]").val() == "SHIP_GUBN_04") {
    		  if($("input[name=GUBN_STARTS]").val() == null || $("input[name=GUBN_STARTS]").val() == "" || 
    		     $("input[name=GUBN_ENDS]").val() == null || $("input[name=GUBN_ENDS]").val() == "" ||
    		     $("input[name=DLVY_AMTS]").val() == null || $("input[name=DLVY_AMTS]").val() == "") {
    			  alert("배송비 상세 설정을 입력하세요.");
    			  $("input[name=SHIP_GUBN]").focus();
    			  return false;
    		  }
    	  }
    	
    	  if($("input[name=RFND_DLVY_AMT]").val() == null || $("input[name=RFND_DLVY_AMT]").val() == "") {
    		  alert("반품 배송비를 입력하세요.");
    		  $("input[name=RFND_DLVY_AMT]").focus();
    		  return false;
    	  }
      } else if($("input[name=SHIP_CONFIG]:checked").val() == "SHIP_CONFIG_03") {
    	  $(".config1").html('');
    	  $(".config2").html('');
    	  
    	  if($("select[name=TEMP_NUM]").val() == null || $("select[name=TEMP_NUM]").val() == "") {
    		  var target = document.getElementById("SelTempNum");
    		  var text = target.options[target.selectedIndex].text;
    		  
    		  if(text == "템플릿명을 선택하세요") {
    			  alert("템플릿명을 선택하세요.");
    			  $("select[name=TEMP_NUM]").focus();
        		  return false;
    		  } else {
    			  $("#TEMP_NAME").val(text);
    		  }
    	  }
      } else {
    	  $(".config2").html('');
    	  $(".config3").html('');
      }
	//만약옵션정보가있다면 저장      
 	if($('.option1_values').val() !='' && $('.option1_values').val() != null){
      optionSet_TotSave();
 	}
      
      $("#saveFrm").submit();
   });

   /* 삭제 */
   $(".btnDel").click(function(){
      if(!confirm("삭제하시겠습니까?")) return;
      
      $("#saveFrm").attr("action","${contextPath }/adm/productMgr/deletePrd");
      $("#saveFrm").submit();
   });
   
   /* 저장 필수값 체크 */
    $('#saveFrm').validate({
        debug: false,
        onfocusout: false,
        rules: {
           PD_NAME: {
                required: true
            },
            CAGO_NAME: {
                required: true
            },
            PD_BARCD: {
                required: true
            },
            PD_PRICE: {
                required: true
            },
            INVEN_QTY: {
                required: true
            },
            LIMIT_QTY: {
                required: true
            },
            SALE_CON: {
                required: true
            },
            TAX_GUBN: {
                required: true
            },
            DLVY_GUBN : {
                required: true
            }
        }, messages: {
           PD_NAME: {
                required: '상품명을 입력해주세요.'
            },
            CAGO_ID: {
                required: '카테고리를 선택해주세요.'
            },
            PD_BARCD: {
                required: '상품바코드를 입력해주세요.'
            },
            PD_PRICE: {
                required: '상품가격을 입력해주세요.'
            },
            INVEN_QTY: {
                required: '재고수량을 입력해주세요.'
            },
            LIMIT_QTY: {
                required: '한정수량을 입력해주세요.'
            },
            SALE_CON : {
                required: '판매상태을 선택해주세요.'
            },
            TAX_GUBN : {
                required: '과세구분을 선택해주세요.'
            },
            DLVY_GUBN: {
                required: '배송구분을 선택해주세요.'
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
   
   /* 마스터 상품 검색 */
   $("#btnGoodsPopup").click(function(){
      //window.open("${contextPath }/adm/productMgr/popup", "_blank", "width=900,height=800");
      alert("서비스 준비중입니다...");      //테이블 및 로직없음
   });
    
   /* 상품코드 중복확인 */
   $("#btnDupChk").click(function(){
      var strPdCode = $("#PD_CODE").val();
      
      $("#CHK_PD_CODE").val(strPdCode);
      
      if(strPdCode == ""){
         alert("상품코드를 입력해 주세요");
         return false;
      }
      
      $.ajax({
         type: "POST",
         url: "${contextPath}/adm/productMgr/pdCodeChk",
         data: $("#pdCodeChkFrm").serialize(),
         success: function (data) {
            // 제품코드 중복 여부
            if (data == '0') {
               $('#chkTxt').html("<span><font color='blue'>사용할 수 있는 제품코드입니다.</font></span>");
               $('#PD_CODE_CHK_YN').val("Y");
            }else{
               $('#chkTxt').html("<span><font color='red'>사용할 수 없는 제품코드입니다.</font></span>");
               $('#PD_CODE_CHK_YN').val("N");
            }
         }, error: function (jqXHR, textStatus, errorThrown) {
            alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
         }
      });      
   });
   
   /* 상품바코드 중복확인 */
   $("#btnBarcdDupChk").click(function(){
      var strPdCode = $("#PD_BARCD").val();
      
      $("#CHK_PD_BARCD").val(strPdCode);
      
      if(strPdCode == ""){
         alert("상품바코드를 입력해 주세요");
         return false;
      }
      if($('#ORG_BARCD').val()==$('#PD_BARCD').val()){
         $('#PD_BARCD_CHK_YN').val("Y");
         $('#chkBarcdTxt').html("<span><font color='blue'>기존에 사용하던 제품바코드입니다.</font></span>");
         
      }else{
         $.ajax({
            type: "POST",
            url: "${contextPath}/adm/productMgr/pdBarCodeChk",
            data: $("#pdBarCodeChkFrm").serialize(),
            success: function (data) {   
               // 제품코드 중복 여부
               if (data == '0') {
                  $('#chkBarcdTxt').html("<span><font color='blue'>사용할 수 있는 제품바코드입니다.</font></span>");
                  $('#PD_BARCD_CHK_YN').val("Y");
               }else{
                  $('#chkBarcdTxt').html("<span><font color='red'>사용할 수 없는 제품바코드입니다.</font></span>");
                  $('#PD_BARCD_CHK_YN').val("N");
               }
            }, error: function (jqXHR, textStatus, errorThrown) {
               alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
            }
         });
      }      
   });
   
   /* 배송&환불안내 초기값 */ 
   if($('#txtaDLVREF_GUIDE').text()==''){
      var dlvTxt = '';
      dlvTxt += '교환/반품 안내 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br />';
      dlvTxt += '1.교환/반품은 상품수령후 7일이내로 가능합니다 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br />';
      dlvTxt += '2.상품의 불량/하자인 경우 해당 상품회수 비용은 무료입니다. &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br />';
      dlvTxt += '&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br />';
      dlvTxt += '교환 및 반품 불가능한 경우 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br />';
      dlvTxt += '1. 냉장,냉동식품의 경우(반송시재판매불가) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br />';
      dlvTxt += '2. 고객님의 책임사유있는이유로 포장된 상품이 훼손된 경우 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br />';
      dlvTxt += '3. 시간이 경과되어 재판매가 곤란할 정도로 상품의 가치가 상실된경우 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br />';
      dlvTxt += '4. 고객센터와협의없이 임의로 반송한경우 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br />';
      dlvTxt += '5. 기타전자상거래 등에서의 소비자보호에 관한 법률이 정하는 소비자청약철회 제한 내용에 해당되는 경우 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br />';
      dlvTxt += '<br />';
      
      $('#txtaDLVREF_GUIDE').text(dlvTxt)
   }
   
   /* 할인필수값 체크 */
   fn_boxpddc_disabled();
   fn_pddc_disabled();  
});

//############### 카테고리 별 상품 상세정보 #################

var cagoIdPath = '${ productInfo.CAGO_ID_PATH }';
var preCagoRootId = "";

if(cagoIdPath != "" && cagoIdPath != "null"){
   preCagoRootId = cagoIdPath.split( '>' )[0];
}
   
/* 카테고리 선택 */
function fnSeleteCategory(strCagoId, strCagoName, strCagoIdPath){
   /* 
   바로 선택으로 변경
   strSelectCagoId = strCagoId;
   strSelectCagoName = strCagoName;
   
   $("#pSelectCategory").text("선택 카테고리 : " + strSelectCagoName);
    */
    
   $("#CAGO_NAME").val(strCagoName);
   $("#CAGO_ID").val(strCagoId);

   //초기화
   cateTree.closeAll();

   var arrCagoId = strCagoIdPath.split( '>' );
   var strHtml = "";
   
   if(preCagoRootId != "" && preCagoRootId != "null" && preCagoRootId != arrCagoId[0]){
      if(confirm("상품상세 설명이 초기화 됩니다. 적용하시겠습니까?")){
         strHtml = fnMakeHtml(arrCagoId[0]);

         if ( CKEDITOR.instances.txtaPD_DINFO.mode == 'wysiwyg' ){        
            //CKEDITOR.instances.txtaPD_DINFO.insertHtml( strHtml );    
            CKEDITOR.instances.txtaPD_DINFO.setData(strHtml);
         }else{
            alert( '소스보기 모드에선 초기화 할수 없습니다.' );
         }        
      }         
   }
   
   if(preCagoRootId == "" || preCagoRootId == "null"){
      strHtml = fnMakeHtml(arrCagoId[0]);
      
      if ( CKEDITOR.instances.txtaPD_DINFO.mode == 'wysiwyg' ){  
         CKEDITOR.instances.txtaPD_DINFO.setData(strHtml);
      }else{
         alert( '소스보기 모드에선 초기화 할수 없습니다.' );
      }      
   }
   preCagoRootId = arrCagoId[0];
   
   $('#divCategory').modal('hide'); 
}

/* 카테고리별 상세정보 양식 */
function fnMakeHtml(topCagoId) {
   var rtnHtml = "";
   var strPdName = $("#PD_NAME").val();
   
   if(strPdName == "" || strPdName == "null"){
      strPdName = "상세설명참조";
   }
   
   //가공식품
   if(topCagoId == '100000000' || topCagoId == '010000000000'){      //010000000000
      rtnHtml += "<p>전자상거래 등에서의 상품정보제공고시(가공식품)</p>";
      rtnHtml += "<table>";
      rtnHtml += "   <tbody>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th style='width:170px'>상품명</th>";
      rtnHtml += "         <td>"+strPdName+"</td>";
      rtnHtml += "         <th style='width:170px'>식품유형</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>생산자및소재지(수입품의경우 생산자,수입자 및 제조국)</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th style='color:red'>제조연월일,유통기한또는품질유지기한</th>";
      rtnHtml += "         <td style='color:red'>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>포장단위별 용량(중량),수량</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>원재료명 및 함량</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>영양성분(식품위생법에 따른 영양성분 표시대상 식품에 한함)</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>유전자재조합식품에 해당하는 경우의 표시</th>";
      rtnHtml += "         <td>해당없음</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>영유아식 또는 체중조절식품 등에 해당하는 경우 표시광고 사전 심의필 유무 및 부작용발생 가능성</th>";
      rtnHtml += "         <td>해당없음</td>";
      rtnHtml += "         <th>수입식품에 해당하는 겨우 &quot;식품위생법에 따른 수입신고를 필함&quot;의 문구</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>섭취량,섭취방법,섭취시주의사항</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>보관방법/취급방법</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>소비자상담관련전화번호</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>&nbsp;</th>";
      rtnHtml += "         <td>&nbsp;</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "   </tbody>";
      rtnHtml += "</table>";
   }

   //양곡
   else if(topCagoId == '140000000' || topCagoId == '020000000000'){   //020000000000
      rtnHtml += "<p>전자상거래 등에서의 상품정보제공고시(양곡)</p>";
      rtnHtml += "<table>";
      rtnHtml += "   <tbody>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th style='width:170px'>상품명</th>";
      rtnHtml += "         <td>"+strPdName+"</td>";
      rtnHtml += "         <th style='width:170px'>식품유형</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>생산자및소재지(수입품의경우 생산자,수입자 및 제조국)</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>제조연월일,유통기한또는품질유지기한</th>";
      rtnHtml += "         <td>상품입고시 마다 제조일이 상이하여 유통기한이 다릅니다.배송되는 상품은 선입선출에 의해 출고되오니 안심하고 구입하시기 바랍니다. 유통기한에 대한 궁금하신사항은 문의글이나 전화를 주시면 상세히 안내해 드리겠습니다.</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>농수축산물품질관리법상 유전자변형농산물 표시,지리적 표시</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>포장단위별 용량(중량),수량</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>원재료명 및 함량</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>영양성분(식품위생법에 따른 영양성분 표시대상 식품에 한함)</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>유전자재조합식품에 해당하는 경우의 표시</th>";
      rtnHtml += "         <td>해당없음</td>";
      rtnHtml += "         <th>영유아식 또는 체중조절식품 등에 해당하는 경우 표시광고 사전 심의필 유무 및 부작용발생 가능성</th>";
      rtnHtml += "         <td>해당없음</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>수입식품에 해당하는 겨우 &quot;식품위생법에 따른 수입신고를 필함&quot;의 문구</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>섭취량,섭취방법,섭취시주의사항</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>보관방법/취급방법</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>소비자상담관련전화번호</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "   </tbody>";
      rtnHtml += "</table>";
   }
   
   //농산물
   else if(topCagoId == '110000000' || topCagoId == '030000000000'){      //030000000000
      rtnHtml += "<p>전자상거래 등에서의 상품정보제공고시(농산물)</p>";
      rtnHtml += "<table>";
      rtnHtml += "   <tbody>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th style='width:170px'>상품명</th>";
      rtnHtml += "         <td>"+strPdName+"</td>";
      rtnHtml += "         <th style='width:170px'>식품유형</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>생산자및소재지(수입품의경우 생산자,수입자 및 제조국)</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>제조연월일,유통기한또는품질유지기한</th>";
      rtnHtml += "         <td>상품입고시 마다 제조일이 상이하여 유통기한이 다릅니다.배송되는 상품은 선입선출에 의해 출고되오니 안심하고 구입하시기 바랍니다. 유통기한에 대한 궁금하신사항은 문의글이나 전화를 주시면 상세히 안내해 드리겠습니다.</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>농수축산물품질관리법상 유전자변형농산물 표시,지리적 표시</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>포장단위별 용량(중량),수량</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>영양성분(식품위생법에 따른 영양성분 표시대상 식품에 한함)</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>유전자재조합식품에 해당하는 경우의 표시</th>";
      rtnHtml += "         <td>해당없음</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>영유아식 또는 체중조절식품 등에 해당하는 경우 표시광고 사전 심의필 유무 및 부작용발생 가능성</th>";
      rtnHtml += "         <td>해당없음</td>";
      rtnHtml += "         <th>수입식품에 해당하는 겨우 &quot;식품위생법에 따른 수입신고를 필함&quot;의 문구</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>섭취량,섭취방법,섭취시주의사항</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>보관방법/취급방법</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>소비자상담관련전화번호</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>&nbsp;</th>";
      rtnHtml += "         <td>&nbsp;</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "   </tbody>";
      rtnHtml += "</table>";
   }
   
   //수산물
   else if(topCagoId == '130000000' || topCagoId == '040000000000'){      //040000000000
      rtnHtml += "<p>전자상거래 등에서의 상품정보제공고시(수산물)</p>";
      rtnHtml += "<table>";
      rtnHtml += "   <tbody>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th style='width:170px'>상품명</th>";
      rtnHtml += "         <td>"+strPdName+"</td>";
      rtnHtml += "         <th style='width:170px'>식품유형</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>생산자및소재지(수입품의경우 생산자,수입자 및 제조국)</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>제조연월일,유통기한또는품질유지기한</th>";
      rtnHtml += "         <td>상품입고시 마다 제조일이 상이하여 유통기한이 다릅니다.배송되는 상품은 선입선출에 의해 출고되오니 안심하고 구입하시기 바랍니다. 유통기한에 대한 궁금하신사항은 문의글이나 전화를 주시면 상세히 안내해 드리겠습니다.</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>농수축산물품질관리법상 유전자변형농산물 표시,지리적 표시</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>포장단위별 용량(중량),수량</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>영양성분(식품위생법에 따른 영양성분 표시대상 식품에 한함)</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>유전자재조합식품에 해당하는 경우의 표시</th>";
      rtnHtml += "         <td>해당없음</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>영유아식 또는 체중조절식품 등에 해당하는 경우 표시광고 사전 심의필 유무 및 부작용발생 가능성</th>";
      rtnHtml += "         <td>해당없음</td>";
      rtnHtml += "         <th>수입식품에 해당하는 겨우 &quot;식품위생법에 따른 수입신고를 필함&quot;의 문구</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>섭취량,섭취방법,섭취시주의사항</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>보관방법/취급방법</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>소비자상담관련전화번호</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>&nbsp;</th>";
      rtnHtml += "         <td>&nbsp;</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "   </tbody>";
      rtnHtml += "</table>";
   }
   
   //축산물
   else if(topCagoId == '160000000' || topCagoId == '050000000000'){      //050000000000
      rtnHtml += "<p>전자상거래 등에서의 상품정보제공고시(축산물)</p>";
      rtnHtml += "<table>";
      rtnHtml += "   <tbody>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th style='width:170px'>상품명</th>";
      rtnHtml += "         <td>"+strPdName+"</td>";
      rtnHtml += "         <th style='width:170px'>식품유형</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>생산자및소재지(수입품의경우 생산자,수입자 및 제조국)</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>제조연월일,유통기한또는품질유지기한</th>";
      rtnHtml += "         <td>상품입고시 마다 제조일이 상이하여 유통기한이 다릅니다.배송되는 상품은 선입선출에 의해 출고되오니 안심하고 구입하시기 바랍니다. 유통기한에 대한 궁금하신사항은 문의글이나 전화를 주시면 상세히 안내해 드리겠습니다.</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>농수축산물품질관리법상 유전자변형농산물 표시,지리적 표시</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>축산물법에 따른등급표시,쇠고기의 경우 이력관리에 따른 표시유무</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>포장단위별 용량(중량),수량</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>원재료명 및 함량</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>영양성분(식품위생법에 따른 영양성분 표시대상 식품에 한함)</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>유전자재조합식품에 해당하는 경우의 표시</th>";
      rtnHtml += "         <td>해당없음</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>영유아식 또는 체중조절식품 등에 해당하는 경우 표시광고 사전 심의필 유무 및 부작용발생 가능성</th>";
      rtnHtml += "         <td>해당없음</td>";
      rtnHtml += "         <th>수입식품에 해당하는 겨우 &quot;식품위생법에 따른 수입신고를 필함&quot;의 문구</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>섭취량,섭취방법,섭취시주의사항</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>보관방법/취급방법</th>";
      rtnHtml += "         <td>냉동보관하시기 바랍니다</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>소비자상담관련전화번호</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>&nbsp;</th>";
      rtnHtml += "         <td>&nbsp;</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "   </tbody>";
      rtnHtml += "</table>";
   }
   
   //비식품
   else if(topCagoId == '120000000' || topCagoId == '060000000000'){      //060000000000
      rtnHtml += "<p>전자상거래 등에서의 상품정보제공고시(비식품)</p>";
      rtnHtml += "<table>";
      rtnHtml += "   <tbody>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th style='width:170px'>상품명</th>";
      rtnHtml += "         <td>"+strPdName+"</td>";
      rtnHtml += "         <th style='width:170px'>재질</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>구성품</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>크기</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>동일모델의출시년월</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>제조자,수입자</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>품질보증기준</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>제조국</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>생산자및소재지(수입품의경우 생산자,수입자 및 제조국)</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>보관방법/취급방법</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>소비자상담관련전화번호</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>&nbsp;</th>";
      rtnHtml += "         <td>&nbsp;</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "   </tbody>";
      rtnHtml += "</table>";
   
   //기타
   }else{      
      rtnHtml += "<p>전자상거래 등에서의 상품정보제공고시</p>";
      rtnHtml += "<table>";
      rtnHtml += "   <tbody>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th style='width:170px'>상품명</th>";
      rtnHtml += "         <td>"+strPdName+"</td>";
      rtnHtml += "         <th style='width:170px'>재질</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>구성품</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>크기</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>동일모델의출시년월</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>제조자,수입자</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>품질보증기준</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>제조국</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>생산자및소재지(수입품의경우 생산자,수입자 및 제조국)</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>보관방법/취급방법</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "      <tr>";
      rtnHtml += "         <th>소비자상담관련전화번호</th>";
      rtnHtml += "         <td>상세설명참조</td>";
      rtnHtml += "         <th>&nbsp;</th>";
      rtnHtml += "         <td>&nbsp;</td>";
      rtnHtml += "      </tr>";
      rtnHtml += "   </tbody>";
      rtnHtml += "</table>";
   }
   
   return rtnHtml;   
}
//############### 카테고리 별 상품 상세정보 #################

/* 첨부파일 삭제 */
function fn_fileDelete(obj, ATFL_ID, ATFL_SEQ) {
   if( "${productInfo.ATFL_ID }" == ATFL_ID && $(':radio[name="mainFileOrdrIn"]:checked').val() == ATFL_SEQ){
      alert("대표이미지는 삭제할 수 없습니다.");
      return;
   }
   
   if(!confirm("삭제하시겠습니까?")) return;
   
   $("#delATFL_ID").val(ATFL_ID);
   $("#delATFL_SEQ").val(ATFL_SEQ);
   
   $.ajax({
         type:"POST",
         url:"${contextPath}/common/commonFileDelete",
         data: $("form[name='delFrm']").serialize(),
         success : function(data) {
         var result = data.result;
         var contents = "";
            
             $('.file_'+ATFL_ID+'_'+ATFL_SEQ).remove();
             obj.remove();
         },
         error : function(xhr, status, error) {
         alert(error);
         }
   });
}

/* 첨부파일 이미지보기 */
var img1= new Image(); 
function doImgPop(img){ 
   img1= new Image(); 
   img1.src=(img); 
   imgControll(img); 
}
function imgControll(img){ 
   if((img1.width!=0)&&(img1.height!=0)){ 
      viewImage(img); 
   } 
   else{ 
      controller="imgControll('"+img+"')"; 
      intervalID=setTimeout(controller,20); 
   } 
}
function viewImage(img){ 
   W=img1.width+20; 
   H=img1.height+20; 
   O="width="+W+",height="+H+",scrollbars=yes"; 
   imgWin=window.open("","",O); 
   imgWin.document.write("<html><head><title>:: 이미지상세보기 ::</title></head>");
   imgWin.document.write("<body topmargin=0 leftmargin=0>");
   imgWin.document.write("<img src="+img+" onclick='self.close()' style='cursor:pointer;' title ='클릭하시면 창이 닫힙니다.'>");
   imgWin.document.close();
}

/* 제품할인 계산 */
/* function calculPrice(){   
   var pddcGubn =$(':radio[name="PDDC_GUBN"]:checked').val();            //할인구분
   var pddcVal = Number($('#PDDC_VAL').val().replace(/[^\d]+/g, ''));      //할인값
   var pdPrice = Number($('#PD_PRICE').val().replace(/[^\d]+/g, ''));      //제품값
   // 제품할인 계산
   if(pddcGubn == 'PDDC_GUBN_02'){
      $('#PDDC_PRICE').val((pdPrice - pddcVal).toLocaleString());   
   }else if(pddcGubn == 'PDDC_GUBN_03'){
      $('#PDDC_PRICE').val((pdPrice - (pdPrice * (pddcVal/100))).toLocaleString());
   }else{
      $('#PDDC_PRICE').val(pdPrice.toLocaleString());
   }
   
   if(pddcGubn == 'PDDC_GUBN_01' || pddcGubn == 'PDDC_GUBN_05'){
      $('#PDDC_PRICE').val(0);
   }
} */

/* 리테일 카테고리 체크 */
function fn_chk_rta_yn(){
   var strChkVal = $("input:radio[name='RETAIL_YN']:checked").val();
   // 리테일 분류 사용시 필수값
   if(strChkVal == 'Y'){
      $('.retail').show();
      $('#RETAIL_GUBN').attr("required", true);
   }else{
      $('.retail').hide();
      $('#RETAIL_GUBN').attr("required", false);
   }
}

/* 박스할인 필수값 */
function fn_boxpddc_disabled(){
   var strChkVal = $("input:radio[name='BOX_PDDC_GUBN']:checked").val();
   
   if(strChkVal == "PDDC_GUBN_01"){
      $("#BOX_PDDC_VAL").val("0");
      $("#BOX_PDDC_VAL").next().text("원");
      $("#BOX_PDDC_VAL").attr("readonly",true);
      $("#INPUT_CNT").attr("required", false);
      
   }else if(strChkVal == "PDDC_GUBN_03"){
      $("#BOX_PDDC_VAL").next().text("%");
      $("#BOX_PDDC_VAL").attr("readonly",false);
      $("#INPUT_CNT").attr("required", true);
      
   }else {
      $("#BOX_PDDC_VAL").next().text("원");
      $("#BOX_PDDC_VAL").attr("readonly", true);   //false
      $("#INPUT_CNT").attr("required", false);   //true
   }
}

/* 제품할인 필수값 */
function fn_pddc_disabled(){
   var strChkVal = $("input:radio[name='PDDC_GUBN']:checked").val();
   
   if(strChkVal == "PDDC_GUBN_01"){
      $("#PDDC_VAL").val("0");
      $("#PDDC_VAL").next().text("원");
      $("#PDDC_VAL").attr("readonly",true);
      
   }else if(strChkVal == "PDDC_GUBN_03"){
      $("#PDDC_VAL").next().text("%");
      $("#PDDC_VAL").attr("readonly",false);
      
   }else{
      $("#PDDC_VAL").next().text("원");
      $("#PDDC_VAL").attr("readonly",false);
   }
}

/* 공백제거 */
function fn_trimstring(obj) {
   var id = obj.getAttribute('id');
   
   if(obj.value != "" || obj.value != null){
      $("#"+id).val(obj.value.replace(/(\s*)/g, ""));
   }   
}

/* 상품검색 조회 결과 (사용안함) */
function fn_popup_return(GOODS_CODE,POS_NAME,CAGO_ID,CAGO_NAME) {   
   $("#PD_NAME").val(POS_NAME);
   
   if(CAGO_ID != ""){
      $("#CAGO_NAME").val(CAGO_NAME);
      $("#CAGO_ID").val(CAGO_ID);
   }   
}

// 옵션 추가 20211110 minu
function addoption(){
    var html = ''
    var num = $("#pdOptionCreate").find("TR").length;

    if(num < 3){
        html +="<tr id='optionTR"+num+"'>";
        html +=    "<td>";
        html +=        '<input class="optionName option_input" type="text" placeholder="ex) 색상">';
        html +=    '</td>';
        html +=    '<td>';
        html +=        '<input class="optionValue option_input" type="text"  placeholder="ex) 빨강,노랑,파랑 (,로 구분)">';
        html +=    '</td>';
	    html +=    '<td style="text-align:center;"><input  class="btn btn-warning" type="button" name="test" class="delBtn btn btn-warning" onclick="delOption('+num+')" style="width: 100%;" value="x"/></td>';
        html +='</tr>';
        
        $("#pdOptionCreate").append(html);
    }else{
        alert("옵션은 최대 3개 까지 추가 할 수 있습니다.");
    }
};

// 추가된 옵션 삭제 20211110 minu
function delOption(num){
    $("#optionTR"+num).remove();
}

// 옵션 목록으로 20211110 minu
function sendToList(){
    var names = new Array;
    
    var value1 = new Array;
    var value2 = new Array;
    var value3 = new Array;
    var values = [value1,value2,value3];
    var opList = [];
    var opCnt = $(".optionName").length;

    for(var i=0; i < opCnt; i++){
        names.push($(".optionName")[i].value);
        values[i] = $(".optionValue")[i].value.split(','); 
    }
    for(var i =0; i<values[0].length;i++){
        var option1 = values[0][i];
        if(values[1].length>0){
            for(var j =0; j<values[1].length;j++){
                var option2 = values[1][j];
                if(values[2].length>0){
                    for(var g =0; g<values[2].length;g++){
                        var option3 = values[2][g];
                        opList.push(names[0]+","+names[1]+','+names[2]+"$#"+option1+','+option2+","+option3);
                    }
                }else{
                    opList.push(names[0]+","+names[1]+'$#'+option1+","+option2);
                }
            }
        }else{
            opList.push(names[0]+'$#'+option1);
        }
    }

    var html = '';
    html +='<table border="1" style="border-color: #d2d6de;">';
    html +=    '<colgroup>';
    html +=        '<col width="3%" />';
    if(opCnt == 1){
        html +=        '<col width="'+18/opCnt+'%" />';
    }else if(opCnt == 2){
        html +=        '<col width="'+18/opCnt+'%" />';
        html +=        '<col width="'+18/opCnt+'%" />';
    }else if(opCnt == 3){
        html +=        '<col width="'+18/opCnt+'%" />';
        html +=        '<col width="'+18/opCnt+'%" />';
        html +=        '<col width="'+18/opCnt+'%" />';
    }
    //html +=        '<col width="18%" />'
    html +=        '<col width="10%" />';
    html +=        '<col width="10%" />';
    html +=        '<col width="10%" />';
    html +=        '<col width="25%" />';
    html +=        '<col width="10%" />';
    html +=      '</colgroup>';
    html +=      '<thead>';
    html +=      '<tr class="option_tr2">';
    html +=          '<th rowspan="2"><input type="checkbox"></th>';
    html +=          '<th colspan="'+opCnt+'">옵션명</th>';
    html +=          '<th rowspan="2">옵션가</th>';
    html +=          '<th rowspan="2">재고수량</th>';
    html +=          '<th rowspan="2">판매상태</th>';
    html +=          '<th rowspan="2">관리코드</th>';
    html +=          '<th rowspan="2">삭제</th>';
    html +=      '</tr>';
    html +=          '<tr class="option_tr3">';
    if(opCnt==1){
        html +=    '<td class="option_name">'+opList[0].split('$#')[0]+'</td>';
    }else if(opCnt==2){
        html +=    '<td class="option_name">'+opList[0].split('$#')[0].split(',')[0]+'</td>';
        html +=    '<td class="option_name">'+opList[0].split('$#')[0].split(',')[1]+'</td>';
    }else if(opCnt==3){
        html +=    '<td class="option_name">'+opList[0].split('$#')[0].split(',')[0]+'</td>';
        html +=    '<td class="option_name">'+opList[0].split('$#')[0].split(',')[1]+'</td>';
        html +=    '<td class="option_name">'+opList[0].split('$#')[0].split(',')[2]+'</td>';
    }
    html +=      '</tr>';
    html +=      '</thead>';
    html +=      '<tbody id="optionList">';
    html +=      '</tbody>';
    html +='</table>';


    $("#opTable").html(html);



    
    
    for(var i =0; i < opList.length;i++){

        html ='';
        html +='<tr class="option_tr3">';
        html +=    '<td><input type="checkbox" class="option_input" name="" id=""></td>';
        if(opCnt==1){
            html +=  '<td><input type="text" class="option1_values option_input" name="OPTION1_VALUE" id="OPTION1_VALUE" value="'+opList[i].split('$#')[1]+'" style="width:60px"></td>';
        }else if(opCnt==2){
            html +=  '<td><input type="text" class="option1_values option_input" name="OPTION1_VALUE" id="OPTION1_VALUE" value="'+opList[i].split('$#')[1].split(',')[0]+'" style="width:60px"></td>';
            html +=  '<td><input type="text" class="option2_values option_input" name="OPTION2_VALUE" id="OPTION2_VALUE" value="'+opList[i].split('$#')[1].split(',')[1]+'" style="width:60px"></td>';
        }else if(opCnt==3){
        	html +=  '<td><input type="text" class="option1_values option_input" name="OPTION1_VALUE" id="OPTION1_VALUE" value="'+opList[i].split('$#')[1].split(',')[0]+'" style="width:60px"></td>';
        	html +=  '<td><input type="text" class="option2_values option_input" name="OPTION2_VALUE" id="OPTION2_VALUE" value="'+opList[i].split('$#')[1].split(',')[1]+'" style="width:60px"></td>';
        	html +=  '<td><input type="text" class="option3_values option_input" name="OPTION3_VALUE" id="OPTION3_VALUE" value="'+opList[i].split('$#')[1].split(',')[2]+'" style="width:60px"></td>';
        }
        html +=    '<td><input type="text" class="price option_input" name="PRICE" id="PRICE" value="0"></td>';
        html +=    '<td><input type="text" class="quantity option_input" name="QUANTITY" id="QUANTITY" value="0"></td>';
        html +=    '<td>';
        html +=        '<select class="sell_yn" name="SELL_YN" id="SELL_YN">';
        html +=            '<option value="Y">Y</option>';
        html +=            '<option value="N">N</option>';
        html +=        '</select>';
        html +=    '</td>';
        html +=    '<td><input type="text" class="mgr_code option_input" name="MGR_CODE" id="MGR_CODE"><input type="hidden" class="option_orig_price" name="OPTION_ORIG_PRICE" id="OPTION_ORIG_PRICE"><input type="button"  name="searchbtn" onclick="searchCode()" value="검색"/></td>';
        html +=    '<td>';
        html +=    '<select class="del_yn"name="DEL_YN" id="DEL_YN">';
        html +=        '<option value="N">N</option>';
        html +=        '<option value="Y">Y</option>';
        html +=    '</select>';
        html +=    '</td>';
        html +='</tr>';
        
        $("#optionList").append(html);
    }
}
//옵션 세팅 저장 20211115 minu
function optionSet(){
	var optionDatas = [];
	var optionNames = [];
	var optionValues = [];
	
	for(var i =0; i < $('.optionName').length;i++ ){
		optionNames.push($('.optionName')[i].value)
		optionValues.push($('.optionValue')[i].value)
	}
	
	console.log('optionNames : ',optionNames);
	console.log('optionValues : ',optionValues);
	
	for(var i =0; i < $(".option1_values").length; i++){
		if(optionNames.length > i){
			var optionName = optionNames[i];
			var optionValue = optionValues[i];
		}else{
			var optionName = '';
			var optionValue = '';
		}
		
		// 옵션 2,3 이 있는지 확인 
		if($(".option2_values").length == 0 ){
			var op2value = ''; 
			var op2name =	'';
			var op3value = ''; 
			var op3name =	'';
		}else{
			var op2value = $(".option2_values")[i].value;
			var op2name = $(".option_name")[1].textContent;
			
			if($(".option3_values").length != 0 ){
				var op3value = $(".option3_values")[i].value;
				var op3name = $(".option_name")[2].textContent;
			}else{
				var op3value = ''; 
				var op3name =	'';
			}
		} 
		
		var optiondata = new Object({'PD_CODE':$("input[name='PD_CODE']")[0].value,
									 'OPTION_NAME':optionName,
									 'OPTION_VALUE':optionValue,
									 'OPTION1_NAME':$(".option_name")[0].textContent,
									 'OPTION1_VALUE':$(".option1_values")[i].value,
									 'OPTION2_NAME':op2name,
									 'OPTION2_VALUE':op2value,
									 'OPTION3_NAME':op3name,
									 'OPTION3_VALUE':op3value,
									 'PRICE':$(".price")[i].value,
									 'QUANTITY':$(".quantity")[i].value,
									 'SELL_YN':$(".sell_yn")[i].value,
									 'MGR_CODE':$(".mgr_code")[i].value,
									 'OPTION_ORIG_PRICE':$(".option_orig_price")[i].value,
									 'DEL_YN':$(".del_yn")[i].value});	
		optionDatas.push(optiondata);
	}
	
	 $.ajax({
		type: "POST",
	    url: "${contextPath}/adm/productMgr/optionSetting",
	    data: {
	    	data : JSON.stringify(optionDatas)
	    },
	    traditional: true,
	    success: function (data) {
	   		alert("상품 옵션이 저장되었습니다.");
	    }, error: function (jqXHR, textStatus, errorThrown) {
	       alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
	    }
	});	
}


//옵션 세팅 저장 20211115 minu
function optionSet_TotSave(){
	var optionDatas = [];
	var optionNames = [];
	var optionValues = [];
	
	for(var i =0; i < $('.optionName').length;i++ ){
		optionNames.push($('.optionName')[i].value)
		optionValues.push($('.optionValue')[i].value)
	}
	
	console.log('optionNames : ',optionNames);
	console.log('optionValues : ',optionValues);
	
	for(var i =0; i < $(".option1_values").length; i++){
		if(optionNames.length > i){
			var optionName = optionNames[i];
			var optionValue = optionValues[i];
		}else{
			var optionName = '';
			var optionValue = '';
		}
		
		// 옵션 2,3 이 있는지 확인 
		if($(".option2_values").length == 0 ){
			var op2value = ''; 
			var op2name =	'';
			var op3value = ''; 
			var op3name =	'';
		}else{
			var op2value = $(".option2_values")[i].value;
			var op2name = $(".option_name")[1].textContent;
			
			if($(".option3_values").length != 0 ){
				var op3value = $(".option3_values")[i].value;
				var op3name = $(".option_name")[2].textContent;
			}else{
				var op3value = ''; 
				var op3name =	'';
			}
		} 
		
		var optiondata = new Object({'PD_CODE':$("input[name='PD_CODE']")[0].value,
									 'OPTION_NAME':optionName,
									 'OPTION_VALUE':optionValue,
									 'OPTION1_NAME':$(".option_name")[0].textContent,
									 'OPTION1_VALUE':$(".option1_values")[i].value,
									 'OPTION2_NAME':op2name,
									 'OPTION2_VALUE':op2value,
									 'OPTION3_NAME':op3name,
									 'OPTION3_VALUE':op3value,
									 'PRICE':$(".price")[i].value,
									 'QUANTITY':$(".quantity")[i].value,
									 'SELL_YN':$(".sell_yn")[i].value,
									 'MGR_CODE':$(".mgr_code")[i].value,
									 'OPTION_ORIG_PRICE':$(".option_orig_price")[i].value,
									 'DEL_YN':$(".del_yn")[i].value});	
		optionDatas.push(optiondata);
	}
	
	 $.ajax({
		type: "POST",
	    url: "${contextPath}/adm/productMgr/optionSetting",
	    data: {
	    	data : JSON.stringify(optionDatas)
	    },
	    traditional: true,
	    success: function (data) {

	    }, error: function (jqXHR, textStatus, errorThrown) {
	       alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
	    }
	});	
}

var target;

/* 배송비 기본 설정 - 이유리 */
var pd_code = $('input[name="PD_CODE"]').val();
//배송비 상세 정보 저장 팝업

/* 배송비 기본 설정 - 이유리 */
function loadShipping(){
	window.open("/adm/productMgr/getShippingPop?PD_CODE=" + pd_code, "_blank", "width=900,height=500");
}

//템플릿 관리 팝업
function loadTemplete(){
	window.open("/adm/productMgr/getTempletePop", "_blank", "width=900,height=500"); 	
}


//상품옵션검색
function searchCode(){
	target = event.target;
	if($('input[name="SUPR_ID"]').val() != null && $('input[name="SUPR_ID"]').val() !=''){
		var SUPR_ID=$('input[name="SUPR_ID"]').val();
	}else if($('input[name="SUPR_ID"]').val() == null || $('input[name="SUPR_ID"]').val() ==''){
		var SUPR_ID=$('#supr').val();
	}
	window.open("/adm/productMgr/searchPop/"+SUPR_ID, "_blank", "width=900,height=700"); 
	
};

//관리코드 부모창으로 전달(2022.01.10장보라)
function selectCodeParent(pdCode, lnvenQty, pdPrice){
	var parent=target.parentNode; //target의 부모
	var pd_price=document.getElementById("PD_PRICE").value.replace(/[^\d]+/g, ''); //PD_PRICE
	var option_price = parseInt(pdPrice) - parseInt(pd_price); //옵션가격 결정
	console.log(pdCode,lnvenQty,pdPrice, option_price);

	$(target).prev().val(pdPrice);	//OPTION_ORIG_PRICE
	$(target).prev().prev().val(pdCode);	//PD_CODE
	$(target).parent().prev().prev().children().val(lnvenQty); //재고수량
	$(target).parent().prev().prev().prev().children().val(option_price);//PD_PRICE-OPTION_ORIG_PRICE
}

//매출가 이벤트 (옵션가 가격 변경/2022.01.10장보라)
function keyevent(){
	var mgr_code=[]; //관리코드
	var option_origin_Price=[]; //옵션 original 가격
	var optionlength=document.querySelectorAll("input[name='MGR_CODE']").length; //옵션의 length
	var change_price=document.getElementById("PD_PRICE").value.replace(/[^\d]+/g, ''); //PD_PRICE변경된
	
	for(var i=0; i<optionlength;i++){
		mgr_code[i] = document.querySelectorAll("input[name='MGR_CODE']")[i].value;
		option_origin_Price[i]= document.querySelectorAll("input[name='OPTION_ORIG_PRICE']")[i].value;
		 	//관리코드가 있을시 옵션가 변경	
		 	if(mgr_code[i] !='' && mgr_code[i] != null){
		 		var changePrice = parseInt(option_origin_Price[i])-parseInt(change_price); //변경될 옵션가격
				document.getElementsByName("PRICE")[i].value=changePrice;
			}
		}
}

//다른상품 옵션불러오기
function loadOption(){
	window.open("/adm/productMgr/getOptionPop/${productInfo.SUPR_ID}", "_blank", "width=900,height=900");  
}

//추가상품 불러오기
function extraPrd(){
	if($('input[name="SUPR_ID"]').val() != null && $('input[name="SUPR_ID"]').val() !=''){
		var SUPR_ID=$('input[name="SUPR_ID"]').val();
	}else if($('input[name="SUPR_ID"]').val() == null || $('input[name="SUPR_ID"]').val() ==''){
		var SUPR_ID=$('#supr').val();
	}
	window.open("/adm/productMgr/getExtraPrd/"+SUPR_ID, "_blank", "width=900,height=900"); 
}
function getOption(code){
	console.log(code);
	// ajax로 선택된 상품 옵션 불러오기 
	$.ajax({
		type: "POST",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	    url: "${contextPath}/adm/productMgr/getOptiontitle",
	    data: {
	    	data : code
	    },
	    traditional: true,
	    success: function (data) {
	   		console.log(data);
	   		var str = data;
	   		var jsonObj = $.parseJSON('[' + str + ']');
	   		var html ='';
	   		for(var i =0;i<jsonObj.length;i++){
	   		
		   		html += '<tr id="optionTR'+i+'">';
	   			html +=    '<td>';
				html +=        '<input class="optionName option_input" type="text" placeholder="ex) 색상" value="'+jsonObj[i].name+'">';
				html +=    '</td>';
				html +=    '<td>';
				html +=         '<input class="optionValue option_input" type="text" placeholder=\'ex) 빨강,노랑,파랑 (","로 구분)\' value="'+jsonObj[i].value+'">';
				html +=     '</td>';
				html +=     '<td style="text-align: center;">';
				if(i==0){
					html +=    	'<input type="button" id="addOption" onclick="addoption()" value="+" style="width: 100%;" class="btn btn-warning"/>';	
				}else{
					html +=    	'<input type="button" id="addOption" onclick="delOption('+i+')" value="x" style="width: 100%;" class="btn btn-warning"/>';
				}
				
				html +=    '</td>';
				html +='</tr>';
				
	   		}
	   		
	   		$("#pdOptionCreate").html(html);
	   		
	   		sendToList();
	   		
	    }, error: function (jqXHR, textStatus, errorThrown) {
	       alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
	    }
	});	
}
	function getExtraPrd(code){
		console.log('getExtraPrd : '+code);
		// ajax로 선택된 상품 옵션 불러오기 
		$.ajax({
			type: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		    url: "${contextPath}/adm/productMgr/getExtraPrdlist",
		    data: {
		    	data : code
		    },
		    traditional: true,
		    success: function (data) {
		   		console.log("data : " + data);
		   		var str = data;
		   		var jsonObj = $.parseJSON('[' + str + ']');
		   		var html ='';
		   		
		   		// 추가상품 테이블에 추가 
		   		 for(var i =0;i<jsonObj.length;i++){
		   		
			   		html += '<tr>';
		   			html +=    '<td>';
					html +=        '<input name="extrPrd" type="checkbox" value="'+jsonObj[i].PD_CODE+'">';
					html +=    '</td>';
		   			html +=    '<td>';
					html +=        jsonObj[i].PD_NAME
					html +=    '</td>';
					html +=    '<td>';
					html +=         '<input class="optionValue option_input" type="text" value="'+jsonObj[i].PD_PRICE+'">';
					html +=     '</td>';
					html +=    '<td>';
					html +=         '<input class="optionValue option_input" type="text" value="'+jsonObj[i].PD_CODE+'">';
					html +=     '</td>';
					html +='</tr>';
					
		   		} 
		   		
		   		$("#extraProducts").append(html);
		   		
		   		extraPrdSave();
		   		
		    }, error: function (jqXHR, textStatus, errorThrown) {
		       alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
		    }
		});	
}
	function selectAll(){
		$("input[name='extrPrd']").click();
	}
	
	function extraPrdSave(){
		var pd_code = $('input[name="PD_CODE"]').val();
		var extraprds = new Array();
		var prdlist = $("input[name='extrPrd']");
		for(var i =0; i<prdlist.length; i++){
			extraprds.push(prdlist[i].value);
		}
		if(extraprds.length > 0){
			$.ajax({
				type: "POST",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			    url: "${contextPath}/adm/productMgr/updateExtraPrdlist",
			    data: {
			    	PD_CODE : pd_code,
			    	data : extraprds,
			    	type : "insert"
			    },
			    traditional: true,
			    success: function (data) {
			   		console.log("data : " + data);
			   		//alert('추가상품 '+data +'개 저장 완료 ')
			   		if(data == '0' ){
			   			location.reload();
			   		}
			    }, error: function (jqXHR, textStatus, errorThrown) {
			       alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
			    }
			});	
		}else{
			//alert("추가할 상품을 1개이상 선택해 주세요.")	
		}
	}
	
	function extraPrdDelete(){
		var pd_code = $('input[name="PD_CODE"]').val();
		var extraprds = new Array();
		var prdlist = $("input[name='extrPrd']:checked");
		for(var i =0; i<prdlist.length; i++){
			extraprds.push(prdlist[i].value);
		}
		if(extraprds.length > 0){
			$.ajax({
				type: "POST",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			    url: "${contextPath}/adm/productMgr/updateExtraPrdlist",
			    data: {
			    	PD_CODE : pd_code,
			    	data : extraprds,
			    	type : "delete"
			    },
			    traditional: true,
			    success: function (data) {
			   		console.log("data : " + data);
			   		$('input[name="extrPrd"]:checked').parents('TR').remove();
			   		alert('추가상품 '+data +'개 삭제 완료 ')
			   		
			    }, error: function (jqXHR, textStatus, errorThrown) {
			       alert("처리중 에러가 발생했습니다. 관리자에게 문의 하세요.(error:"+textStatus+")");
			    }
			});	
		}else{
			alert("삭제할 상품을 1개이상 선택해 주세요.");
		}
	}

//반품 주소지 
function fn_selectValue(addNum, comPn, comBadr, comDadr){
	document.getElementById("ADD_NUM").value=addNum;
	document.getElementById("COM_PN").value=comPn;
	document.getElementById("COM_BADR").value=comBadr;
	document.getElementById("COM_DADR").value=comDadr;
	}
	
//옵션삭제
function optionDelete(main_code){
	console.log(main_code);
	
  	if(!confirm("삭제 하시겠습니까?")) return;
  	
  	$.ajax({
  		url: "${contextPath}/adm/productMgr/optionDelete",
  		method: "POST",
  		data: {MAIN_CODE : main_code},
 		success: function (message) {
  			if(message=="success"){
  				alert("옵션삭제를 완료하였습니다.");
  				location.reload();
  			}else{
  				alert("에러가 발생하였습니다. 관리자에게 문의하세요.");
  				location.reload();
  			}
  		}, 
  		error: function (jqXHR, textStatus, errorThrown) {
  			alert("에러가 발생하였습니다. 관리자에게 문의하세요");
  		}
  	});
	
}
	
</script>