package mall.web.controller.admin;


import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.web.controller.DefaultController;
import mall.web.domain.TB_DELIVERY_ADDR;
import mall.web.domain.TB_MBINFOXM;
import mall.web.service.admin.impl.DeliveryAddrMgrService;

@Controller
@RequestMapping(value="/adm/deliveryAddrMgr")
public class DeliveryAddrMgrController extends DefaultController{
	
	private static final Logger logger = LoggerFactory.getLogger(DeliveryAddrMgrController.class);
	
	@Resource(name="deliveryAddrMgrService")
	DeliveryAddrMgrService deliveryAddrMgrService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.DeliveryAddrMgrController.java
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주소리스트
	 * @Company	: ted
	 * @Author	: jangbora
	 * @Date	: 2021-01-06
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_DELIVERY_ADDR tb_delivery_addr, HttpServletRequest request, Model model )throws Exception {
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_delivery_addr.setSUPR_ID(loginUser.getSUPR_ID());
		
		//페이징 단위
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_delivery_addr.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			tb_delivery_addr.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_delivery_addr.setRowCnt(10);
			tb_delivery_addr.setPagerMaxPageItems(10);
		}

		tb_delivery_addr.setCount(deliveryAddrMgrService.getObjectCount(tb_delivery_addr));
		tb_delivery_addr.setList(deliveryAddrMgrService.getPaginatedObjectList(tb_delivery_addr));
		
		model.addAttribute("obj", tb_delivery_addr);
		model.addAttribute("rowCnt", tb_delivery_addr.getRowCnt());
		model.addAttribute("totalCnt", tb_delivery_addr.getCount());
		return new ModelAndView("popup.layout", "jsp", "admin/supplierMgr/popup");
	}

	@RequestMapping(value={"/productMgr"},method = RequestMethod.GET)
	public ModelAndView getListProductMgr(@ModelAttribute TB_DELIVERY_ADDR tb_delivery_addr, HttpServletRequest request, Model model )throws Exception {
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_delivery_addr.setSUPR_ID(loginUser.getSUPR_ID());
		
		//페이징 단위
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_delivery_addr.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			tb_delivery_addr.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_delivery_addr.setRowCnt(10);
			tb_delivery_addr.setPagerMaxPageItems(10);
		}

		tb_delivery_addr.setCount(deliveryAddrMgrService.getObjectCount(tb_delivery_addr));
		tb_delivery_addr.setList(deliveryAddrMgrService.getPaginatedObjectList(tb_delivery_addr));
		
		model.addAttribute("obj", tb_delivery_addr);
		model.addAttribute("rowCnt", tb_delivery_addr.getRowCnt());
		model.addAttribute("totalCnt", tb_delivery_addr.getCount());
		return new ModelAndView("popup.layout", "jsp", "admin/productMgr/deliveryPopup");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.DeliveryAddrMgrController.java
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주소입력창/상세보기
	 * @Company	: ted
	 * @Author	: jangbora
	 * @Date	: 2021-01-06
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={"/insert", "/{ADD_NUM}"}, method = RequestMethod.GET)
	public ModelAndView view(@ModelAttribute TB_DELIVERY_ADDR tb_delivery_addr, HttpServletRequest request, Model model)throws Exception {
	
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_delivery_addr.setSUPR_ID(loginUser.getSUPR_ID());
			
		if(StringUtils.isNotEmpty(tb_delivery_addr.getADD_NUM())){
			TB_DELIVERY_ADDR tda=(TB_DELIVERY_ADDR)deliveryAddrMgrService.getObject(tb_delivery_addr);
			model.addAttribute("tb_delivery_addr",tda);
		}

		model.addAttribute("loginUser",tb_delivery_addr);
		return new ModelAndView("popup.layout", "jsp", "admin/supplierMgr/popupinsert");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.DeliveryAddrMgrController.java
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주소입력
	 * @Company	: ted
	 * @Author	: jangbora
	 * @Date	: 2021-01-06
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={"/insert"}, method = RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute TB_DELIVERY_ADDR tb_delivery_addr, HttpServletRequest request, Model model)throws Exception {
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_delivery_addr.setREGP_ID(loginUser.getMEMB_ID());
		
		deliveryAddrMgrService.insertObject(tb_delivery_addr);
		RedirectView rv = new RedirectView(servletContextPath + "/adm/deliveryAddrMgr");
		return new ModelAndView(rv); 
	}
	
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.DeliveryAddrMgrController.java
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주소업데이트
	 * @Company	: ted
	 * @Author	: jangbora
	 * @Date	: 2021-01-06
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={"/update"}, method = RequestMethod.POST)
	public ModelAndView update(@ModelAttribute TB_DELIVERY_ADDR tb_delivery_addr, HttpServletRequest request, Model model)throws Exception {
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_delivery_addr.setMODP_ID(loginUser.getMEMB_ID());
		
		
		deliveryAddrMgrService.updateObject(tb_delivery_addr);
		
		RedirectView rv = new RedirectView(servletContextPath + "/adm/deliveryAddrMgr");
		return new ModelAndView(rv); 
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param convert1 
	 * @Class	: mall.web.controller.admin.DeliveryAddrMgrController.java
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주소삭제
	 * @Company	: ted
	 * @Author	: jangbora
	 * @Date	: 2021-01-06
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@ResponseBody
	@RequestMapping(value={"/delete"}, method = RequestMethod.POST)
	public String delete(@ModelAttribute TB_DELIVERY_ADDR tb_delivery_addr, @RequestParam String ADD_NUM, HttpServletRequest request, Model model, String convert1)throws Exception {
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_delivery_addr.setREGP_ID(loginUser.getMEMB_ID());
		tb_delivery_addr.setADD_NUM(ADD_NUM);
		int useNum=deliveryAddrMgrService.useCount(tb_delivery_addr);
		String message ="";
		if ( useNum == 0 ) {
			message ="success";
			deliveryAddrMgrService.deleteObject(tb_delivery_addr);
		}else {
		   message ="false";
		}
		return message;
	}
	
	
	

}
