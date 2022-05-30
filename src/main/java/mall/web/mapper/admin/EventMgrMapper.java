package mall.web.mapper.admin;

import java.util.List;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Company	: ted
 * @Author	: jang bora
 * @Date	: 2021-11-04
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
public interface EventMgrMapper {
	
	public int count(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public List<?> list(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;
	public int update(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;
	
	
	public int updateProduct(Object obj) throws Exception;
	public List<?> listProduct(Object obj) throws Exception;
	public int deleteProduct(Object obj) throws Exception;
	public int ordrSameCnt(Object obj) throws Exception;
	public int grpPdCnt(Object obj) throws Exception;
	
	//상품목록리스트
	public List<?> selectProduct(Object obj) throws Exception;
	
	//각 기획전마다 상품갯수구하기
	public int selectCount(Object obj)throws Exception;
	//GRP_CD중복체크
	public int grpChk(Object obj)throws Exception;
	//상품정렬
	public List<?> getOrderByList(Object obj)throws Exception;
	//파일 정보가져오기
	public List<?> selectFileList(Object obj);
	
	public Object getAllFind(Object obj);
	
//	public int count(Object obj) throws Exception;
//	public List<?> paginatedList(Object obj) throws Exception;
//	public List<?> selectList(Object obj) throws Exception; 
//	
//	public List<?> detailList(Object obj) throws Exception;
//	public Object find(Object obj) throws Exception;
//	public int insert(Object obj) throws Exception;
//	public int update(Object obj) throws Exception;
//	public int delete(Object obj) throws Exception;
//	
//	public int admgrInsert(Object obj) throws Exception; 
	
//	public int admgrUpdate(Object obj) throws Exception;
//	public int copyAdInsert(Object obj) throws Exception;
//	public int copyPdInsert(Object obj) throws Exception;
//	
//	public int excelUpload(Object obj) throws Exception;
//	
//	public int copyInsert(Object obj) throws Exception; 
//	
//	public List<?> selectLog(Object obj) throws Exception; 
}
