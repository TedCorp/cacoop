package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.mapper.admin.TermMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 약관관리 Service
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-12 (오후 11:07:25)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("termMgrService")
public class TermMgrService implements DefaultService {

	@Resource(name="termMgrMapper")
	TermMgrMapper termMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return termMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return termMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return termMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return termMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return termMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return termMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return termMgrMapper.delete(obj);
	}

}
