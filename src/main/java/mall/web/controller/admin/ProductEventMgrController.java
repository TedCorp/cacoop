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
import mall.web.service.admin.impl.ProductEventMgrService;
import mall.web.service.admin.impl.ProductMgrService;
import mall.web.service.common.CommonService;

@Controller
@RequestMapping(value="/adm/productEventMgr")
public class ProductEventMgrController extends DefaultController{

	private static final Logger logger = LoggerFactory.getLogger(ProductEventMgrController.class);

	@Resource(name="commonService")
	CommonService commonService;

	@Resource(name="productEventMgrService")
	ProductEventMgrService productEventMgrService;
	
	@Resource(name="productMgrService")
	ProductMgrService productMgrService;
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductEventMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 행사상품관리 리스트
	 * @Company	: YT Corp.
	 * @Author	: Ji-won Chang (Chjw@youngthink.co.kr)
	 * @Date	: 2019-05-08
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_PDINFOXM tb_pdinfoxm, Model model, HttpServletRequest request) throws Exception {
		// 페이징
		if(request.getParameter("pagerMaxPageItems")!=null){
			tb_pdinfoxm.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));						//페이징 단위 : 입력값
			tb_pdinfoxm.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			tb_pdinfoxm.setRowCnt(20);						// 기본 페이징 단위 : 20
			tb_pdinfoxm.setPagerMaxPageItems(20);
		}
		
		tb_pdinfoxm.setCount(productEventMgrService.getObjectCount(tb_pdinfoxm));
		tb_pdinfoxm.setList(productEventMgrService.getObjectList(tb_pdinfoxm));
		
		model.addAttribute("obj", tb_pdinfoxm);								//리스트
		model.addAttribute("totalCnt", tb_pdinfoxm.getCount());		//전체 카운트
		model.addAttribute("rowCnt", tb_pdinfoxm.getRowCnt());		//페이지 목록수
		
		//링크설정
		String strLink = null;
		strLink =	"&schGbn="+StringUtil.nullCheck(tb_pdinfoxm.getSchGbn())+										//검색구분
				  		"&schTxt="+StringUtil.nullCheck(tb_pdinfoxm.getSchTxt())+											//검색어
				  		"&datepickerStr="+StringUtil.nullCheck(request.getParameter("datepickerStr")) + 			//시작일
				  		"&datepickerEnd="+StringUtil.nullCheck(request.getParameter("datepickerEnd")) + 			//종료일
				  		//"&SALE_CON="+StringUtil.nullCheck(tb_pdinfoxm.getSALE_CON())+									//판매상태
				  		"&pagerMaxPageItems="+StringUtil.nullCheck(tb_pdinfoxm.getPagerMaxPageItems())+	//페이지순번				  		
				  		"&sortGubun="+StringUtil.nullCheck(tb_pdinfoxm.getSortGubun())+								//정렬구분
				  		"&sortOdr="+StringUtil.nullCheck(tb_pdinfoxm.getSortOdr());										//정렬기준 
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/productEventMgr/eventlist");		
	}

	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductEventMgrController.java
	 * @Method	: event
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 행사상품관리 수정화면
	 * @Company	: YT Corp.
	 * @Author	: Ji-won Chang (Chjw@youngthink.co.kr)
	 * @Date	: 2019-05-08
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/event"}, method=RequestMethod.GET)
	public ModelAndView event(@ModelAttribute TB_PDINFOXM tb_pdinfoxm, Model model, HttpServletRequest request) throws Exception {		
		// 기존 행사정보
		tb_pdinfoxm.setList(productEventMgrService.getPaginatedObjectList(tb_pdinfoxm));
		model.addAttribute("tb_pdinfoxm", tb_pdinfoxm);
	
		return new ModelAndView("admin.layout", "jsp", "admin/productEventMgr/eventform");
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductEventMgrController.java
	 * @Method	: nvent
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 행사상품관리 신규등록화면
	 * @Company	: YT Corp.
	 * @Author	: Ji-won Chang (Chjw@youngthink.co.kr)
	 * @Date	: 2019-05-08
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/new"}, method=RequestMethod.GET)
	public ModelAndView event2(@ModelAttribute TB_PDINFOXM tb_pdinfoxm, Model model, HttpServletRequest request) throws Exception {		
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
		
		if( inputFlashMap != null ) {
			model.addAttribute("errlist", inputFlashMap.get("errlist"));
		}
		
		return new ModelAndView("admin.layout", "jsp", "admin/productEventMgr/eventform");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductEventMgrController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 행사상품 등록
	 * @Company	: YT Corp.
	 * @Author	: Ji-won Chang (Chjw@youngthink.co.kr)
	 * @Date	: 2019-05-08
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
	public ModelAndView update(@ModelAttribute TB_PDINFOXM tb_pdinfoxm, HttpServletRequest request, Model model ) throws Exception {
		// 작성자 setting
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_pdinfoxm.setREGP_ID(loginUser.getMEMB_ID());		
		tb_pdinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		String[] splitCd = tb_pdinfoxm.getPD_CODE().split(",");
		
		// 행사상품 업데이트
		if(splitCd.length>0 && !tb_pdinfoxm.getPD_CODE().equals("")){
			for(int i=0;i<splitCd.length;i++){
				// update 데이터 확인
				//System.out.println(splitCd[i]);
				//System.out.println(request.getParameterValues("PDDC_GUBN")[i]);
				//System.out.println(request.getParameterValues("PDDC_VAL")[i]);
				
				tb_pdinfoxm.setPD_CODE(splitCd[i]);
				tb_pdinfoxm.setPDDC_GUBN(request.getParameterValues("PDDC_GUBN")[i]);
				tb_pdinfoxm.setPDDC_VAL(request.getParameterValues("PDDC_VAL")[i]);			
				
				productEventMgrService.updateObject(tb_pdinfoxm);
			}
		}
				
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/productEventMgr");		
		return new ModelAndView(redirectView);
	}	


	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductEventMgrController.java
	 * @Method	: excel
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 행사상품 엑셀 업로드/다운로드
	 * @Company	: YT Corp.
	 * @Author	: Ji-won Chang (Chjw@youngthink.co.kr)
	 * @Date	: 2019-05-08 (오후 12:18:15)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_pdrcmdxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/excelDownload",method=RequestMethod.GET)
	public void excelDownload(@ModelAttribute TB_PDINFOXM tb_pdinfoxm, HttpServletResponse response, Model model) throws Exception{
		
		String[] headerName = {"상품바코드","상품명","할인금액","할인구분","판매가","행사가"};
		String[] columnName = {"PD_BARCD","PD_NAME","PDDC_VAL","PDDC_GUBN","PD_PRICE","REAL_PRICE"};

		String sheetName = "행사상품엑셀";
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) productEventMgrService.getDetailExcelList(tb_pdinfoxm);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}	
	
	@RequestMapping(value="/excelUpload",method=RequestMethod.POST)
	public ModelAndView excelUpload(@ModelAttribute TB_PDINFOXM tb_pdinfoxm, HttpServletRequest request, Model model, MultipartHttpServletRequest multipartRequest, RedirectAttributes redirectAttributes) throws Exception{
		String strRtrUrl = "";
		
		// 유저 setting
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_pdinfoxm.setREGP_ID(loginUser.getMEMB_ID()); 
		tb_pdinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		List<TB_PDINFOXM> errlist = new ArrayList<TB_PDINFOXM>(); 
		
		// 1.jsp에서 업로드 한 파일 읽기
		MultipartFile excelFile =multipartRequest.getFile("EXCEL_FILE");
		
        if(excelFile==null || excelFile.isEmpty()){
            throw new RuntimeException("엑셀파일을 선택 해 주세요.");
        }
        
		if ( StringUtils.isNotEmpty(excelFile.getOriginalFilename()) ) {
	        // 2.MultipartHttpServletRequest로 파일을 서버에 저장
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
	        excelReadOption.setOutputColumns("A","B","C");						//추출할 컬럼명
	        excelReadOption.setStartRow(3);										//추출을 시작할 행번호
	        
	        // 3.저장된 엑셀 파일 경로를 FileInputStream으로 읽어들여서 Workbook 객체로 만듬
	        List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);
	        logger.info("getNumCellCnt>>" + excelReadOption.getNumCellCnt());	//엑셀파일 컬럼수

			if (excelReadOption.getNumCellCnt() < 3) {	// 총컬럼은 5개지만 실사용 컬럼은 3개임으로 3로 지정
				ModelAndView mav = new ModelAndView();				
				mav.addObject("alertMessage", "엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식을 재다운로드 해주시기 바랍니다.");
				mav.addObject("returnUrl", "back");
				mav.setViewName("alertMessage");
				return mav;
			}
			
	        try{
	         	errlist = productEventMgrService.excelUpload(tb_pdinfoxm, excelContent);		//errlist에 upload 결과값 담기
	        }catch(SQLException e){
	        	ModelAndView mav = new ModelAndView();			
				mav.addObject("alertMessage", e.getStackTrace()+"\n엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식 다운로드 후 다시 저장 하세요.");
				mav.addObject("returnUrl", "back");
				mav.setViewName("alertMessage");
				return mav;
	        }
		}
		
		redirectAttributes.addFlashAttribute("errlist", errlist);
		
		// 업로드 에러가 있으면 form에서 errlist 출력
		if(errlist.size() <1){
			strRtrUrl = "/adm/productEventMgr";
		}else{
			strRtrUrl = "/adm/productEventMgr/event";
		}
		
		RedirectView rv = new RedirectView(servletContextPath.concat(strRtrUrl));
		return new ModelAndView(rv);
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductEventMgrController.java
	 * @Method	: pdpop
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 행사상품 상품팝업 (ajax)
	 * @Company	: YT Corp.
	 * @Author	: Ji-won Chang (Chjw@youngthink.co.kr)
	 * @Date	: 2020-02-10 (오후 12:18:15)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param productInfo
	 * @param result
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
	
		productInfo.setCount(productEventMgrService.getObjectCount(productInfo));
		productInfo.setList(productEventMgrService.getPaginatedObjectList(productInfo));	//전체조회
		
		return productInfo;
	}
	
	
	// 행사상품추가 팝업
	@RequestMapping(value={ "/eventpopup"}, method=RequestMethod.GET)
	public ModelAndView eventpopup(@ModelAttribute TB_PDINFOXM productInfo, Model model, HttpServletRequest request) throws Exception {
	
		//결과내 재검색 X
		List schTxt_befList = Arrays.asList(productInfo.getSchTxt());
		productInfo.setSchTxt_befList(schTxt_befList);			// 기본 검색어 만 List
		productInfo.setSchTxt_bef(productInfo.getSchTxt());	// 기본 검색어를 이전 검색어 hidden 데이터로 반영
		
		// 페이징
		if(request.getParameter("pagerMaxPageItems")!=null){
			productInfo.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));	
			productInfo.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {	//기본 페이징 단위 : 10
			productInfo.setRowCnt(10);	
			productInfo.setPagerMaxPageItems(10);
		}
		
		productInfo.setCount(productMgrService.getObjectCount(productInfo));
		productInfo.setList(productMgrService.getPaginatedObjectList(productInfo));
		model.addAttribute("obj", productInfo);
		
		//페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt());		//페이지 목록수
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
		
		return new ModelAndView("popup.layout", "jsp", "admin/productEventMgr/eventpopup");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: delete
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 추천상품삭제
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
	public ModelAndView delete(@ModelAttribute TB_PDRCMDXM tb_pdrcmdxm, BindingResult result, SessionStatus status, Model model) throws Exception {
		// 등록자 정보 변경필요
		tb_pdrcmdxm.setMODP_ID("admin");
		
		productEventMgrService.deleteObject(tb_pdrcmdxm);
		productEventMgrService.deleteProduct(tb_pdrcmdxm);
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/productRcmdMgr");		
		return new ModelAndView(redirectView);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductRcmdMgrController.java
	 * @Method	: update04
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
		
		productEventMgrService.deleteProduct(tb_pdinfoxm);
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/adm/productRcmdMgr/"+tb_pdrcmdxm.getGRP_CD());		
		return new ModelAndView(redirectView);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.MenuMgrController.java
	 * @Method	: insert04
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
		
		int updateCnt = productEventMgrService.getOrdrSameCnt(tb_pdrcmdxm);
		return updateCnt > 0 ? SUCCESS : FAILURE;
	}	
}
