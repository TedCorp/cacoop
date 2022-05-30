package mall.web.apiLink;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;

import javax.xml.parsers.DocumentBuilderFactory;

import mall.web.apiLink.JsonReader;
import mall.web.controller.DefaultController;
import mall.web.domain.LinkAPI;
import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDOPTION;
import mall.web.service.mall.OrderService;
import mall.web.service.mall.ProductService;

/*import org.json.JSONException;
import org.json.JSONObject;*/
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonObjectFormatVisitor;
import com.mysql.cj.x.json.JsonArray;

import java.util.List;

public class OwnerclanAPI{
	
	@Value("#{servletContext.contextPath}")
	public String servletContextPath;
	
	
	// 오너클랜 최초 상품 동기화 : 텍스트기반
	public void setProduct(ProductService productService) throws Exception{
		
		//상품동기화 (스케줄러)
		
		InputStream is = getClass().getClassLoader().getResourceAsStream("/category_ownerclan_byrank.txt");
		Reader reader = new InputStreamReader(is, "UTF-8");
		BufferedReader bf = new BufferedReader(reader);
		String row;
		
		int itemp = 0;

		// modenoffice_product 정보 불러옴
		while ((row = bf.readLine()) != null) {
	
			System.out.println("진행 >> " + (++itemp) );
			
			String[] category_pdcode = row.split(":");
			
			
			//중카테고리명 : [0] 대카테고리, [1] 중카테고리
			String[] cagoName = ((String)category_pdcode[0]).split(">");
			
			// 카테고리 code - 중카테고리 넣음
			String schCagoId = productService.getCagoid(cagoName[1]);  
			
			// 상품코드
			String[] pdcode =  ((String)category_pdcode[1]).replaceAll("\"", "").replaceAll("\\[", "").replaceAll("\\]", "").replaceAll(" ", "").split(",");
			
			
			// 실제 상품조회 
			for (int i=0; i<pdcode.length; i++){
				
				/*
				// 상품연동 중 오류 발생시 사용
				if(itemp < 101)
					continue;
				*/
				
				//17
				//현재 진행
				System.out.println(itemp + "/126" +cagoName[1] + " > " + cagoName[1] +  " : " + pdcode[i]);
				
				
				try{
				Map<String, String> param = new HashMap<String, String>();		
				param.put("key", pdcode[i]);
				
				JSONObject result = execOwnerclanQuery_read("getItem", param);
				
				boolean bNotsave = false;
								
				// 조회				
				//상품정보
				JSONObject jobj = (JSONObject) ((JSONObject)result.get("data")).get("item");
				
				//상품속성				
				String attributes = jobj.get("attributes").toString();
				// 해외배송 상품일경우 등록안함
				if(attributes.contains("ATTR_OVERSEA") || attributes.contains("ATTR_OVERSEA_DIRECT"))
					continue;
				
				
				
				// 상품정보 객체
				TB_PDINFOXM pd = new TB_PDINFOXM();
				
				pd.setPD_CODE(jobj.get("key").toString());		// 상품코드
				pd.setPD_BARCD(jobj.get("key").toString());		// 상품바코드
				pd.setSUPR_ID("C00004");						// 공급사코드
				pd.setPD_NAME(jobj.get("name").toString());		// 상품명
				pd.setCAGO_ID(schCagoId);														// 카테고리
				
				// 소비자준수가격 상품일경우 - 20200615 제거
				/*if(jobj.get("pricePolicy").toString() == "fixed")
					pd.setPD_PRICE(jobj.get("fixedPrice").toString());	// 가격
				else{
					// 자율가격 상품 : 입고가 * 1.13 = 출고가 
					double price = Integer.parseInt(jobj.get("price").toString()) * 1.13;					
					pd.setPD_PRICE( Long.toString(Math.round(price)) );	// 가격		
				}*/				
				// 가격 : 입고가의 1.13
				double price = Integer.parseInt(jobj.get("price").toString()) * 1.13;					
				pd.setPD_PRICE( Long.toString(Math.round(price)) );	// 가격	
				
				// 제조사 : MAKE_COM
				pd.setMAKE_COM(jobj.get("production").toString());
				// 원산지 : ORG_CT
				pd.setORG_CT(jobj.get("origin").toString());
				// 모델 -> 규격 : PD_STD
				pd.setPD_STD(jobj.get("model").toString());
				// 최대 묶음 배송 -> 입수량 : INPUT_CNT
				pd.setINPUT_CNT(jobj.get("boxQuantity").toString());
				
				
				pd.setPDDC_GUBN("PDDC_GUBN_01");				// 할인구분 : 할인암함
				pd.setPDDC_VAL("0");							// 제품할인값
								
				// 판매중이 아니면 품절상태로 설정
				if(!(jobj.get("status").toString().equals("available")))
					pd.setSALE_CON("SALE_CON_02");
				else
					pd.setSALE_CON("SALE_CON_01");					// 판매상태 : 판매가능
				
				pd.setPD_DINFO(jobj.get("content").toString());	// 상품상세정보				
				pd.setATFL_ID(jobj.get("key").toString());								// 파일아이디 코드
				pd.setRPIMG_SEQ("1");;							// 대표이미지순번
				
				pd.setREGP_ID("SystemScheduler");				// 등록자
				pd.setMODP_ID("SystemScheduler");				// 수정자
				
				if(jobj.get("taxFree").toString() == "false")		// 면세과세구분
					pd.setTAX_GUBN("TAX_GUBN_01");					// 과세
				else
					pd.setTAX_GUBN("TAX_GUBN_02");					// 면세
				
				// 기존 상품옵션 삭제 
				// 한번 돌린 뒤 아래로 내리도록하자
				productService.deletePdOption(jobj.get("key").toString());
				
				//상품옵션추가
				JSONArray optionArr =  (JSONArray) jobj.get("options");
				if(optionArr != null && optionArr.size() != 0){
					
					// 중복 데이터 검사용
					List<TB_PDOPTION> opList = new ArrayList<TB_PDOPTION>();
					
					//options 부분
					for(int cnt=0; cnt<optionArr.size(); cnt++){
						
						JSONObject opJObj = (JSONObject) optionArr.get(cnt);
						JSONArray attArr = (JSONArray) opJObj.get("optionAttributes");
						
						//optionAttributes 옵션정보가 비었을경우
						if(attArr.size() == 0)
							continue;
						
						// optionAttributes 부분
						for(int cnt2=0; cnt2<attArr.size(); cnt2++){
							
							if(cnt2 == 2){
								System.out.println("error 옵션 3개이상있음" + jobj.get("key").toString());
								bNotsave = true;
								return;
							}
							
							TB_PDOPTION op = new TB_PDOPTION();
							
							// 상위데이터 값 입력
							if(cnt2 == 0){
								// 첫번째 배열일경우 최상위 레벨로 본다
								op.setUP_NAME("");
								op.setUP_VALUE("");
							}								
							else{
								// 첫번째 배열 값이 아닐경우 이전배열을 상위 레벨로 본다 
								op.setUP_NAME(((JSONObject)attArr.get(cnt2-1)).get("name").toString());
								op.setUP_VALUE(((JSONObject)attArr.get(cnt2-1)).get("value").toString());
							}
							
							op.setPD_CODE(jobj.get("key").toString());
							op.setOPTION_VALUE( ((JSONObject)attArr.get(cnt2)).get("value").toString() );
							op.setOPTION_NAME( ((JSONObject)attArr.get(cnt2)).get("name").toString() );
							op.setSORT_ORDER(Integer.toString(cnt2));
							
							// 마지막 레벨의 데이터일경우 수량, 가격을 입력한다  
							if(cnt2 == attArr.size()-1){
								op.setQUANTITY(opJObj.get("quantity").toString());
								
								
								// 소비자준수가격 상품일경우
								if(jobj.get("pricePolicy").toString() == "fixed")
									op.setPRICE(opJObj.get("price").toString());
								else{
									// 자율가격 상품 : 입고가 * 1.13 = 출고가 
									double oprice = Integer.parseInt(opJObj.get("price").toString()) * 1.13;
									op.setPRICE(Long.toString(Math.round(oprice) ));
								}
								
																
							}
							
							// 중복데이터 검사용
							Boolean dupOption = false;
							
							for(int listCnt=0; listCnt<opList.size(); listCnt++){
								TB_PDOPTION top = opList.get(listCnt);
								
								// 중복되는 데이터 확인
								if(top.getOPTION_NAME().equals(op.getOPTION_NAME()) && top.getOPTION_VALUE().equals(op.getOPTION_VALUE())
										&& top.getUP_NAME().equals(op.getUP_NAME()) && top.getUP_VALUE().equals(op.getUP_VALUE())){
									dupOption=true;	// 중복
									break;
								}	
							}
							if(!dupOption){	// 중복데이터가 아니면 db insert
								opList.add(op);
								productService.insertPdOption(op);	// 상품옵션 추가
							}
							
						}
					}										
				}
				
				pd.setDEL_YN("N");									// 삭제여부				
				pd.setPD_INTERFACE_YN("N");							// 상품연동여부				
				pd.setPD_IWHUPRC(jobj.get("price").toString());				// 입고단가   
				pd.setPRICE_POLICY(jobj.get("pricePolicy").toString());		// 가격정책 free 가격자율, fixed 소비자준수가격
				pd.setLINK_MODP_DATE(jobj.get("updatedAt").toString());		// 연동 API 수정 날짜

				// 상품옵션 오류일 경우 상품등록안함
				if(bNotsave)
					continue;
				
				// 상품추가, 변경사항 없을경우 이미지 테이블, 상품 옵션 입력은 건너뜀
				if(productService.mergeProduct(pd) == 0)
					continue;				
				
				
				// 이미지 추가 				
				if(jobj.get("images") != null){
					
					TB_COATFLXD img = new TB_COATFLXD();
					img.setATFL_ID(jobj.get("key").toString());			// 첨부파일id
					img.setREGP_ID("SystemScheduler");
					img.setMODP_ID("SystemScheduler");
					
					JSONArray imgArr = (JSONArray) jobj.get("images");
					
					productService.mergeImgMst(img);
					
					for(int j=0; j<imgArr.size(); j++){
						
						img.setATFL_SEQ(Integer.toString(j+1));
						img.setSTFL_PATH(imgArr.get(j).toString());
						img.setSTFL_NAME(imgArr.get(j).toString());
						img.setORFL_NAME(imgArr.get(j).toString());
						img.setFILE_EXT("img");
						img.setFILE_SIZE("1");
						img.setDEL_YN("N");
						img.setFILEPATH_FLAG("ownerclan");
						
						productService.mergeImgDtl(img);						
					}				
				}	
				
					
				
				}catch(Exception e){System.out.println("==== Exception ===");}
			}
			
			
		}		
		
	}
		
	// 카테고리 기반 100개상품 동기화 (구버전)
	public void ProductLinkage_Ownerclan(ProductService productService) throws Exception{
		
		//상품동기화 (스케줄러)
				
		// 오너클랜 > 중카테고리 목록 조회
		List<HashMap<String, String>> ocCagoList = (List<HashMap<String, String>>) productService.getOwnclanCagoList();
		
		// 오너클랜 > 중카테고리 기준으로 100개씩 조회함
		for(int ListCnt=0; ListCnt<ocCagoList.size(); ListCnt++){
			
			// 동가화 카테고리
			String schCagoId = (((Map<String, String>)(ocCagoList.get(ListCnt))).get("CAGO_ID")).toString();
			
			Map<String, String> param = new HashMap<String, String>();		
			param.put("category", schCagoId);
			param.put("first", "100");			
						
			// 상품 목록 조회
			JSONObject result = execOwnerclanQuery_read("getItemList", param);
			
			//상품정보
			JSONArray pdArray = (JSONArray) ((JSONObject)((JSONObject)(result.get("data"))).get("allItems")).get("edges");
			
			// 100개 상품 중 포함되지 않는 상품 -> 일시중단 처리
			Map<String, Object> schMap = new HashMap<String, Object>();
			List list = new ArrayList();
			String schString = "'0'";
			for (int a=0; a<pdArray.size(); a++){
				JSONObject jobj = (JSONObject) ((JSONObject) ((JSONObject) pdArray.get(a))).get("node");
				
				list.add(jobj.get("key").toString());
				
				//schString += ",'" + jobj.get("key").toString() + "'";
			}
			schMap.put("CAGO_ID", schCagoId);
			schMap.put("List", list);
			// 일시중단 처리
			productService.updateDisSale(schMap);
			
				
				
			// 상품추가
			for(int i=0; i<pdArray.size(); i++){
				JSONObject jobj = (JSONObject) ((JSONObject) ((JSONObject) pdArray.get(i))).get("node");
				
				// 상품정보 객체
				TB_PDINFOXM pd = new TB_PDINFOXM();
				
				pd.setPD_CODE(jobj.get("key").toString());		// 상품코드
				pd.setPD_BARCD(jobj.get("key").toString());		// 상품바코드
				pd.setSUPR_ID("C00004");						// 공급사코드
				pd.setPD_NAME(jobj.get("name").toString());		// 상품명
				pd.setCAGO_ID(schCagoId);														// 카테고리
				
				// 소비자준수가격 상품일경우
				if(jobj.get("pricePolicy").toString() == "fixed")
					pd.setPD_PRICE(jobj.get("fixedPrice").toString());	// 가격
				else{
					// 자율가격 상품 : 입고가 * 1.13 = 출고가 
					double price = Integer.parseInt(jobj.get("price").toString()) * 1.13;					
					pd.setPD_PRICE( Long.toString(Math.round(price)) );	// 가격		
				}
				
				pd.setPDDC_GUBN("PDDC_GUBN_01");				// 할인구분 : 할인암함
				pd.setPDDC_VAL("0");							// 제품할인값
				pd.setSALE_CON("SALE_CON_01");					// 판매상태 : 판매가능
				pd.setPD_DINFO(jobj.get("content").toString());	// 상품상세정보				
				pd.setATFL_ID(jobj.get("key").toString());								// 파일아이디 코드
				pd.setRPIMG_SEQ("1");;							// 대표이미지순번
				
				pd.setREGP_ID("SystemScheduler");				// 등록자
				pd.setMODP_ID("SystemScheduler");				// 수정자
				
				if(jobj.get("taxFree").toString() == "false")		// 면세과세구분
					pd.setTAX_GUBN("TAX_GUBN_01");					// 과세
				else
					pd.setTAX_GUBN("TAX_GUBN_02");					// 면세
				
				// 기존 상품옵션 삭제 
				// 한번 돌린 뒤 아래로 내리도록하자
				productService.deletePdOption(jobj.get("key").toString());
				
				//상품옵션추가
				JSONArray optionArr =  (JSONArray) jobj.get("options");
				if(optionArr != null && optionArr.size() != 0){
					
					// 중복 데이터 검사용
					List<TB_PDOPTION> opList = new ArrayList<TB_PDOPTION>();
					
					//options 부분
					for(int cnt=0; cnt<optionArr.size(); cnt++){
						
						JSONObject opJObj = (JSONObject) optionArr.get(cnt);
						JSONArray attArr = (JSONArray) opJObj.get("optionAttributes");
						
						//optionAttributes 옵션정보가 비었을경우
						if(attArr.size() == 0)
							continue;
						
						// optionAttributes 부분
						for(int cnt2=0; cnt2<attArr.size(); cnt2++){
							
							if(cnt2 == 2){
								System.out.println("error 옵션 3개이상있음" + jobj.get("key").toString());
								return;
							}
							
							TB_PDOPTION op = new TB_PDOPTION();
							
							// 상위데이터 값 입력
							if(cnt2 == 0){
								// 첫번째 배열일경우 최상위 레벨로 본다
								op.setUP_NAME("");
								op.setUP_VALUE("");
							}								
							else{
								// 첫번째 배열 값이 아닐경우 이전배열을 상위 레벨로 본다 
								op.setUP_NAME(((JSONObject)attArr.get(cnt2-1)).get("name").toString());
								op.setUP_VALUE(((JSONObject)attArr.get(cnt2-1)).get("value").toString());
							}
							
							op.setPD_CODE(jobj.get("key").toString());
							op.setOPTION_VALUE( ((JSONObject)attArr.get(cnt2)).get("value").toString() );
							op.setOPTION_NAME( ((JSONObject)attArr.get(cnt2)).get("name").toString() );
							op.setSORT_ORDER(Integer.toString(cnt2));
							
							// 마지막 레벨의 데이터일경우 수량, 가격을 입력한다  
							if(cnt2 == attArr.size()-1){
								op.setQUANTITY(opJObj.get("quantity").toString());
								
								
								// 소비자준수가격 상품일경우
								if(jobj.get("pricePolicy").toString() == "fixed")
									op.setPRICE(opJObj.get("price").toString());
								else{
									// 자율가격 상품 : 입고가 * 1.13 = 출고가 
									double oprice = Integer.parseInt(opJObj.get("price").toString()) * 1.13;
									op.setPRICE(Long.toString(Math.round(oprice) ));
								}
								
																
							}
							
							// 중복데이터 검사용
							Boolean dupOption = false;
							
							for(int listCnt=0; listCnt<opList.size(); listCnt++){
								TB_PDOPTION top = opList.get(listCnt);
								
								// 중복되는 데이터 확인
								if(top.getOPTION_NAME().equals(op.getOPTION_NAME()) && top.getOPTION_VALUE().equals(op.getOPTION_VALUE())
										&& top.getUP_NAME().equals(op.getUP_NAME()) && top.getUP_VALUE().equals(op.getUP_VALUE())){
									dupOption=true;	// 중복
									break;
								}	
							}
							if(!dupOption){	// 중복데이터가 아니면 db insert
								opList.add(op);
								productService.insertPdOption(op);	// 상품옵션 추가
							}
							
						}
					}										
				}
				
				pd.setDEL_YN("N");									// 삭제여부				
				pd.setPD_INTERFACE_YN("N");							// 상품연동여부				
				pd.setPD_IWHUPRC(jobj.get("price").toString());				// 입고단가   
				pd.setPRICE_POLICY(jobj.get("pricePolicy").toString());		// 가격정책 free 가격자율, fixed 소비자준수가격
				pd.setLINK_MODP_DATE(jobj.get("updatedAt").toString());		// 연동 API 수정 날짜
							
				// 상품추가, 변경사항 없을경우 이미지 테이블, 상품 옵션 입력은 건너뜀
				if(productService.mergeProduct(pd) == 0)
					continue;				
				
				
				// 이미지 추가 				
				if(jobj.get("images") != null){
					
					TB_COATFLXD img = new TB_COATFLXD();
					img.setATFL_ID(jobj.get("key").toString());			// 첨부파일id
					img.setREGP_ID("SystemScheduler");
					img.setMODP_ID("SystemScheduler");
					
					JSONArray imgArr = (JSONArray) jobj.get("images");
					
					productService.mergeImgMst(img);
					
					for(int j=0; j<imgArr.size(); j++){
						
						img.setATFL_SEQ(Integer.toString(j+1));
						img.setSTFL_PATH(imgArr.get(j).toString());
						img.setSTFL_NAME(imgArr.get(j).toString());
						img.setORFL_NAME(imgArr.get(j).toString());
						img.setFILE_EXT("img");
						img.setFILE_SIZE("1");
						img.setDEL_YN("N");
						img.setFILEPATH_FLAG("ownerclan");
						
						productService.mergeImgDtl(img);						
					}				
				}					
			}
		}		
		System.out.println("오너클랜(ownerclan) 상품 동기화 완료");
	}
	
	
	// 상품주문
	@SuppressWarnings("unchecked")
	public void Order_Ownerclan(OrderService orderService, String orderNum) throws Exception{
		
		
		// 오너클랜 상품정보
		List<TB_ODINFOXD> pdList = (List<TB_ODINFOXD>) orderService.getOdinfo_ownerclan(orderNum);
		
		// 오너클랜 상품이 없을 경우 : 종료
		if(pdList == null || pdList.size() == 0)
			return;
		
		// 배송지 정보
		TB_ODDLAIXM dlvyInfo = (TB_ODDLAIXM) orderService.getDlvyInfo_ownerclan(orderNum);		
		
		
		/* * * * * * 주문 정보 세팅 * * * * * */
		JSONObject variables = new JSONObject();
		JSONObject input = new JSONObject();
		
		// 보내는사람 
		// 미입력시 오너클랜 사이트 가입정보가 입력됨
		JSONObject sender = new JSONObject();
		sender.put("name", "");											// 보내는 사람 : 이름
		sender.put("phoneNumber", "");									// 보내는 사람 : 전화번호
		sender.put("email", "");										// 보내는 사람 : 메일
		
		input.put("sender", sender);
		
		//받는사람
		JSONObject recipient = new JSONObject();
		recipient.put("name", dlvyInfo.getRECV_PERS());					// 받는사람 : 이름			
		
		String number = dlvyInfo.getRECV_CPON();						
		if(number == null || number ==""){
			number = dlvyInfo.getRECV_TELN();
			if(number == null || number =="")
				number="";
		}
		recipient.put("phoneNumber", number);							// 받는사람 : 전화번호
		
		JSONObject destinationAddress = new JSONObject();
		destinationAddress.put("addr1", dlvyInfo.getBASC_ADDR());		// 받는사람 : 기본주소
		destinationAddress.put("addr2", dlvyInfo.getDTL_ADDR());		// 받는사람 : 상세주소
		destinationAddress.put("postalCode", dlvyInfo.getPOST_NUM());	// 받는사람 : 우편번호
		
		recipient.put("destinationAddress", destinationAddress);
		
		input.put("recipient", recipient);
		
		// 상품정보
		JSONArray products = new JSONArray();
		// 상품추가
		for(int i = 0; i<pdList.size(); i++){
			
			JSONObject item = new JSONObject();		
			item.put("quantity", Integer.parseInt(pdList.get(i).getORDER_QTY()));			// 주문수량
			item.put("itemKey", pdList.get(i).getPD_CODE());								// 상품코드
			
			//옵션
			JSONArray optionAttributes = new JSONArray();
			
			if(pdList.get(i).getOPTION1_VALUE() != null && !pdList.get(i).getOPTION1_VALUE().equals(""))		// 옵션1
				optionAttributes.add(pdList.get(i).getOPTION1_VALUE());
			
			if(pdList.get(i).getOPTION2_VALUE() != null && !pdList.get(i).getOPTION2_VALUE().equals(""))		// 옵션2
				optionAttributes.add(pdList.get(i).getOPTION2_VALUE());
			
			item.put("optionAttributes", optionAttributes);
			
			products.add(item);
		}
		
		input.put("products", products);		
		
		//원장주문코드
		input.put("note", orderNum);
		
		//주문관리코드
		input.put("sellerNote", orderNum);
		
		//배송시 요청사항
		input.put("ordererNote", dlvyInfo.getDLVY_MSG() == null ? "" : dlvyInfo.getDLVY_MSG() );
		
		//통관고유번호 : 해외상품 취급안하므로 주석처리
		/*
		 * JSONObject customsClearanceCode = new JSONObject();
		 * customsClearanceCode.put("type", ""); // 개인고유통관번호를 쓸 경우 PersonalNumber, 생년월일을
		 * 쓸 경우 BirthDate를 명시. customsClearanceCode.put("value", ""); // 개인고유통관번호(P로
		 * 시작하고 12자리 숫자가 이어지는 13자리의 문자열) 또는 생년월일(YYYYMMDD 포맷) 입력 가능
		 * input.put("customsClearanceCode", customsClearanceCode);
		 */

		variables.put("input", input);	// 파라미터 설정
				
		// 주문 시뮬레이터
		// 결과 : {"data":{"simulateCreateOrder":[{"itemAmounts":[{"amount":110880,"itemKey":"W630A6C"}],"shippingAmount":6000,"extraShippingFeeExists":false}]}}

		JSONObject simulationResult = OrderProduct_Ownerclan("SimulateCreateOrder", variables);
				
		// 실제 주문서 생성
		variables.put("simulationResult", ((JSONObject)(simulationResult.get("data"))).get("simulateCreateOrder") );
		
		JSONObject orderResult = OrderProduct_Ownerclan("CreateOrder", variables);
		
		
		// 주문 실패처리 여기
		
		
		// 오너클랜 주문정보 입력 : 오너클랜 주문관리 코드, 주문 업데이트 시간
		JSONArray orderArr = (JSONArray) ((JSONObject)orderResult.get("data")).get("createOrder");
		
		for(int i=0; i<orderArr.size(); i++){
			JSONObject order = (JSONObject) orderArr.get(i);
			
			String LINK_ORDER_KEY = order.get("key").toString();				// 오너클랜 주문키
			String LINK_MODP_DATE = order.get("updatedAt").toString();			// 주문 수정일자
			String ORDER_NUM = order.get("note").toString();					// 주문번호
			
			
			JSONArray productsArr = (JSONArray) order.get("products");		// 상품리스트

			// 각 상품별 주문 정보 입력
			for(int j=0; j<productsArr.size(); j++){
				String PD_CODE = ((JSONObject)productsArr.get(j)).get("itemKey").toString();
				
				// 상품 정보 저장
				TB_ODINFOXD pdInfo = new TB_ODINFOXD();
				
				pdInfo.setORDER_NUM(ORDER_NUM);
				pdInfo.setPD_CODE(PD_CODE);
				pdInfo.setLINK_MODP_DATE(LINK_MODP_DATE);
				pdInfo.setLINK_ORDER_KEY(LINK_ORDER_KEY);
				
				// 오너클랜 상품 주문 정보 입력
				orderService.updateOwnerclanOrderInit(pdInfo);
				
				
				// 오너클랜 주문 정보 업데이트

			}
			
		}
		
		
		System.out.println(orderResult.toString());
	}
	
	//주문 취소 가능 여부 확인
	@SuppressWarnings("unchecked")
	public String chkCancelOrder_Ownerclan(OrderService orderService, String OrderNum) throws Exception{
		
		// 오너클랜 주문된 상품이 존재하는지 확인
		List<TB_ODINFOXD> list = (List<TB_ODINFOXD>) orderService.getOrderStatusOwerclan(OrderNum);
		
		// 오너클랜 상품이 없을경우
		if(list==null || list.size()==0){
			//orderService.cancelOrderOwerclan(OrderNum);
			return "success";
		}
		else {
			// 오너클랜 상품이 존재하지만 오너클랜에 실제 주문이 안들어갔을 경우 (오너클랜 주문코드가 생성이 안되었을 경우)
			int odcnt = orderService.chkOwnerclanOrderStatus(OrderNum);
			if (odcnt == 0)
				return "success";
		}
		
		try{
			// 해당 odinfoxm이 오너클랜 주문최소 가능한 상태인지 확인
			for(int i=0; i<list.size(); i++){
				Map<String, String> param = new HashMap<String, String>();		
				param.put("key", list.get(i).getLINK_ORDER_KEY());
				
				JSONObject orderResult = execOwnerclanQuery_read("orderInfo", param);	// 주문정보 조회
				
				JSONObject order = (JSONObject) ((JSONObject) orderResult.get("data")).get("order");
				
				// 주문정보가 없을경우 실패
				if(order==null)
					return "해당 오너클랜 주문정보가 존재하지 않습니다";
				
				String status = order.get("status").toString();	// 주문상태
				
				// 결제완료 상태가 아닌 주문이 있으면 주문취소 실패
				if(!status.equals("paid")){
					updateOrderOwnerclan(orderService);	// 오너클랜 주문상태 업데이트
					return "배송진행중인 오너클랜 상품이 존재합니다.";
				}
			}
		}
		catch(Exception e){return e.toString() + "\n오너클랜 API 오류(점검중)";}
		
		
		return "success";
	}
	
	//주문 취소 
	@SuppressWarnings("unchecked")
	public String cancelOrder_Ownerclan(OrderService orderService, String OrderNum) throws Exception{		
		
		// 주문정보 조회 status = paid상태인지 확인하기 위함
		List<TB_ODINFOXD> list = (List<TB_ODINFOXD>) orderService.getOrderStatusOwerclan(OrderNum);
		
		// 외부주문이 없을경우
		if(list==null || list.size()==0){
			//orderService.cancelOrderOwerclan(OrderNum);
			return "success";
		}
		
		try{
			// 해당 odinfoxm이 오너클랜 주문최소 가능한 상태인지 확인
			for(int i=0; i<list.size(); i++){
				Map<String, String> param = new HashMap<String, String>();		
				param.put("key", list.get(i).getLINK_ORDER_KEY());
				
				JSONObject orderResult = execOwnerclanQuery_read("orderInfo", param);	// 주문정보 조회
				
				JSONObject order = (JSONObject) ((JSONObject) orderResult.get("data")).get("order");
				
				// 주문정보가 없을경우 실패
				if(order==null)
					return "해당 오너클랜 주문정보가 존재하지 않습니다";
				
				String status = order.get("status").toString();	// 주문상태
				
				// 결제완료 상태가 아닌 주문이 있으면 주문취소 실패
				if(!status.equals("paid")){
					updateOrderOwnerclan(orderService);	// 오너클랜 주문상태 업데이트
					return "배송진행중인 오너클랜 상품이 존재합니다.";
				}
			}
		}
		catch(Exception e){return e.toString() + "\n오너클랜 API 오류(점검중)";}
		
		// 주문취소 기능
		try{
			for(int i=0; i<list.size(); i++){
				JSONObject result;		
				JSONObject inputVariables = new JSONObject();
				
				inputVariables.put("key", list.get(i).getLINK_ORDER_KEY());
				
				result = OrderProduct_Ownerclan("CancelOrder", inputVariables);
				
				if(result.get("data")!=null)
					System.out.println("취소성공");
				else{
					System.out.println("취소실패");
					updateOrderOwnerclan(orderService);	// 오너클랜 주문상태 업데이트
					return "취소 실패 : 부분취소 되었을수있음";
				}
				
				System.out.print("cancel result >>" + result.toString());
			}
		}catch(Exception e){return e.toString() + "\n오너클랜 API 오류(점검중) / 부분취소 되었을수있음";}
		
		//취소 성공
		return "success";
		
	}
	
	
	// 오너클랜 상품주문, 취소  모듈
	@SuppressWarnings("unchecked")
	public JSONObject OrderProduct_Ownerclan(String queryId, JSONObject variables) throws Exception{
		
		// 토큰 세팅
		String token = getToken("ownerclan", "iibs0017", "iibs0038");
		// 쿼리 세팅
		LinkAPI apiResult = readQuery("ownerclan", queryId);		
		
		// send data
		JSONObject jout = new JSONObject();
		
		jout.put("operationName", queryId);
		jout.put("query", apiResult.getQUERY());
		jout.put("variables", variables);
		
		System.out.println(jout.toString());
		 
		// 상품 주문 결과 조회		
		JSONObject outResult = JsonReader.sendJsonPost_Ownerclan(apiResult.getENDPOINT(), token, jout.toString());
		
		return outResult;
	}
	
	
	//단일상품조회
	public void realTest3() throws Exception{
		
		//상품동기화 (스케줄러)
		
		Map<String, String> param = new HashMap<String, String>();		
		param.put("key", "W64C2AC");
		
		JSONObject result;
		
		// 조회
		result = execOwnerclanQuery_read("getItem", param);
		
		//상품정보
		JSONArray pdArray = (JSONArray) ((JSONObject)((JSONObject)(result.get("data"))).get("allItems")).get("edges");
		JSONObject pageInfo = (JSONObject) ((JSONObject)((JSONObject)(result.get("data"))).get("allItems")).get("pageInfo");
		
		// 출력용
		for(int i=0; i<1/*jarr.size()*/; i++){
			JSONObject jobj = (JSONObject) pdArray.get(i);
			
			//tb_pdinfoxm 리스트 만들어서 담자
			
			System.out.println(jobj.toString());
			
		}
	}
	
	
	//아이템 리스트 겟
	public void realTest4() throws Exception{
		
		//상품동기화 (스케줄러)
		
		Map<String, String> param = new HashMap<String, String>();		
		param.put("key", "W64C2AC");
		
		JSONObject result;
		
		// 조회
		result = execOwnerclanQuery_read("getItemList2", param);
		
		System.out.println("ttest>>" + result.toString());
		
		//상품정보
		JSONArray pdArray = (JSONArray) ((JSONObject)((JSONObject)(result.get("data"))).get("allItems")).get("edges");
		JSONObject pageInfo = (JSONObject) ((JSONObject)((JSONObject)(result.get("data"))).get("allItems")).get("pageInfo");
		
		// 출력용
		for(int i=0; i<1/*jarr.size()*/; i++){
			JSONObject jobj = (JSONObject) pdArray.get(i);
			
			//tb_pdinfoxm 리스트 만들어서 담자
			
			System.out.println("ttest>" + jobj.toString());
			
		}
	}
	
	//W68A6CA, W68A6CB, W68A6CC
	
	// 오너클랜 주문상태 업데이트 
	public void updateOrderOwnerclan(OrderService orderService) throws Exception{
		

		@SuppressWarnings("unchecked")
		List<TB_ODINFOXD> list = (List<TB_ODINFOXD>) orderService.getOrderProgressListOwerclan();
		
		// 주문상태 : 결제완료, 배송준비중, 배송중, 상품수령 << 오너클랜 주문정보 가지고옴
		for(int i=0; i<list.size(); i++){
			Map<String, String> param = new HashMap<String, String>();		
			param.put("key", list.get(i).getLINK_ORDER_KEY());
			
			JSONObject result = execOwnerclanQuery_read("orderInfo", param);	// 주문정보 조회
			
			JSONObject order = (JSONObject) ((JSONObject) result.get("data")).get("order");
			
			// 주문정보가 없을경우 스킵
			if(order==null)
				continue;
			
			JSONArray products = (JSONArray) order.get("products");
			
			String LINK_ORDER_KEY = list.get(i).getLINK_ORDER_KEY();
			String LINK_MODP_DATE = order.get("updatedAt").toString();
			
			// 오너클랜 주문 업데이트 일자 > 라온마켓의 주문 정보가 최신인지 확인.
			//if(LINK_MODP_DATE.equals(list.get(i).getLINK_MODP_DATE()) )
			//	continue;
			
			String status = order.get("status").toString();	// 주문상태
			
			// 주문상태 변환
			/*
			 > status 
				placed : 미처리 상태입니다.
				paid : 입금완료 상태입니다.
				preparing : 발송 준비 상태입니다.
				cancelRequested : 취소 요청 상태입니다.
				cancelled : 주문 취소 상태입니다.
				shipped : 발송 완료 상태입니다.
				exchangeRequested : 교환 요청 상태입니다.
				exchanged : 교환 완료 상태입니다.
				refundRequested : 반품 요청 상태입니다.
				refundAccepted : 반품 접수 상태입니다.
				refundShipped : 반송 물품 발송 완료 상태입니다.
				refunded : 반품 완료 상태입니다.
				refundClosed : 반품 완료 후 PG 정산 완료 상태입니다.
			 */
			switch (status) {
				case "placed":	// 미처리
					status = "ORDER_CON_01"; //결제전
					break;
				case "paid":	// 입금완료
					status = "ORDER_CON_02"; //결제완료
					break;
				case "preparing":	// 발송 준비 상태
					status = "ORDER_CON_03"; //배송준비중
					break;
				case "cancelRequested":	// 취소 요청
					status = "ORDER_CON_04"; //주문취소
					break;
				case "cancelled":	// 주문 취소 상태
					status = "ORDER_CON_04"; //주문취소
					break;
				case "shipped":	// 발송 완료
					status = "ORDER_CON_05"; //배송중
					break;

				default:
					status = "ORDER_CON_09"; // API 에러				
					break;
			}
			
			// 상품별 정보 세팅
			for(int j=0; j<products.size(); j++){
				
				String trackingNumber =  NVL( ((JSONObject)products.get(j)).get("trackingNumber") );	// 운송장번호
				String shippingCompanyName = NVL( ((JSONObject)products.get(j)).get("shippingCompanyName") );	// 택배사 이름
				String itemKey = ((JSONObject)products.get(j)).get("itemKey").toString();	// 상품키
				
				JSONArray option = (JSONArray) ((JSONObject)((JSONObject)products.get(j)).get("itemOptionInfo")).get("optionAttributes");
				
				String OPTION1_NAME = "";
				String OPTION1_VALUE = "";
				String OPTION2_NAME = "";
				String OPTION2_VALUE = "";

				// 상품 옵션 정보 설정 (option1, 2 가 반대로 될수도있음)
				for(int k=0; k<option.size(); k++){
					if(k==0){
						OPTION1_NAME = ((JSONObject)option.get(k)).get("name").toString();
						OPTION1_VALUE = ((JSONObject)option.get(k)).get("value").toString();
					}
					else if(k==1){
						OPTION2_NAME = ((JSONObject)option.get(k)).get("name").toString();
						OPTION2_VALUE = ((JSONObject)option.get(k)).get("value").toString();
					}
				}
				
				TB_ODINFOXD xd = new TB_ODINFOXD();				
				
				xd.setPD_CODE(itemKey);					// 상품코드
				xd.setDLVY_COM(shippingCompanyName);	// 배송업체명
				xd.setDLVY_TDN(trackingNumber);			// 운송장번호
				xd.setOPTION1_NAME(OPTION1_NAME);		// 옵션1명
				xd.setOPTION1_VALUE(OPTION1_VALUE);		// 옵션1값
				xd.setOPTION2_NAME(OPTION2_NAME);		// 옵션2명
				xd.setOPTION2_VALUE(OPTION2_VALUE);		// 옵션2값
				xd.setORDER_CON(status);				// 배송상태
				xd.setLINK_MODP_DATE(LINK_MODP_DATE);	// 오너클랜 업데이트시간
				xd.setLINK_ORDER_KEY(LINK_ORDER_KEY);	// 오너클랜 주문번호
				
				// 오너클랜 주문상태 업데이트
				orderService.updateOrderStatusOwnerclan(xd);
			}
			
			System.out.println(result.toString());
		}
		
	}
	
	// 오너클랜 변경 상품정보 업데이트
	@SuppressWarnings("unchecked")
	public void updateProduct(ProductService productService) throws Exception{
		
		//상품동기화 (스케줄러)
		
		Map<String, String> param = new HashMap<String, String>();		
		param.put("first", "1000");
		param.put("after", "0");
		
		// 현재시간
		Date currentDate = new Date();
		
		// 과거시간 : 현재시간 -1일 00시00분00초 
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		Date preDate = cal.getTime();
		preDate = formatter.parse(formatter.format(preDate));
		
		param.put("dateFrom", String.valueOf( preDate.getTime() ) );
		param.put("dateTo", String.valueOf( currentDate.getTime() ) );
		
		//System.out.println(currentDate.getTime());
		//System.out.println(preDate.getTime());
		
		
		String hasNextPage = "false";
		int tot = 1;
		
		List<String> pdList = getPdlist();	// 동기화 상품리스트
		List<String> upList = new ArrayList<>();	// 업데이트할 상품리스트
		
		// 변경된 상품 리스트 조회
		do{
			JSONObject result;
			
			// 조회
			result = execOwnerclanQuery_read("updateProduct", param);
			
			System.out.println("ttest>>" + result.toString());
			
			//상품정보
			JSONArray pdArray = (JSONArray) ((JSONObject)((JSONObject)(result.get("data"))).get("itemHistories")).get("edges");
			
			//페이지 정보
			JSONObject pageInfo = (JSONObject) ((JSONObject)((JSONObject)(result.get("data"))).get("itemHistories")).get("pageInfo");
			
			// 조회할 데이터가 남았을 경우. 조회 조건 다시 세팅 
			hasNextPage = pageInfo.get("hasNextPage").toString();
			param.put("after", pageInfo.get("endCursor").toString());
			
			// hashset에 데이터를 담아서 중복된 상품코드 제거
			HashSet<String> hashSet = new HashSet<>();		
			
			// 출력용
			for(int i=0; i<pdArray.size(); i++){
				JSONObject jobj = (JSONObject)((JSONObject) pdArray.get(i)).get("node");
				hashSet.add(jobj.get("itemKey").toString());
			}
			
			// 변경이력이 있는 상품의 코드
			List<String> list = new ArrayList<String>(hashSet);
			
			// 변경이력이 있는 상품 중 동기화한 상품이 있을 경우 upList에 저장한다 
			for(int j=0; j<list.size(); j++){
				if( pdList.contains(list.get(j)) )
					upList.add(list.get(j));
			}
			
			System.out.println("현재" + tot++);
			
			//정성
		}while(hasNextPage.equals("true"));		
		
		if(upList.size() == 0){
			System.out.println("변경된 상품이 없음.");
			return;
		}
		
		System.out.println("변경상품 : " + upList.size() );
		
		// 상품 정보 조회 및 동기화		
		for(int k=0; k<upList.size(); k++){
			try{
				Map<String, String> param2 = new HashMap<String, String>();		
				param2.put("key", upList.get(k));
				
				JSONObject result = execOwnerclanQuery_read("getItem", param2);
				
				boolean bNotsave = false;
								
				// 조회				
				//상품정보
				JSONObject jobj = (JSONObject) ((JSONObject)result.get("data")).get("item");
				
				//상품속성				
				String attributes = jobj.get("attributes").toString();
				// 해외배송 상품일경우 등록안함
				if(attributes.contains("ATTR_OVERSEA") || attributes.contains("ATTR_OVERSEA_DIRECT"))
					continue;
				
				// 판매중이 아니면 제외
				if(!(jobj.get("status").toString().equals("available"))){
					
					// 품절처리
					productService.updateSALE_CON_OUT(jobj.get("key").toString());
					continue;
					
				}
				
				// 상품정보 객체
				TB_PDINFOXM pd = new TB_PDINFOXM();
				
				pd.setPD_CODE(jobj.get("key").toString());		// 상품코드
				pd.setPD_BARCD(jobj.get("key").toString());		// 상품바코드
				pd.setSUPR_ID("C00004");						// 공급사코드
				pd.setPD_NAME(jobj.get("name").toString());		// 상품명
				//pd.setCAGO_ID(schCagoId);														// 카테고리
				
				// 소비자준수가격 상품일경우 - 20200615 제거
				/*if(jobj.get("pricePolicy").toString() == "fixed")
					pd.setPD_PRICE(jobj.get("fixedPrice").toString());	// 가격
				else{
					// 자율가격 상품 : 입고가 * 1.13 = 출고가 
					double price = Integer.parseInt(jobj.get("price").toString()) * 1.13;					
					pd.setPD_PRICE( Long.toString(Math.round(price)) );	// 가격		
				}*/				
				// 가격 : 입고가의 1.13
				
				double price = Integer.parseInt(jobj.get("price").toString()) * 1.13;					
				pd.setPD_PRICE( Long.toString(Math.round(price)) );	// 가격	
				
				// 제조사 : MAKE_COM
				pd.setMAKE_COM(jobj.get("production").toString());
				// 원산지 : ORG_CT
				pd.setORG_CT(jobj.get("origin").toString());
				// 모델 -> 규격 : PD_STD
				pd.setPD_STD(jobj.get("model").toString());
				// 최대 묶음 배송 -> 입수량 : INPUT_CNT
				pd.setINPUT_CNT(jobj.get("boxQuantity").toString());
				
				
				pd.setPDDC_GUBN("PDDC_GUBN_01");				// 할인구분 : 할인암함
				pd.setPDDC_VAL("0");							// 제품할인값
				pd.setSALE_CON("SALE_CON_01");					// 판매상태 : 판매가능
				pd.setPD_DINFO(jobj.get("content").toString());	// 상품상세정보				
				pd.setATFL_ID(jobj.get("key").toString());								// 파일아이디 코드
				pd.setRPIMG_SEQ("1");;							// 대표이미지순번
				
				pd.setREGP_ID("SystemScheduler");				// 등록자
				pd.setMODP_ID("SystemScheduler");				// 수정자
				
				if(jobj.get("taxFree").toString() == "false")		// 면세과세구분
					pd.setTAX_GUBN("TAX_GUBN_01");					// 과세
				else
					pd.setTAX_GUBN("TAX_GUBN_02");					// 면세
				
				// 기존 상품옵션 삭제 
				// 한번 돌린 뒤 아래로 내리도록하자
				productService.deletePdOption(jobj.get("key").toString());
				
				//상품옵션추가
				JSONArray optionArr =  (JSONArray) jobj.get("options");
				if(optionArr != null && optionArr.size() != 0){
					
					// 중복 데이터 검사용
					List<TB_PDOPTION> opList = new ArrayList<TB_PDOPTION>();
					
					//options 부분
					for(int cnt=0; cnt<optionArr.size(); cnt++){
						
						JSONObject opJObj = (JSONObject) optionArr.get(cnt);
						JSONArray attArr = (JSONArray) opJObj.get("optionAttributes");
						
						//optionAttributes 옵션정보가 비었을경우
						if(attArr.size() == 0)
							continue;
						
						// optionAttributes 부분
						for(int cnt2=0; cnt2<attArr.size(); cnt2++){
							
							if(cnt2 == 2){
								System.out.println("error 옵션 3개이상있음" + jobj.get("key").toString());
								bNotsave = true;
								return;
							}
							
							TB_PDOPTION op = new TB_PDOPTION();
							
							// 상위데이터 값 입력
							if(cnt2 == 0){
								// 첫번째 배열일경우 최상위 레벨로 본다
								op.setUP_NAME("");
								op.setUP_VALUE("");
							}								
							else{
								// 첫번째 배열 값이 아닐경우 이전배열을 상위 레벨로 본다 
								op.setUP_NAME(((JSONObject)attArr.get(cnt2-1)).get("name").toString());
								op.setUP_VALUE(((JSONObject)attArr.get(cnt2-1)).get("value").toString());
							}
							
							op.setPD_CODE(jobj.get("key").toString());
							op.setOPTION_VALUE( ((JSONObject)attArr.get(cnt2)).get("value").toString() );
							op.setOPTION_NAME( ((JSONObject)attArr.get(cnt2)).get("name").toString() );
							op.setSORT_ORDER(Integer.toString(cnt2));
							
							// 마지막 레벨의 데이터일경우 수량, 가격을 입력한다  
							if(cnt2 == attArr.size()-1){
								op.setQUANTITY(opJObj.get("quantity").toString());
								
								
								// 소비자준수가격 상품일경우
								if(jobj.get("pricePolicy").toString() == "fixed")
									op.setPRICE(opJObj.get("price").toString());
								else{
									// 자율가격 상품 : 입고가 * 1.13 = 출고가 
									double oprice = Integer.parseInt(opJObj.get("price").toString()) * 1.13;
									op.setPRICE(Long.toString(Math.round(oprice) ));
								}
								
																
							}
							
							// 중복데이터 검사용
							Boolean dupOption = false;
							
							for(int listCnt=0; listCnt<opList.size(); listCnt++){
								TB_PDOPTION top = opList.get(listCnt);
								
								// 중복되는 데이터 확인
								if(top.getOPTION_NAME().equals(op.getOPTION_NAME()) && top.getOPTION_VALUE().equals(op.getOPTION_VALUE())
										&& top.getUP_NAME().equals(op.getUP_NAME()) && top.getUP_VALUE().equals(op.getUP_VALUE())){
									dupOption=true;	// 중복
									break;
								}	
							}
							if(!dupOption){	// 중복데이터가 아니면 db insert
								opList.add(op);
								productService.insertPdOption(op);	// 상품옵션 추가
							}
							
						}
					}										
				}
				
				pd.setDEL_YN("N");									// 삭제여부				
				pd.setPD_INTERFACE_YN("N");							// 상품연동여부				
				pd.setPD_IWHUPRC(jobj.get("price").toString());				// 입고단가   
				pd.setPRICE_POLICY(jobj.get("pricePolicy").toString());		// 가격정책 free 가격자율, fixed 소비자준수가격
				pd.setLINK_MODP_DATE(jobj.get("updatedAt").toString());		// 연동 API 수정 날짜

				// 상품옵션 오류일 경우 상품등록안함
				if(bNotsave)
					continue;
				
				// 상품추가, 변경사항 없을경우 이미지 테이블, 상품 옵션 입력은 건너뜀
				if(productService.mergeProduct(pd) == 0)
					continue;				
				
				
				// 이미지 추가 				
				if(jobj.get("images") != null){
					
					TB_COATFLXD img = new TB_COATFLXD();
					img.setATFL_ID(jobj.get("key").toString());			// 첨부파일id
					img.setREGP_ID("SystemScheduler");
					img.setMODP_ID("SystemScheduler");
					
					JSONArray imgArr = (JSONArray) jobj.get("images");
					
					productService.mergeImgMst(img);
					
					for(int j=0; j<imgArr.size(); j++){
						
						img.setATFL_SEQ(Integer.toString(j+1));
						img.setSTFL_PATH(imgArr.get(j).toString());
						img.setSTFL_NAME(imgArr.get(j).toString());
						img.setORFL_NAME(imgArr.get(j).toString());
						img.setFILE_EXT("img");
						img.setFILE_SIZE("1");
						img.setDEL_YN("N");
						img.setFILEPATH_FLAG("ownerclan");
						
						productService.mergeImgDtl(img);						
					}				
				}	
			}catch(Exception e){System.out.println("==== Exception ===");}
			
		}
		
		
		
		
	}
	
	
	
	
	// 1000개이상 조회용
	public void realTest2() throws Exception{
		
		//상품동기화 (스케줄러)
		
		Map<String, String> param = new HashMap<String, String>();		
		param.put("category", "50000108");
		param.put("first", "50");
		param.put("after", "0");
		
		String hasNextPage = "false";
		int tot = 1;
		do{
			// response.data.allItems.pageInfo.hasNextPage TRUE면 더 검색 // do - while문
			// response.data.allItems.pageInfo.endCursor
			
			JSONObject result;
			
			// 조회
			result = execOwnerclanQuery_read("getItemList", param);
			
			//상품정보
			JSONArray pdArray = (JSONArray) ((JSONObject)((JSONObject)(result.get("data"))).get("allItems")).get("edges");
			JSONObject pageInfo = (JSONObject) ((JSONObject)((JSONObject)(result.get("data"))).get("allItems")).get("pageInfo");
			
			// 조회할 데이터가 남았을 경우. 조회 조건 다시 세팅 
			hasNextPage = pageInfo.get("hasNextPage").toString();
			param.put("after", pageInfo.get("endCursor").toString());
			
			System.out.println("hasNextPage > " + pageInfo.get("hasNextPage"));
			System.out.println("endCursor > " + pageInfo.get("endCursor"));			
			
			
			// 출력용
			for(int i=0; i<1/*jarr.size()*/; i++){
				JSONObject jobj = (JSONObject) pdArray.get(i);
				
				//tb_pdinfoxm 리스트 만들어서 담자
				
				System.out.println(jobj.toString());
				
			}
			
			System.out.println("현재 조회 루프 > " + tot + "\n약 > " + (tot*1000) );
			tot++;
			
		}while(false/*hasNextPage.equals("true")*/);
		
		
		
		/*System.out.println("result > " + result.toString());
		System.out.println("result_data > " + result.get("data").toString());*/
		
	}
	
	
	/////////////////////////////////////////////////////////////////// 공 통 ////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////// 오 너 클 랜 //////////////////////////////////////////////////////////////////
	
	//오너클랜 쿼리 실행
	public JSONObject execOwnerclanQuery_read(String queryId, Map<String, String> param) throws Exception{
		
		// 토큰 세팅
		String token = getToken("ownerclan", "iibs0017", "iibs0038");
		// 쿼리 세팅
		LinkAPI apiResult = readQuery("ownerclan", queryId, param);
		// API 호출 : 결과값 리턴
		JSONObject outResult = JsonReader.sendJsonGet_Ownerclan(apiResult.getENDPOINT() + JsonReader.encodeURIComponent(apiResult.getQUERY()), token);
		
		return outResult;
	}
	//오너클랜 쿼리 실행 (파라미터없음)
	public JSONObject execOwnerclanQuery_read(String queryId) throws Exception{
		
		// 토큰 세팅
		String token = getToken("ownerclan", "iibs0017", "iibs0038");
		// 쿼리 세팅
		LinkAPI apiResult = readQuery("ownerclan", queryId);
		// API 호출 : 결과값 리턴
		JSONObject outResult = JsonReader.sendJsonGet_Ownerclan(apiResult.getENDPOINT() + JsonReader.encodeURIComponent(apiResult.getQUERY()), token);
		
		return outResult;
	}
	// 오너클랜 쿼리 실행 POST 방식 	
	@SuppressWarnings("unchecked")
	public JSONObject execOwnerclanQuery_readPost(String queryId, Map<String, String> param) throws Exception{
		
		// 토큰 세팅
		String token = getToken("ownerclan", "iibs0017", "iibs0038");
		// 쿼리 세팅
		LinkAPI apiResult = readQuery("ownerclan", queryId, param);
		
		
		JSONObject variables = new JSONObject();
		JSONObject input = new JSONObject();
		
		//보내는사람
		JSONObject sender = new JSONObject();
		sender.put("name", "보내는사람");
		sender.put("phoneNumber", "010-1111-1111");
		sender.put("email", "aa@gmail.com");
		
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
		JSONObject outResult = JsonReader.sendJsonPost_Ownerclan(apiResult.getENDPOINT(), token, jout.toString());
		
		return outResult;
	}
	
	
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
	public LinkAPI replaceQuery(LinkAPI apiResult, Map<String, String> replaceMap) throws Exception{
		
		// map에 들어있는 값을 쿼리에 세팅함
		if(apiResult.getQUERY() != null && replaceMap.size() != 0)
			for( String key : replaceMap.keySet() )
				apiResult.setQUERY(apiResult.getQUERY().replace("${" + key + "}", replaceMap.get(key)));
		
		return apiResult;		
	}
	
	// read query 파라미터가 있는경우
	public LinkAPI readQuery(String apiName, String queryName, Map<String, String> replaceMap) throws Exception{
		return replaceQuery(readQuery(apiName, queryName), replaceMap);
	}
	
	// read query 파라미터가 없는경우
	public LinkAPI readQuery(String apiName, String queryName) throws Exception{
		
		LinkAPI result = new LinkAPI();
		
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		
		
		//생성된 빌더를 통해서 xml문서를 Document객체로 파싱해서 가져온다	    
		
		//Document doc = dBuilder.parse("http://localhost/resources/LinkAPI/Ownerclan.xml");
		Document doc = dBuilder.parse("http://www.laonmarket.co.kr/resources/LinkAPI/Ownerclan.xml");
		//Document doc = dBuilder.parse("./src/main/webapp/resources/LinkAPI/Ownerclan.xml");
		
		// root 구하기
		Element root = doc.getDocumentElement();		
		
		NodeList childeren = root.getChildNodes(); // 자식 노드 목록 get
		
		for(int i = 0; i < childeren.getLength(); i++){
			Node node = childeren.item(i);
			
			if(node.getNodeType() == Node.ELEMENT_NODE){ // 해당 노드의 종류 판정(Element일 때)
				Element ele = (Element)node;
				String nodeName = ele.getNodeName();
				
				//오너클랜
				if(nodeName.equals(apiName)){					
					
					//Ownerclan의 경우 자식노드가 존재
					NodeList childeren2 = ele.getChildNodes();					
					for(int j = 0; j < childeren2.getLength(); j++){
						Node node2 = childeren2.item(j);
						if(node2.getNodeType() == Node.ELEMENT_NODE){
							Element ele2 = (Element)node2;
							String nodeName2 = ele2.getNodeName();
							
							if(nodeName2.equals("query"))
							{	
								if(ele2.getAttribute("id").equals(queryName)){
									
									result.setQUERY(ele2.getTextContent()/*.replaceAll("\\s", "")*/);
									result.setENDPOINT(ele2.getAttribute("endpoint"));
								}
							}
						}
					}
				}
				
			}			
		}		
		
		return result;
	}
	
	
	// 토큰 조회
	@SuppressWarnings("unchecked")
	public String getToken(String apiName, String id, String pw) throws Exception{
	
		String token = "";
		String url = "";
		
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		
		//Document doc = dBuilder.parse("./src/main/webapp/resources/LinkAPI/Ownerclan.xml");
		Document doc = dBuilder.parse("http://www.laonmarket.co.kr/resources/LinkAPI/Ownerclan.xml");
		Element root = doc.getDocumentElement();
		
		NodeList childeren = root.getChildNodes(); // 자식 노드 목록 get
		// 인증 url 받기
		for(int i = 0; i < childeren.getLength(); i++){			
			Node node = childeren.item(i);
			
			if(node.getNodeType() == Node.ELEMENT_NODE){ // 해당 노드의 종류 판정(Element일 때)
				Element ele = (Element)node;
				String nodeName = ele.getNodeName();
				
				//오너클랜
				if(nodeName.equals(apiName)){
					NodeList childeren2 = ele.getChildNodes();					
					
					for(int j = 0; j<childeren2.getLength(); j++){
						Node node2 = childeren2.item(j);
						
						if(node2.getNodeName().equals("auth"))
							url=node2.getTextContent().trim();
					}
				}
			}
		}	
		if(url.equals(""))
			throw new Exception();
		
		
		JSONObject authData = new JSONObject();
		// 오너클랜 세팅
		if(apiName.equals("ownerclan")){
			authData.put("service", "ownerclan");
			authData.put("userType", "seller");
			authData.put("username", id);
			authData.put("password", pw);
			
			token = JsonReader.sendJsonPost(url, authData.toString());
		}
		
		System.out.println(token);		
		
		return token;
	}
	
	
	// 널처리
	public static String NVL(Object text){
		if(text == null)
			return "";
		else
			return text.toString();
	}
	
	public List<String> getPdlist() throws Exception {
		
		InputStream is = getClass().getClassLoader().getResourceAsStream("/category_ownerclan_byrank.txt");
		Reader reader = new InputStreamReader(is, "UTF-8");
		BufferedReader bf = new BufferedReader(reader);
		String row;
		
		int itemp = 0;
		
		List<String> list = new ArrayList<>(); 

		// modenoffice_product 정보 불러옴
		while ((row = bf.readLine()) != null) {
	
			System.out.println("진행 >> " + (++itemp) );
			
			String[] category_pdcode = row.split(":");
			
			
			//중카테고리명 : [0] 대카테고리, [1] 중카테고리
			//String[] cagoName = ((String)category_pdcode[0]).split(">");			
			
			// 상품코드
			String[] pdcode =  ((String)category_pdcode[1]).replaceAll("\"", "").replaceAll("\\[", "").replaceAll("\\]", "").replaceAll(" ", "").split(",");
			
			ArrayList<String> mNewList = new ArrayList<String>(Arrays.asList(pdcode));
			
			list.addAll(mNewList);

		}
		
		System.out.println(list.size());
		
		return list;
	}
	
	//// 지울거 백업 ////
	@RequestMapping(value={ "/setAllList"}, method=RequestMethod.GET)
	public ModelAndView linkAllList(Model model, HttpServletRequest request) throws Exception {
		
		String token = getToken("ownerclan", "iibs0017", "iibs0038");
		
		// query 치환조건
		Map<String, String> param = new HashMap<String, String>();		
		param.put("category", "50000108");
		param.put("first", "1000");
		param.put("after", "0");		
		LinkAPI apiResult = readQuery("ownerclan", "getItemList", param);
		
		// 필수값
		model.addAttribute("endpoint", apiResult.getENDPOINT());
		model.addAttribute("query", apiResult.getQUERY());
		model.addAttribute("token", token);
		model.addAttribute("exeUrl", "/api/ownerclan/saveAllList");
		//ajax 동기방식으로 심기
		
		return new ModelAndView("mall/test");
	}
	
	public void conAPI() throws Exception{
				
		Map<String, String> param = new HashMap<String, String>();		
		param.put("category", "50000108");
		param.put("first", "1000");
		param.put("after", "0");
		
		String token = getToken("ownerclan", "iibs0017", "iibs0038");
		LinkAPI apiResult = readQuery("ownerclan", "getItemList", param);
		
		/*System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println("token >> " + token);
		System.out.println("query >> " + apiResult.getQUERY());
		System.out.println("endpoint >> " + apiResult.getENDPOINT());
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");*/

		System.out.println("URL" + apiResult.getENDPOINT() + JsonReader.encodeURIComponent(apiResult.getQUERY()));
		
		System.out.println("@@ 결과 @@");
		
		/*JsonReader.getJson(apiResult.getENDPOINT() + "?query=" + apiResult.getQUERY());*/
		JSONObject outResult = JsonReader.sendJsonGet_Ownerclan(apiResult.getENDPOINT() + JsonReader.encodeURIComponent(apiResult.getQUERY()), token);
		
		System.out.println("outResult > " + outResult);
		System.out.println("@@@@@@@@");
	}
	///////////// 지울거 백업 //////////////

}
