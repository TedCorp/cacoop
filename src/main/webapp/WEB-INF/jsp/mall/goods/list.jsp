<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>  



	<c:set var="arrCagoIdPath" value="${fn:split(rtnCagoInfo.CAGO_ID_PATH, '>') }" /> 
	<c:set var="arrCagoNmPath" value="${fn:split(rtnCagoInfo.CAGO_NM_PATH, '>') }" /> 

<!-- 메인테이블 -->
<table border="0" cellpadding="0" cellspacing="0" width="720">
<tr>
	<td width="725" valign="top">
		<!-- 서브이미지 -->
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td><img src="${contextPath }/resources/images/subimg/sub_img.jpg" border="0"></td></tr>
		</table>
		<!-- /서브이미지 -->

		<!-- 중분류리스트 -->
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="155"></td>
			<td width="681">
				<!-- 내용 -->
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="6" height="1" bgcolor="d7d7d7"></td></tr>
				<tr>
					<td colspan="6">
						<!-- 타이틀 -->
						<table border="0" cellpadding="0" cellspacing="0" bgcolor="f3f3f3">
						<tr>
							<td width="20" align="center" height="28"><img src="${contextPath }/resources/images/subimg/tit_icon.gif" border="0"></td>
							<td width="661" style="font-size:13px;color:#84a627"><b>${cagoDownList[0].UPCAGO_NAME }</b></td>
						</tr>
						</table>
						<!-- /타이틀 -->
					</td>
				</tr>
				
				<c:forEach var="ent" items="${ cagoDownList }" varStatus="status">
					<c:if test="${status.count%5 eq 1 }">
						<tr>
							<td width="18" height="25"></td>
					</c:if>
							<td width="137" style="font-size:11px;color:#838383;line-height:22px">
								<a href="${contextPath }/goods?CAGO_ID=${ ent.CAGO_ID }">
									<c:if test="${ent.CAGO_ID eq rtnCagoInfo.CAGO_ID }"><font style="font-size:11px;color:#ff9c00"><u><b></c:if>
									<c:out value="${ ent.CAGO_NAME }" escapeXml="true"/> (${ ent.PRD_CNT })
									<c:if test="${ent.CAGO_ID eq rtnCagoInfo.CAGO_ID }"></font></u></b></c:if>
								</a>
							</td>
					<c:if test="${status.count%5 eq 0 }">
						</tr>
					</c:if>
				</c:forEach>
					<tr>
					<td colspan="6" height="1" bgcolor="d7d7d7"></td></tr>
				</table>
				<!-- /내용 -->
			</td>
			<td></td></tr>
		</table>
		<!-- /중분류리스트 -->

		<!-- 위치타이틀 -->
		<table border="0" cellpadding="0" cellspacing="0" width="695">
		<tr>
			<td width="50%"><img src="${contextPath }/resources/images/subimg/title.gif" border="0"></td>
			<td width="50%" align="right" style="font-size:11px;color:#878787">HOME < 
			<c:forEach var="entPath" items="${ arrCagoNmPath }" varStatus="status">
				<a href="${contextPath }/goods?CAGO_ID=${arrCagoIdPath[status.index] }" class="${ fn:length(arrCagoNmPath) eq status.count ? 'sct_here' : 'sct_bg' } "><font style="font-size:11px;color:#7da41a">${entPath }</font></a>
			</c:forEach>&nbsp;&nbsp;</td></tr>
			
		<tr>
			<td colspan="2">
				<!-- 라인 -->
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="104" height="1" bgcolor="a1c95d"></td>
					<td width="591" height="1" bgcolor="eee79b"></td></tr>
				</table>
				<!-- /라인 -->
			</td></tr>
		</table>
		<!-- /위치타이틀 -->

		<!-- 공간 -->
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="24"></td></tr>
		</table>
		<!-- /공간 -->

		<!-- 상품리스트 -->
		
		<div id="pdList">
		<c:if test="${ !empty(obj.list) }">
			<c:forEach var="ent" items="${ obj.list }" varStatus="status">
				<c:if test="${status.count%4 eq 1 }"><ul class="sct sct_list_10"></c:if>

				<li class="sct_li" style="width: 155px;float:left;">
					<div class="sct_img">
						<a class="sct_a" href="./goods/view/${ ent.PD_CODE }">
						<c:if test="${ !empty(ent.ATFL_ID) }">
							<img class="goodsImg" width="158" height="124" src="${contextPath }/common/commonFileDown?ATFL_ID=${ent.ATFL_ID }&ATFL_SEQ=${ent.RPIMG_SEQ}" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
						</c:if>
						<c:if test="${ empty(ent.ATFL_ID) }">
							<img class="goodsImg" width="158" height="124" src="${contextPath }/resources/images/mall/goods/noimage.png" alt="<c:out value="${ ent.PD_NAME }" escapeXml="true"/>"/>
						</c:if>
						</a>
					</div>
					<div class="sct_txt">
						<a class="sct_a" href="./goods/${ ent.PD_CODE }"><input type="checkbox" name="1" style="width:13px;height:13px"> &nbsp; &nbsp; &nbsp; &nbsp;<c:out value="${ ent.PD_NAME }" escapeXml="true"/></a>
					</div>
					<div class="sct_basic" style="text-align:center;margin-top:3px;">제조사:<c:out value="${ ent.MAKE_COM }" escapeXml="true"/></div>
					<div class="sct_cost" style="text-align:right;margin-top:7px;"><img src="${contextPath }/resources/images/subimg/icon01.gif" border="0" align="absmiddle"> <b><fmt:formatNumber value="${ ent.PD_PRICE }" pattern="#,###"/> 원</b> <img alt="인기상품" src="${contextPath }/resources/images/mall/goods/icon_best.gif" border="0" align="absmiddle"></div>
					<div style="text-align:center;margin-top:7px;margin-bottom:20px;"><a href="#"><img src="${contextPath }/resources/images/subimg/img_btn.gif" border="0" alt="구매하기"></a></div>
				</li>
				
				<c:if test="${status.count%4 eq 0 }"></ul></c:if>
				
			</c:forEach>
		</c:if>
		
		</div>

		<!-- /상품리스트 -->

		<!-- 페지이동 -->
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="195" height="37"></td>
			<td><a href="#"><img src="${contextPath }/resources/images/subimg/btn01.gif" border="0" alt="이전"></a></td>
			<td width="270" align="center" valign="bottom" style="font-family:Gulim;line-height:34px"><font style="font-family:Gulim;color:#000000"><b>1</b></font> &nbsp;|&nbsp; 2 &nbsp;|&nbsp; 3 &nbsp;|&nbsp; 4 &nbsp;| 5 &nbsp;| 6 &nbsp;| 7 &nbsp;|&nbsp; 8 &nbsp;|&nbsp; 9 &nbsp;|&nbsp; 10</td>
			<td><a href="#"><img src="${contextPath }/resources/images/subimg/btn02.gif" border="0" alt="다음"></a></td></tr>
		</table>
		<!-- /페지이동 -->
	</td></tr>
</table>
<!-- /메인테이블 -->
