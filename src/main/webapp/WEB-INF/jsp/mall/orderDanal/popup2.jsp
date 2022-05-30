<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>

<h4 style="margin-left: 20px; margin-top: 20px;">취소사유</h4>

<form name="cancelPopFrm" id="cancelPopFrm" method="POST" action="${contextPath }/order/cancel/popup2" class="form-horizontal">
	<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="${param.ORDER_NUM }" />
	<div class="box-body">
		<div class="form-group">
			<textarea id="CNCL_MSG" name="CNCL_MSG" style="width: 470px; height: 80px; margin-left: 20px; padding-bottom: 1px;"></textarea>
			<div class="remaining" style="float:right; margin-right: 23px;">[<span class="count">100</span> /100자]</div> 
		</div>
	</div>
	<!-- /.box-body -->
	<div class="box-header with-border">
		<h3 class="box-title"></h3>
		<div class="box-tools">
			<a onclick="javascript:fn_save();" class="btn btn-sm btn-success pull-right" style="float:right; margin-right: 5px;" >저장</a>
		</div>
	</div>
</form>

<script type="text/javascript">

function fn_save(){	
	if(!confirm("정말 취소하시겠습니까?")) return;
	$("#cancelPopFrm").submit();
}

$(function () {
    $('.remaining').each(function () {
        var $count = $('.count', this);
        var $input = $(this).prev();
        var maximumCount = $count.text() * 1;
        var update = function () {
        var before = $count.text() * 1;
        var now = maximumCount - $input.val().length;
        if (now < 0) {
            var str = $input.val();
			alert('글자 입력수가 초과하였습니다.');
            $input.val(str.substr(0, maximumCount));
            now = 0;
        }
        if (before != now) {
            $count.text(now);
        }
    };
        $input.bind('input keyup paste', function () { setTimeout(update, 0) });
        update();
    });
}); 


</script>