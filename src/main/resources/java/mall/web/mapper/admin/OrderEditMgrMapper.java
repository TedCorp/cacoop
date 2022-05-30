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
public interface OrderEditMgrMapper {
	// default
	public int count(Object obj) throws Exception;
	public List<?> list(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;
	public int update(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;
	
	// 반품테이블 체크
	public int getReturnInfo(Object obj) throws Exception;
	public Object getRtnMasterObject(Object obj) throws Exception;
	
	// 확정주문 수량변경
	public int updateDatailQty(Object obj) throws Exception;
	public int updateMasterQty(Object obj) throws Exception;

	// 반품수량 insert	
	public int rtOdInfoXmInsert(Object obj) throws Exception;
	public int rtOdInfoXdInsert(Object obj) throws Exception;
	
	public int updateMaster(Object obj) throws Exception;
	
	public Object getMasterInfo(Object obj) throws Exception;
	public List<?> getDetailsList(Object obj) throws Exception;
	
	public int updateTrackCon(Object obj) throws Exception;
	public int updateTrackNum(Object obj) throws Exception;
}
