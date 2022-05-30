package mall.web.mapper.mall;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import mall.web.domain.TB_ODINFOXD;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.mapper.mall
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 주문 내역
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-27 (오후 2:08:09)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
public interface OrderMapper {
	// override
	public int count(Object obj) throws Exception;
	public int exchangeCount(Object obj) throws Exception;
	public int reviewCount(Object obj) throws Exception;
	public List<?> list(Object obj) throws Exception;
	public List<?> orderList(Object obj) throws Exception;
	public List<?> exchange(Object obj) throws Exception;
	public List<?> confirm(Object obj) throws Exception;
	public List<?> reviewList(Object obj) throws Exception;
	public Object review(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;
	public int update(Object obj) throws Exception;
	public int updateDetail(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;
	public int updateDlvyAmt(Object obj) throws Exception;
	public int newDlvyAmt(Object obj) throws Exception;
	
	// 리뷰 - 이유리
	public int insertReview(Object obj) throws Exception;
	public int updateReview(Object obj) throws Exception;
	public int deleteReview(Object obj) throws Exception;
	public int updateFileDetail(Object obj) throws Exception;
	public Object selectFile(Object obj) throws Exception;
	
	// order insert
	public int odInfoXmInsert(Object obj) throws Exception;
	public int odInfoXdInsert(Object obj) throws Exception;
	public int odDlaxiXmInsert(Object obj) throws Exception;
	public int bkInfoXmDelete(Object obj) throws Exception;
	
	// one product order
	public List<?> newList(List list) throws Exception;
	public List<?> buyList(Object obj) throws Exception;
	public List<?> getBuyOnePd(TB_ODINFOXD tb_odinfoxm) throws Exception;
	public TB_ODINFOXD getPdnOption(Object obj);
	
	// order info
	public Object getMasterInfo(Object obj) throws Exception;
	/* 배송조회 주문자 정보 - 이유리 */
	public Object getOrderInfo(Object obj) throws Exception;
	public List<?> getDetailsList(Object obj) throws Exception;
	public Object getDeliveryInfo(Object obj) throws Exception;
	public List<?> getRefundList(Object obj) throws Exception;

	// delivery address info
	public Object getMbDlvyInfo(Object obj) throws Exception;
	public Object getSpDlvyInfo(Object obj) throws Exception;
	public Object getDlvyInfo(Object obj) throws Exception;
	public Object getSfDlvyInfo(Object obj) throws Exception;
	public Object getCtDlvyInfo(Object obj) throws Exception;

	// one product order count
	public int orderCnt(Object obj) throws Exception;

	// order cancel popup -- cancel reason
	public int orderCancel(Object obj) throws Exception;
	
	// order condition update
	public int orderPayUpdate(Object obj) throws Exception;
	public int orderPayUpdateDtl(Object obj) throws Exception;
	// virtual account pay info update
	public int cashRequest(Object obj) throws Exception;
	
	//order delete flag update
	public void orderUpdateDelete(Object obj) throws Exception;
	
	// excel download info
	public List<?> excelList(Object obj) throws Exception;
	
	// delivery info select
	public List<?> getDlvyPdList(Object obj) throws Exception;
	public Map<String, String> getDlvyAddrInfo(Object obj) throws Exception;
	
	// xpay api paykey select
	public Object getPayMdky(Object obj) throws Exception;
	// virtual account info
	public Object getVirAcctInfo(Object obj) throws Exception;
	
	// atomy azamall send order info 
	public List<?> getOrderInfoAza(Object obj) throws Exception;
	
	// all return check
	public int chkAllReturn(Object obj) throws Exception;
	
	// log insert
	public void insertApiLog(Object obj) throws Exception;
	public int lguplusLogInsert(Object obj) throws Exception;
	
	// refund
	public int insertRefundMaster(Object obj) throws Exception;
	public int insertRefundDetail(Object obj) throws Exception;
	public int updateRefundAmt(Object obj) throws Exception;
	

	public int updateMasterTdn(Object obj) throws Exception;
	public int updateDetailTdn(Object obj) throws Exception;
	
	/* ############################################## 확 인 필 요 ####################################################### */
	public Object getOddlaixm(Object obj) throws Exception;
	public List<?> getOdinfoxd_ownerclan(Object obj) throws Exception;
	public Object getDlvyInfo_ownerclan(Object obj) throws Exception;
	public List<?> getOdinfo_ownerclan(Object obj) throws Exception;
	public int updateOwnerclanOrderInit(Object obj) throws Exception;
	public List<?> getOrderProgressListOwerclan() throws Exception;
	public int updateOrderStatusOwnerclan(Object obj) throws Exception;
	public List<?> getOrderStatusOwerclan(Object obj) throws Exception;
	public List<?> getOdinfo_modenoffice(Object obj) throws Exception;
	public int chkOwnerclanOrderStatus(Object obj) throws Exception;
	public int updateOrderStatusModenoffice(Object obj) throws Exception;
	public int setModenOfficeDlvyStatus(Object obj) throws Exception;
	
	
	/* ############################################## 사 용 안 함 ####################################################### */
	public void orderDlvyDateUpdate(Object obj) throws Exception;
	public void orderDlvyUpdate(Object obj) throws Exception;
	public int danalLogInsert(Object obj) throws Exception;
	public String getOrderNum();
	public int updateOrderCon(Object tb_odinfoxm);
	
	/* 공급사 가격 */
	public List<?> suprProductAmt(Object obj) throws Exception;
	public Object getBuyExtraPd(Object obj);
	public Map resetOrder(Map map);
}
