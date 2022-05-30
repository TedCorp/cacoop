package mall.web.service.mall;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.domain.TB_ENTRYCAGOXM;
import mall.web.domain.TB_PDINFOXM;
import mall.web.domain.TB_PDRCMDXM_ENTCAGO;
import mall.web.mapper.mall.ProductMapper;
import mall.web.service.DefaultService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.service.mall
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 사용자 상품
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-27 (오후 2:08:37)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Service("productService")
public class ProductService implements DefaultService{	
	
	@Resource(name="productMapper")
	ProductMapper productMapper;

	@Override
	public int getObjectCount(Object obj) throws Exception {
		return productMapper.count(obj);
	}
	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return productMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return productMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return productMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return productMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return productMapper.update(obj);
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return productMapper.delete(obj);
	}
	
	public List<?> getCagoList(Object obj) throws Exception {
		return productMapper.cagoList(obj);
	}
	
	public List<?> getCagoDownList(Object obj) throws Exception {
		return productMapper.cagoDownList(obj);
	}
	
	public Object getCagoObject(Object obj) throws Exception {
		return productMapper.cagoFind(obj);
	}
	
	public List<?> getCagoAllList(Object obj) throws Exception {
		return productMapper.cagoAllList(obj);
	}
	
	public List<?> getCagoTargetList(Object obj) throws Exception {
		return productMapper.cagoTargetList(obj);
	}
	
	public List<?> getBoardList(Object obj) throws Exception {
		return productMapper.boardList(obj);
	}

	public int basketInst(Object obj) throws Exception {
		return productMapper.basketInst(obj);
	}
	
	public int basketSelect(Object obj) throws Exception {
		return productMapper.basketSelect(obj);
	}
	
	public int wishInst(Object obj) throws Exception {
		return productMapper.wishInst(obj);
	}
	
	public int wishSelect(Object obj) throws Exception {
		return productMapper.wishSelect(obj);
	}
	
	public List<?> getMainProductList(Object obj) throws Exception {
		return productMapper.mainProductList(obj);
	}
	
	public List<?> getMainNewProductList(Object obj) throws Exception {
		return productMapper.mainNewProductList(obj);
	}
	public List<?> getMainRecommandProductList(Object obj) throws Exception {
		return productMapper.mainRecommandProductList(obj);
	}
	public List<?> getMainRecommandProductList3(Object obj) throws Exception {
		return productMapper.mainRecommandProductList3(obj);
	}
	public List<?> getMainRecommandProductList4(Object obj) throws Exception {
		return productMapper.mainRecommandProductList4(obj);
	}
	public List<?> getMainRecommandProductList5(Object obj) throws Exception {
		return productMapper.mainRecommandProductList5(obj);
	}
	public List<?> getMainRecommandProductList6(Object obj) throws Exception {
		return productMapper.mainRecommandProductList6(obj);
	}
	public List<?> getMainRecommandProductList7(Object obj) throws Exception {
		return productMapper.mainRecommandProductList7(obj);
	}
	public List<?> getMainRecommandProductList8(Object obj) throws Exception {
		return productMapper.mainRecommandProductList8(obj);
	}
	public List<?> getProCutList(Object obj) throws Exception {
		return productMapper.proCutList(obj);
	}
	public List<?> getProCutFind(List list) throws Exception {
		return productMapper.proCutFind(list);
	}
	public List<?> getTabRecommandProductList(Object obj) throws Exception {
		return productMapper.tabRecommandProductList(obj);
	}
	
	public int getRetailCount(Object obj) throws Exception {
		return productMapper.retailCount(obj);
	}
	public List<?> getRetailProductList(Object obj) throws Exception {
		return productMapper.paginatedRetailList(obj);
	}
	

	public int getRcmdRetailCount(Object obj) throws Exception {
		return productMapper.retailCount(obj);
	}
	public List<?> getRetailRcmdList(Object obj) throws Exception {
		return productMapper.rcmdRetailList(obj);
	}
	
	public List<?> getEntCagoRcmdPdList(Object obj) throws Exception {
		return productMapper.getEntCagoRcmdPdList(obj);
	}	
	public List<?> getEntCagoRcmdCagoList(Object obj) throws Exception {
		return productMapper.getEntCagoRcmdCagoList(obj);
	}
	public TB_ENTRYCAGOXM getEntryCagoInfo(Object obj) throws Exception {
		return productMapper.getEntryCagoInfo(obj);
	}
	public TB_PDRCMDXM_ENTCAGO getEntCagoSaleCagoList(Object obj) throws Exception {
		return productMapper.getEntCagoSaleCagoList(obj);
	}
	public int mergeProduct(Object obj) throws Exception {
		return productMapper.mergeProduct(obj);
	}
	public int mergeImgMst(Object obj) throws Exception {
		return productMapper.mergeImgMst(obj);
	}
	public int mergeImgDtl(Object obj) throws Exception {
		return productMapper.mergeImgDtl(obj);
	}
	public int updateDisSale(Object obj) throws Exception {
		return productMapper.updateDisSale(obj);
	}
	public List<?> getOwnclanCagoList() throws Exception {
		return productMapper.getOwnclanCagoList();
	}
	public int deletePdOption(Object obj) throws Exception {
		return productMapper.deletePdOption(obj);
	}
	public int insertPdOption(Object obj) throws Exception {
		return productMapper.insertPdOption(obj);
	}
	public List<?> selectPdOption(Object obj) throws Exception {
		return productMapper.selectPdOption(obj);
	}
	public List<?> selectPdOptionStart(Object obj) throws Exception {
		return productMapper.selectPdOptionStart(obj);
	}
	public List<?> selectPdOptionEnd(Object obj) throws Exception {
		return productMapper.selectPdOptionEnd(obj);
	}
	public int setModenOfficeCagoB(Object obj) throws Exception {
		return productMapper.setModenOfficeCagoB(obj);
	}
	public int setModenOfficeCagoC(Object obj) throws Exception {
		return productMapper.setModenOfficeCagoC(obj);
	}
	public int setModenOfficeCagoD(Object obj) throws Exception {
		return productMapper.setModenOfficeCagoD(obj);
	}
	public int insertPdinfo_ModenOffice(Object obj) throws Exception {
		return productMapper.insertPdinfo_ModenOffice(obj);
	}
	public int insertCoatflxm_ModenOffice(Object obj) throws Exception {
		return productMapper.insertCoatflxm_ModenOffice(obj);
	}
	public int insertCoatflxd_ModenOffice(Object obj) throws Exception {
		return productMapper.insertCoatflxd_ModenOffice(obj);
	}
	public int setModenOfficeDiscontinuedPd(Object obj) throws Exception {
		return productMapper.setModenOfficeDiscontinuedPd(obj);
	}
	public int setModenOfficeSoldoutPd(Object obj) throws Exception {
		return productMapper.setModenOfficeSoldoutPd(obj);
	}
	public int setModenOfficeChangedPd(Object obj) throws Exception {
		return productMapper.setModenOfficeChangedPd(obj);
	}	
	public String getCagoid(Object obj) throws Exception {
		return productMapper.getCagoid(obj);
	}
	public List<?> ChkOwnerclanPdList(Object obj) throws Exception {
		return productMapper.ChkOwnerclanPdList(obj);
	}
	
	public List<?> getRcmdCagoList() throws Exception {
		return productMapper.getRcmdCagoList();
	}
	public List<?> getRcmdPdList(Object obj) throws Exception {
		return productMapper.getRcmdPdList(obj);
	}
	
	public int updateSALE_CON_OUT(Object obj) throws Exception {
		return productMapper.updateSALE_CON_OUT(obj);	
	}
	
	public int updateInvalidProduct(Object obj) throws Exception {
		return productMapper.updateInvalidProduct(obj);	
	}
	
	
	
	
	
	
}
