package mall.web.controller.mall;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import mall.common.digest.DigestUtils;
import mall.web.controller.DefaultController;
import mall.web.domain.GuestInfo;
import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.XTB_ODDLAIXM;
import mall.web.domain.XTB_ODINFOXD;
import mall.web.domain.XTB_ODINFOXM;
import mall.web.service.common.CommonService;
import mall.web.service.mall.RequestService;

@Controller
@RequestMapping(value="/request")
public class RequestController extends DefaultController{

	private static final Logger logger = LoggerFactory.getLogger(RequestController.class);
	
	@Resource(name="requestService")
	RequestService requestService;
	
	@Resource(name="commonService")
	CommonService commonService;

	private DigestUtils digestUtils;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.OrderController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문 내역 목록
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-27 (오후 2:07:41)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_odinfoxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping
	public ModelAndView index(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model, HttpSession session) throws Exception {

		//String strEncrpytPasswd = digestUtils.kisaSha256(tb_odinfoxm.getORDER_PW());
		//tb_odinfoxm.setORDER_PW(strEncrpytPasswd);
		

		GuestInfo guestInfo = (GuestInfo)session.getAttribute("GUEST");
		
		if(StringUtils.isEmpty(tb_odinfoxm.getBIZR_NUM()) && guestInfo != null){
			tb_odinfoxm.setBIZR_NUM(guestInfo.getBIZR_NUM());
			tb_odinfoxm.setPW_PASS("PASS");

		}
		
		
		tb_odinfoxm.setList(requestService.getObjectList(tb_odinfoxm));
		
		
		if ( tb_odinfoxm.getList().size() < 1 ) {
			ModelAndView mav = new ModelAndView();
			
			mav.addObject("alertMessage", "주문 내역이 없습니다. 사업자번호와 주문비밀번호를 확인하시기 바랍니다.");
			mav.addObject("returnUrl", "/goods");
			mav.setViewName("alertMessage");
			
			session.invalidate();
			
			return mav;

		} else {
			GuestInfo guest = new GuestInfo();
			XTB_ODINFOXM master = (XTB_ODINFOXM)tb_odinfoxm.getList().get(0);
			logger.info("getORDER_NUM>>"+master.getORDER_NUM());
			logger.info("getBIZR_NUM>>"+master.getBIZR_NUM());
			logger.info("getSTAFF_NAME>>"+master.getSTAFF_NAME());
			logger.info("getSTAFF_NAME>>"+master.getSTAFF_CPON());
			
			guest.setBIZR_NUM(master.getBIZR_NUM());
			guest.setSTAFF_NAME(master.getSTAFF_NAME());
			guest.setSTAFF_CPON(master.getSTAFF_CPON());
			
			// 세션 생성
			session.setAttribute("GUEST",  guest);

		}
		
		model.addAttribute("obj", tb_odinfoxm);
		
		return new ModelAndView("mall.layout", "jsp", "mall/request/list");
	}
	
	@RequestMapping(value="/buy", method=RequestMethod.POST)
	public ModelAndView buy(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model) throws Exception {
		
		StringTokenizer stok = new StringTokenizer(tb_odinfoxm.getPD_CODE_LIST(),"$");
		List<String> list = new ArrayList<String>();
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			list.add(str);
		}
		tb_odinfoxm.setList(requestService.getNewObjectList(list));
		model.addAttribute("obj", tb_odinfoxm);
		
		return new ModelAndView("mall.layout", "jsp", "mall/request/new");
	}
	
	@RequestMapping(value="/basketNew", method=RequestMethod.POST)
	public ModelAndView basketNewForm(@ModelAttribute XTB_ODINFOXD tb_odinfoxd, Model model) throws Exception {

		List<String> list = new ArrayList<String>();
		if(tb_odinfoxd.getPD_CODES() != null){
			for(int i=0; i<tb_odinfoxd.getPD_CODES().length; i++){
				list.add(tb_odinfoxd.getPD_CODES()[i]);
			}
		}
		List<?> objList = requestService.getNewObjectList(list);

		List<Object> rtnList = new ArrayList<Object>();
		
		for(int i=0; i<objList.size(); i++){
			XTB_ODINFOXD data = (XTB_ODINFOXD) objList.get(i);
			
			for(int j=0; j<tb_odinfoxd.getPD_CODES().length; j++){
				if(tb_odinfoxd.getPD_CODES()[j].equals(data.getPD_CODE())){
					data.setORDER_QTY(tb_odinfoxd.getORDER_QTYS()[j]);
				}
			}
			rtnList.add(data);
		}
		
		tb_odinfoxd.setList(rtnList);
		model.addAttribute("obj", tb_odinfoxd);
		
		return new ModelAndView("mall.layout", "jsp", "mall/request/new");
	}
	
	@RequestMapping(value="/basket")
	public ModelAndView basket(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model, HttpServletRequest request) throws Exception {


		Cookie[] cookies  = request.getCookies();
		String name   = "";
		String value   = "";
		String strBasket = "";
		
		if (cookies != null) {
			logger.info("//cookies>>"+cookies.length);
			for (int i = 0; i < cookies.length; i++) {
				name  = cookies[i].getName();
				value  = cookies[i].getValue();
				logger.info("name>>"+name+"//value>>"+value);
				if(name.equals("guestBasket")){
					strBasket = value;  //쿠키에 저장된 제품
				}
			}
		}
		
		// 제품코드1#수량1$제품코드2#수량2$제품코드3#수량3$
		StringTokenizer stok = new StringTokenizer(strBasket,"$");
		List<String> list = new ArrayList<String>();
		List<Object> basketList = new ArrayList<Object>();
		while(stok.hasMoreTokens()){
			String data = stok.nextToken();
			String[] str = data.split("#");
			list.add(str[0]);

			XTB_ODINFOXD objData = new XTB_ODINFOXD();
			objData.setPD_CODE(str[0]);
			objData.setORDER_QTY(str[1]);
			basketList.add(objData);
		}
		if(list.size() > 0){
			tb_odinfoxm.setList(requestService.getNewObjectList(list));
		}
		model.addAttribute("obj", tb_odinfoxm);
		model.addAttribute("basketList", basketList);
		
		return new ModelAndView("mall.layout", "jsp", "mall/request/basket");
	}
	
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, @ModelAttribute XTB_ODINFOXD tb_odinfoxd, @ModelAttribute XTB_ODDLAIXM tb_oddlaixm, @ModelAttribute TB_COATFLXD comFile, Model model, HttpServletRequest request, MultipartHttpServletRequest multipartRequest) throws Exception {

		tb_odinfoxm.setREGP_ID("guest");
		tb_odinfoxd.setREGP_ID("guest");
		tb_oddlaixm.setREGP_ID("guest");
		comFile.setREGP_ID("guest");
		
		//첨부파일 처리 - 사업자 등록증
		String strATFL_ID = commonService.saveFile(comFile, request, multipartRequest, "file", "orderExt", false);
		tb_odinfoxm.setATFL_ID(strATFL_ID);

		//첨부파일 처리 - 개별배송
		comFile.setATFL_ID(tb_odinfoxm.getDLVY_ATFL());
		String strDLVY_ATFL = commonService.saveFile(comFile, request, multipartRequest, "fileDLVY", "orderExt", false);
		tb_odinfoxm.setDLVY_ATFL(strDLVY_ATFL);

		//첨부파일 처리 - 신용카드 결제
		comFile.setATFL_ID(tb_odinfoxm.getCARD_ATFL());
		String strCARD_ATFL = commonService.saveFile(comFile, request, multipartRequest, "fileCARD", "orderExt", false);
		tb_odinfoxm.setCARD_ATFL(strCARD_ATFL);
		
		requestService.insertOrderObject(tb_odinfoxm, tb_odinfoxd, tb_oddlaixm);

		ModelAndView mav = new ModelAndView();
		mav.addObject("alertMessage", "주문 신청이 정상적으로 저장 되었습니다. '주문내역 조회'를 통해 주문내역을 확인하세요");
		mav.addObject("returnUrl", "/goods");
		mav.setViewName("alertMessage");

		return mav;
	}

	@RequestMapping(value="/edit", method=RequestMethod.POST)
	public ModelAndView edit(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, @ModelAttribute XTB_ODINFOXD tb_odinfoxd, @ModelAttribute XTB_ODDLAIXM tb_oddlaixm, @ModelAttribute TB_COATFLXD comFile, Model model, HttpServletRequest request, MultipartHttpServletRequest multipartRequest) throws Exception {

		tb_odinfoxm.setREGP_ID("guest");
		tb_odinfoxd.setREGP_ID("guest");
		tb_oddlaixm.setREGP_ID("guest");
		comFile.setREGP_ID("guest");
		
		//첨부파일 처리
		String strATFL_ID = commonService.saveFile(comFile, request, multipartRequest, "file", "orderExt", false);
		tb_odinfoxm.setATFL_ID(strATFL_ID);

		//첨부파일 처리 - 개별배송
		comFile.setATFL_ID(tb_odinfoxm.getDLVY_ATFL());
		String strDLVY_ATFL = commonService.saveFile(comFile, request, multipartRequest, "fileDLVY", "orderExt", false);
		tb_odinfoxm.setDLVY_ATFL(strDLVY_ATFL);
		
		//첨부파일 처리 - 신용카드 결제
		comFile.setATFL_ID(tb_odinfoxm.getCARD_ATFL());
		String strCARD_ATFL = commonService.saveFile(comFile, request, multipartRequest, "fileCARD", "orderExt", false);
		tb_odinfoxm.setCARD_ATFL(strCARD_ATFL);
		
		
		requestService.updateOrderObject(tb_odinfoxm, tb_odinfoxd, tb_oddlaixm);

		ModelAndView mav = new ModelAndView();
		mav.addObject("alertMessage", "주문내역 수정이 정상적으로 저장 되었습니다.");	//('주문내역 조회'를 통해 주문내역을 확인하세요)
		mav.addObject("returnUrl", "/request");
		mav.setViewName("alertMessage");

		return mav;
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.OrderController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 주문내역 상세
	 * @Company	: YT Corp.
	 * @Author	: Seok-min Jeon (smjeon@youngthink.co.kr)
	 * @Date	: 2016-07-12 (오후 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/view/{ORDER_NUM}", "/edit/{ORDER_NUM}" })
	public ModelAndView view(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model, HttpServletRequest request) throws Exception {
		
		//주문정보 마스터 정보
		XTB_ODINFOXM rtnMaster = (XTB_ODINFOXM)requestService.getMasterInfo(tb_odinfoxm);
		
		GuestInfo guestInfo = (GuestInfo)request.getSession().getAttribute("GUEST");
		
		//리턴용
		ModelAndView mav = new ModelAndView();
		mav.addObject("alertMessage", "정상적인 접근 경로가 아닙니다.(관리자에게 문의하세요.)");
		mav.addObject("returnUrl", "/goods");
		mav.setViewName("alertMessage");
		
		//조회하지 않았을경우, 조회했는데 사업자번호와 조회주문건의 사업자번호와 다를경우
		if(guestInfo == null){
			return mav;
		}else{
			if(!guestInfo.getBIZR_NUM().equals( rtnMaster.getBIZR_NUM() )){
				return mav;
			}
		}

		if(StringUtils.isNotEmpty(rtnMaster.getATFL_ID())){
			//파일 받아오기
			TB_COATFLXD commonFile = new TB_COATFLXD();
			commonFile.setATFL_ID(rtnMaster.getATFL_ID());
			model.addAttribute("fileList", commonService.selectFileList(commonFile));
		}

		if(StringUtils.isNotEmpty(rtnMaster.getDLVY_ATFL())){
			//파일 받아오기
			TB_COATFLXD commonFile = new TB_COATFLXD();
			commonFile.setATFL_ID(rtnMaster.getDLVY_ATFL());
			model.addAttribute("fileListDLVY", commonService.selectFileList(commonFile));
		}

		if(StringUtils.isNotEmpty(rtnMaster.getCARD_ATFL())){
			//파일 받아오기
			TB_COATFLXD commonFile = new TB_COATFLXD();
			commonFile.setATFL_ID(rtnMaster.getCARD_ATFL());
			model.addAttribute("fileListCARD", commonService.selectFileList(commonFile));
		}
		
		
		
		//주문정보 상세  
		rtnMaster.setList(requestService.getDetailsList(tb_odinfoxm));
		
		//배송지 정보
		XTB_ODDLAIXM rtnDelivery = new XTB_ODDLAIXM();
		rtnDelivery.setORDER_NUM(tb_odinfoxm.getORDER_NUM());
		rtnDelivery.setList(requestService.getDeliveryInfo(rtnDelivery));
		
		model.addAttribute("rtnMaster", rtnMaster);
		model.addAttribute("rtnDelivery", rtnDelivery);
		
		String strView = "view";
		String servletPath = request.getServletPath();

		if (servletPath.matches(".*edit.*")){
			strView = "edit";
		}
		//logger.info("strView>>"+strView);
		//logger.info("servletPath>>"+servletPath);
		return new ModelAndView("mall.layout", "jsp", "mall/request/"+strView);
	}
	
	
	//주문상태만 변경
	@RequestMapping(value="/condition", method=RequestMethod.POST)
	public ModelAndView conditionUpdate(@ModelAttribute XTB_ODINFOXM tb_odinfoxm, Model model, HttpServletRequest request) throws Exception {


		GuestInfo guestInfo = (GuestInfo)request.getSession().getAttribute("GUEST");
		
		//리턴용
		ModelAndView mav = new ModelAndView();
		mav.addObject("alertMessage", "정상적인 접근 경로가 아닙니다.(관리자에게 문의하세요.)");
		mav.addObject("returnUrl", "/goods");
		mav.setViewName("alertMessage");
		
		//조회하지 않았을경우, 조회했는데 사업자번호와 조회주문건의 사업자번호와 다를경우
		if(guestInfo == null){
			return mav;
		}else{
			if(!guestInfo.getBIZR_NUM().equals( tb_odinfoxm.getBIZR_NUM() )){
				return mav;
			}
		}

		tb_odinfoxm.setREGP_ID("guest");
		requestService.conditionUpdate(tb_odinfoxm);

		mav.addObject("alertMessage", "정상적으로 저장 되었습니다.");	//('주문내역 조회'를 통해 주문내역을 확인하세요)
		mav.addObject("returnUrl", "/request");
		mav.setViewName("alertMessage");

		return mav;
	}
	//
}
