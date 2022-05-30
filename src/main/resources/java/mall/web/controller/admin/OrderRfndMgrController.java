package mall.web.controller.admin;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.util.StringUtil;
import mall.web.apiLink.AtomyAzaAPI;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.service.admin.impl.OrderMgrService;
import mall.web.service.admin.impl.OrderRfndMgrService;
import mall.web.service.common.CommonService;
import mall.web.service.mall.OrderService;

@Controller
@RequestMapping(value="/adm/orderRfndMgr")
public class OrderRfndMgrController extends DefaultController{

	@Resource(name="orderRfndMgrService")
	OrderRfndMgrService orderRfndMgrService;

	@Resource(name="orderMgrService")
	OrderMgrService orderMgrService;

	@Resource(name="orderService")
	OrderService orderService;
	
	@Resource(name="commonService")
	CommonService commonService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderRfndMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 환불접수 목록
	 * @Company	: YT Corp.
	 * @Author	: chjw
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		// Default date
		Map<String, String> betweenDate = commonService.betweenDate(request.getParameter("datepickerStr"), request.getParameter("datepickerEnd"), 7);
		tb_odinfoxm.setDatepickerStr(betweenDate.get("datepickerStr"));
		tb_odinfoxm.setDatepickerEnd(betweenDate.get("datepickerEnd"));
		
		// 페이징 단위
		if(request.getParameter("pagerMaxPageItems") != null){
			tb_odinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			tb_odinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_odinfoxm.setRowCnt(20);
			tb_odinfoxm.setPagerMaxPageItems(20);	
		}
		tb_odinfoxm.setORDER_CON("ORDER_CON_11");
		
		// 환불신청 상태의 목록
		tb_odinfoxm.setCount(orderRfndMgrService.getObjectCount(tb_odinfoxm));
		tb_odinfoxm.setList(orderRfndMgrService.getPaginatedObjectList(tb_odinfoxm));
		
		model.addAttribute("obj", tb_odinfoxm);
		model.addAttribute("rowCnt", tb_odinfoxm.getRowCnt());
		model.addAttribute("totalCnt", tb_odinfoxm.getCount());
		
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(tb_odinfoxm.getSchGbn())
				+ "&schTxt="+StringUtil.nullCheck(tb_odinfoxm.getSchTxt())
				+ "&pagerMaxPageItems="+StringUtil.nullCheck(tb_odinfoxm.getPagerMaxPageItems())
				+ "&datepickerStr=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerStr())
				+ "&datepickerEnd=" + StringUtil.nullCheck(tb_odinfoxm.getDatepickerEnd())
				+ "&schParam=" + StringUtil.nullCheck(tb_odinfoxm.getSchParam())
				+ "&PAY_METD=" + StringUtil.nullCheck(tb_odinfoxm.getPAY_METD());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderRfndMgr/list");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderRfndMgrController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 환불접수 상세
	 * @Company	: YT Corp.
	 * @Author	: chjw
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/form/{ORDER_NUM}" }, method=RequestMethod.GET)
	public ModelAndView edit(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		//주문M 정보
		tb_odinfoxm = (TB_ODINFOXM)orderMgrService.getMasterInfo(tb_odinfoxm);
		//주문D 정보
		tb_odinfoxm.setList(orderMgrService.getDetailsList(tb_odinfoxm));
		//수취인 정보
		TB_ODINFOXM originInfo = new TB_ODINFOXM();
		originInfo.setORDER_NUM(tb_odinfoxm.getORIGIN_NUM());
		TB_ODDLAIXM tb_oddlaixm = (TB_ODDLAIXM)orderMgrService.getDeliveryInfo(originInfo);
		
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		model.addAttribute("tb_oddlaixm", tb_oddlaixm);
		
		return new ModelAndView("admin.layout", "jsp", "admin/orderRfndMgr/form");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderRfndMgrController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 환불상태 update
	 * @Company	: YT Corp.
	 * @Author	: chjw
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView update(@ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, SessionStatus status, Model model) throws Exception {
		// 세션변경
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_odinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		try {
			// 주문상태 및 결제 정보 수정
			int result = orderRfndMgrService.updateObject(tb_odinfoxm);
			
			if("RFND_CON_03".equals(tb_odinfoxm.getRFND_CON())) {
				// 성공시, 애터미아자 API호출 (마이너스 수량 및 금액 전송)
				if(result > 0) {
					AtomyAzaAPI azapi = new AtomyAzaAPI();
					azapi.Return_AtomyAza2(orderService, tb_odinfoxm.getORIGIN_NUM(), tb_odinfoxm.getORDER_NUM());
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderRfndMgr/form/"+tb_odinfoxm.getORDER_NUM());		
		return new ModelAndView(redirectView);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderRfndMgrController.java
	 * @Method	: partialCancel
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: Xpay 부분취소 -- 추후개발
	 * @Company	: YT Corp.
	 * @Author	: chjw
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/partialCancel" }, method=RequestMethod.GET)
	public ModelAndView getPartialCancel(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODINFOXD tb_odinfoxd, HttpServletRequest request, Model model) throws Exception {
		// 부분취소 가능한지 체크

		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderRfndMgr/form/"+tb_odinfoxm.getORDER_NUM());		
		return new ModelAndView(redirectView);
	}
	@RequestMapping(value={ "/partialCancel" }, method=RequestMethod.POST)
	public ModelAndView partialCancel(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODINFOXD tb_odinfoxd, HttpServletRequest request, Model model) throws Exception {
		//세션변경
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		ModelAndView mav = new ModelAndView();
		// 환불승인건만 로직타야됨
		try {
			//orderService.insertRefund(tb_odinfoxm, tb_odinfoxd);
			mav.addObject("alertMessage", "결제취소가 완료되었습니다.");
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("alertMessage", "결제취소요청이 실패하였습니다.");
		}
		
		mav.addObject("returnUrl", servletContextPath.concat("/adm/orderRfndMgr/form/" + tb_odinfoxd.getORDER_NUM()));
		mav.setViewName("alertMessage");

		return mav;
	}
}
