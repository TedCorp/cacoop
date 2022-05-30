package mall.web.mapper.admin;

import java.util.List;

/**
* @author Your Name (your@email.com)
* 전단 Mapper
*/

public interface JundanMgrMapper {

	public int count(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public List<?> selectList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;	
	public int update(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;
	
	public int copyJdInsert(Object obj) throws Exception;
	public List<?> selectLog(Object obj) throws Exception;
	
}
