package mall.common.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_SYSMNUXM;
import mall.web.service.common.CommonService;

public class AdminLoginCheckInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(AdminLoginCheckInterceptor.class);

	@Autowired
	private CommonService commonService;
	
	/**
	 * 클라이언트의 요청을 컨트롤러에게 전달하기 전에 호출 리턴값 : true/false false인 경우 다음
	 * handlerinterceptor 혹은 컨트롤러를 실행시키지 않고 요청 처리를 종료
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object controller) throws Exception {

		//logger.info("LoginCheckInterceptor > preHandle > start");
		// 로그인 검사 예외
		if ("/adm/loginForm".equals(request.getServletPath()) || 
		    "/adm/login".equals(request.getServletPath()) || 
		    "/adm/logout".equals(request.getServletPath())
		    )
			return true;

		TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");

		if (loginUser == null) {
			logger.info("로그인 필요");
			response.sendRedirect(request.getContextPath() + "/adm/loginForm");
			return false; 
		} 
		
		//현재 메뉴정보 받아오기
		TB_SYSMNUXM inSysMenu = new TB_SYSMNUXM();

		String strServletPath = request.getServletPath();

		//logger.info("getServletPath>1>" + strServletPath);
		
		// 상세페이지 메뉴아이디 조회를 위해     -      /adm/supplierMgr/edit/C00014     ->      /adm/supplierMgr 
		String[] arrPath = strServletPath.split("/");
		if(arrPath.length > 3){
			strServletPath = "/" + arrPath[1] + "/" + arrPath[2];
			
			if(arrPath[2].equals("boardMgr")){
				strServletPath = strServletPath + "/" + arrPath[3];
				if(arrPath.length >= 5 && arrPath[3].equals("type04")){
					strServletPath = strServletPath + "/" + arrPath[4];
				}
			}
			if(arrPath[2].equals("productMgr")) {
				strServletPath = strServletPath + "/" + arrPath[3];
				if(arrPath.length >= 5 && arrPath[3].equals("type04")){
					strServletPath = strServletPath + "/" + arrPath[4];
				}
			}
			if(arrPath[2].equals("jundanMgr")) {
				strServletPath = strServletPath + "/" + arrPath[3];
				if(arrPath.length >= 5 && arrPath[3].equals("type04")){
					strServletPath = strServletPath + "/" + arrPath[4];
				}
			}
			
		}
		
		
		inSysMenu.setSERVLETPATH(strServletPath);
		//inSysMenu.setSERVLETPATH("/mgr/memMenMngList.do");
		inSysMenu.setMEMB_ID(loginUser.getMEMB_ID());
		TB_SYSMNUXM menuInfo = (TB_SYSMNUXM)commonService.selectNowMenu(inSysMenu);

		List<TB_SYSMNUXM> menuList = commonService.selectUserMenuList(inSysMenu);
		
		request.setAttribute("MENU_INFO", menuInfo);
		request.setAttribute("MENU_LIST", menuList);
		
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


