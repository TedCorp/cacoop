package mall.web.controller.admin;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.util.SystemOutLogger;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.util.ExcelDownload;
import mall.common.util.FileUtil;
import mall.common.util.StringUtil;
import mall.common.util.excel.ExcelRead;
import mall.common.util.excel.ExcelReadOption;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_ADPDIFXM;
import mall.web.domain.TB_COMCODXD;
import mall.web.domain.TB_ENTRYCAGOXD;
import mall.web.domain.TB_ENTRYCAGOXM;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_PDCAGOXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDRCMDXM;
import mall.web.domain.TB_SYSMNUXM;
import mall.web.service.admin.impl.EntryCategoryMenuMgrService;
import mall.web.service.admin.impl.ProductMgrService;
import mall.web.service.admin.impl.ProductRcmdMgrService;
import mall.web.service.common.CommonService;

@Controller
@RequestMapping(value="/adm/entryCategoryMenuMgr")
public class EntryCategoryMenuMgrController extends DefaultController{

	private static final Logger logger = LoggerFactory.getLogger(EntryCategoryMenuMgrController.class);

	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="entryCategoryMenuMgrService")
	EntryCategoryMenuMgrService entryCategoryMenuMgrService;
	

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
		List<TB_ENTRYCAGOXM> list = (List<TB_ENTRYCAGOXM>) (entryCategoryMenuMgrService.getEntrycagoList());
		model.addAttribute("obj", list);
		
		return new ModelAndView("admin.layout", "jsp", "admin/entryCategoryMenuMgr/list");		
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
			return new ModelAndView("admin.layout", "jsp", "admin/entryCategoryMenuMgr/form");
		
		TB_ENTRYCAGOXM entCagoInfo = entryCategoryMenuMgrService.getEntrycago(tb_entrycagoxm.getENTRY_ID());
		@SuppressWarnings("unchecked")
		List<TB_ENTRYCAGOXD> entCagoDetail = (List<TB_ENTRYCAGOXD>) entryCategoryMenuMgrService.getEntrycagoDetail(tb_entrycagoxm.getENTRY_ID());
		//tb_pdinfoxm.setList(productRcmdMgrService.getListProduct(tb_pdrcmdxm));
		
		model.addAttribute("entCagoInfo", entCagoInfo);
		model.addAttribute("entCagoDetail", entCagoDetail);
		
		return new ModelAndView("admin.layout", "jsp", "admin/entryCategoryMenuMgr/form");
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
	 * 사용안함
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute TB_ENTRYCAGOXM tb_entrycagoxm, @ModelAttribute TB_ENTRYCAGOXD tb_entrycagoxd
			, HttpServletRequest request, Model model) throws Exception {
				
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_entrycagoxm.setREGP_ID(loginUser.getMEMB_ID()); 
		tb_entrycagoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		String id = entryCategoryMenuMgrService.insertEntryCagoxm(tb_entrycagoxm);		//insert
		
		// detail 카테고리 insert
		tb_entrycagoxd.setENTRY_ID(id);		
		if(tb_entrycagoxd.getENTRYD_ID() != null){
			String[] splitCd = tb_entrycagoxd.getENTRYD_ID().split(",");
			String[] splitOrd = tb_entrycagoxd.getSORT_ORDR().split(",");
			
			if(splitCd.length > 0 && !tb_entrycagoxd.getENTRY_ID().equals("")){
				
				tb_entrycagoxd.setREGP_ID(loginUser.getMEMB_ID());
				tb_entrycagoxd.setMODP_ID(loginUser.getMEMB_ID());
				
				for(int i=0;i<splitCd.length;i++){				
					tb_entrycagoxd.setENTRYD_ID(splitCd[i]);
					tb_entrycagoxd.setSORT_ORDR(splitOrd[i]);
					
					entryCategoryMenuMgrService.insertEntryCagoxd(tb_entrycagoxd);	// detail 카테고리 insert
			    }	
			}
			
		}
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/entryCategoryMenuMgr");
		
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
		
		//entryCategoryMenuMgrService.updateEntryCagoxm(tb_entrycagoxm);		// 진입카테고리 UPDATE
		
		entryCategoryMenuMgrService.deleteEntryCagoxd(tb_entrycagoxm.getENTRY_ID());		// detail 카테고리 삭제
		
		if(tb_entrycagoxd.getENTRYD_ID() != null){
			String[] splitCd = tb_entrycagoxd.getENTRYD_ID().split(",");
			String[] splitOrd = tb_entrycagoxd.getSORT_ORDR().split(",");
			
			if(splitCd.length > 0 && !tb_entrycagoxd.getENTRY_ID().equals("")){
				
				tb_entrycagoxd.setREGP_ID(loginUser.getMEMB_ID());
				tb_entrycagoxd.setMODP_ID(loginUser.getMEMB_ID());
				
				for(int i=0;i<splitCd.length;i++){				
					tb_entrycagoxd.setENTRYD_ID(splitCd[i]);
					tb_entrycagoxd.setSORT_ORDR(splitOrd[i]);
					
					entryCategoryMenuMgrService.insertEntryCagoxd(tb_entrycagoxd);	// detail 카테고리 insert
			    }	
			}
			
		}
				
		
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/entryCategoryMenuMgr/"+tb_entrycagoxm.getENTRY_ID());
		
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
	 * 
	 * 사용안함
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/delete/{ENTRY_ID}" }, method=RequestMethod.PUT)
	public ModelAndView delete(@ModelAttribute TB_ENTRYCAGOXM tb_entrycagoxm, @ModelAttribute TB_ENTRYCAGOXD tb_entrycagoxd
			, BindingResult result, SessionStatus status, Model model,HttpServletRequest request) throws Exception {
		
		tb_entrycagoxm.getENTRY_ID();
		
		entryCategoryMenuMgrService.deleteEntryCagoxm(tb_entrycagoxm.getENTRY_ID());
		entryCategoryMenuMgrService.deleteEntryCagoxd(tb_entrycagoxm.getENTRY_ID());
		
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/entryCategoryMenuMgr/");
		
		return new ModelAndView(redirectView);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: popup
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품 선택
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-20 (오후 4:42:49)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_sysmnuxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/popup"}, method=RequestMethod.GET)
	public ModelAndView popup(@ModelAttribute TB_PDCAGOXM productInfo, Model model, HttpServletRequest request) throws Exception {
	
		//결과내 재검색 X
		List schTxt_befList = Arrays.asList(productInfo.getSchTxt());
		productInfo.setSchTxt_befList(schTxt_befList);			// 기본 검색어 만 List
		productInfo.setSchTxt_bef(productInfo.getSchTxt());	// 기본 검색어를 이전 검색어 hidden 데이터로 반영
		
		// 페이징
		if(request.getParameter("pagerMaxPageItems")!=null){
			productInfo.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));	
			productInfo.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			productInfo.setRowCnt(10);	//기본 페이징 단위 : 10
			productInfo.setPagerMaxPageItems(10);
		}
		
		productInfo.setCount(entryCategoryMenuMgrService.getObjectCount(productInfo));
		productInfo.setList(entryCategoryMenuMgrService.getPaginatedObjectList(productInfo));
		model.addAttribute("obj", productInfo);
		
		//페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount());		//전체 카운트

		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn())+
				  "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt())+
			      "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
			      "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr())+
			      "&pagerMaxPageItems="+StringUtil.nullCheck(productInfo.getPagerMaxPageItems());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("popup.layout", "jsp", "admin/entryCategoryMenuMgr/popup");
	}
	
	
}
