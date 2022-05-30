package mall.common.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import mall.web.domain.TB_BKINFOXM;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_PDCAGOXM;
import mall.web.service.common.CommonService;
import mall.web.service.mall.BasketService;
import mall.web.service.mall.EntryCagoService;
import mall.web.service.mall.MemberService;
import mall.web.service.mall.OrderService;
import mall.web.service.mall.ProductService;

public class UserLoginCheckInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(UserLoginCheckInterceptor.class);

	@Autowired
	private CommonService commonService;

	@Autowired
	ProductService productService;
	
	@Resource(name="orderService")
	OrderService orderService;

	@Resource(name="memberService")
	MemberService memberService;
	
	@Resource(name="basketService")
	BasketService basketService;
	
	@Resource(name="entrycagoService")
	EntryCagoService entrycagoService;
	/**
	 * 클라이언트의 요청을 컨트롤러에게 전달하기 전에 호출 리턴값 : true/false false인 경우 다음
	 * handlerinterceptor 혹은 컨트롤러를 실행시키지 않고 요청 처리를 종료
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object controller) throws Exception {

		//logger.info("LoginCheckInterceptor > preHandle > start");
		//logger.info("request.getServletPath() >> " + request.getServletPath());
		
		// 로그인 검사 예외
		if ("/commonFileDown".equals(request.getServletPath()) || 
		    "/m/user/login".equals(request.getServletPath()) ||
		    "/m/user/loginForm".equals(request.getServletPath()) || 
		    "/m/order/payReturn".equals(request.getServletPath()) || 
		    "/m/order/cashReturn".equals(request.getServletPath())
		    )
			return true;

		// 로그인 검사
		if (request.getServletPath().contains("/mypage") || 
			request.getServletPath().contains("/order") ||
			request.getServletPath().contains("/wishList") ||
			request.getServletPath().contains("/basket") || 
			request.getServletPath().contains("/m/mypage") || 
			request.getServletPath().contains("/m/order") ||
			request.getServletPath().contains("/m/wishList") ||
			request.getServletPath().contains("/m/basket") 
		) {
			// 기존 세션 정보
			TB_MBINFOXM loginUser = (TB_MBINFOXM) request.getSession().getAttribute("USER");
			
			if (loginUser == null) {
				logger.info("로그인 필요" + request.getServletPath());
				response.sendRedirect(request.getContextPath() + "/m/user/loginForm?flag=chklogin");
				/*if (request.getServletPath().contains("/m/")){
					response.sendRedirect(request.getContextPath() + "/m/user/loginForm?flag=chklogin");
				}else{
					response.sendRedirect(request.getContextPath() + "/user/loginForm?flag=chklogin");
				}*/
				
				return false;
				
			}else{
				//세션변경
				TB_ODINFOXM resultNotPayCnt= new TB_ODINFOXM();
				resultNotPayCnt.setREGP_ID(loginUser.getMEMB_ID());	
				resultNotPayCnt.setORDER_CON("ORDER_CON_01");				
				request.getSession().setAttribute("NOTPAYCNT",  orderService.getObjectCount(resultNotPayCnt));

				//배송비쿠폰
				TB_MBINFOXM deliCupon = new TB_MBINFOXM();
				deliCupon = (TB_MBINFOXM) memberService.getObject(loginUser);
				request.getSession().setAttribute("DELICUPON",  deliCupon.getDLVY_CPON());
			}
		}
		
		// 진입카테고리
		//request.getSession().setAttribute("entrycagoList", entrycagoService.getEntryCagoMasterList());
		
		//현재 카테고리
		TB_PDCAGOXM cagoInfo = new TB_PDCAGOXM();
		
		// 진입카테고리 검사 2020-03-25
		//String entcago = request.getParameter("entcago");
		
		// 진입카테고리가 존재할 경우
//		if(entcago != null){
//			request.setAttribute("entcagoInfo", productService.getEntryCagoInfo(entcago));
//			request.setAttribute("cagoList", productService.getCagoTargetList(entcago));
//		}
//		else{
			cagoInfo.setSUPR_ID("C00001");
			request.setAttribute("cagoList", productService.getCagoAllList(cagoInfo));
//		}				

		//장바구니 
		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("USER");
		if (loginUser != null) {
			TB_BKINFOXM tb_bkinfoxm = new TB_BKINFOXM();
			tb_bkinfoxm.setREGP_ID(loginUser.getMEMB_ID());
			
			tb_bkinfoxm.setList(basketService.getObjectList(tb_bkinfoxm));
			request.getSession().setAttribute("myCartList",  basketService.getObjectList(tb_bkinfoxm));
		}
		//logger.info("LoginCheckInterceptor > preHandle > finish");
		
		return true;
	}

	/**
	 * 컨트롤러가 요청을 실행한 후 처리, view(jsp)로 forward되기 전에 리턴값 : void 컨트롤러 실행도중 예외 발생인
	 * 경우 postHandle()는 실행되지 않음
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object controller, ModelAndView modelAndView) throws Exception {
	
	}

	/**
	 * 클라이언트의 요청을 처리한 뒤에 실행 리턴값 : void 컨트롤러 처리 도중이나 view 생성과정 중에 예외가 발생하더라도
	 * afterCompletion()은 실행됨
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object controller, Exception e) throws Exception {

	}

}


