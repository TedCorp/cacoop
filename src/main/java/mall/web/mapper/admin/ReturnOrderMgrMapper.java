package mall.web.mapper.admin;

import java.util.List;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.mapper
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 주문내역 Mapper
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-13 (오후 03:49:22)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
public interface ReturnOrderMgrMapper {
	public int count(Object obj) throws Exception;
	public List<?> list(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;
	public int update(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;
	
	public int rtOdInfoXmInsert(Object obj) throws Exception;
	public int rtOdInfoXdInsert(Object obj) throws Exception;
	
	public Object getMasterInfo(Object obj) throws Exception;
	public List<?> getDetailsList(Object obj) throws Exception;
	
	public int updateMaster(Object obj) throws Exception;

	// 주문번호에 해당하는 반품내역 Count
	public int ordCheck(Object obj) throws Exception;
	public int rtnCheck(Object obj) throws Exception;
	public List<?> rtnOrderInfo(Object obj) throws Exception;
	
	// 주문테이블 신규전표로 반품정보 insert
	public int odInfoXmInsert(Object obj) throws Exception;
	public int odInfoXdInsert(Object obj) throws Exception;
	
	// 주문M 주문금액 update
	public int updateMasterQty(Object master) throws Exception;
	public List<?> rtnDetailList(Object obj) throws Exception;
	
	
	
	//환불완료 공급업체 리스트 불러오기 
	public List<?> getPdSuprList(Object obj) throws Exception;
	
	public int getDetailsUpdate(Object obj) throws Exception;
	
}
