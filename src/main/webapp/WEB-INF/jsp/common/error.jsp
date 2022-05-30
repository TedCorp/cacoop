<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>


    <!-- Main content -->
    <section class="content">
      <div class="error-page">
        <h2 class="headline text-yellow">Error 404</h2>

        <div class="error-content">
          <h3><i class="fa fa-warning text-yellow"></i> 의도치않는 에러가 발생하였습니다.</h3>
			
          <p>
          	관리자에게 문의하시기 바랍니다. <br/>
          	ERROR CODE : 
          	${fn:split(errorMessage,'###')[1]}
            <%-- ${error } --%>
          </p>

          <form class="search-form">
            <div class="input-group">
              <div class="input-group-btn">
                <input type=button value="되돌아가기" onClick="history.back();">
              </div>
            </div>
            <!-- /.input-group -->
          </form>
        </div>
        <!-- /.error-content -->
      </div>
      <!-- /.error-page -->
    </section>
    <!-- /.content -->