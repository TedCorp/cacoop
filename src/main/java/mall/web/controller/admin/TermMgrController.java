package mall.web.controller.admin;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.web.controller.DefaultController;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_TMINFOXM;
import mall.web.service.admin.impl.TermMgrService;

@Controller
@RequestMapping(value="/adm")
public class TermMgrController extends DefaultController{

	private static final Logger logger = LoggerFactory.getLogger(TermMgrController.class);

	@Resource(name="termMgrService")
	TermMgrService termMgrService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.TermMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 약관관리 - 회원약관, 개인정보취급방침
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
	@RequestMapping(value="/termMgr", method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_TMINFOXM termInfo, Model model) throws Exception {

		termInfo.setTERM_GUBN("TERM_GUBN_01");		// TERM_GUBN_01-회원약관,    TERM_GUBN_02-개인정보취급방침
		model.addAttribute("termInfo1", (TB_TMINFOXM)termMgrService.getObject(termInfo));
		
		termInfo.setTERM_GUBN("TERM_GUBN_02");		// TERM_GUBN_01-회원약관,    TERM_GUBN_02-개인정보취급방침
		model.addAttribute("termInfo2", (TB_TMINFOXM)termMgrService.getObject(termInfo));
		
		return new ModelAndView("admin.layout", "jsp", "admin/termMgr/form");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.TermMgrController.java
	 * @Method	: insert
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 약관관리 등록
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-07 (오후 11:05:15)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param memberInfo
	 * @param request
	 * @param model
	 * @return String
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/termMgr",method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute TB_TMINFOXM termInfo, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		termInfo.setREGP_ID(loginUser.getMEMB_ID());

		termInfo.setTERM_GUBN("TERM_GUBN_01");
		termInfo.setTERM_CONT(termInfo.getTERM_CONT1());		//회원약관 

		if( StringUtils.isNotEmpty(termInfo.getTERM_GUBN1()) ){
			termMgrService.updateObject(termInfo);
		}else{
			termMgrService.insertObject(termInfo);
		}
		
		termInfo.setTERM_GUBN("TERM_GUBN_02");
		termInfo.setTERM_CONT(termInfo.getTERM_CONT2());		//개인정보취급방침
		if( StringUtils.isNotEmpty(termInfo.getTERM_GUBN2()) ){
			termMgrService.updateObject(termInfo);
		}else{
			termMgrService.insertObject(termInfo);
		}

		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/termMgr"));
		return new ModelAndView(rv);
	}

	
}
