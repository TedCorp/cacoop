package mall.web.controller.mall;



import java.security.MessageDigest;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

//import lgdacom.XPayClient.XPayClient;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_ODINFOXM;

@Controller
@RequestMapping(value="/pay")
public class PayController extends DefaultController {

	/**
	 * 결제 화면을 보여줍니다.
	 * @param resv
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/form", method=RequestMethod.GET)
	public  ModelAndView view(HttpServletRequest request, HttpSession session, Model model) throws Exception {


		return new ModelAndView("mallNew.layout", "jsp", "mall/pay/form");
	}	
	/**
	 * 결제인증요청 화면 ( 인증을 위한 결제창 호출 )
	 * @param resv
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/payReq")
	public  ModelAndView view2(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, HttpSession session, Model model) throws Exception {



	    /*
	     * [결제 인증요청 페이지(STEP2-1)]
	     * 샘플페이지에서는 기본 파라미터만 예시되어 있으며, 별도로 필요하신 파라미터는 연동메뉴얼을 참고하시어 추가 하시기 바랍니다.
	     */

	    /*
	     * 1. 기본결제 인증요청 정보 변경
	     * 기본정보를 변경하여 주시기 바랍니다.(파라미터 전달시 POST를 사용하세요)
	     */
		
		long timestamp = (System.currentTimeMillis() / 1000L) * 1000L;
		
	    String CST_PLATFORM         = "test";                 //LG유플러스 결제서비스 선택(test:테스트, service:서비스)
	    String CST_MID              = "KRIBB";                //LG유플러스로 부터 발급받으신 상점아이디를 입력하세요.
	    String LGD_MID              = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.
	                                                                                        //상점아이디(자동생성)
	    String LGD_OID              = tb_odinfoxm.getORDER_NUM();                      //주문번호(상점정의 유니크한 주문번호를 입력하세요)
	    String LGD_AMOUNT           = tb_odinfoxm.getORDER_AMT();				//결제금액("," 를 제외한 결제금액을 입력하세요)             
	    String LGD_MERTKEY          = "f521e1be913b23de7a66b793b90069ec";                  //상점MertKey(mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)
	    String LGD_BUYER            = tb_odinfoxm.getMEMB_NM();                    //구매자명
	    String LGD_PRODUCTINFO      = "장비분석이용료";              //상품명
	    String LGD_BUYEREMAIL       = "test@daum.net";               //구매자 이메일
	    String LGD_TIMESTAMP        = ""+timestamp;                //타임스탬프
	    String LGD_CUSTOM_USABLEPAY = "SC0010";        	//상점정의 초기결제수단
	    String LGD_CUSTOM_SKIN      = "red";                                                //상점정의 결제창 스킨(red)
	    String LGD_CUSTOM_SWITCHINGTYPE = "IFRAME"; //신용카드 카드사 인증 페이지 연동 방식 (수정불가)
	    String LGD_WINDOW_VER		= "2.5";												//결제창 버젼정보
	    String LGD_WINDOW_TYPE      = "iframe";              //결제창 호출 방식 (수정불가)
		String LGD_OSTYPE_CHECK     = "P";                                                  //값 P: XPay 실행(PC 결제 모듈): PC용과 모바일용 모듈은 파라미터 및 프로세스가 다르므로 PC용은 PC 웹브라우저에서 실행 필요. 
	                                                                                        //"P", "M" 외의 문자(Null, "" 포함)는 모바일 또는 PC 여부를 체크하지 않음
		//String LGD_ACTIVEXYN		= "N";													//계좌이체 결제시 사용, ActiveX 사용 여부로 "N" 이외의 값: ActiveX 환경에서 계좌이체 결제 진행(IE)

	    
	    /*
	     * 가상계좌(무통장) 결제 연동을 하시는 경우 아래 LGD_CASNOTEURL 을 설정하여 주시기 바랍니다.
	     */
	    String LGD_CASNOTEURL		= "http://127.0.0.1:8080/cas_noteurl.jsp";

	    /*
	     * LGD_RETURNURL 을 설정하여 주시기 바랍니다. 반드시 현재 페이지와 동일한 프로트콜 및  호스트이어야 합니다. 아래 부분을 반드시 수정하십시요.
	     */
	    String LGD_RETURNURL		= "http://211.211.240.166:8080/pay/payReturn";// FOR MANUAL
	    //String LGD_RETURNURL		= "http://1.245.107.177:8080/pay/payReturn";// FOR MANUAL
	    //String LGD_RETURNURL		= "http://127.0.0.1:8080/pay/payReturn";// FOR MANUAL

	    
	    /*
	     *************************************************
	     * 2. MD5 해쉬암호화 (수정하지 마세요) - BEGIN
	     *
	     * MD5 해쉬암호화는 거래 위변조를 막기위한 방법입니다.
	     *************************************************
	     *
	     * 해쉬 암호화 적용( LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP + LGD_MERTKEY )
	     * LGD_MID          : 상점아이디
	     * LGD_OID          : 주문번호
	     * LGD_AMOUNT       : 금액
	     * LGD_TIMESTAMP    : 타임스탬프
	     * LGD_MERTKEY      : 상점MertKey (mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)
	     *
	     * MD5 해쉬데이터 암호화 검증을 위해
	     * LG유플러스에서 발급한 상점키(MertKey)를 환경설정 파일(lgdacom/conf/mall.conf)에 반드시 입력하여 주시기 바랍니다.
	     */
	    StringBuffer sb = new StringBuffer();
	    sb.append(LGD_MID);
	    sb.append(LGD_OID);
	    sb.append(LGD_AMOUNT);
	    sb.append(LGD_TIMESTAMP);
	    sb.append(LGD_MERTKEY);

	    byte[] bNoti = sb.toString().getBytes();
	    MessageDigest md = MessageDigest.getInstance("MD5");
	    byte[] digest = md.digest(bNoti);

	    StringBuffer strBuf = new StringBuffer();
	    for (int i=0 ; i < digest.length ; i++) {
	        int c = digest[i] & 0xff;
	        if (c <= 15){
	            strBuf.append("0");
	        }
	        strBuf.append(Integer.toHexString(c));
	    }

	    String LGD_HASHDATA = strBuf.toString();
	    String LGD_CUSTOM_PROCESSTYPE = "TWOTR";
	    /*
	     *************************************************
	     * 2. MD5 해쉬암호화 (수정하지 마세요) - END
	     *************************************************
	     */
	  	
	    Map payReqMap = new HashMap();
	    payReqMap.put("CST_PLATFORM"                , CST_PLATFORM);                   	// 테스트, 서비스 구분
	    payReqMap.put("CST_MID"                     , CST_MID );                        // 상점아이디
	    payReqMap.put("LGD_WINDOW_TYPE"             , LGD_WINDOW_TYPE );                // 결제창호출 방식(수정불가)
	    payReqMap.put("LGD_MID"                     , LGD_MID );                        // 상점아이디
	    payReqMap.put("LGD_OID"                     , LGD_OID );                        // 주문번호
	    payReqMap.put("LGD_BUYER"                   , LGD_BUYER );                      // 구매자
	    payReqMap.put("LGD_PRODUCTINFO"             , LGD_PRODUCTINFO );                // 상품정보
	    payReqMap.put("LGD_AMOUNT"                  , LGD_AMOUNT );                     // 결제금액
	    payReqMap.put("LGD_BUYEREMAIL"              , LGD_BUYEREMAIL );                 // 구매자 이메일
	    payReqMap.put("LGD_CUSTOM_SKIN"             , LGD_CUSTOM_SKIN );                // 결제창 SKIN
	    payReqMap.put("LGD_CUSTOM_PROCESSTYPE"      , LGD_CUSTOM_PROCESSTYPE );         // 트랜잭션 처리방식
	    payReqMap.put("LGD_TIMESTAMP"               , LGD_TIMESTAMP );                  // 타임스탬프
	    payReqMap.put("LGD_HASHDATA"                , LGD_HASHDATA );      	           	// MD5 해쉬암호값
	    payReqMap.put("LGD_RETURNURL"   			, LGD_RETURNURL );      			// 응답수신페이지
	    payReqMap.put("LGD_CUSTOM_USABLEPAY"  		, LGD_CUSTOM_USABLEPAY );			// 디폴트 결제수단 (해당 필드를 보내지 않으면 결제수단 선택 UI 가 보이게 됩니다.)
	    payReqMap.put("LGD_CUSTOM_SWITCHINGTYPE"  	, LGD_CUSTOM_SWITCHINGTYPE );		// 신용카드 카드사 인증 페이지 연동 방식
	    payReqMap.put("LGD_WINDOW_VER"  			, LGD_WINDOW_VER );					// 결제창 버젼정보 
	    payReqMap.put("LGD_OSTYPE_CHECK"            , LGD_OSTYPE_CHECK);                // 값 P: XPay 실행(PC용 결제 모듈), PC, 모바일 에서 선택적으로 결제가능 
		//payReqMap.put("LGD_ACTIVEXYN"			    , LGD_ACTIVEXYN);					// 계좌이체 결제시 사용, ActiveX 사용 여부
		payReqMap.put("LGD_VERSION"         		, "JSP_Non-ActiveX_Standard");		// 사용타입 정보(수정 및 삭제 금지): 이 정보를 근거로 어떤 서비스를 사용하는지 판단할 수 있습니다.

	    // 가상계좌(무통장) 결제연동을 하시는 경우  할당/입금 결과를 통보받기 위해 반드시 LGD_CASNOTEURL 정보를 LG 유플러스에 전송해야 합니다 .
	    payReqMap.put("LGD_CASNOTEURL"          , LGD_CASNOTEURL );               // 가상계좌 NOTEURL

	    /*Return URL에서 인증 결과 수신 시 셋팅될 파라미터 입니다.*/
		payReqMap.put("LGD_RESPCODE"  		 , "" );
		payReqMap.put("LGD_RESPMSG"  		 , "" );
		payReqMap.put("LGD_PAYKEY"  		 , "" );

		//session.setAttribute("PAYREQ_MAP", payReqMap);
		model.addAttribute("PAYREQ_MAP", payReqMap);
		model.addAttribute("CST_MID", CST_MID);
		model.addAttribute("CST_PLATFORM", CST_PLATFORM);
		model.addAttribute("LGD_OID",    LGD_OID);
		model.addAttribute("LGD_MERTKEY", LGD_MERTKEY);
		model.addAttribute("LGD_AMOUNT", LGD_AMOUNT);
		model.addAttribute("LGD_BUYER", LGD_BUYER);
		model.addAttribute("LGD_PRODUCTINFO", LGD_PRODUCTINFO);
		model.addAttribute("LGD_BUYEREMAIL", LGD_BUYEREMAIL);
		model.addAttribute("LGD_TIMESTAMP", LGD_TIMESTAMP);
		model.addAttribute("LGD_CUSTOM_USABLEPAY", LGD_CUSTOM_USABLEPAY);
		model.addAttribute("LGD_CUSTOM_SWITCHINGTYPE", LGD_CUSTOM_SWITCHINGTYPE);
		model.addAttribute("LGD_WINDOW_TYPE", LGD_WINDOW_TYPE);

		/*return new ModelAndView("mallNew.layout", "jsp", "mall/pay/payReq");*/
		return new ModelAndView("mall.responsive.layout", "jsp", "mall/pay/payReq");
		
	}	/**
	 * 인증요청 응답 화면 (
	 * @param resv
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/payReturn", method=RequestMethod.POST)
	public  ModelAndView payReturn(HttpServletRequest request, HttpSession session, Model model) throws Exception {

		String LGD_RESPCODE = request.getParameter("LGD_RESPCODE");
		String LGD_RESPMSG 	= request.getParameter("LGD_RESPMSG");
		Map payReqMap = request.getParameterMap();


		model.addAttribute("LGD_RESPCODE", LGD_RESPCODE);
		model.addAttribute("LGD_RESPMSG",  LGD_RESPMSG);
		model.addAttribute("payReqMap",    payReqMap);
		
		request.setAttribute("payReqMap", payReqMap);

		return new ModelAndView("mallNew.layout", "jsp", "mall/pay/payReturn");
	}
	
	/**
	 * 최종결제요청 및 결제결과 처리
	 * @param resv
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping(value="/payRes", method=RequestMethod.POST)
//	public  ModelAndView payRes( HttpServletRequest request, HttpSession session, Model model) throws Exception {
//		
//		//String configPath = "C:/lgdacom";  //LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf,/conf/mall.conf") 위치 지정.
//		String configPath = "/home/mirecoweb/webdata/lgdacom";
//		
//		
//		String CST_PLATFORM                 = request.getParameter("CST_PLATFORM");
//	    String CST_MID                      = request.getParameter("CST_MID");
//	    String LGD_MID                      = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;
//	    String LGD_PAYKEY                   = request.getParameter("LGD_PAYKEY");
//	    
//	    //해당 API를 사용하기 위해 WEB-INF/lib/XPayClient.jar 를 Classpath 로 등록하셔야 합니다.
//		// (1) XpayClient의 사용을 위한 xpay 객체 생성
//	    XPayClient xpay = new XPayClient();
//
//		// (2) Init: XPayClient 초기화(환경설정 파일 로드) 
//		// configPath: 설정파일
//		// CST_PLATFORM: - test, service 값에 따라 lgdacom.conf의 test_url(test) 또는 url(srvice) 사용
//		//				 - test, service 값에 따라 테스트용 또는 서비스용 아이디 생성
//	   	boolean isInitOK = xpay.Init(configPath, CST_PLATFORM);
//	   	
//	   	Map<String,String> payResMap = new HashMap<String,String>();
//	   	
//	   	if( !isInitOK ) {
//	    	//API 초기화 실패 화면처리
//	        payResMap.put("msg01" , "결제요청을 초기화 하는데 실패하였습니다.<br>"
//	        		+ "LG유플러스에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.<br>"
//	        		+ "mall.conf에는 Mert ID = Mert Key 가 반드시 등록되어 있어야 합니다.<br><br>"
//	        		+ "문의전화 LG유플러스 1544-7772<br>");
//	        model.addAttribute("payResMap", payResMap);
//	        return new ModelAndView("mallNew.layout", "jsp", "mall/pay/payRes");
//	   	
//	   	}else{      
//	   		try{
//	   			
//				// (3) Init_TX: 메모리에 mall.conf, lgdacom.conf 할당 및 트랜잭션의 고유한 키 TXID 생성
//		    	xpay.Init_TX(LGD_MID);
//		    	xpay.Set("LGD_TXNAME", "PaymentByKey");
//		    	xpay.Set("LGD_PAYKEY", LGD_PAYKEY);
//		    
//		    	//금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
//		    	//String DB_AMOUNT = "DB나 세션에서 가져온 금액"; //반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
//		    	//xpay.Set("LGD_AMOUNTCHECKYN", "Y");
//		    	//xpay.Set("LGD_AMOUNT", DB_AMOUNT);
//		    
//	    	}catch(Exception e) {
//	    		payResMap.put("msg01" , "LG유플러스 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다.");
//	    		payResMap.put("msg02" , ""+e.getMessage());
//		        model.addAttribute("payResMap", payResMap);
//		        return new ModelAndView("mallNew.layout", "jsp", "mall/pay/payRes");
//	    	}
//	   	}
//	   	
//	   	/*
//		 *************************************************
//		 * 1.최종결제 요청(수정하지 마세요) - END
//		 *************************************************
//		 */
//
//	    /*
//	     * 2. 최종결제 요청 결과처리
//	     *
//	     * 최종 결제요청 결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
//	     */
//		
//        //(4) TX: lgdacom.conf에 설정된 URL로 소켓 통신하여 최종 인증요청, 결과값으로 true, false 리턴
//	    if ( xpay.TX() ) {
//	        //1)결제결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
//	        payResMap.put("msg01" , "결제요청이 완료되었습니다.  <br>"
//	        		+ "TX 결제요청 통신 응답코드 = " + xpay.m_szResCode + "<br>"    //통신 응답코드("0000" 일 때 통신 성공)
//	        		+ "TX 결제요청 통신 응답메시지 = " + xpay.m_szResMsg + "<p>");  //통신 응답메시지
//	        
//    		payResMap.put("msg02" , 
//    				  "거래번호 : " + xpay.Response("LGD_TID",0) + "<br>"
//    				+ "상점아이디 : " + xpay.Response("LGD_MID",0) + "<br>"
//    				+ "상점주문번호 : " + xpay.Response("LGD_OID",0) + "<br>"
//    				+ "결제금액 : " + xpay.Response("LGD_AMOUNT",0) + "<br>"
//    				+ "결과코드 : " + xpay.Response("LGD_RESPCODE",0) + "<br>"   //LGD_RESPCODE 가 반드시 "0000" 일때만 결제 성공, 그 외는 모두 실패
//    				+ "결과메세지 : " + xpay.Response("LGD_RESPMSG",0) + "<p>");
//	        
//    		StringBuffer sb = new StringBuffer();
//	        for (int i = 0; i < xpay.ResponseNameCount(); i++)
//	        {
//	        	sb.append(xpay.ResponseName(i) + " = ");
//	            
//	            for (int j = 0; j < xpay.ResponseCount(); j++)
//	            {
//	            	sb.append("\t" + xpay.Response(xpay.ResponseName(i), j) + "<br>");
//	            }
//	        }
//	        sb.append("<p>");
//	        payResMap.put("msg03" , sb.toString());
//	        
//			// (5) DB에 인증요청 결과 처리
//	        if( "0000".equals( xpay.m_szResCode ) ) {
//	        	// 통신상의 문제가 없을시
//	        	// 최종결제요청 결과 성공 DB처리(LGD_RESPCODE 값에 따라 결제가 성공인지, 실패인지 DB처리)
//	        	
//	        	payResMap.put("msg04" , "최종결제요청 성공, DB처리하시기 바랍니다.<br>");
//	        	
//	        	//1. resv 업데이트 및 MIS 송부 처리
////	        	resv.setResvState("5001");
////	        	resv.setPayYn("Y");
////	        	resv.setInDMLUserId(myInfo.getUserId());
////	        	
//	        	boolean isDBOK = false;
//	        	
//	        	//if( reserveService.updateResvPayComplete(resv) > 0 ) {
//	        		isDBOK = true;
//	        		
//	        	//}
//	         	            	
//	         	//최종결제요청 결과를 DB처리합니다. (결제성공 또는 실패 모두 DB처리 가능)
//				//상점내 DB에 어떠한 이유로 처리를 하지 못한경우 false로 변경해 주세요.
//	         	 
//	         	if( !isDBOK ) {
//					 
//	         		xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
//	         		
//	         		payResMap.put("msg05" , "TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE",0) + "<br>");
//	         		payResMap.put("msg06" , "TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG",0) + "<p>");
//	         		
//					if( "0000".equals( xpay.m_szResCode ) ) { 
//						payResMap.put("msg07" , "자동취소가 정상적으로 완료 되었습니다.<br>");
//					}else{
//						payResMap.put("msg07" , "자동취소가 정상적으로 처리되지 않았습니다.<br>");
//					}
//	         	}
//	         	
//	        }else{
//				//통신상의 문제 발생(최종결제요청 결과 실패 DB처리)
//	        	payResMap.put("msg08" , "최종결제요청 결과 실패, DB처리하시기 바랍니다.<br>");           	
//	        }
//	    }else {
//	         //2)API 요청실패 화면처리
//	    	payResMap.put("msg09" , "결제요청이 실패하였습니다.  <br>");
//	    	payResMap.put("msg10" , "TX 결제요청 Response_code = " + xpay.m_szResCode + "<br>");      
//	    	payResMap.put("msg11" , "TX 결제요청 Response_msg = " + xpay.m_szResMsg + "<p>");      
//	    	    
//	     	//최종결제요청 결과 실패 DB처리
//	    	payResMap.put("msg12" , "최종결제요청 결과 실패 DB처리하시기 바랍니다.<br>");      	            
//	    }
//
//	    model.addAttribute("payResMap", payResMap);
//
//		return new ModelAndView("mallNew.layout", "jsp", "mall/pay/payRes");
//		
//	}
}
