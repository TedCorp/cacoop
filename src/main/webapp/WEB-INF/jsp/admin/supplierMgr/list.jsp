<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>
<style>
.content .box .paging_new{margin-top:30px}
.content .box .paging_new ul{display:flex;flex-direction:row;justify-content:center;align-items:center}
.content .box .paging_new li{width:30px;height:30px;}
.content .box .paging_new li a{display:block;width:30px;line-height:30px;font-size:14px;font-weight:500;color:#333;text-align:center;}
.content .box .paging_new li i{display:block;width:30px;height:30px}
.content .box .paging_new li.on a{background:#111;color:#fff;}
.content .box .paging_new li.start .ic{background:url("${contextPath}/resources/resources2/images/icon_page_start.png") no-repeat 50% 50%}
.content .box .paging_new li.end .ic{background:url("${contextPath}/resources/resources2/images/icon_page_end.png") no-repeat 50% 50%}
.content .box .paging_new li.prev .ic{background:url("${contextPath}/resources/resources2/images/icon_page_prev.png") no-repeat 50% 50%}
.content .box .paging_new li.next .ic{background:url("${contextPath}/resources/resources2/images/icon_page_next.png") no-repeat 50% 50%}
</style>
<section class="content-header">
	<h1>
		기업(공급사) 관리	
		<small>기업 목록</small>
	</h1>
<!-- 	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
		<li class="active">Here</li>
	</ol> -->
</section>

<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">검색 조건</h3>

			<div class="box-tools pull-right">
				<button type="button" class="btn btn-box-tool"
					data-widget="collapse">
					<i class="fa fa-minus"></i>
				</button>
				<button type="button" class="btn btn-box-tool" data-widget="remove">
					<i class="fa fa-remove"></i>
				</button>
			</div>
		</div>
		<!-- /.box-header -->
		
		<div class="box-body">
			<form class="form-horizontal">
				<div class="box-body">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-1 control-label">검색조건</label>
						<div class="col-sm-2">
							<select name="schGbn" class="form-control select2" >
								<option value="SUPR_NAME" selected="selected">기업명</option>
								<option value="RPRS_NAME">대표자명</option>
							</select>
						</div>
						
						<div class="col-sm-6">
							<div class="input-group">
								<input name="schTxt" type="text" class="form-control" placeholder="검색어 입력" value="${param.schTxt }">
								<span class="input-group-btn">
									<button type="submit" class="btn btn-success pull-right">검색</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- 검색 박스 -->
	
		<div class="box">
			<div class="box-header with-border">
				<h3 class="box-title">기업 목록 (<font color="green"><b>${totalCnt}</b></font>)</h3>
				<div class="box-tools">
					<a href="${contextPath}/adm/supplierMgr/new?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }${link}" class="btn btn-sm btn-primary pull-right right-5" >신규등록</a>
				</div>
			</div>
			<!-- /.box-header -->
			<div class="box-body" style="white-space:nowrap;overflow-x:scroll;">
				<table class="table table-bordered">
					<colgroup>
						<col />
						<col />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th class="txt-middle">번호</th>
							<th class="txt-middle">기업명</th>
							<th class="txt-middle">대표자명</th>
							<th class="txt-middle">사업자등록번호</th>
							<th class="txt-middle">등록일</th>
						<!-- 	<th class="txt-middle">기업회원수 (승인요청)</th> -->
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${obj.list }" var="ent" varStatus="loop">
						<tr>
							<td class="txt-middle">${ent.RNUM }</td>
							<td class="txt-middle"><a href="${contextPath}/adm/supplierMgr/edit/${ent.SUPR_ID }?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }${link}"><c:out value="${ent.SUPR_NAME }" escapeXml="true"/></a></td>
							<td class="txt-middle">${ent.RPRS_NAME }</td>
							<td class="txt-middle">${ent.BIZR_NUM }</td>
							<td class="txt-middle">${ent.REG_DTM }</td>
						<!-- 	<td class="txt-middle"></td> -->
						</tr>
					</c:forEach>
					<c:if test="${obj.count eq 0}">
						<tr>
							<td colspan="6">조회된 내용이 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
			<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
				<First><Previous><AllPageLink><Next><Last>
			</paging:PageFooter>
		</div>
</section>
