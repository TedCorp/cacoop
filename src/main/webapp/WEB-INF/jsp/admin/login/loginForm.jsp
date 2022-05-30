<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title> Mall 관리자 | Log in</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="${contextPath }/resources/bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="${contextPath }/resources/adminlte/dist/css/AdminLTE.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="${contextPath }/resources/adminlte/plugins/iCheck/square/blue.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="${contextPath }/resources/js/html5shiv.min.js"></script>
  <script src="${contextPath }/resources/js/respond.min.js"></script>
  <![endif]-->
</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo"> 
    <b>건설건축협동조합</b> 
  	<br><span>관리자</span>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <p class="login-box-msg">로그인하여 주세요.</p>
    <form action="${contextPath }/adm/login" method="post">
      <div class="form-group has-feedback">
        <input type="input" name="MEMB_ID" id="MEMB_ID" value="" class="form-control" placeholder="아이디" onkeyup="strtrim(this)">
        <span class="glyphicon glyphicon-user form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" name="MEMB_PW" id="MEMB_PW" value="" class="form-control" placeholder="Password" onkeyup="strtrim(this)">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="row">
        <!-- /.col -->
        <div class="col-xs-12">
          <button type="submit" class="btn btn-primary btn-block btn-flat">로그인</button>
        </div>
        <!-- /.col -->
      </div>
    </form>

  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 2.1.1 -->
<script type="text/javascript" src="${contextPath }/resources/js/jquery-2.2.1.min.js"></script>
<!-- BootStrap 3.3.6 -->
<script type="text/javascript" src="${contextPath }/resources/bootstrap/js/bootstrap.min.js"></script>

</body>


<script type="text/javascript">
$(function() {	
/* 	var idtxt = $('#MEMB_ID').val();
	alter("공백제거 전: "+idtxt);
	
	idtxt = idtxt.trim();
	$('#MEMB_ID').val(idtxt);
	
	alert("공백제거 후: "+idtxt); */
});

/* 공백제거 */
function strtrim(obj){	
	var idtxt = $('#MEMB_ID').val().replace(/ /gi, '');	
	$('#MEMB_ID').val(idtxt);
	
	var pwtxt = $('#MEMB_PW').val().replace(/ /gi, '');	
	$('#MEMB_PW').val(pwtxt);
}

</script>

</html>
