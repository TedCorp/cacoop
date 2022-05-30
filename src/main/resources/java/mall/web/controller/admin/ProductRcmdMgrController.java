package mall.web.controller.admin;

import java.io.File;
import java.io.IOException;
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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDRCMDXM;
import mall.web.service.admin.impl.ProductMgrService;
import mall.web.service.admin.impl.ProductRcmdMgrService;
import mall.web.service.common.CommonService;

@Controller
@RequestMapping(value="/adm/productRcmdMgr")
public class ProductRcmdMgrController extends DefaultController{

	private static final Logger logger = LoggerFactory.getLogger(ProductRcmdMgrController.class);

	@Resource(name="commonService")
	CommonService commonService;

	@Resource(name="productRcmdMgrService")
	ProductRcmdMgrService productRcmdMgrService;
	
	@Resource(name="productMgrService")
	ProductMgrService productMgrService;
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 추천상품관리 조회
	 * @Company	: YT Corp.
	 * @Author	: HEESUN-LEE (hslee@youngthink.co.kr)
	 * @Date	: 2018-07-15 (오후 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_PDRCMDXM tb_pdrcmdxm, Model model) throws Exception {
		
		tb_pdrcmdxm.setList(productRcmdMgrService.getObjectList(tb_pdrcmdxm));
		model.addAttribute("obj", tb_pdrcmdxm);
		
		return new ModelAndView("admin.layout", "jsp", "admin/productRcmdMgr/list");		
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
	@RequestMapping(value={ "/{GRP_CD}", "/new"}, method=RequestMethod.GET)
	public ModelAndView view(@ModelAttribute TB_PDRCMDXM tb_pdrcmdxm, @ModelAttribute TB_PDINFOXM tb_pdinfoxm, Model model, HttpServletRequest request) throws Exception {
		
		if(StringUtils.isNotEmpty(tb_pdrcmdxm.getGRP_CD())){
			tb_pdrcmdxm = (TB_PDRCMDXM) productRcmdMgrService.getObject(tb_pdrcmdxm);
			tb_pdinfoxm.setList(productRcmdMgrService.getListProduct(tb_pdrcmdxm));			
		}
		
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
		if( inputFlashMap != null ){
			model.addAttribute("errlist", inputFlashMap.get("errlist"));
		}
		
		model.addAttribute("tb_pdrcmdxm", tb_pdrcmdxm);
		model.addAttribute("tb_pdinfoxm", tb_pdinfoxm);
		
		if (StringUtils.isNotEmpty(tb_pdrcmdxm.getRCMD_GUBN()) && tb_pdrcmdxm.getRCMD_GUBN().equals("RCMD_GUBN_09")){
			return new ModelAndView("admin.layout", "jsp", "admin/productRcmdMgr/formRetail");
		}
		
		return new ModelAndView("admin.layout", "jsp", "admin/productRcmdMgr/form");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: insert
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 추천상품그룹 신규등록
	 * @Company	: YT Corp.
	 * @Author	: Hee-sun Lee (hslee@youngthink.co.kr)
	 * @Date	: 2018-06-22 (오전 10:48:15)
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
	public ModelAndView insert(@ModelAttribute TB_PDRCMDXM tb_pdrcmdxm,HttpServletRequest request, Model model) throws Exception {
		// 등록자 정보 변경필요
		tb_pdrcmdxm.setREGP_ID("admin");
		tb_pdrcmdxm.setMODP_ID("admin");
		
		productRcmdMgrService.insertObject(tb_pdrcmdxm);		//insert
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/productRcmdMgr");
		return new ModelAndView(redirectView);
	}	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 추천상품 수정
	 * @Company	: YT Corp.
	 * @Author	: Hee-sun Lee (hslee@youngthink.co.kr)
	 * @Date	: 2018-06-22 (오전 10:48:15)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_pdrcmdxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/{GRP_CD}" }, method=RequestMethod.PUT)
	public ModelAndView update(@ModelAttribute TB_PDRCMDXM tb_pdrcmdxm, @ModelAttribute TB_PDINFOXM tb_pdinfoxm
			, BindingResult result, SessionStatus status, Model model,HttpServletRequest request) throws Exception {
		// 등록자 정보 변경필요
		tb_pdrcmdxm.setMODP_ID("admin");
		tb_pdinfoxm.setMODP_ID("admin");
		
		productRcmdMgrService.updateObject(tb_pdrcmdxm);		//그룹정보 UPDATE		
		productRcmdMgrService.deleteProduct(tb_pdrcmdxm);		//기존 그룹상품 삭제
		
		String[] splitCd = tb_pdinfoxm.getPD_CODE().split(",");
		// 신규 그룹상품 등록
		if(splitCd.length>0 && !tb_pdinfoxm.getPD_CODE().equals("")){
			for(int i=0;i<splitCd.length;i++){
				tb_pdrcmdxm.setPD_CODE(splitCd[i]);
				tb_pdrcmdxm.setSORT_ORDR(request.getParameterValues("PD_SORT")[i]);
				// 등록자 정보 변경필요
				tb_pdrcmdxm.setREGP_ID("admin");
				productRcmdMgrService.updateProduct(tb_pdrcmdxm);	//그룹상품 insert
		    }
		}
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/productRcmdMgr/"+tb_pdrcmdxm.getGRP_CD());		
		return new ModelAndView(redirectView);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: delete
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 추천상품 삭제
	 * @Company	: YT Corp.
	 * @Author	: Hee-sun Lee (hslee@youngthink.co.kr)
	 * @Date	: 2018-06-22 (오전 10:48:15)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_pdrcmdxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/{GRP_CD}" }, method=RequestMethod.DELETE)
	public ModelAndView delete(@ModelAttribute TB_PDRCMDXM tb_pdrcmdxm, BindingResult result, SessionStatus status, Model model, HttpServletRequest request) throws Exception {
		// 관리자 계정정보
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_pdrcmdxm.setMODP_ID(loginUser.getMEMB_ID());
		
		productRcmdMgrService.deleteProduct(tb_pdrcmdxm);	//추천상품D 삭제
		productRcmdMgrService.deleteObject(tb_pdrcmdxm);	//추천상품M 삭제
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/productRcmdMgr");		
		return new ModelAndView(redirectView);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: popup
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품 선택 (사용안함)
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
	@RequestMapping(value={ "/pdpop"}, method=RequestMethod.GET)
	public @ResponseBody TB_PDINFOXM pdpop(@ModelAttribute TB_PDINFOXM productInfo, Model model, HttpServletRequest request) throws Exception {	
		//결과내 재검색 X
		List schTxt_befList = Arrays.asList(productInfo.getSchTxt());
		productInfo.setSchTxt_befList(schTxt_befList);			// 기본 검색어 만 List
		productInfo.setSchTxt_bef(productInfo.getSchTxt());	// 기본 검색어를 이전 검색어 hidden 데이터로 반영
	
		productInfo.setCount(productMgrService.getObjectCount(productInfo));
		productInfo.setList(productRcmdMgrService.getPaginatedObjectList(productInfo));	//전체조회
		
		return productInfo;
	}
	
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
			      "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
			      "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr())+
			      "&pagerMaxPageItems="+StringUtil.nullCheck(productInfo.getPagerMaxPageItems());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("popup.layout", "jsp", "admin/productRcmdMgr/popup");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: deleteproduct
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 추천상품수정
	 * @Company	: YT Corp.
	 * @Author	: Hee-sun Lee (hslee@youngthink.co.kr)
	 * @Date	: 2018-06-22 (오전 10:48:15)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_pdrcmdxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/deleteProduct" }, method=RequestMethod.GET)
	public ModelAndView deleteproduct(@ModelAttribute TB_PDRCMDXM tb_pdrcmdxm, @ModelAttribute TB_PDINFOXM tb_pdinfoxm, BindingResult result, SessionStatus status, Model model) throws Exception {
		// 등록자 정보 변경필요
		tb_pdrcmdxm.setMODP_ID("admin");
		tb_pdinfoxm.setMODP_ID("admin");
		
		productRcmdMgrService.deleteProduct(tb_pdinfoxm);
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/productRcmdMgr/"+tb_pdrcmdxm.getGRP_CD());		
		return new ModelAndView(redirectView);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: chk
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 그룹정렬 중복 검사
	 * @Company	: YT Corp.
	 * @Author	: Hee-sun Lee (sjie1638@youngthink.co.kr)
	 * @Date	: 2018-06-26 (오후 3:32:11)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_sysmnuxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/ordrChk"}, method=RequestMethod.POST)
	public @ResponseBody String chk(@ModelAttribute TB_PDRCMDXM tb_pdrcmdxm, BindingResult result, SessionStatus status, Model model) throws Exception {
		
		int updateCnt = productRcmdMgrService.getOrdrSameCnt(tb_pdrcmdxm);
		return updateCnt > 0 ? SUCCESS : FAILURE;
	}
	
	@RequestMapping(value={ "/grpPdChk"}, method=RequestMethod.POST)
	public @ResponseBody String grpPdChk(@ModelAttribute TB_PDRCMDXM tb_pdrcmdxm, BindingResult result, SessionStatus status, Model model) throws Exception {
		
		int updateCnt = productRcmdMgrService.getGrpPdCnt(tb_pdrcmdxm);
		return updateCnt > 0 ? SUCCESS : FAILURE;
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: excel
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 추천상품 엑셀 업로드 / 다운로드
	 * @Company	: YT Corp.
	 * @Author	: Hee-sun Lee (sjie1638@youngthink.co.kr)
	 * @Date	: 2018-06-26 (오후 3:32:11)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_sysmnuxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/excelUpload",method=RequestMethod.POST)
	public ModelAndView excelUpload(@ModelAttribute TB_PDRCMDXM tb_pdrcmdxm, HttpServletRequest request, Model model, MultipartHttpServletRequest multipartRequest, RedirectAttributes redirectAttributes) throws Exception{
		
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
	         	errlist = productRcmdMgrService.excelUpload(tb_pdrcmdxm, excelContent);
	        }catch(SQLException e){
	        	ModelAndView mav = new ModelAndView();			
				mav.addObject("alertMessage", e.getStackTrace()+"\n엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식 다운로드 후 다시 저장 하세요.");
				mav.addObject("returnUrl", "back");
				mav.setViewName("alertMessage");
				return mav;
	        }
		}
		
		redirectAttributes.addFlashAttribute("errlist", errlist);
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/productRcmdMgr/" + tb_pdrcmdxm.getGRP_CD()));		
		return new ModelAndView(rv);
	}
	
	@RequestMapping(value="/excelDownload",method=RequestMethod.POST)
	public void excelDownload(@ModelAttribute TB_PDRCMDXM tb_pdrcmdxm, HttpServletResponse response, Model model) throws Exception{
		
		String[] headerName = {"상품바코드","정렬순서","상품명","상품코드"};
		String[] columnName = {"PD_BARCD","SORT_ORDR","PD_NAME","PD_CODE"};
		String sheetName = "추천상품엑셀";

		List<HashMap<String, String>> list = (List<HashMap<String, String>>) productRcmdMgrService.getDetailExcelList(tb_pdrcmdxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}


	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: popupRetail
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 리테일 추천상품관리 (사용안함)
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_sysmnuxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	/* 리테일 추천상품 팝업 */
	@RequestMapping(value={ "/popupRetail"}, method=RequestMethod.GET)
	public ModelAndView popupRetail(@ModelAttribute TB_PDINFOXM productInfo, Model model, HttpServletRequest request) throws Exception {
	
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
		
		//리테일 상품만 검색
		productInfo.setCount(productRcmdMgrService.getRetailCount(productInfo));
		productInfo.setList(productRcmdMgrService.getRetailList(productInfo));
		model.addAttribute("obj", productInfo);
		
		//페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount());			//전체 카운트

		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn())+
					 "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt())+
					 //"&schTxt="+URLEncoder.encode(StringUtil.nullCheck(productInfo.getSchTxt()),"UTF-8")+
					 "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
					 "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr())+
					 "&pagerMaxPageItems="+StringUtil.nullCheck(productInfo.getPagerMaxPageItems());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("popup.layout", "jsp", "admin/productRcmdMgr/popupRetail");
	}
	
	/* 리테일 상품 중복확인 */
	@RequestMapping(value={ "/grpRtChk"}, method=RequestMethod.POST)
	public @ResponseBody String grpRtChk(@ModelAttribute TB_PDRCMDXM tb_pdrcmdxm, BindingResult result, SessionStatus status, Model model) throws Exception {		
		int updateCnt = productRcmdMgrService.getGrpPdCnt(tb_pdrcmdxm);
		return updateCnt > 0 ? SUCCESS : FAILURE;
	}

	/* 리테일 추천상품 엑셀 다운로드   */
	@RequestMapping(value="/excelDownRetail",method=RequestMethod.POST)
	public void excelDownRetail(@ModelAttribute TB_PDRCMDXM tb_pdrcmdxm, HttpServletResponse response, Model model) throws Exception{
		
		String[] headerName = {"상품바코드","정렬순서","상품명","상품코드", "리테일구분"};
		String[] columnName = {"PD_BARCD","SORT_ORDR","PD_NAME","PD_CODE", "RETAIL_NAME"};

		String sheetName = "리테일추천상품엑셀";
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) productRcmdMgrService.getRetailExcelList(tb_pdrcmdxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}

	/* 리테일 상품 엑셀 다운로드   */
	@RequestMapping(value="/excelDown",method=RequestMethod.POST)
	public void excelDown(@ModelAttribute TB_PDINFOXM productInfo, HttpServletResponse response, Model model) throws Exception{

		String[] headerName = {"제품코드","제품명","공급업체 ID","카테고리ID","카테고리명","제품가격","제품할인 구분","제품할인 값"
				,"재고수량","제품바코드","제품규격","유통기한","제조회사","원산지","판매상태","파일ID","대표이미지 순번"
				,"규격단위","면세과세구분","일배상품구분","박스할인여부","박스할인금액","비닐봉투색상","세절방식"
				,"상세첨부파일","상세첨부파일사용여부","개별배송 여부(INDIVIDUAL)","보관기준","팩킹기준"
				,"보관위치","한정수량","입수량", "리테일구분"};
		String[] columnName = {
				"PD_CODE","PD_NAME","SUPR_ID","CAGO_ID","CAGO_NM","PD_PRICE","PDDC_GUBN","PDDC_VAL"
				,"INVEN_QTY","PD_BARCD","PD_STD","DTB_DLINE","MAKE_COM","ORG_CT","SALE_CON","ATFL_ID","RPIMG_SEQ"
				,"STD_UNIT","TAX_GUBN","ONDY_GUBN","BOX_PDDC_GUBN","BOX_PDDC_VAL","OPTION_GUBN","CUT_UNIT"
				,"DTL_ATFL_ID","DTL_USE_YN","DLVR_INDI_YN","KEEP_GUBN","PACKING_GUBN"
				,"KEEP_LOCATION","LIMIT_QTY","INPUT_CNT", "RETAIL_GUBN"
				};
				
		String sheetName = "리테일상품엑셀";
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) productRcmdMgrService.getExcelList(productInfo);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}

}
