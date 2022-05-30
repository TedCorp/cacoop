package mall.web.mapper.mall;

import java.util.List;

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
public interface RequestMapper {
	public int count(Object obj) throws Exception;
	public List<?> list(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;
	public int update(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;
	
	public int odInfoXmInsert(Object obj) throws Exception;
	public int odInfoXdInsert(Object obj) throws Exception;
	public int odDlaxiXmInsert(Object obj) throws Exception;
	
	public int odInfoXmUpdate(Object obj) throws Exception;
	public int odInfoXdDelete(Object obj) throws Exception;
	public int odDlaxiXmDelete(Object obj) throws Exception;
	
	public List<?> newList(List list) throws Exception;
	public List<?> buyList(Object obj) throws Exception;
	public Object getMasterInfo(Object obj) throws Exception;
	public List<?> getDetailsList(Object obj) throws Exception;
	public List<?> getDeliveryInfo(Object obj) throws Exception;

	public int conditionUpdate(Object obj) throws Exception;
}
