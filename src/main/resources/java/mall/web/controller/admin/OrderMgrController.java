package mall.web.controller.admin;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import lgdacom.XPayClient.XPayClient;
import mall.common.util.ExcelDownload;
import mall.common.util.FileUtil;
import mall.common.util.StringUtil;
import mall.common.util.excel.ExcelRead;
import mall.common.util.excel.ExcelReadOption;
import mall.web.apiLink.AtomyAzaAPI;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_LGUPLUS;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_SPINFOXM;
import mall.web.domain.XTB_ODINFOXM;
import mall.web.service.admin.impl.OrderMgrService;
import mall.web.service.admin.impl.SupplierMgrService;
import mall.web.service.common.CommonService;
import mall.web.service.mall.OrderService;

@Controller
@RequestMapping(value="/adm/orderMgr")
public class OrderMgrController extends DefaultController{
	
	@Autowired
	private Environment environment;

	@Resource(name="orderMgrService")
	OrderMgrService orderMgrService;
	
	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="orderService")
	OrderService orderService;

	@Resource(name="supplierMgrService")
	SupplierMgrService supplierMgrService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문내역 조회
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-13 (오후 03:48:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model,HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_odinfoxm.setMEMB_GUBN(loginUser.getMEMB_GUBN());
		tb_odinfoxm.setLOGIN_SUPR_ID(loginUser.getSUPR_ID());
		System.out.println("로그인유저 MEMB_GUBN?:"+loginUser.getMEMB_GUBN());
		System.out.println("로그인유저 SURP_ID?:"+loginUser.getSUPR_ID());
		
		// 페이징 단위
		if(request.getParameter("pagerMaxPageItems") != null){
			tb_odinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			tb_odinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_odinfoxm.setRowCnt(20);
			tb_odinfoxm.setPagerMaxPageItems(20);
		}
		
		
		
		tb_odinfoxm.setCount(orderMgrService.getObjectCount(tb_odinfoxm));
		tb_odinfoxm.setList(orderMgrService.getPaginatedObjectList(tb_odinfoxm));
		
		model.addAttribute("obj", tb_odinfoxm);
		model.addAttribute("rowCnt", tb_odinfoxm.getRowCnt());
		model.addAttribute("totalCnt", tb_odinfoxm.getCount());
				
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(tb_odinfoxm.getSchGbn())
				+ "&schTxt="+StringUtil.nullCheck(tb_odinfoxm.getSchTxt()
				+ "&pagerMaxPageItems="+StringUtil.nullCheck(tb_odinfoxm.getPagerMaxPageItems())
				+ "&datepickerStr=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerStr())
				+ "&datepickerEnd=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerEnd())
				+ "&ORDER_CON=" + StringUtil.nullCheck(tb_odinfoxm.getORDER_CON())
				+ "&PAY_METD=" + StringUtil.nullCheck(tb_odinfoxm.getPAY_METD())
				+ "&ORDER_GUBUN=" + StringUtil.nullCheck(tb_odinfoxm.getORDER_GUBUN())
				+ "&DATE_ORDER=" + StringUtil.nullCheck(tb_odinfoxm.getDATE_ORDER())
				+ "&MEMB_NM_ORDER=" + StringUtil.nullCheck(tb_odinfoxm.getMEMB_NM_ORDER())
				+ "&COM_NAME_ORDER=" + StringUtil.nullCheck(tb_odinfoxm.getCOM_NAME_ORDER())
				+ "&PAY_DATE_ORDER=" + StringUtil.nullCheck(tb_odinfoxm.getPAY_DATE_ORDER())
				+ "&DLAR_DATE_ORDER=" + StringUtil.nullCheck(tb_odinfoxm.getDLAR_DATE_ORDER()));
				
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderMgr/list");
	}

	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문상세정보(form)
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-13 (오후 07:48:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/form/{ORDER_NUM}" }, method=RequestMethod.GET)
	public ModelAndView edit(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model, HttpServletRequest request) throws Exception {
		
		// 로그인 유저 정보
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		
		// 사용자의 업체코드
		model.addAttribute("login_supr_id", loginUser.getSUPR_ID());
		
		//배송비 조건
		TB_SPINFOXM tb_spinfoxm = new TB_SPINFOXM();
		tb_spinfoxm.setSUPR_ID("C00001");	//C00003
		model.addAttribute("tb_spinfoxm", (TB_SPINFOXM)supplierMgrService.getObject(tb_spinfoxm));
		
		//주문 정보
		tb_odinfoxm = (TB_ODINFOXM)orderMgrService.getMasterInfo(tb_odinfoxm);
		tb_odinfoxm.setList(orderMgrService.getDetailsList(tb_odinfoxm));
		
		//배송지 정보
		TB_ODDLAIXM tb_oddlaixm = new TB_ODDLAIXM();
		tb_oddlaixm = (TB_ODDLAIXM)orderMgrService.getDeliveryInfo(tb_odinfoxm);
		
		// 업체 정보 불러오기
		List<HashMap<String, String>> pd_supr_list = (List<HashMap<String, String>>) orderMgrService.getPdSuprList(tb_odinfoxm); 
		//pd_supr_list = (TB_SPINFOXM)orderMgrService.getPdSuprList(tb_odinfoxm);
		model.addAttribute("pd_supr_list", pd_supr_list);
		
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		model.addAttribute("tb_oddlaixm", tb_oddlaixm);
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderMgr/form");
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
	@RequestMapping(value={ "/pgCancel" }, method=RequestMethod.POST)
	public ModelAndView pgCancel(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model, HttpServletRequest request) throws Exception {
		// 주문정보
		TB_ODINFOXM od = (TB_ODINFOXM) orderService.getPayMdky(tb_odinfoxm);

		ModelAndView mav = new ModelAndView();
		Map<String,String> payResMap = new HashMap<String,String>();
		
    	boolean bState = false;
    	String STATE ="";
    	String PAY_METD = od.getPAY_METD();
    	
		// 결제 정보가 있을경우
		if(StringUtils.isNotEmpty( od.getPAY_MDKY() ) ){

		    /*
		     * [결제취소 요청 페이지]
		     *
		     * LG유플러스으로 부터 내려받은 거래번호(LGD_TID)를 가지고 취소 요청을 합니다.(파라미터 전달시 POST를 사용하세요)
		     * (승인시 LG유플러스으로 부터 내려받은 PAYKEY와 혼동하지 마세요.)
		     */ 
		    String CST_PLATFORM		= environment.getRequiredProperty("lguplus.cst_platform");		//LG유플러스 결제서비스 선택(test:테스트, service:서비스)
		    String CST_MID				= environment.getRequiredProperty("lguplus.cst_mid");			//LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요.
		    String LGD_MID				= ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  		//테스트 아이디는 't'를 제외하고 입력하세요.
		    																															//상점아이디(자동생성)
		    String LGD_TID				= od.getPAY_MDKY();                      									//LG유플러스으로 부터 내려받은 거래번호(LGD_TID)

			/* 
			 * ※ 중요
			 * 환경설정 파일의 경우 반드시 외부에서 접근이 가능한 경로에 두시면 안됩니다.
			 * 해당 환경파일이 외부에 노출이 되는 경우 해킹의 위험이 존재하므로 반드시 외부에서 접근이 불가능한 경로에 두시기 바랍니다. 
			 * 예) [Window 계열] C:\inetpub\wwwroot\lgdacom ==> 절대불가(웹 디렉토리)
			 */
		    String configPath 			= environment.getRequiredProperty("lguplus.configPath");	//LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf") 위치 지정.
		        
		    LGD_TID     					= ( LGD_TID == null )?"":LGD_TID; 
		    
		    XPayClient xpay = new XPayClient();
		    xpay.Init(configPath, CST_PLATFORM);
		    xpay.Init_TX(LGD_MID);
		    xpay.Set("LGD_TXNAME", "Cancel");
		    xpay.Set("LGD_TID", LGD_TID);
		 
		    /*
		     * 1. 결제취소 요청 결과처리
		     *
		     * 취소결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
			 *
			 * [[[중요]]] 고객사에서 정상취소 처리해야할 응답코드
			 * 1. 신용카드 : 0000, AV11  
			 * 2. 계좌이체 : 0000, RF00, RF10, RF09, RF15, RF19, RF23, RF25 (환불진행중 응답건-> 환불결과코드.xls 참고)
			 * 3. 나머지 결제수단의 경우 0000(성공) 만 취소성공 처리
			 *
		     */
		    if (xpay.TX()) {
		        //1)결제취소결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
		    	boolean isXpayOK = false;
		    	
		    	// 신용카드
		    	if("SC0010".equals(PAY_METD)){
		    		// 취소 정상 승인
		    		if("0000".equals( xpay.m_szResCode ) || "AV11".equals( xpay.m_szResCode )) {
		    			mav.addObject("alertMessage", "[" + xpay.m_szResCode + "] " + "결제 취소요청이 완료되었습니다.");
		    			isXpayOK = true;
		    		}
	    		// 계좌이체
		    	} else if("SC0030".equals(PAY_METD)){
		    		// 환불 정상 승인
		    		if( "0000".equals( xpay.m_szResCode ) || "RF00".equals( xpay.m_szResCode )) {
		    			mav.addObject("alertMessage", "[" + xpay.m_szResCode + "] " + "환불이 정상 처리되었습니다.");
		    			isXpayOK = true;
		    		}
		    		
		    		// 환불 진행중 승인
		    		if( "RF10".equals( xpay.m_szResCode ) || "RF09".equals( xpay.m_szResCode ) || 
		    			"RF15".equals( xpay.m_szResCode ) || "RF19".equals( xpay.m_szResCode ) || 
		    			"RF23".equals( xpay.m_szResCode ) || "RF25".equals( xpay.m_szResCode )) {
		    			mav.addObject("alertMessage", "[" + xpay.m_szResCode + "] " + "환불이 요청되었습니다. 환불진행중입니다.");
		    			isXpayOK = true;
		    		}
	    		// 기타 결제
		    	} else {
		    		if("0000".equals( xpay.m_szResCode )) {
		    			mav.addObject("alertMessage", "결제 취소요청이 완료되었습니다.");
		    			isXpayOK = true;
		    		}
		    	}
		    	
		    	
		    	if(isXpayOK) {
		    		tb_odinfoxm.setORDER_CON("ORDER_CON_04");		// 주문취소
					tb_odinfoxm.setCNCL_CON("CNCL_CON_03");			// 취소완료
					
					try{
						if (orderService.cancelObject(tb_odinfoxm) > 0){
							orderService.orderPayUpdateDtl(tb_odinfoxm);
							
							// 애터미아자 API 호출 (결제완료, 배송완료, 주문취소, 환불)
							AtomyAzaAPI azapi = new AtomyAzaAPI();
							azapi.Cancel_AtomyAza(orderService, tb_odinfoxm.getORDER_NUM());
							
						} 
						bState = isXpayOK;
	        			STATE = "OK";
	        			
					} catch(Exception e){
	        			// data : null 이면 주문 실패처리
	        			STATE = "결제취소완료, 상점 DB처리 실패.";
	        		}
		    	} else {
					//통신상의 문제 발생(최종결제요청 결과 실패 DB처리)
		    		mav.addObject("alertMessage", "결제 취소요청이 실패하였습니다.\n  - TX Response_code = " + xpay.m_szResCode + " - \nTX Response_msg = " + xpay.m_szResMsg);
					payResMap.put("msg08" , "최종결제요청 결과 실패, DB처리하시기 바랍니다.<br>");
        			STATE = "최종결제요청 결과 실패, DB처리하시기 바랍니다.";
				}
		    	
		    }else {
		        //2)API 요청 실패 화면처리
		    	mav.addObject("alertMessage", "결제 취소요청이 실패하였습니다.\n  - TX Response_code = " + xpay.m_szResCode + " - \nTX Response_msg = " + xpay.m_szResMsg);
		    	STATE = "결제취소요청실패, API 요청 실패.";
		    }

		    try {
			    //결제 로그 처리
		    	TB_LGUPLUS tb_lguplus = new TB_LGUPLUS();
			    tb_lguplus.setLGD_TID(LGD_TID);
			    tb_lguplus.setLGD_OID(tb_odinfoxm.getORDER_NUM());
			    tb_lguplus.setGUBUN("CANCEL");
			    tb_lguplus.setLGD_RESPCODE(xpay.m_szResCode);
			    tb_lguplus.setLGD_RESPMSG(xpay.m_szResMsg);
			    tb_lguplus.setLGD_PAYTYPE(PAY_METD);
			    tb_lguplus.setSTATE(STATE);
			    
			    if(tb_lguplus.getLGD_TID() != null) {
					orderService.lguplusLogInsert(tb_lguplus);
			    }
				
			}catch(Exception e){
				
			}
		    
		}else{
			mav.addObject("alertMessage", "PG사 결제정보가 없습니다. 결제수단을 확인해주세요.");
		}
		
		mav.addObject("payResMap", payResMap);
		mav.addObject("returnUrl", servletContextPath.concat("/adm/orderMgr/form/" + tb_odinfoxm.getORDER_NUM()));
		mav.setViewName("alertMessage");
		
		return mav;
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문 및 결제정보 수정
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-15 (오후 6:08:29)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView update(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODDLAIXM tb_oddlaixm, @ModelAttribute TB_ODINFOXD tb_odinfoxd
			, BindingResult result, SessionStatus status, Model model) throws Exception {
		// 등록자 정보 변경필요
		tb_odinfoxm.setMODP_ID("admin");
		tb_oddlaixm.setMODP_ID("admin");
		
		String[] ordsplit = tb_odinfoxd.getORDER_DTNUM().split(",");
		String[] ordqtysplit =  tb_odinfoxm.getORDER_QTY().split(",");
		String[] ordloginsuprsplit =  tb_odinfoxd.getLOGIN_SUPR_ID().split(",");
		String[] ordsuprsplit =  tb_odinfoxd.getSUPR_ID().split(",");
		String[] dtldlvytdn =  tb_odinfoxd.getDTL_DLVY_TDN().split(",");
				
		
		for(int i= 0; i<ordsplit.length;i++){
			tb_odinfoxd.setORDER_DTNUM(ordsplit[i]);
			tb_odinfoxd.setORDER_QTY(ordqtysplit[i]);
			tb_odinfoxd.setSUPR_ID(ordsuprsplit[i]);
			tb_odinfoxd.setLOGIN_SUPR_ID(ordloginsuprsplit[i]);
			
			if(dtldlvytdn.length == 0 || dtldlvytdn.length < i+1)
				tb_odinfoxd.setDTL_DLVY_TDN("");
			else
				tb_odinfoxd.setDTL_DLVY_TDN(dtldlvytdn[i]);
			
			// 주문수량 및 가격 변경
			if(ordloginsuprsplit[i].equals(ordsuprsplit[i]) || ordsuprsplit[i].equals("C00001")){	//로그인유저 공급사 + c00001 상품도 같이 관리한다
				orderMgrService.updateDatailQty(tb_odinfoxd);		// 라온마켓 주문처리
			}
			else
				orderMgrService.updateDatailQtyLink(tb_odinfoxd);	// 라온마켓(iibs) 이외의 주문처리
			
			orderMgrService.updateMasterQty(tb_odinfoxm);	
		}
		
		//주문상태 및 결제 정보 수정
		orderMgrService.getDetailsUpdate(tb_odinfoxm,tb_oddlaixm);
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderMgr/form/"+tb_odinfoxm.getORDER_NUM());		
		return new ModelAndView(redirectView);
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: getState
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문상태 변경
	 * @Company	: YT Corp.
	 * @Author	: CHJW 
	 * @Date	: 2020-03-31 (오전 10:16:29)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param model
	 * @param arrayParams
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/state", method=RequestMethod.POST)
	public ModelAndView getState(TB_ODINFOXM tb_odinfoxm, Model model, HttpServletRequest request,
			@RequestParam(value="stateArray", defaultValue="") List<String> arrayParams) throws Exception{
		// 관리자 계정 정보
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");		
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		for(String obj : arrayParams){
			tb_odinfoxm.setORDER_NUM(obj);
			if( orderMgrService.updateState(tb_odinfoxm) > 0 ) {        		
        		//주문디테일 처리
        		orderService.orderPayUpdateDtl(tb_odinfoxm);

        		// 애터미아자 상품주문 API (결제완료, 배송완료, 주문취소, 환불)
        		try{
        			// 결제완료시 애터미아자 주문상태 전달
        	        if(tb_odinfoxm.getORDER_CON() != null && (tb_odinfoxm.getORDER_CON()).equals("ORDER_CON_02")){
        	        	AtomyAzaAPI azapi = new AtomyAzaAPI();
        	        	azapi.Order_AtomyAza(orderService, tb_odinfoxm.getORDER_NUM());
        			}
        		}
        		catch(Exception e){
        			// data : null 이면 처리할것
        			// 주문 실패처리
        		}        		
        	}
		}
				
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderMgr");		
		return new ModelAndView(redirectView);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: getPickingList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 피킹리스트
	 * @Company	: YT Corp.
	 * @Author	: LEE HEE SUN (hslee@youngthink.co.kr)
	 * @Date	: 2018-04-12 (오후 6:08:29)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/picking",method=RequestMethod.GET)
	public ModelAndView getPickingList(TB_ODINFOXM tb_odinfoxm, Model model
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		tb_odinfoxm.setList(arrayParams);
		
		if(tb_odinfoxm.getORDER_GUBUN()!=null && tb_odinfoxm.getORDER_GUBUN().equals("goods")){
			model.addAttribute("objList", orderMgrService.getPickingGoodsList(tb_odinfoxm));
		}else if (tb_odinfoxm.getORDER_GUBUN()!=null && tb_odinfoxm.getORDER_GUBUN().equals("com")){
			model.addAttribute("objList", orderMgrService.getPickingComList(tb_odinfoxm));
		}else if(tb_odinfoxm.getORDER_GUBUN()!=null && tb_odinfoxm.getORDER_GUBUN().equals("car")){
			model.addAttribute("objList", orderMgrService.getPickingCarList(tb_odinfoxm));
		}else{
			model.addAttribute("objList", orderMgrService.getPickingList(tb_odinfoxm));
		}
		model.addAttribute("today",new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderMgr/list");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: getPickingList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문내역 상세 및 주문상태/결제정보 저장
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-15 (오후 6:08:29)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/pickingUpdate",method=RequestMethod.GET)
	public ModelAndView pickingUpdate(TB_ODINFOXM tb_odinfoxm, Model model
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception{
		ModelAndView mav = new ModelAndView();
		//주문상태 및 결제 정보 수정
		tb_odinfoxm.setList(arrayParams);		
		List<?> pickingList = orderMgrService.getPickingList(tb_odinfoxm);
		
		for(int i=0;i<pickingList.size();i++){	//여기서 업데이트
			String num = ((TB_ODINFOXM)pickingList.get(i)).getORDER_NUM();
		
			orderMgrService.updatePickingList(num);
		}
				
		return new ModelAndView("admin.layout", "jsp", "admin/orderMgr/list");
	}
	
	// 주문내역 엑셀
	@RequestMapping(value={ "/excelDown" }, method=RequestMethod.GET)
	public void getExcelList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model,HttpServletRequest request,HttpServletResponse response
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {
		
		String[] headerName = {"주문일자","결제시간", "주문번호","주문자명", "사업자번호", "사업자상호", "주문상품","총 결제금액","배송료","상품주문금액","주문상태 결제수단","출고방식","고객배송 요청사항","배송참조사항(관리자기록)"};
		String[] columnName = {"ORDER_DATE","PAY_DTM","ORDER_NUM","MEMB_NM", "COM_BUNB","COM_NAME", "PD_NAME","ORDER_AMT","DLVY_AMT","REAL_AMT","ORDER_CON_NM","DLAR_GUBN","DLVY_MSG","ADM_REF"};

		String sheetName = "주문내역";
		
		String[] chkArray = request.getParameter("CHK_ORD_LIST").split(",");
		// String[] -> List
        List<String> stringList = Arrays.asList(chkArray);
		tb_odinfoxm.setList(stringList);
		
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_odinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));	//페이징 단위 : 50
			tb_odinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_odinfoxm.setRowCnt(20);	//페이징 단위 : 20
			tb_odinfoxm.setPagerMaxPageItems(20);
		}

		List<HashMap<String, String>> list = (List<HashMap<String, String>>) orderMgrService.getExcelList(tb_odinfoxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);		
	}
	
	// 주문상세내역 엑셀
	@RequestMapping(value={ "/detailExcelDown" }, method=RequestMethod.GET)
	public void getDetailExcelList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model,HttpServletResponse response
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {
		
		String[] headerName = {"주문번호", "외부주문번호","주문일자", "사업자상호", "사업자번호","주문자","배송비결재여부", "공급자","상품코드", "바코드","상품명","세절방식","색상","과면세구분","수량","정상가","할인금액","단가","가격", "택배사", "운송장번호"};
		String[] columnName = {"ORDER_NUM", "LINK_ORDER_KEY", "ORDER_DATE", "COM_NAME", "COM_BUNB", "MEMB_NM","DAP_YN", "SUPR_NAME", "PD_CODE","PD_BARCD","PD_NAME","PD_CUT_SEQ","OPTION_NAME","TAX_GUBN","ORDER_QTY","PD_PRICE"
											,"PDDC_VAL","ORDER_PREICE","ORDER_AMT", "DLVY_COM", "DLVY_TDN"};

		String sheetName = "주문내역상세";
		
		tb_odinfoxm.setList(arrayParams);

		List<HashMap<String, String>> list = (List<HashMap<String, String>>) orderMgrService.getDetailExcelList(tb_odinfoxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);		
	}
	
	@RequestMapping(value={ "/pickingExcelDown" }, method=RequestMethod.GET)
	public void getpickingExcelList(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model,HttpServletResponse response
			,@RequestParam(value="checkArray", defaultValue="") List<String> arrayParams) throws Exception{
		
		tb_odinfoxm.setList(arrayParams);
		
		List<HashMap<String, String>> list =null;
		String[] headerName = null;
		String[] columnName = null;
		String sheetName = "피킹리스트";
		
		if(tb_odinfoxm.getORDER_GUBUN()!=null && tb_odinfoxm.getORDER_GUBUN().equals("goods")){
			list= (List<HashMap<String, String>>)orderMgrService.getPickingGoodsExcel(tb_odinfoxm);
			headerName = new String[]{"상품코드", "상품명", "규격", "입수", "주문수량","바코드","배송구분"};
			columnName = new String[]{"PD_CODE","PD_NAME", "PD_STD", "INPUT_CNT","ORDER_QTY", "PD_BARCD", "DLVY_GUBN"};
			sheetName = "피킹리스트(상품별)";
		}else if (tb_odinfoxm.getORDER_GUBUN()!=null && tb_odinfoxm.getORDER_GUBUN().equals("com")){
			list= (List<HashMap<String, String>>)orderMgrService.getPickingComExcel(tb_odinfoxm);
			headerName = new String[]{"상품코드", "매출처명", "상품명", "규격", "입수", "주문수량","바코드","배송구분"};
			columnName = new String[]{"PD_CODE","COM_ORD","PD_NAME", "PD_STD", "INPUT_CNT","ORDER_QTY", "PD_BARCD", "DLVY_GUBN"};
			sheetName = "피킹리스트(매출처별)";
		}else if(tb_odinfoxm.getORDER_GUBUN()!=null && tb_odinfoxm.getORDER_GUBUN().equals("car")){
			list= (List<HashMap<String, String>>)orderMgrService.getPickingCarExcel(tb_odinfoxm);
			headerName = new String[]{"상품코드","차량별" ,"매출처명", "상품명", "규격", "입수", "주문수량","바코드","배송구분"};
			columnName = new String[]{"PD_CODE","CAR_NUM_NM","COM_ORD","PD_NAME", "PD_STD", "INPUT_CNT","ORDER_QTY", "PD_BARCD", "DLVY_GUBN"};
			sheetName = "피킹리스트(차량별)";
		}else{
			//list= (List<HashMap<String, String>>)orderMgrService.getPickingExcel(tb_odinfoxm);
			headerName = new String[]{"순번", "상품명", "규격", "입수", "주문수량","바코드","배송구분"};
			columnName = new String[]{"PD_CODE","PD_NAME", "PD_STD", "INPUT_CNT","ORDER_QTY", "PD_BARCD", "DLVY_GUBN"};
		}
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);		
	}
	
	// 운송장 양식 조회
	@RequestMapping(value={ "/DlvyTdnExcelDown" }, method=RequestMethod.GET)
	public void getDlvyTdnExcelDown(Model model, HttpServletResponse response, HttpServletRequest request
			,@RequestParam("DLVY_TDN_ORDERNUM") String dlvy_tdn_ordernum) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		
		String[] headerName = {"주문번호", "주문상세번호","상품코드","상품명","수량","주문자","주소", "배송업체", "송장번호", "배송메세지", "전화번호"};
		String[] columnName = {"ORDER_NUM","ORDER_DTNUM","PD_CODE","PD_NAME","ORDER_QTY","ORDER_MEM_NM","ORDER_ADDR", "DLVY_COM","DLVY_TDN", "DLVY_MSG", "RECV_TELN"};
		
		String sheetName = "주문내역";		
		
		//List<String> order_list = Arrays.asList(dlvy_tdn_ordernum.split(","));
		
		TB_ODINFOXD od = new TB_ODINFOXD(); 
		
		od.setObj(Arrays.asList(dlvy_tdn_ordernum.split(",")));
		od.setSUPR_ID(loginUser.getSUPR_ID());
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) orderMgrService.getDlvyTdnlExcelList(od);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);		
	}	
	
	// 주문정보 엑셀 조회 (신규)
	@RequestMapping(value={ "/OrderExcelDown" }, method=RequestMethod.GET)
	public void getOrderExcelDown(Model model, HttpServletResponse response, HttpServletRequest request
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		
		String[] headerName = {"주문일자", "결제시간", "주문번호", "상품바코드", "주문상품", "판매수량","제품단가", "배송료", "총결제금액", "주문상태 결제수단", "고객배송 요청사항","구매자명","수령자명","주소", "구매자전화번호", "수령자전화번호", "운송장번호", "송장전송일", "택배사"};
		String[] columnName = {"ORDER_DATE", "PAY_DTM" ,"ORDER_NUM", "PD_BARCD","PD_NAME","ORDER_QTY","PD_PRICE", "DLVY_AMT", "ORDER_AMT", "PAY_METD", "DLVY_MSG","MEMB_NAME", "RECV_PERS","ORDER_ADDR", "MEMB_TEL", "RECV_TEL", "DLVY_TDN", "DLVY_TDN_MODP_DATE", "DLVY_COM_NM"};
		
		String sheetName = "주문내역(애터미)";		
		
		TB_ODINFOXD od = new TB_ODINFOXD(); 
		
		String[] chkArray = request.getParameter("CHK_ORD_LIST").split(",");
		List<String> stringList = Arrays.asList(chkArray);
		od.setObj(stringList);
		
		//od.setObj(Arrays.asList(dlvy_tdn_ordernum.split(",")));
		od.setSUPR_ID(loginUser.getSUPR_ID());
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) orderMgrService.getOrderExcelList(od);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);		
	}	
			
	
	@RequestMapping(value={ "/deleteOrdList" }, method=RequestMethod.POST)
	public ModelAndView deleteOrdList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model,HttpServletResponse response
			,HttpServletRequest request) throws Exception {
		// 관리자 로그인 계정
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");		
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		String str1 = request.getParameter("ORD_DELETE_LIST");
        String[] words = str1.split(",");
         
        for (String wo : words ){
    		orderMgrService.deleteOrdList(wo);
    		orderMgrService.deleteOrdDetail(wo);
        }			
        
        RedirectView rv = new RedirectView(servletContextPath.concat("/adm/orderMgr"));
		return new ModelAndView(rv);		
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: excelDlvyUpload
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 운송장번호 엑셀 업로드
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 2020-0420
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/excelDlvyUpload",method=RequestMethod.POST)
	public ModelAndView excelDlvyUpload(HttpServletRequest request, Model model, MultipartHttpServletRequest multipartRequest) throws Exception{
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		List<TB_ODINFOXD> list = null;
		TB_ODINFOXD tb_odinfoxd = new TB_ODINFOXD();
		
		tb_odinfoxd.setMODP_ID(loginUser.getMEMB_ID()); 
		
		MultipartFile excelFile =multipartRequest.getFile("EXCEL_FILE");
		
        if(excelFile==null || excelFile.isEmpty()){
            throw new RuntimeException("엑셀파일을 선택 해 주세요.");
        }
        
		if ( StringUtils.isNotEmpty(excelFile.getOriginalFilename()) ) {
			String saveFileName = FileUtil.saveFile2(request, excelFile, "jundan/tmp", false);
			String savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/jundan/tmp" + File.separator;

	        File destFile = new File(savePath+saveFileName);
	        
	        try{
	            excelFile.transferTo(destFile);
	        }catch(IllegalStateException | IOException e){
	            throw new RuntimeException(e.getMessage(),e);
	        }
	        
	        //Service 단에서 가져온 코드 
	        ExcelReadOption excelReadOption = new ExcelReadOption();
	        excelReadOption.setFilePath(destFile.getAbsolutePath());
	        excelReadOption.setOutputColumns("A","B","C","D","E","F","G","H","I","J","K");
	        excelReadOption.setStartRow(2);
	        	        
	        List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);

			if (excelReadOption.getNumCellCnt() != 11) {
				ModelAndView mav = new ModelAndView();
				
				mav.addObject("alertMessage", "엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식을 재 다운로드 해주시기 바랍니다.");
				mav.addObject("returnUrl", "back");
				mav.setViewName("alertMessage");
				return mav;
			}
			
	        try{
	        	list = orderMgrService.excelDlvyUpload(tb_odinfoxd, excelContent);
	        	
	        }catch(SQLException e){
	        	ModelAndView mav = new ModelAndView();			
				mav.addObject("alertMessage", e.getStackTrace()+"\n엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식 다운로드 후 다시 저장하세요.");
				mav.addObject("returnUrl", "back");
				mav.setViewName("alertMessage");
				return mav;
	        }
		}
				
		List<TB_ODINFOXD> successlist = new ArrayList<>();
		List<TB_ODINFOXD> errorlist = new ArrayList<>();
		
		// -1 : 실패 / 0 : 성공
		for(TB_ODINFOXD tb : list)
		{	
			if (tb.getEXCEL_CODE().equals("0"))
				successlist.add(tb);
			else if(tb.getEXCEL_CODE().equals("-1"))
				errorlist.add(tb);
		}
		
		model.addAttribute("errlist", errorlist);
		model.addAttribute("scslist", successlist);
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderMgr/excelResult");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: orderQtyUpdate
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문내역 수량변경 저장 (사용안함)
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-15 (오후 6:08:29)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	
	@RequestMapping(value="/orderQtyUpdate",method=RequestMethod.POST)
	public ModelAndView updateQty(TB_ODINFOXM tb_odinfoxm, TB_ODINFOXD tb_odinfoxd,Model model) throws Exception{
		// 등록자 정보 변경필요
		tb_odinfoxm.setMODP_ID("admin");
		tb_odinfoxd.setMODP_ID("admin");
		
		orderMgrService.updateDatailQty(tb_odinfoxd);
		orderMgrService.updateMasterQty(tb_odinfoxm);
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderMgr/form/"+tb_odinfoxm.getORDER_NUM());		
		return new ModelAndView(redirectView);
	}
	*/
}
