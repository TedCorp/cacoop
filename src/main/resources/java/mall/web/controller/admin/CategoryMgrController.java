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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.web.controller.DefaultController;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_PDCAGOXM;
import mall.web.service.admin.impl.CategoryMgrService;

@Controller
@RequestMapping(value="/adm/categoryMgr")
public class CategoryMgrController extends DefaultController{

	private static final Logger logger = LoggerFactory.getLogger(CategoryMgrController.class);

	@Resource(name="categoryMgrService")
	CategoryMgrService categoryMgrService;
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.CategoryMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 카테고리 트리용 조회
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
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_PDCAGOXM category, Model model) throws Exception {
			

		category.setList(categoryMgrService.getObjectList(category));
		model.addAttribute("obj", category);

		return new ModelAndView("admin.layout", "jsp", "admin/categoryMgr/list");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.CategoryMgrController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 카테고리 상세조회
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
	@RequestMapping(value={ "/view/{CAGO_ID}"}, method=RequestMethod.GET)
	public ModelAndView view(@ModelAttribute TB_PDCAGOXM category, Model model) throws Exception {
		
		model.addAttribute("category", (TB_PDCAGOXM)categoryMgrService.getObject(category));
		
		return new ModelAndView("admin.layout", "jsp", "admin/categoryMgr/form");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.CategoryMgrController.java
	 * @Method	: insert
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 카테고리 등록/수정
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-07 (오후 11:05:15)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param category
	 * @param request
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute TB_PDCAGOXM category, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		category.setREGP_ID(loginUser.getMEMB_ID());		

		//System.out.println(category.getSORT_ORDR());
		
		int nRtn = 0;
		if(StringUtils.isNotEmpty(category.getCAGO_ID())){
			nRtn = categoryMgrService.updateObject(category);
		}else{
			nRtn = categoryMgrService.insertObject(category);
		}
		
		model.addAttribute("category", category);
		
		//리다이렉트 안시키고 다시 조회함
		TB_PDCAGOXM rtnCategory = new TB_PDCAGOXM();
		rtnCategory.setList(categoryMgrService.getObjectList(rtnCategory));
		model.addAttribute("obj", rtnCategory);

		return new ModelAndView("admin.layout", "jsp", "admin/categoryMgr/list");
	}	

	
	@RequestMapping(value="/deleteChk", method=RequestMethod.POST)
	public @ResponseBody String deleteChk(@ModelAttribute TB_PDCAGOXM category) throws Exception {
		int nCateCnt = categoryMgrService.getObjectCount(category);
		return nCateCnt+"";
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.CategoryMgrController.java
	 * @Method	: insert
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 카테고리 삭제
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-07 (오후 11:05:15)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param category
	 * @param request
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/delete"}, method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute TB_PDCAGOXM category, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		category.setREGP_ID(loginUser.getMEMB_ID());		

		int nRtn = 0;
		nRtn = categoryMgrService.deleteObject(category);
		
		//alertMessage
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("alertMessage", "아이디와 비밀번호를 확인하시기 바랍니다.");
//		mav.addObject("returnUrl", "/adm/categoryMgr");
//		mav.setViewName("alertMessage");
//		return mav;
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/categoryMgr"));
		return new ModelAndView(rv);
	}
}
