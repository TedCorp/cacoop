package mall.web.controller.admin;

import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import mall.common.util.StringUtil;
import mall.web.apiLink.AtomyAzaAPI;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_LGUPLUS;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.service.admin.impl.OrderMgrService;
import mall.web.service.admin.impl.OrderRfndMgrService;
import mall.web.service.common.CommonService;
import mall.web.service.mall.OrderService;

@Controller
@RequestMapping(value="/adm/orderRfndMgr")
public class OrderRfndMgrController extends DefaultController{

	@Resource(name="orderRfndMgrService")
	OrderRfndMgrService orderRfndMgrService;

	@Resource(name="orderMgrService")
	OrderMgrService orderMgrService;

	@Resource(name="orderService")
	OrderService orderService;
	
	@Resource(name="commonService")
	CommonService commonService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(OrderRfndMgrController.class);

	private final RestTemplate restTemplate = new RestTemplate();

	private final ObjectMapper objectMapper = new ObjectMapper();

	private final String SECRET_KEY = "test_sk_zXLkKEypNArWmo50nX3lmeaxYG5R";
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderRfndMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 환불접수 목록
	 * @Company	: YT Corp.
	 * @Author	: chjw
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		// Default date
		Map<String, String> betweenDate = commonService.betweenDate(request.getParameter("datepickerStr"), request.getParameter("datepickerEnd"), 7);
		tb_odinfoxm.setDatepickerStr(betweenDate.get("datepickerStr"));
		tb_odinfoxm.setDatepickerEnd(betweenDate.get("datepickerEnd"));
		
		// 페이징 단위
		if(request.getParameter("pagerMaxPageItems") != null){
			tb_odinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			tb_odinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_odinfoxm.setRowCnt(20);
			tb_odinfoxm.setPagerMaxPageItems(20);	
		}
		
		//마스터 RFND_CON값 환불신청으로 수정
		
		/*
		 * tb_odinfoxm.setRFND_CON("RFND_CON_01");
		 * tb_odinfoxm.setORDER_CON("ORDER_CON_10");
		 */
		 

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");		
		// 로그인아이디
		tb_odinfoxm.setMEMB_ID(loginUser.getMEMB_ID());
		tb_odinfoxm.setMEMB_GUBN(loginUser.getMEMB_GUBN());
		tb_odinfoxm.setLOGIN_SUPR_ID(loginUser.getSUPR_ID());
		// 환불신청 상태의 목록
		tb_odinfoxm.setCount(orderRfndMgrService.getObjectCount(tb_odinfoxm));
		tb_odinfoxm.setLOGIN_SUPR_ID(loginUser.getSUPR_ID());
		tb_odinfoxm.setList(orderRfndMgrService.getPaginatedObjectList(tb_odinfoxm));
	
		
		model.addAttribute("obj", tb_odinfoxm);
		model.addAttribute("rowCnt", tb_odinfoxm.getRowCnt());
		model.addAttribute("totalCnt", tb_odinfoxm.getCount());
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(tb_odinfoxm.getSchGbn())
				+ "&schTxt="+StringUtil.nullCheck(tb_odinfoxm.getSchTxt())
				+ "&pagerMaxPageItems="+StringUtil.nullCheck(tb_odinfoxm.getPagerMaxPageItems())
				+ "&datepickerStr=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerStr())
				+ "&datepickerEnd=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerEnd())
				+ "&schParam=" + StringUtil.nullCheck(tb_odinfoxm.getSchParam())
				+"&ORDER_NUM=" + StringUtil.nullCheck(tb_odinfoxm.getORDER_NUM())
				+ "&PAY_METD=" + StringUtil.nullCheck(tb_odinfoxm.getPAY_METD());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderRfndMgr/list");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderRfndMgrController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 환불접수 상세
	 * @Company	: YT Corp.
	 * @Author	: chjw
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/form/{ORDER_NUM}" }, method=RequestMethod.GET)
	public ModelAndView edit(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		//주문M 정보
		TB_ODINFOXM od = (TB_ODINFOXM) orderService.getPayMdky(tb_odinfoxm);
		System.out.println("PAY_MDKY 주문키 : "+od.getPAY_MDKY());
		tb_odinfoxm.setMEMB_ID(loginUser.getMEMB_ID());
		
		tb_odinfoxm = (TB_ODINFOXM)orderMgrService.getMasterInfo(tb_odinfoxm);
		tb_odinfoxm.setLOGIN_SUPR_ID(loginUser.getSUPR_ID());
		tb_odinfoxm.setMEMB_GUBN(loginUser.getMEMB_GUBN());
		tb_odinfoxm.setMEMB_ID(loginUser.getMEMB_ID());
		//주문D 정보
		tb_odinfoxm.setList(orderRfndMgrService.getDetailsList(tb_odinfoxm));
		tb_odinfoxm.setMEMB_GUBN(loginUser.getMEMB_GUBN()); 
		//수취인 정보
		TB_ODINFOXM originInfo = new TB_ODINFOXM();
		originInfo.setORDER_NUM(tb_odinfoxm.getORDER_NUM());

		TB_ODDLAIXM tb_oddlaixm = (TB_ODDLAIXM)orderMgrService.getDeliveryInfo(originInfo);
		
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		model.addAttribute("tb_oddlaixm", tb_oddlaixm);
		model.addAttribute("login_supr_id", loginUser.getSUPR_ID());
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderRfndMgr/form");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderRfndMgrController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 환불상태 update
	 * @Company	: YT Corp.
	 * @Author	: chjw
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@Transactional
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView update(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODINFOXD tb_odinfoxd, HttpServletRequest request, SessionStatus status, Model model) throws Exception {
		// 세션변경
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setMODP_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setLOGIN_SUPR_ID(loginUser.getSUPR_ID()); 
		tb_odinfoxm.setLOGIN_SUPR_ID(loginUser.getSUPR_ID()); 
		tb_odinfoxd.setMEMB_GUBN(loginUser.getMEMB_GUBN());
		tb_odinfoxm.setMEMB_GUBN(loginUser.getMEMB_GUBN());
		
		String order_con=tb_odinfoxm.getORDER_CON();
		String rfnd_dlyv_amt = tb_odinfoxd.getRFND_DLVY_AMT(); 
		String rfnd_con=tb_odinfoxd.getRFND_CON();
		String[] order_num=tb_odinfoxd.getORDER_NUM().split(",");
		String[] rfnd_amt=tb_odinfoxd.getRFND_AMT().split(",");
		String[] pd_code=tb_odinfoxd.getPD_CODE().split(",");
		String[] supr_id =  tb_odinfoxd.getSUPR_ID().split(",");
		String[] option1_value =tb_odinfoxd.getOPTION1_VALUE().split(",");
		String[] option2_value =tb_odinfoxd.getOPTION2_VALUE().split(",");
		String[] option3_value =tb_odinfoxd.getOPTION3_VALUE().split(",");
		
		for(int i=0;i<pd_code.length;i++) {
			tb_odinfoxd.setORDER_NUM(order_num[i]);	
			tb_odinfoxd.setRFND_AMT(rfnd_amt[i]);	
			tb_odinfoxd.setPD_CODE(pd_code[i]);	
			tb_odinfoxd.setSUPR_ID(supr_id[i]);	
			tb_odinfoxd.setRFND_DLVY_AMT(rfnd_dlyv_amt);
			tb_odinfoxd.setORDER_CON(order_con);	
			tb_odinfoxd.setRFND_CON(rfnd_con);
			if(!option3_value[i].equals("-")) {
				tb_odinfoxd.setOPTION1_VALUE(option1_value[i]);
				tb_odinfoxd.setOPTION2_VALUE(option2_value[i]);
				tb_odinfoxd.setOPTION3_VALUE(option3_value[i]);
			}else if(!option2_value[i].equals("-")) {
				tb_odinfoxd.setOPTION1_VALUE(option1_value[i]);
				tb_odinfoxd.setOPTION2_VALUE(option2_value[i]);
				tb_odinfoxd.setOPTION3_VALUE("");
			}else if(!option1_value[i].equals("-")) {
				tb_odinfoxd.setOPTION1_VALUE(option1_value[i]);
				tb_odinfoxd.setOPTION2_VALUE("");
				tb_odinfoxd.setOPTION3_VALUE("");
			}else if(option1_value[i].equals("-")) {
				tb_odinfoxd.setOPTION1_VALUE("");
				tb_odinfoxd.setOPTION2_VALUE("");
				tb_odinfoxd.setOPTION3_VALUE("");
			}
			
			orderRfndMgrService.getDetailsUpdate(tb_odinfoxm, tb_odinfoxd);
		}
//		try {
//			// 주문상태 및 결제 정보 수정
//			int result = orderRfndMgrService.getDetailsUpdate(tb_odinfoxm);
//			if("RFND_CON_03".equals(tb_odinfoxm.getRFND_CON())) {
//				// 성공시, 애터미아자 API호출 (마이너스 수량 및 금액 전송)
//				if(result > 0) {
//					AtomyAzaAPI azapi = new AtomyAzaAPI();
//					azapi.Return_AtomyAza2(orderService, tb_odinfoxm.getORIGIN_NUM(), tb_odinfoxm.getORDER_NUM());
//					System.out.println(tb_odinfoxm.getORIGIN_NUM());
//					System.out.println(tb_odinfoxm.getORDER_NUM());
//					System.out.println("여기가 에러군?");
//				}
//			}
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderRfndMgr");		
		return new ModelAndView(redirectView);
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: pg취소
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 */
	@Transactional
	@RequestMapping(value={ "/pgCancel" }, method=RequestMethod.POST)
	public ModelAndView pgCancel(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODINFOXD tb_odinfoxd,  Model model, HttpServletRequest request) throws Exception {
		// 주문정보
		String order_con[]=tb_odinfoxm.getORDER_CON().split(",");
		String rfnd_dlyv_amt = tb_odinfoxd.getRFND_DLVY_AMT().replaceAll("\\,", "");
		String rfnd_con[]=tb_odinfoxd.getRFND_CON().split(",");
		String[] order_num=tb_odinfoxd.getORDER_NUM().split(",");
		String[] rfnd_amt=tb_odinfoxd.getRFND_AMT().split(",");
		String[] pd_code=tb_odinfoxd.getPD_CODE().split(",");
		String[] supr_id =  tb_odinfoxd.getSUPR_ID().split(",");
		String[] option1_value =tb_odinfoxd.getOPTION1_VALUE().split(",");
		String[] option2_value =tb_odinfoxd.getOPTION2_VALUE().split(",");
		String[] option3_value =tb_odinfoxd.getOPTION3_VALUE().split(",");
		
		TB_ODINFOXM od = (TB_ODINFOXM) orderService.getPayMdky(order_num[0]);
		System.out.println("PAY_MDKY 주문키 : "+od.getPAY_MDKY());
		// 세션변경
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setMODP_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setLOGIN_SUPR_ID(loginUser.getSUPR_ID()); 
		tb_odinfoxm.setLOGIN_SUPR_ID(loginUser.getSUPR_ID()); 
		tb_odinfoxd.setMEMB_GUBN(loginUser.getMEMB_GUBN());
		tb_odinfoxm.setMEMB_GUBN(loginUser.getMEMB_GUBN());
		
		int refundAmt1=0;
		
		for(int i=0; i<rfnd_amt.length; i++) {
			refundAmt1+=Integer.parseInt(rfnd_amt[i]);
		}
		
		int rfnd_dlyv_amt2=Integer.parseInt(rfnd_dlyv_amt);
		int refundAmt=refundAmt1-rfnd_dlyv_amt2;
		
		
		System.out.println("refundAmt 일단금액 : "+refundAmt);
		System.out.println("주문번호 D : "+tb_odinfoxd.getORDER_NUM());
		System.out.println("주문번호 M : "+tb_odinfoxm.getORDER_NUM());
		
		ModelAndView mav = new ModelAndView();
		
		
	
		String reason = "취소요청"; //취소사유
		String cancelAmt = refundAmt+""; //취소금액
		
		HttpHeaders headers = new HttpHeaders();
		 // headers.setBasicAuth(SECRET_KEY, ""); // spring framework 5.2 이상 버전에서 지원
        headers.set("Authorization", "Basic " + Base64.getEncoder().encodeToString((SECRET_KEY + ":").getBytes()));
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, String> payloadMap = new HashMap<>();
        payloadMap.put("cancelReason", reason); //취소사유
        payloadMap.put("cancelAmount", cancelAmt); //취소금액
	        
        				// 무통장일 경우 
					    if(tb_odinfoxm.getPAY_METD() == "SC0040") {
				        	Map<String, String> refundReceiveAccount = new HashMap<>();
					        	refundReceiveAccount.put("bank", "");                           // 환불받을 계좌 은행
					        	refundReceiveAccount.put("accountNumber", "");                  // 환불받을 계좌 번호 
					        	refundReceiveAccount.put("holderName", "");                     // 환불받을 계좌 예금주 
					        	payloadMap.put("refundReceiveAccount", refundReceiveAccount.toString());
					    }
	    
	        HttpEntity<String> request1 = new HttpEntity<>(objectMapper.writeValueAsString(payloadMap), headers);

	        ResponseEntity<JsonNode> responseEntity = restTemplate.postForEntity("https://api.tosspayments.com/v1/payments/"+od.getPAY_MDKY()+"/cancel", request1, JsonNode.class);
	        if (responseEntity.getStatusCode() == HttpStatus.OK) {
	            JsonNode successNode = responseEntity.getBody();
	            System.out.println("successNode : " + successNode);
	            JSONObject jsonNode = new JSONObject(successNode.toString());
	            
	            Object paymentKey = jsonNode.get("paymentKey");
	            Object status = jsonNode.get("status");
	            Object requestedAt = jsonNode.get("requestedAt");
	            Object approvedAt = jsonNode.get("approvedAt");
	            Object method = jsonNode.get("method");
	            Object totalAmount = jsonNode.get("totalAmount");
	            Object balanceAmount = jsonNode.get("balanceAmount");
	            JSONObject card = new JSONObject(jsonNode.get("card").toString());
	            Object approveNo = card.get("approveNo");
	            System.out.println("cancels : " + jsonNode.get("cancels").toString());
	            JSONArray cancelsArr = new JSONArray(jsonNode.get("cancels").toString());
	            JSONObject cancels = cancelsArr.getJSONObject(0);
	            Object cancelAmount = cancels.get("cancelAmount");
	            Object refundableAmount = cancels.get("refundableAmount");
	            
	            try {
	            	for(int i=0;i<pd_code.length;i++) {
	        			tb_odinfoxd.setORDER_NUM(order_num[i]);	
	        			tb_odinfoxd.setRFND_AMT(rfnd_amt[i]);	
	        			tb_odinfoxd.setPD_CODE(pd_code[i]);	
	        			tb_odinfoxd.setSUPR_ID(supr_id[i]);	
	        			tb_odinfoxd.setRFND_DLVY_AMT(rfnd_dlyv_amt);
	        			tb_odinfoxd.setORDER_CON(order_con[0]);	
	        			tb_odinfoxd.setRFND_CON(rfnd_con[0]);
	        			if(!option3_value[i].equals("-")) {
	        				tb_odinfoxd.setOPTION1_VALUE(option1_value[i]);
	        				tb_odinfoxd.setOPTION2_VALUE(option2_value[i]);
	        				tb_odinfoxd.setOPTION3_VALUE(option3_value[i]);
	        			}else if(!option2_value[i].equals("-")) {
	        				tb_odinfoxd.setOPTION1_VALUE(option1_value[i]);
	        				tb_odinfoxd.setOPTION2_VALUE(option2_value[i]);
	        				tb_odinfoxd.setOPTION3_VALUE("");
	        			}else if(!option1_value[i].equals("-")) {
	        				tb_odinfoxd.setOPTION1_VALUE(option1_value[i]);
	        				tb_odinfoxd.setOPTION2_VALUE("");
	        				tb_odinfoxd.setOPTION3_VALUE("");
	        			}else if(option1_value[i].equals("-")) {
	        				tb_odinfoxd.setOPTION1_VALUE("");
	        				tb_odinfoxd.setOPTION2_VALUE("");
	        				tb_odinfoxd.setOPTION3_VALUE("");
	        			}
	        			
	        			orderRfndMgrService.getDetailsUpdate(tb_odinfoxm, tb_odinfoxd);
	        		}
	            	 
				    //결제 로그 처리
			    	TB_LGUPLUS tb_lguplus = new TB_LGUPLUS(); 
			    	
			    	tb_lguplus.setLGD_TID(paymentKey.toString()); 					//결과 코드 
				    tb_lguplus.setLGD_OID(tb_odinfoxm.getORDER_NUM());
				    tb_lguplus.setGUBUN("CANCEL");
				    tb_lguplus.setLGD_RESPCODE("0000"); 							// 응답 코드 
				    tb_lguplus.setLGD_RESPMSG("결제 취소");  							// 응답 메시지 
				    tb_lguplus.setLGD_PAYTYPE(method.toString());					// 결제 방식 
				    tb_lguplus.setSTATE(status.toString()); 						// 상태?
				    tb_lguplus.setLGD_AMOUNT(cancelAmount.toString()); 				// 금액
				    System.out.println("결제 취소 금액 : cancelAmount : "+cancelAmount);
				    System.out.println("결제 취소 금액 : " +( Integer.parseInt(totalAmount.toString()) - Integer.parseInt(balanceAmount.toString()))+"");
				    if(tb_lguplus.getLGD_TID() != null) {
						orderService.lguplusLogInsert(tb_lguplus);
				   	}
				}catch(Exception e){
					logger.info("LgUplus Logging Error : " + e.toString());
				}
	        } else {
	        	 JsonNode failNode = responseEntity.getBody();
	             model.addAttribute("message", failNode.get("message").asText());
	             model.addAttribute("code", failNode.get("code").asText());
	             mav.addObject("alertMessage", "결제 취소가 실패하였습니다.");
	 			 mav.addObject("returnUrl", "/adm/orderMgr");
	 			 mav.setViewName("alertMessage");
	 			 return mav;
	        }
	        
	        
		mav.addObject("responseEntity", responseEntity);
		mav.addObject("returnUrl", servletContextPath.concat("/adm/orderMgr"));
		mav.addObject("alertMessage", "결제 취소를 완료하였습니다.");
		mav.setViewName("alertMessage");
		return mav;
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderRfndMgrController.java
	 * @Method	: partialCancel
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: Xpay 부분취소 -- 추후개발
	 * @Company	: YT Corp.
	 * @Author	: chjw
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/partialCancel" }, method=RequestMethod.GET)
	public ModelAndView getPartialCancel(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODINFOXD tb_odinfoxd, HttpServletRequest request, Model model) throws Exception {
		// 부분취소 가능한지 체크

		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderRfndMgr/form/"+tb_odinfoxm.getORDER_NUM());		
		return new ModelAndView(redirectView);
	}
	@RequestMapping(value={ "/partialCancel" }, method=RequestMethod.POST)
	public ModelAndView partialCancel(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODINFOXD tb_odinfoxd, HttpServletRequest request, Model model) throws Exception {
		//세션변경
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		ModelAndView mav = new ModelAndView();
		// 환불승인건만 로직타야됨
		try {
			//orderService.insertRefund(tb_odinfoxm, tb_odinfoxd);
			mav.addObject("alertMessage", "결제취소가 완료되었습니다.");
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("alertMessage", "결제취소요청이 실패하였습니다.");
		}
		
		mav.addObject("returnUrl", servletContextPath.concat("/adm/orderRfndMgr/form/" + tb_odinfoxd.getORDER_NUM()));
		mav.setViewName("alertMessage");

		return mav;
	}
	
	
	
	
}
