package mall.web.controller.mall;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.web.controller.DefaultController;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_TMINFOXM;
import mall.web.service.common.CommonService;
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
public class MemberController extends DefaultController{


	@Resource(name="commonService")
	CommonService commonService;
	
	//회원관리 서비스 이용
	@Resource(name="memberService")
	MemberService memberService;
	
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
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/memberJoinStep1", method=RequestMethod.GET)
	public ModelAndView index(@ModelAttribute TB_MBINFOXM memberInfo, Model model) throws Exception {
		
		TB_TMINFOXM tmInfo = new TB_TMINFOXM();

		model.addAttribute("TERM", memberService.termList(tmInfo));

		return new ModelAndView("mallNew.layout", "jsp", "mall/member/step1");
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
	@RequestMapping(value="/memberJoinStep2", method=RequestMethod.POST)
	public ModelAndView step2(@ModelAttribute TB_MBINFOXM memberInfo, Model model) throws Exception {
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/member/step2");
	}

	@RequestMapping(value="/memberJoinStep2", method=RequestMethod.GET)
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
	@RequestMapping(value="/memberInsert", method=RequestMethod.POST)
	public ModelAndView memberInsert(@ModelAttribute TB_MBINFOXM memberInfo, HttpServletRequest request, Model model) throws Exception {

		//memberInfo.setMEMB_GUBN("MEMB_GUBN_01");
		memberService.insertObject(memberInfo);


		ModelAndView mav = new ModelAndView();
		mav.addObject("alertMessage", "정상적으로 회원가입이 되었습니다. 로그인 후 사용하세요.");
		mav.addObject("returnUrl", "/");
		mav.setViewName("alertMessage");

		return mav;
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.MemberMgrController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 회원정보 등록/변경을 위한 정보 조회(form)
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-08 (오전 9:31:25)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/idChk", method=RequestMethod.POST)
	public @ResponseBody String idChk(@ModelAttribute TB_MBINFOXM memberInfo) throws Exception {
		int idCnt = memberService.idCheck(memberInfo);
		
		return idCnt+"";
	}
	

	@RequestMapping(value="/comBunbChk", method=RequestMethod.POST)
	public @ResponseBody String comBunbChk(@ModelAttribute TB_MBINFOXM memberInfo) throws Exception {
		int comBunbCnt = memberService.comBunbChk(memberInfo);
		return comBunbCnt+"";
	}
}
