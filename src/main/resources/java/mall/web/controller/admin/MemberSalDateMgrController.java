package mall.web.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import mall.common.util.ExcelDownload;
import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_TOTINFOXM;
import mall.web.service.admin.impl.MemberSalDateMgrService;

@Controller
@RequestMapping(value="/adm")
public class MemberSalDateMgrController extends DefaultController{

	private static final Logger logger = LoggerFactory.getLogger(MemberSalDateMgrController.class);

	@Resource(name="memberSalDateMgrService")
	MemberSalDateMgrService memberSalDateMgrService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.MemberSalDateMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 회원-일별 매출현황
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model6
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/memberSalDateMgr", method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_TOTINFOXM memberInfo, HttpServletRequest request, Model model) throws Exception {
		
		//Default date
		String dateStr = request.getParameter("datepickerStr");
		String dateEnd = request.getParameter("datepickerEnd");		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		
		if (dateStr == null){
			Calendar cal = Calendar.getInstance ( );
			cal.add(Calendar.DATE, -7);
			Date weekago = cal.getTime();
			
			dateStr = dateformat.format(weekago).toString();
			memberInfo.setDatepickerStr(dateStr);
		}
		if(dateEnd == null){
			Date today = new Date ();
			
			dateEnd = dateformat.format(today).toString();
			memberInfo.setDatepickerEnd(dateEnd);
		}
		
		//memberInfo.setSCSS_YN("N");					//Y-탈퇴회원, N-정상회원
		memberInfo.setMEMB_GUBN(request.getParameter("MEMB_GUBN"));
		memberInfo.setTAXCAL_YN(request.getParameter("TAXCAL_YN"));
		memberInfo.setCount(memberSalDateMgrService.getObjectCount(memberInfo));
		memberInfo.setList(memberSalDateMgrService.getPaginatedObjectList(memberInfo));

		model.addAttribute("obj", memberInfo);
		model.addAttribute("rowCnt", memberInfo.getRowCnt());
		model.addAttribute("totalCnt", memberInfo.getCount());
		
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(memberInfo.getSchGbn())
				  + "&schTxt="+StringUtil.nullCheck(memberInfo.getSchTxt())
				  + "&datepickerStr="+StringUtil.nullCheck(dateStr)	
				  + "&datepickerEnd="+StringUtil.nullCheck(dateEnd)
				  + "&PAY_METD="+StringUtil.nullCheck(request.getParameter("PAY_METD"))
				  + "&MEMB_GUBN="+StringUtil.nullCheck(request.getParameter("MEMB_GUBN"))
				  + "&TAXCAL_YN="+StringUtil.nullCheck(request.getParameter("TAXCAL_YN"))
				  + "&MEMB_NM_ORDER=" + StringUtil.nullCheck(memberInfo.getMEMB_NM_ORDER())
				  + "&COM_NAME_ORDER=" + StringUtil.nullCheck(memberInfo.getCOM_NM_ORDER())
				  + "&MEMB_ORD_GUBUN=" + StringUtil.nullCheck(memberInfo.getMEMB_ORD_GUBUN());
		
		model.addAttribute("link", strLink);

		return new ModelAndView("admin.layout", "jsp", "admin/memberSalDateMgr/list");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.MemberSalDateMgrController.java
	 * @Method	: getExcelList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 회원-일별 매출현황 (엑셀)
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model6
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/memberSalDateMgr/excelDown" }, method=RequestMethod.GET)
	public void getExcelList(@ModelAttribute TB_TOTINFOXM memberInfo, Model model,HttpServletResponse response
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {

		String[] headerName = { "고객아이디", "고객명", "상호", "사업자번호", "결제일자"
										, "주문합계", "주문과세", "주문면세", "주문배송비"
										, "반품합계", "반품과세", "반품면세", "반품배송비"
										, "총 매출합계", "총 매출과세", "총 매출면세", "총 매출배송비"
										, "주소", "이메일" };
	
		String[] columnName = { "MEMB_ID", "MEMB_NAME", "COM_NAME", "COM_BUNB", "ORDER_DATE"
										, "ORDER_AMT_SUM", "ORDER_TAX_GUBN_01_SUM","ORDER_TAX_GUBN_02_SUM" ,"ORDER_DLVY_SUM"
										, "RETURN_AMT_SUM", "RETURN_TAX_GUBN_01_SUM","RETURN_TAX_GUBN_02_SUM","RETURN_DLVY_SUM"
										, "TOTAL_AMT_SUM", "TOTAL_TAX_GUBN_01_SUM","TOTAL_TAX_GUBN_02_SUM" ,"TOTAL_DLVY_SUM"
										, "MEMB_BADR", "MEMB_MAIL"};
		
		String sheetName = "일별매출집계";
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) memberSalDateMgrService.getExcelList(memberInfo);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.MemberSalDateMgrController.java
	 * @Method	: getMonth
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 회원-월별 매출현황
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model6
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/memberSalMnthMgr" }, method=RequestMethod.GET)
	public ModelAndView getMonth(@ModelAttribute TB_MBINFOXM memberInfo, HttpServletRequest request, Model model) throws Exception {
		
		if(memberInfo.getDatepickerStr()==null || memberInfo.getDatepickerStr().equals("")){
			String curTime = new SimpleDateFormat("yyyyMM").format(new Date());
			memberInfo.setDatepickerStr(curTime);
		}
		
		int year = Integer.parseInt(memberInfo.getDatepickerStr().substring(0, 4));
        int month = Integer.parseInt(memberInfo.getDatepickerStr().substring(4, 6))-1;
        int day = 1;
        Calendar cal = new GregorianCalendar(year, month, day);
        int daysOfMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
       
		memberInfo.setCount(memberSalDateMgrService.getDateCnt(memberInfo));
		memberInfo.setList(memberSalDateMgrService.getDateList(memberInfo));
		
		model.addAttribute("obj", memberInfo);
		model.addAttribute("rowCnt", memberInfo.getRowCnt());
		model.addAttribute("totalCnt", memberInfo.getCount());
		model.addAttribute("dateCnt",daysOfMonth);
		model.addAttribute("month", month+1);
		
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(memberInfo.getSchGbn())
				  + "&schTxt="+StringUtil.nullCheck(memberInfo.getSchTxt())
				  + "&datepickerStr="+StringUtil.nullCheck(request.getParameter("datepickerStr"))
				  + "&PAY_METD="+StringUtil.nullCheck(request.getParameter("PAY_METD"))
				  + "&MEMB_GUBN="+StringUtil.nullCheck(request.getParameter("MEMB_GUBN"))
				  + "&TAXCAL_YN="+StringUtil.nullCheck(request.getParameter("TAXCAL_YN"))
				  + "&MEMB_NM_ORDER=" + StringUtil.nullCheck(memberInfo.getMEMB_NM_ORDER())
				  + "&COM_NAME_ORDER=" + StringUtil.nullCheck(memberInfo.getCOM_NM_ORDER())
				  + "&MEMB_ORD_GUBUN=" + StringUtil.nullCheck(memberInfo.getMEMB_ORD_GUBUN());
		
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/memberSalDateMgr2/list");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.MemberSalDateMgrController.java
	 * @Method	: getMonth
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 회원-월별 매출현황 (엑셀)
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model6
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/memberSalMnthMgr/excelDown" }, method=RequestMethod.GET)
	public void getDateExcelList(@ModelAttribute TB_MBINFOXM memberInfo, Model model,HttpServletResponse response
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {

		int year = Integer.parseInt(memberInfo.getDatepickerStr().substring(0, 4));
        int month = Integer.parseInt(memberInfo.getDatepickerStr().substring(4, 6))-1;
        int day = 1;
        Calendar cal = new GregorianCalendar(year, month, day);
        int daysOfMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		String[] headerName = new String[daysOfMonth+6];
		headerName[0] = "고객아이디";
		headerName[1] = "고객명";
		headerName[2] = "사업자상호";
		headerName[3] = "사업자번호";
		headerName[4] = "주소";
		headerName[5] = "이메일";
		
		String[] columnName = new String[daysOfMonth+6];
		columnName[0] = "MEMB_ID";
		columnName[1] = "MEMB_NAME";
		columnName[2] = "COM_NAME";
		columnName[3] = "COM_BUNB";
		columnName[4] = "MEMB_BADR";
		columnName[5] = "MEMB_MAIL";
		
		for(int i=6; i<daysOfMonth+6; i++){
			headerName[i] = (i-5)+"일";
			columnName[i] = "DAY"+(i-5);
		}
		
		String sheetName = "회원월별매출집계관리";

		List<HashMap<String, String>> list = (List<HashMap<String, String>>) memberSalDateMgrService.getDateExcelList(memberInfo);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}
	
}
