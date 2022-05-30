package mall.web.controller.admin;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.util.ExcelDownload;
import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.Deliverys;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.XTB_ODINFOXM;
import mall.web.service.admin.impl.OrderBakMgrService;
import mall.web.service.admin.impl.OrderMgrService;
import mall.web.service.common.CommonService;

@Controller
@RequestMapping(value="/adm")
public class OrderBakMgrController extends DefaultController{

	@Resource(name="orderMgrService")
	OrderMgrService orderMgrService;
	
	@Resource(name="commonService")
	CommonService commonService;

	@Resource(name="orderBakMgrService")
	OrderBakMgrService orderBakMgrService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderBakMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문삭제내역 조회
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
	@RequestMapping(value={ "/orderBakMgr/restore" }, method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model,HttpServletRequest request) throws Exception {
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
		tb_odinfoxm.setList(orderBakMgrService.getPaginatedObjectList(tb_odinfoxm));
		
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
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderBakMgr/list");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderBakMgrController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 삭제주문내역 상세정보(form)
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
	@RequestMapping(value={ "/orderBakMgr/form/{ORDER_NUM}" }, method=RequestMethod.GET)
	public ModelAndView edit(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model) throws Exception {		
		//주문삭제 마스터 정보
		tb_odinfoxm = (TB_ODINFOXM)orderBakMgrService.getMasterInfo(tb_odinfoxm);
		//주문삭제 상세정보  
		tb_odinfoxm.setList(orderBakMgrService.getDetailsList(tb_odinfoxm));
		//배송지 정보
		TB_ODDLAIXM tb_oddlaixm = new TB_ODDLAIXM();
		tb_oddlaixm = (TB_ODDLAIXM)orderBakMgrService.getDeliveryInfo(tb_odinfoxm);
		
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		model.addAttribute("tb_oddlaixm", tb_oddlaixm);
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderBakMgr/form");
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderBakMgrController.java
	 * @Method	: deleteOrdList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문삭제내역 복원
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
	@RequestMapping(value={ "/orderBakMgr/deleteReturnOrdList" }, method=RequestMethod.POST)
	public ModelAndView deleteOrdList(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model, HttpServletResponse response, HttpServletRequest request) throws Exception {
		//
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");		
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		String str1 = request.getParameter("ORD_DELETE_LIST");
		
		if(str1.contains(",")){
			String[] words = str1.split(",");
			for (String wo : words ){
	    		orderBakMgrService.getDeleteReturnOrdList(wo);
	    		orderBakMgrService.getDeleteReturnOrdDtlList(wo);
	        }
		}else{
			orderBakMgrService.getDeleteReturnOrdList(str1);
    		orderBakMgrService.getDeleteReturnOrdDtlList(str1);
		}
         
        RedirectView rv = new RedirectView(servletContextPath.concat("/adm/orderBakMgr"));
		return new ModelAndView(rv);
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderBakMgrController.java
	 * @Method	: getExcelList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문삭제내역 엑셀
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
	@RequestMapping(value={ "/orderBakMgr/excelDown" }, method=RequestMethod.GET)
	public void getExcelList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model,HttpServletResponse response,HttpServletRequest request
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {

		tb_odinfoxm.setORDER_CON("ORDER_CON_04");

		String[] headerName = {"주문일자","결제시간", "주문번호","주문자명","사업자상호","주문상품","총 결제금액","배송료","상품주문금액","주문상태 결제수단","출고방식","고객배송 요청사항","배송참조사항(관리자기록)"};
		String[] columnName = {"ORDER_DATE","PAY_DTM","ORDER_NUM","MEMB_NM","COM_NAME","PD_NAME","ORDER_AMT","DLVY_AMT","REAL_AMT","ORDER_CON_NM","DLAR_GUBN","DLVY_MSG","ADM_REF"};

		String sheetName = "주문삭제내역";		
		String[] chkArray = request.getParameter("CHK_ORD_LIST").split(",");

        List<String> stringList = Arrays.asList(chkArray);
		tb_odinfoxm.setList(stringList);
		
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_odinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));	//페이징 단위 : 50
			tb_odinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_odinfoxm.setRowCnt(20);						//페이징 단위 : 20
			tb_odinfoxm.setPagerMaxPageItems(20);
		}
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) orderBakMgrService.getExcelList(tb_odinfoxm);		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);		
	}
	
	@RequestMapping(value={ "/orderBakMgr/detailExcelDown" }, method=RequestMethod.GET)
	public void getDetailExcelList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model,HttpServletResponse response
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {
		
		String[] headerName = {"주문번호","주문일자", "사업자상호","주문자","배송비결재여부","바코드","상품명","세절방식","색상","과면세구분","수량","정상가","할인금액","단가","가격"};
		String[] columnName = {"ORDER_NUM","ORDER_DATE", "COM_NAME","MEMB_NM","DAP_YN","PD_BARCD","PD_NAME","PD_CUT_SEQ","OPTION_NAME","TAX_GUBN","ORDER_QTY","PD_PRICE"
											,"PDDC_VAL","ORDER_PREICE","ORDER_AMT"};

		String sheetName = "주문삭제내역상세";
		
		tb_odinfoxm.setList(arrayParams);

		List<HashMap<String, String>> list = (List<HashMap<String, String>>) orderBakMgrService.getDetailExcelList(tb_odinfoxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderBakMgrController.java
	 * @Method	: getDelivery
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 배송전표
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
	@RequestMapping(value={ "/delivery" }, method=RequestMethod.POST)
	public ModelAndView getDelivery(@ModelAttribute Deliverys delivery, Model model,HttpServletRequest request,
			@RequestParam(value="checkArray", defaultValue="") List<String> arrayParams) throws Exception {
		
		// 배송전표 정보
		List<Deliverys> ordInfo = new ArrayList<>();
		
		if(arrayParams != null){
			for(String obj : arrayParams){
				Deliverys list = new Deliverys();
				list.setSUPR_ID(delivery.getSUPR_ID());
				list.setORDER_NUM(obj);
				
				list = (Deliverys)orderBakMgrService.getSupplierObject(list);			
				list.setList(orderBakMgrService.getDeliverList(obj));
				
				ordInfo.add(list);
			}
			delivery.setList(ordInfo);
		}
		
		model.addAttribute("delivery", delivery);
		
		return new ModelAndView("blankPage", "jsp", "admin/orderMgr/print");
	}
	
}
