<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script type="text/javascript">

$(document).ready(function() {

	/* 일정 등록 글자수 제한 */
    var schedulMaxL = 1500;
	
    $('#CAL_CONT').keyup(function (e){
        var title = $(this).val().trim();
        /* 제한글자 수를 넘어갔을 경우 */
        if(title.length>=schedulMaxL){
            $(this).val(title.substr(0,schedulMaxL));
        }
        // 글자수 표현해달라 할경우 추가
        //$('#schedul_cnt').text($(this).val().length);

    }).change(function (e){
        var title = $(this).val().trim();
        /* 제한글자 수를 넘어갔을 경우 */
        if(title.length>=schedulMaxL){
            $(this).val(title.substr(0,schedulMaxL));
        }
     	// 글자수 표현해달라 할경우 추가
        //$('#schedul_cnt').text($(this).val().length);
    });

    $('.list_schedul .modify_active .schedul_write textarea ').keyup(function (e){
        var title = $(this).val().trim();
        /* 제한글자 수를 넘어갔을 경우 */
        if(title.length>=schedulMaxL){
            $(this).val(title.substr(0,schedulMaxL));
        }
     	// 글자수 표현해달라 할경우 추가
        //$('.list_schedul .modify_active .schedul_write p .byte em').text($(this).val().length);

    }).change(function (e){
        var title = $(this).val().trim();
        /* 제한글자 수를 넘어갔을 경우 */
        if(title.length>=schedulMaxL){
            $(this).val(title.substr(0,schedulMaxL));
        }
     	// 글자수 표현해달라 할경우 추가
        //$('.list_schedul .modify_active .schedul_write p .byte em').text($(this).val().length);
    });
});


/* 일정 저장 */
function sch_comp(CAL_DATE){

	var CAL_CONT = $('#CAL_CONT').val().trim();
    
    if(CAL_CONT == "")
    {
        alert("내용을 입력해주세요");
        $('#sch_text').val('')
        $('#sch_text').text('0')
        $('#sch_text').focus();
    }else{
    	
        // 저장 후 1페이지로 이동
       var formMap = {"saveGbn":"0",
                "CAL_DATE":CAL_DATE,
                "CAL_CONT":CAL_CONT };
       cusFormNew("${contextPath }/adm/calendarMgr/insert", formMap);
    }
}

/* 일정 수정 */
function modify_show(seq,contents){
	var modify = "#modify_"+seq;
	var schedul = "#schedul_"+seq;

	var modify_text = modify+' .schedul_write textarea'
	var modify_textCnt = modify+' .schedul_write p .byte em'
	$(modify_textCnt).text($(modify_text).val().length);
	
	var modi_contents = contents.replace(/<br>/gi, '\n')
	$(modify_text).val(modi_contents);

	$(modify).show();
	$(schedul).css('display','none');
}

/* 일정 수정취소 */
function modify_cancle(seq,contents){
	var modify = "#modify_"+seq;
    var schedul = "#schedul_"+seq;

    var modify_text = modify+' .schedul_write textarea'

    var modi_contents = contents.replace(/<br>/gi, '\n')

    $(modify_text).val(modi_contents);
	$(schedul).show();
    $(modify).css('display','none');
}

   /* 일정 수정 완료 */
function modify_comp(seq){
    var modify = "#modify_"+seq;
    var schedul = "#schedul_"+seq;

    var modify_text = modify+' .schedul_write textarea'
    var modify_textCnt = modify+' .schedul_write p .byte em'

    var schedul_text = $(modify_text).val().trim();

    if(schedul_text == "")
    {
        alert("내용을 입력해주세요");
        $(modify_text).val('')
        $(modify_textCnt).text('0')
        $(modify_text).focus();
    }else{

    	var formMap = {"saveGbn":"1",
                "CAL_DATE":"${CAL_DATE }",
                "CAL_CONT":schedul_text,
                "CAL_SEQ":seq};
       cusFormNew("${contextPath }/adm/calendarMgr/insert", formMap);
    }
}


/* 일정 삭제 완료 */
function schedul_delete(seq){

	if(confirm("삭제하시겠습니까?") == true){
		var formMap = {"saveGbn":"2",
                "CAL_DATE":"${CAL_DATE }",
                "CAL_SEQ":seq };
       cusFormNew("${contextPath }/adm/calendarMgr/insert", formMap);
	}
}

</script>

<script src="${contextPath }/resources/js/jquery-barcode-2.0.2.min.js"></script>

<section class="content-header">
	<h1>
		일정관리
		<small>일정관리</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol>
</section>


<html lang="ko">

<HEAD>
   <TITLE>캘린더</TITLE>

   <meta http-equiv="content-type" content="text/html; charset=utf-8">
   <script type="text/javaScript" language="javascript"> 
   </script>

   <style TYPE="text/css">
        
		.schedul_wrap {padding-top:36px;}
		.schedul_wrap strong {margin-left: 50px;font-size: 30px; margin-bottom: 50px}
		.schedul_wrap .list_result {border-bottom:2px solid #a6a9ab;}
		.schedul_wrap .schedul_write {position:relative;padding:10px;background:#f3f3f3;border-bottom:1px solid #e6e6e6;}
		.schedul_wrap .schedul_write textarea {width:92%;height:80px;padding:5px;background:#fff;border:1px solid #e6e6e6;box-sizing:border-box;overflow:auto;overflow-x:hidden;}
		.schedul_wrap .schedul_write p {position:absolute;right:10px;top:10px;width:90px;text-align:center;}
		.schedul_wrap .schedul_write p .mbtn.white {display:block;min-width:90px;margin-bottom:13px;}
		.schedul_wrap .list_schedul {background: white;margin-top: 10px; margin-left: 30px;margin-right: 30px;margin-bottom: 15px;}
		.schedul_wrap .list_schedul > li {position:relative;padding:20px 100px 8px 20px;border-bottom:1px solid #e6e6e6;word-break:break-all;}
		.schedul_wrap .list_schedul > li.modify_active {background:#f3f3f3;}
		.schedul_wrap .list_schedul > li.modify_active .schedul_write {position:relative;padding:5px;background:#f3f3f3;border-bottom:1px solid #e6e6e6}
		.schedul_wrap .list_schedul > li.modify_active .schedul_write textarea {width:95%;height:80px;padding:5px;background:#fff;border:1px solid #e6e6e6;box-sizing:border-box;overflow:auto;overflow-x:hidden;}
		.schedul_wrap .list_schedul > li.modify_active .schedul_write p {right:0;}
		.schedul_wrap .list_schedul .schedul_id {display:block;position:absolute;left:20px;top:42px;}
		.schedul_wrap .list_schedul .schedul_date {color:#999;}
		.schedul_wrap .list_schedul .schedul_con {padding:6px 0 9px;color:#333;white-space:normal;word-break: break-all;}/* 2018-05-28 수정 */
		.schedul_wrap .list_schedul .schedul_btn {position:absolute;right:20px;top:20px;z-index:10;}
		.schedul_wrap .list_schedul .schedul_btn a {display:inline-block;position:relative;padding-left:16px;}
		.schedul_wrap .list_schedul .schedul_btn a:first-child {color:#ef3116;}
		.schedul_wrap .list_schedul .schedul_btn a:first-child::after {content:'';display:inline-block;position:absolute;right:-11px;top:4px;width:2px;height:12px;background:#ccc;}

   </style>
</HEAD>
<BODY>

<!-- 일정리스트 -->

<section class="content">
<div class="schedul_wrap">

	<strong>${CAL_DATE } 일정입니다</strong>
	<a href="${contextPath}/adm/calendarMgr/list" class="btn btn-default pull-right">리스트</a>
    <div class="schedul_write">
        <textarea rows="1" cols="1" id = "CAL_CONT"></textarea>
        <p>
            <a href="javascript:sch_comp('${CAL_DATE }')" class="btn btn-primary btn-sm pull-right" style="margin-right: 10px;width: 90%;height: 80px;font-size: 15px;padding-top: 28px">등록</a> <span class="byte"></span>
        </p>
     </div>

	<ul class="list_schedul">
		<c:forEach var="list" items="${schedulMap }" varStatus="sta">
            <!-- 댓글 row한개 -->
			<li id = "schedul_${list.CAL_SEQ }">
				<c:out value="${sta.count }.  " escapeXml="false" />
				<c:out value="${list.CAL_CONT }" escapeXml="false" />	
				<p class="schedul_btn">
					<a href="javascript:modify_show('${list.CAL_SEQ }','${list.CAL_CONT }')">수정</a>
					<a href="javascript:schedul_delete('${list.CAL_SEQ }')">삭제</a>
				</p>	
			</li>
			<!-- 댓글 row한개 -->

	        <!-- 수정 클릭시 -->
	        <li class="modify_active"  style="display:none" id = "modify_${list.CAL_SEQ }">
	           <p class="schedul_btn">
	               <a href="javascript:modify_cancle('${list.CAL_SEQ }','${list.CAL_CONT }')">수정취소</a>
	               <a href="javascript:modify_comp('${list.CAL_SEQ }')">수정</a>
	           </p>
	           
	           <div class="schedul_write">
	               <textarea rows="1" cols="1"><c:out value="${list.CAL_CONT }" escapeXml="false" /></textarea>
	           </div>
	        </li>
	        <!-- //수정 클릭시 -->

		</c:forEach>
	</ul>
</div>

<!-- //일정리스트 -->

</section>