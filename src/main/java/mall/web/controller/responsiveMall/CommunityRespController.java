package mall.web.controller.responsiveMall;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_PDBORDXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.service.common.CommonService;
import mall.web.service.mall.BoardService;
import mall.web.service.mall.OrderService;
import mall.web.service.mall.ProductService;

@Controller
@RequestMapping(value="/m/community")
public class CommunityRespController extends DefaultController{

	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="boardService")
	BoardService boardService;
	
	@Resource(name="productService")
	ProductService productService;
	
	@Resource(name="orderService")
	OrderService orderService;
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.CommunityRespController.java
	 * @Method	: preview
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 고객센터 (커뮤니티)
	 * @Company	: YT Corp.
	 * @Author	: CHJW
	 * @Date	: 2020-02-27 16:38:00
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_pdbordxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@SuppressWarnings("unchecked")
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView preview(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, Model model) throws Exception {		
		// 공지사항
		
		/*
		* TB_PDBORDXM notice = new TB_PDBORDXM();
		* notice.setBRD_GUBN("BRD_GUBN_05");
		* notice.setRowCnt(10);
		* List<TB_PDBORDXM> notices = (List<TB_PDBORDXM>) boardService.getPaginatedObjectList(notice);
		* model.addAttribute("notice", notices);
		*/
		
		tb_pdbordxm.setRowCnt(10);
		tb_pdbordxm.setPagerMaxPageItems(10);
		tb_pdbordxm.setBRD_GUBN("BRD_GUBN_05");
		tb_pdbordxm.setCount(boardService.getObjectCount(tb_pdbordxm));
		tb_pdbordxm.setList(boardService.getPaginatedObjectList(tb_pdbordxm));
		
		model.addAttribute("tb_pdbordxm", tb_pdbordxm);
		
		
		/*
		 * // 상품문의 TB_PDBORDXM qna = new TB_PDBORDXM(); qna.setBRD_GUBN("BRD_GUBN_02");
		 * qna.setRowCnt(5); List<TB_PDBORDXM> qnas = (List<TB_PDBORDXM>)
		 * boardService.getPaginatedObjectList(qna); model.addAttribute("qna", qnas);
		 * 
		 * // 반품문의 TB_PDBORDXM review = new TB_PDBORDXM();
		 * review.setBRD_GUBN("BRD_GUBN_03"); review.setRowCnt(5); List<TB_PDBORDXM>
		 * reviews = (List<TB_PDBORDXM>) boardService.getPaginatedObjectList(review);
		 * model.addAttribute("review", reviews);
		 */
		return new ModelAndView("mall.responsive.layout", "jsp", "community/service");
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.CommunityRespController.java
	 * @Method	: listNotice
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 공지사항 목록
	 * @Company	: YT Corp.
	 * @Author	: CHJW
	 * @Date	: 2020-02-27 16:38:00
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_pdbordxm
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/noticeList", method=RequestMethod.GET)
	public ModelAndView listNotice(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, Model model) throws Exception {
		tb_pdbordxm.setRowCnt(10);
		tb_pdbordxm.setPagerMaxPageItems(10);
		tb_pdbordxm.setBRD_GUBN("BRD_GUBN_05");
		tb_pdbordxm.setCount(boardService.getObjectCount(tb_pdbordxm));
		tb_pdbordxm.setList(boardService.getPaginatedObjectList(tb_pdbordxm));
		
		model.addAttribute("tb_pdbordxm", tb_pdbordxm);

		return new ModelAndView("mall.responsive.layout", "jsp", "community/notice");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.CommunityRespController.java
	 * @Method	: viewNotice
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 공지사항 상세보기
	 * @Company	: YT Corp.
	 * @Author	: CHJW
	 * @Date	: 2020-02-27 16:38:00
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_pdbordxm
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/noticeView/{BRD_GUBN}/{BRD_NUM}", method=RequestMethod.GET)
	public ModelAndView viewNotice(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, Model model) throws Exception {
		
		tb_pdbordxm.setBRD_NUM(tb_pdbordxm.getBRD_NUM());
		tb_pdbordxm.setBRD_GUBN("BRD_GUBN_05");
		tb_pdbordxm = (TB_PDBORDXM) boardService.getObject(tb_pdbordxm);
		
		model.addAttribute("tb_pdbordxm", tb_pdbordxm);
		
		return new ModelAndView("mall.responsive.layout", "jsp", "community/board");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.CommunityRespController.java
	 * @Method	: listFAQ
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 자주묻는 질문(FAQ) 목록
	 * @Company	: YT Corp.
	 * @Author	: CHJW
	 * @Date	: 2020-02-27 16:38:00
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_pdbordxm
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/faqList", method=RequestMethod.GET)
	public ModelAndView listFAQ(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, Model model) throws Exception {
	
		tb_pdbordxm.setBRD_GUBN("BRD_GUBN_04");
		tb_pdbordxm.setRowCnt(9999);
		tb_pdbordxm.setCount(boardService.getObjectCount(tb_pdbordxm));
		tb_pdbordxm.setList(boardService.getBoardObjectList(tb_pdbordxm));
		
		model.addAttribute("obj", tb_pdbordxm);
		model.addAttribute("rowCnt", tb_pdbordxm.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", tb_pdbordxm.getCount());			//전체 카운트

		return new ModelAndView("mall.responsive.layout", "jsp", "community/listFaq");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.CommunityRespController.java
	 * @Method	: bordList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 1:1문의 목록
	 * @Company	: YT Corp.
	 * @Author	: CHJW
	 * @Date	: 2020-02-27 16:38:00
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_pdbordxm
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={"/list"}, method=RequestMethod.GET)
	public ModelAndView bordList(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, HttpSession session, Model model) throws Exception {
		TB_MBINFOXM loginMember = (TB_MBINFOXM) session.getAttribute("USER");
		// 로그인 체크
		if(loginMember == null){
			ModelAndView mav = new ModelAndView();				
			mav.addObject("alertMessage", "로그인을 해주세요.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");
			return mav;
		}
				
		// 정보
		tb_pdbordxm.setRowCnt(10);
		tb_pdbordxm.setPagerMaxPageItems(10);
		tb_pdbordxm.setWRTR_ID(loginMember.getMEMB_ID());
		
		tb_pdbordxm.setCount(boardService.getObjectCount(tb_pdbordxm));
		tb_pdbordxm.setList(boardService.getPaginatedObjectList(tb_pdbordxm));
		
		model.addAttribute("tb_pdbordxm", tb_pdbordxm);
		
		return new ModelAndView("mall.responsive.layout", "jsp", "community/list");
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.CommunityRespController.java
	 * @Method	: bordView
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 1:1문의 상세보기
	 * @Company	: YT Corp.
	 * @Author	: CHJW
	 * @Date	: 2020-02-27 16:38:00
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_pdbordxm
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/view/{BRD_GUBN}/{BRD_NUM}", method=RequestMethod.GET)
	public ModelAndView bordView(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, HttpSession session, Model model) throws Exception {
		TB_MBINFOXM loginMember = (TB_MBINFOXM) session.getAttribute("USER");
		// 로그인 체크
		if(loginMember == null){
			ModelAndView mav = new ModelAndView();				
			mav.addObject("alertMessage", "로그인을 해주세요.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		// 유저의 문의글 모음
		tb_pdbordxm.setWRTR_ID(loginMember.getMEMB_ID());
		tb_pdbordxm.setBRD_NUM(tb_pdbordxm.getBRD_NUM());
		tb_pdbordxm = (TB_PDBORDXM) boardService.getObject(tb_pdbordxm);

		model.addAttribute("tb_pdbordxm", tb_pdbordxm);
		
		// 작성자 체크
		if(!loginMember.getMEMB_ID().equals(tb_pdbordxm.getWRTR_ID())){
			ModelAndView mav = new ModelAndView();				
			mav.addObject("alertMessage", "문의글은 작성자만 볼 수 있습니다.");
			mav.addObject("returnUrl", "/m/community/list");
			mav.setViewName("alertMessage");			
			return mav;
		}
		
		return new ModelAndView("mall.responsive.layout", "jsp", "community/view");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.CommunityRespController.java
	 * @Method	: bordEdit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 1:1문의 등록 및 수정
	 * @Company	: YT Corp.
	 * @Author	: CHJW
	 * @Date	: 2020-02-27 16:38:00
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_pdbordxm
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/new", method=RequestMethod.GET)
	public ModelAndView bordNew(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, HttpSession session, Model model) throws Exception {
		TB_MBINFOXM loginMember = (TB_MBINFOXM) session.getAttribute("USER");
		// 로그인 체크
		if(loginMember == null){
			ModelAndView mav = new ModelAndView();				
			mav.addObject("alertMessage", "로그인을 해주세요.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");
			return mav;
		}

		// 작성자 기본정보
		tb_pdbordxm.setWRTR_ID(loginMember.getMEMB_ID());
		tb_pdbordxm.setWRTR_NM(loginMember.getMEMB_NAME());
		tb_pdbordxm.setMEMB_MAIL(loginMember.getMEMB_MAIL());
		tb_pdbordxm.setMEMB_CPON(loginMember.getMEMB_CPON());
		model.addAttribute("tb_pdbordxm", tb_pdbordxm);
		
		return new ModelAndView("mall.responsive.layout", "jsp", "community/form");
	}
	
	@RequestMapping(value={"/edit"}, method=RequestMethod.GET)
	public ModelAndView bordEdit(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, HttpSession session, Model model) throws Exception {
		TB_MBINFOXM loginMember = (TB_MBINFOXM) session.getAttribute("USER");
		// 로그인 체크
		if(loginMember == null){
			ModelAndView mav = new ModelAndView();				
			mav.addObject("alertMessage", "로그인을 해주세요.");
			mav.addObject("returnUrl", "/m/user/loginForm");
			mav.setViewName("alertMessage");
			return mav;
		}

		// 작성자 체크
		if(!loginMember.getMEMB_ID().equals(tb_pdbordxm.getWRTR_ID())){
			ModelAndView mav = new ModelAndView();				
			mav.addObject("alertMessage", "문의글은 작성자만 볼 수 있습니다.");
			mav.addObject("returnUrl", "/m/community/list");
			mav.setViewName("alertMessage");			
			return mav;
		}
		
		// 유저의 문의글 모음
		tb_pdbordxm.setWRTR_ID(loginMember.getMEMB_ID());
		tb_pdbordxm.setBRD_NUM(tb_pdbordxm.getBRD_NUM());
		tb_pdbordxm = (TB_PDBORDXM) boardService.getObject(tb_pdbordxm);
		
		model.addAttribute("tb_pdbordxm", tb_pdbordxm);
		
		return new ModelAndView("mall.responsive.layout", "jsp", "community/form");
	}
	
	@RequestMapping(value="/edit", method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, Model model) throws Exception {
		
		try{
			int obj = boardService.insertObject(tb_pdbordxm);
        }catch(SQLException e){
        	ModelAndView mav = new ModelAndView();			
			mav.addObject("alertMessage", e.getStackTrace()+"\n문의글 등록에 실패하였습니다. 같은 상황이 지속된다면 관리자에게 문의바랍니다.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");
			return mav;
        }
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/m/community/list"));
		return new ModelAndView(rv);
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.responsiveMall.CommunityRespController.java
	 * @Method	: delete
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 1:1문의 삭제
	 * @Company	: YT Corp.
	 * @Author	: CHJW
	 * @Date	: 2020-02-27 16:38:00
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_pdbordxm
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, Model model) throws Exception {
		
		try{
			int obj = boardService.deleteObject(tb_pdbordxm);
        }catch(SQLException e){
        	ModelAndView mav = new ModelAndView();			
			mav.addObject("alertMessage", e.getStackTrace()+"\n문의글 삭제에 실패하였습니다. 같은 상황이 지속된다면 관리자에게 문의바랍니다.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");
			return mav;
        }
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/m/community/list"));
		return new ModelAndView(rv);
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.CommunityRespController.java
	 * @Method	: ordpop
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문번호 팝업
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-20 (오후 4:42:49)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_sysmnuxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/ordpop"}, method=RequestMethod.GET)
	public @ResponseBody TB_PDBORDXM ordpop(@ModelAttribute TB_PDBORDXM tb_pdbordxm, Model model, HttpServletRequest request) throws Exception {	
		//
		TB_ODINFOXM tb_odinfoxm = new TB_ODINFOXM();
		
		tb_odinfoxm.setRowCnt(100);	
		tb_odinfoxm.setPagerMaxPageItems(100);
		tb_odinfoxm.setORDER_NUM(tb_pdbordxm.getORDER_NUM());
		tb_odinfoxm.setREGP_ID(tb_pdbordxm.getWRTR_ID());
		
		tb_pdbordxm.setCount(orderService.getObjectCount(tb_odinfoxm));			
		tb_pdbordxm.setList(orderService.getObjectList(tb_odinfoxm));		
		
		return tb_pdbordxm;
	}


	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.CommunityRespController.java
	 * @Method	: pdpop
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문상품 팝업
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-20 (오후 4:42:49)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_sysmnuxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/pdpop"}, method=RequestMethod.GET)
	public @ResponseBody TB_ODINFOXM pdpop(@ModelAttribute TB_PDBORDXM tb_pdbordxm, Model model, HttpServletRequest request) throws Exception {	
		//
		TB_ODINFOXM tb_odinfoxm = new TB_ODINFOXM();
		
		tb_odinfoxm.setORDER_NUM(tb_pdbordxm.getORDER_NUM());
		tb_odinfoxm.setREGP_ID(tb_pdbordxm.getWRTR_ID());
		
		tb_odinfoxm.setCount(orderService.getObjectCount(tb_odinfoxm));			
		tb_odinfoxm.setList(orderService.getDetailsList(tb_odinfoxm));		
		
		return tb_odinfoxm;
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.CommunityRespController.java
	 * @Method	: popup
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품 팝업 (사용안함)
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-20 (오후 4:42:49)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_sysmnuxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/popup"}, method=RequestMethod.GET)
	public @ResponseBody TB_PDINFOXM popup(@ModelAttribute TB_PDBORDXM tb_pdbordxm, Model model, HttpServletRequest request) throws Exception {	
		//
		TB_PDINFOXM tb_pdinfoxm = new TB_PDINFOXM();
		tb_pdinfoxm.setRowCnt(999);
		tb_pdinfoxm.setPagerMaxPageItems(999);
		
		//결과내 재검색 X
		List schTxt_befList = Arrays.asList(tb_pdbordxm.getSchTxt());
		tb_pdinfoxm.setSchTxt_befList(schTxt_befList);			// 기본 검색어 만 List
		tb_pdinfoxm.setSchTxt_bef(tb_pdbordxm.getSchTxt());	// 기본 검색어를 이전 검색어 hidden 데이터로 반영
		
		tb_pdinfoxm.setCount(productService.getObjectCount(tb_pdinfoxm));			
		tb_pdinfoxm.setList(productService.getPaginatedObjectList(tb_pdinfoxm));		
		
		return tb_pdinfoxm;
	}
}
