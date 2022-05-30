package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.domain.TB_ADPDIFXM;
import mall.web.domain.TB_PDLINKXM;
import mall.web.mapper.admin.ProductLinkMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 제품 연계 가격 관리 Service
 * @Company	: YT Corp.
 * @Author	: Byeong-gwon Gang (multiple@nate.com)
 * @Date	: 2016-07-07 (오후 11:07:25)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("productLinkMgrService")
public class ProductLinkMgrService implements DefaultService {

	@Resource(name="productLinkMgrMapper")
	ProductLinkMgrMapper productLinkMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return productLinkMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return productLinkMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return productLinkMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return productLinkMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return productLinkMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {

		TB_PDLINKXM pdLinkInfo = (TB_PDLINKXM) obj;

		if(pdLinkInfo.getPD_CODES() != null && pdLinkInfo.getPD_CODES().length > 0) {
			for (int i=0; i<pdLinkInfo.getPD_CODES().length; i++) {
				
				for (int j=0; j<pdLinkInfo.getMALL_GUBNS().length; j++) {
					TB_PDLINKXM paramObj = (TB_PDLINKXM)pdLinkInfo;
					
					paramObj.setPD_CODE(pdLinkInfo.getPD_CODES()[i]);
					paramObj.setMALL_GUBN(pdLinkInfo.getMALL_GUBNS()[j]);
					
					if(pdLinkInfo.getMALL_GUBNS()[j].equals("01")){
						paramObj.setPD_PRICE(pdLinkInfo.getPD_PRICES01()[i]);
						
					}
					if(pdLinkInfo.getMALL_GUBNS()[j].equals("02")){
						paramObj.setPD_PRICE(pdLinkInfo.getPD_PRICES02()[i]);
						
					}
					if(pdLinkInfo.getMALL_GUBNS()[j].equals("03")){
						paramObj.setPD_PRICE(pdLinkInfo.getPD_PRICES03()[i]);
						
					}
					if(pdLinkInfo.getMALL_GUBNS()[j].equals("04")){
						paramObj.setPD_PRICE(pdLinkInfo.getPD_PRICES04()[i]);
						
					}
					if(pdLinkInfo.getMALL_GUBNS()[j].equals("05")){
						paramObj.setPD_PRICE(pdLinkInfo.getPD_PRICES05()[i]);
						
					}
					
					productLinkMgrMapper.update(paramObj);
				}
			}
		}
		
		return 0;
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return productLinkMgrMapper.delete(obj);
		
	}
}
