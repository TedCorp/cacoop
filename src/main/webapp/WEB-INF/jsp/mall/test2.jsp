<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script src="${contextPath}/resources/js/jquery-2.2.1.min.js"></script>
	<script>window.jQuery || document.write('<script src="${contextPath}/resources/js/jquery-2.2.1.min.js"><\/script>')</script>
	<script src="${contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="${contextPath}/resources/js/ie10-viewport-bug-workaround.js"></script>
	
	
    <!-- tooltip -->
    <link href="${contextPath}/resources/common/tooltip/tooltip.css?ver=1.1" rel="stylesheet">
    <script src="${contextPath}/resources/common/tooltip/tooltip.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	var authData = {
			service: "ownerclan",
			userType: "seller",
			username: "iibs0017",
			password: "iibs0038" 
			};
	
	
			$.ajax({
				url: "https://auth-sandbox.ownerclan.xyz/auth"			, 
				type: "POST"			,
				contentType: "application/json"			,
				processData: false,
				data: JSON.stringify(authData),
				success: function(data) {
				// 성공한 경우, 토큰을 콘솔에 출력합니다.
				console.log(data);
				alert(data);
				},
				error: function(data) {
				// 실패한 경우 에러와 HTTP status code를 기록합니다.
				console.error(data.responseText, data.status);
				alert("fail");
				}
			});
			

});
	

</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>