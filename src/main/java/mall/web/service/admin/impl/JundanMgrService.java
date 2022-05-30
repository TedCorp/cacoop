package mall.web.service.admin.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mall.web.domain.TB_ADINFOXM;
import mall.web.domain.TB_ADPDIFXM;
import mall.web.domain.TB_JDINFOXM;
import mall.web.mapper.admin.AdMgrMapper;
import mall.web.mapper.admin.AdMgrPrdMapper;
import mall.web.mapper.admin.JundanMgrMapper;
import mall.web.service.DefaultService;

/**
* @author Your Name (your@email.com)
* 전단 Service
*/

@Service("jundanMgrService")
@Transactional
public class JundanMgrService implements DefaultService{

	@Resource(name="jundanMgrMapper") 
	JundanMgrMapper jundanMgrMapper;
	
	@Resource(name="adMgrPrdMapper") 
	AdMgrPrdMapper adMgrPrdMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return jundanMgrMapper.count(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return jundanMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return jundanMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		
		jundanMgrMapper.insert(obj);

		return 0;
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return jundanMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {		
		int deleteCnt = 0;
		
		TB_ADINFOXM adinfoxm = (TB_ADINFOXM) obj;		
		deleteCnt += jundanMgrMapper.delete(adinfoxm);
		
		return deleteCnt;
	}

	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return null;
	}
	
	public List<?> selectList(Object obj) throws Exception {
		return jundanMgrMapper.selectList(obj);
	}
	
	@Transactional	
	public int copyAdInsert(Object obj) throws Exception {
		int updateCnt = 0;
		
		TB_JDINFOXM jdInfoxm = (TB_JDINFOXM) obj;
		
		if(jdInfoxm.getAdIdArr() != null && jdInfoxm.getAdIdArr().length > 0) {
			for(String jdId : jdInfoxm.getAdIdArr()) {
				if(jdId != null) {
					TB_JDINFOXM param = new TB_JDINFOXM();
					param.setJD_ID(jdId);
					updateCnt += jundanMgrMapper.copyJdInsert(param);
				}
			}
		}
		return updateCnt;
	}

	public List<?> selectLog(Object obj) throws Exception {
		return jundanMgrMapper.selectLog(obj);
	}

	/*
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
				
				jundanMgrMapper.excelUpload(paramObj);
        	}
        	
        }
		
		return updateCnt;
	}
	*/
	
}
