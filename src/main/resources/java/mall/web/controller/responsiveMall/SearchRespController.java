package mall.web.controller.responsiveMall;

import java.util.Arrays;
import java.util.List;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import mall.common.util.StringUtil;
import mall.web.controller.DefaultController;
import mall.web.domain.TB_PDINFOXM;
import mall.web.service.common.CommonService;
import mall.web.service.mall.ProductService;

@Controller
@RequestMapping(value="/m/search")
public class SearchRespController extends DefaultController{

	@Resource(name="commonService")
	CommonService commonService;
	
	@Resource(name="productService")
	ProductService productService;

	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.mall.WishListController.java
	 * @Method	: index
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 상품검색 리스트
	 * @Company	: YT Corp.
	 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
	 * @Date	: 2017-01-11 (오후 2:55:14)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param tb_ipinfoxm
	 * @param model
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView index(@ModelAttribute TB_PDINFOXM productInfo, Model model,HttpServletRequest request) throws Exception {
		
		//갯수제안 없음
		if(request.getParameter("pagerMaxPageItems") !=null){
			productInfo.setRowCnt(Integer.parseInt(request.getParameter("pagerMaxPageItems").toString()));	
			productInfo.setPagerMaxPageItems(Integer.parseInt(request.getParameter("pagerMaxPageItems")));
		}else{
			productInfo.setRowCnt(26);
			productInfo.setPagerMaxPageItems(26);
		}
		
		// productInfo.setSUPR_ID("C00001");
		
		// 단독 검색
		if(productInfo.getReSearch() == null || productInfo.getReSearch().equals("")) {
			
			List schTxt_befList = Arrays.asList(productInfo.getSchTxt());
			productInfo.setSchTxt_befList(schTxt_befList);	// 기본 검색어 만 List
			productInfo.setSchTxt_bef(productInfo.getSchTxt());	// 기본 검색어를 이전 검색어 hidden 데이터로 반영
			
			
		} else {	// 결과 내 재검색
			
			// 결과 내 재검색을 체크했으면
			if(!productInfo.getReSearch().toString().equals("")){
				
				StringBuffer str = new StringBuffer();
				str.append(productInfo.getSchTxt_bef());
				
				String schTxt_first ="";
				String schTxt_last ="";
				if(productInfo.getSchTxt_bef().length() > 0){
					List<String> schTxt_bef_list = Arrays.asList(str.toString().split(","));
					if(schTxt_bef_list.size()>0){
						schTxt_first = schTxt_bef_list.get(0);
						
						schTxt_last = schTxt_bef_list.get(schTxt_bef_list.size()-1);
					}
				}
				
				if(schTxt_first.equals(productInfo.getSchTxt().toString())){	// 최초 검색어가 같으면 재검색이므로 ...
					
					if(schTxt_last.equals(productInfo.getReSearch().toString())){
						
						List schTxt_befList = Arrays.asList(productInfo.getSchTxt_bef().toString().split(","));
						productInfo.setSchTxt_befList(schTxt_befList);
						
					}else{ // 결과 내 재검색 이 null 이 아닌대 on도 아니면 페이징으로 간주 기존 값 매칭
						
						if(productInfo.getSchTxt_bef().length() > 0) {
							str.append(",");
						}
						
						str.append(productInfo.getReSearch().toString());
						productInfo.setSchTxt_bef(str.toString());
						
						List schTxt_befList = Arrays.asList(str.toString().split(","));
						productInfo.setSchTxt_befList(schTxt_befList);
					}
				}else{
					List schTxt_befList = Arrays.asList(productInfo.getSchTxt());
					productInfo.setSchTxt_befList(schTxt_befList);	// 기본 검색어 만 List
					productInfo.setSchTxt_bef(productInfo.getSchTxt());	// 기본 검색어를 이전 검색어 hidden 데이터로 반영
					
					// 재검색정보초기화
					productInfo.setReSearch("");	
				}
				
			} 
		}

		// 검색어 입력X경우, 결과 X
		if(productInfo.getReSearch() == null && productInfo.getSchTxt().toString().equals("")){
			productInfo.setCount(0);
			
			model.addAttribute("obj", productInfo);
			model.addAttribute("rowCnt", 0);			//페이지 목록수
			model.addAttribute("totalCnt", 0);			//전체 카운트
		}else{
			productInfo.setCount(productService.getObjectCount(productInfo));
			productInfo.setList(productService.getPaginatedObjectList(productInfo));
			
			model.addAttribute("obj", productInfo);
			model.addAttribute("rowCnt", productInfo.getRowCnt());			//페이지 목록수
			model.addAttribute("totalCnt", productInfo.getCount());			//전체 카운트
		}
		
		//링크설정
		String strLink = null;
		strLink = "&schGbn="+StringUtil.nullCheck(productInfo.getSchGbn()) +
				  "&schTxt_bef="+StringUtil.nullCheck(productInfo.getSchTxt_bef()) +
			      "&schTxt="+StringUtil.nullCheck(productInfo.getSchTxt()) +
			      "&sortGubun="+StringUtil.nullCheck(productInfo.getSortGubun())+
			      "&sortOdr="+StringUtil.nullCheck(productInfo.getSortOdr()) +
			      "&reSearch="+StringUtil.nullCheck(productInfo.getReSearch()) +
			      "&pagerMaxPageItems="+StringUtil.nullCheck(productInfo.getPagerMaxPageItems());
 
		model.addAttribute("link", strLink);
		
		return new ModelAndView("mall.responsive.layout", "jsp", "search/list");
	}
	
	
}
