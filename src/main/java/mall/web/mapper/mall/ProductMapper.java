package mall.web.mapper.mall;

import java.util.HashMap;
import java.util.List;

import mall.web.domain.TB_ENTRYCAGOXM;
import mall.web.domain.TB_PDBORDXM;
import mall.web.domain.TB_PDOPTION;
import mall.web.domain.TB_PDRCMDXM_ENTCAGO;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.mapper.mall
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 관심상품
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-25 (오후 3:15:16)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
public interface ProductMapper {

	public int count(Object obj) throws Exception;
	public List<?> list(Object obj) throws Exception;
	public List<?> paginatedList(Object obj) throws Exception;
	public Object find(Object obj) throws Exception;
	public int insert(Object obj) throws Exception;
	public int update(Object obj) throws Exception;
	public int delete(Object obj) throws Exception;
	
	public List<?> cagoList(Object obj) throws Exception;
	public List<?> cagoDownList(Object obj) throws Exception;
	public Object cagoFind(Object obj) throws Exception;
	public List<?> cagoAllList(Object obj) throws Exception;
	public List<?> cagoTargetList(Object obj) throws Exception;
	
	public List<?> boardList(Object obj) throws Exception;
	public int basketInst(Object obj) throws Exception;
	public int basketSelect(Object obj) throws Exception;
	public int wishInst(Object obj) throws Exception;
	public int wishSelect(Object obj) throws Exception;
	
	public List<?> mainProductList(Object obj) throws Exception;
	public List<?> mainNewProductList(Object obj) throws Exception;
	public List<?> mainRecommandProductList(Object obj) throws Exception;
	public List<?> mainRecommandProductList3(Object obj) throws Exception;
	public List<?> mainRecommandProductList4(Object obj) throws Exception;
	public List<?> mainRecommandProductList5(Object obj) throws Exception;
	public List<?> mainRecommandProductList6(Object obj) throws Exception;
	public List<?> mainRecommandProductList7(Object obj) throws Exception;
	public List<?> mainRecommandProductList8(Object obj) throws Exception;
	
	public List<?> proCutList(Object obj) throws Exception;
	public List<?> proCutFind(List list) throws Exception;
	
	public List<?> tabRecommandProductList(Object obj) throws Exception;
	
	public int retailCount(Object obj) throws Exception;
	public List<?> paginatedRetailList(Object obj) throws Exception;
	
	public int rcmdRetailCount(Object obj) throws Exception;
	public List<?> rcmdRetailList(Object obj) throws Exception;
	
	public List<?> getEntCagoRcmdPdList(Object obj) throws Exception;
	public List<?> getEntCagoRcmdCagoList(Object obj) throws Exception;
	public TB_ENTRYCAGOXM getEntryCagoInfo(Object obj) throws Exception;
	public TB_PDRCMDXM_ENTCAGO getEntCagoSaleCagoList(Object obj) throws Exception;
	public int mergeProduct(Object obj) throws Exception;
	public int mergeImgMst(Object obj) throws Exception;
	public int mergeImgDtl(Object obj) throws Exception;
	public List<?> getOwnclanCagoList() throws Exception;
	public int updateDisSale(Object obj) throws Exception;
	public int deletePdOption(Object obj) throws Exception;
	public int insertPdOption(Object obj) throws Exception;
	public List<TB_PDOPTION> selectPdOption(Object Object) throws Exception;
	public List<?> selectPdOptionStart(Object obj) throws Exception;
	public List<?> selectPdOptionEnd(Object obj) throws Exception;
	public int setModenOfficeCagoB(Object obj) throws Exception;
	public int setModenOfficeCagoC(Object obj) throws Exception;
	public int setModenOfficeCagoD(Object obj) throws Exception;
	public int insertPdinfo_ModenOffice(Object obj) throws Exception;
	public int insertCoatflxm_ModenOffice(Object obj) throws Exception;
	public int insertCoatflxd_ModenOffice(Object obj) throws Exception;
	public int setModenOfficeDiscontinuedPd(Object obj) throws Exception;
	public int setModenOfficeSoldoutPd(Object obj) throws Exception;
	public int setModenOfficeChangedPd(Object obj) throws Exception;
	public String getCagoid(Object obj) throws Exception;
	public List<?> ChkOwnerclanPdList(Object obj) throws Exception;
	public List<?> getRcmdCagoList() throws Exception;
	public List<?> getRcmdPdList(Object obj) throws Exception;
	public int updateSALE_CON_OUT(Object obj) throws Exception;	
	public int updateInvalidProduct(Object obj) throws Exception;
	public List<TB_PDOPTION> getOption2(HashMap<String, String> map) throws Exception;
	public List<?> getOption1(Object obj);
	public List<TB_PDOPTION> getOption3(HashMap<String, String> option);
	public List<?> boardList_paging(Object obj);
	public int getQnaCount(Object obj);
	public int insertQna(Object obj);
	public List<?> getExtraPrdList(Object obj);
	public Object getDeliveryInfo(Object obj) throws Exception;
	/* 템플릿 가져오기 - 이유리 */
	public Object getTempMaster(Object obj) throws Exception;
}
