package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.mapper.admin.SupplierMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 기업정보관리 Service
 * @Company	: YT Corp.
 * @Author	: Seok-min Jeon (smjeon@youngthink.co.kr)
 * @Date	: 2016-07-12 (오후 11:07:25)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("supplierMgrService")
public class SupplierMgrService implements DefaultService {

	@Resource(name="supplierMgrMapper")
	SupplierMgrMapper supplierMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return supplierMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return supplierMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return supplierMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return supplierMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return supplierMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return supplierMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return supplierMgrMapper.delete(obj);
	}

	public int updateObject2(Object obj) throws Exception {
		return supplierMgrMapper.update2(obj);
	}
	
	public int listUpdate(Object obj) throws Exception{
		return supplierMgrMapper.listUpdate(obj);
	}

	public int comBunbChk(Object obj) throws Exception {
		return supplierMgrMapper.comBunbChk(obj);
	}
	
	public int emailObject(Object obj) throws Exception {
		return supplierMgrMapper.email(obj);
	}
}
