<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<div class="sub-title sub-title-underline" id="wrapper_title">
	<h2>	
		회원가입약관 <small class="ml_5"> 회원가입약관 및 개인정보처리방침안내의 내용에 동의하셔야 회원가입 하실 수 있습니다.</small>
	</h2>
	<ul>
		<li><a href='${contextPath }' class="sct_bg">Home</a></li>
		<li><a href="${contextPath }/memberJoinStep1" class=" ">가입하기</a></li>
	</ul>
	<div class="clearfix"></div>
</div><!-- 글자크기 조정 display:none 되어 있음 시작 { -->

<!-- 회원가입약관 동의 시작 { -->
<div class="mbskin">
    <form  name="fregister" id="fregister" action="memberJoinStep2" onsubmit="return fregister_submit(this);" method="POST" autocomplete="off">

		<div class="submenu-box">
			<div class="panel panel-submenu">
				<div class="panel-heading">
					<p>회원가입약관</p>
				</div>
				<div class="panel-body">
			        <textarea rows="10" class="form-control" readonly>${TERM[0].TERM_CONT }</textarea>

					<div class="checkbox">
					  <label>
					    <input type="checkbox" name="agree" value="1">
					    회원가입약관의 내용에 동의합니다.
					  </label>
					</div>

				</div>
			</div>
		</div>

		<div class="submenu-box">
			<div class="panel panel-submenu">
				<div class="panel-heading">
					<p>개인정보처리방침안내</p>
				</div>
				<div class="panel-body">
					<textarea rows="10" class="form-control" readonly>${TERM[1].TERM_CONT }</textarea>
					<div class="checkbox">
					  <label>
					    <input type="checkbox" name="agree2" value="1">
					    개인정보처리방침안내의 내용에 동의합니다.
					  </label>
					</div>

				</div>
			</div>
		</div>


	    <div class="text-center">
	        <input type="submit" class="btn btn-sm btn-default" value="회원가입">
	    </div>

    </form>

    <script>
    function fregister_submit(f)
    {
        if (!f.agree.checked) {
            alert("회원가입약관의 내용에 동의하셔야 회원가입 하실 수 있습니다.");
            f.agree.focus();
            return false;
        }

        if (!f.agree2.checked) {
            alert("개인정보처리방침안내의 내용에 동의하셔야 회원가입 하실 수 있습니다.");
            f.agree2.focus();
            return false;
        }

        return true;
    }
    </script>
</div>
<!-- } 회원가입 약관 동의 끝 -->