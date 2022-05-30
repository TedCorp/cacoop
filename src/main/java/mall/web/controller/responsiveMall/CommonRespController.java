package mall.web.controller.responsiveMall;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.digest.DigestUtils;
import mall.web.domain.TB_COMCODXD;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODINFOXM;
import mall.web.service.admin.impl.MemberMgrService;
import mall.web.service.common.CommonService;
import mall.web.service.mall.OrderService;

@Controller
@RequestMapping(value="/m")
public class CommonRespController {
	
	private DigestUtils digestUtils;
	
	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="memberMgrService")
	MemberMgrService memberMgrService;

	@Resource(name="orderService")
	OrderService orderService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.CommonController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 로그인 세션처리
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-07 (오후 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/user/login", method=RequestMethod.POST)
	public ModelAndView getUserLogin(@ModelAttribute TB_MBINFOXM memberInfo, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		TB_MBINFOXM loginMember = (TB_MBINFOXM)memberMgrService.getObject(memberInfo);

		digestUtils = new DigestUtils();
		String strEncrpytPasswd = digestUtils.kisaSha256(memberInfo.getMEMB_PW());
		// String strEncrpytPasswd = memberInfo.getMEMB_PW();
		String trimEncrpytPasswd = strEncrpytPasswd.trim();
		
		// String strRtnUrl = memberInfo.getRtnUrl();
		
		System.out.println(trimEncrpytPasswd);
		if(loginMember==null){
			// mav.addObject("alertMessage", "아이디와 비밀번호를 입력해 주시기 바랍니다.");
			mav.addObject("alertMessage", "아이디와 비밀번호를 확인하시기 바랍니다.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");
			
		} else if(loginMember.getMEMB_ID()=="" || loginMember.getMEMB_PW()==""|| loginMember.getMEMB_ID()==null || loginMember.getMEMB_PW()==null) {
			
			// mav.addObject("alertMessage", "아이디와 비밀번호를 입력해 주시기 바랍니다.");
			mav.addObject("alertMessage", "아이디와 비밀번호를 확인하시기 바랍니다.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");
			
		}else if (!loginMember.getMEMB_PW().equals( trimEncrpytPasswd )) {	//strEncrpytPasswd
			System.out.println("비번1 : " + loginMember.getMEMB_PW());
			System.out.println("비번2 : " + trimEncrpytPasswd);
			
			mav.addObject("alertMessage", "아이디와 비밀번호를 확인하시기 바랍니다.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");
		
		} else if(loginMember.getSCSS_YN().equals("Y")){
			mav.addObject("alertMessage", "탈퇴된 회원계정입니다.고객센터로 문의바랍니다.");
			mav.addObject("returnUrl", "/");
			mav.setViewName("alertMessage");
			
		} else if(loginMember.getSTOP_YN().equals("Y")){
			mav.addObject("alertMessage", "일시중지된 회원계정입니다.고객센터로 문의바랍니다.");
			mav.addObject("returnUrl", "/");
			mav.setViewName("alertMessage");
			
		}else {
			
			/*
			if(StringUtils.isEmpty(strRtnUrl)){
				strRtnUrl = request.getHeader("referer");
				System.out.println("다시 strRtnUrl : " + strRtnUrl);
			}
			*/
			String rtnUrl = memberInfo.getRtnUrl();
			System.out.println("rtnUrl : " + rtnUrl);
			mav.addObject("returnUrl",rtnUrl);
			// 유저 세션 생성
			session.setAttribute("USER",  loginMember);
						
			// 미결재내역  세션 생성			
			TB_ODINFOXM resultNotPayCnt= new TB_ODINFOXM();
			resultNotPayCnt.setREGP_ID(loginMember.getMEMB_ID());	
			resultNotPayCnt.setORDER_CON("ORDER_CON_01");
			
			session.setAttribute("NOTPAYCNT", orderService.getObjectCount(resultNotPayCnt));
			session.setAttribute("DELICUPON", loginMember.getDLVY_CPON());
			
			//RedirectView rv = new RedirectView(strRtnUrl);
			RedirectView rv = new RedirectView();
			rv.setUrl(rtnUrl);
			rv.setExposeModelAttributes(false);
			
			return new ModelAndView(rv);
		}
		
		return mav;
	}
	
	// logout
	@RequestMapping(value="/user/logout")
	public ModelAndView userLogout(HttpServletRequest request, Model model) {
		// 기존 세션 정보 있을 시 제거
		HttpSession session = request.getSession(false);
		
		if(session != null){
			session.setAttribute("USER", null);
		}
		session.invalidate(); 
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:" + "/m");
		return mav;
	}
	
	@RequestMapping(value="/user/loginForm", method=RequestMethod.GET)
	public ModelAndView userLoginForm(@ModelAttribute TB_COMCODXD comCod, HttpServletRequest request, Model model) throws Exception {


		String rtnUrl = "";
		String rtnType = "post"; 
		System.out.println(request.getHeader("Referer"));
		if(request.getHeader("Referer").split("/m").length > 1 ) {
			rtnUrl = request.getHeader("Referer").split("/m")[1];
		}
		System.out.println("rtnUrl : " + rtnUrl + rtnUrl.equals("/user/login"));
		if( rtnUrl == "" || rtnUrl.equals("/user/login")) {
			rtnUrl = "/m";
		}else {
			rtnUrl = "/m"+rtnUrl;
			rtnType = "get";
		}
		System.out.println("rtnUrl : " + rtnUrl);
		model.addAttribute("rtnUrl", rtnUrl);
		model.addAttribute("rtnType", rtnType);
		
		
		return new ModelAndView("blankPage", "jsp", "responsiveMall/login/loginForm");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.CommonController.java
	 * @Method	: sha256
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 암호화 SHA256
	 * @Company	: YT Corp.
	 * @Author	: CHJW
	 * @Date	: 2020-03-31 (오후 02:24:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@ResponseBody
	@RequestMapping(value="/sha256",method=RequestMethod.POST)
	public String sha256(String password) throws Exception{
		digestUtils = new DigestUtils();
		String encrpytPasswd = digestUtils.kisaSha256(password);
		
		return encrpytPasswd;
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.CommonController.java
	 * @Method	: getAuth
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 이메일 인증번호 체크
	 * @Company	: YT Corp.
	 * @Author	: CHJW
	 * @Date	: 2020-04-06 (오후 04:44:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param request
	 * @param session
	 * @return String
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@ResponseBody
	@RequestMapping(value="/getAuth", method=RequestMethod.POST)
	public String getAuth(HttpServletRequest request, HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		String AuthenticationKey = (String)request.getSession().getAttribute("AuthenticationKey");
		String AuthenticationUser = request.getParameter("AuthenticationUser");
		
		if(!AuthenticationKey.equals(AuthenticationUser)) {
		    return null;
		}
		
		return AuthenticationUser;
	}
}
