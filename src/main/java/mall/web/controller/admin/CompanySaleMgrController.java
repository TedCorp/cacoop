package mall.web.controller.admin;

import java.util.Arrays;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import mall.common.util.ExcelDownload;
import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_TOTINFOXM;
import mall.web.domain.XTB_ODINFOXM;
import mall.web.service.admin.impl.CompanySaleMgrService;

@Controller
@RequestMapping(value="/adm/companySaleMgr")
public class CompanySaleMgrController extends DefaultController{
	

	private static final Logger logger = LoggerFactory.getLogger(CompanySaleMgrController.class);
	
	@Resource(name="companySaleMgrService")
	CompanySaleMgrService companySaleMgrService;
	
	
	//공급사별 매출 집계 리스트 2021.01.03 장보라
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_TOTINFOXM tb_totinfoxm, HttpServletRequest request, Model model) throws Exception{
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_totinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			tb_totinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_totinfoxm.setRowCnt(10);
			tb_totinfoxm.setPagerMaxPageItems(10);
		}
		
		
		tb_totinfoxm.setCount(companySaleMgrService.getObjectCount(tb_totinfoxm));
		tb_totinfoxm.setList(companySaleMgrService.getPaginatedObjectList(tb_totinfoxm));
		
		model.addAttribute("obj", tb_totinfoxm);
		model.addAttribute("rowCnt", tb_totinfoxm.getRowCnt());
		model.addAttribute("totalCnt", tb_totinfoxm.getCount());

		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(tb_totinfoxm.getSchGbn())
				+ "&schTxt="+StringUtil.nullCheck(tb_totinfoxm.getSchTxt())
				+ "&pagerMaxPageItems="+StringUtil.nullCheck(tb_totinfoxm.getPagerMaxPageItems())
				+ "&datepickerStr=" + StringUtil.nullCheck(tb_totinfoxm.getDatepickerStr())
				+ "&datepickerEnd=" + StringUtil.nullCheck(tb_totinfoxm.getDatepickerEnd());
		model.addAttribute("link", strLink);
		return new ModelAndView("admin.layout", "jsp", "admin/companySaleMgr/list");
	}
	
	
	
	
	//공급사별 매출 집계 디테일 2021.02.21 장보라
	@RequestMapping(value= {"/{SUPR_ID}", "{SUPR_ID}/search"}, method=RequestMethod.GET)
	public ModelAndView getDetail(@ModelAttribute TB_ODINFOXD tb_odinfoxd, @PathVariable("SUPR_ID") String SUPR_ID, HttpServletRequest request, Model model) throws Exception{
	
		tb_odinfoxd.setSUPR_ID(SUPR_ID);
		
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_odinfoxd.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			tb_odinfoxd.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_odinfoxd.setRowCnt(10);
			tb_odinfoxd.setPagerMaxPageItems(10);
		}
		
		tb_odinfoxd.setCount(companySaleMgrService.getObjectCountDetail(tb_odinfoxd));
		tb_odinfoxd.setList(companySaleMgrService.getPaginatedObjectListDetail(tb_odinfoxd));
		
		model.addAttribute("SUPR_ID", SUPR_ID);
		model.addAttribute("obj", tb_odinfoxd);
		model.addAttribute("rowCnt", tb_odinfoxd.getRowCnt());
		model.addAttribute("totalCnt", tb_odinfoxd.getCount());
		
		
		String strLink = null;
		strLink = "&pagerMaxPageItems="+StringUtil.nullCheck(tb_odinfoxd.getPagerMaxPageItems())
				+ "&datepickerStr=" + StringUtil.nullCheck(tb_odinfoxd.getDatepickerStr())
				+ "&datepickerEnd=" + StringUtil.nullCheck(tb_odinfoxd.getDatepickerEnd());
	
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/companySaleMgr/form");
	}
	
	
	
	//공급사별 엑셀출력
	@RequestMapping(value={ "/excelDown" }, method=RequestMethod.GET)
	public void excelDown(@ModelAttribute TB_TOTINFOXM tb_totinfoxm, Model model,HttpServletResponse response
						,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {

		String[] headerName = {"공급사 상호", "사업자 번호", "대표자", "주문금액", "반품금액", "총매출금액"};
		String[] columnName = {"SUPR_NAME", "BIZR_NUM", "RPRS_NAME", "ORDER_AMT", "RFND_AMT", "REAL_AMT"};
		
		String sheetName = "공급사별 매출현황";
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) companySaleMgrService.getExcelList(tb_totinfoxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);		
	}
	
	
	
	//공급사별 디테일 엑셀출력
	@RequestMapping(value={ "/excelDownDetail" }, method=RequestMethod.GET)
	public void excelDownDetail(@ModelAttribute TB_ODINFOXD tb_odinfoxd, Model model, HttpServletResponse response
								,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {
		
	
		String[] headerName = {"주문번호", "상품이름",  "주문금액", "반품금액", "총매출금액"};
		String[] columnName = {"ORDER_NUM", "PD_NAME", "ORDER_AMT", "RFND_AMT", "REAL_AMT"};
		
		String sheetName = "공급사상세매출내역";
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) companySaleMgrService.excelDownDetail(tb_odinfoxd);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);		
	}
}
