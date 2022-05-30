package mall.web.controller.mall;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.util.DanalFunction;
import mall.common.util.DanalFunction2;
import mall.web.controller.DefaultController;
import mall.web.controller.admin.CategoryMgrController;
import mall.web.domain.TB_BKINFOXM;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODDNLGXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_SPINFOXM;
import mall.web.service.admin.impl.SupplierMgrService;
import mall.web.service.mall.MemberService;
import mall.web.service.mall.OrderService;
import mall.web.service.mall.ProductService;

@Controller
//@RequestMapping(value="/order")
@RequestMapping(value="/orderDanal")
public class OrderController extends DefaultController{
	
	private static final Logger logger = LoggerFactory.getLogger(CategoryMgrController.class);

	@Autowired
	private Environment environment;
	
	@Resource(name="orderService")
	OrderService orderService;

	@Resource(name="supplierMgrService")
	SupplierMgrService supplierMgrService;
	
	@Resource(name="productService")
	ProductService productService;

	@Resource(name="memberService")
	MemberService memberService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.OrderController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문 내역 목록
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-27 (오후 2:07:41)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/wishList", method=RequestMethod.GET)
	public ModelAndView index(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		if(loginUser==null){
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "로그인 후 이용해주세요.");
			mav.addObject("returnUrl", "/user/loginForm");
			mav.setViewName("alertMessage");
			return mav;
			
		}else{
			
			if(request.getParameter("pagerMaxPageItems")!=null){
				tb_odinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));	//페이징 단위 : 50
				tb_odinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			}else {
				tb_odinfoxm.setRowCnt(20);	//페이징 단위 : 20
				tb_odinfoxm.setPagerMaxPageItems(20);	
			}
			
			tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
			tb_odinfoxm.setCount(orderService.getObjectCount(tb_odinfoxm));
			
			tb_odinfoxm.setList(orderService.getObjectList(tb_odinfoxm));
			model.addAttribute("obj", tb_odinfoxm);
			
			model.addAttribute("rowCnt", tb_odinfoxm.getRowCnt());
			model.addAttribute("totalCnt", tb_odinfoxm.getCount());
			
			/*
			String strLink = null;
			strLink = "&pagerMaxPageItems="+StringUtil.nullCheck(tb_odinfoxm.getPagerMaxPageItems());	
			model.addAttribute("link", strLink);
			request.getSession().setAttribute("NOTPAYCNT", refreshOrder(loginUser.getMEMB_ID()));
			*/
			/*
			//세션변경
			TB_ODINFOXM resultNotPayCnt= new TB_ODINFOXM();
			resultNotPayCnt.setREGP_ID(loginUser.getMEMB_ID());	
			List<TB_ODINFOXM> notPayCnt =(List<TB_ODINFOXM>) orderService.getObjectList(resultNotPayCnt);
			int cnt = 0;
			for(int i=0; i<notPayCnt.size();i++){
				if(notPayCnt.get(i).getORDER_CON().equals("ORDER_CON_01"))
					cnt++;
			}
			request.getSession().setAttribute("NOTPAYCNT",  cnt);
			*/
			
			return new ModelAndView("mallNew.layout", "jsp", "mall/order/list");
		}
	}
	
	@RequestMapping(value="/new", method=RequestMethod.POST)
	public ModelAndView newForm(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model, HttpServletRequest request) throws Exception {
		
		StringTokenizer stok = new StringTokenizer(tb_odinfoxm.getBSKT_REGNO_LIST(),"$");
		List<String> list = new ArrayList<String>();
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			list.add(str);
		}
		
//		StringTokenizer stok2 = new StringTokenizer(tb_odinfoxm.getPD_CUT_SEQ_LIST(),"$");
		
//		List<String> list2 = new ArrayList<String>();
//		while(stok2.hasMoreTokens()){
//			String str2 = stok2.nextToken();
//			list2.add(str2);
//		}
		
		String[] cut_seq_name = tb_odinfoxm.getPD_CUT_SEQ_LIST().split("@@!");
		String[] option_name = tb_odinfoxm.getOPTION_CODE_LIST().split("@@#");
		
		tb_odinfoxm.setList(orderService.getNewObjectList(list));
		model.addAttribute("obj", tb_odinfoxm);
		model.addAttribute("PD_CUT_SEQ", cut_seq_name);
		model.addAttribute("OPTION_CODE", option_name);

		//배송비쿠폰 select
		TB_MBINFOXM tb_mbinfoxm = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_mbinfoxm = (TB_MBINFOXM) memberService.getObject(tb_mbinfoxm);
		model.addAttribute("mbinfo", tb_mbinfoxm);		
				
		//배송비 조건
		TB_SPINFOXM supplierInfo = new TB_SPINFOXM();
		supplierInfo.setSUPR_ID("C00001");
		model.addAttribute("supplierInfo", (TB_SPINFOXM)supplierMgrService.getObject(supplierInfo));
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/order/new");
	}
	
	@RequestMapping(value="/buy")
	public ModelAndView buy(@ModelAttribute TB_ODINFOXD tb_odinfoxd, Model model, HttpServletRequest request) throws Exception {

		StringTokenizer stok = new StringTokenizer(tb_odinfoxd.getPD_CODE(),"$");
		List<String> list = new ArrayList<String>();
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			list.add(str);
		}
		
		tb_odinfoxd.setList(orderService.getBuyObjectList(list));
		model.addAttribute("obj", tb_odinfoxd);
		
		//배송비쿠폰 select
		TB_MBINFOXM tb_mbinfoxm = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_mbinfoxm = (TB_MBINFOXM) memberService.getObject(tb_mbinfoxm);
		model.addAttribute("mbinfo", tb_mbinfoxm);		
				
		//배송비 조건
		TB_SPINFOXM supplierInfo = new TB_SPINFOXM();
		supplierInfo.setSUPR_ID("C00001");
		model.addAttribute("supplierInfo", (TB_SPINFOXM)supplierMgrService.getObject(supplierInfo));
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/order/new");

	}
	
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODINFOXD tb_odinfoxd, @ModelAttribute TB_ODDLAIXM tb_oddlaixm, Model model, HttpServletRequest request) throws Exception {

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setREGP_ID(loginUser.getMEMB_ID());
		tb_oddlaixm.setREGP_ID(loginUser.getMEMB_ID());
		//System.out.println(request.getParameter("CPON_YN"));
		if(tb_oddlaixm.getDLAR_DATE()!=null&&!tb_oddlaixm.getDLAR_DATE().equals("")){
			if(tb_oddlaixm.getDLAR_DATE().equals("DLAR_DATE_01")){
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		        Calendar c1 = Calendar.getInstance();
		        c1.add(Calendar.DATE, 1);
		        if(c1.get(Calendar.DAY_OF_WEEK)==1){
		        	c1.add(Calendar.DATE, 1);
		        }
		        String strToday = sdf.format(c1.getTime());

		        tb_oddlaixm.setDLAR_DATE(strToday);

			}else{
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		        Calendar c1 = Calendar.getInstance();
		        if(c1.get(Calendar.DAY_OF_WEEK)==1){
		        	c1.add(Calendar.DATE, 1);
		        }
		        String strToday = sdf.format(c1.getTime());

		        tb_oddlaixm.setDLAR_DATE(strToday);
			}
		}
		/*여기*/
		orderService.insertOrderObject(tb_odinfoxm, tb_odinfoxd, tb_oddlaixm);		
		
		//주문정보 마스터 정보
		TB_ODINFOXM rtnOdinfoxm = (TB_ODINFOXM)orderService.getMasterInfo(tb_odinfoxm);
		//주문정보 상세  
		rtnOdinfoxm.setList(orderService.getDetailsList(rtnOdinfoxm));
		//배송지 정보
		TB_ODDLAIXM rtnOddlaixm = new TB_ODDLAIXM();
		rtnOddlaixm = (TB_ODDLAIXM)orderService.getDeliveryInfo(rtnOdinfoxm);
		
		model.addAttribute("tb_odinfoxm", rtnOdinfoxm);
		model.addAttribute("tb_oddlaixm", rtnOddlaixm);

		//System.out.println(tb_odinfoxm.getCPON_YN());
		//회원정보 배송비쿠폰갯수 UPDATE_20190523
		if(tb_odinfoxm.getCPON_YN() != null && tb_odinfoxm.getCPON_YN().equals("Y")){
			TB_MBINFOXM mbinfoxm = new TB_MBINFOXM();
			mbinfoxm.setMEMB_ID(loginUser.getMEMB_ID());
			mbinfoxm.setREGP_ID(loginUser.getMEMB_ID());
			mbinfoxm.setDLVY_CPON(tb_odinfoxm.getDLVY_CPON());
			
			memberService.updateCponCnt(mbinfoxm);
		}
		
		//세션변경
		/*TB_ODINFOXM resultNotPayCnt= new TB_ODINFOXM();
		resultNotPayCnt.setREGP_ID(loginUser.getMEMB_ID());	
		List<TB_ODINFOXM> notPayCnt =(List<TB_ODINFOXM>) orderService.getObjectList(resultNotPayCnt);
		int cnt = 0;
		for(int i=0; i<notPayCnt.size();i++){
			if(notPayCnt.get(i).getORDER_CON().equals("ORDER_CON_01"))
				cnt++;
		}
		request.getSession().setAttribute("NOTPAYCNT",  cnt);*/
		
		//return new ModelAndView("mallNew.layout", "jsp", "mall/order/payReq");
		RedirectView redirectView = new RedirectView(servletContextPath+"/order/view/"+rtnOdinfoxm.getORDER_NUM());
		return new ModelAndView(redirectView);
	}

	@RequestMapping(value="/orderReady")
	public ModelAndView orderPay(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model, HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		//주문정보 마스터 정보
		TB_ODINFOXM rtnOdinfoxm = (TB_ODINFOXM)orderService.getMasterInfo(tb_odinfoxm);
		//주문정보 상세  
		rtnOdinfoxm.setList(orderService.getDetailsList(rtnOdinfoxm));
		//배송지 정보
		TB_ODDLAIXM rtnOddlaixm = new TB_ODDLAIXM();
		rtnOddlaixm = (TB_ODDLAIXM)orderService.getDeliveryInfo(rtnOdinfoxm);
		
		//테스트ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		orderService.orderDlvyUpdate(tb_odinfoxm);

		String strItemName = "";
		
		List<?> list = rtnOdinfoxm.getList();
		if(list.size() > 0){
			TB_ODINFOXD odinfoxd = (TB_ODINFOXD)list.get(0);
			if(list.size() == 1){
				strItemName = odinfoxd.getPD_NAME();
			}else{
				strItemName = odinfoxd.getPD_NAME() + " 외 " + (list.size()-1) + "건";			
			}
		}
		
		//model.addAttribute("tb_odinfoxm", rtnOdinfoxm);
		//model.addAttribute("tb_oddlaixm", rtnOddlaixm);
		

		String MODE = environment.getProperty("danal.MODE"); 						// service, test
		String DN_CREDIT_URL = environment.getProperty("danal.DN_CREDIT_URL"); 		// 결제 서버 정의
		String CPID = environment.getProperty("danal.CPID"); 						// CPID
		String CRYPTOKEY = environment.getProperty("danal.CRYPTOKEY");				// 암호화Key

		
		DanalFunction danalFun = new DanalFunction(MODE, DN_CREDIT_URL, CPID, CRYPTOKEY);
		
		/*[ 필수 데이터 ]***************************************/
		Map REQ_DATA = new HashMap();
		Map RES_DATA = null;

		/******************************************************
		 *  RETURNURL 	: CPCGI페이지의 Full URL을 넣어주세요
		 *  CANCELURL 	: BackURL페이지의 Full URL을 넣어주세요
		 ******************************************************/
		String RETURNURL = environment.getProperty("danal.RETURNURL");
		String CANCELURL = environment.getProperty("danal.CANCELURL");

		/**************************************************
		 * SubCP 정보
		 **************************************************/
		REQ_DATA.put("SUBCPID", "");

		/**************************************************
		 * 결제 정보
		 **************************************************/
		REQ_DATA.put("ORDERID", rtnOdinfoxm.getORDER_NUM());
		REQ_DATA.put("AMOUNT", rtnOdinfoxm.getORDER_AMT());
		REQ_DATA.put("CURRENCY", "410");
		REQ_DATA.put("ITEMNAME", strItemName);			//상품명
		
		//사용자 환경
		String userAgent = request.getHeader("user-agent");
		boolean mobile1 = userAgent.matches(".*(iPhone|iPad|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|POLATIS|IEMobile|lgtelecom|mokia|SonyEricsson).*");
		boolean mobile2 = userAgent.matches(".*(LG|SAMSUNG|Samsung).*");
		if(mobile1 || mobile2){
			REQ_DATA.put("USERAGENT", "WM");
		}else{
			REQ_DATA.put("USERAGENT", "PC");
		}
		REQ_DATA.put("OFFERPERIOD", "2015102920151129");

		/**************************************************
		 * 고객 정보
		 **************************************************/
		REQ_DATA.put("USERNAME", (String) loginUser.getMEMB_NAME()); // 구매자 이름
		REQ_DATA.put("USERID", (String) loginUser.getMEMB_ID()); // 사용자 ID
		REQ_DATA.put("USEREMAIL", (String) loginUser.getMEMB_MAIL()); // 소보법 email수신처

		/**************************************************
		 * URL 정보
		 **************************************************/
		REQ_DATA.put("CANCELURL", CANCELURL);
		REQ_DATA.put("RETURNURL", RETURNURL);

		/**************************************************
		 * 기본 정보
		 **************************************************/
		REQ_DATA.put("TXTYPE", "AUTH");
		REQ_DATA.put("SERVICETYPE", "DANALCARD");
		REQ_DATA.put("ISNOTI", "N");
		//REQ_DATA.put("BYPASSVALUE", "this=is;a=test;bypass=value"); // BILL응답 또는 Noti에서 돌려받을 값. '&'를 사용할 경우 값이 잘리게되므로 유의.

		System.out.println(REQ_DATA);
		
		RES_DATA = danalFun.CallCredit(REQ_DATA, true);
		
		//if ("0000".equals(RES_DATA.get("RETURNCODE"))) {
		//	
		//}else{
		//
		//}

		String STARTURL = (String) RES_DATA.get("STARTURL");
		String STARTPARAMS = (String) RES_DATA.get("STARTPARAMS");
		
		String RETURNCODE = (String) RES_DATA.get("RETURNCODE");
		String RETURNMSG = (String) RES_DATA.get("RETURNMSG");

		model.addAttribute("STARTURL", STARTURL);
		model.addAttribute("STARTPARAMS", STARTPARAMS);
		
		model.addAttribute("RETURNCODE", RETURNCODE);
		model.addAttribute("RETURNMSG", RETURNMSG);
		
		
		return new ModelAndView("popup.layout", "jsp", "mall/order/orderReady");
		
	}
	
	/**
	 * 인증요청 응답 화면 (
	 * @param resv
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/orderReturn")
	public  ModelAndView payReturn(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, HttpSession session, Model model) throws Exception {
			
		String MODE = environment.getProperty("danal.MODE"); 						// service, test
		String DN_CREDIT_URL = environment.getProperty("danal.DN_CREDIT_URL"); 		// 결제 서버 정의
		String CPID = environment.getProperty("danal.CPID"); 						// CPID
		String CRYPTOKEY = environment.getProperty("danal.CRYPTOKEY");				// 암호화Key

		DanalFunction danalFun = new DanalFunction(MODE, DN_CREDIT_URL, CPID, CRYPTOKEY);
		
		
		String RES_STR = danalFun.toDecrypt((String) request.getParameter("RETURNPARAMS"));
		Map retMap = danalFun.str2data(RES_STR);

		String returnCode = (String) retMap.get("RETURNCODE");
		String returnMsg = (String) retMap.get("RETURNMSG");
		
		//*****  신용카드 인증결과 확인 *****************
		if (returnCode == null || !"0000".equals(returnCode)) {
			// returnCode가 없거나 또는 그 결과가 성공이 아니라면 실패 처리
			logger.info("Authentication failed. " + returnMsg + "[" + returnCode + "]");

			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "잘못된 접근 입니다. 관리자에게 문의하세요.\n"
							+"Authentication failed. " + returnMsg + "[" + returnCode + "]");
			mav.addObject("returnUrl", "close");
			mav.setViewName("alertMessage");
			return mav;
			
			
		}
		//주문정보 마스터 정보
		tb_odinfoxm.setORDER_NUM((String) retMap.get("ORDERID"));
		TB_ODINFOXM rtnOdinfoxm = (TB_ODINFOXM)orderService.getMasterInfo(tb_odinfoxm);
		
		/*[ 필수 데이터 ]***************************************/
		Map REQ_DATA = new HashMap();
		Map RES_DATA = new HashMap();

		/**************************************************
		 * 결제 정보
		 **************************************************/
		REQ_DATA.put("TID", (String) retMap.get("TID"));
		REQ_DATA.put("AMOUNT", rtnOdinfoxm.getORDER_AMT()); 		// 최초 결제요청(AUTH)시에 보냈던 금액과 동일한 금액을 전송

		/**************************************************
		 * 기본 정보
		 **************************************************/
		REQ_DATA.put("TXTYPE", "BILL");
		REQ_DATA.put("SERVICETYPE", "DANALCARD");

		RES_DATA = danalFun.CallCredit(REQ_DATA, false);

		String RETURNCODE = (String) RES_DATA.get("RETURNCODE");
		String RETURNMSG = (String) RES_DATA.get("RETURNMSG");
		
		model.addAttribute("RETURNCODE", RETURNCODE);
		model.addAttribute("RETURNMSG", RETURNMSG);


//		logger.info("TID : " + (String) RES_DATA.get("TID"));
//		logger.info("ORDERID : " + (String) RES_DATA.get("ORDERID"));
//		logger.info("AMOUNT : " + (String) RES_DATA.get("AMOUNT"));
//		logger.info("RETURNCODE : " + (String) RES_DATA.get("RETURNCODE"));
//		logger.info("RETURNMSG : " + (String) RES_DATA.get("RETURNMSG"));
//		logger.info("TRANDATE : " + (String) RES_DATA.get("TRANDATE"));
//		logger.info("TRANTIME : " + (String) RES_DATA.get("TRANTIME"));
//		logger.info("CARDCODE : " + (String) RES_DATA.get("CARDCODE"));
//		logger.info("CARDNAME : " + (String) RES_DATA.get("CARDNAME"));
//		logger.info("CARDAUTHNO : " + (String) RES_DATA.get("CARDAUTHNO"));
//		logger.info("BYPASSVALUE : " + (String) RES_DATA.get("BYPASSVALUE"));
		
		//결제 상태 변경
		if ("0000".equals(RES_DATA.get("RETURNCODE"))) {
	    	TB_ODINFOXM odinfoxm = new TB_ODINFOXM();
	    	
	    	odinfoxm.setORDER_NUM((String) RES_DATA.get("ORDERID"));
	    	odinfoxm.setORDER_CON("ORDER_CON_02");					//결제완료
	    	odinfoxm.setPAY_METD("PAY_METD_01");					//카드결제
	    	odinfoxm.setPAY_MDKY((String) RES_DATA.get("TID"));
	    	odinfoxm.setPAY_AMT((String) RES_DATA.get("AMOUNT"));
	    	
			orderService.orderPayUpdate(odinfoxm);
			
		}
		
		model.addAttribute("ORDER_NUM", (String) RES_DATA.get("ORDERID"));
		
		//결제 로그 처리
		try {
			
			TB_ODDNLGXM oddnlgxm = new TB_ODDNLGXM();

			oddnlgxm.setTID((String) RES_DATA.get("TID"));
			oddnlgxm.setORDER_NUM((String) RES_DATA.get("ORDERID"));
			oddnlgxm.setGUBUN("ORDER");
			oddnlgxm.setRETURNCODE((String) RES_DATA.get("RETURNCODE"));
			oddnlgxm.setRETURNMSG((String) RES_DATA.get("RETURNMSG"));
			oddnlgxm.setAMOUNT((String) RES_DATA.get("AMOUNT"));
			oddnlgxm.setTRANDATE((String) RES_DATA.get("TRANDATE"));
			oddnlgxm.setTRANTIME((String) RES_DATA.get("TRANTIME"));
			oddnlgxm.setCARDCODE((String) RES_DATA.get("CARDCODE"));
			oddnlgxm.setCARDNAME((String) RES_DATA.get("CARDNAME"));
			oddnlgxm.setCARDAUTHNO((String) RES_DATA.get("CARDAUTHNO"));
			oddnlgxm.setBYPASSVALUE((String) RES_DATA.get("BYPASSVALUE"));
	    	
			orderService.danalLogInsert(oddnlgxm);
			
		}catch(Exception e){
			logger.info("Danal Logging Error : " + e.toString());
		}		
		
		return new ModelAndView("popup.layout", "jsp", "mall/order/orderReturn");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.OrderController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문내역 상세
	 * @Company	: YT Corp.
	 * @Author	: Seok-min Jeon (smjeon@youngthink.co.kr)
	 * @Date	: 2016-07-12 (오후 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/view/{ORDER_NUM}" }, method=RequestMethod.GET)
	public ModelAndView view(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		
		//세션변경
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		/*TB_ODINFOXM resultNotPayCnt= new TB_ODINFOXM();
		resultNotPayCnt.setREGP_ID(loginUser.getMEMB_ID());
		List<TB_ODINFOXM> notPayCnt =(List<TB_ODINFOXM>) orderService.getObjectList(resultNotPayCnt);
		int cnt = 0;
		for(int i=0; i<notPayCnt.size();i++){
			if(notPayCnt.get(i).getORDER_CON().equals("ORDER_CON_01"))
				cnt++;
		}
		request.getSession().setAttribute("NOTPAYCNT",  cnt);	*/
		
		TB_ODDLAIXM tb_oddlaixm = new TB_ODDLAIXM();
		//배송지정보
		tb_oddlaixm = (TB_ODDLAIXM)orderService.getDeliveryInfo(tb_odinfoxm);
		//주문정보 마스터 정보
		tb_odinfoxm = (TB_ODINFOXM)orderService.getMasterInfo(tb_odinfoxm);
		//주문정보 상세  
		tb_odinfoxm.setList(orderService.getDetailsList(tb_odinfoxm));
		
		/*백업해두기ㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣ
		if(tb_odinfoxm.getORDER_CON().equals("ORDER_CON_02")
				&&(tb_oddlaixm.getDLAR_DATE()==null||tb_oddlaixm.getDLAR_DATE().equals(""))
				&&(tb_odinfoxm.getPAY_DTM()!=null&&!tb_odinfoxm.getPAY_DTM().equals(""))){
			tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
			//배송날짜, 배송시간 저장
			orderService.orderDlvyDateUpdate(tb_odinfoxm);	
		}
		*/
		
		//배송지 정보 다시 불러오기
		tb_oddlaixm = (TB_ODDLAIXM)orderService.getDeliveryInfo(tb_odinfoxm);

		if(!loginUser.getMEMB_ID().equals(tb_odinfoxm.getMEMB_ID())){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "주문자와 로그인 정보가 일치하지 않습니다.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		model.addAttribute("tb_oddlaixm", tb_oddlaixm);
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/order/view");
	}

	@RequestMapping(value={ "/orderCancel" }, method=RequestMethod.GET)
	public ModelAndView cancel(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		
		return new ModelAndView("popup.layout", "jsp", "mall/order/orderCancel");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.OrderController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문내역 상세
	 * @Company	: YT Corp.
	 * @Author	: Seok-min Jeon (smjeon@youngthink.co.kr)
	 * @Date	: 2016-07-12 (오후 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/deliveryAddr" }, method=RequestMethod.POST)
	public @ResponseBody TB_ODDLAIXM deliveryAddr(@ModelAttribute TB_ODDLAIXM tb_oddlaixm, Model model, HttpServletRequest request) throws Exception {
		
		//System.out.println(tb_oddlaixm.getDLAR_GUBN());
		
		String dlarGubn = tb_oddlaixm.getDLAR_GUBN();

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_oddlaixm.setREGP_ID(loginUser.getMEMB_ID());
		
		/*
		  DLAR_GUBN_01 자택
		  DLAR_GUBN_02 회사
		  DLAR_GUBN_03 최근배송지
		  DLAR_GUBN_04 신규
		  DLAR_GUBN_05 직접출고
		*/
		
		TB_ODDLAIXM obj = new TB_ODDLAIXM();
		
		if(dlarGubn.equals("DLAR_GUBN_01")){
			obj = (TB_ODDLAIXM)orderService.getMbDlvyInfo(tb_oddlaixm);
		}else if(dlarGubn.equals("DLAR_GUBN_02")){
			obj = (TB_ODDLAIXM)orderService.getSpDlvyInfo(tb_oddlaixm);
		}else if(dlarGubn.equals("DLAR_GUBN_03")){
			obj = (TB_ODDLAIXM)orderService.getDlvyInfo(tb_oddlaixm);
		}else if(dlarGubn.equals("DLAR_GUBN_05")){
			obj = (TB_ODDLAIXM)orderService.getSfDlvyInfo(tb_oddlaixm);
		}else{
			
		}
		
		if(obj == null){
			obj = new TB_ODDLAIXM();
		}
		
		obj.setDLAR_GUBN(dlarGubn);
		
		return obj;
	}
	
	
	
	/* 반품문구 팝업 */
	@RequestMapping(value={ "/returnInfo/popup" }, method=RequestMethod.GET)
	public ModelAndView returnInfoPop(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
				
		return new ModelAndView("popup.layout", "jsp", "mall/order/popup3");
	}
	
	
	/* 주문취소 팝업 */
	@RequestMapping(value={ "/cancel/popup" }, method=RequestMethod.GET)
	public ModelAndView cancelPop(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");

		TB_ODINFOXM rtnOdinfoxm = (TB_ODINFOXM)orderService.getMasterInfo(tb_odinfoxm);
		
		if(!loginUser.getMEMB_ID().equals(rtnOdinfoxm.getMEMB_ID())){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "주문자와 로그인 정보가 일치하지 않습니다.");
			mav.addObject("returnUrl", "close");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		return new ModelAndView("popup.layout", "jsp", "mall/order/popup");
	}
	
	
	/* 주문취소 */
	@RequestMapping(value={ "/cancel/popup" }, method=RequestMethod.POST)
	public ModelAndView orderCancel(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {

		ModelAndView mav = new ModelAndView();
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());

		TB_ODINFOXM rtnOdinfoxm = (TB_ODINFOXM)orderService.getMasterInfo(tb_odinfoxm);
		
		if(!loginUser.getMEMB_ID().equals(rtnOdinfoxm.getMEMB_ID())){
			mav.addObject("alertMessage", "주문자와 로그인 정보가 일치하지 않습니다.");
			mav.addObject("returnUrl", "close");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		
		//결제 정보가 있을경우
		if(StringUtils.isNotEmpty(rtnOdinfoxm.getPAY_MDKY())){
			String MODE = environment.getProperty("danal.MODE"); 						// service, test
			String DN_CREDIT_URL = environment.getProperty("danal.DN_CREDIT_URL"); 		// 결제 서버 정의
			String CPID = environment.getProperty("danal.CPID"); 						// CPID
			String CRYPTOKEY = environment.getProperty("danal.CRYPTOKEY");				// 암호화Key

			DanalFunction danalFun = new DanalFunction(MODE, DN_CREDIT_URL, CPID, CRYPTOKEY);
			
			Map REQ_DATA = new HashMap();
			Map RES_DATA = new HashMap();
			
			/**************************************************
			 * 결제 정보
			 **************************************************/
			REQ_DATA.put("TID", rtnOdinfoxm.getPAY_MDKY());
			
			/**************************************************
			 * 기본 정보
			 **************************************************/
			REQ_DATA.put("CANCELTYPE", "C");
			REQ_DATA.put("AMOUNT", rtnOdinfoxm.getORDER_AMT());

			/**************************************************
			 * 취소 정보
			 **************************************************/
			REQ_DATA.put("CANCELREQUESTER", "CP_CS_PERSON");
			REQ_DATA.put("CANCELDESC", "Item not delivered");


			REQ_DATA.put("TXTYPE", "CANCEL");
			REQ_DATA.put("SERVICETYPE", "DANALCARD");

			
			RES_DATA = danalFun.CallCredit(REQ_DATA, false);
			
			if( RES_DATA.get("RETURNCODE").equals("0000")){
				// 결제 성공 시 작업 진행
		    	mav.addObject("alertMessage", "결제 취소요청이 완료되었습니다.");
		    	
				tb_odinfoxm.setORDER_CON("ORDER_CON_04");
				orderService.cancelObject(tb_odinfoxm);
			} else {
				// 결제 실패 시 작업 진행
		    	mav.addObject("alertMessage", "결제 취소요청이 실패하였습니다.(RETURNCODE = " + (String) RES_DATA.get("RETURNCODE") + ", TX Response_msg = " + (String) RES_DATA.get("RETURNMSG") + ") 관리자에게 문의하세요.");
			}

			//결제 로그 처리
			try {
				
				TB_ODDNLGXM oddnlgxm = new TB_ODDNLGXM();

				oddnlgxm.setTID((String) RES_DATA.get("O_TID"));
				oddnlgxm.setORDER_NUM(tb_odinfoxm.getORDER_NUM());
				oddnlgxm.setGUBUN("CANCEL");
				oddnlgxm.setRETURNCODE((String) RES_DATA.get("RETURNCODE"));
				oddnlgxm.setRETURNMSG((String) RES_DATA.get("RETURNMSG"));
				oddnlgxm.setAMOUNT((String) RES_DATA.get("AMOUNT"));
				oddnlgxm.setTRANDATE((String) RES_DATA.get("TRANDATE"));
				oddnlgxm.setTRANTIME((String) RES_DATA.get("TRANTIME"));
				oddnlgxm.setCARDCODE("");
				oddnlgxm.setCARDNAME("");
				oddnlgxm.setCARDAUTHNO("");
				oddnlgxm.setBYPASSVALUE((String) RES_DATA.get("TID"));
		    	
				orderService.danalLogInsert(oddnlgxm);
				
			}catch(Exception e){
				logger.info("Danal Logging Error : " + e.toString());
			}
		    
		}else{
	    	mav.addObject("alertMessage", "결제 취소요청이 완료되었습니다.");

			tb_odinfoxm.setORDER_CON("ORDER_CON_04");
			orderService.cancelObject(tb_odinfoxm);
		}


		mav.addObject("gubun", "popup");
		mav.addObject("returnUrl", servletContextPath.concat("/order/view/" + tb_odinfoxm.getORDER_NUM()));
		mav.setViewName("alertMessage");

		return mav;
		
		//RedirectView rv = new RedirectView(servletContextPath.concat("/order/view/" + tb_odinfoxm.getORDER_NUM()));
		//return new ModelAndView(rv);
	}
	
	
	
	//무통장입금
	@RequestMapping(value="/orderReady2")
	public ModelAndView orderPay2(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model, HttpServletRequest request) throws Exception {

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		//주문정보 마스터 정보
		TB_ODINFOXM rtnOdinfoxm = (TB_ODINFOXM)orderService.getMasterInfo(tb_odinfoxm);
		//주문정보 상세  
		rtnOdinfoxm.setList(orderService.getDetailsList(rtnOdinfoxm));
		//배송지 정보
		TB_ODDLAIXM rtnOddlaixm = new TB_ODDLAIXM();   
		rtnOddlaixm = (TB_ODDLAIXM)orderService.getDeliveryInfo(rtnOdinfoxm);
		
		orderService.orderDlvyUpdate(tb_odinfoxm);

		String strItemName = "";
		
		List<?> list = rtnOdinfoxm.getList();
		if(list.size() > 0){
			TB_ODINFOXD odinfoxd = (TB_ODINFOXD)list.get(0);
			if(list.size() == 1){
				strItemName = odinfoxd.getPD_NAME();
			}else{
				strItemName = odinfoxd.getPD_NAME() + " 외 " + (list.size()-1) + "건";			
			}
		}
		
		//model.addAttribute("tb_odinfoxm", rtnOdinfoxm);
		//model.addAttribute("tb_oddlaixm", rtnOddlaixm);
		

		String MODE = environment.getProperty("danal.MODE"); 									// service, test
		String DN_CREDIT_URL = environment.getProperty("danal.DN_BANK_URL"); 		// 결제 서버 정의
		String CPID = environment.getProperty("danal.BANK_CPID"); 							// CPID
		String CRYPTOKEY = environment.getProperty("danal.BANK_CRYPTOKEY");			// 암호화Key
		
		DanalFunction2 danalFun = new DanalFunction2(MODE, DN_CREDIT_URL, CPID, CRYPTOKEY);
		
		/*[ 필수 데이터 ]***************************************/
		Map REQ_DATA = new HashMap();
		Map RES_DATA = null;

		/******************************************************
		 *  RETURNURL 	: CPCGI페이지의 Full URL을 넣어주세요
		 *  CANCELURL 	: BackURL페이지의 Full URL을 넣어주세요
		 ******************************************************/
		String RETURNURL = environment.getProperty("danal.BANK_RETURNURL");
		String CANCELURL = environment.getProperty("danal.BANK_CANCELURL");

		/**************************************************
		 * SubCP 정보
		 **************************************************/
		REQ_DATA.put("SUBCPID", "");

		/**************************************************
		 * 결제 정보
		 **************************************************/
		REQ_DATA.put("ORDERID", rtnOdinfoxm.getORDER_NUM());
		REQ_DATA.put("AMOUNT", rtnOdinfoxm.getORDER_AMT());
		//REQ_DATA.put("ISCASHRECEIPTUI", "Y");			//현금영수증
		REQ_DATA.put("ITEMNAME", strItemName);			//상품명

		//사용자 환경
		String userAgent = request.getHeader("user-agent");
		boolean mobile1 = userAgent.matches(".*(iPhone|iPad|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|POLATIS|IEMobile|lgtelecom|mokia|SonyEricsson).*");
		boolean mobile2 = userAgent.matches(".*(LG|SAMSUNG|Samsung).*");
		if(mobile1 || mobile2){
			REQ_DATA.put("USERAGENT", "MW");
		}else{
			REQ_DATA.put("USERAGENT", "PC");
		}
		//REQ_DATA.put("USERAGENT", "PC");
		//REQ_DATA.put("BYPASSVALUE", "a=b;c=d;");

		/**************************************************
		 * 고객 정보
		 **************************************************/
		REQ_DATA.put("USERNAME", (String) loginUser.getMEMB_NAME()); // 구매자 이름
		REQ_DATA.put("USERID", (String) loginUser.getMEMB_ID()); // 사용자 ID
		REQ_DATA.put("USEREMAIL", (String) loginUser.getMEMB_MAIL()); // 소보법 email수신처
		//REQ_DATA.put("USEREMAIL", "test@test.com"); // 소보법 email수신처

		/**************************************************
		 * URL 정보
		 **************************************************/
		REQ_DATA.put("CANCELURL", CANCELURL);
		REQ_DATA.put("RETURNURL", RETURNURL);

		/**************************************************
		 * 기본 정보
		 **************************************************/
		REQ_DATA.put("TXTYPE", "AUTH");
		REQ_DATA.put("SERVICETYPE", "WIRETRANSFER");
		REQ_DATA.put("ISNOTI", "N");
		//REQ_DATA.put("BYPASSVALUE", "this=is;a=test;bypass=value"); // BILL응답 또는 Noti에서 돌려받을 값. '&'를 사용할 경우 값이 잘리게되므로 유의.

		System.out.println(REQ_DATA);
		
		//RES_DATA = danalFun.CallCredit(REQ_DATA, false);
		RES_DATA = danalFun.CallDanalBank(REQ_DATA, true);

		String STARTURL = (String) RES_DATA.get("STARTURL");
		String STARTPARAMS = (String) RES_DATA.get("STARTPARAMS");
		
		String RETURNCODE = (String) RES_DATA.get("RETURNCODE");
		String RETURNMSG = (String) RES_DATA.get("RETURNMSG");

		model.addAttribute("STARTURL", STARTURL);
		model.addAttribute("STARTPARAMS", STARTPARAMS);
		
		model.addAttribute("RETURNCODE", RETURNCODE);
		model.addAttribute("RETURNMSG", RETURNMSG);
		
		
		return new ModelAndView("popup.layout", "jsp", "mall/order/orderReady");
		
	}
	
	/**
	 * 인증요청 응답 화면 - 계좌이체
	 * @param resv
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/orderReturn2")	
	public  ModelAndView payReturn2(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, HttpSession session, Model model) throws Exception {
	
		String MODE = environment.getProperty("danal.MODE"); 						// service, test
		String DN_CREDIT_URL = environment.getProperty("danal.DN_BANK_URL"); 		// 결제 서버 정의
		String CPID = environment.getProperty("danal.BANK_CPID"); 						// CPID
		String CRYPTOKEY = environment.getProperty("danal.BANK_CRYPTOKEY");				// 암호화Key

		DanalFunction2 danalFun = new DanalFunction2(MODE, DN_CREDIT_URL, CPID, CRYPTOKEY);
		
		
		String RES_STR = danalFun.toDecrypt((String) request.getParameter("RETURNPARAMS"));
		Map retMap = danalFun.str2data(RES_STR);

		String returnCode = (String) retMap.get("RETURNCODE");
		String returnMsg = (String) retMap.get("RETURNMSG");

		//*****  신용카드 인증결과 확인 *****************
		if (returnCode == null || !"0000".equals(returnCode)) {
			// returnCode가 없거나 또는 그 결과가 성공이 아니라면 실패 처리
			logger.info("Authentication failed. " + returnMsg + "[" + returnCode + "]");
		
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "잘못된 접근 입니다. 관리자에게 문의하세요.\n"
					+"Authentication failed. " + returnMsg + "[" + returnCode + "]");
			mav.addObject("returnUrl", "close");
			mav.setViewName("alertMessage");
			return mav;
			
			
		}
		//주문정보 마스터 정보
		tb_odinfoxm.setORDER_NUM((String) retMap.get("ORDERID"));
		TB_ODINFOXM rtnOdinfoxm = (TB_ODINFOXM)orderService.getMasterInfo(tb_odinfoxm);
		
		/*[ 필수 데이터 ]***************************************/
		Map REQ_DATA = new HashMap();
		Map RES_DATA = new HashMap();

		/**************************************************
		 * 결제 정보
		 **************************************************/
		REQ_DATA.put("TID", (String) retMap.get("TID"));
		REQ_DATA.put("AMOUNT", rtnOdinfoxm.getORDER_AMT()); 		// 최초 결제요청(AUTH)시에 보냈던 금액과 동일한 금액을 전송

		/**************************************************
		 * 기본 정보
		 **************************************************/
		REQ_DATA.put("TXTYPE", "BILL");
		REQ_DATA.put("SERVICETYPE", "WIRETRANSFER");

		RES_DATA = danalFun.CallDanalBank(REQ_DATA, false);

		String RETURNCODE = (String) RES_DATA.get("RETURNCODE");
		String RETURNMSG = (String) RES_DATA.get("RETURNMSG");
		
		model.addAttribute("RETURNCODE", RETURNCODE);
		model.addAttribute("RETURNMSG", RETURNMSG);


//		logger.info("TID : " + (String) RES_DATA.get("TID"));
//		logger.info("ORDERID : " + (String) RES_DATA.get("ORDERID"));
//		logger.info("AMOUNT : " + (String) RES_DATA.get("AMOUNT"));
//		logger.info("RETURNCODE : " + (String) RES_DATA.get("RETURNCODE"));
//		logger.info("RETURNMSG : " + (String) RES_DATA.get("RETURNMSG"));
//		logger.info("TRANDATE : " + (String) RES_DATA.get("TRANDATE"));
//		logger.info("TRANTIME : " + (String) RES_DATA.get("TRANTIME"));
//		logger.info("CARDCODE : " + (String) RES_DATA.get("CARDCODE"));
//		logger.info("CARDNAME : " + (String) RES_DATA.get("CARDNAME"));
//		logger.info("CARDAUTHNO : " + (String) RES_DATA.get("CARDAUTHNO"));
//		logger.info("BYPASSVALUE : " + (String) RES_DATA.get("BYPASSVALUE"));
		
		//결제 상태 변경
		if ("0000".equals(RES_DATA.get("RETURNCODE"))) {
	    	TB_ODINFOXM odinfoxm = new TB_ODINFOXM();
	    	
	    	odinfoxm.setORDER_NUM((String) RES_DATA.get("ORDERID"));
	    	odinfoxm.setORDER_CON("ORDER_CON_02");					//결제완료
	    	odinfoxm.setPAY_METD("SC0030");					//카드결제
	    	odinfoxm.setPAY_MDKY((String) RES_DATA.get("TID"));
	    	odinfoxm.setPAY_AMT((String) RES_DATA.get("AMOUNT"));
	    	
			orderService.orderPayUpdate(odinfoxm);
		}
		
		model.addAttribute("ORDER_NUM", (String) RES_DATA.get("ORDERID"));
		
		//결제 로그 처리
		try {
			
			TB_ODDNLGXM oddnlgxm = new TB_ODDNLGXM();

			oddnlgxm.setTID((String) RES_DATA.get("TID"));
			oddnlgxm.setORDER_NUM((String) RES_DATA.get("ORDERID"));
			oddnlgxm.setGUBUN("ORDER");
			oddnlgxm.setRETURNCODE((String) RES_DATA.get("RETURNCODE"));
			oddnlgxm.setRETURNMSG((String) RES_DATA.get("RETURNMSG"));
			oddnlgxm.setAMOUNT((String) RES_DATA.get("AMOUNT"));
			oddnlgxm.setTRANDATE((String) RES_DATA.get("TRANDATE"));
			oddnlgxm.setTRANTIME((String) RES_DATA.get("TRANTIME"));
			oddnlgxm.setCARDCODE("계좌이체");
			oddnlgxm.setCARDNAME("계좌이체");
			//oddnlgxm.setCARDAUTHNO((String) RES_DATA.get("CARDAUTHNO"));
			//oddnlgxm.setBYPASSVALUE((String) RES_DATA.get("BYPASSVALUE"));
	    	
			orderService.danalLogInsert(oddnlgxm);
			
		}catch(Exception e){
			logger.info("Danal Logging Error : " + e.toString());
		}
		
		return new ModelAndView("popup.layout", "jsp", "mall/order/orderReturn2");
	}
	
	/* 주문취소 팝업 */
	@RequestMapping(value={ "/cancel/popup2" }, method=RequestMethod.GET)
	public ModelAndView cancelPop2(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");

		TB_ODINFOXM rtnOdinfoxm = (TB_ODINFOXM)orderService.getMasterInfo(tb_odinfoxm);
		
		if(!loginUser.getMEMB_ID().equals(rtnOdinfoxm.getMEMB_ID())){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "주문자와 로그인 정보가 일치하지 않습니다.");
			mav.addObject("returnUrl", "close");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		return new ModelAndView("popup.layout", "jsp", "mall/order/popup2");
	}
	
	/* 주문취소 */
	@RequestMapping(value={ "/cancel/popup2" }, method=RequestMethod.POST)
	public ModelAndView orderCancel2(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {

		ModelAndView mav = new ModelAndView();
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());

		TB_ODINFOXM rtnOdinfoxm = (TB_ODINFOXM)orderService.getMasterInfo(tb_odinfoxm);
		
		if(!loginUser.getMEMB_ID().equals(rtnOdinfoxm.getMEMB_ID())){
			mav.addObject("alertMessage", "주문자와 로그인 정보가 일치하지 않습니다.");
			mav.addObject("returnUrl", "close");
			mav.setViewName("alertMessage");
			return mav;
		}
	
		//결제 정보가 있을경우
		if(StringUtils.isNotEmpty(rtnOdinfoxm.getPAY_MDKY())){
			String MODE = environment.getProperty("danal.MODE"); 									// service, test
			String DN_CREDIT_URL = environment.getProperty("danal.DN_BANK_URL"); 		// 결제 서버 정의
			String CPID = environment.getProperty("danal.BANK_CPID"); 							// CPID
			String CRYPTOKEY = environment.getProperty("danal.BANK_CRYPTOKEY");			// 암호화Key

			DanalFunction2 danalFun = new DanalFunction2(MODE, DN_CREDIT_URL, CPID, CRYPTOKEY);
			
			Map REQ_DATA = new HashMap();
			Map RES_DATA = new HashMap();
			
			/**************************************************
			 * 결제 정보
			 **************************************************/
			REQ_DATA.put("TID", rtnOdinfoxm.getPAY_MDKY());
			
			/**************************************************
			 * 기본 정보
			 **************************************************/
			REQ_DATA.put("CANCELTYPE", "C");
			REQ_DATA.put("AMOUNT", rtnOdinfoxm.getORDER_AMT());

			/**************************************************
			 * 취소 정보
			 **************************************************/
			REQ_DATA.put("CANCELREQUESTER", "CP_CS_PERSON");
			REQ_DATA.put("CANCELDESC", "Item not delivered");

			REQ_DATA.put("TXTYPE", "CANCEL");
			REQ_DATA.put("SERVICETYPE", "WIRETRANSFER");

			
			RES_DATA = danalFun.CallDanalBank(REQ_DATA, false);
			
			if( RES_DATA.get("RETURNCODE").equals("0000")){
				// 결제 성공 시 작업 진행
		    	mav.addObject("alertMessage", "결제 취소요청이 완료되었습니다.");
		    	
				tb_odinfoxm.setORDER_CON("ORDER_CON_04");
				orderService.cancelObject(tb_odinfoxm);
			} else {
				// 결제 실패 시 작업 진행
		    	mav.addObject("alertMessage", "결제 취소요청이 실패하였습니다.\n  - RETURNCODE = " + (String) RES_DATA.get("RETURNCODE") + " - \nTX Response_msg = " + (String) RES_DATA.get("RETURNMSG"));
			}

			//결제 로그 처리
			try {
				
				TB_ODDNLGXM oddnlgxm = new TB_ODDNLGXM();

				oddnlgxm.setTID((String) RES_DATA.get("O_TID"));
				oddnlgxm.setORDER_NUM(tb_odinfoxm.getORDER_NUM());
				oddnlgxm.setGUBUN("CANCEL");
				oddnlgxm.setRETURNCODE((String) RES_DATA.get("RETURNCODE"));
				oddnlgxm.setRETURNMSG((String) RES_DATA.get("RETURNMSG"));
				oddnlgxm.setAMOUNT((String) RES_DATA.get("AMOUNT"));
				oddnlgxm.setTRANDATE((String) RES_DATA.get("TRANDATE"));
				oddnlgxm.setTRANTIME((String) RES_DATA.get("TRANTIME"));
				oddnlgxm.setCARDCODE("");
				oddnlgxm.setCARDNAME("");
				oddnlgxm.setCARDAUTHNO("");
				oddnlgxm.setBYPASSVALUE((String) RES_DATA.get("TID"));
		    	
				orderService.danalLogInsert(oddnlgxm);
				
			}catch(Exception e){
				logger.info("Danal Logging Error : " + e.toString());
			}
		    
		}else{
	    	mav.addObject("alertMessage", "결제 취소요청이 완료되었습니다.");

			tb_odinfoxm.setORDER_CON("ORDER_CON_04");
			orderService.cancelObject(tb_odinfoxm);
		}


		mav.addObject("gubun", "popup");
		mav.addObject("returnUrl", servletContextPath.concat("/order/view/" + tb_odinfoxm.getORDER_NUM()));
		mav.setViewName("alertMessage");

		return mav;
		
		//RedirectView rv = new RedirectView(servletContextPath.concat("/order/view/" + tb_odinfoxm.getORDER_NUM()));
		//return new ModelAndView(rv);
	}
	
	@RequestMapping(value={ "/orderCancel2" }, method=RequestMethod.GET)
	public ModelAndView cancel2(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		return new ModelAndView("popup.layout", "jsp", "mall/order/orderCancel2");
	}
	
	@RequestMapping(value={ "/updateDelete" }, method=RequestMethod.GET)
	public ModelAndView updateDelete(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		
		for(int i=0;i<arrayParams.size();i++){	//여기서 업데이트
			String num = arrayParams.get(i);
			tb_odinfoxm.setORDER_NUM(num);
			orderService.orderUpdateDelete(tb_odinfoxm);
		
		}
		return new ModelAndView("mallNew.layout", "jsp", "mall/order/list");
	}
	
	//장바구니에 저장
	@RequestMapping(value="/insertBsktAjax", method=RequestMethod.POST)
	public void insertBsktAjax(@ModelAttribute TB_ODINFOXD tb_odinfoxd, Model model, HttpServletRequest request) throws Exception {

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");

		for(int i=0; i<tb_odinfoxd.getPD_CODES().length; i++){
			
			TB_BKINFOXM tb_bkinfoxm = new TB_BKINFOXM();
			tb_bkinfoxm.setREGP_ID(loginUser.getMEMB_ID());
			tb_bkinfoxm.setPD_CODE(tb_odinfoxd.getPD_CODES()[i]);
			tb_bkinfoxm.setPD_QTY(tb_odinfoxd.getORDER_QTYS()[i]);
			
			tb_bkinfoxm.setOPTION1_NAME(tb_odinfoxd.getOPTION1_NAMES()[i]);
			tb_bkinfoxm.setOPTION1_VALUE(tb_odinfoxd.getOPTION1_VALUES()[i]);
			tb_bkinfoxm.setOPTION2_NAME(tb_odinfoxd.getOPTION2_NAMES()[i]);
			tb_bkinfoxm.setOPTION2_VALUE(tb_odinfoxd.getOPTION2_VALUES()[i]);
			
			int cnt = productService.basketSelect(tb_bkinfoxm);
			
			if(cnt <= 0 ){
				if(tb_odinfoxd.getPD_CUT_SEQS().length==0||tb_odinfoxd.getPD_CUT_SEQS()[i]==null||tb_odinfoxd.getPD_CUT_SEQS()[i].equals("")){
					tb_bkinfoxm.setPD_CUT_SEQ("");
				}else{
					tb_bkinfoxm.setPD_CUT_SEQ(tb_odinfoxd.getPD_CUT_SEQS()[i]);
				}
				
				if(tb_odinfoxd.getOPTION_CODES().length==0||tb_odinfoxd.getOPTION_CODES()[i]==null||tb_odinfoxd.getOPTION_CODES()[i].equals("")){
					tb_bkinfoxm.setOPTION_CODE("");
				}else{
					tb_bkinfoxm.setOPTION_CODE(tb_odinfoxd.getOPTION_CODES()[i]);
				}				
				
				productService.basketInst(tb_bkinfoxm);
				cnt = 0;
			}
		}
	}

		
	
	
}

