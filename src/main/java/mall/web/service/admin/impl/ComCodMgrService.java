package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.mapper.admin.ComCodMgrMapper;
import mall.web.mapper.admin.MenuMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service.admin.impl
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 메뉴관리
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-20 (오후 3:05:57)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("comCodMgrService")
public class ComCodMgrService implements DefaultService{

	@Resource(name="comCodMgrMapper")
	ComCodMgrMapper comCodMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return comCodMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return comCodMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return comCodMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return comCodMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return comCodMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return comCodMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return comCodMgrMapper.delete(obj);
	}
	
	public int getCodeSameCnt(Object obj) throws Exception {
		return comCodMgrMapper.codeSameCnt(obj);
	}
	public List<?> getSelectComCodList(Object obj) throws Exception {
		return comCodMgrMapper.selectComCodList(obj);
	}
	
	
	public int DtlInsert(Object obj) throws Exception {
		return comCodMgrMapper.DtlInsert(obj);
	}
	
	public int MatserInsert(Object obj) throws Exception {
		return comCodMgrMapper.MatserInsert(obj);
	}
	
	public int ComdUpdateChk(Object obj) throws Exception {
		return comCodMgrMapper.ComdUpdateChk(obj);
	}
	
}
