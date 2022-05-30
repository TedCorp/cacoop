package mall.web.mapper.mall;

import java.util.List;

public interface BoardMapper {

	public int count(Object obj) throws Exception;
	public List<?> list(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;
	public int update(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;
	
	public int reviewInsert(Object obj) throws Exception;
	public int qnaInsert(Object obj) throws Exception;
	
	public List<?> boardList(Object obj) throws Exception;
	public Object revQnaFind(Object obj) throws Exception;
	
	public int updateQna(Object obj) throws Exception;
	public int updateReview(Object obj) throws Exception;
	
}
