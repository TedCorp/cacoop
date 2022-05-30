package mall.web.service.mall;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import freemarker.template.utility.StringUtil;
import mall.web.domain.TB_BKINFOXM;
import mall.web.domain.TB_LGUPLUS;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.mapper.mall.OrderMapper;
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
@Service("orderService")
public class OrderService implements DefaultService{	
	
	@Resource(name="orderMapper")
	OrderMapper orderMapper;

	@Override
	public int getObjectCount(Object obj) throws Exception {
		return orderMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return orderMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return orderMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return orderMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return orderMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return orderMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return orderMapper.delete(obj);
	}
	
	@Transactional
	public int insertOrderObject(TB_ODINFOXM obj, TB_ODINFOXD obj2, TB_ODDLAIXM obj3) throws Exception {
		int updateCnt = 0; 
		orderMapper.odInfoXmInsert(obj);	//결제전
		
		for(int i=0; i<obj2.getPD_CODES().length; i++){
			TB_ODINFOXD tb_odinfoxd = new TB_ODINFOXD();
			tb_odinfoxd.setORDER_NUM(obj.getORDER_NUM());
			tb_odinfoxd.setREGP_ID(obj.getREGP_ID());
			tb_odinfoxd.setPD_CODE(obj2.getPD_CODES()[i]);
			tb_odinfoxd.setPD_NAME(obj2.getPD_NAMES()[i]);
			tb_odinfoxd.setPD_PRICE(obj2.getPD_PRICES()[i]);
			tb_odinfoxd.setPDDC_GUBN(obj2.getPDDC_GUBNS()[i]);
			tb_odinfoxd.setPDDC_VAL(obj2.getPDDC_VALS()[i]);
			tb_odinfoxd.setORDER_QTY(obj2.getORDER_QTYS()[i]);
			tb_odinfoxd.setORDER_AMT(obj2.getORDER_AMTS()[i]);

			if( ((String[])obj2.getOPTION1_NAMES()).length != 0 )
				tb_odinfoxd.setOPTION1_NAME((obj2.getOPTION1_NAMES())[i]);
			if( ((String[])obj2.getOPTION1_VALUES()).length != 0 )
				tb_odinfoxd.setOPTION1_VALUE((obj2.getOPTION1_VALUES())[i]);
			if( ((String[])obj2.getOPTION2_NAMES()).length != 0 )
				tb_odinfoxd.setOPTION2_NAME((obj2.getOPTION2_NAMES())[i]);
			if( ((String[])obj2.getOPTION2_VALUES()).length != 0 )
				tb_odinfoxd.setOPTION2_VALUE((obj2.getOPTION2_VALUES())[i]);

			if(obj2.getOPTION_CODES().length>0){
				tb_odinfoxd.setOPTION_CODE(obj2.getOPTION_CODES()[i]);
			}else{
				tb_odinfoxd.setOPTION_CODE("");
			}

			/* 세절방식 */
			if(obj2.getPD_CUT_SEQS().length>0){
				tb_odinfoxd.setPD_CUT_SEQ(obj2.getPD_CUT_SEQS()[i]);
			}else{
				tb_odinfoxd.setPD_CUT_SEQ("");
			}
			
			/* 박스할인율 */
			if(obj2.getBOX_PDDC_GUBNS().length>0){
				tb_odinfoxd.setBOX_PDDC_GUBN(obj2.getBOX_PDDC_GUBNS()[i]);
			}else{
				tb_odinfoxd.setBOX_PDDC_GUBN("");
			}
			if(obj2.getBOX_PDDC_VALS().length>0){
				tb_odinfoxd.setBOX_PDDC_VAL(obj2.getBOX_PDDC_VALS()[i]);
			}else{
				tb_odinfoxd.setBOX_PDDC_VAL("");
			}
			if(obj2.getINPUT_CNTS().length>0){
				tb_odinfoxd.setINPUT_CNT(obj2.getINPUT_CNTS()[i]);
			}else{
				tb_odinfoxd.setINPUT_CNT("");
			}
			
			updateCnt += orderMapper.odInfoXdInsert(tb_odinfoxd);
		}
		//배송지 정보 insert
		obj3.setORDER_NUM(obj.getORDER_NUM());
		orderMapper.odDlaxiXmInsert(obj3);
		
		//주문상품 장바구니 삭제
		for(int i=0; i<obj2.getPD_CODES().length; i++){
			TB_BKINFOXM tb_bkinfoxm = new TB_BKINFOXM();

			tb_bkinfoxm.setPD_CODE(obj2.getPD_CODES()[i]);
			tb_bkinfoxm.setREGP_ID(obj.getREGP_ID());
			
			orderMapper.bkInfoXmDelete(tb_bkinfoxm);
		}
		
		return updateCnt;
	}
	
	/* 단일 상품 주문 */
	public List<?> getNewObjectList(List list) throws Exception {
		return orderMapper.newList(list);
	}
	
	public List<?> getBuyObjectList(List list) throws Exception {
		return orderMapper.buyList(list);
	}
	
	public List<?> getBuyOnePd(TB_ODINFOXD tb_odinfoxm) throws Exception {
		return orderMapper.getBuyOnePd(tb_odinfoxm);
	}
	
	/* m/order/view -- 주문상세화면 */
	// 주문정보 마스터
	public Object getMasterInfo(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderMapper.getMasterInfo(tb_odinfoxm);
	}
	// 주문정보 상세
	public List<?> getDetailsList(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderMapper.getDetailsList(tb_odinfoxm);
	}
	// 배송지 정보
	public Object getDeliveryInfo(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderMapper.getDeliveryInfo(tb_odinfoxm);
	}
	// 상품별 주문량
	public int orderCnt(Object obj) throws Exception {
		return orderMapper.orderCnt(obj);
	}
	// 반품가능 상세정보
	public List<?> getRefundList(Object obj) throws Exception {
		return orderMapper.getRefundList(obj);
	}
	
	/* 배송지정보 */
	public Object getMbDlvyInfo(Object obj) throws Exception {
		return orderMapper.getMbDlvyInfo(obj);
	}
	public Object getSpDlvyInfo(Object obj) throws Exception {
		return orderMapper.getSpDlvyInfo(obj);
	}
	public Object getDlvyInfo(Object obj) throws Exception {
		return orderMapper.getDlvyInfo(obj);
	}
	public Object getSfDlvyInfo(Object obj) throws Exception {
		return orderMapper.getSfDlvyInfo(obj);
	}
	public Object getCtDlvyInfo(Object obj) throws Exception {
		return orderMapper.getCtDlvyInfo(obj);
	}
	
	/* 주문취소 팝업 -- 취소사유저장 */
	public int cancelObject(Object obj) throws Exception {
		return orderMapper.orderCancel(obj);
	}

	/* 주문상태 및 결제정보 변경 */
	// 주문상태 변경 master
	public int orderPayUpdate(Object obj) throws Exception {
		return orderMapper.orderPayUpdate(obj);
	}
	// 주문상태 변경 detail
	public int orderPayUpdateDtl(Object obj) throws Exception {
		return orderMapper.orderPayUpdateDtl(obj);
	}
	// 가상계좌할당 update
	public int cashRequest(Object obj) throws Exception {
		return orderMapper.cashRequest(obj);
	}
	
	/* 주문삭제 flag 변경*/
	public void orderUpdateDelete(Object obj) throws Exception{
		orderMapper.orderUpdateDelete(obj);
	}

	/* 엑셀 다운로드 상세주문정보 */
	public List<?> getExcelList(Object obj) throws Exception {
		return orderMapper.excelList(obj);
	}

	/* 배송조회 */
	public Map<String, String> getDlvyAddrInfo(Object obj) throws Exception{
		return orderMapper.getDlvyAddrInfo(obj);
	}
	public List<?> getDlvyPdList(Object obj) throws Exception{
		return orderMapper.getDlvyPdList(obj);
	}

	/* Xpay 결제키 확인 */
	public Object getPayMdky(Object obj) throws Exception{
		return orderMapper.getPayMdky(obj);
	}

	/* 주문정보 상세 (아자몰 전송용) */
	public List<?> getOrderInfoAza(Object obj) throws Exception{
		return orderMapper.getOrderInfoAza(obj);
	}

	/* 아자몰 API 결과로그 저장 */
	public void insertApiLog(Object obj) throws Exception{
		orderMapper.insertApiLog(obj);
	}

	/* 전체환불 여부확인 */
	public int chkAllReturn(Object obj) throws Exception{
		return orderMapper.chkAllReturn(obj);
	}

	/* Xpqy API 결과로그 저장 */
	public int lguplusLogInsert(Object obj) throws Exception{
		return orderMapper.lguplusLogInsert(obj);
	}

	/* Xpqy 가상계좌정보 */
	public Object getVirAcctInfo(Object obj) throws Exception {
		return orderMapper.getVirAcctInfo(obj);
	}

	@Transactional
	public int insertRefund(Object obj, Object obj2) throws Exception {
		int updateCnt = 0;
		TB_ODINFOXM master = (TB_ODINFOXM)obj;
		TB_ODINFOXD detail = (TB_ODINFOXD)obj2;
		
		// master insert
		orderMapper.insertRefundMaster(master);

		for(int i=0; i<detail.getPD_CODES().length; i++){
			TB_ODINFOXD tb_odinfoxd = new TB_ODINFOXD();
			tb_odinfoxd.setORDER_NUM(master.getORDER_NUM());
			tb_odinfoxd.setREGP_ID(master.getMEMB_ID());
			tb_odinfoxd.setRFND_CON(master.getRFND_CON());
			tb_odinfoxd.setORDER_CON(master.getORDER_CON());
			tb_odinfoxd.setPAY_METD(master.getPAY_METD());
			tb_odinfoxd.setDLVY_CON(master.getDLVY_CON());
			tb_odinfoxd.setPD_CODE(detail.getPD_CODES()[i]);
			tb_odinfoxd.setPD_NAME(detail.getPD_NAMES()[i].replaceAll("@!", ","));
			tb_odinfoxd.setPD_PRICE(detail.getPD_PRICES()[i]);
			tb_odinfoxd.setPDDC_GUBN(detail.getPDDC_GUBNS()[i]);
			tb_odinfoxd.setPDDC_VAL(detail.getPDDC_VALS()[i]);
			tb_odinfoxd.setORDER_QTY(detail.getORDER_QTYS()[i]);
			if(detail.getPD_CUT_SEQS().length>0){
				tb_odinfoxd.setPD_CUT_SEQ(detail.getPD_CUT_SEQS()[i]);
			}else{
				tb_odinfoxd.setPD_CUT_SEQ("");
			}
			
			// detail calculation
			int qty = Integer.parseInt(detail.getORDER_QTYS()[i]);
			int price = Integer.parseInt(detail.getREAL_PRICES()[i]);
			int total =  qty * price;
			tb_odinfoxd.setORDER_AMT(Integer.toString(total));

			// detail insert
			updateCnt += orderMapper.insertRefundDetail(tb_odinfoxd);
		}
		
		// master total price update
		updateCnt = orderMapper.updateRefundAmt(master);
		
		return updateCnt;
	}

	@Transactional
	public int updateWaybill(Object obj) throws Exception {
		int updateCnt = 0;
		TB_ODINFOXM tb_odinfoxm = (TB_ODINFOXM)obj;

		// insert
		updateCnt = orderMapper.updateMasterTdn(tb_odinfoxm);
		updateCnt = orderMapper.updateDetailTdn(tb_odinfoxm);

		return updateCnt;		
	}
	
	/* ############################################## 확 인 필 요 ####################################################### */
	public Object getOddlaixm(Object obj) throws Exception{
		return orderMapper.getOddlaixm(obj);
	}
	public List<?> getOdinfoxd_ownerclan(Object obj) throws Exception{
		return orderMapper.getOdinfoxd_ownerclan(obj);
	}
	public Object getDlvyInfo_ownerclan(Object obj) throws Exception{
		return orderMapper.getDlvyInfo_ownerclan(obj);
	}
	public List<?> getOdinfo_ownerclan(Object obj) throws Exception{
		return orderMapper.getOdinfo_ownerclan(obj);
	}
	public int updateOwnerclanOrderInit(Object obj) throws Exception{
		return orderMapper.updateOwnerclanOrderInit(obj);
	}
	public List<?> getOrderProgressListOwerclan() throws Exception{
		return orderMapper.getOrderProgressListOwerclan();
	}
	public int updateOrderStatusOwnerclan(Object obj) throws Exception{
		return orderMapper.updateOrderStatusOwnerclan(obj);
	}
	public List<?> getOrderStatusOwerclan(Object obj) throws Exception{
		return orderMapper.getOrderStatusOwerclan(obj);
	}
	public List<?> getOdinfo_modenoffice(Object obj) throws Exception{
		return orderMapper.getOdinfo_modenoffice(obj);
	}
	public int chkOwnerclanOrderStatus(Object obj) throws Exception {
		return orderMapper.chkOwnerclanOrderStatus(obj);
	}
	public int updateOrderStatusModenoffice(Object obj) throws Exception {
		return orderMapper.updateOrderStatusModenoffice(obj);
	}
	public int setModenOfficeDlvyStatus(Object obj) throws Exception {
		return orderMapper.setModenOfficeDlvyStatus(obj);
	}
	
	/* ############################################## 사 용 안 함 ####################################################### */
	public void orderDlvyDateUpdate(Object obj) throws Exception{
		orderMapper.orderDlvyDateUpdate(obj);
	}
	public void orderDlvyUpdate(Object obj) throws Exception {
		orderMapper.orderDlvyUpdate(obj);
	}
	public int danalLogInsert(Object obj) throws Exception {
		return orderMapper.danalLogInsert(obj);
	}
	
}
