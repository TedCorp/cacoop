package mall.web.controller.admin;

import java.text.SimpleDateFormat;
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
import org.springframework.web.servlet.ModelAndView;

import mall.common.util.ExcelDownload;
import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_TOTINFOXM;
import mall.web.service.admin.impl.MemberSalCntMgrService;

@Controller
@RequestMapping(value="/adm/memberSalCntMgr")
public class MemberSalCntMgrController extends DefaultController{

	private static final Logger logger = LoggerFactory.getLogger(MemberSalCntMgrController.class);

	@Resource(name="memberSalCntMgrService")
	MemberSalCntMgrService memberSalCntMgrService;
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.MemberSalCntMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 회원매출집계
	 * @Company	: YT Corp.
	 * @Author	: chjw
	 * @Date	: 2020-10-20
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getSalCntList(@ModelAttribute TB_TOTINFOXM memberInfo, HttpServletRequest request, Model model) throws Exception {
		// Default date
		String dateStr = request.getParameter("datepickerStr");
		String dateEnd = request.getParameter("datepickerEnd");
		SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
		
		if (dateStr == null){
			Calendar cal = Calendar.getInstance ( );
			cal.add(Calendar.DATE, -7);
			Date weekago = cal.getTime();
			
			dateStr = sdformat.format(weekago).toString();
			memberInfo.setDatepickerStr(dateStr);
		}
		if(dateEnd == null){
			Date today = new Date ();			
			dateEnd = sdformat.format(today).toString();
			memberInfo.setDatepickerEnd(dateEnd);
		}
		
		//memberInfo.setSCSS_YN("N");					// Y-탈퇴회원, N-정상회원
		memberInfo.setCount(memberSalCntMgrService.getObjectCount(memberInfo));
		memberInfo.setList(memberSalCntMgrService.getPaginatedObjectList(memberInfo));
		
		model.addAttribute("obj", memberInfo);
		model.addAttribute("rowCnt", memberInfo.getRowCnt());
		model.addAttribute("totalCnt", memberInfo.getCount());
		
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(memberInfo.getSchGbn())
					+ "&schTxt="+StringUtil.nullCheck(memberInfo.getSchTxt())
					+ "&datepickerStr="+StringUtil.nullCheck(request.getParameter("datepickerStr"))
					+ "&datepickerEnd="+StringUtil.nullCheck(request.getParameter("datepickerEnd"))
					+ "&PAY_GUBN="+StringUtil.nullCheck(request.getParameter("PAY_GUBN"))
					+ "&MEMB_GUBN="+StringUtil.nullCheck(request.getParameter("MEMB_GUBN"))
					+ "&TAXCAL_YN="+StringUtil.nullCheck(request.getParameter("TAXCAL_YN"))
					+ "&MEMB_NM_ORDER=" + StringUtil.nullCheck(memberInfo.getMEMB_NM_ORDER())
					+ "&COM_NAME_ORDER=" + StringUtil.nullCheck(memberInfo.getCOM_NM_ORDER())
					+ "&MEMB_ORD_GUBUN=" + StringUtil.nullCheck(memberInfo.getMEMB_ORD_GUBUN());
		
		model.addAttribute("link", strLink);

		return new ModelAndView("admin.layout", "jsp", "admin/memberSalCntMgr/list");
	}
	
	@RequestMapping(value={ "/excelDown" }, method=RequestMethod.GET)
	public void getExcelList(@ModelAttribute TB_TOTINFOXM memberInfo, Model model, HttpServletResponse response) throws Exception {
		String sheetName = "회원매출집계";

		String[] headerName = {
			"고객ID", "고객구분", "고객명(대표자명)","사업자상호","사업자번호","계산서발행구분"
			,"주문합계","주문배송비","주문과세매출","주문면세매출"
			,"반품총합계","반품상품합계","반품배송비합계","반품과세금액","반품면세금액"
			,"확정 신용카드 (과세)","확정 신용카드 (면세)","확정 무통장 (과세)","확정 무통장 (면세)"
			,"총 과세매출","총 면세매출","총 상품합계","총 배송비"
			,"사업자 기본주소","사업자 상세주소","회원 이메일"
		};
		
		String[] columnName = {
			"MEMB_ID", "MEMB_GUBN_NM", "MEMB_NAME","COM_NAME", "COM_BUNB","TAXCAL_YN"
			,"ORDER_PROD_SUM", "ORDER_DLVY_SUM","ORDER_TAX_GUBN_01_SUM","ORDER_TAX_GUBN_02_SUM"
			,"RETURN_AMT_SUM","RETURN_PROD_SUM","RETURN_DLVY_SUM","RETURN_TAX_GUBN_01_SUM","RETURN_TAX_GUBN_02_SUM"
			,"PAY_METD_01_TAX_GUBN_01_SUM","PAY_METD_01_TAX_GUBN_02_SUM","PAY_METD_02_TAX_GUBN_01_SUM","PAY_METD_02_TAX_GUBN_02_SUM"
			,"TOTAL_TAX_GUBN_01_SUM","TOTAL_TAX_GUBN_02_SUM","TOTAL_PROD_SUM","TOTAL_DLVY_SUM"
			,"COM_BADR","COM_DADR","MEMB_MAIL"
		};
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) memberSalCntMgrService.getExcelList(memberInfo);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);		
	}
}
