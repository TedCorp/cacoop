package mall.web.service.admin.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.util.SystemOutLogger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mall.web.domain.TB_ADPDIFXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDRCMDXM;
import mall.web.mapper.admin.ProductMgrMapper;
import mall.web.mapper.admin.ProductRcmdMgrMapper;
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
@Service("productRcmdMgrService")
public class ProductRcmdMgrService implements DefaultService {

	@Resource(name="productRcmdMgrMapper")
	ProductRcmdMgrMapper productRcmdMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return productRcmdMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return productRcmdMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return productRcmdMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return productRcmdMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return productRcmdMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return productRcmdMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return productRcmdMgrMapper.delete(obj);
		
	}
	public int updateProduct(Object obj) throws Exception {
		return productRcmdMgrMapper.updateProduct(obj);		
	}
	
	public List<?> getListProduct(Object obj) throws Exception {
		return productRcmdMgrMapper.listProduct(obj);
	}
	
	public int deleteProduct(Object obj) throws Exception{
		return productRcmdMgrMapper.deleteProduct(obj);
	}
	
	public int getOrdrSameCnt(Object obj) throws Exception {
		return productRcmdMgrMapper.ordrSameCnt(obj);
	}
	
	public int getGrpPdCnt(Object obj) throws Exception {
		return productRcmdMgrMapper.grpPdCnt(obj);
	}
	
	public List<TB_PDINFOXM> excelUpload(Object obj,  List<Map<String, String>>excelContent) throws Exception {
		
		TB_PDRCMDXM pdrcmdxm = (TB_PDRCMDXM) obj;				
		List<TB_PDINFOXM> listPD = new ArrayList<TB_PDINFOXM>();	// 예외 반환용 리스트
		
        for(Map<String, String> article: excelContent){

        	if(StringUtils.isNotEmpty(article.get("A"))) {
        		TB_PDRCMDXM paramObj = (TB_PDRCMDXM)pdrcmdxm;
				
				//paramObj.setPD_CODE(article.get("A"));
        		paramObj.setPD_BARCD(article.get("A"));
				paramObj.setSORT_ORDR(article.get("B"));
				
				try{					
					//중복되어 있는 바코드 수 반환 : 조건 - 바코드, 사용여부 Y
					int bcdCnt = productRcmdMgrMapper.excelUploadChk_BarcodeCount(paramObj) ;
					// 바코드가 일치하는 상품이 없음, 바코드가 일치하는 상품 2개이상
					if( bcdCnt != 1) {
						TB_PDINFOXM pd = new TB_PDINFOXM();
						pd.setPD_BARCD(article.get("A"));
						pd.setSORT_ORDR(article.get("B"));
						pd.setPD_NAME(article.get("C"));
						
						if(bcdCnt == 0) {
							pd.setERROR_CODE("-101");
							pd.setERROR_TEXT("상품이 존재하지 않습니다.");
						} else {
							pd.setERROR_CODE("-102");
							pd.setERROR_TEXT("바코드가 중복된 상품입니다. ( " + bcdCnt + " 개 )");
						}
						
						listPD.add(pd);
						continue;
					}
					
					productRcmdMgrMapper.excelUpload(paramObj);
					
				}catch(SQLException e){
				
				}catch(Exception ex){
					
				}
        	}
        }
        
		return listPD;
	}
	
	public List<?> getDetailExcelList(Object obj) throws Exception {
		return productRcmdMgrMapper.detailExcelList(obj);
	}

	// 리테일 추천상품 중복검사
	public int getGrpRtCnt(Object obj) throws Exception {
		return productRcmdMgrMapper.grpRtCnt(obj);
	}
	
	//리테일 추천상품 엑셀 다운로드
	public List<?> getRetailExcelList(Object obj) throws Exception {
		return productRcmdMgrMapper.retailExcelList(obj);
	}

	//리테일 상품 갯수
	public int getRetailCount(Object obj) throws Exception {
		return productRcmdMgrMapper.countRetail(obj);
	}
	
	//리테일 상품 리스트
	public List<?> getRetailList(Object obj) throws Exception {
		return productRcmdMgrMapper.retailList(obj);
	}

	//리테일 상품 엑셀 다운로드
	public List<?> getExcelList(Object obj) throws Exception {
		return productRcmdMgrMapper.retailExcel(obj);
	}

}
