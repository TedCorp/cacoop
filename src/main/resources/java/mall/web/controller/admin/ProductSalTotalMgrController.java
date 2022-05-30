package mall.web.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mall.common.util.ExcelDownload;
import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_PDTOTXM;
import mall.web.service.admin.impl.ProductSalTotalMgrService;

@Controller
@RequestMapping(value="/adm")
public class ProductSalTotalMgrController  extends DefaultController{
	private static final Logger logger = LoggerFactory.getLogger(ProductSalTotalMgrController.class);

	@Resource(name="productSalTotalMgrService")
	ProductSalTotalMgrService productSalTotalMgrService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductSalTotalMgrController.java
	 * @Method	: getPrdSalTot
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품 매출관리
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 2020-08-06 (오후 5:00:00)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/productSalTotalMgr" }, method=RequestMethod.GET)
	public ModelAndView getPrdSalTot(@ModelAttribute TB_PDTOTXM tb_totalxm, Model model, HttpServletRequest request) throws Exception {
		//Default date
		String dateStr = request.getParameter("datepickerStr");
		String dateEnd = request.getParameter("datepickerEnd");		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		
		if (dateStr == null){
			Calendar cal = Calendar.getInstance ( );
			cal.add(Calendar.DATE, -7);
			Date weekago = cal.getTime();
			
			dateStr = dateformat.format(weekago).toString();
			tb_totalxm.setDatepickerStr(dateStr);
		}
		if(dateEnd == null){
			Date today = new Date ();
			
			dateEnd = dateformat.format(today).toString();
			tb_totalxm.setDatepickerEnd(dateEnd);
		}
		
		// 페이징
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_totalxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			tb_totalxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			// 기본 페이징 단위 : 20
			tb_totalxm.setRowCnt(20);
			tb_totalxm.setPagerMaxPageItems(20);
		}
		
		//if (tb_totalxm.getSchTxt() != null) {
			tb_totalxm.setCount(productSalTotalMgrService.getTotalCount(tb_totalxm));
			tb_totalxm.setList(productSalTotalMgrService.getPaginatedObjectList(tb_totalxm));
		//}

		model.addAttribute("obj", tb_totalxm);								//리스트
		model.addAttribute("totalCnt", tb_totalxm.getCount());		//전체 카운트
		model.addAttribute("rowCnt", tb_totalxm.getRowCnt());		//페이지 목록수
		
		//링크설정
		String strLink = null;
		strLink =	"&schGbn="+StringUtil.nullCheck(tb_totalxm.getSchGbn())+											//검색구분
				  		"&schTxt="+StringUtil.nullCheck(tb_totalxm.getSchTxt())+											//검색어
				  		"&datepickerStr="+StringUtil.nullCheck(request.getParameter("datepickerStr")) + 			//시작일
				  		"&datepickerEnd="+StringUtil.nullCheck(request.getParameter("datepickerEnd")) + 			//종료일
				  		"&pagerMaxPageItems="+StringUtil.nullCheck(tb_totalxm.getPagerMaxPageItems())+		//페이지순번				  		
				  		"&sortGubun="+StringUtil.nullCheck(tb_totalxm.getSortGubun())+									//정렬구분
				  		"&sortOdr="+StringUtil.nullCheck(tb_totalxm.getSortOdr());											//정렬기준 
		
		model.addAttribute("link", strLink);
				
		return new ModelAndView("admin.layout", "jsp", "admin/productSalTotalMgr/total");
	}

	@RequestMapping(value="/productSalTotalMgr/excel")
	public void getPrdSalTotExcel(@ModelAttribute TB_PDTOTXM tb_totalxm, Model model, HttpServletResponse response) throws Exception {
		String sheetName = "상품매출집계";
		
		String[] headerName = {
			"상품코드", "상품바코드", "상품명", "과세구분", 
			"제품단가", "판매단가", "판매수량", "소계"
		};
	
		String[] columnName = {
			"PD_CODE", "PD_BARCD", "PD_NAME", "TAX_GUBN",
			"PD_PRICE", "REAL_PRICE", "ORDER_QTY", "SUM_PRICE"
		};
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) productSalTotalMgrService.getTotalList(tb_totalxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductSalTotalMgrController.java
	 * @Method	: getPrdSalDate
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 2020-08-11 (오후 5:00:00)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/productSalDateMgr" }, method=RequestMethod.GET)
	public ModelAndView getPrdSalDate(@ModelAttribute TB_PDTOTXM tb_totalxm, Model model, HttpServletRequest request) throws Exception {
		//Default date
		String dateStr = request.getParameter("datepickerStr");
		String dateEnd = request.getParameter("datepickerEnd");		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		
		if (dateStr == null){
			Calendar cal = Calendar.getInstance ( );
			cal.add(Calendar.DATE, -7);
			Date weekago = cal.getTime();
			
			dateStr = dateformat.format(weekago).toString();
			tb_totalxm.setDatepickerStr(dateStr);
		}
		if(dateEnd == null){
			Date today = new Date ();
			
			dateEnd = dateformat.format(today).toString();
			tb_totalxm.setDatepickerEnd(dateEnd);
		}
		
		// 페이징
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_totalxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			tb_totalxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			// 기본 페이징 단위 : 20
			tb_totalxm.setRowCnt(20);
			tb_totalxm.setPagerMaxPageItems(20);
		}
		
		//if (tb_totalxm.getSchTxt() != null) {
			tb_totalxm.setCount(productSalTotalMgrService.getDateCount(tb_totalxm));
			tb_totalxm.setList(productSalTotalMgrService.getPaginatedDateList(tb_totalxm));
		//}

		model.addAttribute("obj", tb_totalxm);								//리스트
		model.addAttribute("totalCnt", tb_totalxm.getCount());		//전체 카운트
		model.addAttribute("rowCnt", tb_totalxm.getRowCnt());		//페이지 목록수
		
		//링크설정
		String strLink = null;
		strLink =	"&schGbn="+StringUtil.nullCheck(tb_totalxm.getSchGbn())+										//검색구분
				  		"&schTxt="+StringUtil.nullCheck(tb_totalxm.getSchTxt())+										//검색어
				  		"&datepickerStr="+StringUtil.nullCheck(request.getParameter("datepickerStr")) + 		//시작일
				  		"&datepickerEnd="+StringUtil.nullCheck(request.getParameter("datepickerEnd")) + 		//종료일
				  		"&pagerMaxPageItems="+StringUtil.nullCheck(tb_totalxm.getPagerMaxPageItems())+	//페이지순번				  		
				  		"&sortGubun="+StringUtil.nullCheck(tb_totalxm.getSortGubun())+								//정렬구분
				  		"&sortOdr="+StringUtil.nullCheck(tb_totalxm.getSortOdr());										//정렬기준 
		
		model.addAttribute("link", strLink);
				
		return new ModelAndView("admin.layout", "jsp", "admin/productSalTotalMgr/date");
	}	

	@RequestMapping(value="/productSalDateMgr/excel")
	public void getPrdSalDateExcel(@ModelAttribute TB_PDTOTXM tb_totalxm, Model model, HttpServletResponse response) throws Exception {
		String sheetName = "상품-일자별 매출집계";
		
		String[] headerName = {
			"결제일자", "상품코드", "상품바코드", "상품명", "과세구분", 
			"제품단가","판매단가","판매수량","소계"
		};
	
		String[] columnName = {
			"PAY_DTM", "PD_CODE", "PD_BARCD", "PD_NAME", "TAX_GUBN",
			"PD_PRICE", "REAL_PRICE", "ORDER_QTY", "SUM_PRICE"
		};
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) productSalTotalMgrService.getDateList(tb_totalxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductSalTotalMgrController.java
	 * @Method	: getPrdSalPeriod
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 2020-08-11 (오후 5:00:00)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/productSalPeriodMgr" }, method=RequestMethod.GET)
	public ModelAndView getPrdSalPeriod(@ModelAttribute TB_PDTOTXM tb_totalxm, Model model, HttpServletRequest request) throws Exception {
		//Default date
		String dateStr = request.getParameter("datepickerStr");
		String dateEnd = request.getParameter("datepickerEnd");		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		
		if (dateStr == null){
			Calendar cal = Calendar.getInstance ( );
			cal.add(Calendar.DATE, -7);
			Date weekago = cal.getTime();
			
			dateStr = dateformat.format(weekago).toString();
			tb_totalxm.setDatepickerStr(dateStr);
		}
		if(dateEnd == null){
			Date today = new Date ();
			
			dateEnd = dateformat.format(today).toString();
			tb_totalxm.setDatepickerEnd(dateEnd);
		}
		
		// 페이징
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_totalxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			tb_totalxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			// 기본 페이징 단위 : 20
			tb_totalxm.setRowCnt(20);
			tb_totalxm.setPagerMaxPageItems(20);
		}
		
		//if (tb_totalxm.getSchTxt() != null) {
			tb_totalxm.setCount(productSalTotalMgrService.getPeriodCount(tb_totalxm));
			tb_totalxm.setList(productSalTotalMgrService.getPaginatedPeriodList(tb_totalxm));
		//}

		model.addAttribute("obj", tb_totalxm);								//리스트
		model.addAttribute("totalCnt", tb_totalxm.getCount());		//전체 카운트
		model.addAttribute("rowCnt", tb_totalxm.getRowCnt());		//페이지 목록수
		
		//링크설정
		String strLink = null;
		strLink =	"&schGbn="+StringUtil.nullCheck(tb_totalxm.getSchGbn())+										//검색구분
				  		"&schTxt="+StringUtil.nullCheck(tb_totalxm.getSchTxt())+										//검색어
				  		"&datepickerStr="+StringUtil.nullCheck(request.getParameter("datepickerStr")) + 		//시작일
				  		"&datepickerEnd="+StringUtil.nullCheck(request.getParameter("datepickerEnd")) + 		//종료일
				  		"&pagerMaxPageItems="+StringUtil.nullCheck(tb_totalxm.getPagerMaxPageItems())+	//페이지순번				  		
				  		"&sortGubun="+StringUtil.nullCheck(tb_totalxm.getSortGubun())+								//정렬구분
				  		"&sortOdr="+StringUtil.nullCheck(tb_totalxm.getSortOdr());										//정렬기준 
		
		model.addAttribute("link", strLink);
				
		return new ModelAndView("admin.layout", "jsp", "admin/productSalTotalMgr/period");
	}

	@RequestMapping(value="/productSalPeriodMgr/excel")
	public void getPrdSalPeriodExcel(@ModelAttribute TB_PDTOTXM tb_totalxm, Model model, HttpServletResponse response) throws Exception {
		String sheetName = "상품-기간별 매출집계";
		
		String[] headerName = {
			"결제일자", "상품코드", "상품바코드", "상품명", "과세구분",
			"제품단가", "판매단가", "판매수량", "소계"
		};
	
		String[] columnName = {
			"PAY_DTM", "PD_CODE", "PD_BARCD", "PD_NAME", "TAX_GUBN",
			"PD_PRICE", "REAL_PRICE", "ORDER_QTY", "SUM_PRICE"
		};
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) productSalTotalMgrService.getPeriodList(tb_totalxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}
	
		
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductSalTotalMgrController.java
	 * @Method	: getPrdSalMember
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 2020-08-11 (오후 5:00:00)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/productSalMemberMgr" }, method=RequestMethod.GET)
	public ModelAndView getPrdSalMember(@ModelAttribute TB_PDTOTXM tb_totalxm, Model model, HttpServletRequest request) throws Exception {
		//Default date
		String dateStr = request.getParameter("datepickerStr");
		String dateEnd = request.getParameter("datepickerEnd");		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		
		if (dateStr == null){
			Calendar cal = Calendar.getInstance ( );
			cal.add(Calendar.DATE, -7);
			Date weekago = cal.getTime();
			
			dateStr = dateformat.format(weekago).toString();
			tb_totalxm.setDatepickerStr(dateStr);
		}
		if(dateEnd == null){
			Date today = new Date ();
			
			dateEnd = dateformat.format(today).toString();
			tb_totalxm.setDatepickerEnd(dateEnd);
		}
		
		// 페이징
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_totalxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));						//페이징 단위 : 입력값
			tb_totalxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			// 기본 페이징 단위 : 20
			tb_totalxm.setRowCnt(20);
			tb_totalxm.setPagerMaxPageItems(20);
		}
		
		//if (tb_totalxm.getSchTxt() != null) {
			tb_totalxm.setCount(productSalTotalMgrService.getMemberCount(tb_totalxm));
			tb_totalxm.setList(productSalTotalMgrService.getPaginatedMemberList(tb_totalxm));
		//}

		model.addAttribute("obj", tb_totalxm);								//리스트
		model.addAttribute("totalCnt", tb_totalxm.getCount());		//전체 카운트
		model.addAttribute("rowCnt", tb_totalxm.getRowCnt());		//페이지 목록수
		
		//링크설정
		String strLink = null;
		strLink =	"&schGbn="+StringUtil.nullCheck(tb_totalxm.getSchGbn())+										//검색구분
				  		"&schTxt="+StringUtil.nullCheck(tb_totalxm.getSchTxt())+										//검색어
				  		"&datepickerStr="+StringUtil.nullCheck(request.getParameter("datepickerStr")) + 		//시작일
				  		"&datepickerEnd="+StringUtil.nullCheck(request.getParameter("datepickerEnd")) + 		//종료일
				  		"&pagerMaxPageItems="+StringUtil.nullCheck(tb_totalxm.getPagerMaxPageItems())+	//페이지순번				  		
				  		"&sortGubun="+StringUtil.nullCheck(tb_totalxm.getSortGubun())+								//정렬구분
				  		"&sortOdr="+StringUtil.nullCheck(tb_totalxm.getSortOdr());										//정렬기준 
		
		model.addAttribute("link", strLink);
				
		return new ModelAndView("admin.layout", "jsp", "admin/productSalTotalMgr/member");
	}

	@RequestMapping(value="/productSalMemberMgr/excel")
	public void getPrdSalMemberExcel(@ModelAttribute TB_PDTOTXM tb_totalxm, Model model, HttpServletResponse response) throws Exception {
		String sheetName = "상품-회원별 매출집계";
		
		String[] headerName = {
			"회원ID", "회원명", "상호",   
			"상품코드", "상품바코드", "상품명", "과세구분",
			"제품단가","판매단가","판매수량", "소계"
		};
	
		String[] columnName = {
			"MEMB_ID", "MEMB_NAME", "COM_NAME",
			"PD_CODE", "PD_BARCD", "PD_NAME", "TAX_GUBN",
			"PD_PRICE", "REAL_PRICE", "ORDER_QTY", "SUM_PRICE"
		};
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) productSalTotalMgrService.getMemberList(tb_totalxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}
	
		
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductEventMgrController.java
	 * @Method	: pdpop
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품 선택 팝업 (ajax)
	 * @Company	: YT Corp.
	 * @Author	: Ji-won Chang (Chjw@youngthink.co.kr)
	 * @Date	: 2020-08-10 (오후 12:18:15)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param productInfo
	 * @param result
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/productSalTotalMgr/pdpop"}, method=RequestMethod.GET)
	public @ResponseBody TB_PDTOTXM pdpop(@ModelAttribute TB_PDTOTXM productInfo, Model model, HttpServletRequest request) throws Exception {	
		//결과내 재검색 X
		List schTxt_befList = Arrays.asList(productInfo.getSchTxt());
		productInfo.setSchTxt_befList(schTxt_befList);			// 기본 검색어 만 List
		productInfo.setSchTxt_bef(productInfo.getSchTxt());	// 기본 검색어를 이전 검색어 hidden 데이터로 반영
	
		productInfo.setCount(productSalTotalMgrService.getObjectCount(productInfo));
		productInfo.setList(productSalTotalMgrService.getObjectList(productInfo));	//전체조회
		
		return productInfo;
	}	
}
