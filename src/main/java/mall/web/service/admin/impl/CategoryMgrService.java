package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.mapper.admin.CategoryMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 카테고리관리 Service
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-12 (오후 11:07:25)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("categoryMgrService")
public class CategoryMgrService implements DefaultService {

	@Resource(name="categoryMgrMapper")
	CategoryMgrMapper categoryMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return categoryMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return categoryMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return categoryMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return categoryMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return categoryMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return categoryMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return categoryMgrMapper.delete(obj);
	}

}
