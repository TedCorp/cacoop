package mall.web.mapper.admin;

import java.util.List;
import java.util.Map;

import mall.web.domain.Customers;
import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDSHIPXM;
import mall.web.domain.TB_SPINFOXM;

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
public interface ProductMgrMapper {
	public int count(Object obj) throws Exception;
	public int countAdmin(Object obj) throws Exception;
	public List<TB_PDINFOXM> list(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public List<?> paginatedListAdmin(Object obj) throws Exception;
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
	public TB_SPINFOXM getSuprList2(TB_PDINFOXM productInfo) throws Exception;
	public int optionInsert(Object obj);
	public int optionDelete(Object obj);
	public List<?> getOptionList(Object obj);
	public List<?> getOptionTitle(Object obj);
	public List<?> getExtraPrdlist(Object obj);
	public int insertExtrprod(Object obj);
	public List<?> getSavedExtPrdList(Object obj);
	public int deleteExtrprod(Object obj);
	public int checkExtrprod(Object obj);
	public List<?> getUplodeResult(Object obj);
	
	/* 상품코드 가져오기 - 이유리 */
	public Object getProductCode(Object obj);
	/* 배송정보 마스터 가져오기 - 이유리 */
	public Object getShipMaster(Object obj);
	/* 배송정보 디테일 가져오기 - 이유리 */
	public List<?> getShipDetail(Object obj);
	/* 배송정보 마스터 업데이트 - 이유리 */
	public int updateShipMaster(Object obj);
	/* 배송정보 디테일 삭제 - 이유리 */
	public int deleteShipDetail(Object obj);
	/* 배송정보 디테일 업데이트 - 이유리 */
	public int updateShipDetail(Object obj);
	/* 템플릿 마스터 리스트 가져오기 - 이유리 */
	public List<?> getTempMasterList(Object obj);
	/* 템플릿 마스터 가져오기 - 이유리 */
	public Object getTempMaster(Object obj);
	/* 템플릿 디테일 가져오기 - 이유리 */
	public List<?> getTempDetail(Object obj);
	/* 템플릿 마스터 인서트 - 이유리 */
	public int insertTempMaster(Object obj);
	/* 템플릿 마스터 업데이트 - 이유리 */
	public int updateTempMaster(Object obj);
	/* 템플릿 마스터 삭제 - 이유리 */
	public int deleteTempMaster(Object obj);
	/* 템플릿 디테일 삭제 - 이유리 */
	public int deleteTempDetail(Object obj);
	/* 템플릿 디테일 업데이트 - 이유리 */
	public int updateTempDetail(Object obj);
	/* 조합원 배송비 가져오기 - 이유리 */
	public Object getSuprInfo(Object obj);
	/* 조합원코드 가져오기 - 이유리 */
	public Object selectSuprCode(Object obj);
	/* 조합원 배송비 업데이트 - 이유리 */
	public int updateSuprInfo(Object obj);
	public int insertProductInfo(Object obj) throws Exception;
	public String getUploadCode();
	public Map callValidChk(Map map);
	//반품지
	public Object getDeliveryInfo(Object obj)throws Exception;
	
	public int countOriginPrice(Object obj) throws Exception;
	
	public int updateOrignPrice(Object obj) throws Exception;
	
	public int updateOptionPrice(Object obj) throws Exception;
	
	public int optionUpdate(Object obj) throws Exception;
	public int insertPrdData(Object obj);
	public int resetTmpPdinfoxm(TB_PDINFOXM pdinfoxm);
	public List<?> cagoSearch(Object obj);
	public int setDetailimg(Object obj);
	public int detailMasterInsert(Object obj);
	public int insertLinkedObject(TB_PDINFOXM productInfo);
	public int updateLinkedObject(TB_PDINFOXM productInfo);
	public int linkDuplicateChk(TB_PDINFOXM tb_pdinfoxm);
	public String selectByNpdcode(String n_PD_CODE);
	
	public TB_PDSHIPXM insertShip(TB_PDSHIPXM asdf);
}
