package mall.web.service.admin.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mall.web.domain.TB_ADINFOXM;
import mall.web.domain.TB_ADPDIFXM;
import mall.web.mapper.admin.AdMgrMapper;
import mall.web.mapper.admin.AdMgrPrdMapper;
import mall.web.service.DefaultService;

/**
* @author Your Name (your@email.com)
* 광고 Service
*/

@Service("adMgrService")
@Transactional
public class AdMgrService implements DefaultService{

	@Resource(name="adMgrMapper") 
	AdMgrMapper adMgrMapper;
	
	@Resource(name="adMgrPrdMapper") 
	AdMgrPrdMapper adMgrPrdMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return adMgrMapper.count(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return adMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return adMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		
		adMgrMapper.insert(obj);

		TB_ADPDIFXM adPdInfoxm = (TB_ADPDIFXM) obj;

		if(adPdInfoxm.getPD_IDS() != null && adPdInfoxm.getPD_IDS().length > 0) {
			for (int i=0; i<adPdInfoxm.getPD_IDS().length; i++) {
				
				TB_ADPDIFXM paramObj = (TB_ADPDIFXM)adPdInfoxm;
				
				paramObj.setPD_ID(adPdInfoxm.getPD_IDS()[i]);
				paramObj.setPD_NAME(adPdInfoxm.getPD_NAMES()[i]);
				paramObj.setPD_PRICE(adPdInfoxm.getPD_PRICES()[i]);
				paramObj.setSELL_PRICE(adPdInfoxm.getSELL_PRICES()[i]);
				paramObj.setPD_CONS(adPdInfoxm.getPD_CONSS()[i]);
				paramObj.setDEL_YN(adPdInfoxm.getDEL_YNS()[i]);
				
				adMgrMapper.admgrInsert(paramObj);
			}
		}
		
		return 0;
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return adMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		int deleteCnt = 0;
		TB_ADINFOXM adinfoxm = (TB_ADINFOXM) obj;
		TB_ADPDIFXM adpdifxm = new TB_ADPDIFXM();
		
		adpdifxm.setAD_ID(adinfoxm.getAD_ID());
		
		deleteCnt += adMgrMapper.delete(adinfoxm);
		deleteCnt += adMgrPrdMapper.delete(adpdifxm);
		
		return deleteCnt;
	}

	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return null;
	}
	
	public List<?> getDetailList(Object obj) throws Exception {
		return adMgrMapper.detailList(obj);
	}
	
	public List<?> selectList(Object obj) throws Exception {
		return adMgrMapper.selectList(obj);
	}
	
	@Transactional
	public int admgrUpdateObject(Object obj) throws Exception {

		TB_ADPDIFXM adPdInfoxm = (TB_ADPDIFXM) obj;
		
		adMgrMapper.update(adPdInfoxm);	

		if(adPdInfoxm.getPD_IDS() != null && adPdInfoxm.getPD_IDS().length > 0) {
			for (int i=0; i<adPdInfoxm.getPD_IDS().length; i++) {
				
				TB_ADPDIFXM paramObj = (TB_ADPDIFXM)adPdInfoxm;
				
				paramObj.setPD_ID(adPdInfoxm.getPD_IDS()[i]);
				paramObj.setPD_NAME(adPdInfoxm.getPD_NAMES()[i]);
				paramObj.setPD_PRICE(adPdInfoxm.getPD_PRICES()[i]);
				paramObj.setSELL_PRICE(adPdInfoxm.getSELL_PRICES()[i]);
				paramObj.setPD_CONS(adPdInfoxm.getPD_CONSS()[i]);
				paramObj.setDEL_YN(adPdInfoxm.getDEL_YNS()[i]);
				paramObj.setOPT_NAME(adPdInfoxm.getOPT_NAMES()[i]);
				paramObj.setOPT_PRICE(adPdInfoxm.getOPT_PRICES()[i]);
				paramObj.setUNIT_NAME(adPdInfoxm.getUNIT_NAMES()[i]);
				paramObj.setORD(adPdInfoxm.getORDS()[i]);
				
				if( adPdInfoxm.getFLAGS()[i].equals("U") ){
					adMgrMapper.admgrUpdate(paramObj);
				}else{
					adMgrMapper.admgrInsert(paramObj);
				}
				
			}
		}
		
		return 0;
	}

	@Transactional	
	public int copyAdInsert(Object obj) throws Exception {
		int updateCnt = 0;
		TB_ADINFOXM adInfoxm = (TB_ADINFOXM) obj;
		
		if(adInfoxm.getAdIdArr() != null && adInfoxm.getAdIdArr().length > 0) {
			for(String adId : adInfoxm.getAdIdArr()) {
				if(adId != null) {
					TB_ADINFOXM param = new TB_ADINFOXM();
					param.setAD_ID(adId);
					updateCnt += adMgrMapper.copyAdInsert(param);
					updateCnt += adMgrMapper.copyPdInsert(param);
				}
			}
		}
		return updateCnt;
	}

	@Transactional	
	public int excelUpload(Object obj,  List<Map<String, String>>excelContent) throws Exception {
		int updateCnt = 0;
		TB_ADPDIFXM adPdInfoxm = (TB_ADPDIFXM) obj;
		
        for(Map<String, String> article: excelContent){

        	if(StringUtils.isNotEmpty(article.get("A"))) {
				TB_ADPDIFXM paramObj = (TB_ADPDIFXM)adPdInfoxm;
				
				paramObj.setPD_ID(article.get("A"));
				paramObj.setPD_NAME(article.get("B"));
				paramObj.setPD_PRICE(article.get("C"));
				paramObj.setSELL_PRICE(article.get("D"));
				paramObj.setPD_CONS(article.get("E"));
				paramObj.setOPT_NAME(article.get("F"));
				paramObj.setOPT_PRICE(article.get("G"));
				paramObj.setUNIT_NAME(article.get("H"));
				paramObj.setORD(article.get("I"));
				paramObj.setDEL_YN("N");
				
				adMgrMapper.excelUpload(paramObj);
        	}
        	
        }
		
		return updateCnt;
	}
	
	@Transactional	
	public int getCopyInsert(Object obj) throws Exception {
		int updateCnt = 0;
		TB_ADPDIFXM pdinfo = (TB_ADPDIFXM) obj;
		
		if(pdinfo.getPdIdArr() != null && pdinfo.getPdIdArr().length > 0) {
			for(String pdId : pdinfo.getPdIdArr()) {
				if(pdId != null) {
					TB_ADPDIFXM param = new TB_ADPDIFXM();
					param.setPD_ID(pdId);
					param.setAD_ID(pdinfo.getAD_ID());
					param.setAD_ID_NCOPY(pdinfo.getAD_ID_NCOPY());
					updateCnt += adMgrMapper.copyInsert(param);
				}
			}
		}
		return updateCnt;
	}
	
	public List<?> selectLog(Object obj) throws Exception {
		return adMgrMapper.selectLog(obj);
	}
	
}
