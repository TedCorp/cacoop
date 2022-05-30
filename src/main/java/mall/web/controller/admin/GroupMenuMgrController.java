package mall.web.controller.admin;

import javax.annotation.Resource;

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
import mall.web.domain.TB_SYSGMNXM;
import mall.web.domain.TB_SYSGRPXM;
import mall.web.service.admin.impl.GroupMenuMgrService;
import mall.web.service.admin.impl.GroupMgrService;

@Controller
@RequestMapping(value="/adm/groupMenuMgr")
public class GroupMenuMgrController extends DefaultController{

	@Resource(name="groupMenuMgrService")
	GroupMenuMgrService groupMenuMgrService;
	
	@Resource(name="groupMgrService")
	GroupMgrService groupMgrService;

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.GroupMenuMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 그룹별 메뉴 관리 목록
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-20 (오후 8:35:11)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_sysgrpxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_SYSGMNXM tb_sysgmnxm, Model model) throws Exception {
		
		TB_SYSGRPXM tb_sysgrpxm = new TB_SYSGRPXM();
		tb_sysgrpxm.setList(groupMgrService.getObjectList(tb_sysgmnxm));
		model.addAttribute("tb_sysgrpxm", tb_sysgrpxm);
		
		if(tb_sysgmnxm.getGROUP_CD() == "" || tb_sysgmnxm.getGROUP_CD() == null){
			tb_sysgmnxm.setGROUP_CD(((TB_SYSGRPXM)tb_sysgrpxm.getList().get(0)).getGROUP_CD());
		}
		
		tb_sysgmnxm.setList(groupMenuMgrService.getObjectList(tb_sysgmnxm));
		model.addAttribute("obj", tb_sysgmnxm);
		
		return new ModelAndView("admin.layout", "jsp", "admin/groupMenuMgr/list");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.GroupMenuMgrController.java
	 * @Method	: insert
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 그룹별 메뉴 관리 등록
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-21 (오후 3:08:29)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_sysgmnxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute TB_SYSGMNXM tb_sysgmnxm, BindingResult result, SessionStatus status, Model model) throws Exception {
		// 등록자 정보 변경필요
		tb_sysgmnxm.setREGP_ID("admin");
		tb_sysgmnxm.setMODP_ID("admin");
		
		groupMenuMgrService.insertObject(tb_sysgmnxm);
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/groupMenuMgr?GROUP_CD="+tb_sysgmnxm.getGROUP_CD());		
		return new ModelAndView(redirectView);
	}
}
