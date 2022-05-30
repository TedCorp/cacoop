package mall.web.controller.mall;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import mall.web.service.mall.BoardService;
import mall.web.service.mall.OrderService;
import mall.web.service.mall.ProductService;

@Controller
@RequestMapping(value="/board")
public class BoardController extends DefaultController{

	@Resource(name="boardService")
	BoardService boardService;
	
	@Resource(name="productService")
	ProductService productService;
	
	/* 구매후기 팝업 폼 */
	
	@RequestMapping(value={ "/review/popup" }, method=RequestMethod.GET)
	public ModelAndView productReview(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_pdbordxm.setREGP_ID(loginUser.getMEMB_ID());
		
		return new ModelAndView("popup.layout", "jsp", "mall/board/review");
	}
	
	
	/* 구매후기 팝업 처리 */
	
	@RequestMapping(value={ "/review/popup" }, method=RequestMethod.POST)
	public ModelAndView reviewInsert(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_pdbordxm.setREGP_ID(loginUser.getMEMB_ID());
		
		request.getParameter("PD_CODE");
		request.getParameter("BRD_NUM");
		request.getParameter("BRD_GUBN");
		request.getParameter("WRTR_ID");
		request.getParameter("WRT_DTM");
		request.getParameter("PD_PTS");
		request.getParameter("BRD_SBJT");
		request.getParameter("BRD_CONT");
		
		tb_pdbordxm.setBRD_GUBN("BRD_GUBN_03");
		boardService.reviewInsert(tb_pdbordxm);

		model.addAttribute("flag", "true");
		
		return new ModelAndView("popup.layout", "jsp", "mall/board/review");
	}
	
	
	/* 상품문의 팝업 폼 */
	
	@RequestMapping(value={ "/ask/popup" }, method=RequestMethod.GET)
	public ModelAndView productQna(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_pdbordxm.setREGP_ID(loginUser.getMEMB_ID());
		
		
		return new ModelAndView("popup.layout", "jsp", "mall/board/ask");
	}
	
	
	/* 상품문의 팝업 처리 */
	
	@RequestMapping(value={ "/ask/popup" }, method=RequestMethod.POST)
	public ModelAndView qnaInsert(@ModelAttribute TB_PDBORDXM tb_pdbordxm, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		/*tb_pdbordxm.setREGP_ID(loginUser.getMEMB_ID());*/

		
		// 로그인여부 (2019.02.25/ chjw)
		if(loginUser == null){
			ModelAndView mav = new ModelAndView();			
			mav.addObject("returnUrl", "/user/loginForm");
			
			return mav;
		}else{
			tb_pdbordxm.setREGP_ID(loginUser.getMEMB_ID());			
		}				
				
		// null처리		
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
		
		request.getParameter("PD_CODE");
		request.getParameter("BRD_NUM");
		request.getParameter("BRD_GUBN");
		if(request.getParameter("WRTR_ID")!= null)
			request.getParameter("WRTR_ID");
		if(request.getParameter("WRT_DTM")!= null)
			request.getParameter("WRT_DTM");
		request.getParameter("BRD_SBJT");
		request.getParameter("BRD_CONT");
		if(request.getParameter("SCWT_YN")!=null)
			request.getParameter("SCWT_YN");
		request.getParameter("BRD_PW");
				
		
		tb_pdbordxm.setBRD_GUBN(request.getParameter("BRD_GUBN"));
		boardService.qnaInsert(tb_pdbordxm);

		model.addAttribute("flag", "true");
		
		
		RedirectView rv = null;
		if(request.getParameter("BRD_GUBN").equals("BRD_GUBN_03"))
			rv = new RedirectView(servletContextPath.concat("/community/orderReturnList"));
		else
			rv =new RedirectView(servletContextPath.concat("/community/qnaList"));
		
		return new ModelAndView(rv);
//		return new ModelAndView("popup.layout", "jsp", "mall/board/ask");
	}
	
	
	
}
