package mall.web.mapper.admin;

import java.util.List;

import mall.web.domain.Customers;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.mapper
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 제품정보 Mapper
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-07 (오후 11:09:58)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
public interface ProductEventMgrMapper {
	public int count(Object obj) throws Exception;
	public List<?> list(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;
	public int update(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;
	
	public int updateProduct(Object obj) throws Exception;
	public int deleteProduct(Object obj) throws Exception;
	
	public int ordrSameCnt(Object obj) throws Exception;
	public int grpPdCnt(Object obj) throws Exception;

	public int excelUpload(Object obj) throws Exception;	
	public int  excelUploadChk_BarcodeCount(Object obj) throws Exception;
		
	public List<?> detailExcelList(Object obj) throws Exception;		
}
