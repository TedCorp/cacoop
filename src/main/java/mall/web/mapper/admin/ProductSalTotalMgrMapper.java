package mall.web.mapper.admin;

import java.util.List;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.mapper
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 상품집계정보 Mapper
 * @Company	: YT Corp.
 * @Author	: 
 * @Date	: 
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
public interface ProductSalTotalMgrMapper {
	public int count(Object obj) throws Exception;
	public List<?> list(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;
	public int update(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;
	
	public List<?> paginatedListDate(Object obj) throws Exception;
	public List<?> paginatedListPeriod(Object obj) throws Exception;
	public List<?> paginatedListMember(Object obj) throws Exception;

	public List<?> excelList(Object obj) throws Exception;
	public List<?> excelDate(Object obj) throws Exception;
	public List<?> excelPeriod(Object obj) throws Exception;
	public List<?> excelMember(Object obj) throws Exception;
	
	public int countTotal(Object obj);
	public int countPeriod(Object obj);
	public int countDate(Object obj);
	public int countMember(Object obj);
}
