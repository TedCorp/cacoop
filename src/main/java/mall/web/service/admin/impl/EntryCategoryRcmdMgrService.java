package mall.web.service.admin.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import mall.web.domain.TB_ENTRYCAGOXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDRCMDXM;
import mall.web.domain.TB_PDRCMDXM_ENTCAGO;
import mall.web.mapper.admin.EntryCategoryRcmdMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 
 * @Company	: YT Corp.
 * @Author	: 
 * @Date	: 
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("entryCategoryRcmdMgrService")
public class EntryCategoryRcmdMgrService implements DefaultService {

	@Resource(name="entryCategoryRcmdMgrMapper")
	EntryCategoryRcmdMgrMapper entryCategoryRcmdMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return entryCategoryRcmdMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return entryCategoryRcmdMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return entryCategoryRcmdMgrMapper.paginatedList(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return entryCategoryRcmdMgrMapper.insert(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return entryCategoryRcmdMgrMapper.find(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return entryCategoryRcmdMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return entryCategoryRcmdMgrMapper.delete(obj);		
	}
	
	
	// IIBS 관련
	// 공급업체 리스트 조회
	public List<?> getSuprList(Object obj) throws Exception {
		return entryCategoryRcmdMgrMapper.getSuprList(obj);
	}
	
	
	
	public List<?> getEntrycagoList() throws Exception{
		return entryCategoryRcmdMgrMapper.getEntrycagoList();
	}
	public TB_ENTRYCAGOXM getEntrycago(Object obj) throws Exception{
		return entryCategoryRcmdMgrMapper.getEntrycago(obj);
	}
	public List<?> getEntrycagoDetail(Object obj) throws Exception{
		return entryCategoryRcmdMgrMapper.getEntrycagoDetail(obj);
	}
	public int updateEntryCagoxm(Object obj) throws Exception{
		return entryCategoryRcmdMgrMapper.updateEntryCagoxm(obj);
	}
	public int insertEntryCagoxd(Object obj) throws Exception{
		return entryCategoryRcmdMgrMapper.insertEntryCagoxd(obj);
	}
	public int deleteEntryCagoxd(Object obj) throws Exception{
		return entryCategoryRcmdMgrMapper.deleteEntryCagoxd(obj);
	}
	public int deleteEntryCagoxm(Object obj) throws Exception{
		return entryCategoryRcmdMgrMapper.deleteEntryCagoxm(obj);
	}
	public String insertEntryCagoxm(TB_ENTRYCAGOXM tb_entrycagoxm) throws Exception{
		String id = entryCategoryRcmdMgrMapper.getEntCagoMaxEtryId();
		tb_entrycagoxm.setENTRY_ID(id);
		
		entryCategoryRcmdMgrMapper.insertEntryCagoxm(tb_entrycagoxm);
		
		return id;
	}
	
	
	public List<?> getPdRcmdxmEntcago(Object obj) throws Exception{
		return entryCategoryRcmdMgrMapper.getPdRcmdxmEntcago(obj);
	}
		
	public TB_PDRCMDXM_ENTCAGO getPdRcmdxmEntcagoxm(Object obj) throws Exception{
		return entryCategoryRcmdMgrMapper.getPdRcmdxmEntcagoxm(obj);
	}
	public List<?> getPdRcmdxmEntcagoxd(Object obj) throws Exception{
		return entryCategoryRcmdMgrMapper.getPdRcmdxmEntcagoxd(obj);
	}
	
	public int updatePdrcmdxm_entcago(Object obj) throws Exception{
		return entryCategoryRcmdMgrMapper.updatePdrcmdxm_entcago(obj);
	}
	public int insertPdrcmdxd_entcago(Object obj) throws Exception{
		return entryCategoryRcmdMgrMapper.insertPdrcmdxd_entcago(obj);
	}
	public int deletePdrcmdxd_entcago(Object obj) throws Exception{
		return entryCategoryRcmdMgrMapper.deletePdrcmdxd_entcago(obj);
	}
	public int deletePdrcmdxm_entcago(Object obj) throws Exception{
		return entryCategoryRcmdMgrMapper.deletePdrcmdxm_entcago(obj);
	}
	public int getchkGubn(Object obj) throws Exception{
		return entryCategoryRcmdMgrMapper.getchkGubn(obj);
	}
	public String insertPdrcmdxm_entcago(TB_PDRCMDXM_ENTCAGO tb_pdrcmdxm_entcago) throws Exception{
		String cd = entryCategoryRcmdMgrMapper.getEntCagoRcmdMaxEtryId(tb_pdrcmdxm_entcago);
		tb_pdrcmdxm_entcago.setGRP_CD(cd);
		
		entryCategoryRcmdMgrMapper.insertPdrcmdxm_entcago(tb_pdrcmdxm_entcago);
		
		return cd;
	}
	
	public List<TB_PDINFOXM> excelUpload(Object obj,  List<Map<String, String>>excelContent) throws Exception {
		
		TB_PDRCMDXM_ENTCAGO pdrcmdxm = (TB_PDRCMDXM_ENTCAGO) obj;				
		List<TB_PDINFOXM> listPD = new ArrayList<TB_PDINFOXM>();	// 예외 반환용 리스트
		
        for(Map<String, String> article: excelContent){

        	if(StringUtils.isNotEmpty(article.get("A"))) {
        		TB_PDRCMDXM_ENTCAGO paramObj = (TB_PDRCMDXM_ENTCAGO)pdrcmdxm;
				
				//paramObj.setPD_CODE(article.get("A"));
        		paramObj.setPD_BARCD(article.get("A"));
				paramObj.setSORT_ORDR(article.get("B"));
				
				try{					
					//중복되어 있는 바코드 수 반환 : 조건 - 바코드, 사용여부 Y
					int bcdCnt = entryCategoryRcmdMgrMapper.excelUploadChk_BarcodeCount(paramObj) ;
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
					
					entryCategoryRcmdMgrMapper.excelUpload(paramObj);
					
				}catch(SQLException e){
				
				}catch(Exception ex){
					
				}
        	}
        }
        
		return listPD;
	}
}
