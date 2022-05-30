package mall.web.mapper.admin;

import java.util.List;

public interface CompanySaleMgrMapper {

	public int count(Object obj) throws Exception; //리스트 카운트
	public int countDetail(Object obj) throws Exception; //디테일 카운트
	public List<?> list(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception; //리스트 목록
	public List<?> paginatedListDetail(Object obj) throws Exception; //디테일리스트
	public Object find(Object obj) throws Exception;
	public List<?> excelList(Object obj) throws Exception;
	public List<?> excelDownDetail(Object obj) throws Exception;
	
}
