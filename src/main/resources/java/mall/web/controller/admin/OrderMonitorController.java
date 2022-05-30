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
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.XTB_ODINFOXM;
import mall.web.service.admin.impl.OrderBakMgrService;
import mall.web.service.admin.impl.OrderMgrService;
import mall.web.service.common.CommonService;

@Controller
@RequestMapping(value="/adm/orderMonitor")
public class OrderMonitorController extends DefaultController{

	@Resource(name="orderMgrService")
	OrderMgrService orderMgrService;

	@Resource(name="orderBakMgrService")
	OrderBakMgrService orderBakMgrService;
	
	@Resource(name="commonService")
	CommonService commonService;

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderBakMgrController.java
	 * @Method	: getMonitor
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문모니터링
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return 
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	//@RequestMapping(value={ "/monitor" }, method=RequestMethod.GET)
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getMonitor(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model,HttpServletResponse response,HttpServletRequest request) throws Exception {

		// 페이징 단위
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_odinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));	
			tb_odinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {	
			//기본 페이징 : 20
			tb_odinfoxm.setRowCnt(20);	
			tb_odinfoxm.setPagerMaxPageItems(20);
		}
		
		// 주문삭제내역 Select
		tb_odinfoxm.setCount(orderBakMgrService.getObjectCount(tb_odinfoxm));
		tb_odinfoxm.setList(orderBakMgrService.getObjectList(tb_odinfoxm));
		
		model.addAttribute("obj", tb_odinfoxm);
		model.addAttribute("rowCnt", tb_odinfoxm.getRowCnt());
		model.addAttribute("totalCnt", tb_odinfoxm.getCount());
		
		String strLink = null;
		/*
		 * strLink = "&schGbn="+StringUtil.nullCheck(tb_odinfoxm.getSchGbn()) +
		 * "&schTxt="+StringUtil.nullCheck(tb_odinfoxm.getSchTxt() +
		 * "&PAY_METD="+StringUtil.nullCheck(tb_odinfoxm.getPAY_METD()) +
		 * "&pagerMaxPageItems="+StringUtil.nullCheck(tb_odinfoxm.getPagerMaxPageItems()
		 * ) + "&datepickerStr=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerStr())
		 * + "&datepickerEnd=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerEnd()));
		 */
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
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderMonitor/monitor");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문내역 조회
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 2020-03-12
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/list" }, method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model,HttpServletRequest request) throws Exception {
		
		tb_odinfoxm.setORDER_CON("ORDER_CON_04");
		
		if(tb_odinfoxm.getORDER_CON_STATE()!="" && tb_odinfoxm.getORDER_CON_STATE()!=null){
			// 등록자 정보 변경필요
			tb_odinfoxm.setMODP_ID("admin");
			orderMgrService.updateStateObject(tb_odinfoxm);
		}
		
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_odinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));	//페이징 단위 : 50
			tb_odinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_odinfoxm.setRowCnt(20);	//페이징 단위 : 20
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
				+ "&PAY_METD="+StringUtil.nullCheck(tb_odinfoxm.getPAY_METD())
				+ "&pagerMaxPageItems="+StringUtil.nullCheck(tb_odinfoxm.getPagerMaxPageItems())
				+ "&datepickerStr=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerStr())
				+ "&datepickerEnd=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerEnd()));
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderMonitor/list");
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
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderDltMgr/form");
	}
	
	@RequestMapping(value={ "/deleteReturnOrdList" }, method=RequestMethod.POST)
	public ModelAndView deleteOrdList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model
			,HttpServletResponse response, HttpServletRequest request) throws Exception {
		
		// 등록자 정보 변경필요
		tb_odinfoxm.setMODP_ID("admin");
		
		String str1 = request.getParameter("ORD_DELETE_LIST");
		if(str1.contains(",")){
			String[] words = str1.split(",");
			for (String wo : words ){
	    		orderMgrService.getDeleteReturnOrdList(wo);
	    		orderMgrService.getDeleteReturnOrdDtlList(wo);
	        }
		}else{
			orderMgrService.getDeleteReturnOrdList(str1);
    		orderMgrService.getDeleteReturnOrdDtlList(str1);
		}
        
        RedirectView rv = new RedirectView(servletContextPath.concat("/adm/orderDltMgr"));
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
		
		orderMgrService.updateDatailQty(tb_odinfoxd);
		orderMgrService.updateMasterQty(tb_odinfoxm);		
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderDltMgr/form/"+tb_odinfoxm.getORDER_NUM());		
		return new ModelAndView(redirectView);
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
	public ModelAndView update(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODDLAIXM tb_oddlaixm
			, BindingResult result, SessionStatus status, Model model) throws Exception {
		// 등록자 정보 변경필요
		tb_odinfoxm.setMODP_ID("admin");
		tb_oddlaixm.setMODP_ID("admin");
		
		// 주문상태 및 결제 정보 수정
		orderMgrService.getDetailsUpdate(tb_odinfoxm,tb_oddlaixm);
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderDltMgr/form/"+tb_odinfoxm.getORDER_NUM());		
		return new ModelAndView(redirectView);
	}
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderDtlMgrController.java
	 * @Method	: getExcelList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문내역 상세 및 주문상태/결제정보 저장
	 * @Company	: YT Corp.
	 * @Author	: Hee-Sun Lee (hslee@youngthink.co.kr)
	 * @Date	: 2016-07-15 (오후 6:08:29)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	/*
	 * @RequestMapping(value={ "/excelDown" }, method=RequestMethod.GET) public void
	 * getExcelList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model
	 * model,HttpServletResponse response,HttpServletRequest request
	 * ,@RequestParam(value="checkArray[]", defaultValue="") List<String>
	 * arrayParams) throws Exception {
	 * 
	 * tb_odinfoxm.setORDER_CON("ORDER_CON_04");
	 * 
	 * String[] headerName = {"주문일자","결제시간",
	 * "주문번호","주문자명","사업자상호","주문상품","총 결제금액","배송료","상품주문금액","주문상태 결제수단"
	 * ,"출고방식","고객배송 요청사항","배송참조사항(관리자기록)"}; String[] columnName =
	 * {"ORDER_DATE","PAY_DTM","ORDER_NUM","MEMB_NM","COM_NAME","PD_NAME",
	 * "ORDER_AMT","DLVY_AMT","REAL_AMT","ORDER_CON_NM","DLAR_GUBN","DLVY_MSG",
	 * "ADM_REF"};
	 * 
	 * String sheetName = "주문취소내역";
	 * 
	 * String[] chkArray = request.getParameter("CHK_ORD_LIST").split(","); //
	 * String[] -> List List<String> stringList = Arrays.asList(chkArray);
	 * tb_odinfoxm.setList(stringList);
	 * 
	 * if(request.getParameter("pagerMaxPageItems")!=null){
	 * tb_odinfoxm.setRowCnt(Integer.parseInt(request.getParameter(
	 * "pagerMaxPageItems"))); //페이징 단위 : 50
	 * tb_odinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter(
	 * "pagerMaxPageItems"))); }else { tb_odinfoxm.setRowCnt(20); //페이징 단위 : 20
	 * tb_odinfoxm.setPagerMaxPageItems(20); }
	 * 
	 * //tb_odinfoxm.setList(arrayParams);
	 * 
	 * List<HashMap<String, String>> list = (List<HashMap<String, String>>)
	 * orderMgrService.getExcelList(tb_odinfoxm);
	 * 
	 * ExcelDownload.excelDownloadOrder(response, list, headerName, columnName,
	 * sheetName);
	 * 
	 * }
	 */
	
	// 주문내역 엑셀
	@RequestMapping(value={ "/excelDown" }, method=RequestMethod.GET)
	public void getExcelList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model,HttpServletRequest request,HttpServletResponse response
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {
		
		String[] headerName = {"공급업체", "주문일자", "결제시간", "주문번호", "주문번호상세", "주문자명", "사업사상호", "사업자번호", "상품코드", "상품명", "수량", "상품소계", "주문상태", "결제수단", "매출가", "매입가", "배송비"};
		String[] columnName = {"SUPR_ID","ORDER_DATE","ORDER_DATE","ORDER_NUM", "ORDER_DTNUM", "MEMB_NM","COM_NAME", "COM_BUNB", "PD_CODE", "PD_NAME", "ORDER_QTY", "ORDER_AMT","ORDER_CON_NM","PAY_METD_NM","REAL_PRICE","PD_IWHUPRC","DLVY_AMT"};

		String sheetName = "주문모니터링내역";
		
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

		List<HashMap<String, String>> list = (List<HashMap<String, String>>) orderBakMgrService.getMonitorExcelList(tb_odinfoxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);		
	}
	
	
	@RequestMapping(value={ "/detailExcelDown" }, method=RequestMethod.GET)
	public void getDetailExcelList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model,HttpServletResponse response
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {
		
		String[] headerName = {"주문번호","주문일자", "사업자상호","주문자","배송비결재여부","바코드","상품명","세절방식","색상","과면세구분","수량","정상가","할인금액","단가","가격"};
		String[] columnName = {"ORDER_NUM","ORDER_DATE", "COM_NAME","MEMB_NM","DAP_YN","PD_BARCD","PD_NAME","PD_CUT_SEQ","OPTION_NAME","TAX_GUBN","ORDER_QTY","PD_PRICE"
											,"PDDC_VAL","ORDER_PREICE","ORDER_AMT"};

		String sheetName = "주문취소내역상세";
		
		tb_odinfoxm.setList(arrayParams);

		List<HashMap<String, String>> list = (List<HashMap<String, String>>) orderMgrService.getDetailExcelList(tb_odinfoxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
		
	}
}
