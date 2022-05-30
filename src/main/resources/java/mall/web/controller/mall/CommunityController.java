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
@RequestMapping(value="/community")
public class CommunityController extends DefaultController{

	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="boardService")
	BoardService boardService;
	
	@Resource(name="productService")
	ProductService productService;
	
	@Resource(name="orderService")
	OrderService orderService;
	
	
	/* 커뮤니티 리스트 */
	
	@SuppressWarnings("unchecked")
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView preview(@ModelAttribute TB_PDBORDXM tb_pdbordxm, Model model) throws Exception {
		
		// 공지사항 받아오기
		TB_PDBORDXM notice = new TB_PDBORDXM();
		notice.setBRD_GUBN("BRD_GUBN_05");
		notice.setRowCnt(5);
		List<TB_PDBORDXM> notices = (List<TB_PDBORDXM>) boardService.getBoardObjectList(notice);
		model.addAttribute("notice", notices);
		
		// FAQ 받아오기
		TB_PDBORDXM faq = new TB_PDBORDXM();
		faq.setBRD_GUBN("BRD_GUBN_04");
		faq.setRowCnt(5);
		List<TB_PDBORDXM> faqs = (List<TB_PDBORDXM>) boardService.getBoardObjectList(faq);
		model.addAttribute("faq", faqs);
		
		// 상품문의 받아오기
		TB_PDBORDXM qna = new TB_PDBORDXM();
		qna.setBRD_GUBN("BRD_GUBN_02");
		qna.setRowCnt(5);
		List<TB_PDBORDXM> qnas = (List<TB_PDBORDXM>) boardService.getBoardObjectList(qna);
		model.addAttribute("qna", qnas);
		
/*		// 구매후기 받아오기
		TB_PDBORDXM review = new TB_PDBORDXM();
		review.setBRD_GUBN("BRD_GUBN_03");
		review.setRowCnt(5);
		List<TB_PDBORDXM> reviews = (List<TB_PDBORDXM>) productService.getBoardList(review);
		model.addAttribute("review", reviews);*/
		
		// 반품문의 받아오기
		TB_PDBORDXM review = new TB_PDBORDXM();
		review.setBRD_GUBN("BRD_GUBN_03");
		review.setRowCnt(5);
		List<TB_PDBORDXM> reviews = (List<TB_PDBORDXM>) boardService.getBoardObjectList(review);
		model.addAttribute("review", reviews);
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/community/list");
	}
	
	
	/* 공지사항 list */
	
	@RequestMapping(value="/noticeList", method=RequestMethod.GET)
	public ModelAndView listNotice(@ModelAttribute TB_PDBORDXM listNotice, HttpServletRequest request, Model model) throws Exception {
	
		listNotice.setBRD_GUBN("BRD_GUBN_05");

		listNotice.setCount(boardService.getObjectCount(listNotice));
		listNotice.setList(boardService.getBoardObjectList(listNotice));
		
		model.addAttribute("obj", listNotice);
		model.addAttribute("rowCnt", listNotice.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", listNotice.getCount());			//전체 카운트

		return new ModelAndView("mallNew.layout", "jsp", "mall/community/list/notice");

	}
	
	
	
	/* 공지사항 상세페이지 */
	
	@RequestMapping(value="/notice/detail", method=RequestMethod.GET)
	public ModelAndView viewNotice(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, Model model) throws Exception {
		
		TB_PDBORDXM detailNotice = new TB_PDBORDXM();
		detailNotice.setBRD_NUM(tb_pdbordxm.getBRD_NUM());
		detailNotice.setBRD_GUBN("BRD_GUBN_05");
		model.addAttribute("detailNotice", boardService.getRevQnaObject(detailNotice));
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/community/viewNotice");
	}

	
	/* FAQ list */
	
	@RequestMapping(value="/faqList", method=RequestMethod.GET)
	public ModelAndView listFAQ(@ModelAttribute TB_PDBORDXM listFAQ, HttpServletRequest request, Model model) throws Exception {
	
		listFAQ.setBRD_GUBN("BRD_GUBN_04");

		listFAQ.setCount(boardService.getObjectCount(listFAQ));
		listFAQ.setList(boardService.getBoardObjectList(listFAQ));
		
		model.addAttribute("obj", listFAQ);
		model.addAttribute("rowCnt", listFAQ.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", listFAQ.getCount());			//전체 카운트

		return new ModelAndView("mallNew.layout", "jsp", "mall/community/list/faq");

	}
	
	/* FAQ 상세페이지 */
	
	@RequestMapping(value="/faq/detail", method=RequestMethod.GET)
	public ModelAndView viewFAQ(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, Model model) throws Exception {
		
		TB_PDBORDXM detailFAQ = new TB_PDBORDXM();
		detailFAQ.setBRD_NUM(tb_pdbordxm.getBRD_NUM());
		detailFAQ.setBRD_GUBN("BRD_GUBN_04");
		model.addAttribute("detailFAQ", boardService.getRevQnaObject(detailFAQ));
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/community/viewFAQ");
	}
	
	
	/* QNA list */
	
	@RequestMapping(value="/qnaList", method=RequestMethod.GET)
	public ModelAndView listQNA(@ModelAttribute TB_PDBORDXM listQNA, HttpServletRequest request, Model model) throws Exception {
	
		//TB_PDBORDXM listQNA = new TB_PDBORDXM();
		listQNA.setBRD_GUBN("BRD_GUBN_02");

		// listQNA.setRowCnt(5);

		listQNA.setCount(boardService.getObjectCount(listQNA));
		listQNA.setList(boardService.getBoardObjectList(listQNA));
		
		model.addAttribute("obj", listQNA);
		model.addAttribute("rowCnt", listQNA.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", listQNA.getCount());			//전체 카운트
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/community/list/qna");

	}
	
	
	
	/* QNA 상세페이지 */
	
	@RequestMapping(value="/qna/detail/view", method=RequestMethod.GET)
	public ModelAndView viewQna(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, HttpSession session, Model model) throws Exception {
		
		TB_PDBORDXM detailQna = new TB_PDBORDXM();		
		detailQna.setBRD_NUM(tb_pdbordxm.getBRD_NUM());		
		detailQna.setBRD_GUBN("BRD_GUBN_02");	
		detailQna = (TB_PDBORDXM) boardService.getRevQnaObject(detailQna);
		model.addAttribute("detailQna", detailQna);	
		
		//System.out.println(detailQna.getSCWT_YN());
		
		TB_MBINFOXM loginMember = (TB_MBINFOXM) session.getAttribute("USER");
		
		if(detailQna != null && StringUtils.isNotBlank(detailQna.getBRD_PW())){
			if(!loginMember.getMEMB_ID().equals(detailQna.getWRTR_ID())){
//				RedirectView rv = new RedirectView();					
//				rv.setUrl(request.getContextPath() + "/community");		
//				rv.setExposeModelAttributes(false);	
//				return new ModelAndView(rv);
//				
				ModelAndView mav = new ModelAndView();
				
				mav.addObject("alertMessage", "비밀글은 작성자만 볼 수 있습니다.");
				mav.addObject("returnUrl", "/community/qnaList");
				mav.setViewName("alertMessage");
				
				return mav;
			}
		}
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/community/viewQna"); 
		
	}
	
	
	/* QNA 수정 폼 */
	@RequestMapping(value="/qna/detail", method=RequestMethod.GET)
	public ModelAndView qnaDetail(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, HttpSession session, Model model) throws Exception {
		
		TB_PDBORDXM detailQna = new TB_PDBORDXM();	
		
		if(request.getParameter("BRD_NUM")!=null && request.getParameter("BRD_NUM")!=""){
			detailQna.setBRD_NUM(tb_pdbordxm.getBRD_NUM());
			detailQna.setBRD_GUBN("BRD_GUBN_02");
			detailQna = (TB_PDBORDXM) boardService.getRevQnaObject(detailQna);	
			
		}else{
			detailQna.setBRD_NUM("");
			detailQna.setBRD_GUBN("");
			
		}
		
		model.addAttribute("detailQna", detailQna);	
		
		TB_MBINFOXM loginMember = (TB_MBINFOXM) session.getAttribute("USER");

		// 로그인여부
		if(loginMember == null){			
			ModelAndView mav = new ModelAndView();
			
			mav.addObject("alertMessage", "로그인이 필요합니다.");
			mav.addObject("returnUrl", "/user/loginForm");
			mav.setViewName("alertMessage");
			
			return mav;			
		}
		
		if(detailQna != null && StringUtils.isNotBlank(detailQna.getBRD_PW())){
			if(!loginMember.getMEMB_ID().equals(detailQna.getWRTR_ID())){
//				RedirectView rv = new RedirectView();					
//				rv.setUrl(request.getContextPath() + "/community");		
//				rv.setExposeModelAttributes(false);	
//				return new ModelAndView(rv);
//				
				ModelAndView mav = new ModelAndView();
				
				mav.addObject("alertMessage", "작성자만 수정할 수 있습니다.");
				mav.addObject("returnUrl", "/community/qnaList");
				mav.setViewName("alertMessage");
				
				return mav;
			}
		}		
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/community/formQna");
	}
	
	
	/* QNA 수정 */
	
	@RequestMapping(value="/qna/detail", method=RequestMethod.POST)
	public ModelAndView updateQna(@ModelAttribute TB_PDBORDXM tb_pdbordxm, TB_PDINFOXM productInfo, HttpServletRequest request, Model model) throws Exception {
		
		TB_PDBORDXM detailQna = new TB_PDBORDXM();
		
		// 비밀번호 확인 (2019.02.25 / chjw)
		if(detailQna != null && StringUtils.isNotBlank(request.getParameter("BRD_BFPW"))){
			if(request.getParameter("SCWT_YN")!=null & request.getParameter("SCWT_YN")!="" && request.getParameter("SCWT_YN").equals("Y")){ 	
				
				if(!request.getParameter("BRD_BFPW").equals(request.getParameter("BRD_PW"))){					
					ModelAndView mav2 = new ModelAndView();
					
					mav2.addObject("alertMessage", "비밀번호를 확인해주세요.");
					mav2.addObject("returnUrl", "/community/qna/detail?BRD_NUM="+request.getParameter("BRD_NUM"));
					mav2.setViewName("alertMessage");
					
					return mav2;
				}				
			}
		}

		if(StringUtils.isNotBlank(request.getParameter("SCWT_YN"))){
			if(request.getParameter("SCWT_YN") != null && request.getParameter("SCWT_YN")!="" && request.getParameter("SCWT_YN").equals("Y")){
				tb_pdbordxm.setSCWT_YN("Y");
				tb_pdbordxm.setBRD_PW(request.getParameter("BRD_PW"));
			}else{
				tb_pdbordxm.setSCWT_YN("N");
				tb_pdbordxm.setBRD_PW("");
			}
		}else{
			tb_pdbordxm.setSCWT_YN("N");
			tb_pdbordxm.setBRD_PW("");
		}
		
		//
		tb_pdbordxm.setBRD_GUBN("BRD_GUBN_02");
		tb_pdbordxm.setREGP_ID("user"); 
		boardService.updateObjectQna(tb_pdbordxm);
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/community/qna/detail/view?BRD_NUM=" + tb_pdbordxm.getBRD_NUM()));
		return new ModelAndView(rv);
	}
	
	
	/* 반품문의 list */
	
	@RequestMapping(value="/orderReturnList", method=RequestMethod.GET)
	public ModelAndView listOrderReturn(@ModelAttribute TB_PDBORDXM listOrderReturn, HttpServletRequest request, Model model) throws Exception {
	
		//TB_PDBORDXM listOrderReturn = new TB_PDBORDXM();
		listOrderReturn.setBRD_GUBN("BRD_GUBN_03");

		// listQNA.setRowCnt(5);

		listOrderReturn.setCount(boardService.getObjectCount(listOrderReturn));
		listOrderReturn.setList(boardService.getBoardObjectList(listOrderReturn));
		
		model.addAttribute("obj", listOrderReturn);
		model.addAttribute("rowCnt", listOrderReturn.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", listOrderReturn.getCount());			//전체 카운트
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/community/list/order_return");

	}
	
	/* 반품문의 상세페이지 */
	
	@RequestMapping(value="/orderReturn/detail/view", method=RequestMethod.GET)
	public ModelAndView viewOrderReturn(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, HttpSession session, Model model) throws Exception {
		
		TB_PDBORDXM detailOrderReturn = new TB_PDBORDXM();		
		detailOrderReturn.setBRD_NUM(tb_pdbordxm.getBRD_NUM());		
		detailOrderReturn.setBRD_GUBN("BRD_GUBN_03");	
		detailOrderReturn = (TB_PDBORDXM) boardService.getRevQnaObject(detailOrderReturn);
		model.addAttribute("detailOrderReturn", detailOrderReturn);	
		
		TB_MBINFOXM loginMember = (TB_MBINFOXM) session.getAttribute("USER");
		
		if(detailOrderReturn != null && StringUtils.isNotBlank(detailOrderReturn.getBRD_PW())){
			if(!loginMember.getMEMB_ID().equals(detailOrderReturn.getWRTR_ID())){
//				RedirectView rv = new RedirectView();					
//				rv.setUrl(request.getContextPath() + "/community");		
//				rv.setExposeModelAttributes(false);	
//				return new ModelAndView(rv);
//				
				ModelAndView mav = new ModelAndView();
				
				mav.addObject("alertMessage", "비밀글은 작성자만 볼 수 있습니다.");
				mav.addObject("returnUrl", "/community/orderReturnList");
				mav.setViewName("alertMessage");
				
				return mav;
			}
		}
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/community/viewOrderReturn"); 
		
	}
	
	/* 반품문의 수정 폼 */
	@RequestMapping(value="/orderReturn/detail", method=RequestMethod.GET)
	public ModelAndView orderReturnDetail(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, HttpSession session, Model model) throws Exception {
		
		TB_PDBORDXM detailOrderReturn = new TB_PDBORDXM();
		
		if(request.getParameter("BRD_NUM")!=null && request.getParameter("BRD_NUM")!=""){
			detailOrderReturn.setBRD_NUM(tb_pdbordxm.getBRD_NUM());
			detailOrderReturn.setBRD_GUBN("BRD_GUBN_03");
			detailOrderReturn = (TB_PDBORDXM) boardService.getRevQnaObject(detailOrderReturn);	
			
		}else{
			detailOrderReturn.setBRD_NUM("");
			detailOrderReturn.setBRD_GUBN("");
			
		}
		
		model.addAttribute("detailOrderReturn", detailOrderReturn);	
		
		TB_MBINFOXM loginMember = (TB_MBINFOXM) session.getAttribute("USER");
		
		if(detailOrderReturn != null && StringUtils.isNotBlank(detailOrderReturn.getBRD_PW())){
			if(!loginMember.getMEMB_ID().equals(detailOrderReturn.getWRTR_ID())){
//				RedirectView rv = new RedirectView();					
//				rv.setUrl(request.getContextPath() + "/community");		
//				rv.setExposeModelAttributes(false);	
//				return new ModelAndView(rv);
//				
				ModelAndView mav = new ModelAndView();
				
				mav.addObject("alertMessage", "작성자만 수정할 수 있습니다.");
				mav.addObject("returnUrl", "/community/orderReturnList");
				mav.setViewName("alertMessage");
				
				return mav;
			}
		}		
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/community/formOrderReturn");
	}
	
	
	/* 반품문의 수정 */
	
	@RequestMapping(value="/orderReturn/detail", method=RequestMethod.POST)
	public ModelAndView updateOrderReturn(@ModelAttribute TB_PDBORDXM tb_pdbordxm, TB_PDINFOXM productInfo, HttpServletRequest request, Model model) throws Exception {
		
		TB_PDBORDXM detailQnaReturn = new TB_PDBORDXM();
		
		//System.out.println(request.getParameter("SCWT_YN"));
		 
		// 비밀번호 확인 (2019.02.25/ chjw)
		if(detailQnaReturn != null && StringUtils.isNotBlank(request.getParameter("BRD_BFPW"))){
			if(request.getParameter("SCWT_YN")!=null & request.getParameter("SCWT_YN")!="" && request.getParameter("SCWT_YN").equals("Y")){ 	
				
				if(!request.getParameter("BRD_BFPW").equals(request.getParameter("BRD_PW"))){					
					ModelAndView mav2 = new ModelAndView();
					
					mav2.addObject("alertMessage", "비밀번호를 확인해주세요.");
					mav2.addObject("returnUrl", "/community/orderReturn/detail?BRD_NUM="+request.getParameter("BRD_NUM"));
					mav2.setViewName("alertMessage");
					
					return mav2;
				}				
			}
		}

		if(StringUtils.isNotBlank(request.getParameter("SCWT_YN"))){
			if(request.getParameter("SCWT_YN") != null && request.getParameter("SCWT_YN")!="" && request.getParameter("SCWT_YN").equals("Y")){
				tb_pdbordxm.setSCWT_YN("Y");
				tb_pdbordxm.setBRD_PW(request.getParameter("BRD_PW"));
			}else{
				tb_pdbordxm.setSCWT_YN("N");
				tb_pdbordxm.setBRD_PW("");
			}
		}else{
			tb_pdbordxm.setSCWT_YN("N");
			tb_pdbordxm.setBRD_PW("");
		}
				
		tb_pdbordxm.setBRD_GUBN("BRD_GUBN_03");
		tb_pdbordxm.setREGP_ID("user"); 
		boardService.updateObjectQna(tb_pdbordxm);
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/community/orderReturn/detail/view?BRD_NUM=" + tb_pdbordxm.getBRD_NUM()));
		return new ModelAndView(rv);
	}
	
	
	
	
	/* 구매후기 list */
	
	@RequestMapping(value="/reviewList", method=RequestMethod.GET)
	public ModelAndView listReview(@ModelAttribute TB_PDBORDXM listReview, HttpServletRequest request, Model model) throws Exception {
	
		listReview.setBRD_GUBN("BRD_GUBN_03");

		listReview.setCount(boardService.getObjectCount(listReview));
		listReview.setList(boardService.getBoardObjectList(listReview));
		
		model.addAttribute("obj", listReview);
		model.addAttribute("rowCnt", listReview.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", listReview.getCount());			//전체 카운트

		return new ModelAndView("mallNew.layout", "jsp", "mall/community/list/review");

	}
	
	
	
	/* 구매후기 상세페이지 */
	
	@RequestMapping(value="/review/detail/view", method=RequestMethod.GET)
	public ModelAndView viewRev(@ModelAttribute TB_PDBORDXM tb_pdbordxm, TB_ODINFOXM tb_odinfoxm, HttpSession session, Model model) throws Exception {
		
		TB_PDBORDXM detailReview = new TB_PDBORDXM();
		detailReview.setBRD_NUM(tb_pdbordxm.getBRD_NUM());
		detailReview.setBRD_GUBN("BRD_GUBN_03");
		
		//주문자만 후기수정
		TB_ODINFOXM orderInfo = new TB_ODINFOXM();
		orderInfo.setORDER_CON("ORDER_CON_08");
		orderInfo.setPD_CODE(tb_odinfoxm.getPD_CODE());
		
		int cnt = 0;
		if(StringUtils.isNotEmpty(orderInfo.getREGP_ID())){
			cnt = orderService.orderCnt(orderInfo);
		}

		//model.addAttribute("cnt", cnt);
		model.addAttribute("detailRev", boardService.getRevQnaObject(detailReview));
		
		
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/community/viewRev");
	}
	
	
	/* 구매후기 수정 폼 */
	
	@RequestMapping(value="/review/detail", method=RequestMethod.GET)
	public ModelAndView reviewDetail(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, HttpSession session, Model model) throws Exception {
		
		TB_PDBORDXM detailReview = new TB_PDBORDXM();
		detailReview.setBRD_NUM(tb_pdbordxm.getBRD_NUM());
		detailReview.setBRD_GUBN("BRD_GUBN_03");
		model.addAttribute("detailRev", boardService.getRevQnaObject(detailReview));
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/community/formRev");
	}
	
	
	/* 구매후기 수정 */
	
	@RequestMapping(value="/review/detail", method=RequestMethod.POST)
	public ModelAndView updateReview(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, Model model) throws Exception {
		
		tb_pdbordxm.setBRD_GUBN("BRD_GUBN_03");
		tb_pdbordxm.setREGP_ID("user"); 
		boardService.updateObjectReview(tb_pdbordxm);
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/community/review/detail/view?BRD_NUM=" + tb_pdbordxm.getBRD_NUM()));
		return new ModelAndView(rv);
		
	}
	
}
