package mall.web.domain;

import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 추천상품 DTO (진입카테고리별)
 * @Company	: YT Corp.
 * @Author	: 
 * @Date	: 2020-03-26
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_pdrcmdxd_entcago")
@XmlRootElement(name="tb_pdrcmdxd_entcago")
public class TB_PDRCMDXD_ENTCAGO extends DefaultDomain{
	
	private static final long serialVersionUID = -1471161809434513649L;
	
	private String GRP_CD;
	private String PD_CODE;
	private String PD_NAME;
	private String SORT_ORDR;
	private String REGP_ID;
	private String MODP_ID;
	private String ENTRY_ID;
	
	private String PD_SORT;
	private String PD_BARCD;
	
	
	
	public String getPD_SORT() {
		return PD_SORT;
	}
	public void setPD_SORT(String pD_SORT) {
		PD_SORT = pD_SORT;
	}
	public String getENTRY_ID() {
		return ENTRY_ID;
	}
	public void setENTRY_ID(String eNTRY_ID) {
		ENTRY_ID = eNTRY_ID;
	}
	public String getPD_BARCD() {
		return PD_BARCD;
	}
	public void setPD_BARCD(String pD_BARCD) {
		PD_BARCD = pD_BARCD;
	}
	public String getGRP_CD() {
		return GRP_CD;
	}
	public void setGRP_CD(String gRP_CD) {
		GRP_CD = gRP_CD;
	}
	public String getPD_CODE() {
		return PD_CODE;
	}
	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}
	public String getPD_NAME() {
		return PD_NAME;
	}
	public void setPD_NAME(String pD_NAME) {
		PD_NAME = pD_NAME;
	}
	public String getSORT_ORDR() {
		return SORT_ORDR;
	}
	public void setSORT_ORDR(String sORT_ORDR) {
		SORT_ORDR = sORT_ORDR;
	}	
	public String getREGP_ID() {
		return REGP_ID;
	}
	public void setREGP_ID(String rEGP_ID) {
		REGP_ID = rEGP_ID;
	}	
	public String getMODP_ID() {
		return MODP_ID;
	}
	public void setMODP_ID(String mODP_ID) {
		MODP_ID = mODP_ID;
	}
	
	
	

}
