package mall.web.service.admin.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDRCMDXM;
import mall.web.mapper.admin.ProductMgrMapper;
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
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return productMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return productMgrMapper.paginatedList(obj);
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
	

	
}
