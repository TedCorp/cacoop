package mall.web.service.mall;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import freemarker.template.utility.StringUtil;
import mall.common.util.FileUtil;
import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_BKINFOXM;
import mall.web.domain.TB_LGUPLUS;
import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_PDCOMMXM;
import mall.web.mapper.common.CommonMapper;
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
	
	/* 교환/반품 개수 - 이유리 */
	public int getExchangeObjectCount(Object obj) throws Exception {
		return orderMapper.exchangeCount(obj);
	}
	

	/* 댓글 개수 - 이유리 */
	public int getReviewObjectCount(Object obj) throws Exception {
		return orderMapper.reviewCount(obj);
	}
	
	/* 구매확정 개수 - 이유리 */
	/*
	public int getConfirmedObjectCount(Object obj) throws Exception {
		return orderMapper.exchangeCount(obj);
	}*/
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return orderMapper.list(obj);
	}
	
	/* 주문리스트 - 이유리 */
	public List<?> getObjectOrderList(Object obj) throws Exception {
		return orderMapper.orderList(obj);
	}
	
	/* 교환/반품 리스트 - 이유리 */
	public List<?> getExchangeObjectList(Object obj) throws Exception {
		return orderMapper.exchange(obj);
	}
	
	/* 구매확정 리스트 - 이유리 */
	public List<?> getConfirmedObjectList(Object obj) throws Exception {
		return orderMapper.confirm(obj);
	}
	
	/* 댓글 리스트 - 이유리 */
	public List<?> getReviewObjectList(Object obj) throws Exception {
		return orderMapper.reviewList(obj);
	}
	
	/* 댓글 상세 - 이유리 */
	public Object getReviewObject(Object obj) throws Exception {
		return orderMapper.review(obj);
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

	/* 주문수정 마스터 - 이유리 */
	@Override
	public int updateObject(Object obj) throws Exception {
		return orderMapper.update(obj);
	}
	
	/* 주문수정 디테일 - 이유리 */
	public int updateObjects(Object obj) throws Exception {
		return orderMapper.updateDetail(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return orderMapper.delete(obj);
	}
	
	/* 배송비 변경 - 이유리 */
	public int updateDlvyAmt(Object obj) throws Exception {
		return orderMapper.updateDlvyAmt(obj);
	}
	
	/* 리뷰 등록 */
	public int insertReviewObject(Object obj) throws Exception {
		return orderMapper.insertReview(obj);
	}

	/* 리뷰 수정 */
	public int updateReviewObject(Object obj) throws Exception {
		return orderMapper.updateReview(obj);
	}

	/* 리뷰 삭제 */
	public int deleteReviewObject(Object obj) throws Exception {
		return orderMapper.deleteReview(obj);
	}
	
	@Transactional
	public int insertOrderObject(TB_ODINFOXM obj, TB_ODINFOXD obj2, TB_ODDLAIXM obj3) throws Exception {
		int updateCnt = 0; 
		if(obj.getPAY_METD().equals("SC0040")) {
			obj.setORDER_CON("ORDER_CON_01");
		} else {
			obj.setORDER_CON("ORDER_CON_02");
		}
		System.out.println("orderService : "+ obj.getPAY_METD());
		orderMapper.odInfoXmInsert(obj);	//결제전
		for(int i=0; i<obj2.getPD_CODES().length; i++){
			TB_ODINFOXD tb_odinfoxd = new TB_ODINFOXD();
			tb_odinfoxd.setORDER_NUM(obj.getORDER_NUM());
			tb_odinfoxd.setREGP_ID(obj.getREGP_ID());
			tb_odinfoxd.setPD_CODE(obj2.getPD_CODES()[i]);
			tb_odinfoxd.setPD_NAME(obj2.getPD_NAMES()[i]);
			tb_odinfoxd.setPD_PRICE(obj2.getPD_PRICES()[i]);
			tb_odinfoxd.setORDER_QTY(obj2.getORDER_QTYS()[i]);
			tb_odinfoxd.setORDER_AMT(obj2.getORDER_AMTS()[i]);
			tb_odinfoxd.setDLVY_AMT(obj2.getDLVY_AMTS()[i]);
			tb_odinfoxd.setSETPD_CODE(obj2.getSETPD_CODES()[i]);
			System.out.println("디테일주문금액 : "+obj2.getORDER_AMTS()[i]);
			/* 결제 방식 추가 - 이유리 */
			tb_odinfoxd.setPAY_METD(obj.getPAY_METD());
			
			if(obj.getPAY_METD().equals("SC0040")) {
				tb_odinfoxd.setORDER_CON("ORDER_CON_01");
			} else {
				tb_odinfoxd.setORDER_CON("ORDER_CON_02");
			}
			
			if( ((String[])obj2.getOPTION1_NAMES()).length != 0 )
				tb_odinfoxd.setOPTION1_NAME((obj2.getOPTION1_NAMES())[i]);
			if( ((String[])obj2.getOPTION1_VALUES()).length != 0 )
				tb_odinfoxd.setOPTION1_VALUE((obj2.getOPTION1_VALUES())[i]);
			if( ((String[])obj2.getOPTION2_NAMES()).length != 0 )
				tb_odinfoxd.setOPTION2_NAME((obj2.getOPTION2_NAMES())[i]);
			if( ((String[])obj2.getOPTION2_VALUES()).length != 0 )
				tb_odinfoxd.setOPTION2_VALUE((obj2.getOPTION2_VALUES())[i]);
			if( ((String[])obj2.getOPTION3_NAMES()).length != 0 )
				tb_odinfoxd.setOPTION3_NAME((obj2.getOPTION3_NAMES())[i]);
			if( ((String[])obj2.getOPTION3_VALUES()).length != 0 )
				tb_odinfoxd.setOPTION3_VALUE((obj2.getOPTION3_VALUES())[i]);

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
	/* 배송조회 주문자 정보 - 이유리 */
	public Object getOrderInfo(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderMapper.getOrderInfo(tb_odinfoxm);
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
	public TB_ODINFOXD getPdnOption(Object obj) {
		return orderMapper.getPdnOption(obj);
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

	public Object updateFile(TB_COATFLXD commonFile, HttpServletRequest request, MultipartHttpServletRequest multipartRequest, String objName, String filePath, Boolean bOriginalFilename) throws Exception {
		
		List<MultipartFile> fileList = multipartRequest.getFiles(objName);
		String strRtnATFL_ID = commonFile.getATFL_ID();
		
		if ( StringUtils.isNotEmpty(fileList.get(0).getOriginalFilename()) ) {
			for (MultipartFile multipartFile : fileList) {
				if(StringUtils.isNotEmpty(multipartFile.getOriginalFilename())) {
					String saveFileName = FileUtil.saveFile2(request, multipartFile, filePath+"/"+strRtnATFL_ID, bOriginalFilename);

					commonFile.setORFL_NAME(multipartFile.getOriginalFilename());									// 원본파일명
					commonFile.setFILE_EXT(saveFileName.substring(saveFileName.lastIndexOf("."), saveFileName.length()));		// 파일 확장자
					commonFile.setSTFL_NAME(saveFileName);																	// 스토리지 파일 명
					commonFile.setSTFL_PATH(filePath+"/"+strRtnATFL_ID);												// 스토리지 파일 경로
					commonFile.setATFL_SEQ("1");
					commonFile.setFILE_SIZE("" + multipartFile.getSize());
					commonFile.setFILEPATH_FLAG("cjaza");			
				}
			}
		} else {
			TB_COATFLXD tb_coatflxd = (TB_COATFLXD)orderMapper.selectFile(commonFile);
			
			commonFile.setORFL_NAME(tb_coatflxd.getORFL_NAME());	// 원본파일명
			commonFile.setFILE_EXT(tb_coatflxd.getFILE_EXT());		// 파일 확장자
			commonFile.setSTFL_NAME(tb_coatflxd.getSTFL_NAME());	// 스토리지 파일 명
			commonFile.setSTFL_PATH(tb_coatflxd.getSTFL_PATH());	// 스토리지 파일 경로
			commonFile.setATFL_SEQ("1");
			commonFile.setFILE_SIZE(tb_coatflxd.getFILE_SIZE());
			commonFile.setFILEPATH_FLAG(tb_coatflxd.getFILEPATH_FLAG());			
		}
		
		return orderMapper.updateFileDetail(commonFile);
	}

	public String getOrderNum() {
		return orderMapper.getOrderNum();
	}

	

	public int updateOrderCon(Object tb_odinfoxm)throws Exception  {
		return orderMapper.updateOrderCon(tb_odinfoxm);
	}
	
	/* 공급사 가격 - 이유리 */
	public List<?> getSuprProductAmt(Object obj) throws Exception {
		return orderMapper.suprProductAmt(obj);
	}
	/* 새 배송비 가져오기 - 이유리 */
	public int getNewDlvyAmt(Object tb_odinfoxm)throws Exception  {
		return orderMapper.newDlvyAmt(tb_odinfoxm);
	}

	public Object getBuyExtraPd(Object obj) {
		return orderMapper.getBuyExtraPd(obj);
	}

	public Map resetOrder(Map map) {
		return orderMapper.resetOrder(map);
	}
}
