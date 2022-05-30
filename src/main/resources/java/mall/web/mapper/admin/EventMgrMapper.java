package mall.web.mapper.admin;

import java.util.List;

/**
* @author Your Name (your@email.com)
* 광고 Mapper
*/

public interface EventMgrMapper {

	public int count(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public List<?> selectList(Object obj) throws Exception; 
	
	public List<?> detailList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;
	public int update(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;
	
	public int admgrInsert(Object obj) throws Exception;
	public int admgrUpdate(Object obj) throws Exception;
	public int copyAdInsert(Object obj) throws Exception;
	public int copyPdInsert(Object obj) throws Exception;
	
	public int excelUpload(Object obj) throws Exception;
	
	public int copyInsert(Object obj) throws Exception; 
	
	public List<?> selectLog(Object obj) throws Exception; 
	
}
