package mall.web.service.mall;

import java.util.List;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.domain.TB_BKINFOXM;
import mall.web.mapper.mall.BasketMapper;
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
@Service("basketService")
public class BasketService implements DefaultService{	

	@Resource(name="basketMapper")
	BasketMapper basketMapper;

	@Override
	public int getObjectCount(Object obj) throws Exception {
		return basketMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return basketMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return basketMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return basketMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
			   basketMapper.insert(obj);
		return basketMapper.delete(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return basketMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return basketMapper.delete(obj);
	}
	
	public void insertMultiObject(TB_BKINFOXM tb_bkinfoxm) throws Exception {
		StringTokenizer stok = new StringTokenizer(tb_bkinfoxm.getBSKT_REGNO_LIST(),"$");
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			TB_BKINFOXM obj = new TB_BKINFOXM();
			obj.setBSKT_REGNO(str);
			obj.setREGP_ID(tb_bkinfoxm.getMODP_ID());
			obj.setMODP_ID(tb_bkinfoxm.getMODP_ID());
			basketMapper.insert(obj);
		}
		
		stok = new StringTokenizer(tb_bkinfoxm.getBSKT_REGNO_LIST(),"$");
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			TB_BKINFOXM obj = new TB_BKINFOXM();
			obj.setBSKT_REGNO(str);
			basketMapper.delete(obj);
		}		   
	}
	
	public void deleteMulitObject(TB_BKINFOXM tb_bkinfoxm) throws Exception {
		StringTokenizer stok = new StringTokenizer(tb_bkinfoxm.getBSKT_REGNO_LIST(),"$");
		while(stok.hasMoreTokens()){
			String str = stok.nextToken();
			TB_BKINFOXM obj = new TB_BKINFOXM();
			obj.setBSKT_REGNO(str);
			basketMapper.delete(obj);
		}		   
	}
	
	// 장바구니 엑셀 다운로드
	public List<?> getExcelList(Object obj) throws Exception {
		return basketMapper.excelList(obj);
	}

}
