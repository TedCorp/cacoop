package mall.web.controller.responsiveMall;

import java.io.File;
import java.util.ArrayList;
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

import mall.common.util.JunDanUtil;
import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_BKINFOXM;
import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_DELIVERY_ADDR;
import mall.web.domain.TB_EVENT_MAIN;
import mall.web.domain.TB_JDINFOXM;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_PDBORDXM;
import mall.web.domain.TB_PDCOMMXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDSHIPXD;
import mall.web.domain.TB_PDSHIPXM;
import mall.web.domain.TB_SHIPTEXD;
import mall.web.domain.TB_SHIPTEXM;
import mall.web.domain.TB_SPINFOXM;
import mall.web.service.admin.impl.EventMgrService;
import mall.web.service.admin.impl.ProductMgrService;
import mall.web.service.admin.impl.SupplierMgrService;
import mall.web.service.common.CommonService;
import mall.web.service.mall.OrderService;
import mall.web.service.mall.ProductService;


@Controller
@RequestMapping(value="/m/product")
public class ProductRespController extends DefaultController{

	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="productService")
	ProductService productService;

	@Resource(name="orderService")
	OrderService orderService;
	
	@Resource(name="eventMgrService")
	EventMgrService eventMgrService;
	
	@Resource(name="productMgrService")
	ProductMgrService productMgrService;
	
	@Resource(name="supplierMgrService")
	SupplierMgrService supplierMgrService;
	
	
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
	public ModelAndView index(@ModelAttribute TB_PDINFOXM productInfo,@ModelAttribute TB_JDINFOXM jundanInfo,  @ModelAttribute TB_EVENT_MAIN tb_event_main, Model model,HttpServletRequest request) throws Exception {

		  if(StringUtils.isEmpty(productInfo.getCAGO_ID())){
		         productInfo.setCAGO_ID("170000000");
		      }
		      
		      //갯수제안 없음
		      if(request.getParameter("pagerMaxPageItems") !=null){
		         productInfo.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems").toString()));   
		         productInfo.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		      }else{
		         productInfo.setRowCnt(20);
		         productInfo.setPagerMaxPageItems(20);
		      }
		      
		      productInfo.setSUPR_ID("C00001");
		      //productInfo.setSALE_CON("SALE_CON_01");

		      productInfo.setCount(productService.getObjectCount(productInfo));
		      productInfo.setList(productService.getPaginatedObjectList(productInfo));
		      model.addAttribute("obj", productInfo);

		      model.addAttribute("rtnCagoInfo", productService.getCagoObject(productInfo));
		      model.addAttribute("cagoDownList", productService.getCagoDownList(productInfo));
		      
		      //페이징 정보
		      model.addAttribute("rowCnt", productInfo.getRowCnt());         //페이지 목록수
		      model.addAttribute("totalCnt", productInfo.getCount());         //전체 카운트

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
				model.addAttribute("img", jundanInfo);
				// ############ 롤링이미지 읽어오기 (끝)_20190613 ##############
		      
		      
		      //링크설정
		      String strLink = null;
		      strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn()) +
		               "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt()) +
		               "&CAGO_ID="+StringUtil.nullCheck(productInfo.getCAGO_ID()) +
		               "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
		               "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr()) + 
		               "&pagerMaxPageItems="+StringUtil.nullCheck(productInfo.getPagerMaxPageItems());
		      
		      model.addAttribute("link", strLink);      
		      model.addAttribute("rtnCagoList", productService.getCagoList(productInfo));
		      
		      // 이벤트 목록가져오기 2021-11-05 장보라
		      //tb_event_main.setList(eventMgrService.getObjectList(tb_event_main));
		      //model.addAttribute("tb_event_main", tb_event_main);
				
		      
		      
		      /*
		      TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		      if(loginUser!=null){
		         request.getSession().setAttribute("NOTPAYCNT", refreshOrder(loginUser.getMEMB_ID()));
		      }
		      */
		      
		      return new ModelAndView("mall.responsive.layout", "jsp", "product/list");
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
	public ModelAndView update(@ModelAttribute TB_PDINFOXM productInfo, BindingResult result, SessionStatus status, TB_ODINFOXM tb_odinfoxm, HttpServletRequest request, Model model) throws Exception {
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		if(loginUser==null){
			productInfo.setMEMB_ID("");
		}else {
			productInfo.setMEMB_ID(loginUser.getMEMB_ID());
			model.addAttribute("loginUser", loginUser.getMEMB_ID());
		}
		TB_PDINFOXM rtnObj = (TB_PDINFOXM)productService.getObject(productInfo);
		model.addAttribute("result", rtnObj);
		
		TB_SPINFOXM spinfoxm = new TB_SPINFOXM();
		spinfoxm.setSUPR_ID(rtnObj.getSUPR_ID());
		model.addAttribute("supply", supplierMgrService.getObject(spinfoxm));
		
		//주소정보가져오기- 장보라
		TB_DELIVERY_ADDR tb_delivery_addr=new TB_DELIVERY_ADDR();
		System.out.println("ADD_NUM:"+rtnObj.getADD_NUM());
		tb_delivery_addr=(TB_DELIVERY_ADDR)productService.getDeliveryInfo(rtnObj);
		model.addAttribute("tb_delivery_addr", tb_delivery_addr);
		
		List<?> pdcutList = productService.getProCutList(productInfo);
		
		// 첫번째 옵션 가져오기
		List<?>  option1 = productService.getOption1(tb_odinfoxm);
		model.addAttribute("option1",option1);
		
		
		List<?> extrList = productService.getExtraPrdList(productInfo);
		model.addAttribute("extrList",extrList);
		
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

		//현재 카테고리
		TB_PDINFOXM rtnCagoInfo = (TB_PDINFOXM)productService.getCagoObject(rtnObj);
		model.addAttribute("rtnCagoInfo",  rtnCagoInfo);
		
		//동일 카테고리 목록
		TB_PDINFOXM catagoryInfo = new TB_PDINFOXM();
		catagoryInfo.setSUPR_ID("C00001");
		
		if (rtnCagoInfo != null){
			catagoryInfo.setCAGO_ID(rtnCagoInfo.getUPCAGO_ID());
			model.addAttribute("rtnCagoList", productService.getCagoList(catagoryInfo));			
		}
		
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

		int thisPage = 1;
		int rowCnt = 5;
		String pagemove = "false";
		System.out.println("qnaPage : "+(String)request.getParameter("qnaPage"));
		if( request.getParameter("qnaPage") != null ) {
			thisPage = Integer.parseInt((String)request.getParameter("qnaPage"));
			pagemove = "true";
		};
		
		resultQna.setPageNum(thisPage);
		resultQna.setPagerOffset((thisPage-1)*rowCnt+1);
		resultQna.setEndItem((thisPage-1)*rowCnt+rowCnt);
		
		System.out.println("페이지 갯수 :  "+(productService.getQnaCount(resultQna)+4)/rowCnt);
		
		model.addAttribute("QnaPage",(productService.getQnaCount(resultQna)+4)/rowCnt);
		model.addAttribute("resultQna", productService.getBoardList_paging(resultQna));
		model.addAttribute("pagemove",pagemove);
		/* 댓글 리스트 가져오기 - 이유리 */
		TB_PDCOMMXM tb_pdcommxm = new TB_PDCOMMXM();
		tb_pdcommxm.setCount(orderService.getReviewObjectCount(productInfo));
		tb_pdcommxm.setList(orderService.getReviewObjectList(productInfo));
		// 리스트 개수 10개로 제한
		tb_pdcommxm.setRowCnt(10);
		tb_pdcommxm.setPagerMaxPageItems(10);
		
		model.addAttribute("review", tb_pdcommxm);
		model.addAttribute("rowCnt", tb_pdcommxm.getRowCnt());
		model.addAttribute("totalCnt", tb_pdcommxm.getCount());
		
		/*배송비 가져오기 - 이유리 */
		TB_PDSHIPXM tb_pdshipxm = new TB_PDSHIPXM();
		tb_pdshipxm.setPD_CODE(productInfo.getPD_CODE());
		tb_pdshipxm = (TB_PDSHIPXM)productMgrService.getShipMaster(tb_pdshipxm);
		model.addAttribute("tb_pdshipxm", tb_pdshipxm);
		
		//개별일 때
		if(tb_pdshipxm != null) {
			if(tb_pdshipxm.getSHIP_CONFIG().equals("SHIP_CONFIG_02")) {
				TB_PDSHIPXD tb_pdshipxd = new TB_PDSHIPXD();
				tb_pdshipxd.setPD_CODE(productInfo.getPD_CODE());
				tb_pdshipxd.setList(productMgrService.getShipDetail(tb_pdshipxd));
				model.addAttribute("tb_pdshipxd", tb_pdshipxd);
			//템플릿일 때
			} else if(tb_pdshipxm.getSHIP_CONFIG().equals("SHIP_CONFIG_03")) {
				TB_SHIPTEXM tb_shiptexm = new TB_SHIPTEXM();
				tb_shiptexm.setTEMP_NUM(tb_pdshipxm.getTEMP_NUM());
				tb_shiptexm = (TB_SHIPTEXM)productService.getTempMaster(tb_shiptexm);
				model.addAttribute("tb_shiptexm", tb_shiptexm);
				
				if(tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_03") || tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_04")) {
					TB_SHIPTEXD tb_shiptexd = new TB_SHIPTEXD();
					tb_shiptexd.setTEMP_NUM(tb_shiptexm.getTEMP_NUM());
					tb_shiptexd.setList(productMgrService.getTempDetail(tb_shiptexd));
					model.addAttribute("tb_shiptexd", tb_shiptexd);
				}
			}
		}
		
		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn()) +
			      "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt()) +
                  "&CAGO_ID="+StringUtil.nullCheck(productInfo.getCAGO_ID());
		
		if( !(StringUtil.nullCheck(request.getAttribute("entcago")).equals("")) )
				strLink += "&entcago="+StringUtil.nullCheck(request.getAttribute("entcago"));
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("mall.responsive.layout", "jsp", "product/view");
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
	@RequestMapping(value="/basketInst")
	public @ResponseBody String basketInst(@ModelAttribute TB_BKINFOXM productInfo, HttpServletRequest request) throws Exception {

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		productInfo.setREGP_ID(loginUser.getMEMB_ID());
		
		int cnt = productService.basketSelect(productInfo);
		System.out.println("여기?");
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
	@RequestMapping(value="/wishInst")
	public @ResponseBody String wishInst(@ModelAttribute TB_BKINFOXM productInfo, HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		productInfo.setREGP_ID(loginUser.getMEMB_ID());
		
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

		return new ModelAndView("mall.responsive.layout", "jsp", "product/listNew");
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

		return new ModelAndView("mall.responsive.layout", "jsp", "product/listBest");
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
	@RequestMapping(value="/retailListIcon", method=RequestMethod.GET)
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

		return new ModelAndView("mall.responsive.layout", "jsp", "product/listRetailIcon");
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
		return new ModelAndView("mall.responsive.layout", "jsp", "product/listRetail");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.ProductRespController.java
	 * @Method	: eventList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 기획전 리스트
	 * @Author	: jang Bora
	 * @Date	: 2021-11-04
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_event_main
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/eventList", method=RequestMethod.GET)
	public ModelAndView eventList(@ModelAttribute TB_EVENT_MAIN tb_event_main, Model model, HttpServletRequest request)throws Exception  {
		
		tb_event_main.setList(eventMgrService.getObjectListMain(tb_event_main));
		model.addAttribute("tb_event_main", tb_event_main);
		
		
	
		
		return new ModelAndView("mall.responsive.layout", "jsp", "product/eventList");
	}
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.ProductRespController.java
	 * @Method	: eventDetail
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 기획전 디테일
	 * @Author	: jang Bora
	 * @Date	: 2021-11-04
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_event_main
	 * @param model tb_pdinfoxm
	 * @param model
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/eventDetail", method=RequestMethod.GET)
	public ModelAndView eventDetail(@ModelAttribute TB_EVENT_MAIN tb_event_main, 
									@ModelAttribute TB_PDINFOXM productInfo, 
									Model model,HttpServletRequest request)throws Exception  {
	
		productInfo.setRowCnt(20);
		productInfo.setPagerMaxPageItems(20);
		productInfo.setCount(eventMgrService.selectCount(tb_event_main)); 
		model.addAttribute("rowCnt", productInfo.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount());			//전체 카운트
		
		
	    if(StringUtils.isNotEmpty(tb_event_main.getGRP_CD())){
	    	System.out.println(1);
	    	TB_EVENT_MAIN tem = (TB_EVENT_MAIN)eventMgrService.getObject(tb_event_main);
	    	System.out.println(2);
	 
	    	productInfo.setList(eventMgrService.selectProduct(tb_event_main));
	    	System.out.println(3);

	     	//상품정렬
			if( tb_event_main.getSortOdr()!=null && tb_event_main.getSortOdr()!="") {
				productInfo.setList(eventMgrService.getOrderByList(tb_event_main));
			}	     
			
			//파일 받아오기 - 상세이미지
			if(StringUtils.isNotEmpty(tem.getATFL_ID_D())){
				TB_COATFLXD commonDtlFile = new TB_COATFLXD();
				commonDtlFile.setATFL_ID(tem.getATFL_ID_D());
				model.addAttribute("fileDtlList", commonService.selectFileList(commonDtlFile));
			}
			
			System.out.println(4);
			model.addAttribute("testtest5512", tem.getD_USE_YN());
			model.addAttribute("tem", tem);
			model.addAttribute("obj",productInfo);
			
			System.out.println("tem 그거 : " + tem.getD_USE_YN());
			System.out.println("tem 그거 : " + tem.getGRP_NM());
			
		}else {
			System.out.println("저장된 제품이 없습니다");
		}
	    
	    
	    
	    
	    String strLink = null;
	    strLink = "&GRP_CD="+StringUtil.nullCheck(tb_event_main.getGRP_CD())+
	    		  "&schGbn="+StringUtil.nullCheck(tb_event_main.getSchGbn()) +
			      "&sortGubun="+StringUtil.nullCheck(tb_event_main.getSortGubun())+
			      "&sortOdr="+StringUtil.nullCheck(tb_event_main.getSortOdr());
	    
	    model.addAttribute("link", strLink);
			
		return new ModelAndView("mall.responsive.layout", "jsp", "product/eventDetail");
	}
	
	@RequestMapping(value="/insertQna", produces = "text/html; charset=utf8")
	public @ResponseBody String insertQna(@ModelAttribute TB_BKINFOXM productInfo, HttpServletRequest request) throws Exception {		
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		String pdCode = (String)request.getParameter("pdCode");
		String brd_cont = (String)request.getParameter("brd_cont");
		String brd_sbjt = (String)request.getParameter("brd_sbjt");
		String brd_pw = (String)request.getParameter("brd_pw");

		System.out.println("asfasdfas");
		TB_PDBORDXM tb_pdbordxm = new TB_PDBORDXM();
		tb_pdbordxm.setPD_CODE(pdCode);
		tb_pdbordxm.setBRD_CONT(brd_cont);
		tb_pdbordxm.setBRD_SBJT(brd_sbjt);
		tb_pdbordxm.setBRD_PW(brd_pw);
		tb_pdbordxm.setMEMB_ID(loginUser.getMEMB_ID());
		int update = productService.insertQna(tb_pdbordxm);
	
		return update+"";
	}
	
	
}