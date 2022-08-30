package mall.web.controller.admin;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.util.JunDanUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_JDINFOXM;
import mall.web.domain.TB_MBINFOXM;
import mall.web.service.admin.impl.JundanMgrService;
import mall.web.service.common.CommonService;

/** 
* @author Ji-won Chang (Chjw@youngthink.co.kr)
* 전단 Controller
*/

@Controller
@RequestMapping(value="/adm/jundanMgr")
public class JundanMgrController extends DefaultController {

	private static final Logger logger = LoggerFactory.getLogger(MemberMgrController.class);
	
	@Resource(name="jundanMgrService")
	JundanMgrService jundanMgrService;
	
	@Resource(name="commonService")
	CommonService commonService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.JundanMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 전단 업로드 form
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
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(HttpServletRequest request, @ModelAttribute TB_JDINFOXM jdinfo, Model model) throws Exception {
 
		try {
			TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
			jdinfo.setREGP_ID(loginUser.getMEMB_ID());
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("admin.layout", "jsp", "admin/jundanMgr/form");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.JundanMgrController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 전단 등록/수정
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
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView update(@ModelAttribute TB_JDINFOXM jdpdinfo, HttpServletRequest request, Model model, MultipartHttpServletRequest multipartRequest) throws Exception{
		String errorMsg = "";
		String moveResult = "";	//이동결과
		String result = "";			//업로드결과
		String strRtURl = "";		//returnUrl

		// 전단구분
		String jdgubn = request.getParameter("JD_GUBN");
		String jdpath = "";
		if(jdgubn.equals("1")){
			jdpath = "cj_online/";
			strRtURl = "adCjOn";
		}else if(jdgubn.equals("2")){
			jdpath = "cj/";
			strRtURl = "adCjOff";
		}		
		
		try{
			// 해당 경로에 이미지 파일이 존재하는 지 체크
			int fileCnt = JunDanUtil.jundanFileCnt(request, "jundan/"+jdpath);
			
			// 존재한다면 
			if(fileCnt > 0){						
		    	// 년월일 생성		
				GregorianCalendar gc = new GregorianCalendar();
				SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
				InputStream is = null;
				Date d = gc.getTime();
				
				//현재경로			
				String path= (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/jundan/" + jdpath;
				
				// 파일 객체 생성
				File dir = new File(path);
				File[] fileList = dir.listFiles();
				
				if(fileList != null){
		        	for(File tempFile : fileList) {
						if(tempFile.isFile()) {
							//기존 이미지파일 이동
							moveResult = JunDanUtil.jundanFileMove(path, sf.format(d), tempFile.getName());							
						}
		        	}
				}
				// 디렉토리에 파일존재여부 다시체크
				fileCnt = JunDanUtil.jundanFileCnt(request, "jundan/"+jdpath);
			}
			
			//디렉토리만 있다면
			if(fileCnt == 0) {
				//첨부 이미지파일 업로드(저장)
				int i = 0;
				for (i=1; i<5; i++){
					//업로드할 파일 담기
					MultipartFile multiFile =multipartRequest.getFile("jdImgFile" + i);

			        if(multiFile==null || multiFile.isEmpty()){
			            //System.out.println("첨부파일 없음");
			        }else{
			        	//파일 업로드
						if(multiFile.getOriginalFilename() != null || StringUtils.isNotEmpty(multiFile.getOriginalFilename())){
							result = JunDanUtil.jundanFileUpload(request, multiFile, "jundan/"+jdpath, "jdImgFile" + i + "_");
						}
			        }		        
				}
			}	
		}catch(IOException e){
			result = null;
			errorMsg = e.getMessage();
		}
		
		ModelAndView mav = new ModelAndView();
		
		if(result != null || StringUtils.isNotEmpty(result)){
			// result가 성공일경우 업로드성공 팝업과 함께 전단 URL로 이동
			mav.addObject("alertMessage", "전단 업로드에 성공하였습니다.");
			mav.addObject("returnUrl", "/"+strRtURl);
			mav.setViewName("alertMessage");
		}else{
			// result가 실패일경우 업로드실패 팝업과 전단정보 화면으로 이동
			mav.addObject("alertMessage", errorMsg+"\n전단파일 업로드에 실패하였습니다. 재시도 후 같은 증상이 반복될 경우 관리자에게 문의해주세요.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");
		}
		
		return mav;
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.JundanMgrController.java
	 * @Method	: delete
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 전단 삭제
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
	@RequestMapping(value={"/delete"}, method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute TB_JDINFOXM jdinfo, HttpServletRequest request, Model model) throws Exception {
		String errorMsg = "";
		String result = "";			//이동결과
		String strRtURl = "";		//returnUrl
		
		// 전단구분
		String jdgubn = request.getParameter("JD_GUBN");
		String jdpath = "";
		if(jdgubn.equals("1")){
			jdpath = "cj_online/";
			strRtURl = "adCjOn";
		}else if(jdgubn.equals("2")){
			jdpath = "cj/";
			strRtURl = "adCjOff";
		}		

		try{
			// 해당 경로에 이미지 파일이 존재하는 지 체크
			int fileCnt = JunDanUtil.jundanFileCnt(request, "jundan/"+jdpath);
			
			// 존재한다면 
			if(fileCnt > 0){			
		    	// 년월일 폴더명 생성		
				GregorianCalendar gc = new GregorianCalendar();
				SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
				InputStream is = null;
				Date d = gc.getTime();
				
				//현재경로			
				String path= (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/jundan/" + jdpath;
				
				// 파일 객체 생성
				File dir = new File(path);
				File[] fileList = dir.listFiles();
				
				if(fileList != null){
		        	for(File tempFile : fileList) {
						if(tempFile.isFile()) {
							//기존 이미지파일 이동
							result = JunDanUtil.jundanFileMove(path, sf.format(d), tempFile.getName());
						}
		        	}
				}
				// 디렉토리에 파일존재여부 다시체크
				fileCnt = JunDanUtil.jundanFileCnt(request, "jundan/"+jdpath);
			}
		}catch(IOException e){
			result = null;
			errorMsg = e.getMessage();
		}
		
		ModelAndView mav = new ModelAndView();
		
		if(result != null || StringUtils.isNotEmpty(result)){
			// result가 성공일경우 이동성공 팝업과 함께 전단 URL로 이동
			mav.addObject("alertMessage", "전단 삭제에 성공하였습니다.");
			mav.addObject("returnUrl", "/"+strRtURl);
			mav.setViewName("alertMessage");
		}else{
			// result가 실패일경우 이동실패 팝업과 전단정보 화면으로 이동
			mav.addObject("alertMessage", errorMsg+"\n전단파일 삭제에 실패하였습니다. 재시도 후 같은 증상이 반복될 경우 관리자에게 문의해주세요.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");
		}
		
		return mav;
		
		//RedirectView rv = new RedirectView(servletContextPath.concat("/adm/jundanMgr"));
		//return new ModelAndView(rv);
	}
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.JundanMgrController.java
	 * @Method	: adTest
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 테스트용 전단화면--------사용안함
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
	@RequestMapping(value={"/adTest"}, method=RequestMethod.GET)
	public ModelAndView adTest(@ModelAttribute TB_JDINFOXM jdinfo, HttpServletRequest request,  Model model) throws Exception {
		
		//파일 경로		
		String vewInf = "jundan/cj_online/";
		String path= (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" + vewInf;
		
		//파일 읽어오기
		File dirFile=new File(path);
		File[] fileList=dirFile.listFiles();
		/*
		//viewImgTest2 (if-else용)
		if(fileList != null){
			for(File tempFile : fileList) {
				System.out.println("Path="+tempFile.getParent());
				System.out.println("FileName="+tempFile.getName());
				
				//Jundan Image File add
				if(tempFile.isFile()) {
					String[] fileIndex = tempFile.getName().split("_");
					System.out.println("FileIndex="+fileIndex[0]);
					
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
		*/

		//viewImgTest (foreach용)
		List<TB_JDINFOXM> jdfileinfo = new ArrayList<>();
		
		if(fileList != null){
			for(File tempFile : fileList) {
				if(tempFile.isFile()) {
					//System.out.println("Path="+tempFile.getParent());
					//System.out.println("FileName="+tempFile.getName());
					
					//filePath add
					TB_JDINFOXM jdpath = new TB_JDINFOXM();
					jdpath.setJD_LIST(tempFile.getName());
					jdfileinfo.add(jdpath);
				}
			}
			//전단지 리스트
			jdinfo.setList(jdfileinfo);
		}
		
		jdinfo.setCount(fileList.length);
		model.addAttribute("obj", jdinfo);

		return new ModelAndView("blankPage", "jsp", "mall/jundan/viewImgTest");
	}
	
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.JundanMgrController.java
	 * @Method	: getRolling
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 롤링이미지 업로드 form
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
	@RequestMapping(value={"/rolling"}, method=RequestMethod.GET)
	public ModelAndView getRolling(HttpServletRequest request, @ModelAttribute TB_JDINFOXM jdinfo, Model model) throws Exception {
		try {
			//파일 경로		
			String vewInf = "jundan/main/";
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
						
						if(fileIndex[0].equals("rolImgFile1")){
							jdinfo.setJD_FL1(tempFile.getName());
						}else if(fileIndex[0].equals("rolImgFile2")){
							jdinfo.setJD_FL2(tempFile.getName());
						}else if(fileIndex[0].equals("rolImgFile3")){
							jdinfo.setJD_FL3(tempFile.getName());
						}else if(fileIndex[0].equals("rolImgFile4")){
							jdinfo.setJD_FL4(tempFile.getName());
						}else if(fileIndex[0].equals("rolImgFile5")){
							jdinfo.setJD_FL5(tempFile.getName());
						}else if(fileIndex[0].equals("rolImgFile6")){
							jdinfo.setJD_FL6(tempFile.getName());
						}
					}
				}
			}
			
			// 해당 경로에 이미지 파일이 존재하는 지 체크
			int fileCnt = JunDanUtil.jundanFileCnt(request, vewInf);
			
			jdinfo.setCount(fileCnt);
			jdinfo.setJD_PATH(vewInf);
			model.addAttribute("obj", jdinfo);
			
		} catch (Exception e) {
			//e.printStackTrace();
		}

		return new ModelAndView("admin.layout", "jsp", "admin/jundanMgr/rolling");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.JundanMgrController.java
	 * @Method	: rolling
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 롤링이미지 등록/수정
	 * @Company	: YT Corp.
	 * @Author	: Ji-won Chang (Chjw@youngthink.co.kr)
	 * @Date	: 2019-06-05 (오전 10:50:25)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 */
	@RequestMapping(value={"/rolling"}, method=RequestMethod.POST)
	public ModelAndView rolling(@ModelAttribute TB_JDINFOXM jdpdinfo, HttpServletRequest request, Model model, MultipartHttpServletRequest multipartRequest,
								@RequestParam("uploadtype") String uploadtype) throws Exception{
		
		String errorMsg = "";
		String moveResult = "";								//이동결과
		String result = "";										//업로드결과
		String strRtURl = "adm/jundanMgr/rolling";		//returnUrl
		String jdpath = null;
		if(uploadtype.equals("web")) {	//웹 노출시
			jdpath = "main/";								//구분
		} else {	//모바일 노출시
			jdpath = "mobile/";
		}
			
			
		try{
			// 해당 경로에 이미지 파일이 존재하는 지 체크
			int fileCnt = JunDanUtil.jundanFileCnt(request, "jundan/"+jdpath);
				
			// 존재한다면 
			if(fileCnt > 0){						
		    	// 현재일자(년월일) 폴더명 생성		
				GregorianCalendar gc = new GregorianCalendar();
				SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
				InputStream is = null;
				Date d = gc.getTime();
				
				// 현재경로			
				String path= (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/jundan/" + jdpath;
				
				// 파일 객체 생성
				File dir = new File(path);
				File[] fileList = dir.listFiles();
				
				String[] fileIndex;				
				
				// 기존파일내역 Select	-- 수정필요				
				if(fileList != null){
		        	for(File tempFile : fileList) {
						if(tempFile.isFile()) {
							fileIndex = tempFile.getName().split("_");
							//System.out.println("FileIndex="+fileIndex[0]);
							// 파일명 Split해서 업로드 하려는 파일 코드?와 같으면 이동	-- 수정필요
							if(fileIndex[0].equals("rolImgFile"+jdpdinfo.getJD_GUBN())){								
								moveResult = JunDanUtil.jundanFileMove(path, sf.format(d), tempFile.getName());		//기존 이미지파일 이동
							}
						}
		        	}
				}				
			}
			
			// 파일명 Split해서 업로드 하려는 파일 코드?와 같은게 없다면 업로드	-- 수정필요			
			MultipartFile multiFile =multipartRequest.getFile("rolImgFile");
			// 첨부 이미지파일 업로드(저장)
	        if(multiFile==null || multiFile.isEmpty()){
	            System.out.println("첨부파일 없음");
	        }else{
	        	// 파일 업로드
				if(multiFile.getOriginalFilename() != null || StringUtils.isNotEmpty(multiFile.getOriginalFilename())){
					result = JunDanUtil.jundanFileUpload(request, multiFile, "jundan/"+jdpath, "rolImgFile" + jdpdinfo.getJD_GUBN() + "_");
				}
		    }
		}catch(IOException e){
			result = null;
			errorMsg = e.getMessage();
		}
		
		ModelAndView mav = new ModelAndView();
		
		if(result != null || StringUtils.isNotEmpty(result)){
			// result가 성공일경우 업로드성공 팝업과 함께 전단 URL로 이동
			mav.addObject("alertMessage", "이미지 업로드에 성공하였습니다.");
			mav.addObject("returnUrl", "/"+strRtURl);
			mav.setViewName("alertMessage");
		}else{
			// result가 실패일경우 업로드실패 팝업과 전단정보 화면으로 이동
			mav.addObject("alertMessage", errorMsg+"\n이미지 업로드에 실패하였습니다. 재시도 후 같은 증상이 반복될 경우 관리자에게 문의해주세요.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");
		}
		
		return mav;
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.JundanMgrController.java
	 * @Method	: rolImg
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 현재 롤링 이미지 Ajax 
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
	@RequestMapping(value={"/rolImg"}, method=RequestMethod.GET)
	public @ResponseBody TB_JDINFOXM rolImg(HttpServletRequest request, @ModelAttribute TB_JDINFOXM jdinfo, Model model) throws Exception {
		
		//노출지면 radio 체크값
		String uploadtype = request.getParameter("uploadtype");
		
		//파일 경로
		String vewInf = null;
		if(uploadtype.equals("web")) {	//웹 노출시
			vewInf = "jundan/main/";
		} else if(uploadtype.equals("mobile")) {	//모바일 노출시
			vewInf = "jundan/mobile/";
		}
		String path= (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" + vewInf;
		
		//파일 읽어오기
		File dirFile=new File(path);
		File[] fileList=dirFile.listFiles();
		
		TB_JDINFOXM obj = new TB_JDINFOXM();
		
		//구분값에 해당하는 롤링이미지 가져오기
		try {
			if(fileList != null){
				for(File tempFile : fileList) {
					System.out.println("Path="+tempFile.getParent());
					//System.out.println("FileName="+tempFile.getName());
					
					//Jundan Image File add
					if(tempFile.isFile()) {
						String[] fileIndex = tempFile.getName().split("_");
						//System.out.println("FileIndex="+fileIndex[0]);
						
						if(fileIndex[0].equals("rolImgFile"+jdinfo.getJD_GUBN())){
							obj.setJD_LIST(tempFile.getName());
						}
					}
				}
			}
		} catch (Exception e) {
			//e.printStackTrace();
		}		
		//이미지 Count
		int fileCnt = JunDanUtil.jundanFileCnt(request, vewInf);
		
		obj.setCount(fileCnt);
		obj.setJD_PATH(vewInf);
		obj.setJD_GUBN(jdinfo.getJD_GUBN());
		
		return obj;
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.JundanMgrController.java
	 * @Method	: move
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 롤링이미지 삭제
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
	@RequestMapping(value={"/move"}, method=RequestMethod.POST)
	public ModelAndView move(@ModelAttribute TB_JDINFOXM jdinfo, HttpServletRequest request, Model model) throws Exception {
		String errorMsg = "";									//에러메세지
		String result = "";										//이동결과
		String strRtURl = "adm/jundanMgr/rolling";		//returnUrl
		
		//노출지면 radio 체크값
		String uploadtype = request.getParameter("uploadtype");
		
		// 전단구분
		String jdgubn = request.getParameter("JD_GUBN");
		String jdpath = null;
		if(uploadtype.equals("web")) {	//웹 파일삭제
			jdpath = "main/";
		} else if (uploadtype.equals("mobile")) {	//모바일 파일삭제
			jdpath = "mobile/";
		}
		
		//System.out.println(jdinfo.getJD_LIST());

		try{			
	    	// 년월일 파일명 생성		
			GregorianCalendar gc = new GregorianCalendar();
			SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
			InputStream is = null;
			Date d = gc.getTime();
			
			// 현재경로			
			String path= (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/jundan/" + jdpath;
			
			// 파일 객체 생성
			File dir = new File(path);
			File[] fileList = dir.listFiles();
			
			if(fileList != null){
	        	for(File tempFile : fileList) {
					if(tempFile.isFile()) {
						//System.out.println(tempFile.getName()+"==="+jdinfo.getJD_LIST());	//이미지파일명 가져와야함 
						// 해당 이미지 체크
						if(tempFile.getName().equals(jdinfo.getJD_LIST())){
							//이미지파일 이동
							result = JunDanUtil.jundanFileMove(path, sf.format(d), tempFile.getName());
						}						
					}
	        	}
			}
		}catch(IOException e){
			result = null;
			errorMsg = e.getMessage();
		}
		
		ModelAndView mav = new ModelAndView();
		
		if(result != null || StringUtils.isNotEmpty(result)){
			// result가 성공일경우 이동성공 팝업과 함께 전단 URL로 이동
			mav.addObject("alertMessage", "이미지 삭제에 성공하였습니다.");
			mav.addObject("returnUrl", "/"+strRtURl);
			mav.setViewName("alertMessage");
		}else{
			// result가 실패일경우 이동실패 팝업과 전단정보 화면으로 이동
			mav.addObject("alertMessage", errorMsg+"\n이미지 삭제에 실패하였습니다. 재시도 후 같은 증상이 반복될 경우 관리자에게 문의해주세요.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");
		}
		
		return mav;
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.JundanMgrController.java
	 * @Method	: Hysteresis
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 이미지 관리(Tree)
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
	@RequestMapping(value={"/history"}, method=RequestMethod.GET)
	public ModelAndView hysteresis(HttpServletRequest request, @ModelAttribute TB_JDINFOXM jdinfo, Model model) throws Exception {

		String vewInf = "";		
		String topNode = "";							
		String jdgubn = request.getParameter("JD_GUBN")==null ? "" : request.getParameter("JD_GUBN");
		//System.out.println(request.getParameter("JD_GUBN"));	// null이 아닌 "null"이라 error
		
		//이미지경로 구분 ----- 온라인 ,오프라인, 롤링이미지
		if(jdgubn != null || jdgubn != ""){
			if(jdgubn.equals("1")){
				vewInf = "cj_online/";
				topNode = "cj_online";
			}else if(jdgubn.equals("2")){
				vewInf = "cj/";
				topNode = "cj";
			}else if(jdgubn.equals("3")){
				vewInf = "main/";
				topNode = "main";
			}else{
				vewInf = "main/";
				topNode = "main";
				jdinfo.setJD_GUBN("3");
			}
		}
		
		//파일 경로		
		String path= (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/jundan/" + vewInf;
		
		//파일 읽어오기
		File dirFile=new File(path);
		File[] fileList=dirFile.listFiles();
		
		//Tree 쌓기
		List<TB_JDINFOXM> jdfileinfo = new ArrayList<>();
		
		if(dirFile.exists()){
			//top directory
			TB_JDINFOXM main = new TB_JDINFOXM();
			
			main.setJD_ID(topNode);					//파일 id
			main.setJD_NAME(topNode);				//파일명
			main.setJD_PATH(vewInf);				//path
			
			jdfileinfo.add(main);
			
			if(fileList != null){
				for(File tempFile : fileList) {				
					if(tempFile.isFile()) {					
						// 파일일 경우
						//System.out.println("Directory="+tempFile.getParent());
						//System.out.println("FileName="+tempFile.getName());
						//System.out.println("Path="+tempFile.getPath());
						
						/*
						 * 현재 게시된 파일 제외한 내역만 보여주기 위해 주석처리
						 *
						TB_JDINFOXM jdpath = new TB_JDINFOXM();
						
						jdpath.setJD_ID_NEW(topNode);											//디렉토리 id
						jdpath.setJD_ID_NCOPY(topNode);										//디렉토리명
						jdpath.setJD_ID(tempFile.getName().replaceAll("[^0-9]", ""));	//파일 id
						jdpath.setJD_NAME(tempFile.getName());								//파일명
						jdpath.setJD_PATH(topNode+"/");											//path					
						
						jdfileinfo.add(jdpath);
						*/
					}else if(tempFile.isDirectory()){
						//디렉토리 일 경우
						String subPath = tempFile.getPath();
						
						File subDirFile=new File(subPath);
						File[] subList=subDirFile.listFiles();
						
						//System.out.println("Path="+subDirFile.getParent());
						//System.out.println("Path="+subDirFile.getName());
						//System.out.println("Path="+subDirFile.getPath());
						
						//filePath add
						TB_JDINFOXM subdir = new TB_JDINFOXM();
						
						subdir.setJD_ID_NEW(topNode);									//디렉토리 id
						subdir.setJD_ID_NCOPY(topNode);									//디렉토리명
						subdir.setJD_ID(subDirFile.getName());							//파일 id
						subdir.setJD_NAME(subDirFile.getName());						//파일명
						subdir.setJD_PATH(topNode+"/"+subDirFile.getName());	//path
						
						jdfileinfo.add(subdir);
						
						for(File subFile : subList) {
							if(subFile.isFile()) {
								// 파일일 경우
								//System.out.println("Directory="+subFile.getParent());
								//System.out.println("FileName="+subFile.getName());
								//System.out.println("Path="+subFile.getPath());
									
								//subPath add
								TB_JDINFOXM jdpath = new TB_JDINFOXM();
								
								jdpath.setJD_ID_NEW(subDirFile.getName());							//디렉토리 id
								jdpath.setJD_ID_NCOPY(subDirFile.getName());						//디렉토리명
								jdpath.setJD_ID(subFile.getName().replaceAll("[^0-9]", ""));		//파일 id
								jdpath.setJD_NAME(subFile.getName());									//파일명
								jdpath.setJD_PATH(topNode+"/"+subDirFile.getName()+"/"+subFile.getName());
								
								jdfileinfo.add(jdpath);
							}
						}
					}else{
						System.out.println("There is nothing.");
					}
				}
				//디렉토리 리스트
				jdinfo.setList(jdfileinfo);
			}			
		}
		jdinfo.setTOP_ATFL(topNode);
		jdinfo.setCount(fileList==null ? 0 : fileList.length);
		model.addAttribute("obj", jdinfo);
		
		return new ModelAndView("admin.layout", "jsp", "admin/jundanMgr/list");
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.JundanMgrController.java
	 * @Method	: delete2
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 파일 삭제
	 * @Company	: YT Corp.
	 * @Author	: Ji-won Chang (Chjw@youngthink.co.kr)
	 * @Date	: 2019-06-18 (오후 1:50:25)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={"/delete2"}, method=RequestMethod.POST)
	public ModelAndView delete2(@ModelAttribute TB_JDINFOXM jdinfo, HttpServletRequest request, Model model) throws Exception {		
		boolean result = false;				//결과
		String errorMsg = "";		//에러메세지
		String strRtrUrl = "/adm/jundanMgr/history";
		
		// 전단구분
		String jdgubn = request.getParameter("JD_GUBN");
		String jdpath = "";
		
		if(jdgubn.equals("1")){
			jdpath = "cj_online/";
		}else if(jdgubn.equals("2")){
			jdpath = "cj/";
		}else if(jdgubn.equals("3")){
			jdpath = "main/";
		}
		
		try{			
			File file = new File((request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/jundan/" + jdinfo.getJD_PATH());
			
			// 해당 경로에 파일이 존재하면 
			if(file.exists()){
				//삭제경로
				String deletePath = jdinfo.getJD_PATH().substring(0, jdinfo.getJD_PATH().lastIndexOf("/"));
				//System.out.println(deletePath);
				
				// 파일 삭제
				result = JunDanUtil.deleteFile2(request, "jundan/"+deletePath, jdinfo.getJD_NAME());				
			}
		}catch(IOException e){
			errorMsg = e.getMessage();
		}
		
		if(result){
			System.out.println("삭제성공");
		}else{
			System.out.println("삭제실패");
		}
		RedirectView rv = new RedirectView(servletContextPath.concat(strRtrUrl));
		return new ModelAndView(rv);
	}
	
}
