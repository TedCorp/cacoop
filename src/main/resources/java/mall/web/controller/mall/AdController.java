package mall.web.controller.mall;

import java.io.File;
import java.net.URLEncoder;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import mall.common.util.FileUtil;
import mall.common.util.JunDanUtil;
import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.DefaultDomain;
import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_JDINFOXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.service.common.CommonService;
import mall.web.service.mall.AdService;

@Controller 
@RequestMapping(value="/")
public class AdController extends DefaultController{
	private static final Logger logger = LoggerFactory.getLogger(AdController.class);

	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="adService")
	AdService adService;

	
	@RequestMapping(value={"/jundan", "/ad"}, method=RequestMethod.GET)
	public ModelAndView ad(@ModelAttribute DefaultDomain defaultdomain,  Model model) throws Exception {
		return new ModelAndView("blankPage", "jsp", "mall/jundan/view");
	}
	
	@RequestMapping(value={"/jundan1", "/ad1"}, method=RequestMethod.GET)
	public ModelAndView ad1(@ModelAttribute DefaultDomain defaultdomain,  Model model) throws Exception {
		return new ModelAndView("blankPage", "jsp", "mall/jundan/view1");
	}
	
	@RequestMapping(value={"/jundan2", "/ad2"}, method=RequestMethod.GET)
	public ModelAndView ad2(@ModelAttribute DefaultDomain defaultdomain,  Model model) throws Exception {
		return new ModelAndView("blankPage", "jsp", "mall/jundan/view2");
	}
	
	@RequestMapping(value={"/jundanNew", "/adNew"}, method=RequestMethod.GET)
	public ModelAndView index(@RequestParam Map<String,Object> map, HttpServletRequest request, Model model) throws Exception {
			
		String strAdId = "";

		if( map.get("AD_ID") == null ){
			strAdId = "AD0001";
		}else{
			strAdId = map.get("AD_ID").toString();
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

	@RequestMapping(value={"/jundanNew1", "/adNew1"}, method=RequestMethod.GET)
	public ModelAndView index2(@RequestParam Map<String,Object> map, Model model) throws Exception {

		HashMap param = new HashMap();
		
		//광고id
		param.put("AD_ID", "AD0001");
		map.put("AD_ID", "AD0001");
		
		model.addAttribute("rtnProdList", adService.getObjectList(map));
		//model.addAttribute("rtnCagoList", adService.getCagoList(param));
				
		return new ModelAndView("blankPage", "jsp", "mall/jundan/viewNew");
	}
	
	@RequestMapping(value={"/jundanNew2", "/adNew2"}, method=RequestMethod.GET)
	public ModelAndView index1(@ModelAttribute TB_PDINFOXM productInfo, Model model) throws Exception {

		HashMap param = new HashMap();
		
		//광고id
		param.put("AD_ID", "AD0001");
		
		model.addAttribute("rtnProdList", adService.getObjectList(param));
		model.addAttribute("rtnCagoList", adService.getCagoList(param));
				
		return new ModelAndView("blankPage", "jsp", "mall/jundan/viewNew1");
	}
	
	/**
	 * 첨부파일 다운로드
	 */	
	@RequestMapping("/imgAdInfo")
	public void adInfoFilr(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpServletResponse response) throws Exception {	

		String strAdId = map.get("AD_ID").toString();
		String strPdId = map.get("PD_ID").toString();
		String strAtflId = map.get("ATFL_ID").toString();

		//System.out.println("Id >>>>>>>>>>>> " + strAdId+"/"+strPdId);;
		if( StringUtils.isNotEmpty(strAdId )) {	
			
			String fileName = strPdId + ".jpg";
			String savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/jundan/" +strAdId + "/" + strAtflId;

			File file = new File(savePath+"/"+fileName);
			//등록된 이미지가 없을 경우
			// 1. 제품id로 제품정보 조회후 기본이미지 사용
			// 2. 일괄 업로드된 메인 이미지 찾아봄
			if (file.isFile() == false) {
				// 1번
				HashMap<String, String> param = new HashMap<String, String>();
				param.put("PD_CODE", strPdId);
				
				TB_COATFLXD model = (TB_COATFLXD) adService.selectFile(param);		

				if(model != null){
					String strSTFL_NAME = model.getSTFL_NAME().trim();
					String strSTFL_PATH = model.getSTFL_PATH().trim();
					fileName = strSTFL_NAME;
					
					//thumbnail에 있는지 확인 - 없으면 기본 이미지
					savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" + strSTFL_PATH  + "/thumbnail";
					File pdFile = new File(savePath+"/"+strSTFL_NAME);
					if (pdFile.isFile() == false) {
						savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" +strSTFL_PATH;
					}
				}
				
				// 2번
//				File fileChk = new File(savePath+"/"+fileName);
//				if (fileChk.isFile() == false) {
//					savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/product/main/thumbnail";
//					File fileThum = new File(savePath+"/"+fileName);
//					
//					if (fileThum.isFile() == false) {
//						savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/product/main";
//					}	
//				}				
			}
			
			System.out.println(">>>>>>>>>>>>" + savePath+"/"+fileName);;
			File fileChk = new File(savePath+"/"+fileName);
			if (fileChk.isFile()) {
				byte fileByte[] = FileUtils.readFileToByteArray(new File(savePath+"/"+fileName));
	
				response.setContentType("application/octet-stream");
				response.setContentLength(fileByte.length);
				response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName,"UTF-8")+"\";");
				response.setHeader("Content-Transfer-Encoding", "binary");
				response.getOutputStream().write(fileByte);
				
				response.getOutputStream().flush();
				response.getOutputStream().close();
			}
		}
	}

	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.AdController.java
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
	//관저점
	@RequestMapping(value={"/adGj"}, method=RequestMethod.GET)
	public ModelAndView indexGj(@RequestParam Map<String,Object> map, HttpServletRequest request, Model model) throws Exception {
		map.put("REGP_ID", "woori");
		
		return getAd(map, request, model);
	}
	@RequestMapping(value={"/adGj1"}, method=RequestMethod.GET)
	public ModelAndView adGj(@ModelAttribute DefaultDomain defaultdomain, HttpServletRequest request,  Model model) throws Exception {

		try {
			//접속 로그
			String userAgent = request.getHeader("User-Agent");
			String strOs = StringUtil.os(userAgent);
			String strBrowser = StringUtil.browser(userAgent);
			String strIp = request.getRemoteAddr();
			
			HashMap param = new HashMap();
			param.put("AD_ID", "adGj1");
			param.put("LOG_AGENT", userAgent);
			param.put("LOG_OS", strOs);
			param.put("LOG_BROWSER", strBrowser);
			param.put("LOG_IP", strIp);
			
			adService.adLogInsert(param);
			
		} catch (Exception e) {
			//e.printStackTrace();
		}
		
		return new ModelAndView("blankPage", "jsp", "mall/jundan/viewImgGj");
	}
	
	//유성점
	@RequestMapping(value={"/adYs"}, method=RequestMethod.GET)
	public ModelAndView indexYs(@RequestParam Map<String,Object> map, HttpServletRequest request, Model model) throws Exception {
		map.put("REGP_ID", "admin");
		
		return getAd(map, request, model);
	}
	@RequestMapping(value={"/adYs1"}, method=RequestMethod.GET)
	public ModelAndView adYs(@ModelAttribute DefaultDomain defaultdomain, HttpServletRequest request,  Model model) throws Exception {

		try {
			//접속 로그
			String userAgent = request.getHeader("User-Agent");
			String strOs = StringUtil.os(userAgent);
			String strBrowser = StringUtil.browser(userAgent);
			String strIp = request.getRemoteAddr();
			
			HashMap param = new HashMap();
			param.put("AD_ID", "adYs1");
			param.put("LOG_AGENT", userAgent);
			param.put("LOG_OS", strOs);
			param.put("LOG_BROWSER", strBrowser);
			param.put("LOG_IP", strIp);
			
			adService.adLogInsert(param);
			
		} catch (Exception e) {
			//e.printStackTrace();
		}
		
		return new ModelAndView("blankPage", "jsp", "mall/jundan/viewImgYs");
	}
	
	//둔산점
	@RequestMapping(value={"/adDs"}, method=RequestMethod.GET)
	public ModelAndView indexDs(@RequestParam Map<String,Object> map, HttpServletRequest request, Model model) throws Exception {
		map.put("REGP_ID", "woori");
		
		return getAd(map, request, model);
	}
	@RequestMapping(value={"/adDs1"}, method=RequestMethod.GET)
	public ModelAndView adDs(@ModelAttribute DefaultDomain defaultdomain, HttpServletRequest request,  Model model) throws Exception {

		try {
			//접속 로그
			String userAgent = request.getHeader("User-Agent");
			String strOs = StringUtil.os(userAgent);
			String strBrowser = StringUtil.browser(userAgent);
			String strIp = request.getRemoteAddr();
			
			HashMap param = new HashMap();
			param.put("AD_ID", "adDs1");
			param.put("LOG_AGENT", userAgent);
			param.put("LOG_OS", strOs);
			param.put("LOG_BROWSER", strBrowser);
			param.put("LOG_IP", strIp);
			
			adService.adLogInsert(param);
			
		} catch (Exception e) {
			//e.printStackTrace();
		}
		
		return new ModelAndView("blankPage", "jsp", "mall/jundan/viewImgDs");
	}
	
	//삼성점
	@RequestMapping(value={"/adCj"}, method=RequestMethod.GET)
	public ModelAndView indexCj(@RequestParam Map<String,Object> map, HttpServletRequest request, Model model) throws Exception {
		map.put("REGP_ID", "cjfls");
		
		return getAd(map, request, model);
	}
	@RequestMapping(value={"/adCj1"}, method=RequestMethod.GET)
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

		} catch (Exception e) {
			//e.printStackTrace();
		}
		
		return new ModelAndView("blankPage", "jsp", "mall/jundan/viewImgCj");
	}
	
	//삼성 온라인 전단지
	@RequestMapping(value={"/adCj2"}, method=RequestMethod.GET)
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
			
		} catch (Exception e) {
			//e.printStackTrace();
		}
		
		return new ModelAndView("blankPage", "jsp", "mall/jundan/viewImgCj2");
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
