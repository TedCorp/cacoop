package mall.web.mapper.admin;

import java.util.List;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.mapper.admin
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 게시판 관리
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-18 (오전 10:56:41)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
public interface BoardMgrMapper {
	public int count(Object obj) throws Exception;
	public List<?> list(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;
	public int update(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;
	
	public int count01(Object obj) throws Exception;
	public List<?> paginatedList01(Object obj) throws Exception;
	public Object find01(Object obj) throws Exception;
	public int update01(Object obj) throws Exception;
	
	public int count02(Object obj) throws Exception;
	public List<?> paginatedList02(Object obj) throws Exception;
	public Object find02(Object obj) throws Exception;
	public int update02(Object obj) throws Exception;
	
	public int count03(Object obj) throws Exception;
	public List<?> paginatedList03(Object obj) throws Exception;
	public Object find03(Object obj) throws Exception;
	public int update03(Object obj) throws Exception;
	
	public int count04(Object obj) throws Exception;
	public List<?> paginatedList04(Object obj) throws Exception;
	public Object find04(Object obj) throws Exception;
	public int insert04(Object obj) throws Exception;
	public int update04(Object obj) throws Exception;
	
	
	
	public List<?> cagoList(Object obj) throws Exception;
	public List<?> schCagoList(Object obj) throws Exception;
}
