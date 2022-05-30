package mall.web.controller.admin;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
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

import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_SPINFOXM;
import mall.web.service.admin.impl.MemberMgrService;
import mall.web.service.admin.impl.SupplierMgrService;

@Controller
@RequestMapping(value="/adm")
public class SupplierMbrMgrController extends DefaultController{
	private static final Logger logger = LoggerFactory.getLogger(SupplierMbrMgrController.class);

	@Resource(name="supplierMgrService")
	SupplierMgrService supplierMgrService;
	
	@Resource(name="memberMgrService")
	MemberMgrService memberMgrService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.SupplierMbrMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 기업회원목록 조회
	 * @Company	: YT Corp.
	 * @Author	: Seok-min Jeon (smjeon@youngthink.co.kr)
	 * @Date	: 2016-07-12 (오후 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/supplierMbrMgr", method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_MBINFOXM memberInfo, TB_SPINFOXM supplierInfo, Model model) throws Exception {
		
		TB_SPINFOXM spinfoxm = new TB_SPINFOXM();		
		spinfoxm.setSUPR_ID(memberInfo.getSUPR_ID());
		
		List<TB_SPINFOXM> splist = (List<TB_SPINFOXM>) supplierMgrService.getObjectList(spinfoxm);
		
		memberInfo.setMEMB_GUBN("MEMB_GUBN_02");	//MEMB_GUBN_01-일반회원, MEMB_GUBN_02-기업회원,  MEMB_GUBN_03-시스템관리자
		memberInfo.setSCSS_YN("N");					//Y-탈퇴회원, N-정상회원
		memberInfo.setCount(memberMgrService.getObjectCount(memberInfo));
		memberInfo.setList(memberMgrService.getPaginatedObjectList(memberInfo)); 
		
		model.addAttribute("obj", memberInfo);
		model.addAttribute("splist", splist);	
		model.addAttribute("rowCnt", memberInfo.getRowCnt());
		model.addAttribute("totalCnt", memberInfo.getCount());
		
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(supplierInfo.getSchGbn())+
				  "&schTxt="+StringUtil.nullCheck(supplierInfo.getSchTxt());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/supplierMbrMgr/list");				
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.SupplierMbrMgrController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 회원정보 등록/변경을 위한 정보 조회(form)
	 * @Company	: YT Corp.
	 * @Author	: Seok-min Jeon (smjeon@youngthink.co.kr)
	 * @Date	: 2016-07-12 (오후 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/supplierMbrMgr/edit/{SUPR_ID}", "/new" }, method=RequestMethod.GET)
	public ModelAndView edit(@ModelAttribute TB_SPINFOXM supplierInfo, TB_MBINFOXM memberInfo, Model model) throws Exception {
		
		if(StringUtils.isNotEmpty(supplierInfo.getSUPR_ID())){												
			model.addAttribute("supplierInfo", (TB_SPINFOXM)supplierMgrService.getObject(supplierInfo));    
		}

		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(supplierInfo.getSchGbn())+
				  "&schTxt="+StringUtil.nullCheck(supplierInfo.getSchTxt());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/supplierMbrMgr/form");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.SuppierMgrController.java
	 * @Method	: insert
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 기업회원정보 등록
	 * @Company	: YT Corp.
	 * @Author	: Seok-min Jeon (smjeon@youngthink.co.kr)
	 * @Date	: 2016-07-12 (오후 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param supplierInfo
	 * @param result
	 * @param status
	 * @param model
	 * @return String
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/supplierMbrMgr", method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute TB_MBINFOXM memberInfo, TB_SPINFOXM supplierInfo, BindingResult result, SessionStatus status, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");	
		memberInfo.setREGP_ID(loginUser.getMEMB_ID());										
		memberInfo.setMEMB_GUBN("MEMB_GUBN_04");											
		/*
		memberInfo.setMEMB_SEX("W");
		memberInfo.setSLCAL_GUBN("양력");												
		memberInfo.setMEMB_BTDY("19671114");												
		memberInfo.setMEMB_PN("25476");														
		memberInfo.setMEMB_BADR("대전");
		memberInfo.setMEMB_DADR("유성구");													
		
		if(memberInfo.getSUPR_FLAG().equals("U")){											
			memberMgrService.updateObject(memberInfo);										
		}else{																				
			memberMgrService.insertObject(memberInfo);										
		}														
		*/
		
		if(memberInfo.getSUPR_FLAG().equals("U")){											
			supplierMgrService.updateObject2(memberInfo);										
		}else{																				
			/*supplierMgrService.insertObject(memberInfo);		*/								
		}
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/supplierMbrMgr"));
		return new ModelAndView(rv);
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin. extends SuppierMgrController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 기업회원정보 수정
	 * @Company	: YT Corp.
	 * @Author	: Seok-min Jeon (smjeon@youngthink.co.kr)
	 * @Date	: 2016-07-12 (오후 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param supplierInfo
	 * @param result
	 * @param status
	 * @param model
	 * @return String
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/supplierMbrMgr/edit/{SUPR_ID}", method=RequestMethod.PUT)
	public ModelAndView update(@ModelAttribute TB_MBINFOXM memberInfo,TB_SPINFOXM supplierInfo, BindingResult result, SessionStatus status, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		memberInfo.setSUPR_ID(loginUser.getMEMB_ID());
		memberInfo.setREGP_ID(loginUser.getMEMB_ID());
		memberInfo.setMEMB_GUBN("MEMB_GUBN_02");
		
		memberMgrService.updateObject(memberInfo);
		
		logger.info("SUPR_ID>>" + supplierInfo.getSUPR_ID());
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/supplierMbrMgr/edit/" + memberInfo.getSUPR_ID()));
		return new ModelAndView(rv);
		
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.SupplierMbrMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 기업회원목록 조회 - 로그인사용자 회사
	 * @Company	: YT Corp.
	 * @Author	: Seok-min Jeon (smjeon@youngthink.co.kr)
	 * @Date	: 2016-07-12 (오후 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/supplierMbrInfoMgr", method=RequestMethod.GET)
	public ModelAndView getListInfo(@ModelAttribute TB_MBINFOXM memberInfo, HttpServletRequest request, Model model) throws Exception {
			
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		memberInfo.setSUPR_ID(loginUser.getSUPR_ID());	
		memberInfo.setREGP_ID(loginUser.getMEMB_ID());	
		
		//기업정보
		model.addAttribute("supplierInfo", (TB_SPINFOXM)supplierMgrService.getObject(memberInfo));		
		
		memberInfo.setMEMB_GUBN("MEMB_GUBN_02");	//MEMB_GUBN_01-일반회원, MEMB_GUBN_02-기업회원,  MEMB_GUBN_03-시스템관리자
		memberInfo.setSCSS_YN("N");					//Y-탈퇴회원, N-정상회원

		//회원리스트
		memberInfo.setCount(memberMgrService.getObjectCount(memberInfo));						
		memberInfo.setList(memberMgrService.getPaginatedObjectList(memberInfo));
		
		model.addAttribute("obj", memberInfo);													
		model.addAttribute("rowCnt", memberInfo.getRowCnt());
		model.addAttribute("totalCnt", memberInfo.getCount());
		
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(memberInfo.getSchGbn())+
				  "&schTxt="+StringUtil.nullCheck(memberInfo.getSchTxt());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/supplierMbrMgr/listInfo");
	}
	
	/* 기업회원 등록/수정 - 로그인사용자 회사 */
	
	@RequestMapping(value="/supplierMbrInfoMgr", method=RequestMethod.POST)
	public ModelAndView infoInsert(@ModelAttribute TB_MBINFOXM memberInfo, TB_SPINFOXM supplierInfo, BindingResult result, SessionStatus status, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		memberInfo.setSUPR_ID(loginUser.getSUPR_ID());	
		memberInfo.setREGP_ID(loginUser.getMEMB_ID());
		memberInfo.setMEMB_GUBN("MEMB_GUBN_02");
		
		memberInfo.setMEMB_SEX("W");
		memberInfo.setSLCAL_GUBN("양력");
		memberInfo.setMEMB_BTDY("19671114");
		memberInfo.setMEMB_PN("25476");
		memberInfo.setMEMB_BADR("대전");
		memberInfo.setMEMB_DADR("유성구");
		
		if(memberInfo.getSUPR_FLAG().equals("U")){
			memberMgrService.updateObject(memberInfo);
		}else{
			memberMgrService.insertObject(memberInfo);
		}
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/supplierMbrInfoMgr"));
		return new ModelAndView(rv);
	}
	
	/* 기업회원 탈퇴 - 로그인사용자 회사 */
	
	@RequestMapping(value="/supplierMbrInfoMgr/delete", method=RequestMethod.POST)
	public ModelAndView infoDelete(@ModelAttribute TB_MBINFOXM memberInfo, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		memberInfo.setSUPR_ID(loginUser.getSUPR_ID());	
		memberInfo.setREGP_ID(loginUser.getMEMB_ID());	
		
		memberMgrService.deleteObject(memberInfo);
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/supplierMbrInfoMgr"));
		return new ModelAndView(rv);
	}
	
	
	
}
