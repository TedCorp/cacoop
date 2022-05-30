<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>

<section class="content-header">
	<h1>광고관리</h1>
</section>

<c:set var="strActionUrl" value="${contextPath }/adm/adMgr" />
<c:set var="strMethod" value="post" />
<c:if test="${ !empty adinfo.AD_ID }">
	<c:set var="strActionUrl" value="${contextPath }/adm/adMgr/edit" />
	<c:set var="strMethod" value="put" />
</c:if>

<section class="content">
	<!-- 광고 정보 시작 -->
	<spform:form name="saveFrm" id="saveFrm" method="${strMethod}" action="${strActionUrl}" class="form-horizontal" enctype="multipart/form-data" >
		<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">광고정보</h3>
			</div>
			<!-- /.box-header -->

			<!-- box-body -->
			<div class="box-body">
				<div class="form-group">
					<input type="hidden" id="pageNum" name="pageNum" value="${param.pageNum }" /> 
					<input type="hidden" id="rowCnt" name="rowCnt" value="${param.rowCnt }" /> 
					<input type="hidden" id="schTxt" name="schTxt" value="${param.schTxt }" /> 
					<input type="hidden" id="ATFL_ID" name="ATFL_ID" value="${eventInfo.ATFL_ID }">	
					
					<label class="col-sm-2 control-label">광고번호</label>
						<div class="col-sm-8">
							<c:if test="${ !empty eventInfo.AD_ID }">
								<input type="text" class="form-control" id="AD_ID" name="AD_ID" value="${eventInfo.AD_ID }" readonly="readonly" />
							</c:if>
							<c:if test="${ empty eventInfo.AD_ID }">
								<p class="form-control-static">자동 생성</p>
							</c:if>
						</div>
				</div>


				<c:if test="${ !empty eventInfo.AD_ID }">
					<div class="form-group">
						<label class="col-sm-2 control-label">광고 주소</label>
						<div class="col-sm-8">
							<p class="form-control-static">${currentUrl }/adNew?AD_ID=${eventInfo.AD_ID }</p>
							<p class="form-control-static">유성점 : ${currentUrl }/adYs</p>
							<p class="form-control-static">둔산점 : ${currentUrl }/adDs</p>
							<p class="form-control-static">삼성점 : ${currentUrl }/adCj</p>
						</div>
					</div>
				</c:if>
						
				<div class="form-group">
					<label class="col-sm-2 control-label">광고명</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="AD_NAME" name="AD_NAME" value="${eventInfo.AD_NAME }" placeholder="광고명" />
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label">광고기간 시작</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="START_DT" name="START_DT" value="${eventInfo.START_DT }" placeholder="예) 2017.02.06(월)" style="width:150px;" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">광고기간 종료</label>
					<div class="col-sm-10">
						<input
							type="text" class="form-control" id="END_DT" name="END_DT" value="${eventInfo.END_DT }" placeholder="예) 02.11(토)" style="width:150px;" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">광고 마감 여부</label>
					<div class="col-sm-10">
						<c:set var="END_YN" value="N" />
						<c:if test="${ !empty eventInfo.AD_ID }">
							<c:set var="END_YN" value="${ eventInfo.END_YN }" />
						</c:if>

						<label class="check" style="margin-right: 10px">
							<input type="radio" class="iradio" name="END_YN" value="N" ${END_YN eq 'N' ? 'checked' : '' } /> 사용중
						</label>
						<label class="check" style="margin-right: 10px"> 
							<input type="radio" class="iradio" name="END_YN" value="Y" ${END_YN eq 'Y' ? 'checked' : '' }/> 마감
						</label> 

					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label">광고 상단 타입</label>
					<div class="col-md-10">
						<div class="input-group">
							<label class="check" style="width:100%">
								<input type="radio" class="iradio" name="TOP_TYPE" value="1" ${ eventInfo.TOP_TYPE eq '1' ? 'checked' : '' } />
								<img src="${contextPath}/resources/img/sub/ad/header_type1.gif" alt=""/>
							</label>
							<label class="check" style="width:100%">
								<input type="radio" class="iradio" name="TOP_TYPE" value="2" ${ eventInfo.TOP_TYPE eq '2' ? 'checked' : '' } />
								<img src="${contextPath}/resources/img/sub/ad/header_type2.gif" alt=""/>
							</label>
							<label class="check" style="width:100%">
								<input type="radio" class="iradio" name="TOP_TYPE" value="3" ${ eventInfo.TOP_TYPE eq '3' ? 'checked' : '' } />
								<img src="${contextPath}/resources/img/sub/ad/header_type3.gif" alt=""/>
							</label>
							<label class="check" style="width:100%">
								<input type="radio" class="iradio" name="TOP_TYPE" value="0" ${ eventInfo.TOP_TYPE eq '0' ? 'checked' : '' } />
								이미지 직접 등록
							</label>

						</div> 
					</div>

				</div>
				
				<div class="form-group" id="divTopFile">
					<label class="col-md-2 control-label">광고 상단 이미지<br><a href="${contextPath}/upload/template/woori_sample.psd" target="_blank">[PSD 샘플 다운]</a></label>
					<div class="col-md-3">
						<input type="hidden" name="TOP_ATFL" id="file-simple" value="${eventInfo.TOP_ATFL }">
						${eventInfo.TOP_ATFL }
						<input type="file" id="topFile" name="topFile" id="file-simple"> 1100px * 600px
					</div>
				</div>

				<div class="form-group">
					<label class="col-md-2 control-label">상품 이미지</label>
					<div class="col-md-3">
						<input type="file" id="pdImgFile" multiple name="pdImgFile" id="file-simple" value="${eventInfo.TOP_ATFL }"> 예) 상품ID.jpg
					</div>
				</div>
				
				<div class="form-group">
					<label for="PD_DINFO" class="col-md-2 control-label">광고상세정보</label>
					<div class="col-md-8">
						<textarea name="AD_DESC" id="AD_DESC" class="form-control" rows="5">${eventInfo.AD_DESC } </textarea>
						<!-- input name="AD_DESC" id="AD_DESC" type="hidden" / -->
					</div>
				</div>

				<!-- 광고 정보 끝 -->

			</div>
			<!-- /.box-body -->
		</div>
		<div class="row">
			<div class="col-xs-12">
				<a href="${contextPath}/adm/adMgr?pageNum=${param.pageNum }&rowCnt=${param.rowCnt }${link}" class="btn btn-success pull-right" style="margin-left: 10px; margin-bottom: 20px;">
				<i class="fa fa-list"></i> 목록 </a>
				<button type="button" class="btn btn-success pull-right btnSave" style="margin-left: 10px; margin-bottom: 20px;">
					<i class="fa fa-save"></i> 저장 </button>
				<c:if test="${ !empty eventInfo.AD_ID }">
					<button type="button" class="btn btn-success pull-right btnView" style="margin-left: 10px; margin-bottom: 20px;">
						<i class="fa fa-clone"></i> 미리보기 </button>
					<button type="button" class="btn btn-info pull-right btnChartView" style="margin-left: 10px; margin-bottom: 20px;">
						<i class="fa fa-area-chart"></i> 접속통계 </button>
					<button type="button" class="btn btn-danger pull-right btnDel" style="margin-left: 10px; margin-bottom: 20px;">
						<i class="fa fa-remove"></i> 광고 삭제 </button>
				</c:if>
			</div>
		</div>
		
		<%//등록할때 안나오게 %>
		<c:if test="${ !empty eventInfo.AD_ID }">
	
			<!-- 상품 정보 시작 -->
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">상품목록 </h3>
					* 체크 박스 선택 후 <span class="label label-primary">저장</span>버튼을 클릭하면 상품이 삭제 됩니다. 상품이미지는 상품ID.jpg로 자동 생성됩니다.
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<div class="row">
						<div class="col-xs-12">
							총 ${detailListCnt } 개의 상품이 조회
							<c:if test="${ !empty eventInfo.AD_ID }">
								<button type="button" class="btn btn-primary pull-right btnExcelUpload" style="margin-right: 10px; margin-bottom: 20px;">
									<i class="fa fa-file-excel-o"></i> 상품 엑셀 업로드 </button>
							</c:if>
							<button type="button" class="btn btn-primary pull-right btnAdd" style="margin-right: 10px; margin-bottom: 20px;">
								<i class="fa fa-plus"></i> 상품 추가 </button>
							<!-- button type="button" class="btn btn-primary pull-right btnCopyPopup" style="margin-right: 10px; margin-bottom: 20px;">
								<i class="fa fa-copy"></i> 복사 추가 </button -->
						</div>
					</div>
					
					<table class="table table-bordered">
						<thead>
							<tr>
								<th><input type="checkbox" id="allCheck" /></th>
								<th style="width:120px;">상품ID</th>
								<th>상품명</th>
								<th style="width:80px;">정상가</th>
								<th style="width:80px;">판매가</th>
								<th style="width:50px;">정렬</th>
							</tr>
						</thead>
						<tbody id="pdtAdd">
							<c:forEach items="${detailList }" var="ent" varStatus="loop">
								<tr>
									<td>
										<input type="checkbox" name="chkYn" />
										<input type="hidden" name="DEL_YNS" value="${ent.DEL_YN }" />
										<input type="hidden" name="FLAGS" value="U" />
									</td>
									<td><input class="form-control input-sm" type="text" name="PD_IDS" value="${ent.PD_ID }" readonly="readonly"/></td>
									<td><input class="form-control input-sm" type="text" name="PD_NAMES" value="${ent.PD_NAME }" /></td>
									<td><input class="form-control input-sm number" type="text" name="PD_PRICES" value="<fmt:formatNumber value="${ent.PD_PRICE }" />"></td>
									<td><input class="form-control input-sm number" type="text" name="SELL_PRICES" value="<fmt:formatNumber value="${ent.SELL_PRICE }" />"></td>
									
									<td><input class="form-control input-sm" type="text" name="ORDS" value="${ent.ORD }"></td>
								</tr>
							</c:forEach>
							<c:if test="${ empty detailList}">
								<tr id="trNoData">
									<td colspan="6">등록된 상품이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					
					<%//상품 목록이 20개 이상일때 하단 버튼 표시 %>
					<c:if test="${ fn:length(detailList) > 20 }">
						<div class="row">
							<div class="col-xs-12">
								<c:if test="${ !empty eventInfo.AD_ID }">
									<button type="button" class="btn btn-primary pull-right btnExcelUpload" style="margin: 20px 10px 20px 0;">
										<i class="fa fa-file-excel-o"></i> 상품 엑셀 업로드 </button>
								</c:if>
								<button type="button" class="btn btn-primary pull-right btnAdd" style="margin: 20px 10px 20px 0;">
									<i class="fa fa-plus"></i> 상품 추가 </button>
								<!-- button type="button" class="btn btn-primary pull-right btnCopyPopup" style="margin: 20px 10px 20px 0;">
									<i class="fa fa-copy"></i> 복사 추가 </button -->
							</div>
						</div>
					</c:if>
				</div>
			</div>
			<!-- 상품 정보 끝 -->
			
			<%//상품 목록이 20개 이상일때 하단 버튼 표시 %>
			<c:if test="${ fn:length(detailList) > 20 }">
			<div class="row">
				<div class="col-xs-12">
					<a href="${contextPath}/adm/adMgr?pageNum=${param.pageNum }&rowCnt=${param.rowCnt }${link}" class="btn btn-success pull-right" style="margin-left: 10px;">
					<i class="fa fa-list"></i> 목록 </a>
					<button type="button" class="btn btn-success pull-right btnSave" style="margin-left: 10px;">
						<i class="fa fa-save"></i> 저장 </button>
					<c:if test="${ !empty eventInfo.AD_ID }">
						<button type="button" class="btn btn-success pull-right btnView" style="margin-left: 10px;">
							<i class="fa fa-clone"></i> 미리보기 </button>
						<button type="button" class="btn btn-info pull-right btnChartView" style="margin-left: 10px; margin-bottom: 20px;">
							<i class="fa fa-area-chart"></i> 접속통계 </button>
						<button type="button" class="btn btn-danger pull-right btnDel" style="margin-left: 10px; margin-bottom: 20px;">
							<i class="fa fa-remove"></i> 광고 삭제 </button>
					</c:if>
				</div>
				</c:if>
			</div>
		</c:if>
	</spform:form>
</section>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">상품 엑셀 업로드</h4>
			</div>
			<div class="modal-body">
            <form role="form">
            </form>
				<!-- 기업정보 박스 -->
					<div class="box box-info">
						<div class="box-header with-border">
							<h3 class="box-title">업로드</h3>
						</div>
						<!-- /.box-header -->
					
						<!-- box-body -->
						<spform:form name="excelFrm" id="excelFrm" method="post" action="${contextPath }/adm/adMgr/excelUpload" role="form" class="form-horizontal" enctype="multipart/form-data">
						<input type="hidden" name="AD_ID" value="${eventInfo.AD_ID }" />
						<div class="box-body">

							<div class="form-group">
								<label for="MEMB_ID" class="col-sm-2 control-label">양식파일</label>
								<div class="col-sm-10">
									<button type="button" class="btn btn-primary pull-left" id="btnExcelDown"><i class="fa fa-download"></i> 양식 받기 </button>
								</div>
							</div>
							<div class="form-group">
								<label for="MEMB_MAIL" class="col-sm-2 control-label">중복처리</label>
								<div class="col-sm-10">
				                  <div class="checkbox">
				                    <label>
				                      <input name="CHK_UPDATE" value="Y" type="checkbox">상품ID 중복시 엑셀파일 데이타로 덮어쓰기
				                    </label>
				                  </div>
								</div>
							</div>
							<div class="form-group">
								<label for="MEMB_NAME" class="col-sm-2 control-label">엑셀파일</label>
								<div class="col-sm-10">
									<input type="file" id="EXCEL_FILE" name="EXCEL_FILE" id="file-simple" value=""> 
								</div>
							</div>

						</div>
						</spform:form>
						<!-- /.box-body -->
					</div>
				<!-- 기업정보 박스 -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="btnExcelSave">업로드</button>
			</div>
		</div>
	</div>
</div>

<!-- 통계 -->
<div class="modal fade" id="divChartView" tabindex="-1" role="dialog" aria-labelledby="divChartViewLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="divChartViewLabel">접속 통계</h4>
			</div>
			<div class="modal-body">
				<c:if test="${empty logList }">통계 데이타가 없습니다.</c:if>
				<div class="chart" id="divLineChart" style="height:250px">
					<canvas id="lineChart" style="height:250px"></canvas>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(function() {

		<c:if test="${ eventInfo.TOP_TYPE ne '0' }">
			$("#divTopFile").hide();		//탑이미지 입력 숨김
		</c:if>
			
	    //숫자만 입력토록 함.
	    $(document).on("keyup", ".number", function() {
	    	$(this).number(true);
	    });
	    
		$('.goodsImg').each(function() {
			$(this).error(function(){
				$(this).attr('src', '${contextPath }/resources/images/mall/goods/noimage.png');
			});
		});
		
		//CKEDITOR.replace('txtaAD_DESC');
		
		$(".btnSave").click(function() {
			var bChk = true;

    		if($("input[name='AD_NAME']").val() == ""){
    			alert("광고명은 필수 입력 항목입니다.");
    			$("input[name='AD_NAME']").focus();
    	     	return false;
    		}
	    	
	    	$("input[name='PD_IDS']").each(function() {
	    		if($(this).val() == ""){
	    			strMsg = "상품ID";
	    			$(this).focus();
	    	     	bChk = false;
	    	     	return false;
	    		}
	    	});

	    	if(!bChk){
	    		alert(strMsg + "는(은) 필수 입력 항목입니다.");
	        	return false;
	    	}
	    	
			//var strAD_DESC = CKEDITOR.instances.txtaAD_DESC.getData();
			//$("#AD_DESC").val(strAD_DESC);
			
			if(!confirm("저장하시겠습니까?")) return;
			
			$("input[name=chkYn]").each(function(nIdx){
				if($(this).is(":checked")){ // true
					$("input[name=DEL_YNS]").eq(nIdx).val("Y");
				}
			});
			
			$("#saveFrm").attr("action","${contextPath }/adm/adMgr");
			$("#saveFrm").submit();
		});
		
		$(".btnDel").click(function(){
			if(!confirm("광고 및 등록 상품이 모두 삭제 됩니다.삭제하시겠습니까?")) return;
			$("#saveFrm").attr("action","${contextPath }/adm/adMgr/delete");
			$("#saveFrm").submit();
		});

		$("#allCheck").click(function() {
			if ($("#allCheck").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else {
				$("input[type=checkbox]").prop("checked", false);
			}
		});
		
		$(".btnAdd").click(function(){
			
			$("#trNoData").hide();		//row 삭제
			
			var pdadd='';
			
			pdadd += '<tr>';
			pdadd +=	'<td><input type="hidden" name="DEL_YNS" value="N" /><input type="hidden" name="FLAGS" value="I" /></td>';
			pdadd +=	'<td><input class="form-control input-sm" type="text" name="PD_IDS" /></td>';
			pdadd +=    '<td><input class="form-control input-sm" type="text" name="PD_NAMES" /></td>';
			pdadd +=	'<td><input class="form-control input-sm number" type="text" name="PD_PRICES" /></td>';
			pdadd += 	'<td><input class="form-control input-sm number" type="text" name="SELL_PRICES" /></td>';
			pdadd += 	'<td><input class="form-control input-sm" type="text" name="PD_CONSS" /></td>';
			
			pdadd += 	'<td><input class="form-control input-sm" type="text" name="OPT_NAMES" /></td>';
			pdadd += 	'<td><input class="form-control input-sm" type="text" name="OPT_PRICES" /></td>';
			pdadd += 	'<td><input class="form-control input-sm" type="text" name="UNIT_NAMES" /></td>';
			pdadd += 	'<td><input class="form-control input-sm" type="text" name="ORDS" /></td>';
			
			pdadd += 	'<td><button type="button" class="btn btn-sm btn-warning DELROW">삭제</button></td>';
			pdadd += '<tr>';

		    $('#pdtAdd').append(pdadd); // 추가
		    
		    $('input[name=PD_IDS]:last').focus();
		    
		    
		    $('.DELROW').click(function(){ // 삭제
	            $(this).parent().parent().remove(); 
	        });
        });
		
		$(".btnExcelUpload").click(function(){
			$('#myModal').modal('show');
        });

	    
		$(".btnChartView").click(function(){
		    
			$('#divChartView').modal('show');
			setTimeout (function() { chartUpdate(); }, 500);
        });
		
		$("#btnExcelDown").click(function(){
			document.location.href = "${contextPath }/upload/jundan/excel/excel_form.xls";
        });
		
		$("#btnExcelSave").click(function(){
			$('#excelFrm').submit();
        });

		$(".btnView").click(function(){
		    window.open("${contextPath }/adNew?AD_ID=${eventInfo.AD_ID}&view=preview", "광고 미리보기", "width=1150, height=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes" );
        });
		
		$(".btnCopyPopup").click(function(){
			window.open("${contextPath }/adm/adMgr/popup?AD_ID_NCOPY=${eventInfo.AD_ID}", "_blank", "width=900,height=800"); 
		});
		
		//상품코드 입력 변경시
		$("input:radio[name='TOP_TYPE']").change(function(){
			var strChkVal = $("input:radio[name='TOP_TYPE']:checked").val();
			
			if(strChkVal == "0"){
				$("#divTopFile").show();
			}else{
				$("#divTopFile").hide();
			}
		});
		
	});

	var chartLabels = [];
	var chartDatas = [];
	
	<c:forEach items="${logList }" var="ent" varStatus="loop">
		chartLabels[${loop.index}] = "${ent.LOG_DTM}";
		chartDatas[${loop.index}] = ${ent.LOG_CNT};
	</c:forEach>
	
    var areaChartData = {
    	      labels: chartLabels,
    	      datasets: [
    	        {
    	          label: "접속 통계",
    	          fillColor: "rgba(210, 214, 222, 1)",
    	          strokeColor: "rgba(210, 214, 222, 1)",
    	          pointColor: "rgba(210, 214, 222, 1)",
    	          pointStrokeColor: "#c1c7d1",
    	          pointHighlightFill: "#fff",
    	          pointHighlightStroke: "rgba(220,220,220,1)",
    	          data: chartDatas
    	        }
    	      ]
    	    };
    

    var areaChartOptions = {
      //Boolean - If we should show the scale at all
      showScale: true,
      //Boolean - Whether grid lines are shown across the chart
      scaleShowGridLines: true,
      //String - Colour of the grid lines
      scaleGridLineColor: "rgba(0,0,0,.05)",
      //Number - Width of the grid lines
      scaleGridLineWidth: 1,
      //Boolean - Whether to show horizontal lines (except X axis)
      scaleShowHorizontalLines: true,
      //Boolean - Whether to show vertical lines (except Y axis)
      scaleShowVerticalLines: true,
      //Boolean - Whether the line is curved between points
      bezierCurve: true,
      //Number - Tension of the bezier curve between points
      bezierCurveTension: 0.3,
      //Boolean - Whether to show a dot for each point
      pointDot: true,
      //Number - Radius of each point dot in pixels
      pointDotRadius: 4,
      //Number - Pixel width of point dot stroke
      pointDotStrokeWidth: 1,
      //Number - amount extra to add to the radius to cater for hit detection outside the drawn point
      pointHitDetectionRadius: 20,
      //Boolean - Whether to show a stroke for datasets
      datasetStroke: true,
      //Number - Pixel width of dataset stroke
      datasetStrokeWidth: 2,
      //Boolean - Whether to fill the dataset with a color
      datasetFill: true,
      //Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
      maintainAspectRatio: true,
      //Boolean - whether to make the chart responsive to window resizing
      responsive: true,
      showTooltips: false,
      onAnimationComplete: function () {

          var ctx = this.chart.ctx;
          ctx.font = this.scale.font;
          ctx.fillStyle = this.scale.textColor
          ctx.textAlign = "center";
          ctx.textBaseline = "bottom";

          this.datasets.forEach(function (dataset) {
              dataset.points.forEach(function (points) {
                  ctx.fillText(points.value, points.x, points.y - 5);
              });
          })
      }
    };
    
    
    var chartUpdate = function() {

	    //-------------
	    //- LINE CHART -
	    //--------------
	    var lineChartCanvas = $("#lineChart").get(0).getContext("2d");
	    var lineChart = new Chart(lineChartCanvas);
	    var lineChartOptions = areaChartOptions;
	    lineChartOptions.datasetFill = false;
	    lineChart.Line(areaChartData, lineChartOptions);
        
      }
</script>

<!--
<c:forEach items="${detailList }" var="ent" varStatus="loop">
${ent.PD_ID }	${ent.PD_NAME }	${ent.PD_PRICE }	${ent.SELL_PRICE }	${ent.PD_CONS }	${ent.ORD }
</c:forEach>
 -->
