package mall.web.service.admin.impl;

import java.util.List;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_SYSGMNXM;
import mall.web.domain.TB_SYSGUSXM;
import mall.web.mapper.admin.GroupMemberMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service.admin.impl
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 그룹별 회원 관리
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-20 (오후 8:32:49)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("groupMemberMgrService")
public class GroupMemberMgrService implements DefaultService{	
	
	@Resource(name="groupMemberMgrMapper")
	GroupMemberMgrMapper groupMemberMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return groupMemberMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return groupMemberMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return groupMemberMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return groupMemberMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return groupMemberMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return groupMemberMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return groupMemberMgrMapper.delete(obj);
	}
	
	public List<?> getObjectPopupList(Object obj) throws Exception {
		return groupMemberMgrMapper.popupList(obj);
	}
	
	public void insertObject(TB_SYSGUSXM tb_sysgusxm) throws Exception {
		
		StringTokenizer stok = new StringTokenizer(tb_sysgusxm.getCHK_MEMB_ID(),"$");
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			TB_SYSGUSXM obj = new TB_SYSGUSXM();
			obj.setMEMB_ID(str);
			obj.setGROUP_CD(tb_sysgusxm.getGROUP_CD());
			obj.setREGP_ID(tb_sysgusxm.getMODP_ID());
			obj.setMODP_ID(tb_sysgusxm.getMODP_ID());
			
			int cnt = groupMemberMgrMapper.count(obj);
			
			if(cnt == 0){
				groupMemberMgrMapper.insert(obj);
			}
		}
	}
	
}
