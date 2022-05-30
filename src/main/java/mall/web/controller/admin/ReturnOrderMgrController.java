package mall.web.controller.admin;

import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import mall.common.util.StringUtil;
import mall.web.apiLink.AtomyAzaAPI;
import mall.web.controller.DefaultController;
import mall.web.controller.responsiveMall.OrderRestController;
import mall.web.domain.TB_LGUPLUS;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_RTODINFOXD;
import mall.web.domain.TB_RTODINFOXM;
import mall.web.service.admin.impl.OrderEditMgrService;
import mall.web.service.admin.impl.OrderMgrService;
import mall.web.service.admin.impl.ReturnOrderMgrService;
import mall.web.service.common.CommonService;
import mall.web.service.mall.OrderService;

@Controller
@RequestMapping(value="/adm/returnOrderMgr")
public class ReturnOrderMgrController extends DefaultController{

	@Resource(name="commonService")
	CommonService commonService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(OrderRestController.class);

	private final RestTemplate restTemplate = new RestTemplate();

	private final ObjectMapper objectMapper = new ObjectMapper();

	private final String SECRET_KEY = "test_sk_zXLkKEypNArWmo50nX3lmeaxYG5R";
	
	@Resource(name="orderService")
	OrderService orderService;

	@Resource(name="orderMgrService")
	OrderMgrService orderMgrService;
	
	@Resource(name="returnOrderMgrService")
	ReturnOrderMgrService returnOrderMgrService;

	@Resource(name="orderEditMgrService")
	OrderEditMgrService orderEditMgrService;
	
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
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model,HttpServletRequest request) throws Exception {
		// 페이징 단위
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_odinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			tb_odinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_odinfoxm.setRowCnt(20);
			tb_odinfoxm.setPagerMaxPageItems(20);
		}
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");		
		//회원 아이디
		tb_odinfoxm.setMEMB_ID(loginUser.getMEMB_ID());
		tb_odinfoxm.setMEMB_GUBN(loginUser.getMEMB_GUBN());
		tb_odinfoxm.setLOGIN_SUPR_ID(loginUser.getSUPR_ID());
		
		tb_odinfoxm.setCount(returnOrderMgrService.getObjectCount(tb_odinfoxm));
		tb_odinfoxm.setLOGIN_SUPR_ID(loginUser.getSUPR_ID());
		tb_odinfoxm.setMEMB_GUBN(loginUser.getMEMB_GUBN()); 
		tb_odinfoxm.setList(returnOrderMgrService.getPaginatedObjectList(tb_odinfoxm));
		
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
		+ "&ORDER_NUM=" + StringUtil.nullCheck(tb_odinfoxm.getORDER_NUM())
		+ "&PAY_METD=" + StringUtil.nullCheck(tb_odinfoxm.getPAY_METD());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/returnOrderMgr/return");
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
		model.addAttribute("login_supr_id", loginUser.getSUPR_ID());
		tb_odinfoxm.setMEMB_ID(loginUser.getMEMB_ID());
		//주문 마스터 정보
		tb_odinfoxm = (TB_ODINFOXM)orderMgrService.getMasterInfo(tb_odinfoxm);
		tb_odinfoxm.setMEMB_ID(loginUser.getMEMB_ID());
		tb_odinfoxm.setLOGIN_SUPR_ID(loginUser.getSUPR_ID());
		tb_odinfoxm.setMEMB_GUBN(loginUser.getMEMB_GUBN());
		//주문 상세 정보  
		tb_odinfoxm.setList(returnOrderMgrService.getDetailsList(tb_odinfoxm));
		
		// 업체 정보 불러오기
		List<HashMap<String, String>> pd_supr_list = (List<HashMap<String, String>>) returnOrderMgrService.getPdSuprList(tb_odinfoxm);
		model.addAttribute("pd_supr_list", pd_supr_list);		
		model.addAttribute("tb_odinfoxm", tb_odinfoxm);
		
		return new ModelAndView("admin.layout", "jsp", "admin/returnOrderMgr/edit");
	}
	/*public ModelAndView edit(@ModelAttribute TB_RTODINFOXM tb_rtodinfoxm, Model model) throws Exception {
		
		//주문정보 마스터 정보
		tb_rtodinfoxm = (TB_RTODINFOXM)returnOrderMgrService.getMasterInfo(tb_rtodinfoxm);
		//주문정보 상세  
		tb_rtodinfoxm.setList(returnOrderMgrService.getDetailsList(tb_rtodinfoxm));
		
		model.addAttribute("tb_rtodinfoxm", tb_rtodinfoxm);
		
		return new ModelAndView("admin.layout", "jsp", "admin/returnOrderMgr/form");
	}*/
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
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
	public ModelAndView update(@ModelAttribute TB_ODINFOXD tb_odinfoxd, @ModelAttribute TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {		
	
		ModelAndView mav = new ModelAndView();
		// 로그인 유저 정보
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_odinfoxd.setMODP_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setLOGIN_SUPR_ID(loginUser.getSUPR_ID()); 
		tb_odinfoxd.setMEMB_GUBN(loginUser.getMEMB_GUBN());
		//배송정보 수정
		String[] order_num=tb_odinfoxd.getORDER_NUM().split(",");
		String[] pd_code=tb_odinfoxd.getPD_CODE().split(",");
		String[] supr_id=tb_odinfoxd.getSUPR_ID().split(",");
		String[] dtl_rfnd_dlyv_tdn =  tb_odinfoxd.getDTL_RFND_DLVY_TDN().split(",");
		String[] option1_value =tb_odinfoxd.getOPTION1_VALUE().split(",");
		String[] option2_value =tb_odinfoxd.getOPTION2_VALUE().split(",");
		String[] option3_value =tb_odinfoxd.getOPTION3_VALUE().split(",");

		for(int i= 0; i<pd_code.length;i++) {
			tb_odinfoxd.setORDER_NUM(order_num[i]);
			tb_odinfoxd.setPD_CODE(pd_code[i]);
			tb_odinfoxd.setSUPR_ID(supr_id[i]);
		
			if(!option3_value[i].equals("-")) {
				tb_odinfoxd.setOPTION1_VALUE(option1_value[i]);
				tb_odinfoxd.setOPTION2_VALUE(option2_value[i]);
				tb_odinfoxd.setOPTION3_VALUE(option3_value[i]);
			}else if(!option2_value[i].equals("-")) {
				tb_odinfoxd.setOPTION1_VALUE(option1_value[i]);
				tb_odinfoxd.setOPTION2_VALUE(option2_value[i]);
				tb_odinfoxd.setOPTION3_VALUE("");
			}else if(!option1_value[i].equals("-")) {
				tb_odinfoxd.setOPTION1_VALUE(option1_value[i]);
				tb_odinfoxd.setOPTION2_VALUE("");
				tb_odinfoxd.setOPTION3_VALUE("");
			}else if(option1_value[i].equals("-")) {
				tb_odinfoxd.setOPTION1_VALUE("");
				tb_odinfoxd.setOPTION2_VALUE("");
				tb_odinfoxd.setOPTION3_VALUE("");
			}
			
			if(dtl_rfnd_dlyv_tdn.length == 0 || dtl_rfnd_dlyv_tdn.length < i+1) {
				tb_odinfoxd.setRFND_DLVY_TDN("");
				tb_odinfoxd.setDTL_RFND_DLVY_TDN("");
			}else{
				tb_odinfoxd.setRFND_DLVY_TDN(dtl_rfnd_dlyv_tdn[i]);
				tb_odinfoxd.setDTL_RFND_DLVY_TDN(dtl_rfnd_dlyv_tdn[i]);
			}
			System.out.println("RFND_DLVY_TDN "+i+ " : "+tb_odinfoxd.getRFND_DLVY_TDN());
			System.out.println("DTL_RFND_DLVY_TDN "+i+" : "+tb_odinfoxd.getDTL_RFND_DLVY_TDN());
			returnOrderMgrService.getDetailsUpdate(tb_odinfoxd);
	        }
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/returnOrderMgr/form/"+tb_odinfoxd.getORDER_NUM());
		return new ModelAndView(redirectView);
	}

	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ReturnOrderMgrController.java
	 * @Method	: insert
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문내역 상세 및 주문상태/결제정보 저장 (사용안함)
	 * @Company	: YT Corp.
	 * @Author	: Hee-sun Lee(hslee@youngthink.co.kr)
	 * @Date	: 2018-10-17 (오후 6:08:29)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/insert" }, method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODINFOXD tb_odinfoxd,@ModelAttribute TB_RTODINFOXM tb_rtodinfoxm,
			@ModelAttribute TB_RTODINFOXD tb_rtodinfoxd, BindingResult result, SessionStatus status, Model model,HttpServletRequest request) throws Exception {
		//반품신청 유저 셋팅
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_rtodinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		tb_rtodinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		tb_rtodinfoxd.setREGP_ID(loginUser.getMEMB_ID());
		tb_rtodinfoxd.setMODP_ID(loginUser.getMEMB_ID());
	
		//반품마스터 insert
		returnOrderMgrService.insertRtOrdObject(tb_rtodinfoxm,tb_rtodinfoxd);
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/orderCmptMgr/form/"+tb_odinfoxm.getORDER_NUM());		
		return new ModelAndView(redirectView);
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ReturnOrderMgrController.java
	 * @Method	: insert2
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문내역 상세 및 주문상태/결제정보 저장
	 * @Company	: YT Corp.
	 * @Author	: Hee-sun Lee(hslee@youngthink.co.kr)
	 * @Date	: 2018-10-17 (오후 6:08:29)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm1
	 * @param pagerOffset
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/insert2" }, method=RequestMethod.POST)
	public ModelAndView insert2(@ModelAttribute TB_ODINFOXM tb_odinfoxm, @ModelAttribute TB_ODINFOXD tb_odinfoxd, @ModelAttribute TB_ODDLAIXM tb_oddlaixm,
			BindingResult result, SessionStatus status, Model model,HttpServletRequest request) throws Exception {
		//반품신청 유저 셋팅
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		tb_odinfoxd.setREGP_ID(loginUser.getMEMB_ID());
		tb_oddlaixm.setREGP_ID(loginUser.getMEMB_ID());
		
		//반품 신규전표 insert
		TB_ODINFOXM tb_rtninfoxm = (TB_ODINFOXM) returnOrderMgrService.insertOrderObject(tb_odinfoxm, tb_odinfoxd, tb_odinfoxm.getORDER_NUM());

		// 성공시, 애터미아자 API호출 (마이너스 수량 및 금액 전송)
		if(tb_rtninfoxm.getCount() > 0) {
			AtomyAzaAPI azapi = new AtomyAzaAPI();
			azapi.Return_AtomyAza2(orderService, tb_rtninfoxm.getORIGIN_NUM(), tb_rtninfoxm.getORDER_NUM());
		}
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/returnOrderMgr/form/"+tb_odinfoxm.getORDER_NUM());		
		return new ModelAndView(redirectView);
	}
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.OrderMgrController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문번호에 해당하는 반품내역 존재여부 확인
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
	@RequestMapping(value={ "/ordCheck" }, method=RequestMethod.POST)
	public @ResponseBody String ordCheck(@ModelAttribute TB_RTODINFOXM tb_rtodinfoxm) throws Exception {
		//주문번호에 따른 반품내역 갯수
		int ordCount = returnOrderMgrService.getOrdCount(tb_rtodinfoxm);
		return ordCount+"";
	}
	@RequestMapping(value={ "/rtnCheck" }, method=RequestMethod.GET)
	public @ResponseBody String rtnCheck(@ModelAttribute TB_ODINFOXM tb_odinfoxm) throws Exception {
		//주문번호에 따른 반품내역 갯수
		int chkCnt = returnOrderMgrService.getRtnCount(tb_odinfoxm);
		return chkCnt+"";
	}	
}
