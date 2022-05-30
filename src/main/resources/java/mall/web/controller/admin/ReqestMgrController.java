package mall.web.controller.admin;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
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
import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.XTB_ODDLAIXM;
import mall.web.domain.XTB_ODINFOXD;
import mall.web.domain.XTB_ODINFOXM;
import mall.web.service.admin.impl.RequestMgrService;
import mall.web.service.common.CommonService;

@Controller
@RequestMapping(value="/adm/requestMgr")
public class ReqestMgrController extends DefaultController{


	@Resource(name="requestMgrService")
	RequestMgrService requestMgrService;
	
	@Resource(name="commonService")
	CommonService commonService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.requestMgrController.java
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
	public ModelAndView getList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model) throws Exception {

		tb_odinfoxm.setRowCnt(30);
		tb_odinfoxm.setCount(requestMgrService.getObjectCount(tb_odinfoxm));
		tb_odinfoxm.setList(requestMgrService.getPaginatedObjectList(tb_odinfoxm));
		model.addAttribute("obj", tb_odinfoxm);

		//페이징 정보
		model.addAttribute("rowCnt", tb_odinfoxm.getRowCnt());		//페이지 목록수
		model.addAttribute("totalCnt", tb_odinfoxm.getCount());		//전체 카운트
		
		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(tb_odinfoxm.getSchGbn())+
				"&schTxt="+StringUtil.nullCheck(tb_odinfoxm.getSchTxt())+
				"&ORDER_CON="+StringUtil.nullCheck(tb_odinfoxm.getORDER_CON())+
				"&ORDER_GUBUN="+StringUtil.nullCheck(tb_odinfoxm.getORDER_GUBUN())+
				"&DATE_ORDER="+StringUtil.nullCheck(tb_odinfoxm.getDATE_ORDER())+
				"&COM_NAME_ORDER="+StringUtil.nullCheck(tb_odinfoxm.getCOM_NAME_ORDER())+
				"&STAFF_NAME_ORDER="+StringUtil.nullCheck(tb_odinfoxm.getSTAFF_NAME_ORDER())+
				"&datepickerStr="+StringUtil.nullCheck(tb_odinfoxm.getDatepickerStr())+
				"&datepickerEnd="+StringUtil.nullCheck(tb_odinfoxm.getDatepickerEnd());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/requestMgr/list");
	}
	

	@RequestMapping(value={ "/excelDown" }, method=RequestMethod.GET)
	public void getExcelList(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model, HttpServletResponse response) throws Exception {


		String[] headerName = {"주문번호", "업체명", "사업자등록번호", "담당자명", "담당자 연락처", "담당자 EMAIL", "배송요청일", "주문메모", "결제방법", "주문상태", "총 주문금액"
				              , "상품명", "과세면세구분",  "판매가", "주문수량", "상품구매금액", "배송지구분", "담당자", "담당자 연락처", "배송주소"};
		String[] columnName = {"ORDER_NUM", "COM_NAME", "BIZR_NUM", "STAFF_NAME", "STAFF_CPON", "STAFF_MAIL", "ARRIVAL_DATE", "ORDER_MSG", "PAY_METD_NM", "ORDER_CON_NM", "ORDER_AMT"
	                          , "PD_NAME", "TAX_GUBN_NM", "REAL_PRICE", "ORDER_QTY", "D_ORDER_AMT", "DLVY_NAME", "D_STAFF_NAME", "D_STAFF_CPON", "DLVY_ADDR"};
		String sheetName = "주문내역";

		List<HashMap<String, String>> list = (List<HashMap<String, String>>) requestMgrService.getExcelList(tb_odinfoxm);
		
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
	public ModelAndView edit(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model) throws Exception {
		
		//주문정보 마스터 정보
		tb_odinfoxm = (XTB_ODINFOXM)requestMgrService.getMasterInfo(tb_odinfoxm);
		//주문정보 상세  
		tb_odinfoxm.setList(requestMgrService.getDetailsList(tb_odinfoxm));
		
		//배송지 정보
		TB_ODDLAIXM tb_oddlaixm = new TB_ODDLAIXM();
		tb_oddlaixm.setList(requestMgrService.getDeliveryInfo(tb_odinfoxm));

		if(StringUtils.isNotEmpty(tb_odinfoxm.getATFL_ID())){
			//파일 받아오기
			TB_COATFLXD commonFile = new TB_COATFLXD();
			commonFile.setATFL_ID(tb_odinfoxm.getATFL_ID());
			model.addAttribute("fileList", commonService.selectFileList(commonFile));
		}

		if(StringUtils.isNotEmpty(tb_odinfoxm.getDLVY_ATFL())){
			//파일 받아오기
			TB_COATFLXD commonFile = new TB_COATFLXD();
			commonFile.setATFL_ID(tb_odinfoxm.getDLVY_ATFL());
			model.addAttribute("fileListDLVY", commonService.selectFileList(commonFile));
		}

		if(StringUtils.isNotEmpty(tb_odinfoxm.getCARD_ATFL())){
			//파일 받아오기
			TB_COATFLXD commonFile = new TB_COATFLXD();
			commonFile.setATFL_ID(tb_odinfoxm.getCARD_ATFL());
			model.addAttribute("fileListCARD", commonService.selectFileList(commonFile));
		}
		
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		model.addAttribute("tb_oddlaixm", tb_oddlaixm);
		
		return new ModelAndView("admin.layout", "jsp", "admin/requestMgr/form");
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
	@RequestMapping(value={ "/print/{ORDER_NUM}" }, method=RequestMethod.GET)
	public ModelAndView print(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model) throws Exception {
		
		//주문정보 마스터 정보
		tb_odinfoxm = (XTB_ODINFOXM)requestMgrService.getMasterInfo(tb_odinfoxm);
		//주문정보 상세  
		tb_odinfoxm.setList(requestMgrService.getDetailsList(tb_odinfoxm));
		
		//배송지 정보
		TB_ODDLAIXM tb_oddlaixm = new TB_ODDLAIXM();
		tb_oddlaixm.setList(requestMgrService.getDeliveryInfo(tb_odinfoxm));

		if(StringUtils.isNotEmpty(tb_odinfoxm.getATFL_ID())){
			//파일 받아오기
			TB_COATFLXD commonFile = new TB_COATFLXD();
			commonFile.setATFL_ID(tb_odinfoxm.getATFL_ID());
			model.addAttribute("fileList", commonService.selectFileList(commonFile));
		}
		
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		model.addAttribute("tb_oddlaixm", tb_oddlaixm);
		
		return new ModelAndView("admin.layout", "jsp", "admin/requestMgr/print");
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
	 * @param multipartRequest
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView update(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, @ModelAttribute XTB_ODDLAIXM tb_oddlaixm,HttpServletRequest request) throws Exception {
		

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());	
		tb_oddlaixm.setREGP_ID(loginUser.getMEMB_ID());	
		
		//주문상태 및 결제 정보 수정
		requestMgrService.getDetailsUpdate(tb_odinfoxm,tb_oddlaixm);
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/requestMgr/form/"+tb_odinfoxm.getORDER_NUM());
		
		return new ModelAndView(redirectView);
	}
	
}
