package mall.web.controller.admin;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.apache.tomcat.util.json.JSONParser;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mysql.cj.core.util.LogUtils;


import aj.org.objectweb.asm.Attribute;
import mall.common.util.ExcelDownload;
import mall.common.util.FileUtil;
import mall.common.util.StringUtil;
import mall.common.util.excel.ExcelRead;
import mall.common.util.excel.ExcelReadOption;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_COMCODXD;
import mall.web.domain.TB_DELIVERY_ADDR;
import mall.web.domain.TB_EXTRPROD;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_PDSHIPXM;
import mall.web.domain.TB_SHIPTEXD;
import mall.web.domain.TB_SHIPTEXM;
import mall.web.domain.TB_SPINFOXM;
import mall.web.domain.TB_OPTCODXD;
import mall.web.domain.TB_PDCAGOXM;
import mall.web.domain.TB_PDCUTXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDOPTION;
import mall.web.domain.TB_PDSHIPXD;
import mall.web.service.admin.impl.CategoryMgrService;
import mall.web.service.admin.impl.ProductMgrService;
import mall.web.service.common.CommonService;
import mall.web.service.mall.ProductService;

@Controller
@RequestMapping(value="/adm/productMgr")
public class ProductMgrController extends DefaultController{

	private static final Logger logger = LoggerFactory.getLogger(ProductMgrController.class);

	private final RestTemplate restTemplate = new RestTemplate();

    private final ObjectMapper objectMapper = new ObjectMapper();


	@Resource(name="commonService")
	CommonService commonService;

	@Resource(name="categoryMgrService")
	CategoryMgrService categoryMgrService;
	
	@Resource(name="productMgrService")
	ProductMgrService productMgrService;
	
	@Resource(name="productService")
	ProductService productService;



	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 제품 목록 조회
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-07 (오후 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param productInfo
	 * @param model
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_PDINFOXM productInfo, Model model,HttpServletRequest request) throws Exception {
		
		//정렬 초기화
		if(StringUtils.isEmpty(productInfo.getSortGubun())){
			productInfo.setSortGubun("REG_DTM");
			productInfo.setSortOdr("desc");
		}
		
		//페이징 단위
		if(request.getParameter("pagerMaxPageItems")!=null){
			productInfo.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			productInfo.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else {
			productInfo.setRowCnt(20);
			productInfo.setPagerMaxPageItems(20);
		}
		
		//공통코드 - 할인구분
		TB_COMCODXD comCod = new TB_COMCODXD();
		comCod.setCOMM_CODE("PDDC_GUBN");
		model.addAttribute("codPDDC_GUBN", commonService.selectComCodList(comCod));
		
		//공통코드 - 판매상태
		comCod.setCOMM_CODE("SALE_CON");
		model.addAttribute("codSALE_CON", commonService.selectComCodList(comCod));
		
		
		// 단독 검색
		if(productInfo.getReSearch() == null || productInfo.getReSearch().toString().equals("")) {
			List schTxt_befList = Arrays.asList(productInfo.getSchTxt());
			productInfo.setSchTxt_befList(schTxt_befList);			// 기본 검색어 만 List
			productInfo.setSchTxt_bef(productInfo.getSchTxt());	// 기본 검색어를 이전 검색어 hidden 데이터로 반영
		// 결과 내 재검색
		} else {
			// 결과 내 재검색을 체크했으면
			if(!productInfo.getReSearch().toString().equals("")){				
				StringBuffer str = new StringBuffer();
				str.append(productInfo.getSchTxt_bef());
				
				String schTxt_first ="";
				String schTxt_last ="";
				
				if(productInfo.getSchTxt_bef().length() > 0){
					List<String> schTxt_bef_list = Arrays.asList(str.toString().split(","));
					
					if(schTxt_bef_list.size()>0){
						schTxt_first = schTxt_bef_list.get(0);						
						schTxt_last = schTxt_bef_list.get(schTxt_bef_list.size()-1);
					}
				}
				// 최초 검색어가 같으면 재검색이므로 ...
				if(schTxt_first.equals(productInfo.getSchTxt().toString())){	
					
					if(schTxt_last.equals(productInfo.getReSearch().toString())){						
						List schTxt_befList = Arrays.asList(productInfo.getSchTxt_bef().toString().split(","));
						productInfo.setSchTxt_befList(schTxt_befList);
					// 결과 내 재검색 이 null 이 아닌대 on도 아니면 페이징으로 간주 기존 값 매칭
					}else{ 
						
						if(productInfo.getSchTxt_bef().length() > 0) {
							str.append(",");
						}
						
						str.append(productInfo.getReSearch().toString());
						productInfo.setSchTxt_bef(str.toString());
						
						List schTxt_befList = Arrays.asList(str.toString().split(","));
						productInfo.setSchTxt_befList(schTxt_befList);
					}
				}else{
					List schTxt_befList = Arrays.asList(productInfo.getSchTxt());
					productInfo.setSchTxt_befList(schTxt_befList);	// 기본 검색어 만 List
					productInfo.setSchTxt_bef(productInfo.getSchTxt());	// 기본 검색어를 이전 검색어 hidden 데이터로 반영
					
					// 재검색정보초기화
					productInfo.setReSearch("");	
				}
			}				
		}
		
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		productInfo.setSUPR_ID(loginUser.getSUPR_ID());		
		productInfo.setMEMB_GUBN(loginUser.getMEMB_GUBN());
		
		//admin 계정일경우
		if(productInfo.getMEMB_GUBN().equals("MEMB_GUBN_03")){
			productInfo.setCount(productMgrService.getObjectCountAdmin(productInfo));
			productInfo.setList(productMgrService.getPaginatedObjectListAdmin(productInfo));
			model.addAttribute("obj", productInfo);

		//admin 계정 외
		}else {
			productInfo.setCount(productMgrService.getObjectCount(productInfo));
			productInfo.setList(productMgrService.getPaginatedObjectList(productInfo));
			model.addAttribute("obj", productInfo);

		}

		//페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount());			//전체 카운트

		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn())+
				  	 "&schTxt_bef="+URLEncoder.encode(StringUtil.nullCheck(productInfo.getSchTxt_bef()),"UTF-8") +
					 "&schTxt="+URLEncoder.encode(StringUtil.nullCheck(productInfo.getSchTxt()),"UTF-8")+
				  	 "&reSearch="+URLEncoder.encode(StringUtil.nullCheck(productInfo.getReSearch()),"UTF-8")+
				  	 "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
				  	 "&pagerMaxPageItems="+StringUtil.nullCheck(productInfo.getPagerMaxPageItems())+
				  	 "&ONDY_GUBN="+StringUtil.nullCheck(productInfo.getONDY_GUBN())+
				  	 "&salecon_sch="+StringUtil.nullCheck(productInfo.getSalecon_sch())+
				  	 "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/productMgr/list");
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductMgrController.java
	 * @Method	: view
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품 상세 조회
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-08 (오전 9:31:25)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param productInfo
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/edit/{PD_CODE}", "/new"}, method=RequestMethod.GET)
	public ModelAndView view(@ModelAttribute TB_PDINFOXM productInfo,  Model model, HttpServletRequest request) throws Exception {		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		
		//카테고리 받아오기
		TB_PDCAGOXM category = new TB_PDCAGOXM();
		model.addAttribute("categoryList", categoryMgrService.getObjectList(category));
		
		//2020.02.12 공급업체 리스트 조회
		model.addAttribute("suprList", productMgrService.getSuprList(productInfo));
		
		TB_MBINFOXM supr_id = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		model.addAttribute("suprid", supr_id.getSUPR_ID());
		
		//조합원 배송비 가져오기
		TB_SPINFOXM tb_spinfoxm = new TB_SPINFOXM();
		tb_spinfoxm.setSUPR_ID(loginUser.getSUPR_ID());
		
		tb_spinfoxm = (TB_SPINFOXM)productMgrService.getSuprInfo(tb_spinfoxm);
		model.addAttribute("tb_spinfoxm", tb_spinfoxm);
		
		if(StringUtils.isNotEmpty(productInfo.getPD_CODE())){
			//옵션 유무 및 옵션조회
			productInfo.setSUPR_NAME(loginUser.getCOM_NAME());
			productInfo.setSUPR_ID(loginUser.getSUPR_ID());
		
			
			List<?> pdoption = productMgrService.getOptionList(productInfo);
			if(!pdoption.isEmpty()) {
				model.addAttribute("optionList", pdoption);
			}
			
			List<?> pdoptiontitle = productMgrService.getOptionTitle(productInfo);
			if(!pdoptiontitle.isEmpty()) {
				model.addAttribute("optiontitle", pdoptiontitle);
			}
		
			/* 배송정보 - 이유리 */
			TB_PDSHIPXM tb_pdshipxm = new TB_PDSHIPXM();
			tb_pdshipxm.setPD_CODE(productInfo.getPD_CODE());
			
			TB_PDSHIPXD tb_pdshipxd = new TB_PDSHIPXD();
			tb_pdshipxd.setPD_CODE(productInfo.getPD_CODE());
			
			TB_SHIPTEXM tb_shiptexm = new TB_SHIPTEXM();
			tb_shiptexm.setSUPR_ID(loginUser.getSUPR_ID());
			
			tb_pdshipxm = (TB_PDSHIPXM)productMgrService.getShipMaster(tb_pdshipxm);
			model.addAttribute("tb_pdshipxm", tb_pdshipxm);
			
			tb_pdshipxd.setList(productMgrService.getShipDetail(tb_pdshipxd));
			model.addAttribute("tb_pdshipxd", tb_pdshipxd);
			
			tb_shiptexm.setList(productMgrService.getTempMasterList(tb_shiptexm));
			model.addAttribute("tb_shiptexm", tb_shiptexm);
			/* 배송비 여기까지 */
			
			if(!pdoptiontitle.isEmpty()) {
				model.addAttribute("optiontitle", pdoptiontitle);
			}
			
			TB_PDINFOXM pdtInfo = (TB_PDINFOXM)productMgrService.getObject(productInfo);
			model.addAttribute("productInfo", pdtInfo);
			
			List<?> pdcut = productMgrService.getProCutList(productInfo);
			model.addAttribute("productCut", pdcut);
			
			List<?> extrPrd = productMgrService.getSavedExtPrdList(productInfo);
			model.addAttribute("extrPrd",extrPrd);
			
			//주소정보가져오기- 장보라
			TB_DELIVERY_ADDR tb_delivery_addr=new TB_DELIVERY_ADDR();
			System.out.println("ADD_NUM:"+pdtInfo.getADD_NUM());
			tb_delivery_addr=(TB_DELIVERY_ADDR)productMgrService.getDeliveryInfo(pdtInfo);
			model.addAttribute("tb_delivery_addr", tb_delivery_addr);

			//파일 받아오기 - 마스터이미지
			if(StringUtils.isNotEmpty(pdtInfo.getATFL_ID())){
				TB_COATFLXD commonFile = new TB_COATFLXD();
				commonFile.setATFL_ID(pdtInfo.getATFL_ID());
				model.addAttribute("fileList", commonService.selectFileList(commonFile));
			}
			
			//파일 받아오기 - 상세이미지
			if(StringUtils.isNotEmpty(pdtInfo.getDTL_ATFL_ID())){
				TB_COATFLXD commonDtlFile = new TB_COATFLXD();
				commonDtlFile.setATFL_ID(pdtInfo.getDTL_ATFL_ID());
				model.addAttribute("fileDtlList", commonService.selectFileList(commonDtlFile));
			}
		} else {
			productInfo.setSUPR_NAME(loginUser.getCOM_NAME());
			productInfo.setSUPR_ID(loginUser.getSUPR_ID());
		
			// 신규 등록시 default value 			
			// 업체코드 : C00001(YTMALL) 2020.02.13
			model.addAttribute("product", productInfo);
			
			//템플릿 리스트
			TB_SHIPTEXM tb_shiptexm = new TB_SHIPTEXM();
			tb_shiptexm.setSUPR_ID(loginUser.getSUPR_ID());
			tb_shiptexm.setList(productMgrService.getTempMasterList(tb_shiptexm));
			model.addAttribute("tb_shiptexm", tb_shiptexm);
		}
		
		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn())+
				  	 "&schTxt="+URLEncoder.encode(StringUtil.nullCheck(productInfo.getSchTxt()),"UTF-8")+
				  	 "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
				  	 "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/productMgr/form");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductMgrController.java
	 * @Method	: updateList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 목록 선택상품 업데이트
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param productInfo
	 * @param model
	 * @param request
	 * @param saveValues
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/updateList"}, method=RequestMethod.POST)
	public ModelAndView updateList(@ModelAttribute TB_PDINFOXM productInfo, Model model,HttpServletRequest request,
			@RequestParam String[] saveValues) throws Exception {
			
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		productInfo.setREGP_ID(loginUser.getMEMB_ID());		
		
		for(int i=0; i<saveValues.length; i++){
			String[] saveVal = saveValues[i].toString().split("!!@");
			
			productInfo.setPD_CODE(saveVal[0].toString());
			productInfo.setPDDC_GUBN(saveVal[1].toString());
			productInfo.setSALE_CON(saveVal[2].toString());
						 
			if(saveVal.length>3){
				//System.out.println("saveVal[3]==="+saveVal[3].toString());
				productInfo.setPD_PRICE(saveVal[3].toString());
				productMgrService.updateList(productInfo);
			}else{
				productMgrService.updateList(productInfo);
			}
		}
		//링크설정
		String strRtrUrl ="";		
		String strLink = null;
		
		strLink = "schGbn="+StringUtil.nullCheck(productInfo.getSchGbn())+
					  "&schTxt_bef="+URLEncoder.encode(StringUtil.nullCheck(productInfo.getSchTxt_bef()),"UTF-8") +
					  "&schTxt="+URLEncoder.encode(StringUtil.nullCheck(productInfo.getSchTxt()),"UTF-8")+
					  "&reSearch="+URLEncoder.encode(StringUtil.nullCheck(productInfo.getReSearch()),"UTF-8")+
				      "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
				      "&pagerMaxPageItems="+StringUtil.nullCheck(productInfo.getPagerMaxPageItems())+
				      "&pageNum="+StringUtil.nullCheck(productInfo.getPageNum())+
				      "&ONDY_GUBN="+StringUtil.nullCheck(productInfo.getONDY_GUBN())+
				      "&salecon_sch="+StringUtil.nullCheck(productInfo.getSalecon_sch())+
				      "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr());
		
		strRtrUrl = "/adm/productMgr?"+strLink;
		
	//	RedirectView rv = new RedirectView(servletContextPath.concat(strRtrUrl));
		RedirectView rv = new RedirectView(servletContextPath + "/adm/productMgr");
		return new ModelAndView(rv); 
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductMgrController.java
	 * @Method	: insert
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 제품정보 등록/수정
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-07 (오후 11:05:15)
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
	public ModelAndView insert(@ModelAttribute TB_PDINFOXM productInfo, 
							   @ModelAttribute TB_COATFLXD comFile, 
							   @ModelAttribute TB_PDCUTXM productcut,
							   @ModelAttribute TB_PDSHIPXM tb_pdshipxm,
							   @ModelAttribute TB_PDSHIPXD tb_pdshipxd,
							   String TEMP_NAME,
			HttpServletRequest request, Model model, MultipartHttpServletRequest multipartRequest) throws Exception {
		String strRtrUrl = "";
		// 로그인정보
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		productInfo.setREGP_ID(loginUser.getMEMB_ID());
		comFile.setREGP_ID(loginUser.getMEMB_ID());
		
//		// 공급사코드 체크	
//		if(StringUtils.isEmpty(productInfo.getSUPR_ID())){
//			productInfo.setSUPR_ID("C00001");
//			productInfo.setSUPR_NAME(loginUser.getCOM_NAME());
//			productInfo.setSUPR_ID(loginUser.getSUPR_ID());
//			
//		}
		
		//첨부파일이 두개 이상일 경우 객체하나씩 추가
		TB_COATFLXD comDtlFile = new TB_COATFLXD();
		comDtlFile.setATFL_ID(productInfo.getDTL_ATFL_ID()); 
		comDtlFile.setREGP_ID(loginUser.getMEMB_ID()); 
		
		//첨부파일 처리
		String strATFL_ID = commonService.saveFile(comFile, request, multipartRequest, "file", "product", false);
		String strDTL_ATFL_ID = commonService.saveFile(comDtlFile, request, multipartRequest, "fileDtl", "product", false);
				
		String[] splitSeq = productcut.getSEQ().split("!!@");
		String[] splitCut = productcut.getCUT_UNIT().split("!!@");
		String[] splitUse = productcut.getUSE_YN().split("!!@");
		
		if(splitSeq.length>0 && !productcut.getSEQ().equals("")){
			for(int i=0;i<splitSeq.length;i++){

				productcut.setPD_CODE_IN(productInfo.getPD_CODE_IN());
				productcut.setCAGO_ID(productInfo.getCAGO_ID());
				productcut.setCAGO_ID_LEN(productInfo.getCAGO_ID_LEN());
				
				productcut.setREGP_ID(loginUser.getMEMB_ID());
				productcut.setSEQ(splitSeq[i]);
				productcut.setCUT_UNIT(splitCut[i]);
				productcut.setUSE_YN(splitUse[i]);
				
				if(splitCut[i].equals("")){
					
				}else{
					productMgrService.insertProCut(productcut);
				}
		    }	
		}

		//링크설정
		String strLink = null;
		strLink = "pageNum="+StringUtil.nullCheck(productInfo.getPageNum())+
				  	 "&rowCnt="+StringUtil.nullCheck(productInfo.getRowCnt())+
				  	 "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn())+
				  	 "&schTxt="+URLEncoder.encode(StringUtil.nullCheck(productInfo.getSchTxt()),"UTF-8")+
				  	 "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
				  	 "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr());
		
		
		int nRtn = 0;
		// 상품코드가 있고, 수동입력이 아닐 경우
		if( StringUtils.isNotEmpty(productInfo.getPD_CODE()) && !productInfo.getPD_CODE_IN().equals("INPUT")){
		
			productInfo.setATFL_ID(strATFL_ID);
			productInfo.setDTL_ATFL_ID(strDTL_ATFL_ID);
			productInfo.setSUPR_NAME(loginUser.getCOM_NAME());   
			productInfo.setSUPR_ID(loginUser.getSUPR_ID());
			
			nRtn = productMgrService.updateObject(productInfo);
			
			System.out.println("상품가격"+productInfo.getPD_PRICE());
			//count 가 0 이라 이라면 수정
			int count = productMgrService.countOriginPrice(productInfo);
			System.out.println("번호 : "+count);
			if(count !=0) {
				productMgrService.updateOrignPrice(productInfo);
				productMgrService.updateOptionPrice(productInfo);
			}
			
			strRtrUrl = "/adm/productMgr/edit/"+ productInfo.getPD_CODE() + "?" +strLink;
		}else{
			
			productInfo.setSUPR_NAME(loginUser.getCOM_NAME());   
			productInfo.setSUPR_ID(loginUser.getSUPR_ID());      
			productInfo.setATFL_ID(strATFL_ID);
			productInfo.setDTL_ATFL_ID(strDTL_ATFL_ID);
			productInfo.setCAGO_ID_LEN(productInfo.getCAGO_ID().length()+1);
			
			nRtn = productMgrService.insertObject(productInfo);
			//상품 등록 api
			
			
			
			
			
			
			
			
			
			strRtrUrl = "/adm/productMgr";
		}
		
		/* 상품코드 가져오기 - 이유리 */
		TB_PDSHIPXM shipInfo = new TB_PDSHIPXM();
		
		shipInfo = (TB_PDSHIPXM)productMgrService.getProductCode(productInfo);
		
		/* 배송비 설정 - 이유리 */
		int result = 0;
		int result1 = 0;
		int result2 = 0;
		
		//상품코드 입력
		tb_pdshipxd.setPD_CODE(shipInfo.getPD_CODE());
		tb_pdshipxm.setPD_CODE(shipInfo.getPD_CODE());
		
		if(StringUtils.isNotEmpty(shipInfo.getPD_CODE())) {
			//조합원코드 가져오기
			TB_PDINFOXM tb_pdinfoxm = new TB_PDINFOXM();
			tb_pdinfoxm.setPD_CODE(shipInfo.getPD_CODE());
			tb_pdinfoxm = (TB_PDINFOXM)productMgrService.selectSuprCode(tb_pdinfoxm);
			tb_pdshipxm.setSUPR_ID(tb_pdinfoxm.getSUPR_ID());
			tb_pdshipxd.setSUPR_ID(tb_pdinfoxm.getSUPR_ID());
		} else {
			tb_pdshipxm.setSUPR_ID(loginUser.getSUPR_ID());
			tb_pdshipxd.setSUPR_ID(loginUser.getSUPR_ID());
		}
		
		//배송비 디테일 삭제
		productMgrService.deleteShipDetail(tb_pdshipxd);
		
		if(tb_pdshipxm.getSHIP_CONFIG().equals("SHIP_CONFIG_02")) {
			System.out.println("1번");
			tb_pdshipxm.setTEMP_NUM("");
			
			//배송비 디테일 입력
			if(tb_pdshipxm.getSHIP_GUBN().equals("SHIP_GUBN_03") || tb_pdshipxm.getSHIP_GUBN().equals("SHIP_GUBN_04")) {
				if(tb_pdshipxd.getDLVY_AMTS().length != 0) {
					int length = tb_pdshipxd.getDLVY_AMTS().length;
					
					for(int i = 0; i < length; i++) {
						tb_pdshipxd.setGUBN_START(tb_pdshipxd.getGUBN_STARTS()[i]);
						tb_pdshipxd.setGUBN_END(tb_pdshipxd.getGUBN_ENDS()[i]);
						tb_pdshipxd.setDLVY_AMT(tb_pdshipxd.getDLVY_AMTS()[i]);
						tb_pdshipxd.setSHIP_SEQ(i+1);
						
						result += productMgrService.updateShipDetail(tb_pdshipxd);
					}
					
					System.out.println("result 값 : " + result);
				}
			}
			
			result2 = productMgrService.updateShipMaster(tb_pdshipxm);
			
		} else if(tb_pdshipxm.getSHIP_CONFIG().equals("SHIP_CONFIG_03")) {
			System.out.println("2번");
			tb_pdshipxm.setDLVY_GUBN("");
			tb_pdshipxm.setSHIP_GUBN("");
			tb_pdshipxm.setGUBN_START("");
			tb_pdshipxm.setDLVY_AMT("");
			tb_pdshipxm.setRFND_DLVY_AMT("");
			
			if(StringUtils.isEmpty(tb_pdshipxm.getTEMP_NUM())) {
				TB_SHIPTEXM tb_shiptexm = new TB_SHIPTEXM();
				tb_shiptexm.setSUPR_ID(loginUser.getSUPR_ID());
				tb_shiptexm.setTEMP_NAME(TEMP_NAME);
				
				tb_shiptexm = (TB_SHIPTEXM)productMgrService.getTempMaster(tb_shiptexm);
				tb_pdshipxm.setTEMP_NUM(tb_shiptexm.getTEMP_NUM());
			}
			
			result2 = productMgrService.updateShipMaster(tb_pdshipxm);
		} else {
			if(StringUtils.isEmpty(tb_pdshipxm.getTEMP_NUM())) {
				tb_pdshipxm.setTEMP_NUM("");
			}
			
			//공급업체 배송비 조건 변경
			result1 = productMgrService.updateSuprInfo(tb_pdshipxm);
			result2 = productMgrService.updateShipMaster(tb_pdshipxm);
		}
		
		RedirectView rv = new RedirectView(servletContextPath.concat(strRtrUrl));
		return new ModelAndView(rv);
	}	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductMgrController.java
	 * @Method	: deletePrd
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품삭제
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param productInfo
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/optionSetting", method=RequestMethod.POST)
	@ResponseBody
	 public ModelAndView optionSetting(@RequestParam String data, HttpServletRequest request, Model model) throws Exception {
	    String strRtrUrl = "/adm/productMgr";
	    
	    JSONArray optiondatas = new JSONArray(data);
	    String pd_code = optiondatas.getJSONObject(0).getString("PD_CODE");
	    
	    if(pd_code != "" && pd_code != null) {
			TB_PDOPTION topn = new TB_PDOPTION();
			topn.setPD_CODE(pd_code);
			int delCnt = productMgrService.optionDelete(topn);			
		}
	    // 옵션 전체 저장 
	    for(int i =0; i< optiondatas.length();i++ ){
	       JSONObject temp = optiondatas.getJSONObject(i);
	       if(!temp.getString("OPTION_NAME").equals("")) {
	          TB_PDOPTION tb_pdoption = new TB_PDOPTION();
	          tb_pdoption.setPD_CODE(temp.getString("PD_CODE"));
	          tb_pdoption.setOPTION_VALUE(temp.getString("OPTION_VALUE"));
	          tb_pdoption.setOPTION_NAME(temp.getString("OPTION_NAME"));
	          tb_pdoption.setDEL_YN("N");
		       tb_pdoption.setSELL_YN("Y");
	          int test = productMgrService.optionInsert(tb_pdoption);
	       }else {
	          break;
	       }
	    }
	    int cnt = 0;
	    for(int i =0; i< optiondatas.length();i++ ) {
	       JSONObject temp = optiondatas.getJSONObject(i);
	       TB_PDOPTION tb_pdoption = new TB_PDOPTION();
	       tb_pdoption.setPD_CODE(temp.getString("PD_CODE"));
	       tb_pdoption.setOPTION1_VALUE(temp.getString("OPTION1_VALUE"));
	       tb_pdoption.setOPTION1_NAME(temp.getString("OPTION1_NAME"));
	       tb_pdoption.setQUANTITY(temp.getString("QUANTITY"));
	       tb_pdoption.setPRICE(temp.getString("PRICE"));
	       tb_pdoption.setOPTION2_NAME(temp.getString("OPTION2_NAME"));
	       tb_pdoption.setOPTION2_VALUE(temp.getString("OPTION2_VALUE"));
	       tb_pdoption.setOPTION3_NAME(temp.getString("OPTION3_NAME"));
	       tb_pdoption.setOPTION3_VALUE(temp.getString("OPTION3_VALUE"));
	       tb_pdoption.setMGR_CODE(temp.getString("MGR_CODE"));
	       tb_pdoption.setOPTION_ORIG_PRICE(temp.getString("OPTION_ORIG_PRICE"));
	       tb_pdoption.setDEL_YN(temp.getString("DEL_YN"));
	       tb_pdoption.setSELL_YN(temp.getString("SELL_YN"));
	       productMgrService.optionUpdate(tb_pdoption);
	       cnt += productMgrService.optionInsert(tb_pdoption);
	    };
	    
	    RedirectView rv = new RedirectView(servletContextPath.concat(strRtrUrl));
	    return new ModelAndView(rv);
	 }
	   
	//옵션삭제
	@ResponseBody
	@RequestMapping(value="/optionDelete", method=RequestMethod.POST)
	public String optionDelete(@RequestParam String MAIN_CODE, @ModelAttribute TB_PDOPTION tb_pdoption, HttpServletRequest request, Model model) throws Exception {
		tb_pdoption.setPD_CODE(MAIN_CODE);
		System.out.println("pd_code(삭제) : "+tb_pdoption.getPD_CODE());
		int delCnt = productMgrService.optionDelete(tb_pdoption);			
		String message ="";
		if ( delCnt > 0 ) {
			message ="success";
		}else {
		   message ="false";
		}
		return message;
	}
	
	
	// 상품옵션검색
	@RequestMapping(value = { "/searchPop/{SUPR_ID}" }, method = RequestMethod.GET)
	public ModelAndView popup(@ModelAttribute TB_PDINFOXM productInfo,@PathVariable("SUPR_ID") String SUPR_ID, Model model, HttpServletRequest request)
			throws Exception {

		// 결과내 재검색 X
		List schTxt_befList = Arrays.asList(productInfo.getSchTxt());
		productInfo.setSchTxt_befList(schTxt_befList); // 기본 검색어 만 List
		productInfo.setSchTxt_bef(productInfo.getSchTxt()); // 기본 검색어를 이전 검색어 hidden 데이터로 반영
		productInfo.setMODE("searchPop"); //검색mode
		productInfo.setSUPR_ID(SUPR_ID); 
		// 페이징
		if (request.getParameter("pagerMaxPageItems") != null) {
			productInfo.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			productInfo.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		} else {
			productInfo.setRowCnt(10); // 기본 페이징 단위 : 10
			productInfo.setPagerMaxPageItems(10);
		}
		
		productInfo.setCount(productMgrService.getObjectCountAdmin(productInfo));
		productInfo.setList(productMgrService.getPaginatedObjectListAdmin(productInfo));
		model.addAttribute("obj", productInfo);

		// 페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt()); // 페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount()); // 전체 카운트

		// 링크설정
		String strLink = null;
		strLink = "&schGbn=" + StringUtil.nullCheck(productInfo.getSchGbn()) + "&schTxt="
				+ StringUtil.nullCheck(productInfo.getSchTxt()) + "&sortGubun="
				+ StringUtil.nullCheck(productInfo.getSortGubun()) + "&sortOdr="
				+ StringUtil.nullCheck(productInfo.getSortOdr()) + "&pagerMaxPageItems="
				+ StringUtil.nullCheck(productInfo.getPagerMaxPageItems());
		
		model.addAttribute("type","searchPop");	
		model.addAttribute("supr_id",SUPR_ID);
		model.addAttribute("link", strLink);

		return new ModelAndView("popup.layout", "jsp", "admin/productMgr/searchPopup");
	}
	
	//다른상품옵션불러오기
	@RequestMapping(value = { "/getOptionPop/{SUPR_ID}" }, method = RequestMethod.GET)
	public ModelAndView getOptionPopup(@ModelAttribute TB_PDINFOXM productInfo,@PathVariable("SUPR_ID") String SUPR_ID, Model model, HttpServletRequest request)
			throws Exception {

		// 결과내 재검색 X
		List schTxt_befList = Arrays.asList(productInfo.getSchTxt());
		productInfo.setSchTxt_befList(schTxt_befList); // 기본 검색어 만 List
		productInfo.setSchTxt_bef(productInfo.getSchTxt()); // 기본 검색어를 이전 검색어 hidden 데이터로 반영
		productInfo.setMODE("getOption");
		productInfo.setSUPR_ID(SUPR_ID);

		// 페이징
		if (request.getParameter("pagerMaxPageItems") != null) {
			productInfo.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			productInfo.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		} else {
			productInfo.setRowCnt(10); // 기본 페이징 단위 : 10
			productInfo.setPagerMaxPageItems(10);
		}

		productInfo.setCount(productMgrService.getObjectCountAdmin(productInfo));
		productInfo.setList(productMgrService.getPaginatedObjectListAdmin(productInfo));
		model.addAttribute("obj", productInfo);

		// 페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt()); // 페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount()); // 전체 카운트

		// 링크설정
		String strLink = null;
		strLink = "&schGbn=" + StringUtil.nullCheck(productInfo.getSchGbn()) + "&schTxt="
				+ StringUtil.nullCheck(productInfo.getSchTxt()) + "&sortGubun="
				+ StringUtil.nullCheck(productInfo.getSortGubun()) + "&sortOdr="
				+ StringUtil.nullCheck(productInfo.getSortOdr()) + "&pagerMaxPageItems="
				+ StringUtil.nullCheck(productInfo.getPagerMaxPageItems());
		
		model.addAttribute("link", strLink);
		model.addAttribute("type","getOptionPop");
		model.addAttribute("supr_id",SUPR_ID);

		return new ModelAndView("popup.layout", "jsp", "admin/productMgr/searchPopup");
	}
	
	//추가상품 불러오기
	@RequestMapping(value = { "/getExtraPrd/{SUPR_ID}" }, method = RequestMethod.GET)
	public ModelAndView getExtraPrd(@ModelAttribute TB_PDINFOXM productInfo,@PathVariable("SUPR_ID") String SUPR_ID, Model model, HttpServletRequest request)
			throws Exception {

		// 결과내 재검색 X
		List schTxt_befList = Arrays.asList(productInfo.getSchTxt());
		productInfo.setSchTxt_befList(schTxt_befList); // 기본 검색어 만 List
		productInfo.setSchTxt_bef(productInfo.getSchTxt()); // 기본 검색어를 이전 검색어 hidden 데이터로 반영
		productInfo.setSUPR_ID(SUPR_ID);
		// 페이징
		if (request.getParameter("pagerMaxPageItems") != null) {
			productInfo.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
			productInfo.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		} else {
			productInfo.setRowCnt(10); // 기본 페이징 단위 : 10
			productInfo.setPagerMaxPageItems(10);
		}
		productInfo.setMODE("extraPrd");
		productInfo.setCount(productMgrService.getObjectCountAdmin(productInfo));
		productInfo.setList(productMgrService.getPaginatedObjectListAdmin(productInfo));
		model.addAttribute("obj", productInfo);

		// 페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt()); // 페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount()); // 전체 카운트
		
		// 링크설정
		String strLink = null;
		strLink = "&schGbn=" + StringUtil.nullCheck(productInfo.getSchGbn()) + "&schTxt="
				+ StringUtil.nullCheck(productInfo.getSchTxt()) + "&sortGubun="
				+ StringUtil.nullCheck(productInfo.getSortGubun()) + "&sortOdr="
				+ StringUtil.nullCheck(productInfo.getSortOdr()) + "&pagerMaxPageItems="
				+ StringUtil.nullCheck(productInfo.getPagerMaxPageItems());
		
		model.addAttribute("link", strLink);
		model.addAttribute("type","getExtraPrd");
		model.addAttribute("supr_id",SUPR_ID);
		return new ModelAndView("popup.layout", "jsp", "admin/productMgr/searchPopup");
	}
	
	/* 기본 배송정보 팝업 - 이유리 */
	@RequestMapping(value = { "/getShippingPop" }, method = RequestMethod.GET)
	public ModelAndView getShippingPop(@ModelAttribute TB_PDSHIPXM tb_pdshipxm, Model model, HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		
		if(StringUtils.isNotEmpty(tb_pdshipxm.getPD_CODE())) {
			tb_pdshipxm.setSHIP_CONFIG("SHIP_CONFIG_01");
			tb_pdshipxm.setSHIP_GUBN("SHIP_GUBN_02");
			tb_pdshipxm.setPOP_Yn("Y");
			
			TB_PDSHIPXM pdshipInfo = new TB_PDSHIPXM();
			
			pdshipInfo = (TB_PDSHIPXM)productMgrService.getShipMaster(tb_pdshipxm);
			model.addAttribute("tb_pdshipxm", pdshipInfo);
		}
		
		if(StringUtils.isNotEmpty(tb_pdshipxm.getPD_CODE())) {
			//조합원코드 가져오기
			TB_PDINFOXM tb_pdinfoxm = new TB_PDINFOXM();
			tb_pdinfoxm.setPD_CODE(tb_pdshipxm.getPD_CODE());
			tb_pdinfoxm = (TB_PDINFOXM)productMgrService.selectSuprCode(tb_pdinfoxm);
			tb_pdshipxm.setSUPR_ID(tb_pdinfoxm.getSUPR_ID());
		} else {
			tb_pdshipxm.setSUPR_ID(loginUser.getSUPR_ID());
		}
		
		TB_SPINFOXM tb_spinfoxm = new TB_SPINFOXM();
		tb_spinfoxm.setSUPR_ID(tb_pdshipxm.getSUPR_ID());
		
		//조합원 배송비 가져오기
		tb_spinfoxm = (TB_SPINFOXM)productMgrService.getSuprInfo(tb_spinfoxm);
		model.addAttribute("tb_spinfoxm", tb_spinfoxm);
		
		return new ModelAndView("popup.layout", "jsp", "admin/productMgr/shippingPopup");
	}
	
	/* 템플릿 팝업 리스트 - 이유리 */
	@RequestMapping(value = { "/getTempletePop" }, method = RequestMethod.GET)
	public ModelAndView getTempletePop(Model model, HttpServletRequest request) throws Exception {
		
		TB_SHIPTEXM tb_shiptexm = new TB_SHIPTEXM();
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_shiptexm.setSUPR_ID(loginUser.getSUPR_ID());
		
		tb_shiptexm.setList(productMgrService.getTempMasterList(tb_shiptexm));
		model.addAttribute("tb_shiptexm", tb_shiptexm);
		
		return new ModelAndView("popup.layout", "jsp", "admin/productMgr/templetePopup");
	}
	
	/* 템플릿 팝업 디테일 - 이유리 */
	@RequestMapping(value = { "/templete/new" }, method = RequestMethod.GET)
	public ModelAndView newTemplete(Model model, HttpServletRequest request) throws Exception {
		
		return new ModelAndView("popup.layout", "jsp", "admin/productMgr/templeteDetail");
	}
	
	/* 템플릿 팝업 디테일 - 이유리 */
	@RequestMapping(value = { "/templete/edit" }, method = RequestMethod.GET)
	public ModelAndView editTemplete(@ModelAttribute TB_SHIPTEXM tb_shiptexm,
									 @ModelAttribute TB_SHIPTEXD tb_shiptexd,
									 Model model, HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_shiptexm.setSUPR_ID(loginUser.getSUPR_ID());
		
		tb_shiptexm = (TB_SHIPTEXM)productMgrService.getTempMaster(tb_shiptexm);
		
		tb_shiptexd.setTEMP_NUM(tb_shiptexm.getTEMP_NUM());
		tb_shiptexd.setList(productMgrService.getTempDetail(tb_shiptexd));
		
		
		model.addAttribute("tb_shiptexm", tb_shiptexm);
		model.addAttribute("tb_shiptexd", tb_shiptexd);
		
		return new ModelAndView("popup.layout", "jsp", "admin/productMgr/templeteDetail");
	}
	
	@RequestMapping(value="/getOptiontitle", method=RequestMethod.POST,  produces = "text/html; charset=utf8")
	@ResponseBody
	public String getOptiontitle(@RequestParam String data, HttpServletRequest request, Model model) throws Exception {
		
		System.out.println("data : "+data);
		TB_PDINFOXM tb_pdinfoxm = new TB_PDINFOXM();
		tb_pdinfoxm.setPD_CODE(data); 
		
		List<?> tb_pdoption =  productMgrService.getOptionTitle(tb_pdinfoxm); 
		String optionName ;
		String optionValue ;
		String result = ""; //'{"id":1,"name":"Test1"},{"id":2,"name":"Test2"}'
		for(int i =0;i < tb_pdoption.size();i++) {
			System.out.println("OPTION_NAME  : "+((TB_PDOPTION)tb_pdoption.get(i)).getOPTION_NAME());
			System.out.println("OPTION_VALUE : "+((TB_PDOPTION)tb_pdoption.get(i)).getOPTION_VALUE());
			if(i==0) {
				result += "{\"name\":\""+((TB_PDOPTION)tb_pdoption.get(i)).getOPTION_NAME()+"\",\"value\":\""+((TB_PDOPTION)tb_pdoption.get(i)).getOPTION_VALUE()+"\"}";				
			}else {
				result += ",{\"name\":\""+((TB_PDOPTION)tb_pdoption.get(i)).getOPTION_NAME()+"\",\"value\":\""+((TB_PDOPTION)tb_pdoption.get(i)).getOPTION_VALUE()+"\"}";
			}
		}
		
		return result;
	
	}
	
	@RequestMapping(value="/getExtraPrdlist", method=RequestMethod.POST,  produces = "text/html; charset=utf8")
	@ResponseBody
	public String getExtraPrdlist(@RequestParam String data, HttpServletRequest request, Model model) throws Exception {
		
		System.out.println("data : "+data);
		
		ArrayList<String> pdcodes = new ArrayList<>();
		String[] temp = data.split(",");
		for(int i =0; i < temp.length ; i++) {
			pdcodes.add(temp[i]);			
		}
		
		List<?> tb_pdinfo =  productMgrService.getExtraPrdlist(pdcodes); 
		
		String result = ""; //'{"id":1,"name":"Test1"},{"id":2,"name":"Test2"}'
		for(int i =0;i < tb_pdinfo.size();i++) {
			System.out.println("PD_CODE  : "+((TB_PDINFOXM)tb_pdinfo.get(i)).getPD_CODE());
			System.out.println("PD_NAME : "+((TB_PDINFOXM)tb_pdinfo.get(i)).getPD_NAME());
			System.out.println("PD_PRICE : "+((TB_PDINFOXM)tb_pdinfo.get(i)).getPD_PRICE());
			if(i==0) {
				result += "{\"PD_CODE\":\""+((TB_PDINFOXM)tb_pdinfo.get(i)).getPD_CODE()
						+"\",\"PD_NAME\":\""+((TB_PDINFOXM)tb_pdinfo.get(i)).getPD_NAME()
						+"\",\"PD_PRICE\":\""+((TB_PDINFOXM)tb_pdinfo.get(i)).getPD_PRICE()+"\"}";				
			}else {
				result += ",{\"PD_CODE\":\""+((TB_PDINFOXM)tb_pdinfo.get(i)).getPD_CODE()
						+"\",\"PD_NAME\":\""+((TB_PDINFOXM)tb_pdinfo.get(i)).getPD_NAME()
						+"\",\"PD_PRICE\":\""+((TB_PDINFOXM)tb_pdinfo.get(i)).getPD_PRICE()+"\"}";	
			}
		}
		
		return result;
	
	}
	
	@RequestMapping(value="/updateExtraPrdlist", method=RequestMethod.POST,  produces = "text/html; charset=utf8")
	@ResponseBody
	public String saveExtraPrdlist(@RequestParam(defaultValue = "1") String data,@RequestParam String PD_CODE ,@RequestParam String type , HttpServletRequest request, Model model) throws Exception {
		
		System.out.println("save data : "+data);

		TB_EXTRPROD tb_extrprod = new TB_EXTRPROD();
		String[] extraPrdcodes = data.split(",");
		int result = 0;
		tb_extrprod.setPD_CODE(PD_CODE);
		
		for(int i =0 ;i<extraPrdcodes.length;i++) {
			tb_extrprod.setEXTRA_PD_CODE(extraPrdcodes[i]);
			if(type.equals("insert")) {
				int check = productMgrService.checkExtrprod(tb_extrprod);
				if(check ==0 ) {
					result += productMgrService.insertExtrprod(tb_extrprod);
				}
			}else if(type.equals("delete")) {
				result += productMgrService.deleteExtrprod(tb_extrprod);
			}
		}
		
		return result+"";
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductMgrController.java
	 * @Method	: deletePrd
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품삭제
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param productInfo
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/deletePrd", method=RequestMethod.POST)
	public ModelAndView deletePrd(@ModelAttribute TB_PDINFOXM productInfo, HttpServletRequest request, Model model) throws Exception {
		
		//########## 상품삭제 로직변경 : Temp로 백업 후 Delete ###########
		String strRtrUrl = "/adm/productMgr";
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		productInfo.setREGP_ID(loginUser.getMEMB_ID());
		
		
		
		
		// 삭제상품 temp 테이블로 백업
		int tmpBackUp = 0;
		tmpBackUp = productMgrService.tmpInsertObject(productInfo);
		
		// 상품 삭제
		int deleteCnt = 0;
		if(tmpBackUp != 0){
			deleteCnt = productMgrService.deleteObject2(productInfo);			
		}
		
		if(deleteCnt ==0){
			ModelAndView mav = new ModelAndView();			
			mav.addObject("alertMessage", "상품이 삭제되지 않았습니다. 관리자에게 문의해주세요.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		RedirectView rv = new RedirectView(servletContextPath.concat(strRtrUrl));
		return new ModelAndView(rv);
		//############### 상품삭제 로직변경 End #################
		/*
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		productInfo.setREGP_ID(loginUser.getMEMB_ID());
		
		int deleteCnt = productMgrService.deletePrdObject(productInfo);
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/productMgr"));
		return new ModelAndView(rv);
		*/
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.MemberMgrController.java
	 * @Method	: CodeChk
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품코드/바코드 중복체크
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
	@RequestMapping(value="/pdCodeChk", method=RequestMethod.POST)
	public @ResponseBody String pdCodeChk(@ModelAttribute TB_PDINFOXM productInfo) throws Exception {
		//System.out.println(productInfo.getPD_CODE());
		
		int nCnt = productMgrService.pdCodeChk(productInfo);
		//System.out.println(nCnt+"");
		return nCnt+"";
	}
	
	@RequestMapping(value="/pdBarCodeChk", method=RequestMethod.POST)
	public @ResponseBody String pdBarCodeChk(@ModelAttribute TB_PDINFOXM productInfo) throws Exception {
		//System.out.println(productInfo.getPD_BARCD());
		
		int nCnt = productMgrService.pdBarCodeChk(productInfo);
		//System.out.println(nCnt+"");
		return nCnt+"";
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.MemberMgrController.java
	 * @Method	: getExcelList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품목록 엑셀 다운로드
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/excelDown" }, method=RequestMethod.GET)
	public void getExcelList(@ModelAttribute TB_PDINFOXM productInfo, Model model,HttpServletResponse response
			,@RequestParam(value="checkArray[]", defaultValue="") List<String> arrayParams) throws Exception {
		
		String[] headerName = {"제품코드","제품명","공급업체 ID","카테고리ID","카테고리명","제품가격","제품할인 구분","제품할인 값"
				,"재고수량","제품바코드","제품규격","유통기한","제조회사","원산지","판매상태","파일ID","대표이미지 순번"
				,"규격단위","면세과세구분","일배상품구분","박스할인여부","박스할인금액","비닐봉투색상","세절방식"
				,"상세첨부파일","상세첨부파일사용여부","개별배송 여부(INDIVIDUAL)","보관기준","팩킹기준"
				,"보관위치","한정수량","입수량"};
		String[] columnName = {
				"PD_CODE","PD_NAME","SUPR_ID","CAGO_ID","CAGO_NM","PD_PRICE","PDDC_GUBN","PDDC_VAL"
				,"INVEN_QTY","PD_BARCD","PD_STD","DTB_DLINE","MAKE_COM","ORG_CT","SALE_CON","ATFL_ID","RPIMG_SEQ"
				,"STD_UNIT","TAX_GUBN","ONDY_GUBN","BOX_PDDC_GUBN","BOX_PDDC_VAL","OPTION_GUBN","CUT_UNIT"
				,"DTL_ATFL_ID","DTL_USE_YN","DLVR_INDI_YN","KEEP_GUBN","PACKING_GUBN"
				,"KEEP_LOCATION","LIMIT_QTY","INPUT_CNT" };
		
		String sheetName = "상품목록";
		
		List<HashMap<String, String>> list = (List<HashMap<String, String>>) productMgrService.getExcelList(productInfo);
		
		ExcelDownload.excelDownloadOrder(response, list, headerName, columnName, sheetName);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.productMgrController.java
	 * @Method	: excelUpload
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 엑셀 상품단가 업로드
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
//	@RequestMapping(value="/excelUpload",method=RequestMethod.POST)
//	public ModelAndView excelUpload(@ModelAttribute TB_PDINFOXM tb_pdinfoxm,@RequestParam String type, HttpServletRequest request, Model model, MultipartHttpServletRequest multipartRequest) throws Exception{
//		
//		System.out.println("여기까지는 넘어오나?");
//		// 유저 setting
//		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
//		List<TB_PDINFOXM> list = null;
//		tb_pdinfoxm.setREGP_ID(loginUser.getMEMB_ID()); 
//		tb_pdinfoxm.setMODP_ID(loginUser.getMEMB_ID()); 
//		
//		// 사용자가 업로드한 엑셀 파일 초기화
//		MultipartFile excelFile =multipartRequest.getFile("EXCEL_FILE");
//		
//		// 파일이 비어있거나 파일을 선택하지 않았을 경우
//        if(excelFile==null || excelFile.isEmpty()){
//            throw new RuntimeException("엑셀파일을 선택 해 주세요.");
//        }
//        
//        //파일이 비어있지 않을 경우
//		if ( StringUtils.isNotEmpty(excelFile.getOriginalFilename()) ) {
//			
//			String saveFileName = FileUtil.saveFile2(request, excelFile, "jundan/tmp", false);
//			String savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/jundan/tmp" + File.separator;
//			
//			// 대상파일
//	        File destFile = new File(savePath+saveFileName);
//	        try{
//	        	// 업로드한 파일 데이터를 지정한 파일에 저장한다.
//	            excelFile.transferTo(destFile);
//	        }catch(IllegalStateException | IOException e){
//	            throw new RuntimeException(e.getMessage(),e);
//	        }
//	        
//	        //Service 단에서 가져온 코드 
//	        ExcelReadOption excelReadOption = new ExcelReadOption();
//	        excelReadOption.setFilePath(destFile.getAbsolutePath());
//	        excelReadOption.setOutputColumns("A","B", "C");
//	        excelReadOption.setStartRow(3);
//	        
//	        List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);
//	        logger.info("getNumCellCnt>>" + excelReadOption.getNumCellCnt());
//
//			if (excelReadOption.getNumCellCnt() != 3) {
//				ModelAndView mav = new ModelAndView();
//				
//				mav.addObject("alertMessage", "엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식 다운로드 후 다시 저장 하세요.");
//				mav.addObject("returnUrl", "back");
//				mav.setViewName("alertMessage");
//				return mav;
//			}
//			
//	        try{
//	        	list = productMgrService.excelUpload(tb_pdinfoxm, excelContent);
//	        	
//	        }catch(SQLException e){
//	        	ModelAndView mav = new ModelAndView();			
//				mav.addObject("alertMessage", e.getStackTrace()+"\n엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식 다운로드 후 다시 저장 하세요.");
//				mav.addObject("returnUrl", "back");
//				mav.setViewName("alertMessage");
//				return mav;
//	        }
//		}
//		
//		// 상품등록 파일 업로드 일 경우
//		if(type.equals("uploadPrds")) {
//			//프로시저 호출
//		}
//		
//		
//		List<TB_PDINFOXM> successlist = new ArrayList<>();
//		List<TB_PDINFOXM> errorlist = new ArrayList<>();
//		
//		// -1 : 실패 / 0 : 성공
//		for(TB_PDINFOXM tb : list)
//		{	
//			if (tb.getADC1_NAME().equals("0"))
//				successlist.add(tb);
//			else if(tb.getADC1_NAME().equals("-1"))
//				errorlist.add(tb);
//		}
//		
//		model.addAttribute("errlist", errorlist);
//		model.addAttribute("scslist", successlist);
//		
//		return new ModelAndView("admin.layout", "jsp", "admin/productMgr/excelResult");
//	}
	
	
	@RequestMapping(value="/excelUpload",method=RequestMethod.POST, produces = "text/html; charset=utf8")
	@ResponseBody
	public String excelUpload(@ModelAttribute TB_PDINFOXM tb_pdinfoxm, HttpServletRequest request, Model model, MultipartHttpServletRequest multipartRequest) throws Exception{
		
		// 유저 setting
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		List<TB_PDINFOXM> list = null;
		tb_pdinfoxm.setREGP_ID(loginUser.getMEMB_ID()); 
		tb_pdinfoxm.setMODP_ID(loginUser.getMEMB_ID()); 
		tb_pdinfoxm.setSUPR_ID(loginUser.getSUPR_ID());
		System.out.println("loginUser.getSUPR_ID() : "+loginUser.getSUPR_ID());

		// 사용자가 업로드한 엑셀 파일 초기화
		MultipartFile excelFile =multipartRequest.getFile("EXCEL_FILE");
		
		// 파일이 비어있거나 파일을 선택하지 않았을 경우
        if(excelFile==null || excelFile.isEmpty()){
            throw new RuntimeException("엑셀파일을 선택 해 주세요.");
        }
        
        //파일이 비어있지 않을 경우
		if ( StringUtils.isNotEmpty(excelFile.getOriginalFilename()) ) {
			
			String saveFileName = FileUtil.saveFile2(request, excelFile, "jundan/tmp", false);
			String savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/jundan/tmp" + File.separator;
			
			// 대상파일
	        File destFile = new File(savePath+saveFileName);
	        try{
	        	// 업로드한 파일 데이터를 지정한 파일에 저장한다.
	            excelFile.transferTo(destFile);
	        }catch(IllegalStateException | IOException e){
	            throw new RuntimeException(e.getMessage(),e);
	        }
	        
	        //Service 단에서 가져온 코드 
	        ExcelReadOption excelReadOption = new ExcelReadOption();
	        excelReadOption.setFilePath(destFile.getAbsolutePath());
	        excelReadOption.setOutputColumns("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P");
	        excelReadOption.setStartRow(4);
	        
	        List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);
	        logger.info("getNumCellCnt>>" + excelReadOption.getNumCellCnt());

//			if (excelReadOption.getNumCellCnt() != 16 ) {
//				ModelAndView mav = new ModelAndView();
//
//				mav.addObject("alertMessage", "엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식 다운로드 후 다시 저장 하세요.");
//				mav.addObject("returnUrl", "back");
//				mav.setViewName("alertMessage");
//				return "error";
//			}

			try{
	        	list = productMgrService.prdExcelUpload(tb_pdinfoxm, excelContent);
	        	System.out.println("list(Controller) : "+list.size()); 
	        	
	        }catch(SQLException e){
	        	ModelAndView mav = new ModelAndView();			
				mav.addObject("alertMessage", e.getStackTrace()+"\n엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식 다운로드 후 다시 저장 하세요.");
				mav.addObject("returnUrl", "back");
				mav.setViewName("alertMessage");
				return "error";
	        }
		}
		
		List<TB_PDINFOXM> successlist = new ArrayList<>();
		List<TB_PDINFOXM> errorlist = new ArrayList<>();
		
		// -1 : 실패 / 0 : 성공
		for(TB_PDINFOXM tb : list)
		{	
			if (tb.getADC1_NAME().equals("0"))
				successlist.add(tb);
			else if(tb.getADC1_NAME().equals("-1"))
				errorlist.add(tb);
		}
		
		model.addAttribute("errlist", errorlist);
		model.addAttribute("scslist", successlist);
		
		String jsonStr="";
		String resultjson ="[";
		System.out.println("size : " + list.size());
		for(int i = 0 ; i < list.size() ; i++) {
			
			if(i!=0) resultjson += ",";
			
			resultjson +="{\"UPLOAD_CODE\" : \""  +list.get(i).getUPLOAD_CODE()+"\""
						+",\"UPLOAD_STATE\" : \"" +list.get(i).getUPLOAD_STATE()+"\""
						+",\"FAIL_MSG\" : \""     +list.get(i).getFAIL_MSG()+"\""
						+",\"PD_CODE\" : \""      +"생성 전"+"\""
						+",\"SALE_CON\" : \""     +list.get(i).getSALE_CON()+"\""
						+",\"CAGO_ID\" : \""    +list.get(i).getCAGO_ID()+"\""
						+",\"PD_NAME\" : \""      +list.get(i).getPD_NAME()+"\""
						+",\"PD_PRICE\" : \""     +list.get(i).getPD_PRICE()+"\""
						+",\"INVEN_QTY\" : \""    +list.get(i).getINVEN_QTY()+"\""
						+",\"UPLOAD_STATE\" : \""    +"등록 전"+"\""
						+"}";
		}
		jsonStr = resultjson+"]";

		System.out.println("jsonStr : " + jsonStr);
		return jsonStr;
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductMgrController.java
	 * @Method	: deleteList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품 리스트 선택삭제
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 2019-11-11 (오전 9:31:25)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/deleteList"}, method=RequestMethod.POST)
	public ModelAndView deleteList(@ModelAttribute TB_PDINFOXM productInfo, Model model, HttpServletRequest request,
			@RequestParam String[] deleteValues) throws Exception {
				
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		productInfo.setREGP_ID(loginUser.getMEMB_ID());		
		
		List<TB_PDINFOXM> successlist = new ArrayList<>();
		List<TB_PDINFOXM> errorlist = new ArrayList<>();
		
		for(int i=0; i<deleteValues.length; i++){			
			productInfo.setPD_CODE(deleteValues[i].toString());
						 
			// 삭제상품 temp 테이블로 백업
			int tmpBackUp = 0;
			tmpBackUp = productMgrService.tmpInsertObject(productInfo);
			
			// 상품 삭제
			if(tmpBackUp != 0){
				productMgrService.deleteObject2(productInfo);
				productInfo.setADC1_VAL("삭제성공");
				successlist.add(productInfo);
			} else {
				productInfo.setADC1_VAL("삭제실패");
				errorlist.add(productInfo);
			}			
		}
		
		// 삭제안된상품 존재할시
		if(errorlist.size() > 0){
			model.addAttribute("errlist", errorlist);
			model.addAttribute("scslist", successlist);
			new ModelAndView("admin.layout", "jsp", "admin/productMgr/errorResult");
		}		
		
		//링크설정
		String strRtrUrl = "";
		String strLink = null;
		
		strLink = "schGbn="+StringUtil.nullCheck(productInfo.getSchGbn())+
					  "&schTxt_bef="+URLEncoder.encode(StringUtil.nullCheck(productInfo.getSchTxt_bef()),"UTF-8") +
					  "&schTxt="+URLEncoder.encode(StringUtil.nullCheck(productInfo.getSchTxt()),"UTF-8")+
					  "&reSearch="+URLEncoder.encode(StringUtil.nullCheck(productInfo.getReSearch()),"UTF-8")+
				      "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
				      "&pagerMaxPageItems="+StringUtil.nullCheck(productInfo.getPagerMaxPageItems())+
				      "&pageNum="+StringUtil.nullCheck(productInfo.getPageNum())+
				      "&ONDY_GUBN="+StringUtil.nullCheck(productInfo.getONDY_GUBN())+				      
				      "&salecon_sch="+StringUtil.nullCheck(productInfo.getSalecon_sch())+
				      "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr());
		
		strRtrUrl = "/adm/productMgr?"+strLink;
		
		RedirectView rv = new RedirectView(servletContextPath + "/adm/productMgr");
		return new ModelAndView(rv); 
	}

	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductMgrController.java
	 * @Method	: deleteChk
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: ??? (사용안함)
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param productInfo
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	
	@RequestMapping(value="/deleteChk", method=RequestMethod.POST)
	public @ResponseBody String deleteChk(@ModelAttribute TB_PDINFOXM productInfo) throws Exception {
		int nCateCnt = productMgrService.getObjectCount(productInfo);
		return nCateCnt+"";
	}
	*/
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductMgrController.java
	 * @Method	: insert
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 카테고리 삭제 (잘못된로직?)
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-07 (오후 11:05:15)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param productInfo
	 * @param request
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	
	@RequestMapping(value={ "/delete"}, method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute TB_PDINFOXM productInfo, HttpServletRequest request, Model model) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		productInfo.setREGP_ID(loginUser.getMEMB_ID());		

		int nRtn = 0;
		nRtn = productMgrService.deleteObject(productInfo);		//카테고리 삭제 로직아님

		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/categoryMgr"));
		return new ModelAndView(rv);
	}
	*/
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductMgrController.java
	 * @Method	: popup
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품연계 테이블 조회 (사용안함)
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-20 (오후 4:42:49)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_sysmnuxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	
	@RequestMapping(value={ "/popup"}, method=RequestMethod.GET)
	public ModelAndView popup(@ModelAttribute GOODS_MASTER goods_master, Model model) throws Exception {
		
		goods_master.setCount(productMgrService.getGoodsMasterCount(goods_master));
		goods_master.setList(productMgrService.getGoodsMasterList(goods_master));
		model.addAttribute("obj", goods_master);

		//페이징 정보
		model.addAttribute("rowCnt", goods_master.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", goods_master.getCount());			//전체 카운트
		
		return new ModelAndView("popup.layout", "jsp", "admin/productMgr/popup");
	}
	*/	
	
	@RequestMapping(value={ "/productUpload"}, method=RequestMethod.GET)
	public ModelAndView productUpload(Model model, HttpServletRequest request) throws Exception {		
		return new ModelAndView("admin.layout", "jsp", "admin/productMgr/productUpload");
	}	
//	@RequestMapping(value={ "/categorySearch"}, method=RequestMethod.GET)
//	public ModelAndView categorySearch(Model model, HttpServletRequest request) throws Exception {		
//		
//		
//		return new ModelAndView("blankPage", "jsp", "admin/productMgr/categorySearch");
//	}	
	
	 @RequestMapping(value = {"/categorySearch"}, method = {RequestMethod.GET})
	  public ModelAndView categorySearch(Model model, HttpServletRequest request) throws Exception {
	    String text = request.getParameter("text");
	    if (text != null && !text.equals("")) {
	      TB_PDCAGOXM tb_pdcagoxm = new TB_PDCAGOXM();
	      tb_pdcagoxm.setCAGO_NAME(text);
	      tb_pdcagoxm.setList(productMgrService.cagoSearch(tb_pdcagoxm));
	      model.addAttribute("obj", tb_pdcagoxm);
	    } 
	    return new ModelAndView("blankPage", "jsp", "admin/productMgr/categorySearch");
	  }
	
	
	
	@RequestMapping(value={"/validationChk"}, method=RequestMethod.POST,  produces = "text/html; charset=utf8")
	@ResponseBody
	public String validationChk(Model model, HttpServletRequest request, @RequestParam String type, @RequestParam String upload_code )throws Exception{
		String jsonStr ="";
		// 상품등록 파일 업로드 일 경우
			//프로시저 호출
			
			//생성된 UPLOAD_CODE 로 조회
			System.out.println("type : "+type);
			System.out.println("UPLOAD_CODE : "+upload_code);
			TB_PDINFOXM tmp_pdinfoxm= new TB_PDINFOXM();
			
			// 프로시저 호출
			Map map = new HashMap(); 
			map.put("UPLOAD_CODE", upload_code);

			Map resultMap = productMgrService.callValidChk(map);
			
			System.out.println("resultMap.isEmpty() : " + resultMap == null);
			
			//받아온 코드 넣기 
			tmp_pdinfoxm.setUPLOAD_CODE(upload_code);
			List<TB_PDINFOXM> result = (List<TB_PDINFOXM>)productMgrService.getUplodeResult(tmp_pdinfoxm);
			String resultjson ="[";
			System.out.println("size : " + result.size());
			for(int i = 0 ; i < result.size() ; i++) {
				
				if(i!=0) resultjson += ",";
				
				resultjson +="{\"UPLOAD_CODE\" : \""  +result.get(i).getUPLOAD_CODE()+"\""
							+",\"UPLOAD_STATE\" : \"" +result.get(i).getUPLOAD_STATE()+"\""
							+",\"FAIL_MSG\" : \""     +result.get(i).getFAIL_MSG()+"\""
							+",\"PD_CODE\" : \""      +result.get(i).getPD_CODE()+"\""
							+",\"SALE_CON\" : \""     +result.get(i).getSALE_CON()+"\""
							+",\"CAGO_ID\" : \""    +result.get(i).getCAGO_ID()+"\""
							+",\"PD_NAME\" : \""      +result.get(i).getPD_NAME()+"\""
							+",\"PD_PRICE\" : \""     +result.get(i).getPD_PRICE()+"\""
							+",\"INVEN_QTY\" : \""    +result.get(i).getINVEN_QTY()+"\"";
							if(result.get(i).getFAIL_MSG().equals("")) {
								resultjson += ",\"UPLOAD_STATE\" : \""    +"상품 등록 대기"+"\""
											+"}";	
							}else {
								resultjson += ",\"UPLOAD_STATE\" : \""    +"상품데이터 부족"+"\""
										+"}";
							}
							
			}
			resultjson+="]";
			
			jsonStr = resultjson;
			return jsonStr;
	}
	@RequestMapping(value={"/prdInsert"}, method=RequestMethod.POST,  produces = "text/html; charset=utf8")
	@ResponseBody
	public String prdInsert(Model model, HttpServletRequest request,@RequestParam String upload_code)throws Exception{
		String jsonStr ="";
		// 상품등록 파일 업로드 일 경우
		//프로시저 호출
		
		//생성된 UPLOAD_CODE 로 조회 후 insert
		TB_PDINFOXM tb_pdinfoxm= new TB_PDINFOXM();
		tb_pdinfoxm.setUPLOAD_CODE(upload_code);
		
		int result = productMgrService.insertPrdData(tb_pdinfoxm);
		System.out.println("result : "+ result);
		return result+"";
	}
	

	@RequestMapping(value={"/imgUpload"}, method=RequestMethod.POST,  produces = "text/html; charset=utf8")
	@ResponseBody
	public String imgUpload(@ModelAttribute TB_PDINFOXM productInfo, 
							@ModelAttribute TB_COATFLXD comFile, 
							Model model, 
							HttpServletRequest request,
							MultipartHttpServletRequest multipartRequest )throws Exception{
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>img Upload start!<<<<<<<<<<<<<<<<<<<<<<<<<");
		
		String UPLOAD_CODE = productMgrService.getUploadCode();
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		TB_COATFLXD comDtlFile = new TB_COATFLXD();
		
		comFile.setATFL_ID(productInfo.getDTL_ATFL_ID());
		comFile.setREGP_ID(loginUser.getMEMB_ID()); 
		comFile.setUPLOAD_CODE(UPLOAD_CODE);
		
		comDtlFile.setATFL_ID(productInfo.getDTL_ATFL_ID()); 
		comDtlFile.setREGP_ID(loginUser.getMEMB_ID()); 
		
		comFile.setIMG_GUBUN("multiPrdUpload");
		comDtlFile.setIMG_GUBUN("multiPrdUpload");	
		
		//첨부파일 처리
		String strATFL_ID = commonService.saveFile(comFile, request, multipartRequest, "IMG_FILE", "product/multiUpload/"+UPLOAD_CODE, false);
		System.out.println("대표이미지 insert : " + strATFL_ID);
		String strDTL_ATFL_ID = commonService.saveFile(comDtlFile, request, multipartRequest, "IMG_FILE", "product/multiUpload/"+UPLOAD_CODE, false);
		System.out.println("디테일이미지 insert : " + strDTL_ATFL_ID);
			
		
			return UPLOAD_CODE;
	}
	
	/* 기본 배송비 설정 - 이유리 */
	@RequestMapping(value={"/updateShipping"}, method=RequestMethod.POST)
	public @ResponseBody String updateOriginShipping(@ModelAttribute TB_PDSHIPXM tb_pdshipxm, Model model, HttpServletRequest request) throws Exception {
				
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");

		if(StringUtils.isNotEmpty(tb_pdshipxm.getPD_CODE())) {
			//조합원코드 가져오기
			TB_PDINFOXM tb_pdinfoxm = new TB_PDINFOXM();
			tb_pdinfoxm.setPD_CODE(tb_pdshipxm.getPD_CODE());
			tb_pdinfoxm = (TB_PDINFOXM)productMgrService.selectSuprCode(tb_pdinfoxm);
			tb_pdshipxm.setSUPR_ID(tb_pdinfoxm.getSUPR_ID());
		} else tb_pdshipxm.setSUPR_ID(loginUser.getSUPR_ID());
		
		tb_pdshipxm.setSHIP_CONFIG("SHIP_CONFIG_01");
		
		int result = productMgrService.updateSuprInfo(tb_pdshipxm);
		int result2 = productMgrService.updateShipMaster(tb_pdshipxm);
		
		return result + result2 + "";
	}
	
	/* 템플릿 인서트 - 이유리 */
	@RequestMapping(value={"/insertTemplete"}, method=RequestMethod.POST)
	public @ResponseBody String insertTemplete(@ModelAttribute TB_SHIPTEXM tb_shiptexm, 
											   @ModelAttribute TB_SHIPTEXD tb_shiptexd,
											   Model model, HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_shiptexm.setSUPR_ID(loginUser.getSUPR_ID());
		
		int result = productMgrService.insertTempMaster(tb_shiptexm);
		tb_shiptexm = (TB_SHIPTEXM)productMgrService.getTempMaster(tb_shiptexm);
		
		//배송비 디테일 삭제
		tb_shiptexd.setTEMP_NUM(tb_shiptexm.getTEMP_NUM());
		
		//배송비 디테일 입력
		if(tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_03") || tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_04")) {
			if(tb_shiptexd.getDLVY_AMTS().length != 0) {
				int length = tb_shiptexd.getDLVY_AMTS().length;
				
				for(int i = 0; i < length; i++) {
					tb_shiptexd.setTEMP_NUM(tb_shiptexm.getTEMP_NUM());
					tb_shiptexd.setGUBN_START(tb_shiptexd.getGUBN_STARTS()[i]);
					tb_shiptexd.setGUBN_END(tb_shiptexd.getGUBN_ENDS()[i]);
					tb_shiptexd.setDLVY_AMT(tb_shiptexd.getDLVY_AMTS()[i]);
					tb_shiptexd.setTEMP_SEQ(i+1);
					
					result += productMgrService.updateTempDetail(tb_shiptexd);
				}
			}
		}
		
		System.out.println("result 값 : " + result);
		
		return result + ""; 
	}
	
	/* 템플릿 업데이트 - 이유리 */
	@RequestMapping(value={"/updateTemplete"}, method=RequestMethod.POST)
	public @ResponseBody String updateTemplete(@ModelAttribute TB_SHIPTEXM tb_shiptexm, 
											   @ModelAttribute TB_SHIPTEXD tb_shiptexd,
											   Model model, HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_shiptexm.setSUPR_ID(loginUser.getSUPR_ID());
		
		int result = productMgrService.updateTempMaster(tb_shiptexm);
		tb_shiptexm = (TB_SHIPTEXM)productMgrService.getTempMaster(tb_shiptexm);
		
		//배송비 디테일 삭제
		tb_shiptexd.setTEMP_NUM(tb_shiptexm.getTEMP_NUM());
		productMgrService.deleteTempDetail(tb_shiptexd);
		
		//배송비 디테일 입력
		if(tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_03") || tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_04")) {
			if(tb_shiptexd.getDLVY_AMTS().length != 0) {
				int length = tb_shiptexd.getDLVY_AMTS().length;
				
				for(int i = 0; i < length; i++) {
					tb_shiptexd.setTEMP_NUM(tb_shiptexm.getTEMP_NUM());
					tb_shiptexd.setGUBN_START(tb_shiptexd.getGUBN_STARTS()[i]);
					tb_shiptexd.setGUBN_END(tb_shiptexd.getGUBN_ENDS()[i]);
					tb_shiptexd.setDLVY_AMT(tb_shiptexd.getDLVY_AMTS()[i]);
					tb_shiptexd.setTEMP_SEQ(i+1);
					
					result += productMgrService.updateTempDetail(tb_shiptexd);
				}
			}
		}
		
		System.out.println("result 값 : " + result);
		
		return result + ""; 
	}
	
	/* 템플릿 삭제 - 이유리 */
	@RequestMapping(value={"/deleteTemplete"}, method=RequestMethod.POST)
	public @ResponseBody String deleteTemplete(String TEMP_NUM, Model model, HttpServletRequest request) throws Exception {
		TEMP_NUM = TEMP_NUM.replace(" ", "");
		String[] TEMP_NUMS = TEMP_NUM.split(",");
		int length = TEMP_NUMS.length;
		int result = 0;
		int result2 = 0;
		
		TB_SHIPTEXM tb_shiptexm = new TB_SHIPTEXM();
		TB_SHIPTEXD tb_shiptexd = new TB_SHIPTEXD();
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		tb_shiptexm.setSUPR_ID(loginUser.getSUPR_ID());
		
		for(int i = 0; i < length; i++) {
			tb_shiptexd.setTEMP_NUM(TEMP_NUMS[i]);
			tb_shiptexm.setTEMP_NUM(TEMP_NUMS[i]);
			
			result += productMgrService.deleteTempDetail(tb_shiptexd);
			result2 += productMgrService.deleteTempMaster(tb_shiptexm);
		}
		
		System.out.println("디테일 : " + result);
		System.out.println("마스터 : " + result2);
		
		return result2 + ""; 
	}
	
	@RequestMapping(value = {"/linkProduct"}, method = {RequestMethod.GET})
	  public ModelAndView getlinkProductList(Model model, HttpServletRequest request) throws Exception {
		
			RestTemplate restTemplate = new RestTemplate();

			String schTxt = request.getParameter("schTxt") == null?"":request.getParameter("schTxt");
			String brand = request.getParameter("brand") == null?"":request.getParameter("brand");
			int listCnt = request.getParameter("listCnt") == null? 10 :Integer.parseInt(request.getParameter("listCnt"));
			int pageNum = request.getParameter("pageNum") == null? 0 :Integer.parseInt(request.getParameter("pageNum"))-1;
			int offset = (pageNum)*listCnt;
			if(offset<0) offset = 0;
			
			restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));
			
			String url = "http://ct.e-kiss.co.kr:24088/api/v2/prdSynth";
		  	HttpHeaders httpHeaders = new HttpHeaders();
		  	httpHeaders.setContentType(MediaType.APPLICATION_JSON);
		  	
		  	String requestJson = "{" + 
		  			"    \"brand\": \""+brand+"\"," + 
		  			"    \"bsnsTy\": \"\"," + 
		  			"    \"prductCl1\": \"\"," + 
		  			"    \"prductCl2\": \"\"," + 
		  			"    \"prductCl3\": \"\"," + 
		  			"    \"prductCl4\": \"\"," + 
		  			"    \"delYn\": \"N\"," + 
		  			"    \"useYn\": \"Y\"," + 
		  			"    \"prductNm\": \""+schTxt+"\"," + 
		  			"    \"offset\": "+offset+"," + 
		  			"    \"pageNumber\": "+pageNum+"," + 
		  			"    \"pageSize\": \""+listCnt+"\"," + 
		  			"    \"paged\": \"true\"}";
	
		  	// Combine Message
	        HttpEntity<?> requestMessage = new HttpEntity<>(requestJson, httpHeaders);
	        // Request and getResponse
	        HttpEntity<String> response = restTemplate.postForEntity(url, requestMessage, String.class);
	        JSONObject requestBody = new JSONObject(response.getBody());
	        String totalCnt = requestBody.get("totalElements").toString();
	        
	        JSONArray jsonArray = new JSONArray(requestBody.get("content").toString());
	        
	        model.addAttribute("test",jsonArray);
	        model.addAttribute("totalCnt", totalCnt);
	        return new ModelAndView("admin.layout", "jsp", "admin/productMgr/linkProduct");
	  }
	
	@RequestMapping(value = {"/insertLinkProduct"},method= {RequestMethod.POST})
	public ModelAndView linkProductInsert(@ModelAttribute String prdNums, HttpServletRequest request, Model model) throws Exception {

		
		// 로그인정보
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
//		productInfo.setREGP_ID(loginUser.getMEMB_ID());
		String[] prdNos = request.getParameter("prdNums").split(",");
		TB_PDINFOXM tb_pdinfoxm = new TB_PDINFOXM();
		tb_pdinfoxm.setSUPR_ID(loginUser.getSUPR_ID());
		
		
		for (String prdNo : prdNos) {
			
			tb_pdinfoxm.setN_PD_CODE(prdNo);
			
			int valichk = productMgrService.linkDuplicateChk(tb_pdinfoxm); 
			if(valichk == 0 ) {
				
				RestTemplate restTemplate = new RestTemplate();
				restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));
				
				String url = "http://ct.e-kiss.co.kr:24088/api/v2/prdSynth/"+prdNo;
				HttpHeaders httpHeaders = new HttpHeaders();
				httpHeaders.setContentType(MediaType.APPLICATION_JSON);
				
				HttpEntity<?> requestMessage = new HttpEntity<>(httpHeaders);
				HttpEntity<String> response = restTemplate.postForEntity(url, requestMessage, String.class);
				JSONObject requestBody = new JSONObject(response.getBody());
				String[] imgLink = requestBody.get("dtlHtmlCn").toString().split("\"");
				
				TB_PDINFOXM productInfo = new TB_PDINFOXM();
				productInfo.setPD_NAME(requestBody.get("prductNm").toString());
				productInfo.setSUPR_ID(loginUser.getSUPR_ID());
				productInfo.setCAGO_ID("021000000000");
				productInfo.setCAGO_ID_LEN(productInfo.getCAGO_ID().length()+1);
				productInfo.setPD_PRICE(requestBody.get("cnsmrPc").toString());
				productInfo.setINVEN_QTY("999");
				productInfo.setSALE_CON("SALE_CON_01");
//				productInfo.setATFL_ID("00000");
				productInfo.setREGP_ID(loginUser.getMEMB_NAME());
				productInfo.setMODP_ID(loginUser.getMEMB_NAME());
				productInfo.setRETAIL_YN("N");
				productInfo.setBOX_PDDC_GUBN("PDDC_GUBN_01");
				productInfo.setIMGURL(imgLink[1]);
				productInfo.setN_PD_CODE(requestBody.get("prdNo").toString());
				
				int nRtn = productMgrService.insertLinkedObject(productInfo);
				
				System.out.println("prdOptSetNo : " + requestBody.get("prdOptSetNo"));
				
				if(requestBody.get("prdOptSetNo") != null){
					String PD_CODE = productMgrService.selectByNpdcode(productInfo.getN_PD_CODE());
					TB_PDOPTION tb_pdoption = new TB_PDOPTION();
					tb_pdoption.setPD_CODE(PD_CODE);
					tb_pdoption.setDEL_YN("N");
					tb_pdoption.setSELL_YN("Y");
					
					url = "http://ct.e-kiss.co.kr:24088/api/v1/prdOptSetOne";
					String requestJson = "{" + 
					  "\"cmpnyNo\": 10001,"+
//					  "\"cmpnyNo\":"+ requestBody.get("createCmpnyNo")+","+
					  "\"prdOptSetNo\": "+requestBody.get("prdOptSetNo")+","+
					  "\"delYn\": \"N\","+
					  "\"offset\": 0," +
					  "\"pageNumber\": 0," +
					  "\"pageSize\": 100," +
					  "\"paged\": true" +
					  "}";

					HttpEntity<?> requestSet = new HttpEntity<>(requestJson, httpHeaders);
					response = restTemplate.postForEntity(url, requestSet, String.class);
					requestBody = new JSONObject(response.getBody());
					System.out.println("requestBody : " +requestBody);
					
					JSONArray body = (JSONArray)requestBody.get("prdOptList");
					System.out.println("body : " + body);
					
					int dtlCnt =0;
					JSONObject option1 = body.getJSONObject(0); 
					JSONObject option2 = null;
					JSONObject option3 = null;
					if(body.length() == 3) {
						option2 = body.getJSONObject(1); 
						option3 = body.getJSONObject(2); 
					}else if(body.length() == 2) {
						option2 = body.getJSONObject(1); 
					}
					
					JSONArray optDtls1 = (JSONArray)option1.get("prdOptDtlList");
					for(int i =0;i<optDtls1.length();i++) {
						tb_pdoption.setOPTION1_NAME(option1.getString("prdOptNm"));
						tb_pdoption.setOPTION1_VALUE(((JSONObject)optDtls1.get(i)).getString("prdOptDtlNm"));
						if(option2 != null) {
							
							JSONArray optDtls2 = (JSONArray)option2.get("prdOptDtlList");
							for(int j =0; j<optDtls2.length();j++) {
								tb_pdoption.setOPTION2_NAME(option2.getString("prdOptNm"));
								tb_pdoption.setOPTION2_VALUE(((JSONObject)optDtls2.get(j)).getString("prdOptDtlNm"));
								
								if(option3 != null) {
									JSONArray optDtls3 = (JSONArray)option3.get("prdOptDtlList");
									for(int k =0; k<optDtls3.length();k++) {
										tb_pdoption.setOPTION3_NAME(option3.getString("prdOptNm"));
										tb_pdoption.setOPTION3_VALUE(((JSONObject)optDtls3.get(j)).getString("prdOptDtlNm"));
										dtlCnt += productMgrService.optionInsert(tb_pdoption);
										System.out.println("name1 : "+tb_pdoption.getOPTION1_NAME()+"op1 : "+tb_pdoption.getOPTION1_VALUE()
														   +"name2 : "+tb_pdoption.getOPTION2_NAME()+"op2 : "+tb_pdoption.getOPTION2_VALUE()
															+"name3 : "+tb_pdoption.getOPTION3_NAME()+"op3 : "+tb_pdoption.getOPTION3_VALUE());
									}
								}else {
									System.out.println("name1 : "+tb_pdoption.getOPTION1_NAME()+"op1 : "+tb_pdoption.getOPTION1_VALUE()+"name2 : "+tb_pdoption.getOPTION2_NAME()+"op2 : "+tb_pdoption.getOPTION2_VALUE());
									dtlCnt += productMgrService.optionInsert(tb_pdoption);
								}
							}
							
						}else {
							System.out.println("name1 : "+tb_pdoption.getOPTION1_NAME()+"op1 : "+tb_pdoption.getOPTION1_VALUE());
							dtlCnt += productMgrService.optionInsert(tb_pdoption);
						}
					}

				}
				
			}
		 
		}

		
		
		
		return  new ModelAndView("blankPage", "jsp", "blank/center"); 
	}	
	
}
