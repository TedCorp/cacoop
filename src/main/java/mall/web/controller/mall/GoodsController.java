package mall.web.controller.mall;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
import mall.web.domain.TB_EXTRPROD;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_PDBORDXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDOPTION;
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
	@Transactional
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
		
		
		int cnt = 0;
		String[] options1 = productInfo.getOPTION1_VALUE().split(",");
		String[] options2 = productInfo.getOPTION2_VALUE().split(",");
		String[] options3 = productInfo.getOPTION3_VALUE().split(",");
		String[] qtys = productInfo.getPD_QTY().split(",");
		
		
		
		for(int i = 0; i < options1.length; i++) { 
			productInfo.setOPTION1_VALUE(options1[i]);
			System.out.println(productInfo);
			
			if(productInfo.getOPTION2_VALUE() != "") {
				productInfo.setOPTION2_VALUE(options2[i]);
			}
			if(productInfo.getOPTION3_VALUE() != "") {
				productInfo.setOPTION3_VALUE(options3[i]);
			}
			productInfo.setPD_QTY(qtys[i]);
			System.out.println("저기??");
			System.out.println("옵션1의 값은? : " +productInfo.getOPTION1_NAME());
			int chk = productService.basketSelect(productInfo); // 장바구니에 해당 상품이 있는지 확인
			
			
			if(chk < 1) {
				productService.basketInst(productInfo); // 장바구니에 상품 INSERT
				cnt++;
			}else {
				chk = 0;
			}
		}
		
		//추가상품 장바구니
		TB_EXTRPROD tb_extrprod=new TB_EXTRPROD();
		
		String[] extrPrd_PdCode=request.getParameter("EXTRA_PD_CODE").split(",");
		String[] extrPrd_PdQty=request.getParameter("EXTRA_PD_QTY").split(",");
		
		for(int i=0; i<extrPrd_PdCode.length; i++) {
			productInfo.setPD_CODE(extrPrd_PdCode[i]);
			productInfo.setPD_QTY(extrPrd_PdQty[i]);
			productInfo.setOPTION1_NAME("");
			productInfo.setOPTION1_VALUE("");
			productInfo.setOPTION2_NAME("");
			productInfo.setOPTION2_VALUE("");
			productInfo.setEXTRA_YN("Y");
			int chk = productService.basketSelect(productInfo); // 장바구니에 해당 상품이 있는지 확인
			if(chk < 1) {
				productService.basketInst(productInfo); // 장바구니에 상품 INSERT
			}else{
				System.out.println("추가상품 장바구니 Insert 안됨");
			}
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
	@RequestMapping(value="/optionSelect", produces = "text/html; charset=utf8")
	public @ResponseBody String optionSelect(@ModelAttribute TB_BKINFOXM productInfo, HttpServletRequest request) throws Exception {		
		
		String optionValue2 = (String)request.getParameter("optionValue2");
		String optionValue1 = (String)request.getParameter("optionValue1");
		String pdCode = (String)request.getParameter("pdCode");
		String optionDeps = (String)request.getParameter("optionDeps");
		
		HashMap<String, String> option = new HashMap<String, String>(){{
			put("Code",pdCode);
			put("Value2",optionValue2);
			put("Value1",optionValue1);
			
		}};
		
		String optionList = "";
		String opPrice ="PRICE:";
		System.out.println("optionDeps : "+optionDeps);
		
		if(optionDeps !="" && optionDeps !=null) {
			List<TB_PDOPTION> pdOption = productService.getOption3(option);

			if(pdOption.size()>1) {
				optionList = pdOption.get(0).getOPTION3_NAME();
				for(int i=0; i <pdOption.size();i++) {
					if(pdOption.get(i).getPRICE() != "0") {
						optionList += "#@"+pdOption.get(i).getOPTION3_VALUE();	
						opPrice += "#@"+pdOption.get(i).getPRICE();
					}else {
						optionList += "#@"+pdOption.get(i).getOPTION3_VALUE();
						opPrice += "#@"+pdOption.get(i).getPRICE();
					}
				}
				optionList = optionList+opPrice;
			}else {
				optionList = "";
			}

		}else {
			
			List<TB_PDOPTION> pdOption = productService.getOption2(option);
			
			if(pdOption.size()>1) {
				optionList = pdOption.get(0).getOPTION2_NAME();
				
				for(int i=0; i <pdOption.size();i++) {
					if(pdOption.get(i).getPRICE() != "0") {
						optionList += "#@"+pdOption.get(i).getOPTION2_VALUE();	
						opPrice += "#@"+pdOption.get(i).getPRICE();
					}else {
						optionList += "#@"+pdOption.get(i).getOPTION2_VALUE();
						opPrice += "#@"+pdOption.get(i).getPRICE();
					}
				}
				optionList = optionList+opPrice;
			}else {
				optionList = "";
			}
		}
		
		return optionList;
	}
	
}
