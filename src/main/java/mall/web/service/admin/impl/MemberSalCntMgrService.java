package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import mall.web.mapper.admin.MemberSalCntMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 회원매출집계 관리 Service
 * @Company	: YT Corp.
 * @Author	: HEESUN LEE (hslee@youngthink.co.kr)
 * @Date	: 2018-06-15 (오후 02:55:25)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("memberSalCntMgrService")
public class MemberSalCntMgrService implements DefaultService {

	@Resource(name="memberSalCntMgrMapper")
	MemberSalCntMgrMapper memberSalCntMgrMapper;

	@Override
	public int getObjectCount(Object obj) throws Exception {
		return memberSalCntMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return memberSalCntMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return memberSalCntMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return memberSalCntMgrMapper.find(obj);
	}

	//사용안함

	@Override
	public int insertObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	//--사용안함
	
	public List<?> getExcelList(Object obj) throws Exception {
		return memberSalCntMgrMapper.excelList(obj);
	}
}
