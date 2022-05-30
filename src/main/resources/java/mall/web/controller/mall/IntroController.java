package mall.web.controller.mall;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

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

import mall.web.controller.DefaultController;
import mall.web.controller.admin.ProductMgrController;
import mall.web.domain.DefaultDomain;
import mall.web.domain.TB_PDINFOXM;
import mall.web.service.common.CommonService;
import mall.web.service.mall.AdService;

@Controller
public class IntroController extends DefaultController{
	private static final Logger logger = LoggerFactory.getLogger(IntroController.class);

	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="adService")
	AdService adService;

	
	@RequestMapping(value="/intro", method=RequestMethod.GET)	//이용약관
	public ModelAndView helpDesk(@ModelAttribute DefaultDomain defaultdomain,  Model model) throws Exception {

		return new ModelAndView("mallNew.layout", "jsp", "mall/intro/view");
	}
	@RequestMapping(value="/intro2", method=RequestMethod.GET)	//개인정보 보호정책
	public ModelAndView helpDesk2(@ModelAttribute DefaultDomain defaultdomain,  Model model) throws Exception {

		return new ModelAndView("mallNew.layout", "jsp", "mall/intro/view2");
	}
	@RequestMapping(value="/intro3", method=RequestMethod.GET)
	public ModelAndView helpDesk3(@ModelAttribute DefaultDomain defaultdomain,  Model model) throws Exception {

		return new ModelAndView("mallNew.layout", "jsp", "mall/intro/view3");
	}
	@RequestMapping(value="/introPicture", method=RequestMethod.GET)	//매장사진
	public ModelAndView helpDesk4(@ModelAttribute DefaultDomain defaultdomain,  Model model) throws Exception {

		return new ModelAndView("mallNew.layout", "jsp", "mall/intro/view_picture");	
	}
	
}
