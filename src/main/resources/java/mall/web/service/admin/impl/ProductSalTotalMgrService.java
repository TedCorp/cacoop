package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.mapper.admin.ProductSalTotalMgrMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 상품집계 Service
 * @Company	: YT Corp.
 * @Author	: 
 * @Date	: 
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("productSalTotalMgrService")
public class ProductSalTotalMgrService implements DefaultService {

	@Resource(name="productSalTotalMgrMapper")
	ProductSalTotalMgrMapper productSalTotalMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return productSalTotalMgrMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return productSalTotalMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return productSalTotalMgrMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return productSalTotalMgrMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return productSalTotalMgrMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return productSalTotalMgrMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return productSalTotalMgrMapper.delete(obj);		
	}
	
	public int getTotalCount(Object obj) throws Exception {
		return productSalTotalMgrMapper.countTotal(obj);
	}
	
	/* 상품 기간별 집계 페이징 목록 */
	public int getPeriodCount(Object obj) throws Exception {
		return productSalTotalMgrMapper.countPeriod(obj);
	}
	public List<?> getPaginatedPeriodList(Object obj) throws Exception {
		return productSalTotalMgrMapper.paginatedListPeriod(obj);
	}
	
	/* 상품 일자별 집계 페이징 목록 */
	public int getDateCount(Object obj) throws Exception {
		return productSalTotalMgrMapper.countDate(obj);
	}
	public List<?> getPaginatedDateList(Object obj) throws Exception {
		return productSalTotalMgrMapper.paginatedListDate(obj);
	}
	
	/* 상품 회원별 집계 페이징 목록 */
	public int getMemberCount(Object obj) throws Exception {
		return productSalTotalMgrMapper.countMember(obj);
	}
	public List<?> getPaginatedMemberList(Object obj) throws Exception {
		return productSalTotalMgrMapper.paginatedListMember(obj);
	}

	/* 상품 집계 목록 (엑셀) */
	public List<?> getTotalList(Object obj) throws Exception {
		return productSalTotalMgrMapper.excelList(obj);
	}
	
	/* 상품 기간별 집계 목록 (엑셀) */
	public List<?> getPeriodList(Object obj) throws Exception {
		return productSalTotalMgrMapper.excelPeriod(obj);
	}
	
	/* 상품 일자별 집계 목록 (엑셀) */
	public List<?> getDateList(Object obj) throws Exception {
		return productSalTotalMgrMapper.excelDate(obj);
	}
	
	/* 상품 회원별 집계 목록 (엑셀) */
	public List<?> getMemberList(Object obj) throws Exception {
		return productSalTotalMgrMapper.excelMember(obj);
	}
}
