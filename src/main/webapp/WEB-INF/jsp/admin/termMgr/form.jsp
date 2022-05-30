<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<section class="content-header">
	<h1>
		약관관리
	</h1>
</section>

<section class="content">
	<!-- Horizontal Form -->
	<!-- form start -->
	<spform:form name="frm" id="frm" method="post" class="form-horizontal" onsubmit="return check()">  	
	   <input type="hidden" name="TERM_GUBN1" id="TERM_GUBN1" value="${termInfo1.TERM_GUBN }">
	   <input type="hidden" name="TERM_GUBN2" id="TERM_GUBN2" value="${termInfo2.TERM_GUBN }">
	   <input type="hidden" name="TERM_CONT1" id="TERM_CONT1">
	   <input type="hidden" name="TERM_CONT2" id="TERM_CONT2">

		<div class="row">
			<div class="col-md-12 row-md-12">
				<!-- Custom Tabs -->
				<div class="nav-tabs-custom">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab_1" data-toggle="tab">회원약관</a></li>
						<li><a href="#tab_2" data-toggle="tab">개인정보취급방침</a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab_1">
		                    <textarea id="txtaCONT1" rows="15" style="width:100%">${termInfo1.TERM_CONT } </textarea>
						</div>
						<div class="tab-pane" id="tab_2">
		                    <textarea id="txtaCONT2" rows="15" style="width:100%">${termInfo2.TERM_CONT } </textarea>
						</div>
					</div>
					<!-- /.tab-content -->
				</div>
				<!-- nav-tabs-custom -->
			</div>
			<!-- /.col -->


			<!-- this row will not appear when printing -->
			<div class="row">
				<div class="col-xs-12">
					<button type="submit" class="btn btn-primary pull-right" style="margin-right: 5px;">
						<i class="fa fa-save"></i> 저장
					</button>
				</div>
			</div>
	</spform:form>
	<!-- /.box -->
</section>

<script>
	$(function() {

		//CKEDITOR.replace('txtaCONT1');
		//CKEDITOR.replace('txtaCONT2');
		
	});
	
	function check() {

		//var strTERM_CONT1 = CKEDITOR.instances.txtaCONT1.getData();
		//var strTERM_CONT2 = CKEDITOR.instances.txtaCONT2.getData();
		
		var strTERM_CONT1 = $("#txtaCONT1").val();
		var strTERM_CONT2 = $("#txtaCONT2").val();
		
		$("#TERM_CONT1").val(strTERM_CONT1);
		$("#TERM_CONT2").val(strTERM_CONT2);
		
		return true;
	}
</script>