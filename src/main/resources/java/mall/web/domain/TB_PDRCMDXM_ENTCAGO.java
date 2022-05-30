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
@Alias("tb_pdrcmdxm_entcago")
@XmlRootElement(name="tb_pdrcmdxm_entcago")
public class TB_PDRCMDXM_ENTCAGO extends DefaultDomain{
	
	private static final long serialVersionUID = -1471161809434513649L;
	
	private String GRP_CD;				//카테고리ID
	private String GRP_NM;				//카테고리명
	private String DEL_YN;				//상위 카테고리ID
	private String SORT_ORDR;			//정렬순서
	private String USE_YN;				//사용여부
	private String RCMD_GUBN;			//상품그룹구분
	private String RCMD_GUBN_NM;	//상품그룹구분
	
	private String PD_CODE;				//상품코드
	private String PD_BARCD;			//상품바코드
	
	private String CHK_UPDATE; 		//중복체크
	
	private String ENTRY_ID;	// 집입카테고리ID
	
	private List<?> PDLIST;		//상품리스트
	
		
	public List<?> getPDLIST() {
		return PDLIST;
	}
	public void setPDLIST(List<?> pDLIST) {
		PDLIST = pDLIST;
	}
	public String getENTRY_ID() {
		return ENTRY_ID;
	}
	public void setENTRY_ID(String eNTRY_ID) {
		ENTRY_ID = eNTRY_ID;
	}
	public String getGRP_CD() {
		return GRP_CD;
	}
	public void setGRP_CD(String gRP_CD) {
		GRP_CD = gRP_CD;
	}
	public String getGRP_NM() {
		return GRP_NM;
	}
	public void setGRP_NM(String gRP_NM) {
		GRP_NM = gRP_NM;
	}
	public String getDEL_YN() {
		return DEL_YN;
	}
	public void setDEL_YN(String dEL_YN) {
		DEL_YN = dEL_YN;
	}
	public String getSORT_ORDR() {
		return SORT_ORDR;
	}
	public void setSORT_ORDR(String sORT_ORDR) {
		SORT_ORDR = sORT_ORDR;
	}
	public String getUSE_YN() {
		return USE_YN;
	}
	public void setUSE_YN(String uSE_YN) {
		USE_YN = uSE_YN;
	}
	public String getRCMD_GUBN() {
		return RCMD_GUBN;
	}
	public void setRCMD_GUBN(String rCMD_GUBN) {
		RCMD_GUBN = rCMD_GUBN;
	}
	public String getRCMD_GUBN_NM() {
		return RCMD_GUBN_NM;
	}
	public void setRCMD_GUBN_NM(String rCMD_GUBN_NM) {
		RCMD_GUBN_NM = rCMD_GUBN_NM;
	}
	public String getPD_CODE() {
		return PD_CODE;
	}
	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}
	public String getPD_BARCD() {
		return PD_BARCD;
	}
	public void setPD_BARCD(String pD_BARCD) {
		PD_BARCD = pD_BARCD;
	}
	public String getCHK_UPDATE() {
		return CHK_UPDATE;
	}
	public void setCHK_UPDATE(String cHK_UPDATE) {
		CHK_UPDATE = cHK_UPDATE;
	}
}
