package mall.web.service.mall;

import java.util.List;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.domain.TB_IPINFOXM;
import mall.web.domain.TB_SYSGMNXM;
import mall.web.mapper.mall.WishListMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service.mall
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 관심상품
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-25 (오후 3:16:35)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("wishListService")
public class WishListService implements DefaultService{	

	@Resource(name="wishListMapper")
	WishListMapper wishListMapper;

	@Override
	public int getObjectCount(Object obj) throws Exception {
		return wishListMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return wishListMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return wishListMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return wishListMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {

		int bkCnt = wishListMapper.getBasketCount(obj);
		
		int cnt = 0;
		
		if(bkCnt <= 0){
			cnt = wishListMapper.insert(obj);
		}
		
		//wishListMapper.delete(obj);
		
		return cnt;
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return wishListMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return wishListMapper.delete(obj);
	}
	
	public void insertMultiObject(TB_IPINFOXM tb_ipinfoxm) throws Exception {
		StringTokenizer stok = new StringTokenizer(tb_ipinfoxm.getINTPD_REGNO_LIST(),"$");
		int i = 0;
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			TB_IPINFOXM obj = new TB_IPINFOXM();
			obj.setINTPD_REGNO(str);
			obj.setREGP_ID(tb_ipinfoxm.getREGP_ID());
			obj.setMODP_ID(tb_ipinfoxm.getMODP_ID());
			
			obj.setOPTION1_NAME(tb_ipinfoxm.getOPTION1_NAMES()[i]);
			obj.setOPTION1_VALUE(tb_ipinfoxm.getOPTION1_VALUES()[i]);
			obj.setOPTION2_NAME(tb_ipinfoxm.getOPTION2_NAMES()[i]);
			obj.setOPTION2_VALUE(tb_ipinfoxm.getOPTION2_VALUES()[i]);
			i++;
			
			int bkCnt = wishListMapper.getBasketCount(obj);
			
			if(bkCnt <= 0){
				wishListMapper.insert(obj);
			}
		}
		
//		stok = new StringTokenizer(tb_ipinfoxm.getINTPD_REGNO_LIST(),"$");
//		while(stok.hasMoreTokens()){
//			String str = stok.nextToken();
//			TB_IPINFOXM obj = new TB_IPINFOXM();
//			obj.setINTPD_REGNO(str);
//			wishListMapper.delete(obj);
//		}
		   
	}
	
	public void deleteMulitObject(TB_IPINFOXM tb_ipinfoxm) throws Exception {
		StringTokenizer stok = new StringTokenizer(tb_ipinfoxm.getINTPD_REGNO_LIST(),"$");
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			TB_IPINFOXM obj = new TB_IPINFOXM();
			obj.setINTPD_REGNO(str);
			wishListMapper.delete(obj);
		}
		   
	}
	public int getBasketCount(Object obj) throws Exception {
		return wishListMapper.getBasketCount(obj);
	}
}
