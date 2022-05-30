package mall.web.service.admin.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import mall.web.domain.TB_COATFLXD;
import mall.web.domain.TB_ENTRYCAGOXD;
import mall.web.domain.TB_ENTRYCAGOXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDRCMDXM;
import mall.web.mapper.admin.EntryCategoryMenuMgrMapper;
import mall.web.mapper.admin.EntryCategoryMenuMgrMapper;
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
@Service("entryCategoryMenuMgrService")
public class EntryCategoryMenuMgrService implements DefaultService {

	@Resource(name="entryCategoryMenuMgrMapper")
	EntryCategoryMenuMgrMapper EntryCategoryMenuMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return EntryCategoryMenuMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return EntryCategoryMenuMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return EntryCategoryMenuMgrMapper.paginatedList(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return EntryCategoryMenuMgrMapper.insert(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return EntryCategoryMenuMgrMapper.find(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return EntryCategoryMenuMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return EntryCategoryMenuMgrMapper.delete(obj);		
	}
	
	
	// IIBS 관련
	// 공급업체 리스트 조회
	public List<?> getSuprList(Object obj) throws Exception {
		return EntryCategoryMenuMgrMapper.getSuprList(obj);
	}
	
	
	
	public List<?> getEntrycagoList() throws Exception{
		return EntryCategoryMenuMgrMapper.getEntrycagoList();
	}
	public TB_ENTRYCAGOXM getEntrycago(Object obj) throws Exception{
		return EntryCategoryMenuMgrMapper.getEntrycago(obj);
	}
	public List<?> getEntrycagoDetail(Object obj) throws Exception{
		return EntryCategoryMenuMgrMapper.getEntrycagoDetail(obj);
	}
	public int updateEntryCagoxm(Object obj) throws Exception{
		return EntryCategoryMenuMgrMapper.updateEntryCagoxm(obj);
	}
	public int insertEntryCagoxd(Object obj) throws Exception{
		return EntryCategoryMenuMgrMapper.insertEntryCagoxd(obj);
	}
	public int deleteEntryCagoxd(Object obj) throws Exception{
		return EntryCategoryMenuMgrMapper.deleteEntryCagoxd(obj);
	}
	public int deleteEntryCagoxm(Object obj) throws Exception{
		return EntryCategoryMenuMgrMapper.deleteEntryCagoxm(obj);
	}
	public String insertEntryCagoxm(TB_ENTRYCAGOXM tb_entrycagoxm) throws Exception{
		String id = EntryCategoryMenuMgrMapper.getEntCagoMaxEtryId();
		tb_entrycagoxm.setENTRY_ID(id);
		
		EntryCategoryMenuMgrMapper.insertEntryCagoxm(tb_entrycagoxm);
		
		return id;
	}
}
