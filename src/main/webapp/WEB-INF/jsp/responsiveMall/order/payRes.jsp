<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<%
System.out.println("ttttttttttes2222t");
%>
<!-- 결제 실패 화면 >> 디자인 필요 -->
<div class="payResBody">
	<div>
		<c:if test="${!payRtnSatus}">
			<c:forEach items="${payResMap}" var="data" varStatus="loop">
				<c:choose>
					<c:when test="${data.key eq 'msg02' or data.key eq 'msg07'}">
						<p>${data.value}</p>
					</c:when>
					<c:otherwise>
						<pre style="color:white;"><c:out value="${data.value}"/></pre>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:if>
		<c:if test="${payRtnSatus}">
			<c:if test="${LGD_PAYTYPE eq 'SC0040'}">
				<c:forEach items="${virtualMap}" var="account" varStatus="loop">
					<p>
						<c:if test="${account.key eq 'LGD_SAOWNER'}">
							입금계좌주: ${account.value}
						</c:if>
						<c:if test="${account.key eq 'LGD_FINANCENAME'}">
							결제기관명: ${account.value}
						</c:if>
						<c:if test="${account.key eq 'LGD_ACCOUNTNUM'}">
							가상계좌번호: ${account.value}
						</c:if>
						<c:if test="${account.key eq 'LGD_CLOSEDATE'}">
							입금마감시간: ${account.value}
						</c:if>
					</p>
				</c:forEach>
				<b style="color:red;">
				* 가상계좌는 일회성 계좌이므로 재사용시(다시 그 계좌로 입금하는 경우) 타인의 계좌로 입금될 가능성이 있습니다. <br>
				 이 경우는 구매고객의 책임이므로 사용에 주의하시기 바랍니다. <br>
				* CD기에서 계좌이체는 가능하나 CD기에서 해당 계좌로 현금을 입금할 수는 없습니다. <br> 
				(과오납이 허용되지 않을 수 있으니 CD기 이용은 지양해 주시기 바랍니다.) <br>
				</b>
			</c:if>
			<c:if test="${LGD_PAYTYPE ne 'SC0040'}">
				<h3>결제가 완료되었습니다.</h3>
			</c:if>
		</c:if>
	</div>
	<div class="btn_confirm">
		<button onclick="popup_close();" class="btn btn-sm btn-default">닫기</button>
	</div>
</div>

<script type="text/javascript">
	var state = "${payRtnSatus}";
	var type = "${LGD_PAYTYPE}"
	if(state == "true" && type != "SC0040"){
		popup_close();
	}
	
	/* 창닫기 */
	function popup_close(){
		parent.window.fnPayClose();
	}
</script>

<style>
	body{ margin: 0;}
	.payResBody{
		width:auto;
		height:100%;
		background-color: white;
		padding: 10px 15px;
	}
</style>
	