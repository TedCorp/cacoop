package mall.web.service.admin.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import mall.web.domain.TB_ODDLAIXM;
import mall.web.domain.TB_ODINFOXD;
import mall.web.domain.TB_ODINFOXM;
import mall.web.mapper.admin.OrderMgrMapper;
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
@Service("orderMgrService")
public class OrderMgrService implements DefaultService {

	@Resource(name="orderMgrMapper")
	OrderMgrMapper orderMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return orderMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return orderMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return orderMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return orderMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return orderMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return orderMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return orderMgrMapper.delete(obj);
	}

	/*주문상태 일괄변경*/
	public int updateState(Object obj) throws Exception {
		return orderMgrMapper.ordState(obj);
	}
	
	/*주문상태 일괄변경*/
	public void updateStateObject(TB_ODINFOXM tb_odinfoxm) throws Exception {
		StringTokenizer stok = new StringTokenizer(tb_odinfoxm.getORDER_CON_ORDER_NUM(),"$");
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			TB_ODINFOXM obj = new TB_ODINFOXM();
			obj.setORDER_NUM(str);
			obj.setORDER_CON_STATE(tb_odinfoxm.getORDER_CON_STATE());
			obj.setMODP_ID(tb_odinfoxm.getMODP_ID());
			orderMgrMapper.updateState(obj);
		}
	}
	
	/*주문 마스터정보 (상세화면)*/
	public Object getMasterInfo(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderMgrMapper.getMasterInfo(tb_odinfoxm);
	}
	
	/*주문 상세정보 (상세화면)*/
	public List<?> getDetailsList(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderMgrMapper.getDetailsList(tb_odinfoxm);
	}
	
	/*배송지 정보 (상세화면)*/
	public Object getDeliveryInfo(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderMgrMapper.getDeliveryInfo(tb_odinfoxm);
	}
	
	/*주문정보 수정*/
	public void getDetailsUpdate(TB_ODINFOXD tb_odinfoxd, TB_ODDLAIXM tb_oddlaixm) throws Exception {
		//주문상태 및 결제 정보 수정
		orderMgrMapper.getDetailsUpdate(tb_odinfoxd);
		//배송정보 수정
		orderMgrMapper.getDeliveryUpdate(tb_oddlaixm);
		
		// 주문상세 (TB_ODINFOXD) 주문상태, 운송장 변경 (연동) 2020-02-27 LJS
		orderMgrMapper.getOrderDetailsUpdate(tb_odinfoxd);
		
		// 애터미아자 API 호출 (결제완료, 배송완료, 주문취소, 환불)
	}
	//주문 마스터 수정(배송비)	
	public int getMasterUpdate(Object obj) throws Exception{
		return orderMgrMapper.getMasterUpdate(obj);
	}
	
	
	public void orderCancel(TB_ODINFOXM tb_odinfoxm) throws Exception {
		//주문상태 및 결제 정보 수정
		if (orderMgrMapper.getDetailsUpdate(tb_odinfoxm) >0){
			// 주문상세 (TB_ODINFOXD) 주문상태, 운송장 변경 (연동) 2020-02-27 LJS
			orderMgrMapper.getOrderDetailsUpdate(tb_odinfoxm);
			
			// 애터미아자 API 호출 (결제완료, 배송완료, 주문취소, 환불)	
		}
	}
	
	/*//배송정보 수정
	public void getDeliveryUpdate(Object obj) throws Exception {
		orderMgrMapper.getDeliveryUpdate(obj);
	}*/
	
	//피킹리스트
	public List<?> getPickingList(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrMapper.pickingList(tb_odinfoxm);
		
	}
	//피킹리스트 - 상품별
	public List<?> getPickingGoodsList(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrMapper.pickingGoodsList(tb_odinfoxm);
		
	}
	//피킹리스트 - 매출처별
	public List<?> getPickingComList(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrMapper.pickingComList(tb_odinfoxm);
		
	}
	//피킹리스트 - 차량별
	public List<?> getPickingCarList(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrMapper.pickingCarList(tb_odinfoxm);
		
	}
	//피킹리스트 주문상태 업데이트
	public void updatePickingList(String num) throws Exception{
		orderMgrMapper.updatePickingList(num);
	}
	
	public List<?> getExcelList(Object obj) throws Exception {
		return orderMgrMapper.excelList(obj);
	}
	
	// 운송장리스트 조회
	public List<?> getDlvyTdnlExcelList(Object obj) throws Exception {
		return orderMgrMapper.getDlvyTdnlExcelList(obj);
	}
	
	public List<?> getExcelAllList(Object obj) throws Exception {
		return orderMgrMapper.excelAllList(obj);
	}
	
	public List<?> getDetailExcelList(Object obj) throws Exception {
		return orderMgrMapper.detailExcelList(obj);
	}

	//주문내역삭제
	public void deleteOrdList(String num) throws Exception{
		orderMgrMapper.deleteOrdList(num);
	}
	//주문내역상세삭제
	public void deleteOrdDetail(String num) throws Exception{
		orderMgrMapper.deleteOrdDetail(num);
	}
	
	//주문내역삭제
	public void updateDatailQty(Object obj) throws Exception{
		orderMgrMapper.updateDatailQty(obj);
	}
	//주문내역상세삭제
	public void updateMasterQty(Object obj) throws Exception{
		orderMgrMapper.updateMasterQty(obj);
	}
	
	public void updateDatailQtyLink(Object obj) throws Exception{
		orderMgrMapper.updateDatailQtyLink(obj);
	}
	
	
	// 상품 공급업체 리스트 불러오기 2020-02-25
	public List<?> getPdSuprList(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrMapper.getPdSuprList(tb_odinfoxm);		
	}
	
	
	//테스트ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	//피킹리스트 - 상품별
	public List<?> getPickingGoodsExcel(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrMapper.pickingGoodsExcel(tb_odinfoxm);
		
	}
	//피킹리스트 - 매출처별
	public List<?> getPickingComExcel(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrMapper.pickingComExcel(tb_odinfoxm);
		
	}
	//피킹리스트 - 차량별
	public List<?> getPickingCarExcel(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrMapper.pickingCarExcel(tb_odinfoxm);
		
	}
	//결제전 내역 삭제
	public int getObjectDeleteCount(Object obj) throws Exception {
		return orderMgrMapper.deleteCount(obj);
	}

	public List<?> getPaginatedDeleteObjectList(Object obj) throws Exception {
		return orderMgrMapper.paginatedDeleteList(obj);
	}
	
	//주문내역삭제복원
	public void getDeleteReturnOrdList(String num) throws Exception{
		orderMgrMapper.deleteReturnOrdList(num);
	}
	public void getDeleteReturnOrdDtlList(String num) throws Exception{
		orderMgrMapper.deleteReturnOrdDtlList(num);
	}
	
	// 오너클랜 주문신청 누락 cnt
	public int getCntOrderOwnerclan(Object obj) throws Exception{
		return orderMgrMapper.getCntOrderOwnerclan(obj);
	
	}
	
	// 모든오피스 주문신청 누락 cnt
	public int getCntOrderModeoffice(Object obj) throws Exception{
		return orderMgrMapper.getCntOrderModeoffice(obj);
		
	}
	
	// 오너클랜 주문번호 null 세팅
	public void setNullOwerclanOrdernum(Object obj) throws Exception{
		orderMgrMapper.setNullOwerclanOrdernum(obj);
	}
	
	// 운송장번호 엑셀 업로드
	public List<TB_ODINFOXD> excelDlvyUpload(Object obj,  List<Map<String, String>>excelContent) throws Exception {
		int updateCnt = 0;
		
		List<TB_ODINFOXD> list = new ArrayList<TB_ODINFOXD>();
		
        for(Map<String, String> article: excelContent){
        	
        	TB_ODINFOXD paramObj = new TB_ODINFOXD();

        	if(StringUtils.isNotEmpty(article.get("A"))) {        		
        		//필수값
        		paramObj.setORDER_NUM(article.get("A"));
        		paramObj.setORDER_DTNUM(article.get("B"));
        		paramObj.setPD_CODE(article.get("C"));
        		paramObj.setPD_NAME(article.get("D"));
        		paramObj.setORDER_QTY(article.get("E"));
        		paramObj.setORDER_NM(article.get("F"));
        		paramObj.setORDER_ADDR(article.get("G"));					
        		paramObj.setDLVY_COM(article.get("H"));					
        		paramObj.setDLVY_TDN(article.get("I"));				
				
				// 주문번호 null 체크 
				if(paramObj.getORDER_NUM() == null || paramObj.getORDER_NUM().equals("") 
						|| paramObj.getORDER_DTNUM() == null || paramObj.getORDER_DTNUM().equals("")) {
					
					paramObj.setEXCEL_CODE("-1");
					paramObj.setEXCEL_MSG("<FONT COLOR = \"RED\">주문번호</FONT>가 비어있습니다.");					
					list.add(paramObj);	
					
					continue;
				}
				
				// 운송장번호 null 체크
				if(paramObj.getDLVY_COM() == null || paramObj.getDLVY_COM().equals("")
						|| paramObj.getDLVY_TDN() == null || paramObj.getDLVY_TDN().equals("")) {
									
					paramObj.setEXCEL_CODE("-1");
					paramObj.setEXCEL_MSG("<FONT COLOR = \"RED\">운송장정보</FONT>가 비어있습니다.");
					list.add(paramObj);
					
					continue;
				}
				
				try
				{
					paramObj.setMODP_ID( ((TB_ODINFOXD)obj).getMODP_ID() );
					
					updateCnt = orderMgrMapper.excelUpdate_Dlvy(paramObj);
					
					// - 업데이트된 상품이 없는 경우 -//
					if(updateCnt == 0) {
						paramObj.setEXCEL_CODE("-1");
						paramObj.setEXCEL_MSG("<FONT COLOR = \"RED\">주문번호</FONT>가 존재하지 않습니다.");
					}
					// - 정상적인 업데이트 - //
					else if(updateCnt == 1) {
						paramObj.setEXCEL_CODE("0");
						paramObj.setEXCEL_MSG("");
						
						// 주문마스터 배송정보 배송중으로 변경
						orderMgrMapper.excelUpdate_Dlvy_mst_ordercon(paramObj);
						
					}					
					
					list.add(paramObj);				
					
				}catch(SQLException e){
				
				}catch(Exception ex){				
					return null;
				}				
        	}        	
        }
        
		return list;
	}
	
	// 주문정보 엑셀 조회
	public List<?> getOrderExcelList(Object obj) throws Exception {
		return orderMgrMapper.getOrderExcelList(obj);
	}
	// 주문상태 변경 detail
	public int orderPayUpdateDtl(Object obj) throws Exception {
		return orderMgrMapper.orderPayUpdateDtl(obj);
	}
	
	
	public int getUpdateCancel(Object obj) throws Exception {
		return orderMgrMapper.getUpdateCancel(obj);
	}
	
	/* 공급사 가격  */
	public List<?> getSuprProductAmt(Object obj) throws Exception {
		return orderMgrMapper.suprProductAmt(obj);
	}

	/* 배송비 변경 - 이유리  */
	public int updateDlvyAmt(Object obj) throws Exception {
		return orderMgrMapper.updateDlvyAmt(obj);
	}
	/* 새 배송비 가져오기 - 이유리 */
	public int getNewDlvyAmt(Object tb_odinfoxm)throws Exception  {
		return orderMgrMapper.newDlvyAmt(tb_odinfoxm);
	}
}