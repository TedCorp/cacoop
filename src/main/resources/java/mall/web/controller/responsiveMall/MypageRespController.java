package mall.web.controller.responsiveMall;

import java.sql.SQLException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.digest.DigestUtils;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_FINDMEMBERINFO;
import mall.web.domain.TB_IPINFOXM;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_PDBORDXM;
import mall.web.service.mall.BoardService;
import mall.web.service.mall.FindMemberInfoService;
import mall.web.service.mall.MemberService;
import mall.web.service.mall.OrderService;

@Controller
@RequestMapping(value="/m/mypage")
public class MypageRespController extends DefaultController{
	
	@Resource(name="orderService")
	OrderService orderService;
	
	@Resource(name="boardService")
	BoardService boardService;
	
	@Resource(name="memberService")
	MemberService memberService;

	@Resource(name="findMemberInfoService")
	FindMemberInfoService findMemberInfoService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.MypageRespController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 마이페이지 - 개인정보
	 * @Company	: YT Corp.
	 * @Author	: HEESUN LEE (hslee@youngthink.co.kr)
	 * @Date	: 2018-04-04 (오후 2:55:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView index(@ModelAttribute TB_MBINFOXM tb_mbinfoxm, Model model, HttpServletRequest request) throws Exception {

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		if(loginUser==null){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "로그인 후 이용해주세요.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		tb_mbinfoxm.setMEMB_ID(loginUser.getMEMB_ID());
		model.addAttribute("obj", memberService.getObject(tb_mbinfoxm));
		
		return new ModelAndView("mall.responsive.layout", "jsp", "mypage/info");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.MypageRespController.java
	 * @Method	: password
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 비밀번호 변경
	 * @Company	: YT Corp.
	 * @Author	: CHJW
	 * @Date	: 2020-03-06 (오후 4:15:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/pwUpdate", method=RequestMethod.POST)
	public ModelAndView password(@ModelAttribute TB_FINDMEMBERINFO findmbinfo, HttpServletRequest request, Model model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		try {
			if(StringUtils.isNotEmpty(findmbinfo.getMEMB_ID()) && StringUtils.isNotEmpty(findmbinfo.getMEMB_PW())){
				// 비밀번호 SHA256 암호화
				DigestUtils digestUtils = new DigestUtils();
				String strEncrpytPasswd = digestUtils.kisaSha256(findmbinfo.getMEMB_PW());
				findmbinfo.setMEMB_PW(strEncrpytPasswd);
				// 임시 비밀번호 업데이트				
				findMemberInfoService.updateObject(findmbinfo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			
			mav.addObject("alertMessage", "비밀번호 변경에 실패하였습니다. 잠시후 다시 시도해주세요.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		mav.addObject("alertMessage", "비밀번호가 변경되었습니다. 다시 로그인해주세요.");
		mav.addObject("returnUrl", "/m/user/logout");
		mav.setViewName("alertMessage");
		
		return mav;
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.MypageRespController.java
	 * @Method	: orderList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 마이페이지 주문내역
	 * @Company	: YT Corp.
	 * @Author	: HEESUN LEE (hslee@youngthink.co.kr)
	 * @Date	: 2018-04-04 (오후 2:55:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/buyInfo"}, method=RequestMethod.GET)
	public ModelAndView orderList(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model, HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		if(loginUser==null){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "로그인 후 이용해주세요.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");
			
			return mav;
		}
		
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		tb_odinfoxm.setList(orderService.getObjectList(tb_odinfoxm));
		model.addAttribute("obj", tb_odinfoxm);
		
		return new ModelAndView("mall.responsive.layout", "jsp", "mypage/buyInfo");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.MypageRespController.java
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
	@RequestMapping(value="/memberUpdate", method=RequestMethod.POST)
	public ModelAndView memberInsert(@ModelAttribute TB_MBINFOXM memberInfo, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		memberInfo.setMEMB_ID(loginUser.getMEMB_ID());
		memberInfo.setREGP_ID(loginUser.getMEMB_ID());
		
		memberService.updateObject(memberInfo);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("alertMessage", "개인정보가 수정되었습니다.");
		mav.addObject("returnUrl", "/m/mypage");
		mav.setViewName("alertMessage");

		return mav;
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.MypageRespController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 마이페이지 문의답변
	 * @Company	: YT Corp.
	 * @Author	: HEESUN LEE (hslee@youngthink.co.kr)
	 * @Date	: 2018-04-05 (오후 2:55:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param listQNA
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/myQna"}, method=RequestMethod.GET)
	public ModelAndView qnaList(@ModelAttribute TB_PDBORDXM listQNA, HttpServletRequest request, Model model) throws Exception {
		
		listQNA.setBRD_GUBN("BRD_GUBN_02");
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		if(loginUser==null){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "로그인 후 이용해주세요.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");
			
			return mav;
		}

		//내 작성글
		listQNA.setWRTR_ID(loginUser.getMEMB_ID());
		listQNA.setCount(boardService.getObjectCount(listQNA));
		listQNA.setList(boardService.getBoardObjectList(listQNA));
		
		model.addAttribute("obj", listQNA);
		model.addAttribute("rowCnt", listQNA.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", listQNA.getCount());			//전체 카운트
				
		return new ModelAndView("mall.responsive.layout", "jsp", "mypage/myQna");
	}
	
	@RequestMapping(value={ "/memberLeave"}, method=RequestMethod.POST)
	public ModelAndView memberLeave(@ModelAttribute TB_IPINFOXM tb_ipinfoxm, BindingResult result, SessionStatus status, Model model) throws Exception {
		
		if (tb_ipinfoxm.getSTATE_GUBUN().equals("DELETE")) {
			//wishListService.deleteMulitObject(tb_ipinfoxm);
		}else{
			//wishListService.deleteObject(tb_ipinfoxm);
		}
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/wishList");
		
		return new ModelAndView(redirectView);
	}
	
	@RequestMapping(value={ "/buyBeforeInfo"}, method=RequestMethod.GET)
	public ModelAndView buyBeforeInfo(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model, HttpServletRequest request) throws Exception {
				
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		
		tb_odinfoxm.setORDER_CON("ORDER_CON_01");
		tb_odinfoxm.setRowCnt(100);	//페이징 단위 : 20
		tb_odinfoxm.setPagerMaxPageItems(100);	
		
		tb_odinfoxm.setList(orderService.getObjectList(tb_odinfoxm));
		model.addAttribute("obj", tb_odinfoxm);
				
		return new ModelAndView("mall.responsive.layout", "jsp", "mypage/buyBeforeInfo");
	}
}
