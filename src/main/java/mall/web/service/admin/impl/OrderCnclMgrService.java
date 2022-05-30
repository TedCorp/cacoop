package mall.web.service.admin.impl;

import java.util.List;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXM;
import mall.web.mapper.admin.OrderCnclMgrMapper;
import mall.web.service.DefaultService;


/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 취소내역(접수) Service
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-16 (오전 11:41:40)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("orderCnclMgrService")
public class OrderCnclMgrService implements DefaultService {

	@Resource(name="orderCnclMgrMapper")
	OrderCnclMgrMapper orderCnclMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return orderCnclMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return orderCnclMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return orderCnclMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return orderCnclMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return orderCnclMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return orderCnclMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return orderCnclMgrMapper.delete(obj);
	}
	
	//일괄 주문 상태 변경
	public void updateStateObject(TB_ODINFOXM tb_odinfoxm) throws Exception {
		StringTokenizer stok = new StringTokenizer(tb_odinfoxm.getCNCL_CON_ORDER_NUM(),"$");
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			TB_ODINFOXM obj = new TB_ODINFOXM();
			obj.setORDER_NUM(str);
			obj.setCNCL_CON(tb_odinfoxm.getCNCL_CON_STATE());
			obj.setMODP_ID(tb_odinfoxm.getMODP_ID());
			orderCnclMgrMapper.updateState(obj);
		}
	}
	
	//주문정보 마스터 정보 - 상세화면
	public Object getMasterInfo(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderCnclMgrMapper.getMasterInfo(tb_odinfoxm);
	}
	
	//주문정보 상세 - 상세화면  
	public List<?> getDetailsList(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderCnclMgrMapper.getDetailsList(tb_odinfoxm);
	}
	
	//배송지 정보 - 상세화면
	public Object getDeliveryInfo(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderCnclMgrMapper.getDeliveryInfo(tb_odinfoxm);
	}
	
	/*//주문상태 및 결제 정보 수정
	public void getDetailsUpdate(Object obj) throws Exception {
		orderCnclMgrMapper.getDetailsUpdate(obj);
	}*/
	public void getDetailsUpdate(TB_ODINFOXM tb_odinfoxm, TB_ODDLAIXM tb_oddlaixm) throws Exception {
		//주문상태 및 결제 정보 수정
		orderCnclMgrMapper.getDetailsUpdate(tb_odinfoxm);
		//배송정보 수정
		orderCnclMgrMapper.getDeliveryUpdate(tb_oddlaixm);
	}
	
	/*//배송정보 수정
	public void getDeliveryUpdate(Object obj) throws Exception {
		orderCnclMgrMapper.getDeliveryUpdate(obj);
	}*/

}