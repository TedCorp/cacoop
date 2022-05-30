package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.mapper.admin.MenuMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service.admin.impl
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 메뉴관리
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-20 (오후 3:05:57)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("menuMgrService")
public class MenuMgrService implements DefaultService{

	@Resource(name="menuMgrMapper")
	MenuMgrMapper menuMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return menuMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return menuMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return menuMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return menuMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return menuMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return menuMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return menuMgrMapper.delete(obj);
	}
	
	public int getCodeSameCnt(Object obj) throws Exception {
		return menuMgrMapper.codeSameCnt(obj);
	}
}
