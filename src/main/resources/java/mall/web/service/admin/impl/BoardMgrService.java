package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.mapper.admin.BoardMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service.admin.impl
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 게시판 관리
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-18 (오전 10:57:12)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("boardMgrService")
public class BoardMgrService implements DefaultService {
	
	@Resource(name="boardMgrMapper")
	BoardMgrMapper boardMgrMapper;

	@Override
	public int getObjectCount(Object obj) throws Exception {
		return boardMgrMapper.count(obj);
	}

	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return null;
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return boardMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return boardMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return boardMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return boardMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return boardMgrMapper.delete(obj);
	}
	
	
	public int getObjectCount01(Object obj) throws Exception {
		return boardMgrMapper.count01(obj);
	}

	public List<?> getPaginatedObjectList01(Object obj) throws Exception {
		return boardMgrMapper.paginatedList01(obj);
	}
	
	public Object getObject01(Object obj) throws Exception {
		return boardMgrMapper.find01(obj);
	}
	
	public int updateObject01(Object obj) throws Exception {
		return boardMgrMapper.update01(obj);
	}
	
	
	
	public int getObjectCount02(Object obj) throws Exception {
		return boardMgrMapper.count02(obj);
	}

	public List<?> getPaginatedObjectList02(Object obj) throws Exception {
		return boardMgrMapper.paginatedList02(obj);
	}
	public Object getObject02(Object obj) throws Exception {
		return boardMgrMapper.find02(obj);
	}
	
	public int updateObject02(Object obj) throws Exception {
		return boardMgrMapper.update02(obj);
	}
	
	
	
	public int getObjectCount03(Object obj) throws Exception {
		return boardMgrMapper.count03(obj);
	}

	public List<?> getPaginatedObjectList03(Object obj) throws Exception {
		return boardMgrMapper.paginatedList03(obj);
	}
	public Object getObject03(Object obj) throws Exception {
		return boardMgrMapper.find03(obj);
	}
	
	public int updateObject03(Object obj) throws Exception {
		return boardMgrMapper.update03(obj);
	}
	
	

	public int getObjectCount04(Object obj) throws Exception {
		return boardMgrMapper.count04(obj);
	}

	public List<?> getPaginatedObjectList04(Object obj) throws Exception {
		return boardMgrMapper.paginatedList04(obj);
	}
	
	public Object getObject04(Object obj) throws Exception {
		return boardMgrMapper.find04(obj);
	}
	
	public int insertObject04(Object obj) throws Exception {
		return boardMgrMapper.insert04(obj);
	}
	
	public int updateObject04(Object obj) throws Exception {
		return boardMgrMapper.update04(obj);
	}
	
	
	
	public List<?> getCagoObjectList(Object obj) throws Exception {
		return boardMgrMapper.cagoList(obj);
	}
	public List<?> getSchCagoObjectList(Object obj) throws Exception {
		return boardMgrMapper.schCagoList(obj);
	}
}
