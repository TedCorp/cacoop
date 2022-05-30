package mall.web.controller.admin;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_COMCODXD;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDLINKXM;
import mall.web.service.admin.impl.CategoryMgrService;
import mall.web.service.admin.impl.ProductLinkMgrService;
import mall.web.service.common.CommonService;

@Controller
@RequestMapping(value="/adm/productLinkMgr")
public class ProductLinkMgrController extends DefaultController{

	private static final Logger logger = LoggerFactory.getLogger(ProductLinkMgrController.class);

	@Resource(name="commonService")
	CommonService commonService;

	@Resource(name="categoryMgrService")
	CategoryMgrService categoryMgrService;
	
	@Resource(name="productLinkMgrService")
	ProductLinkMgrService productLinkMgrService;
	

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductLinkMgrController.java
	 * @Method	: getList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 제품 연계 가격 조회
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-07 (오후 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getList(@ModelAttribute TB_PDINFOXM productInfo, Model model) throws Exception {
		

		//productInfo.setSUPR_ID();
		productInfo.setRowCnt(30);

		
		//정렬 초기화
		if(StringUtils.isEmpty(productInfo.getSortGubun())){
			productInfo.setSortGubun("REG_DTM");
			productInfo.setSortOdr("desc");
		}
		
		//공통코드 - 마켓구분
		TB_COMCODXD comCod = new TB_COMCODXD();
		comCod.setCOMM_CODE("MALL_GUBN");
		model.addAttribute("codMALL_GUBN", commonService.selectComCodList(comCod));
		
		productInfo.setCount(productLinkMgrService.getObjectCount(productInfo));
		productInfo.setList(productLinkMgrService.getPaginatedObjectList(productInfo));
		model.addAttribute("obj", productInfo);


		//페이징 정보
		model.addAttribute("rowCnt", productInfo.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", productInfo.getCount());		//전체 카운트

		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn())+
			      "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt())+
			      "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
			      "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr());
		
		model.addAttribute("link", strLink);
		
		return new ModelAndView("admin.layout", "jsp", "admin/productLinkMgr/list");
		
	}

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.admin.ProductLinkMgrController.java
	 * @Method	: insert
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 제품정보 등록/수정
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2016-07-07 (오후 11:05:15)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param productInfo
	 * @param request
	 * @param model
	 * @param multipartRequest
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute TB_PDLINKXM productLinkInfo, HttpServletRequest request, Model model) throws Exception {
		String strRtrUrl = "";
		
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
		productLinkInfo.setREGP_ID(loginUser.getMEMB_ID());		

		int nRtn = 0;
		nRtn = productLinkMgrService.updateObject(productLinkInfo);
		
		//링크설정
		String strLink = null;
		strLink = "pageNum="+StringUtil.nullCheck(productLinkInfo.getPageNum())+
				  "&rowCnt="+StringUtil.nullCheck(productLinkInfo.getRowCnt())+
			  	  "&schGbn="+StringUtil.nullCheck(productLinkInfo.getSchGbn())+
			  	  "&schTxt="+StringUtil.getURLEncoding(StringUtil.nullCheck(productLinkInfo.getSchTxt()))+
			      "&sortGubun="+StringUtil.nullCheck(productLinkInfo.getSortGubun())+
			      "&sortOdr="+StringUtil.nullCheck(productLinkInfo.getSortOdr());
		
		strRtrUrl = "/adm/productLinkMgr?" +strLink;
		
		RedirectView rv = new RedirectView(servletContextPath.concat(strRtrUrl));
		return new ModelAndView(rv);
	}	
}
