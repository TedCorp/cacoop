package mall.web.controller.mall;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.web.controller.DefaultController;
import mall.web.domain.TB_BKINFOXM;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_SPINFOXM;
import mall.web.service.admin.impl.SupplierMgrService;
import mall.web.service.mall.BasketService;

@Controller
@RequestMapping(value="/basket")
public class BasketController extends DefaultController{

	@Resource(name="basketService")
	BasketService basketService;

	@Resource(name="supplierMgrService")
	SupplierMgrService supplierMgrService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.BasketController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 장바구니 리스트
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:55:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_bkinfoxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView index(@ModelAttribute TB_BKINFOXM tb_bkinfoxm, Model model, HttpServletRequest request) throws Exception {

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		if(loginUser==null){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "로그인 후 이용해주세요.");
			//mav.addObject("returnUrl", "back");
			mav.addObject("returnUrl", "/user/loginForm");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		tb_bkinfoxm.setREGP_ID(loginUser.getMEMB_ID());		
		tb_bkinfoxm.setList(basketService.getObjectList(tb_bkinfoxm));
		model.addAttribute("obj", tb_bkinfoxm);
		
		//배송비 조건
		TB_SPINFOXM supplierInfo = new TB_SPINFOXM();
		supplierInfo.setSUPR_ID("C00001");
		model.addAttribute("supplierInfo", (TB_SPINFOXM)supplierMgrService.getObject(supplierInfo));
				
		//request.getSession().setAttribute("NOTPAYCNT", refreshOrder(loginUser.getMEMB_ID()));
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/basket/list");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.BasketController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 장바구니 장바구니로 이동
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:57:09)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_bkinfoxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/{INTPD_REGNO}" , "/multi"}, method=RequestMethod.POST)
	public ModelAndView update(@ModelAttribute TB_BKINFOXM tb_bkinfoxm, BindingResult result, SessionStatus status, Model model, HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		tb_bkinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		tb_bkinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		if (tb_bkinfoxm.getSTATE_GUBUN().equals("MOVE")) {
			basketService.insertMultiObject(tb_bkinfoxm);
		}else{
			basketService.insertObject(tb_bkinfoxm);
		}
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/basket");		
		return new ModelAndView(redirectView);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.BasketController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 장바구니 삭제
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:57:09)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_bkinfoxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/delete/{INTPD_REGNO}" , "/delete/multi"}, method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute TB_BKINFOXM tb_bkinfoxm, BindingResult result, SessionStatus status, Model model) throws Exception {
		
		if (tb_bkinfoxm.getSTATE_GUBUN().equals("DELETE")) {
			basketService.deleteMulitObject(tb_bkinfoxm);
		}else{
			basketService.deleteObject(tb_bkinfoxm);
		}
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/basket");		
		return new ModelAndView(redirectView);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.BasketController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 장바구니 수량변경
	 * @Company	: YT Corp.
	 * @Author	: HEESUN-LEE (hslee@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:57:09)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_bkinfoxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/qtyUpdate",method=RequestMethod.GET)
	public void pickingUpdate(TB_BKINFOXM tb_bkinfoxm, Model model, @RequestParam(value="CHK_BSKT") String chkBskt, @RequestParam(value="PD_QTY") String pdQty) throws Exception{
		//주문상태 및 결제 정보 수정
		tb_bkinfoxm.setPD_QTY(pdQty);
		tb_bkinfoxm.setBSKT_REGNO(chkBskt);
	
		basketService.updateObject(tb_bkinfoxm);
	
		//orderMgrService.updatePickingList(pickingList); foreach쓸때..
	}
}
