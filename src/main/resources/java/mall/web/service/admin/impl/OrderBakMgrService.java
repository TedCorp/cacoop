package mall.web.service.admin.impl;

import java.util.List;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXM;
import mall.web.mapper.admin.OrderBakMgrMapper;
import mall.web.service.DefaultService;


/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 주문삭제내역 Service
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-16 (오전 11:41:40)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("orderBakMgrService")
public class OrderBakMgrService implements DefaultService {

	@Resource(name="orderBakMgrMapper")
	OrderBakMgrMapper orderBakMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return orderBakMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return orderBakMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return orderBakMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return orderBakMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return orderBakMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return orderBakMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return orderBakMgrMapper.delete(obj);
	}

	//주문정보 마스터 정보 - 상세화면
	public Object getMasterInfo(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderBakMgrMapper.getMasterInfo(tb_odinfoxm);
	}
	
	//주문정보 상세 - 상세화면  
	public List<?> getDetailsList(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderBakMgrMapper.getDetailsList(tb_odinfoxm);
	}
	
	//배송지 정보 - 상세화면
	public Object getDeliveryInfo(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderBakMgrMapper.getDeliveryInfo(tb_odinfoxm);
	}

	//주문내역삭제복원
	public void getDeleteReturnOrdList(String num) throws Exception{
		orderBakMgrMapper.deleteReturnOrdList(num);
	}
	public void getDeleteReturnOrdDtlList(String num) throws Exception{
		orderBakMgrMapper.deleteReturnOrdDtlList(num);
	}

	// 엑셀
	public List<?> getExcelAllList(Object obj) throws Exception {
		return orderBakMgrMapper.excelAllList(obj);
	}	
	public List<?> getExcelList(Object obj) throws Exception {
		return orderBakMgrMapper.excelList(obj);
	}	
	public List<?> getDetailExcelList(Object obj) throws Exception {
		return orderBakMgrMapper.detailExcelList(obj);
	}

	// 배송전표
	public List<?> getDeliverList(Object obj) throws Exception {
		return orderBakMgrMapper.delivery(obj);
	}
	
	public Object getSupplierObject(Object obj) throws Exception {
		return orderBakMgrMapper.supplierInfo(obj);
	}
	
	public List<?> getMonitorExcelList(Object obj) throws Exception {
		return orderBakMgrMapper.getMonitorExcelList(obj);
	}
	
}