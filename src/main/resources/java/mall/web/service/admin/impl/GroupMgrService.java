package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.mapper.admin.GroupMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service.admin.impl
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 그룹관리
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-20 (오후 8:32:30)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("groupMgrService")
public class GroupMgrService implements DefaultService{	
	
	@Resource(name="groupMgrMapper")
	GroupMgrMapper groupMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return groupMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return groupMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return groupMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return groupMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return groupMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return groupMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return groupMgrMapper.delete(obj);
	}
	
	public int getCodeSameCnt(Object obj) throws Exception {
		return groupMgrMapper.codeSameCnt(obj);
	}
}
