package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.mapper.admin.BoardMgrMapper;
import mall.web.mapper.admin.CalendarMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service.admin.impl
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 게시판 관리
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-18 (오전 10:57:12)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("calendarMgrService")
public class CalendarMgrService implements DefaultService {
	
	@Resource(name="calendarMgrMapper")
	CalendarMgrMapper calendarMgrMapper;

	@Override
	public int getObjectCount(Object obj) throws Exception {
		return 0;
	}

	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		
		return calendarMgrMapper.schedulTotList(obj);
	}
	
	public List<?> getSchedulList(Object obj) throws Exception {
		
		return calendarMgrMapper.schedulList(obj);
	}
	
	@Override
	public int insertObject(Object obj) throws Exception {
		
		return calendarMgrMapper.insertSchdul(obj);
	}
	
	@Override
	public int updateObject(Object obj) throws Exception {

		return calendarMgrMapper.updateSchdul(obj);
	}
	
	@Override
	public int deleteObject(Object obj) throws Exception {

		return calendarMgrMapper.deleteSchdul(obj);
	}
	
	
	
	

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return null;
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return null;
	}

}
