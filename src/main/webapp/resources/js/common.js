/*******************************************************************************
 * [ Validate ] NULL 체크
 * 
 * 입력 : formName 폼 객체 이름, objName 검사 할 폼 객체 focusName 검사 후 해당 객체로 포커스이동,
 * alertMsg 검사 메세지 사용 : if ( !validateNullCheck("form", "userId", "userId",
 * "사용자ID을 입력하세요 ") ) return false;
 ******************************************************************************/
/*function validateNullCheck(formName, objName, focusName, alertMsg) {
	var strObj = eval(formName + "." + objName);
	var objType = "";
	
	if (strObj.type == undefined) {
		objType = strObj[0].type;
	} else {
		objType = strObj.type;
	}
	
	if (objType.toLowerCase() != "checkbox") {
		// 단일 셀렉트박스를 아래 if문에서 인식 못하는 버그를 수정(20140715_이규동) => 코드추가 : || (objType.toLowerCase().substr(0,6) == "select" && strObj.size != undefined)
		if (strObj.length == undefined || (objType.toLowerCase().substr(0,6) == "select" && strObj.size != undefined) ) {
			if (strObj.value.replace(/^\s+|\s+$/g, '') == "") {
				if (alertMsg != "" && alertMsg != undefined ) {
					alert(alertMsg);
				} else {
					if(objType.toLowerCase().substr(0,6) == "select") { //select타입 인식방법 수정(20140715_이규동) => 원본 : objType.toLowerCase() == "selectbox"
						alert(strObj.getAttribute("title")+"(을)를 선택하세요");
					} else{
						alert(strObj.getAttribute("title")+"(을)를 입력하세요");
					}
				}
				if (focusName != "") {
					var strFocus = eval(formName + "." + focusName);
					strFocus.focus();
				}
				return false;
			}
		} else {
			for (i=0; i<strObj.length; i++) {
				if (strObj[i].value.replace(/^\s+|\s+$/g, '') == "") {
					if (alertMsg != "" && alertMsg != undefined ) {
						alert(alertMsg);
					} else {
						if(objType.toLowerCase().substr(0,6) == "select") { //select타입 인식방법 수정(20140715_이규동) => 원본 : objType.toLowerCase() == "selectbox"
							alert(strObj[i].getAttribute("title")+"(을)를 선택하세요");
						} else{
							alert(strObj[i].getAttribute("title")+"(을)를 입력하세요");
						}
					}
					if (focusName != "") {
						var strFocus = eval(formName + "." + focusName + "[" + i + "]");
						strFocus.focus();
					}
					return false;
				}
			}
		}
	} else {
		if (!fnGetCheckBoxValue(objName)) {
			if (alertMsg != "" && alertMsg != undefined ) {
				alert(alertMsg);
			} else {
				alert(strObj.getAttribute("title")+"(을)를 선택하세요");
			}
			return false;
		}	
	}
	return true;
}*/

$(function() {

	$('.goodsImg').each(function() {
		$(this).error(function(){
			$(this).attr('src', '/resources/images/mall/goods/noimage.png');
		});
	 });

	$('.goodsImg270').each(function() {
		$(this).error(function(){
			$(this).attr('src', '/resources/images/mall/goods/noimage_270.png');
		});
	 });
	
	//숫자만 입력토록 함.
    $(document).on("keyup", ".number", function() {
    	$(this).number(true);
    });
})
/*******************************************************************************
 * [ Validate ] NULL 체크
 * 
 * 입력 : 폼 아이디
 * 필수 입력값(input, select)에 est(esential)="1" 속성 지정
 * title 속성 지정시 title을 입력(선택)하세요 alert지정
 ******************************************************************************/
function validateNullCheck(frmId){
	var result = true;
	var frm = $("#"+frmId+" input[est=1], select[est=1]").not("input[type=hidden]").not("input[type=radio]")
	var chkNum = 2;
	frm.each(function(idx, ele){
		if("" == $(ele).val() || null == $(ele).val()){
			if( typeof $(ele).attr("type") == "undefined"){
				alert($(ele).attr("title") + "을(를) 선택하세요");
			}else{
				alert($(ele).attr("title") + "을(를) 입력하세요");
			}
			$(ele).focus();
			result = false;
			return false;
		}
		if($(ele).attr("type") == "password"){
			//비밀번호문자, 숫자, 특수문자조합 validation
		    if(!$(ele).val().match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)){
		    	alert("비밀번호는 문자, 숫자, 특수문자의 조합으로 6~16자리로 입력해주세요.");
		    	result = false;
				return false;
		    }
		}
		
	});
	
	/*checkbox 이용시 사용예정*/
	/*if($(ele).prop("type") == "checkbox"){
		if($("input[name="+$(ele).prop("name")+"]:checkbox:checked").length != chkNum){
			alert($(ele).attr("title")+"(을)를은 "+chkNum+"개만 선택하세요");
			$(ele).focus();
			result = false;
			return false;
		}*/
	return result;
}
/*******************************************************************************
 * [ Validate ] 숫자,음수,소숫점만 입력
 * 
 * 입력 : 폼 객체 허용 : 0~9, -(음수), .(소숫점) 사용 : onkeyup="validateNonNumberDot(this)"
 ******************************************************************************/
function validateNonNumberDot(from) {
	$(from).val($(from).val().replace(/[^\-.0-9]/gi,""));
	
	// - 부호 제거(첫번째 이후)
	var strValArr = $(from).val().split("-");
	if(strValArr.length > 1){
		if(strValArr[0] == "")
			$(from).val("-" + strValArr.join(""));
		else
			$(from).val(strValArr.join(""));
	}
	
	// . 소숫점 제거(첫번째 이후)
	var strValArr = $(from).val().split(".");
	if(strValArr.length > 1){
		$(from).val(strValArr.join(""));
		$(from).val($(from).val().replace(strValArr[0], strValArr[0]+"."));
	}
}	

/*******************************************************************************
 * [ Validate ] 영어, 숫자만 입력
 * 
 * 입력 : 폼 객체 허용 : 영어, 숫자 사용 : onkeyup="validateNonKorean(this)"
 ******************************************************************************/
function validateNonKorean(from) {
	$(from).val($(from).val().replace(/[가-힣ㄱ-ㅎㅏ-ㅣ]/gi,""));
	                                 
	// - 부호 제거(첫번째 이후)
	var strValArr = $(from).val().split("-");
	if(strValArr.length > 1){
		if(strValArr[0] == "")
			$(from).val("-" + strValArr.join(""));
		else
			$(from).val(strValArr.join(""));
	}
	
	// . 소숫점 제거(첫번째 이후)
	var strValArr = $(from).val().split(".");
	if(strValArr.length > 1){
		$(from).val(strValArr.join(""));
		$(from).val($(from).val().replace(strValArr[0], strValArr[0]+"."));
	}
}

/*******************************************************************************
 * [ Validate ] 콤마만 제외
 * 
 * 입력 : 폼 객체 허용 : 콤마만 제외 : onkeyup="validateNonCom(this)"
 ******************************************************************************/
function validateNonCom(from) {
	$(from).val($(from).val().replace(/,/gi,""));
}

/*******************************************************************************
 * [ Validate ] 하이픈만 제외
 * 
 * 입력 : 폼 객체 허용 : 하이픈만 제외 : "validateNonHyphen(value)"
 ******************************************************************************/
function validateNonHyphen(value) {
	return value.replace(/-/gi,""); 
}

/*******************************************************************************
 * [ CheckBox ] 체크된 체크박스의 Value 값을 가져온다
 * 
 * 입력 : CheckBox Name 사용 : fnGetCheckBoxValue("chk");
 ******************************************************************************/
function fnGetCheckBoxValue(obj_name) {
	
	// 객체가 한개인지 여러개 인지 체크
	obj = eval("document.all." + obj_name);	
	if(obj.length != null) {
		
		// 객체가 여러개 일때.
		var len = obj.length;
		var i;
		var cnt = 0;
		r_value = ""
		for (i=0;i<len;i++)
		{
			if (obj[i].checked == true)
			{
				cnt++;
				if (cnt == 1) {
					r_value = obj[i].value;
				} else {
					r_value = r_value + "," + obj[i].value;
				}
			}
		}
		
		if (r_value.length == 0) {
			return false;
		} else {
			return r_value;
		}
		
	} else {
		
		// 객체가 한개일때.
		if (obj.checked == true) {
			return (obj.value);
		} else {
			return false;
		}
	}
}


/*******************************************************************************
 * [ Select ] 해당하는 셀렉트 value 가져오기
 * 
 * 입력 : 셀렉트 아이디, 셀렉트 선택값 사용 : fnOptionSelected("오브젝 아이디","선택할 값")
 ******************************************************************************/
function fnOptionSelected(id, val){
	var id = document.getElementById(id);
	for(i=0; i < id.length; i++){
		if(id.options[i].value == val){
			id.options[i].selected = true;
		}
	}
}

/*******************************************************************************
 * [ Select ] 해당하는 셀렉트 text 가져오기
 * 
 * 입력 : 셀렉트 아이디, 셀렉트 선택값 사용 : fnSelectedText("오브젝트")
 ******************************************************************************/
function fnSelectedText(objSelect)
{
    var selectedtext;
    for(var i=0;i<objSelect.options.length;i++){
        if(objSelect.options[i].selected==true){
            selectedtext= objSelect.options[i].text;
            break;
        }
    }
    return selectedtext;
}

/*******************************************************************************
 * [ Radio ] Checked 된 Value 가져오기
 * 
 * 입력 : 폼 이름, Radio 아이디 사용 : getCheckedVal("frm", "job")
 ******************************************************************************/
function getCheckedVal(formName, fieldName)
{
	var strObj = eval("document." + formName + "." + fieldName);
    var checkedVal;
    for(var i=0;i<strObj.length;i++){
    	if(strObj[i].checked){
    		checkedVal = strObj[i].value;
            break;
        }
    }
    return checkedVal;
}

/*******************************************************************************
 * [ 인코딩 ]
 * 
 * 입력 : URL 사용 : fnUrlEncode("URL")
 ******************************************************************************/
function fnUrlEncode(sStr) {
    return escape(sStr).replace(/\+/g, '%2C').replace(/\"/g,'%22').replace(/\'/g, '%27');
}

/*******************************************************************************
 * [ 날짜체크 ] 입력한 날짜가 패턴에 맞는지 체크
 * 
 * 입력 : YYYY-MM-DD, YYYYMMDD 사용 : onChange="fnChkDate(this,'YYYY-MM-DD')"
 ******************************************************************************/
function fnChkDate(obj, pattern) 
{
	var input = obj.value.replace(/-/g,"");
	var inputYear = input.substr(0,4);
	var inputMonth = input.substr(4,2) - 1;
	var inputDate = input.substr(6,2);
	var resultDate = new Date(inputYear, inputMonth, inputDate);
	
	if ( resultDate.getFullYear() != inputYear || resultDate.getMonth() != inputMonth || resultDate.getDate() != inputDate) {
		obj.value = "";
		if (pattern == "YYYY-MM-DD") {
			alert("지정된 날짜형식이 아닙니다.\n YYYY-MM-DD 형식으로 입력해 주십시오");
		} else {
			alert("지정된 날짜형식이 아닙니다.\n YYYYMMDD 형식으로 입력해 주십시오");
		}
		obj.focus();
		return false;
	} else {
		if (pattern == "YYYY-MM-DD") {
			obj.value = inputYear + "-" + input.substr(4,2) + "-" + inputDate;
		} else {
			obj.value = inputYear + "" + input.substr(4,2) + "" + inputDate;
		}
		return true;
	}
}


// 키업시 입력데이터를 3자리마다 콤마를 붙혀준다.
function check(f) {
  var len;
  var str = f.value;
  str = str.replace(/,/g,'');
  var str1 = '';

  len = str.length;

  if(len>3) {
    for(var i=0;len-i-3>0;i+=3) {
      str1 = ','+str.substring(len-3-i,len-i)+str1;
    }
    str1 = str.substring(0,len-i)+str1;
    f.value = str1;
  }
}

// 콤마 삭제
function commaRemove(txt) {
	var str = "";
	if(txt != null){
		str = txt;
		str = str.replace(/,/g,'');
		str = str.replace(/ /g,'');
	}
	return str;
}

// 콤마 삭제
// input 중에서 class="number" 또는 class="number wfull"를 찾아서 콤마 삭제
function commaRemoveAll(obj) {
	var item = obj.getElementsByTagName("input");
	
	if( item != null && item.length> 0) {
		for (var i = 0 ; i < item.length ; i++) {
			if(item[i].type == "text" && item[i].className.indexOf("number")>=0){
				item[i].value = commaRemove(item[i].value);
			}
		}
	}
}

// 부모창에서 아이프레임 크기 조정
function iframeResize(name)
{
	if(name == null || name == "")
		return;
	try{
		var obj = eval("document." + name);
		var oBody = obj.document.body;
		var oFrame = document.all(name);
		var iHeight = oBody.scrollHeight + (oBody.offsetHeight - oBody.clientHeight);
		var iWidth = oBody.scrollWidth + (oBody.offsetWidth - oBody.clientWidth);
		
		oFrame.style.height = iHeight;
	} catch(e) {
		window.status = 'Error: ' + e.number + '; ' + e.description;
	}
}

// 쿠키값 설정
function setCookie(name, value, expiredays)
{
	var today = new Date();
	today.setDate( today.getDate() + expiredays );
	document.cookie = name + "=" + escape(value) + "; path="+contextPath+"; expires=" + today.toGMTString() + ";";
}

// 쿠키값 가져오기
function getCookie(key)
{
	var cook = document.cookie + ";";
	var idx = cook.indexOf(key,0);
	var val = "";
	
	if(idx!=-1)
	{
		cook = cook.substring(idx,cook.length);
		begin = cook.indexOf("=",0) + 1;
		end = cook.indexOf(";",begin);
		val = unescape(cook.substring(begin,end));
	}
	
	return val;
}

// 상위메뉴 Click
function fnMenuTop(url, menuid)
{
	setCookie("MenuCode", menuid, 1);
	setCookie("MenuCodeSub", url, 1);
	document.location.href = url;
}

// 하위메뉴 Click
function fnMenuSub(url, menuid)
{
	// setCookie("MenuCodeSub", url, 1);
	// document.location.href = url;
	
	/*
	 * if(url.replace(/\?/g,'') == url) { document.location.href = url +
	 * "?menuid=" + menuid; } else { document.location.href = url + "&menuid=" +
	 * menuid; }
	 */
	document.location.href = url;
}



// 체크박스 전체선택
function fnCheckAll(objName)
{
	checked = $("input:checkbox[name=toggleChk]").is(":checked");
	$("input:checkbox[name=" + objName + "]").each(function() {
		this.checked = checked;
	});
}

// 엑셀파일 여부 검사
function fnCheckExcelFileType(filePath)
{
	var fileFormat = filePath.toLowerCase();
	
	if( fileFormat.indexOf(".xls") > -1 ){
		return true;
	}else{
		alert("엑셀파일만 업로드 하실수 있습니다.");
		return false;
	}
}

//테이블을 동적으로 rowspan 
jQuery.fn.rowspan = function(colIdx) {
	return this.each(function(){
		var that;
		$('tr', this).each(function(row) {
			$('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {
			if ($(this).html() == $(that).html()) {
				rowspan = $(that).attr("rowSpan");
				if (rowspan == undefined) {
					$(that).attr("rowSpan",1);
					rowspan = $(that).attr("rowSpan");
				}
				rowspan = Number(rowspan)+1;
				$(that).attr("rowSpan",rowspan); // do your action for the colspan cell here
				$(this).hide(); // .remove(); // do your action for the old cell here
			} else {
				that = this;
			}
			that = (that == null) ? this : that; // set the that if not already set
			});
		});
	});
}

//테이블을 동적으로 colspan 
jQuery.fn.colspan = function(rowIdx) {
	return this.each(function(){
		var that;
		$('tr', this).filter(":eq("+rowIdx+")").each(function(row) {
			$(this).find('td').filter(':visible').each(function(col) {
			if ($(this).html() == $(that).html()) {
				colspan = $(that).attr("colSpan");
				if (colspan == undefined) {
					$(that).attr("colSpan",1);
					colspan = $(that).attr("colSpan");
				}
				colspan = Number(colspan)+1;
				$(that).attr("colSpan",colspan);
				$(this).hide(); // .remove();
			} else {
				that = this;
			}
			that = (that == null) ? this : that; // set the that if not already set
			});
		});
	});
}

function fnUiMove(ui)
{
	document.location.href = "usrIntList.do?ui=" + ui;
}

/*******************************************************************************
 * [ Table ] 동일한 td를 rowspan으로 합친다(row와 col의 범위지정 값 필요)
 * 이규동
 * 입력 : 테이블 Object, 시작 Row, 마지막 Col 
 * 사용 : fnTableRowspan( document.getElementById("tableId"), 1, 0 );
 * 주의 : 1.테이블이 먼저 완성 된 후에 함수가 실행되어야 함, 2.Row와 Col의 값은 0부터시작
 ******************************************************************************/
function fnTableRowspan(tableObj, startRow, endCol){
	//Input 값이 없거나 숫자가 아니면 기본값을 넣어준다
	if(startRow == '' || startRow == null || (startRow+0).length != startRow.length)
		startRow = 1; //0번째 ROW는 보통 헤더이므로 제외하는 것
	if(endCol == '' || endCol == null || (endCol+0).length != endCol.length)
		endCol = 0; //0번째 col만 합쳐준다.
	
	for (var i=tableObj.rows.length-1; i>startRow; i--) {
		var o_tr=tableObj.rows[i], o_tr2=tableObj.rows[(i-1)];
		for (var j=endCol; j>=0; j--) { // j=o_tr.cells.length-1 : 전체
			var o_td=o_tr.cells[j], o_td2=o_tr2.cells[j];
			if (o_td.innerHTML==o_td2.innerHTML) {
				o_td2.rowSpan+=o_td.rowSpan;
				o_td.parentNode.removeChild(o_td);
			}
		}
	}
}

/*******************************************************************************
 * (Ver 0.9) 테이블을 엑셀형식으로 다운로드 (table to excel down)
 * 이규동
 * 입력 : 저장할 이름, 테이블을 감싸고 있는 DIV의 ID
 * 사용 : fnTableToExcelDown( "엑셀파일", "divId" ); 
 * 사용2 : fnTableToExcelDown("$+이부분제거+{ fn:replace(fn:trim( fn:split(PARMENU.mnuPath, '|')[fn:length( fn:split(PARMENU.mnuPath, '|') )-1] ), ' ', '_') }", "excelDownDiv");
 * 주의 : 반드시 테이블을 div로 감싼뒤에 div의 id를 넘겨야한다. 주석은 독립된 라인에만 있어야 하며 같은 라인에서 시작하고 끝내야 한다.(ex: <!-- 주석 -->)
 * 개선점 : html이므로 엑셀에서 오류창이 한번 뜬다. 엑셀프로그램에서 다른이름으로 저장(엑셀파일로 지정)해 주어야만 완전한 엑셀 파일이 된다.
 ******************************************************************************/
function fnTableToExcelDown(name, id)
{
	//테이블 데이터 생성
	var tableData = document.getElementById(id).innerHTML;
	if(tableData.length < "<table>".length) { //테이블이 없으면 다운을 중지한다.
		alert("다운로드 데이터가 없습니다.");
		return false;
	}
	
	/*테이블에서 특정 태그를 삭제*/
	//링크(href='', onClick="") 삭제
	rexVal = /(?:href|onClick)\=\"[^\"]*(?=\")\"/ig;
	tableData = tableData.replace(rexVal, '');
	rexVal = /(?:href|onClick)\=\'[^\']*(?=\')\'/ig;
	tableData = tableData.replace(rexVal, '');
	
	//체크박스(checkbox)가 있는 td 또는 th를 삭제 / ex: <th width="30"><input name="toggleChk" type="checkbox" onclick="javascript:fnCheckAll('lonCodArr')"></th>
	//정규식 설명 => (th|td) : th나 td, ([^\>]*)(?=\>) : '>'를 제외한 모든 문자열중 '>'로 끝나는 것('>'는 제외됨)
	rexVal = /\<(th|td)([^\>]*)(?=\>)\>([^\<]*)(?=\<)\<(input)([^\>]*)(?=checkbox)(checkbox)([^\>]*)(?=\>)\>([^\<]*)(?=\<\/\1\>)\<\/\1\>/ig;
	tableData = tableData.replace(rexVal, '');
	
	//주석( <!-- 주석 -->) 삭제 (동일한 라인에서만 검색됨)
	rexVal = /(?:\<\!\-\-)(?:.*)(?=\-\-\>)(?:\-\-\>)/ig;
	tableData = tableData.replace(rexVal, '');
	
	
	//지정한 시작 태그들 외에 모든 태그를 삭제 : 추가시 "(?!\/|table"뒤에 "|"를 넣은후 태그를 입력(시작과 종료 모두 추가해야함)
	rexVal = /\<(?!\/|\!\-\-|table|caption|colgroup|col|thead|tfoot|tbody|tr|th|td|div|br|p)(?:[^\>]*)(?=\>)\>/ig;
	tableData = tableData.replace(rexVal, '');
	//위와 동일하며 종료 태그를 삭제 
	rexVal = /\<\/(?!\/|table|caption|colgroup|col|thead|tfoot|tbody|tr|th|td|div|br|p)(?:[^\>]*)(?=\>)\>/ig;
	tableData = tableData.replace(rexVal, '');
	
	
	/*테스트*/
//	rexVal = /\n|\t/ig; tableData = tableData.replace(rexVal, '');
//	rexVal = /\>/ig; tableData = tableData.replace(rexVal, '>\n');
//	rexVal = /\<\//ig; tableData = tableData.replace(rexVal, '\n</');
//	rexVal = /\n{2,}/ig; tableData = tableData.replace(rexVal, '\n');
//	alert(tableData);
//	return false;
	
	//처리
	var form = document.createElement("form");

	form.setAttribute("method", "post");
	form.action = "./excel_xls/excel_default_down.jsp";
	document.body.appendChild(form);
	
	var obj = document.createElement("input");
	obj.setAttribute("type", "hidden");
	obj.setAttribute("name", "excel_file_name");
	obj.setAttribute("value", name);
	form.appendChild(obj);
	
	var obj = document.createElement("input");
	obj.setAttribute("type", "hidden");
	obj.setAttribute("name", "excel_data");
	obj.setAttribute("value", tableData);
	form.appendChild(obj);
	
	form.submit();
}


/*******************************************************************************
 * (Test Ver 0.1) 테이블을 엑셀형식으로 다운로드2 (ActiveXObject사용)
 * 이규동
 * 입력 : 저장할 이름(작동X), 테이블의 ID
 * 사용 : fnTableToExcelDown2( "엑셀파일", "tableId" ); 
 * 사용2 : fnTableToExcelDown2("$+이부분제거+{ fn:replace(fn:trim( fn:split(PARMENU.mnuPath, '|')[fn:length( fn:split(PARMENU.mnuPath, '|') )-1] ), ' ', '_') }", "tableId");
 * 주의 : 테스트 버전이며 IE에서만 테스트됨
 * 개선점 : colspan, rowspan, 파일이름, IE에서만 됨(개선불가?) 등등..
 ******************************************************************************/
function fnTableToExcelDown2(name, id)
{
	try
	{
		var oXL = new ActiveXObject('Excel.Application');
		oXL.Visible = true;
		
		// Get a new workbook.
		var oWB = oXL.Workbooks.Add();
		var oSheet = oWB.ActiveSheet;
		
		var tb  = document.getElementById(id).children[0];
		
		for(var i=0; i<tb.children.length; i++)
		{
			for(var j=0; j<tb.children[i].children.length; j++)
			{
		    	oSheet.Cells(i+1, j+1).Value = tb.children[i].children[j].innerText;  //innerHTML;
			}
		}
	}
	catch(e)
	{
		alert('엑셀 파일을 다운 하시려면 다음 설정을 변경하여 주세요.\n브라우저 옵션 > 도구 > 인터넷옵션 > 보안 > 안전하지 않는 것으로 표시된 AcrivX컨트롤 초기화 > 확인\n또는 이 사이트를 [도구 > 인터넷 옵션 > 보안]의 신뢰할 수 있는 사이트로 등록하세요');
	}
}



/*******************************************************************************
 * 프로그래스창 띄우기
 * 이규동
 * 입력 : 없음
 * 사용 : fnShowProcessing();
 ******************************************************************************/
function fnShowProcessing()
{
	$("#processingDiv").css("visibility", ""); //processingDiv가 보이도록 visibility 속성을 제거한다. 
	$("body > div").hide(); //body의 자식 노드중 모든 div를 숨긴다.
	$("#processingDiv").show(); //processingDiv도 body의 자식 div들 중 하나이기 때문에 show를 해준다. 
}

/*******************************************************************************
 * 프로그래스창 감추기
 * 이규동
 * 입력 : 없음
 * 사용 : fnHideProcessing();
 ******************************************************************************/
function fnHideProcessing()
{
	$("#processingDiv").css("visibility", "hidden"); //processingDiv가 보이도록 visibility 속성을 hidden으로 설정한다. 
	$("body > div").show(); //body의 자식 노드중 모든 div를 보인다.
	$("#processingDiv").hide(); //processingDiv도 body의 자식 div들 중 하나이기 때문에 hide를 해준다. 
}

/*******************************************************************************
 * 엑셀양식 다운로드(코드참조 자동변경)
 * 이규동
 * 입력 :다운로드할 파일이 있는 uri주소
 * 사용 : fnExcelDownBizCodReplace("./excelForm/${ REQMDLNAME }Form.xls"););
 * 주의 : common.controller.CommonExcelController.ExcelDownBizCodReplace 컨트롤러와 함께 사용해야함.
 ******************************************************************************/
function fnExcelDownBizCodReplace(filePath)
{
	var form = document.createElement("form");

	form.setAttribute("method", "post");
	form.action = "./excelDownBizCodReplace.do";
	document.body.appendChild(form);
	
	var obj = document.createElement("input");
	obj.setAttribute("type", "hidden");
	obj.setAttribute("name", "filePath");
	obj.setAttribute("value", filePath);
	form.appendChild(obj);
	
	form.submit();
}


function number_format(data)
{

    var tmp = '';
    var number = '';
    var cutlen = 3;
    var comma = ',';
    var i;

    var sign = data.match(/^[\+\-]/);
    if(sign) {
        data = data.replace(/^[\+\-]/, "");
    }

    len = data.length;
    mod = (len % cutlen);
    k = cutlen - mod;
    for (i=0; i<data.length; i++)
    {
        number = number + data.charAt(i);

        if (i < data.length - 1)
        {
            k++;
            if ((k % cutlen) == 0)
            {
                number = number + comma;
                k = 0;
            }
        }
    }

    if(sign != null)
        number = sign+number;

    return number;
}

//왼쪽에서부터 채운다는 의미
function fn_LPAD(s, c, n) {    

    if (! s || ! c || s.length >= n) {
        return s;
    }
 
    var max = (n - s.length)/c.length;

    for (var i = 0; i < max; i++) {
        s = c + s;
    }

    return s;
}

/**
 * 우편번호 창
 **/
var win_zip = function(frm_name, frm_zip, frm_addr1, frm_addr2, frm_addr3, frm_jibeon) {
    if(typeof daum === 'undefined'){
        alert("다음 우편번호 postcode.v2.js 파일이 로드되지 않았습니다.");
        return false;
    }

    var zip_case = 0;   //0이면 레이어, 1이면 페이지에 끼워 넣기, 2이면 새창

    var complete_fn = function(data){
        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
        var fullAddr = ''; // 최종 주소 변수
        var extraAddr = ''; // 조합형 주소 변수

        // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            fullAddr = data.roadAddress;

        } else { // 사용자가 지번 주소를 선택했을 경우(J)
            fullAddr = data.jibunAddress;
        }

        // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
        if(data.userSelectedType === 'R'){
            //법정동명이 있을 경우 추가한다.
            if(data.bname !== ''){
                extraAddr += data.bname;
            }
            // 건물명이 있을 경우 추가한다.
            if(data.buildingName !== ''){
                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
            extraAddr = (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
        }

        // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
        var of = document[frm_name];

        of[frm_zip].value = data.zonecode;

        of[frm_addr1].value = fullAddr;
        
        if(of[frm_addr3] !== undefined){
        	of[frm_addr3].value = extraAddr;
        }
        
        if(of[frm_jibeon] !== undefined){
            of[frm_jibeon].value = data.userSelectedType;
        }

        of[frm_addr2].focus();
    };

    switch(zip_case) {
        case 1 :    //iframe을 이용하여 페이지에 끼워 넣기
            var daum_pape_id = 'daum_juso_page'+frm_zip,
                element_wrap = document.getElementById(daum_pape_id),
                currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
            if (element_wrap == null) {
                element_wrap = document.createElement("div");
                element_wrap.setAttribute("id", daum_pape_id);
                element_wrap.style.cssText = 'display:none;border:1px solid;left:0;width:100%;height:300px;margin:5px 0;position:relative;-webkit-overflow-scrolling:touch;';
                element_wrap.innerHTML = '<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-21px;z-index:1" class="close_daum_juso" alt="접기 버튼">';
                jQuery('form[name="'+frm_name+'"]').find('input[name="'+frm_addr1+'"]').before(element_wrap);
                jQuery("#"+daum_pape_id).off("click", ".close_daum_juso").on("click", ".close_daum_juso", function(e){
                    e.preventDefault();
                    jQuery(this).parent().hide();
                });
            }

            new daum.Postcode({
                oncomplete: function(data) {
                    complete_fn(data);
                    // iframe을 넣은 element를 안보이게 한다.
                    element_wrap.style.display = 'none';
                    // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                    document.body.scrollTop = currentScroll;
                },
                // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분.
                // iframe을 넣은 element의 높이값을 조정한다.
                onresize : function(size) {
                    element_wrap.style.height = size.height + "px";
                },
                width : '100%',
                height : '100%'
            }).embed(element_wrap);

            // iframe을 넣은 element를 보이게 한다.
            element_wrap.style.display = 'block';
            break;
        case 2 :    //새창으로 띄우기
            new daum.Postcode({
                oncomplete: function(data) {
                    complete_fn(data);
                }
            }).open();
            break;
        default :   //iframe을 이용하여 레이어 띄우기
            var rayer_id = 'daum_juso_rayer'+frm_zip,
                element_layer = document.getElementById(rayer_id);
            if (element_layer == null) {
                element_layer = document.createElement("div");
                element_layer.setAttribute("id", rayer_id);
                element_layer.style.cssText = 'display:none;border:5px solid;position:fixed;width:300px;height:460px;left:50%;margin-left:-155px;top:50%;margin-top:-235px;overflow:hidden;-webkit-overflow-scrolling:touch;z-index:10000';
                element_layer.innerHTML = '<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" class="close_daum_juso" alt="닫기 버튼">';
                document.body.appendChild(element_layer);
                jQuery("#"+rayer_id).off("click", ".close_daum_juso").on("click", ".close_daum_juso", function(e){
                    e.preventDefault();
                    jQuery(this).parent().hide();
                });
            }

            new daum.Postcode({
                oncomplete: function(data) {
                    complete_fn(data);
                    // iframe을 넣은 element를 안보이게 한다.
                    element_layer.style.display = 'none';
                },
                width : '100%',
                height : '100%'
            }).embed(element_layer);

            // iframe을 넣은 element를 보이게 한다.
            element_layer.style.display = 'block';
    }
}




/**
 * 우편번호 창 - 컴포넌트 아이디 버젼
 **/
var win_zip_id = function(frm_name, frm_zip, frm_addr1, frm_addr2, frm_addr3, frm_jibeon) {
    if(typeof daum === 'undefined'){
        alert("다음 우편번호 postcode.v2.js 파일이 로드되지 않았습니다.");
        return false;
    }

    var zip_case = 0;   //0이면 레이어, 1이면 페이지에 끼워 넣기, 2이면 새창

    var complete_fn = function(data){
        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
        var fullAddr = ''; // 최종 주소 변수
        var extraAddr = ''; // 조합형 주소 변수

        // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            fullAddr = data.roadAddress;

        } else { // 사용자가 지번 주소를 선택했을 경우(J)
            fullAddr = data.jibunAddress;
        }

        // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
        if(data.userSelectedType === 'R'){
            //법정동명이 있을 경우 추가한다.
            if(data.bname !== ''){
                extraAddr += data.bname;
            }
            // 건물명이 있을 경우 추가한다.
            if(data.buildingName !== ''){
                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
            extraAddr = (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
        }

        // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
        var of = document[frm_name];
        
        jQuery("#"+frm_zip).val(data.zonecode);
        jQuery("#"+frm_addr1).val(fullAddr);
        
        if(frm_addr3 !== ""){
            jQuery("#"+frm_addr3).val(extraAddr);
        }
        
        if(frm_jibeon !== undefined){
            jQuery("#"+frm_jibeon).val(data.userSelectedType);
        }

        jQuery("#"+frm_addr2).focus();
    };

    switch(zip_case) {
        case 1 :    //iframe을 이용하여 페이지에 끼워 넣기
            var daum_pape_id = 'daum_juso_page'+frm_zip,
                element_wrap = document.getElementById(daum_pape_id),
                currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
            if (element_wrap == null) {
                element_wrap = document.createElement("div");
                element_wrap.setAttribute("id", daum_pape_id);
                element_wrap.style.cssText = 'display:none;border:1px solid;left:0;width:100%;height:300px;margin:5px 0;position:relative;-webkit-overflow-scrolling:touch;';
                element_wrap.innerHTML = '<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-21px;z-index:1" class="close_daum_juso" alt="접기 버튼">';
                jQuery("#"+frm_addr1).before(element_wrap);
                jQuery("#"+daum_pape_id).off("click", ".close_daum_juso").on("click", ".close_daum_juso", function(e){
                    e.preventDefault();
                    jQuery(this).parent().hide();
                });
            }

            new daum.Postcode({
                oncomplete: function(data) {
                    complete_fn(data);
                    // iframe을 넣은 element를 안보이게 한다.
                    element_wrap.style.display = 'none';
                    // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                    document.body.scrollTop = currentScroll;
                },
                // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분.
                // iframe을 넣은 element의 높이값을 조정한다.
                onresize : function(size) {
                    element_wrap.style.height = size.height + "px";
                },
                width : '100%',
                height : '100%'
            }).embed(element_wrap);

            // iframe을 넣은 element를 보이게 한다.
            element_wrap.style.display = 'block';
            break;
        case 2 :    //새창으로 띄우기
            new daum.Postcode({
                oncomplete: function(data) {
                    complete_fn(data);
                }
            }).open();
            break;
        default :   //iframe을 이용하여 레이어 띄우기
            var rayer_id = 'daum_juso_rayer'+frm_zip,
                element_layer = document.getElementById(rayer_id);
            if (element_layer == null) {
                element_layer = document.createElement("div");
                element_layer.setAttribute("id", rayer_id);
                element_layer.style.cssText = 'display:none;border:5px solid;position:fixed;width:300px;height:460px;left:50%;margin-left:-155px;top:50%;margin-top:-235px;overflow:hidden;-webkit-overflow-scrolling:touch;z-index:10000';
                element_layer.innerHTML = '<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" class="close_daum_juso" alt="닫기 버튼">';
                document.body.appendChild(element_layer);
                jQuery("#"+rayer_id).off("click", ".close_daum_juso").on("click", ".close_daum_juso", function(e){
                    e.preventDefault();
                    jQuery(this).parent().hide();
                });
            }

            new daum.Postcode({
                oncomplete: function(data) {
                    complete_fn(data);
                    // iframe을 넣은 element를 안보이게 한다.
                    element_layer.style.display = 'none';
                },
                width : '100%',
                height : '100%'
            }).embed(element_layer);

            // iframe을 넣은 element를 보이게 한다.
            element_layer.style.display = 'block';
    }
}

function fnCopy(str){
	var IE=(document.all)?true:false;
	if (IE) {
		window.clipboardData.setData("Text", str);
		alert ( "클립보드로 복사되었습니다. \'Ctrl+V\'를 눌러 붙여넣기 해주세요." );
	} else {
		temp = prompt("Ctrl+C를 눌러 클립보드로 복사하세요", str);
	}
}



/**
 * 동적으로 form을 생성한다( 새창으로 띄우기 )
 *
 * @author 짱성ㅋ
 * @param action
 *            {String} 요청 주소
 * @param formMap
 *            {Object|String|Array} 요청 데이터 ex> {"curPage":1, "searchGbn":'0', "name": value}
 * @returns
 */
function cusFormNew(action, formMap) {
	var form = document.createElement("form");

	form.method = "post";
	form.action = action;

	document.body.appendChild(form);

	for ( var key in formMap) {
		var input_id = document.createElement("input");
		input_id.setAttribute("type", "hidden");
		input_id.setAttribute("name", key);
		input_id.setAttribute("value", formMap[key]);

		form.appendChild(input_id);
	}

	form.submit();
}
/* 동적 form생성 */


/**
 * 우편번호 창 (도서산간 체크추가)_chjw
 **/
var win_zip_island = function(frm_name, frm_zip, frm_addr1, frm_addr2, frm_addr3, frm_jibeon) {
	// postcode 파일 체크
    if(typeof daum === 'undefined'){
        alert("다음 우편번호 postcode.v2.js 파일이 로드되지 않았습니다.");
        return false;
    }

    /**
     * 주소창 노출 형태
     * 0 : 레이어
     * 1 : 페이지에 끼워 넣기
     * 2 : 새창
     **/
    var zip_case = 0;

    var complete_fn = function(data){
    	/**
         * 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
         * 각 주소의 노출 규칙에 따라 주소를 조합한다.
         * 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
         **/
        var fullAddr = "";	// 최종 주소 변수
        var extraAddr = "";	// 조합형 주소 변수

        /**
         * 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
         * R : 도로명주소
         * J : 지번주소
         **/
        if (data.userSelectedType === 'R') {
        	// 사용자가 도로명 주소를 선택했을 경우(R)
            fullAddr = data.roadAddress;

        } else {
        	// 사용자가 지번 주소를 선택했을 경우(J)
            fullAddr = data.jibunAddress;
        }

        /**
         * 사용자가 선택한 주소가 도로명 타입일때 조합한다.
         **/
        if(data.userSelectedType === 'R'){
            //법정동명이 있을 경우 추가한다.
            if(data.bname !== ''){
                extraAddr += data.bname;
            }
            // 건물명이 있을 경우 추가한다.
            if(data.buildingName !== ''){
                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
            extraAddr = (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
        }

        /**
         * 우편번호와 주소 정보를 해당 필드에 넣는다.
         **/
        var of = document[frm_name];

        of[frm_zip].value = data.zonecode;

        of[frm_addr1].value = fullAddr;
        
        if(of[frm_addr3] !== undefined){
        	of[frm_addr3].value = extraAddr;
        }
        
        if(of[frm_jibeon] !== undefined){
            of[frm_jibeon].value = data.userSelectedType;
        }

        /**
         * 도서산간지역일 경우 추가배송비 적용한다.
         **/
        fn_addrIsland(data.zonecode);
        
        /**
         * 커서를 상세주소 필드로 이동한다.
         **/
        of[frm_addr2].focus();
    };

    switch(zip_case) {
    	// iframe을 이용하여 페이지에 끼워 넣기
        case 1 :
            var daum_pape_id = 'daum_juso_page'+frm_zip,
                  element_wrap = document.getElementById(daum_pape_id),
                  currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
            
            if (element_wrap == null) {
                element_wrap = document.createElement("div");
                element_wrap.setAttribute("id", daum_pape_id);
                element_wrap.style.cssText = 'display:none;border:1px solid;left:0;width:100%;height:300px;margin:5px 0;position:relative;-webkit-overflow-scrolling:touch;';
                element_wrap.innerHTML = '<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-21px;z-index:1" class="close_daum_juso" alt="접기 버튼">';
                
                jQuery('form[name="'+frm_name+'"]').find('input[name="'+frm_addr1+'"]').before(element_wrap);
                jQuery("#"+daum_pape_id).off("click", ".close_daum_juso").on("click", ".close_daum_juso", function(e){
                    e.preventDefault();
                    jQuery(this).parent().hide();
                });
            }

            new daum.Postcode({
                oncomplete: function(data) {
                    complete_fn(data);
                    // iframe을 넣은 element를 안보이게 한다.
                    element_wrap.style.display = 'none';
                    // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                    document.body.scrollTop = currentScroll;
                },
                // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분.
                // iframe을 넣은 element의 높이값을 조정한다.
                onresize : function(size) {
                    element_wrap.style.height = size.height + "px";
                },
                width : '100%',
                height : '100%'
            }).embed(element_wrap);

            // iframe을 넣은 element를 보이게 한다.
            element_wrap.style.display = 'block';
            break;
            
        //새창으로 띄우기    
        case 2 :
            new daum.Postcode({
                oncomplete: function(data) {
                    complete_fn(data);
                }
            }).open();
            break;
            
        //iframe을 이용하여 레이어 띄우기
        default :
            var rayer_id = 'daum_juso_rayer'+frm_zip,
                element_layer = document.getElementById(rayer_id);
            if (element_layer == null) {
                element_layer = document.createElement("div");
                element_layer.setAttribute("id", rayer_id);
                element_layer.style.cssText = 'display:none;border:5px solid;position:fixed;width:300px;height:460px;left:50%;margin-left:-155px;top:50%;margin-top:-235px;overflow:hidden;-webkit-overflow-scrolling:touch;z-index:10000';
                element_layer.innerHTML = '<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" class="close_daum_juso" alt="닫기 버튼">';
                document.body.appendChild(element_layer);
                jQuery("#"+rayer_id).off("click", ".close_daum_juso").on("click", ".close_daum_juso", function(e){
                    e.preventDefault();
                    jQuery(this).parent().hide();
                });
            }

            new daum.Postcode({
                oncomplete: function(data) {
                    complete_fn(data);
                    // iframe을 넣은 element를 안보이게 한다.
                    element_layer.style.display = 'none';
                },
                width : '100%',
                height : '100%'
            }).embed(element_layer);

            // iframe을 넣은 element를 보이게 한다.
            element_layer.style.display = 'block';
    }
}