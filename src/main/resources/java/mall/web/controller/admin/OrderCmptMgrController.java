package mall.web.controller.admin;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.util.ExcelDownload;
import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_SPINFOXM;
import mall.web.domain.XTB_ODINFOXM;
import mall.web.service.admin.impl.OrderEditMgrService;
import mall.web.service.admin.impl.OrderMgrService;
import mall.web.service.admin.impl.ReturnOrderMgrService;
import mall.web.service.admin.impl.SupplierMgrService;
import mall.web.service.common.CommonService;
import mall.web.service.mall.OrderService;

@Controller
@RequestMapping(value="/adm/orderCmptMgr")
public class OrderCmptMgrController extends DefaultController{

	@Resource(name="orderMgrService")
	OrderMgrService orderMgrService;
	
	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="supplierMgrService")
	SupplierMgrService supplierMgrService;

	@Resource(name="returnOrderMgrService")
	ReturnOrderMgrService returnOrderMgrService;

	@Resource(name="orderEditMgrService")
	OrderEditMgrService orderEditMgrService;

	@Resource(name="orderService")
	OrderService orderService;
		
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderCmptMgrController.java
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
		//페이징 단위 : 20
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_odinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			tb_odinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_odinfoxm.setRowCnt(20);	
			tb_odinfoxm.setPagerMaxPageItems(20);
		}
		
		tb_odinfoxm.setORDER_CON("ORDER_CON_08");
		tb_odinfoxm.setCount(orderMgrService.getObjectCount(tb_odinfoxm));
		tb_odinfoxm.setList(orderMgrService.getPaginatedObjectList(tb_odinfoxm));
		
		model.addAttribute("obj", tb_odinfoxm);
		model.addAttribute("rowCnt", tb_odinfoxm.getRowCnt());
		model.addAttribute("totalCnt", tb_odinfoxm.getCount());

		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(tb_odinfoxm.getSchGbn())
				+ "&schTxt="+StringUtil.nullCheck(tb_odinfoxm.getSchTxt()
				+ "&PAY_METD="+StringUtil.nullCheck(tb_odinfoxm.getPAY_METD())
				+ "&pagerMaxPageItems="+StringUtil.nullCheck(tb_odinfoxm.getPagerMaxPageItems())
				+ "&datepickerStr=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerStr())
				+ "&datepickerEnd=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerEnd()));
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderCmptMgr/list");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderCmptMgrController.java
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
		model.addAttribute("login_supr_id", loginUser.getSUPR_ID());
		// 배송비 조건
		TB_SPINFOXM tb_spinfoxm = new TB_SPINFOXM();
		tb_spinfoxm.setSUPR_ID("C00001");	//C00003
		model.addAttribute("tb_spinfoxm", (TB_SPINFOXM)supplierMgrService.getObject(tb_spinfoxm));
		
		// 주문 정보
		tb_odinfoxm = (TB_ODINFOXM)orderMgrService.getMasterInfo(tb_odinfoxm);
		tb_odinfoxm.setList(orderMgrService.getDetailsList(tb_odinfoxm));

		// 기존 환불정보
		List<TB_ODINFOXM> returnNum = (List<TB_ODINFOXM>) returnOrderMgrService.rtnOrderInfo(tb_odinfoxm); 
		model.addAttribute("returnNum", returnNum);
		
		// 환불신청 정보
		TB_ODINFOXM tb_rtninfoxm = new TB_ODINFOXM();
		if (returnNum != null){
			tb_rtninfoxm.setList(orderService.getRefundList(tb_odinfoxm));
		}
		model.addAttribute("tb_rtninfoxm", tb_rtninfoxm);

		/* 
		// 반품 마스터 정보
		TB_RTODINFOXM tb_rtodinfoxm = new TB_RTODINFOXM();
		tb_rtodinfoxm = (TB_RTODINFOXM)orderEditMgrService.getRtnMasterObject(tb_odinfoxm);
		if(tb_rtodinfoxm != null) {
			tb_rtodinfoxm.setList(returnOrderMgrService.getDetailsList(tb_rtodinfoxm));
		}
		model.addAttribute("tb_rtodinfoxm", tb_rtodinfoxm);
		*/
		
		//배송지 정보
		TB_ODDLAIXM tb_oddlaixm = new TB_ODDLAIXM();
		tb_oddlaixm = (TB_ODDLAIXM)orderMgrService.getDeliveryInfo(tb_odinfoxm);
		
		// 업체 정보 불러오기
		List<HashMap<String, String>> pd_supr_list = (List<HashMap<String, String>>) orderMgrService.getPdSuprList(tb_odinfoxm); 
		//pd_supr_list = (TB_SPINFOXM)orderMgrService.getPdSuprList(tb_odinfoxm);
		model.addAttribute("pd_supr_list", pd_supr_list);
		
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		model.addAttribute("tb_oddlaixm", tb_oddlaixm);
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderCmptMgr/form");
	}
	// 기존 화면 백업 20200602
/*	@RequestMapping(value={ "/form/{ORDER_NUM}" }, method=RequestMethod.GET)
	public ModelAndView edit(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model) throws Exception {
		
		//주문정보 마스터 정보
		tb_odinfoxm = (TB_ODINFOXM)orderMgrService.getMasterInfo(tb_odinfoxm);
		//주문정보 상세  
		tb_odinfoxm.setList(orderMgrService.getDetailsList(tb_odinfoxm));
		//배송지 정보
		TB_ODDLAIXM tb_oddlaixm = new TB_ODDLAIXM();
		tb_oddlaixm = (TB_ODDLAIXM)orderMgrService.getDeliveryInfo(tb_odinfoxm);
		
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		model.addAttribute("tb_oddlaixm", tb_oddlaixm);
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderCmptMgr/form");
	}
*/	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderCmptMgrController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 배송정보 수정
	 * @Company	: YT Corp.
	 * @Author	: chjw
	 * @Date	: 2020-10-21 (오후 6:08:29)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView update(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODINFOXD tb_odinfoxd, 
			HttpServletRequest request, BindingResult result, SessionStatus status, Model model) throws Exception {		
		// 로그인 유저 정보
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setMODP_ID(loginUser.getMEMB_ID());
		
		//배송정보 수정
		orderEditMgrService.updateTrackNum(tb_odinfoxd);		
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderCmptMgr/form/"+tb_odinfoxm.getORDER_NUM());
		return new ModelAndView(redirectView);
	}
	
	
	@RequestMapping(value={ "/excelDown" }, method=RequestMethod.GET)
	public void getExcelList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model,HttpServletResponse response,HttpServletRequest request
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {

		tb_odinfoxm.setORDER_CON("ORDER_CON_08");

		String[] headerName = {"주문일시", "주문번호", "회원아이디","주문자명(수령자명)", "주문상품", "총 주문금액", "주문상태(결제수단)"};
		String[] columnName = {"ORDER_DATE", "ORDER_NUM", "MEMB_ID","MEMB_NM", "PD_NAME", "ORDER_AMT","ORDER_CON_NM"};
		String sheetName = "구매완료내역";
		
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
	
	@RequestMapping(value={ "/deleteOrdList" }, method=RequestMethod.POST)
	public ModelAndView deleteOrdList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model,HttpServletResponse response
			,HttpServletRequest request) throws Exception {
		
		String str1 = request.getParameter("ORD_DELETE_LIST");
        String[] words = str1.split(",");
         
        for (String wo : words ){
    		orderMgrService.deleteOrdList(wo);
    		orderMgrService.deleteOrdDetail(wo);
        }			
        
        RedirectView rv = new RedirectView(servletContextPath.concat("/adm/orderCmptMgr"));
		return new ModelAndView(rv);	
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderCmptMgrController.java
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
		
		orderMgrService.updateDatailQty(tb_odinfoxd);
		orderMgrService.updateMasterQty(tb_odinfoxm);		
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderCmptMgr/form/"+tb_odinfoxm.getORDER_NUM());		
		return new ModelAndView(redirectView);
	}
	
	@RequestMapping(value={ "/detailExcelDown" }, method=RequestMethod.GET)
	public void getDetailExcelList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model,HttpServletResponse response
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {

		
		String[] headerName = {"주문번호","주문일자", "사업자상호","회원아이디","주문자","배송비결재여부","바코드","상품명","세절방식","색상","과면세구분","수량","정상가","할인금액","단가","가격"};
		String[] columnName = {"ORDER_NUM","ORDER_DATE", "COM_NAME","MEMB_ID","MEMB_NM","DAP_YN","PD_BARCD","PD_NAME","PD_CUT_SEQ","OPTION_NAME","TAX_GUBN","ORDER_QTY","PD_PRICE"
											,"PDDC_VAL","ORDER_PREICE","ORDER_AMT"};

		String sheetName = "구매완료내역상세";
		
		tb_odinfoxm.setList(arrayParams);

		List<HashMap<String, String>> list = (List<HashMap<String, String>>) orderMgrService.getDetailExcelList(tb_odinfoxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}
	
	@RequestMapping(value={ "/excelAllDown" }, method=RequestMethod.GET)
	public void getExcelAllList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model
			,HttpServletResponse response,HttpServletRequest request) throws Exception {

		tb_odinfoxm.setORDER_CON("ORDER_CON_08");

		String[] headerName = {"주문일시", "주문번호", "회원아이디","주문자명(수령자명)", "주문상품", "총 주문금액", "주문상태(결제수단)"};
		String[] columnName = {"ORDER_DATE", "ORDER_NUM", "MEMB_ID","MEMB_NM", "PD_NAME", "ORDER_AMT","ORDER_CON_NM"};
		String sheetName = "구매완료내역(전체)";
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) orderMgrService.getExcelAllList(tb_odinfoxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}
	
}
