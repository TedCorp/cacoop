package mall.web.mapper.admin;

import java.util.List;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.mapper
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 주문삭제내역 Mapper
 * @Company	: YT Corp.
 * @Author	: 
 * @Date	: 
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
public interface OrderBakMgrMapper {
	public int count(Object obj) throws Exception;
	public List<?> list(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;
	public int update(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;
	
	public int updateState(Object obj) throws Exception;
	public Object getMasterInfo(Object obj) throws Exception;
	public List<?> getDetailsList(Object obj) throws Exception;
	public Object getDeliveryInfo(Object obj) throws Exception;

	public int deleteReturnOrdList(String num) throws Exception;
	public int deleteReturnOrdDtlList(String num) throws Exception;

	public List<?> excelList(Object obj) throws Exception;
	public List<?> excelAllList(Object obj) throws Exception;
	public List<?> detailExcelList(Object obj) throws Exception;

	public Object supplierInfo(Object obj) throws Exception;
	public List<?> delivery(Object obj) throws Exception;
	
	public List<?> getMonitorExcelList(Object obj) throws Exception;
}
