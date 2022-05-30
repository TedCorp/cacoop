package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 배송정보
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-21 (오후 1:57:40)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_pdshipxd")
@XmlRootElement(name="tb_pdshipxd")
public class TB_PDSHIPXD extends DefaultDomain{

	private static final long serialVersionUID = 1733226044024796314L;
	
	/*TB_PDSHIPXM*/
	private String PD_CODE;					//VARCHAR2(20 Byte)			제품코드
	private String SUPR_ID;					//VARCHAR2(12 Byte)			공급업체
	private String SHIP_GUBN;				//VARCHAR2(50 Byte)			배송비구분
	private String GUBN_START;				//NUMBER					구분1
	private String GUBN_END;				//NUMBER					구분2
	private String DLVY_AMT;				//NUMBER					배송비
	private int SHIP_SEQ;					//NUMBER					배송비 순번
	
	private String[] GUBN_STARTS;				//NUMBER					구분1
	private String[] GUBN_ENDS;				//NUMBER					구분2
	private String[] DLVY_AMTS;				//NUMBER					배송비
	
	public String getPD_CODE() {
		return PD_CODE;
	}
	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}
	public String getSUPR_ID() {
		return SUPR_ID;
	}
	public void setSUPR_ID(String sUPR_ID) {
		SUPR_ID = sUPR_ID;
	}
	public String getSHIP_GUBN() {
		return SHIP_GUBN;
	}
	public void setSHIP_GUBN(String sHIP_GUBN) {
		SHIP_GUBN = sHIP_GUBN;
	}
	public String getGUBN_START() {
		return GUBN_START;
	}
	public void setGUBN_START(String gUBN_START) {
		GUBN_START = gUBN_START.replaceAll("\\,", "");
	}
	public String getGUBN_END() {
		return GUBN_END;
	}
	public void setGUBN_END(String gUBN_END) {
		GUBN_END = gUBN_END.replaceAll("\\,", "");
	}
	public String getDLVY_AMT() {
		return DLVY_AMT;
	}
	public void setDLVY_AMT(String dLVY_AMT) {
		DLVY_AMT = dLVY_AMT.replaceAll("\\,", "");
	}
	public int getSHIP_SEQ() {
		return SHIP_SEQ;
	}
	public void setSHIP_SEQ(int sHIP_SEQ) {
		SHIP_SEQ = sHIP_SEQ;
	}
	public String[] getGUBN_STARTS() {
		return GUBN_STARTS;
	}
	public void setGUBN_STARTS(String[] gUBN_STARTS) {
		GUBN_STARTS = gUBN_STARTS;
	}
	public String[] getGUBN_ENDS() {
		return GUBN_ENDS;
	}
	public void setGUBN_ENDS(String[] gUBN_ENDS) {
		GUBN_ENDS = gUBN_ENDS;
	}
	public String[] getDLVY_AMTS() {
		return DLVY_AMTS;
	}
	public void setDLVY_AMTS(String[] dLVY_AMTS) {
		DLVY_AMTS = dLVY_AMTS;
	}
}
