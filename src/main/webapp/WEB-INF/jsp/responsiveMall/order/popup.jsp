<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp"%>

<div class="main-container container">
	<h4 class="title">취소사유</h4>
	<form class="form-horizontal" name="cancelPopFrm" id="cancelPopFrm" method="POST" action="${contextPath }/m/order/cancel/popup">
		<input type="hidden" id="ORDER_NUM" name="ORDER_NUM" value="${param.ORDER_NUM }" />
		<input type="hidden" id="PAY_MDKY" name="PAY_MDKY" value="${param.PAY_MDKY }" />
		<input type="hidden" id="PAY_METD" name="PAY_METD" value="${param.PAY_METD }" />
		
		<div class="box-body">
			<div class="form-group">
				<textarea class="form-control" id="CNCL_MSG" name="CNCL_MSG"></textarea>
				<div class="remaining" style="margin:5px;">
					<span>[<span class="count">100</span> /100자]&nbsp;</span>
					<a onclick="javascript:fn_save();" class="btn btn-sm btn-danger pull-right">등록</a>
				</div> 
			</div>		
		</div>
	</form>
</div>

<script type="text/javascript">
	function fn_save(){	
		if(!confirm("정말 취소하시겠습니까?")) return;
		$("#cancelPopFrm").submit();
		
		/* 
		var frm=document.getElementById("cancelPopFrm");
		
		$.ajax({
		    url: "${contextPath }/order/cancel/popup",
		    type: 'post',
		    data: "&ORDER_NUM="+frm.ORDER_NUM.value + "&PAY_MDKY=" + frm.PAY_MDKY.value + "&CNCL_MSG=" + frm.CNCL_MSG.value,
		    success: function(data){                               
		    	opener.cancel_popup_return(frm.ORDER_NUM.value, frm.CNCL_MSG.value);
		    	window.close(); 
		    },
		    error: function(e){
		       alert("에러:");
		    }
		});
		*/
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