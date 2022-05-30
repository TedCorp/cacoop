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

import mall.common.util.ExcelDownload;
import mall.common.util.FileUtil;
import mall.common.util.StringUtil;
import mall.common.util.excel.ExcelRead;
import mall.common.util.excel.ExcelReadOption;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_SPINFOXM;
import mall.web.domain.XTB_ODINFOXM;
import mall.web.service.admin.impl.OrderMgrLinkService;
import mall.web.service.admin.impl.SupplierMgrService;

@Controller
@RequestMapping(value="/adm/orderMgrLink")
public class OrderMgrLinkController extends DefaultController{

	@Resource(name="orderMgrLinkService")
	OrderMgrLinkService orderMgrLinkService;
	
	/*@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="orderService")
	OrderService orderService;*/

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
	//iibs
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model,HttpServletRequest request) throws Exception {
		
		// 로그인 유저 정보
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		
		// C00001만 업데이트 되도록 변경
		/*if(tb_odinfoxm.getORDER_CON_STATE()!="" && tb_odinfoxm.getORDER_CON_STATE()!=null){
		 * // 등록자 정보 변경필요
			tb_odinfoxm.setMODP_ID("admin");
			orderMgrLinkService.updateStateObject(tb_odinfoxm);
		}*/
		
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_odinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));	//페이징 단위 : 50
			tb_odinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_odinfoxm.setRowCnt(20);	//페이징 단위 : 20
			tb_odinfoxm.setPagerMaxPageItems(20);
		}
		
		// 조건 : 유저의 해당 업체코드 주문만 노출 
		//tb_odinfoxm.setLOGIN_SUPR_ID(loginUser.getSUPR_ID());
		tb_odinfoxm.setLOGIN_SUPR_ID("C00001");		
		tb_odinfoxm.setCount(orderMgrLinkService.getObjectCount(tb_odinfoxm));
		tb_odinfoxm.setList(orderMgrLinkService.getPaginatedObjectList(tb_odinfoxm));
		
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
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderMgrLink/list");
	}
	
	// 운송장 양식 조회
	@RequestMapping(value={ "/DlvyTdnExcelDown" }, method=RequestMethod.GET)
	public void getDlvyTdnExcelDown(Model model, HttpServletResponse response, HttpServletRequest request
			,@RequestParam("DLVY_TDN_ORDERNUM") String dlvy_tdn_ordernum) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		
		String[] headerName = {"주문번호", "주문상세번호","상품코드","상품명","수량","주문자","주소", "배송업체", "송장번호"};
		String[] columnName = {"ORDER_NUM","ORDER_DTNUM","PD_CODE","PD_NAME","ORDER_QTY","ORDER_MEM_NM","ORDER_ADDR", "DLVY_COM","DLVY_TDN"};
		
		String sheetName = "운송장내역";		
		
		//List<String> order_list = Arrays.asList(dlvy_tdn_ordernum.split(","));
		
		TB_ODINFOXD od = new TB_ODINFOXD(); 
		
		od.setObj(Arrays.asList(dlvy_tdn_ordernum.split(",")));
		//od.setSUPR_ID(loginUser.getSUPR_ID());		
		od.setSUPR_ID("C00001");
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) orderMgrLinkService.getDlvyTdnlExcelList(od);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);		
	}	

	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문내역 상세 및 주문상태/결제정보(form)
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
		//model.addAttribute("login_supr_id", loginUser.getSUPR_ID());
		model.addAttribute("login_supr_id", "C00001");
		
		//배송비 조건
		TB_SPINFOXM tb_spinfoxm = new TB_SPINFOXM();
		tb_spinfoxm.setSUPR_ID("C00001");	//C00003
		model.addAttribute("tb_spinfoxm", (TB_SPINFOXM)supplierMgrService.getObject(tb_spinfoxm));
		
		// 로그인 유저의 업체상품만 조회
		//tb_odinfoxm.setLOGIN_SUPR_ID(loginUser.getSUPR_ID());
		tb_odinfoxm.setLOGIN_SUPR_ID("C00001");
		
		
		//주문정보 마스터 정보
		tb_odinfoxm = (TB_ODINFOXM)orderMgrLinkService.getMasterInfo(tb_odinfoxm);
		
		//주문정보 상세				
		tb_odinfoxm.setList(orderMgrLinkService.getDetailsList(tb_odinfoxm));
		
		// YT몰 첫번째 상품의 배송정보 및 주문상태를 YT몰 전체상품의 상태로 인지한다 
		tb_odinfoxm.setORDER_CON( ((TB_ODINFOXD)(tb_odinfoxm.getList().get(0))).getORDER_CON() );
		tb_odinfoxm.setDLVY_TDN( ((TB_ODINFOXD)(tb_odinfoxm.getList().get(0))).getDLVY_TDN() );
		
		//배송지 정보
		TB_ODDLAIXM tb_oddlaixm = new TB_ODDLAIXM();
		tb_oddlaixm = (TB_ODDLAIXM)orderMgrLinkService.getDeliveryInfo(tb_odinfoxm);
		
		// 업체 정보 불러오기
		List<HashMap<String, String>> pd_supr_list = (List<HashMap<String, String>>) orderMgrLinkService.getPdSuprList(tb_odinfoxm); 
		//pd_supr_list = (TB_SPINFOXM)orderMgrLinkService.getPdSuprList(tb_odinfoxm);
		model.addAttribute("pd_supr_list", pd_supr_list);
		
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		model.addAttribute("tb_oddlaixm", tb_oddlaixm);
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderMgrLink/form");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: update
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
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView update(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODDLAIXM tb_oddlaixm, @ModelAttribute TB_ODINFOXD tb_odinfoxd
			, BindingResult result, SessionStatus status, Model model) throws Exception {
		// 등록자 정보 변경필요
		tb_odinfoxm.setMODP_ID("admin");
		tb_oddlaixm.setMODP_ID("admin");
		
		String[] ordsplit = tb_odinfoxd.getORDER_DTNUM().split(",");
		String[] ordqtysplit =  tb_odinfoxm.getORDER_QTY().split(",");
		//String[] ordloginsuprsplit =  tb_odinfoxd.getLOGIN_SUPR_ID().split(",");
		String[] ordsuprsplit =  tb_odinfoxd.getSUPR_ID().split(",");
		String[] dtldlvytdn =  tb_odinfoxd.getDTL_DLVY_TDN().split(",");
		
		
		for(int i= 0; i<ordsplit.length;i++){
			
			tb_odinfoxd.setORDER_DTNUM(ordsplit[i]);
			tb_odinfoxd.setORDER_QTY(ordqtysplit[i]);
			tb_odinfoxd.setSUPR_ID(ordsuprsplit[i]);
			tb_odinfoxd.setLOGIN_SUPR_ID("C00001");
			
			
			if(dtldlvytdn.length == 0 || dtldlvytdn.length < i+1)
				tb_odinfoxd.setDTL_DLVY_TDN("");
			else
				tb_odinfoxd.setDTL_DLVY_TDN(dtldlvytdn[i]);

			//tb_odinfoxd.setDTL_DLVY_TDN(dtldlvytdn[i] == null ? "" : dtldlvytdn[i]);
			
			// 주문수량 및 가격 변경 X, 운송장번호, 배송정보 업데이트 (수정) 
			orderMgrLinkService.updateDatailQty(tb_odinfoxd);
		}		
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderMgrLink/form/"+tb_odinfoxm.getORDER_NUM());		
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
			model.addAttribute("objList", orderMgrLinkService.getPickingGoodsList(tb_odinfoxm));
		}else if (tb_odinfoxm.getORDER_GUBUN()!=null && tb_odinfoxm.getORDER_GUBUN().equals("com")){
			model.addAttribute("objList", orderMgrLinkService.getPickingComList(tb_odinfoxm));
		}else if(tb_odinfoxm.getORDER_GUBUN()!=null && tb_odinfoxm.getORDER_GUBUN().equals("car")){
			model.addAttribute("objList", orderMgrLinkService.getPickingCarList(tb_odinfoxm));
		}else{
			model.addAttribute("objList", orderMgrLinkService.getPickingList(tb_odinfoxm));
		}
		model.addAttribute("today",new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		//mav.addObject("obj",orderMgrLinkService.getPickingList(tb_odinfoxm));
		//mav.addObject("test","test");
		
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
		
		List<?> pickingList = orderMgrLinkService.getPickingList(tb_odinfoxm);
		for(int i=0;i<pickingList.size();i++){	//여기서 업데이트
			String num = ((TB_ODINFOXM)pickingList.get(i)).getORDER_NUM();
		
			orderMgrLinkService.updatePickingList(num);
		}
		
		//orderMgrLinkService.updatePickingList(pickingList); foreach쓸때..
				
		return new ModelAndView("admin.layout", "jsp", "admin/orderMgr/list");
	}
	
	// 주문내역 엑셀
	@RequestMapping(value={ "/excelDown" }, method=RequestMethod.GET)
	public void getExcelList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model,HttpServletRequest request,HttpServletResponse response
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {
		
		String[] headerName = {"주문일자","결제시간", "주문번호","주문자명","사업자상호","주문상품","총 결제금액","배송료","상품주문금액","주문상태 결제수단","출고방식","고객배송 요청사항","배송참조사항(관리자기록)"};
		String[] columnName = {"ORDER_DATE","PAY_DTM","ORDER_NUM","MEMB_NM","COM_NAME","PD_NAME","ORDER_AMT","DLVY_AMT","REAL_AMT","ORDER_CON_NM","DLAR_GUBN","DLVY_MSG","ADM_REF"};
//
//		String[] headerName = {"주문일시", "주문번호", "주문자명(수령자명)", "주문상품", "총 주문금액", "주문상태(결제수단)"};
//		String[] columnName = {"ORDER_DATE", "ORDER_NUM", "MEMB_NM", "PD_NAME", "ORDER_AMT","ORDER_CON_NM"};
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

		List<HashMap<String, String>> list = (List<HashMap<String, String>>) orderMgrLinkService.getExcelList(tb_odinfoxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);		
	}
	
	// 주문상세내역 엑셀
	@RequestMapping(value={ "/detailExcelDown" }, method=RequestMethod.GET)
	public void getDetailExcelList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model,HttpServletResponse response
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {
		
		String[] headerName = {"주문번호","주문일자", "사업자상호","주문자","배송비결재여부","바코드","상품명","세절방식","색상","과면세구분","수량","정상가","할인금액","단가","가격"};
		String[] columnName = {"ORDER_NUM","ORDER_DATE", "COM_NAME","MEMB_NM","DAP_YN","PD_BARCD","PD_NAME","PD_CUT_SEQ","OPTION_NAME","TAX_GUBN","ORDER_QTY","PD_PRICE"
											,"PDDC_VAL","ORDER_PREICE","ORDER_AMT"};

		String sheetName = "주문내역상세";
		
		tb_odinfoxm.setList(arrayParams);

		List<HashMap<String, String>> list = (List<HashMap<String, String>>) orderMgrLinkService.getDetailExcelList(tb_odinfoxm);
		
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
			list= (List<HashMap<String, String>>)orderMgrLinkService.getPickingGoodsExcel(tb_odinfoxm);
			headerName = new String[]{"상품코드", "상품명", "규격", "입수", "주문수량","바코드","배송구분"};
			columnName = new String[]{"PD_CODE","PD_NAME", "PD_STD", "INPUT_CNT","ORDER_QTY", "PD_BARCD", "DLVY_GUBN"};
			sheetName = "피킹리스트(상품별)";
		}else if (tb_odinfoxm.getORDER_GUBUN()!=null && tb_odinfoxm.getORDER_GUBUN().equals("com")){
			list= (List<HashMap<String, String>>)orderMgrLinkService.getPickingComExcel(tb_odinfoxm);
			headerName = new String[]{"상품코드", "매출처명", "상품명", "규격", "입수", "주문수량","바코드","배송구분"};
			columnName = new String[]{"PD_CODE","COM_ORD","PD_NAME", "PD_STD", "INPUT_CNT","ORDER_QTY", "PD_BARCD", "DLVY_GUBN"};
			sheetName = "피킹리스트(매출처별)";
		}else if(tb_odinfoxm.getORDER_GUBUN()!=null && tb_odinfoxm.getORDER_GUBUN().equals("car")){
			list= (List<HashMap<String, String>>)orderMgrLinkService.getPickingCarExcel(tb_odinfoxm);
			headerName = new String[]{"상품코드","차량별" ,"매출처명", "상품명", "규격", "입수", "주문수량","바코드","배송구분"};
			columnName = new String[]{"PD_CODE","CAR_NUM_NM","COM_ORD","PD_NAME", "PD_STD", "INPUT_CNT","ORDER_QTY", "PD_BARCD", "DLVY_GUBN"};
			sheetName = "피킹리스트(차량별)";
		}else{
			//list= (List<HashMap<String, String>>)orderMgrLinkService.getPickingExcel(tb_odinfoxm);
			headerName = new String[]{"순번", "상품명", "규격", "입수", "주문수량","바코드","배송구분"};
			columnName = new String[]{"PD_CODE","PD_NAME", "PD_STD", "INPUT_CNT","ORDER_QTY", "PD_BARCD", "DLVY_GUBN"};
		}
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);		
	}
	
	
	@RequestMapping(value={ "/deleteOrdList" }, method=RequestMethod.POST)
	public ModelAndView deleteOrdList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model,HttpServletResponse response
			,HttpServletRequest request) throws Exception {
		
		String str1 = request.getParameter("ORD_DELETE_LIST");
        String[] words = str1.split(",");
         
        for (String wo : words ){
    		orderMgrLinkService.deleteOrdList(wo);
    		orderMgrLinkService.deleteOrdDetail(wo);
        }			
        
        RedirectView rv = new RedirectView(servletContextPath.concat("/adm/orderMgr"));
		return new ModelAndView(rv);		
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: orderQtyUpdate
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
	@RequestMapping(value="/orderQtyUpdate",method=RequestMethod.POST)
	public ModelAndView updateQty(TB_ODINFOXM tb_odinfoxm, TB_ODINFOXD tb_odinfoxd,Model model) throws Exception{
		// 등록자 정보 변경필요
		tb_odinfoxm.setMODP_ID("admin");
		tb_odinfoxd.setMODP_ID("admin");
		
		orderMgrLinkService.updateDatailQty(tb_odinfoxd);
		orderMgrLinkService.updateMasterQty(tb_odinfoxm);
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderMgr/form/"+tb_odinfoxm.getORDER_NUM());		
		return new ModelAndView(redirectView);
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: excelDlvyUpload
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 운송장번호 엑셀 업로드
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/excelDlvyUpload",method=RequestMethod.POST)
	public ModelAndView excelDlvyUpload(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model, MultipartHttpServletRequest multipartRequest) throws Exception{
		
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
	        excelReadOption.setOutputColumns("A","B","C","D","E","F","G","H","I");
	        excelReadOption.setStartRow(2);
	        	        
	        List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);

			if (excelReadOption.getNumCellCnt() != 9) {
				ModelAndView mav = new ModelAndView();
				
				mav.addObject("alertMessage", "엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식을 재 다운로드 해주시기 바랍니다.");
				mav.addObject("returnUrl", "back");
				mav.setViewName("alertMessage");
				return mav;
			}
			
	        try{
	        	list = orderMgrLinkService.excelDlvyUpload(tb_odinfoxd, excelContent);
	        	
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
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderMgrLink/excelResult");
	}
}
