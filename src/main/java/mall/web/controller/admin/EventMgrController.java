package mall.web.controller.admin;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_EVENT_MAIN;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.service.admin.impl.EventMgrService;
import mall.web.service.admin.impl.ProductMgrService;
import mall.web.service.common.CommonService;

/**
 * @author Your Name (your@email.com) 이벤트관리 Controller
 */

@Controller
@RequestMapping(value = "/adm/eventMgr")
public class EventMgrController extends DefaultController {

	private static final Logger logger = LoggerFactory.getLogger(EventMgrController.class);
	
	
	@Resource(name = "eventMgrService")
	EventMgrService eventMgrService;

	@Resource(name = "commonService")
	CommonService commonService;

	@Resource(name = "productMgrService")
	ProductMgrService productMgrService;

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.EventMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 기획전리스트
	 * @Company	: ted
	 * @Author	: jang bora
	 * @Date	: 2021-11-04
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_event_main
	 * @param model
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_EVENT_MAIN tb_event_main, Model model, SessionStatus status, HttpServletRequest request) throws Exception {
		
		//ID정보 가져오기
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		
		//ID정보 REGP_ID에 넣기 xml 파일에서 조건문으로 사용 목적
		tb_event_main.setREGP_ID(loginUser.getMEMB_ID());
		
		tb_event_main.setList(eventMgrService.getObjectList(tb_event_main));
		model.addAttribute("obj", tb_event_main);
		return new ModelAndView("admin.layout", "jsp", "admin/eventMgr/newList");
	}


	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.EventMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 기획전등록화면/상세화면
	 * @Company	: ted
	 * @Author	: jang bora
	 * @Date	: 2021-11-04
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_event_main
	 * @param model
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value = { "/{GRP_CD}", "/newForm" }, method = RequestMethod.GET)
	public ModelAndView view(@ModelAttribute TB_EVENT_MAIN tb_event_main, @ModelAttribute TB_PDINFOXM tb_pdinfoxm, HttpServletRequest request, Model model) throws Exception {
			
			if(StringUtils.isNotEmpty(tb_event_main.getGRP_CD())){ //GRP_CD가 빈값이 아니면
				TB_EVENT_MAIN tem = (TB_EVENT_MAIN)eventMgrService.getAllFind(tb_event_main);
				model.addAttribute("tb_event_main", tem);
				
				tb_pdinfoxm.setList(eventMgrService.getListProduct(tb_event_main));
				model.addAttribute("tb_pdinfoxm", tb_pdinfoxm);
				//파일 받아오기 - 마스터이미지
				
				if(StringUtils.isNotEmpty(tem.getATFL_ID())){ //ATFL_ID가 빈값이 아니면
					TB_COATFLXD commonFile = new TB_COATFLXD();
					commonFile.setATFL_ID(tem.getATFL_ID());
					model.addAttribute("fileList", commonService.selectFileList(commonFile));
				}
				
				//파일 받아오기 - 상세이미지
				if(StringUtils.isNotEmpty(tem.getATFL_ID_D())){
					TB_COATFLXD commonDtlFile = new TB_COATFLXD();
					commonDtlFile.setATFL_ID(tem.getATFL_ID_D());
					model.addAttribute("fileDtlList", commonService.selectFileList(commonDtlFile));
				}
			}
		return new ModelAndView("admin.layout", "jsp", "admin/eventMgr/newForm");
	}

	
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.EventMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 기획전등록/수정화면
	 * @Company	: ted
	 * @Author	: jang bora
	 * @Date	: 2021-11-04
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_event_main
	 * @param model
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView insertAndUpdate(@ModelAttribute TB_EVENT_MAIN tb_event_main, @ModelAttribute TB_PDINFOXM tb_pdinfoxm, @ModelAttribute TB_COATFLXD comFile,  MultipartHttpServletRequest multipartRequest,
			HttpServletRequest request, Model model, String val) throws Exception {
		// 등록자 정보 변경필요
		System.out.println("testtest:"+val);
		
		String URL="";
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		comFile.setREGP_ID(loginUser.getMEMB_ID());
		
		
		TB_COATFLXD comDtlFile = new TB_COATFLXD();
		comDtlFile.setATFL_ID(tb_event_main.getATFL_ID_D()); 
		comDtlFile.setREGP_ID(loginUser.getMEMB_ID()); 
		
		//첨부파일 처리
		String strATFL_ID = commonService.saveFile(comFile, request, multipartRequest, "file", "event", false);
		String strATFL_ID_D = commonService.saveFile(comDtlFile, request, multipartRequest, "fileDtl", "event", false);
		//이미지 등록
		
		int nRtn = 0;
		// 기획전명이 비어있으면 insert 
		if(val.equals("Y")){
			
			tb_event_main.setREGP_ID(loginUser.getMEMB_ID());
			tb_event_main.setMODP_ID(loginUser.getMEMB_ID());
			
			String[] splitCd = tb_pdinfoxm.getPD_CODE().split(",");
			//그룹상품 등록
			if (splitCd.length > 0 && !tb_pdinfoxm.getPD_CODE().equals("")) {
				for (int i = 0; i < splitCd.length; i++) {
					System.out.println("나는 상품목록입니다." + i + ":" + splitCd[i]);
					tb_event_main.setPD_CODE(splitCd[i]);
					// 등록자 정보 변경필요
					tb_event_main.setREGP_ID(loginUser.getMEMB_ID());
					
					eventMgrService.updateProduct(tb_event_main); // 그룹상품 insert
				}
			}
			
			tb_event_main.setATFL_ID(strATFL_ID);
			tb_event_main.setATFL_ID_D(strATFL_ID_D);
			nRtn = eventMgrService.insertObject(tb_event_main);
			URL="/adm/eventMgr";
	
		//기획전명이  있으면 update
		}else{
			tb_event_main.setMODP_ID(loginUser.getMEMB_ID());
		    tb_pdinfoxm.setMODP_ID(loginUser.getMEMB_ID());
			
			
			tb_event_main.setATFL_ID(strATFL_ID);
			tb_event_main.setATFL_ID_D(strATFL_ID_D);
			eventMgrService.deleteProduct(tb_event_main);		//기존 그룹상품 삭제
			
			String[] splitCd = tb_pdinfoxm.getPD_CODE().split(",");
			// 신규 그룹상품 등록
			if (splitCd.length > 0 && !tb_pdinfoxm.getPD_CODE().equals("")) {
				for (int i = 0; i < splitCd.length; i++) {
					System.out.println("나는 상품목록입니다." + i + ":" + splitCd[i]);
					tb_event_main.setPD_CODE(splitCd[i]);
					// 등록자 정보 변경필요
					tb_event_main.setREGP_ID(loginUser.getMEMB_ID());
					eventMgrService.updateProduct(tb_event_main); // 그룹상품 insert
				}
			}
			tb_event_main.setATFL_ID(strATFL_ID);
			tb_event_main.setATFL_ID_D(strATFL_ID_D);
			nRtn = eventMgrService.updateObject(tb_event_main);
			URL="/adm/eventMgr/"+ tb_event_main.getGRP_CD();
			
		}

		RedirectView redirectView = new RedirectView(servletContextPath + URL);
		return new ModelAndView(redirectView);
	}



	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.EventMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 기획전삭제
	 * @Company	: ted
	 * @Author	: jang bora
	 * @Date	: 2021-11-04
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_event_main
	 * @param model
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value = { "/{GRP_CD}" }, method = RequestMethod.DELETE)
	public ModelAndView delete(@ModelAttribute TB_EVENT_MAIN tb_event_main, BindingResult result, SessionStatus status,
			Model model, HttpServletRequest request) throws Exception {
		// 관리자 계정정보
		TB_MBINFOXM loginUser = (TB_MBINFOXM) request.getSession().getAttribute("ADMUSER");
		tb_event_main.setMODP_ID(loginUser.getMEMB_ID());

		eventMgrService.deleteProduct(tb_event_main); // 추천상품D 삭제
		eventMgrService.deleteObject(tb_event_main); // 추천상품M 삭제
		

		RedirectView redirectView = new RedirectView(servletContextPath + "/adm/eventMgr");
		return new ModelAndView(redirectView);
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.EventMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 기획전코드 중복확인
	 * @Company	: ted
	 * @Author	: jang bora
	 * @Date	: 2021-11-06
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_event_main
	 * @param model
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/grpChk", method=RequestMethod.POST)
	public @ResponseBody String grpChk(@ModelAttribute TB_EVENT_MAIN tb_event_main) throws Exception {
		int nCnt = eventMgrService.grpChk(tb_event_main);
		return nCnt+"";
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.EventMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 기획전상품삭제
	 * @Company	: ted
	 * @Author	: jang bora
	 * @Date	: 2021-11-04
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_event_main
	 * @param model
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value = { "/deleteProduct" }, method = RequestMethod.GET)
	public ModelAndView deleteproduct(@ModelAttribute TB_EVENT_MAIN tb_event_main,
			@ModelAttribute TB_PDINFOXM tb_pdinfoxm, BindingResult result, SessionStatus status, Model model)
			throws Exception {
		// 등록자 정보 변경필요
		tb_event_main.setMODP_ID("admin");
		tb_pdinfoxm.setMODP_ID("admin");

		eventMgrService.deleteProduct(tb_pdinfoxm);

		RedirectView redirectView = new RedirectView(servletContextPath + "/adm/eventMgr/" + tb_event_main.getGRP_CD());
		return new ModelAndView(redirectView);
	}

	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.EventMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 기획전상품리스트팝업
	 * @Company	: ted
	 * @Author	: jang bora
	 * @Date	: 2021-11-04
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_event_main
	 * @param model
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value = { "/popup" }, method = RequestMethod.GET)
	public ModelAndView popup(@ModelAttribute TB_PDINFOXM productInfo, Model model, HttpServletRequest request)
			throws Exception {

		// 결과내 재검색 X
		List schTxt_befList = Arrays.asList(productInfo.getSchTxt());
		productInfo.setSchTxt_befList(schTxt_befList); // 기본 검색어 만 List
		productInfo.setSchTxt_bef(productInfo.getSchTxt()); // 기본 검색어를 이전 검색어 hidden 데이터로 반영

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

		return new ModelAndView("popup.layout", "jsp", "admin/eventMgr/popup");
	}


	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.EventMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 기획전상품중복체크
	 * @Company	: ted
	 * @Author	: jang bora
	 * @Date	: 2021-11-04
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_event_main
	 * @param model
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value = { "/ordrChk" }, method = RequestMethod.POST)
	public @ResponseBody String chk(@ModelAttribute TB_EVENT_MAIN tb_event_main, BindingResult result,
			SessionStatus status, Model model) throws Exception {
		int updateCnt = eventMgrService.getOrdrSameCnt(tb_event_main);
		return updateCnt > 0 ? SUCCESS : FAILURE;
	}

	@RequestMapping(value = { "/grpPdChk" }, method = RequestMethod.POST)
	public @ResponseBody String grpPdChk(@ModelAttribute TB_EVENT_MAIN tb_event_main, BindingResult result,
			SessionStatus status, Model model) throws Exception {
		int updateCnt = eventMgrService.getGrpPdCnt(tb_event_main);
		return updateCnt > 0 ? SUCCESS : FAILURE;
	}
	
	@RequestMapping(value = "/imgUpload", method = RequestMethod.POST)
	public Map<String, String> imgUpload(@RequestParam("file") MultipartFile file, HttpServletRequest session) {
		
		// 원래 파일 이름 추출
        String origName = file.getOriginalFilename();

        // 파일 이름으로 쓸 uuid 생성
        //String uuid = UUID.randomUUID().toString();

        // 확장자 추출(ex : .png)
        //String extension = origName.substring(origName.lastIndexOf("."));

        // uuid와 확장자 결합
        //String savedName = uuid + extension;

        // 파일을 불러올 때 사용할 파일 경로
        //String savedPath = "C:\\"+"upload\\"+"test\\" + origName;
        
        //실질적으로 파일 넣는 경로
        //String savedPath = session.getServletContext().getRealPath("/")+"resources\\adminlte\\dist\\ToastImgTemp\\" + origName;
        //서버용
        String savedPath = session.getServletContext().getRealPath("/")+"resources/adminlte/dist/ToastImgTemp/" + origName;
        //파일 가져올때 넣어주는 경로
        String savedPath2 = "/resources/adminlte/dist/ToastImgTemp/" + origName;
        
        //프로젝트 까지 경로
        //String abcc = session.getServletContext().getRealPath("/");
        //C:\Users\park\Desktop\project\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\cacoop\ 이렇게 출력
        
        
        // 실제로 로컬에 uuid를 파일명으로 저장
        try {
        	file.transferTo(new File(savedPath));
		} catch (Exception e) {
			
		}
		
		Map<String, String> myMap = new HashMap<String, String>();
		myMap.put("imgPath", savedPath2);
		
		return myMap;
	}
}


//
//@Controller
//@RequestMapping(value="/adm/eventMgr")
//public class EventMgrController extends DefaultController {
//
//	private static final Logger logger = LoggerFactory.getLogger(MemberMgrController.class);
//	
//	@Resource(name="eventMgrService")
//	EventMgrService eventMgrService;
//
//	@Resource(name="commonService")
//	CommonService commonService;
//	
//	/* 목록 */
//	@RequestMapping(method=RequestMethod.GET)
//	public ModelAndView getList(HttpServletRequest request, @ModelAttribute TB_EVENTIFXM eventInfo, Model model) throws Exception {
// 
//		try {
//			TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
//			eventInfo.setREGP_ID(loginUser.getMEMB_ID());
//			
//			eventInfo.setCount(eventMgrService.getObjectCount(eventInfo));
//			eventInfo.setList(eventMgrService.getPaginatedObjectList(eventInfo));
//			
//			model.addAttribute("obj", eventInfo);
//			model.addAttribute("rowCnt", eventInfo.getRowCnt());
//			model.addAttribute("totalCnt", eventInfo.getCount());
//			
//			String strLink = null;
//			strLink = "&schTxt="+StringUtil.nullCheck(eventInfo.getSchTxt());
//			model.addAttribute("link", strLink);
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return new ModelAndView("admin.layout", "jsp", "admin/eventMgr/list");
//	}
//	
//	/* 상세조회 */
//	@SuppressWarnings("unchecked")
//	@RequestMapping(value={"/edit/{EVENT_ID}", "/new"}, method=RequestMethod.GET)
//	public ModelAndView view(@ModelAttribute TB_EVENTIFXM eventInfo, Model model) throws Exception {
//		
//		List<TB_EVENTPDXM> productList = new ArrayList<TB_EVENTPDXM>();
//		
//		try {
//			model.addAttribute("eventInfo", eventMgrService.getObject(eventInfo));
//			
//			if(StringUtils.isNotEmpty(eventInfo.getEVENT_ID())) {
//				TB_EVENTPDXM detailList = new TB_EVENTPDXM();
//				detailList.setEVENT_ID(eventInfo.getEVENT_ID());
//				productList = (List<TB_EVENTPDXM>) eventMgrService.getDetailList(detailList);
//				
//				model.addAttribute("detailList", productList);
//				model.addAttribute("detailListCnt", productList.size());
//			}
//			
//			String strLink = null;
//			strLink = "&schTxt="+StringUtil.nullCheck(eventInfo.getSchTxt());
//			model.addAttribute("link", strLink);
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return new ModelAndView("admin.layout", "jsp", "admin/adMgr/form");
//	}
//	
//	/* 등록/수정 */
//	@RequestMapping(method=RequestMethod.POST)
//	public ModelAndView update(@ModelAttribute TB_ADPDIFXM adpdinfo, @ModelAttribute TB_COATFLXD comFile, HttpServletRequest request, Model model, MultipartHttpServletRequest multipartRequest) throws Exception{
//		
//		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
//		adpdinfo.setREGP_ID(loginUser.getMEMB_ID());
//		comFile.setREGP_ID(loginUser.getMEMB_ID());  
//				
//		//등록, 수정 분기
//		if(StringUtils.isNotEmpty(adpdinfo.getAD_ID())){
//			
//			//광고 상단 이미지 있을경우 기존 이미지 변경
//			MultipartFile topFile =multipartRequest.getFile("topFile");
//			if(StringUtils.isNotEmpty(topFile.getOriginalFilename())){
//				String saveFileName = FileUtil.saveFile2(request, topFile, "jundan/"+adpdinfo.getAD_ID(), false);
//				adpdinfo.setTOP_ATFL(saveFileName);
//			}
//
//			//첨부파일 처리 - 제품 이미지
//			String strATFL_ID = commonService.saveFile(comFile, request, multipartRequest, "pdImgFile", "jundan/"+adpdinfo.getAD_ID(), true);
//			adpdinfo.setATFL_ID(strATFL_ID);
//			
//			eventMgrService.admgrUpdateObject(adpdinfo);
//		}else {
//			eventMgrService.insertObject(adpdinfo);
//			//광고 상단 이미지 있을경우 기존 이미지 변경
//			MultipartFile topFile =multipartRequest.getFile("topFile");
//			if(StringUtils.isNotEmpty(topFile.getOriginalFilename())){
//				String saveFileName = FileUtil.saveFile2(request, topFile, "jundan/"+adpdinfo.getAD_ID(), false);
//				adpdinfo.setTOP_ATFL(saveFileName);
//			}
//			
//			//첨부파일 처리 - 제품 이미지
//			String strATFL_ID = commonService.saveFile(comFile, request, multipartRequest, "pdImgFile", "jundan/"+adpdinfo.getAD_ID(), true);
//			adpdinfo.setATFL_ID(strATFL_ID);
//			
//			//상단이미지, 상품이미지 둘중 하나라도 있을경우 업데이트
//			if(StringUtils.isNotEmpty(topFile.getOriginalFilename()) || StringUtils.isNotEmpty(strATFL_ID) ){
//				//이미지 수정을위해 업데이트
//				eventMgrService.updateObject(adpdinfo);
//			}
//			
//		}
//		
//		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/adMgr/edit/" + adpdinfo.getAD_ID() 
//																	+ "?pageNum=" + StringUtil.nullCheck(adpdinfo.getPageNum())
//																	+ "&rowCnt=" + StringUtil.nullCheck(adpdinfo.getRowCnt())
//																	+ "&schTxt=" + StringUtil.nullCheck(adpdinfo.getSchTxt())));
//		return new ModelAndView(rv);
//	}
//
//	/* 등록/수정   */
//	@RequestMapping(value="/excelUpload",method=RequestMethod.POST)
//	public ModelAndView excelUpload(@ModelAttribute TB_ADPDIFXM adpdinfo, HttpServletRequest request, Model model, MultipartHttpServletRequest multipartRequest) throws Exception{
//		
//		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
//		adpdinfo.setREGP_ID(loginUser.getMEMB_ID()); 
//		
//		MultipartFile excelFile =multipartRequest.getFile("EXCEL_FILE");
//		
//        if(excelFile==null || excelFile.isEmpty()){
//            throw new RuntimeException("엑셀파일을 선택 해 주세요.");
//        }
//        
//		if ( StringUtils.isNotEmpty(excelFile.getOriginalFilename()) ) {
//			String saveFileName = FileUtil.saveFile2(request, excelFile, "jundan/tmp", false);
//			String savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/jundan/tmp" + File.separator;
//
//	        File destFile = new File(savePath+saveFileName);
//	        try{
//	            excelFile.transferTo(destFile);
//	        }catch(IllegalStateException | IOException e){
//	            throw new RuntimeException(e.getMessage(),e);
//	        }
//	        
//	        //Service 단에서 가져온 코드 
//	        ExcelReadOption excelReadOption = new ExcelReadOption();
//	        excelReadOption.setFilePath(destFile.getAbsolutePath());
//	        excelReadOption.setOutputColumns("A","B","C","D","E","F","G","H","I");
//	        excelReadOption.setStartRow(3);
//	        	        
//	        List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);
//	        logger.info("getNumCellCnt>>" + excelReadOption.getNumCellCnt());
//
//			if (excelReadOption.getNumCellCnt() < 9) {
//				ModelAndView mav = new ModelAndView();
//				
//				mav.addObject("alertMessage", "엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식 다운로드 후 다시 저장 하세요.");
//				mav.addObject("returnUrl", "back");
//				mav.setViewName("alertMessage");
//				return mav;
//			}
//			
//	        
//			eventMgrService.excelUpload(adpdinfo, excelContent);
//		}
//
//		
//		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/adMgr/edit/" + adpdinfo.getAD_ID() 
//																	+ "?pageNum=" + StringUtil.nullCheck(adpdinfo.getPageNum())
//																	+ "&rowCnt=" + StringUtil.nullCheck(adpdinfo.getRowCnt())
//																	+ "&schTxt=" + StringUtil.nullCheck(adpdinfo.getSchTxt())));
//		return new ModelAndView(rv);
//	}
//	
//	/* 복사등록  */
//	@RequestMapping(value={"/copyInsert"}, method=RequestMethod.POST)
//	public ModelAndView copyAdInsert(@ModelAttribute TB_EVENTIFXM eventInfo, HttpServletRequest request, Model model) throws Exception {
//		eventMgrService.copyAdInsert(eventInfo);
//		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/adMgr"));
//		return new ModelAndView(rv);
//		
//	}
//
//	
//	/* 삭제 */
//	@RequestMapping(value={"/delete"}, method=RequestMethod.POST)
//	public ModelAndView delete(@ModelAttribute TB_EVENTIFXM eventInfo, HttpServletRequest request, Model model) throws Exception {
//		try {
//			TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
//			eventInfo.setREGP_ID(loginUser.getMEMB_ID());	
//			eventMgrService.deleteObject(eventInfo);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/adMgr"));
//		return new ModelAndView(rv);
//	}
//	
//}
//
