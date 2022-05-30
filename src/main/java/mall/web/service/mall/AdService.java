package mall.web.service.mall;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.mapper.mall.AdMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service.mall
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 전단 광고
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-27 (오후 2:08:37)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("adService")
public class AdService implements DefaultService{	
	
	@Resource(name="adMapper")
	AdMapper adMapper;

	@Override
	public int getObjectCount(Object obj) throws Exception {
		return adMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return adMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return adMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return adMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return adMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return adMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return adMapper.delete(obj);
	}

	public List<?> getCagoList(Object obj) throws Exception {
		return adMapper.cagoList(obj);
	}
	
	public Object selectFile(Object obj) throws Exception {
		return adMapper.selectFile(obj);
	}
	

	public int adLogInsert(Object obj) throws Exception {
		return adMapper.adLogInsert(obj);
	}
	
	public Object getObjectLast(Object obj) throws Exception {
		return adMapper.findLast(obj);
	}
}
