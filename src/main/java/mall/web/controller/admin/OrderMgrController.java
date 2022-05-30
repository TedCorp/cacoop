package mall.web.controller.admin;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.Source;

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
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import mall.common.util.ExcelDownload;
import mall.common.util.FileUtil;
import mall.common.util.StringUtil;
import mall.common.util.excel.ExcelRead;
import mall.common.util.excel.ExcelReadOption;
import mall.web.apiLink.AtomyAzaAPI;
import mall.web.controller.DefaultController;
import mall.web.controller.responsiveMall.OrderRestController;
import mall.web.domain.TB_IPINFOXM;
import mall.web.domain.TB_LGUPLUS;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_PDSHIPXD;
import mall.web.domain.TB_PDSHIPXM;
import mall.web.domain.TB_SHIPTEXD;
import mall.web.domain.TB_SHIPTEXM;
import mall.web.domain.TB_SPINFOXM;
import mall.web.domain.XTB_ODINFOXM;
import mall.web.service.admin.impl.OrderMgrService;
import mall.web.service.admin.impl.OrderRfndMgrService;
import mall.web.service.admin.impl.ProductMgrService;
import mall.web.service.admin.impl.SupplierMgrService;
import mall.web.service.common.CommonService;
import mall.web.service.mall.OrderService;

@Controller
@RequestMapping(value="/adm/orderMgr")
public class OrderMgrController extends DefaultController{
	
	@Autowired
	private Environment environment;
	
	private static final Logger logger = LoggerFactory.getLogger(OrderMgrController.class);

	private final RestTemplate restTemplate = new RestTemplate();

	private final ObjectMapper objectMapper = new ObjectMapper();

	private final String SECRET_KEY = "test_sk_zXLkKEypNArWmo50nX3lmeaxYG5R";
	
	@Resource(name="orderMgrService")
	OrderMgrService orderMgrService;
	
	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="orderService")
	OrderService orderService;

	@Resource(name="supplierMgrService")
	SupplierMgrService supplierMgrService;
	
	@Resource(name="orderRfndMgrService")
	OrderRfndMgrService orderRfndMgrService;
	
	@Resource(name="productMgrService")
	ProductMgrService productMgrService;
	
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
	public ModelAndView getList(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute 	TB_ODINFOXD tb_odinfoxd ,  Model model, HttpServletRequest request) throws Exception {
		// 페이징 단위
		if(request.getParameter("pagerMaxPageItems") != null){
			tb_odinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			tb_odinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_odinfoxm.setRowCnt(20);
			tb_odinfoxm.setPagerMaxPageItems(20);
		}
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");		
		// 로그인 유저정보 (장보라)
		tb_odinfoxm.setMEMB_ID(loginUser.getMEMB_ID());
		tb_odinfoxm.setLOGIN_SUPR_ID(loginUser.getSUPR_ID());
		tb_odinfoxm.setMEMB_GUBN(loginUser.getMEMB_GUBN());
		//상품합계
		tb_odinfoxm.setCount(orderMgrService.getObjectCount(tb_odinfoxm));
		//상품리스트
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
				+ "&DLAR_DATE_ORDER=" + StringUtil.nullCheck(tb_odinfoxm.getDLAR_DATE_ORDER()))
				+ "&LOGIN_SUPR_ID="+ StringUtil.nullCheck(tb_odinfoxm.getLOGIN_SUPR_ID());
		
		
		
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
	public ModelAndView edit(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute  TB_ODINFOXD tb_odinfoxd, Model model, HttpServletRequest request) throws Exception {
		
		// 로그인 유저 정보
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");

		// 사용자의 업체코드
		model.addAttribute("login_supr_id", loginUser.getSUPR_ID());
		//배송비 조건
		/*
		 * TB_SPINFOXM tb_spinfoxm = new TB_SPINFOXM();
		 * tb_spinfoxm.setSUPR_ID("C00001"); //C00003 model.addAttribute("tb_spinfoxm",
		 * (TB_SPINFOXM)supplierMgrService.getObject(tb_spinfoxm));
		 */
		String memb_id=loginUser.getMEMB_ID();
		tb_odinfoxm.setMEMB_ID(memb_id); //로그인유저아이디
		 
		//주문 정보
		tb_odinfoxm = (TB_ODINFOXM)orderMgrService.getMasterInfo(tb_odinfoxm);
		tb_odinfoxm.setMEMB_ID(memb_id); //로그인유저아이디
		
		//로그인 유저 권한이 MEMB_GUBN_03 라면 admin (전체조회) : 장보라
		//로그인 유저 권한이 MEMB_GUBN_03 이 아니라면 해당업체의 주문건만 조회 : 장보라
		tb_odinfoxm.setMEMB_GUBN(loginUser.getMEMB_GUBN());  //로그인유저 권한
		tb_odinfoxm.setLOGIN_SUPR_ID(loginUser.getSUPR_ID()); //로그인유저 업체코드
		tb_odinfoxm.setList(orderMgrService.getDetailsList(tb_odinfoxm));
		
		System.out.println("주문번호 : " + tb_odinfoxm.getORDER_NUM());
		
		//배송비 계산 - 이유리
		int DLVY_AMT = orderMgrService.getNewDlvyAmt(tb_odinfoxm);
		tb_odinfoxm.setDLVY_AMT(DLVY_AMT + "");
		
		//주문금액 계산 - 이유리
		List<TB_ODINFOXM> list = new ArrayList<TB_ODINFOXM>();
		list = (List<TB_ODINFOXM>)orderMgrService.getSuprProductAmt(tb_odinfoxm);
		int ORDER_AMT = 0;
		
		for(TB_ODINFOXM index : list) {
			ORDER_AMT += Integer.parseInt(index.getSUPR_AMT());
		}
		
		tb_odinfoxm.setORDER_AMT(ORDER_AMT + "");
		
		//배송지 정보
		TB_ODDLAIXM tb_oddlaixm = new TB_ODDLAIXM();
		tb_oddlaixm = (TB_ODDLAIXM)orderMgrService.getDeliveryInfo(tb_odinfoxm);
		
		// 업체 정보 불러오기
		List<HashMap<String, String>> pd_supr_list = (List<HashMap<String, String>>) orderMgrService.getPdSuprList(tb_odinfoxm); 
		model.addAttribute("pd_supr_list", pd_supr_list);
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		model.addAttribute("tb_oddlaixm", tb_oddlaixm);
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderMgr/form");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문 및 결제정보 수정(디테일에서)
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
			, BindingResult result, SessionStatus status, Model model, HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		// 등록자 정보 변경필요
		tb_odinfoxm.setMEMB_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setMEMB_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setLOGIN_SUPR_ID(loginUser.getSUPR_ID()); 
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		tb_oddlaixm.setMODP_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setMODP_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setMEMB_GUBN(loginUser.getMEMB_GUBN());
	
		
		String[] ordsplit = tb_odinfoxd.getORDER_DTNUM().split(","); 
		String[] ordqtysplit =  tb_odinfoxm.getORDER_QTY().split(",");
		String[] ordsuprsplit =  tb_odinfoxd.getSUPR_ID().split(",");
		String[] dtldlvytdn =  tb_odinfoxd.getDTL_DLVY_TDN().split(",");
		String[] pd_code =  tb_odinfoxd.getPD_CODE().split(",");
		String[] order_con =tb_odinfoxd.getDTL_ORDER_CON().split(",");
		String[] option1_value =tb_odinfoxd.getOPTION1_VALUE().split(",");
		String[] option2_value =tb_odinfoxd.getOPTION2_VALUE().split(",");
		String[] option3_value =tb_odinfoxd.getOPTION3_VALUE().split(",");
		
		for(int i= 0; i<ordsplit.length;i++){
			tb_odinfoxd.setORDER_DTNUM(ordsplit[i]);
			tb_odinfoxd.setORDER_QTY(ordqtysplit[i]);
			tb_odinfoxd.setSUPR_ID(ordsuprsplit[i]);
			tb_odinfoxd.setPD_CODE(pd_code[i]);
			tb_odinfoxd.setORDER_CON(order_con[i]);	
			
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
			
				
				if(dtldlvytdn.length == 0 || dtldlvytdn.length < i+1) {
					tb_odinfoxd.setDTL_DLVY_TDN("");
					tb_odinfoxd.setDLVY_TDN("");
					
				}else {
					tb_odinfoxd.setDLVY_TDN(dtldlvytdn[i]);
					tb_odinfoxd.setDTL_DLVY_TDN(dtldlvytdn[i]);
					
				}
			orderMgrService.updateDatailQtyLink(tb_odinfoxd);	// 라온마켓(iibs) 이외의 주문처리
			orderMgrService.updateMasterQty(tb_odinfoxm);	
			//주문내역 D (수정)
			orderMgrService.getDetailsUpdate(tb_odinfoxd, tb_oddlaixm);
		
			// 주문수량 및 가격 변경
//			if(ordloginsuprsplit[i].equals(ordsuprsplit[i]) || ordsuprsplit[i].equals("C00001")){	//로그인유저 공급사 + c00001 상품도 같이 관리한다
//				orderMgrService.updateDatailQty(tb_odinfoxd);		// 라온마켓 주문처리
//			}
//			else
		
		}
		System.out.println(tb_odinfoxd.getORDER_NUM());
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderMgr/form/"+tb_odinfoxm.getORDER_NUM());		
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
	public ModelAndView pgCancel(@ModelAttribute TB_ODINFOXM tb_odinfoxm,@ModelAttribute TB_ODINFOXD tb_odinfoxd,  Model model, HttpServletRequest request) throws Exception {
		//로그인정보
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_odinfoxd.setMEMB_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setLOGIN_SUPR_ID(loginUser.getSUPR_ID()); 
		tb_odinfoxd.setMEMB_GUBN(loginUser.getMEMB_GUBN());
		
		//String[] ALL_DLVY_AMT2=request.getParameterValues("ALL_DLVY_AMT2");
		//System.out.println(Arrays.toString(ALL_DLVY_AMT2));
		
		TB_ODINFOXM od = (TB_ODINFOXM) orderService.getPayMdky(tb_odinfoxm);
		System.out.println("PAY_MDKY 주문키 : "+od.getPAY_MDKY());
	
		String[] pd_price = tb_odinfoxd.getPD_PRICE().split(",");
		String[] ordsuprsplit =  tb_odinfoxd.getSUPR_ID().split(",");
		String[] pd_code = tb_odinfoxd.getPD_CODE().split(",");
		String[] option1_value =tb_odinfoxd.getOPTION1_VALUE().split(",");
		String[] option2_value =tb_odinfoxd.getOPTION2_VALUE().split(",");
		String[] option3_value =tb_odinfoxd.getOPTION3_VALUE().split(",");
		String[] order_amt=tb_odinfoxd.getORDER_AMT().split(",");
		String[] setpd_code = tb_odinfoxd.getSETPD_CODE().split(",");
	
		/* 결제금액 & 배송비 재계산 - 이유리 */
		List<TB_ODINFOXM> list = new ArrayList<TB_ODINFOXM>();
		list = (List<TB_ODINFOXM>)orderMgrService.getSuprProductAmt(tb_odinfoxm);

		String SUPR_ID = "";  //공급사아이디 
		int size = ordsuprsplit.length;	//체크박스 length
		int CNT = 0;                // 공급사 상품 개수
		int SUPR_AMT = 0;			// 공급사 상품 합계
		int ALL_DLVY_AMT = Integer.parseInt(tb_odinfoxm.getDLVY_AMT()); //최초 배송비
		int ALL_SUPR_AMT = 0;
		int ALL_ORDER_AMT = Integer.parseInt(request.getParameter("ALL_ORDER_AMT")) - ALL_DLVY_AMT; //처음주문금액
		int refundAmt = 0;
		String SETPD_CODE = "";
		
		int result = 0;
		int result2 = 0;
		int total = 0;
		
		for(TB_ODINFOXM index : list) {
			CNT = Integer.parseInt(index.getCNT());			 	 		 // 묶음상품 개수
			ALL_SUPR_AMT = Integer.parseInt(index.getSUPR_AMT());		 // 공급사 상품 총액
			SUPR_AMT = Integer.parseInt(index.getSUPR_AMT());			 // 묶음상품 금액(총액  - 취소금액 = 남은금액)
			SETPD_CODE = index.getSETPD_CODE();							 // 묶음상품 코드
			int COUNT = 0;
			
			for(int i = 0; i < size; i++) {
				System.out.println(SETPD_CODE);
				System.out.println(setpd_code[i]);
				//묶음상품코드가 같을 때
				if(SETPD_CODE.equals(setpd_code[i])) {
					//상품 금액
					SUPR_AMT = SUPR_AMT - Integer.parseInt(order_amt[i]);
					COUNT++;
					
					//배송비 마스터 가져오기
					TB_PDSHIPXM tb_pdshipxm = new TB_PDSHIPXM();
					tb_pdshipxm.setPD_CODE(setpd_code[i]);
					tb_pdshipxm = (TB_PDSHIPXM)productMgrService.getShipMaster(tb_pdshipxm);
					
					//배송비 개별
					if(tb_pdshipxm.getSHIP_CONFIG().equals("SHIP_CONFIG_02")) {
						//배송비 디테일 가져오기
						if(tb_pdshipxm.getSHIP_GUBN().equals("SHIP_GUBN_03") || tb_pdshipxm.getSHIP_GUBN().equals("SHIP_GUBN_04")) {
							TB_PDSHIPXD tb_pdshipxd = new TB_PDSHIPXD();
							List<TB_PDSHIPXD> list2 = new ArrayList<TB_PDSHIPXD>();
							tb_pdshipxd.setPD_CODE(setpd_code[i]);
							list2 = (List<TB_PDSHIPXD>)productMgrService.getShipDetail(tb_pdshipxd);
							
							for(TB_PDSHIPXD index2 : list2) {
								String PD_CODE = index2.getPD_CODE();
								int GUBN_START = Integer.parseInt(index2.getGUBN_START());
								int GUBN_END = Integer.parseInt(index2.getGUBN_END());
								int DLVY_AMT = Integer.parseInt(index2.getDLVY_AMT());
								
								//구매금액별
								if(tb_pdshipxm.getSHIP_GUBN().equals("SHIP_GUBN_03")) {
									if(setpd_code[i].equals(PD_CODE)) {
										if(SUPR_AMT != 0) {
											if((SUPR_AMT > GUBN_START || SUPR_AMT == GUBN_START) && SUPR_AMT < GUBN_END) {
												tb_odinfoxd.setDLVY_AMT(DLVY_AMT + "");
												tb_odinfoxd.setSETPD_CODE(setpd_code[i]);
												orderMgrService.updateDlvyAmt(tb_odinfoxd);
											}
										}
									}
								//상품수량별
								} else {
									if(setpd_code[i].equals(PD_CODE)) {
										if(CNT - COUNT != 0) {
											if(((CNT - COUNT) > GUBN_START || (CNT - COUNT) == GUBN_START) && (CNT - COUNT) < GUBN_END) {
												tb_odinfoxd.setDLVY_AMT(DLVY_AMT + "");
												tb_odinfoxd.setSETPD_CODE(setpd_code[i]);
												orderMgrService.updateDlvyAmt(tb_odinfoxd);
											}
										}
									}
								}
							}
						//조건부무료배송
						} else if(tb_pdshipxm.getSHIP_GUBN().equals("SHIP_GUBN_02")) {
							if(SUPR_AMT < Integer.parseInt(tb_pdshipxm.getGUBN_START())) {
								tb_odinfoxd.setDLVY_AMT(tb_pdshipxm.getDLVY_AMT());
								tb_odinfoxd.setSETPD_CODE(setpd_code[i]);
								orderMgrService.updateDlvyAmt(tb_odinfoxd);
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
										if((SUPR_AMT > GUBN_START || SUPR_AMT == GUBN_START) && SUPR_AMT < GUBN_END) {
											tb_odinfoxd.setDLVY_AMT(DLVY_AMT + "");
											tb_odinfoxd.setSETPD_CODE(setpd_code[i]);
											orderMgrService.updateDlvyAmt(tb_odinfoxd);
										}
									}
								//상품수량별
								} else {
									if(tb_shiptexd.getTEMP_NUM().equals(TEMP_NUM)) {
										if(((CNT - COUNT) > GUBN_START || (CNT - COUNT) == GUBN_START) && (CNT - COUNT) < GUBN_END) {
											tb_odinfoxd.setDLVY_AMT(DLVY_AMT + "");
											tb_odinfoxd.setSETPD_CODE(setpd_code[i]);
											orderMgrService.updateDlvyAmt(tb_odinfoxd);
										}
									}
								}
							}
						//조건부무료배송
						} else if(tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_02")) {
							if(SUPR_AMT < Integer.parseInt(tb_pdshipxm.getGUBN_START())) {
								tb_odinfoxd.setDLVY_AMT(tb_shiptexm.getDLVY_AMT());
								tb_odinfoxd.setSETPD_CODE(setpd_code[i]);
								orderMgrService.updateDlvyAmt(tb_odinfoxd);
							}
						}
					//배송비 기본
					} else {
						if(SUPR_AMT < Integer.parseInt(tb_pdshipxm.getGUBN_START())) {
							tb_odinfoxd.setDLVY_AMT(tb_pdshipxm.getDLVY_AMT());
							tb_odinfoxd.setSETPD_CODE(setpd_code[i]);
							orderMgrService.updateDlvyAmt(tb_odinfoxd);
						}
					}
				}
				
			}
		}
		
		for(int i = 0; i < size; i++) {
			refundAmt += Integer.parseInt(order_amt[i]);
		}
		
		ALL_ORDER_AMT = ALL_ORDER_AMT - refundAmt;
		System.out.println("취소상품 뺀 상품가격 : " + ALL_ORDER_AMT);
		
		for(int i=0; i<pd_price.length;i++) {
         	tb_odinfoxd.setSUPR_ID(ordsuprsplit[i]);
 			tb_odinfoxd.setPD_CODE(pd_code[i]);
 			tb_odinfoxd.setORDER_CON("ORDER_CON_04");
 			tb_odinfoxd.setCNCL_CON("CNCL_CON_03");
 			tb_odinfoxd.setRFND_AMT(order_amt[i]);	
 			tb_odinfoxd.setMODP_ID(loginUser.getMEMB_ID());
 			
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
         	
         	total = orderMgrService.getUpdateCancel(tb_odinfoxd);
    	}
		
		System.out.println("refundAmt은 얼마? : " + refundAmt);
		//배송비 새로 가져오기
		int NEW_DLVY_AMT = orderMgrService.getNewDlvyAmt(tb_odinfoxm);
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
		
		/*
		for(int j=0; j<ALL_DLVY_AMT2.length; j++) {
			refundAmt=0;
			for(int i=0; i<order_amt.length; i++) {
				refundAmt+=Integer.parseInt(order_amt[i]);
			}
			System.out.println("배송비계산전 취소금액 :" +refundAmt);
			if(Integer.parseInt(ALL_DLVY_AMT2[j])==0){ //만약에 
				System.out.println(CNT);
				if(CNT==1) {
					refundAmt+=Integer.parseInt(ALL_DLVY_AMT2[j]);
					System.out.println("배송비 포함하여 취소(주문내용을 전부 취소할때) :" + refundAmt);
				}else {
					refundAmt-=Integer.parseInt(DLVY_AMT2);
					System.out.println("배송비 빼고 취소(주문금액이 3만원 이하로 갈때) :" + refundAmt);
				}
			}else {
				System.out.println(CNT);
				if(CNT==1) {
					refundAmt+=Integer.parseInt(ALL_DLVY_AMT2[j]);
					System.out.println("배송비 포함 취소(주문내용을 전부 취소할때)"+refundAmt);
				}
				System.out.println("배송비 빼고 취소금액"+refundAmt);	
			} 
		}*/
		
		
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
	            Object company = card.get("company");
	            Object number = card.get("number");
	            System.out.println("cancels : " + jsonNode.get("cancels").toString());
	            JSONArray cancelsArr = new JSONArray(jsonNode.get("cancels").toString());
	            JSONObject cancels = cancelsArr.getJSONObject(0);
	            Object cancelAmount = cancels.get("cancelAmount");
	            Object refundableAmount = cancels.get("refundableAmount");
	            Object canceledAt = cancels.get("canceledAt");
	            
	            try {
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
				    tb_lguplus.setLGD_PAYDATE(canceledAt.toString()); 						// 취소날짜 
				    tb_lguplus.setLGD_FINANCECODE(company.toString()); 						// 은행코드 
				    tb_lguplus.setLGD_FINANCENAME(number.toString()); 						// 은행명 
				    if(tb_lguplus.getLGD_TID() != null) {
						orderService.lguplusLogInsert(tb_lguplus);
				   	}
				}catch(Exception e){
					logger.info("LgUplus Logging Error : " + e.toString());
				}
	            int RFND_AMT = Integer.parseInt(tb_odinfoxm.getRFND_AMT());
	            System.out.println("기존 취소금액 : " + RFND_AMT);
	            
	            tb_odinfoxm.setRFND_AMT(RFND_AMT + refundAmt + "");
		    	result2 = orderMgrService.updateObject(tb_odinfoxm);
		    	result = total + result2;
		    	
		    	System.out.println("결제취소 성공");
		    	System.out.println("total : " + total);
		 		System.out.println("result2 : " + result2);
		 		System.out.println("최종값 : " + result);
	        } else {
	        	//ORDER_CON 되돌리기
	        	for(int i=0; i<size; i++) {
	        		tb_odinfoxd.setSUPR_ID(ordsuprsplit[i]);
	     			tb_odinfoxd.setPD_CODE(pd_code[i]);
	     			tb_odinfoxd.setORDER_CON("ORDER_CON_02");
	     			tb_odinfoxd.setCNCL_CON("");
	     			tb_odinfoxd.setRFND_AMT("0");	
	     			tb_odinfoxd.setMODP_ID(loginUser.getMEMB_ID());
	    	    	int result1 = orderMgrService.getUpdateCancel(tb_odinfoxd);
	    	    	if(result1 == 1) {
	    	    		total++;
	    	    	}
	    	    }
		    	
		    	System.out.println("결제취소 실패");
		    	System.out.println("total : " + total);
		 		System.out.println("최종값 : " + total);
	        	
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
	
	
	
//	@RequestMapping(value={ "/pgCancel" }, method=RequestMethod.POST)
//	public ModelAndView pgCancel(@ModelAttribute TB_ODINFOXM tb_odinfoxm,@ModelAttribute TB_ODINFOXD tb_odinfoxd,  Model model, HttpServletRequest request) throws Exception {
//		// 주문정보
//		
//		TB_ODINFOXM od = (TB_ODINFOXM) orderService.getPayMdky(tb_odinfoxm);
//		System.out.println("PAY_MDKY : "+tb_odinfoxm.getPAY_MDKY());
//		System.out.println("PD_CODE : "+tb_odinfoxd.getPD_CODE());
//		ModelAndView mav = new ModelAndView();
//		Map<String,String> payResMap = new HashMap<String,String>();
//		
//    	boolean bState = false;
//    	String STATE ="";
//    	String PAY_METD = od.getPAY_METD();
//    	
//		// 결제 정보가 있을경우
//		if(StringUtils.isNotEmpty(od.getPAY_MDKY())){
//
//		    /*
//		     * [결제취소 요청 페이지]
//		     * LG유플러스으로 부터 내려받은 거래번호(LGD_TID)를 가지고 취소 요청을 합니다.(파라미터 전달시 POST를 사용하세요)
//		     * (승인시 LG유플러스으로 부터 내려받은 PAYKEY와 혼동하지 마세요.)
//		     */ 
//		    String CST_PLATFORM	= environment.getRequiredProperty("lguplus.cst_platform");		//LG유플러스 결제서비스 선택(test:테스트, service:서비스)
//		    String CST_MID= environment.getRequiredProperty("lguplus.cst_mid");			//LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요.
//		    String LGD_MID= ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  		//테스트 아이디는 't'를 제외하고 입력하세요.
//		    String LGD_TID= od.getPAY_MDKY();                      						//LG유플러스으로 부터 내려받은 거래번호(LGD_TID)
//
//			/* 
//			 * ※ 중요
//			 * 환경설정 파일의 경우 반드시 외부에서 접근이 가능한 경로에 두시면 안됩니다.
//			 * 해당 환경파일이 외부에 노출이 되는 경우 해킹의 위험이 존재하므로 반드시 외부에서 접근이 불가능한 경로에 두시기 바랍니다. 
//			 * 예) [Window 계열] C:\inetpub\wwwroot\lgdacom ==> 절대불가(웹 디렉토리)
//			 */
//		    String configPath= environment.getRequiredProperty("lguplus.configPath");	//LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf") 위치 지정.
//		        
//		    LGD_TID= ( LGD_TID == null )?"":LGD_TID; 
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
//		    	
//		    	// 신용카드
//		    	if("SC0010".equals(PAY_METD)){
//		    		// 취소 정상 승인
//		    		if("0000".equals( xpay.m_szResCode ) || "AV11".equals( xpay.m_szResCode )) {
//		    			mav.addObject("alertMessage", "[" + xpay.m_szResCode + "] " + "결제 취소요청이 완료되었습니다.");
//		    			isXpayOK = true;
//		    		}
//	    		// 계좌이체
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
//	    		// 기타 결제
//		    	} else {
//		    		if("0000".equals( xpay.m_szResCode )) {
//		    			mav.addObject("alertMessage", "결제 취소요청이 완료되었습니다.");
//		    			isXpayOK = true;
//		    		}
//		    	}
//		    	
//		    	
//		    	if(isXpayOK) {
//		    		tb_odinfoxm.setORDER_CON("ORDER_CON_04");		// 주문취소
//					tb_odinfoxm.setCNCL_CON("CNCL_CON_03");			// 취소완료
//					
//					try{
//						if (orderService.cancelObject(tb_odinfoxm) > 0){
//							orderService.orderPayUpdateDtl(tb_odinfoxm);
//							
//							// 애터미아자 API 호출 (결제완료, 배송완료, 주문취소, 환불)
//							AtomyAzaAPI azapi = new AtomyAzaAPI();
//							azapi.Cancel_AtomyAza(orderService, tb_odinfoxm.getORDER_NUM());
//							
//						} 
//						bState = isXpayOK;
//	        			STATE = "OK";
//	        			
//					} catch(Exception e){
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
//		    	STATE = "결제취소요청실패, API 요청 실패.";
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
//				System.out.println("얍");
//			}catch(Exception e){
//				System.out.println("pgCancel의 에러입니다. "+e.getMessage());
//			}
//		    
//		}else{ //결제정보가 없을 경우
//			mav.addObject("alertMessage", "PG사 결제정보가 없습니다. 결제수단을 확인해주세요.");
//		}
//		
//		mav.addObject("payResMap", payResMap);
//		mav.addObject("returnUrl", servletContextPath.concat("/adm/orderMgr/form/" + tb_odinfoxm.getORDER_NUM()));
//		mav.setViewName("alertMessage");
//		
//		return mav;
//	}
//	
	
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: getState
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문상태 변경(List에서 )
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
		tb_odinfoxm.setMEMB_ID(loginUser.getMEMB_ID());
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		tb_odinfoxm.setMEMB_GUBN(loginUser.getMEMB_GUBN());
		tb_odinfoxm.setLOGIN_SUPR_ID(loginUser.getSUPR_ID());
		for(String obj : arrayParams){
			tb_odinfoxm.setORDER_NUM(obj);
			if( orderMgrService.updateState(tb_odinfoxm) > 0 ) {        		
        		//주문디테일 처리
				orderMgrService.orderPayUpdateDtl(tb_odinfoxm);
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
	public void getDlvyTdnExcelDown(@ModelAttribute TB_ODINFOXD tb_odinfoxd, Model model, HttpServletResponse response, HttpServletRequest request
			,@RequestParam("DLVY_TDN_ORDERNUM") String dlvy_tdn_ordernum) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_odinfoxd.setLOGIN_SUPR_ID(loginUser.getSUPR_ID());
		tb_odinfoxd.setMEMB_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setMEMB_GUBN(loginUser.getMEMB_GUBN());
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
	public void getOrderExcelDown( Model model, HttpServletResponse response, HttpServletRequest request
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		
		
		String[] headerName = {"주문일자", "결제시간", "주문번호", "상품바코드", "주문상품", "판매수량","제품단가",  "총결제금액", "주문상태 결제수단", "주문상태", "고객배송 요청사항","구매자명","수령자명","주소", "구매자전화번호", "수령자전화번호", "운송장번호", "송장전송일", "택배사"};
		String[] columnName = {"ORDER_DATE", "PAY_DTM" ,"ORDER_NUM", "PD_BARCD","PD_NAME","ORDER_QTY","PD_PRICE", "ORDER_AMT", "PAY_METD","ORDER_CON_NM", "DLVY_MSG","MEMB_NAME", "RECV_PERS","ORDER_ADDR", "MEMB_TEL", "RECV_TEL", "DLVY_TDN", "DLVY_TDN_MODP_DATE", "DLVY_COM_NAME"};
		
		String sheetName = "주문내역(애터미)";		
		
		TB_ODINFOXD od = new TB_ODINFOXD(); 
		TB_ODINFOXM om = new TB_ODINFOXM();
		String[] chkArray = request.getParameter("CHK_ORD_LIST").split(",");
		List<String> stringList = Arrays.asList(chkArray);
		od.setObj(stringList);
		
		om.setSUPR_ID(loginUser.getSUPR_ID());
		od.setSUPR_ID(loginUser.getSUPR_ID());
		od.setLOGIN_SUPR_ID(loginUser.getSUPR_ID());
		od.setMEMB_ID(loginUser.getMEMB_ID());
		od.setMEMB_GUBN(loginUser.getMEMB_GUBN());
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
	@Transactional
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
