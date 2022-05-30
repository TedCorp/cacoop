package mall.web.service.admin.impl;

import java.util.List;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXM;
import mall.web.mapper.admin.OrderRfndMgrMapper;
import mall.web.service.DefaultService;


/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 환불접수 Service
 * @Company	: YT Corp.
 * @Author	: chjw
 * @Date	: 2021-01-05 (오후 11:41:40)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("orderRfndMgrService")
public class OrderRfndMgrService implements DefaultService {

	@Resource(name="orderRfndMgrMapper")
	OrderRfndMgrMapper orderRfndMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return orderRfndMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return orderRfndMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return orderRfndMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return orderRfndMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return orderRfndMgrMapper.insert(obj);
	}

	@Override
	@Transactional
	public int updateObject(Object obj) throws Exception {
		TB_ODINFOXM inObj = (TB_ODINFOXM)obj;
		int result = orderRfndMgrMapper.updateMaster(inObj);
		result = orderRfndMgrMapper.updateDetail(inObj);
		return result;
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return orderRfndMgrMapper.delete(obj);
	}
}