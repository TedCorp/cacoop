package mall.web.controller.responsiveMall;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.web.controller.DefaultController;
import mall.web.domain.TB_FINDMEMBERINFO;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_TMINFOXM;
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
	@RequestMapping(value="/m/memberJoinStep1", method=RequestMethod.GET)
	public ModelAndView index(@ModelAttribute TB_MBINFOXM memberInfo, Model model) throws Exception {
		
		TB_TMINFOXM tmInfo = new TB_TMINFOXM();

		model.addAttribute("TERM", memberService.termList(tmInfo));

		return new ModelAndView("mall.responsive.layout", "jsp", "member/register");
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
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/member/step2");
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
	public ModelAndView memberInsert(@ModelAttribute TB_MBINFOXM memberInfo, HttpServletRequest request, Model model) throws Exception {

		//memberInfo.setMEMB_GUBN("MEMB_GUBN_01");
		memberService.insertObject(memberInfo);


		ModelAndView mav = new ModelAndView();
		mav.addObject("alertMessage", "정상적으로 회원가입이 되었습니다. 로그인 후 사용하세요.");
		mav.addObject("returnUrl", "/m");
		mav.setViewName("alertMessage");

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
		
		mav.setViewName("responsiveMall/login/findResult");
		return mav;
	}

}
