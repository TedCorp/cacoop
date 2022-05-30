package mall.web.service.common;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_COMCODXD;
import mall.web.domain.TB_OPTCODXD;
import mall.web.domain.TB_SYSMNUXM;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 공통기능 Service Interface
 * @Company	: YT Corp.
 * @Author	: Byeong-gwon Gang (multiple@nate.com)
 * @Date	: 2016-07-07 (오후 11:07:44)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
public interface CommonService {
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.service.CommonService.java
	 * @Method	: selectComCodList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 공통코드 조회
	 * @Company	: YT Corp.
	 * @Author	: Byeong-gwon Gang (multiple@nate.com)
	 * @Date	: 2016-07-07 (오후 11:07:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param comCod
	 * @return List<TB_COMCODXD>
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	public List<TB_COMCODXD> selectComCodList(TB_COMCODXD comCod) throws Exception;

	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.service.common.CommonService.java
	 * @Method	: selectComCodList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 공통코드 코드명 조회
	 * @Company	: YT Corp.
	 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
	 * @Date	: 2016-07-18 (오후 8:44:56)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param comCod
	 * @return
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	public TB_COMCODXD selectComCodName(TB_COMCODXD comCod) throws Exception;
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.service.CommonService.java
	 * @Method	: selectNowMenu
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 현재 접속 메뉴 조회
	 * @Company	: YT Corp.
	 * @Author	: Byeong-gwon Gang (multiple@nate.com)
	 * @Date	: 2016-07-07 (오후 11:07:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param comCod
	 * @return TB_SYSMNUXM
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	public TB_SYSMNUXM selectNowMenu(TB_SYSMNUXM sysMenu) throws Exception;
	
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.service.CommonService.java
	 * @Method	: selectUserMenuList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 사용자 메뉴 조회
	 * @Company	: YT Corp.
	 * @Author	: Byeong-gwon Gang (multiple@nate.com)
	 * @Date	: 2016-07-07 (오후 11:07:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param comCod
	 * @return List<TB_SYSMNUXM>
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	public List<TB_SYSMNUXM> selectUserMenuList(TB_SYSMNUXM sysMenu) throws Exception;
	public Object authGroupCheck(Object obj) throws Exception;
	

	public String saveFile(TB_COATFLXD inObj, HttpServletRequest request, MultipartHttpServletRequest multipartRequest, String objName, String filePath, Boolean bOriginalFilename) throws Exception;	
	
	public List<?> selectFileList(Object inObj) throws Exception;	
	public Object selectFile(Object inObj) throws Exception;	
	
	public int deleteFile(Object obj) throws Exception;	
	
	
	public List<TB_OPTCODXD> selectOptCodList(TB_OPTCODXD optCod) throws Exception;
	
	// 기본시간
	public Map<String, String> betweenDate(String datepickerStr, String datepickerEnd, int day) throws Exception;
}
