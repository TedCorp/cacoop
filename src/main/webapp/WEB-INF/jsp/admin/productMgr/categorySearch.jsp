<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/layout/inc/taglib.jsp" %>

<head>
	<style>
        .resultText{font-size: 12px;color:rgb(0, 183, 255)}
        .titlebox{width:100%; height:25px; background:#00BCD4; color: white; padding: 10px; }
        .resultBox{height:200px;margin-top:15px}
        .searchBox{ border:none; width: calc(100% - 120px);float: left; height:100%}
        .searchBox:focus {outline:none;}
        .searchBtn{float:right; border: none;background: lightgray;color: white; height: 100%;}
        #closeLabel{padding: 8px;  background: #00c0ef;  color: white;  border-radius: 3px;  font-size: 13px;}
        table{font-size:12px;  border-collapse:collapse; border-spacing:0;}
        th{border:1px solid lightgray; width:200px}
        td{border:1px solid lightgray; text-align: center;	}
    </style>
</head>

<body>
	<section class="content">
		
	    <div class="titlebox">
	        카테고리 찾기
	    </div>
	 
	    <div style="padding: 20px;">
	        <div style="border:1px solid lightgrey; margin-top: 10px; height:25px">
	        	<form method="GET"  id="categorySearch" name="categorySearch" action="${contextPath }/adm/productMgr/categorySearch" >
		            <input type="text" class="searchBox" name="text" id="text" >
					<input type="submit" class="searchBtn" value="검색"/>
				</form>
				
	        </div>
	        <div class="resultBox">
	 	        <c:if test="${obj.list[0] ne null}"> 
	 	        	<table>
					<thead>
						<tr>
							<th>카테고리명</th>
							<th>카테고리 코드</th>
						</tr>
					</thead>
					<tbody>
						 <c:forEach  var="cagolist" items="${ obj.list }" varStatus="status" >
						<tr>
							<td>${cagolist.CAGO_NAME }</td>
							<td>${cagolist.CAGO_ID }</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				</c:if>	
				 <c:if test="${obj.list[0] eq null}">
					<span class="resultText"> 검색 결과가 없습니다.</span>
				</c:if>
			</div> 
	        <div style="text-align: center;">
	        	<label for="closeBtn" id="closeLabel">닫기</label>
	            <input type="button" id="closeBtn" onclick="javascript:window.close()" value="닫기" style="display:none">
	        </div>
	    </div>		
</section>
</body>
<script>
function popResizer() {

    window.resizeTo(400,400);
};



</script>

