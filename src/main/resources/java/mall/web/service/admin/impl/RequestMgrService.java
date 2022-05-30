package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.domain.XTB_ODDLAIXM;
import mall.web.domain.XTB_ODINFOXM;
import mall.web.mapper.admin.RequestMgrMapper;
import mall.web.service.DefaultService;


/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 주문내역 Service
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-13 (오후 03:49:40)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("requestMgrService")
public class RequestMgrService implements DefaultService {

	@Resource(name="requestMgrMapper")
	RequestMgrMapper requestMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return requestMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return requestMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return requestMgrMapper.paginatedList(obj);
	}	
	
	@Override
	public Object getObject(Object obj) throws Exception {
		return requestMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return requestMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return requestMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return requestMgrMapper.delete(obj);
	}
	
	//주문정보 마스터 정보 - 상세화면
	public Object getMasterInfo(XTB_ODINFOXM tb_odinfoxm) throws Exception {
		return requestMgrMapper.getMasterInfo(tb_odinfoxm);
	}
	
	//주문정보 상세 - 상세화면  
	public List<?> getDetailsList(XTB_ODINFOXM tb_odinfoxm) throws Exception {
		return requestMgrMapper.getDetailsList(tb_odinfoxm);
	}
	
	//배송지 정보 - 상세화면
	public List<?> getDeliveryInfo(XTB_ODINFOXM tb_odinfoxm) throws Exception {
		return requestMgrMapper.getDeliveryInfo(tb_odinfoxm);
	}
	
	/*//주문상태 및 결제 정보 수정
	public void getDetailsUpdate(Object obj) throws Exception {
		requestMgrMapper.getDetailsUpdate(obj);
	}*/
	public void getDetailsUpdate(XTB_ODINFOXM tb_odinfoxm, XTB_ODDLAIXM tb_oddlaixm) throws Exception {
		//주문상태 및 결제 정보 수정
		requestMgrMapper.getDetailsUpdate(tb_odinfoxm);
		//배송정보 수정
		//requestMgrMapper.getDeliveryUpdate(tb_oddlaixm);
	}
	
	public List<?> getExcelList(Object obj) throws Exception {
		return requestMgrMapper.excelList(obj);
	}

}