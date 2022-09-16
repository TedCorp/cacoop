package mall.web.service.mall;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import mall.web.mapper.mall.FindMemberInfoMapper;
import mall.web.service.DefaultService;;


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
@Service("findMemberInfoService")
public class FindMemberInfoService implements DefaultService {	
	
	@Resource(name="findMemberInfoMapper")
	FindMemberInfoMapper findMemberInfoMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return findMemberInfoMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return 	findMemberInfoMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	public Object getEmail(Object obj) throws Exception {
		return findMemberInfoMapper.findEmail(obj);
	}

	public List<?> findID(Object obj) throws Exception {
		return findMemberInfoMapper.findID(obj);
	}
	
	public List<?> findPW(Object obj) throws Exception {
		return findMemberInfoMapper.findPW(obj);
	}
	
	public int updatePw(Object obj) throws Exception {
		
		return findMemberInfoMapper.updatePw(obj);
	}

}
