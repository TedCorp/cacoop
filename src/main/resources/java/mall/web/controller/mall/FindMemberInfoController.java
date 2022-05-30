package mall.web.controller.mall;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.digest.DigestUtils;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_FINDMEMBERINFO;
import mall.web.domain.TB_MBINFOXM;
import mall.web.service.admin.impl.MemberMgrService;
import mall.web.service.common.CommonService;
import mall.web.service.mall.FindMemberInfoService;
import mall.web.service.mall.OrderService;

@Controller
@RequestMapping(value="/findmemberinfo")
public class FindMemberInfoController extends DefaultController{


	@Resource(name="commonService")
	CommonService commonService;
	
	//회원관리 서비스 이용
	@Resource(name="memberMgrService")
	MemberMgrService memberMgrService;
	
	@Resource(name="orderService")
	OrderService orderService;
	
	@Resource(name="findMemberInfoService")
	FindMemberInfoService findMemberInfoService;
	
	private DigestUtils digestUtils;
	
	// - 아이디 찾기 - //
	@RequestMapping(value="/findid", method=RequestMethod.GET)
	public ModelAndView FindidForm(Model model) throws Exception {

		return new ModelAndView("blankPage", "jsp", "mall/findmemberinfo/id_find");
	}
	
	// - 아이디 찾기 결과 페이지 - //
	@RequestMapping(value="/result", method=RequestMethod.POST)
	public ModelAndView FindIdResult(@ModelAttribute TB_FINDMEMBERINFO findinfo,  Model model, HttpSession session) throws Exception {
		
		TB_FINDMEMBERINFO tb = new TB_FINDMEMBERINFO();
		
		List<TB_FINDMEMBERINFO> lst = (List<TB_FINDMEMBERINFO>) findMemberInfoService.findID(findinfo);
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("mall/findmemberinfo/result");
		mav.addObject("list", lst);
		
		return mav;
	}
	
	// - 비밀번호 찾기 - //
	@RequestMapping(value="/findpw", method=RequestMethod.GET)
	public ModelAndView FindpwForm(Model model) throws Exception {

		return new ModelAndView("blankPage", "jsp", "mall/findmemberinfo/pw_find");
	}
	
	//- 비밀번호 찾기 결과 페이지 - //
	@RequestMapping(value="/result2", method=RequestMethod.POST)
	public ModelAndView FindIdResult2(@ModelAttribute TB_FINDMEMBERINFO findinfo,  Model model, HttpSession session) throws Exception {
		
		TB_FINDMEMBERINFO tb = new TB_FINDMEMBERINFO();
		
		List<TB_FINDMEMBERINFO> lst = (List<TB_FINDMEMBERINFO>) findMemberInfoService.findPW(findinfo);
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("mall/findmemberinfo/result2");
		mav.addObject("list", lst);
		
		return mav;
	}
	
	
	
	@RequestMapping(value="/adm/login", method=RequestMethod.POST)
	public ModelAndView getLogin(@ModelAttribute TB_MBINFOXM memberInfo, Model model, HttpSession session) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		TB_MBINFOXM loginMember = (TB_MBINFOXM)memberMgrService.getObject(memberInfo);

        DigestUtils util = new DigestUtils();
		String strEncrpytPasswd = util.kisaSha256(memberInfo.getMEMB_PW());
		
        //System.out.println(strEncrpytPasswd);
		strEncrpytPasswd = memberInfo.getMEMB_PW();
		
		if (!loginMember.getMEMB_PW().equals( strEncrpytPasswd )) {
			mav.addObject("alertMessage", "아이디와 비밀번호를 확인하시기 바랍니다.");
			mav.addObject("returnUrl", "/adm/loginForm");
			mav.setViewName("alertMessage");

		} else {
			// 세션 생성
			session.setAttribute("ADMUSER",  loginMember);

			mav.setViewName("redirect:" + "/adm/main");
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
	/**
	 * @param memberInfo
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	/**
	 * @param memberInfo
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/user/login", method=RequestMethod.POST)
	public ModelAndView getUserLogin(@ModelAttribute TB_MBINFOXM memberInfo, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		TB_MBINFOXM loginMember = (TB_MBINFOXM)memberMgrService.getObject(memberInfo);

		//String strEncrpytPasswd = digestUtils.kisaSha256(memberInfo.getMEMB_PW());
		String strEncrpytPasswd = memberInfo.getMEMB_PW();
		
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
			
		}else if (!loginMember.getMEMB_PW().equals( strEncrpytPasswd )) {
			mav.addObject("alertMessage", "아이디와 비밀번호를 확인하시기 바랍니다.");
			mav.addObject("returnUrl", "/");
			mav.setViewName("alertMessage");

		} else if(loginMember.getSCSS_YN().equals("Y")){
			mav.addObject("alertMessage", "탈퇴된 회원계정입니다.고객센터로 문의바랍니다.");
			mav.addObject("returnUrl", "/");
			mav.setViewName("alertMessage");
		}else {

			if(StringUtils.isEmpty(strRtnUrl)){
				strRtnUrl = request.getHeader("referer");
			}
			
			// 유저 세션 생성
			session.setAttribute("USER",  loginMember);
			
			// 미결재내역  세션 생성
			/*
			TB_ODINFOXM resultNotPayCnt= new TB_ODINFOXM();
			resultNotPayCnt.setREGP_ID(loginMember.getMEMB_ID());	
			List<TB_ODINFOXM> notPayCnt =(List<TB_ODINFOXM>) orderService.getObjectList(resultNotPayCnt);
			int cnt = 0;
			for(int i=0; i<notPayCnt.size();i++){
				if(notPayCnt.get(i).getORDER_CON().equals("ORDER_CON_01"))
					cnt++;
			}
			session.setAttribute("NOTPAYCNT",  cnt);
			*/

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
}
