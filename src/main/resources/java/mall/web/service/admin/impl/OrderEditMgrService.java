package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mall.web.apiLink.AtomyAzaAPI;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_RTODINFOXD;
import mall.web.domain.TB_RTODINFOXM;
import mall.web.mapper.admin.OrderEditMgrMapper;
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
@Service("orderEditMgrService")
public class OrderEditMgrService implements DefaultService {

	@Resource(name="orderEditMgrMapper")
	OrderEditMgrMapper orderEditMgrMapper;

	@Resource(name="orderService")
	OrderService orderService;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return orderEditMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return orderEditMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return orderEditMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return orderEditMgrMapper.find(obj);
	}
	
	@Override
	public int insertObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return orderEditMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return orderEditMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return orderEditMgrMapper.delete(obj);
	}
	
	// 주문정보 수정
	public void editOrderObject(TB_ODINFOXM master, TB_ODINFOXD detail) throws Exception{
		//
		String[] dtIndexSplit = detail.getORDER_DTNUM().split(",");				// 주문상세번호
		String[] orginQtySplit = detail.getORIGIN_QTY().split(",");				// 기존수량
		String[] ordQtySplit = detail.getORDER_QTY().split(",");					// 변경수량
		String[] realPriceSplit = detail.getREAL_PRICE().split(",");					// 변경수량
		String[] ordSuprSplit = detail.getSUPR_ID().split(",");						// 공급사코드
		String[] ordLoginSuprSplit = detail.getLOGIN_SUPR_ID().split(",");		// 로그인 업체코드

		// 변동 상품수량 반품테이블 저장
		//int check = getReturnCount(master);
		int update = 0;
		int check = 0;
		TB_RTODINFOXM tb_rtodinfoxm= (TB_RTODINFOXM) orderEditMgrMapper.getRtnMasterObject(master);
		
		if (tb_rtodinfoxm == null){
			// 신규반품 insert
			insertRtOrdObject(master, detail);
		} else {
			// 기존 반품상세 insert
			check = insertRtDtlObject(tb_rtodinfoxm, detail);
			// 반품 마스터 update
			if (check > 0) {
				orderEditMgrMapper.updateMaster(tb_rtodinfoxm);
			}
		}
		
		for(int i= 0; i < dtIndexSplit.length; i++){
			TB_ODINFOXD tb_odinfoxd = new TB_ODINFOXD();
			
			tb_odinfoxd.setORDER_NUM(master.getORDER_NUM());	// 주문번호
			tb_odinfoxd.setORDER_DTNUM(dtIndexSplit[i]);				// 주문 상세번호
			tb_odinfoxd.setREAL_PRICE(realPriceSplit[i]);					// 제품 판매가격
			tb_odinfoxd.setORIGIN_QTY(orginQtySplit[i]);					// 이전 주문수량
			tb_odinfoxd.setORDER_QTY(ordQtySplit[i]);					// 변경 주문수량
			tb_odinfoxd.setSUPR_ID(ordSuprSplit[i]);						// 공급사 코드
			tb_odinfoxd.setLOGIN_SUPR_ID(ordLoginSuprSplit[i]);		// 로그인 업체코드
			
			// 변경 주문수량 업데이트
			if(ordLoginSuprSplit[i].equals(ordSuprSplit[i]) || ordSuprSplit[i].equals("C00005")){	//로그인유저 공급사 + c00005 상품도 같이 관리한다
				update = updateDatailQty(tb_odinfoxd);		// 라온마켓 주문처리
			} else {
				update = updateDatailQty(tb_odinfoxd);		// 연동시, 라온마켓(iibs) 이외의 주문처리로 수정해야함
			}
			
			if(update > 0) { 
				update = updateMasterQty(master);
			}
		}
		
		// 성공시, 애터미아자 API호출 (마이너스 수량 및 금액 전송)
		if(update > 0) {
			AtomyAzaAPI azapi = new AtomyAzaAPI();
			//azapi.Return_AtomyAza(orderService, master , detail, master.getORDER_NUM());
		}
	}

	public int insertRtDtlObject(TB_RTODINFOXM tb_rtodinfoxm, TB_ODINFOXD detail) throws Exception {
		// 마스터 정보 가져오기
		int updateCnt = 0;
		
		if (tb_rtodinfoxm != null) {
			// 디테일 정보 세팅
			String[] dtIndexSplit = detail.getORDER_DTNUM().split(",");				// 주문상세번호
			String[] orginQtySplit = detail.getORIGIN_QTY().split(",");				// 기존수량
			String[] ordQtySplit = detail.getORDER_QTY().split(",");					// 변경수량
			String[] pdCodeSplit = detail.getPD_CODE().split(",");						// 제품코드
			String[] pdNameSplit = detail.getPD_NAME().split(",");						// 제품명
			String[] realPriceSplit = detail.getREAL_PRICE().split(",");					// 판매가격
			String[] pdDcgbSplit = detail.getPDDC_GUBN().split(",");					// 할인구분
			String[] pdDcValSplit = detail.getPDDC_VAL().split(",");					// 할인값
			
			for(int i=0; i < pdCodeSplit.length; i++){
				// 반품 상세 정보 세팅
				TB_RTODINFOXD tb_rtodinfoxd = new TB_RTODINFOXD();
				
				int originQty = Integer.parseInt(orginQtySplit[i]);
				int editQty = Integer.parseInt(ordQtySplit[i]);
				int realPrice = Integer.parseInt(realPriceSplit[i]);
				int rtnQty = originQty - editQty;
				
				tb_rtodinfoxd.setRETURN_NUM(tb_rtodinfoxm.getRETURN_NUM());
				tb_rtodinfoxd.setPD_CODE(pdCodeSplit[i]);
				tb_rtodinfoxd.setPD_NAME(pdNameSplit[i]);
				tb_rtodinfoxd.setPD_PRICE(realPriceSplit[i]);
				tb_rtodinfoxd.setPDDC_GUBN(pdDcgbSplit[i]);
				tb_rtodinfoxd.setPDDC_VAL(pdDcValSplit[i]);				
				tb_rtodinfoxd.setRETURN_QTY(Integer.toString(rtnQty));
				tb_rtodinfoxd.setRETURN_AMT(Integer.toString(realPrice * rtnQty));
				tb_rtodinfoxd.setRETURN_GBN(" ");
				tb_rtodinfoxd.setREGP_ID(tb_rtodinfoxm.getREGP_ID());
				tb_rtodinfoxd.setMODP_ID(tb_rtodinfoxm.getMODP_ID());
				tb_rtodinfoxd.setORDER_DTNUM(dtIndexSplit[i]);
		
				if (rtnQty != 0) {
					updateCnt += orderEditMgrMapper.rtOdInfoXdInsert(tb_rtodinfoxd);
				}
			}
		}

		return updateCnt;
	}
	
	public int insertRtOrdObject(TB_ODINFOXM master, TB_ODINFOXD detail) throws Exception {		
		// 마스터정보 세팅
		int updateCnt = 0;
		
		String[] dtIndexSplit = detail.getORDER_DTNUM().split(",");				// 주문상세번호
		String[] orginQtySplit = detail.getORIGIN_QTY().split(",");				// 기존수량
		String[] ordQtySplit = detail.getORDER_QTY().split(",");					// 변경수량
		String[] realPriceSplit = detail.getREAL_PRICE().split(",");					// 변경수량

		TB_RTODINFOXM tb_rtodinfoxm = new TB_RTODINFOXM();
		tb_rtodinfoxm.setORDER_CON(master.getORDER_CON());
		tb_rtodinfoxm.setMEMB_ID(master.getMEMB_ID());
		tb_rtodinfoxm.setORDER_NUM(master.getORDER_NUM());
		tb_rtodinfoxm.setREGP_ID("admin");
		tb_rtodinfoxm.setMODP_ID("admin");
		
		int total = 0;
		for(int i=0; i < dtIndexSplit.length; i++){			
			int originQty = Integer.parseInt(orginQtySplit[i]);
			int editQty = Integer.parseInt(ordQtySplit[i]);
			int realPrice = Integer.parseInt(realPriceSplit[i]);
			
			total += realPrice * (originQty - editQty);
			//System.out.println("subtot ::: "+total);
		}
		
		//System.out.println("total ::: "+total);
		tb_rtodinfoxm.setRETURN_AMT(Integer.toString(total));
		tb_rtodinfoxm.setDLVY_AMT("0");	//master.getDLVY_AMT()
		
		updateCnt = orderEditMgrMapper.rtOdInfoXmInsert(tb_rtodinfoxm);
		
		
		// 반품 마스터 등록
		if ( updateCnt > 0) {
			updateCnt = insertRtDtlObject(tb_rtodinfoxm, detail);
		}
		
		return updateCnt;
	}

	// 반품마스터 테이블 체크
	public int getReturnCount(Object obj) throws Exception {
		return orderEditMgrMapper.getReturnInfo(obj);
	}
	
	// 반품마스터 정보
	public Object getRtnMasterObject(Object obj) throws Exception {
		return orderEditMgrMapper.getRtnMasterObject(obj);
	}
	
	// 주문상세 수량변경
	public int updateDatailQty(Object obj) throws Exception{
		return orderEditMgrMapper.updateDatailQty(obj);
	}
	
	// 주문마스터 수량변경
	public int updateMasterQty(Object obj) throws Exception{
		return orderEditMgrMapper.updateMasterQty(obj);
	}
	
	/*public int updateDatailQtyLink(Object obj) throws Exception{
		return orderEditMgrMapper.updateDatailQtyLink(obj);
	}*/
	
	//주문정보 마스터 정보 - 상세화면
	public Object getMasterInfo(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderEditMgrMapper.getMasterInfo(tb_odinfoxm);
	}
	
	//주문정보 상세 - 상세화면  
	public List<?> getDetailsList(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderEditMgrMapper.getDetailsList(tb_odinfoxm);
	}
	
	public int updateMasterObject(Object obj) throws Exception {
		return orderEditMgrMapper.updateMaster(obj);
	}
	
	@Transactional
	public int updateTrackNum(TB_ODINFOXD detail) throws Exception {
		int updateCnt = 0;

		String[] ordsplit = detail.getORDER_DTNUM().split(",");
		String[] ordloginsuprsplit =  detail.getLOGIN_SUPR_ID().split(",");
		String[] ordsuprsplit =  detail.getSUPR_ID().split(",");
		String[] dtldlvytdn =  detail.getDTL_DLVY_TDN().split(",");
		
		for(int i= 0; i<ordsplit.length;i++){
			detail.setORDER_DTNUM(ordsplit[i]);
			detail.setSUPR_ID(ordsuprsplit[i]);
			detail.setLOGIN_SUPR_ID(ordloginsuprsplit[i]);
			
			if(dtldlvytdn.length == 0 || dtldlvytdn.length < i+1)
				detail.setDTL_DLVY_TDN("");
			else
				detail.setDTL_DLVY_TDN(dtldlvytdn[i]);

			//배송정보 수정
			if(orderEditMgrMapper.updateTrackCon(detail) > 0){
				updateCnt += orderEditMgrMapper.updateTrackNum(detail);
			}
		}
		
		return updateCnt;
	}
}