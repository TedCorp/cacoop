package mall.web.mapper.admin;

import java.util.List;

import mall.web.domain.Customers;
import mall.web.domain.TB_ENTRYCAGOXD;
import mall.web.domain.TB_ENTRYCAGOXM;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.mapper
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 
 * @Company	: YT Corp.
 * @Author	: 
 * @Date	: 2020-03-30
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
public interface EntryCategoryMgrMapper {
	public int count(Object obj) throws Exception;
	public List<?> list(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;
	public int update(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;
	
	public int deletePrd(Object obj) throws Exception;
	
	public int goodsMasterCount(Object obj) throws Exception;
	public List<?> goodsMasterList(Object obj) throws Exception;
	public int pdCodeChk(Object obj) throws Exception;
	public int pdBarCodeChk(Object obj) throws Exception;

	public List<?> excelList(Object obj) throws Exception;
	
	public List<?> proCutList(Object obj) throws Exception;
	public int proCutInsert(Object obj) throws Exception;
	
	public int listUpdate(Object obj) throws Exception;
	
	public int excelUpload(Object obj) throws Exception;
	public int excelUpdate_pdPrice(Object obj) throws Exception;
	
	// 우리마켓 첨부파일 정보 업데이트
	public int insertWrFileMaster(Object obj) throws Exception;
	public int insertWrFileDetail(Object obj) throws Exception;
	public int updateWrmall(Object obj) throws Exception;
	public List<?> selectFileList(Object obj);
	public int selectWrCount(Object obj) throws Exception;
	
	// temp backup
	public int tmpBackUp(Object obj) throws Exception;
	public int delete2(Object obj) throws Exception;
	
	// IIBS 연동관련
	// 공급업체 리스트 조회
	public List<?> getSuprList(Object obj) throws Exception;
	
	
	public List<?> getEntrycagoList() throws Exception;
	public TB_ENTRYCAGOXM getEntrycago(Object obj) throws Exception;
	public List<?> getEntrycagoDetail(Object obj) throws Exception;
	public int updateEntryCagoxm(Object obj) throws Exception;
	public int insertEntryCagoxd(Object obj) throws Exception;
	public int deleteEntryCagoxd(Object obj) throws Exception;
	public int deleteEntryCagoxm(Object obj) throws Exception;
	public int insertEntryCagoxm(Object obj) throws Exception;
	public String getEntCagoMaxEtryId() throws Exception;
	
}
