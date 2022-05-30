package mall.web.service.admin.impl;

import java.io.Console;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_EXTRPROD;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDOPTION;
import mall.web.domain.TB_PDRCMDXM;
import mall.web.mapper.admin.ProductMgrMapper;
import mall.web.mapper.mall.ProductMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 제품정보 관리 Service
 * @Company	: YT Corp.
 * @Author	: Byeong-gwon Gang (multiple@nate.com)
 * @Date	: 2016-07-07 (오후 11:07:25)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("productMgrService")
public class ProductMgrService implements DefaultService {

	@Resource(name="productMgrMapper")
	ProductMgrMapper productMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return productMgrMapper.count(obj);
	}
	
	public int getObjectCountAdmin(Object obj) throws Exception{
		return productMgrMapper.countAdmin(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return productMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return productMgrMapper.paginatedList(obj);
	}

	public List<?> getPaginatedObjectListAdmin(Object obj) throws Exception{
		return productMgrMapper.paginatedListAdmin(obj);
	}
	
	@Override
	public int insertObject(Object obj) throws Exception {
		return productMgrMapper.insert(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return productMgrMapper.find(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return productMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return productMgrMapper.delete(obj);		
	}
	
	public int deletePrdObject(Object obj) throws Exception {
		return productMgrMapper.deletePrd(obj);
	}
	
	public List<?> getGoodsMasterList(Object obj) throws Exception {
		return productMgrMapper.goodsMasterList(obj);
	}
	
	public int getGoodsMasterCount(Object obj) throws Exception {
		return productMgrMapper.goodsMasterCount(obj);
	}
	
	public int pdCodeChk(Object obj) throws Exception {
		return 	productMgrMapper.pdCodeChk(obj);
	}
	
	public int pdBarCodeChk(Object obj) throws Exception {
		return 	productMgrMapper.pdBarCodeChk(obj);
	}
	
	public List<?> getExcelList(Object obj) throws Exception {
		return productMgrMapper.excelList(obj);
	}
	
	public List<?> getProCutList(Object obj) throws Exception {
		return productMgrMapper.proCutList(obj);
	}
	
	public int insertProCut(Object obj) throws Exception {
		return productMgrMapper.proCutInsert(obj);
	}
	
	public int updateList(Object obj) throws Exception {
		return productMgrMapper.listUpdate(obj);
	}
	
	public List<TB_PDINFOXM> excelUpload(Object obj,  List<Map<String, String>>excelContent) throws Exception {
		int updateCnt = 0;
		
		List<TB_PDINFOXM> list = new ArrayList<TB_PDINFOXM>();
		
		TB_PDINFOXM pdinfoxm = (TB_PDINFOXM) obj;
		
        for(Map<String, String> article: excelContent){

        	if(StringUtils.isNotEmpty(article.get("A"))) {
        		TB_PDINFOXM paramObj = (TB_PDINFOXM)pdinfoxm;

        		paramObj.setPD_BARCD(article.get("A"));
				paramObj.setPD_PRICE(article.get("B"));
				paramObj.setPD_NAME(article.get("C"));
				
				// - 예외처리 - // => 메소드로 만들것
				if(paramObj.getPD_PRICE() == null || paramObj.getPD_PRICE().equals(""))
				{
					TB_PDINFOXM tb = new TB_PDINFOXM();
					tb.setPD_BARCD(article.get("A"));
					tb.setPD_PRICE(article.get("B"));
					tb.setPD_NAME(article.get("C"));
					tb.setADC1_NAME("-1");
					tb.setADC1_VAL("<FONT COLOR = \"RED\">상품 가격</FONT>이 비어있습니다.");
					list.add(tb);
					
					continue;
				}
				// - 숫자이외의 값 보류 : jsp내 금액 구분자 변경 관련 오류 - //
				if( !StringUtils.isNumeric(paramObj.getPD_PRICE()) )
				{
					TB_PDINFOXM tb = new TB_PDINFOXM();
					tb.setPD_BARCD(article.get("A"));
					tb.setPD_PRICE(article.get("B"));
					tb.setPD_NAME(article.get("C"));
					tb.setADC1_NAME("-1");
					tb.setADC1_VAL("<FONT COLOR = \"RED\">상품 가격</FONT>이 숫자가 아닙니다.");
					list.add(tb);
					
					continue;
				}
				
				try
				{
					updateCnt = productMgrMapper.excelUpdate_pdPrice(paramObj);

					TB_PDINFOXM tb = new TB_PDINFOXM();
					tb.setPD_BARCD(article.get("A"));
					tb.setPD_PRICE(article.get("B"));
					tb.setPD_NAME(article.get("C"));
					
					// - 업데이트된 상품이 없는 경우 -//
					if(updateCnt == 0)
					{
						tb.setADC1_NAME("-1");
						tb.setADC1_VAL("<FONT COLOR = \"RED\">바코드</FONT>가 존재하지 않습니다.");
					}
					// - 정상적인 업데이트 - //
					else if(updateCnt == 1)
					{
						tb.setADC1_NAME("0");
						tb.setADC1_VAL("");
					}
					// - 2개이상의 상품이 업데이트 됨 ( 변경된 상품이 중복된 바코드를 가지고 있음 ) - //
					else 
					{
						tb.setADC1_NAME("0");
						tb.setADC1_VAL("<FONT COLOR = \"RED\">중복된 바코드의 상품</FONT>이 존재합니다.<br> 변경된 상품의 수 : " + updateCnt);
					}
					
					list.add(tb);
					
					
				}catch(SQLException e){
				
				}catch(Exception ex){				
					return null;
				}
				
        	}
        	
        }
        
		return list;
	}
	
	public List<TB_PDINFOXM> prdExcelUpload(Object obj,  List<Map<String, String>>excelContent) throws Exception {
		int updateCnt = 0;
		int insertCnt = 0;
		
		List<TB_PDINFOXM> list = new ArrayList<TB_PDINFOXM>();
		
		// UPDATE_CODE 생성
		//String UPDATE_CODE = productMgrMapper.getUploadCode();
		TB_PDINFOXM pdinfoxm = (TB_PDINFOXM) obj;
		String UPDATE_CODE = pdinfoxm.getUPLOAD_CODE();
		System.out.println("UPDATE_CODE : "+UPDATE_CODE);
		// 파일 재업로드 시 데이터 중복을 위한 초기화
		updateCnt = productMgrMapper.resetTmpPdinfoxm(pdinfoxm);
		int cnt = 1;
        for(Map<String, String> article: excelContent){
        	if(StringUtils.isNotEmpty(article.get("A")) || StringUtils.isNotEmpty(article.get("B"))) {
        		TB_PDINFOXM paramObj = (TB_PDINFOXM)pdinfoxm;

				paramObj.setSUPR_ID(pdinfoxm.getSUPR_ID());
				
				paramObj.setPD_NAME(article.get("A"));
				paramObj.setCAGO_ID(article.get("B"));
				paramObj.setPD_PRICE(article.get("C"));
				paramObj.setINVEN_QTY(article.get("D"));
				paramObj.setPD_BARCD(article.get("E"));
				paramObj.setPD_STD(article.get("F"));
				
				
				paramObj.setSALE_CON("SALE_CON_01");
				
				
				paramObj.setMAKE_COM(article.get("G"));
				paramObj.setORG_CT(article.get("H"));
				paramObj.setPD_DINFO(article.get("I"));
				paramObj.setDLVREF_GUIDE(article.get("J"));
				
				if(article.get("K").equals("과세")) {
					paramObj.setTAX_GUBN("TAX_GUBN_01");
				}else if(article.get("K").equals("면세")) {
					paramObj.setTAX_GUBN("TAX_GUBN_02");
				}else {
					paramObj.setTAX_GUBN("TAX_GUBN_01");
				}
				
				if(article.get("L").equals("택배배송")) {
					paramObj.setDLVY_GUBN("DLVY_GUBN_01");
				}else if(article.get("L").equals("직접배송")) {
					paramObj.setDLVY_GUBN("DLVY_GUBN_02");
				}else {
					paramObj.setDLVY_GUBN("DLVY_GUBN_01");
				}
				
				paramObj.setPD_IWHUPRC(article.get("M"));
				paramObj.setMEMBER_PRICE(article.get("N"));
				
				paramObj.setATFL_ID("");
				paramObj.setRPIMG_SEQ("1");
				paramObj.setPD_ICON("");
				paramObj.setSTD_UNIT("");
				paramObj.setDTL_ATFL_ID("");
				paramObj.setDTL_USE_YN("");
				paramObj.setLINK_YN("");
				paramObj.setBUNDLE_CNT("");
				paramObj.setDLVR_INDI_YN("");
				paramObj.setKEEP_GUBN("");
				paramObj.setPACKING_GUBN("");
				paramObj.setKEEP_LOCATION("");
				paramObj.setLIMIT_QTY("");
				paramObj.setINPUT_CNT("");
				paramObj.setRETAIL_GUBN("");
				paramObj.setQNT_LIMT_USE("");
				paramObj.setRETAIL_GUBN("");
				paramObj.setOPTION_GUBN("");
				paramObj.setBOX_PDDC_VAL("");
				paramObj.setPRICE_POLICY("");
				
				paramObj.setRETAIL_YN("N");
				paramObj.setDEL_YN("N");
				paramObj.setBOX_PDDC_GUBN("PDDC_GUBN_01");
				paramObj.setUPLOAD_CODE(UPDATE_CODE);
				paramObj.setUPLOAD_CNT(cnt+"");
				paramObj.setORFL_NAME(article.get("O"));
				
				paramObj.setCAGO_ID_LEN(article.get("B").length()+1);
		
				
				// 디테일 사진 메인사진으로 묶기
				if(article.get("P") != ""&& article.get("P") != null) {
					TB_COATFLXD tb_coatflxd = new TB_COATFLXD();
					tb_coatflxd.setREGP_ID(pdinfoxm.getREGP_ID());
					tb_coatflxd.setUPLOAD_CODE(UPDATE_CODE);
					tb_coatflxd.setORFL_NAME(paramObj.getORFL_NAME());
					int mCount = productMgrMapper.detailMasterInsert(tb_coatflxd);
					
					try {
						int update = 0;
						String[] detailes = article.get("P").split(",");
						int i =1;
						for (String detail : detailes) {

							tb_coatflxd.setSTFL_NAME(detail);
							tb_coatflxd.setATFL_SEQ(i+"");
							update += productMgrMapper.setDetailimg(tb_coatflxd);
							System.out.println("detail" + detail +" ///// " + tb_coatflxd.getSTFL_NAME());
							System.out.println("detailUpdate1 : " + update);
							i++;
						}
					} catch (Exception e) {
						int update = 0;
						String detail = article.get("P");
						
						tb_coatflxd.setSTFL_NAME(detail);
						
						update += productMgrMapper.setDetailimg(tb_coatflxd);
						System.out.println("detailUpdate2 : "+ e + update);
					}
						
				}
				
//				if(article.get("P").split(",") != null) {
//					int update = 0;
//					String[] detailes = article.get("P").split(",");
//					for (String detail : detailes) {
//						TB_COATFLXD tb_coatflxd = new TB_COATFLXD();
//						
//						tb_coatflxd.setUPLOAD_CODE(UPDATE_CODE);
//						tb_coatflxd.setORFL_NAME(paramObj.getORFL_NAME());
//						tb_coatflxd.setSTFL_NAME(detail);
//						
//						update += productMgrMapper.setDetailimg(tb_coatflxd);
//						System.out.println("detailUpdate : " + update);
//						
//					}
//				}else {
//					int update = 0;
//					String detail = article.get("P");
//					TB_COATFLXD tb_coatflxd = new TB_COATFLXD();
//					
//					tb_coatflxd.setUPLOAD_CODE(UPDATE_CODE);
//					tb_coatflxd.setORFL_NAME(paramObj.getORFL_NAME());
//					tb_coatflxd.setSTFL_NAME(detail);
//					
//					update += productMgrMapper.setDetailimg(tb_coatflxd);
//					System.out.println("detailUpdate : " + update);
//				}
				
				
				
				cnt++;
				
				try
				{
					System.out.println("paramObj.getPD_CODE() : "+paramObj.getPD_CODE());

					insertCnt = productMgrMapper.insertProductInfo(paramObj);
					System.out.println("insertCnt : " + insertCnt);
					TB_PDINFOXM tb = new TB_PDINFOXM();
					tb.setSUPR_ID("");
					
					tb.setPD_NAME(article.get("A"));
					tb.setCAGO_ID(article.get("B"));
					tb.setPD_PRICE(article.get("C"));
					tb.setINVEN_QTY(article.get("D"));
					tb.setPD_BARCD(article.get("E"));
					tb.setPD_STD(article.get("F"));
					
					tb.setSALE_CON("SALE_CON_01");
					
					
					tb.setMAKE_COM(article.get("G"));
					tb.setORG_CT(article.get("H"));
					tb.setPD_DINFO(article.get("I"));
					tb.setDLVREF_GUIDE(article.get("J"));
					
					if(article.get("K").equals("과세")) {
						tb.setTAX_GUBN("TAX_GUBN_01");
					}else if(article.get("K").equals("면세")) {
						tb.setTAX_GUBN("TAX_GUBN_02");
					}else {
						tb.setTAX_GUBN("TAX_GUBN_01");
					}
					
					if(article.get("L").equals("택배배송")) {
						tb.setDLVY_GUBN("DLVY_GUBN_01");
					}else if(article.get("L").equals("직접배송")) {
						tb.setDLVY_GUBN("DLVY_GUBN_02");
					}else {
						tb.setDLVY_GUBN("DLVY_GUBN_01");
					}
					
					tb.setPD_IWHUPRC(article.get("M"));
					tb.setMEMBER_PRICE(article.get("N"));
					tb.setATFL_ID("");
					tb.setRPIMG_SEQ("1");
					tb.setPD_ICON("");
					tb.setSTD_UNIT("");
					tb.setDTL_ATFL_ID("");
					tb.setDTL_USE_YN("");
					tb.setLINK_YN("");
					tb.setBUNDLE_CNT("");
					tb.setDLVR_INDI_YN("");
					tb.setKEEP_GUBN("");
					tb.setPACKING_GUBN("");
					tb.setKEEP_LOCATION("");
					tb.setLIMIT_QTY("");
					tb.setINPUT_CNT("");
					tb.setRETAIL_GUBN("");
					tb.setQNT_LIMT_USE("");
					tb.setRETAIL_GUBN("");
					tb.setOPTION_GUBN("");
					tb.setBOX_PDDC_VAL("");
					tb.setPRICE_POLICY("");
					tb.setRETAIL_YN("N");
					tb.setDEL_YN("N");
					tb.setBOX_PDDC_GUBN("PDDC_GUBN_01");
					tb.setUPLOAD_CODE(UPDATE_CODE);
					tb.setUPLOAD_CNT(cnt+"");
					tb.setORFL_NAME(article.get("O"));
									
					// - 업데이트된 상품이 없는 경우 -//
					if(insertCnt == 0)
					{
						tb.setADC1_NAME("-1");
						tb.setADC1_VAL("<FONT COLOR = \"RED\">바코드</FONT>가 존재하지 않습니다.");
					}
					// - 정상적인 업데이트 - //
					else if(insertCnt == 1)
					{
						tb.setADC1_NAME("0");
						tb.setADC1_VAL("");
					}
					// - 2개이상의 상품이 업데이트 됨 ( 변경된 상품이 중복된 바코드를 가지고 있음 ) - //
					else 
					{
						tb.setADC1_NAME("0");
						tb.setADC1_VAL("<FONT COLOR = \"RED\">중복된 바코드의 상품</FONT>이 존재합니다.<br> 변경된 상품의 수 : " + insertCnt);
					}
					
					list.add(tb);
					System.out.println("list.size() : "+list.size());
					
					
				}catch(SQLException e){
				
				}catch(Exception ex){				
					return null;
				}
				
        	}
        	
        }
        System.out.println("return list!");
		return list;
	}
	
	
	// 우리마켓 첨부파일 데이터 업데이트
	public int updateWrmall(Object obj) throws Exception {
		return productMgrMapper.updateWrmall(obj);
	}

	public int insertWRFileMaster(Object obj) throws Exception {
		return productMgrMapper.insertWrFileMaster(obj);
		
	}

	public int insertWRFileDetail(Object obj) throws Exception {
		return productMgrMapper.insertWrFileDetail(obj);
	}

	public List<?> selectFileList(Object obj) {
		return productMgrMapper.selectFileList(obj);
	}

	public int selectWRCount(Object obj) throws Exception {
		return productMgrMapper.selectWrCount(obj);
	}
	
	// Temp Table Backup
	public int tmpInsertObject(Object obj) throws Exception {
		return productMgrMapper.tmpBackUp(obj);
	}
	public int deleteObject2(Object obj) throws Exception {
		return productMgrMapper.delete2(obj);		
	}
	
	// IIBS 관련
	// 공급업체 리스트 조회
	public List<?> getSuprList(Object obj) throws Exception {
		return productMgrMapper.getSuprList(obj);
	}
	
	public int optionInsert(Object obj) {
		return productMgrMapper.optionInsert(obj);
		
	}

	public int optionDelete(Object obj) {
		return productMgrMapper.optionDelete(obj);
	}

	public List<?> getOptionList(Object obj) {
		return productMgrMapper.getOptionList(obj);
	}

	public List<?> getOptionTitle(Object obj) {
		return productMgrMapper.getOptionTitle(obj);
	}

	public List<?> getExtraPrdlist(Object obj) {
		// TODO Auto-generated method stub
		return productMgrMapper.getExtraPrdlist(obj);
	}

	public int insertExtrprod(Object obj) {
		return productMgrMapper.insertExtrprod(obj);
	}

	public List<?> getSavedExtPrdList(Object obj) {
		return productMgrMapper.getSavedExtPrdList(obj);
	}

	public int deleteExtrprod(Object obj) {
		return productMgrMapper.deleteExtrprod(obj);
	}

	public int checkExtrprod(Object obj) {
		return productMgrMapper.checkExtrprod(obj);
	}

	public List<?> getUplodeResult(Object obj) {
		return productMgrMapper.getUplodeResult(obj);
	}
	
	/* 상품코드 가져오기 - 이유리 */
	public Object getProductCode(Object obj) {
		return productMgrMapper.getProductCode(obj);
	}
	
	/* 배송정보 마스터 가져오기 - 이유리 */
	public Object getShipMaster(Object obj) {
		return productMgrMapper.getShipMaster(obj);
	}
	
	/* 배송정보 디테일 가져오기 - 이유리 */
	public List<?> getShipDetail(Object obj) {
		return productMgrMapper.getShipDetail(obj);
	}
	
	/* 배송정보 마스터 업데이트 - 이유리 */
	public int updateShipMaster(Object obj) {
		return productMgrMapper.updateShipMaster(obj);
	}
	
	/* 배송정보 디테일 삭제 - 이유리 */
	public int deleteShipDetail(Object obj) {
		return productMgrMapper.deleteShipDetail(obj);
	}
	
	/* 배송정보 디테일 업데이트 - 이유리 */
	public int updateShipDetail(Object obj) {
		return productMgrMapper.updateShipDetail(obj);
	}

	public Map callValidChk(Map map) {
		return productMgrMapper.callValidChk(map);
		
	}
	
	/* 템플릿 마스터 리스트 가져오기 - 이유리 */
	public List<?> getTempMasterList(Object obj) {
		return productMgrMapper.getTempMasterList(obj);
	}
	
	/* 템플릿 마스터 가져오기 - 이유리 */
	public Object getTempMaster(Object obj) {
		return productMgrMapper.getTempMaster(obj);
	}
	
	/* 템플릿 디테일 가져오기 - 이유리 */
	public List<?> getTempDetail(Object obj) {
		return productMgrMapper.getTempDetail(obj);
	}
	
	/* 템플릿 마스터 인서트 - 이유리 */
	public int insertTempMaster(Object obj) {
		return productMgrMapper.insertTempMaster(obj);
	}
	
	/* 템플릿 마스터 업데이트 - 이유리 */
	public int updateTempMaster(Object obj) {
		return productMgrMapper.updateTempMaster(obj);
	}
	
	/* 템플릿 마스터 삭제 - 이유리 */
	public int deleteTempMaster(Object obj) {
		return productMgrMapper.deleteTempMaster(obj);
	}
	
	/* 템플릿 디테일 삭제 - 이유리 */
	public int deleteTempDetail(Object obj) {
		return productMgrMapper.deleteTempDetail(obj);
	}
	
	/* 템플릿 디테일 업데이트 - 이유리 */
	public int updateTempDetail(Object obj) {
		return productMgrMapper.updateTempDetail(obj);
	}
	
	/* 조합원 배송비 가져오기 - 이유리 */
	public Object getSuprInfo(Object obj) {
		return productMgrMapper.getSuprInfo(obj);
	}
	
	/* 조합원코드 가져오기 - 이유리 */
	public Object selectSuprCode(Object obj) {
		return productMgrMapper.selectSuprCode(obj);
	}
	
	/* 조합원 배송비 업데이트 - 이유리 */
	public int updateSuprInfo(Object obj) {
		return productMgrMapper.updateSuprInfo(obj);
	}
	
	//주소 
	public Object getDeliveryInfo(Object obj)throws Exception {
		return productMgrMapper.getDeliveryInfo(obj);
	}
	//옵션가격과 상품가격의 다를 경우
	public int countOriginPrice(Object obj)throws Exception{
		return productMgrMapper.countOriginPrice(obj);
	}
	//옵션상품가격과 상품가격 업데이트
	public int updateOrignPrice(Object obj)throws Exception{
		return productMgrMapper.updateOrignPrice(obj);
	}
	//옵션가격 업데이트
	public int updateOptionPrice(Object obj)throws Exception{
		return productMgrMapper.updateOptionPrice(obj);
	}
	//옵션 업데이트
	public int optionUpdate(Object obj)throws Exception{
		return productMgrMapper.optionUpdate(obj);
	}
	/*
	public List<?> getShipInfo(Object obj) {
		return productMgrMapper.getShipInfo(obj);
	}*/

	public String getUploadCode() {
		return productMgrMapper.getUploadCode();
	}

	public int insertPrdData(Object obj) {
		return productMgrMapper.insertPrdData(obj);
	}
	
	public List<?> cagoSearch(Object obj) {
	    return productMgrMapper.cagoSearch(obj);
	  }

	public int insertLinkedObject(TB_PDINFOXM productInfo) {
		return productMgrMapper.insertLinkedObject(productInfo);
	}

	public int linkDuplicateChk(TB_PDINFOXM tb_pdinfoxm) {
		return productMgrMapper.linkDuplicateChk(tb_pdinfoxm);
	}

	public String selectByNpdcode(String n_PD_CODE) {
		return productMgrMapper.selectByNpdcode(n_PD_CODE);
	}

}
