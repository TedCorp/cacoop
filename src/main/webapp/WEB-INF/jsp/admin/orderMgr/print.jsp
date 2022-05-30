<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<!-- BootStrap 3.3.6 -->		
	<link rel="stylesheet" href="${contextPath }/resources/bootstrap/css/bootstrap.min.css">
	<!-- Font Awesome 4.6.3 -->
	<link rel="stylesheet" href="${contextPath }/resources/css/font-awesome/css/font-awesome.min.css">
	<!-- Ionicons 2.0.1 -->
	<link rel="stylesheet" href="${contextPath }/resources/css/ionicons/css/ionicons.min.css">
	<!-- AdminLTE 2.3.5 -->
	<link rel="stylesheet" href="${contextPath }/resources/adminlte/dist/css/AdminLTE.min.css">
	<link rel="stylesheet" href="${contextPath }/resources/adminlte/dist/css/skins/skin-blue.min.css">
	<link rel="stylesheet" href="${contextPath }/resources/adminlte/dist/css/style.css?ver=1.0">
 	
	<!-- jQuery 2.1.1 -->
	<script type="text/javascript" src="${contextPath }/resources/js/jquery-2.2.1.min.js"></script>
	<!-- BootStrap 3.3.6 -->
	<script type="text/javascript" src="${contextPath }/resources/bootstrap/js/bootstrap.min.js"></script>
	<!-- AdminLTE 2.3.5 -->
	<script type="text/javascript" src="${contextPath }/resources/adminlte/dist/js/app.min.js"></script>
	
	<!-- 바코드 라이브러리 -->
	<script src="${contextPath }/resources/js/jquery-barcode-2.0.2.min.js"></script>
	<%-- <link href="${contextPath}/resources/css/responsive/print.css" rel="stylesheet"> --%>
	
	<style>
		body {
		    width: 100%;
		    height: 100%;
		    margin: 0;
		    padding: 0;
		    background-color: #ddd;	    
		}
		* {
		    box-sizing: border-box;
		    -moz-box-sizing: border-box;
		}	
		.table-bordered>thead>tr>th, 
		.table-bordered>tbody>tr>th, 
		.table-bordered>tfoot>tr>th, 
		.table-bordered>thead>tr>td, 
		.table-bordered>tbody>tr>td, 
		.table-bordered>tfoot>tr>td {
			padding: 3px;
			font-size:10px;
			border : 1px solid #666;
		}	
		.width-one { width : 17px; }	
		.width-num { width : 25px; }	
		.paper {
		    width: 210mm;
		    min-height: 297mm;
		    padding: 20mm;
		    margin: 10mm auto;
		    border-radius: 5px;
		    background: #fff;
		    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
		    page-break-after: always;
		    display:block;
		}
		.paper-idx {
		    padding: 0;
		    border: 1px #888 dotted;
		    height: 257mm;
		}
		.printHtml {
			background-color: #ddd;
		}
		.barcodeTarget {
			margin: 0 0 5px; 
		}
		
		@page {
		    size: A4 !important;	/* landscape */
		    margin: 0 !important;
		}
		@media print {
		    html, body {
		        width: 210mm;
		        height: 297mm;
		        background: #fff;
		    }
		    .paper {
		        margin: 0;
		        border: initial;
		        border-radius: initial;
		        width: initial;
		        min-height: initial;
		        box-shadow: initial;
		        background: initial;
		        page-break-after: always !important;
		    }
		    .paper-idx {
		    	padding: 0;
		    	border: 0;
			    height: initial;
			}
		    .no-print-page { display:none !important; }
		    .page-divide { page-break-after: always !important; }
		    .barcodeTarget { margin: 0 0 5px !important;}
		    
		    .table-bordered>thead>tr>th, 
			.table-bordered>tbody>tr>th, 
			.table-bordered>tfoot>tr>th, 
			.table-bordered>thead>tr>td, 
			.table-bordered>tbody>tr>td, 
			.table-bordered>tfoot>tr>td {
				padding: 3px !important;
				font-size:10px !important;
				border : 1px solid #666 !important;
			}
		}
	</style>
	
	<script type="text/javascript">
		$(function() {	
			/* 현재날짜 */
			$(".nowDt").text("작성일시 : " + dateConvert());
			
			/* 바코드 생성 - 필요없을시 주석 */
			$(".barcodeTarget").barcode($(".barcodeTarget").attr('id').replace(/[^0-9]/g,''), "ean13", {barWidth:2, barHeight:22});
			
			/* 출력 */
			$(".btnPrint").click(function(){		
				var initBody = document.body.innnerHTML;
				
				window.onbeforeprint = function(){
					document.body.innerHTML = document.querySelector('.printHtml').innerHTML;
				}
				window.onafterprint = function(){	
					window.location.reload(true);
				}
				
				window.print();	
			});
			
			/* 닫기 */
			$(".btnClose").click(function(){	
				self.close();
			});
		});
		
		/* Date format */
		function dateConvert() {
			var _today = new Date();		
			var yyyy = _today.getFullYear().toString();
		    var MM = (_today.getMonth() + 1).toString();
		    var dd = _today.getDate().toString();
		    var convert = yyyy + "-" + (MM[1] ? MM : "0" + MM[0]) + "-" + (dd[1] ? dd : "0" + dd[0]);
		    
		    return convert;
		}
		</script>	
</head>
<body>
	<c:set var="strActionUrl" value="${contextPath }/adm/orderMgr/" />
	<c:set var="strMethod" value="post" />
	
	<section class="content">
		<!-- 출력 html -->
		<div class="box box-default printHtml">
			<div class="box-header no-print-page">
				<h3 class="box-title"></h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool right-5 btnPrint">
						<i class="fa fa-print"></i>출력
					</button>
					<button type="button" class="btn btn-box-tool btnClose">
						<i class="fa fa-window-close-o"></i>닫기
					</button>
				</div>
			</div>
			<!-- /.box-header -->
			
			<c:forEach items="${delivery.list }" var="ordnum" varStatus="status">
				<c:set var= "pdsum" value="0" /><!-- 상품합계 초기화 -->
				<!-- 페이지 index-->
				<div class="box-body paper">
					<div class="paper-idx">
						<div class="box-header">
							<h3 class="box-title"><i class="fa fa-truck" aria-hidden="true"></i> 거래명세표</h3>
							<small class="ml_5">&nbsp; &nbsp; # 주문번호 : ${ordnum.ORDER_NUM }</small>
							<small class="ml_5 pull-right nowDt">* 작성일자 : </small>
						</div>
						<!-- 공급사 정보 -->
						<table class="table table-bordered">
							<tr>
								<th class="txt-middle width-num" rowspan="4">공<br>급<br>사</th>
								<th class="txt-left ">사업번호</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.BIZR_NUM, 0, 1) }</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.BIZR_NUM, 1, 2) }</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.BIZR_NUM, 2, 3) }</th>
								<th class="txt-middle width-one">-</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.BIZR_NUM, 3, 4) }</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.BIZR_NUM, 4, 5) }</th>
								<th class="txt-middle width-one">-</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.BIZR_NUM, 5, 6) }</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.BIZR_NUM, 6, 7) }</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.BIZR_NUM, 7, 8) }</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.BIZR_NUM, 8, 9) }</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.BIZR_NUM, 9, 10) }</th>
								<th class="txt-middle width-num" rowspan="4">공<br>급<br>받<br>는<br>자</th>
								<th class="txt-left">사업번호</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.COM_BUNB, 0, 1) }</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.COM_BUNB, 1, 2) }</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.COM_BUNB, 2, 3) }</th>
								<th class="txt-middle width-one">-</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.COM_BUNB, 3, 4) }</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.COM_BUNB, 4, 5) }</th>
								<th class="txt-middle width-one">-</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.COM_BUNB, 5, 6) }</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.COM_BUNB, 6, 7) }</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.COM_BUNB, 7, 8) }</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.COM_BUNB, 8, 9) }</th>
								<th class="txt-middle width-one">${fn:substring(ordnum.COM_BUNB, 9, 10) }</th>
							</tr>
							<tr>
								<th class="txt-left">상호</th>
								<td class="txt-left" colspan="6">${ordnum.SUPR_NAME }</td>
								<th class="txt-left" colspan="2">성명</th>
								<td class="txt-left" colspan="4">${ordnum.RPRS_NAME }</td>
								<th class="txt-left">상호</th>
								<td colspan="6">${ordnum.COM_NAME }</td>
								<th class="txt-left" colspan="2">성명</th>
								<td class="txt-left" colspan="4">${ordnum.RECV_PERS }</td>
							</tr>
							<tr>
								<th class="txt-left">주소</th>
								<td class="txt-left" colspan="12">${ordnum.BIZR_ADDR }</td>
								<th class="txt-left">주소</th>
								<td class="txt-left" colspan="12">${ordnum.RECV_ADDR }</td>
							</tr>
							<tr>
								<th class="txt-left">고객센터</th>
								<td class="txt-left" colspan="12">042-933-8911</td>
								<th class="txt-left">연락처</th>
								<td class="txt-left" colspan="6">${ordnum.RECV_CPON }</td>
								<td class="txt-left" colspan="6">${ordnum.RECV_TELN }</td>									
							</tr>
						</table>
						
						<!-- 주문 상품 정보 -->
						<table class="table table-bordered">							
							<thead>								
								<tr>
									<th class="txt-middle width-num">NO</th>
									<th class="txt-middle">상품명</th>
									<th class="txt-middle">수량</th>
									<th class="txt-middle">공급가액</th>
									<th class="txt-middle">소계</th>
									<th class="txt-middle">상품코드</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${ordnum.list }" var="list" varStatus="status">							
									<tr>
										<td class="txt-middle width-num" rowspan="2">${status.count }</td>
										<td class="txt-left">${list.PD_NAME }</td>
										<td class="txt-middle"><fmt:formatNumber value="${list.ORDER_QTY }" /></td>
										<td class="txt-right"><fmt:formatNumber value="${list.REAL_PRICE }" /></td>
										<td class="txt-right"><fmt:formatNumber value="${list.ORDER_AMT }" /></td>
										<td class="txt-left">${list.PD_CODE }</td>
									</tr>
									<tr>
										<td class="txt-middle" style="padding-bottom:0;">
											<p class="barcodeTarget" id="barcd_${list.PD_BARCD}"></p>
										</td>
										<td class="txt-left" colspan="4">
											${list.OPTION_NAME } &nbsp; ${list.CUT_UNIT } <br>${list.STD_UNIT }
										</td>
									</tr>
									<c:if test="${status.count % 16 eq 0 and status.count ne fn:length( ordnum.list )}">
													</tbody> 
												</table>
											</div>
										</div>
										<div class="box-body paper">
											<div class="paper-idx">
												<div class="box-header">
													<h3 class="box-title"><i class="fa fa-truck" aria-hidden="true"></i> &nbsp; 배송전표</h3>
													<small class="ml_5">&nbsp;# 주문번호 : ${ordnum.ORDER_NUM }</small>
													<small class="ml_5 pull-right nowDt">* 작성일자 : </small>
												</div>
												<table class="table table-bordered">
													<thead>								
														<tr>
															<th class="txt-middle width-num">NO</th>
															<th class="txt-middle">상품명</th>
															<th class="txt-middle">수량</th>
															<th class="txt-middle">공급가액</th>
															<th class="txt-middle">소계</th>
															<th class="txt-middle">상품코드</th>
														</tr>
													</thead>
													<tbody>
									</c:if>
									<c:set var= "pdsum" value="${pdsum + list.ORDER_AMT}"/>
								</c:forEach>
								
								<%-- <c:if test="${fn:length( ordnum.list ) < 16}">
									<c:forEach begin="1" end="${15 - fn:length( ordnum.list )}">
										<tr style="height:21px;">
											<td class="txt-middle width-num" rowspan="2"></td>
											<td class="txt-left"></td>
											<td class="txt-middle"></td>
											<td class="txt-right"></td>
											<td class="txt-right"></td>
											<td class="txt-left"></td>
										</tr>
										<tr style="height:21px;">
											<td class="txt-middle" style="padding-bottom:0;"></td>
											<td class="txt-left" colspan="4"></td>
										</tr>
									</c:forEach>
								</c:if> --%>
							</tbody>
						</table>
						
						<!-- 요청사항 정보 -->
						<table class="table table-bordered">
							<tr>
								<th class="txt-middle">배송요청시간</th>
								<th class="txt-middle">요청/전달사항</th>
								<th class="txt-right">합&nbsp;&nbsp;&nbsp;계</th>
								<th class="txt-right"><fmt:formatNumber value="${pdsum }"/></th>
							</tr>
							<tr>
								<td class="txt-middle" rowspan="2"><h5>${ordnum.DLAR_DATE } &nbsp; ${ordnum.DLAR_TIME }</h5></td>
								<td class="txt-left" rowspan="2">${ordnum.DLVY_MSG }<br>${ordnum.ADM_REF }</td>
								<th class="txt-right">배송비</th>
								<th class="txt-right"><fmt:formatNumber value="${ordnum.DLVY_AMT }"/></th>
							</tr>
							<tr>
								<th class="txt-right">총&nbsp;&nbsp;&nbsp;계<br>(부가세포함)</th>
								<th class="txt-right"><fmt:formatNumber value="${ordnum.ORDER_TOT }"/></th>
							</tr>
						</table>
					</div>
				</div>
			</c:forEach>
			<!-- ./주문정보 -->
		</div>
		
		<div class="box-footer no-print-page">
			<button type="button" class="btn btn-default pull-right btnClose"><i class="fa fa-window-close-o"></i>닫기</button>
			<button type="button" class="btn btn-primary pull-right right-5 btnPrint"><i class="fa fa-print"></i> 출력</button>
		</div>
		<!-- /.footer -->
	</section>
</body>
