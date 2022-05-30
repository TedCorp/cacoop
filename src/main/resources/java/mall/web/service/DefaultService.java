package mall.web.service;

import java.util.List;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 기본 Service Interface
 * @Company	: YT Corp.
 * @Author	: Byeong-gwon Gang (multiple@nate.com)
 * @Date	: 2016-07-07 (오후 11:07:44)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
public interface DefaultService {
	public int getObjectCount(Object obj) throws Exception;
	public List<?> getObjectList(Object obj) throws Exception;
	public List<?> getPaginatedObjectList(Object obj) throws Exception;
	public Object getObject(Object obj) throws Exception;
	public int insertObject(Object obj) throws Exception;
	public int updateObject(Object obj) throws Exception;
	public int deleteObject(Object obj) throws Exception;
}

