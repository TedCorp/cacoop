package mall.web.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.util.JunDanUtil;
import mall.web.domain.Customers;
import mall.web.domain.TB_JDINFOXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDRCMDXM;
import mall.web.domain.TB_PDRCMDXM_ENTCAGO;
import mall.web.service.admin.impl.BoardMgrService;
import mall.web.service.common.CommonService;
import mall.web.service.mall.BoardService;
import mall.web.service.mall.EntryCagoService;
import mall.web.service.mall.MemberService;
import mall.web.service.mall.OrderService;
import mall.web.service.mall.ProductService;;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * 
 * @Package : mall.web.controller ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc : 초기 페이지 접속 관리용 Controller
 * @Company : YT Corp.
 * @Author : Byeong-gwon Gang (multiple@nate.com)
 * @Date : 2016-07-07 (오후 11:13:33)
 * @Version : 1.0 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 */
@Controller
@RequestMapping(value = "/")
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Value("#{servletContext.contextPath}")
	private String servletContextPath;

	@Resource(name = "commonService")
	CommonService commonService;

	@Resource(name = "productService")
	ProductService productService;

	@Resource(name = "boardMgrService")
	BoardMgrService boardMgrService;

	@Resource(name = "boardService")
	BoardService boardService;

	@Resource(name = "orderService")
	OrderService orderService;

	@Resource(name = "memberService")
	MemberService memberService;

	@Resource(name = "entrycagoService")
	EntryCagoService entrycagoService;

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.MainController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 리뉴얼전 초기 페이지 (사용안함)
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
	@RequestMapping(value = { "/main1" }, method = RequestMethod.GET)
	public ModelAndView index(@ModelAttribute TB_PDINFOXM productInfo, HttpServletRequest request, Model model) throws Exception {
		return new ModelAndView("blankPage", "jsp", "mall/main");
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.MainController.java
	 * @Method	: responsiveMall
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 메인화면 리다이렉트
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
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView index1(@ModelAttribute TB_PDINFOXM productInfo, @ModelAttribute TB_JDINFOXM jundanInfo,
			HttpServletRequest request, Model model) throws Exception {

		RedirectView redirectView = new RedirectView("/m");
		return new ModelAndView(redirectView);
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.MainController.java
	 * @Method	: responsiveMall
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 반응형 웹 메인화면
	 * @Company	: YT Corp.
	 * @Author	: Chang Ji Won
	 * @Date	: 2020-02-03 (오후 5:13:45)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value = { "/m" }, method = RequestMethod.GET) // @RequestMapping(method=RequestMethod.GET)
	public ModelAndView responsiveMall(@ModelAttribute TB_JDINFOXM jundanInfo, @ModelAttribute TB_PDINFOXM productInfo,
			HttpServletRequest request, Model model) throws Exception {
		// 상품목록
		//productInfo.setSUPR_ID("C00001");
		//productInfo.setSALE_CON("SALE_CON_01");

		// ############ 롤링이미지 읽어오기 (시작)_20190613 #############
		// 파일 경로
		String vewInf = "jundan/main/";
		String path = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" + vewInf;

		// 파일 읽어오기
		File dirFile = new File(path);
		File[] fileList = dirFile.listFiles();

		// viewImgTest2 (foreach용)
		List<TB_JDINFOXM> jdfileinfo = new ArrayList<>();

		if (fileList != null) {
			for (File tempFile : fileList) {
				// file Check
				if (tempFile.isFile()) {
					// System.out.println("FilePath="+tempFile.getPath());

					// filePath add
					TB_JDINFOXM jdpath = new TB_JDINFOXM(); // 초기화
					jdpath.setJD_LIST(tempFile.getName());
					jdfileinfo.add(jdpath);
				}
			}

			jundanInfo.setList(jdfileinfo); // Rolling Image List Add
		}

		// 해당 경로에 파일 Count
		int fileCnt = JunDanUtil.jundanFileCnt(request, vewInf);

		jundanInfo.setCount(fileCnt);
		jundanInfo.setJD_PATH(vewInf);
		model.addAttribute("obj", jundanInfo);
		// ############ 롤링이미지 읽어오기 (끝)_20190613 ##############

		// 진입카테고리
		// model.addAttribute("entrycagoList",
		// entrycagoService.getEntryCagoMasterList());

		// 진입카테고리 선택분기
		String entcago = request.getParameter("entcago");
		// 진입카테고리 선택
		if (entcago != null) {

			// 추천카테고리 리스트 불러오기
			@SuppressWarnings("unchecked")
			List<TB_PDRCMDXM_ENTCAGO> pdrcmd = (List<TB_PDRCMDXM_ENTCAGO>) productService
					.getEntCagoRcmdCagoList(entcago);
			model.addAttribute("rcmd_cago_list", pdrcmd);

			// 현재 선택한 진입카테고리 정보
			model.addAttribute("entcagoInfo", productService.getEntryCagoInfo(entcago));

			// 추천카테고리 상품 세팅
			for (TB_PDRCMDXM_ENTCAGO list : pdrcmd) {
				list.setPDLIST(productService.getEntCagoRcmdPdList(list));
			}

			// 세일 상품 세팅
			TB_PDRCMDXM_ENTCAGO saleCago = productService.getEntCagoSaleCagoList(entcago);
			if (saleCago != null) {
				model.addAttribute("salePdName", saleCago.getGRP_NM());
				model.addAttribute("saleProduct", productService.getEntCagoRcmdPdList(saleCago));
			}

			return new ModelAndView("main.responsive1_entcago.layout", "jsp", "main_entcago");
		}

		// 일반화면 (메인화면)
		// model.addAttribute("entrycagoList",
		// entrycagoService.getEntryCagoMasterList());

		// 인기좋은 판촉물
		model.addAttribute("miniInfo", productService.getMainRecommandProductList8(productInfo));

		//추천상품 사용가능 그룹목록		
		List<TB_PDRCMDXM> rcmdInfo = (List<TB_PDRCMDXM>) productService.getRcmdCagoList();
		for (TB_PDRCMDXM list : rcmdInfo) {
			list.setPDLIST(productService.getRcmdPdList(list));
		}
		model.addAttribute("rcmdInfo", rcmdInfo);
		
		return new ModelAndView("main.responsive1.layout", "jsp", "main");
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * 
	 * @Class : mall.web.controller.MainController.java
	 * @Method : main ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc : 관리자 메인 페이지
	 * @Company : YT Corp.
	 * @Author : Byeong-gwon Gang (multiple@nate.com)
	 * @Date : 2016-07-07 (오후 11:13:45)
	 *       ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 */
	@RequestMapping(value = { "/adm", "/adm/main" }, method = RequestMethod.GET)
	public ModelAndView main(@ModelAttribute Customers customers, Model model) throws Exception {
		return new ModelAndView("admin.layout", "jsp", "admin/main");
		// 관리자 계정 체크
		//RedirectView redirectView = new RedirectView("/adm/orderMgr");
		//return new ModelAndView(redirectView);
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.BasketController.java
	 * @Method	: rcmndListAjax
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 장바구니 수량변경
	 * @Company	: YT Corp.
	 * @Author	: 
	 * @Date	: 
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_bkinfoxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value = "/main1/rcmndListAjax", method = RequestMethod.GET)
	public ModelAndView rcmndListAjax(@ModelAttribute TB_PDRCMDXM prodRcmdInfo, Model model,
			@RequestParam(value = "rcmdGubn") String rcmdGubn) throws Exception {
		// 주문상태 및 결제 정보 수정
		prodRcmdInfo.setRCMD_GUBN(rcmdGubn);
		model.addAttribute("pdList", productService.getTabRecommandProductList(prodRcmdInfo));
		
		return new ModelAndView("admin.layout", "jsp", "mall/main1");
	}	
}
