package mall.web.service.mall;

import java.util.List;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.domain.TB_BKINFOXM;
import mall.web.mapper.mall.MemberMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service.mall
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 장바구니
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-25 (오후 3:16:35)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("memberService")
public class MemberService implements DefaultService{	

	@Resource(name="memberMapper")
	MemberMapper memberMapper;

	@Override
	public int getObjectCount(Object obj) throws Exception {
		return 	memberMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return 	memberMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return 	memberMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return 	memberMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return 	memberMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return 	memberMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return 	memberMapper.delete(obj);
	}
	
	public List<?> termList(Object obj) throws Exception {
		return 	memberMapper.termList(obj);
	}
	
	public int idCheck(Object obj) throws Exception {
		return 	memberMapper.idCheck(obj);
	}
	
	public int comBunbChk(Object obj) throws Exception {
		return memberMapper.comBunbChk(obj);
	}
	
	public void insertMultiObject(TB_BKINFOXM tb_bkinfoxm) throws Exception {
		StringTokenizer stok = new StringTokenizer(tb_bkinfoxm.getBSKT_REGNO_LIST(),"$");
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			TB_BKINFOXM obj = new TB_BKINFOXM();
			obj.setBSKT_REGNO(str);
			obj.setREGP_ID(tb_bkinfoxm.getMODP_ID());
			obj.setMODP_ID(tb_bkinfoxm.getMODP_ID());
			memberMapper.insert(obj);
		}
		
		stok = new StringTokenizer(tb_bkinfoxm.getBSKT_REGNO_LIST(),"$");
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			TB_BKINFOXM obj = new TB_BKINFOXM();
			obj.setBSKT_REGNO(str);
			memberMapper.delete(obj);
		}		   
	}
	
	public void deleteMulitObject(TB_BKINFOXM tb_bkinfoxm) throws Exception {
		StringTokenizer stok = new StringTokenizer(tb_bkinfoxm.getBSKT_REGNO_LIST(),"$");
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			TB_BKINFOXM obj = new TB_BKINFOXM();
			obj.setBSKT_REGNO(str);
			memberMapper.delete(obj);
		}		   
	}

	//
	public int updateCponCnt(Object obj) throws Exception {
		return 	memberMapper.updateCpon(obj);
	}
}
