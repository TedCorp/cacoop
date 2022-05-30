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
			border : 1px solid #444;
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
		    .barcodeTarget { margin: 0 0 5px; }
		    
		    .table-bordered>thead>tr>th, 
			.table-bordered>tbody>tr>th, 
			.table-bordered>tfoot>tr>th, 
			.table-bordered>thead>tr>td, 
			.table-bordered>tbody>tr>td, 
			.table-bordered>tfoot>tr>td {
				padding: 3px !important;
				font-size:10px !important;
				border : 1px solid #444 !important;
			}
		}
	</style>
	
	<script type="text/javascript">
		$(function() {	
			/* 현재날짜 */
			$(".nowDt").text(dateConvert());
			/* 합계금액(한글) */
			$(".totalKor").text(numToKorean($(".totalPrc").text())+'원 '+' (￦ '+$(".totalPrc").text()+')');
			
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
		    var convert = yyyy + "년 " + (MM[1] ? MM : "0" + MM[0]) + "월 " + (dd[1] ? dd : "0" + dd[0])+ "일";
		    
		    return convert;
		}
		
		/* money format */
		function numToKorean(num) {
			num = parseInt((num + '').replace(/[^0-9]/g, ''), 10) + '';  // 숫자,문자,돈 을 숫자만 있는 문자열로 변환
			
			if(num == '0') return '영';			
			
			var number = ['영', '일', '이', '삼', '사', '오', '육', '칠', '팔', '구'];			
			var unit = ['', '만', '억', '조'];			
			var smallUnit = ['천', '백', '십', ''];
			var result = [];  //변환된 값을 저장할 배열
			
			var unitCnt = Math.ceil(num.length / 4);	// 단위 갯수. 숫자 10000은 일단위와 만단위 2개이다.			
			num = num.padStart(unitCnt * 4, '0');		// 4자리 값이 되도록 0을 채운다			
			
			var regexp = /[\w\W]{4}/g;						// 4자리 단위로 숫자 분리			
			var array = num.match(regexp);			
			
			// 낮은 자릿수에서 높은 자릿수 순으로 값을 만든다 (그래야 자릿수 계산이 편하다)
			
			for(var i = array.length - 1, unitCnt = 0; i >= 0; i--, unitCnt++) {			
				var hanValue = _makeHan(array[i]);		// 한글로 변환된 숫자
				
				if(hanValue == '') continue;					// 값이 없을땐 해당 단위의 값이 모두 0이란 뜻.			  
				result.unshift(hanValue + unit[unitCnt]);  // unshift는 항상 배열의 앞에 넣는다.
			}
			
			// 여기로 들어오는 값은 무조건 네자리이다. 1234 -> 일천이백삼십사
			function _makeHan(text) {
				var str = '';			
				for(var i = 0; i < text.length; i++) {
					var num = text[i];
					
					if(num == '0') continue;		// 0은 읽지 않는다
					str += number[num] + smallUnit[i];
				}			
				return str;
			}
			
			return result.join('');
		}
	</script>
		
</head>
<body>
	<c:set var="strActionUrl" value="${contextPath }/adm/orderMgr/" />
	<c:set var="strMethod" value="post" />
	
	<section class="content">
		<!-- 출력 html -->
		<div class="box box-default printHtml" style="">
			<div class="box-header no-print-page">
				<h3 class="box-title"></h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool right-5 btnPrint" style="color: #333;">
						<i class="fa fa-print"></i>출력
					</button>
					<button type="button" class="btn btn-box-tool btnClose" style="color: #333;">
						<i class="fa fa-window-close-o"></i>닫기
					</button>
				</div>
			</div>
			<!-- /.box-header -->
			<c:set var= "pdsum" value="0" /><!-- 상품합계 초기화 -->
			<!-- 페이지 index-->
			<div class="box-body paper">
				<div class="paper-idx">
					<!-- 공급사 정보 -->
					<table class="table table-bordered" style="margin-bottom:0;">
						<tr>
							<th class="txt-middle" colspan="6">
								<h3 class="box-title"><i class="fa fa-globe" aria-hidden="true"></i> 견적서</h3>
							</th>
						</tr>
						<tr>
							<th class="txt-left">NO.</th>															
							<th class="txt-middle width-num" rowspan="4">공<br>급<br>사</th>
							<th class="txt-middle">사업번호</th>
							<th class="txt-middle" colspan="4">${supplier.BIZR_NUM }</th>					
						</tr>
						<tr>
							<th class="txt-middle nowDt"></th>
							<th class="txt-middle">상&emsp;&emsp;호</th>
							<td class="txt-left">${supplier.SUPR_NAME }</td>
							<th class="txt-middle">대표자</th>
							<td class="txt-left">${supplier.RPRS_NAME }</td>
						</tr>
						<tr>
							<th class="txt-middle">${estimate.list[0].RECV_PERS} 귀하</th>
							<th class="txt-middle">주&emsp;&emsp;소</th>
							<td class="txt-left" colspan="4">[${supplier.POST_NUM }]&nbsp;${supplier.BASC_ADDR }&nbsp;${supplier.DTL_ADDR }</td>
						</tr>
						<tr>
							<th class="txt-middle">아래와 같이 견적합니다.</th>	
							<th class="txt-middle">업&emsp;&emsp;태</th>
							<td class="txt-left">${supplier.BIZR_STYLE }</td>
							<th class="txt-middle">종&emsp;목</th>
							<td class="txt-left">${supplier.BIZR_EVENT }</td>									
						</tr>
						<tr>
							<th class="txt-middle">합계금액 <br>(공급가액+세액)</th>
							<th class="txt-middle totalKor" colspan="5"> 원 &nbsp; (운송료 별도)</th>									
						</tr>
					</table>
					
					<!-- 주문 정보 -->
					<table class="table table-bordered">
						<thead>								
							<tr>
								<th class="txt-middle width-num">NO</th>
								<th class="txt-middle">상품명</th>
								<th class="txt-middle">규격</th>
								<th class="txt-middle">수량</th>
								<th class="txt-middle">단가</th>
								<th class="txt-middle">공급가액</th>
								<th class="txt-middle">비고</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${estimate.list }" var="list" varStatus="status">
								<tr>
									<td class="txt-middle width-num">${status.count }</td>
									<td class="txt-left">${list.PD_NAME } <br> ${list.OPTION_NAME } &nbsp; ${list.CUT_UNIT }</td>
									<td class="txt-left">${list.STD_UNIT }</td>
									<td class="txt-middle"><fmt:formatNumber value="${list.ORDER_QTY }" /></td>
									<td class="txt-right"><fmt:formatNumber value="${list.REAL_PRICE }" /></td>
									<td class="txt-right"><fmt:formatNumber value="${list.ORDER_QTY * list.REAL_PRICE }" /></td>
									<td class="txt-left"></td>
								</tr>
								<c:if test="${status.count % 20 eq 0 and status.count ne fn:length( estimate.list )}">
												</tbody> 
											</table>
										</div>
									</div>
									<div class="box-body paper">
										<div class="paper-idx">
											<table class="table table-bordered">
												<thead>								
													<tr>
														<th class="txt-middle width-num">NO</th>
														<th class="txt-middle">상품명</th>
														<th class="txt-middle">규격</th>
														<th class="txt-middle">수량</th>
														<th class="txt-middle">단가</th>
														<th class="txt-middle">공급가액</th>
														<th class="txt-middle">비고</th>
													</tr>
												</thead>
												<tbody>
								</c:if>								
								<c:set var= "pdsum" value="${pdsum + (list.ORDER_QTY * list.REAL_PRICE)}"/>								
							</c:forEach>
							<c:if test="${fn:length( estimate.list ) < 20}">
								<c:forEach begin="1" end="${19 - fn:length( estimate.list )}">
									<tr style="height:35px;">
										<td class="txt-middle width-num"></td>
										<td class="txt-left"><br></td>
										<td class="txt-left"></td>
										<td class="txt-middle"></td>
										<td class="txt-right"></td>
										<td class="txt-right"></td>
										<td class="txt-left"></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
						<tfoot>
							<tr>
								<th class="txt-middle" colspan="2"><h6><b>계</b>&nbsp; (부가세포함)</h6></th>
								<th class="txt-right totalPrc" colspan="5"><h6><b><fmt:formatNumber value="${ pdsum }"/></b></h6></th>
							</tr>
							<tr>
								<th class="txt-left" colspan="7">※ 주문에 따라 배송료가 별도 부과될 수 있습니다.<br>※ 본 견적의 유효기간은 견적일 기준 7일입니다.</th>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
			<!-- ./주문정보 -->
		</div>
		
		<div class="box-footer no-print-page">
			<button type="button" class="btn btn-default pull-right btnClose"><i class="fa fa-window-close-o"></i>닫기</button>
			<button type="button" class="btn btn-primary pull-right right-5 btnPrint"><i class="fa fa-print"></i> 출력</button>
		</div>
		<!-- /.footer -->
	</section>
</body>
