package mall.web.apiLink;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.service.mall.OrderService;

public class AtomyAzaAPI {
	
	final String dev = "http://dev.atomyaza.co.kr/plugin/serviceapi/cjfls.php";
	final String service = "https://atomyaza.co.kr/plugin/serviceapi/cjfls.php";
	final String type = "AP-90004";
	final String platform = dev;
	
	/* {
		  "service_od_id": "20200907000001",
		  "service_type": "AP-90004",
		  "mb_id": "azatest",
		  "name": "홍길동",
		  "cellphone": "010-333-5555",
		  "dan": "2",
		  "od_info": [{
		                   "goods_code":"gs1111",
		                   "goods_name":"상품명1",
		                   "qty":"1",
		                   "goods_price": "20000",
		                   "baesong_price": "3000",
		                  "pay_price": "40000",
		                  "unit_price": "20000"
		                 },
		                 {
		                   "goods_code":"gs2222",
		                   "goods_name":"상품명2",
		                   "qty":"2",
		                   "goods_price": "40000",
		                   "baesong_price": "0",
		                   "pay_price": "40000",
		                   "unit_price": "20000"
		                 }],
		  "od_time": "2019-12-01 15:20:30",
		  "memo": ""
	 } */
	
	/**
	 * 애터미아자 주문 (결제완료)
	 * @param orderService
	 * @param orderNum
	 * @return
	 * @throws Exception
	 */
    @SuppressWarnings("unchecked")
	public void Order_AtomyAza(OrderService orderService, String orderNum) throws Exception{
		try{
			List<TB_ODINFOXD> pdList = (List<TB_ODINFOXD>) orderService.getOrderInfoAza(orderNum);

			JSONObject atomy = new JSONObject();
            JSONArray order = new JSONArray();
            
            // 수취인 정보
            atomy.put("service_od_id", orderNum);							    	// 업체주문번호
            atomy.put("service_type", type);										// 업체코드(AP-90001~AP-90099), 애터미아자에서 부여
            atomy.put("mb_id", pdList.get(0).getMEMB_ID());			                // 아자아이디
            atomy.put("dan", pdList.get(0).getORDER_CON());                  		// 주문상태(결제완료:2, 배송전취소:6, 환불완료:7)
            atomy.put("name", encode(pdList.get(0).getMEMB_NAME()));				// 고객명
            atomy.put("cellphone", pdList.get(0).getMEMB_CPON());          			// 고객 핸드폰번호
            
            // 상품정보
            for (int i=0; i< pdList.size(); i++){
                JSONObject pd = new JSONObject();
                
                // od_info
                pd.put("goods_code", pdList.get(i).getPD_CODE());					// 상품코드
                pd.put("goods_name", encode(pdList.get(i).getPD_NAME()));			// 상품명
                pd.put("qty", pdList.get(i).getORDER_QTY());                  		// 주문수량
                pd.put("goods_price", pdList.get(i).getORDER_AMT());                // 주문상품 수량*단가 가격
                pd.put("baesong_price", "0");				                		// 배송비
                pd.put("pay_price", pdList.get(i).getORDER_AMT());                  // 상품 실결제금액 (배송비포함)
                pd.put("unit_price", pdList.get(i).getREAL_PRICE());                // 상품단가
                
            	order.add(pd);
            }
            
            // 배송비 단일상품
            String baesong_price = pdList.get(0).getDLVY_AMT().length() < 1 ? "0" : pdList.get(0).getDLVY_AMT();
            
            if (!"0".equals(baesong_price)) {
            	JSONObject pd = new JSONObject();
                
                // od_info
                pd.put("goods_code", "000000");										// 상품코드 (가상코드)
                pd.put("goods_name", encode("배송비"));								// 상품명
                pd.put("qty", "1");                  								// 주문수량
                pd.put("goods_price", "0");                  						// 주문상품 수량*단가 가격
                pd.put("baesong_price", baesong_price);								// 배송비
                pd.put("pay_price", baesong_price);                    				// 상품 실결제금액 (배송비포함)
                pd.put("unit_price", "0");                  						// 상품단가
                
            	order.add(pd);
            }
            
            atomy.put("od_info", order);											// 전송하는 쪽 주문 상품정보
            atomy.put("od_time", pdList.get(0).getORDER_DTM());						// 주문일시
            atomy.put("memo", "");													// 메모

            // JSON Object 확인
            //System.out.println(atomy.toString());

            // API POST 호출
            String result = sendJSONPost_AtomyAza(platform, atomy.toString(), orderService);
            
		}catch(Exception e){
			e.printStackTrace();
			AtomyAzaAPI ato = new AtomyAzaAPI();
    		ato.insertLog(orderService, "ATOMY", "N", "Order_AtomyAza", "FAIL");
		}
    }
    
    /**
   	 * 애터미아자 환불 (부분반품)
   	 * @param orderService
   	 * @param orderNum
   	 * @param returnNum
   	 * @return
   	 * @throws Exception
   	 */
    public void Return_AtomyAza2(OrderService orderService, String orderNum, String returnNum) throws Exception{
		try{
			List<TB_ODINFOXD> pdList = (List<TB_ODINFOXD>) orderService.getOrderInfoAza(orderNum);			// 원 주문정보
			List<TB_ODINFOXD> rtnList = (List<TB_ODINFOXD>) orderService.getOrderInfoAza(returnNum);		// 반품 정보

			JSONObject atomy = new JSONObject();
            JSONArray order = new JSONArray();
            
            // 수취인 정보
            atomy.put("service_od_id", orderNum);							    	// 업체주문번호
            atomy.put("service_type", type);										// 업체코드(AP-90001~AP-90099), 애터미아자에서 부여
            atomy.put("mb_id", pdList.get(0).getMEMB_ID());			                // 아자아이디
            atomy.put("dan", "7");                  								// 주문상태(결제완료:2, 배송전취소:6, 환불완료:7)
            atomy.put("name", encode(pdList.get(0).getMEMB_NAME()));				// 고객명
            atomy.put("cellphone", pdList.get(0).getMEMB_CPON());          			// 고객 핸드폰번호
            
            // 상품정보
            for (int i=0; i< rtnList.size(); i++){
                JSONObject pd = new JSONObject();
                
                // od_info
                pd.put("goods_code", rtnList.get(i).getPD_CODE());					// 상품코드
                pd.put("goods_name", encode(rtnList.get(i).getPD_NAME()));			// 상품명
                pd.put("qty", rtnList.get(i).getORDER_QTY());                  		// 주문수량
                pd.put("goods_price", rtnList.get(i).getORDER_AMT());				// 주문상품 수량*단가 가격
                pd.put("baesong_price", "0");				                		// 배송비
                pd.put("pay_price", rtnList.get(i).getORDER_AMT());					// 상품 실결제금액 (배송비포함)
                pd.put("unit_price", rtnList.get(i).getREAL_PRICE());				// 상품단가
                
            	order.add(pd);
            }

            // 전체환불 여부 
         	boolean allReturn = false;
         	// 전체상품 반품이거나 기존 반품내역이 있으면 체크 
         	//if (pdList.size() == rtnList.size()){
         		allReturn = Compare_Return(orderService, orderNum, returnNum);
         	//}
            
            // 전체반품일때 배송비 차감
            if (allReturn){
            	// 배송비 단일상품
            	String baesong_price = pdList.get(0).getDLVY_AMT().length() < 1 ? "0" : pdList.get(0).getDLVY_AMT();
                
                if (!"0".equals(pdList.get(0).getDLVY_AMT())) {
                	JSONObject pd = new JSONObject();
                    
                    // od_info
                    pd.put("goods_code", "000000");									// 상품코드 (가상코드)
                    pd.put("goods_name", encode("배송비"));							// 상품명
                    pd.put("qty", "-1");                  							// 주문수량
                    pd.put("goods_price", "0");                  					// 주문상품 수량*단가 가격
                    pd.put("baesong_price", baesong_price);							// 배송비
                    pd.put("pay_price", baesong_price);                    			// 상품 실결제금액 (배송비포함)
                    pd.put("unit_price", "0");                  					// 상품단가
                    
                	order.add(pd);
                }
            }
            
            atomy.put("od_info", order);											// 전송하는 쪽 주문 상품정보
            atomy.put("od_time", pdList.get(0).getORDER_DTM());						// 주문일시
            atomy.put("memo", "");													// 메모

            // JSON Object 확인
            //System.out.println(atomy.toString());

            // API POST 호출
            String result = sendJSONPost_AtomyAza(platform, atomy.toString(), orderService);
            
		}catch(Exception e){
			e.printStackTrace();
			AtomyAzaAPI ato = new AtomyAzaAPI();
    		ato.insertLog(orderService, "ATOMY", "N", "Return_AtomyAza2", "FAIL");
		}
    }
    
    /**
	 * 전체환불여부 (원주문-반품주문 비교)
	 * @param org
	 * @param rtn
	 * @return
	 * @throws Exception
	 */
    private boolean Compare_Return(OrderService orderService, String orderNum, String returnNum) throws Exception{
    	// 비교
    	Map<String, String> map = new HashMap<String, String>();		
		map.put("orderNum", orderNum);
		map.put("returnNum", returnNum);
		
		int chkCnt = orderService.chkAllReturn(map);
		
		if(chkCnt == 0) return true;
    	
    	return false;
    }
    
    /**
	 * 애터미아자 주문취소 (전체취소)
	 * @param orderService
	 * @param orderNum
	 * @return
	 * @throws Exception
	 */
    @SuppressWarnings("unchecked")
	public void Cancel_AtomyAza(OrderService orderService, String orderNum) throws Exception{
		try{
			List<TB_ODINFOXD> pdList = (List<TB_ODINFOXD>) orderService.getOrderInfoAza(orderNum);
			
			JSONObject atomy = new JSONObject();
            JSONArray order = new JSONArray();
            
            // 수취인 정보
            atomy.put("service_od_id", orderNum);							    	// 업체주문번호
            atomy.put("service_type", type);										// 업체코드(AP-90001~AP-90099), 애터미아자에서 부여
            atomy.put("mb_id", pdList.get(0).getMEMB_ID());			                // 아자아이디
            atomy.put("dan", pdList.get(0).getORDER_CON());                  		// 주문상태(결제완료:2, 배송전취소:6, 환불완료:7)
            atomy.put("name", encode(pdList.get(0).getMEMB_NAME()));				// 고객명
            atomy.put("cellphone", pdList.get(0).getMEMB_CPON());          			// 고객 핸드폰번호
            
            // 상품정보
            for (int i=0; i< pdList.size(); i++){
                JSONObject pd = new JSONObject();
                
                int qty = Integer.parseInt(pdList.get(i).getORDER_QTY()) * -1;
                int total = Integer.parseInt(pdList.get(i).getORDER_AMT()) * -1;
                               
                // od_info
                pd.put("goods_code", pdList.get(i).getPD_CODE());					// 상품코드
                pd.put("goods_name", encode(pdList.get(i).getPD_NAME()));			// 상품명
                pd.put("qty", Integer.toString(qty));                  				// 주문수량 * -1
                pd.put("goods_price", Integer.toString(total));                		// 주문상품 수량 * 단가 가격 * -1
                pd.put("baesong_price", "0");                						// 배송비 * -1
                pd.put("pay_price", Integer.toString(total));            			// 상품 실결제금액 * -1
                pd.put("unit_price", pdList.get(i).getREAL_PRICE());                // 상품단가
                
            	order.add(pd);
            }

            // 배송비 단일상품
            int dlvy_amt = pdList.get(0).getDLVY_AMT().length() < 1 ? 0 : (Integer.parseInt(pdList.get(0).getDLVY_AMT()));
            String baesong_price = Integer.toString(dlvy_amt);
            
            if (!"0".equals(baesong_price)) {
            	JSONObject pd = new JSONObject();
                
                // od_info
                pd.put("goods_code", "000000");										// 상품코드 (가상코드)
                pd.put("goods_name", encode("배송비"));								// 상품명
                pd.put("qty", "-1");                  								// 주문수량
                pd.put("goods_price", "0");                  						// 주문상품 수량*단가 가격
                pd.put("baesong_price", baesong_price);								// 배송비
                pd.put("pay_price", baesong_price);                    				// 상품 실결제금액 (배송비포함)
                pd.put("unit_price", "0");                  						// 상품단가
                
            	order.add(pd);
            }
            
            atomy.put("od_info", order);											// 전송하는 쪽 주문 상품정보
            atomy.put("od_time", pdList.get(0).getORDER_DTM());						// 주문일시
            atomy.put("memo", "");													// 메모

            // JSON Object 확인
            //System.out.println(atomy.toString());

            // API POST 호출
            String result = sendJSONPost_AtomyAza(platform, atomy.toString(), orderService);
            
		}catch(Exception e){
			e.printStackTrace();
			AtomyAzaAPI ato = new AtomyAzaAPI();
    		ato.insertLog(orderService, "ATOMY", "N", "Cancel_AtomyAza", "FAIL");
		}
    }
    
    public String sendJSONPost_AtomyAza(String azaUrl, String jsonValue, OrderService ods){
        String inputLine = null;
        StringBuffer outResult = new StringBuffer();
        
        try {
            URL url = new URL(azaUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Accept-Charset", "UTF-8");
            conn.setDoOutput(true);				// POST 데이터를 OutputStream으로 넘겨 주겠다는 설정
            conn.setConnectTimeout(50000);	// 서버에 연결되는 Timeout 시간 설정
            conn.setReadTimeout(50000);		// InputStream 읽어 오는 Timeout 시간 설정

            OutputStream os = conn.getOutputStream();
            os.write(jsonValue.getBytes("UTF-8"));
            os.flush();

            //System.out.println(conn.getResponseCode());
            //System.out.println(conn.getResponseMessage());
            //System.out.println(conn.getErrorStream());              
            
            InputStreamReader is;
            if(conn.getResponseCode() == 200){
                is = new InputStreamReader(conn.getInputStream(), "UTF-8");
            } else {
            	is = new InputStreamReader(conn.getErrorStream(), "UTF-8");
            }
            
            // 리턴된 결과 읽기
            BufferedReader in = new BufferedReader(is);
            inputLine = in.readLine();
            while (inputLine != null) {
                outResult.append(inputLine);
                inputLine = in.readLine(); 
            }
            
            conn.disconnect();
            
            // insert api log - success            
            AtomyAzaAPI ato = new AtomyAzaAPI();
            ato.insertLog(ods, "ATOMY", "Y", NVL(jsonValue), NVL(outResult.toString()) );

        } catch (Exception e) {        	
        	//insert api log - fail            
        	try {
        		AtomyAzaAPI ato = new AtomyAzaAPI();
        		ato.insertLog(ods, "ATOMY", "N", NVL(jsonValue), NVL(outResult.toString()) );
        	}catch(Exception ee) {}
        	
            //TODO: handle exception
            e.printStackTrace();
        }
        
        //System.out.println("outResult::: "+ outResult.toString());
        return outResult.toString();
    }

    /* 애터미아자몰 결과값 리턴 */
    public JSONObject returnStates(OrderService orderService, String result) throws Exception{
    	/*
        {
		    "states": "OK",
		    "states_detail": "성공",
		    "service_od_id": "19654321333",
		    "aza_od_id": "19120215222389"
		 }
        */
       JSONParser jsonParse = new JSONParser();
       JSONObject jObject = (JSONObject) jsonParse.parse(new StringReader(result));
       
       if(jObject.get("states").toString().equals("OK")){
    	   //System.out.println("API SUCCESS>>" + jObject.get("states_detail").toString());
       } else {
    	   //실패 로그저장 (주문번호, return json, post json)
       }
       
       return jObject;
    }
    
	// 널처리
	public String NVL(Object text){
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
		if(str==null) return "";
		
		return java.net.URLEncoder.encode(str, "UTF-8");
	}
	
	
	/* * * * API 로그 기록 * * * */
	/*	 
	 - TB_APILOG
	 id : NVL(MAX(id), 0)+1
	 gubn : "ATOMY"
	 success : 'Y', 'N'
	 send : String (3000) 
	 recv : String (1000)
	 create_date : sysdate
	 */	
	public void insertLog (OrderService ods, String gubn, String success, String send_msg, String recv_msg) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("gubn", gubn);
		map.put("success", success);
		map.put("send_msg", NVL(send_msg.toString()));
		map.put("recv_msg", NVL(recv_msg.toString()));
		
		ods.insertApiLog(map);
	}
}
