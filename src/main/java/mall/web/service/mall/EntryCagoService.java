package mall.web.service.mall;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mall.web.mapper.mall.EntryCagoMapper;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service.mall
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 진입카테고리
 * @Company	: YT Corp.
 * @Author	: 
 * @Date	: 2020-03-25
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("entrycagoService")
public class EntryCagoService{	
	
	/*@Resource(name="entrycagoMapper")
	EntryCagoMapper entryCagoMapper;*/
	
	
	@Autowired
	EntryCagoMapper entryCagoMapper;
	
	
	// 진입카테고리 마스터 조회
	public List<?> getEntryCagoMasterList() throws Exception {
		return entryCagoMapper.getEntryCagoMasterList();
	}

}
