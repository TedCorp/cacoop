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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.digest.DigestUtils;
import mall.common.util.FileUtil;
import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_BKINFOXM;
import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_COMCODXD;
import mall.web.domain.TB_FINDMEMBERINFO;
import mall.web.domain.TB_IPINFOXM;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_PDBORDXM;
import mall.web.domain.TB_PDCOMMXM;
import mall.web.service.mall.BasketService;
import mall.web.service.mall.BoardService;
import mall.web.service.mall.FindMemberInfoService;
import mall.web.service.mall.MemberService;
import mall.web.service.mall.OrderService;
import mall.web.service.common.CommonService;

@Controller
@RequestMapping(value="/m/mypage")
public class MypageRespController extends DefaultController{
	
	@Resource(name="orderService")
	OrderService orderService;
	
	@Resource(name="boardService")
	BoardService boardService;
	
	@Resource(name="basketService")
	BasketService basketService;
	
	@Resource(name="memberService")
	MemberService memberService;

	@Resource(name="findMemberInfoService")
	FindMemberInfoService findMemberInfoService;
	
	@Resource(name="commonService")
	CommonService commonService;
	
	private DigestUtils digestUtils;
	
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
	public ModelAndView index(@ModelAttribute TB_ODINFOXM tb_odinfoxm,
							  @ModelAttribute TB_BKINFOXM tb_bkinfoxm,
							  Model model, HttpServletRequest request) throws Exception {

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		
		if(loginUser==null){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "로그인 후 이용해주세요.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		tb_odinfoxm.setList(orderService.getObjectOrderList(tb_odinfoxm));
		model.addAttribute("obj", tb_odinfoxm);
		
		
		tb_bkinfoxm.setREGP_ID(loginUser.getMEMB_ID());		
		tb_bkinfoxm.setList(basketService.getObjectList(tb_bkinfoxm));
		model.addAttribute("obj2", tb_bkinfoxm);
		
		return new ModelAndView("mall.responsive.layout", "jsp", "mypage/mypage");
	}
	
	/* 회원정보 수정 전 비밀번호 체크 */
	@RequestMapping(value="/pwChk", method=RequestMethod.POST)
	public @ResponseBody String pwCheck(@ModelAttribute TB_MBINFOXM memberInfo) throws Exception {
		
		digestUtils = new DigestUtils();
		String strEncrpytPasswd = digestUtils.kisaSha256(memberInfo.getMEMB_PW());
		String trimEncrpytPasswd = strEncrpytPasswd.trim();
		memberInfo.setMEMB_PW(trimEncrpytPasswd);
		
		System.out.println("입력 비번 : " + trimEncrpytPasswd);
		
		int pwCnt = memberService.pwCheck(memberInfo);
		
		return pwCnt + "";
	}
	
	/* 회원정보 수정1 JSP 추가 - 이유리 */
	@RequestMapping(value="/info", method=RequestMethod.GET)
	public ModelAndView mypageInfo(@ModelAttribute TB_MBINFOXM memberInfo, Model model,
			 						HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		model.addAttribute("MEMB_NAME", loginUser.getMEMB_NAME());
		
		return new ModelAndView("mall.responsive.layout", "jsp", "mypage/info");
	}
	
	/* 회원정보 수정2 JSP 추가 - 이유리 */
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public ModelAndView joinSuccess(@ModelAttribute TB_MBINFOXM tb_mbinfoxm, Model model, HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		tb_mbinfoxm.setMEMB_ID(loginUser.getMEMB_ID());
		model.addAttribute("obj", memberService.getObject(tb_mbinfoxm));
		
		return new ModelAndView("mall.responsive.layout", "jsp", "mypage/infoDetail");
	}
	

	/* 상품리뷰 JSP 추가 - 이유리 */
	@RequestMapping(value="/review", method=RequestMethod.GET)
	public ModelAndView review(@ModelAttribute TB_ODINFOXM tb_odinfoxm, Model model, HttpServletRequest request) throws Exception {
		// 로그인 체크
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");

		if(loginUser == null){			
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "로그인 후 이용해주세요.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");
			return mav;			
		}else{
			
			/* 구매확정된 상품만 불러옴 */
			tb_odinfoxm.setREGP_ID(loginUser.getMEMB_ID());
			//tb_odinfoxm.setCount(orderService.getConfirmedObjectCount(tb_odinfoxm));			
			tb_odinfoxm.setList(orderService.getConfirmedObjectList(tb_odinfoxm));
			//tb_odinfoxm.setList(orderService.getObjectWishList(tb_odinfoxm));
			
			model.addAttribute("obj", tb_odinfoxm);
		
			return new ModelAndView("mall.responsive.layout", "jsp", "mypage/review");
		}
	}
	
	/* 상품리뷰작성 JSP 추가 - 이유리 */
	@RequestMapping(value="/review/{ORDER_NUM}/{PD_CODE}", method=RequestMethod.POST)
	public ModelAndView reviewWrite(@ModelAttribute TB_PDCOMMXM tb_pdcommxm,
									String PD_NAME, String ORDER_DATE, Model model, HttpServletRequest request) throws Exception {
		
		
		System.out.println("나는 리뷰작성 입니다. ");
		
		
		// 로그인 체크
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		if(loginUser == null){			
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "로그인 후 이용해주세요.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");

			return mav;			
		}else{
			
			tb_pdcommxm.setREGP_ID(loginUser.getMEMB_ID());
			TB_PDCOMMXM obj = (TB_PDCOMMXM)orderService.getReviewObject(tb_pdcommxm);
			
			model.addAttribute("tb_pdcommxm", tb_pdcommxm);
			model.addAttribute("PD_NAME", PD_NAME);
			model.addAttribute("ORDER_DATE", ORDER_DATE);
			model.addAttribute("obj", obj);
			
			return new ModelAndView("mall.responsive.layout", "jsp", "mypage/reviewWrite");
		}
	}
	
	/* 리뷰 저장 - 이유리 */
	@RequestMapping(value="/review/save", method=RequestMethod.POST)
	public ModelAndView saveReview(@ModelAttribute TB_PDCOMMXM tb_pdcommxm,
			 					 @ModelAttribute TB_COATFLXD comFile, Model model, HttpServletRequest request, 
			 					 MultipartHttpServletRequest multipartRequest, MultipartFile multipartFile) throws Exception {
		// 로그인 체크
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		//첨부파일이 두개 이상일 경우 객체하나씩 추가
		/*
		TB_COATFLXD comDtlFile = new TB_COATFLXD();
		comDtlFile.setATFL_ID(tb_pdcommxm.getDTL_ATFL_ID()); 
		comDtlFile.setREGP_ID(loginUser.getMEMB_ID());
		*/
		
		// 리뷰 수정
		if(StringUtils.isNotEmpty(tb_pdcommxm.getBRD_NUM())){
			System.out.println("&&&&&&&여기가 수정");
			
			tb_pdcommxm.setMODP_ID(loginUser.getMEMB_ID());
			
			if(StringUtils.isNotEmpty(tb_pdcommxm.getFILE_NM())) {
				comFile.setMODP_ID(loginUser.getMEMB_ID());
				comFile.setATFL_ID(tb_pdcommxm.getATFL_ID());
				comFile.setATFL_SEQ("1");
				
				orderService.updateFile(comFile, request, multipartRequest, "reviewFile", "review", false);
				tb_pdcommxm.setATFL_ID(comFile.getATFL_ID());
			}
			
			orderService.updateReviewObject(tb_pdcommxm);
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "리뷰가 수정되었습니다.");
			mav.setViewName("alertMessage");
		// 리뷰 신규 등록
		}else{
			System.out.println("&&&&&&&여기가 등록");
			
			tb_pdcommxm.setREGP_ID(loginUser.getMEMB_ID());
			
			//첨부파일 처리
			if(StringUtils.isNotEmpty(tb_pdcommxm.getFILE_NM())) {
				comFile.setREGP_ID(loginUser.getMEMB_ID());
				String strATFL_ID = commonService.saveFile(comFile, request, multipartRequest, "reviewFile", "review", false);
				//String strDTL_ATFL_ID = commonService.saveFile(comDtlFile, request, multipartRequest, "fileDtl", "product", false);
				tb_pdcommxm.setATFL_ID(strATFL_ID);
			}
			
			orderService.insertReviewObject(tb_pdcommxm);
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "리뷰가 등록되었습니다.");
			mav.setViewName("alertMessage");
		}
		
		String strRtrUrl = "/m/mypage/review";
		
		RedirectView rv = new RedirectView(servletContextPath.concat(strRtrUrl));
		return new ModelAndView(rv);
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
		
		digestUtils = new DigestUtils();
		String strEncrpytPasswd = digestUtils.kisaSha256(memberInfo.getMEMB_PW());
		String trimEncrpytPasswd = strEncrpytPasswd.trim();
		memberInfo.setMEMB_PW(trimEncrpytPasswd);
		memberService.updateObject(memberInfo);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("alertMessage", "개인정보가 수정되었습니다.");
//		mav.addObject("returnUrl", "/m/mypage");
		mav.addObject("returnUrl", "/m/mypage/detail");
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
