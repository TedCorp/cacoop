package mall.web.controller.mall;

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
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_PDBORDXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.service.admin.impl.BoardMgrService;
import mall.web.service.common.CommonService;
import mall.web.service.mall.ProductService;

@Controller
@RequestMapping(value="/goods")
public class GoodsController extends DefaultController{

	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="productService")
	ProductService productService;

	@Resource(name="boardMgrService")
	BoardMgrService boardMgrService;
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
	public ModelAndView index(@ModelAttribute TB_PDINFOXM productInfo, Model model) throws Exception {
		if(StringUtils.isEmpty(productInfo.getCAGO_ID())){
			productInfo.setCAGO_ID("070000000000");
		}
		
		//갯수제안 없음
		productInfo.setRowCnt(120);
		productInfo.setSUPR_ID("C00001");
		//productInfo.setSALE_CON("SALE_CON_01");

		productInfo.setCount(productService.getObjectCount(productInfo));
		productInfo.setList(productService.getPaginatedObjectList(productInfo));
		model.addAttribute("obj", productInfo);

		model.addAttribute("rtnCagoInfo", productService.getCagoObject(productInfo));
		model.addAttribute("cagoDownList", productService.getCagoDownList(productInfo));
		
		//페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount());		//전체 카운트

		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn()) +
			      "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt()) +
			      "&CAGO_ID="+StringUtil.nullCheck(productInfo.getCAGO_ID());
		
		model.addAttribute("link", strLink);
		
		//카테고리 추석선물만 나오도록 
		productInfo.setCAGO_ID("070000000000");
		model.addAttribute("rtnCagoList", productService.getCagoList(productInfo));
		
		//mav.addObject("result", objRtn[1]);
		//mav.addObject("resultCate", objRtn[2]);
		
		
		return new ModelAndView("mall.layout", "jsp", "mall/goods/list_bak");
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
	public ModelAndView update(@ModelAttribute TB_PDINFOXM productInfo, BindingResult result, SessionStatus status, Model model) throws Exception {
		
		TB_PDINFOXM rtnObj = (TB_PDINFOXM)productService.getObject(productInfo);
		model.addAttribute("result", rtnObj);

		if(rtnObj == null || StringUtil.nullCheck(rtnObj.getSALE_CON()).equals("SALE_CON_03") || StringUtil.nullCheck(rtnObj.getSALE_CON()).equals("SALE_CON_04")){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "없는 상품 이거나 판매 중단된 상품입입니다.");
			mav.addObject("returnUrl", "/back");
			mav.setViewName("alertMessage");

			return mav;
		}
		
		//파일 받아오기
		TB_COATFLXD commonFile = new TB_COATFLXD();
		commonFile.setATFL_ID(rtnObj.getATFL_ID());
		model.addAttribute("fileList", commonService.selectFileList(commonFile));
		
		//현제 카테고리
		TB_PDINFOXM rtnCagoInfo = (TB_PDINFOXM)productService.getCagoObject(rtnObj);
		model.addAttribute("rtnCagoInfo",  rtnCagoInfo);
		
		//동일 카테고리 목록
		TB_PDINFOXM catagoryInfo = new TB_PDINFOXM();
		catagoryInfo.setSUPR_ID("C00001");
		catagoryInfo.setCAGO_ID(rtnCagoInfo.getUPCAGO_ID());
		model.addAttribute("rtnCagoList", productService.getCagoList(catagoryInfo));
		
		//상품 리뷰
		TB_PDBORDXM resultRev = new TB_PDBORDXM();
		resultRev.setPD_CODE(rtnObj.getPD_CODE());

		resultRev.setBRD_GUBN("BRD_GUBN_03");
		model.addAttribute("resultRev", productService.getBoardList(resultRev));

		//상품문의
		resultRev.setBRD_GUBN("BRD_GUBN_02");
		model.addAttribute("resultQna", productService.getBoardList(resultRev));
		
		
		return new ModelAndView("mall.layout", "jsp", "mall/goods/view_bak");
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
		if(productInfo.getPD_CUT_SEQ()==null||productInfo.getPD_CUT_SEQ().equals("")){
			productInfo.setPD_CUT_SEQ(null);
		}
		if(productInfo.getOPTION_CODE()==null||productInfo.getOPTION_CODE().equals("")){
			productInfo.setOPTION_CODE(null);
		}
		
		// productInfo.setREGP_ID("user");
		
		int cnt = productService.basketSelect(productInfo);

		if(cnt <= 0 ){
			
			if(StringUtils.isBlank(productInfo.getPD_QTY())) {
				productInfo.setPD_QTY("1");
			}
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
		if(loginUser==null){
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "로그인 후 이용해주세요.");
			mav.addObject("returnUrl", "/user/loginForm");
			mav.setViewName("alertMessage");
			//return mav+"";
			return "";
			
		}else{
		
			productInfo.setREGP_ID(loginUser.getMEMB_ID());
		
			//productInfo.setREGP_ID("user");
		
			int cnt = productService.wishSelect(productInfo);
		
			if(cnt <= 0 ){
				productService.wishInst(productInfo);
				cnt = 0;
			}
		
			return cnt+"";
		}
	}
	
}
