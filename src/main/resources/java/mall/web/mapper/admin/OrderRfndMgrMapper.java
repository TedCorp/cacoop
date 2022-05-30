package mall.web.mapper.admin;

import java.util.List;

import mall.web.domain.TB_ODINFOXM;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.mapper
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 환불접수 Mapper
 * @Company	: YT Corp.
 * @Author	: chjw
 * @Date	: 2021-01-05 (오후 11:41:40)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
public interface OrderRfndMgrMapper {
	// override
	public int count(Object obj) throws Exception;
	public List<?> list(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;
	public int update(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;

	public int updateMaster(TB_ODINFOXM inObj) throws Exception;
	public int updateDetail(TB_ODINFOXM inObj) throws Exception;
}
