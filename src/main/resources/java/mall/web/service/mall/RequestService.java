package mall.web.service.mall;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mall.web.domain.TB_BKINFOXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.XTB_ODDLAIXM;
import mall.web.domain.XTB_ODINFOXD;
import mall.web.domain.XTB_ODINFOXM;
import mall.web.mapper.mall.RequestMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service.mall
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 주문 내역
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-27 (오후 2:08:37)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("requestService")
public class RequestService implements DefaultService{	
	
	@Resource(name="requestMapper")
	RequestMapper requestMapper;

	@Override
	public int getObjectCount(Object obj) throws Exception {
		return requestMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return requestMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return requestMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return requestMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return requestMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return requestMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return requestMapper.delete(obj);
	}
	
	@Transactional
	public int insertOrderObject(XTB_ODINFOXM obj, XTB_ODINFOXD obj2, XTB_ODDLAIXM obj3) throws Exception {
		
		requestMapper.odInfoXmInsert(obj);
		
		obj2.setORDER_NUM(obj.getORDER_NUM());
		
		String[] pdCode = obj2.getPD_CODES();
		String[] pdName = obj2.getPD_NAMES();
		String[] pdPrice = obj2.getPD_PRICES();
		String[] pddcGubn = obj2.getPDDC_GUBNS();
		String[] pddcVal = obj2.getPDDC_VALS();
		String[] orderQty = obj2.getORDER_QTYS();
		String[] orderAmt = obj2.getORDER_AMTS();
		String[] selectDlvyRownum = obj2.getSELECT_DLVY_ROWNUMS();
		
		for(int i=0; i<pdCode.length; i++){
		
			XTB_ODINFOXD tb_odinfoxd = new XTB_ODINFOXD();
			
			tb_odinfoxd = obj2;
			
			tb_odinfoxd.setPD_CODE(pdCode[i]);
			tb_odinfoxd.setPD_NAME(pdName[i]);
			tb_odinfoxd.setPD_PRICE(pdPrice[i]);
			tb_odinfoxd.setPDDC_GUBN(pddcGubn[i]);
			tb_odinfoxd.setPDDC_VAL(pddcVal[i]);
			tb_odinfoxd.setORDER_QTY(orderQty[i]);
			tb_odinfoxd.setORDER_AMT(orderAmt[i]);
			tb_odinfoxd.setDLVY_ROWNUM(selectDlvyRownum[i]);

			requestMapper.odInfoXdInsert(tb_odinfoxd);
		
		}

		obj3.setORDER_NUM(obj.getORDER_NUM());
		
		//String[] extraAddr = obj3.getEXTRA_ADDRS();
		
		if(obj3.getDLVY_ROWNUMS() != null){
			
			String[] dlvyRownum = obj3.getDLVY_ROWNUMS();
			String[] dlvyName = obj3.getDLVY_NAMES();
			String[] staffName = obj3.getSTAFF_NAMES();
			String[] staffCpon = obj3.getSTAFF_CPONS();
			String[] postNum = obj3.getPOST_NUMS();
			String[] bascAddr = obj3.getBASC_ADDRS();
			String[] dtlAddr = obj3.getDTL_ADDRS();
			
			for(int i=0; i<dlvyRownum.length; i++){
			
				XTB_ODDLAIXM xtb_oddlaixm = new XTB_ODDLAIXM();
				
				xtb_oddlaixm = obj3;
				
				xtb_oddlaixm.setDLVY_ROWNUM(dlvyRownum[i]);
				xtb_oddlaixm.setDLVY_NAME(dlvyName[i]);
				xtb_oddlaixm.setSTAFF_NAME(staffName[i]);
				xtb_oddlaixm.setSTAFF_CPON(staffCpon[i]);
				xtb_oddlaixm.setPOST_NUM(postNum[i]);
				xtb_oddlaixm.setBASC_ADDR(bascAddr[i]);
				xtb_oddlaixm.setDTL_ADDR(dtlAddr[i]);
				//xtb_oddlaixm.setEXTRA_ADDR(extraAddr[i]);
				xtb_oddlaixm.setDLVY_MSG("");
	
				requestMapper.odDlaxiXmInsert(xtb_oddlaixm);
			
			}
		}
		return 0;
	}

	@Transactional
	public int updateOrderObject(XTB_ODINFOXM obj, XTB_ODINFOXD obj2, XTB_ODDLAIXM obj3) throws Exception {
		
		requestMapper.odInfoXmUpdate(obj);
		
		obj2.setORDER_NUM(obj.getORDER_NUM());
		
		String[] pdCode = obj2.getPD_CODES();
		String[] pdName = obj2.getPD_NAMES();
		String[] pdPrice = obj2.getPD_PRICES();
		String[] pddcGubn = obj2.getPDDC_GUBNS();
		String[] pddcVal = obj2.getPDDC_VALS();
		String[] orderQty = obj2.getORDER_QTYS();
		String[] orderAmt = obj2.getORDER_AMTS();
		String[] selectDlvyRownum = obj2.getSELECT_DLVY_ROWNUMS();
		
		//삭제 후
		requestMapper.odInfoXdDelete(obj2);
		
		for(int i=0; i<pdCode.length; i++){
		
			XTB_ODINFOXD tb_odinfoxd = new XTB_ODINFOXD();
			
			tb_odinfoxd = obj2;
			
			tb_odinfoxd.setPD_CODE(pdCode[i]);
			tb_odinfoxd.setPD_NAME(pdName[i]);
			tb_odinfoxd.setPD_PRICE(pdPrice[i]);
			tb_odinfoxd.setPDDC_GUBN(pddcGubn[i]);
			tb_odinfoxd.setPDDC_VAL(pddcVal[i]);
			tb_odinfoxd.setORDER_QTY(orderQty[i]);
			tb_odinfoxd.setORDER_AMT(orderAmt[i]);
			tb_odinfoxd.setDLVY_ROWNUM(selectDlvyRownum[i]);

			requestMapper.odInfoXdInsert(tb_odinfoxd);
		
		}

		obj3.setORDER_NUM(obj.getORDER_NUM());

		if(obj3.getDLVY_ROWNUMS() != null){
			String[] dlvyRownum = obj3.getDLVY_ROWNUMS();
			String[] dlvyName = obj3.getDLVY_NAMES();
			String[] staffName = obj3.getSTAFF_NAMES();
			String[] staffCpon = obj3.getSTAFF_CPONS();
			String[] postNum = obj3.getPOST_NUMS();
			String[] bascAddr = obj3.getBASC_ADDRS();
			String[] dtlAddr = obj3.getDTL_ADDRS();
			//String[] extraAddr = obj3.getEXTRA_ADDRS();
	
			//삭제 후
			requestMapper.odDlaxiXmDelete(obj3);
			
			for(int i=0; i<dlvyRownum.length; i++){
			
				XTB_ODDLAIXM xtb_oddlaixm = new XTB_ODDLAIXM();
				
				xtb_oddlaixm = obj3;
				
				xtb_oddlaixm.setDLVY_ROWNUM(dlvyRownum[i]);
				xtb_oddlaixm.setDLVY_NAME(dlvyName[i]);
				xtb_oddlaixm.setSTAFF_NAME(staffName[i]);
				xtb_oddlaixm.setSTAFF_CPON(staffCpon[i]);
				xtb_oddlaixm.setPOST_NUM(postNum[i]);
				xtb_oddlaixm.setBASC_ADDR(bascAddr[i]);
				xtb_oddlaixm.setDTL_ADDR(dtlAddr[i]);
				//xtb_oddlaixm.setEXTRA_ADDR(extraAddr[i]);
				xtb_oddlaixm.setDLVY_MSG("");
	
				requestMapper.odDlaxiXmInsert(xtb_oddlaixm);
			
			}
		}
		
		return 0;
	}
	
	public List<?> getNewObjectList(List list) throws Exception {
		return requestMapper.newList(list);
	}
	
	public List<?> getBuyObjectList(Object obj) throws Exception {
		return requestMapper.buyList(obj);
	}
	
	//주문정보 마스터 정보 - 상세화면
	public Object getMasterInfo(Object obj) throws Exception {
		return requestMapper.getMasterInfo(obj);
	}
	
	//주문정보 상세 - 상세화면  
	public List<?> getDetailsList(Object obj) throws Exception {
		return requestMapper.getDetailsList(obj);
	}
	
	//배송지 정보 - 상세화면
	public List<?> getDeliveryInfo(Object obj) throws Exception {
		return requestMapper.getDeliveryInfo(obj);
	}
	
	public int conditionUpdate(Object obj) throws Exception {
		return requestMapper.conditionUpdate(obj);
	}
}
