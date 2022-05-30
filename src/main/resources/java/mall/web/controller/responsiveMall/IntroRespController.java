package mall.web.controller.responsiveMall;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import mall.web.controller.DefaultController;
import mall.web.domain.DefaultDomain;
import mall.web.service.common.CommonService;
import mall.web.service.mall.AdService;

@Controller
public class IntroRespController extends DefaultController{
	private static final Logger logger = LoggerFactory.getLogger(IntroRespController.class);

	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="adService")
	AdService adService;

	@RequestMapping(value="/m/intro", method=RequestMethod.GET)	//회사소개
	public ModelAndView helpDesk(@ModelAttribute DefaultDomain defaultdomain,  Model model) throws Exception {

		return new ModelAndView("mall.responsive.layout", "jsp", "intro/view");
	}
	@RequestMapping(value="/m/intro2", method=RequestMethod.GET)	//개인정보 보호정책
	public ModelAndView helpDesk2(@ModelAttribute DefaultDomain defaultdomain,  Model model) throws Exception {

		return new ModelAndView("mall.responsive.layout", "jsp", "intro/view2");
	}
	@RequestMapping(value="/m/intro3", method=RequestMethod.GET)	//이메일
	public ModelAndView helpDesk3(@ModelAttribute DefaultDomain defaultdomain,  Model model) throws Exception {

		return new ModelAndView("mall.responsive.layout", "jsp", "intro/view3");
	}
	@RequestMapping(value="/m/intro4", method=RequestMethod.GET)	//이용약관
	public ModelAndView helpDesk5(@ModelAttribute DefaultDomain defaultdomain,  Model model) throws Exception {

		return new ModelAndView("mall.responsive.layout", "jsp", "intro/termUse");
	}
	@RequestMapping(value="/m/introPicture", method=RequestMethod.GET)	//매장사진
	public ModelAndView helpDesk4(@ModelAttribute DefaultDomain defaultdomain,  Model model) throws Exception {

		return new ModelAndView("mall.responsive.layout", "jsp", "intro/view_picture");	
	}
	
}
