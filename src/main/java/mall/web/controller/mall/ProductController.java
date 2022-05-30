package mall.web.controller.mall;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_BKINFOXM;
import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_COMCODXD;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_PDBORDXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.service.common.CommonService;
import mall.web.service.mall.OrderService;
import mall.web.service.mall.ProductService;

@Controller
@RequestMapping(value="/product")
public class ProductController extends DefaultController{

	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="productService")
	ProductService productService;

	@Resource(name="orderService")
	OrderService orderService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.WishListController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품목록(카테고리) 리스트
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:55:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_ipinfoxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView index(@ModelAttribute TB_PDINFOXM productInfo, Model model,HttpServletRequest request) throws Exception {

		if(StringUtils.isEmpty(productInfo.getCAGO_ID())){
			productInfo.setCAGO_ID("170000000");
		}
		
		//갯수제안 없음
		if(request.getParameter("pagerMaxPageItems") !=null){
			productInfo.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems").toString()));	
			productInfo.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else{
			productInfo.setRowCnt(16);
			productInfo.setPagerMaxPageItems(16);
		}
		
		productInfo.setSUPR_ID("C00001");
		//productInfo.setSALE_CON("SALE_CON_01");

		productInfo.setCount(productService.getObjectCount(productInfo));
		productInfo.setList(productService.getPaginatedObjectList(productInfo));
		model.addAttribute("obj", productInfo);

		model.addAttribute("rtnCagoInfo", productService.getCagoObject(productInfo));
		model.addAttribute("cagoDownList", productService.getCagoDownList(productInfo));
		
		//페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount());			//전체 카운트

		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn()) +
			      "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt()) +
                  "&CAGO_ID="+StringUtil.nullCheck(productInfo.getCAGO_ID()) +
                  "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
			      "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr()) + 
			      "&pagerMaxPageItems="+StringUtil.nullCheck(productInfo.getPagerMaxPageItems());
		
		model.addAttribute("link", strLink);
		
		//카테고리 추석선물만 나오도록 
		//productInfo.setCAGO_ID("170000000");
		model.addAttribute("rtnCagoList", productService.getCagoList(productInfo));
		
		//mav.addObject("result", objRtn[1]);
		//mav.addObject("resultCate", objRtn[2]);
		
		/*TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		if(loginUser!=null)
			request.getSession().setAttribute("NOTPAYCNT", refreshOrder(loginUser.getMEMB_ID()));*/
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/product/list");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.WishListController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품 상세페이지
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:57:09)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_ipinfoxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/view/{PD_CODE}", method=RequestMethod.GET)
	public ModelAndView update(@ModelAttribute TB_PDINFOXM productInfo, TB_MBINFOXM tb_meinfoxm,BindingResult result, SessionStatus status, TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		
		TB_PDINFOXM rtnObj = (TB_PDINFOXM)productService.getObject(productInfo);
		
		// - 옵션(현재 비닐봉투색상)이 있을 경우 - //
		if(rtnObj.getOPTION_GUBN().equals("OPTION_GUBN_02"))
		{
			TB_COMCODXD cmxd = new TB_COMCODXD();
			// * 공통코드 이름이 변경될 경우 밑의 값도 변경되어야함 (COMM_CODE).
			cmxd.setCOMM_CODE("OPTION_GUBN");
			cmxd.setCOMD_CODE(rtnObj.getOPTION_GUBN());
			
			cmxd = commonService.selectComCodName(cmxd);
			
			// 상품 객체.옵션이름 = 옵션구분이름 // (rtnObj.OPTIN_GUBN_NAME) = (GUBN_NAME).
			rtnObj.setOPTION_GUBN_NAME(cmxd.getCOMDCD_NAME());
			
			// - 공통 마스터(option_gubn) 의 디테일 네임을 가지고옴 - //
			List<TB_COMCODXD> optionList = commonService.selectComCodList(cmxd);
			
			
			model.addAttribute("option_cnt", optionList.size());
			model.addAttribute("optionList", optionList);
		}
		if(rtnObj.getOPTION_GUBN() != null && !rtnObj.getOPTION_GUBN().equals("OPTION_GUBN_02")){
			model.addAttribute("option_cnt", "1");
			model.addAttribute("optionList", "test");
		}
		
		
		model.addAttribute("result", rtnObj);
		List<?> pdcutList = productService.getProCutList(productInfo);
		
		model.addAttribute("pdcut_cnt", pdcutList.size());
		model.addAttribute("pdcutList", pdcutList);

		if(rtnObj == null || StringUtil.nullCheck(rtnObj.getSALE_CON()).equals("SALE_CON_03") || StringUtil.nullCheck(rtnObj.getSALE_CON()).equals("SALE_CON_04")){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "없는 상품 이거나 판매 중단된 상품입입니다.");
			mav.addObject("returnUrl", "back");
			mav.setViewName("alertMessage");

			return mav;
		}
		
		//파일 받아오기
		if(StringUtils.isNotEmpty(rtnObj.getATFL_ID())){
			TB_COATFLXD commonFile = new TB_COATFLXD();
			commonFile.setATFL_ID(rtnObj.getATFL_ID());
			model.addAttribute("fileList", commonService.selectFileList(commonFile));
		}
		
		//파일 받아오기 - 상세이미지
		if(StringUtils.isNotEmpty(rtnObj.getDTL_ATFL_ID())){
			TB_COATFLXD commonDtlFile = new TB_COATFLXD();
			commonDtlFile.setATFL_ID(rtnObj.getDTL_ATFL_ID());
			model.addAttribute("fileDtlList", commonService.selectFileList(commonDtlFile));
		}
		
		// 상품옵션 가져오기
		// 단일 옵션일 경우 option1에 가격 정보가 있는 end옵션을 넣는다
		Object optionStart = productService.selectPdOptionStart(rtnObj.getPD_CODE());
		Object optionEnd = productService.selectPdOptionEnd(rtnObj.getPD_CODE());
		
		if(optionStart == null){
			model.addAttribute("PD_OPTION1", optionEnd);
			model.addAttribute("PD_OPTION2", optionStart);	// null
		}
		else{
			model.addAttribute("PD_OPTION1", optionStart);
			model.addAttribute("PD_OPTION2", optionEnd);
		}
		
		//현재 카테고리
		TB_PDINFOXM rtnCagoInfo = (TB_PDINFOXM)productService.getCagoObject(rtnObj);
		model.addAttribute("rtnCagoInfo",  rtnCagoInfo);
		
		//동일 카테고리 목록
		TB_PDINFOXM catagoryInfo = new TB_PDINFOXM();
		catagoryInfo.setSUPR_ID("C00001");
		catagoryInfo.setCAGO_ID(rtnCagoInfo.getUPCAGO_ID());
		model.addAttribute("rtnCagoList", productService.getCagoList(catagoryInfo));
		
		//구매후기
		TB_PDBORDXM resultRev = new TB_PDBORDXM();
		resultRev.setPD_CODE(rtnObj.getPD_CODE());
		resultRev.setBRD_GUBN("BRD_GUBN_03");
		
		//주문자만 상품평등록
		TB_ODINFOXM orderInfo = new TB_ODINFOXM();
		orderInfo.setORDER_CON("ORDER_CON_08");
		orderInfo.setPD_CODE(tb_odinfoxm.getPD_CODE());
		
		int cnt = 0;
		if(StringUtils.isNotEmpty(orderInfo.getREGP_ID())){
			cnt = orderService.orderCnt(orderInfo);
		}
		

		model.addAttribute("cnt", cnt);
		model.addAttribute("resultRev", productService.getBoardList(resultRev));
		
		//상품 문의
		TB_PDBORDXM resultQna = new TB_PDBORDXM();
		resultQna.setPD_CODE(rtnObj.getPD_CODE());
		resultQna.setBRD_GUBN("BRD_GUBN_02");
		model.addAttribute("resultQna", productService.getBoardList(resultQna));
		
		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn()) +
			      "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt()) +
                  "&CAGO_ID="+StringUtil.nullCheck(productInfo.getCAGO_ID());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("mallNew.layout", "jsp", "mall/product/view");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.WishListController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품 장바구니 등록
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:57:09)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_ipinfoxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/basketInst")
	public @ResponseBody String basketInst(@ModelAttribute TB_BKINFOXM productInfo, HttpServletRequest request) throws Exception {

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		productInfo.setREGP_ID(loginUser.getMEMB_ID());		
		//productInfo.setREGP_ID("user");
		
		int cnt = productService.basketSelect(productInfo);

		if(cnt <= 0 ){
			productService.basketInst(productInfo);
			cnt = 0;
		}
		
		return cnt+"";
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.WishListController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 관심상품 등록
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:57:09)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_ipinfoxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 */
	@RequestMapping(value="/wishInst")
	public @ResponseBody String wishInst(@ModelAttribute TB_BKINFOXM productInfo, HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		productInfo.setREGP_ID(loginUser.getMEMB_ID());		
		//productInfo.setREGP_ID("user");
		
		int cnt = productService.wishSelect(productInfo);
		
		if(cnt <= 0 ){
			productService.wishInst(productInfo);
			cnt = 0;
		}
		
		return cnt+"";
	}
	
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.WishListController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품목록(카테고리) 리스트
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:55:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_ipinfoxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/newList", method=RequestMethod.GET)
	public ModelAndView newList(@ModelAttribute TB_PDINFOXM productInfo, Model model) throws Exception {

		//갯수제안 없음
		productInfo.setRowCnt(16);
		
		productInfo.setSUPR_ID("C00001");
		productInfo.setSALE_CON("SALE_CON_01");

		productInfo.setCount(productService.getObjectCount(productInfo));
		productInfo.setList(productService.getMainNewProductList(productInfo));
		model.addAttribute("obj", productInfo);

		//페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount());			//전체 카운트

		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn()) +
			      "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt());
		
		model.addAttribute("link", strLink);

		return new ModelAndView("mallNew.layout", "jsp", "mall/product/listNew");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.WishListController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품목록(카테고리) 리스트
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:55:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_ipinfoxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/bestList", method=RequestMethod.GET)
	public ModelAndView bestList(@ModelAttribute TB_PDINFOXM productInfo, Model model) throws Exception {

		//갯수제안 없음
		productInfo.setRowCnt(16);
		
		productInfo.setSUPR_ID("C00001");
		productInfo.setSALE_CON("SALE_CON_01");

		productInfo.setCount(productService.getObjectCount(productInfo));
		productInfo.setList(productService.getMainProductList(productInfo));
		model.addAttribute("obj", productInfo);

		//페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount());			//전체 카운트

		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn()) +
			      "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt());
		
		model.addAttribute("link", strLink);

		return new ModelAndView("mallNew.layout", "jsp", "mall/product/listBest");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.WishListController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 리테일상품 카테고리 화면
	 * @Company	: YT Corp.
	 * @Author	: Hee-sun Lee (hslee@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:55:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_ipinfoxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/retailRcmd", method=RequestMethod.GET)	//retailListIcon
	public ModelAndView retailListIcon(@ModelAttribute TB_PDINFOXM productInfo, Model model) throws Exception {
		
		productInfo.setSUPR_ID("C00001");
		productInfo.setSALE_CON("SALE_CON_01");

		productInfo.setCount(productService.getObjectCount(productInfo));
		productInfo.setList(productService.getMainProductList(productInfo));
		model.addAttribute("obj", productInfo);

		//페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount());			//전체 카운트

		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn()) +
			      "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt());
		
		model.addAttribute("link", strLink);

		//return new ModelAndView("mallNew.layout", "jsp", "mall/product/listRcmdRetail");
		return new ModelAndView("mallNew.layout", "jsp", "mall/product/listRetailIcon");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.WishListController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 리테일상품 리스트 화면
	 * @Company	: YT Corp.
	 * @Author	: Hee-sun Lee (hslee@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:55:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_ipinfoxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/retailList", method=RequestMethod.GET)
	public ModelAndView retailList(@ModelAttribute TB_PDINFOXM productInfo, Model model,HttpServletRequest request) throws Exception {
		
		//갯수제안 없음
		if(request.getParameter("pagerMaxPageItems") !=null){
			productInfo.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems").toString()));	
			productInfo.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else{
			productInfo.setRowCnt(16);
			productInfo.setPagerMaxPageItems(16);
		}
		
		productInfo.setSUPR_ID("C00001");
		productInfo.setSALE_CON("SALE_CON_01");

		productInfo.setCount(productService.getRetailCount(productInfo));
		productInfo.setList(productService.getRetailProductList(productInfo));
		model.addAttribute("obj", productInfo);

		//페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount());			//전체 카운트

		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn()) +
			      "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt()) +
			      "&CAGO_ID="+StringUtil.nullCheck(productInfo.getCAGO_ID()) +
			      "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
			      "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr()) + 
			      "&pagerMaxPageItems="+StringUtil.nullCheck(productInfo.getPagerMaxPageItems())+
			      "&RETAIL_GUBN="+StringUtil.nullCheck(productInfo.getRETAIL_GUBN());
		
		model.addAttribute("link", strLink);

		return new ModelAndView("mallNew.layout", "jsp", "mall/product/listRetail");
	}
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.WishListController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 리테일추천상품 화면
	 * @Company	: YT Corp.
	 * @Author	: Hee-sun Lee (hslee@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:55:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_ipinfoxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/retailListIcon", method=RequestMethod.GET)	//retailRcmd
	public ModelAndView RcmdretailList(@ModelAttribute TB_PDINFOXM productInfo, Model model,HttpServletRequest request) throws Exception {
		
		productInfo.setSUPR_ID("C00001");
		productInfo.setSALE_CON("SALE_CON_01");

		// 추천상품테이블 리테일 추천상품 Select		 
		productInfo.setCount(productService.getRcmdRetailCount(productInfo));
		productInfo.setList(productService.getRetailRcmdList(productInfo));
		model.addAttribute("obj", productInfo);

		model.addAttribute("rtnCagoInfo", productService.getCagoObject(productInfo));
		model.addAttribute("cagoDownList", productService.getCagoDownList(productInfo));
		/*
		//갯수제안 없음
		if(request.getParameter("pagerMaxPageItems") !=null){
			productInfo.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems").toString()));	
			productInfo.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else{
			productInfo.setRowCnt(16);
			productInfo.setPagerMaxPageItems(16);
		}
		
		//페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount());			//전체 카운트

		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn()) +
			      	 "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt()) +
			      	 "&CAGO_ID="+StringUtil.nullCheck(productInfo.getCAGO_ID()) +
			      	 "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
			      	 "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr()) + 
			      	 "&pagerMaxPageItems="+StringUtil.nullCheck(productInfo.getPagerMaxPageItems());
		
		model.addAttribute("link", strLink);
		*/
		return new ModelAndView("mallNew.layout", "jsp", "mall/product/listRcmdRetail");
	}
	
	
	
	
	
	
}
