package mall.web.controller.responsiveMall;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.web.controller.DefaultController;
import mall.web.domain.TB_IPINFOXM;
import mall.web.domain.TB_MBINFOXM;
import mall.web.service.mall.WishListService;

@Controller
@RequestMapping(value="/m/wishList")
public class WishListRespController extends DefaultController{

	@Resource(name="wishListService")
	WishListService wishListService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.WishListController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 관심상품 리스트
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:55:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_ipinfoxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView index(@ModelAttribute TB_IPINFOXM tb_ipinfoxm, Model model, HttpServletRequest request) throws Exception {

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_ipinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		
		tb_ipinfoxm.setList(wishListService.getObjectList(tb_ipinfoxm));
		model.addAttribute("obj", tb_ipinfoxm);
		
		return new ModelAndView("mall.responsive.layout", "jsp", "wishList/list");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.WishListController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 관심상품 장바구니로 이동
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:57:09)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_ipinfoxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/{INTPD_REGNO}" , "/multi"}, method=RequestMethod.POST)
	public ModelAndView update(@ModelAttribute TB_IPINFOXM tb_ipinfoxm, BindingResult result, SessionStatus status, Model model, HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_ipinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		tb_ipinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		if (tb_ipinfoxm.getSTATE_GUBUN().equals("MOVE")) {
			wishListService.insertMultiObject(tb_ipinfoxm);
		}else{
			wishListService.insertObject(tb_ipinfoxm);
		}
		
		/*if(loginUser!=null)
			request.getSession().setAttribute("NOTPAYCNT", refreshOrder(loginUser.getMEMB_ID()));*/
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/m/wishList");
		
		return new ModelAndView(redirectView);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.WishListController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 관심상품 삭제
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:57:09)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_ipinfoxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/delete/{INTPD_REGNO}" , "/delete/multi"}, method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute TB_IPINFOXM tb_ipinfoxm, BindingResult result, SessionStatus status, Model model) throws Exception {
		
		if (tb_ipinfoxm.getSTATE_GUBUN().equals("DELETE")) {
			wishListService.deleteMulitObject(tb_ipinfoxm);
		}else{
			wishListService.deleteObject(tb_ipinfoxm);
		}
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/m/wishList");
		
		return new ModelAndView(redirectView);
	}
}
