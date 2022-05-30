package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import mall.web.mapper.admin.MemberSalCntMgrMapper;
import mall.web.mapper.admin.MemberSalDateMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 회원매출집계 관리 Service
 * @Company	: YT Corp.
 * @Author	: HEESUN LEE (hslee@youngthink.co.kr)
 * @Date	: 2018-07-06 (오후 02:55:25)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("memberSalDateMgrService")
public class MemberSalDateMgrService implements DefaultService {

	@Resource(name="memberSalDateMgrMapper")
	MemberSalDateMgrMapper memberSalDateMgrMapper;

	@Override
	public int getObjectCount(Object obj) throws Exception {
		return memberSalDateMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return memberSalDateMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return memberSalDateMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return memberSalDateMgrMapper.find(obj);
	}

	public List<?> getExcelList(Object obj) throws Exception {
		return memberSalDateMgrMapper.excelList(obj);
	}

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
	
	public List<?> getDateList(Object obj) throws Exception {
		return memberSalDateMgrMapper.dateList(obj);
	}
	public int getDateCnt(Object obj) throws Exception {
		return memberSalDateMgrMapper.dateCnt(obj);
	}
	public List<?> getDateExcelList(Object obj) throws Exception {
		return memberSalDateMgrMapper.dateExcelList(obj);
	}
}
