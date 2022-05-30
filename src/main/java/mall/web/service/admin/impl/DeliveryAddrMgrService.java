package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.domain.TB_DELIVERY_ADDR;
import mall.web.mapper.admin.DeliveryAddrMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 주소상제정보 DTO
 * @Company	: TED
 * @Author	: jangBora
 * @Date	: 2022-01-04
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("deliveryAddrMgrService")
public class DeliveryAddrMgrService implements DefaultService{

	@Resource(name="deliveryAddrMgrMapper")
	DeliveryAddrMgrMapper deliveryAddrMgrMapper;

	@Override
	public int getObjectCount(Object obj) throws Exception {
		return deliveryAddrMgrMapper.count(obj);
	}

	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return deliveryAddrMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return deliveryAddrMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return deliveryAddrMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return deliveryAddrMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return deliveryAddrMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return deliveryAddrMgrMapper.delete(obj);
	}
	
	//배송지종류 갯수 
	public int addrCount() throws Exception {
		return deliveryAddrMgrMapper.addrCount();
	}
	
	
	
	//사용여부 카운트(삭제시필요)
	public int useCount(Object obj)throws Exception {
		return deliveryAddrMgrMapper.useCount(obj);
	}
	

}
