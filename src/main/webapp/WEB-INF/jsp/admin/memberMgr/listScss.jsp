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
.content .box .paging_new li.next .ic{background:url("${contextPath}/resources/ resources2/images/icon_page_next.png") no-repeat 50% 50%}

</style>
<section class="content-header">
	<h1>
		탈퇴회원 	
	</h1>
</section>

<section class="content">
	<!-- 검색 박스 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">검색조건</h3>
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
			<div class="box-body">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-1 control-label">검색어</label>

					<div class="col-sm-2">
						<select name="schGbn" class="form-control select2">
							<option value="MEMB_NAME" selected="selected">회원명</option>
							<option value="MEMB_ID">회원ID</option>
						</select>
					</div>
					<div class="col-sm-6">
						<div class="input-group">
							<input type="search" class="form-control" name="schTxt" placeholder="검색어 입력" value="${param.schTxt }">
							<span class="input-group-btn">
								<button type="submit" class="btn btn-success pull-right">검색</button>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.box-body -->
	</div>
	<!-- /.검색 박스 -->
	
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">탈퇴회원 목록(${totalCnt})</h3>
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
						<th>회원구분</th>
						<th>아이디</th>
						<th>성명</th>
						<th>탈퇴일자</th>						
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${obj.list }" var="ent" varStatus="loop">
					<tr>
						<td class="txt-middle">${ent.RNUM }</td>
						<td>${ent.MEMB_GUBN_NM }</td>
						<td><a href="${contextPath}/adm/memberMgr/edit?MEMB_ID=${ent.MEMB_ID }&pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }${link}"><c:out value="${ent.MEMB_ID }" escapeXml="true"/></a></td>						
						<td>${ent.MEMB_NAME }</td>
						<td>${ent.STOP_DTM }</td>						
					</tr>
				</c:forEach>
				<c:if test="${obj.count eq 0}">
					<tr>
						<td colspan="5">조회된 내용이 없습니다.</td>
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
