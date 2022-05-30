package mall.web.service.admin.impl;

import java.util.List;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.domain.TB_ODINFOXM;
import mall.web.domain.TB_SYSGMNXM;
import mall.web.mapper.admin.GroupMenuMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service.admin.impl
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 그룹별 메뉴 관리
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-20 (오후 8:32:39)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("groupMenuMgrService")
public class GroupMenuMgrService implements DefaultService{	
	
	@Resource(name="groupMenuMgrMapper")
	GroupMenuMgrMapper groupMenuMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return groupMenuMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return groupMenuMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return groupMenuMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return groupMenuMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return groupMenuMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return groupMenuMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return groupMenuMgrMapper.delete(obj);
	}
	
	public void insertObject(TB_SYSGMNXM tb_sysgmnxm) throws Exception {
		groupMenuMgrMapper.delete(tb_sysgmnxm);
		StringTokenizer stok = new StringTokenizer(tb_sysgmnxm.getCHK_MENU_CODE(),"$");
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			TB_SYSGMNXM obj = new TB_SYSGMNXM();
			obj.setMENU_CD(str);
			obj.setGROUP_CD(tb_sysgmnxm.getGROUP_CD());
			obj.setREGP_ID(tb_sysgmnxm.getMODP_ID());
			obj.setMODP_ID(tb_sysgmnxm.getMODP_ID());
			groupMenuMgrMapper.insert(obj);
		}
	}
	
}
