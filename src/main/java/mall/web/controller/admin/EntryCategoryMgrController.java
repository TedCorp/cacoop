package mall.web.controller.admin;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import mall.web.domain.TB_ENTRYCAGOXD;
import mall.web.domain.TB_ENTRYCAGOXM;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDRCMDXM;
import mall.web.service.admin.impl.EntryCategoryMgrService;
import mall.web.service.common.CommonService;

@Controller
@RequestMapping(value="/adm/entryCategoryMgr")
public class EntryCategoryMgrController extends DefaultController{

	private static final Logger logger = LoggerFactory.getLogger(EntryCategoryMgrController.class);

	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="entryCategoryMgrService")
	EntryCategoryMgrService entryCategoryMgrService;
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 2020-03-30
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_PDRCMDXM tb_pdrcmdxm, Model model) throws Exception {
		
		
		@SuppressWarnings("unchecked")
		List<TB_ENTRYCAGOXM> list = (List<TB_ENTRYCAGOXM>) (entryCategoryMgrService.getEntrycagoList());
		model.addAttribute("obj", list);
		
		return new ModelAndView("admin.layout", "jsp", "admin/entryCategoryMgr/list");		
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 추천상품관리 상세(form)
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-08 (오전 9:31:25)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/{ENTRY_ID}", "/new"}, method=RequestMethod.GET)
	public ModelAndView view(@ModelAttribute TB_ENTRYCAGOXM tb_entrycagoxm, @ModelAttribute TB_PDINFOXM tb_pdinfoxm, Model model, HttpServletRequest request) throws Exception {
				
		if(tb_entrycagoxm.getENTRY_ID() == null)
			return new ModelAndView("admin.layout", "jsp", "admin/entryCategoryMgr/form");
		
		TB_ENTRYCAGOXM entCagoInfo = entryCategoryMgrService.getEntrycago(tb_entrycagoxm.getENTRY_ID());		
		
		model.addAttribute("entCagoInfo", entCagoInfo);
		
		return new ModelAndView("admin.layout", "jsp", "admin/entryCategoryMgr/form");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: 
	 * @Method	: insert
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 2020-03-31
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param productInfo
	 * @param request
	 * @param model
	 * @param multipartRequest
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute TB_ENTRYCAGOXM tb_entrycagoxm, @ModelAttribute TB_ENTRYCAGOXD tb_entrycagoxd
			, HttpServletRequest request, Model model) throws Exception {
				
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_entrycagoxm.setREGP_ID(loginUser.getMEMB_ID()); 
		tb_entrycagoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		entryCategoryMgrService.insertEntryCagoxm(tb_entrycagoxm);		//insert				
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/entryCategoryMgr");
		
		return new ModelAndView(redirectView);
	}	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: 
	 * @Method	: update04
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 2020-03-31
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param 
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/{ENTRY_ID}" }, method=RequestMethod.PUT)
	public ModelAndView update(@ModelAttribute TB_ENTRYCAGOXM tb_entrycagoxm, @ModelAttribute TB_ENTRYCAGOXD tb_entrycagoxd
			, BindingResult result, SessionStatus status, Model model,HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_entrycagoxm.setREGP_ID(loginUser.getMEMB_ID()); 
		tb_entrycagoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		entryCategoryMgrService.updateEntryCagoxm(tb_entrycagoxm);		// 진입카테고리 UPDATE
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/entryCategoryMgr/"+tb_entrycagoxm.getENTRY_ID());
		
		return new ModelAndView(redirectView);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: delete
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 진입카테고리삭제
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 2020-03-31
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_pdrcmdxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/delete/{ENTRY_ID}" }, method=RequestMethod.PUT)
	public ModelAndView delete(@ModelAttribute TB_ENTRYCAGOXM tb_entrycagoxm, @ModelAttribute TB_ENTRYCAGOXD tb_entrycagoxd
			, BindingResult result, SessionStatus status, Model model,HttpServletRequest request) throws Exception {
		
		tb_entrycagoxm.getENTRY_ID();
		
		entryCategoryMgrService.deleteEntryCagoxm(tb_entrycagoxm.getENTRY_ID());
		entryCategoryMgrService.deleteEntryCagoxd(tb_entrycagoxm.getENTRY_ID());
		
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/entryCategoryMgr/");
		
		return new ModelAndView(redirectView);
	}
	
	
	
	
}
