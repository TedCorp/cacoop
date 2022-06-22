package mall.web.apiLink;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.JSONArray;
import org.json.JSONObject;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

//import mall.web.domain.LinkAPI;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.service.mall.OrderService;
import mall.web.service.mall.ProductService;

public class ModenOfficeAPI{
	
	
	
	// 모든오피스 최초 상품 동기화
	public void setProduct(ProductService productService) throws Exception{
		
		//상품동기화 (스케줄러)
		
		InputStream is = getClass().getClassLoader().getResourceAsStream("/modenoffice_product.txt");
		BufferedReader bf = new BufferedReader(new InputStreamReader(is));
		String row;
		
		int itemp = 0;

		// modenoffice_product 정보 불러옴
		while ((row = bf.readLine()) != null) {
	
			System.out.println("진행 >> " + (itemp ++) );
			
			//if(itemp < 3323)
				//continue;

			Map<String, String> param = new HashMap<String, String>();		
			param.put("key", row);
			
			
			// response.data.allItems.pageInfo.hasNextPage TRUE면 더 검색 // do - while문
			// response.data.allItems.pageInfo.endCursor
			
			JSONObject result;
			
			// 조회
//			result = execModenOfficeQuery_read("getItem", param);
//			
//			// 상품정보
//			JSONArray MshpZidInfo = (JSONArray) result.get("MshpZidInfo");
//			
//			// 상품정보 없을경우 기존 db 상품은 판매불가처리
//			if( !((boolean) result.get("rtn")))
//				productService.updateInvalidProduct(row.toString());
//			
//			for (int i=0; i<MshpZidInfo.size(); i++){
//				
//				JSONObject pd = (JSONObject) MshpZidInfo.get(i);				
//				
//				// 대카테고리
//				String McodeB = decode(pd.get("McodeB").toString());
//				
//				// 중카테고리
//				String McodeC = decode(pd.get("McodeC").toString());
//				
//				// 소카테고리
//				String McodeD = decode(pd.get("McodeD").toString());
//				
//				// 판매여부 : 1 판매, 2 품절
//				String Msales = decode(pd.get("Msales").toString());
//								
//				// 상품코드
//				String Mcode = decode(pd.get("Mcode").toString());			
//				
//				// 상품명
//				String Mname = decode(pd.get("Mname").toString());				
//				
//				// 바코드
//				String McodeBar = decode(pd.get("McodeBar").toString());				
//				
//				// 판매가 : modeoffice.com의 웹 판매가
//				String MpriceCustomerB2C = decode(pd.get("MpriceRetails").toString());
//				//String MpriceCustomerB2C = decode(pd.get("MpriceCustomerB2C").toString());
//				
//				// 구매가 : 모든에서 귀사의 구매가  <<<<<<<<<<<
//				String MpricePurchase = decode(pd.get("MpriceCustomer").toString());
//				//String MpricePurchase = decode(pd.get("MpricePurchase").toString());
//				
//				// 브랜드
//				String McodeBrand = decode(pd.get("McodeBrand").toString());
//								
//				// 판매단위 : EA / 박스
//				//String MsaleUnit = decode(pd.get("MsaleUnit").toString());
//				String MsaleUnit = "";
//				
//				// 상품스펙 : 상품상세
//				String MspecLong = decode(pd.get("MspecLong").toString());				
//				
//				// 원산지
//				String MspecOrigin = decode(pd.get("MspecOrigin").toString());
//				
//				// 상품 이미지 500x500
//				String Mimg500 = decode(pd.get("Mimg500").toString());
//				
//				
//				// 파라미터 설정 //////////////////////////////////////////////////////
//				
//				Map<String, String> map = new HashMap<>();				
//				map.put("McodeB", McodeB);				// 대카테고리
//				map.put("McodeC", McodeC);				// 중카테고리
//				map.put("McodeD", McodeD);				// 소카테고리
//				map.put("Msales", Msales.equals("1") ? "SALE_CON_01" : "SALE_CON_02");				// 판매여부 : 1 판매, 2 품절
//				map.put("Mcode", Mcode);				// 상품코드
//				map.put("Mname", Mname);				// 상품명
//				map.put("McodeBar", McodeBar);			// 바코드
//				
//				// 판매가 : modeoffice.com의 웹 판매가
//				if ( ( Double.valueOf(MpricePurchase) * 1.15 ) > Double.valueOf(MpriceCustomerB2C) )	// 구매가*1.15 > 웹판매가  = 웹판매가  	
//					map.put("MpriceCustomerB2C", MpriceCustomerB2C);					
//				else
//					map.put("MpriceCustomerB2C", Integer.toString( (int)(Double.valueOf(MpricePurchase) * 1.15) ) );	// 판매가 :  구매가 * 1.15 (기본적인 판매가)
//				
//				map.put("MpricePurchase", MpricePurchase);			// 구매가 : 모든에서 귀사의 구매가  <<<<<<<<<<<
//				map.put("McodeBrand", McodeBrand);		// 브랜드
//				map.put("MsaleUnit", MsaleUnit);		// 판매단위 : EA / 박스
//				map.put("MspecLong", MspecLong);		// 상품스펙 : 상품상세
//				map.put("MspecOrigin", MspecOrigin);	// 원산지
//				map.put("Mimg500", Mimg500);			// 상품 이미지 500x500
//				
//				map.put("SUPR_ID", "C00006");			// 공급사 : 모든오피스
//				
//				productService.insertCoatflxm_ModenOffice(map);		// 이미지  insert
//				productService.insertCoatflxd_ModenOffice(map);		// 이미지  insert
//				productService.insertPdinfo_ModenOffice(map);			// 상품 insert
//				
//				
//				
//				
//			}			
			
	   }
		
	}
	
	
	// 카테고리 동기화
	public void setProductCago(ProductService productService) throws Exception{
		
		//상품동기화 (스케줄러)
		
		JSONObject result;
		
		// 조회
//		result = execModenOfficeQuery_read("getCago");
//		
//		// 상품정보
//		JSONArray MshpBCD = (JSONArray) result.get("MshpBCD");
//		
//		for (int i=0; i<MshpBCD.size(); i++){
//			
//			JSONObject pd = (JSONObject) MshpBCD.get(i);
//			
//			// 대카테고리
//			String McodeB = decode(pd.get("McodeB").toString());
//			String MnameB = decode(pd.get("MnameB").toString());
//			
//			// 중카테고리
//			String McodeC = decode(pd.get("McodeC").toString());
//			String MnameC = decode(pd.get("MnameC").toString());			
//			
//			// 소카테고리
//			String McodeD = decode(pd.get("McodeD").toString());
//			String MnameD = decode(pd.get("MnameD").toString());
//			
//			Map<String, String> map = new HashMap<>();
//			
//			map.put("rootCode", "000001");
//			map.put("McodeB", McodeB);
//			map.put("MnameB", MnameB);
//			map.put("McodeC", McodeC);
//			map.put("MnameC", MnameC);
//			map.put("McodeD", McodeD);
//			map.put("MnameD", MnameD);
//			map.put("SORT_ORDR", ""+i);
//			
//			
//			
//			// 카테고리 대 INSERT
//			productService.setModenOfficeCagoB(map);
//			// 카테고리 중 INSERT
//			productService.setModenOfficeCagoC(map);			
//			// 카테고리 소 INSERT
//			productService.setModenOfficeCagoD(map);
//			
//		}
//		
//		
//		System.out.println(result.toString());
		
	}
	
	
	// 단종 상품 제거
	public void deleteDiscontinuedProduct(ProductService productService) throws Exception{
		
		//단종 상품 제거 (스케줄러)
		
		JSONObject result;
		
		// 조회 - 최근 일주일 내 단종상품 조회
//		result = execModenOfficeQuery_read("getDiscontinuedProduct");
//		
//		// 상품정보
//		JSONArray MshpZidPE = (JSONArray) result.get("MshpZidPE");
//		
//		for (int i=0; i<MshpZidPE.size(); i++){
//			
//			JSONObject pd = (JSONObject) MshpZidPE.get(i);
//			
//			// 상품코드
//			String McodeB = decode(pd.get("Mcode").toString());
//			
//			// 단종처리
//			productService.setModenOfficeDiscontinuedPd(McodeB);
//			
//		}			
		
	}
	
	// 일시 품절 상품 처리
	public void setProductCurDate(ProductService productService) throws Exception{
			
		//단종 상품 제거 (스케줄러)
		
		JSONObject result;
		
		// 조회 - 일시 품절 상품 조회
//		result = execModenOfficeQuery_read("getSoldoutProduct");
//		
//		// 상품정보
//		JSONArray MshpZidOS = (JSONArray) result.get("MshpZidOS");
//		
//		for (int i=0; i<MshpZidOS.size(); i++){
//			
//			JSONObject pd = (JSONObject) MshpZidOS.get(i);
//			
//			// 상품코드
//			String McodeB = decode(pd.get("Mcode").toString());
//			
//			// 단종처리
//			productService.setModenOfficeSoldoutPd(McodeB);			
//		}					
	}
	
	// 일주일 주기 변경 단종 상품 동기화
	public void setSoldoutProduct(ProductService productService) throws Exception{
			
		//단종 상품 제거 (스케줄러)
		
		JSONObject result;
		
		// 조회 - 일시 품절 상품 조회
//		result = execModenOfficeQuery_read("getSoldoutProduct");
//		
//		// 상품정보
//		JSONArray MshpZidOS = (JSONArray) result.get("MshpZidOS");
//		
//		for (int i=0; i<MshpZidOS.size(); i++){
//			
//			JSONObject pd = (JSONObject) MshpZidOS.get(i);
//			
//			// 상품코드
//			String McodeB = decode(pd.get("Mcode").toString());
//			
//			// 단종처리
//			productService.setModenOfficeSoldoutPd(McodeB);			
//		}					
	}
	
	// 기간별 변경 상품 동기화
	public void setChangedProduct(ProductService productService) throws Exception{
		
		//단종 상품 제거 (스케줄러)
		
		JSONObject result;

		// 조회할 날짜 설정
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		
		Map<String, String> param = new HashMap<String, String>();		
		param.put("date", sdf.format(d));
		
		// 조회 - 일시 품절 상품 조회
//		result = execModenOfficeQuery_read("getChangedProduct", param);
//		
//		// 상품정보
//		JSONArray MshpZidInfo = (JSONArray) result.get("MshpZidInfo");
//		
//		for (int i=0; i<MshpZidInfo.size(); i++){
//			
//			JSONObject pd = (JSONObject) MshpZidInfo.get(i);
//			
//			// 대카테고리
//			String McodeB = decode(pd.get("McodeB").toString());
//			
//			// 중카테고리
//			String McodeC = decode(pd.get("McodeC").toString());
//			
//			// 소카테고리
//			String McodeD = decode(pd.get("McodeD").toString());
//			
//			// 판매여부 : 1 판매, 2 품절
//			String Msales = decode(pd.get("Msales").toString());
//							
//			// 상품코드
//			String Mcode = decode(pd.get("Mcode").toString());			
//			
//			// 상품명
//			String Mname = decode(pd.get("Mname").toString());				
//			
//			// 바코드
//			String McodeBar = decode(pd.get("McodeBar").toString());				
//			
//			// 판매가 : modeoffice.com의 웹 판매가
//			String MpriceCustomerB2C = decode(pd.get("MpriceRetails").toString());
//			//String MpriceCustomerB2C = decode(pd.get("MpriceCustomerB2C").toString());
//			
//			// 구매가 : 모든에서 귀사의 구매가  <<<<<<<<<<<
//			String MpricePurchase = decode(pd.get("MpriceCustomer").toString());
//			//String MpricePurchase = decode(pd.get("MpricePurchase").toString());
//			
//			// 브랜드
//			String McodeBrand = decode(pd.get("McodeBrand").toString());
//							
//			// 판매단위 : EA / 박스
//			//String MsaleUnit = decode(pd.get("MsaleUnit").toString());
//			String MsaleUnit = "";
//			
//			// 상품스펙 : 상품상세
//			String MspecLong = decode(pd.get("MspecLong").toString());				
//			
//			// 원산지
//			String MspecOrigin = decode(pd.get("MspecOrigin").toString());
//			
//			// 상품 이미지 500x500
//			String Mimg500 = decode(pd.get("Mimg500").toString());
//			
//			
//			// 파라미터 설정 //////////////////////////////////////////////////////
//			
//			Map<String, String> map = new HashMap<>();				
//			map.put("McodeB", McodeB);				// 대카테고리
//			map.put("McodeC", McodeC);				// 중카테고리
//			map.put("McodeD", McodeD);				// 소카테고리
//			map.put("Msales", Msales.equals("1") ? "SALE_CON_01" : "SALE_CON_02");				// 판매여부 : 1 판매, 2 품절
//			map.put("Mcode", Mcode);				// 상품코드
//			map.put("Mname", Mname);				// 상품명
//			map.put("McodeBar", McodeBar);			// 바코드
//			
//			// 판매가 : modeoffice.com의 웹 판매가
//			if ( ( Double.valueOf(MpricePurchase) * 1.15 ) > Double.valueOf(MpriceCustomerB2C) )	// 구매가*1.15 > 웹판매가  = 웹판매가  	
//				map.put("MpriceCustomerB2C", MpriceCustomerB2C);					
//			else
//				map.put("MpriceCustomerB2C", Integer.toString( (int)(Double.valueOf(MpricePurchase) * 1.15) ) );	// 판매가 :  구매가 * 1.15 (기본적인 판매가)
//			
//			map.put("MpricePurchase", MpricePurchase);			// 구매가 : 모든에서 귀사의 구매가  <<<<<<<<<<<
//			map.put("McodeBrand", McodeBrand);		// 브랜드
//			map.put("MsaleUnit", MsaleUnit);		// 판매단위 : EA / 박스
//			map.put("MspecLong", MspecLong);		// 상품스펙 : 상품상세
//			map.put("MspecOrigin", MspecOrigin);	// 원산지
//			map.put("Mimg500", Mimg500);			// 상품 이미지 500x500
//			
//			map.put("SUPR_ID", "C00006");			// 공급사 : 모든오피스
//			
//			
//			// 상품 업데이트
//			productService.setModenOfficeChangedPd(map);			
//		}					
	}
	
	
	// 모든오피스 상품주문 
	@SuppressWarnings("unchecked")
	public void Order_ModenOffice(OrderService orderService, String orderNum) throws Exception{
			
		// 모든오피스 상품주문 (스케줄러)
		
		// 모든오피스 상품정보
		List<TB_ODINFOXD> pdList = (List<TB_ODINFOXD>) orderService.getOdinfo_modenoffice(orderNum);
		
		// 모든오피스 상품이 없을 경우 : 종료
		if(pdList == null || pdList.size() == 0)
			return;
		
		// 배송지 정보
		TB_ODDLAIXM dlvyInfo = (TB_ODDLAIXM) orderService.getDlvyInfo_ownerclan(orderNum);
		
		
		//받는사람
		JSONObject order = new JSONObject();
		
		order.put("MnumberSuju", "F" + orderNum);							// 주문번호 - F로 시작해야함
		order.put("MmemoPacking", encode(dlvyInfo.getDLVY_MSG()));			// 포장메모
		order.put("MdeliveryName", encode(dlvyInfo.getRECV_PERS()));		// 배송정보 - 이름
		order.put("MdeliveryZipcode", encode(dlvyInfo.getPOST_NUM()));		// 배송정보 - 우편번호
		order.put("MdeliveryAddress1", encode(dlvyInfo.getBASC_ADDR()));	// 배송정보 - 주소1 
		order.put("MdeliveryAddress2", encode(dlvyInfo.getDTL_ADDR()));		// 배송정보 - 주소2
		order.put("MdeliveryTel", dlvyInfo.getRECV_TELN());					// 전화번호
		order.put("MdeliveryHp", dlvyInfo.getRECV_CPON());					// 핸드폰번호
		order.put("MdeliveryMemo", encode(dlvyInfo.getDLVY_MSG() == null ? "" :  dlvyInfo.getDLVY_MSG()) );			// 배송기사 전달 메모

		// 상품정보 입력
		JSONArray Morders = new JSONArray();
		
		for (int i=0; i<pdList.size(); i++){
			JSONObject pd = new JSONObject();
			pd.put("Mcode", pdList.get(i).getPD_CODE());					// 상품코드
			pd.put("Mamount", Integer.parseInt(pdList.get(i).getORDER_QTY()));				// 주문수량
			
//			Morders.add(pd);
		}
		
		order.put("Morders", Morders);										// 상품정보입력
		
		
		
		System.out.println("order>>" + order.toString());
		
		// post전송, 포장메모 테스트 주문 명기, URI인코딩
		
		// API POST 호출 : 결과값 리턴
//		LinkAPI apiResult = readQuery("modenoffice", "insertOrder");
//		JSONObject outResult = JsonReader.sendJsonPost_ModenOffice(apiResult.getENDPOINT(), order.toString());
//				
//		System.out.println("orderOut>>" + outResult.toString());		
//		
//		
//		org.json.simple.parser.JSONParser jparser = new org.json.simple.parser.JSONParser();	  
//		JSONObject jobj = (JSONObject) jparser.parse(new StringReader(outResult.toString()));
//		
//		
//		
//		
//		// 주문성공
//		if ((jobj.get("rtn").toString()).equals("true")){
//			
//			TB_ODINFOXD xd = new TB_ODINFOXD();			
//			xd.setLINK_ORDER_KEY("F" + orderNum);
//			xd.setORDER_NUM(orderNum);
//			xd.setSUPR_ID("C00006");	//모든오피스
//			
//			orderService.updateOrderStatusModenoffice(xd);			
//		}
				
	}
	
	
	// 배송결과 조회 : 운송장번호
	public void setDlvyStatus(OrderService orderService) throws Exception{
			
		//배송결과 조회 (스케줄러)
		
		JSONObject result;
		
		// 배송결과 조회
//		result = execModenOfficeQuery_read("getDlvyStatus");
//		
//		// 배송정보 세팅
//		JSONArray MbsnDeliverys = (JSONArray) result.get("MbsnDeliverys");
//		
//		for (int i=0; i<MbsnDeliverys.size(); i++){
//			
//			JSONObject pd = (JSONObject) MbsnDeliverys.get(i);
//			
//			// 주문, 운송장 정보 세팅
//			String MnumberSuju = decode(pd.get("MnumberSuju").toString());	// 주문번호
//			String MnumberTrace = decode(pd.get("MnumberTrace").toString());	// 운송장번호
//			
//			Map<String, String> map = new HashMap<>();
//			map.put("MnumberSuju", MnumberSuju);
//			map.put("MnumberTrace", MnumberTrace);
//			map.put("DlvyCom", "모든오피스택배");
//		
//			// 배송결과 동기화
//			orderService.setModenOfficeDlvyStatus(map);			
//		}					
	}
	
	
	
	/////////////////////////////////////////////////////////////// 공 통 ////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////// 모 든 오 피 스//////////////////////////////////////////////////////////////////
	
	//오너클랜 쿼리 실행
//	public JSONObject execModenOfficeQuery_read(String queryId, Map<String, String> param) throws Exception{
//		
//		// 쿼리 세팅
//		LinkAPI apiResult = readQuery("modenoffice", queryId, param);
//		// API 호출 : 결과값 리턴
//		JSONObject outResult = JsonReader.sendJsonGet_ModenOffice(apiResult.getENDPOINT() + JsonReader.encodeURIComponent(apiResult.getQUERY()));
//				
//		return outResult;
//	}
//	//오너클랜 쿼리 실행 (파라미터없음)
//	public JSONObject execModenOfficeQuery_read(String queryId) throws Exception{
//				
//		// 쿼리 세팅
//		LinkAPI apiResult = readQuery("modenoffice", queryId);
//		// API 호출 : 결과값 리턴
//		JSONObject outResult = JsonReader.sendJsonGet_ModenOffice(apiResult.getENDPOINT() + JsonReader.encodeURIComponent(apiResult.getQUERY()));
//		
//		return outResult;
//	}
	
	
	// 오너클랜 쿼리 실행 POST 방식 	
	/*@SuppressWarnings("unchecked")
	public JSONObject execOwnerclanQuery_readPost(String queryId, Map<String, String> param) throws Exception{
		
		// 쿼리 세팅
		LinkAPI apiResult = readQuery("ownerclan", queryId, param);
		
		
		JSONObject variables = new JSONObject();
		JSONObject input = new JSONObject();
		
		//보내는사람
		JSONObject sender = new JSONObject();
		sender.put("name", "보내는사람");
		sender.put("phoneNumber", "010-2936-4429");
		sender.put("email", "leejs00319@gmail.com");
		
		input.put("sender", sender);
		
		//받는사람
		JSONObject recipient = new JSONObject();
		recipient.put("name", "받는이");
		recipient.put("phoneNumber", "010-2936-4429");
		
		JSONObject destinationAddress = new JSONObject();
		destinationAddress.put("addr1", "서울 금천구 가산디지털1로 128");
		destinationAddress.put("addr2", "808호");
		destinationAddress.put("postalCode", "08507");
		
		recipient.put("destinationAddress", destinationAddress);
		
		input.put("recipient", recipient);
		
		
		// 상품
		JSONArray products = new JSONArray();
		
		JSONObject item1 = new JSONObject();		
		item1.put("quantity", 4);
		item1.put("itemKey", "W630A6C");
		
		JSONArray optionAttributes1 = new JSONArray();
		optionAttributes1.add("Q");
		optionAttributes1.add("블루");
		item1.put("optionAttributes", optionAttributes1);
		
		products.add(item1);
		
		input.put("products", products);
		
		
		//원장주문코드
		input.put("note", "1123123");
		
		//주문관리코드
		input.put("sellerNote", "1123123");
		
		//배송시 요청사항
		input.put("ordererNote", "test");
		
		//통관고유번호
		input.put("customsClearanceCode", "1123123");

		variables.put("input", input);	// 파라미터 설정
		
		
		// send data
		JSONObject jout = new JSONObject();
		
		jout.put("operationName", "SimulateCreateOrder");
		jout.put("query", apiResult.getQUERY());
		jout.put("variables", variables);
		
		System.out.println(jout.toString());
		
		// API POST 호출 : 결과값 리턴
		JSONObject outResult = JsonReader.sendJsonPost_Ownerclan(apiResult.getENDPOINT(), jout.toString());
		
		return outResult;
	}*/
	
	
	//////////////////////////////////////////////////////////////////// 공 통 ////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////// 일 반 ////////////////////////////////////////////////////////////////////
	
	/*
	 * @parameter
	 * graphql
	 * ownerclan
	 * query id
	 * 
	 * return 
	 * 토큰
	 * 쿼리
	 * 
	 * @ 토큰처리
	 */
	
	// 쿼리 파라미터 replace 기능 
//	public LinkAPI replaceQuery(LinkAPI apiResult, Map<String, String> replaceMap) throws Exception{
//		
//		// map에 들어있는 값을 쿼리에 세팅함
//		if(apiResult.getQUERY() != null && replaceMap.size() != 0)
//			for( String key : replaceMap.keySet() )
//				apiResult.setQUERY(apiResult.getQUERY().replace("${" + key + "}", replaceMap.get(key)));
//		
//		return apiResult;		
//	}
//	
//	// read query 파라미터가 있는경우
//	public LinkAPI readQuery(String apiName, String queryName, Map<String, String> replaceMap) throws Exception{
//		return replaceQuery(readQuery(apiName, queryName), replaceMap);
//	}
//	
//	// read query 파라미터가 없는경우
//	public LinkAPI readQuery(String apiName, String queryName) throws Exception{
//		
//		LinkAPI result = new LinkAPI();
//		
//		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
//		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
//		
//		
//		//생성된 빌더를 통해서 xml문서를 Document객체로 파싱해서 가져온다	    
//		
//		//Document doc = dBuilder.parse("http://localhost/resources/LinkAPI/ModenOffice.xml");
//		Document doc = dBuilder.parse("http://www.laonmarket.co.kr/resources/LinkAPI/ModenOffice.xml");
//		
//		// root 구하기
//		Element root = doc.getDocumentElement();		
//		
//		NodeList childeren = root.getChildNodes(); // 자식 노드 목록 get
//		
//		for(int i = 0; i < childeren.getLength(); i++){
//			Node node = childeren.item(i);
//			
//			if(node.getNodeType() == Node.ELEMENT_NODE){ // 해당 노드의 종류 판정(Element일 때)
//				Element ele = (Element)node;
//				String nodeName = ele.getNodeName();
//				
//				//오너클랜
//				if(nodeName.equals(apiName)){					
//					
//					//Ownerclan의 경우 자식노드가 존재
//					NodeList childeren2 = ele.getChildNodes();					
//					for(int j = 0; j < childeren2.getLength(); j++){
//						Node node2 = childeren2.item(j);
//						if(node2.getNodeType() == Node.ELEMENT_NODE){
//							Element ele2 = (Element)node2;
//							String nodeName2 = ele2.getNodeName();
//							
//							if(nodeName2.equals("query"))
//							{	
//								if(ele2.getAttribute("id").equals(queryName)){
//									
//									result.setQUERY(ele2.getTextContent()/*.replaceAll("\\s", "")*/);
//									result.setENDPOINT(ele2.getAttribute("endpoint"));
//								}
//							}
//						}
//					}
//				}
//				
//			}			
//		}		
//		
//		return result;
//	}
	
	// 널처리
	public static String NVL(Object text){
		if(text == null)
			return "";
		else
			return text.toString();
	}
	
	//URL DECODER
	public String decode(String str) throws Exception{
		return java.net.URLDecoder.decode(str, "UTF-8");
	}
	
	//URL ENCODER
	public String encode(String str) throws Exception{
		if(str==null)
			return "";
		
		return java.net.URLEncoder.encode(str, "UTF-8");
	}

}
