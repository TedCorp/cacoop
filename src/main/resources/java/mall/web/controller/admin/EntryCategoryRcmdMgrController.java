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
import mall.web.domain.TB_PDRCMDXD_ENTCAGO;
import mall.web.domain.TB_PDRCMDXM;
import mall.web.domain.TB_PDRCMDXM_ENTCAGO;
import mall.web.domain.TB_SYSMNUXM;
import mall.web.service.admin.impl.EntryCategoryRcmdMgrService;
import mall.web.service.admin.impl.ProductMgrService;
import mall.web.service.admin.impl.ProductRcmdMgrService;
import mall.web.service.common.CommonService;

@Controller
@RequestMapping(value="/adm/entryCategoryRcmdMgr")
public class EntryCategoryRcmdMgrController extends DefaultController{

	private static final Logger logger = LoggerFactory.getLogger(EntryCategoryRcmdMgrController.class);

	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="entryCategoryRcmdMgrService")
	EntryCategoryRcmdMgrService entryCategoryRcmdMgrService;
	
	@Resource(name="productMgrService")
	ProductMgrService productMgrService;
	

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
		List<TB_ENTRYCAGOXM> list = (List<TB_ENTRYCAGOXM>) (entryCategoryRcmdMgrService.getEntrycagoList());
		model.addAttribute("obj", list);
		
		return new ModelAndView("admin.layout", "jsp", "admin/entryCategoryRcmdMgr/list");		
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 2020-04-01
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 */
	@RequestMapping(value={ "/{ENTRY_ID}"}, method=RequestMethod.GET)
	public ModelAndView getRcmdList(@ModelAttribute TB_PDRCMDXM_ENTCAGO tb_pdrcmdxm_entcago, Model model) throws Exception {
		
		//사이드상품도 같이 관리하자
		
		@SuppressWarnings("unchecked")
		List<TB_PDRCMDXM_ENTCAGO> list = (List<TB_PDRCMDXM_ENTCAGO>) (entryCategoryRcmdMgrService.getPdRcmdxmEntcago(tb_pdrcmdxm_entcago.getENTRY_ID()));
		model.addAttribute("obj", list);
		model.addAttribute("ENTRY_ID", tb_pdrcmdxm_entcago.getENTRY_ID());
		
		return new ModelAndView("admin.layout", "jsp", "admin/entryCategoryRcmdMgr/list2");		
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
	@RequestMapping(value={ "/form/{ENTRY_ID}/{GRP_CD}"}, method=RequestMethod.GET)
	public ModelAndView view(@ModelAttribute TB_PDRCMDXM_ENTCAGO tb_pdrcmdxm_entcago, @ModelAttribute TB_PDINFOXM tb_pdinfoxm, Model model, HttpServletRequest request) throws Exception {
				
		if(tb_pdrcmdxm_entcago.getENTRY_ID() == null)
			return new ModelAndView("admin.layout", "jsp", "admin/entryCategoryRcmdMgr/form");
		
		//TB_PDRCMDXD_ENTCAGO 조회 / 조건 : ENTRY_ID, GRP_CD
		TB_PDRCMDXM_ENTCAGO rcmdInfo;
		
		if(!tb_pdrcmdxm_entcago.getGRP_CD().equals("NEW"))
			rcmdInfo = entryCategoryRcmdMgrService.getPdRcmdxmEntcagoxm(tb_pdrcmdxm_entcago);
		else{
			rcmdInfo = new TB_PDRCMDXM_ENTCAGO();
			rcmdInfo.setENTRY_ID(tb_pdrcmdxm_entcago.getENTRY_ID());
		}
		
		
		@SuppressWarnings("unchecked")
		List<TB_PDRCMDXD_ENTCAGO> entCagoDetail = (List<TB_PDRCMDXD_ENTCAGO>) entryCategoryRcmdMgrService.getPdRcmdxmEntcagoxd(tb_pdrcmdxm_entcago);
		//tb_pdinfoxm.setList(productRcmdMgrService.getListProduct(tb_pdrcmdxm));
		
		model.addAttribute("tb_pdrcmdxm", rcmdInfo);
		model.addAttribute("tb_pdinfoxm", entCagoDetail);		
		
		return new ModelAndView("admin.layout", "jsp", "admin/entryCategoryRcmdMgr/form");
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
	@RequestMapping(value={ "/insert/{ENTRY_ID}" }, method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute TB_PDRCMDXM_ENTCAGO tb_pdrcmdxm_entcago, @ModelAttribute TB_PDRCMDXD_ENTCAGO tb_pdrcmdxd_entcago
			, BindingResult result, SessionStatus status, Model model,HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_pdrcmdxm_entcago.setREGP_ID(loginUser.getMEMB_ID()); 
		tb_pdrcmdxm_entcago.setMODP_ID(loginUser.getMEMB_ID());
		
		String cd = entryCategoryRcmdMgrService.insertPdrcmdxm_entcago(tb_pdrcmdxm_entcago);		// 진입카테고리 - 추천상품마스터 UPDATE
		tb_pdrcmdxd_entcago.setGRP_CD(cd);
		// 추천상품 디테일 처리
		//entryCategoryRcmdMgrService.deletePdrcmdxd_entcago(tb_pdrcmdxm_entcago);		// 진입카테고리 - 추천상품디테일 DELETE		
		if(tb_pdrcmdxd_entcago.getPD_CODE() != null && tb_pdrcmdxd_entcago.getSORT_ORDR() != null){
			String[] splitCd = tb_pdrcmdxd_entcago.getPD_CODE().split(",");
			String[] splitOrd = tb_pdrcmdxd_entcago.getPD_SORT().split(",");
			
			if(splitCd.length > 0 && !tb_pdrcmdxd_entcago.getPD_CODE().equals("")){
				
				tb_pdrcmdxd_entcago.setREGP_ID(loginUser.getMEMB_ID());
				tb_pdrcmdxd_entcago.setMODP_ID(loginUser.getMEMB_ID());
				
				for(int i=0;i<splitCd.length;i++){				
					tb_pdrcmdxd_entcago.setPD_CODE(splitCd[i]);
					tb_pdrcmdxd_entcago.setSORT_ORDR(splitOrd[i]);
					
					entryCategoryRcmdMgrService.insertPdrcmdxd_entcago(tb_pdrcmdxd_entcago);		// 진입카테고리 - 추천상품디테일 UPDATE
			    }	
			}
		}
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/entryCategoryRcmdMgr/form/"+tb_pdrcmdxm_entcago.getENTRY_ID()+"/"+tb_pdrcmdxm_entcago.getGRP_CD());
		
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
	@RequestMapping(value={ "/form/{ENTRY_ID}/{GRP_CD}" }, method=RequestMethod.PUT)
	public ModelAndView update(@ModelAttribute TB_PDRCMDXM_ENTCAGO tb_pdrcmdxm_entcago, @ModelAttribute TB_PDRCMDXD_ENTCAGO tb_pdrcmdxd_entcago
			, BindingResult result, SessionStatus status, Model model,HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_pdrcmdxm_entcago.setREGP_ID(loginUser.getMEMB_ID()); 
		tb_pdrcmdxm_entcago.setMODP_ID(loginUser.getMEMB_ID());
		
		entryCategoryRcmdMgrService.updatePdrcmdxm_entcago(tb_pdrcmdxm_entcago);		// 진입카테고리 - 추천상품마스터 UPDATE
		
		// 추천상품 디테일 처리
		entryCategoryRcmdMgrService.deletePdrcmdxd_entcago(tb_pdrcmdxm_entcago);		// 진입카테고리 - 추천상품디테일 DELETE		
		if(tb_pdrcmdxd_entcago.getPD_CODE() != null && tb_pdrcmdxd_entcago.getSORT_ORDR() != null){
			String[] splitCd = tb_pdrcmdxd_entcago.getPD_CODE().split(",");
			String[] splitOrd = tb_pdrcmdxd_entcago.getPD_SORT().split(",");
			
			if(splitCd.length > 0 && !tb_pdrcmdxd_entcago.getPD_CODE().equals("")){
				
				tb_pdrcmdxd_entcago.setREGP_ID(loginUser.getMEMB_ID());
				tb_pdrcmdxd_entcago.setMODP_ID(loginUser.getMEMB_ID());
				
				for(int i=0;i<splitCd.length;i++){				
					tb_pdrcmdxd_entcago.setPD_CODE(splitCd[i]);
					tb_pdrcmdxd_entcago.setSORT_ORDR(splitOrd[i]);
					
					entryCategoryRcmdMgrService.insertPdrcmdxd_entcago(tb_pdrcmdxd_entcago);		// 진입카테고리 - 추천상품디테일 UPDATE
			    }	
			}
		}
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/entryCategoryRcmdMgr/form/"+tb_pdrcmdxm_entcago.getENTRY_ID()+"/"+tb_pdrcmdxm_entcago.getGRP_CD());
		
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
	@RequestMapping(value={ "/delete/{ENTRY_ID}/{GRP_CD}" }, method=RequestMethod.PUT)
	public ModelAndView delete(@ModelAttribute TB_PDRCMDXM_ENTCAGO tb_pdrcmdxm_entcago
			, BindingResult result, SessionStatus status, Model model,HttpServletRequest request) throws Exception {
	
		
		entryCategoryRcmdMgrService.deletePdrcmdxm_entcago(tb_pdrcmdxm_entcago);
		entryCategoryRcmdMgrService.deletePdrcmdxd_entcago(tb_pdrcmdxm_entcago);
		
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/entryCategoryRcmdMgr/"+tb_pdrcmdxm_entcago.getENTRY_ID());
		
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
	public ModelAndView popup(@ModelAttribute TB_PDINFOXM productInfo, Model model, HttpServletRequest request) throws Exception {
	
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
		
		productInfo.setCount(productMgrService.getObjectCount(productInfo));
		productInfo.setList(productMgrService.getPaginatedObjectList(productInfo));
		model.addAttribute("obj", productInfo);
		
		//페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount());		//전체 카운트

		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn())+
					 "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt())+
			      //"&schTxt="+URLEncoder.encode(StringUtil.nullCheck(productInfo.getSchTxt()),"UTF-8")+
			      "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
			      "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr())+
			      "&pagerMaxPageItems="+StringUtil.nullCheck(productInfo.getPagerMaxPageItems());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("popup.layout", "jsp", "admin/entryCategoryRcmdMgr/popup");
	}
	
	//세일상품 체크 : 한개만 등록 가능함
	@RequestMapping(value={ "/chkGubn"}, method=RequestMethod.POST)
	public @ResponseBody String grpPdChk(@ModelAttribute TB_PDRCMDXM_ENTCAGO tb_pdrcmdxm_entcago, BindingResult result, SessionStatus status, Model model) throws Exception {
		
		int updateCnt = entryCategoryRcmdMgrService.getchkGubn(tb_pdrcmdxm_entcago);
		
		return updateCnt > 0 ? SUCCESS : FAILURE;
	}
	
	/* 엑셀 업로드 등록&수정   */
	@RequestMapping(value="/excelUpload",method=RequestMethod.POST)
	public ModelAndView excelUpload(@ModelAttribute TB_PDRCMDXM_ENTCAGO tb_pdrcmdxm, HttpServletRequest request, Model model, MultipartHttpServletRequest multipartRequest, RedirectAttributes redirectAttributes) throws Exception{
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_pdrcmdxm.setREGP_ID(loginUser.getMEMB_ID()); 
		tb_pdrcmdxm.setMODP_ID(loginUser.getMEMB_ID());
		
		List<TB_PDINFOXM> errlist = new ArrayList<TB_PDINFOXM>(); 
		
		MultipartFile excelFile =multipartRequest.getFile("EXCEL_FILE");
		
        if(excelFile==null || excelFile.isEmpty()){
            throw new RuntimeException("엑셀파일을 선택 해 주세요.");
        }
        
		if ( StringUtils.isNotEmpty(excelFile.getOriginalFilename()) ) {
			String saveFileName = FileUtil.saveFile2(request, excelFile, "jundan/tmp", false);
			String savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/jundan/tmp" + File.separator;

	        File destFile = new File(savePath+saveFileName);
	        try{
	            excelFile.transferTo(destFile);
	        }catch(IllegalStateException | IOException e){
	            throw new RuntimeException(e.getMessage(),e);
	        }
	        
	        //Service 단에서 가져온 코드 
	        ExcelReadOption excelReadOption = new ExcelReadOption();
	        excelReadOption.setFilePath(destFile.getAbsolutePath());
	        excelReadOption.setOutputColumns("A","B","C");
	        excelReadOption.setStartRow(3);
	        	        
	        List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);
	        logger.info("getNumCellCnt>>" + excelReadOption.getNumCellCnt());

			if (excelReadOption.getNumCellCnt() < 3) {
				ModelAndView mav = new ModelAndView();
				
				mav.addObject("alertMessage", "엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식 다운로드 후 다시 저장 하세요.");
				mav.addObject("returnUrl", "back");
				mav.setViewName("alertMessage");
				return mav;
			}
			
	        try{
	         	errlist = entryCategoryRcmdMgrService.excelUpload(tb_pdrcmdxm, excelContent);
	        }catch(SQLException e){
	        	ModelAndView mav = new ModelAndView();			
				mav.addObject("alertMessage", e.getStackTrace()+"\n엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식 다운로드 후 다시 저장 하세요.");
				mav.addObject("returnUrl", "back");
				mav.setViewName("alertMessage");
				return mav;
	        }
		}
		
		redirectAttributes.addFlashAttribute("errlist", errlist);
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/entryCategoryRcmdMgr/form/" + tb_pdrcmdxm.getENTRY_ID() + "/" + tb_pdrcmdxm.getGRP_CD()));
		/*rv.addStaticAttribute("errlist", errlist);*/
		return new ModelAndView(rv);
	}
	
	
}
