package mall.web.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.util.FileUtil;
import mall.common.util.StringUtil;
import mall.common.util.excel.ExcelRead;
import mall.common.util.excel.ExcelReadOption;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_ADINFOXM;
import mall.web.domain.TB_ADPDIFXM;
import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_MBINFOXM;
import mall.web.service.admin.impl.AdMgrService;
import mall.web.service.common.CommonService;

/** 
* @author Your Name (your@email.com)
* 광고 Controller
*/

@Controller
@RequestMapping(value="/adm/adMgr")
public class AdMgrController extends DefaultController {

	private static final Logger logger = LoggerFactory.getLogger(MemberMgrController.class);
	
	@Resource(name="adMgrService")
	AdMgrService adMgrService;

	@Resource(name="commonService")
	CommonService commonService;
	
	/* 목록 */
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(HttpServletRequest request, @ModelAttribute TB_ADINFOXM adinfo, Model model) throws Exception {
 
		try {
			TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
			adinfo.setREGP_ID(loginUser.getMEMB_ID());
			
			adinfo.setCount(adMgrService.getObjectCount(adinfo));
			adinfo.setList(adMgrService.getPaginatedObjectList(adinfo));
			
			model.addAttribute("obj", adinfo);
			model.addAttribute("rowCnt", adinfo.getRowCnt());
			model.addAttribute("totalCnt", adinfo.getCount());
			
			String strLink = null;
			strLink = "&schTxt="+StringUtil.nullCheck(adinfo.getSchTxt());
			model.addAttribute("link", strLink);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("admin.layout", "jsp", "admin/adMgr/list");
	}
	
	/* 상세조회 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value={"/edit/{AD_ID}", "/new"}, method=RequestMethod.GET)
	public ModelAndView view(@ModelAttribute TB_ADINFOXM adinfo, Model model) throws Exception {
		
		List<TB_ADPDIFXM> adpdifxmList = new ArrayList<TB_ADPDIFXM>();
		
		try {
			model.addAttribute("adverinfo", adMgrService.getObject(adinfo));
			
			if(StringUtils.isNotEmpty(adinfo.getAD_ID())) {
				TB_ADPDIFXM detailList = new TB_ADPDIFXM();
				detailList.setAD_ID(adinfo.getAD_ID());
				adpdifxmList = (List<TB_ADPDIFXM>) adMgrService.getDetailList(detailList);
				
				model.addAttribute("detailList", adpdifxmList);
				model.addAttribute("detailListCnt", adpdifxmList.size());
				
				model.addAttribute("logList", adMgrService.selectLog(detailList));
			}
			
			String strLink = null;
			strLink = "&schTxt="+StringUtil.nullCheck(adinfo.getSchTxt());
			model.addAttribute("link", strLink);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("admin.layout", "jsp", "admin/adMgr/form");
	}
	
	/* 등록/수정 */
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView update(@ModelAttribute TB_ADPDIFXM adpdinfo, @ModelAttribute TB_COATFLXD comFile, HttpServletRequest request, Model model, MultipartHttpServletRequest multipartRequest) throws Exception{
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		adpdinfo.setREGP_ID(loginUser.getMEMB_ID());
		comFile.setREGP_ID(loginUser.getMEMB_ID());  
				
		//등록, 수정 분기
		if(StringUtils.isNotEmpty(adpdinfo.getAD_ID())){
			
			//광고 상단 이미지 있을경우 기존 이미지 변경
			MultipartFile topFile =multipartRequest.getFile("topFile");
			if(StringUtils.isNotEmpty(topFile.getOriginalFilename())){
				String saveFileName = FileUtil.saveFile2(request, topFile, "jundan/"+adpdinfo.getAD_ID(), false);
				adpdinfo.setTOP_ATFL(saveFileName);
			}

			//첨부파일 처리 - 제품 이미지
			String strATFL_ID = commonService.saveFile(comFile, request, multipartRequest, "pdImgFile", "jundan/"+adpdinfo.getAD_ID(), true);
			adpdinfo.setATFL_ID(strATFL_ID);
			
			adMgrService.admgrUpdateObject(adpdinfo);
		}else {
			adMgrService.insertObject(adpdinfo);
			//광고 상단 이미지 있을경우 기존 이미지 변경
			MultipartFile topFile =multipartRequest.getFile("topFile");
			if(StringUtils.isNotEmpty(topFile.getOriginalFilename())){
				String saveFileName = FileUtil.saveFile2(request, topFile, "jundan/"+adpdinfo.getAD_ID(), false);
				adpdinfo.setTOP_ATFL(saveFileName);
			}
			
			//첨부파일 처리 - 제품 이미지
			String strATFL_ID = commonService.saveFile(comFile, request, multipartRequest, "pdImgFile", "jundan/"+adpdinfo.getAD_ID(), true);
			adpdinfo.setATFL_ID(strATFL_ID);
			
			//상단이미지, 상품이미지 둘중 하나라도 있을경우 업데이트
			if(StringUtils.isNotEmpty(topFile.getOriginalFilename()) || StringUtils.isNotEmpty(strATFL_ID) ){
				//이미지 수정을위해 업데이트
				adMgrService.updateObject(adpdinfo);
			}
			
		}
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/adMgr/edit/" + adpdinfo.getAD_ID() 
																	+ "?pageNum=" + StringUtil.nullCheck(adpdinfo.getPageNum())
																	+ "&rowCnt=" + StringUtil.nullCheck(adpdinfo.getRowCnt())
																	+ "&schTxt=" + StringUtil.nullCheck(adpdinfo.getSchTxt())));
		return new ModelAndView(rv);
	}

	/* 등록/수정   */
	@RequestMapping(value="/excelUpload",method=RequestMethod.POST)
	public ModelAndView excelUpload(@ModelAttribute TB_ADPDIFXM adpdinfo, HttpServletRequest request, Model model, MultipartHttpServletRequest multipartRequest) throws Exception{
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		adpdinfo.setREGP_ID(loginUser.getMEMB_ID()); 
		
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
	        excelReadOption.setOutputColumns("A","B","C","D","E","F","G","H","I");
	        excelReadOption.setStartRow(3);
	        	        
	        List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);
	        logger.info("getNumCellCnt>>" + excelReadOption.getNumCellCnt());

			if (excelReadOption.getNumCellCnt() < 9) {
				ModelAndView mav = new ModelAndView();
				
				mav.addObject("alertMessage", "엑셀 업로드 양식이 변경 되었거나 일치하지 않습니다. 양식 다운로드 후 다시 저장 하세요.");
				mav.addObject("returnUrl", "back");
				mav.setViewName("alertMessage");
				return mav;
			}
			
	        
			adMgrService.excelUpload(adpdinfo, excelContent);
		}

		
		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/adMgr/edit/" + adpdinfo.getAD_ID() 
																	+ "?pageNum=" + StringUtil.nullCheck(adpdinfo.getPageNum())
																	+ "&rowCnt=" + StringUtil.nullCheck(adpdinfo.getRowCnt())
																	+ "&schTxt=" + StringUtil.nullCheck(adpdinfo.getSchTxt())));
		return new ModelAndView(rv);
	}
	
	/* 복사등록  */
	@RequestMapping(value={"/copyInsert"}, method=RequestMethod.POST)
	public ModelAndView copyAdInsert(@ModelAttribute TB_ADINFOXM adinfo, HttpServletRequest request, Model model) throws Exception {
		adMgrService.copyAdInsert(adinfo);
		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/adMgr"));
		return new ModelAndView(rv);
		
	}

	
	/* 삭제 */
	@RequestMapping(value={"/delete"}, method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute TB_ADINFOXM adinfo, HttpServletRequest request, Model model) throws Exception {
		try {
			TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
			adinfo.setREGP_ID(loginUser.getMEMB_ID());	
			adMgrService.deleteObject(adinfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		RedirectView rv = new RedirectView(servletContextPath.concat("/adm/adMgr"));
		return new ModelAndView(rv);
	}
	
}
