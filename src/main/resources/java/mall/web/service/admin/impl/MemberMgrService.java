package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_SYSGUSXM;
import mall.web.mapper.admin.GroupMemberMgrMapper;
import mall.web.mapper.admin.MemberMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 회원정보 관리 Service
 * @Company	: YT Corp.
 * @Author	: Byeong-gwon Gang (multiple@nate.com)
 * @Date	: 2016-07-07 (오후 11:07:25)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("memberMgrService")
public class MemberMgrService implements DefaultService {

	@Resource(name="memberMgrMapper")
	MemberMgrMapper memberMgrMapper;

	@Resource(name="groupMemberMgrMapper")
	GroupMemberMgrMapper groupMemberMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return memberMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return memberMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return memberMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return memberMgrMapper.find(obj);
	}
	
	@Override
	@Transactional
	public int insertObject(Object obj) throws Exception {
		TB_MBINFOXM memberInfo = (TB_MBINFOXM)obj;			
															
		TB_SYSGUSXM tb_sysgusxm = new TB_SYSGUSXM();		 
		tb_sysgusxm.setGROUP_CD("00000000002");				
		tb_sysgusxm.setMEMB_ID(memberInfo.getMEMB_ID());	
		tb_sysgusxm.setREGP_ID(memberInfo.getREGP_ID());	
		
		memberMgrMapper.insert(memberInfo);					
		groupMemberMgrMapper.insert(tb_sysgusxm);	
				
		return 1;
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return memberMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return memberMgrMapper.delete(obj);
	}
	
	public List<?> getComAreaGubn() throws Exception {
		return memberMgrMapper.comAreaGubn();
	}
		
	public List<?> getExcelList(Object obj) throws Exception {
		return memberMgrMapper.excelList(obj);
	}
	
	
	public int backupObject(Object obj) throws Exception {
		memberMgrMapper.tmpBackUp(obj);
		
		return 1;
	}
	
	public int PermdeleteObject(Object obj) throws Exception {
		memberMgrMapper.delete2(obj);
		
		return 1;
	}
}
