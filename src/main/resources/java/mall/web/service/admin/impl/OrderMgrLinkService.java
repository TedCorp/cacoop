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
import mall.web.mapper.admin.OrderMgrLinkMapper;
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
@Service("orderMgrLinkService")
public class OrderMgrLinkService implements DefaultService {
	
	@Resource(name="orderMgrLinkMapper")
	OrderMgrLinkMapper orderMgrLinkMapper;
	
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return orderMgrLinkMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return orderMgrLinkMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return orderMgrLinkMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return orderMgrLinkMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return orderMgrLinkMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return orderMgrLinkMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return orderMgrLinkMapper.delete(obj);
	}
	
	//일괄 주문 상태 변경
	public void updateStateObject(TB_ODINFOXM tb_odinfoxm) throws Exception {
		StringTokenizer stok = new StringTokenizer(tb_odinfoxm.getORDER_CON_ORDER_NUM(),"$");
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			TB_ODINFOXM obj = new TB_ODINFOXM();
			obj.setORDER_NUM(str);
			obj.setORDER_CON_STATE(tb_odinfoxm.getORDER_CON_STATE());
			obj.setMODP_ID(tb_odinfoxm.getMODP_ID());
			orderMgrLinkMapper.updateState(obj);
		}
	}
	
	//주문정보 마스터 정보 - 상세화면
	public Object getMasterInfo(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderMgrLinkMapper.getMasterInfo(tb_odinfoxm);
	}
	
	//주문정보 상세 - 상세화면  
	public List<?> getDetailsList(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderMgrLinkMapper.getDetailsList(tb_odinfoxm);
	}
	
	//배송지 정보 - 상세화면
	public Object getDeliveryInfo(TB_ODINFOXM tb_odinfoxm) throws Exception {
		return orderMgrLinkMapper.getDeliveryInfo(tb_odinfoxm);
	}
	
	/*//주문상태 및 결제 정보 수정
	public void getDetailsUpdate(Object obj) throws Exception {
		orderMgrLinkMapper.getDetailsUpdate(obj);
	}*/
	public void getDetailsUpdate(TB_ODINFOXM tb_odinfoxm, TB_ODDLAIXM tb_oddlaixm) throws Exception {
		//주문상태 및 결제 정보 수정
		orderMgrLinkMapper.getDetailsUpdate(tb_odinfoxm);
		//배송정보 수정
		orderMgrLinkMapper.getDeliveryUpdate(tb_oddlaixm);
		
		// 주문상세 (TB_ODINFOXD) 주문상태, 운송장 변경 (연동) 2020-02-27 LJS
		// orderMgrLinkMapper.getOrderDetailsUpdate(tb_odinfoxm);
		
		
	}
	
	/*//배송정보 수정
	public void getDeliveryUpdate(Object obj) throws Exception {
		orderMgrLinkMapper.getDeliveryUpdate(obj);
	}*/
	
	//피킹리스트
	public List<?> getPickingList(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrLinkMapper.pickingList(tb_odinfoxm);
		
	}
	//피킹리스트 - 상품별
	public List<?> getPickingGoodsList(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrLinkMapper.pickingGoodsList(tb_odinfoxm);
		
	}
	//피킹리스트 - 매출처별
	public List<?> getPickingComList(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrLinkMapper.pickingComList(tb_odinfoxm);
		
	}
	//피킹리스트 - 차량별
	public List<?> getPickingCarList(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrLinkMapper.pickingCarList(tb_odinfoxm);
		
	}
	//피킹리스트 주문상태 업데이트
	public void updatePickingList(String num) throws Exception{
		orderMgrLinkMapper.updatePickingList(num);
	}
	
	public List<?> getExcelList(Object obj) throws Exception {
		return orderMgrLinkMapper.excelList(obj);
	}
	
	// 운송장리스트 조회
	public List<?> getDlvyTdnlExcelList(Object obj) throws Exception {
		return orderMgrLinkMapper.getDlvyTdnlExcelList(obj);
	}
	
	public List<?> getExcelAllList(Object obj) throws Exception {
		return orderMgrLinkMapper.excelAllList(obj);
	}
	
	public List<?> getDetailExcelList(Object obj) throws Exception {
		return orderMgrLinkMapper.detailExcelList(obj);
	}

	//주문내역삭제
	public void deleteOrdList(String num) throws Exception{
		orderMgrLinkMapper.deleteOrdList(num);
	}
	//주문내역상세삭제
	public void deleteOrdDetail(String num) throws Exception{
		orderMgrLinkMapper.deleteOrdDetail(num);
	}
	
	//주문내역삭제
	public void updateDatailQty(Object obj) throws Exception{
		orderMgrLinkMapper.updateDatailQty(obj);
	}
	//주문내역상세삭제
	public void updateMasterQty(Object obj) throws Exception{
		orderMgrLinkMapper.updateMasterQty(obj);
	}
	
	public void updateDatailQtyLink(Object obj) throws Exception{
		orderMgrLinkMapper.updateDatailQtyLink(obj);
	}
	
	
	// 상품 공급업체 리스트 불러오기 2020-02-25
	public List<?> getPdSuprList(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrLinkMapper.getPdSuprList(tb_odinfoxm);		
	}
	
	
	//테스트ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	//피킹리스트 - 상품별
	public List<?> getPickingGoodsExcel(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrLinkMapper.pickingGoodsExcel(tb_odinfoxm);
		
	}
	//피킹리스트 - 매출처별
	public List<?> getPickingComExcel(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrLinkMapper.pickingComExcel(tb_odinfoxm);
		
	}
	//피킹리스트 - 차량별
	public List<?> getPickingCarExcel(TB_ODINFOXM tb_odinfoxm) throws Exception{
		return orderMgrLinkMapper.pickingCarExcel(tb_odinfoxm);
		
	}
	//결제전 내역 삭제
	public int getObjectDeleteCount(Object obj) throws Exception {
		return orderMgrLinkMapper.deleteCount(obj);
	}

	public List<?> getPaginatedDeleteObjectList(Object obj) throws Exception {
		return orderMgrLinkMapper.paginatedDeleteList(obj);
	}
	
	//주문내역삭제복원
	public void getDeleteReturnOrdList(String num) throws Exception{
		orderMgrLinkMapper.deleteReturnOrdList(num);
	}
	public void getDeleteReturnOrdDtlList(String num) throws Exception{
		orderMgrLinkMapper.deleteReturnOrdDtlList(num);
	}
	
	// 오너클랜 주문신청 누락 cnt
	public int getCntOrderOwnerclan(Object obj) throws Exception{
		return orderMgrLinkMapper.getCntOrderOwnerclan(obj);
	
	}
	
	// 모든오피스 주문신청 누락 cnt
	public int getCntOrderModeoffice(Object obj) throws Exception{
		return orderMgrLinkMapper.getCntOrderModeoffice(obj);
		
	}
	
	// 오너클랜 주문번호 null 세팅
	public void setNullOwerclanOrdernum(Object obj) throws Exception{
		orderMgrLinkMapper.setNullOwerclanOrdernum(obj);
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
					
					updateCnt = orderMgrLinkMapper.excelUpdate_Dlvy(paramObj);
					
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
						/*orderMgrLinkMapperLink.excelUpdate_Dlvy_mst_ordercon(paramObj);*/
						
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
}