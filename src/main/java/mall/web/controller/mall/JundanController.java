package mall.web.controller.mall;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import mall.common.util.JunDanUtil;
import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.DefaultDomain;
import mall.web.domain.TB_JDINFOXM;
import mall.web.service.common.CommonService;
import mall.web.service.mall.AdService;

@Controller 
@RequestMapping(value="/")
public class JundanController extends DefaultController{
	private static final Logger logger = LoggerFactory.getLogger(JundanController.class);

	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="adService")
	AdService adService;

	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.JundanController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 온/오프라인 전단 
	 * @Company	: YT Corp.
	 * @Author	: Ji-won Chang (Chjw@youngthink.co.kr)
	 * @Date	: 2019-06-03 (오후 1:50:25)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	
	//삼성점
	/*
	@RequestMapping(value={"/adCj"}, method=RequestMethod.GET)
	public ModelAndView indexCj(@RequestParam Map<String,Object> map, HttpServletRequest request, Model model) throws Exception {
		map.put("REGP_ID", "cjfls");		
		return getAd(map, request, model);
	}
	*/
	@RequestMapping(value={"/adCjOff"}, method=RequestMethod.GET)
	public ModelAndView adCj(@ModelAttribute DefaultDomain defaultdomain, @ModelAttribute TB_JDINFOXM jdinfo, HttpServletRequest request,  Model model) throws Exception {

		try {
			//접속 로그
			String userAgent = request.getHeader("User-Agent");
			String strOs = StringUtil.os(userAgent);
			String strBrowser = StringUtil.browser(userAgent);
			String strIp = request.getRemoteAddr();
			
			HashMap param = new HashMap();
			param.put("AD_ID", "adCj1");
			param.put("LOG_AGENT", userAgent);
			param.put("LOG_OS", strOs);
			param.put("LOG_BROWSER", strBrowser);
			param.put("LOG_IP", strIp);
			
			adService.adLogInsert(param);

			//############ 전단 이미지 읽어오기 (시작)_20190603 #############
			//파일 경로
			String vewInf = "jundan/cj/";
			String path= (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" + vewInf;

			//파일 읽어오기
			File dirFile=new File(path);
			File[] fileList=dirFile.listFiles();
			
			//viewImgTest2
			if(fileList != null){
				for(File tempFile : fileList) {
					//System.out.println("Path="+tempFile.getParent());
					//System.out.println("FileName="+tempFile.getName());
					
					//Jundan Image File add
					if(tempFile.isFile()) {
						String[] fileIndex = tempFile.getName().split("_");
						//System.out.println("FileIndex="+fileIndex[0]);
						
						if(fileIndex[0].equals("jdImgFile1")){
							jdinfo.setJD_FL1(tempFile.getName());
						}else if(fileIndex[0].equals("jdImgFile2")){
							jdinfo.setJD_FL2(tempFile.getName());
						}else if(fileIndex[0].equals("jdImgFile3")){
							jdinfo.setJD_FL3(tempFile.getName());
						}else if(fileIndex[0].equals("jdImgFile4")){
							jdinfo.setJD_FL4(tempFile.getName());
						}else{
							
						}
					}
				}
			}
			
			// 해당 경로에 이미지 파일이 존재하는 지 체크
			int fileCnt = JunDanUtil.jundanFileCnt(request, vewInf);
			
			jdinfo.setCount(fileCnt);
			jdinfo.setJD_PATH(vewInf);
			model.addAttribute("obj", jdinfo);	
			
			//############ 전단 이미지 읽어오기 (끝)_20190603 ##############			
		} catch (Exception e) {
			//e.printStackTrace();
		}
		
		return new ModelAndView("blankPage", "jsp", "mall/jundan/viewImgTest2");
	}
	
	//삼성 온라인 전단지
	@RequestMapping(value={"/adCjOn"}, method=RequestMethod.GET)
	public ModelAndView adCj2(@ModelAttribute DefaultDomain defaultdomain, @ModelAttribute TB_JDINFOXM jdinfo, HttpServletRequest request,  Model model) throws Exception {
		
		try {
			//접속 로그
			String userAgent = request.getHeader("User-Agent");
			String strOs = StringUtil.os(userAgent);
			String strBrowser = StringUtil.browser(userAgent);
			String strIp = request.getRemoteAddr();
			
			HashMap param = new HashMap();
			param.put("AD_ID", "adCj2");
			param.put("LOG_AGENT", userAgent);
			param.put("LOG_OS", strOs);
			param.put("LOG_BROWSER", strBrowser);
			param.put("LOG_IP", strIp);
			
			adService.adLogInsert(param);
			
			//############ 전단 이미지 읽어오기 (시작)_20190603 #############
			//파일 경로		
			String vewInf = "jundan/cj_online/";
			String path= (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" + vewInf;

			//파일 읽어오기
			File dirFile=new File(path);
			File[] fileList=dirFile.listFiles();
			
			//viewImgTest2 (if-else용)
			if(fileList != null){
				for(File tempFile : fileList) {
					//System.out.println("Path="+tempFile.getParent());
					//System.out.println("FileName="+tempFile.getName());
					
					//Jundan Image File Add
					if(tempFile.isFile()) {
						String[] fileIndex = tempFile.getName().split("_");
						//System.out.println("FileIndex="+fileIndex[0]);
						
						if(fileIndex[0].equals("jdImgFile1")){
							jdinfo.setJD_FL1(tempFile.getName());
						}else if(fileIndex[0].equals("jdImgFile2")){
							jdinfo.setJD_FL2(tempFile.getName());
						}else if(fileIndex[0].equals("jdImgFile3")){
							jdinfo.setJD_FL3(tempFile.getName());
						}else if(fileIndex[0].equals("jdImgFile4")){
							jdinfo.setJD_FL4(tempFile.getName());
						}
					}
				}
			}
			
			// 해당 경로에 이미지 파일이 존재하는 지 체크
			int fileCnt = JunDanUtil.jundanFileCnt(request, vewInf);
			
			jdinfo.setCount(fileCnt);
			jdinfo.setJD_PATH(vewInf);
			model.addAttribute("obj", jdinfo);
			
			//############ 전단 이미지 읽어오기 (끝)_20190603 ##############
		} catch (Exception e) {
			//e.printStackTrace();
		}
		
		return new ModelAndView("blankPage", "jsp", "mall/jundan/viewImgTest2");
	}
	
	public ModelAndView getAd(@RequestParam Map<String,Object> map, HttpServletRequest request, Model model) throws Exception {

		String strAdId = "";
		HashMap adLast = (HashMap)adService.getObjectLast(map);
		if( adLast == null ){

			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "등록된 광고가 없습니다.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");
			
			return mav;
		}else{
			strAdId = adLast.get("AD_ID").toString();
		}

		//광고id
		map.put("AD_ID", strAdId);

		HashMap adInfo = (HashMap)adService.getObject(map);
		model.addAttribute("rtnAdInfo", adInfo);
		model.addAttribute("rtnProdList", adService.getObjectList(map));
		model.addAttribute("AD_ID", strAdId);
		logger.info(adInfo.get("END_YN").toString());

		try {
			//광고 마감 여부 및 접속 로그
			if( map.get("view") == null || !map.get("view").toString().equals("preview") ){

				if( adInfo.get("END_YN").toString().equals("Y") ){
					ModelAndView mav = new ModelAndView();
					mav.addObject("alertMessage", "종료된 광고입니다.");
					mav.addObject("returnUrl", "back");
					mav.setViewName("alertMessage");
					
					return mav;
				}				
				
				//접속 로그
				String userAgent = request.getHeader("User-Agent");
				String strOs = StringUtil.os(userAgent);
				String strBrowser = StringUtil.browser(userAgent);
				String strIp = request.getRemoteAddr();
								
				HashMap param = new HashMap();
				param.put("AD_ID", strAdId);
				param.put("LOG_AGENT", userAgent);
				param.put("LOG_OS", strOs);
				param.put("LOG_BROWSER", strBrowser);
				param.put("LOG_IP", strIp);
				
				adService.adLogInsert(param);
			}			
		} catch (Exception e) {
			//e.printStackTrace();
		}	
		
		return new ModelAndView("blankPage", "jsp", "mall/jundan/viewNewImg");
	}
}
