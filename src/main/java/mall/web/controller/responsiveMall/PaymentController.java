package mall.web.controller.responsiveMall;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import mall.web.controller.DefaultController;
import mall.web.domain.TB_LGUPLUS;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.service.mall.OrderService;

import org.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.*;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.client.ResponseErrorHandler;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value="/payment")
public class PaymentController extends DefaultController{
	
	
	private static final Logger logger = LoggerFactory.getLogger(OrderRestController.class);

	@Autowired
	private Environment environment;
	
	@Resource(name="orderService")
	OrderService orderService;
	
	private final RestTemplate restTemplate = new RestTemplate();

    private final ObjectMapper objectMapper = new ObjectMapper();

    @PostConstruct
    private void init() {
        restTemplate.setErrorHandler(new ResponseErrorHandler() {
            @Override
            public boolean hasError(ClientHttpResponse response) {
                return false;
            }

            @Override
            public void handleError(ClientHttpResponse response) {
            }
        });
    }

    private final String SECRET_KEY = "live_sk_OAQ92ymxN34jBkzPKL4rajRKXvdk";

    @RequestMapping("/success")
    public ModelAndView confirmPayment(
            @RequestParam String paymentKey, @RequestParam String orderId, @RequestParam Long amount,
            Model model) throws Exception {
    	TB_ODINFOXM tb_odinfoxm = new TB_ODINFOXM();
    	TB_LGUPLUS tb_lguplus = new TB_LGUPLUS();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Basic " + Base64.getEncoder().encodeToString((SECRET_KEY + ":").getBytes()));
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, String> payloadMap = new HashMap<>();
        payloadMap.put("orderId", orderId);
        payloadMap.put("amount", String.valueOf(amount));
        HttpEntity<String> request = new HttpEntity<>(objectMapper.writeValueAsString(payloadMap), headers);

        ResponseEntity<JsonNode> responseEntity = restTemplate.postForEntity(
                "https://api.tosspayments.com/v1/payments/" + paymentKey, request, JsonNode.class);

        if (responseEntity.getStatusCode() == HttpStatus.OK) {
            JsonNode successNode = responseEntity.getBody();
            model.addAttribute("orderId", successNode.get("orderId").asText());
            System.out.println("successNode : " + successNode);
            JSONObject jsonNode = new JSONObject(successNode.toString());
            Object mId = jsonNode.get("mId");
            Object method = jsonNode.get("method");
            Object status = jsonNode.get("status");
            Object requestedAt = jsonNode.get("requestedAt");
            Object approvedAt = jsonNode.get("approvedAt");
            Object useEscrow = jsonNode.get("useEscrow");
            Object secret = jsonNode.get("secret");
            Object totalAmount = jsonNode.get("totalAmount");
            if(method.toString().equals("카드")) {
            	System.out.println("카드 결제");
            	JSONObject card = new JSONObject(jsonNode.get("card").toString());
            	Object company = card.get("company");
            	Object number = card.get("number");
            	Object installmentPlanMonths = card.get("installmentPlanMonths");
            	Object isInterestFree = card.get("isInterestFree");
            	Object approveNo = card.get("approveNo");
            	Object useCardPoint = card.get("useCardPoint");
            	Object cardType = card.get("cardType");
            	Object ownerType = card.get("ownerType");
            	Object acquireStatus = card.get("acquireStatus");
            	Object receiptUrl = card.get("receiptUrl");
            	
            	tb_lguplus.setLGD_CARDNUM(number.toString());
            	tb_lguplus.setLGD_PAYTYPE("SC0010");
            	tb_lguplus.setLGD_FINANCENAME(company.toString());
            	tb_lguplus.setLGD_FINANCECODE(company.toString());
            	tb_lguplus.setLGD_FINANCEAUTHNUM(company.toString());
            	tb_odinfoxm.setPAY_METD("SC0010");
            	tb_odinfoxm.setFINANCENAME(company.toString());
            	tb_lguplus.setLGD_RESPMSG("결제성공");
            	
            	tb_lguplus.setLGD_FINANCEAUTHNUM(approveNo.toString());            	
            }
            
            if(method.toString().equals("계좌이체")) {
            	System.out.println("계좌이체 결제");
            	tb_lguplus.setLGD_RESPMSG("계좌이체 확인");
            	tb_lguplus.setLGD_PAYTYPE("SC0030");
            	tb_odinfoxm.setPAY_METD("SC0030");
            }
			if(method.toString().equals("가상계좌") ) {
				System.out.println("가상계좌 결제");
				JSONObject virtualAccount = new JSONObject(jsonNode.get("virtualAccount").toString());
				Object accountNumber = virtualAccount.get("accountNumber");
				Object accountType = virtualAccount.get("accountType");
				Object bank = virtualAccount.get("bank");
				Object customerName = virtualAccount.get("customerName");
				Object dueDate = virtualAccount.get("dueDate");
            	Object expired = virtualAccount.get("expired");
            	Object settlementStatus = virtualAccount.get("settlementStatus");
            	Object refundStatus = virtualAccount.get("refundStatus");
            	
            	tb_lguplus.setLGD_RESPMSG("가상계좌 입금 대기");
            	tb_lguplus.setLGD_FINANCENAME(bank.toString());
            	tb_lguplus.setLGD_FINANCECODE(bank.toString());
     		    tb_lguplus.setLGD_ACCOUNTNUM(accountNumber.toString());
     		    tb_lguplus.setLGD_PAYTYPE("SC0040");
				tb_lguplus.setLGD_CASTAMOUNT(totalAmount.toString());		//입금총액 (무통장)
				tb_lguplus.setLGD_CASCAMOUNT("0");			//현입금총액 (무통장)
				tb_lguplus.setLGD_CASFLAG("R");			//무통장입금 플래그
				tb_lguplus.setLGD_CASSEQNO(accountNumber.toString());			// 입금순서 
				
     		    tb_odinfoxm.setPAY_METD("SC0040");
     		    tb_odinfoxm.setFINANCENAME(bank.toString());
     		    tb_odinfoxm.setFINANCECODE(accountNumber.toString());
     		    
			}
			if(method.toString().equals("휴대폰")) {
				System.out.println("휴대폰 결제");
				JSONObject mobilePhone = new JSONObject(jsonNode.get("mobilePhone").toString());
				Object carrier = mobilePhone.get("carrier");
            	Object customerMobilePhone = mobilePhone.get("customerMobilePhone");
            	Object settlementStatus = mobilePhone.get("settlementStatus");
            	tb_lguplus.setLGD_PAYTYPE("SC0060");
            	tb_lguplus.setLGD_RESPMSG("결제성공");
            	tb_lguplus.setLGD_FINANCECODE(carrier.toString());
            	tb_lguplus.setLGD_FINANCENAME(carrier.toString());
            	
            	tb_odinfoxm.setPAY_METD("SC0060");
            	tb_odinfoxm.setFINANCECODE(customerMobilePhone.toString());
			}
			System.out.println("nullcheck : "+(!jsonNode.isNull("cashReceipt")));
			if(!jsonNode.isNull("cashReceipt")) {
				System.out.println("소득공제 있음 ");
				JSONObject cashReceipt = new JSONObject(jsonNode.get("cashReceipt").toString());
				Object type = cashReceipt.get("taxFreeAmount");    	
				Object rAmount = cashReceipt.get("amount");    	
				Object taxFreeAmount = cashReceipt.get("taxFreeAmount");    	
				Object issueNumber = cashReceipt.get("issueNumber");    	
				Object receiptUrl = cashReceipt.get("receiptUrl");    	
			}else{
				System.out.println("소득공제 없음 ");
			}
			String resultMSG = "";
            System.out.println("mId : "+mId);
            System.out.println("method ; "+method);
            System.out.println("orderId : "+orderId);
            
	    	// 결제정보
            
			
			tb_odinfoxm.setORDER_NUM(orderId);
			//tb_odinfoxm.setPAY_METD("SC0040");		//LGD_PAYTYPE
			tb_odinfoxm.setPAY_AMT(totalAmount.toString());	//입금총액
			tb_odinfoxm.setPAY_MDKY(paymentKey);
			tb_odinfoxm.setMODP_ID("toss");
			tb_odinfoxm.setORDER_CON("ORDER_CON_02");
			
			
//	        	if( "R".equals( LGD_CASFLAG.trim() ) ) { // 무통장입금 플래그(무통장입금) - 'R':계좌할당, 'I':입금, 'C':입금취소 
//	                /* 무통장 할당 성공 결과 상점 처리(DB) 부분 */
//	        		resultMSG = "가상계좌 할당성공";
//        			tb_odinfoxm.setORDER_CON("ORDER_CON_10");
//        			try {
//	        			if( orderService.cashRequest(tb_odinfoxm) > 0 ) {
//			        		orderService.orderPayUpdateDtl(tb_odinfoxm);	//주문디테일 처리
//		            		resultMSG = "OK";
//			        	}
//        			} catch(Exception e) {
//        			    e.printStackTrace();
//	        			resultMSG = "가상계좌할당 DB처리 실패";
//        			}
//	        	}else if( "I".equals( LGD_CASFLAG.trim() ) ) {
//	 	            /* 무통장 입금 성공 결과 상점 처리(DB) 부분 */    
//	        		if(LGD_AMOUNT.equals(LGD_CASTAMOUNT)) {
//	        			// 결제완료처리
//	        			tb_odinfoxm.setORDER_CON("ORDER_CON_02");
//	        			try {
//	        				if( orderService.orderPayUpdate(tb_odinfoxm) > 0 ) {
//				        		orderService.orderPayUpdateDtl(tb_odinfoxm);	//주문디테일 처리
//			            		resultMSG = "OK";
//				        	}
//	        			} catch(Exception e) {
//	        			    e.printStackTrace();
//		        			resultMSG = "결제완료 DB처리 실패";
//	        			}
//	        		} else {
//	        			// 가상계좌 할당상태
//	        			tb_odinfoxm.setORDER_CON("ORDER_CON_10");
//	        			try {
//		        			if( orderService.cashRequest(tb_odinfoxm) > 0 ) {
//				        		orderService.orderPayUpdateDtl(tb_odinfoxm);	//주문디테일 처리
//			            		resultMSG = "OK";
//				        	}
//	        			} catch(Exception e) {
//	        			    e.printStackTrace();
//		        			resultMSG = "입금대기 DB처리 실패";
//	        			}
//	        		}
//	        	}else if( "C".equals( LGD_CASFLAG.trim() ) ) {
//	 	            /* 무통장 입금취소 성공 결과 상점 처리(DB) 부분 */
//	        		GUBN = "CALCEL";
//        			tb_odinfoxm.setORDER_CON("ORDER_CON_10");				//가상계좌 할당상태
//        			tb_odinfoxm.setCNCL_MSG("은행에서 입금 취소");
//        			try{
//	        			if( orderService.cancelObject(tb_odinfoxm) > 0 ) {
//			        		orderService.orderPayUpdateDtl(tb_odinfoxm);	//주문디테일 처리
//			        		
//			        		// 애터미아자 상품주문 API -- 취소처리
//			        		tb_odinfoxm.setORDER_CON("ORDER_CON_04");
//			        		
//		            		resultMSG = "OK";
//			        	}
//		        	}
//	        		catch(Exception e){
//        			    e.printStackTrace();
//	        			resultMSG = "입금취소 DB처리 실패";
//		        	}
//	        	}
			
    			if( orderService.orderPayUpdate(tb_odinfoxm) > 0 ) {
    				orderService.orderPayUpdateDtl(tb_odinfoxm);
    			}
    			
    		    try {
    		    //결제 로그 처리
    	    	
    		    tb_lguplus.setLGD_TID(paymentKey);
    		    tb_lguplus.setLGD_OID(orderId);
    		    tb_lguplus.setLGD_AMOUNT(totalAmount.toString());
    		    tb_lguplus.setGUBUN("ORDER");
    		    tb_lguplus.setLGD_RESPCODE(status.toString());
//    		    tb_lguplus.setLGD_RESPMSG("결제성공");
    		    tb_lguplus.setLGD_PAYDATE(requestedAt.toString());
//    		    tb_lguplus.setLGD_FINANCECODE(LGD_FINANCECODE);
//    		    tb_lguplus.setLGD_CASTAMOUNT(LGD_CASTAMOUNT);
//    		    tb_lguplus.setLGD_CASCAMOUNT(LGD_CASCAMOUNT);
//    		    tb_lguplus.setLGD_CASFLAG(LGD_CASFLAG);
//    		    tb_lguplus.setLGD_CASSEQNO(LGD_CASSEQNO);
//    		    tb_lguplus.setLGD_CASHRECEIPTNUM(LGD_CASHRECEIPTNUM);
//    		    tb_lguplus.setLGD_CASHRECEIPTKIND(LGD_CASHRECEIPTKIND);
//    		    tb_lguplus.setLGD_CLOSEDATE(LGD_CLOSEDATE);
    		    tb_lguplus.setSTATE(resultMSG);
    		    
    		    if(tb_lguplus.getLGD_TID() != null) {
    				orderService.lguplusLogInsert(tb_lguplus);
    		    }
    			
    		}catch(Exception e){
    			logger.info("LgUplus Logging Error : " + e.toString());
    		}
    		tb_odinfoxm.setORDER_NUM(orderId);
    		
    		System.out.println("update 쿼리 실행 ");
    		System.out.println(tb_odinfoxm.getPAY_METD());
            int updateCnt = orderService.updateOrderCon(tb_odinfoxm);
            
            RedirectView redirectView = new RedirectView(servletContextPath+"/m/order/view/"+orderId);
    		return new ModelAndView(redirectView);
        } else {
            JsonNode failNode = responseEntity.getBody();
            model.addAttribute("message", failNode.get("message").asText());
            model.addAttribute("code", failNode.get("code").asText());
            
            RedirectView redirectView = new RedirectView(servletContextPath+"/m/order/fail");
            return new ModelAndView(redirectView);
        }
    }

    @RequestMapping("/fail")
    public String failPayment(@RequestParam String message, @RequestParam String code, Model model) {
        model.addAttribute("message", message);
        model.addAttribute("code", code);
        return "fail";
    }
//
//    @RequestMapping("/virtual-account/callback")
//    @ResponseStatus(HttpStatus.OK)
//    public void handleVirtualAccountCallback(@RequestBody CallbackPayload payload) {
//        if (payload.getStatus().equals("DONE")) {
//            // handle deposit result
//        }
//    }

    @RequestMapping(value="/insertPayLog")
    public ModelAndView insertPayLog(HttpServletRequest request,HttpSession session,Model model) throws NoSuchAlgorithmException {
    	String GUBN = "";
    	/*
	     * [상점 결제결과처리(DB) 페이지]
	     *
	     * 1) 위변조 방지를 위한 hashdata값 검증은 반드시 적용하셔야 합니다.
	     *
	     */
	    String LGD_RESPCODE = "";					// 응답코드: 0000(성공) 그외 실패
	    String LGD_RESPMSG = "";					// 응답메세지
	    String LGD_MID = "";						// 상점아이디 
	    String LGD_OID = "";						// 주문번호
	    String LGD_AMOUNT = "";						// 거래금액
	    String LGD_TID = "";						// LG유플러스에서 부여한 거래번호
	    String LGD_PAYTYPE = "";					// 결제수단코드
	    String LGD_PAYDATE = "";					// 거래일시(승인일시/이체일시)
	    String LGD_HASHDATA = "";					// 해쉬값
	    String LGD_FINANCECODE = "";				// 결제기관코드(은행코드)
	    String LGD_FINANCENAME = "";				// 결제기관이름(은행이름)
	    String LGD_ESCROWYN = "";					// 에스크로 적용여부
	    String LGD_TIMESTAMP = "";					// 타임스탬프
	    String LGD_ACCOUNTNUM = "";					// 계좌번호(무통장입금) 
	    String LGD_CASTAMOUNT = "";					// 입금총액(무통장입금)
	    String LGD_CASCAMOUNT = "";					// 현입금액(무통장입금)
	    String LGD_CASFLAG = "";            		// 무통장입금 플래그(무통장입금) - 'R':계좌할당, 'I':입금, 'C':입금취소 
	    String LGD_CASSEQNO = "";           		// 입금순서(무통장입금)
	    String LGD_CASHRECEIPTNUM = "";				// 현금영수증 승인번호
	    String LGD_CASHRECEIPTSELFYN = "";			// 현금영수증자진발급제유무 Y: 자진발급제 적용, 그외 : 미적용
	    String LGD_CASHRECEIPTKIND = "";			// 현금영수증 종류 0: 소득공제용 , 1: 지출증빙용
	    String LGD_PAYER = "";						// 입금자명
	    String LGD_CLOSEDATE = "";					// 임금마감시간
	    
	    /*
	     * 구매정보
	     */
	    String LGD_BUYER = "";						// 구매자
	    String LGD_PRODUCTINFO = "";				// 상품명
	    String LGD_BUYERID = "";					// 구매자 ID
	    String LGD_BUYERADDRESS = "";				// 구매자 주소
	    String LGD_BUYERPHONE = "";					// 구매자 전화번호
	    String LGD_BUYEREMAIL = "";					// 구매자 이메일
	    String LGD_BUYERSSN = "";					// 구매자 주민번호
	    String LGD_PRODUCTCODE = "";				// 상품코드
	    String LGD_RECEIVER = "";					// 수취인
	    String LGD_RECEIVERPHONE = "";				// 수취인 전화번호
	    String LGD_DELIVERYINFO = "";				// 배송지

//	    LGD_RESPCODE					= request.getParameter("LGD_RESPCODE");
//	    LGD_RESPMSG						= request.getParameter("LGD_RESPMSG");
//	    LGD_MID							= request.getParameter("LGD_MID");
//	    LGD_OID							= request.getParameter("LGD_OID");
//	    LGD_AMOUNT						= request.getParameter("LGD_AMOUNT");
//	    LGD_TID							= request.getParameter("LGD_TID");
//	    LGD_PAYTYPE						= request.getParameter("LGD_PAYTYPE");
//	    LGD_PAYDATE						= request.getParameter("LGD_PAYDATE");
//	    LGD_HASHDATA					= request.getParameter("LGD_HASHDATA");
//	    LGD_FINANCECODE					= request.getParameter("LGD_FINANCECODE");
//	    LGD_FINANCENAME					= request.getParameter("LGD_FINANCENAME");
//	    LGD_ESCROWYN					= request.getParameter("LGD_ESCROWYN");
//	    LGD_TIMESTAMP					= request.getParameter("LGD_TIMESTAMP");
//	    LGD_ACCOUNTNUM					= request.getParameter("LGD_ACCOUNTNUM");
//	    LGD_CASTAMOUNT					= request.getParameter("LGD_CASTAMOUNT");
//	    LGD_CASCAMOUNT					= request.getParameter("LGD_CASCAMOUNT");
//	    LGD_CASFLAG						= request.getParameter("LGD_CASFLAG");
//	    LGD_CASSEQNO					= request.getParameter("LGD_CASSEQNO");
//	    LGD_CASHRECEIPTNUM				= request.getParameter("LGD_CASHRECEIPTNUM");
//	    LGD_CASHRECEIPTSELFYN			= request.getParameter("LGD_CASHRECEIPTSELFYN");
//	    LGD_CASHRECEIPTKIND				= request.getParameter("LGD_CASHRECEIPTKIND");
//	    LGD_PAYER						= request.getParameter("LGD_PAYER");
//	    LGD_CLOSEDATE					= request.getParameter("LGD_CLOSEDATE");	//
//
//	    LGD_BUYER						= request.getParameter("LGD_BUYER");
//	    LGD_PRODUCTINFO					= request.getParameter("LGD_PRODUCTINFO");
//	    LGD_BUYERID						= request.getParameter("LGD_BUYERID");
//	    LGD_BUYERADDRESS				= request.getParameter("LGD_BUYERADDRESS");
//	    LGD_BUYERPHONE					= request.getParameter("LGD_BUYERPHONE");
//	    LGD_BUYEREMAIL					= request.getParameter("LGD_BUYEREMAIL");
//	    LGD_BUYERSSN					= request.getParameter("LGD_BUYERSSN");
//	    LGD_PRODUCTCODE					= request.getParameter("LGD_PRODUCTCODE");
//	    LGD_RECEIVER					= request.getParameter("LGD_RECEIVER");
//	    LGD_RECEIVERPHONE				= request.getParameter("LGD_RECEIVERPHONE");
//	    LGD_DELIVERYINFO				= request.getParameter("LGD_DELIVERYINFO");
//
//	    /*
//	     * hashdata 검증을 위한 mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다. 
//	     * LG유플러스에서 발급한 상점키로 반드시변경해 주시기 바랍니다.
//	     */  
//	    String LGD_MERTKEY = environment.getRequiredProperty("lguplus.lgd_martkey");		//상점MertKey
//
//	    StringBuffer sb = new StringBuffer();
//	    sb.append(LGD_MID);
//	    sb.append(LGD_OID);
//	    sb.append(LGD_AMOUNT);
//	    sb.append(LGD_RESPCODE);
//	    sb.append(LGD_TIMESTAMP);
//	    sb.append(LGD_MERTKEY);
//
//	    byte[] bNoti = sb.toString().getBytes();
//	    MessageDigest md = MessageDigest.getInstance("MD5");
//	    byte[] digest = md.digest(bNoti);
//
//	    StringBuffer strBuf = new StringBuffer();
//	    for (int i=0 ; i < digest.length ; i++) {
//	        int c = digest[i] & 0xff;
//	        if (c <= 15){
//	            strBuf.append("0");
//	        }
//	        strBuf.append(Integer.toHexString(c));
//	    }
//
//	    String LGD_HASHDATA2 = strBuf.toString();  //상점검증 해쉬값  
	    
	    /*
	     * 상점 처리결과 리턴메세지
	     * OK  : 상점 처리결과 성공
	     * 그외 : 상점 처리결과 실패
	     * ※ 주의사항 : 성공시 'OK' 문자이외의 다른문자열이 포함되면 실패처리 되오니 주의하시기 바랍니다.
	     */    
	    String resultMSG = "결제결과 상점 DB처리(LGD_CASNOTEURL) 결과값을 입력해 주시기 바랍니다.";  
	    
	    //if (LGD_HASHDATA2.trim().equals(LGD_HASHDATA)) { //해쉬값 검증이 성공이면
	        if ( ("0000".equals(LGD_RESPCODE.trim())) ){ //결제가 성공이면
	        	// 결제정보
    			TB_ODINFOXM tb_odinfoxm = new TB_ODINFOXM();
    			tb_odinfoxm.setORDER_NUM(LGD_OID);
    			tb_odinfoxm.setPAY_METD("SC0040");		//LGD_PAYTYPE
    			tb_odinfoxm.setPAY_AMT(LGD_CASTAMOUNT);	//입금총액
    			tb_odinfoxm.setPAY_MDKY(LGD_TID);
    			tb_odinfoxm.setMODP_ID("toss");
    			
	        	if( "R".equals( LGD_CASFLAG.trim() ) ) {
	                /* 무통장 할당 성공 결과 상점 처리(DB) 부분 */
	        		resultMSG = "가상계좌 할당성공";
        			tb_odinfoxm.setORDER_CON("ORDER_CON_10");
        			try {
	        			if( orderService.cashRequest(tb_odinfoxm) > 0 ) {
			        		orderService.orderPayUpdateDtl(tb_odinfoxm);	//주문디테일 처리
		            		resultMSG = "OK";
			        	}
        			} catch(Exception e) {
        			    e.printStackTrace();
	        			resultMSG = "가상계좌할당 DB처리 실패";
        			}
	        	}else if( "I".equals( LGD_CASFLAG.trim() ) ) {
	 	            /* 무통장 입금 성공 결과 상점 처리(DB) 부분 */    
	        		if(LGD_AMOUNT.equals(LGD_CASTAMOUNT)) {
	        			// 결제완료처리
	        			tb_odinfoxm.setORDER_CON("ORDER_CON_02");
	        			try {
	        				if( orderService.orderPayUpdate(tb_odinfoxm) > 0 ) {
				        		orderService.orderPayUpdateDtl(tb_odinfoxm);	//주문디테일 처리
			            		resultMSG = "OK";
				        	}
	        			} catch(Exception e) {
	        			    e.printStackTrace();
		        			resultMSG = "결제완료 DB처리 실패";
	        			}
	        		} else {
	        			// 가상계좌 할당상태
	        			tb_odinfoxm.setORDER_CON("ORDER_CON_10");
	        			try {
		        			if( orderService.cashRequest(tb_odinfoxm) > 0 ) {
				        		orderService.orderPayUpdateDtl(tb_odinfoxm);	//주문디테일 처리
			            		resultMSG = "OK";
				        	}
	        			} catch(Exception e) {
	        			    e.printStackTrace();
		        			resultMSG = "입금대기 DB처리 실패";
	        			}
	        		}
	        	}else if( "C".equals( LGD_CASFLAG.trim() ) ) {
	 	            /* 무통장 입금취소 성공 결과 상점 처리(DB) 부분 */
	        		GUBN = "CALCEL";
        			tb_odinfoxm.setORDER_CON("ORDER_CON_10");				//가상계좌 할당상태
        			tb_odinfoxm.setCNCL_MSG("은행에서 입금 취소");
        			try{
	        			if( orderService.cancelObject(tb_odinfoxm) > 0 ) {
			        		orderService.orderPayUpdateDtl(tb_odinfoxm);	//주문디테일 처리
			        		
			        		// 애터미아자 상품주문 API -- 취소처리
			        		tb_odinfoxm.setORDER_CON("ORDER_CON_04");
			        		
		            		resultMSG = "OK";
			        	}
		        	}
	        		catch(Exception e){
        			    e.printStackTrace();
	        			resultMSG = "입금취소 DB처리 실패";
		        	}
	        	}
	        } else { //결제가 실패이면
	            /*
	             * 거래실패 결과 상점 처리(DB) 부분
	             */
	        	resultMSG = "거래실패";
	        }
	    
	    System.out.println(resultMSG.toString());
	    
//	    try {
//		    //결제 로그 처리
//	    	TB_LGUPLUS tb_lguplus = new TB_LGUPLUS();
//		    tb_lguplus.setLGD_TID(LGD_TID);
//		    tb_lguplus.setLGD_OID(LGD_OID);
//		    tb_lguplus.setLGD_AMOUNT(LGD_AMOUNT);
//		    tb_lguplus.setGUBUN(GUBN);
//		    tb_lguplus.setLGD_RESPCODE(LGD_RESPCODE);
//		    tb_lguplus.setLGD_RESPMSG(LGD_RESPMSG);
//		    tb_lguplus.setLGD_PAYTYPE(LGD_PAYTYPE);
//		    tb_lguplus.setLGD_PAYDATE(LGD_PAYDATE);
//		    tb_lguplus.setLGD_FINANCECODE(LGD_FINANCECODE);
//		    tb_lguplus.setLGD_FINANCENAME(LGD_FINANCENAME);
//		    tb_lguplus.setLGD_ACCOUNTNUM(LGD_ACCOUNTNUM);
//		    tb_lguplus.setLGD_CASTAMOUNT(LGD_CASTAMOUNT);
//		    tb_lguplus.setLGD_CASCAMOUNT(LGD_CASCAMOUNT);
//		    tb_lguplus.setLGD_CASFLAG(LGD_CASFLAG);
//		    tb_lguplus.setLGD_CASSEQNO(LGD_CASSEQNO);
//		    tb_lguplus.setLGD_CASHRECEIPTNUM(LGD_CASHRECEIPTNUM);
//		    tb_lguplus.setLGD_CASHRECEIPTKIND(LGD_CASHRECEIPTKIND);
//		    tb_lguplus.setLGD_CLOSEDATE(LGD_CLOSEDATE);
//		    tb_lguplus.setSTATE(resultMSG);
//		    
//		    if(tb_lguplus.getLGD_TID() != null) {
//				orderService.lguplusLogInsert(tb_lguplus);
//		    }
//			
//		}catch(Exception e){
//			logger.info("LgUplus Logging Error : " + e.toString());
//		}
	    return new ModelAndView();
    }
    
    
    public String cancelPayment(String paymentKey,String reason,String cancelAmount) throws Exception {

        HttpHeaders headers = new HttpHeaders();
        // headers.setBasicAuth(SECRET_KEY, ""); // spring framework 5.2 이상 버전에서 지원
        headers.set("Authorization", "Basic " + Base64.getEncoder().encodeToString((SECRET_KEY + ":").getBytes()));
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, String> payloadMap = new HashMap<>();
        payloadMap.put("cancelReason", reason);
        payloadMap.put("cancelAmount", cancelAmount);
        
        // 무통장일 경우 
        if(false) {
        	payloadMap.put("refundReceiveAccount", "");
        	payloadMap.put("bank", "");
        	payloadMap.put("accountNumber", "");
        	payloadMap.put("holderName", "");
        }
        HttpEntity<String> request = new HttpEntity<>(objectMapper.writeValueAsString(payloadMap), headers);

        ResponseEntity<JsonNode> responseEntity = restTemplate.postForEntity(
                "https://api.tosspayments.com/v1/payments/{paymentKey}/cancel", request, JsonNode.class);
        if (responseEntity.getStatusCode() == HttpStatus.OK) {
            JsonNode successNode = responseEntity.getBody();
            System.out.println("successNode : " + successNode);
            JSONObject jsonNode = new JSONObject(successNode.toString());
            
            return "success";
        } else {
            JsonNode failNode = responseEntity.getBody();
            RedirectView redirectView = new RedirectView(servletContextPath+"/m/order/fail");
    		return "fail";
            
        }
	
    
    }
}
