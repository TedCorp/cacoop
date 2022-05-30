package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_RTODINFOXD;
import mall.web.domain.TB_RTODINFOXM;
import mall.web.mapper.admin.OrderMgrMapper;
import mall.web.mapper.admin.ReturnOrderMgrMapper;
import mall.web.service.DefaultService;
import mall.web.service.mall.OrderService;


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
@Service("returnOrderMgrService")
public class ReturnOrderMgrService implements DefaultService {

	@Resource(name="returnOrderMgrMapper")
	ReturnOrderMgrMapper returnOrderMgrMapper;

	@Resource(name="orderMgrMapper")
	OrderMgrMapper orderMgrMapper;

	@Resource(name="orderService")
	OrderService orderService;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return returnOrderMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return returnOrderMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return returnOrderMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return returnOrderMgrMapper.find(obj);
	}
	@Override
	public int insertObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return returnOrderMgrMapper.insert(obj);
	}

	@Transactional
	public int insertRtOrdObject(TB_RTODINFOXM master, TB_RTODINFOXD detail) throws Exception {
		int updateCnt = 0; 
		returnOrderMgrMapper.rtOdInfoXmInsert(master);	
		
		for(int i=0; i<detail.getPD_CODES().length; i++){
			
			TB_RTODINFOXD tb_rtodinfoxd = new TB_RTODINFOXD();
			
			tb_rtodinfoxd.setRETURN_NUM(master.getRETURN_NUM());
			tb_rtodinfoxd.setPD_CODE(detail.getPD_CODES()[i]);
			tb_rtodinfoxd.setPD_NAME(detail.getPD_NAMES()[i]);
			tb_rtodinfoxd.setPD_PRICE(detail.getPD_PRICES()[i]);
			tb_rtodinfoxd.setPDDC_GUBN(detail.getPDDC_GUBNS()[i]);
			tb_rtodinfoxd.setPDDC_VAL(detail.getPDDC_VALS()[i]);
			tb_rtodinfoxd.setRETURN_QTY(detail.getRETURN_QTYS()[i]);
			if(tb_rtodinfoxd.getPDDC_GUBN().equals("PDDC_GUBN_02")){
				int price = Integer.parseInt(tb_rtodinfoxd.getPD_PRICE());
				int pddcval = Integer.parseInt(tb_rtodinfoxd.getPDDC_VAL());
				int qty = Integer.parseInt(tb_rtodinfoxd.getRETURN_QTY());
				tb_rtodinfoxd.setRETURN_AMT(Integer.toString((price-pddcval)*qty));
			}else if(tb_rtodinfoxd.getPDDC_GUBN().equals("PDDC_GUBN_03")){
				int price = Integer.parseInt(tb_rtodinfoxd.getPD_PRICE());
				int pddcval = Integer.parseInt(tb_rtodinfoxd.getPDDC_VAL());
				int qty = Integer.parseInt(tb_rtodinfoxd.getRETURN_QTY());
				tb_rtodinfoxd.setRETURN_AMT(Integer.toString((price - (price*pddcval/100))*qty));
			}else{
				int price = Integer.parseInt(tb_rtodinfoxd.getPD_PRICE());
				int qty = Integer.parseInt(tb_rtodinfoxd.getRETURN_QTY());
				tb_rtodinfoxd.setRETURN_AMT(Integer.toString(price*qty));
			}
			//tb_rtodinfoxd.setRETURN_AMT(detail.getRETURN_AMTS()[i]);
			tb_rtodinfoxd.setRETURN_GBN(detail.getRETURN_GBNS()[i]);
			tb_rtodinfoxd.setREGP_ID(detail.getREGP_ID());
			tb_rtodinfoxd.setMODP_ID(detail.getMODP_ID());
			tb_rtodinfoxd.setORDER_DTNUM(detail.getORDER_DTNUMS()[i]);
			//세절방식 잠시 보류....ㅠ.ㅠ..
			/*if(obj2.getPD_CUT_SEQS().length>0){
				tb_odinfoxd.setPD_CUT_SEQ(obj2.getPD_CUT_SEQS()[i]);
			}else{
				tb_odinfoxd.setPD_CUT_SEQ("");
			}*/
	
			updateCnt += returnOrderMgrMapper.rtOdInfoXdInsert(tb_rtodinfoxd);
		}
		
		
		return updateCnt;
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return returnOrderMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return returnOrderMgrMapper.delete(obj);
	}
	
	//주문정보 마스터 정보 - 상세화면
	public Object getMasterInfo(TB_RTODINFOXM tb_odinfoxm) throws Exception {
		return returnOrderMgrMapper.getMasterInfo(tb_odinfoxm);
	}
	
	//주문정보 상세 - 상세화면  
	public List<?> getDetailsList(Object obj) throws Exception {
		return returnOrderMgrMapper.getDetailsList(obj);
	}
	
	public int updateMasterObject(Object obj) throws Exception {
		return returnOrderMgrMapper.updateMaster(obj);
	}
	
	// 주문번호에 해당하는 반품내역 Count
	public int getOrdCount(Object obj) throws Exception {
		return returnOrderMgrMapper.ordCheck(obj);
	}
	public int getRtnCount(Object obj) throws Exception {
		return returnOrderMgrMapper.rtnCheck(obj);
	}
	public List<?> rtnOrderInfo(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return returnOrderMgrMapper.rtnOrderInfo(tb_odinfoxm);
	}
	public List<?> rtnDetailsList(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return returnOrderMgrMapper.rtnDetailList(tb_odinfoxm);
	}
	
	@Transactional
	public Object insertOrderObject(TB_ODINFOXM master, TB_ODINFOXD detail, String originNum) throws Exception {
		int updateCnt = 0;
		// 주문M insert
		returnOrderMgrMapper.odInfoXmInsert(master);
		
		for(int i=0; i< detail.getORDER_DTNUMS().length; i++){
			// 반품상세 
			TB_ODINFOXD tb_odinfoxd = new TB_ODINFOXD();

			// 기존주문 내역 불러오기
			tb_odinfoxd.setORDER_NUM(originNum);
			tb_odinfoxd.setORDER_DTNUM(detail.getORDER_DTNUMS()[i]);
			
			tb_odinfoxd = (TB_ODINFOXD) returnOrderMgrMapper.find(tb_odinfoxd);
			
			// 추가 반품 정보 세팅
			tb_odinfoxd.setREGP_ID(master.getREGP_ID());
			tb_odinfoxd.setORDER_NUM(master.getORDER_NUM());
			
			int qty = Integer.parseInt(detail.getORDER_QTYS()[i]);
			int real = Integer.parseInt(tb_odinfoxd.getREAL_PRICE());
			int amt = qty * real;
			
			tb_odinfoxd.setORDER_QTY(Integer.toString(qty));
			tb_odinfoxd.setORDER_AMT(Integer.toString(amt));
			
			tb_odinfoxd.setPAY_METD(master.getPAY_METD());
			tb_odinfoxd.setORDER_CON(master.getORDER_CON());
			tb_odinfoxd.setDLVY_CON(master.getDLVY_CON());
			tb_odinfoxd.setRFND_CON(master.getRFND_CON());
			
			tb_odinfoxd.setDLVY_COM(master.getDLVY_COM());
			if(detail.getDLVY_TDNS().length > 0) {
				tb_odinfoxd.setDLVY_TDN(detail.getDLVY_TDNS()[i]);
			}
			
			// 주문D insert
			updateCnt += returnOrderMgrMapper.odInfoXdInsert(tb_odinfoxd);
		}
		
		master.setCount(updateCnt);
		
		return master;
	}

	@Transactional
	public int updateMasterQty(Object obj) throws Exception {
		return returnOrderMgrMapper.updateMasterQty(obj);
	}
	
	// 환불완료 업체 리스트 
	public List<?> getPdSuprList(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return returnOrderMgrMapper.getPdSuprList(tb_odinfoxm);		
	}
	
	public void getDetailsUpdate(Object obj)throws Exception{
		returnOrderMgrMapper.getDetailsUpdate(obj);
	}
	
}