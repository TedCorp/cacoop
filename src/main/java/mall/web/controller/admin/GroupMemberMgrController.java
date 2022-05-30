package mall.web.controller.admin;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.web.controller.DefaultController;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_SYSGRPXM;
import mall.web.domain.TB_SYSGUSXM;
import mall.web.service.admin.impl.GroupMemberMgrService;
import mall.web.service.admin.impl.GroupMgrService;
import mall.web.service.admin.impl.MemberMgrService;

@Controller
@RequestMapping(value="/adm/groupMemberMgr")
public class GroupMemberMgrController extends DefaultController{

	@Resource(name="groupMemberMgrService")
	GroupMemberMgrService groupMemberMgrService;

	@Resource(name="groupMgrService")
	GroupMgrService groupMgrService;
	
	@Resource(name="memberMgrService")
	MemberMgrService memberMgrService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.GroupMemberMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 그룹별 회원 관리 목록
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-20 (오후 8:34:43)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_sysgrpxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_SYSGUSXM tb_sysgusxm, Model model) throws Exception {
				
		TB_SYSGRPXM tb_sysgrpxm = new TB_SYSGRPXM();								
		tb_sysgrpxm.setList(groupMgrService.getObjectList(tb_sysgusxm));			
		model.addAttribute("tb_sysgrpxm", tb_sysgrpxm);								
		
		if(tb_sysgusxm.getGROUP_CD() == "" || tb_sysgusxm.getGROUP_CD() == null){					
			tb_sysgusxm.setGROUP_CD(((TB_SYSGRPXM)tb_sysgrpxm.getList().get(0)).getGROUP_CD());		
	}																							
		tb_sysgusxm.setList(groupMemberMgrService.getObjectList(tb_sysgusxm));						 
		model.addAttribute("obj", tb_sysgusxm); 			
		
		return new ModelAndView("admin.layout", "jsp", "admin/groupMemberMgr/list");
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.GroupMemberMgrController.java
	 * @Method	: delete
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 그룹별 회원 관리 삭제
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-21 (오후 4:49:24)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_sysgusxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.DELETE)
	public ModelAndView delete(@ModelAttribute TB_SYSGUSXM tb_sysgusxm, BindingResult result, SessionStatus status, Model model) throws Exception {
		
		groupMemberMgrService.deleteObject(tb_sysgusxm);
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/groupMemberMgr?GROUP_CD="+tb_sysgusxm.getGROUP_CD());
		
		return new ModelAndView(redirectView);
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.GroupMemberMgrController.java
	 * @Method	: popup
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 회원선택 팝업 호출
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-21 (오후 5:48:07)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_sysgusxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/popup"}, method=RequestMethod.GET)
	public ModelAndView popup(@ModelAttribute TB_MBINFOXM memberInfo, TB_SYSGUSXM tb_sysgusxm, Model model) throws Exception {
		
		memberInfo.setList(groupMemberMgrService.getObjectPopupList(memberInfo));
		model.addAttribute("obj", memberInfo);
		
		return new ModelAndView("popup.layout", "jsp", "admin/groupMemberMgr/popup");
		
	}
		
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.GroupMemberMgrController.java
	 * @Method	: popupSave
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 회원선택 팝업 저장
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-21 (오후 5:48:16)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_sysgusxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/popup"}, method=RequestMethod.POST)
	public @ResponseBody String popupSave(@ModelAttribute TB_SYSGUSXM tb_sysgusxm, BindingResult result, SessionStatus status, Model model) throws Exception {
		// 등록자 정보 변경필요
		tb_sysgusxm.setREGP_ID("admin");
		tb_sysgusxm.setMODP_ID("admin");
		
		groupMemberMgrService.insertObject(tb_sysgusxm);
		
		int updateCnt = 1;
		return updateCnt > 0 ? SUCCESS : FAILURE;
	}
	
}
