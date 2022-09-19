package mall.web.controller.responsiveMall;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.digest.DigestUtils;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_DELIVERY_ADDR;
import mall.web.domain.TB_FINDMEMBERINFO;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_SPINFOXM;
import mall.web.domain.TB_TMINFOXM;
import mall.web.service.admin.impl.DeliveryAddrMgrService;
import mall.web.service.common.CommonService;
import mall.web.service.mall.FindMemberInfoService;
import mall.web.service.mall.MemberService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.mall.MemberController
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 회원관련 Controller
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-07 (오후 11:13:33)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Controller
public class MemberRespController extends DefaultController{


	@Resource(name="commonService")
	CommonService commonService;
	
	//회원관리 서비스 이용
	@Resource(name="memberService")
	MemberService memberService;

	@Resource(name="findMemberInfoService")
	FindMemberInfoService findMemberInfoService;
	
	@Resource(name="deliveryAddrMgrService")
	DeliveryAddrMgrService deliveryAddrMgrService;
	
	
	private DigestUtils digestUtils;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.MemberController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 회원가입 회원약관/개인정보취급방침 동의
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-07 (오후 11:13:45)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param memberInfo
	 * @param model
	 * @return ModelAndView
	 * 
	 * 
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/m/memberJoinStep1", method=RequestMethod.GET)
	public ModelAndView index(@ModelAttribute TB_MBINFOXM memberInfo, Model model) throws Exception {
		
		TB_TMINFOXM tmInfo = new TB_TMINFOXM();

		model.addAttribute("TERM", memberService.termList(tmInfo));

		return new ModelAndView("blankPage", "jsp", "responsiveMall/member/register");
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.MemberController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 회원가입 회원정보 입력 폼
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-07 (오후 11:13:45)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param memberInfo
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/m/memberJoinStep2", method=RequestMethod.POST)
	public ModelAndView step2(@ModelAttribute TB_MBINFOXM memberInfo, Model model) throws Exception {
		
		return new ModelAndView("blankPage", "jsp", "mall/member/step2");
	}

	@RequestMapping(value="/m/memberJoinStep2", method=RequestMethod.GET)
	public ModelAndView stepreturn(@ModelAttribute TB_MBINFOXM memberInfo, Model model, HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");		
		String redirectPath = servletContextPath+"/mall/member/step1";
		
		if (loginUser != null){
			redirectPath = servletContextPath+"/";
		}
		
		RedirectView redirectView = new RedirectView(redirectPath);		
		return new ModelAndView(redirectView);				
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.MemberController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 회원가입 회원정보 입력 폼
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-07 (오후 11:13:45)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param memberInfo
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/m/memberInsert", method=RequestMethod.POST)
	public ModelAndView memberInsert(@ModelAttribute TB_MBINFOXM tb_mbinfoxm,
									 @ModelAttribute TB_SPINFOXM tb_spinfoxm,
									 @ModelAttribute TB_DELIVERY_ADDR tb_delivery_addr,
									 HttpServletRequest request, Model model) throws Exception {

		//ogto 회원가입 시 비번 암호화 설정
		digestUtils = new DigestUtils();
		String strEncrpytPasswd = digestUtils.kisaSha256(tb_mbinfoxm.getMEMB_PW());
		String trimEncrpytPasswd = strEncrpytPasswd.trim();
		tb_mbinfoxm.setMEMB_PW(trimEncrpytPasswd);
		
		String BIZR_NUM=tb_spinfoxm.getBIZR_NUM().replace("-","");
		tb_spinfoxm.setBIZR_NUM(BIZR_NUM);

		
		if(StringUtils.isNotEmpty(tb_spinfoxm.getBIZR_NUM())) {
			/* 공급사일 때 승인 대기 */
			if(tb_spinfoxm.getUSE_YN().equals("Y")) {
				tb_mbinfoxm.setSUPMEM_APST("SUPMEM_APST_02");
			}
			
			//조합원 유무체크 
			TB_SPINFOXM obj = new TB_SPINFOXM();
			obj = (TB_SPINFOXM)memberService.getSuprObject(tb_spinfoxm);
			
			//조합원이 
			if(obj != null) {
				tb_mbinfoxm.setSUPR_ID(obj.getSUPR_ID());
			} else {
				tb_spinfoxm.setREGP_ID(tb_mbinfoxm.getMEMB_ID());
				tb_spinfoxm.setPOST_NUM(tb_mbinfoxm.getMEMB_PN());
				memberService.insertSuprObject(tb_spinfoxm);
			
				TB_SPINFOXM obj2 = (TB_SPINFOXM)memberService.getSuprObject(tb_spinfoxm);
				tb_mbinfoxm.setSUPR_ID(obj2.getSUPR_ID());
			}
		}
		
		memberService.insertObject(tb_mbinfoxm);
	
		if(tb_spinfoxm.getUSE_YN().equals("Y")) {
			
			TB_SPINFOXM obj = new TB_SPINFOXM();
			obj = (TB_SPINFOXM)memberService.getSuprObject(tb_spinfoxm);
			int addr_count = deliveryAddrMgrService.addrCount();
			//기존 배송지가 등록되어있는지 확인
			if(StringUtils.isNotEmpty(tb_spinfoxm.getBIZR_NUM())) {
				tb_delivery_addr.setSUPR_ID(obj.getSUPR_ID());
				
				int count=deliveryAddrMgrService.getObjectCount(tb_delivery_addr);
				if(count == 0) {
					for(int i=0; i<addr_count; i++) {
						tb_delivery_addr.setADDR_GUBN("ADDR_GUBN_"+i);
						tb_delivery_addr.setCOM_PN(tb_mbinfoxm.getMEMB_PN());
						tb_delivery_addr.setCOM_BADR(tb_mbinfoxm.getMEMB_BADR());
						tb_delivery_addr.setCOM_DADR(tb_mbinfoxm.getMEMB_DADR());
						tb_delivery_addr.setCOM_TELN(tb_mbinfoxm.getMEMB_TELN());
						tb_delivery_addr.setCOM_MOBILE(tb_mbinfoxm.getMEMB_CPON());
						tb_delivery_addr.setREGP_ID(tb_mbinfoxm.getMEMB_ID());
						deliveryAddrMgrService.insertObject(tb_delivery_addr);
					}
				}
			}
		}
		
		ModelAndView mav = new ModelAndView();
		if(StringUtils.isNotEmpty(tb_spinfoxm.getBIZR_NUM()) && tb_spinfoxm.getUSE_YN().equals("Y")) {
			mav.addObject("alertMessage", "승인 후 이용 바랍니다.");
			mav.addObject("returnUrl", "/m");
			mav.setViewName("alertMessage");
		} else {
			mav.addObject("returnUrl", "/m/joinSuccess");
			mav.setViewName("responsiveMall/member/joinSuccess");
		}
		return mav;
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.MemberRespController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 아이디 찾기(form)
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 2019-06-16 (오전 9:31:25)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/m/findmemberinfo", method=RequestMethod.GET)
	public ModelAndView FindidForm(Model model) throws Exception {

		return new ModelAndView("blankPage", "jsp", "responsiveMall/login/findMember");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.MemberRespController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 아이디 찾기(form)
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 2019-06-16 (오전 9:31:25)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	
	/* 페이지 이동을 막기 위해 주석 처리 - 이유리
	@RequestMapping(value="/m/findmemberinfo/result", method=RequestMethod.POST)
	public ModelAndView FindIdResult(@ModelAttribute TB_FINDMEMBERINFO findinfo,  Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();

		if("ID".equals(findinfo.getFIND_GBN())){
			List<TB_FINDMEMBERINFO> lst = (List<TB_FINDMEMBERINFO>) findMemberInfoService.findID(findinfo);
			mav.addObject("list", lst);
		}else{
			List<TB_FINDMEMBERINFO> lst = (List<TB_FINDMEMBERINFO>) findMemberInfoService.findPW(findinfo);
			mav.addObject("list", lst);
		}
		
		mav.setViewName("responsiveMall/m/findResult");
		return mav;
	}
	*/
	
	@RequestMapping(value="/m/findmemberinfo/result", method=RequestMethod.POST)
	public @ResponseBody String FindIdResult(@ModelAttribute TB_FINDMEMBERINFO findinfo) throws Exception {
		String val = "";
		
		if("ID".equals(findinfo.getFIND_GBN())){
			List<TB_FINDMEMBERINFO> lst = (List<TB_FINDMEMBERINFO>) findMemberInfoService.findID(findinfo);
			if( lst.size()!=0){
				val = lst.get(0).getMEMB_ID();
			}
			return val;
		}else{
			List<TB_FINDMEMBERINFO> lst = (List<TB_FINDMEMBERINFO>) findMemberInfoService.findPW(findinfo);
			if( lst.size()!=0){
				val = lst.get(0).getMEMB_PW();
			}
			return val;
		}
	}
	
	/* 아이디 찾기 JSP 추가 - 이유리 */
	@RequestMapping(value="/m/findMemberId", method=RequestMethod.GET)
	public ModelAndView findMemberId(@ModelAttribute TB_MBINFOXM memberInfo, Model model) throws Exception {
		
		return new ModelAndView("blankPage", "jsp", "responsiveMall/login/findMemberId");
	}

	/* 비밀번호 찾기 JSP 추가 - 이유리 */
	@RequestMapping(value="/m/findMemberPw", method=RequestMethod.GET)
	public ModelAndView findMemberPw(@ModelAttribute TB_MBINFOXM memberInfo, Model model) throws Exception {
		
		return new ModelAndView("blankPage", "jsp", "responsiveMall/login/findMemberPw");
	}
	
	/* 화원가입 성공 JSP 추가 - 이유리 */
	@RequestMapping(value="/m/joinSuccess", method=RequestMethod.POST)
	public ModelAndView joinSuccess(@ModelAttribute TB_MBINFOXM memberInfo, Model model) throws Exception {
		
		return new ModelAndView("blankPage", "jsp", "responsiveMall/member/joinSuccess");
	}
	
	/* 회원탈퇴 JSP 추가 - 이유리 */
	@RequestMapping(value="/m/unregister", method=RequestMethod.GET)
	public ModelAndView unregister(@ModelAttribute TB_MBINFOXM memberInfo, Model model) throws Exception {
		
		return new ModelAndView("mall.responsive.layout", "jsp", "/member/unregister");
	}
	
	@RequestMapping(value="/m/exit", method=RequestMethod.POST)
	public ModelAndView exit(@ModelAttribute TB_MBINFOXM memberInfo, HttpServletRequest request, Model model) throws Exception {

		ModelAndView mav = new ModelAndView();
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		if(loginUser == null){
			mav.addObject("alertMessage", "로그인 후 이용해 주세요.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");
		} else {
			memberInfo.setMEMB_ID(loginUser.getMEMB_ID());
			memberInfo.setMODP_ID(loginUser.getMEMB_ID());
			memberService.deleteObject(memberInfo);
			
			// 기존 세션 정보 있을 시 제거
			HttpSession session = request.getSession(false);
			
			if(session != null){
				session.setAttribute("USER", null);
			}
			session.invalidate(); 
			//mav.setViewName("redirect:" + "/m");
			
			mav.addObject("alertMessage", "회원탈퇴가 정상적으로 처리되었습니다.");
			mav.addObject("returnUrl", "/");
			mav.setViewName("alertMessage");
		}
		return mav;
	}
	
	/* 비밀번호 찾기후 비밀번호 변경*/
	@RequestMapping(value="/m/findmemberinfo/updatepw", method=RequestMethod.POST)
	public ModelAndView updatepw(@ModelAttribute TB_MBINFOXM tb_mbinfoxm, @RequestParam("MEMB_PW") String MEMB_PW) throws Exception {
		
		//해싱처리
		digestUtils = new DigestUtils();
		String strEncrpytPasswd = digestUtils.kisaSha256(tb_mbinfoxm.getMEMB_PW());
		String trimEncrpytPasswd = strEncrpytPasswd.trim();
		tb_mbinfoxm.setMEMB_PW(trimEncrpytPasswd);
		
		
		int cnt = findMemberInfoService.updatePw(tb_mbinfoxm);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("alertMessage", "비밀번호 변경이 완료되었습니다. 로그인해주시길 바라겠습니다.");
		mav.addObject("returnUrl", "/m");
		mav.setViewName("alertMessage");
		
		return mav;
	}
	
}
