package mall.web.controller.responsiveMall;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.web.controller.DefaultController;
import mall.web.domain.Deliverys;
import mall.web.domain.TB_BKINFOXM;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDSHIPXD;
import mall.web.domain.TB_PDSHIPXM;
import mall.web.domain.TB_SHIPTEXD;
import mall.web.domain.TB_SHIPTEXM;
import mall.web.domain.TB_SPINFOXM;
import mall.web.service.admin.impl.ProductMgrService;
import mall.web.service.admin.impl.SupplierMgrService;
import mall.web.service.mall.BasketService;

@Controller
@RequestMapping(value="/m/basket")
public class BasketRespController extends DefaultController{

	@Resource(name="basketService")
	BasketService basketService;

	@Resource(name="supplierMgrService")
	SupplierMgrService supplierMgrService;
	
	@Resource(name="productMgrService")
	ProductMgrService productMgrService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.BasketRespController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 장바구니 리스트
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:55:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_bkinfoxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView index(@ModelAttribute TB_BKINFOXM tb_bkinfoxm, Model model, HttpServletRequest request) throws Exception {

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		if(loginUser==null){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "로그인 후 이용해주세요.");
			mav.addObject("returnUrl", "/user/loginForm");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		tb_bkinfoxm.setREGP_ID(loginUser.getMEMB_ID());		
		tb_bkinfoxm.setList(basketService.getObjectList(tb_bkinfoxm));
		
		
		model.addAttribute("obj", tb_bkinfoxm);

		List<TB_PDINFOXM> list = new ArrayList<TB_PDINFOXM>();
		tb_bkinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		list = (List<TB_PDINFOXM>)basketService.getSuprDlvyAmt(tb_bkinfoxm);
		
		/* 배송비 계산 - 이유리 */
		int TOTAL_DLVY_AMT = 0;
		
		for(TB_PDINFOXM index : list) {
			TOTAL_DLVY_AMT += Integer.parseInt(index.getDLVY_AMT()); 
		}
		
		System.out.println("총 가격 : " + TOTAL_DLVY_AMT);
		
		TB_PDSHIPXM tb_pdshipxm = new TB_PDSHIPXM();
		tb_pdshipxm.setDLVY_AMT(TOTAL_DLVY_AMT + "");
		model.addAttribute("tb_pdshipxm", tb_pdshipxm);
		
		//배송비 조건
		TB_SPINFOXM supplierInfo = new TB_SPINFOXM();
		supplierInfo.setSUPR_ID(loginUser.getSUPR_ID());
		model.addAttribute("supplierInfo", (TB_SPINFOXM)supplierMgrService.getObject(supplierInfo));
		
		return new ModelAndView("mall.responsive.layout", "jsp", "basket/list");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.BasketRespController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 장바구니로 이동
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:57:09)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_bkinfoxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/{INTPD_REGNO}" , "/multi"}, method=RequestMethod.POST)
	public ModelAndView update(@ModelAttribute TB_BKINFOXM tb_bkinfoxm, BindingResult result, SessionStatus status, Model model, HttpServletRequest request) throws Exception {
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		tb_bkinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		tb_bkinfoxm.setMODP_ID(loginUser.getMEMB_ID());
		
		if (tb_bkinfoxm.getSTATE_GUBUN().equals("MOVE")) {
			basketService.insertMultiObject(tb_bkinfoxm);
		}else{
			basketService.insertObject(tb_bkinfoxm);
		}
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/m/basket");		
		return new ModelAndView(redirectView);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.BasketRespController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 장바구니 삭제
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:57:09)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_bkinfoxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value={ "/delete/{INTPD_REGNO}" , "/delete/multi"}, method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute TB_BKINFOXM tb_bkinfoxm, BindingResult result, SessionStatus status, Model model) throws Exception {
		
		if (tb_bkinfoxm.getSTATE_GUBUN().equals("DELETE")) {
			basketService.deleteMulitObject(tb_bkinfoxm);
		}else{
			basketService.deleteObject(tb_bkinfoxm);
		}
		
		RedirectView redirectView = new RedirectView(servletContextPath+"/m/basket");		
		return new ModelAndView(redirectView);
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.BasketRespController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 장바구니 수량변경
	 * @Company	: YT Corp.
	 * @Author	: HEESUN-LEE (hslee@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:57:09)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_bkinfoxm
	 * @param result
	 * @param status
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/qtyUpdate",method=RequestMethod.GET)
	@ResponseBody
	public List pickingUpdate(TB_BKINFOXM tb_bkinfoxm, Model model
			,@RequestParam(value="CHK_BSKT") String chkBskt, @RequestParam(value="PD_QTY") String pdQty
			,@RequestParam(value="SETPD_CODE") String setpdCode
			,HttpServletRequest request) throws Exception{
		//주문상태 및 결제 정보 수정
		//System.out.println("pdQty===="+pdQty);
		tb_bkinfoxm.setPD_QTY(pdQty);
		tb_bkinfoxm.setBSKT_REGNO(chkBskt);
	
		basketService.updateObject(tb_bkinfoxm);
		
		/* 베송비 수정 - 이유리 */
		//상품 개수&총합 가져오기
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		TB_BKINFOXM bkinInfo = new TB_BKINFOXM();
		bkinInfo.setREGP_ID(loginUser.getMEMB_ID());
		bkinInfo.setSETPD_CODE(setpdCode);
		bkinInfo = (TB_BKINFOXM)basketService.selectBkinInfo(bkinInfo);
		
		int PD_QTY = Integer.parseInt(bkinInfo.getPD_QTY());
		int PD_PRICE = Integer.parseInt(bkinInfo.getPD_PRICE());
		System.out.println("PD 개수 : " + PD_QTY);
		System.out.println("PD 금액 : " + PD_PRICE);
		
		bkinInfo.setSETPD_CODE(setpdCode);
		bkinInfo.setREGP_ID(loginUser.getMEMB_ID());
		System.out.println("setPD 값은 : " + setpdCode);
		
		//배송비 마스터 가져오기
		TB_PDSHIPXM tb_pdshipxm = new TB_PDSHIPXM();
		tb_pdshipxm.setPD_CODE(setpdCode);
		tb_pdshipxm = (TB_PDSHIPXM)productMgrService.getShipMaster(tb_pdshipxm);
		
		//배송비 개별
		if(tb_pdshipxm.getSHIP_CONFIG().equals("SHIP_CONFIG_02")) {
			//배송비 디테일 가져오기
			if(tb_pdshipxm.getSHIP_GUBN().equals("SHIP_GUBN_03") || tb_pdshipxm.getSHIP_GUBN().equals("SHIP_GUBN_04")) {
				TB_PDSHIPXD tb_pdshipxd = new TB_PDSHIPXD();
				List<TB_PDSHIPXD> list = new ArrayList<TB_PDSHIPXD>();
				tb_pdshipxd.setPD_CODE(setpdCode);
				list = (List<TB_PDSHIPXD>)productMgrService.getShipDetail(tb_pdshipxd);
				
				for(TB_PDSHIPXD index2 : list) {
					String PD_CODE = index2.getPD_CODE();
					int GUBN_START = Integer.parseInt(index2.getGUBN_START());
					int GUBN_END = Integer.parseInt(index2.getGUBN_END());
					int DLVY_AMT = Integer.parseInt(index2.getDLVY_AMT());
					System.out.println("여기부터 시작");
					System.out.println(GUBN_START);
					System.out.println(GUBN_END);
					System.out.println(DLVY_AMT);
					
					//구매금액별
					if(tb_pdshipxm.getSHIP_GUBN().equals("SHIP_GUBN_03")) {
						if(setpdCode.equals(PD_CODE)) {
							if((PD_PRICE > GUBN_START || PD_PRICE == GUBN_START) && PD_PRICE < GUBN_END) {
								bkinInfo.setDLVY_AMT(DLVY_AMT + "");
								basketService.updateDlvyAmt(bkinInfo);
							}
						}
					//상품수량별
					} else {
						if(setpdCode.equals(PD_CODE)) {
							if((PD_QTY > GUBN_START || PD_QTY == GUBN_START) && PD_QTY < GUBN_END) {
								bkinInfo.setDLVY_AMT(DLVY_AMT + "");
								basketService.updateDlvyAmt(bkinInfo);
							}
						}
					}
				}
			//조건부무료배송
			} else if(tb_pdshipxm.getSHIP_GUBN().equals("SHIP_GUBN_02")) {
				//무료조건을 충족할 때
				if(PD_PRICE > Integer.parseInt(tb_pdshipxm.getGUBN_START()) || PD_PRICE == Integer.parseInt(tb_pdshipxm.getGUBN_START())) {
					bkinInfo.setDLVY_AMT("0");
					basketService.updateDlvyAmt(bkinInfo);
				//무료조건을 충족하지 않았을 때
				} else {
					bkinInfo.setDLVY_AMT(tb_pdshipxm.getDLVY_AMT());
					basketService.updateDlvyAmt(bkinInfo);
				}
			}
		//배송비 템플릿
		} else if(tb_pdshipxm.getSHIP_CONFIG().equals("SHIP_CONFIG_03")) {
			TB_SHIPTEXM tb_shiptexm = new TB_SHIPTEXM();
			tb_shiptexm.setTEMP_NUM(tb_pdshipxm.getTEMP_NUM());
			tb_shiptexm.setSUPR_ID(tb_pdshipxm.getSUPR_ID());
			tb_shiptexm.setREGP_ID(loginUser.getMEMB_ID());
			tb_shiptexm = (TB_SHIPTEXM)productMgrService.getTempMaster(tb_shiptexm);
			
			//배송비 디테일 가져오기
			if(tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_03") || tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_04")) {
				TB_SHIPTEXD tb_shiptexd = new TB_SHIPTEXD();
				List<TB_SHIPTEXD> list2 = new ArrayList<TB_SHIPTEXD>();
				tb_shiptexd.setTEMP_NUM(tb_pdshipxm.getTEMP_NUM());
				list2 = (List<TB_SHIPTEXD>)productMgrService.getTempDetail(tb_shiptexd);
				
				for(TB_SHIPTEXD index2 : list2) {
					String TEMP_NUM = index2.getTEMP_NUM();
					int GUBN_START = Integer.parseInt(index2.getGUBN_START());
					int GUBN_END = Integer.parseInt(index2.getGUBN_START());
					int DLVY_AMT = Integer.parseInt(index2.getDLVY_AMT());
					//구매금액별
					if(tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_03")) {
						if(tb_shiptexd.getTEMP_NUM().equals(TEMP_NUM)) {
							if((PD_PRICE > GUBN_START || PD_PRICE == GUBN_START) && PD_PRICE < GUBN_END) {
								bkinInfo.setDLVY_AMT(DLVY_AMT + "");
								basketService.updateDlvyAmt(bkinInfo);
							}
						}
					//상품수량별
					} else {
						if(tb_shiptexd.getTEMP_NUM().equals(TEMP_NUM)) {
							if((PD_QTY > GUBN_START || PD_QTY == GUBN_START) && PD_QTY < GUBN_END) {
								bkinInfo.setDLVY_AMT(DLVY_AMT + "");
								basketService.updateDlvyAmt(bkinInfo);
							}
						}
					}
				}
			//조건부무료배송
			} else if(tb_shiptexm.getSHIP_GUBN().equals("SHIP_GUBN_02")) {
				//무료조건을 충족할 때
				if(PD_PRICE > Integer.parseInt(tb_shiptexm.getGUBN_START()) || PD_PRICE == Integer.parseInt(tb_shiptexm.getGUBN_START())) {
					bkinInfo.setDLVY_AMT("0");
					basketService.updateDlvyAmt(bkinInfo);
				//무료조건을 충족하지 않았을 때
				} else {
					bkinInfo.setDLVY_AMT(tb_shiptexm.getDLVY_AMT());
					basketService.updateDlvyAmt(bkinInfo);
				}
			}
		//배송비 기본
		} else {
			//무료조건을 충족할 때
			if(PD_PRICE > Integer.parseInt(tb_pdshipxm.getGUBN_START()) || PD_PRICE == Integer.parseInt(tb_pdshipxm.getGUBN_START())) {
				bkinInfo.setDLVY_AMT("0");
				basketService.updateDlvyAmt(bkinInfo);
			//무료조건을 충족하지 않았을 때
			} else {
				bkinInfo.setDLVY_AMT(tb_pdshipxm.getDLVY_AMT());
				basketService.updateDlvyAmt(bkinInfo);
			}
		}
		
		List<TB_PDINFOXM> list = new ArrayList<TB_PDINFOXM>();
		tb_bkinfoxm.setREGP_ID(loginUser.getMEMB_ID());
		list = (List<TB_PDINFOXM>)basketService.getSuprDlvyAmt(tb_bkinfoxm);
		
		/* 배송비 계산 - 이유리 */
		/*
		이전 계산코드 
		int TOTAL_DLVY_AMT = 0;
		for(TB_PDINFOXM index : list) {
			TOTAL_DLVY_AMT += Integer.parseInt(index.getDLVY_AMT()); 
			System.out.println(index.getDLVY_AMT());
		}

		System.out.println("그래서 배송비는?" + TOTAL_DLVY_AMT);
		*/
		
		return list;
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.BasketRespController.java
	 * @Method	: getEstimate
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 견적서 발행
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
	@RequestMapping(value={ "/estimate" }, method=RequestMethod.POST)
	public ModelAndView getEstimate(@ModelAttribute Deliverys delivery, Model model,HttpServletRequest request,
			@RequestParam(value="checkArray", defaultValue="") List<String> arrayParams) throws Exception {
		
		// 견적서 정보
		TB_SPINFOXM supplier = new TB_SPINFOXM();
		supplier = (TB_SPINFOXM)supplierMgrService.getObject(delivery);
		delivery.setList(basketService.getPaginatedObjectList(arrayParams));
		
		model.addAttribute("supplier", supplier);
		model.addAttribute("estimate", delivery);
		
		return new ModelAndView("blankPage", "jsp", "responsiveMall/basket/print");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.BasketRespController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 장바구니 팝업 (로직없음)
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-26 (오후 2:55:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_bkinfoxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	
	@RequestMapping(value={ "/popView"}, method=RequestMethod.GET)
	public ModelAndView popView(@ModelAttribute TB_BKINFOXM tb_bkinfoxm, Model model, HttpServletRequest request) throws Exception {

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		
		if(loginUser==null){
			ModelAndView mav = new ModelAndView();
			mav.addObject("alertMessage", "로그인 후 이용해주세요.");
			mav.addObject("returnUrl", "/user/loginForm");
			mav.setViewName("alertMessage");
			return mav;
		}
		
		tb_bkinfoxm.setREGP_ID(loginUser.getMEMB_ID());		
		tb_bkinfoxm.setList(basketService.getObjectList(tb_bkinfoxm));
		model.addAttribute("obj", tb_bkinfoxm);
		
		return new ModelAndView("blankPage", "jsp", "responsiveMall/basket/popupView");
	}
	*/
}
