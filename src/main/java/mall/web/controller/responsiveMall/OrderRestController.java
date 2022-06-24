package mall.web.controller.responsiveMall;

import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.ResponseErrorHandler;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

//import lgdacom.XPayClient.XPayClient;
import mall.common.digest.DigestUtils;
import mall.common.util.DanalFunction;
import mall.common.util.DanalFunction2;
import mall.common.util.ExcelDownload;
import mall.common.util.StringUtil;
import mall.web.apiLink.AtomyAzaAPI;
import mall.web.controller.DefaultController;
import mall.web.controller.admin.CategoryMgrController;
import mall.web.domain.TB_BKINFOXM;
import mall.web.domain.TB_LGUPLUS;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODDNLGXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_PDSHIPXD;
import mall.web.domain.TB_PDSHIPXM;
import mall.web.domain.TB_SHIPTEXD;
import mall.web.domain.TB_SHIPTEXM;
import mall.web.domain.TB_SPINFOXM;
import mall.web.service.admin.impl.ProductMgrService;
import mall.web.service.admin.impl.SupplierMgrService;
import mall.web.service.mall.MemberService;
import mall.web.service.mall.OrderService;
import mall.web.service.mall.ProductService;

@Controller
@RequestMapping(value="/m/order")
public class OrderRestController extends DefaultController{
	
	private static final Logger logger = LoggerFactory.getLogger(OrderRestController.class);

	private final RestTemplate restTemplate = new RestTemplate();

	private final ObjectMapper objectMapper = new ObjectMapper();
	
	private final String SECRET_KEY = "live_sk_OAQ92ymxN34jBkzPKL4rajRKXvdk";
	 
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
	
	@Resource(name="productMgrService")
	ProductMgrService productMgrService;
	
	PaymentController paycon;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문목록
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/wishList", method=RequestMethod.GET)
	public ModelAndView index(@ModelAttribute TB_ODINFOXM tb_odinfoxm,  HttpServletRequest request, Model model) throws Exception {
		// 로그인 체크
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		int pageNum = 1;
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}

		if(loginUser == null){			
//			ModelAndView mav = new ModelAndView();
//			mav.addObject("alertMessage", "로그인 후 이용해주세요.");
//			mav.addObject("returnUrl", "/m/user/loginForm");
//			mav.setViewName("alertMessage");
//			return mav;
			loginUser = new TB_MBINFOXM();
			loginUser.setMEMB_ID("Non-member");
		}else{
			
		}
			// 페이징 단위
			/*
			if(request.getParameter("pagerMaxPageItems") != null){
				tb_odinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
				tb_odinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			}else {
				tb_odinfoxm.setRowCnt(20);
				tb_odinfoxm.setPagerMaxPageItems(20);
			}
			*/

			// 리스트 개수 3개로 제한
			tb_odinfoxm.setRowCnt(5);
			tb_odinfoxm.setPagerMaxPageItems(5);
			
			tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
			tb_odinfoxm.setCount(orderService.getObjectCount(tb_odinfoxm));			
			tb_odinfoxm.setList(orderService.getObjectOrderList(tb_odinfoxm));
			//tb_odinfoxm.setList(orderService.getObjectWishList(tb_odinfoxm));
			
			// 리스트 개수
			/*
			int listCount = orderService.getObjectCount(tb_odinfoxm);
			if(listCount == 0) listCount = 1;
			
			int pageLimit = 10;	// 페이지 하단에 보여질 페이지 수
			int listLimit = 3;  // 한 페이지에 보여질 리스트 최대 수
			int maxPage;	    // 전체 페이지의 마지막 페이지
			int startPage;		// 페이지 하단에 보여질 시작 페이지
			int endPage; 		// 페이지 하단에 보여질 끝 페이지
			
			
			maxPage= (int)Math.ceil((double)listCount / listLimit);
			startPage= (pageNum - 1) / pageLimit * pageLimit + 1;
			endPage= startPage + pageLimit - 1;
			if(maxPage < endPage) endPage = maxPage;
			
			model.addAttribute("pageLimit", pageLimit);
			model.addAttribute("listLimit", listLimit);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", tb_odinfoxm);
			*/

			//tb_odinfoxm.setPagerOffset((tb_odinfoxm.getPageNum()-1)*tb_odinfoxm.getRowCnt());
			
			model.addAttribute("obj", tb_odinfoxm);			
			model.addAttribute("rowCnt", tb_odinfoxm.getRowCnt());
			model.addAttribute("totalCnt", tb_odinfoxm.getCount());
			//model.addAttribute("totalPage", (int)Math.ceil((double)(tb_odinfoxm.getCount())/3));
			
			String strLink = null;
			strLink = "&datepickerStr=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerStr())
					+ "&datepickerEnd=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerEnd());
					
			model.addAttribute("link", strLink);
			
			return new ModelAndView("mall.responsive.layout", "jsp", "order/list");
//		}
	}
	
	/* 환불/반품 조회 JSP 추가 - 이유리 */
	@RequestMapping(value="/exchange", method=RequestMethod.GET)
	public ModelAndView exchange(@ModelAttribute TB_ODINFOXM tb_odinfoxm,
								 HttpServletRequest request, Model model) throws Exception {
		// 로그인 체크
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		int pageNum = 1;
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}

		if(loginUser == null){			
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "로그인 후 이용해주세요.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");
			return mav;			
		}else{
			
			// 리스트 개수 5개로 제한
			tb_odinfoxm.setRowCnt(5);
			tb_odinfoxm.setPagerMaxPageItems(5);
			
			tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
			System.out.println("REGP_ID : " + tb_odinfoxm.getREGP_ID());
			tb_odinfoxm.setCount(orderService.getExchangeObjectCount(tb_odinfoxm));			
			tb_odinfoxm.setList(orderService.getExchangeObjectList(tb_odinfoxm));
			
			model.addAttribute("obj", tb_odinfoxm);			
			model.addAttribute("rowCnt", tb_odinfoxm.getRowCnt());
			model.addAttribute("totalCnt", tb_odinfoxm.getCount());
			
			String strLink = null;
			strLink = "&datepickerStr=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerStr())
					+ "&datepickerEnd=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerEnd());
					
			
			model.addAttribute("link", strLink);
			
			return new ModelAndView("mall.responsive.layout", "jsp", "order/exchange");
		}
	}
	
	/* 주문상세 JSP 추가 - 이유리 */
	@RequestMapping(value="/detail/{ORDER_NUM}", method=RequestMethod.GET)
	public ModelAndView detail(@ModelAttribute TB_ODINFOXM tb_odinfoxm, String CANCEL, String REFUND, String CONFIRM,
								 HttpServletRequest request, Model model) throws Exception {
		//String viewJsp = "order/detail";
		
		//세션변경
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		//배송지정보
		TB_ODDLAIXM tb_oddlaixm = (TB_ODDLAIXM)orderService.getDeliveryInfo(tb_odinfoxm);
		//주문정보
		tb_odinfoxm = (TB_ODINFOXM)orderService.getMasterInfo(tb_odinfoxm);
		
		if(StringUtils.isNotEmpty(CANCEL)){
			tb_odinfoxm.setCANCEL(CANCEL);
		}
		
		if(StringUtils.isNotEmpty(REFUND)){
			tb_odinfoxm.setREFUND(REFUND);
		}
		
		if(StringUtils.isNotEmpty(CONFIRM)){ 
			tb_odinfoxm.setCONFIRM(CONFIRM);
		}
		
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		//주문상품
		tb_odinfoxm.setList(orderService.getDetailsList(tb_odinfoxm));
		
		//배송비 계산 - 이유리
		int DLVY_AMT = orderService.getNewDlvyAmt(tb_odinfoxm);
		model.addAttribute("DLVY_AMT", DLVY_AMT);
		
		//주문금액 계산 - 이유리
		List<TB_ODINFOXM> list = new ArrayList<TB_ODINFOXM>();
		list = (List<TB_ODINFOXM>)orderService.getSuprProductAmt(tb_odinfoxm);
		int ORDER_AMT = 0;
		
		for(TB_ODINFOXM index : list) {
			ORDER_AMT += Integer.parseInt(index.getSUPR_AMT());
		}
		
		model.addAttribute("ORDER_AMT", ORDER_AMT);
		
		if(!loginUser.getMEMB_ID().equals(tb_odinfoxm.getMEMB_ID())){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "주문자와 로그인 정보가 일치하지 않습니다.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		model.addAttribute("tb_oddlaixm", tb_oddlaixm);
		model.addAttribute("tb_mbinfoxm", loginUser);
		
		
		/*
		if("ORDER_CON_07".equals(tb_odinfoxm.getORDER_CON()) || "ORDER_CON_10".equals(tb_odinfoxm.getORDER_CON())) {
			viewJsp = "order/refund";
		}*/
		
		return new ModelAndView("mall.responsive.layout", "jsp", "order/detail");
	}
	
	/* 반품상세 JSP 추가 - 이유리 */
	@RequestMapping(value="/refund/{ORDER_NUM}", method=RequestMethod.POST)
	public ModelAndView refund(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		
		String PD_CODE = tb_odinfoxm.getPD_CODE();
		
		//세션변경
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		//배송지정보
		TB_ODDLAIXM tb_oddlaixm = (TB_ODDLAIXM)orderService.getDeliveryInfo(tb_odinfoxm);
		//주문정보
		tb_odinfoxm = (TB_ODINFOXM)orderService.getMasterInfo(tb_odinfoxm);
		
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		tb_odinfoxm.setPD_CODE(PD_CODE);
		//주문상품
		tb_odinfoxm.setList(orderService.getDetailsList(tb_odinfoxm));
		
		if(!loginUser.getMEMB_ID().equals(tb_odinfoxm.getMEMB_ID())){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "주문자와 로그인 정보가 일치하지 않습니다.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		model.addAttribute("tb_oddlaixm", tb_oddlaixm);
		model.addAttribute("tb_mbinfoxm", loginUser);
		
		return new ModelAndView("mall.responsive.layout", "jsp", "order/refund");
	}
	
	/* 배송 조회 팝업 - 이유리 */
	@RequestMapping(value = {"/deliveryPopup"}, method = RequestMethod.GET)
	public ModelAndView deliveryPopup(Model model, HttpServletRequest request) throws Exception{
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		TB_ODINFOXM tb_odinfoxm = new TB_ODINFOXM();
		
		String ORDER_NUM = request.getParameter("order_num");
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		tb_odinfoxm.setORDER_NUM(ORDER_NUM);
		
		tb_odinfoxm = (TB_ODINFOXM)orderService.getOrderInfo(tb_odinfoxm);
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		
		TB_ODINFOXD tb_odinfoxd = new TB_ODINFOXD();
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setORDER_NUM(ORDER_NUM);
		tb_odinfoxd.setList(orderService.getDetailsList(tb_odinfoxm));
		
		model.addAttribute("tb_odinfoxd", tb_odinfoxd);
		
		return new ModelAndView("popup.layout", "jsp", "responsiveMall/order/deliveryPopup");
	}
	
	/* 반품 팝업 - 이유리 */
	@RequestMapping(value = {"/refundPopup"}, method = RequestMethod.POST)
	public ModelAndView refundPopup(Model model, HttpServletRequest request ) throws Exception{

		return new ModelAndView("popup.layout", "jsp", "responsiveMall/order/refundPopup");
	}
	
	/* 주문상태 변경 - 이유리 */
	@RequestMapping(value={"/updateOrder"}, method = RequestMethod.POST)
	@ResponseBody
	public String updateOrder(@ModelAttribute TB_ODINFOXM tb_odinfoxm, 
							  @ModelAttribute TB_ODINFOXD tb_odinfoxd,
							  HttpServletRequest request) throws Exception {
		
		
		TB_ODINFOXM od = (TB_ODINFOXM) orderService.getPayMdky(tb_odinfoxm);
		tb_odinfoxm.setPAY_MDKY(od.getPAY_MDKY());
		System.out.println("PAY_MDKY 주문키 : "+tb_odinfoxm.getPAY_MDKY());
		 
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setMODP_ID(loginUser.getMEMB_ID());
		
		int size = tb_odinfoxd.getPD_CODES().length;
		int total = 0;
		int total2 = 0;
		int result2 = 0;
		int refundAmt = 0;
		int ALL_DLVY_AMT = 0;
		int ALL_ORDER_AMT = 0;
		int RFND_AMT = 0;
		
		if(tb_odinfoxm.getSTATUS().equals("CANCEL")) {
			tb_odinfoxm.setORDER_CON("ORDER_CON_04");
			tb_odinfoxm.setCNCL_CON("CNCL_CON_03");
			
			ALL_DLVY_AMT = Integer.parseInt(tb_odinfoxm.getDLVY_AMT());
			System.out.println("ALL_DLVY_AMT : " + ALL_DLVY_AMT);
			ALL_ORDER_AMT = Integer.parseInt(tb_odinfoxm.getORDER_AMT()) - ALL_DLVY_AMT;
			System.out.println("ALL_ORDER_AMT : " + ALL_ORDER_AMT);
			
			//환불금액
			if(StringUtils.isNotEmpty(tb_odinfoxm.getRFND_AMT())) {
	        	RFND_AMT = Integer.parseInt(tb_odinfoxm.getRFND_AMT());
	        }
			
			System.out.println("RFND_AMT : " + RFND_AMT);
			
			/* 결제금액 & 배송비 재계산 - 이유리 */
			List<TB_ODINFOXM> list = new ArrayList<TB_ODINFOXM>();
			list = (List<TB_ODINFOXM>)orderService.getSuprProductAmt(tb_odinfoxm);
			int CNT = 0;
			int SUPR_AMT = 0;
			String SETPD_CODE = "";
			int ALL_SUPR_AMT = 0;
			
			for(TB_ODINFOXM index : list) {
				CNT = Integer.parseInt(index.getCNT());			 	 		 // 묶음상품 개수
				ALL_SUPR_AMT = Integer.parseInt(index.getSUPR_AMT());		 // 공급사 상품 총액
				SUPR_AMT = Integer.parseInt(index.getSUPR_AMT());			 // 묶음상품 금액
				SETPD_CODE = index.getSETPD_CODE();							 // 묶음상품 코드
				int COUNT = 0;
				
				for(int i = 0; i < size; i++) {
					//묶음상품코드가 같을 때
					if(SETPD_CODE.equals(tb_odinfoxd.getSETPD_CODES()[i])) {
						//상품 금액
						SUPR_AMT = SUPR_AMT - Integer.parseInt(tb_odinfoxm.getPD_COSTS()[i]);
						COUNT++;
						
						
						//배송비 마스터 가져오기
						TB_PDSHIPXM tb_pdshipxm = new TB_PDSHIPXM();
						tb_pdshipxm.setPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
						tb_pdshipxm = (TB_PDSHIPXM)productMgrService.getShipMaster(tb_pdshipxm);
						
						//배송비 개별
						if(tb_pdshipxm.getSHIP_CONFIG().equals("SHIP_CONFIG_02")) {
							//배송비 디테일 가져오기
							if(tb_pdshipxm.getSHIP_GUBN().equals("SHIP_GUBN_03") || tb_pdshipxm.getSHIP_GUBN().equals("SHIP_GUBN_04")) {
								TB_PDSHIPXD tb_pdshipxd = new TB_PDSHIPXD();
								List<TB_PDSHIPXD> list2 = new ArrayList<TB_PDSHIPXD>();
								tb_pdshipxd.setPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
								list2 = (List<TB_PDSHIPXD>)productMgrService.getShipDetail(tb_pdshipxd);
								
								for(TB_PDSHIPXD index2 : list2) {
									String PD_CODE = index2.getPD_CODE();
									int GUBN_START = Integer.parseInt(index2.getGUBN_START());
									int GUBN_END = Integer.parseInt(index2.getGUBN_END());
									int DLVY_AMT = Integer.parseInt(index2.getDLVY_AMT());
									
									//구매금액별
									if(tb_pdshipxm.getSHIP_GUBN().equals("SHIP_GUBN_03")) {
										if(tb_odinfoxd.getSETPD_CODES()[i].equals(PD_CODE)) {
											if(SUPR_AMT != 0) {
												if((SUPR_AMT > GUBN_START || SUPR_AMT == GUBN_START) && SUPR_AMT < GUBN_END) {
													tb_odinfoxd.setDLVY_AMT(DLVY_AMT + "");
													tb_odinfoxd.setSETPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
													orderService.updateDlvyAmt(tb_odinfoxd);
												}
											} else {
												tb_odinfoxd.setDLVY_AMT("0");
												tb_odinfoxd.setSETPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
												orderService.updateDlvyAmt(tb_odinfoxd);
											}
										}
									//상품수량별
									} else {
										if(tb_odinfoxd.getSETPD_CODES()[i].equals(PD_CODE)) {
											if(CNT - COUNT != 0) {
												if(((CNT - COUNT) > GUBN_START || (CNT - COUNT) == GUBN_START) && (CNT - COUNT) < GUBN_END) {
													tb_odinfoxd.setDLVY_AMT(DLVY_AMT + "");
													tb_odinfoxd.setSETPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
													orderService.updateDlvyAmt(tb_odinfoxd);
												}
											} else {
												tb_odinfoxd.setDLVY_AMT("0");
												tb_odinfoxd.setSETPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
												orderService.updateDlvyAmt(tb_odinfoxd);
											}
										}
									}
								}
							//조건부무료배송
							} else if(tb_pdshipxm.getSHIP_GUBN().equals("SHIP_GUBN_02")) {
								if(SUPR_AMT != 0) {
									if(SUPR_AMT < Integer.parseInt(tb_pdshipxm.getGUBN_START())) {
										tb_odinfoxd.setDLVY_AMT(tb_pdshipxm.getDLVY_AMT());
										tb_odinfoxd.setSETPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
										orderService.updateDlvyAmt(tb_odinfoxd);
									}
								} else {
									tb_odinfoxd.setDLVY_AMT("0");
									tb_odinfoxd.setSETPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
									orderService.updateDlvyAmt(tb_odinfoxd);
								}
							}
						//배송비 템플릿
						} else if(tb_pdshipxm.getSHIP_CONFIG().equals("SHIP_CONFIG_03")) {
							TB_SHIPTEXM tb_shiptexm = new TB_SHIPTEXM();
							tb_shiptexm.setTEMP_NUM(tb_pdshipxm.getTEMP_NUM());
							tb_shiptexm.setSUPR_ID(tb_pdshipxm.getSUPR_ID());
							tb_shiptexm.setREGP_ID(loginUser.getMEMB_ID());
							tb_shiptexm = (TB_SHIPTEXM)productMgrService.getTempMaster(tb_shiptexm);
							
							//배송비 디테일 가져오기
							if(tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_03") || tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_04")) {
								TB_SHIPTEXD tb_shiptexd = new TB_SHIPTEXD();
								List<TB_SHIPTEXD> list2 = new ArrayList<TB_SHIPTEXD>();
								tb_shiptexd.setTEMP_NUM(tb_pdshipxm.getTEMP_NUM());
								list2 = (List<TB_SHIPTEXD>)productMgrService.getTempDetail(tb_shiptexd);
								
								for(TB_SHIPTEXD index2 : list2) {
									String TEMP_NUM = index2.getTEMP_NUM();
									int GUBN_START = Integer.parseInt(index2.getGUBN_START());
									int GUBN_END = Integer.parseInt(index2.getGUBN_START());
									int DLVY_AMT = Integer.parseInt(index2.getDLVY_AMT());
									//구매금액별
									if(tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_03")) {
										if(tb_shiptexd.getTEMP_NUM().equals(TEMP_NUM)) {
											if(SUPR_AMT != 0) {
												if((SUPR_AMT > GUBN_START || SUPR_AMT == GUBN_START) && SUPR_AMT < GUBN_END) {
													tb_odinfoxd.setDLVY_AMT(DLVY_AMT + "");
													tb_odinfoxd.setSETPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
													orderService.updateDlvyAmt(tb_odinfoxd);
												}
											} else {
												tb_odinfoxd.setDLVY_AMT("0");
												tb_odinfoxd.setSETPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
												orderService.updateDlvyAmt(tb_odinfoxd);
											}
										}
									//상품수량별
									} else {
										if(tb_shiptexd.getTEMP_NUM().equals(TEMP_NUM)) {
											if(CNT - COUNT != 0) {
												if(((CNT - COUNT) > GUBN_START || (CNT - COUNT) == GUBN_START) && (CNT - COUNT) < GUBN_END) {
													tb_odinfoxd.setDLVY_AMT(DLVY_AMT + "");
													tb_odinfoxd.setSETPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
													orderService.updateDlvyAmt(tb_odinfoxd);
												}
											} else {
												tb_odinfoxd.setDLVY_AMT("0");
												tb_odinfoxd.setSETPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
												orderService.updateDlvyAmt(tb_odinfoxd);
											}
										}
									}
								}
							//조건부무료배송
							} else if(tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_02")) {
								if(SUPR_AMT != 0) {
									if(SUPR_AMT < Integer.parseInt(tb_pdshipxm.getGUBN_START())) {
										tb_odinfoxd.setDLVY_AMT(tb_shiptexm.getDLVY_AMT());
										tb_odinfoxd.setSETPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
										orderService.updateDlvyAmt(tb_odinfoxd);
									}
								} else {
									tb_odinfoxd.setDLVY_AMT("0");
									tb_odinfoxd.setSETPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
									orderService.updateDlvyAmt(tb_odinfoxd);
								}
							}
						//배송비 기본
						} else {
							if(SUPR_AMT != 0) {
								if(SUPR_AMT < Integer.parseInt(tb_pdshipxm.getGUBN_START())) {
									tb_odinfoxd.setDLVY_AMT(tb_pdshipxm.getDLVY_AMT());
									tb_odinfoxd.setSETPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
									orderService.updateDlvyAmt(tb_odinfoxd);
								}
							} else {
								tb_odinfoxd.setDLVY_AMT("0");
								tb_odinfoxd.setSETPD_CODE(tb_odinfoxd.getSETPD_CODES()[i]);
								orderService.updateDlvyAmt(tb_odinfoxd);
							}
						}
					}
					
				}
			}
			
			for(int i = 0; i < size; i++) {
				refundAmt += Integer.parseInt(tb_odinfoxm.getPD_COSTS()[i]);
			}
			
			ALL_ORDER_AMT = ALL_ORDER_AMT - refundAmt;
			System.out.println("취소상품 뺀 상품가격 : " + ALL_ORDER_AMT);
			
		} else if(tb_odinfoxm.getSTATUS().equals("REFUND")) {
			tb_odinfoxm.setORDER_CON("ORDER_CON_10");
			tb_odinfoxm.setRFND_CON("RFND_CON_01");
		} else if(tb_odinfoxm.getSTATUS().equals("CONFIRM")) {
			tb_odinfoxm.setORDER_CON("ORDER_CON_08");
		}
		
	    for(int i=0; i<size; i++) {
	    	tb_odinfoxm.setPD_CODE(tb_odinfoxd.getPD_CODES()[i]);
	    	
	    	if(tb_odinfoxm.getSTATUS().equals("CANCEL")) {
	    		tb_odinfoxm.setRFND_AMT(tb_odinfoxm.getPD_COSTS()[i]);
	    	}
	    	
			if(tb_odinfoxd.getOPTION1_VALUES().length != 0) {
				tb_odinfoxm.setOPTION1_VALUE(tb_odinfoxd.getOPTION1_VALUES()[i]);
			} else {
				tb_odinfoxm.setOPTION1_VALUE("");
			}
			
			if(tb_odinfoxd.getOPTION2_VALUES().length != 0) {
				tb_odinfoxm.setOPTION2_VALUE(tb_odinfoxd.getOPTION2_VALUES()[i]); 
			} else {
				tb_odinfoxm.setOPTION2_VALUE("");
			}
			
			if(tb_odinfoxd.getOPTION3_VALUES().length != 0) {
				tb_odinfoxm.setOPTION3_VALUE(tb_odinfoxd.getOPTION3_VALUES()[i]); 
			} else {
				tb_odinfoxm.setOPTION3_VALUE("");
			}
			
	    	int result1 = orderService.updateObjects(tb_odinfoxm);
	    	
	    	if(result1 == 1) {
	    		total++;
	    	}
	    }
	    
	    System.out.println("refundAmt은 얼마? : " + refundAmt);
		//배송비 새로 가져오기
		int NEW_DLVY_AMT = orderService.getNewDlvyAmt(tb_odinfoxm);
		System.out.println("NEW_DLVY_AMT은 얼마? : " + NEW_DLVY_AMT);
		tb_odinfoxm.setDLVY_AMT(NEW_DLVY_AMT + "");
		//최종결제금액
		ALL_ORDER_AMT = ALL_ORDER_AMT + NEW_DLVY_AMT;
		System.out.println("최종 ORDER_AMT은 얼마? : " + ALL_ORDER_AMT);
		
		int FINAL_AMT = NEW_DLVY_AMT - ALL_DLVY_AMT;
		System.out.println("FINAL_AMT은 얼마? : " + FINAL_AMT);
		// 최종 배송비
		refundAmt -= FINAL_AMT;
		
		System.out.println("refundAmt : "+refundAmt);
		int result = 0;
		String reason = "고객의 요청으로 취소";
		String cancelAmt = refundAmt+""; //취소금액
			
	    
	    // api 응답이왔을 때 update
		if(tb_odinfoxm.getSTATUS().equals("CANCEL")) {
	        Map<String, String> payloadMap = new HashMap<>();
	        payloadMap.put("cancelReason", reason);
	        //부분취소 
	        System.out.println("환불금액 / 주문금액 ");
	        System.out.println(refundAmt);
	        System.out.println(Integer.parseInt(tb_odinfoxm.getORDER_AMT()));
	        if(refundAmt <= Integer.parseInt(tb_odinfoxm.getORDER_AMT()));
	        payloadMap.put("cancelAmount", cancelAmt);
	        
	        // 무통장일 경우 
	        if(tb_odinfoxm.getPAY_METD() == "SC0040") {
	        	Map<String, String> refundReceiveAccount = new HashMap<>();
	        	refundReceiveAccount.put("bank", "");                           // 환불받을 계좌 은행
	        	refundReceiveAccount.put("accountNumber", "");                  // 환불받을 계좌 번호 
	        	refundReceiveAccount.put("holderName", "");                     // 환불받을 계좌 예금주 
	        	payloadMap.put("refundReceiveAccount", refundReceiveAccount.toString());
	        }
	        
	        HttpHeaders headers = new HttpHeaders();
	        headers.set("Authorization", "Basic " + Base64.getEncoder().encodeToString((SECRET_KEY + ":").getBytes()));
	        headers.setContentType(MediaType.APPLICATION_JSON);
	        HttpEntity<String> request1 = new HttpEntity<>(objectMapper.writeValueAsString(payloadMap), headers);
	        
	        System.out.println("PAY_MDKY : "+tb_odinfoxm.getPAY_MDKY());
	        String mdky = tb_odinfoxm.getPAY_MDKY();
	        ResponseEntity<JsonNode> responseEntity = restTemplate.postForEntity(
	                "https://api.tosspayments.com/v1/payments/"+mdky+"/cancel", request1, JsonNode.class);
	        if (responseEntity.getStatusCode() == HttpStatus.OK) {
	        	TB_LGUPLUS tb_lguplus = new TB_LGUPLUS();
	        	
	            JsonNode successNode = responseEntity.getBody();
	            System.out.println("successNode : " + successNode);
	            JSONObject jsonNode = new JSONObject(successNode.toString());
	            
	            Object paymentKey = jsonNode.get("paymentKey");
	            Object method = jsonNode.get("method");
	            Object status = jsonNode.get("status");
	            Object requestedAt = jsonNode.get("requestedAt");
	            Object approvedAt = jsonNode.get("approvedAt");
	            Object totalAmount = jsonNode.get("totalAmount");
	            Object balanceAmount = jsonNode.get("balanceAmount");
	            if(method.toString().equals("휴대폰")) {
	            	JSONObject mobilePhone = new JSONObject(jsonNode.get("mobilePhone").toString());
		            Object carrier = mobilePhone.get("carrier");
		            Object customerMobilePhone = mobilePhone.get("customerMobilePhone");
		            Object settlementStatus = mobilePhone.get("settlementStatus");
		            
		            tb_lguplus.setLGD_FINANCECODE(carrier.toString()); 						// 은행코드 
				    tb_lguplus.setLGD_FINANCENAME(customerMobilePhone.toString()); 
	            }else if(method.toString().equals("카드")) {
	            	JSONObject card = new JSONObject(jsonNode.get("card").toString());
		            Object approveNo = card.get("approveNo");
		            Object company = card.get("company");
		            Object number = card.get("number");	
		            
		            tb_lguplus.setLGD_FINANCECODE(company.toString()); 						// 은행코드 
				    tb_lguplus.setLGD_FINANCENAME(number.toString()); 						// 은행명
	            }else if(method.toString().equals("가상계좌")) {
	            	
	            }else if(method.toString().equals("계좌이체")) {
	            	
	            }
	            
	            
	            
	            System.out.println("cancels : " + jsonNode.get("cancels").toString());
	            JSONArray cancelsArr = new JSONArray(jsonNode.get("cancels").toString());
	            JSONObject cancels = cancelsArr.getJSONObject(0);
	            Object cancelAmount = cancels.get("cancelAmount");
	            Object refundableAmount = cancels.get("refundableAmount");
	            Object canceledAt = cancels.get("canceledAt");
	            
	            
	            
	            try {
				    //결제 로그 처리
			    	
			    	tb_lguplus.setLGD_TID(paymentKey.toString()); 					//결과 코드 
				    tb_lguplus.setLGD_OID(tb_odinfoxm.getORDER_NUM());
				    tb_lguplus.setGUBUN("CANCEL");
				    tb_lguplus.setLGD_RESPCODE("0000"); 							// 응답 코드 
				    tb_lguplus.setLGD_RESPMSG("결제 취소");  							// 응답 메시지 
				    tb_lguplus.setLGD_PAYTYPE(method.toString());					// 결제 방식 
				    tb_lguplus.setSTATE(status.toString()); 						// 상태? 
				    tb_lguplus.setLGD_PAYDATE(canceledAt.toString()); 						// 취소날짜 
				    tb_lguplus.setLGD_AMOUNT(cancelAmount.toString()); 				// 금액
				    System.out.println("결제 취소 금액 : " +( Integer.parseInt(totalAmount.toString()) - Integer.parseInt(balanceAmount.toString()))+"");
				    
				    if(tb_lguplus.getLGD_TID() != null) {
						orderService.lguplusLogInsert(tb_lguplus);
				    }
				    
				    
					
				}catch(Exception e){
					logger.info("LgUplus Logging Error : " + e.toString());
				}
	            
	            System.out.println("기존 취소금액 : " + RFND_AMT);
	            
	            tb_odinfoxm.setRFND_AMT(RFND_AMT + refundAmt + "");
		    	result2 = orderService.updateObject(tb_odinfoxm);
		    	result = total + result2;
		    	 
		    	System.out.println("결제취소 성공");
		    	System.out.println("total : " + total);
		 		System.out.println("result2 : " + result2);
		 		System.out.println("최종값 : " + result);
		 		
		 		return result+"";
	        } else {
	        	//ORDER_CON 되돌리기
	        	for(int i=0; i<size; i++) {
	        		tb_odinfoxm.setORDER_CON("ORDER_CON_02");
	        		tb_odinfoxm.setCNCL_CON("");
	        		tb_odinfoxm.setRFND_AMT("0");
	    	    	int result1 = orderService.updateObjects(tb_odinfoxm);
	    	    	if(result1 == 1) {
	    	    		total2++;
	    	    	}
	    	    }
	        	
		    	System.out.println("결제취소 실패");
		    	System.out.println("total2 : " + total2);
		 		System.out.println("최종값 : " + result);
	        	
	            JsonNode failNode = responseEntity.getBody();
	            RedirectView redirectView = new RedirectView(servletContextPath+"/m/order/fail");
	            return "0";
	        }
		}else {
			// 취소가 아닐 경우
	    	result2 = orderService.updateObject(tb_odinfoxm);
	    	result = total + result2;
		    	 
			return result+"";
		}
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
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
		String viewJsp = "order/view";
		String loginId = "Non-member";
		//세션변경
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		if(loginUser != null) {
			System.out.println("aasdadasdasdasd");
			loginId=loginUser.getMEMB_ID();
		}
		//배송지정보
		TB_ODDLAIXM tb_oddlaixm = (TB_ODDLAIXM)orderService.getDeliveryInfo(tb_odinfoxm);
		//주문정보
		tb_odinfoxm = (TB_ODINFOXM)orderService.getMasterInfo(tb_odinfoxm);
		//주문상품
		/* 이유리 추가 */
		System.out.println("loginUser.getMEMB_ID() : " + loginId);
		tb_odinfoxm.setREGP_ID(loginId);
		tb_odinfoxm.setList(orderService.getDetailsList(tb_odinfoxm));
		if(!loginId.equals(tb_odinfoxm.getMEMB_ID())){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "주문자와 로그인 정보가 일치하지 않습니다.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		model.addAttribute("tb_oddlaixm", tb_oddlaixm);
		model.addAttribute("tb_mbinfoxm", loginUser);
		model.addAttribute("method",tb_odinfoxm.getPAY_METD_NM());
		if("ORDER_CON_07".equals(tb_odinfoxm.getORDER_CON()) || "ORDER_CON_10".equals(tb_odinfoxm.getORDER_CON())) {
			viewJsp = "order/refund";
		}
		
		return new ModelAndView("mall.responsive.layout", "jsp", viewJsp);
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
	 * @Method	: deliveryAddr
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주소검색
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
		//세션변경
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
		String dlarGubn = tb_oddlaixm.getDLAR_GUBN();
		
		if(dlarGubn.equals("DLAR_GUBN_01")){
			obj = (TB_ODDLAIXM)orderService.getMbDlvyInfo(tb_oddlaixm);
		}else if(dlarGubn.equals("DLAR_GUBN_02")){
			obj = (TB_ODDLAIXM)orderService.getSpDlvyInfo(tb_oddlaixm);
		}else if(dlarGubn.equals("DLAR_GUBN_03")){
			obj = (TB_ODDLAIXM)orderService.getDlvyInfo(tb_oddlaixm);
		}else if(dlarGubn.equals("DLAR_GUBN_05")){
			obj = (TB_ODDLAIXM)orderService.getSfDlvyInfo(tb_oddlaixm);
		}
		
		if(obj == null){
			obj = new TB_ODDLAIXM();
		}
		obj.setDLAR_GUBN(dlarGubn);
		
		return obj;
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
	 * @Method	: dlvyChk
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 배송조회
	 * @Company	: YT Corp.
	 * @Author	: ljs
	 * @Date	: 2020-04-22
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param order_num
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/dlvyChk/{ORDER_NUM}", method=RequestMethod.GET)
	public ModelAndView dlvyChk(@PathVariable("ORDER_NUM") String order_num, Model model, HttpServletRequest request) throws Exception {
		model.addAttribute("info", orderService.getDlvyAddrInfo(order_num));
		model.addAttribute("list", orderService.getDlvyPdList(order_num));
		
		return new ModelAndView("responsiveMall/order/dlvychk");
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
	 * @Method	: newForm
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 신규주문
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/new", method=RequestMethod.POST)
	public ModelAndView newForm(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model, HttpServletRequest request) throws Exception {
		StringTokenizer stok = new StringTokenizer(tb_odinfoxm.getBSKT_REGNO_LIST(),"$");
		List<String> list = new ArrayList<String>();
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			list.add(str);
			System.out.println(str);
		}		
		
		String[] cut_seq_name = tb_odinfoxm.getPD_CUT_SEQ_LIST().split("@@!");
		String[] option_name = tb_odinfoxm.getOPTION_CODE_LIST().split("@@#");
		
		tb_odinfoxm.setList(orderService.getNewObjectList(list));
		String totOrder = tb_odinfoxm.getList().size()+"";
		
//		주문번호 생성  
		String orderNum = orderService.getOrderNum();
		model.addAttribute("orderNum",orderNum);
		
		model.addAttribute("obj", tb_odinfoxm);
		model.addAttribute("totOrder", totOrder);
		model.addAttribute("PD_CUT_SEQ", cut_seq_name);
		model.addAttribute("OPTION_CODE", option_name);
		
		
				
		//배송비 조건
		TB_SPINFOXM supplierInfo = new TB_SPINFOXM();
		supplierInfo.setSUPR_ID("C00001");
		model.addAttribute("supplierInfo", (TB_SPINFOXM)supplierMgrService.getObject(supplierInfo));

		//배송비쿠폰 select
		TB_MBINFOXM tb_mbinfoxm = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		//tb_mbinfoxm = (TB_MBINFOXM) memberService.getObject(tb_mbinfoxm);
		model.addAttribute("mbinfo", tb_mbinfoxm);		
				
		return new ModelAndView("mall.responsive.layout", "jsp", "order/new");
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
	 * @Method	: buy
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 신규주문 (단일상품)
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/buy")
	public ModelAndView buy(@ModelAttribute TB_ODINFOXD tb_odinfoxm, Model model, HttpServletRequest request) throws Exception {

		StringTokenizer stok = new StringTokenizer(tb_odinfoxm.getPD_CODE(),"$");
		List<String> list = new ArrayList<String>();
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			list.add(str);
		}
		System.out.println("EXTRA_PD_CODES : " + tb_odinfoxm.getEXTRA_PD_CODE());
		tb_odinfoxm.setList(orderService.getBuyObjectList(list));
		model.addAttribute("obj", tb_odinfoxm);

		//배송비 조건
		TB_SPINFOXM supplierInfo = new TB_SPINFOXM();
		supplierInfo.setSUPR_ID("C00001");
		model.addAttribute("supplierInfo", (TB_SPINFOXM)supplierMgrService.getObject(supplierInfo));
		
		//배송비쿠폰 select
		TB_MBINFOXM tb_mbinfoxm = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		//tb_mbinfoxm = (TB_MBINFOXM) memberService.getObject(tb_mbinfoxm);
		model.addAttribute("mbinfo", tb_mbinfoxm);		
		
		return new ModelAndView("mall.responsive.layout", "jsp", "order/new");
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
	 * @Method	: buy2
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 신규주문2 (option 상품 추가에 따른 변경 : 상품상세 -> 단일상품구매 기능)
	 * @Company	: YT Corp.
	 * @Author	: ljs
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	
	@RequestMapping(value="/buy2")
	public ModelAndView buy2(@ModelAttribute TB_ODINFOXD tb_odinfoxm, Model model, HttpServletRequest request) throws Exception {
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		if(loginUser == null) {
			tb_odinfoxm.setMEMB_ID("Non-members");
		}else {
			tb_odinfoxm.setMEMB_ID(loginUser.getMEMB_ID());
		}
		
		//묶음상품코드 - 이유리
		model.addAttribute("SETPD_CODE", tb_odinfoxm.getSETPD_CODE());
		
		// 단일상품
		String[] option1 = tb_odinfoxm.getOPTION1().split(",");
		String[] option2 = tb_odinfoxm.getOPTION2().split(",");
		String[] option3 = tb_odinfoxm.getOPTION3().split(",");
		String[] pd_qty = tb_odinfoxm.getPD_QTY().split(",");
		
		int cnt=1;
		int qtys =1;
		System.out.println("tb_odinfoxm.getOPTION1정보 : "+tb_odinfoxm.getOPTION1());
		if(tb_odinfoxm.getOPTION1().length()>0) {
			tb_odinfoxm.setOPTION1_VALUES(tb_odinfoxm.getOPTION1().split(","));
			tb_odinfoxm.setOPTION2_VALUES(tb_odinfoxm.getOPTION2().split(","));
			tb_odinfoxm.setOPTION3_VALUES(tb_odinfoxm.getOPTION3().split(","));
			tb_odinfoxm.setPD_QTYs(tb_odinfoxm.getPD_QTY().split(","));
		
			cnt = tb_odinfoxm.getPD_QTYs().length;
			qtys =0;
					
			List<TB_ODINFOXD> temp = new ArrayList<TB_ODINFOXD>() ;
			for(int i =0;i<cnt;i++) {
				
				tb_odinfoxm.setOPTION1_VALUE(option1[i]);
				if(option2.length >i) {
					tb_odinfoxm.setOPTION2_VALUE(option2[i]);
				}
				if(option3.length>i) {
					tb_odinfoxm.setOPTION3_VALUE(option3[i]);
				}
				tb_odinfoxm.setORDER_QTY(pd_qty[i]);
				
				TB_ODINFOXD tbod = orderService.getPdnOption(tb_odinfoxm);
				tbod.setORDER_QTY(pd_qty[i]);
				qtys += Integer.parseInt(pd_qty[i]);
				temp.add(tbod);
			}
			tb_odinfoxm.setList(temp);
		}else {
			for(int i=0; i<pd_qty.length; i++) {
				tb_odinfoxm.setORDER_QTY(pd_qty[i]);
				tb_odinfoxm.setList(orderService.getBuyOnePd(tb_odinfoxm));
			}
		}
		
		
		TB_ODINFOXD tb_odinfoxd = new TB_ODINFOXD();
		if(tb_odinfoxm.getEXTRA_PD_QTY() != "") {
			List<TB_ODINFOXD> temp = new ArrayList<TB_ODINFOXD>();
			
			String[] ExtraCodeList=request.getParameter("EXTRA_PD_CODE").split(",");
			String[] ExtraQtyList=request.getParameter("EXTRA_PD_QTY").split(",");
			
			for(int i =0; i<ExtraCodeList.length;i++) {
				tb_odinfoxd.setMEMB_ID(loginUser.getMEMB_ID());
				tb_odinfoxd.setEXTRA_PD_CODE(ExtraCodeList[i]);
				tb_odinfoxd.setEXTRA_PD_QTY(ExtraQtyList[i]);
				tb_odinfoxd.setORDER_QTY(tb_odinfoxd.getEXTRA_PD_QTY());
				TB_ODINFOXD addExtraPd = (TB_ODINFOXD)orderService.getBuyExtraPd(tb_odinfoxd);
				System.out.println("addExtraPd 추가상품의 갯수 : "+addExtraPd.getORDER_QTY());
				System.out.println("addExtraPd 추가상품의 코드 : "+addExtraPd.getPD_CODE());
				System.out.println("addExtraPd 추가상품의 이름 : "+addExtraPd.getPD_NAME());
				temp.add(addExtraPd);
			}
			tb_odinfoxd.setList(temp);
		}
		model.addAttribute("extra", tb_odinfoxd);
		
		tb_odinfoxm.setPD_QTY(qtys+"");
		System.out.println("tb_odinfoxm의 상품갯수"+tb_odinfoxm.getORDER_QTY());
		//주문번호 생성 
		String orderNum = orderService.getOrderNum();
		model.addAttribute("orderNum",orderNum);
		model.addAttribute("obj", tb_odinfoxm);
		
		//배송비쿠폰 select
		TB_MBINFOXM tb_mbinfoxm = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		//tb_mbinfoxm = (TB_MBINFOXM) memberService.getObject(tb_mbinfoxm);
		model.addAttribute("mbinfo", tb_mbinfoxm);		
		//배송비 조건
		TB_SPINFOXM supplierInfo = new TB_SPINFOXM();
		supplierInfo.setSUPR_ID("C00001");
		model.addAttribute("supplierInfo", (TB_SPINFOXM)supplierMgrService.getObject(supplierInfo));
		
		return new ModelAndView("mall.responsive.layout", "jsp", "order/new");
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
	 * @Method	: insert
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문서등록
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param tb_odinfoxd
	 * @param tb_oddlaixm
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODINFOXD tb_odinfoxd, @ModelAttribute TB_ODDLAIXM tb_oddlaixm, Model model, HttpServletRequest request) throws Exception {
		// 세션변경
		Map map = new HashMap(); 
		map.put("ORDER_NUM", tb_odinfoxm.getORDER_NUM());

		Map resultMap = orderService.resetOrder(map);
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		if(loginUser == null ) {
			loginUser = new TB_MBINFOXM();
			loginUser.setMEMB_ID("Non-member");
		}
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());		
		tb_odinfoxd.setREGP_ID(loginUser.getMEMB_ID());
		tb_oddlaixm.setREGP_ID(loginUser.getMEMB_ID());
		
		
		
		tb_odinfoxm.setORDER_AMT(request.getParameter("TOTAL_PRICE"));
		System.out.println("마스터금액"+tb_odinfoxm.getORDER_AMT());
		System.out.println("orderController : "+ tb_odinfoxm.getPAY_METD());
		
		try {
			// 주문번호 중복이 없도록 초기화
			
			
			orderService.insertOrderObject(tb_odinfoxm, tb_odinfoxd, tb_oddlaixm);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		//회원정보 배송비쿠폰갯수 UPDATE_20190523
		if(tb_odinfoxm.getCPON_YN() != null && tb_odinfoxm.getCPON_YN().equals("Y")){
			TB_MBINFOXM mbinfoxm = new TB_MBINFOXM();
			mbinfoxm.setMEMB_ID(loginUser.getMEMB_ID());
			mbinfoxm.setREGP_ID(loginUser.getMEMB_ID());
			mbinfoxm.setDLVY_CPON(tb_odinfoxm.getDLVY_CPON());
			
			memberService.updateCponCnt(mbinfoxm);
		}
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/m/order/view/"+tb_odinfoxm.getORDER_NUM());
		return new ModelAndView(redirectView);
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
	 * @Method	: updateDelete
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문삭제
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param checkArray
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/updateDelete" }, method=RequestMethod.GET)
	public ModelAndView updateDelete(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {
		// 세션변경
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
				
		for(int i=0;i<arrayParams.size();i++){
			String num = arrayParams.get(i);
			tb_odinfoxm.setORDER_NUM(num);
			orderService.orderUpdateDelete(tb_odinfoxm);
		}
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/order/list");
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
	 * @Method	: insertBsktAjax
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 장바구니 저장
	 * @Company	: YT Corp.
	 * @Author	: ljs
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param checkArray
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/insertBsktAjax", method=RequestMethod.POST)
	public void insertBsktAjax(@ModelAttribute TB_ODINFOXD tb_odinfoxd, Model model, HttpServletRequest request) throws Exception {
		// 세션정보
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
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
	 * @Method	: excelDown
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 엑셀 다운로드
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/excelDown" }, method=RequestMethod.GET)
	public void excelDown(@ModelAttribute TB_ODINFOXD tb_odinfoxd, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		// 세션변경
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		String[] orderNum = tb_odinfoxd.getORDER_NUM().split(",");
		tb_odinfoxd.setORDER_NUM(orderNum[0]);
		tb_odinfoxd.setREGP_ID(loginUser.getMEMB_ID());
		
		String sheetName = "주문내역 ("+tb_odinfoxd.getORDER_NUM()+")";
		String[] headerName = { "순번","주문번호","제품코드","제품명","규격","세절방식","옵션","판매가","주문수량","주문금액","비고" };
		String[] columnName = { "ORDER_DTNUM","ORDER_NUM","PD_CODE","PD_NAME","STD_UNIT","PD_CUT_SEQ_UNIT","OPTION_NAME","REAL_PRICE","ORDER_QTY","ORDER_AMT","RELATE" };
				
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) orderService.getExcelList(tb_odinfoxd);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
	 * @Method	: state
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문상태 업데이트 -- 월간결제 사용안함
	 * @Company	: YT Corp.
	 * @Author	: chjw
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/stateAjax", method=RequestMethod.POST)
	public void state(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		// 로그인 정보
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		//배송상태 및 결제수단 업데이트
		if(orderService.cashRequest(tb_odinfoxm) > 0){
			orderService.orderPayUpdateDtl(tb_odinfoxm);
		}
	}	
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
	 * @Method	: getState
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 입금확인요청 -- 사용안함 (무통장 Xpay연동)
	 * @Company	: YT Corp.
	 * @Author	: chjw
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/state", method=RequestMethod.POST)
	public ModelAndView getState(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		// 로그인 정보
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		//배송상태 및 결제수단 업데이트
		int stateMst = orderService.cashRequest(tb_odinfoxm);
		
		if(stateMst > 0){
			orderService.orderPayUpdateDtl(tb_odinfoxm);

			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "입금확인요청이 완료되었습니다.");
			mav.addObject("returnUrl", "/m/order/view/"+tb_odinfoxm.getORDER_NUM());
			mav.setViewName("alertMessage");
			return mav;
		}
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/m/order/view/"+tb_odinfoxm.getORDER_NUM());
		return new ModelAndView(redirectView);
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderRfndMgrController.java
	 * @Method	: updateWaybill
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 운송정 정보 등록 Ajax
	 * @Company	: YT Corp.
	 * @Author	: chjw
	 * @Date	: 2021-01-06
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/updateWaybill" }, method=RequestMethod.POST)
	public @ResponseBody String updateWaybill(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		int result = 0;
		try {
			result = orderService.updateWaybill(tb_odinfoxm);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result+"";
	}
	
	/**
     * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
     * @Method	: state
     * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     * @Desc	: 애터미아자 주문 POST
     * @Company	: YT Corp.
     * @Author	: chjw
     * @Date	: 
     * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     * @param tb_odinfoxm
     * @param 
     * @param 
     * @return
     * @throws Exception
     * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    */
    public void orderAtomyAza(TB_ODINFOXM tb_odinfoxm) throws Exception{
    	// 애터미아자 주문상태 전달
    	AtomyAzaAPI azapi = new AtomyAzaAPI();
    	
        if(tb_odinfoxm.getORDER_CON() != null && (tb_odinfoxm.getORDER_CON()).equals("ORDER_CON_02")){
        	// 결제완료 
        	azapi.Order_AtomyAza(orderService, tb_odinfoxm.getORDER_NUM());
        } else if(tb_odinfoxm.getORDER_CON() != null && (tb_odinfoxm.getORDER_CON()).equals("ORDER_CON_04")){
        	// 주문취소
        	azapi.Cancel_AtomyAza(orderService, tb_odinfoxm.getORDER_NUM());
        }
    }

	/* 
	 * ① XPay 인증결제창 호출 페이지 -- 20201228 CHJW
	 * 입력된 정보를 바탕으로 LG U+에서 제공하는 “XPay 인증결제창”을 호출합니다.
	 * @param tb_odinfoxm
	 * @param tb_odinfoxd
	 * @param tb_oddlaixm
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/orderPay")//, method=RequestMethod.POST)
	public ModelAndView orderPay(HttpServletRequest request, HttpSession session, Model model, 
			@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODINFOXD tb_odinfoxd, @ModelAttribute TB_ODDLAIXM tb_oddlaixm) throws Exception {

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		
		TB_ODINFOXM rtnOdinfoxm = (TB_ODINFOXM) orderService.getMasterInfo(tb_odinfoxm);	// 주문 마스터
		rtnOdinfoxm.setList(orderService.getDetailsList(rtnOdinfoxm));						// 주문 상세  
		//TB_ODDLAIXM rtnOddlaixm = (TB_ODDLAIXM) orderService.getDeliveryInfo(rtnOdinfoxm);	// 배송지
		
		/*
		logger.info("lguplus.cst_platform >> " + environment.getProperty("lguplus.cst_platform"));
		logger.info("lguplus.cst_mid >> " + environment.getProperty("lguplus.cst_mid"));
		logger.info("lguplus.lgd_martkey >> " + environment.getRequiredProperty("lguplus.lgd_martkey"));
		logger.info("lguplus.lgd_custom_skin >> " + environment.getRequiredProperty("lguplus.lgd_custom_skin"));
		logger.info("lguplus.lgd_window_ver >> " + environment.getRequiredProperty("lguplus.lgd_window_ver"));
		logger.info("lguplus.lgd_window_type >> " + environment.getRequiredProperty("lguplus.lgd_window_type"));
		logger.info("lguplus.lgd_ostype_check >> " + environment.getRequiredProperty("lguplus.lgd_ostype_check"));
		logger.info("lguplus.lgd_casnoteurl >> " + environment.getRequiredProperty("lguplus.lgd_casnoteurl"));
		logger.info("lguplus.lgd_returnurl >> " + environment.getRequiredProperty("lguplus.lgd_returnurl"));
		
		
	    /*
	     * [결제 인증요청 페이지(STEP2-1)]
	     * 샘플페이지에서는 기본 파라미터만 예시되어 있으며, 별도로 필요하신 파라미터는 연동메뉴얼을 참고하시어 추가 하시기 바랍니다.
	     */

	    /*
	     * 1. 기본결제 인증요청 정보 변경
	     * 기본정보를 변경하여 주시기 바랍니다.(파라미터 전달시 POST를 사용하세요)
	     * 아자마트 - tcjfls    70a2fbe58528f7b31f507f354a6cf208  https://www.cjflsmart.co.kr/order/payReturn
	     */
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Calendar cal = new GregorianCalendar();
		cal.add(Calendar.DATE, 1);
		String tomorrow = sdf.format(cal.getTime());

		long timestamp = (System.currentTimeMillis() / 1000L) * 1000L;
		
	    String CST_PLATFORM						= environment.getRequiredProperty("lguplus.cst_platform");			//LG유플러스 결제서비스 선택(test:테스트, service:서비스)
	    String CST_MID              			= environment.getRequiredProperty("lguplus.cst_mid");				//LG유플러스로 부터 발급받으신 상점아이디를 입력하세요.
	    String LGD_MID              			= ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;				//테스트 아이디는 't'를 제외하고 입력하세요.
	    																											//상점아이디(자동생성)
	    String LGD_OID              			= rtnOdinfoxm.getORDER_NUM();										//주문번호(상점정의 유니크한 주문번호를 입력하세요)
	    String LGD_AMOUNT           			= rtnOdinfoxm.getORDER_AMT();										//결제금액("," 를 제외한 결제금액을 입력하세요)	    
	    String LGD_MERTKEY          			= environment.getRequiredProperty("lguplus.lgd_martkey");			//상점MertKey(mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)
	    
	    String LGD_BUYER						= loginUser.getMEMB_ID();											//구매자명
	    String LGD_PRODUCTINFO					= "쇼핑몰 상품 주문";												//상품명
	    String LGD_BUYEREMAIL					= loginUser.getMEMB_MAIL();											//구매자 이메일
	    String LGD_TIMESTAMP					= ""+timestamp;														//타임스탬프
	    String LGD_CUSTOM_USABLEPAY 			= tb_odinfoxm.getPAY_METD();;										//상점정의 초기결제수단
	    String LGD_CUSTOM_SKIN					= environment.getRequiredProperty("lguplus.lgd_custom_skin");		//상점정의 결제창 스킨(red)
	    
	    String LGD_CUSTOM_SWITCHINGTYPE			= "IFRAME";		 													//신용카드 카드사 인증 페이지 연동 방식 (수정불가)
	    String LGD_WINDOW_VER					= environment.getRequiredProperty("lguplus.lgd_window_ver");		//결제창 버젼정보
	    String LGD_WINDOW_TYPE					= environment.getRequiredProperty("lguplus.lgd_window_type");		//결제창 호출 방식 (수정불가)
		String LGD_OSTYPE_CHECK					= environment.getRequiredProperty("lguplus.lgd_ostype_check");		//값 P: XPay 실행(PC 결제 모듈): PC용과 모바일용 모듈은 파라미터 및 프로세스가 다르므로 PC용은 PC 웹브라우저에서 실행 필요. 
																													//"P", "M" 외의 문자(Null, "" 포함)는 모바일 또는 PC 여부를 체크하지 않음
		//String LGD_ACTIVEXYN					= "N";																//계좌이체 결제시 사용, ActiveX 사용 여부로 "N" 이외의 값: ActiveX 환경에서 계좌이체 결제 진행(IE)
		//String LGD_TAXFREEAMOUNT				= 0;																//결제금액(LGD_AMOUNT) 중 면세금액
		String LGD_CLOSEDATE					= tomorrow;															//무통장 입금 마감시간 예) yyyyMMddHHmmss

		// 사용자 환경체크
		String userAgent = request.getHeader("user-agent");
		boolean mobile1 = userAgent.matches(".*(iPhone|iPad|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|POLATIS|IEMobile|lgtelecom|mokia|SonyEricsson).*");
		boolean mobile2 = userAgent.matches(".*(LG|SAMSUNG|Samsung).*");
		if(mobile1 || mobile2){
			LGD_OSTYPE_CHECK = "M";
		}else{
			LGD_OSTYPE_CHECK = "P";
		}
		
	    
	    /*
	     * 가상계좌(무통장) 결제 연동을 하시는 경우 아래 LGD_CASNOTEURL 을 설정하여 주시기 바랍니다.
	     */
	    String LGD_CASNOTEURL		= environment.getRequiredProperty("lguplus.lgd_casnoteurl");

	    /*
	     * LGD_RETURNURL 을 설정하여 주시기 바랍니다. 반드시 현재 페이지와 동일한 프로트콜 및  호스트이어야 합니다. 아래 부분을 반드시 수정하십시요.
	     */
	    String LGD_RETURNURL		= environment.getRequiredProperty("lguplus.lgd_returnurl");	// FOR MANUAL

	    
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
	    payReqMap.put("CST_PLATFORM"                		, CST_PLATFORM);				// 테스트, 서비스 구분
	    payReqMap.put("CST_MID"                     		, CST_MID );					// 상점아이디
	    payReqMap.put("LGD_WINDOW_TYPE"             		, LGD_WINDOW_TYPE );			// 결제창호출 방식(수정불가)
	    payReqMap.put("LGD_MID"                     		, LGD_MID );					// 상점아이디
	    payReqMap.put("LGD_OID"                     		, LGD_OID );					// 주문번호
	    payReqMap.put("LGD_BUYER"                   		, LGD_BUYER );					// 구매자
	    payReqMap.put("LGD_PRODUCTINFO"             		, LGD_PRODUCTINFO );			// 상품정보
	    payReqMap.put("LGD_AMOUNT"                  		, LGD_AMOUNT );					// 결제금액
	    payReqMap.put("LGD_BUYEREMAIL"              		, LGD_BUYEREMAIL );				// 구매자 이메일
	    payReqMap.put("LGD_CUSTOM_SKIN"             		, LGD_CUSTOM_SKIN );			// 결제창 SKIN
	    payReqMap.put("LGD_CUSTOM_PROCESSTYPE"      		, LGD_CUSTOM_PROCESSTYPE );		// 트랜잭션 처리방식
	    payReqMap.put("LGD_TIMESTAMP"               		, LGD_TIMESTAMP );				// 타임스탬프
	    payReqMap.put("LGD_HASHDATA"                		, LGD_HASHDATA );      	        // MD5 해쉬암호값
	    payReqMap.put("LGD_RETURNURL"   					, LGD_RETURNURL );				// 응답수신페이지
	    payReqMap.put("LGD_CUSTOM_USABLEPAY"				, LGD_CUSTOM_USABLEPAY );		// 디폴트 결제수단 (해당 필드를 보내지 않으면 결제수단 선택 UI 가 보이게 됩니다.)
	    payReqMap.put("LGD_CUSTOM_SWITCHINGTYPE"			, LGD_CUSTOM_SWITCHINGTYPE );	// 신용카드 카드사 인증 페이지 연동 방식
	    payReqMap.put("LGD_WINDOW_VER"  					, LGD_WINDOW_VER );				// 결제창 버젼정보 
	    payReqMap.put("LGD_OSTYPE_CHECK"            		, LGD_OSTYPE_CHECK );           // 값 P: XPay 실행(PC용 결제 모듈), PC, 모바일 에서 선택적으로 결제가능 
		//payReqMap.put("LGD_ACTIVEXYN"			    		, LGD_ACTIVEXYN);				// 계좌이체 결제시 사용, ActiveX 사용 여부
		payReqMap.put("LGD_VERSION"         				, "JSP_Non-ActiveX_Standard");	// 사용타입 정보(수정 및 삭제 금지): 이 정보를 근거로 어떤 서비스를 사용하는지 판단할 수 있습니다.

	    // 가상계좌(무통장) 결제연동을 하시는 경우  할당/입금 결과를 통보받기 위해 반드시 LGD_CASNOTEURL 정보를 LG 유플러스에 전송해야 합니다 .
	    payReqMap.put("LGD_CASNOTEURL"          			, LGD_CASNOTEURL );				// 가상계좌 NOTEURL
		payReqMap.put("LGD_CLOSEDATE"						, LGD_CLOSEDATE );				// 입금마감시간		

	    /* Return URL에서 인증 결과 수신 시 셋팅될 파라미터 입니다 */
		payReqMap.put("LGD_RESPCODE"						, "" );
		payReqMap.put("LGD_RESPMSG"							, "" );
		payReqMap.put("LGD_PAYKEY"							, "" );

		/* Encoding 설정(EUC-KR 이외의 경우 사용) */
		payReqMap.put("LGD_ENCODING"						, "UTF-8" );					//결제창 호출문자 인코딩방식 (기본값: EUC-KR)
		payReqMap.put("LGD_ENCODING_RETURNURL"				, "UTF-8" );					//결과수신페이지 호출문자 인코딩방식 (기본값: EUC-KR)
		payReqMap.put("LGD_ENCODING_NOTEURL"				, "UTF-8" );					//결과수신페이지 호출문자 인코딩방식 (기본값: EUC-KR)
		
		session.setAttribute("PAYREQ_MAP"					, payReqMap);

		/* payReq.jsp 에 전달할 값 */
		model.addAttribute("PAYREQ_MAP"						, payReqMap);
		model.addAttribute("CST_MID"						, CST_MID);
		model.addAttribute("CST_PLATFORM"					, CST_PLATFORM);
		model.addAttribute("LGD_OID"						, LGD_OID);
		model.addAttribute("LGD_MERTKEY"					, LGD_MERTKEY);
		model.addAttribute("LGD_AMOUNT"						, LGD_AMOUNT);
		model.addAttribute("LGD_BUYER"						, LGD_BUYER);
		model.addAttribute("LGD_PRODUCTINFO"				, LGD_PRODUCTINFO);
		model.addAttribute("LGD_BUYEREMAIL"					, LGD_BUYEREMAIL);
		model.addAttribute("LGD_TIMESTAMP"					, LGD_TIMESTAMP);
		model.addAttribute("LGD_CUSTOM_USABLEPAY"			, LGD_CUSTOM_USABLEPAY);
		model.addAttribute("LGD_CUSTOM_SWITCHINGTYPE"		, LGD_CUSTOM_SWITCHINGTYPE);
		model.addAttribute("LGD_WINDOW_TYPE"				, LGD_WINDOW_TYPE);
		model.addAttribute("LGD_OSTYPE_CHECK"				, LGD_OSTYPE_CHECK);
		
		model.addAttribute("tb_odinfoxm"					, rtnOdinfoxm);
		//model.addAttribute("tb_oddlaixm"					, rtnOddlaixm);
		System.out.println("여기까지 타는지?");
		return new ModelAndView("blankPage", "jsp", "responsiveMall/order/payReq");
	}

	/**
	 * ② 인증요청 응답 화면 -- 20201228 CHJW
	 * 최종 결제를 위한 인증키 전달 페이지
	 * 인증이 완료된 후 LG U+로부터 LGD_PAYKEY(인증Key)를 받아 
	 * XPay 최종결제요청 및 결제결과처리 페이지로 전달합니다.
	 * @param session
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/payReturn", method=RequestMethod.POST)
	public ModelAndView payReturn(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, HttpSession session, Model model) throws Exception {
		/*
		request.setCharacterEncoding("euc-kr");
		logger.info("LGD_RESPCODE>>"+request.getParameter("LGD_RESPCODE"));
		logger.info("LGD_RESPMSG1>>"+request.getParameter("LGD_RESPMSG"));
		logger.info("LGD_PAYTYPE>>"+request.getParameter("LGD_PAYTYPE"));
		logger.info("LGD_BUYER>>"+request.getParameter("LGD_BUYER"));
		logger.info("LGD_FINANCENAME>>"+request.getParameter("LGD_FINANCENAME"));
		logger.info("LGD_SA>>"+request.getParameter("LGD_SA"));
		logger.info("LGD_COMPANYNAME>>"+request.getParameter("LGD_COMPANYNAME"));
		logger.info("LGD_AMOUNT>>"+request.getParameter("LGD_AMOUNT"));
		*/
		// payReturn.jsp 에 보내줄 값 세팅
		Map payReqMap 		= request.getParameterMap();
		String LGD_RESPCODE	= request.getParameter("LGD_RESPCODE");
		String LGD_RESPMSG 	= request.getParameter("LGD_RESPMSG");

		model.addAttribute("LGD_RESPCODE"		, LGD_RESPCODE);
		model.addAttribute("LGD_RESPMSG"		, LGD_RESPMSG);
		model.addAttribute("payReqMap"			, payReqMap);
		
		request.setAttribute("payReqMap"		, payReqMap);

		return new ModelAndView("blankPage", "jsp", "responsiveMall/order/payReturn");
	}

	/**
	 * ③ 최종결제요청 및 결제결과 처리 -- 20201231 CHJW
	 * LG U+ API를 통해서 최종 결제 요청을 한 후, 결제 요청 결과를 리턴 받아 해당 결과를 처리하는 페이지입니다. 
	 * 최종 결제 요청은 API를 통해 LGD_PAYKEY(인증Key)를 사용하여 요청합니다.
	 * @param resv
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping(value="/payRes", method=RequestMethod.POST)
//	public ModelAndView payRes( HttpServletRequest request, HttpSession session, Model model) throws Exception {
//		boolean bSatus = false;
//	   	Map<String,String> payResMap = new HashMap<String,String>();
//	   	Map<String,String> virtualMap = new HashMap<String,String>();
//	   	
//		/*
//	     * [최종결제요청 페이지(STEP2-2)]
//		 *
//	     * 매뉴얼 "5.1. XPay 결제 요청 페이지 개발"의 "단계 5. 최종 결제 요청 및 요청 결과 처리" 참조
//		 *
//	     * LG유플러스으로 부터 내려받은 LGD_PAYKEY(인증Key)를 가지고 최종 결제요청.(파라미터 전달시 POST를 사용하세요)
//	     */
//
//		/* 
//		 * ※ 중요
//		 * 환경설정 파일의 경우 반드시 외부에서 접근이 가능한 경로에 두시면 안됩니다.
//		 * 해당 환경파일이 외부에 노출이 되는 경우 해킹의 위험이 존재하므로 반드시 외부에서 접근이 불가능한 경로에 두시기 바랍니다. 
//		 * 예) [Window 계열] C:\inetpub\wwwroot\lgdacom ==> 절대불가(웹 디렉토리)
//		 */
//		String configPath						= environment.getRequiredProperty("lguplus.configPath");	//LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf,/conf/mall.conf") 위치 지정.
//		/*
//	     *************************************************
//	     * 1.최종결제 요청 - BEGIN
//	     *  (단, 최종 금액체크를 원하시는 경우 금액체크 부분 주석을 제거 하시면 됩니다.)
//	     *************************************************
//	     */	    
//		String CST_PLATFORM						= request.getParameter("CST_PLATFORM");
//	    String CST_MID							= request.getParameter("CST_MID");
//	    String LGD_MID							= ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;
//	    String LGD_PAYKEY						= request.getParameter("LGD_PAYKEY");
//	    
//	    // 로그용
//	   	String LGD_RESPCODE 					= "";
//	   	String LGD_PAYTYPE 						= "";
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
//	   	if( !isInitOK ) {
//	    	//API 초기화 실패 화면처리
//	        payResMap.put("msg02", "결제요청을 초기화 하는데 실패하였습니다.<br>"
//	        					+  "LG유플러스에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.<br>"
//	        					+  "mall.conf에는 Mert ID = Mert Key 가 반드시 등록되어 있어야 합니다.<br><br>"
//	        					+  "문의전화 LG유플러스 1544-7772<br>");
//	        model.addAttribute("payResMap", payResMap);
//	        return new ModelAndView("blankPage", "jsp", "responsiveMall/order/payRes");
//	   	}else{      
//	   		try{
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
//	    		payResMap.put("msg02" , "LG유플러스 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다.");
//	    		payResMap.put("msg01" , ""+e.getMessage());
//		        model.addAttribute("payResMap", payResMap);
//		        return new ModelAndView("blankPage", "jsp", "responsiveMall/order/payRes");
//	    	}
//	   	}
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
//        //(4) TX: lgdacom.conf에 설정된 URL로 소켓 통신하여 최종 인증요청, 결과값으로 true, false 리턴
//	    if ( xpay.TX() ) {
//	        //1)결제결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
//	        payResMap.put("msg01", "결제요청이 완료되었습니다.  <br>"
//	        					+  "TX 결제요청 통신 응답코드 = " 	+ xpay.m_szResCode + "<br>"		//통신 응답코드("0000" 일 때 통신 성공)
//	        					+  "TX 결제요청 통신 응답메시지 = " + xpay.m_szResMsg + "<br>");		//통신 응답메시지
//	        
//    		payResMap.put("msg02", "거래번호 : " 		+ xpay.Response("LGD_TID", 0) + "<br>"
//    							+  "상점아이디 : " 		+ xpay.Response("LGD_MID", 0) + "<br>"
//    							+  "상점주문번호 : "	+ xpay.Response("LGD_OID", 0) + "<br>"
//    							+  "결제금액 : " 		+ xpay.Response("LGD_AMOUNT", 0) + "<br>"
//    							+  "결과코드 : " 		+ xpay.Response("LGD_RESPCODE", 0) + "<br>"	//LGD_RESPCODE 가 반드시 "0000" 일때만 결제 성공, 그 외는 모두 실패
//    							+  "결과메세지 : " 		+ xpay.Response("LGD_RESPMSG", 0) + "<br>"
//	        					+  "문의전화 LG유플러스 1544-7772<br>");
//	        
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
//	        	payResMap.put("msg04" , "최종결제요청 성공, DB처리하시기 바랍니다.<br>");
//
//	        	LGD_RESPCODE = xpay.Response("LGD_RESPCODE"	, 0);
//	        	LGD_PAYTYPE	= xpay.Response("LGD_PAYTYPE"	, 0);
//	        	
//	        	// 공통
//	        	logger.info(xpay.Response("LGD_RESPCODE"			, 0));		// 응답코드
//	        	logger.info(xpay.Response("LGD_RESPMSG"				, 0));		// 응답메세지
//	        	logger.info(xpay.Response("LGD_MID"					, 0));		// 유플러스 발급아이디
//	        	logger.info(xpay.Response("LGD_OID"					, 0));		// 상점아이디
//	        	logger.info(xpay.Response("LGD_AMOUNT"				, 0));		// 결제금액
//	        	logger.info(xpay.Response("LGD_TID"					, 0));		// 거래번호
//	        	logger.info(xpay.Response("LGD_PAYTYPE"				, 0));		// 결제수단
//	        	logger.info(xpay.Response("LGD_PAYDATE"				, 0));		// 결제일시
//
//	        	logger.info(xpay.Response("LGD_TIMESTAMP"			, 0));		// 타임스탬프
//	        	logger.info(xpay.Response("LGD_BUYER"				, 0));		// 구매자명
//	        	logger.info(xpay.Response("LGD_BUYERID"				, 0));		// 구매자아이디
//	        	logger.info(xpay.Response("LGD_PRODUCTINFO"			, 0));		// 구매내역
//	        	logger.info(xpay.Response("LGD_BUYERADDRESS"		, 0));		// 구매자주소
//	        	logger.info(xpay.Response("LGD_BUYERPHONE"			, 0));		// 구매자모바일
//	        	logger.info(xpay.Response("LGD_BUYEREMAIL"			, 0));		// 구매자메일
//	        	logger.info(xpay.Response("LGD_PRODUCTCODE"			, 0));		// 상품코드
//	        	logger.info(xpay.Response("LGD_RECEIVER"			, 0));		// 수취인
//	        	logger.info(xpay.Response("LGD_RECEIVERPHONE"		, 0));		// 수취인번호
//	        	logger.info(xpay.Response("LGD_DELIVERYINFO"		, 0));		// 배송정보
//	        	
//	        	logger.info(xpay.Response("LGD_FINANCECODE"			, 0));		// 결제기관코드
//	        	logger.info(xpay.Response("LGD_FINANCENAME"			, 0));		// 결제기관명
//	        	logger.info(xpay.Response("LGD_ESCROWYN"			, 0));		// 최종에스크로 적용여부
//	        	logger.info(xpay.Response("LGD_TRANSAMOUNT"			, 0));		// 환율적용금액
//	        	logger.info(xpay.Response("LGD_EXCHANGERATE"		, 0));		// 적용환율
//	        	
//	        	// 신용카드
//	        	logger.info(xpay.Response("LGD_FINANCEAUTHNUM"		, 0));		// 결제기관승인번호
//	        	logger.info(xpay.Response("LGD_CARDNUM"				, 0));		// 신용카드번호
//	        	logger.info(xpay.Response("LGD_CARDINSTALLMONTH"	, 0));		// 신용카드할부개월
//	        	logger.info(xpay.Response("LGD_CARDNOINTYN"			, 0));		// 신용카드무이자여부
//	        	logger.info(xpay.Response("LGD_AFFILIATECODE"		, 0));		// 신용카드제휴코드
//	        	logger.info(xpay.Response("LGD_CARDGUBUN1"			, 0));		// 신용카드추가정보1 (0:개인, 1:법인, 9:미확인)
//	        	logger.info(xpay.Response("LGD_CARDGUBUN2"			, 0));		// 신용카드추가정보2 (0:신용, 1:체크, 2:기프트, 9:미확인)
//	        	logger.info(xpay.Response("LGD_CARDACQUIRER"		, 0));		// 신용카드매입사코드
//	        	logger.info(xpay.Response("LGD_PCANCELFLAG"			, 0));		// 부분취소가능여부(1: 부분취소가능, 0 : 부분취소불가)
//	        	logger.info(xpay.Response("LGD_PCANCELSTR"			, 0));		// 부분취소 불가시 응답메세지
//	        	logger.info(xpay.Response("LGD_DISCOUNTUSEYN"		, 0));		// 신용카드 즉시할인 여부 (0:할인안됨, 1:할인됨)
//	        	logger.info(xpay.Response("LGD_DISCOUNTUSEAMOUNT"	, 0));		// 신용카드 즉시할인 금액
//
//	        	// 현금영수증
//	        	logger.info(xpay.Response("LGD_CASHRECEIPTNUM"		, 0));		// 현금영수증 승인번호
//	        	logger.info(xpay.Response("LGD_CASHRECEIPTSELFYN"	, 0));		// 현금영수증자진발급제유무
//	        	logger.info(xpay.Response("LGD_CASHRECEIPTKIND"		, 0));		// 현금영수증 종류
//	        	
//	        	// 계좌이체
//	        	logger.info(xpay.Response("LGD_ACCOUNTOWNER"		, 0));		// 계좌주명
//	        	
//	        	// 가상계좌
//	        	logger.info(xpay.Response("LGD_ACCOUNTNUM"			, 0));		// 가상계좌 발급번호 (입금할 계좌번호)
//	        	logger.info(xpay.Response("LGD_PAYER"				, 0));		// 가상계좌입금자명
//	        	logger.info(xpay.Response("LGD_CASTAMOUNT"			, 0));		// 입금누적금액
//	        	logger.info(xpay.Response("LGD_CASCAMOUNT"			, 0));		// 현입금금액
//	        	logger.info(xpay.Response("LGD_CASFLAG"				, 0));		// 거래종류(R:할당,I:입금,C:취소)
//	        	logger.info(xpay.Response("LGD_CASSEQNO"			, 0));		// 가상계좌일련번호
//	        	logger.info(xpay.Response("LGD_SAOWNER"				, 0));		// 가상계좌 입금계좌주명 (상점명이 디폴트로 리턴)
//	        	logger.info(xpay.Response("LGD_TELNO"				, 0));		// 결제휴대폰번호
//	        	logger.info(xpay.Response("LGD_CLOSEDATE"			, 0));		// 입금마감시간
//	        	
//
//	         	//최종결제요청 결과를 DB처리합니다. (결제성공 또는 실패 모두 DB처리 가능)
//	    		boolean isDBOK = false;
//	    		
//	        	//LGD_RESPCODE 가 반드시 "0000" 일때만 결제 성공, 그 외는 모두 실패
//	        	if("0000".equals(LGD_RESPCODE)) {
//	        		TB_ODINFOXM tb_odinfoxm = new TB_ODINFOXM();
//		    		tb_odinfoxm.setORDER_NUM(xpay.Response("LGD_OID"	, 0));		// 주문번호
//		    		tb_odinfoxm.setPAY_METD(xpay.Response("LGD_PAYTYPE"	, 0));		// 결제수단
//		    		tb_odinfoxm.setPAY_MDKY(xpay.Response("LGD_TID"		, 0));		// 결제키
//		    		tb_odinfoxm.setPAY_AMT(xpay.Response("LGD_AMOUNT"	, 0));		// 결제금액
//		    		tb_odinfoxm.setMODP_ID("lguplus");
//
//		    		// 무통장은 결제수단만 처리, 상태 DB처리는 LGD_CASNOTEURL에서 처리
//		    		if("SC0040".equals(LGD_PAYTYPE)) {
//		        		isDBOK = true;
//		        		
//			        	virtualMap.put("LGD_SAOWNER", xpay.Response("LGD_SAOWNER"			, 0));
//			        	virtualMap.put("LGD_ACCOUNTNUM", xpay.Response("LGD_ACCOUNTNUM"		, 0));
//			        	virtualMap.put("LGD_FINANCENAME", xpay.Response("LGD_FINANCENAME"	, 0));
//			        	virtualMap.put("LGD_CLOSEDATE", xpay.Response("LGD_CLOSEDATE"		, 0));
//			        	
//		    		// 신용카드 & 계좌이체 DB처리
//		    		} else {
//			    		tb_odinfoxm.setORDER_CON("ORDER_CON_02");					// 주문상태 (결제완료)
//			    		try{
//				        	if( orderService.orderPayUpdate(tb_odinfoxm) > 0 ) {
//			    				orderService.orderPayUpdateDtl(tb_odinfoxm);
//				        		orderAtomyAza(tb_odinfoxm);	// 애터미아자 상품주문 API
//				        	}
//			        		isDBOK = true;
//			        	} catch(Exception e){
//		        			// data : null 이면 주문 실패처리
//		        		}
//		    		}
//		        	
//	        	} else {
//					//결제 실패(최종결제요청 결과 실패 DB처리)
//		        	payResMap.put("msg04" , "LGD_RESPCODE"  + xpay.Response("LGD_RESPCODE", 0)+"<br> LGD_RESPMSG:" + xpay.Response("LGD_RESPMSG", 0));
//		        	payResMap.put("msg07" , "LGD_RESPCODE 최종결제요청 결과 실패, DB처리하시기 바랍니다.<br>");
//	        	}
//
//				//상점내 DB에 어떠한 이유로 처리를 하지 못한경우 false로 변경해 주세요.	         	 
//	        	if( !isDBOK ) {
//	        		/*
//	        		 *  가상계좌의 경우 xpay.Rollback시 계좌가 반납되어 정산 요청이 이루어짐
//	        		 *  1.정상처리: 계좌발급|정산미요청 / 2.계좌반납: 계좌발급|정산요청 
//	        		 */
//	         		xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" + xpay.Response("LGD_TID", 0) +", MID:" + xpay.Response("LGD_MID", 0) +", OID:"+ xpay.Response("LGD_OID", 0) +"]");	         		
//	         		payResMap.put("msg05", "TX Rollback Response_code = "	+ xpay.Response("LGD_RESPCODE", 0) + "<br>");
//	         		payResMap.put("msg06", "TX Rollback Response_msg = "	+ xpay.Response("LGD_RESPMSG", 0) + "<p>");
//	         		
//					if( "0000".equals( xpay.m_szResCode ) ) { 
//						payResMap.put("msg07", "[결제실패] 자동취소가 정상적으로 완료 되었습니다.<br>"
//											 + "결제 처리중 에러가 발생했습니다. 같은 에러가 계속 발생시 관리자에게 문의하세요.");
//					}else{
//						payResMap.put("msg07", "[결제실패] 자동취소가 정상적으로 처리되지 않았습니다.<br>"
//											 + "결제 처리중 에러가 발생했습니다. 같은 에러가 계속 발생시 관리자에게 문의하세요.");
//					}
//	        	}else{
//	        		bSatus = true;
//	         		payResMap.put("msg07", "결제가 정상적으로 처리 되었습니다. 배송/주문조회 페이지로 이동합니다.");
//	         	}
//	        }else{
//				//통신상의 문제 발생(최종결제요청 결과 실패 DB처리)
//	        	payResMap.put("msg07" , "통신상의 문제 발생으로, 최종결제요청 결과 실패하였습니다. DB처리하시기 바랍니다.<br>");           	
//	        }
//	    }else {
//	        //2)API 요청실패 화면처리
//	    	payResMap.put("msg09" , "결제요청이 실패하였습니다.  <br>");
//	    	payResMap.put("msg10" , "TX 결제요청 Response_code = " + xpay.m_szResCode + "<br>");      
//	    	payResMap.put("msg11" , "TX 결제요청 Response_msg = " + xpay.m_szResMsg + "<p>");
//	    	    
//	     	//최종결제요청 결과 실패 DB처리
//	    	payResMap.put("msg07" , "최종결제요청 결과실패, DB처리하시기 바랍니다.<br>");
//	    }
//
//	    /* 결과화면으로 보내기 */
//	    model.addAttribute("payRtnSatus", bSatus);			// 결제성공여부
//	    model.addAttribute("LGD_PAYTYPE", LGD_PAYTYPE);		// 결제수단
//	    model.addAttribute("virtualMap", virtualMap);		// 가상계좌 정보
//	    model.addAttribute("payResMap", payResMap);			// 결과메세지
//	    
//	    try {
//		    //결제 로그 처리
//	    	String STATE = bSatus ? "OK" : "FAIL";
//	    	TB_LGUPLUS tb_lguplus = new TB_LGUPLUS();
//		    tb_lguplus.setLGD_TID((String) xpay.Response("LGD_TID", 0));
//		    tb_lguplus.setLGD_OID((String) xpay.Response("LGD_OID", 0));
//		    tb_lguplus.setGUBUN("ORDER");
//		    tb_lguplus.setLGD_AMOUNT((String) xpay.Response("LGD_AMOUNT", 0));
//		    tb_lguplus.setLGD_RESPCODE(LGD_RESPCODE);
//		    tb_lguplus.setLGD_RESPMSG((String) xpay.Response("LGD_RESPMSG", 0));
//		    tb_lguplus.setLGD_PAYTYPE(LGD_PAYTYPE);
//		    tb_lguplus.setLGD_PAYDATE((String) xpay.Response("LGD_PAYDATE", 0));
//		    tb_lguplus.setLGD_FINANCECODE((String) xpay.Response("LGD_FINANCECODE", 0));
//		    tb_lguplus.setLGD_FINANCENAME((String) xpay.Response("LGD_FINANCENAME", 0));
//		    tb_lguplus.setSTATE(STATE);
//		    
//		    if("SC0010".equals(LGD_PAYTYPE)) {
//			    tb_lguplus.setLGD_CARDNUM((String) xpay.Response("LGD_CARDNUM", 0));
//			    tb_lguplus.setLGD_FINANCEAUTHNUM((String) xpay.Response("LGD_FINANCEAUTHNUM", 0));
//		    	
//		    } else if("SC0030".equals(LGD_PAYTYPE)) {
//			    tb_lguplus.setLGD_CASHRECEIPTNUM((String) xpay.Response("LGD_CASHRECEIPTNUM", 0));
//			    tb_lguplus.setLGD_CASHRECEIPTKIND((String) xpay.Response("LGD_CASHRECEIPTKIND", 0));
//		    	
//		    } else if("SC0040".equals(LGD_PAYTYPE)) {
//			    /*tb_lguplus.setLGD_ACCOUNTNUM((String) xpay.Response("LGD_ACCOUNTNUM", 0));
//			    tb_lguplus.setLGD_CASTAMOUNT((String) xpay.Response("LGD_CASTAMOUNT", 0));
//			    tb_lguplus.setLGD_CASCAMOUNT((String) xpay.Response("LGD_CASCAMOUNT", 0));
//			    tb_lguplus.setLGD_CASFLAG((String) xpay.Response("LGD_CASFLAG", 0));
//			    tb_lguplus.setLGD_CASSEQNO((String) xpay.Response("LGD_CASSEQNO", 0));
//			    tb_lguplus.setLGD_CASHRECEIPTNUM((String) xpay.Response("LGD_CASHRECEIPTNUM", 0));
//			    tb_lguplus.setLGD_CASHRECEIPTKIND((String) xpay.Response("LGD_CASHRECEIPTKIND", 0));*/
//		    }
//		    
//		    if(tb_lguplus.getLGD_TID() != null) {
//				orderService.lguplusLogInsert(tb_lguplus);
//		    }
//			
//		}catch(Exception e){
//			logger.info("LgUplus Logging Error : " + e.toString());
//		}
//	    
//        return new ModelAndView("blankPage", "jsp", "responsiveMall/order/payRes");
//	}

	/**
	 * ④ 무통장(가상계좌) DB처리 -- 20201231 CHJW
	 * @param session
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cashReturn", method= RequestMethod.POST)
	public void cashReturn(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception {
		String GUBN = "ORDER";
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

	    LGD_RESPCODE					= request.getParameter("LGD_RESPCODE");
	    LGD_RESPMSG						= request.getParameter("LGD_RESPMSG");
	    LGD_MID							= request.getParameter("LGD_MID");
	    LGD_OID							= request.getParameter("LGD_OID");
	    LGD_AMOUNT						= request.getParameter("LGD_AMOUNT");
	    LGD_TID							= request.getParameter("LGD_TID");
	    LGD_PAYTYPE						= request.getParameter("LGD_PAYTYPE");
	    LGD_PAYDATE						= request.getParameter("LGD_PAYDATE");
	    LGD_HASHDATA					= request.getParameter("LGD_HASHDATA");
	    LGD_FINANCECODE					= request.getParameter("LGD_FINANCECODE");
	    LGD_FINANCENAME					= request.getParameter("LGD_FINANCENAME");
	    LGD_ESCROWYN					= request.getParameter("LGD_ESCROWYN");
	    LGD_TIMESTAMP					= request.getParameter("LGD_TIMESTAMP");
	    LGD_ACCOUNTNUM					= request.getParameter("LGD_ACCOUNTNUM");
	    LGD_CASTAMOUNT					= request.getParameter("LGD_CASTAMOUNT");
	    LGD_CASCAMOUNT					= request.getParameter("LGD_CASCAMOUNT");
	    LGD_CASFLAG						= request.getParameter("LGD_CASFLAG");
	    LGD_CASSEQNO					= request.getParameter("LGD_CASSEQNO");
	    LGD_CASHRECEIPTNUM				= request.getParameter("LGD_CASHRECEIPTNUM");
	    LGD_CASHRECEIPTSELFYN			= request.getParameter("LGD_CASHRECEIPTSELFYN");
	    LGD_CASHRECEIPTKIND				= request.getParameter("LGD_CASHRECEIPTKIND");
	    LGD_PAYER						= request.getParameter("LGD_PAYER");
	    LGD_CLOSEDATE					= request.getParameter("LGD_CLOSEDATE");	//

	    LGD_BUYER						= request.getParameter("LGD_BUYER");
	    LGD_PRODUCTINFO					= request.getParameter("LGD_PRODUCTINFO");
	    LGD_BUYERID						= request.getParameter("LGD_BUYERID");
	    LGD_BUYERADDRESS				= request.getParameter("LGD_BUYERADDRESS");
	    LGD_BUYERPHONE					= request.getParameter("LGD_BUYERPHONE");
	    LGD_BUYEREMAIL					= request.getParameter("LGD_BUYEREMAIL");
	    LGD_BUYERSSN					= request.getParameter("LGD_BUYERSSN");
	    LGD_PRODUCTCODE					= request.getParameter("LGD_PRODUCTCODE");
	    LGD_RECEIVER					= request.getParameter("LGD_RECEIVER");
	    LGD_RECEIVERPHONE				= request.getParameter("LGD_RECEIVERPHONE");
	    LGD_DELIVERYINFO				= request.getParameter("LGD_DELIVERYINFO");

	    /*
	     * hashdata 검증을 위한 mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다. 
	     * LG유플러스에서 발급한 상점키로 반드시변경해 주시기 바랍니다.
	     */  
	    String LGD_MERTKEY = environment.getRequiredProperty("lguplus.lgd_martkey");		//상점MertKey

	    StringBuffer sb = new StringBuffer();
	    sb.append(LGD_MID);
	    sb.append(LGD_OID);
	    sb.append(LGD_AMOUNT);
	    sb.append(LGD_RESPCODE);
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

	    String LGD_HASHDATA2 = strBuf.toString();  //상점검증 해쉬값  
	    
	    /*
	     * 상점 처리결과 리턴메세지
	     * OK  : 상점 처리결과 성공
	     * 그외 : 상점 처리결과 실패
	     * ※ 주의사항 : 성공시 'OK' 문자이외의 다른문자열이 포함되면 실패처리 되오니 주의하시기 바랍니다.
	     */    
	    String resultMSG = "결제결과 상점 DB처리(LGD_CASNOTEURL) 결과값을 입력해 주시기 바랍니다.";  
	    
	    if (LGD_HASHDATA2.trim().equals(LGD_HASHDATA)) { //해쉬값 검증이 성공이면
	        if ( ("0000".equals(LGD_RESPCODE.trim())) ){ //결제가 성공이면
	        	// 결제정보
    			TB_ODINFOXM tb_odinfoxm = new TB_ODINFOXM();
    			tb_odinfoxm.setORDER_NUM(LGD_OID);
    			tb_odinfoxm.setPAY_METD("SC0040");		//LGD_PAYTYPE
    			tb_odinfoxm.setPAY_AMT(LGD_CASTAMOUNT);	//입금총액
    			tb_odinfoxm.setPAY_MDKY(LGD_TID);
    			tb_odinfoxm.setMODP_ID("lguplus");
    			
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
				        		orderAtomyAza(tb_odinfoxm);						// 애터미아자 상품주문 API
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
			        		orderAtomyAza(tb_odinfoxm);
			        		
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
	    } else { //해쉬값이 검증이 실패이면
	        /*
	         * hashdata검증 실패 로그를 처리하시기 바랍니다. 
	         */      
	        resultMSG = "결제결과 상점 DB처리(LGD_CASNOTEURL) 해쉬값 검증이 실패하였습니다.";   
	    }
	    
	    System.out.println(resultMSG.toString());
	    
	    try {
		    //결제 로그 처리
	    	TB_LGUPLUS tb_lguplus = new TB_LGUPLUS();
		    tb_lguplus.setLGD_TID(LGD_TID);
		    tb_lguplus.setLGD_OID(LGD_OID);
		    tb_lguplus.setLGD_AMOUNT(LGD_AMOUNT);
		    tb_lguplus.setGUBUN(GUBN);
		    tb_lguplus.setLGD_RESPCODE(LGD_RESPCODE);
		    tb_lguplus.setLGD_RESPMSG(LGD_RESPMSG);
		    tb_lguplus.setLGD_PAYTYPE(LGD_PAYTYPE);
		    tb_lguplus.setLGD_PAYDATE(LGD_PAYDATE);
		    tb_lguplus.setLGD_FINANCECODE(LGD_FINANCECODE);
		    tb_lguplus.setLGD_FINANCENAME(LGD_FINANCENAME);
		    tb_lguplus.setLGD_ACCOUNTNUM(LGD_ACCOUNTNUM);
		    tb_lguplus.setLGD_CASTAMOUNT(LGD_CASTAMOUNT);
		    tb_lguplus.setLGD_CASCAMOUNT(LGD_CASCAMOUNT);
		    tb_lguplus.setLGD_CASFLAG(LGD_CASFLAG);
		    tb_lguplus.setLGD_CASSEQNO(LGD_CASSEQNO);
		    tb_lguplus.setLGD_CASHRECEIPTNUM(LGD_CASHRECEIPTNUM);
		    tb_lguplus.setLGD_CASHRECEIPTKIND(LGD_CASHRECEIPTKIND);
		    tb_lguplus.setLGD_CLOSEDATE(LGD_CLOSEDATE);
		    tb_lguplus.setSTATE(resultMSG);
		    
		    if(tb_lguplus.getLGD_TID() != null) {
				orderService.lguplusLogInsert(tb_lguplus);
		    }
			
		}catch(Exception e){
			logger.info("LgUplus Logging Error : " + e.toString());
		}
	}

	/* 
	 * 가상계좌 정보 -- 20201231 CHJW
	 * @param tb_lguplus
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={ "/virInfoPop" }, method=RequestMethod.GET)
	public ModelAndView virInfoPop(@ModelAttribute TB_LGUPLUS tb_lguplus, HttpServletRequest request, Model model) throws Exception {
		// 계좌로그 가상계좌정보 가져오기
		String LGD_OID = request.getParameter("ORDER_NUM");
		tb_lguplus.setLGD_OID(LGD_OID);
		TB_LGUPLUS lguplus = (TB_LGUPLUS)orderService.getVirAcctInfo(tb_lguplus);
		model.addAttribute("lguplus", lguplus);
		
		return new ModelAndView("popup.layout", "jsp", "responsiveMall/order/virInfoPop");
	}
	
	/**
	 * 주문취소 팝업 
	 * @param tb_odinfoxm
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={ "/cancel/popup" }, method=RequestMethod.GET)
	public ModelAndView cancelPop(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		
		request.getParameter("ORDER_NUM");
		request.getParameter("PAY_METD");
		
		return new ModelAndView("popup.layout", "jsp", "responsiveMall/order/popup");
	}
	
	/**
	 * 주문취소
	 * @param tb_odinfoxm
	 * @param request 
	 * @param model
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping(value={ "/cancel/popup" }, method=RequestMethod.POST)
//	public ModelAndView orderCancel(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
//		// 로그인 정보
//		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
//		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
//
//		ModelAndView mav = new ModelAndView();
//		Map<String,String> payResMap = new HashMap<String,String>();
//
//    	boolean bState = false;
//    	String STATE ="";
//    	String PAY_METD = tb_odinfoxm.getPAY_METD();
//    	
//		//결제 정보가 있을경우
//		if(StringUtils.isNotEmpty(tb_odinfoxm.getPAY_MDKY())){
//
//		    /*
//		     * [결제취소 요청 페이지]
//		     *
//		     * LG유플러스으로 부터 내려받은 거래번호(LGD_TID)를 가지고 취소 요청을 합니다.(파라미터 전달시 POST를 사용하세요)
//		     * (승인시 LG유플러스으로 부터 내려받은 PAYKEY와 혼동하지 마세요.)
//		     */
//		    String CST_PLATFORM			= environment.getRequiredProperty("lguplus.cst_platform");		//LG유플러스 결제서비스 선택(test:테스트, service:서비스)
//		    String CST_MID				= environment.getRequiredProperty("lguplus.cst_mid");			//LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요.
//		    String LGD_MID				= ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  		//테스트 아이디는 't'를 제외하고 입력하세요.
//		    																							//상점아이디(자동생성)
//		    String LGD_TID				= tb_odinfoxm.getPAY_MDKY();                      				//LG유플러스으로 부터 내려받은 거래번호(LGD_TID)
//
//			/* 
//			 * ※ 중요
//			 * 환경설정 파일의 경우 반드시 외부에서 접근이 가능한 경로에 두시면 안됩니다.
//			 * 해당 환경파일이 외부에 노출이 되는 경우 해킹의 위험이 존재하므로 반드시 외부에서 접근이 불가능한 경로에 두시기 바랍니다. 
//			 * 예) [Window 계열] C:\inetpub\wwwroot\lgdacom ==> 절대불가(웹 디렉토리)
//			 */
//		    String configPath 			= environment.getRequiredProperty("lguplus.configPath");	//LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf") 위치 지정.
//		        
//		    LGD_TID     				= ( LGD_TID == null )?"":LGD_TID; 
//		    
//		    XPayClient xpay = new XPayClient();
//		    xpay.Init(configPath, CST_PLATFORM);
//		    xpay.Init_TX(LGD_MID);
//		    xpay.Set("LGD_TXNAME", "Cancel");
//		    xpay.Set("LGD_TID", LGD_TID);
//		 
//		    /*
//		     * 1. 결제취소 요청 결과처리
//		     *
//		     * 취소결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
//			 *
//			 * [[[중요]]] 고객사에서 정상취소 처리해야할 응답코드
//			 * 1. 신용카드 : 0000, AV11  
//			 * 2. 계좌이체 : 0000, RF00, RF10, RF09, RF15, RF19, RF23, RF25 (환불진행중 응답건-> 환불결과코드.xls 참고)
//			 * 3. 나머지 결제수단의 경우 0000(성공) 만 취소성공 처리
//			 *
//		     */
//		    if (xpay.TX()) {
//		        //1)결제취소결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
//		    	boolean isXpayOK = false;
//		    	payResMap.put("msg01", "취소요청이 완료되었습니다.  <br>"
//									 + "TX 취소요청 통신 응답코드 = " 	+ xpay.m_szResCode + "<br>"		//통신 응답코드("0000" 일 때 통신 성공)
//									 + "TX 취소요청 통신 응답메시지 = " + xpay.m_szResMsg + "<p>");		//통신 응답메시지
//		    	// 신용카드
//		    	if("SC0010".equals(PAY_METD)){
//		    		// 취소 정상 승인
//		    		if("0000".equals( xpay.m_szResCode ) || "AV11".equals( xpay.m_szResCode )) {
//		    			mav.addObject("alertMessage", "[" + xpay.m_szResCode + "] " + "결제 취소요청이 완료되었습니다.");
//		    			isXpayOK = true;
//		    		}
//		    		
//		    	// 계좌이체	
//		    	} else if("SC0030".equals(PAY_METD)){
//		    		// 환불 정상 승인
//		    		if( "0000".equals( xpay.m_szResCode ) || "RF00".equals( xpay.m_szResCode )) {
//		    			mav.addObject("alertMessage", "[" + xpay.m_szResCode + "] " + "환불이 정상 처리되었습니다.");
//		    			isXpayOK = true;
//		    		}
//		    		
//		    		// 환불 진행중 승인
//		    		if( "RF10".equals( xpay.m_szResCode ) || "RF09".equals( xpay.m_szResCode ) || 
//		    			"RF15".equals( xpay.m_szResCode ) || "RF19".equals( xpay.m_szResCode ) || 
//		    			"RF23".equals( xpay.m_szResCode ) || "RF25".equals( xpay.m_szResCode )) {
//		    			mav.addObject("alertMessage", "[" + xpay.m_szResCode + "] " + "환불이 요청되었습니다. 환불진행중입니다.");
//		    			isXpayOK = true;
//		    		}
//		    		
//		    	// 기타 결제	
//		    	} else {
//		    		if("0000".equals( xpay.m_szResCode )) {
//		    			mav.addObject("alertMessage", "결제 취소요청이 완료되었습니다.");
//		    			isXpayOK = true;
//		    		}
//		    	}
//		    	
//		    	if(isXpayOK) {
//		    		tb_odinfoxm.setORDER_CON("ORDER_CON_04");
//					tb_odinfoxm.setCNCL_CON("CNCL_CON_03");		// 취소완료
//
//					try{
//						if (orderService.cancelObject(tb_odinfoxm) > 0){
//							orderService.orderPayUpdateDtl(tb_odinfoxm);
//							orderAtomyAza(tb_odinfoxm);	// 애터미아자 API 호출 (결제완료, 배송완료, 주문취소, 환불)
//						}
//						bState = isXpayOK;
//	        			STATE = "OK";
//	        			
//	        		} catch(Exception e){
//	        			// data : null 이면 주문 실패처리
//	        			STATE = "결제취소완료, 상점 DB처리 실패.";
//	        		}
//		    	} else {
//					//통신상의 문제 발생(최종결제요청 결과 실패 DB처리)
//		    		mav.addObject("alertMessage", "결제 취소요청이 실패하였습니다.\n  - TX Response_code = " + xpay.m_szResCode + " - \nTX Response_msg = " + xpay.m_szResMsg);
//					payResMap.put("msg08" , "최종결제요청 결과 실패, DB처리하시기 바랍니다.<br>");
//        			STATE = "최종결제요청 결과 실패, DB처리하시기 바랍니다.";
//				}
//				
//		    }else {
//		        //2)API 요청 실패 화면처리
//		    	mav.addObject("alertMessage", "결제 취소요청이 실패하였습니다.\n  - TX Response_code = " + xpay.m_szResCode + " - \nTX Response_msg = " + xpay.m_szResMsg);
//    			STATE = "결제취소요청실패, API 요청 실패.";
//		    }
//		    
//		    try {
//			    //결제 로그 처리
//		    	TB_LGUPLUS tb_lguplus = new TB_LGUPLUS();
//			    tb_lguplus.setLGD_TID(LGD_TID);
//			    tb_lguplus.setLGD_OID(tb_odinfoxm.getORDER_NUM());
//			    tb_lguplus.setGUBUN("CANCEL");
//			    tb_lguplus.setLGD_RESPCODE(xpay.m_szResCode);
//			    tb_lguplus.setLGD_RESPMSG(xpay.m_szResMsg);
//			    tb_lguplus.setLGD_PAYTYPE(PAY_METD);
//			    tb_lguplus.setSTATE(STATE);
//			    
//			    if(tb_lguplus.getLGD_TID() != null) {
//					orderService.lguplusLogInsert(tb_lguplus);
//			    }
//				
//			}catch(Exception e){
//				logger.info("LgUplus Logging Error : " + e.toString());
//			}
//		    
//		}else{
//			mav.addObject("alertMessage", "PG사 결제정보가 없습니다. 결제수단을 확인해주세요.");
//		}
//
//		mav.addObject("payResMap", payResMap);
//		mav.addObject("gubun", "popup");
//		mav.addObject("returnUrl", servletContextPath.concat("/m/order/view/" + tb_odinfoxm.getORDER_NUM()));
//		mav.setViewName("alertMessage");
//
//		return mav;		
//	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.OrderRestController.java
	 * @Method	: getRefund
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 반품신청
	 * @Company	: YT Corp.
	 * @Author	: chjw
	 * @Date	: 2021-01-05 (오전 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/refund" }, method=RequestMethod.GET)
	public ModelAndView getRefund(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		//세션변경
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		//주문정보
		String ORDER_NUM = request.getParameter("ORDER_NUM");
		tb_odinfoxm.setORDER_NUM(ORDER_NUM);
		
		TB_ODINFOXM orderInfo = (TB_ODINFOXM)orderService.getMasterInfo(tb_odinfoxm);
		orderInfo.setList(orderService.getRefundList(tb_odinfoxm));
		
		if(!loginUser.getMEMB_ID().equals(orderInfo.getMEMB_ID())){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "주문자와 로그인 정보가 일치하지 않습니다.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		//배송비 조건
		TB_SPINFOXM supplierInfo = new TB_SPINFOXM();
		supplierInfo.setSUPR_ID("C00001");
		model.addAttribute("supplierInfo", (TB_SPINFOXM)supplierMgrService.getObject(supplierInfo));
		model.addAttribute("tb_odinfoxm", orderInfo);

		return new ModelAndView("mall.responsive.layout", "jsp", "order/partialCancel");
	}
	
	@RequestMapping(value={ "/refund" }, method=RequestMethod.POST)
	public ModelAndView refund(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODINFOXD tb_odinfoxd, HttpServletRequest request, Model model) throws Exception {
		//세션변경
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		ModelAndView mav = new ModelAndView();
		String ORIFIN_NUM = tb_odinfoxm.getORIGIN_NUM();
		
		try {
			orderService.insertRefund(tb_odinfoxm, tb_odinfoxd);
			mav.addObject("alertMessage", "환불신청이 완료되었습니다.");
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("alertMessage", "환불요청이 실패하였습니다. 잠시후 다시 시도하여 주시기 바랍니다.");
		}
		
		mav.addObject("returnUrl", servletContextPath.concat("/m/order/wishList"));
		mav.setViewName("alertMessage");

		return mav;
	}
}