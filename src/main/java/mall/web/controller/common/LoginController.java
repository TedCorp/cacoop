package mall.web.controller.common;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.digest.DigestUtils;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_COMCODXD;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_SYSGUSXM;
import mall.web.service.admin.impl.MemberMgrService;
import mall.web.service.common.CommonService;
import mall.web.service.mall.MemberService;
import mall.web.service.mall.OrderService;

@Controller
@RequestMapping(value="/")
public class LoginController extends DefaultController{

	@Resource(name="commonService")
	CommonService commonService;
	
	//회원관리 서비스 이용
	@Resource(name="memberMgrService")
	MemberMgrService memberMgrService;

	@Resource(name="memberService")
	MemberService memberService;
	
	@Resource(name="orderService")
	OrderService orderService;
	
	private DigestUtils digestUtils;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.CommonController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 로그인 Form
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
	@RequestMapping(value="/adm/loginForm", method=RequestMethod.GET)
	public ModelAndView loginForm(@ModelAttribute TB_COMCODXD comCod,  Model model) throws Exception {

		return new ModelAndView("blankPage", "jsp", "admin/login/loginForm");
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.CommonController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 관리자 로그인 세션처리
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
	@RequestMapping(value="/adm/login", method=RequestMethod.POST)
	public ModelAndView getLogin(@ModelAttribute TB_MBINFOXM memberInfo, Model model, HttpSession session) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		TB_MBINFOXM loginMember = (TB_MBINFOXM)memberMgrService.getObject(memberInfo);

		digestUtils = new DigestUtils();
		String strEncrpytPasswd = digestUtils.kisaSha256(memberInfo.getMEMB_PW());
		String trimEncrpytPasswd = strEncrpytPasswd.trim();
		
		/*
		 * 권한체크
		 * 관리자 : 00000000001
		 * 공급사 : 00000000002
		 * 일반회원 : 00000000003
		 * 개발사 : 00000000004
		 */
		TB_SYSGUSXM authCheck = new TB_SYSGUSXM();
		authCheck = (TB_SYSGUSXM) commonService.authGroupCheck(loginMember);
		
		if(authCheck == null || "00000000003".equals(authCheck.getGROUP_CD())) {
			mav.addObject("alertMessage", "관리자 사이트를 사용할 수 있는 계정이 아닙니다.");
			mav.addObject("returnUrl", "/adm/loginForm");
			mav.setViewName("alertMessage");
			
		}else if (!loginMember.getMEMB_PW().equals( trimEncrpytPasswd )) {
			mav.addObject("alertMessage", "아이디와 비밀번호를 확인하시기 바랍니다.");
			mav.addObject("returnUrl", "/adm/loginForm");
			mav.setViewName("alertMessage");
		} else if ("00000000002".equals(authCheck.getGROUP_CD()) && "SUPMEM_APST_03".equals(authCheck.getSUPMEM_APST())) {
			// 세션 생성
			session.setAttribute("ADMUSER",  loginMember);
			mav.setViewName("redirect:" + "/adm/orderMgr");
		} else if("00000000004".equals(authCheck.getGROUP_CD()) && "SUPMEM_APST_03".equals(authCheck.getSUPMEM_APST())){
			session.setAttribute("ADMUSER",  loginMember);
			mav.setViewName("redirect:" + "/adm/orderMgr");
		}else if ("00000000001".equals(authCheck.getGROUP_CD()) && "SUPMEM_APST_03".equals(authCheck.getSUPMEM_APST())) {
			// 세션 생성
			session.setAttribute("ADMUSER",  loginMember);
			mav.setViewName("redirect:" + "/adm/orderMgr");
		} else {
			mav.addObject("alertMessage", "관리자 사이트를 사용할 수 있는 계정이 아닙니다.");
			mav.addObject("returnUrl", "/adm/loginForm");
			mav.setViewName("alertMessage");
		}
		return mav;
	}
	
	// logout
	@RequestMapping(value="/adm/logout", method=RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, Model model) {
		ModelAndView mav = new ModelAndView();
		request.getSession().invalidate();

		mav.setViewName("redirect:" + "/adm");
		return mav;
	}
	
	
	@RequestMapping(value="/user/loginForm", method=RequestMethod.GET)
	public ModelAndView userLoginForm(@ModelAttribute TB_COMCODXD comCod,  Model model) throws Exception {

		return new ModelAndView("blankPage", "jsp", "mall/login/loginForm");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.CommonController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 유저 로그인 세션처리
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-07 (오후 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param memberInfo
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	
	@RequestMapping(value="/user/login", method=RequestMethod.POST)
	public ModelAndView getUserLogin(@ModelAttribute TB_MBINFOXM memberInfo, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		TB_MBINFOXM loginMember = (TB_MBINFOXM)memberMgrService.getObject(memberInfo);

		digestUtils = new DigestUtils();
		String strEncrpytPasswd = digestUtils.kisaSha256(memberInfo.getMEMB_PW());
		//String strEncrpytPasswd = memberInfo.getMEMB_PW();
		String trimEncrpytPasswd = strEncrpytPasswd.trim();
		
		String strRtnUrl = memberInfo.getRtnUrl();
		//System.out.println("request.getHeader('referer'); >> " + strRtnUrl);
		
		if(loginMember==null){
			mav.addObject("alertMessage", "아이디와 비밀번호를 입력해 주시기 바랍니다.");
			mav.addObject("returnUrl", "/");
			mav.setViewName("alertMessage");
			
		}else if(loginMember.getMEMB_ID()=="" || loginMember.getMEMB_PW()==""
					|| loginMember.getMEMB_ID()==null || loginMember.getMEMB_PW()==null) {
			
			mav.addObject("alertMessage", "아이디와 비밀번호를 입력해 주시기 바랍니다.");
			mav.addObject("returnUrl", "/");
			mav.setViewName("alertMessage");
			
		}else if (!loginMember.getMEMB_PW().equals( trimEncrpytPasswd )) {	//strEncrpytPasswd
			mav.addObject("alertMessage", "아이디와 비밀번호를 확인하시기 바랍니다.");
			mav.addObject("returnUrl", "/");
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
			
			if(StringUtils.isEmpty(strRtnUrl)){
				strRtnUrl = request.getHeader("referer");
			}

			// 유저 세션 생성
			session.setAttribute("USER",  loginMember);
						
			// 미결재내역  세션 생성			
			TB_ODINFOXM resultNotPayCnt= new TB_ODINFOXM();
			resultNotPayCnt.setREGP_ID(loginMember.getMEMB_ID());	
			resultNotPayCnt.setORDER_CON("ORDER_CON_01");
			
			session.setAttribute("NOTPAYCNT", orderService.getObjectCount(resultNotPayCnt));
			session.setAttribute("DELICUPON", loginMember.getDLVY_CPON());

			RedirectView rv = new RedirectView(strRtnUrl);			
			return new ModelAndView(rv);
		}
		
		return mav;
	}
		
	// logout
	@RequestMapping(value="/user/logout", method=RequestMethod.POST)
	public ModelAndView userLogout(HttpServletRequest request, Model model) {
		ModelAndView mav = new ModelAndView();
		request.getSession().invalidate();

		mav.setViewName("redirect:" + "/");
		return mav;
	}
	
	// logout
	@RequestMapping(value="/user/logout", method=RequestMethod.GET)
	public ModelAndView userLogout2(HttpServletRequest request, Model model) {
		ModelAndView mav = new ModelAndView();
		request.getSession().invalidate();

		mav.setViewName("redirect:" + "/");
		return mav;
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.CommonController.java
	 * @Method	: getAzaLogin
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 아자몰 로그인
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param memberInfo
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/aza/login", method=RequestMethod.GET)
	public ModelAndView getAzaLogin(@ModelAttribute TB_MBINFOXM memberInfo, Model model, HttpServletRequest request, HttpSession session) throws Exception {		
		//
		ModelAndView mav = new ModelAndView();
		
		// parameter setting		
		memberInfo.setMEMB_ID(request.getParameter("id"));
		memberInfo = (TB_MBINFOXM) memberService.getObject(memberInfo);
		
		try {
			if (memberInfo == null) {
				// 회원등록 안되어있다면 신규데이터 insert
				digestUtils = new DigestUtils();
				String password = digestUtils.kisaSha256(request.getParameter("id"));
				
				//System.out.println(request.getParameter("id")+ ", " +request.getParameter("name")+", " +request.getParameter("tel"));
				//System.out.println(password);
				
				TB_MBINFOXM tb_mbinfoxm = new TB_MBINFOXM();
				tb_mbinfoxm.setMEMB_ID(request.getParameter("id"));
				tb_mbinfoxm.setMEMB_PW(password);
				tb_mbinfoxm.setMEMB_NAME(request.getParameter("name"));
				tb_mbinfoxm.setMEMB_CPON(request.getParameter("tel"));
				
				tb_mbinfoxm.setSUPR_ID("C00001");							// 기업코드
				tb_mbinfoxm.setMEMB_MAIL("-");								// 이메일 (필수값)				
				tb_mbinfoxm.setMEMB_GUBN("MEMB_GUBN_01");					// 회원구분 : 개인				
				tb_mbinfoxm.setMEMB_SEX("MEMB_SEX_03");						// 성별 : 비공개
				tb_mbinfoxm.setSLCAL_GUBN("SLCAL_GUBN_01");					// 음양력 : 양력
				tb_mbinfoxm.setMEMB_BTDY("19500101");						// 생일 : 기본값
				
				tb_mbinfoxm.setMEMB_PN("00000");
				tb_mbinfoxm.setMEMB_BADR(" ");
				tb_mbinfoxm.setMEMB_DADR(" ");
				/*tb_mbinfoxm.setCOM_OPEN("");
				tb_mbinfoxm.setCOM_CLOSE("");
				tb_mbinfoxm.setKEEP_LOCATION("");
				tb_mbinfoxm.setBANK_BUNB("");
				tb_mbinfoxm.setBANK_NAME("");*/
				
				memberService.insertObject(tb_mbinfoxm);
			}
		} catch(Exception e) {
			e.printStackTrace();
			
		} finally  {
			if (memberInfo == null) {
				TB_MBINFOXM loginInfo = new TB_MBINFOXM();
				loginInfo.setMEMB_ID(request.getParameter("id"));
				memberInfo = loginInfo; 
			}
			memberInfo = (TB_MBINFOXM) memberService.getObject(memberInfo);

			if (memberInfo.getMEMB_ID()=="" || memberInfo.getMEMB_PW()==""
				|| memberInfo.getMEMB_ID()==null || memberInfo.getMEMB_PW()==null) {
				
				mav.addObject("alertMessage", "아이디와 비밀번호를 입력해 주시기 바랍니다.");
				mav.addObject("returnUrl", "/");
				mav.setViewName("alertMessage");
				
			} else if (memberInfo.getSCSS_YN().equals("Y")){
				mav.addObject("alertMessage", "탈퇴된 회원계정입니다.고객센터로 문의바랍니다.");
				mav.addObject("returnUrl", "/");
				mav.setViewName("alertMessage");
				
			} else if (memberInfo.getSTOP_YN().equals("Y")){
				mav.addObject("alertMessage", "일시중지된 회원계정입니다.고객센터로 문의바랍니다.");
				mav.addObject("returnUrl", "/");
				mav.setViewName("alertMessage");
				
			} else {
				// 유저 세션 생성
				session.setAttribute("USER",  memberInfo);
				
				// 미결재내역  세션 생성			
				TB_ODINFOXM resultNotPayCnt= new TB_ODINFOXM();
				resultNotPayCnt.setREGP_ID(memberInfo.getMEMB_ID());	
				resultNotPayCnt.setORDER_CON("ORDER_CON_01");
				
				session.setAttribute("NOTPAYCNT", orderService.getObjectCount(resultNotPayCnt));
				session.setAttribute("DELICUPON", memberInfo.getDLVY_CPON());
				
				RedirectView rv = new RedirectView("/");			
				return new ModelAndView(rv);
			}
		}
		
		return mav;
	}
}
